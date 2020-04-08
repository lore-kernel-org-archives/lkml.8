Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9251BC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDAC20787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgDHQ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:26:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgDHQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:26:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8XHb-1jHHhA1YYr-014Tax; Wed, 08 Apr 2020 18:25:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Enrico Weigelt <info@metux.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: mx3fb: avoid warning about psABI change
Date:   Wed,  8 Apr 2020 18:25:38 +0200
Message-Id: <20200408162551.3928330-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a1SttS1sh0V8p8yNp3DZOBnM7t3XNhEBzBMwVVmOUCS7K8nEh0c
 8njey4uOCRCAK8sgTmZLVKJHFuADY6t12iLayYT208LdNpRm9Nk2tYvZpNj7E+Yc/U2qtcA
 ulytP8YPz81OEx7SWoYabgaStCwARP5d5nQqJ862NIg3i/L0a0t/j4a9gOK5SZYohRsPksi
 bNGUs6HQEWyFiT+EgxmAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dk5f3Sr4sU4=:G4pwmQu7W8VWR/oKC4D7fh
 zYDpiz4/nmqqokBhiixH+tYQlboMpqizLqa98wG16tvgtwcmSxyB6gapFuYgkdXdiNRSNzw7q
 f6pK2VziehJuaGLcKDA7NXTbXAmstSsWfhKs9OFN15XhNZo5wkHNxCJrJpEdwhqIcTNJpR6aX
 cl7tu3JT3y+hHOcHtGwlki3J5zrvxxPWpIHOVG/CR5AYtwQj4JQ8vDNNquIjvOtKA0K+fCUHV
 1RF/GbCLqdMHdtIdy9fOy1JwjdBQF0LTM3uuIBSlWgXgh8kiqKw831N7blh3zBlzbZQ/70OWj
 EeDZfy5ywcdqhoPXklXwxmoCHKHB7K6dfBbJfZ9HOlBca/Y1W8rGJxRGPIqL/p26bDrQIIOBF
 H37E6PPuCrDz07n3VzWnL/zryCOG0fS4nBRbF+LHy/twFiGyQjwvFD68Yw0dE0GOoFkyQWwGt
 Yt61AHVZu1qETiIo9dojxRC/zZ3mvyun5Qf4Not90U9oCHBUsa/wlDj5LsX6cvzNJDGFM/M8X
 lXLrrZgIdoSPJ4Ingtj+USfaCKIlUmPNIWOYMuXcIYCGcZd0vJkgxsxr4OxxS328VIEPDed46
 MzwIe+hsdcsiMDXofUp1utgQGJOVpeJEono+Ox25sEQPZSPjxh+wLF4+1PFbKtytzJNlDrEfU
 kFFZc9URlkox2/4mqU5YYQlYEAmb6ziOaabhhB1n3YIq97qWkG6P/OpB5RmfhaJqm5m3j9gOO
 tuPELPlQUdNNqsGW+xHzppnJPh7i2hmUlOIdgU923HaMqJorb2RCqr1lV+8/EiQ2ZkJw6Ss/Z
 UbysbcvUGU1nYfLBnovzS1M1baR38tmUQOqpuh+qv9y19jvSYc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 gcc-9 release warns about a change in the calling
conventions:

drivers/video/fbdev/mx3fb.c: In function 'sdc_init_panel':
drivers/video/fbdev/mx3fb.c:506:12: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
  506 | static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
      |            ^~~~~~~~~~~~~~
drivers/video/fbdev/mx3fb.c: In function '__set_par':
drivers/video/fbdev/mx3fb.c:848:7: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1

Change the file to just pass the struct by reference, which is
unambiguous and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mx3fb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 4af28e4421e5..e13fea3a292f 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 			  uint16_t h_start_width, uint16_t h_sync_width,
 			  uint16_t h_end_width, uint16_t v_start_width,
 			  uint16_t v_sync_width, uint16_t v_end_width,
-			  struct ipu_di_signal_cfg sig)
+			  struct ipu_di_signal_cfg *sig)
 {
 	unsigned long lock_flags;
 	uint32_t reg;
@@ -591,17 +591,17 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 
 	/* DI settings */
 	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_IF_CONF) & 0x78FFFFFF;
-	old_conf |= sig.datamask_en << DI_D3_DATAMSK_SHIFT |
-		sig.clksel_en << DI_D3_CLK_SEL_SHIFT |
-		sig.clkidle_en << DI_D3_CLK_IDLE_SHIFT;
+	old_conf |= sig->datamask_en << DI_D3_DATAMSK_SHIFT |
+		sig->clksel_en << DI_D3_CLK_SEL_SHIFT |
+		sig->clkidle_en << DI_D3_CLK_IDLE_SHIFT;
 	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_IF_CONF);
 
 	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_SIG_POL) & 0xE0FFFFFF;
-	old_conf |= sig.data_pol << DI_D3_DATA_POL_SHIFT |
-		sig.clk_pol << DI_D3_CLK_POL_SHIFT |
-		sig.enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
-		sig.Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
-		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
+	old_conf |= sig->data_pol << DI_D3_DATA_POL_SHIFT |
+		sig->clk_pol << DI_D3_CLK_POL_SHIFT |
+		sig->enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
+		sig->Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
+		sig->Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
 	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
 
 	map = &di_mappings[mx3fb->disp_data_fmt];
@@ -855,7 +855,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
 				   fbi->var.upper_margin,
 				   fbi->var.vsync_len,
 				   fbi->var.lower_margin +
-				   fbi->var.vsync_len, sig_cfg) != 0) {
+				   fbi->var.vsync_len, &sig_cfg) != 0) {
 			dev_err(fbi->device,
 				"mx3fb: Error initializing panel.\n");
 			return -EINVAL;
-- 
2.26.0

