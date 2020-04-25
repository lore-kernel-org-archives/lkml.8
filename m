Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1BC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942E420661
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YbnaQenF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:43:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:42533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587822213;
        bh=iETB4e3tt/hvX2U6n73mT3vyOlfUqj2WPmPqbk9BnU4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YbnaQenFkW1x/SJSI32llZdsZ1cP85OhBr5yFnEE/KAs7PF5pyy9vR/+R+192ZibX
         RWhDiXxeUs9Pq05FEELSQWZQokNvjthvs54s0WMk6/OSqcvJofb1bY0FhV3OTKPqIr
         L07bYtZ9FiUyePKxEmQYYL99uX36Sl7kcS2D2nT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MfHAB-1j0fz407Mh-00glvH; Sat, 25 Apr 2020 15:43:33 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Sat, 25 Apr 2020 15:42:56 +0200
Message-Id: <20200425134257.4502-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425134257.4502-1-oscar.carter@gmx.com>
References: <20200425134257.4502-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNrCR/2hZAc9asstP8iwDEm6xJPU8BJW6w/t/NWNI+5E2UH3B1m
 oj2ezIWExpdSf5nB4rsPCGD86wgUHvwd4qxNAPz0pDTEzdB5pGdtMBu8A/WoDFpPiM0MEA5
 fILAhBc/SUGzR+objwfikftyrr++qVDaNBe1jeVKa2AYrrcaiP6dPkUeP7jXgqnGRrGNwib
 7oImLu1SQ1iM+L4gTojHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVupSYIdF8o=:LOKoNT9sdyrgephRRJWy46
 iHB8cbybZYExayP2URE0/gemK7ifHVgq6fAMIJoDivz/E6aPYuYwTbemSeJRjPiH4zfFBLRi2
 8t6Uloa5I9wfrYlEBpAeeOu/mO50dudTMH4FEmqgPYxwsimIBh2162ycJuIrWlvIoAc/BRAEp
 FeWZehmwbUHATHHKqvlIQJ2/vV6qhqM6NSRjGZiwIvl9M8jyHAVBD/K7FVLG0f4qgEs8v8BY4
 qjDr8avXqY3w7aaaUYI8bNeXPJZpU7EiNWehnDlPKarEupsZodBe4h2k8CjeLVKLIvxn7T+pc
 msVRz8ZyyRBTjO+jfB7/pKrqK4aZL027JlAJpwplD/htqtnD2APQPRd9J4g3/uPgCFLkM0FZZ
 r+0ifiCAC/3UN14GSViHVQpvlto1ekqgzD0Rg25wQLJyJmiCnBhNdm6v7SIBAR5aEO5gOO55b
 /uVqcG9xjgU4yKsrIa+sfH64iPm0TFvOerwd2jUTe8ikHHe544Sw17K4Wy7slxiolqTvxMEhX
 GMD97zn2ZxgC2BMG2RxFAN0ZkHPfVsz27bqM0YHjEYLUz9L8m81o0t+1CxizqNl1KO7kWiEg3
 8Trj+PLb8owYy5TAsMoB4QgQCEBt5NNaYonMpa90Wt7PFUUG3pG78soJucC5OTViC8g2rFjZM
 Jkyzu6pWn9nI24KKxmYLu98dxoqCGtt6wDr0WmoPGO6AIcikwLIzIaSQFIU+yCsSvlctoGEon
 uXAd2wjhLD+AaYuESvIYie9HrvJ2VIA0BUDmZD84mX/Kb5nltesiciCJb9MLee50gwq045GOG
 xt+WRJjx2AYr8E1QBLnZLay4O0WneilDsL92cMixgKAnNm+tpCBkcvWSSv5N9w+NQmmBEob1o
 xRM/Amw5McqoEn0cE7Nd1hTQohag07g/06AjFgQtM4Q7ijJoLNQcsCJeSKYimMypJ7RjeWn3S
 gXTfEPWHY2i9q67Nq9sEUSOVL/us9MBBhs85W7usAdmkfbLHKaVLXak/raCEuy69053zJDo0A
 0z7to43f9xVa5PxrbRVzpRs6QdjeReiVHb/DV06Yi9q8Mwdqn2Rwdr8U5ACEWXB58A30sWRVL
 eb2NODqQox3NQBUYRaQG2pbERMCF0bnI9e8mcuP2+/9X8VFUx3PKuS3tbx0cHYHkHiwMdf3E1
 sVXGlYXNvvkE1mx34i2wFdfoViyNgXFYwvOyHYaEw8RPXDEst1GuEWh635H5/FkhFWcyJUs6J
 /Z79/fwUBsuyZMiHG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of vnt_control_out_* function calls. When
