Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85178C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF6B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Vud+dJP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCZR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:59:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:54989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZR7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585245572;
        bh=cPjKmWw8meoxOOBomnUDNFhhyBAqdxH6BTS5Evx+ve4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Vud+dJP6a5kczEoNBwR36K2uBBL547TniEzDA6KoFmnCTKElpwKIZzQJEIC/csKKA
         vP/hiwYytKI5i2O0DCfvQwIiwCC0r9q/jcfuWGcsTnHVnetPxXryhMRdFD5Uyy22TU
         6exsUWs0c12KoJlIQJAEu4Yk6dwz6HAS0fAv21rc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MbRk3-1joeYH1qNl-00bsDl; Thu, 26 Mar 2020 18:59:32 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use DIV_ROUND_UP macro instead of specific code
Date:   Thu, 26 Mar 2020 18:59:02 +0100
Message-Id: <20200326175902.14467-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ehfgG7X17anP/3NHQibLpL75ANGu1+tTH2VrJUp1HUmlV3TbA7X
 jap2Mw7ExHxp17/JrmAOjkt9LvHt2SIaItOGmWoWdT/9eKeIIIXZQmDTvZ3E1lNaLyCbHUH
 urVu6FaQO3wmKYM21G/vmlIDaXhmvmphuclgv7RSMSpbSnWBZ2QmaFp6k1VHZeRd3/GbEDy
 q2xJufiK2/BS7Fi/2falA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:InpDidYQ6xI=:f5Q64SxSbPBU35Js9Q2VsW
 or/nLYfU9MCQ5pPXEcynGskxs8BGznzoGlZ0BVjFGkEkmHuKg00RFXZ/dRNY/C0iLFCGrvN7s
 TNJKxnkbkzI+cB+5LM7s2XIigAbIohPuQDnvNkCCwsofneCGxpMPNo9AYQCUYgvZLbjnsmxMP
 ZIkw8hFm3mIIhIoigQEftwLMIZDQyj7UJqNSbBzzSjGrhfq9WRpM/F3oIFij646FvgzLQBsol
 JG5GmnpAjNtCjveYmyKk2pMJu+9ItCNsTqbFXXTHCYdHsgHf2c+g3mZzPYjZ+QQTRsx15Dzyl
 HSZMiijSOZy1FbykZwYxV81q8k7zqH28hq9vjZ89u73NNT6ADa6MwsRatSsU/ySUriqVA83Sh
 7YP7iZ9rXeEkqTP+AjI/lUGAeFqpHZ4V+wUQa8xcMCksvlYsD4n98D/O5ESI7/HVODg6FfA5z
 894W0w0DRBJo9iK+90qaYA2pxP4kK4VgBgp8eXiJNL8szH83X+Bt6ygWPWlZx7wEjnNP4m9C4
 4agHAZ95E4mYOeTpeSyEHqNLZADXkodsgGK0NICEGwgEeJrZLqeKjWk0/AnPJyHjPI6yp51Jt
 NgiOvSBnkre//kRXGgC4Vahqgu9L83qfoEUs2VfHOlI0aF/JZtA4mA0sP4apAKbF7RJe/lyva
 wFSx55N+WcVYXsmppADQKB/9/WZ+CfCd+FhsoB7Uq33Hu9MduTW9t7CLfxnCEQo78XpodG87G
 XJBVlW43wjf7h+0yZiGoO9ior5Ty8jyMTaXlJTuw9gnX0BKZtgWtY4qy93qspK2vCCN4ZKaia
 IzChEZXWuEwsQ+BZG5xRcJ0zkBTbAPRd3nWY6jRG5VFG5EZ9YyLfHagTrHOc+qHHz0LXeynzP
 R/ucGktKtvy+w1SISzN1Py9i9teyOWlFTGpmxLbWdcccEPg1LfS7ahvOfjf8gFhXazxUGX9N2
 JOc/XBR/jwub+H1XoMp3UKruTh+sBeJrz499T6/B+sqk0GRRvNapwNTxAo1+klmBaCU/nJOrE
 Zr50Z0RhKwYxyyGsnBwQLOX7MUpj9uwfwGaDqhLDa2ltyTM3c2caivGC/0vt5XETRJRnutWkz
 9hRfjSATCNWDVmfEklXGvQxHpK2fyXt5y0sfRut1hDGTLANTbfPELEY97cHdYJcQp99UBUhHR
 Ex8JzvuOkytssm0KCgqno0BCAGEAHu5D6Jasy/SpSXkxFMkqGCyYypFT5+RszSd1MpO7OEGKF
 i9SSFzBDMK4pxeeKF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_UP macro instead of specific code with the same purpose.
Also, remove the unused variables.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Rebase the original patch [1] against the staging-next branch of the gre=
g's
  staging.git tree.

  [1] https://lore.kernel.org/lkml/20200322112342.9040-1-oscar.carter@gmx.=
com/

 drivers/staging/vt6656/baseband.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 0b5729abcbcd..a19a563d8bcc 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -23,6 +23,7 @@
  */

 #include <linux/bits.h>
+#include <linux/kernel.h>
 #include "mac.h"
 #include "baseband.h"
 #include "rf.h"
@@ -133,7 +134,6 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 {
 	unsigned int frame_time;
 	unsigned int preamble;
-	unsigned int tmp;
 	unsigned int rate =3D 0;

 	if (tx_rate > RATE_54M)
@@ -147,20 +147,11 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8=
 pkt_type,
 		else
 			preamble =3D 192;

-		frame_time =3D (frame_length * 80) / rate;
-		tmp =3D (frame_time * rate) / 80;
-
-		if (frame_length !=3D tmp)
-			frame_time++;
-
+		frame_time =3D DIV_ROUND_UP(frame_length * 80, rate);
 		return preamble + frame_time;
 	}
-	frame_time =3D (frame_length * 8 + 22) / rate;
-	tmp =3D ((frame_time * rate) - 22) / 8;
-
-	if (frame_length !=3D tmp)
-		frame_time++;

+	frame_time =3D DIV_ROUND_UP(frame_length * 8 + 22, rate);
 	frame_time =3D frame_time * 4;

 	if (pkt_type !=3D PK_TYPE_11A)
@@ -214,11 +205,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 =
frame_length,

 		break;
 	case RATE_5M:
-		count =3D (bit_count * 10) / 55;
-		tmp =3D (count * 55) / 10;
-
-		if (tmp !=3D bit_count)
-			count++;
+		count =3D DIV_ROUND_UP(bit_count * 10, 55);

 		if (preamble_type =3D=3D 1)
 			phy->signal =3D 0x0a;
=2D-
2.20.1

