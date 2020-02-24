Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44DCC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BF920658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aU7BNV09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rEjci/IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBXJNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:41 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48659 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbgBXJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 001C0642;
        Mon, 24 Feb 2020 04:09:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5VHijJAYm3oTK
        O0zNKBs8Gagg4smi82iYxVSDlNTN7o=; b=aU7BNV09UShQ+5K4/7KIXbU80V6Zi
        jvAYm5LHbInuecOAyw7epjDg6qD1KIxrXj0CX6Qm0icJrRnzan8I6s1GTFvUKoIq
        t3MilKcu7cCdaDItxjscal5QmfcxoRf2lOQwTJwsuNMR7JoRjJhV2XFNnA8NvY5g
        6Iyqe8as+vZtQNgxaufFZaxW/FXW/BYklurckzHOTBs5PR7mfZSejmOebaYy1Ti2
        kyU+7qLGQsXb9rmstJ0kdMFh+YMC1eUfBZinRCddEnwepa1pu4ZcT8CUyuBBd75k
        sxBK5R2KjNi3qhMhzWZJN8jGgiBF1xeQQjn5vKMHPqyDaj1MZQsYplA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5VHijJAYm3oTKO0zNKBs8Gagg4smi82iYxVSDlNTN7o=; b=rEjci/IR
        G7AJaxyirQS/0F3BIJ79pP7V6IWMiUsile5o0HTEDLDkMV78CSCpzC7U7Y7EA92z
        +JXfFnmDecyR/JfnPqtZR6MV2muGnlbrfC60dUkgRsHGxng/hjrZYTlhN+ES3IEh
        g0VQztGJkwfb17W6+16Jvu9SsklOcp8iD45VkkkzbQYzijyfssfIJdt2VRkoH6A6
        Yc7vwPOaItH1DT1b1lb+Ka4Ap7xMcyhX1BLieA4FiUC3YqMexXusE+0UcNtMTQOk
        LsEC0yVmMuneRAliUvzdKEEnysXLrGgzg4fUgCDTCo9UNUsgQljjldmw1DhTxD7h
        PJakevcdCbz6dQ==
X-ME-Sender: <xms:0pJTXpJjDqYsGBLVSdpCkzhtMT5C6rafL2dJltBvOnp0n5c46vj6jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0pJTXk1mtT7krM7Y3bbsLBiurzcoOpJZjn6Uqsyar7JHCtwmjj8G7Q>
    <xmx:0pJTXsgC_BRWpCHt-X0mJWpMUxsa7m_XMS9sAQKg2fZicwZfbfBlSA>
    <xmx:0pJTXs2afXjkw5MJQLE-AtVMPQiabblLBbGTaHYuSGTCa0TxxHdKjA>
    <xmx:0pJTXku1nRpBR4me4XxeBlfStmrC6C5jomBytLPiDxoi6iG8-bbdNHTHpA8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4378F3280063;
        Mon, 24 Feb 2020 04:09:38 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 34/89] drm/vc4: drv: Add include guards
Date:   Mon, 24 Feb 2020 10:06:36 +0100
Message-Id: <9032ef5343f779a04fe9f8017e582b4fa5162868.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vc4_drv.h doesn't have any include guards which prevents it from being
included twice. Let's add them.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 6627b20c99e9..0a2447bb0f5d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2015 Broadcom
  */
+#ifndef _VC4_DRV_H_
+#define _VC4_DRV_H_
 
 #include <linux/delay.h>
 #include <linux/refcount.h>
@@ -892,3 +894,5 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *file_priv);
 int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
+
+#endif /* _VC4_DRV_H_ */
-- 
git-series 0.9.1
