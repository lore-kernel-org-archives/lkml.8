Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71227C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529032084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kjkFPUtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="06f2Ne+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgDXPfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:35:43 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:51877 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbgDXPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id DA864EB7;
        Fri, 24 Apr 2020 11:35:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=lgLp0qWWRscbA
        ZPBFEBy9wSxXxrWVVMD/Dw+AAXxxz4=; b=kjkFPUtv+BsrrC7LNyrzdOEpThfTA
        ov5+EVfmj6tF24zR7hzUrEkvVPEsaKm3CCUn4VIwEidYbGeBqvMi6ht2tnc7Zgnf
        dXAyY5WRAnS8uquielvWkT+BCfrBVeyKMqkOBWQT6YW8I4VFBCtH1GqH8KapziWV
        8/3VA4ia4jH0ZZNuj6Skx4O2YkhxnjrMwrzgfOY2s2fv4Y1LCtPEHCO3NmnlWIoM
        ZVCWZDWcubCIUMNJ3pqvbZ85gMy1vmhIzUU2L3i+SwGVraJOaOUszsVsuV6LGGL6
        FrIIAzTJKa0XIPIEOZfW3oOi7sqcSBlDfJA9Y4WE/ZTqzvVsJbrvkfNsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lgLp0qWWRscbAZPBFEBy9wSxXxrWVVMD/Dw+AAXxxz4=; b=06f2Ne+l
        fsDrhicSiId4nb/KZ1YTsCUhB9S7OpbBA23AHXiUKuxvF4pwrUX+w+8dsAdSwK9L
        XkvPEolO9QzbfC0Wj7mUgSbBrBfCtX3sYEjpcaqGOqoy1hg3DXtp14xIrRCyta2/
        Gt0hORSH2A8iHMEhfpjuXZQJ/+dIXL4uRon3dM0Pms6VlDFmDJ/iX/HWsmnRq8a0
        BDEWSVVLzYUuko1IbGUh22uF+cIytKpA4rrk678PWtKB2xY9HwVdvUkSkOAVAk+j
        qKEhBqgSkLBc+csUrlzv0owBh6hQ2OiH2VIkmPbuVVMFkoFAW6dnKIu0wAU8JfBS
        kHcyqf8RRL796A==
X-ME-Sender: <xms:SwejXuSW-qd1WRNEkIt7ADT90j6iMa2MMHAZ7GrxOsW5scx8r1FYBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SwejXvZNlHipdz5UMUC0ndUwu4xi8ETPpPOmFq54UKgZjpZNGX5VJw>
    <xmx:SwejXmSs2mJAxZdnWlLvDvKmz5Pbh3oRWhGcLnDbaMaxkU4o8-5uXw>
    <xmx:SwejXn5XnJWSmiHd3OxKK-F3hhDgvdbguO3BA8z8hK5S_EUU4AasRQ>
    <xmx:SwejXonBV-lQITbqSloKXLyshcj0Mze12CD0mPxJFBzjPU1s5LJLxlMnLtU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 312F4328005D;
        Fri, 24 Apr 2020 11:35:39 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 12/91] clk: bcm: rpi: Make sure the clkdev lookup is removed
Date:   Fri, 24 Apr 2020 17:33:53 +0200
Message-Id: <12b4b665e18c34e5b81882ddd19bfce2ee50b78a.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkdev lookup created for the cpufreq device is never removed if
there's an issue later in probe or at module removal time.

Let's convert to the managed variant of the clk_hw_register_clkdev function
to make sure it happens.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 013706816895..eb5c4f5720e8 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -245,8 +245,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
-				     NULL, "cpu0");
+	ret = devm_clk_hw_register_clkdev(rpi->dev,
+					  &raspberrypi_clk_pllb_arm.hw,
+					  NULL, "cpu0");
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize clkdev\n");
 		return ret;
-- 
git-series 0.9.1
