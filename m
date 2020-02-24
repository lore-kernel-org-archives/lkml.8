Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEFC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D2320658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="d0BLb0ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qV/Fy4nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBXJLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:02 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44317 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728360AbgBXJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C55F0647;
        Mon, 24 Feb 2020 04:10:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2fIkfY5nUkZIR
        qQtgh0SSi7eUztpIu/nJGe44ypJz6g=; b=d0BLb0ouXXmUM+WD9WAJIQRjiH1UF
        7Eu7oAJdPEP9LzPovr4VVVyLCHxdnAb+B97wtDQKp86K6x9axFpZxR4mnIEDslyv
        CbWmQ8lob/ljcoyUQ2Iw9gwwBBPV5w1NzFL2h+KZTPtK8mdwbS7uJgSPi6kJFdxi
        mcPq/bDx11YvLHEikKFx9I4nNxBq42WNYfQ83BbUCAfd+19Da+KQ/HZfdvoafMCO
        AsKhUGFU9gqI73OjyvzG3uf+dRQMnlY49kFQxBg1e7dhBnifWIi8hA3pAlYNuAh3
        qUgT4/HSgx6Tf9b0RBOFwH2ofEIHS+i0yFKBJ7yW3JGROVHHZpjXORD+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2fIkfY5nUkZIRqQtgh0SSi7eUztpIu/nJGe44ypJz6g=; b=qV/Fy4nY
        TXKbE/dM8iqVFsceTTI+Illnfw8CXYuZ8qfr60faLiEog8z5wMqXoxCIiJM7qDdr
        a8swyO2o4Rx+qHqafljPgVmmK/gvYzFajotR3MbMLvN8MfXE45wp9VAKgEmjjnyT
        DJ6KVPs68BoSfK14GAtkJQOmhqSJjGJ0yGgXG2SIJfDShjbKJvzUSQrRlXwF4QuG
        ijHVvHU/ybpTEvloD6LDLP0QV95I6GHJwzfmamVaryl3OO2HhUAv7MwqWlqV0Gti
        hj6svxdbqjY6s+44evv0hQhTSNUQ//AOD40pykE1LKEtgb9NJv2urymy+ulQw7MV
        C09/8REOAfEi9A==
X-ME-Sender: <xms:GpNTXhKujlOv74uPEMTBfHTxQCHSjzTzmLXBpvj1tBcC19YpZQSWgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GpNTXhY_4XmIOfiJ1ZtmWsedmUg9z8WSCDjJ7fkoGjEgAvDhWjYlYw>
    <xmx:GpNTXkuNiEHorzz-rJ1XCGogn7RrAAscO1hiic62o3K1jYAxJVGXZA>
    <xmx:GpNTXmuUOPBSH7xvLKWa320T6e2g4cSi4vg6iWqQvT1sL_9_yK-Rkg>
    <xmx:GpNTXoVV0lwPzHjtumqbaG2BXZzRbKSG5iTm-gqmY9t8FKEMfMShhw50fzk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12401328005E;
        Mon, 24 Feb 2020 04:10:49 -0500 (EST)
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
Subject: [PATCH 84/89] drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
Date:   Mon, 24 Feb 2020 10:07:26 +0100
Message-Id: <7050dab4e8d23a36ee1f7238b32a5a8f92c38e3c.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CEC_CLOCK_DIV define is not used anywhere in the driver, let's remove
it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 1762484bd97a..9b06352da377 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -54,7 +54,6 @@
 
 #define HSM_CLOCK_FREQ 163682864
 #define CEC_CLOCK_FREQ 40000
-#define CEC_CLOCK_DIV  (HSM_CLOCK_FREQ / CEC_CLOCK_FREQ)
 
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
-- 
git-series 0.9.1
