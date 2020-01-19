Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DFC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1C206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgASWCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:02:52 -0500
Received: from mout.perfora.net ([74.208.4.196]:46211 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgASWCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:02:51 -0500
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.128.11]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M41XI-1jkRQf2XHm-00rZmO; Sun, 19 Jan 2020 23:02:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     info@logictechno.com, Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        j.bauer@endrich.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: add vendor prefix for logic technologies limited
Date:   Sun, 19 Jan 2020 23:02:02 +0100
Message-Id: <20200119220204.208751-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jjLOqXuv2by4EJLQeH/ScEtpzVFtAz0VS19+C7zEHeSvWPbiTwy
 LDFUP9YFQGhtKnV6lBHbWFwnRF1t3JEIaYS6/OMyLege+P6xIkp1c3kalQtWUVwFYanNoOV
 rl6OMKDd2McWAR+kuocOyIzA262yJ1dvPoEtGSAuiRekP7NWGrWYrL9xhEUt1PSdl77X2fW
 rViBk0Qzt8Nw+iHRc7JMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpJcJ+lEr9U=:ZQw6NSiEGAfGxuK9wNrxVj
 sU4M386rfyma+qAxVEADpO7aQoqZYeiupu3Yk4NaCBT9iSsIBR+WMQydoVZFPkLEa4wKYgY/9
 ggr37kVjRXLCbaUz45PJKIomKeXTK6qTtNVwi4Ca1tJf6SVSFdd6Cx141yGz/zrbnWRXE0XjE
 qs9h8MIHNepTGAVkbT81XsMafbtKlEUytsEGeI7L09biQJcpAi0F7CzgfLzW+y58BEWlRwage
 2dEv3h/C0teHz5/avoJDG8yIY1oORLKRWltKBhjY4tQQXh0MCQkX4j7kcVbHbU0ZJb/6X28sO
 dCcpXQ6RrI1af5Z7np88YKWq3Dwqh2hZpdWi08tCsVJRGMJv22FYUJwaXbMaFSmWwqq0WrXNA
 E+C/Qzf4F7QeD6uB9btEuRSuzrC/K/94DGX4m5r1oaWW41H/4OGcjLvqXq89wHMDj2rRZ4liW
 VHtJRobmYx7qsKJMPqvyv+cTqa252XAiW5ovJIeewIrXUvlAUrtIgnGk7EknFMLVek9q4P1fM
 gAfP3fDLDyvQBRv5kEh0bCxMsE/0cwygZ/BpcXaYSvUNVs/jlYuLKzMPTRElElu4Vs2uhrdqU
 kQvxzhROL+SzZX0vrSJPBiGptp/CcA6/Zw11S9hRZJ291ybwk22wSxeTG3LzXhMP02WzazTYn
 43iYrCQtYPauFBvh5q1QPf2aRHotNDd2K5Ep2CrVYp0IxcskpHYk8hVeApaz7U1HV7jOhVCq9
 n2pxtu5J7qCio+wHhl6Ld/zlg0xSErrYU4DxvBG/hdeYZWnAs+cg9k+ESud5bD+GDsAFN+h2S
 xRCUqIjRPhoo6YZGuf3v9yc8ErgN5XXYmRkx+av29wQSKn1ha0KpKMA2sAtj7llVCtWmTOCYC
 Oa+ojSjUQoQa6Z96KwVQ==
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

