Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA3C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65B620748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="czG04/DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDYPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:18:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:43221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDYPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587827916;
        bh=1SIn20szDlQ1F4nqk/0hZ4TyVykqVcZwhLZeWLcVgGw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=czG04/DBSPtmlI8zLUxfI4a+WBUhg0Tsg1wCv6E4cUxnv6zUZ9yY7oRQJekxwm++D
         A4jLYBCDkqo00b6zSLRFlbKYhPPd9Whb2kcFLWpSwBYI5B9JEoaJKfubQMGqgXKsdI
         x2SErddN8O9AHd8Tj8Do4x8FTSk0YX851tCyWlbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MCKBm-1jK9NZ2xPu-009Lus; Sat, 25 Apr 2020 17:18:35 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/3] staging: vt6656: Use return instead of goto
Date:   Sat, 25 Apr 2020 17:17:46 +0200
Message-Id: <20200425151747.8199-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425151747.8199-1-oscar.carter@gmx.com>
References: <20200425151747.8199-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dSKDSH2PmwoWhFUHy30J0iudMbXoJEVM2KWUysCDF/0/DcK8GvV
 ejRAaFZV4wyIsY59XWoZfdSHGrrcoP6g0qcHZVu0bKGuJH7h2n+aJ2kp3N9OVGzeMBYOwSv
 2ZVUE+0LeviPZjGR1JFdlM+V9kwKBboUTxKndFo0v7xgODPldx6XXRQbOxJF4UvTVe8m1Tt
 pXc8swqR+p+X0+ecAYv8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KdEsPLDpies=:M4fIKrEDHH4Bezwu3CRTCo
 s//uikx5zn+9x6YOOhRYyUNqoBeTUoicenevYFmXm+MDMj3ZS8c49aoL+R2b06fMCXJtrjZ/O
 etOAhFqsrYtDAta/SDUZTwnhK33Zen2yzbZFBqiWUsAH6W74bKpGBFGwx/5mFMPH0pojCKqAj
 u4+Zu/Vg9TKDD8jC5QcCYiFkdPDWs/IgVyJxk8bQZjl2XL8y5nF6Wpu1kD0/j95neBSJnYHOI
 cIc17a1uYVoaQ1VRbDoz+NBwrrr6RjG3Nz7IXLgDSyIaGs5jEfGgR3UfCumfUIBVuObbwviN+
 LEfYn6aInN1HaUJF7s2lrDlvy+Q/wHQ1z6/o74RdMWP29MA94K4EiTN1UEY6bRUIwu2fgZCsb
 UT2hxtbr3/yQkyq+P1HB7Xn00C0lKgjm07xvyWE6BQeaxfk2kvkceakKmNIMzCHzyQlaiuvRO
 lwLxDsKgB2LlgfIsEdUL/RtX67y63t6s2l4DSEjQyentcEf+Tvlc8df7E78mTesJBuGRHBsLJ
 5y3CPRR9Aa77WBHllPsZuFhSz+Trnmv2UzQMh/9j4iIgoX8iDhz+VNJ/RX0UFVo/XaZUJeKA8
 +Z56ca7RXIX6EbL8IWe2v25s/EXxLXNU4C9/NqPtKPA00KB2A90aQ1Wf/jdFz7Q4mLH/OKGQw
 Tp15MTdjbxkPWVFS+GZ1xRd79Ozp6m5LUi7OtutlHql1kDXn+XlRtxaJgf8KzfjdvakpawHAZ
 jtCZYLt9KSbEObCiQutougkkg7MVQR615Q8YrNTY0UFXeftrNVuiVEPU4mmVPGt6L4CYJEQAc
 ZGj7N0H/z9HcYA0cHm8iz0bBlcPUQTjg4gM8T+E2Ny9MinU/ljinrVqVl1266Q8q9xfvMKpjO
 tlja0ubqM7+3UgQzXWnjLT79AFUaMvs3sNg/+TpaVjDw8FozvEQoZjb+m4UDoxZwW45HRHOjG
 9fzvV+LuXWxHZ3SYP+APqA820e/s/B0I7aAlMjYJgBIwbx5S0aXvll6yOAnE1vphOb5quOUBq
 HzzigoUm2Pyv2WhSCV9UTgOLqlxTteAeCofdQLsGR0f/8+Lcn8koaZ8XrwfQBTFGIxSHB4/Lb
 64ueVTmHZprQmDu0q+UgwSQrAN2ncoDmIM+yjs8pBeOMk2yusfDfmCvQFXZ9OW5wTR+Psnmv6
 wCRXFGzHyVOfdDYa2i/3jBzDSk7W9hdhygMWm2A+xQRxy6tpy/F8BAw0yE4uVkdDj9wYUMqRj
 LQqzO7Jz2vG/9fcRO
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

