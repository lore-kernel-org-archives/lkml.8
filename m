Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28811C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B752076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dnch9q0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgDWRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:06:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:50883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgDWRGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587661582;
        bh=EFoet2sHsrazKCmeWq8vS35/INWJasHQ6ZT4FP4XYU4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dnch9q0mkeSfLR4few9AuYLgos2XArTckfDtAuHpcBMDe2iweCUaYVCkvJj3o+vJv
         tWSDBaolaygXczlgr30SLanetzWIDHChi2n4BZuuUhcETQug7Wrv1G4m143fV05F9q
         lquS3NvLwBycEWuvPJsYNy4BLfYkOHO+oerTluPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MAfYw-1jL5jZ28bY-00B4pr; Thu, 23 Apr 2020 19:06:22 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Add formula to the vnt_rf_addpower function
Date:   Thu, 23 Apr 2020 19:05:57 +0200
Message-Id: <20200423170557.10401-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s2AKSwgBK6pKD3g1eM4Bf+xszXJ9QKNoSOSezgVCvS4kM2XcSqJ
 nN68RR/IcoxzfUpdNl0RGPyQd1xyrgCsst4dfMwflujnurgogkYv+II1wxqDWDh3WUDIX5k
 TFLIyS28KY+PNZlsR/PjG/QkaZL3triFrK6Y7uT1h9Hdn9MLkZYiKACStZOVyvtMUVtYXCK
 b4+yfZczxdxWMa0NlCo6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dYCPScnRMmA=:Tq0A2oVNVggqE3mrj40uLf
 6aHPsR1KuQSBgEU3kql6zw8l2TnpTfTqnG2bgdre+mXOf0iIebkWQbrgqE78+ao7YNzTRcScO
 +m2KxQCKYOaBfYiT/not5athP5TdKqmKJFjFWX7u2XFYK/lzEyy+vog4QSDsFv3Pggm+g+KfX
 PM0v9NnHYM1x1TS1uScM6m7FkoHiBLuZg13l23t+Cx5zgdEEZAq/UoEdAgRdYDiGaupia4m/R
 2xmjpPvc3LXXM5wNIStuVfii00GpjpSS6d2Ay520xFiIbSykP4oWk0MHWWJ9zgNOQDiLFJ8Z9
 /hdOHKQYhn0ZFDQSSVDLnapSZRwy81iHuw4rD34G6E+804W7IqRRWYu2LC8cBQEPCIjS4XKCT
 9SQeCN1DGQJIiFidtcHzCr2+FDhzztfyjGKX5syz/w2MeZkQD1Nr0tFlvsjwTDGz5FXu6V/gE
 dEfmu/HTr5C4VBThisBLpYiVQYTgajVviLYuh7TgAWJQoi31pDrBh118AqLrYQFs6LAsdOfHP
 szC96wCae0H+2SfEDH17hqnmE5PYZOzJi0/7QRAsAWTqT1WznHHY/4+yOhTkp+uQVwFe7HwDq
 uMikVJoloycxkBjjZJc7nZj500DqE94+qi8bPTgwr1icNl8P5eLMuvQukTMabGhduGsb6HID6
 1mGaW6LhIPR3lnVI8Io93KjI6XiG+OregTVipHuqBp1hhULvB2DxXZkZd2dyl771vOhmLhOkX
 xPJTofHPWqGf5jfzMxooNYGzaL53K6kYQEIPUmDNuQvi7Ma4Lpg03QzSMXg4SMu1cXcoKXFeb
 ilonWabYVg0kOKe1Z3TgZ+8FA760FBH87bb9MWQ6pSNbcXXC4zLB4lv7pk2DjFJyx4UENZLqF
 FTKI8LUr2+1qbbpsayDkoNncydLrNTFCBbqGng8dGN9sVWwrtYFBmZYPlgAhuFQnrfAQ1QboG
 fJrOUmU+xCU4yy/gqxBLPc6Rpt6uanBk1NOHclF5AEn8dYQ3NFGHiNUh1zKTipMak8lFWCFhF
 Oi6gDkty7g/WsVKp7I2mlopWrrGMJ2RNfmUZmGxiSbE7gQA/eEA3S3eqo7wk+JjD051LB2vDO
 hennND5Dp9Wu3pAuKdmPP0K2F/mPxXYCLupTBaaif+M92raZh6pzvDclC2WQfBowN4EZNUi0g
 r8+VAx8itx/ZmzX0kIzX8JnVIkNOIiYOXW/Xyy8NhZ0U6D05GpIWrP7OUrSNrMrSEug6Anx27
 7IR1n1U51bK6w0tYd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a formula to calculate the return value of the vnt_rf_addpower
function instead of the "if" statement with literal values for every
case.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Change the type of "base" variable from s32 to int as Dan Carpenter
  suggested.
- Remove the "--" postoperator and replace with (base - 1) as Dan
  Carpenter suggested. Also, as this expression has a minus before the
  parenthesis, remove it an apply the minus operator changing the sign of
  "base" and literal "1".

 drivers/staging/vt6656/rf.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 06fa8867cfa3..612fd4a59f8a 100644
=2D-- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -538,28 +538,14 @@ int vnt_rf_write_embedded(struct vnt_private *priv, =
u32 data)

 static u8 vnt_rf_addpower(struct vnt_private *priv)
 {
+	int base;
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
+	return (rssi < base) ? ((rssi - base + 1) / -5) * 2 + 5 : 0;
 }

 /* Set Tx power by power level and rate */
=2D-
2.20.1

