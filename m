Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A342073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATICB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:02:01 -0500
Received: from mout.perfora.net ([74.208.4.196]:41067 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgATICB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:02:01 -0500
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MIxBv-1ivMsA0LBB-002VEd; Mon, 20 Jan 2020 09:01:11 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: panel-simple: add bindings for logic technologies displays
Date:   Mon, 20 Jan 2020 09:00:59 +0100
Message-Id: <20200120080100.170294-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120080100.170294-1-marcel@ziswiler.com>
References: <20200120080100.170294-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s1YhVdw4eX8lnWxPXPUdwEDdSpyhr/cTaEUmZmnSuORfJ+RTbAz
 ZHoAsjJ2plmBFvYddfoQ8KOAu3OTokhtE9UsIW3H6kGpY8YzRO1SqaYzKTvs9CmqcZ+GhTh
 uE4ZY5T3SnfCn9WpsB/4HmH8grkCf58MB15hzUz82rIZSCCAs1EG5xOGc5ZYNvbwmgbqCrj
 24uPLf/+PaEuqouwR4CMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8rtjWTZ5I0=:8HwvfDcwTFzzPj/I7nHmXc
 GXqgYk+64Dm/Zy5mRLKzPSvlM+j2iTJ4GjYwRROrpvqiuOeaGdVNB0RXIr28rsh5i9YGhCr75
 DjT2st3H3XYE899Fs8uHc0CoTQ8jqmC6wp5L7ruDTyb0LhOP4Elldx3gq2DhfVaur/C3Jj1Ku
 K6My9rNJQ0xfO+bG/i9ZT73hU4pg1fEhULQEHEcP446I5WEMAfywraN5kYAeMPh44mCWvYXTk
 0mjUl97GDixde3gP7sbrut1L+EJ1Jn1I0ntwvEwD/E0plgxlvdbbgkNX55hN89qujEkJStHMM
 nwhwINulgjp9giFzBkyqGC+Y+rcGrTrIJUCZ4RgSTVZURTbSlVHu/njYCzzG/Zbf6C+jwxQa6
 TBJhXG1745hYVBJLC2NBq8Egc2kq8SDohh/3h72/dy5YHgIwO82quzm8rqerwAf6eYooL7U/x
 PsxQEVrrBbw6nU8NiwfhEh5013GoIyUu6NygXHaC1rQPxCgV9MCFs+cmiVVbh9YwVksGcctGK
 0NeMA//VtzWG7SYnsI1HTpZSRyCuOs/ClogaoGOkIgjdoyWO+2AnvJU8rO2/L0X+tZWYfl8Qm
 y/jxNJmctMG9S0PjhTrORC2w6qsOpiR3Ku/aDRIN4tPENmh633vVLThwSj5Dwmpe1DmBZI3GN
 UFcQtK1V3dD0EImRORcZGUoyH5jRspiDfJ2zZZCCop3nMQPeAX9UQPftjpzaviO3cKkYTnw1R
 YWjOYoWh4vMFd0sYR63sxLmArSUyeorNEeIl0eplK1KWgJlIHCl95D/c6W6YszKmtFtILEah6
 59yqiGg5DuY2aPSOyUFmy4AYHXUTDtEeCdbvvSCFQnRwCPiKBmxoyBD8i3Hx96PZwQIPUCfny
 xSSKh0v9+shMRaPcQEqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add bindings for the following 3 to be added display panels manufactured
by Logic Technologies Limited:

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

Changes in v4:
- Re-ordered commits as suggested by Sam and re-worded commit message.

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

