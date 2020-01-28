Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9366C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7757922522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220588;
	bh=/s9ACbFT8qMDpDRwayydE1Jt32U6UwpIRX67EL52aKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6Z3zG/TKzI4plLN+UnA/M5GfIzVqZY2RLLXQ72GAhHw5dnBD6EkyXe74iHT+YmKC
	 WoSRiPgFUpDYC0RyNHfRWKpq186ZQc/nXGxdPDYCVSJxN3Ycmddqc9FHZ6BCxqQA6P
	 ZuG7UWOPUAHGCZzr9r5SNQ0j8FJ5pewo5GdHdmNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgA1OJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgA1OJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:09:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D4824681;
        Tue, 28 Jan 2020 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220579;
        bh=/s9ACbFT8qMDpDRwayydE1Jt32U6UwpIRX67EL52aKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncotS0nrHrKJqTJLjIxgZk1NTVNDW+C2sPvgamTYnV0u92thxHa4PMkY4Ni+qoYzF
         P440QeOQFNicH78Nt6H8YptVfX4QY+clDjrKIPsIbyQleLKYEVEGNePsEb8wO6Rqsf
         8V2OfC5smQT2sXiMDfZ/Fr5mgzj+hcmtE9w6FM7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 062/183] media: cx18: update *pos correctly in cx18_read_pos()
Date:   Tue, 28 Jan 2020 15:04:41 +0100
Message-Id: <20200128135836.178903262@linuxfoundation.org>
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
index df837408efd59..0171dc5b8809e 100644
--- a/drivers/media/pci/cx18/cx18-fileops.c
+++ b/drivers/media/pci/cx18/cx18-fileops.c
@@ -490,7 +490,7 @@ static ssize_t cx18_read_pos(struct cx18_stream *s, char __user *ubuf,
 
 	CX18_DEBUG_HI_FILE("read %zd from %s, got %zd\n", count, s->name, rc);
 	if (rc > 0)
-		pos += rc;
+		*pos += rc;
 	return rc;
 }
 
-- 
2.20.1