necessary modify the function prototype to be able to return the new
checked error code.

It's safe to modify all the function prototypes without fix the call
because the only change is the return value from void to int. If before
the call didn't check the return value, now neither.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 35 ++++++-----
 drivers/staging/vt6656/baseband.h |  4 +-
 drivers/staging/vt6656/card.c     | 97 ++++++++++++++++++++-----------
 drivers/staging/vt6656/card.h     | 18 +++---
 drivers/staging/vt6656/mac.c      | 76 ++++++++++++------------
 drivers/staging/vt6656/mac.h      | 26 ++++-----
 drivers/staging/vt6656/power.c    | 12 +++-
 drivers/staging/vt6656/power.h    |  2 +-
 8 files changed, 156 insertions(+), 114 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index e7000bba644a..1d75acaec8f3 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -23,6 +23,7 @@
  */

 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include "device.h"
 #include "mac.h"
@@ -367,21 +368,22 @@ int vnt_set_short_slot_time(struct vnt_private *priv=
)

 	ret =3D vnt_control_in_u8(priv, MESSAGE_REQUEST_BBREG, 0xe7, &bb_vga);
 	if (ret)
-		goto end;
+		return ret;

 	if (bb_vga =3D=3D priv->bb_vga[0])
 		priv->bb_rx_conf |=3D 0x20;

-	ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a,
-				 priv->bb_rx_conf);
-
-end:
-	return ret;
+	return vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a,
+				  priv->bb_rx_conf);
 }

-void vnt_set_vga_gain_offset(struct vnt_private *priv, u8 data)
+int vnt_set_vga_gain_offset(struct vnt_private *priv, u8 data)
 {
-	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xE7, data);
+	int ret;
+
+	ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xE7, data);
+	if (ret)
+		return ret;

 	/* patch for 3253B0 Baseband with Cardbus module */
 	if (priv->short_slot_time)
@@ -389,7 +391,8 @@ void vnt_set_vga_gain_offset(struct vnt_private *priv,=
 u8 data)
 	else
 		priv->bb_rx_conf |=3D 0x20; /* 0010 0000 */

