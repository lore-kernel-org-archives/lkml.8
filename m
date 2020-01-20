Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BBC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72BF207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgATICP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:02:15 -0500
Received: from mout.perfora.net ([74.208.4.194]:56535 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgATICO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:02:14 -0500
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M5O2r-1jq3lT27Bf-00zXV3; Mon, 20 Jan 2020 09:01:08 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: add vendor prefix for logic technologies limited
Date:   Mon, 20 Jan 2020 09:00:58 +0100
Message-Id: <20200120080100.170294-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cz02pypmXVVY9XStb0HoEZkx90vTXXjTAnxUxTCC/wEc/muxf/f
 AJAG1HLkGWz4YsSAlYrIu4ElEUR7z6r56s8TmO19+3b292a/Pvewx3QCaEwdvzQc0CLRHe4
 OqTco8zERosmNtc6+SbmNbaZkLKw6XbpvXA0JyizMUYY/nDnwx2XRR+m+uDdshsF9ZECjyU
 BxGjZgn7K+Nc5XiuUk6pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpKVWY8NVCU=:A8i+IMii7mHWnzZPyIhoTq
 60gLU+m3boGJcEechrLIBb6UWPHspULkn7x1DyF0jIIcxKMnH31oINGHoP5kKk4F3c1Pklk8Q
 LoKGfl4XRa6lQDpPS2yEy1cI77IGIXxyYERX8yWGGoxKKgEXHgcrdjPPzhEZJs0IQIh9mVx0L
 IRNII7qpfWA1IlZqWv+TFRAzZY2rCzbIC3UJbRh7AyxGCSTJnIPAivMQ35GDtroj4BoOBTWxP
 LwvmHp47lcMsIIXMD15ERoqZ8w7Zc8vNkfYYg7g5A8s6Dwsm3k5+ckSTZvxCSNZPK7KafdQrr
 OjeK8Ex5WxGAoozdtY6ClPSgnmPVhfaPxFSPAX3dR6ULUW80sF/vfj6AwR/ARSO5pYSHv6utJ
 2PBIqOg5m2kg7xzquw+onkTgX/mAEZ0J4ho8SNmKz6yNh4vh8m0gcbRw2rvjVXnjhSJVq0FOo
 2nKj9fdEEwqrQWQiqFriDcnzwoKCt6uKqmPcvjiQCm4rbp278N6DjOcV6Sfrk76d0HKwYUgP4
 LjQD7u2ohhTHTcSTUcP7wXy/NVm4xAzcG9LttYD2u5Go+t2cmXOeAIyS01kDdHj0s+WhVNeAd
 yx0e3dH4uTplhsJElQob3FFNhjuOkB28K7AjhmUP6jXHa64NyvTNDyhBeOtZrUuo3LfwOViPc
 og00QIEt7EDT/g34nQFqCVBsgyO2bMbeP1g4LaW59D3qZdgPOAOazg4WXtRKxAVROPs5oWxKw
 x1JD/EAxyqoO/SvT59u7OcXM/FiBJu0DrgtX3LmusJ6IoYFcbysaRzgr2X5+GdoR/BVJ+5pku
 6Ziny4Kvc3Vg4AS4NXk35tHbCu12jxW/GkucotLLK/DC/uDCVx7tRkFs/rE5dWLSyqtk9Xtt9
 lXvFVLCWTNMUtElXqFjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add vendor prefix for Logic Technologies Limited [1] which is a Chinese
display manufacturer e.g. distributed by German Endrich Bauelemente
Vertriebs GmbH [2].

[1] https://logictechno.com/contact-us/
[2] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Added Philippe's reviewed-by.
- Added Rob's acked-by.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f9b84f24a382..ac4804d0a991 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -549,6 +549,8 @@ patternProperties:
     description: Linear Technology Corporation
   "^logicpd,.*":
     description: Logic PD, Inc.
+  "^logictechno,.*":
+    description: Logic Technologies Limited
   "^longcheer,.*":
     description: Longcheer Technology (Shanghai) Co., Ltd.
   "^lsi,.*":
-- 
2.24.1

