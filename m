Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4AFC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B942076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IBNBwJTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440728AbgDNPlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:41:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:49841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440634AbgDNPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586878778;
        bh=AHa4Q10JDOKLRlghJ1WsjdEYi8ByvokcX/zRyKSVffo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IBNBwJTTBWNL201sLWo3pGdf1eKSZNtcaxcrh5wBIbXzndA0s7FG5Z3gOI+L8M+D3
         WKaScYlrXrtEFL/ddnSLPAn3YQ5TBpI/6WHQRO3rAIeP64xGU/V5SwHQ/mHXTh0rNQ
         yvEF0ovZAiunjEDdaV8qL75lnBJVY2s3Ld1LYxgk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MYeQr-1jkbUn1e7f-00Vdx9; Tue, 14 Apr 2020 17:39:38 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: vt6656: Use BIT() macro instead of bit shift operator
Date:   Tue, 14 Apr 2020 17:38:46 +0200
Message-Id: <20200414153849.5785-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414153849.5785-1-oscar.carter@gmx.com>
References: <20200414153849.5785-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hj50RiMhC57fIwjkP88TjST87uGtiICioi+9D6iF1LKxncuYvNo
 +5rBEPSYcPDQEVc6Nmhl7pOS+FPUkXtAncKXwtHqIECNZTnR5K7jUArK9pgr3B+sgt0O2j5
 AJ+ScEmwvAXvjsjS4n351mrX7/zxjXYA/06OYizTxGTiBkG3nj9YoYxhFJop+8vYAbyXzB1
 O3Z31u/K5VGTDr9w3vCdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OiIqfM/tpjg=:V1bSJlgAU3YcgWH/0IcNLb
 KMBrmJ5g8V2//ToAqQeLSt/oi71/cjteCcIYRyousXnjgwo9kYI7iKgCpGDtV/PU/xyE5s3LN
 Ftv3u3HB6btuQ/vJZcVwoXDP6dF4nbPBxeSmRuyPuCiKlvshoTYNillcBbObhgLWMfcru5pow
 ieh0n2wrsi4hA1EcG7nghZOiV2OzILdsMI/KHLaBte8+BwdXUI4KoGfLM6CmC1PS7jdHvcrgW
 //NJhyORuTfF6mdNaIE1hH/yjRJLUGfW745WqFtzHJk4RuWBesaQ4b/Io4lEeEKV6QsrLVJuL
 +Xm63GmmJ4iAw7IJxRUZuwo3IlQYA2ZfnMoSQ+ImJnfGtkH/TX/xsOWqvf5xm8rVTIHAIpimW
 FY/sAaMeJJcS9C/HDA0b6f2YYmunPluFKloUeJ9PVkkE+Q+IOjm0PAEA6ZuMaQFT7RDbxl5Rz
 IRURXlTKl8FR6/eefN6hAKxJX/usHGOqtPMfSikPNPz/tTdjlO9bxfrlQAEJZrFG5Rwe1a++n
 n5oculesh1Zy0JkvQV0srJVP9msTLcijxsvDALtfFp+kpCkfrYaMzC9J1WvUkw8amy5ukiT1h
 LvjIi+tEtFYNzt8MRyo6MWv+/4GuuKTspmimCV2/qbcPVpNQBeyNMghAhqGFoOY2wRlOiFbB0
 kH3Hkj3QaInEDh9I5krSYcYyfVRVGqXPvKAGyEZ/sJmRUY9PLNm9iQf9UCy/SRm96IXVcc/o1
 T5eHr/EE5tEdUDk7D8ULl8OgIjPnb3ZBfykhXVaALxl7e1ioI0jfokACJrVMdITN9gZfyZ+oW
 viMIG9YT1Qmp3Zq2C9A/IEJH1Wqy2tqVZcegSUcsg2ruugYJcuH+YoaOjdOluoyoNOwFT4Vxf
 INphGDK6nz/1OJYVEcsTEGDME7bC3NCv3aX0YbqeDo5GIDeTw8oaMBRAMg/F2z5eLXoIopaUg
 pg+2ZTkOB0/aSaQZ8YC1uaftPccWfqPiI0erOM/qomhfGDukONH5quFR+lNtQZYdrDpQ2tmkF
 VYXP0VmZpB5vANZfZ7Kw/11pixJRZfyHMCBT0ntx8TIWUUNZmB4SnOJDXkqZTCBoj9cZ0yo7H
 MKspyqGTNc+eiC8yi8nFg3sGffKuDVB2nzYLM3qOYDshQEr6mWMeO1vI6+M7w0y3s+hLqd4gB
 DgM4VyhRjgTlRRMicDRdtJ3OKn7p3iGJ3RzYA01xaW6PXud270DejvZugy/o6g5nnYXeIonJL
 Cr6aQDY3fFZ4CqYqO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the BIT() macro instead of the bit left shift operator. So the code
is more clear.

It's safe to remove the casting to u16 type because the value obtained
never exceeds 16 bits. So the casting is unnecessary.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 9bd37e57c727..f8bfadd4b506 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -228,7 +228,7 @@ void vnt_update_top_rates(struct vnt_private *priv)

 	/*Determines the highest basic rate.*/
 	for (i =3D RATE_54M; i >=3D RATE_6M; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
+		if (priv->basic_rates & BIT(i)) {
 			top_ofdm =3D i;
 			break;
 		}
@@ -237,7 +237,7 @@ void vnt_update_top_rates(struct vnt_private *priv)
 	priv->top_ofdm_basic_rate =3D top_ofdm;

 	for (i =3D RATE_11M;; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
+		if (priv->basic_rates & BIT(i)) {
 			top_cck =3D i;
 			break;
 		}
=2D-
2.20.1