-	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a, priv->bb_rx_conf);
+	return vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a,
+				  priv->bb_rx_conf);
 }

 /*
@@ -430,12 +433,13 @@ int vnt_exit_deep_sleep(struct vnt_private *priv)
 	return vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0d, 0x01);
 }

-void vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning)
+int vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning)
 {
 	const struct vnt_threshold *threshold =3D NULL;
 	u8 length;
 	u8 cr_201, cr_206;
 	u8 ed_inx;
+	int ret;

 	switch (priv->rf_type) {
 	case RF_AL2230:
@@ -458,7 +462,7 @@ void vnt_update_pre_ed_threshold(struct vnt_private *p=
riv, int scanning)
 	}

 	if (!threshold)
-		return;
+		return -EINVAL;

 	for (ed_inx =3D scanning ? 0 : length - 1; ed_inx > 0; ed_inx--) {
 		if (priv->bb_pre_ed_rssi <=3D threshold[ed_inx].bb_pre_ed_rssi)
@@ -469,14 +473,17 @@ void vnt_update_pre_ed_threshold(struct vnt_private =
*priv, int scanning)
 	cr_206 =3D threshold[ed_inx].cr_206;

 	if (ed_inx =3D=3D priv->bb_pre_ed_index && !scanning)
-		return;
+		return 0;

 	priv->bb_pre_ed_index =3D ed_inx;

 	dev_dbg(&priv->usb->dev, "%s bb_pre_ed_rssi %d\n",
 		__func__, priv->bb_pre_ed_rssi);

-	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xc9, cr_201);
-	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xce, cr_206);
+	ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xc9, cr_201);
+	if (ret)
+		return ret;
+
+	return vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0xce, cr_206);
 }

diff --git a/drivers/staging/vt6656/baseband.h b/drivers/staging/vt6656/ba=
seband.h
index ee7325d942fe..12456ebc23ec 100644
=2D-- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -67,11 +67,11 @@
 #define TOP_RATE_1M         0x00100000

 int vnt_set_short_slot_time(struct vnt_private *priv);
-void vnt_set_vga_gain_offset(struct vnt_private *priv, u8 data);
+int vnt_set_vga_gain_offset(struct vnt_private *priv, u8 data);
 int vnt_set_antenna_mode(struct vnt_private *priv, u8 antenna_mode);
 int vnt_vt3184_init(struct vnt_private *priv);
 int vnt_set_deep_sleep(struct vnt_private *priv);
 int vnt_exit_deep_sleep(struct vnt_private *priv);
-void vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning);
+int vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning);

 #endif /* __BASEBAND_H__ */
diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 939bf11d5a6f..341796da2561 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -27,6 +27,7 @@
  */

 #include <linux/bitops.h>
+#include <linux/errno.h>
 #include "device.h"
 #include "card.h"
 #include "baseband.h"
@@ -55,10 +56,12 @@ static const u16 cw_rxbcntsf_off[MAX_RATE] =3D {
  *  Out:
  *      none
  */
-void vnt_set_channel(struct vnt_private *priv, u32 connection_channel)
+int vnt_set_channel(struct vnt_private *priv, u32 connection_channel)
 {
+	int ret;
+
 	if (connection_channel > CB_MAX_CHANNEL || !connection_channel)
-		return;
+		return -EINVAL;

 	/* clear NAV */
 	vnt_mac_reg_bits_on(priv, MAC_REG_MACCR, MACCR_CLRNAV);
@@ -67,11 +70,13 @@ void vnt_set_channel(struct vnt_private *priv, u32 con=
nection_channel)
 	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL,
 			     (BIT(7) | BIT(5) | BIT(4)));

-	vnt_control_out(priv, MESSAGE_TYPE_SELECT_CHANNEL,
-			connection_channel, 0, 0, NULL);
+	ret =3D vnt_control_out(priv, MESSAGE_TYPE_SELECT_CHANNEL,
+			      connection_channel, 0, 0, NULL);
+	if (ret)
+		return ret;

-	vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG, MAC_REG_CHANNEL,
-			   (u8)(connection_channel | 0x80));
+	return vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG, MAC_REG_CHANNEL,
+				  (u8)(connection_channel | 0x80));
 }

 static const u8 vnt_rspinf_b_short_table[] =3D {
@@ -107,10 +112,11 @@ static const u8 vnt_rspinf_gb_table[] =3D {
  *
  */

-void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type)
+int vnt_set_rspinf(struct vnt_private *priv, u8 bb_type)
 {
 	const u8 *data;
 	u16 len;
+	int ret;

 	if (priv->preamble_type) {
 		data =3D vnt_rspinf_b_short_table;
@@ -121,8 +127,10 @@ void vnt_set_rspinf(struct vnt_private *priv, u8 bb_t=
ype)
 	}

 	 /* RSPINF_b_1 to RSPINF_b_11 */
-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_B_1,
-			MESSAGE_REQUEST_MACREG, len, data);
+	ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_B_1,
+			      MESSAGE_REQUEST_MACREG, len, data);
+	if (ret)
+		return ret;

 	if (bb_type =3D=3D BB_TYPE_11A) {
 		data =3D vnt_rspinf_a_table;
@@ -133,8 +141,8 @@ void vnt_set_rspinf(struct vnt_private *priv, u8 bb_ty=
pe)
 	}

 	/* RSPINF_a_6 to RSPINF_a_72 */
