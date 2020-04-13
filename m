Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031FC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5320692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UXmiIOPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgDMOCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:02:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:37161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbgDMOCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586786553;
        bh=aWabkX+VjxCXEjMZgVB4rhzfh2PYPDYf+m/yRAvUdDY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UXmiIOPA01lkaO7c8pVPiFVlYAdtE2z6cx/xBQtkdNWd8r6HszcmTzc1kjzbLO6vd
         UaedWVg1B0qb21PmcMXg69xHmqQY9a7c8LsfMdLAv5rRtfnLydMSSWsMWaQ6wEIIpY
         480jAfm8AdHGDiFwG/26t+3bXL+RxPC0Yw/VEJHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MORAU-1jcltO3vu2-00PuwR; Mon, 13 Apr 2020 16:02:33 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RFC] staging: vt6656: Add formula to the vnt_rf_addpower function
Date:   Mon, 13 Apr 2020 16:02:09 +0200
Message-Id: <20200413140209.4520-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Sy7ENs56EYNCOfQsabHsx7yt45HYz2D+WcFO1uzxDE12fmN9Ho
 kB/1t2vAIFxKUzTOW0Vdjnq8jrSToLtEPqKIYm1ChSBptJqxklKw8WFOunBwTQcWkNCB/FF
 uoLUV3/bqAX6XH5InrZhum8I+RAWOZn90yEPNgR68+dcftV3wwgmhwt1ijQJsvXE6YC1kjV
 5N+Ut59T+fexUk6ISm0GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G5K3oNxTWQI=:tiYGVznO3UgoOT1SouVKw/
 0JF6wxj/IKctsFjZsO7Eh3qJst9qhvElq4WWcozw7x9a8KBxEb0XAMQ58sPWXnhxpfis/aLc6
 3UGGeJHFrN7n/SmReiq9lWX6r7gCc9nOs/+auElvoRkoSUt80bfThbEaM/hHVzDUPTKusDicp
 HqDUInDAg2peNwwC+EITNeITUhe7DcYJEKIZe9NbbyiX1rrKRzxKkVKdXwAAwHv6wg6zC7oSX
 uNow+QKfIICJOjH/sMsY0IcnTfNkWLmqvjdW7R2drib5flBY+6lcY6bniuFR7XpxW6igg9g4n
 ypXZTELY0Jjrq0gxLZGCZhgy46QvbTvQmDgxt2OgSIRky4ITPYcxvTjhOCvPstxTdbZRNTVza
 phHW/hOMKXsfc1epqngYlwHLSU7uX5sxufhsozbQzwNqknp2u73OA6AXRh/bqQTpGoZ9TnnV4
 g5aMmqkgG/Op7d0xidn3XfBwmxzl83ZtWNo+7bpfIG3qyW5v4D6pn+ggugCF8ats6bE4rV+F2
 rQMx7RqjbQ1sgbmdd9e/wli6BrxdaqshIsVuR8Gm+vrzcrzolipT5T2+9sxjZXCUjB/DxIvAV
 Kvhi8IyE1skEkbQAnuVXbsslvucDSDXk4a52SBUfVHWG5sMp0awn+WEVGRZDWPns3ha/DEk5c
 ZMwyZhp12aW+bAC0dPDQsk6UlBBCrhFwdSjSFPrKFIBGy3SQic5DUlWuHPYyeXFNlj7BWUpxz
 MH/GSAZdOn9Hi4QDIEo7y6Gk2RpF8GLJ1i1jmyZWNsiF3LISpBA9pvKwWsQt5r/WuCfbM/HU8
 YwxscsQMwgQKgSbkdoD1EV7Hvt/a5GyGAkX/6QlD1qT9Nb9CZ3GNXU4HrHcmX/R53A0WDTCmp
 cPq4pnyQCg/fIRR6+JMXD+mJqMB+BC7C06t9fomVSflLarv2nkOczWf7mplRsbBx0jAkyODfK
 hrSVJh/QmIM5MyRFUSDo5tgnd/S1yj0fNgS8W3qbKfBBO0sFINRh3kmv0bKHyvztxOy0av8KK
 wncfeN92AF6xkavqoNhuQkjAPfKWoAfyZDfgn8+LxKJFcf6HCvFeudBOmz11Qp0nPa9Xnu722
 rbUhkA6MP1/82kBVkTpaZjLCOnY/DD8rn9V3hGGESnyzdAzz1hMZ3fxezf8BqHW8AKowyR/vP
 o/U75LXQAAD+Ry3SOuGL4yi7zEcKZpOz8XvWWRHupR8cEJqDH9paA7mjdrdB5hl/g1R+37PQ0
 vrNDR/0M9UEDLyoST
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a formula to calculate the return value of the vnt_rf_addpower
function instead of the "if" statement with literal values for every
case.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
What is the better approach for this function ? Leave it as is or use
a formula although it is less clear.

I prefer the formula as it is a more compact function.
What do you think ? Feedback wellcome.

Thanks,
Oscar Carter

 drivers/staging/vt6656/rf.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 4f9aba0f21b0..3b200d7290a5 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -575,28 +575,14 @@ int vnt_rf_setpower(struct vnt_private *priv, u32 ra=
te, u32 channel)

 static u8 vnt_rf_addpower(struct vnt_private *priv)
 {
+	s32 base;
 	s32 rssi =3D -priv->current_rssi;

 	if (!rssi)
 		return 7;

-	if (priv->rf_type =3D=3D RF_VT3226D0) {
-		if (rssi < -70)
-			return 9;
-		else if (rssi < -65)
-			return 7;
-		else if (rssi < -60)
-			return 5;
-	} else {
-		if (rssi < -80)
-			return 9;
-		else if (rssi < -75)
-			return 7;
-		else if (rssi < -70)
-			return 5;
-	}
-
-	return 0;
+	base =3D (priv->rf_type =3D=3D RF_VT3226D0) ? -60 : -70;
+	return (rssi < base--) ? ((rssi - base) / -5) * 2 + 5 : 0;
 }

 /* Set Tx power by power level and rate */
=2D-
2.20.1

