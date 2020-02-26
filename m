Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48678C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBZH0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:26:33 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42310 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727035AbgBZH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:26:33 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01Q7QV4s031800
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:26:31 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01Q7QQVV025813
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:26:31 -0500
Received: by mail-qt1-f199.google.com with SMTP id r9so3264066qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 23:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=/RrYGkGua2Nxdn/5XcsUsmert5oNHB1woL1bedy/GmI=;
        b=Mi9fiv1BCr3hbBIfRDKERWQK+Z2Q2zPE1IR+429m+TmKgL4re59KgrA16rDK7LPJ1O
         3qSZ50UiG/dmjQyl+8GrNFgOF8lnvFRkr7JZGvY4i/q9n4XUrZ9yqbK4AfEg4LYpmjjW
         PlxMjL9qcqnEMiypHxcE1Zq/q3MQhjGxtFsrFCpvz4aEf1VBkJvoPkMxTqLxLuJ/+30O
         sEqiN6OmDhSxyT8IHwla1C4BAKKyrqCFPjchayAj7tjqrgE2seGEMhEfDghY9PToDHkB
         uCLS3JyUbibw3DJqEAHw+edexWmc5M/BoRsPSWZsC80qwZDAqRhIIqkStpf+PRtHNc34
         H8VA==
X-Gm-Message-State: APjAAAXneawsR4KWOsFg6I59LwS7PPDIDR1qtJl2OFCovvawC0URqMkc
        papFShJgg1LpCKOSqaF/C07permrFtdYmy2vtnkKM6amBLEogXv6WtLhbJdhF0MSWSBnmOTBtvj
        15c6UugWQ6U0TXUgk4WWNQANc6eTI3SOcrvg=
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr3993095qks.369.1582701986638;
        Tue, 25 Feb 2020 23:26:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9jp1KDxLFeQLv7QeR2TtKnSWWQ2++QWZI9Gbb8l6PC8kX3KCPOu2JNC/AcAu35IfNkSy/tg==
X-Received: by 2002:a05:620a:818:: with SMTP id s24mr3993072qks.369.1582701986335;
        Tue, 25 Feb 2020 23:26:26 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x131sm689963qka.1.2020.02.25.23.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 23:26:24 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: remove symlink feature : Additional patch
In-Reply-To: <20200226063746.3128-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200226063746.3128-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1582701983_403032P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Feb 2020 02:26:23 -0500
Message-ID: <503049.1582701983@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1582701983_403032P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Feb 2020 15:37:46 +0900, Tetsuhiro Kohada said:
> Completely remove symlink codes and definitions.

> In the previous patch, it was not completely removed.

Then this should have been [PATCH v2], and the fixed version [PATCH v3]

> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
>
> ---
And right in here there should be something like this:

v3: fixed subject line
v2: previous patch didn't completely remove it

>  drivers/staging/exfat/exfat.h       |  3 ---
>  drivers/staging/exfat/exfat_core.c  |  3 ---
>  drivers/staging/exfat/exfat_super.c | 27 ---------------------------
>  3 files changed, 33 deletions(-)
>
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 4a0a481fe010..cd3479fc78ba 100644



--==_Exmh_1582701983_403032P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXlYdnwdmEQWDXROgAQJaqQ/+LFm+5gnoObjHByvFiSe/WLwyDsLR5ck8
NxQVtg5wFV9uNxsVdsTCyiwaPril0sXlQfIvt3+di7OqzwfwSmsmLkDNHnrxPoCi
n874KFMcJ7QpBXNP+FwWKd6tFB6ORf0A4EAQG+oS1afzVvFXKN9Vc+FYiT3GfPlj
KlUgi8WJpQriRYz2HQ6RcYZj7PrrCSr3AOHTzVpvCwJXSKJlKi62LxRw6yIq5rRZ
18Sqe8t6v4eX5CNOPvlZPBLYnbyW9AxUslhF/qWTzRIy7Vd/urwRY68tbKsnvMvT
7dmjmPPOxurq2kirYBGBYdATN6LhIN22OVctFghT10c2ddrwyhnxHtwJbQLGNXcO
QrHzgkFyabWQlVkQOuG25CBE/d0M7+gtPJmIx+zun63GTvd8m53GZoKkGc8dIDqe
pLug/kVCbkxtffVovWXSgriu6KQnGa6jTo95l85trYbXbGW9+DAGdmSR5N6HgLb6
mBi3stwpDgOFq86r+paMyDhZVwfNLh6z0zLf+obEP1W9j3aL8KNx4txUzR7RoKFk
PizGKPz9E2iQWc/VBsnKa65Of1EwylK0hefiYjM+jTt8zFthT8RG1JXX5CxjeVYF
UJUUbH9tF+76AsSx4w06kRaiG1kS6bZ9aFhspyZcXYUTBbb2ua19gPsSdg5JAZ8K
AZraphreKpc=
=69Q7
-----END PGP SIGNATURE-----

--==_Exmh_1582701983_403032P--
