Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185CBC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F54214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052053;
	bh=r3EaPMwV0p6JcapleCkt9G0+Er8yoqBCX2k8wvPVHwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edrpued2THv68GOpcJGU5Tv7MSz7xWWW0Y0Ac/N93Hiv7fshmjT57jWqtvPZ/qitq
	 gytk4nFiqr6YyZB+B2L59AfQdLYmlqb8FuX2qyTIhZRRvBvV9jsD6Bf/rZ3SSzPBuH
	 oy42fy8VWOuvojpDDSBNUEa3OnmwyK3cJExOEB+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506751AbgDPPrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896791AbgDPNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40358221F4;
        Thu, 16 Apr 2020 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044027;
        bh=r3EaPMwV0p6JcapleCkt9G0+Er8yoqBCX2k8wvPVHwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilvkpXeFdE+ryq0Bn7OPXj3+k8i7g+pwUu5Qa+71/BQgyqkos+R6zau2vxwTfIhOj
         X4ZdzAUHzMnFvswclHKlPnt1btxz4dI1W9JOcTijcry4U54nVpzsvzoFaA6breyRNc
         Ldkd7z2g6dxdbyhhdJJ+52mj784oHlWmwLdWW+k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 051/257] media: allegro: fix type of gop_length in channel_create message
Date:   Thu, 16 Apr 2020 15:21:42 +0200
Message-Id: <20200416131332.318221233@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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



