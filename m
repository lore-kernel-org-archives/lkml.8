Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE942465E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCCDj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:39:29 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37402 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgCCDj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:39:29 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0233dRo2013830
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 22:39:27 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0233dM5b003761
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 22:39:27 -0500
Received: by mail-qt1-f199.google.com with SMTP id p12so1360736qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 19:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=FTbJOMePSTPFZUgojgxvDoh7xnLDmsFnL2EoLai2PSI=;
        b=FBLY9/WeC6O7JV8DSpx35cFpjlX4xCHtQkriprkCNmDj18khsX8GQEdo8Kt7n7TgBd
         roNt1qvYGoZjW+KFY4mMjLG0FdULpkQZEo8hMrciDqjv+ZiysgtFJhbji6hsQA0zUS+D
         yE86GZrFAvhgPTyVO79FQfFi8VNKDTFdWgTWRM2ZrxSualtt4r3bLcWjQ/lPxFlXpHfj
         ObFBiKNl1Tz1PLmaFtAqJXhcz1QwckEAY0jQPEB6/tnQiSQYwkqvWcGLxYw9YkXKD3fh
         bhv/lgJrGso/WmqPyGqiHeVj7bdXsmRaIC1vgAarq4QOD3fTWasbSvJdjlUg11aCQGZ3
         4xyA==
X-Gm-Message-State: ANhLgQ2zSGNrSsb9sPA486kUPYiiO4urzLh2R7EWKpNYu/YwoYno6t+A
        VUCiEBiVJpE88siE1TCjJwStx+AFE9cIvsj8pAoiigm/p+M+4m+MWyv1cbZPcIxMvp2HCBYjm+i
        8Rj5Km2y7b8cqxGg7gv2NYUogvDrDaDBZptk=
X-Received: by 2002:a37:a7d2:: with SMTP id q201mr2452445qke.144.1583206762106;
        Mon, 02 Mar 2020 19:39:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvwQMeMav5A4bTYMSAhdKnSSxWMCEzktF52MG9KJML2CW3SBd0QJ/NKuQgC8ICg1bjcB7PuLg==
X-Received: by 2002:a37:a7d2:: with SMTP id q201mr2452435qke.144.1583206761795;
        Mon, 02 Mar 2020 19:39:21 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w13sm4637470qtn.83.2020.03.02.19.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 19:39:20 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: exfat: clean up d_entry rebuilding.
In-Reply-To: <TY1PR01MB1578983D124E99FB66FB707190E40@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp> <240472.1583144994@turing-police>
 <TY1PR01MB1578983D124E99FB66FB707190E40@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1583206759_2391P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 22:39:19 -0500
Message-ID: <295313.1583206759@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1583206759_2391P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Mar 2020 03:07:51 +0000, "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" said:

> > Are you sure this is OK to do? exfat_get_entry_type() does a lot of
> > mapping between values, using a file_dentry_t->type, while
> > fid->type is a file_id_t->type.

> The value that vfs sets to the old_dentry of exfat_rename() is the dentry value returned by exfat_lookup(), exfat_create(), and create_dir().
> In each function, the value of dentry->fid is initialized to fid->type at create_file(), ffsLookupFile(), and create_dir().
>
>  * create_file() <- ffsCreateFile() <-exfat_create()
>  * ffsLookupFile() <- exfat_find() <-exfat_lookup()
>  * exfat_mkdir() <- ffsCreateDir() <-create_dir()
>
> > and at first read it's not obvious to
> > me whether type is guaranteed to have the correct value already.
>
> A valid value is set in fid->type for all paths.
> What do you think?

OK, that's the part I was worried about, but I hadn't had enough caffeine
to do that analysis.  Thanks.

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>


--==_Exmh_1583206759_2391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXl3RZgdmEQWDXROgAQIYeRAAkZo7uu42LhGq9PsreYrqUXNm0xB/XGj6
NZAvcAtGjsf20gasBoa0nkBE+yxBisOxu2z25nTVC6blNonyQPjBWf8S5iQVb5gd
vmC/yboWHfQHRXhPmOSod8FK1FjrqnAKV/+EBcHvcRcpqR3BJpBN89pckVAuFVKj
N5WJ+Guyaqhm8pNdllTla8uL5TvvpH3BOu9+y7l4vAgkJvkfjM3crScCXAlpxzmY
EBx4NL8RSvUuhcE4PTszpYebplIe8FmfmVGBb2YoOMVchKS72swX0ME7vy2KdaoE
7ZvAggB02ZuqSucoZonDTqrK5jLYcl7xbQBWfuBlQN10mi+wxL66HcKmsehLjjlS
q/qJWiE7cHjSPz+3cIVWqogYazOHF0j8clQGRbTPgo/SDBca/pAVlHOck80HCGTl
5YQWWBehNiqNC5UAODnQz4e0/RmORnecgq62NLaMgjUo6BoxgW5SEJxPJFpriACH
NwjVHB4km/xJwOSulIOIsMki59GoXSyaBtRVPYGV/ZqenE2rCBn9TYY1JKoLtXKQ
OLDnkSmN4VOxBh6RPZWNZ5hKDdbZ0TpyoqmpM+jxm6t2IvGG11ZZcgFWB31ZrD4d
dD1oX7QNpXu6CxAFWzBEk6sIGIdFNGHQ1NdMQYXTF/9Zhis0zufS/tmTtAhtNylk
qgb07J+8a1I=
=keUw
-----END PGP SIGNATURE-----

--==_Exmh_1583206759_2391P--
