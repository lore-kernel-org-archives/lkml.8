Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EAFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8C20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 09:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="l6xPybgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgC1Jzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:55:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:40407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgC1Jzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585389319;
        bh=GF5fOQBU8LcGvDbPJpFKcu8Xuvl8GxKStGoxi7M1Hps=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=l6xPybgjMzn27Pf86wSYUTLvkQe3lOX0Ac9IXp8i+xeUrvHHLcEOpQbY/BzUe+GAj
         Z9nLiR1wFuhJfakOPuStiKkynGBVKgqNan42hvgj/rzX4MHqHOOX7Z+8J9wdmjZZKC
         Sk9Si+Dni+atCwarOcv2I0F/BqwvkP6RXvHtzvPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MOzT4-1iss6U3upw-00PMkQ; Sat, 28 Mar 2020 10:55:19 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: vt6656: Use defines in vnt_mac_reg_bits_* functions
Date:   Sat, 28 Mar 2020 10:54:33 +0100
Message-Id: <20200328095433.7879-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:812Pai66WVOzf4x7TeQ0az2SXkPT1AiBLUTVSXGCgdJkGxEFITZ
 1XKFwyKGPvrKJiod7Lo4ekZPmjGk43JSxkUv3RbrsMEOSnIhmoRL/DVEZ1/T4EDA+8Mqk/H
 NqxxP2nbuxydqaEDFr7WbeUKA24KwB5MmcIRFd+sfi9rVPCPltxzOpHBdxyQWJdIPay5/LS
 U4VaIOP0XAo42qFr4iWVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hq4z73EcVdM=:5j1xCcPsUIvjTogKmTYrNy
 rRT0DDOQcFGWAd1rZAz5mecZdBwCNvhD6c9Q8Zvgids10YDrSQxW1q8kPKvW5r6fhxOKRwjRa
 4YkcNbUIDj9MUqajUI45EWvddWT/xKrPxc/g7I9uuzw4yucOi0X1blUYnNNqv/4vFkkY2FV+K
 7r+u77MM8hFHz67dupt3qhtJsidQ837wvadPG2BVkD86xWB/Vsh/webwc/l/bm8ohevObIsUH
 spoB93a+icJY/DHkXtGAtLIxOt1wSn2wQCEcWkFOePXUqnaal9KbxTXrqjmjENkGPfUCBd6sg
 1vGNMH1DLGjuZ5pSryioAZM9K3XxMuMk9E6f9HHEUDxuvCzTIT8uvTG2bTbff8v3mbFCu+CS9
 q52QssciNwIhBrqTxYTVcptlRXil6nVDaMaLqYrDTCPAlrK7TFB75vLBjzjhyhn0gVRZK8l8J
 FS12/Xg817ijeYPnD+O3XQzySJOAqAGOr3yDI3TD8p1BoyvXpOTEGVGgSxUfKAhEJdNyTZaIQ
 8dTPGOAGP3OjUA1RLno1/7chavtWDkn+OPKiJMJUF1C5SadY5qLXwfsrZesp06oYjQaUO7ksf
 6z5EsV+cmUAXaCTQWGuDhDES3d1K9xBZk8zCrilkzpnVDfAVn+PxKTAjjKdL9mudmKI1woMaC
 TZzV4x1mfQ99HViwccfxBd3KVeL9NwY54R/Q6uatkI/S4mzQ/daEbLzwXzts3rX9ozQIa2Ppy
 s+IwUlhoL2SLx7xFCT0ErUxqsm/5VXKPGzXXZ7KePx+HTqmedAtBejLR7cwpPoQU31TDB3jJ0
 1NWTnmDbx9sQiJtKX7liYhXhOKcRfddT4bhtdJ+WmEzmHYYp1su1JLp7TgeXJgd9dd2fIGNfP
 AXz/WhlwTt3Kr8SGES5gCyeKkZhRo5us/qhqmkpOZLiqS5CysrKUvaIqOLzg8XEHrD9urFnOb
 6IOndMOHnGNgvyfN+FOYhlEzdWLHCN/hf2k1coagkMI4yqDbapDr8ecRWXqWYxJgT8ueiB26t
 fyl8mCEZv4zikeTbM42eVr7tboyoWT37Klg97c91EXFB8fKHiXMk4MhODzIO+Oxpfqf8f+w/9
 dIDoLdgHMp9EZOYBpRPgnI+1KTjRF/11DlPreE/cJzYQf+wG5603EhSFfKAbGkWAe/l7POWB4
 m2GRnN0LotDezwAdwvaYNjFRGTjXv0HNHMPatlsIb5RL6hYFpKproGLdVruE99j2sUCWrWU9+
 Ufxa8g3mRd9goKULo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the necessary bits in the CHANNEL, PAPEDELAY and GPIOCTL0
