Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC6C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F3E206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045962;
	bh=r3EaPMwV0p6JcapleCkt9G0+Er8yoqBCX2k8wvPVHwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzYowd51bPktSdjjGdMxJaBaebck3xrKZbpTCwtZmD12DqaxVg++gmm9dhjHOdcG5
	 BAkdUte7IxCeXebBQsi/2joISWLWT8FaZjHSyTZzp8oqP7STD1GmjWQUsrLV9lHpm0
	 YMnY9YSvJY7EpE5A5shjVJYH/4nJFfluWtD/40Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408333AbgDPOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440088AbgDPNoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:44:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE504214D8;
        Thu, 16 Apr 2020 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044646;
        bh=r3EaPMwV0p6JcapleCkt9G0+Er8yoqBCX2k8wvPVHwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLmEJ3ZMJZTJ7KnYIk7sQT9plDwMKsrPiigXSshXJJs/ZGTyKBMBC5F0ajiCVedlp
         bb8oQ8QFtCIVBexyGwIcea3R/io0mSInJvR4XCzxWwRcDOVDz1EAYBMmJcOkJWGdTi
         GcZd6qYDRHnVfp3K0nz+ssQlwDMu/Kzhu+xwx6Q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/232] media: allegro: fix type of gop_length in channel_create message
Date:   Thu, 16 Apr 2020 15:22:16 +0200
Message-Id: <20200416131321.107990644@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Tretter <m.tretter@pengutronix.de>

[ Upstream commit 8277815349327b8e65226eb58ddb680f90c2c0c0 ]

The gop_length field is actually only u16 and there are two more u8
fields in the message:

- the number of consecutive b-frames
- frequency of golden frames

Fix the message and thus fix the configuration of the GOP length.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/allegro-dvt/allegro-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index 6f0cd07847863..c5a262a12e401 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -393,7 +393,10 @@ struct mcu_msg_create_channel {
 	u32 freq_ird;
 	u32 freq_lt;
 	u32 gdr_mode;
-	u32 gop_length;
+	u16 gop_length;
+	u8 num_b;
+	u8 freq_golden_ref;
+
 	u32 unknown39;
 
 	u32 subframe_latency;
-- 
2.20.1