-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_A_6,
-			MESSAGE_REQUEST_MACREG, len, data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_RSPINF_A_6,
+			       MESSAGE_REQUEST_MACREG, len, data);
 }

 /*
@@ -149,10 +157,11 @@ void vnt_set_rspinf(struct vnt_private *priv, u8 bb_=
type)
  * Return Value: None.
  *
  */
-void vnt_update_ifs(struct vnt_private *priv)
+int vnt_update_ifs(struct vnt_private *priv)
 {
 	u8 max_min =3D 0;
 	u8 data[4];
+	int ret;

 	if (priv->packet_type =3D=3D PK_TYPE_11A) {
 		priv->slot =3D C_SLOT_SHORT;
@@ -212,13 +221,15 @@ void vnt_update_ifs(struct vnt_private *priv)
 	data[2] =3D (u8)priv->eifs;
 	data[3] =3D (u8)priv->slot;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_SIFS,
-			MESSAGE_REQUEST_MACREG, 4, &data[0]);
+	ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_SIFS,
+			      MESSAGE_REQUEST_MACREG, 4, &data[0]);
+	if (ret)
+		return ret;

 	max_min |=3D 0xa0;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_CWMAXMIN0,
-			MESSAGE_REQUEST_MACREG, 1, &max_min);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_CWMAXMIN0,
+			       MESSAGE_REQUEST_MACREG, 1, &max_min);
 }

 void vnt_update_top_rates(struct vnt_private *priv)
@@ -281,8 +292,8 @@ u64 vnt_get_tsf_offset(u8 rx_rate, u64 tsf1, u64 tsf2)
  * Return Value: none
  *
  */
-void vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
-		    u64 time_stamp, u64 local_tsf)
+int vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
+		   u64 time_stamp, u64 local_tsf)
 {
 	u64 tsf_offset =3D 0;
 	u8 data[8];
@@ -298,8 +309,8 @@ void vnt_adjust_tsf(struct vnt_private *priv, u8 rx_ra=
te,
 	data[6] =3D (u8)(tsf_offset >> 48);
 	data[7] =3D (u8)(tsf_offset >> 56);

-	vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
-			MESSAGE_REQUEST_TSF, 0, 8, data);
+	return vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
+			       MESSAGE_REQUEST_TSF, 0, 8, data);
 }

 /*
@@ -388,7 +399,7 @@ u64 vnt_get_next_tbtt(u64 tsf, u16 beacon_interval)
  * Return Value: none
  *
  */
-void vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval)
+int vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval)
 {
 	u64 next_tbtt =3D 0;
 	u8 data[8];
@@ -406,8 +417,8 @@ void vnt_reset_next_tbtt(struct vnt_private *priv, u16=
 beacon_interval)
 	data[6] =3D (u8)(next_tbtt >> 48);
 	data[7] =3D (u8)(next_tbtt >> 56);

-	vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
-			MESSAGE_REQUEST_TBTT, 0, 8, data);
+	return vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
+			       MESSAGE_REQUEST_TBTT, 0, 8, data);
 }

 /*
@@ -425,10 +436,11 @@ void vnt_reset_next_tbtt(struct vnt_private *priv, u=
16 beacon_interval)
  * Return Value: none
  *
  */
-void vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
-			  u16 beacon_interval)
+int vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
+			 u16 beacon_interval)
 {
 	u8 data[8];
+	int ret;

 	tsf =3D vnt_get_next_tbtt(tsf, beacon_interval);

@@ -441,10 +453,13 @@ void vnt_update_next_tbtt(struct vnt_private *priv, =
u64 tsf,
 	data[6] =3D (u8)(tsf >> 48);
 	data[7] =3D (u8)(tsf >> 56);

-	vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
-			MESSAGE_REQUEST_TBTT, 0, 8, data);
+	ret =3D vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
+			      MESSAGE_REQUEST_TBTT, 0, 8, data);
+	if (ret)
+		return ret;

 	dev_dbg(&priv->usb->dev, "%s TBTT: %8llx\n", __func__, tsf);