registers to can use them in the calls to vnt_mac_reg_bits_on and
vnt_mac_reg_bits_off functions. In this way, avoid the use of BIT()
macros and clarify the code.

Fixes: 3017e587e368 ("staging: vt6656: Use BIT() macro in vnt_mac_reg_bits=
_* functions")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c |  6 ++++--
 drivers/staging/vt6656/card.c     |  3 +--
 drivers/staging/vt6656/mac.h      | 12 ++++++++++++
 drivers/staging/vt6656/main_usb.c |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index a19a563d8bcc..dd3c3bf5e8b5 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -442,7 +442,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		if (ret)
 			goto end;

-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
+		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY,
+					  PAPEDELAY_B0);
 		if (ret)
 			goto end;
 	} else if (priv->rf_type =3D=3D RF_VT3226D0) {
@@ -451,7 +452,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		if (ret)
 			goto end;

-		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
+		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY,
+					  PAPEDELAY_B0);
 		if (ret)
 			goto end;
 	}
diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..b88de0042b9d 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -64,8 +64,7 @@ void vnt_set_channel(struct vnt_private *priv, u32 conne=
ction_channel)
 	vnt_mac_reg_bits_on(priv, MAC_REG_MACCR, MACCR_CLRNAV);

 	/* Set Channel[7] =3D 0 to tell H/W channel is changing now. */
-	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL,
-			     (BIT(7) | BIT(5) | BIT(4)));
+	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL, CHANNEL_B7_B5_B4);

 	vnt_control_out(priv, MESSAGE_TYPE_SELECT_CHANNEL,
 			connection_channel, 0, 0, NULL);
diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index c532b27de37f..f61b6595defb 100644
=2D-- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -295,11 +295,20 @@
 #define BBREGCTL_REGR		BIT(1)
 #define BBREGCTL_REGW		BIT(0)

+/* Bits in the CHANNEL register */
+#define CHANNEL_B7		BIT(7)
+#define CHANNEL_B5		BIT(5)
+#define CHANNEL_B4		BIT(4)
+#define CHANNEL_B7_B5_B4	(CHANNEL_B7 | CHANNEL_B5 | CHANNEL_B4)
+
 /* Bits in the IFREGCTL register */
 #define IFREGCTL_DONE		BIT(2)
 #define IFREGCTL_IFRF		BIT(1)
 #define IFREGCTL_REGW		BIT(0)

+/* Bits in the PAPEDELAY register */
+#define PAPEDELAY_B0		BIT(0)
+
 /* Bits in the SOFTPWRCTL register */
 #define SOFTPWRCTL_RFLEOPT	BIT(3)
 #define SOFTPWRCTL_TXPEINV	BIT(1)
@@ -311,6 +320,9 @@
 #define SOFTPWRCTL_SWPE1	BIT(1)
 #define SOFTPWRCTL_SWPE3	BIT(0)

+/* Bits in the GPIOCTL0 register */
+#define GPIOCTL0_B0		BIT(0)
+
 /* Bits in the GPIOCTL1 register */
 #define GPIO3_MD		BIT(5)
 #define GPIO3_DATA		BIT(6)
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 8e7269c87ea9..aa9c1fccc134 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -366,7 +366,7 @@ static int vnt_init_registers(struct vnt_private *priv=
)
 	if (ret)
 		goto end;

-	ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_GPIOCTL0, BIT(0));
+	ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_GPIOCTL0, GPIOCTL0_B0);
 	if (ret)
 		goto end;

=2D-
2.20.1

