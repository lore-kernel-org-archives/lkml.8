Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB2BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964B820C09
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="P4fGsJzs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9H0TRGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgICIMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:12:30 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48409 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgICICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2B1C295D;
        Thu,  3 Sep 2020 04:02:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HP2Umc0xayx3I
        eEsu6ucfKoQyCoydkeUKb+6o6lgPuA=; b=P4fGsJzsslLqTPbmbbJGep0U2lR1t
        fEOxqpF5Xeur17AIK/edcWAohSs6XXu59noedq+C6T5tJjnhsHEMqmY57DpFA4EF
        gOdF6fbrAXzWydJpX7yKAQxuqPgo3NW4CZzNE45GDbS9bFw6X8BLLRYp/Wv41fzW
        Up5WtK2Eltpo0K0NHx6xBXZ615UPKhOOcsMZsq1oevbvuRI12B4CBOc0W46kFk9G
        LQqThTT65wvR9QHdSOOPehT3j1RdTDWc17WAZMz890lYXM1l3IfYCcu1H74CAAY2
        il4G662zIVFCoj/dHDlHUuwBgK0gOGuKtQFtllHcQ3thXGfuC4OZ3rgYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HP2Umc0xayx3IeEsu6ucfKoQyCoydkeUKb+6o6lgPuA=; b=i9H0TRGI
        V8lUlwxTGyT6ncP0p9M5Pj9/2idKIsK9z8fma2T4Ehh/uHTtcN3g3OcnYgT8YhIB
        QSQ79SfUtSGrSmGViLa/86I/pgNmL4grR03S5U5o87wDnlVTDTrx3DN+LdRJ5nKg
        e/gSGHx2+q0/Vfrm3+yMrIafpIxCbFMDOYdXYyT0mUekU7uynUeA3vIMAmHENQML
        pWDZ7c5BQhZlaVxjmPwGMmdZORGHxUylT2QOyaQJ30VCMSD+nXv8T3mMUlTeVd6O
        +yKnKM+VWo+L8l9ADD6//2Jv4uWty/SGOIilXabMckIYb58Cdll81cyEPwLvScOf
        v5PlZw4r7QLK/w==
X-ME-Sender: <xms:BKNQXxIelnp3OPAU4ZiQoHSA5X4UIfJkUClNa8ynDU8u6CjXB-Oj0Q>
    <xme:BKNQX9IVfa0u-ZFNYN1acAqa16_-uEHxROjmnol-ARk3vN7cJAGQkRfGhSPa7aV17
    SLcbNzMrQDHVJFlh6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedutd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BKNQX5tO1XBkbL46PxX9HK1z8WSQfSd905Yhfmmw6jnVVc_GhlBQSA>
    <xmx:BKNQXyYmOdUJvdmtR5NK_MJHbZAlh6IvxZy8xKWG7ZrRjmnta1-0aA>
    <xmx:BKNQX4Ym53waRpRFPE6RMy9ADTczA7Pt-m-q9pnd34gb_ZGgOMBpxg>
    <xmx:BKNQXyAS9fPten9k5mk3ufKAKBKRJKuOBpP2ernML55osEZggLPu213mGR8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 685FE306005F;
        Thu,  3 Sep 2020 04:02:12 -0400 (EDT)
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
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 13/80] drm/vc4: kms: Convert to for_each_new_crtc_state
Date:   Thu,  3 Sep 2020 10:00:45 +0200
Message-Id: <a712d2b70aaee20379cfc52c2141aa2f6e2a9d5b.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4 atomic commit loop has an handrolled loop that is basically
identical to for_each_new_crtc_state, let's convert it to that helper.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 210cc2408087..a41d105d4e3c 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -152,14 +152,16 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 	struct drm_device *dev = state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_hvs *hvs = vc4->hvs;
-	struct vc4_crtc *vc4_crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc *crtc;
 	int i;
 
-	for (i = 0; i < dev->mode_config.num_crtc; i++) {
-		if (!state->crtcs[i].ptr || !state->crtcs[i].commit)
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+
+		if (!new_crtc_state->commit)
 			continue;
 
-		vc4_crtc = to_vc4_crtc(state->crtcs[i].ptr);
 		vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
 	}
 
-- 
git-series 0.9.1