+	return 0;
 }

 /*
@@ -533,8 +548,10 @@ int vnt_radio_power_on(struct vnt_private *priv)
 	return vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 }

-void vnt_set_bss_mode(struct vnt_private *priv)
+int vnt_set_bss_mode(struct vnt_private *priv)
 {
+	int ret =3D 0;
+
 	if (priv->rf_type =3D=3D RF_AIROHA7230 && priv->bb_type =3D=3D BB_TYPE_1=
1A)
 		vnt_mac_set_bb_type(priv, BB_TYPE_11G);
 	else
@@ -543,11 +560,16 @@ void vnt_set_bss_mode(struct vnt_private *priv)
 	priv->packet_type =3D vnt_get_pkt_type(priv);

 	if (priv->bb_type =3D=3D BB_TYPE_11A)
-		vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x88, 0x03);
+		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+					 0x88, 0x03);
 	else if (priv->bb_type =3D=3D BB_TYPE_11B)
-		vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x88, 0x02);
+		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+					 0x88, 0x02);
 	else if (priv->bb_type =3D=3D BB_TYPE_11G)
-		vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x88, 0x08);
+		ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+					 0x88, 0x08);
+	if (ret)
+		return ret;

 	vnt_update_ifs(priv);
 	vnt_set_rspinf(priv, (u8)priv->bb_type);
@@ -556,8 +578,10 @@ void vnt_set_bss_mode(struct vnt_private *priv)
 		if (priv->rf_type =3D=3D RF_AIROHA7230) {
 			priv->bb_vga[0] =3D 0x20;

-			vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-					   0xe7, priv->bb_vga[0]);
+			ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+						 0xe7, priv->bb_vga[0]);
+			if (ret)
+				return ret;
 		}

 		priv->bb_vga[2] =3D 0x10;
@@ -566,8 +590,10 @@ void vnt_set_bss_mode(struct vnt_private *priv)
 		if (priv->rf_type =3D=3D RF_AIROHA7230) {
 			priv->bb_vga[0] =3D 0x1c;

-			vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
-					   0xe7, priv->bb_vga[0]);
+			ret =3D vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG,
+						 0xe7, priv->bb_vga[0]);
+			if (ret)
+				return ret;
 		}

 		priv->bb_vga[2] =3D 0x0;
@@ -575,4 +601,5 @@ void vnt_set_bss_mode(struct vnt_private *priv)
 	}

 	vnt_set_vga_gain_offset(priv, priv->bb_vga[0]);
+	return 0;
 }
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index eaa15d0c291a..a524fdc60ae3 100644
=2D-- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -25,23 +25,23 @@

 struct vnt_private;

-void vnt_set_channel(struct vnt_private *priv, u32 connection_channel);
-void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type);
-void vnt_update_ifs(struct vnt_private *priv);
+int vnt_set_channel(struct vnt_private *priv, u32 connection_channel);
+int vnt_set_rspinf(struct vnt_private *priv, u8 bb_type);
+int vnt_update_ifs(struct vnt_private *priv);
 void vnt_update_top_rates(struct vnt_private *priv);
 bool vnt_ofdm_min_rate(struct vnt_private *priv);
-void vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
-		    u64 time_stamp, u64 local_tsf);
+int vnt_adjust_tsf(struct vnt_private *priv, u8 rx_rate,
+		   u64 time_stamp, u64 local_tsf);
 bool vnt_get_current_tsf(struct vnt_private *priv, u64 *current_tsf);
 bool vnt_clear_current_tsf(struct vnt_private *priv);
-void vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval);
-void vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
-			  u16 beacon_interval);
+int vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval);
+int vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
+			 u16 beacon_interval);
 u64 vnt_get_next_tbtt(u64 tsf, u16 beacon_interval);
 u64 vnt_get_tsf_offset(u8 rx_rate, u64 tsf1, u64 tsf2);
 int vnt_radio_power_off(struct vnt_private *priv);
 int vnt_radio_power_on(struct vnt_private *priv);
 u8 vnt_get_pkt_type(struct vnt_private *priv);
-void vnt_set_bss_mode(struct vnt_private *priv);
+int vnt_set_bss_mode(struct vnt_private *priv);

 #endif /* __CARD_H__ */
