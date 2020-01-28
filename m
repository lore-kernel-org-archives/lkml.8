Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D618C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D542F2469C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220581;
	bh=IjtfUMnJI/lqOHQoihXKUsqWIuy5eOSc3QHSOJpALl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gc5yAmdDNSS8B/2TzZnVouPnZSNRzjV0mgIYKmMueiGsFwludWWsMLNya0ycG48A4
	 uDHGhLroV3CaPls/91gRgInhrEm8QDPdrVn1EcmuwGkbPPa86uuJ0UrdobUirERhNB
	 xk8zJ2ix1lnzS2can4YruWJY2VIu8qQosjYv6Nvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgA1OJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgA1OJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:09:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579CC22522;
        Tue, 28 Jan 2020 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220576;
        bh=IjtfUMnJI/lqOHQoihXKUsqWIuy5eOSc3QHSOJpALl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfDAV12Acxtob1jYIWBqPfT0eaKnCPaqLDzfBSL9sWT6pRgmgKN6i8KeFd+nsCGIw
         tc349ll9H8kbrtWa0A2wVcF4f41+pLppHpGpebW1cPCB3emaIFBN438Fh1zT2w15/W
         0bCtIqqRXxL7qIk7zR4wjYqvjpEykF9eVK+jsf/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 061/183] media: ivtv: update *pos correctly in ivtv_read_pos()
Date:   Tue, 28 Jan 2020 15:04:40 +0100
Message-Id: <20200128135836.057042926@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f8e579f3ca0973daef263f513da5edff520a6c0d ]

We had intended to update *pos, but the current code is a no-op.

Fixes: 1a0adaf37c30 ("V4L/DVB (5345): ivtv driver for Conexant cx23416/cx23415 MPEG encoder/decoder")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-fileops.c b/drivers/media/pci/ivtv/ivtv-fileops.c
index 605d280d8a5f0..cb65fe6c49e01 100644
--- a/drivers/media/pci/ivtv/ivtv-fileops.c
+++ b/drivers/media/pci/ivtv/ivtv-fileops.c
@@ -420,7 +420,7 @@ static ssize_t ivtv_read_pos(struct ivtv_stream *s, char __user *ubuf, size_t co
 
 	IVTV_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1



