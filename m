Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A956C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279DA20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594150706;
	bh=IxkmBRf5TYZxdfGV0Qe1Hi63hNYzahR8LL/gGB7loAc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=n3igPeyUrS0pU5HXSBMDMDhU50ok4ek4l2e607jHwcL+dAdG/j5bJ5u/ovu/FHuJe
	 FZjdxSUNjBxoWAcGkv1ILp+wAlpAqlPKc9qcSJCFOMjP8YZT2z5YmSeQYVQZqYPZHT
	 ZULJsEWOT49ha6hwIFFGVp64qbg+af47hVxpqqqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGTiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGGTiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:38:24 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF410206BE;
        Tue,  7 Jul 2020 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594150704;
        bh=IxkmBRf5TYZxdfGV0Qe1Hi63hNYzahR8LL/gGB7loAc=;
        h=Date:From:To:Cc:Subject:From;
        b=hhI/dZxFPsgY9dhg9vOlTbYpMfFkqPTyr0+UEOgByk2BnO84qOVYZVVxKHrBO7C7A
         hJUeSnJoab7xuA1DSbipg5hQnT0bYgP7ZJCzutcRa3QODOjaRROpsPcq4F9IIsy1/8
         WpE5+Xm+cNW/bms0PyNBV9/zIi347LqKtmWESEuQ=
Date:   Tue, 7 Jul 2020 14:43:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] staging: vt6655: Use fallthrough pseudo-keyword
Message-ID: <20200707194350.GA3255@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/vt6655/channel.c |    2 +-
 drivers/staging/vt6655/key.c     |    6 +++---
 drivers/staging/vt6656/channel.c |    2 +-
 drivers/staging/vt6656/key.c     |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 62a85c1ca6c4..889fc22f19bd 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -133,7 +133,7 @@ void vnt_init_bands(struct vnt_private *priv)
 
 		priv->hw->wiphy->bands[NL80211_BAND_5GHZ] =
 						&vnt_supported_5ghz_band;
-	/* fallthrough */
+		fallthrough;
 	case RF_RFMD2959:
 	case RF_AIROHA:
 	case RF_AL2230S:
diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
index 4d6b48fd119d..94665ddc36a5 100644
--- a/drivers/staging/vt6655/key.c
+++ b/drivers/staging/vt6655/key.c
@@ -51,15 +51,15 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 		/* default key last entry */
 		entry = MAX_KEY_TABLE - 1;
 		key->hw_key_idx = entry;
-		/* fall through */
+		fallthrough;
 	case VNT_KEY_ALLGROUP:
 		key_mode |= VNT_KEY_ALLGROUP;
 		if (onfly_latch)
 			key_mode |= VNT_KEY_ONFLY_ALL;
-		/* fall through */
+		fallthrough;
 	case VNT_KEY_GROUP_ADDRESS:
 		key_mode |= mode;
-		/* fall through */
+		fallthrough;
 	case VNT_KEY_GROUP:
 		key_mode |= (mode << 4);
 		key_mode |= VNT_KEY_GROUP;
diff --git a/drivers/staging/vt6656/channel.c b/drivers/staging/vt6656/channel.c
index 5d57d34577f5..7855689af7cb 100644
--- a/drivers/staging/vt6656/channel.c
+++ b/drivers/staging/vt6656/channel.c
@@ -145,7 +145,7 @@ void vnt_init_bands(struct vnt_private *priv)
 
 		priv->hw->wiphy->bands[NL80211_BAND_5GHZ] =
 						&vnt_supported_5ghz_band;
-	/* fallthrough */
+		fallthrough;
 	case RF_AL2230:
 	case RF_AL2230S:
 	case RF_VT3226:
diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index c66cb53cfc09..70f75c5760ce 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -67,7 +67,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 		/* default key last entry */
 		entry = MAX_KEY_TABLE - 1;
 		key->hw_key_idx = entry;
-		/* fall through */
+		fallthrough;
 	case VNT_KEY_GROUP_ADDRESS:
 		key_mode = mode | (mode << 4);
 		break;

