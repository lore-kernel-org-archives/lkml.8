Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E051C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F15420720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBFE0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:26:53 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43456 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbgBFE0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:26:53 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0164Qqkr020022
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 23:26:52 -0500
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0164Qlvj019247
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 23:26:52 -0500
Received: by mail-yw1-f72.google.com with SMTP id q130so6425548ywh.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 20:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=MhCySqbOzzfn5gIyvxr/SnYTBS2T8s0EdVrXnFr8wHk=;
        b=r48ovKoORmIfO7RUYGENTxxrE/vpujYE6vMNv0zYz3q5RZ9ub84aDAjztWOK0BxAPI
         5tImWNtRPq/gKiFVHXN/oLkY14JojdWqdLmud8s+gQV7LsooxKUqWjM5bVUR+9TLX/K6
         VgrPUt9OeEAb5DDQy4jAR3ANQlHp09KCnykBPNRMYkO+1q9PN/iWhdco3FTPq6vUFjOl
         AdogPrbX7N8tDye0bl1eHONURF79lQuIKQRhEoOiFQr/KM17/qRGc3kHJkz8DqeGadHH
         Ren3HnnEwDs40newSXbukzkPxos0qSlKtZuUi1dWJ3R6CkoypOlNqBgBH/nVs2ypRbZx
         Grqw==
X-Gm-Message-State: APjAAAUPvVISdDtrOTQQAaNzwZsRqIA4rqBknfE4/lztcPHpeTK2JGQE
        ss63EmrcFZbzaadWmFsnjqD9W1r7kckelGnzCAr30ZJ7k75gqM7wuQxvaxlWXAHIBBNqk/3ZF82
        FNmu2dTTRIHsnXvIfQxW4c50b4yzQM4ykjFc=
X-Received: by 2002:a25:7713:: with SMTP id s19mr1360969ybc.449.1580963206395;
        Wed, 05 Feb 2020 20:26:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxymezFocNbnfWO28lRZigLgbo3T6tK34wy9pWSSpfu/W+BaYL8P42JOV1GwcRaOnIqxE5k+g==
X-Received: by 2002:a25:7713:: with SMTP id s19mr1360944ybc.449.1580963206022;
        Wed, 05 Feb 2020 20:26:46 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id h23sm900349ywc.105.2020.02.05.20.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 20:26:43 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Namjae Jeon" <namjae.jeon@samsung.com>
Cc:     "'Namjae Jeon'" <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
        "'Christoph Hellwig'" <hch@lst.de>
Subject: Re: [PATCH] exfat: update file system parameter handling
In-Reply-To: <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
References: <297144.1580786668@turing-police> <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com> <20200204060654.GB31675@lst.de>
 <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1580963201_12134P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 23:26:42 -0500
Message-ID: <252365.1580963202@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1580963201_12134P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Feb 2020 15:53:38 +0900, "Namjae Jeon" said:
> > > Al Viro recently reworked the way file system parameters are handled
> > > Update super.c to work with it in linux-next 20200203.

> Acked-by: Namjae Jeon <namjae.jeon@samsung.com>
>
> If I need to make v14 patch series for this, Let me know it.

Hmm... That's a process/git question that somebody else (probably Al Viro) will
have to answer.

fs/exfat/super.c won't compile on next-20200203 or later without the patch, and
as a practical matter the version that finally goes into the main tree will need the patch.

On the one hand, the proper way to track the history of that patch would be to
cherry-pick it into the proper spot in your patch series, right after the
commit that adds super.c.  Then the git history reflects what code came from
where.

On the other hand, it leaves a really small window where a git bisect can land
exactly on the commit that adds the unpatched version of super.c and fail to
buiild.  If all the Signed-off-by's were from one person, the obvious answer is
to fold the fix into the commit that adds super.c - but that loses the git
history.

So I'm going to dodge the question by saying "What would Al Viro do?" :)





--==_Exmh_1580963201_12134P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXjuVgQdmEQWDXROgAQLHsBAAmBcnkD/ko40Nc45jXotKjplQwdbXeZvZ
5wO8GdAbkF8TCLMZOSIwi+cXoEtTH4TFSP+SYoyHfyMMvmn68HHnXGqO0IU312Qx
6lU/p3EmSlV9kxArZAK49+g3RhCwyckdhmULMFf2mvhgAfBg7ViNYv9wezoQP9xT
Ja013jCCuZ5tInt2Dt0QQCmAlJjHY1/YYH4RaZQ7hpbweY6OK516JgJyjG2ZOEP0
4VOpTRk7qEFyV/4ew9/HYU7t0h7pm0xdQ8JrIJ4Dva4hdU+LMqkWW8Fe/ISoktni
FqZ1wLrPUWMLV/ph0+XDo82biVnkZZOKAbIyk6c7ZXRMvzANiwFdLejCAIptEGld
8ra5N/2pw9zC0Cwk8xTGbg6Hj9r3oxAiV230Vj85cVolntFoKTh0i9PcownPAIZh
NFq8h0Xuviha7s0EJHCFP82EkHr48bYWVYy6plj8LaFce96aRjT4m5FaK3SINeXB
yYAhSqn0Y7tQa47+4l4oNw/M+I+awGys6w3jq0Dm1Dkh2//kkkPU2QFZJ7n/DM2E
H92K9LqP79XUJpLv7HFLu6+Eq59tSK+w51qBQOirCGR1YkcAxKyWy3cLgSQfXs0o
oWSQgZ/+1qK9VP0zXjbeJpgAZKif+HIhr6EotXxBhgThcryezKOgFQGshV3gM1gD
pftiBKef1ks=
=1wFm
-----END PGP SIGNATURE-----

--==_Exmh_1580963201_12134P--
