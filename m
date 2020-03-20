Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D962C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314920767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="byjtBHFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:14:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:56529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584728066;
        bh=NVeH1dn/ScU37/5w8nAopqBEabpDsLhr8PY522Oluf4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=byjtBHFYxpwYw471ZevoY3znIOQpJT4UPv2P5NGrIYHZzxMA1oCwRoKn3QmcwCxB8
         FTB8VkxIy9P5tx31BeAKhHX3p/Vg6B/knShXMMwRGb/Zfkk39X8clO61oshnSZfHwF
         SKeFfZDutDfkFeyoRUUj3OtvO3enchP0bNLhlnp8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N7zFZ-1jKIEs3q9D-014y8B; Fri, 20 Mar 2020 19:14:26 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_* functions
Date:   Fri, 20 Mar 2020 19:13:26 +0100
Message-Id: <20200320181326.12156-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:japkTAZTvJrWPT6iJs0JHtU2NsctqO1+FSu2OWQ+Yt+bbaOGmPd
 RVb9VKbF8MpuokKF2fXXRIuYCajnrH1hwx1dDyyMjacRRhp93/FkcZzAty49Xk4CWIl0yr5
 p/boc7X632/Txp3Zu7hNBT7GOR1Fwx9D9PtVx2TTXOYOmoBUYpxfu8Fvrw08Nw4uakDTmYg
 J6bT/dBIJ/+iw+wxv6GAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+3GjvuRnz/Y=:vFxGFFT5TELS3m8Xv/Av9f
 bFkZoQGaNhuTnC5yElBDg3orTyD7JiUCJoiJyLLcaYL556yjDnHNJKoUEMJqinJIZTyIaxmct
 auP6uVbDSshq+lWcSu0JkD3fBYB20WRGgAskSwmtWxQeVop0MvwRs6ynP3vYDdjtLuNx4GeLR
 AuYIuYRTcSbQaP9CtDQ0QLYpgfygM74/pxJlHY46tzBFgNfsSpILD/J5q6iFhpu0DieaMH3dr
 E5zlrKBl8G3reNBpijYBfRumvNFlmC29i+6lHzFN5RaYISDTXO+O8VOQiY/wejQS0rRLFUTtd
 sbt67aU3Q3xXC/nm6Tj2SNf82O4wht00q0DozpL3HY2ahOtPWmNS30SpeqbxxMiRJ+/QMlVh5
 dIeRCUEJ3aRxnFfvY+zdmo0CBhjWRYLbsl14wDUEbHWP+l8h+J6inXGpjVQUEZ24L+Wg5IuJH
 P1QLb1LHrdXvExSqqBl8w5hLOvbd86xEBLIvYEZrn6FYzz7iq/faNylbf2IvSq4fr7JExYBYs
 P5Bxq2SqxjH/XDeDVEZe1kkS72FwzJUh8s7skI1utNaSQ2vmZYhsP1fTymdvtWXIIh9kdzSiQ
 fcY5cPlfDp6tefnWyzRR6vsquOd8gXv6+O2L/t+WpVFc+zVB8oekveHnsRMB/ZogsRzLNnA/8
 lLDh9PdfibKVqydz6AJQmNpPXH2xJsJoHa29T+Rwg6Ur/96geFijs5+CCA7i4sA9zxjDCYlKI
 GVGii4nf+LEbp9BdQFGLuFqu58W1lWg2TWlxQvuHWv8E0lXYfLu/PT9I0NUw4kVVm/ADMezr7
 ymM3RlbIs7ZwFfiuKDVL+0VMLH8L+2kd+hKMHGQ//70147Cu6A1jsLLJydOv2oGQvwWmXFN+n
 ON0XXoaB7PpZE59PQCGLZn1t1sFIGgHwFyBR2E+hHfzGivcUEpNmnIZPHp855KNOG6ya9Sanr
 TR4d2XBgn4VVMgoWeDfLAVyEY6YcGApnwRxG7VT+Lh2znLpaRp9st80EDUTEO+GRawbdT7QQK
 +1yWfTOPCHGLnYyZjv7BoPePLeI9oBNEzjipR9ZG4hguZrK8atGFuCxyzIF9VdY5M81nDswb2
 gARwBj8U9bSEycurNkc4Gw7w3ah4u6HO9C1rQY/yJ5fUZwO1tjw58qxAPvpniSm9rDAJESKs4
 aNI84XFMl6my5wTEPQdd36QDPa7xdkLXp+dkfndb9/5BJxY2eQAcylTc0TAJ1s7wvmZm4jb++
 MTkXNWjw/SoSndo3T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last parameter in the functions vnt_mac_reg_bits_on and
vnt_mac_reg_bits_off defines the bits to set or unset. So, it's more
clear to use the BIT() macro instead of an hexadecimal value.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 5 +++--
 drivers/staging/vt6656/card.c     | 4 +++-
 drivers/staging/vt6656/main_usb.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index f18e059ce66b..a29d9f4f575e 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -22,6 +22,7 @@
  *
  */

+#include <linux/bits.h>
 #include "mac.h"
 #include "baseband.h"
 #include "rf.h"
@@ -468,7 +469,7 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		if (ret)
 			goto end;

-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, 0x01);
+		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
 		if (ret)
 			goto end;
 	} else if (priv->rf_type =3D=3D RF_VT3226D0) {
@@ -477,7 +478,7 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		if (ret)
 			goto end;

-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, 0x01);
+		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
 		if (ret)
 			goto end;
 	}
diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 7958fc165462..dc3ab10eb630 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -26,6 +26,7 @@
  *
  */

+#include <linux/bits.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -63,7 +64,8 @@ void vnt_set_channel(struct vnt_private *priv, u32 conne=
ction_channel)
 	vnt_mac_reg_bits_on(priv, MAC_REG_MACCR, MACCR_CLRNAV);

 	/* Set Channel[7] =3D 0 to tell H/W channel is changing now. */
-	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL, 0xb0);
+	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL,
+			     (BIT(7) | BIT(5) | BIT(4)));

 	vnt_control_out(priv, MESSAGE_TYPE_SELECT_CHANNEL,
 			connection_channel, 0, 0, NULL);
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 5e48b3ddb94c..1196b6e28c22 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -21,6 +21,7 @@
  */
 #undef __NO_VERSION__

+#include <linux/bits.h>
 #include <linux/etherdevice.h>
 #include <linux/file.h>
 #include "device.h"
@@ -370,7 +371,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	if (ret)
 		goto end;

-	ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_GPIOCTL0, 0x01);
+	ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_GPIOCTL0, BIT(0));
 	if (ret)
 		goto end;

=2D-
2.20.1

