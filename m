Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3EB21D82
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="eQ2SC3u3";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9U1qZZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIJDMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:12:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53991 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIJDMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:12:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 16DD45C004F;
        Wed,  9 Sep 2020 23:12:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 09 Sep 2020 23:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=0vEttpy+arTAmSK0kyYkwC4TzT
        WvE6U0iylftvN47wc=; b=eQ2SC3u3ar+k2/fGeVmW9VE3EoOwZ5T8QBjJXneReO
        aNth+KVfP1UwmAAxaqJQOCqg2ig8fSHEkxDk0krB2tJotZRUQEyPtjwLi0Z8A3GD
        wj2J0JqxOcHNcoCxwJlTofdZXjmSfvPNp+e52gD7VBQqDPGoIMweID/LH+uvNcQf
        QfnctVt4xozIRI5eSypZ1rWu3376ei+QpdhuQ7TmBysxa0Cf1UzBZHxbANARz8B2
        xVUnkqxGoHVsDvE7NZU6ksR5sxgkUA+yQUM+9TQIssRcqm2sEAtDmkYiHTiNmaNv
        cFGCE3F0uXF1ktrI3EPm0H7VNrMtVZTz86i0r/dvPhsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0vEttpy+arTAmSK0k
        yYkwC4TzTWvE6U0iylftvN47wc=; b=H9U1qZZ/Mfp2kb3MxDYWFCzvtniAprj98
        ecvJM1cM1H94sooO04gG2f8/cJLMjT5nI2+it+qmfemgcosRNuUHVDEin8t92MDq
        NQdjaakonknw6KLIMJwCB/YeuHCITd58m8AbKIbaaJnjrfzhWjwy7FUMiG/tIIjk
        HynO8+ZDEphek3qhXZQSELPBZ4yv+/gd5AFaLBCOqA9It4nP8ZKu6Nm+7sznY9kq
        ly+c9MaajDBFWMH7r66zjaqPu8Adpki861h+Bhi3WwIPekzOwNVTWnyWTo5oL/Y8
        eevDMVPs3pq/ZnrvavWhPCPUxa8NUXVPkzyKUQw0b0kfv6VW+Je4Q==
X-ME-Sender: <xms:kplZXxs4RHjx-SVFmJi9oxXrIig3kZbvMmapo2MXPe7qgkaEBIQsxw>
    <xme:kplZX6dBTuorKvhNximucstC30nZqkqy0-bX9KJuRyiucS0rplJyRCOHxF1AoxOzL
    8ZEWvL5zn4ECWn2Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecukfhppedugedrvddruddtledrkeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifse
    grjhdrihgurdgruh
X-ME-Proxy: <xmx:kplZX0xWomFcGgFbQZCcmk700c5XvFbaRqjt0Wc6o08z5cl-L2aTtw>
    <xmx:kplZX4NymiaVLsGOv12si78kZx9Vs-N6JbojWbshenNLKNj4JJhboQ>
    <xmx:kplZXx84rJl2YbwrYXhiwm30uFMk6C0j7RwX_wpE_FUWvCtSxgaxKA>
    <xmx:lJlZX8bMPkkLOO5uY4oGzbPAadmDEQZQNxsjj_Pbq_iP-d5FbJdC7g>
Received: from mistburn.lan (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DF563068C6A;
        Wed,  9 Sep 2020 23:12:16 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rainier: Disable internal pull-downs on eMMC pins
Date:   Thu, 10 Sep 2020 12:41:43 +0930
Message-Id: <20200910031143.2997298-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a veritable tug-of-war going on in the design, so disable one of
the warring parties.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 1fa233d2da26..21ae880c7530 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -180,6 +180,10 @@ &emmc_controller {
 	status = "okay";
 };
 
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
 &emmc {
 	status = "okay";
 };
-- 
2.25.1

