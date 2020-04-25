Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A41C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8739820724
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MZWbrsqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDYMjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:39:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:38573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYMjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587818386;
        bh=1SIn20szDlQ1F4nqk/0hZ4TyVykqVcZwhLZeWLcVgGw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MZWbrsqn2bp0LXGKm2V7LgrvHAhex5rDATqhiahLGB/XRiuenc5gv1ehwhidL0eFb
         vikFHZ47knPaNzTA1KrV5PVYyoGod4tfTYTg6zMNqh+3zny36LDVEE72BWkEGPrQGk
         XexarK/nud65maPXI/fzBKIW/xX1BLQiwn6LeTZM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MyKDe-1jGQyk1Nlc-00ydV5; Sat, 25 Apr 2020 14:39:46 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: vt6656: Use return instead of goto
Date:   Sat, 25 Apr 2020 14:38:43 +0200
Message-Id: <20200425123844.7959-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425123844.7959-1-oscar.carter@gmx.com>
References: <20200425123844.7959-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sGY3ikEfwZKdQXuJ2Ru64c19gYQpIsD/6uUw9Ul0BFBAtl/zNIu
 r2ezFMrU4BwH75/n12wBVwcUNDPI0I0d6i5TLK7BsEU61hyelkoL4ivctN2t0aZmRJHI7yp
 nVwJGV1zS7R+mDMG4pywISSwI7l44dKxFG8uzZiTXrTsncTl7HWYcj3rU/qVNEM0aMx4joO
 0NFl85JTbBlvdR0MKw7GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XYzhrhaQobQ=:95754qRKPj/ltbWzxh+qgU
 /46cAPgTr5PgTktRkwd13dhEaFcWI8a/OF0fkS9Of4tFvuHiHU0ONRMpkpzB8Rg+4Tqgd1kxu
 FVUvmSuVxwdsMhtoAp/qR9Gz7BAfmHkBxqliXTx3d3LBM/5bpjrNH6Rm8L0zC1fzzttkgjHpn
 AStQM/fwjWRro6QgSm+f/Wdnn8x9+f+mw/YEIAJVDSTDPSt6/abzjp3ro+CkhY/bklH6np68X
 XiP506k5OnNiqYAJLZnF6cW/mIchsppjaHCE37ZfecV+k2J0IGKpWOY3BShCIfAzZF3g25I3Z
 omtTdo6rLA+hcLiu8EbveVfPNWuMtovUMNZby0KYWLlf76jmsQ4JBF6qmxV1N571QVNojVPH4
 v4BIHqaGFjQTfWHIagmX0+MTFGiTgMSRtDy1qXwcxwLEq8kMaL2Z51Zau3hRnutzNtFsRVu7i
 FJmJ+JcvhCtUU8kV3MEQgEoom0h+tB2hm4cHf6j6GSb92LB+L4yJ3ENhh7z9UD7fpB5T7X65C
 zciZx4GBgMUkWSfrLVkQkc7N1GVXohA1nqQljCjbrAYDDofwz0cheZ1rGzhpSUPNfri8btKJT
 0ZpZi7/bQkIJmwapNSraJoBu8nWTy9uchRAnYSsQkZKnO2rtCl02XKtEZaE0w+iaEmtBMhDRl
 5p/cDLKSSXVUXqzbyEkr22gmy2oIbH3dQwehhrw6UyufSITWe5itE/PCEpTqS8xAK0iFSqen6
 WpfJLMx+pdqAu450iGU+FQsZZ5PMlJ0AyRGAusDIbUiD9pCjS8P4uoVgQHN0oOoURrJhEiWIw
 wGhQ7PQZc5MyDOTJXGp9D6+4LT14qcJpvKnN+4KMFCE8iuKWMX88ltTRDT+JG33OMrxleCMk1
 GOXifpblP2hSiZHsG5C0R/lHF3Wy+ygmxOd1wjlR2prYDsI+3FHDIUeAAsVZ9+Oq0U2TmtSHU
 Wo93mzkyUM5GoNx8gnxzbGF62ET9/c98MR1YD6iSKicJBFuBZDLw5xIbaq+pzFzZQtGCLjFd2
 6Tvn/zxNUtHVePmtGFKsnsL+W8UMUPutciX7gPlefZz+G4t1VQqwEW4Tfj2KF9IHap93HNIIj
 A4MU6bG1ovxCzBN6+ilT8HSTKgeHmkOhPZcrYUsVT2l+qTuj55VZsTvdsS8YVCS+z5VbNv+7e
 2WQQ2ZJNPBVtVq99T4qrBCHtw+K8g11YPmgmhtUa971o0tvaA79HAws9qFVjrE69yEE4BWpzS
 uZvnL1QDzlptNoSit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the "goto" statements with a direct "return ret" as the jump
label only returns the ret variable.

Also, remove the unnecessary variable initialization because the ret
variable is set a few lines later.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/rf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 82d3b6081b5b..888b6fcb6e91 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -766,7 +766,7 @@ void vnt_rf_rssi_to_dbm(struct vnt_private *priv, u8 r=
ssi, long *dbm)

 int vnt_rf_table_download(struct vnt_private *priv)
 {
-	int ret =3D 0;
+	int ret;
 	u16 length1 =3D 0, length2 =3D 0, length3 =3D 0;
 	u8 *addr1 =3D NULL, *addr2 =3D NULL, *addr3 =3D NULL;
 	u16 length, value;
@@ -819,7 +819,7 @@ int vnt_rf_table_download(struct vnt_private *priv)
 	ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
 			      MESSAGE_REQUEST_RF_INIT, length1, addr1);
 	if (ret)
-		goto end;
+		return ret;

 	/* Channel Table 0 */
 	value =3D 0;
@@ -832,7 +832,7 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
 				      MESSAGE_REQUEST_RF_CH0, length, addr2);
 		if (ret)
-			goto end;
+			return ret;

 		length2 -=3D length;
 		value +=3D length;
@@ -850,7 +850,7 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
 				      MESSAGE_REQUEST_RF_CH1, length, addr3);
 		if (ret)
-			goto end;
+			return ret;

 		length3 -=3D length;
 		value +=3D length;
@@ -867,7 +867,7 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		ret =3D vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
 				      MESSAGE_REQUEST_RF_INIT2, length1, addr1);
 		if (ret)
-			goto end;
+			return ret;

 		/* Channel Table 0 */
 		value =3D 0;
@@ -881,7 +881,7 @@ int vnt_rf_table_download(struct vnt_private *priv)
 					      MESSAGE_REQUEST_RF_CH2, length,
 					      addr2);
 			if (ret)
-				goto end;
+				return ret;

 			length2 -=3D length;
 			value +=3D length;
@@ -889,6 +889,5 @@ int vnt_rf_table_download(struct vnt_private *priv)
 		}
 	}

-end:
-	return ret;
+	return 0;
 }
=2D-
2.20.1

