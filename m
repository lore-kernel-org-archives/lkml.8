Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305CC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192E20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859572;
	bh=xmJ6Yq12MlaEQQHRa9y9gtOJJsLZW8uh5VcTiWaOeTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VWDah25Hi3u7GXKFxW6wIEpzTi0LRZSI1XLei1mg/jTEH5h7w7vE9sl3+UVS2BMcs
	 4LYAsVaraTl2fs14YY9up/Vtq2jKOw3Vk7mtHRh4uuZmEUOFoziX3WCXB4/AnScYW4
	 7+fNJ61VAH7mw4Qzv24qRfyWvn2dYbiGNn4/Hg+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgAXJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731453AbgAXJwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:52:49 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F48320709;
        Fri, 24 Jan 2020 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859568;
        bh=xmJ6Yq12MlaEQQHRa9y9gtOJJsLZW8uh5VcTiWaOeTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOiKorbggX1KkrTUslWc4+Gj6GAHUEzymD1QIcs+OF3JRFADYwHHvM0lpJvAiVG6+
         koHSC5p9GRXqgvS4TFPMcnuZz1E5Atcjnl6Cr3J9FuejUXmtO1yMYztS7130OQCMyS
         clF5ZbaFh3cKjVTfvvSzCJEPmJPHQGN2g35z0TDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 145/343] media: cx18: update *pos correctly in cx18_read_pos()
Date:   Fri, 24 Jan 2020 10:29:23 +0100
Message-Id: <20200124092939.077255169@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7afb0df554292dca7568446f619965fb8153085d ]

We should be updating *pos.  The current code is a no-op.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-fileops.c b/drivers/media/pci/cx18/cx18-fileops.c
index 98467b2089fa8..099d59b992c1b 100644
--- a/drivers/media/pci/cx18/cx18-fileops.c
+++ b/drivers/media/pci/cx18/cx18-fileops.c
@@ -484,7 +484,7 @@ static ssize_t cx18_read_pos(struct cx18_stream *s, char __user *ubuf,
 
 	CX18_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1



