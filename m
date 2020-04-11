Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080BC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DD2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OTvl5qOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDKMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:51:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:54069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgDKMvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586609507;
        bh=SVlJCMTqCvv1c7w+nfXau/qquMjlmrvygXkqNvJ5DeA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OTvl5qOXk+sZS01NtSzMawPXJv0EYDrjhqI10N/3pkGGezTZs3HAjDudN4e16ZWcc
         zuF8/XcNpehMy8FWThKLijWm/kamBmjNE3AdnC7ooPqfa97w+mDmAVz7JCdTfHYbrR
         KdRweir4YfuEMKZoFeVMopiFrq06cp3FUjtQhAZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N3se2-1jELf10eY4-00zjYw; Sat, 11 Apr 2020 14:51:47 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6656: Remove unnecessary local variable initialization
Date:   Sat, 11 Apr 2020 14:51:04 +0200
Message-Id: <20200411125104.9625-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411125104.9625-1-oscar.carter@gmx.com>
References: <20200411125104.9625-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tNvyN6LT2MEV85uEyIvoHXTQfbD8/HTPpV5C1/Zxar6stA3PZZA
 vn95fFukMuJQmtJ5nhhR8aTK7OPF0cUt/h45oKgo/X1le6zM1k2F7roBba5JTdS8sxsZJwj
 lZyAFU5fAi54xlkRBEBdSH5sjJh1M6Q9wRUppoGTTYw773O/OQKphcsgaOw5QgPVpsCjbwy
 nm9jj9EuwRlwt6xh8QjEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkd81Q42ko0=:946dBrp9QK3j+5gy9BSKYx
 VZeqvLvElj8sRI6cNqg5AgSfQgowxwakhPM61IUjEliUWe1b8RrJ2cNsIg9pPFul1TYISIOUE
 uso0JQLMRrY3viawSLTiDRDlhHgQDGatTrJPQtUGt3vP/RcLjO8rciXwhOb9h5OsKvUIOTZwC
 m4W+Dceb2Ljeem6Mbdl4WDLez8zxkY4zF7qExo+SPVMDW5Gwb48pA86zedVq+VIJsyCo8/O9l
 ne2IYlrrrWa0z6sfPYhsbZ+GvJT/EwkcTKX6WxModm/b3lcYRyhjzolvSwpFzg7OmQAv3EN+z
 XMAO8omytfdi3yH1h21A9EoTidDYUZahU+scmErNJKmC+oD/tNBGzRZGifXaQ+1+zomFAEG2A
 9XbEw1kQlNkF+IEZ/Md0kf9xqLPAB7aQLhNhADFEFmr2R7FHwvzEtjkJAQZThIA71cAsoI5sT
 5qXcLOjtQ9J+IWqMiWte7TVahmwjjePgY5ikQq09IswbLcuREWwmQds2BCeNV03hRGxhdKzpA
 D3XTho4XZCFPzjRKJexVxIb0ZJNTPseinHqG09Ffkoo+W4DE56KsaMlzmKnCqTs1JHgm1jHQb
 9mzOV3f4VoF6NGeB8vh7Bb1UXGrvbCMBU5SrEPVFrrba8HNVNUiumZhkC37dOy4nLOHshcoIz
 pwthBwIZpC3MD2XEtKBNWnB6YhafuBrPz21sCzXHIrNeFWi+jGtl82C0+Y0f/Gx1LBJnspmSP
 LwT48sIFq3ce9B5Us2Fwd4wNCtWF5KQEsen4fLY9iIshU9OdNP34HjvYAkH6YzPcyUSvfVWrf
 Z9U1k5X89O+IKUwUUrOH/OUSUDmMGKoqokzjg2dlzTtjujnFZb41TImohek5zJDFWAODnh5A0
 UA7jwtLhUIXEQoWZFfbgN/+L5LQ7WgIGTf87yZy/umAieauY4gZYpx77fuEkkizYL02iS6tx+
 Is57eWnqgk4hGzPHIS//YoeGx6M8R67b/r98+0ZADOFuQkaBseRVRCA4f1e+IohSGRH4p4JDr
 9/OPm7CmTykYoar0qYYCuIUgzzzYJx9kkCq86J+p6n4eLnumqDC88JCGQJ3rYSVnmkuxrzxvS
 siQ1NGXoTYArAfYInDORlc9I3eQqan45lexf5AL47+GWju7t4zipG/xoFKzgNInzR23/jaYda
 kDxwXLx6PDj5EE+65eGXm8+V8yD5G+Qatut2PKKI4ED06WRVc468CVGr/AshfDfT6zBfboaTs
 gj2ySC++1UdUS/rBk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't initialize the ret variable as it is set a few lines later.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 276210a7284e..10d1f2cbb3d9 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -352,7 +352,7 @@ int vnt_set_antenna_mode(struct vnt_private *priv, u8 =
antenna_mode)

 int vnt_vt3184_init(struct vnt_private *priv)
 {
-	int ret =3D 0;
+	int ret;
 	u16 length;
 	u8 *addr;
 	u8 data;
=2D-
2.20.1