diff --git a/drivers/staging/vt6656/mac.c b/drivers/staging/vt6656/mac.c
index 5cacf6e60e90..639172fad0f3 100644
=2D-- a/drivers/staging/vt6656/mac.c
+++ b/drivers/staging/vt6656/mac.c
@@ -35,12 +35,13 @@
  * Return Value: none
  *
  */
-void vnt_mac_set_filter(struct vnt_private *priv, u64 mc_filter)
+int vnt_mac_set_filter(struct vnt_private *priv, u64 mc_filter)
 {
 	__le64 le_mc =3D cpu_to_le64(mc_filter);

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_MAR0,
-			MESSAGE_REQUEST_MACREG, sizeof(le_mc), (u8 *)&le_mc);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_MAR0,
+			       MESSAGE_REQUEST_MACREG, sizeof(le_mc),
+			       (u8 *)&le_mc);
 }

 /*
@@ -54,20 +55,21 @@ void vnt_mac_set_filter(struct vnt_private *priv, u64 =
mc_filter)
  *
  *
  */
-void vnt_mac_shutdown(struct vnt_private *priv)
+int vnt_mac_shutdown(struct vnt_private *priv)
 {
-	vnt_control_out(priv, MESSAGE_TYPE_MACSHUTDOWN, 0, 0, 0, NULL);
+	return vnt_control_out(priv, MESSAGE_TYPE_MACSHUTDOWN, 0, 0, 0, NULL);
 }

-void vnt_mac_set_bb_type(struct vnt_private *priv, u8 type)
+int vnt_mac_set_bb_type(struct vnt_private *priv, u8 type)
 {
 	u8 data[2];

 	data[0] =3D type;
 	data[1] =3D EnCFG_BBType_MASK;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
-			MESSAGE_REQUEST_MACREG,	ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
+			       MESSAGE_REQUEST_MACREG,	ARRAY_SIZE(data),
+			       data);
 }

 /*
@@ -84,10 +86,10 @@ void vnt_mac_set_bb_type(struct vnt_private *priv, u8 =
type)
  * Return Value: none
  *
  */
-void vnt_mac_disable_keyentry(struct vnt_private *priv, u8 entry_idx)
+int vnt_mac_disable_keyentry(struct vnt_private *priv, u8 entry_idx)
 {
-	vnt_control_out(priv, MESSAGE_TYPE_CLRKEYENTRY, 0, 0,
-			sizeof(entry_idx), &entry_idx);
+	return vnt_control_out(priv, MESSAGE_TYPE_CLRKEYENTRY, 0, 0,
+			       sizeof(entry_idx), &entry_idx);
 }

 /*
@@ -104,8 +106,8 @@ void vnt_mac_disable_keyentry(struct vnt_private *priv=
, u8 entry_idx)
  * Return Value: none
  *
  */
