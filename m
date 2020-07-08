Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B32C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0519120760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NyNNnw7G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7eCYlOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGHRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:03 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35725 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbgGHRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E905910A5;
        Wed,  8 Jul 2020 13:43:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=GnbtfFU8aTFeD
        wUZr0nWCBIFykNjel/BZCz1dGHIXyY=; b=NyNNnw7GfXkRhXgMCbG4R2QwP9Qza
        6TgY9mQ2bl9Q8hhQdxisWZ+hAqC4qko3eXbBdxFLXe0bSehUDOSXUjGufrffNgSB
        /nl4moxeUMONFpXMj4PmMJrcUYiIbtRdxgtT+ZUbgyxNH27Qb1FM1K9jF9JSqp66
        esA43fc+7Sa4v5LhBAyDiC0vTPmZkqmK2rb19r6YQ4AK1PmGwUVimJ5CllBC+Kmg
        pQhcXVj6JH5FTHWZrlSvH+/NHw1yvkEEbiELOXxwECt0Dr7g1X1uOqEyGaVJW5Ju
        ep3GTMOp/pYVBhROUO0B/NcziJoV3joJPLJtzihzgx3mDWzQrbNBmps8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=GnbtfFU8aTFeDwUZr0nWCBIFykNjel/BZCz1dGHIXyY=; b=F7eCYlOM
        W+tTBYsmA0zBGnCSnaDo2jTubrRsgumLYLYDb46r92T/dPN5rFzMg6L2K474cBFP
        PSxO4aUUf8uhC12jQfdlG5cCtu1EHK1iPRkpnc8e8SHuZLzTU1pudlCjuvFn7VXn
        OLstomZ7L7N+BjTcZaC6K7a47ZIoFwa7dXNLCiXvhQOah97YI4NQufM9P2jX1iXF
        kh9WjAv+dIUNc+pV6IoNAqXJA+2EnWrJGe0Y9AXzOKVT34jZKVQ3a/UDzBSdsfcF
        sONyE5k1U4+FNYv0ksbJJiUNzrQO2hsK4u7zLo3ed85aDf5K0mufKBhAVlYQtlO1
        oUXOuN+cxd6NsA==
X-ME-Sender: <xms:3QUGX0Wvl08UJiDtYN9Tv-IfghWCnputTAYdiamlknKf_PuydW62hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3QUGX4m6n9zaeKRy-BWMcwko2kW7jktvK7dfYZvVk4bmacp-Rn1lzA>
    <xmx:3QUGX4baRS3dx8pJGoYf3E4TVssIon0ZxVdW1SP5IPdndUUKGMeioQ>
    <xmx:3QUGXzXbffUv17gidyFQuwIl7OFtu-3SU7r-wZqwd4LCOIiwHkMNXQ>
    <xmx:3QUGXwX5gByCAHS5IEHerWqfkf9-4qSKYodm3SjZg5VD1N7zcwhSjZhQIyg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31DAD328005E;
        Wed,  8 Jul 2020 13:43:57 -0400 (EDT)
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
Subject: [PATCH v4 60/78] drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
Date:   Wed,  8 Jul 2020 19:42:08 +0200
Message-Id: <cdbba354ffc234d6c03978671f99e129748ff48f.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index 86e21de6c578..a01562a49bf0 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -55,7 +55,6 @@
 
 #define HSM_CLOCK_FREQ 163682864
 #define CEC_CLOCK_FREQ 40000
-#define CEC_CLOCK_DIV  (HSM_CLOCK_FREQ / CEC_CLOCK_FREQ)
 
 static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
-- 
git-series 0.9.1
