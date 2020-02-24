Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57FAC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA4620828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="y+zc+9Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBXLPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:15:21 -0500
Received: from mx01-muc.bfs.de ([193.174.230.67]:9507 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXLPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:15:21 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 06:15:19 EST
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id 2D1DF2030F;
        Mon, 24 Feb 2020 12:07:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1582542479; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCtrqclveZMR9bnvI+c35GZ68+SSPkioSoUcgAu7HVQ=;
        b=y+zc+9PnKoovr5BCvCo7GA9XEMgHyanYcREL45gWStYT8FIVh0tkI2IGR2q9b6ou4y5pGB
        KXxEKJRqUWb4K8ChNHjFfVSIsUG3Jm8zHEIb4hkFMnjnYecVWizeskB/g8JecJXwtAzlql
        86muZe7+JOTHRRWLcXJ5j43HYRv0kLkyk1KeCxeAQITpysgfjL2cl1MxfQYwo8Gr/h4a0i
        +UVP98BmP73xXpaZ36gQEkEvBo83YSsbc6X2kh2Y99VbHfOQWQZPSg04IrZZWx7uX3RyFZ
        Xb3IVS98u8Z42h5jgh8qYVrA0Kmng8xE+lNLp+pO7usS65/ms61XDIvawoF4ww==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Mon, 24 Feb
 2020 12:07:55 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Mon, 24 Feb 2020 12:07:55 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of
 counter variable k
Thread-Topic: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of
 counter variable k
Thread-Index: AQHV6l3vorwXgv50W0ysut7cburs2qgqLndI
Date:   Mon, 24 Feb 2020 11:07:55 +0000
Message-ID: <5f875f84e6014d2bb5b78f71dc2831a2@bfs.de>
References: <20200223152840.418439-1-colin.king@canonical.com>
In-Reply-To: <20200223152840.418439-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-muc.bfs.de
X-Spamd-Result: default: False [-3.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.989,0];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[99.99%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Colin King <colin.king@canonical.com>
Gesendet: Sonntag, 23. Februar 2020 16:28
An: Greg Kroah-Hartman; devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of cou=
nter variable k

From: Colin Ian King <colin.king@canonical.com>

The zero'ing of counter variable k is redundant as it is never read
after breaking out of the while loop. Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/r=
tl8723bs/core/rtw_efuse.c
index 3b8848182221..bdb6ff8aab7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -244,10 +244,8 @@ u16        Address)
                while (!(Bytetemp & 0x80)) {
                        Bytetemp =3D rtw_read8(Adapter, EFUSE_CTRL+3);
                        k++;
-                       if (k =3D=3D 1000) {
-                               k =3D 0;
+                       if (k =3D=3D 1000)
                                break;
-                       }

IMHO this is confusing to read, i suggest:

 for(k=3D0;k<1000;k++) {
      Bytetemp =3D rtw_read8(Adapter, EFUSE_CTRL+3);
      if ( Bytetemp & 0x80 )
               break;
      }

 NTL is am wondering what will happen if k=3D=3D1000
 and Bytetemp is still invalid. Will rtw_read8() fail or
 simply return invalid data ?

 ym2c,
 re,
 wh
                }
                return rtw_read8(Adapter, EFUSE_CTRL);
        } else
--
2.25.0

