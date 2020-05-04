Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03655C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF932068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EfYfqCXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgEDRPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:15:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:56061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgEDRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588612478;
        bh=Xn2gavpIWQ0DU9ZY9hafpAe5jpDKjLmd0xje7CYpgmc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EfYfqCXCZOqypRU3p1pX4jc+GeXcmvn5DmOxGyxMF8hG/L/+kTn8CUr9hfg5/CQqC
         k9ExJJXq/vVZNR99F6rFwWBPKo+4R/xr2Xe47SRP8oiwXBlw8SI7fS+xT4DIXGp/hN
         dJklvHLbNmGEcfPx2CfcM6vT5cmA903mzQNn/c2o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M59C8-1jWkbS1PZk-001Ceo; Mon, 04 May 2020 19:14:38 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Benjamin Sherman <benjamin@bensherman.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Subject: [PATCH] staging: vt6656: Use const for read only data
Date:   Mon,  4 May 2020 19:14:14 +0200
Message-Id: <20200504171414.11307-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2BgVsJlKeKnlRgESKOPI70DFJmdz7SkMPgF8b+m6IATUWf0mPI
 KKSPRPKZ1EgVG84VYUssGWlM2SqASk7qlKkU7wQuqRzHaKiC/2rZOMnepl57EltmRZaZ4IM
 WcESfzrgRVEHk97ee7paRX12EwKW1lJYwnwkHoftWHbSGWZYjY/2ns2LPXZW5e2Te00hRHc
 QvmAB73sK7FRrVmbV0tUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oiEO+z/IRwU=:VBHum2bZZDCoQ5X0LiFcnP
 Fv+lM12uZzd09aYz2aHCVQAXvUfPL7Mqzg9pfmEsCPtuSHVmISFuuqhHrKsAacMOEF0hneQ08
 KuTJDW+kLWgxGr6GAatzkdwKN3ZXwOhCd6UG74vfUiPvq68zLh1Hd5VjYoHg69hbVC3skEdJZ
 rcIXFDfDepNuoqVMcUQaRWrLK/kiaLqhnrjcTx0clTfNaSeueiVh7kwC+HeKftY9lQMF2RGQu
 +n6s1jBg94xAkxu5lL0e2H8W1bayZ/wgatPzHzsgaD2MP7/iXGQqf2IxjXqPfM0pOrwfbPCVw
 /FrfI91XSjZinrTVU7sdqshrmkCxVhIrIY9PwzrTI7GPxb1R4rRjaJlVwP+rz8b9a3Pu6cCv1
 GrbydcouhUv9IovoR5nwdsfVAdyIxwiqf9uq9UMoH0dscPRLHpH54I5kwROy0ZyLCaq9tGq2g
 jOmeqfily2/NgcZOaousIEOtBX+2YKx8iCiqf396jYH0iz5pAsU4QIzJ9m6zho/Yf3H2SpGlT
 qxLMeHDW48mF/Xk9LROXKc5TjnB6J6ACObZw6205IKD4f3TUakOapGDM/USF1ps7O2RRHmA2/
 Jr6kGLpIJrjdbjn0pbrvKGtVYMAb4SNILlNEn0it6IGewb3sWGCNGbIKWcjqCwwiIvC6cW2sc
 0MMBP8shNHe5Dv//L4nhnUe4k/R0utDmn0ma7AM3dnzLdSCgZ2riextecw9wQzBVHojT9cR/9
 fZpN9NerEz2uSmrKA9DNBL1Md+YyKna0Vy9wB8HVlkhxCL3poqzFVtZn1KPebwGsw2TR8p2Xe
 5Zzw0yayAKHiHOialvE7EeXiQ0+Rgj3dR/2tC9B1ChfRq+2uld8Hs7YvwGRlbwB3wMp8QrPFt
 2N29npzjk5Fj/wabiyE8md6MDcuFwFpijrDfkX2bNrBGAAuVd6rD9OVuWobcaB08Cv6Besy9j
 s1Zq5NNOwJZ7DhJeFuGAxYAfOT7ns6av5fO/5B1cQnuSbwx2DsBeEpMVwwSEwYYIj1aOG8dWw
 Ix8taN5lTbwSf+pjTwd8tlWwSu9yeuV0VqWxabLummNw4UM88AvNEaEh/8sTF7n9lgaodp98u
 Cb7dHAR8WMAExacUF/sFXhWz37FPR4dgcIDEVaPTy6R9Wl+4D2GJ6m567KAvE5oVGyiOKolHR
 EFySnlAU+HS/11DSfZxEkTidMcB2EKzrNTXHauZaGPUg176Kig+x6kDGzDYvY2b113RnAfNni
 Em9QK2C0PXiegChfw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use const for the arrays that are used as "read only". Also, modify the
prototype of vnt_control_out_blocks() function to use a pointer to a
const type.

