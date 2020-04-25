Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FFC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9131D2063A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DideTJiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDYMj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:39:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:48565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587818391;
        bh=V4mn8XWOidnV35lpF6k4PLGi3eJjtkJ7bFNpYDHAFrM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DideTJiB8slIn57i6tk5GiN8UIMfAoDmIKzYHYyQMAEuNQLmih/z/6GShZPvTb4wO
         g01Y2hE6Oe7L7A5QhUxlUfzQ3TCschYdobkUDxw62R6ipgcCYc7AxozJI2XlcKBRcK
         ab1tlYkZQwqaEEKDuZplwvzg+raJRrv+WQNgCQoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MBUqL-1jLOki1TNn-00D2no; Sat, 25 Apr 2020 14:39:51 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vt6656: Remove duplicate code in vnt_rf_table_download
Date:   Sat, 25 Apr 2020 14:38:44 +0200
Message-Id: <20200425123844.7959-4-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425123844.7959-1-oscar.carter@gmx.com>
References: <20200425123844.7959-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jqFWb70n9RfPKgUObno8Iw7CMmVxtFSt4+RfiveChfRkOcYAhBu
 IKwax26Nf3eDVNaBLhEa6abtpz6Qvym96PAmR1e3Rl0SGHTPnP9nJRWQUt6Mi+uQNbcot4R
 md0AWx/88QtPQsObcWnSBeMrYQiKMAC7AWaTuYAxf/7tpPiwPAhkwi47Rm9N6gvtakJWAuZ
 z0vxNJ1DB0llerY+cDpnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LoMAp7C5TW8=:1t2tuXAJZXVaYNrNcE7NnC
 XY7MRqDjGFQEHQ/XG6qzyHGMKwV32XvKQeqIkqarfZEB8+N2XPY3Xp6KmQn9E3hiRJR6IQUgb
 daxY8d+yYF1/DaNKcmJQ9vdhksqVYxnSBq3OaQW7Cm4qGmAywnQ/T2Y7w9fA/hrnnMW6xJHFP
 F3E5uPy8xDe3s8cFgVbUxWWWn8ByFZUvxcga67s0K30zbt8TNi86P9r3yFUc2kJSiVm1nzxqz
 r3ydMguppQoe4eCtGKgLuAYLZJaFbgYKRgpwO8+8bN1qI3pyd9OQsS7Tnyykvjn5NHBBwBRqx
 MnQjibK+yF/SNiyeSpqQqm4PkAP/gKWK1oTj0fl2YG3feIWIr4CudqAgReTn+v4RIZlv4t/jt
 jLJS5HzEct1oksRtgy5/XF0jUA57VrpJRDJaU4PZVnq2Vhwa0bk2GI+SLm187+UVDc8YmsDzk
 EvtKZQXPRBPXOZhuaXMKYSoZw1Rfnkh/n58b5JXe4dmqSZS+rBF9oQ9yAX6Q/3E31UZV5nW/c
 wa1L3QJvbQ9l21sGM4flh8GlvbONRUHNMs7MDceQHL01iPlMCLv77HNpL1iemi7UaYhuV2SXI
 MyTfxPeko1EBUH9xWM0enjAKxTCPFEBpsY9i5xKoKFMzX/TL9kZbG9a8te5limkkZhQcbfXUg
 VfEfLNJfwsrQ08SV9T3zomRVuw7zS3fbgRMMJvPdpCLwrpKFiAO/jR2h2zxghGi8hknLxTm+Y
 frzF44boLMjj89TJs/b6IEtp9UXX5cuq70m4YeUNmrCRkphATk3I7mc7cyIgLUonZ9RtRrMUn
 SDeJfFhMOmoenvgrsBI8sMGPCx82fVTQMfpdHzF1tZcYRe39VdLAOaVM3KetetqouiPsfXRqn
 X5xV2bVsj7kQMDOMNPB3rRryc24M68x0Ay2BTGOcqJmeKMD5Rsg5fICuVjCBRkXoTKH1Ix2PS
 fAvtI1K4pcFVBPZxHQVCT98QGXgfKn/BX7lW6oS+mNKkLg5QK4PrybWDDHyCVzPo6fRjShf+g
 FUzhs6E8cs6jbUPWG2flc24Z26Igm19E+73Ay66d4yWoJNSpqezkaKRCsglz4WjN2ww7z/3yI
 yDlT3q3K9RnvfI1CsulqXhnRurA9NLQXeDpZ0ycql60vJ8tU1EtTZ4AEdSdppJdTI+Gmh88De
 Sc5RUgGpju+kIf2kYimCtZKINWNSsC5kdsZfM4MO7hYfnYwPuINmjlWrWLCYi9O3TZB2Y/AJR
 viNmYMfHYR41h21/3
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

