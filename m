Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33AC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2335C2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VqqO9Qr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgDWPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:39:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:34425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgDWPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587656352;
        bh=xTj1Gx2tHOZYUTiqL2dXiWWl9cRHR972/ugnPdc1NJ0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VqqO9Qr7ewDpg3jtisGTUmMf9ddnLoAgUBfTo8yVvkS0E6fts261a7NlJP2vMxROW
         Kyo5yAfhaevhSVxI+rB3C/qiuTANWCYYdG3I0IjwICPWL872m0p5093vmdlM13cQLt
         I71CRi2AQk4pYJ2bOU/wc7V31MHzuZAbUTXkyP2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N2V0H-1j4ifX15G3-013rwZ; Thu, 23 Apr 2020 17:39:12 +0200
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
Subject: [PATCH v3 1/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Thu, 23 Apr 2020 17:38:35 +0200
Message-Id: <20200423153836.5582-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423153836.5582-1-oscar.carter@gmx.com>
References: <20200423153836.5582-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r6q/r78ypXSYBnui7+gAuZyQ23IDcPkuJ84JkjeO/RTchcqT0X5
 v8d+u3vhlR63WLMCeiTUggFVnRKrJkjHn8gsBD/SBLya1JlnhVY05d2VPv31xgZcsJde1dq
 Qz8ZzHc51bjcCmV/D360NypHEqZyFtZxxK9bPOm3DLw5UAhz93YoVC+oDpB/G1KdF5HLndN
 epKvljwMCAdovyyV9s/gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Lez9ZupFiQ=:zjLHkL7241MgkRV83e1f/B
 2cMnnnTFrLotyeFX4uODf9L+Aode4aDDnG43OqKzv+MKAhdxmmBSLmcRChXaEty3iTJcO4pjO
 284TX9ri5b/zDWzrg0SdnltJyzeeDJEJPMlTIRjFrMlNXT2sjMSDUJCPQsB/rVYQskOnuwoVz
 8B+E01pMEEczEqOxdzYw3gIn0+Shf4CPa0Yrdy0aofMtqWNLnEYyPKhAGcAJb9ndbiUnYbDnx
 4x6UQx/5zU55nxThj5zuHLLACOAuqYyGKbSimn5VspETxx3hiGu3i+2y5UxcA8lRAfbgGiTEE
 h4rm1/hSoDqGTJzDWl2RI0zaf2Z1OMv7WwrWnj+J48RqEgZIP31BOWLJh72SLAuQDvJ/qf99Z
 TVLudpZkkrvJ+/ZMSDHxgclszBROL0rawmOEaWv4L6P5Ru4LbacOzBXHMCXIyfUXvzsHyzp0c
 21CXAxoUXPfCkRpC7aN19hiuyLnS1PJTLJryAAA1NrIxwGRQU9ofeZUw59Qkfb3LF91AXBrRt
 gFiV2AWLw7CXxwif/d5dxFE7Wy+4EEIv0Ol1JXqd+4sgyOMJ4q4hPkTxvqotQv/KqI82+iiuY
 cSvLKPqOBJcTP+jruH3psxSo/yJjUFe99DE0/+ZbMOi1EUORsL3EvtkeP6S/HszlMSGlHPex/
 hTvdkthyC7ZwJ7eDFZhj2KCQR3NgLJB0pw43Pz6svFXS9U6SXcXcHNoox4deJX4wMjFsLPrmr
 7NOENqo/13SYA0gEZ2op7J/PmTxYNrb4VgPn/WpuAub9QivJSs/4pBHq1Ed/tctBgvCwhlrhZ
 iL1Z1AId6UazSHJw95yujj1pCbUJteqSQemJvEk32dBZiu/Uwuzr//kHRb3xSwFv7IQ+SvAhc
 Z/QK4p/DHuNMCZF+AMRtf1ZUYrU1cvZ9Wz5a1/GvAkc9HMHGZ96ZuRRFSPUVNyBCEvZc+kcHf
 3KMpu0XYCwsJ1VpoGJikG3nDG2UItcJcOoDdrujLpZq9w3+P1cn4066QvtZxIgfSWCxlyehVP
 QwksgTAHMvzhVpd2gn46mxVaE8Yo6pClkiZOqXm1sDxlD97zmhNWa33AoFVrPn7r3I4jKswIA
 oy2DcZ+6hz5kJfFcqCMwvLF5H1H7KRdAZlvGLIDFEPdKJlf12l8fVA2TLsYGiEyhxan0Vrl2Z
 h3CABcoWZHCzBhOw2LY5fzTlGIteXdhwjdJAZvqo1aNcWlwrGkVG/6tS5y4Kh5VYJXybvr6nQ
 Y72WDClFnbLSSDhGZ
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
index d21a9cf0afe5..3d2d20e6f055 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -23,6 +23,7 @@
  */

 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include "device.h"
 #include "mac.h"
@@ -506,21 +507,22 @@ int vnt_set_short_slot_time(struct vnt_private *priv=
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
@@ -528,7 +530,8 @@ void vnt_set_vga_gain_offset(struct vnt_private *priv,=
 u8 data)
 	else
 		priv->bb_rx_conf |=3D 0x20; /* 0010 0000 */

-	vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a, priv->bb_rx_conf);
+	return vnt_control_out_u8(priv, MESSAGE_REQUEST_BBREG, 0x0a,
+				  priv->bb_rx_conf);
 }

 /*
@@ -569,12 +572,13 @@ int vnt_exit_deep_sleep(struct vnt_private *priv)
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
@@ -597,7 +601,7 @@ void vnt_update_pre_ed_threshold(struct vnt_private *p=
riv, int scanning)
 	}

 	if (!threshold)
-		return;
+		return -EINVAL;

 	for (ed_inx =3D scanning ? 0 : length - 1; ed_inx > 0; ed_inx--) {
 		if (priv->bb_pre_ed_rssi <=3D threshold[ed_inx].bb_pre_ed_rssi)
@@ -608,14 +612,17 @@ void vnt_update_pre_ed_threshold(struct vnt_private =
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
index dc42aa6ae1d9..8739988bf9e8 100644
=2D-- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -80,11 +80,11 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 f=
rame_length,
 		       u16 tx_rate, u8 pkt_type, struct vnt_phy_field *phy);

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
index f8bfadd4b506..c29f7072c742 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -27,6 +27,7 @@
  */

 #include <linux/bits.h>
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
@@ -304,8 +315,8 @@ u64 vnt_get_tsf_offset(u8 rx_rate, u64 tsf1, u64 tsf2)
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
@@ -321,8 +332,8 @@ void vnt_adjust_tsf(struct vnt_private *priv, u8 rx_ra=
te,
 	data[6] =3D (u8)(tsf_offset >> 48);
 	data[7] =3D (u8)(tsf_offset >> 56);

-	vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
-			MESSAGE_REQUEST_TSF, 0, 8, data);
+	return vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
+			       MESSAGE_REQUEST_TSF, 0, 8, data);
 }

 /*
@@ -411,7 +422,7 @@ u64 vnt_get_next_tbtt(u64 tsf, u16 beacon_interval)
  * Return Value: none
  *
  */
