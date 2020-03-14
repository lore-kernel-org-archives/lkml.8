Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E54FC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389A2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZeR190iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCOCXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:23:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:51867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgCOCXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584239017;
        bh=V0rq/NHA00NI5YnNp0x0uYL1fI/UE5EKZlIF0XhdxTc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZeR190iGYErOkG14DcPyoWDG+9wpU8BlYLQ9OLybGJThewuUgYJ6UMzX6T477ux4o
         jdQJ+1Bfa6Z23DfK+2wruSxlbisp0VGoM3cFjyeCCEFgbvRIjHAj944c/KDsiEQssz
         HI06DIO7boJTCRUOT5OaYVNjN0ehRbSD6EqBOUJM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MmULx-1jdSIk43NZ-00iWkv; Sat, 14 Mar 2020 17:48:20 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use ARRAY_SIZE instead of hardcoded size
Date:   Sat, 14 Mar 2020 17:47:54 +0100
Message-Id: <20200314164754.8531-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VqoulxDnv12K6z91LHZ6YrGqLdCMqF0Pa57KICKH3pdWYb9OcmH
 n+5VUMqHAwm75wJO38WkU/60n0tF2eZLwYkBW1d6yEGF7T05XxDjhljoF+sP9aKvmX+fRaT
 Xh6y+PORdU4K3oA+v75KzDJLQLu8/+Y7io9eHAs0ytG9mIcivfooyZZpnptHw5zilPSPHAj
 3LGPGTQBflZSM8MAK/x9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5MeGT5rzhdw=:UeLno0Lm86hQkseI50F2fv
 Q7mJ+xDjrwGQXfTnAlwMqmozrcYDxV7HU3l2O44g3swEraqtsCUOdU6DvSMWUFG5SnE9AJthm
 Wfbad9RVEoDDPSSddrTLntMG831rrnMpBSc3km4aFLqI2QkIKzYpkiGny1H3axz1M94ylmNAF
 sHPcDRKYZGZmBlRgfKRVdk/5wE5e5iqbW2wTqq6esfV7lRhzmONfMGyXqqrKUqJ1YTxZNG27x
 ykFOqQm7qf+1mpgaSJL9QKZ+maFbMSJiEoEtLcGw8QY0lSUWTjFJjA6JowfKMgk5Yzdfclx3k
 enQec4gF9wr7FJQf5lBsUCuJVqcMiInSBYT3ZmL5dsAu0kXOG0z7b/ZxEQb3ASrhZAblx9BiB
 i065C3/m1UzEyFOmOI3AyqjyxY+pwswct1VqG/pM2FdtExfCSdPrjBC9yAzHi3d0KkuRWIH/q
 oSedUNMqCVMh6jtWMzzI7Mkt5zuSl/xnJBBh5oG6WjX9q8LSgQohoapdRUQ3lojxEAAD6ES/0
 AJs7Fzy2kPOJVTo4v2c2hSbteSETjXPlttLFiQlG/iVqj2bmY6NsVtsJhnB1ip/Wj8TF2tK58
 zTkCUp0fS7wkdDhIc9KSR2XfqccF2VkQ5U4S9msGNQmloFok8vTURzSsYKkQ4Sns2rR0wFY//
 i7yv0WFbpXuQd4EaUr6Y2Yg24oc6Nr9NAvlz2d6j1YfzuQpveJbH5YWX1VCqS8v1c01KK1ikB
 w2nEwMojsavzhY7N1Pcu3e2dKg+BbIBNn32bwszn99FwUUd2S1u50cd8wD4mB4Fo5mWPL2NWr
 1/D/NPWhAvHrFCiwbr5B2SeEP5SXnxhOu16L2CMnQ9tcEOK9jIUFOEkHp0WPfqpgHLkf0rrPR
 9HqZhXNwc8bR+Z7oE6qOX0AD4cBMNUPpQ97fKdD/pVHpZfyzxm7+IkxeRYHeDeQXiJNsQUVI0
 SMLnM9c3aH31ZpJqQq3LljpQi49xilDpZSjY8CcPcH7psoxbwxsSPUIS81xie0ckzU6lJo42R
 WsBiD9enAMCp9xDjZ3QNWIzl0HLfKVqdLXX6u/gOA/msReL82gGnyqEpiQ0S7k+PR5vvoCL/P
 vbzs9zkv/hzpNYk1omaaByinFJPHcnOcwsEzhSZW+dzS8NlgnVD3T4GHSiuL5a9BMhlbtk1aK
 ZIskCZrC4HvaW4/Z8YYFgs/zPd70vuLsS6wG9L7UEbnx+IfCg2v7rWTLnTJJHs3G+kmDY49Gd
 bovUhfy7dQaVBDch2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE to replace the hardcoded size so we will never have a
mismatch.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/main_usb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 5e48b3ddb94c..4370941ffc04 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -23,6 +23,7 @@

 #include <linux/etherdevice.h>
 #include <linux/file.h>
+#include <linux/kernel.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -116,6 +117,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	int ii;
 	u8 tmp;
 	u8 calib_tx_iq =3D 0, calib_tx_dc =3D 0, calib_rx_iq =3D 0;
+	const int n_cck_pwr_tbl =3D ARRAY_SIZE(priv->cck_pwr_tbl);

 	dev_dbg(&priv->usb->dev, "---->INIbInitAdapter. [%d][%d]\n",
 		DEVICE_INIT_COLD, priv->packet_type);
@@ -145,7 +147,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)

 	init_cmd->init_class =3D DEVICE_INIT_COLD;
 	init_cmd->exist_sw_net_addr =3D priv->exist_sw_net_addr;
-	for (ii =3D 0; ii < 6; ii++)
+	for (ii =3D 0; ii < ARRAY_SIZE(init_cmd->sw_net_addr); ii++)
 		init_cmd->sw_net_addr[ii] =3D priv->current_net_addr[ii];
 	init_cmd->short_retry_limit =3D priv->short_retry_limit;
 	init_cmd->long_retry_limit =3D priv->long_retry_limit;
@@ -184,7 +186,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	priv->cck_pwr =3D priv->eeprom[EEP_OFS_PWR_CCK];
 	priv->ofdm_pwr_g =3D priv->eeprom[EEP_OFS_PWR_OFDMG];
 	/* load power table */
-	for (ii =3D 0; ii < 14; ii++) {
+	for (ii =3D 0; ii < n_cck_pwr_tbl; ii++) {
 		priv->cck_pwr_tbl[ii] =3D
 			priv->eeprom[ii + EEP_OFS_CCK_PWR_TBL];
 		if (priv->cck_pwr_tbl[ii] =3D=3D 0)
@@ -200,7 +202,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	 * original zonetype is USA, but custom zonetype is Europe,
 	 * then need to recover 12, 13, 14 channels with 11 channel
 	 */
-	for (ii =3D 11; ii < 14; ii++) {
+	for (ii =3D 11; ii < n_cck_pwr_tbl; ii++) {
 		priv->cck_pwr_tbl[ii] =3D priv->cck_pwr_tbl[10];
 		priv->ofdm_pwr_tbl[ii] =3D priv->ofdm_pwr_tbl[10];
 	}
=2D-
2.20.1

