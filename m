Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA5C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E0520719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Vnjc0av1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCRRlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:41:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:45143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRRlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584553260;
        bh=vCgXZ2I+Xf8X2pR7gWvHEO+dE4EhgtLquAj/ck7xEj8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Vnjc0av1x3dyOYUm1G/PujvpeZYIxuWq5g0K5EM1+bvDSRx97FEIyTPrlb0kwY3JO
         cyOwYS2kLNsdSTPnvvj0Ldm1s/Ax7tK7PnGiHOtTLL4ySA+d0Cfcb1U1wlkL7zYPCI
         oPqk0mkwTKn7k8JqhaVhg9Sp1qVCL9F9a7x+hb2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MgNh7-1jmYSq3rBv-00hyB0; Wed, 18 Mar 2020 18:41:00 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use ARRAY_SIZE instead of hardcoded size
Date:   Wed, 18 Mar 2020 18:40:15 +0100
Message-Id: <20200318174015.7515-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Kz+2ZK4OkT6fKoYDfLfppenzBOKnJHXnSZKnWuc2wQdKuuSwgZ
 LC7YodICd25iZrsFRfAefnR1nwcvgWMJRL83EWkr2AlFfxdcBUpBmw8z5LGAuKbTBxEekPu
 cuhwcore9TN9yZRzgKZ7KtzQZUw4u+RoQT3ufB5V4eLBa4yNXTAocMGTRtXWWfDV9oVqZzK
 A/6CatuXREpwgHSSz1LDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h0lERaXlW6w=:LJHAJpG0QQhm7qQW5MIU2W
 vQ+W+2gzCPTT5SB/X/gU88eOYBHO07m1KgH8hhpaIcBe08pYO7dRN6QZ5Hobu/RCR5GYZ01zR
 P6Tt6eY3CWToJgq1vZBKeHMHKVW1IRxUmKWkSTu1YHPZJ7HCilW7NJqEjSlfZds53dCHy38I1
 Ne9myH0rDQY/1FI/JPnlEIemlkIHYmzwxRhyhBWsevC/5f7YuilKg9DEq9su1JaRyzYPgUE0u
 zgHIW44TsadL3lkaFmcPgKhB32soxBDy7yXlsFiQfFC5PDxSsbCMwBy3FsbfVrTnsXweJO8tx
 BqlBfyssM5r3KUjfOTr9cNQ7EXwJueeRMY1DDCef7yeGV714dYtZ3Shr7S820t/ck6QHyRgZ4
 l9QAum7kjtV+PAuyH4/FQgPvwys2Fl53hkTfa9CESDTSUp1eqP6MEuuZMCbNvGLHOBlgZBxUu
 hZZlXa39A1B+hARBRxpdq9Hpi9Vkw6Xwkg+V7L2qmRnw7EOZkUUN4AxVMLoOZOJX8e8Bh1xph
 i9UXQYAGM0SNjZTgsqtWKA8vS1v+vXXAS0FyrYoySqQEBiGC4jg7GX0Gq1staQftKlaq65xUJ
 sTbkhDI4sCVjqLpSzEf2+orp8+pIruLsGNqzFzW10FfEu/5MUDLKsTCiEGm/KkrkUFWIPidhE
 ZW4z/+BuZGUxSEj13CziCEPo+Wc2kZD5jKQ/wv8WqArWQQwm7lAR+pfoVWhr9rGBdBRPdyDcL
 gE5dM5f/F1jP93kjzy0nkR7NkQeOcYGf0D5bCOY81TsEPc/LehHZk4naBBT22Wq27xsJvcvtE
 qBZp98MdjWZni8nL27ZUjhLFhk1TkeE4z/guwCT72ZG6GB0vLF8RvCJqLQyUYyGHSdTYX7Xck
 XbfdDwHyclf/mQ/6RbQsU/nLGFKWqeERX+oLJjoVj8afThI2IQpe3P6KjbeiFyh+/vtULz9Xc
 nEq/yAEretjrWwbR+dQf67pyKt/3vBjPJfoKCf+uIke5oRJiNcsDfKonGD7ljD5P+gyPG0dgf
 vk/7iOVxtQ0SFMfm/va+3yaaDiCzeuo/T8lpFf1Lqhpp3dCtGrtClt6sthR7g+/JqOUaKj52C
 XRpSKGnmDzGSVdczoroMl59+HLwAqj6FVgNlZaHyEwdJehnAPNZXpeG7ug8OofRoT/XTKcR3N
 SwourUVrIriE3hOPWuGfszqhl3KlzYykplK9UDG0VvAvQuSJsyT9NCOmW6NgUmiOduWI8zN1P
 HKfrbqiKZsYejCKP0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE to replace the hardcoded size so we will never have a
mismatch.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Use ARRAY_SIZE(priv->cck_pwr_tbl) everywhere instead of introducing a ne=
w
  variable to hold its value.

 drivers/staging/vt6656/main_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 5e48b3ddb94c..acfcc11c3b61 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -23,6 +23,7 @@

 #include <linux/etherdevice.h>
 #include <linux/file.h>
+#include <linux/kernel.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -145,7 +146,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)

 	init_cmd->init_class =3D DEVICE_INIT_COLD;
 	init_cmd->exist_sw_net_addr =3D priv->exist_sw_net_addr;
-	for (ii =3D 0; ii < 6; ii++)
+	for (ii =3D 0; ii < ARRAY_SIZE(init_cmd->sw_net_addr); ii++)
 		init_cmd->sw_net_addr[ii] =3D priv->current_net_addr[ii];
 	init_cmd->short_retry_limit =3D priv->short_retry_limit;
 	init_cmd->long_retry_limit =3D priv->long_retry_limit;
@@ -184,7 +185,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	priv->cck_pwr =3D priv->eeprom[EEP_OFS_PWR_CCK];
 	priv->ofdm_pwr_g =3D priv->eeprom[EEP_OFS_PWR_OFDMG];
 	/* load power table */
-	for (ii =3D 0; ii < 14; ii++) {
+	for (ii =3D 0; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
 		priv->cck_pwr_tbl[ii] =3D
 			priv->eeprom[ii + EEP_OFS_CCK_PWR_TBL];
 		if (priv->cck_pwr_tbl[ii] =3D=3D 0)
@@ -200,7 +201,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	 * original zonetype is USA, but custom zonetype is Europe,
 	 * then need to recover 12, 13, 14 channels with 11 channel
 	 */
-	for (ii =3D 11; ii < 14; ii++) {
+	for (ii =3D 11; ii < ARRAY_SIZE(priv->cck_pwr_tbl); ii++) {
 		priv->cck_pwr_tbl[ii] =3D priv->cck_pwr_tbl[10];
 		priv->ofdm_pwr_tbl[ii] =3D priv->ofdm_pwr_tbl[10];
 	}
=2D-
2.20.1