-void vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval)
+int vnt_reset_next_tbtt(struct vnt_private *priv, u16 beacon_interval)
 {
 	u64 next_tbtt =3D 0;
 	u8 data[8];
@@ -429,8 +440,8 @@ void vnt_reset_next_tbtt(struct vnt_private *priv, u16=
 beacon_interval)
 	data[6] =3D (u8)(next_tbtt >> 48);
 	data[7] =3D (u8)(next_tbtt >> 56);

-	vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
-			MESSAGE_REQUEST_TBTT, 0, 8, data);
+	return vnt_control_out(priv, MESSAGE_TYPE_SET_TSFTBTT,
+			       MESSAGE_REQUEST_TBTT, 0, 8, data);
 }

 /*
@@ -448,10 +459,11 @@ void vnt_reset_next_tbtt(struct vnt_private *priv, u=
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

@@ -464,10 +476,13 @@ void vnt_update_next_tbtt(struct vnt_private *priv, =
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
@@ -556,8 +571,10 @@ int vnt_radio_power_on(struct vnt_private *priv)
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
@@ -566,11 +583,16 @@ void vnt_set_bss_mode(struct vnt_private *priv)
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
@@ -579,8 +601,10 @@ void vnt_set_bss_mode(struct vnt_private *priv)
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
@@ -589,8 +613,10 @@ void vnt_set_bss_mode(struct vnt_private *priv)
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
@@ -598,4 +624,5 @@ void vnt_set_bss_mode(struct vnt_private *priv)
 	}

 	vnt_set_vga_gain_offset(priv, priv->bb_vga[0]);
+	return 0;
 }
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index 75cd340c0cce..5ef8bad9607e 100644
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
 int vnt_ofdm_min_rate(struct vnt_private *priv);
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

