Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA288C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAF52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="uf58EdpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgBXLom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:44:42 -0500
Received: from mx01-sz.bfs.de ([194.94.69.67]:13014 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXLol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:44:41 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 06:44:40 EST
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 5D528202D9;
        Mon, 24 Feb 2020 12:36:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1582544174; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQfCLb+2eT+U7A5VwBTNyMYdMQKUx4lCZB/1s9gm2Io=;
        b=uf58EdpYHgG/inEbgiLTnQ5LWQDAsIiWHmkXOr9sYNHfbGmeqAN9EbAnZ2O8YZdZGLrDMx
        RBcvSO7b2Wp4wbKL6gYz8W8Jl1G8Gbr3+/VcpY114Q74iUSfB1o9YnfMdM67cdFE+wGTct
        6ZEAqygTrwyMCZzRpA7uhldwKu7AwE+rVZvg4ze2JgiBJmJXXkotHMC7m9qaFWtnF3lIah
        uJExg3dRtK4K6+o/EF7MAvl8L9+ywuWyr2bPt/dvgkC8LBIiCB9kz/z2Suj5I172loAzyw
        htLcUD9xoota4LhorlwtaWFbuo0ecqsUqyTmAp6WRY4ch8fsTcCcz0GXh6ubcw==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Mon, 24 Feb
 2020 12:36:13 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Mon, 24 Feb 2020 12:36:13 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of
 counter variable k
Thread-Topic: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of
 counter variable k
Thread-Index: AQHV6l3vorwXgv50W0ysut7cburs2qgqLndI///23ICAABIfGA==
Date:   Mon, 24 Feb 2020 11:36:13 +0000
Message-ID: <af6f814014104e3c899c5d0f4890beae@bfs.de>
References: <20200223152840.418439-1-colin.king@canonical.com>
 <5f875f84e6014d2bb5b78f71dc2831a2@bfs.de>,<20200224112735.GC3286@kadam>
In-Reply-To: <20200224112735.GC3286@kadam>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [-0.96 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.981,0];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.96)[86.71%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
Von: Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Montag, 24. Februar 2020 12:27
An: Walter Harms
Cc: Colin King; Greg Kroah-Hartman; devel@driverdev.osuosl.org; kernel-jani=
tors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of=
 counter variable k

On Mon, Feb 24, 2020 at 11:07:55AM +0000, Walter Harms wrote:
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging=
/rtl8723bs/core/rtw_efuse.c
> index 3b8848182221..bdb6ff8aab7d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -244,10 +244,8 @@ u16        Address)
>                 while (!(Bytetemp & 0x80)) {
>                         Bytetemp =3D rtw_read8(Adapter, EFUSE_CTRL+3);
>                         k++;
> -                       if (k =3D=3D 1000) {
> -                               k =3D 0;
> +                       if (k =3D=3D 1000)
>                                 break;
> -                       }
>
> IMHO this is confusing to read, i suggest:
>
>  for(k=3D0;k<1000;k++) {
>       Bytetemp =3D rtw_read8(Adapter, EFUSE_CTRL+3);
>       if ( Bytetemp & 0x80 )
>                break;
>       }
>

The problem with the original code is that the variable is named "k"
instead of "retry".  It should be:

        do {
                Bytetemp =3D rtw_read8(Adapter, EFUSE_CTRL+3);
        } while (!(Bytetemp & 0x80)) && ++retry < 1000);

good point,
personally i try to avoid putting to much into braces, so i
would go for the additional if() but this is for the maintainer.


>  NTL is am wondering what will happen if k=3D=3D1000
>  and Bytetemp is still invalid. Will rtw_read8() fail or
>  simply return invalid data ?

Yeah.  That was my thought reviewing this patch as well.

It should probably return 0xff on failure.

        if (retry >=3D 1000)
                return 0xff;

looks nice,

re,
 wh
regards,
dan carpenter

