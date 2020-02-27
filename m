Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F6C72913
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142C12468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813472;
	bh=5QnRTmfd6KtE19+R4Twv3aJf/UotOhBde0DRMcUgRyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fxYSL1ncCApWZ2Xlxp8Qc25iyEsXkaLUGh+vVNtp0lNix/ok3BhGmdCeo4ahDBjd1
	 3XyR/8C6daQgU36BaN7ErRAxWIQQo46JxF3JEUc7hPCwz6xziJccsV6C3kz7elpMjR
	 QpCXWOchb8XeQyCEpN3v0kFaI9MPZ+zPZtwF7wI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbgB0OYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388903AbgB0OMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:12:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA6A20578;
        Thu, 27 Feb 2020 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812772;
        bh=5QnRTmfd6KtE19+R4Twv3aJf/UotOhBde0DRMcUgRyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOq5OqUD6E1S1CrvMi02wa8FwPnG8qD+VaCfNKiMRSKQJCA2x+E+x4czdyvsaYXdt
         Z4zNvrJBvUzqqoMa8PNpbaqQzNYGsYtU4FnPqnaWg5wMzFkxXPJ+tGCL1payFZoiKk
         srG6v1Uvc+dvxPwgGRdcTK3iPsrNGC1OAA9X47s8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, stable@kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 011/150] ASoC: sun8i-codec: Fix setting DAI data format
Date:   Thu, 27 Feb 2020 14:35:48 +0100
Message-Id: <20200227132234.361978110@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

commit 96781fd941b39e1f78098009344ebcd7af861c67 upstream.

Use the correct mask for this two-bit field. This fixes setting the DAI
data format to RIGHT_J or DSP_A.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20200217064250.15516-7-samuel@sholland.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sunxi/sun8i-codec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -80,6 +80,7 @@
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
+#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
@@ -241,7 +242,7 @@ static int sun8i_set_fmt(struct snd_soc_
 		return -EINVAL;
 	}
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT),
+			   SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK,
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
 
 	return 0;


