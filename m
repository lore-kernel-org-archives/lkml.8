Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405BC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3985206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgASWCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:02:46 -0500
Received: from mout.perfora.net ([74.208.4.197]:36725 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgASWCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:02:45 -0500
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.128.11]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LwYMD-1jhRgd1qLX-018NA9; Sun, 19 Jan 2020 23:02:16 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     info@logictechno.com, Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        j.bauer@endrich.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: panel-simple: add bindings for logic technologies displays
Date:   Sun, 19 Jan 2020 23:02:04 +0100
Message-Id: <20200119220204.208751-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119220204.208751-1-marcel@ziswiler.com>
References: <20200119220204.208751-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hw82bcaPWPwRrI77lcUeqVX5rPe9mSITMwkyCj3DhwJV1Jy7sjF
 G5jsx6nFQbqTzb6c7zCwHoDT3mVvsPgQq9HaWVVQEiQIU5r3LbvE922LooRY79Ys/eJdkLT
 rb0w0yIimcbuvTtxCi3cUlDS05RlV+m/XBQwmFW7l/RS/Kc8kNc6KYvhfc3Aap2fAnpQ+n2
 bQ5usd69vFLeQONi3zBjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Dzw8OPAP0c=:LQ3DaTyXz5b3qvwlMcnIAE
 xYeeJhTSTiAR+EpElIKLBKyDResj1z89YLeTsTwZ3960xiI5ol+ngFfcCwCOs8D2ZcBg1TzSH
 RbRx0y0dhVB/OOnlVVJmNxuo+kW4hmN/KmQ3f2HWYuKzC0nMhPjvXYq2dg3IZ8HCNoNWw2HLY
 G5tZW8rqr1+8ewAKR6GCepQ/gqIHEHeZ5MQ83nchB7H2eIEyXnWollXxn/YRLmOow9EODN1ib
 VlriWgNh/b6hdmufy1Yok2qQCv2d+kZaP63EGJfGP3N8lxIrXDGaALdqj6h6l4dArAN4o64oa
 OD3GFwExVIxvt0pEPjsM5walBPrwFMWLFn5HHwtRgJ9P5O3a0i6O3JfkJkU/jRoRS5FyTA6Zu
 zr9O4Kuqao7M+39PfcbQaHKukFGSzftRWygKdD//Uh+L2/Qy3lj25wZnLo0pjc3fcJu2q2ee0
 JV6Cd2wCcB5Ck98IDWnWkHD3sV/fdpm5mA88etikI7A0rvufWyNgzSiaCWz+y/W2akJ4DxRI5
 pgDEMtG+Q0FLkR3aQ3XbOobwuGV+vqH7AvX8Un8Sc8zXW4kbQxo2E9CRpoMvqlnbbqMJOd3mY
 e+HiK9phSggXfYipt2d+OS1MT7jONZx8inZsdo8Cx8NJzE4mt93nH5sa1dsmx2BHEXtNzzq8F
 cgcZS062SXNJwpFiO50gbdEObRjfWruDqIUPPb/8oRUqkNJzVVxdfT5LD/X7lI+tpwIHKn5BP
 Y28Y/WG2gKxuE94wAaynZtNuv0TAVeYUsFboPlRnxBJ2a/y6w9/fKIHBuP5elp1Qp0qkV/AU2
 4oYnccDfwd6glTzE62ur4ou2YzC9y9JdwFbVVvLsG/2Wvv43mYXvOgeiCS0dCzMirO/8eZPDF
 FzYgPv9udhzi0Cxh2F3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add bindings for the following 3 previously added display panels
manufactured by Logic Technologies Limited:

- LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
7" Parallel [1]
- LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
Parallel [2]
- LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
10.1" LVDS [3]

Those panels may also be distributed by Endrich Bauelemente Vertriebs
GmbH [4].

[1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
[2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
[3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
[4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3:
- Add it to recently introduced panel-simple.yaml instead as suggested
  by Sam.

Changes in v2:
- New patch adding display panel bindings as well as suggested by Rob.

 .../devicetree/bindings/display/panel/panel-simple.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 4a8064e31793..f33c5d979f96 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -41,6 +41,12 @@ properties:
       - frida,frd350h54004
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
+        # Logic Technologies LT161010-2NHC 7" WVGA TFT Cap Touch Module
+      - logictechno,lt161010-2nhc
+        # Logic Technologies LT161010-2NHR 7" WVGA TFT Resistive Touch Module
+      - logictechno,lt161010-2nhr
+        # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Mod.
+      - logictechno,lt170410-2whc
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
       - satoz,sat050at40h12r2
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
-- 
2.24.1