-void vnt_mac_set_keyentry(struct vnt_private *priv, u16 key_ctl, u32 entr=
y_idx,
-			  u32 key_idx, u8 *addr, u8 *key)
+int vnt_mac_set_keyentry(struct vnt_private *priv, u16 key_ctl, u32 entry=
_idx,
+			 u32 key_idx, u8 *addr, u8 *key)
 {
 	struct vnt_mac_set_key set_key;
 	u16 offset;
@@ -124,9 +126,9 @@ void vnt_mac_set_keyentry(struct vnt_private *priv, u1=
6 key_ctl, u32 entry_idx,
 	dev_dbg(&priv->usb->dev, "offset %d key ctl %d set key %24ph\n",
 		offset, key_ctl, (u8 *)&set_key);

-	vnt_control_out(priv, MESSAGE_TYPE_SETKEY, offset,
-			(u16)key_idx, sizeof(struct vnt_mac_set_key),
-			(u8 *)&set_key);
+	return vnt_control_out(priv, MESSAGE_TYPE_SETKEY, offset,
+			       (u16)key_idx, sizeof(struct vnt_mac_set_key),
+			       (u8 *)&set_key);
 }

 int vnt_mac_reg_bits_off(struct vnt_private *priv, u8 reg_ofs, u8 bits)
@@ -151,76 +153,76 @@ int vnt_mac_reg_bits_on(struct vnt_private *priv, u8=
 reg_ofs, u8 bits)
 			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_write_word(struct vnt_private *priv, u8 reg_ofs, u16 word)
+int vnt_mac_write_word(struct vnt_private *priv, u8 reg_ofs, u16 word)
 {
 	u8 data[2];

 	data[0] =3D (u8)(word & 0xff);
 	data[1] =3D (u8)(word >> 8);

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, reg_ofs,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, reg_ofs,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_set_bssid_addr(struct vnt_private *priv, u8 *addr)
+int vnt_mac_set_bssid_addr(struct vnt_private *priv, u8 *addr)
 {
-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_BSSID0,
-			MESSAGE_REQUEST_MACREG, ETH_ALEN, addr);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_BSSID0,
+			       MESSAGE_REQUEST_MACREG, ETH_ALEN, addr);
 }