The vnt_vt3184_al2230 array can't be converted to const as it's modified
later.

Then in the vnt_vt3184_init() function use two types of pointers (to
const type and to no const type) to avoid the compiler warning:

assignment discards 'const' qualifiers from pointer target type

This way decrease the .data section and increase the .rodata section
limiting the surface attack.

Before this change:
=2D------------------

drivers/staging/vt6656/baseband.o  :
section              size   addr
.text                1278      0
.data                 576      0
.bss                    0      0
.rodata               319      0
.comment               45      0
.note.GNU-stack         0      0
.note.gnu.property     32      0
Total                2250

After this change:
=2D-----------------

drivers/staging/vt6656/baseband.o  :
section              size   addr
.text                1278      0
.data                 256      0
.bss                    0      0
.rodata               640      0
.comment               45      0
.note.GNU-stack         0      0
.note.gnu.property     32      0
Total                2251

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 14 +++++++++-----
 drivers/staging/vt6656/usbpipe.c  |  2 +-
 drivers/staging/vt6656/usbpipe.h  |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 1d75acaec8f3..41ae779ec61f 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -31,7 +31,7 @@
 #include "rf.h"
 #include "usbpipe.h"

-static u8 vnt_vt3184_agc[] =3D {
+static const u8 vnt_vt3184_agc[] =3D {
 	0x00, 0x00, 0x02, 0x02, 0x04, 0x04, 0x06, 0x06,
 	0x08, 0x08, 0x0a, 0x0a, 0x0c, 0x0c, 0x0e, 0x0e, /* 0x0f */
 	0x10, 0x10, 0x12, 0x12, 0x14, 0x14, 0x16, 0x16,
@@ -78,7 +78,7 @@ static u8 vnt_vt3184_al2230[] =3D {
 };

 /* {{RobertYu:20060515, new BB setting for VT3226D0 */
-static u8 vnt_vt3184_vt3226d0[] =3D {
+static const u8 vnt_vt3184_vt3226d0[] =3D {
 	0x31, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00,
 	0x70, 0x45, 0x2a, 0x76, 0x00, 0x00, 0x80, 0x00, /* 0x0f */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -243,7 +243,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 {
 	int ret;
 	u16 length;
-	u8 *addr;
+	u8 *addr =3D NULL;
+	const u8 *c_addr;
 	u8 data;

 	ret =3D vnt_control_in(priv, MESSAGE_TYPE_READ, 0, MESSAGE_REQUEST_EEPRO=
M,
@@ -275,7 +276,7 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		   (priv->rf_type =3D=3D RF_VT3342A0)) {
 		priv->bb_rx_conf =3D vnt_vt3184_vt3226d0[10];
 		length =3D sizeof(vnt_vt3184_vt3226d0);
-		addr =3D vnt_vt3184_vt3226d0;
+		c_addr =3D vnt_vt3184_vt3226d0;

 		priv->bb_vga[0] =3D 0x20;
 		priv->bb_vga[1] =3D 0x10;
@@ -291,8 +292,11 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		goto end;
 	}

+	if (addr)
+		c_addr =3D addr;
+
 	ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-				     MESSAGE_REQUEST_BBREG, length, addr);
+				     MESSAGE_REQUEST_BBREG, length, c_addr);
 	if (ret)
 		goto end;

diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usb=
pipe.c
index 91b62c3dff7b..fb5e1b0dce6b 100644
=2D-- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -77,7 +77,7 @@ int vnt_control_out_u8(struct vnt_private *priv, u8 reg,=
 u8 reg_off, u8 data)
 }

 int vnt_control_out_blocks(struct vnt_private *priv,
-			   u16 block, u8 reg, u16 length, u8 *data)
+			   u16 block, u8 reg, u16 length, const u8 *data)
 {
 	int ret =3D 0, i;

diff --git a/drivers/staging/vt6656/usbpipe.h b/drivers/staging/vt6656/usb=
pipe.h
index 35697b58d748..1f0b2566c288 100644
=2D-- a/drivers/staging/vt6656/usbpipe.h
+++ b/drivers/staging/vt6656/usbpipe.h
@@ -52,7 +52,7 @@ int vnt_control_out_u8(struct vnt_private *priv, u8 reg,=
 u8 ref_off, u8 data);
 int vnt_control_in_u8(struct vnt_private *priv, u8 reg, u8 reg_off, u8 *d=
ata);

 int vnt_control_out_blocks(struct vnt_private *priv,
-			   u16 block, u8 reg, u16 len, u8 *data);
+			   u16 block, u8 reg, u16 len, const u8 *data);

 int vnt_start_interrupt_urb(struct vnt_private *priv);
 int vnt_submit_rx_urb(struct vnt_private *priv, struct vnt_rcb *rcb);
=2D-
2.20.1

