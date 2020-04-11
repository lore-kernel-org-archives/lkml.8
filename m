Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BFC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C2D206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X3YKhTzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgDKM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:26:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:55509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgDKM04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586608011;
        bh=srZpBeRis2/6y/kg+tlgDeL20N0J/abMsBYWWU6lnrA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X3YKhTzk8NChTYYOZUv7F1IE7poNZrjHUlQaNFINc6ZW6U7UElAa/SOy9cGBFZks+
         QxWYAvk13Y564c1yznMQdQ7ftRNwupAUMWKiP3IQlHpLUp7wm6kp/01U/XHK7/r8TD
         mqHowLHg6CoZZ7Jr5s0kBVC/07Or02d2GHTlISAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mgeo8-1imnPa2tie-00h6FI; Sat, 11 Apr 2020 14:26:50 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: vt6656: Remove duplicate code for the phy->service assignment
Date:   Sat, 11 Apr 2020 14:26:10 +0200
Message-Id: <20200411122610.7901-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411122610.7901-1-oscar.carter@gmx.com>
References: <20200411122610.7901-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AGbfPJ4dTYtyjWLjOEMr+meLDN5FRKKzT/A2cHztiQSul6SZqpA
 uDCUSutE6GN23yAgkqoQHJ7Fwcw+UOIkK45NTQk6ZWggMdgYbsIYZykvhZqSdV/Lx9tpE5z
 8K0oQBOWRNTxb8BZP6yBV9irZaEIcRgyKfMVlhVMbemnYxmEBn8Ha2sEkRusGzNtRkwlGC2
 sm4CvBzIWOp3VveiMMzVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+bExj3+xiY=:35Oe3zYzGb+QfZo4BX74Du
 DeoKOVUXTkCqohT789Z4uolod1EGTwT8RlYB4NsBXl22/JzYhCumLkx3wR6ayedVS9tN4MPCR
 1KjQLSOkWCfA+8C4HsS7aHno3atP3JigmNMPstNGJYh+89kwYCxpt4kbEMSwctJ6j3EzBDemi
 skMeFXMTtO+sLxPsbmULz6Z9qw/41ULDMKfFaMfPrchbV5hAOzPDlskDaJKdjW8lIQ5pe5j86
 qEVFCMa4LS9CSKx9gKc79K+H755wdOoYDc1mghdxQtGTMwAz3uOY+fsUVwKbOrRr0morltfBU
 WXdW5z8QbvTlNhLnAwOrypm0G1l9wf+o+Mu5hgHVH1aHa04ld0hb2tonZ/K+gEXAE2Elr4nP8
 7qFP4ecvl9LrXDc1QdYRVFp9RfdaMa6X8UcLl2qnPUuZpgegdYx4Iu4EVgwr7OuLo3UWz7ZF8
 x9n/yKRskzF8ztEU2Yi2CkXvVxoMhoSAQGWmZN7jF2VULD+7mL2/oYzYqCXc1ZFg6Ln38EODN
 cI2Pp3gLQxx4faiEFMv9VSArZpViAApN80EX5QOzfP7qQGcPTJ5i2UZCu7UO50VCQ67Ow7zvq
 3Q/478LYVIpNukOJSFUDtqcLWq1S8x5pTOSzOCWZQqkfSYC3QOu7ZisVoANBFB/xV1jGu+E8X
 9tzcoMqAbYRyIZZ/yB778iQDgyS74wGPIc713Y5s/9OI8Qms1qlK9YG4lgiYrL/58aQMRwq0C
 Ae8i4pWXuNr594HFq6SjPmVtjMAXK0LDH221RPAF3ok3IL0uI8N1L6el3gNBE0o4f2ECldICr
 Eqrf2QsYDzEcjKcmHxNZMpHAWOjEZ47YZu50DTKZ9LRf8W/IsrMsBBTqSr0B6TmNFd0nerj2F
 2cNPIpqfa6Lj28pSBDH4a2ylcTtWSZOX4Fxh9/nP1ULbnwvjsz0PwhXFJM4CpPUooD0UbeCNg
 lOx9WhIcVjvwdTMjusoX2DepAheq0bHCw4AfgyOok5Fk1ETkmAkfasLhX+68FPiKdNN6A4sWv
 E9YN3EgsRO8EWTTRBizy0vKfYRN0ovirt2Lbzy04bpkC4KiCah1rhyCUy67gJMsUPWtPJlTjH
 2o0zX3yu03xN032Sc86JEWkpW+/51mMdAAickZol4W4BbFRuXItUhWF1+OKQ+bmUb5C8YB1CO
 oKm8j+UuZChHrYDIEaKnKx0XKmprRb5BltTWUm9VgDS1Y3xvSEfUPUyAYdmZM/y4x9Ee7pZLG
 WFIWssTUtUB3VajnU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take out the "phy->service" assignment from the if-else statement due to
it's the same for the two branches.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 05cc4797df52..c8b3cc84da6c 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -239,14 +239,13 @@ void vnt_get_phy_field(struct vnt_private *priv, u32=
 frame_length,

 	i =3D tx_rate > RATE_54M ? RATE_54M : tx_rate;
 	phy->signal =3D vnt_phy_signal[i] | mask;
+	phy->service =3D 0x00;

 	if (pkt_type =3D=3D PK_TYPE_11B) {
-		phy->service =3D 0x00;
 		if (ext_bit)
 			phy->service |=3D 0x80;
 		phy->len =3D cpu_to_le16((u16)count);
 	} else {
-		phy->service =3D 0x00;
 		phy->len =3D cpu_to_le16((u16)frame_length);
 	}
 }
=2D-
2.20.1