-void vnt_mac_enable_protect_mode(struct vnt_private *priv)
+int vnt_mac_enable_protect_mode(struct vnt_private *priv)
 {
 	u8 data[2];

 	data[0] =3D EnCFG_ProtectMd;
 	data[1] =3D EnCFG_ProtectMd;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_disable_protect_mode(struct vnt_private *priv)
+int vnt_mac_disable_protect_mode(struct vnt_private *priv)
 {
 	u8 data[2];

 	data[0] =3D 0;
 	data[1] =3D EnCFG_ProtectMd;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_enable_barker_preamble_mode(struct vnt_private *priv)
+int vnt_mac_enable_barker_preamble_mode(struct vnt_private *priv)
 {
 	u8 data[2];

 	data[0] =3D EnCFG_BarkerPream;
 	data[1] =3D EnCFG_BarkerPream;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_disable_barker_preamble_mode(struct vnt_private *priv)
+int vnt_mac_disable_barker_preamble_mode(struct vnt_private *priv)
 {
 	u8 data[2];

 	data[0] =3D 0;
 	data[1] =3D EnCFG_BarkerPream;

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

-void vnt_mac_set_beacon_interval(struct vnt_private *priv, u16 interval)
+int vnt_mac_set_beacon_interval(struct vnt_private *priv, u16 interval)
 {
 	u8 data[2];

 	data[0] =3D (u8)(interval & 0xff);
 	data[1] =3D (u8)(interval >> 8);

-	vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_BI,
-			MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
+	return vnt_control_out(priv, MESSAGE_TYPE_WRITE, MAC_REG_BI,
+			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
 }

 int vnt_mac_set_led(struct vnt_private *priv, u8 state, u8 led)
diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index b01d9ee8677e..dae70b5c7634 100644
=2D-- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -355,21 +355,21 @@ struct vnt_mac_set_key {
 	u8 key[WLAN_KEY_LEN_CCMP];
 } __packed;

-void vnt_mac_set_filter(struct vnt_private *priv, u64 mc_filter);
-void vnt_mac_shutdown(struct vnt_private *priv);
-void vnt_mac_set_bb_type(struct vnt_private *priv, u8 type);
-void vnt_mac_disable_keyentry(struct vnt_private *priv, u8 entry_idx);
-void vnt_mac_set_keyentry(struct vnt_private *priv, u16 key_ctl, u32 entr=
y_idx,
-			  u32 key_idx, u8 *addr, u8 *key);
+int vnt_mac_set_filter(struct vnt_private *priv, u64 mc_filter);
+int vnt_mac_shutdown(struct vnt_private *priv);
+int vnt_mac_set_bb_type(struct vnt_private *priv, u8 type);
+int vnt_mac_disable_keyentry(struct vnt_private *priv, u8 entry_idx);
+int vnt_mac_set_keyentry(struct vnt_private *priv, u16 key_ctl, u32 entry=
_idx,
+			 u32 key_idx, u8 *addr, u8 *key);
 int vnt_mac_reg_bits_off(struct vnt_private *priv, u8 reg_ofs, u8 bits);
 int vnt_mac_reg_bits_on(struct vnt_private *priv, u8 reg_ofs, u8 bits);
-void vnt_mac_write_word(struct vnt_private *priv, u8 reg_ofs, u16 word);
-void vnt_mac_set_bssid_addr(struct vnt_private *priv, u8 *addr);
-void vnt_mac_enable_protect_mode(struct vnt_private *priv);
-void vnt_mac_disable_protect_mode(struct vnt_private *priv);
-void vnt_mac_enable_barker_preamble_mode(struct vnt_private *priv);
-void vnt_mac_disable_barker_preamble_mode(struct vnt_private *priv);
-void vnt_mac_set_beacon_interval(struct vnt_private *priv, u16 interval);
+int vnt_mac_write_word(struct vnt_private *priv, u8 reg_ofs, u16 word);
+int vnt_mac_set_bssid_addr(struct vnt_private *priv, u8 *addr);
+int vnt_mac_enable_protect_mode(struct vnt_private *priv);
+int vnt_mac_disable_protect_mode(struct vnt_private *priv);
+int vnt_mac_enable_barker_preamble_mode(struct vnt_private *priv);
+int vnt_mac_disable_barker_preamble_mode(struct vnt_private *priv);
+int vnt_mac_set_beacon_interval(struct vnt_private *priv, u16 interval);
 int vnt_mac_set_led(struct vnt_private *privpriv, u8 state, u8 led);

 #endif /* __MAC_H__ */
diff --git a/drivers/staging/vt6656/power.c b/drivers/staging/vt6656/power=
.c
index 7a086c72d5a8..2d8d5a332a63 100644
=2D-- a/drivers/staging/vt6656/power.c
+++ b/drivers/staging/vt6656/power.c
@@ -87,17 +87,23 @@ void vnt_enable_power_saving(struct vnt_private *priv,=
 u16 listen_interval)
  *
  */

-void vnt_disable_power_saving(struct vnt_private *priv)
+int vnt_disable_power_saving(struct vnt_private *priv)
 {
+	int ret;
+
 	/* disable power saving hw function */
-	vnt_control_out(priv, MESSAGE_TYPE_DISABLE_PS, 0,
-			0, 0, NULL);
+	ret =3D vnt_control_out(priv, MESSAGE_TYPE_DISABLE_PS, 0,
+			      0, 0, NULL);
+	if (ret)
+		return ret;

 	/* clear AutoSleep */
 	vnt_mac_reg_bits_off(priv, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);

 	/* set always listen beacon */
 	vnt_mac_reg_bits_on(priv, MAC_REG_PSCTL, PSCTL_ALBCN);
+
+	return 0;
 }

 /*
diff --git a/drivers/staging/vt6656/power.h b/drivers/staging/vt6656/power=
.h
index 58755ae16e5a..160872026db3 100644
=2D-- a/drivers/staging/vt6656/power.h
+++ b/drivers/staging/vt6656/power.h
@@ -18,7 +18,7 @@

 #define C_PWBT	1000 /* micro sec. power up before TBTT */

-void vnt_disable_power_saving(struct vnt_private *priv);
+int vnt_disable_power_saving(struct vnt_private *priv);
 void vnt_enable_power_saving(struct vnt_private *priv, u16 listen_interva=
l);
 int vnt_next_tbtt_wakeup(struct vnt_private *priv);

=2D-
2.20.1

