Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE974C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99152468F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844714;
	bh=5SN7HBIx7S/iolfgVHveQ4pUn7G7+gnmiMjM+m1Zmmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COCtlUT/lWb33QJIL8FFD4nWaCCFfvayEiV8ByLSNbiclNOYdxYo8CabbDOR5BIw1
	 lsT5fDHevPeYs5uNzMCeu5Ij7r5A8+GHExypnZ4OQI/hJXcsZOnZqrYx9ehIjPTCPr
	 KuvKL/BFxAQjrUA2TAoUPad3zy37OuoEXl7e7JL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgCJMvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbgCJMvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A6E2253D;
        Tue, 10 Mar 2020 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844707;
        bh=5SN7HBIx7S/iolfgVHveQ4pUn7G7+gnmiMjM+m1Zmmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBxzc8kL70ySX922sy6QBuBevmsiQQEyfg8Pip+iE9vdpCuUUDVNv2OoZBXEeIMqt
         1SL5J58hNHV7T/ATTIKnRGuIk3oclRFqt+3J195lmhDZN01HGnlSQUq87hY8XzGbXE
         UK5DB4Ncy1mXCyqS1RQyTO/uP/hkZiUCeF35fjcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 089/168] media: mc-entity.c: use & to check pad flags, not ==
Date:   Tue, 10 Mar 2020 13:38:55 +0100
Message-Id: <20200310123644.307258286@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 044041cd5227ec9ccf969f4bf1cc08bffe13b9d3 upstream.

These are bits so to test if a pad is a sink you use & but not ==.

It looks like the only reason this hasn't caused problems before is that
media_get_pad_index() is currently only used with pads that do not set the
MEDIA_PAD_FL_MUST_CONNECT flag. So a pad really had only the SINK or SOURCE
flag set and nothing else.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v5.3 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/mc/mc-entity.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -639,9 +639,9 @@ int media_get_pad_index(struct media_ent
 		return -EINVAL;
 
 	for (i = 0; i < entity->num_pads; i++) {
-		if (entity->pads[i].flags == MEDIA_PAD_FL_SINK)
+		if (entity->pads[i].flags & MEDIA_PAD_FL_SINK)
 			pad_is_sink = true;
-		else if (entity->pads[i].flags == MEDIA_PAD_FL_SOURCE)
+		else if (entity->pads[i].flags & MEDIA_PAD_FL_SOURCE)
 			pad_is_sink = false;
 		else
 			continue;	/* This is an error! */


