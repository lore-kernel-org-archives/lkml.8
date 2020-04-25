Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BEC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C62071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b2HK/aFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDYPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:18:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:53825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDYPSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587827919;
        bh=V4mn8XWOidnV35lpF6k4PLGi3eJjtkJ7bFNpYDHAFrM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b2HK/aFjc/NgxS6heebeuWwbwZIfNCCAoaM5rua60nDkJ4gtc3mBKKWJwoGyxA7NM
         rIMUfhxM+YuGff2CoDmpIo4w3IBTryflI8UntDPjLSWERAjrlAiYBKuaukQC/unqzH
         nfcPEF69w4NTBd99/9IhmRIEEV4ArQNcNuoH/qMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MysRu-1jFlbp2aos-00w0Sg; Sat, 25 Apr 2020 17:18:39 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 3/3] staging: vt6656: Remove duplicate code in vnt_rf_table_download
Date:   Sat, 25 Apr 2020 17:17:47 +0200
Message-Id: <20200425151747.8199-4-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425151747.8199-1-oscar.carter@gmx.com>
References: <20200425151747.8199-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O0CbRDf92e151EFq1Tr62g7Abu264JDJMB0TQsvFCf5to1J4tlu
 uGIVzKgrpivucPTVkS+I8nfkoGKr11imtK/QLaOPiAwHgbHVhFLLnn0eRvVZ2TTV5TZa+Nv
 gEPHNRtQNLnQqISLx141zUzA8Nl3+52wFDezmPueb6NiG7WAmCTSJoZQ8rOvupN0L3esxfa
 M5UVFcCM/0BzuP2kYL2SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P7XaABjktOo=:mYSAPT8yUikJd6o5uzjVjS
 gbDmQcWxXGAC3xuAmK3hAeKzD5YKhZJhVjMMF+yg2jcYjB8JDULAVnaKRBcJMh9ec4q6h4PF6
 CEySSeGjEhmGwmtuEMPmOLxBKvyMJL2djBRlky3xfOh1LEttp9n53cQQNo6MuhcXOnedf9/qH
 +BEJBfXN216SyRi64avQNC/DJNdNQr6j+AcFXrXfwXDvSCithxujcgasrnQ1JANNN1bAhBplD
 jax4KgkMOe06tajaEYYHJk4xoZwFihftT0rDkVFWruUkVZjxvswJ8lZG1CK8sksiPMkw917EW
 sKs930UIixEYuDP4Qi4MkEt3XURVG6HxiwTsW63KN5umAS1RQZzRDt0liXp5nUh1TxR52mRj8
 yO7QDclwdHx09pe47aBW8xQTyOqRaConXy73wmeVJJt7sKvs9d0DK/btMyed1VKsPoP9P9K3R
 J2HJuPUPi7v48hk/GbaPLo4iy+4QdURiKLPo2s8TfoS6FxJ8U4qNDuQ1LB2NLDdtd1F6xWfJ/
 7gsqYOTmXJeG0upG49MLPpBUDcwCmYKlK5bOP6R93w5H4aMndwaLEVYh1CLDEJrTbKR08DV3S
 b1dU3f3fPIKssujyPnqo1ojgrWnFnXgSYd6U+5SjqJ9YU8Peum57VjYmZ97CNwQwGMP1hkQpi
 sEeYg/0K6k5Z56E4dh+fg50BZHeJVGDQyPZ77X2UxQL/kFQ4Q6wA9AZN+uWiSoPE85sHQMBGe
 YnDUMyDTnmqLopIob1+fNCwOr1P6xUwW52WiWmPx70oLhiddhPaMlIj52gfdZ06m1Nkqw9b+Z
 9fwcWciwZnHR3EMLbtxiZ7p/RSxn05xsjtMvS2A8NmULgQIJGtF4KxBKoDERhejZGaaNMdNL4
 D07/Elpj2yPVoILjshnFKh1zXgI9bXB31S+O9P0L93c53q5XsGuoh0IhBSb+qte+ED+S2YhLb
 rBsTV/pfW2RojsptfcWpZBks1H93WVpgTyN7owe6EVtlQlCRT9Vopn/Zpnu3uL2QdNhyYlhYf
 /wi0RniHbiP51oNarAiZe8OSvYqvu6/dc+DUSt0MBYZVaKGUbMUi2RaEz8VuDdT5DJKxC1C55
 9ZHbLxNoc1aUnEvk7HR+tXyHC+YN7Q3Ql2mU7l1g1RtS1lYGUZPyWqqysk6g5bG4zCH/OfJYq
 2n1S+yVnMEZRVNgGf9EhBFEMrSLQTAjiLhmkzwN/1KYYVIbHXdeFBE2z2RhiiL5o1v67oLan9
 HtbuntM+1gcnL7P9x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace three while loops with three calls to the vnt_control_out_blocks
function. This way avoid repeat a functionality that already exists.

Also remove the variables that now are not used.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/rf.c | 65 +++++++------------------------------
 1 file changed, 12 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 888b6fcb6e91..420e9869af76 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -769,7 +769,6 @@ int vnt_rf_table_download(struct vnt_private *priv)
 	int ret;
 	u16 length1 =3D 0, length2 =3D 0, length3 =3D 0;
 	u8 *addr1 =3D NULL, *addr2 =3D NULL, *addr3 =3D NULL;
-	u16 length, value;

 	switch (priv->rf_type) {
 	case RF_AL2230:
@@ -822,40 +821,14 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		return ret;

 	/* Channel Table 0 */
-	value =3D 0;
-	while (length2 > 0) {
-		if (length2 >=3D 64)
-			length =3D 64;
-		else
-			length =3D length2;
-
-		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
-				      MESSAGE_REQUEST_RF_CH0, length, addr2);
-		if (ret)
-			return ret;
-
-		length2 -=3D length;
-		value +=3D length;
-		addr2 +=3D length;
-	}
-
-	/* Channel table 1 */
-	value =3D 0;
-	while (length3 > 0) {
-		if (length3 >=3D 64)
-			length =3D 64;
-		else
-			length =3D length3;
-
-		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
-				      MESSAGE_REQUEST_RF_CH1, length, addr3);
-		if (ret)
-			return ret;
+	ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
+				     MESSAGE_REQUEST_RF_CH0, length2, addr2);
+	if (ret)
+		return ret;

-		length3 -=3D length;
-		value +=3D length;
-		addr3 +=3D length;
-	}
+	/* Channel Table 1 */
+	ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
+				     MESSAGE_REQUEST_RF_CH1, length3, addr3);

 	if (priv->rf_type =3D=3D RF_AIROHA7230) {
 		length1 =3D CB_AL7230_INIT_SEQ * 3;
@@ -869,25 +842,11 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		if (ret)
 			return ret;

-		/* Channel Table 0 */
-		value =3D 0;
-		while (length2 > 0) {
-			if (length2 >=3D 64)
-				length =3D 64;
-			else
-				length =3D length2;
-
-			ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
-					      MESSAGE_REQUEST_RF_CH2, length,
-					      addr2);
-			if (ret)
-				return ret;
-
-			length2 -=3D length;
-			value +=3D length;
-			addr2 +=3D length;
-		}
+		/* Channel Table 2 */
+		ret =3D vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
+					     MESSAGE_REQUEST_RF_CH2, length2,
+					     addr2);
 	}

-	return 0;
+	return ret;
 }
=2D-
2.20.1

