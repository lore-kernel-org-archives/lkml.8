Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E60C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61B924692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJLZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:25:05 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51150 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgCJLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:25:04 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 02ABP3Pu032270
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:25:03 -0400
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 02ABOwOT010833
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:25:03 -0400
Received: by mail-qv1-f71.google.com with SMTP id o10so8877416qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=OesXhfFfB1ZZgxnRfuwwLM+t7VkmSIoWuSuAcfzfaQ8=;
        b=dCZbYLbquuVk5/ZFppDzrETygoVy3jGZ6CPKHNclKR7C3jw2V4zUxcQFwVO5Zi3FuS
         UUNcGkzqrItSiMyM1ZY4hEuovR537qulZwmwOSc0JbmlF+cgfVEh+M+Y6XBv2qs1K1uw
         +PTeAAVDxY8BXU1zO/92kOKjxEWxAsMqKnkbpy+0L1NIemp8UyTH1K278Zhf1cntce8O
         QeI7Ukdw903H3H+vob7sBE7PI5oOYHwNljlO/LQ7UGT90NB/xhbQZhUUmGPu99ZZF2Pi
         EnWImIGEmENwaQjYSUsQf/e8Yx3/jgiZDYMzyxZVVgWefpTrCeuvbLPRUKAt4/5ZYxj9
         OvjA==
X-Gm-Message-State: ANhLgQ2PH9GjgUaBBvB2YU9AQfYedUjA1pbJJQFJOVaVJP3h7V+GQObg
        Fn2WzsENPXYrMROfpjx+E59JwzpkIqOQOxa64VymHUMSHGPzR4ziuOjQ/FUbVjPbYzJrJ+mjBdp
        pFlT9DhES7FXhYdi+UTe/rRh4ZAe0etpWuxM=
X-Received: by 2002:a05:6214:60d:: with SMTP id z13mr5971526qvw.183.1583839142739;
        Tue, 10 Mar 2020 04:19:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vto9Cc/inOPkYfcSZLmhvSxM16DJD9Z9E7y4/q01ZrjcE60oTAT3RepCU3XjTs472qHoHtnOQ==
X-Received: by 2002:a05:6214:60d:: with SMTP id z13mr5971506qvw.183.1583839142428;
        Tue, 10 Mar 2020 04:19:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w2sm23859201qto.73.2020.03.10.04.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:19:00 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "'Linux Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] staging: exfat: remove staging version of exfat filesystem
In-Reply-To: <20200310105421.GA2810679@kroah.com>
References: <20200310105421.GA2810679@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1583839139_13328P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 07:18:59 -0400
Message-ID: <35151.1583839139@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1583839139_13328P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2020 11:54:21 +0100, Greg Kroah-Hartman said:
> Now that there is a =22real=22 solution for exfat in the vfs tree queue=
d up
> to be merged in 5.7-rc1 the =22old=22 exfat code in staging can be remo=
ved.
>
> Many thanks to Valdis for doing the work to get this into the tree in
> the first place, it was greatly appreciated.
>
> Cc: Valdis Kletnieks <valdis.kletnieks=40vt.edu>

You can stick my Acked-by: on that. :)

And thanks to Namjae Jeon for graciously offering to take it off my hands=

by providing a better version, and to all the people at Linux Foundation
and Microsoft who did a lot of behind the scenes work to make it happen..=
.

--==_Exmh_1583839139_13328P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXmd3owdmEQWDXROgAQIhLhAAkEefL8MqDbPRHTLSuvJEcgA0wOk3+Y5q
NaIlQZ3VNZQkIguUEEKq4Ic+mpBl9+r8rWIbJiDWYe2gZRq+b4BFi8Dlc9T46yst
rW9YWLIGLsVwnCjvVRyZRO/S+6oSzFh6yTdkxQIBBOmWhhITLvIKoJozoSFTOwwn
I0G97lwb9++mH2r9n87/3NHOfTyUB061TU3l5/fk/a3bpWWYrR+NXEuEli8QGukl
eDwRMUvegpPBt/iPN7PTznuwbVKSYigB17Wopr+gAEnS3rZ2YeG2lkQFe7vnoevl
6FNTcq2W5hJU2Jrb2eAuKMrW4LVg2rSis8jHmM7Eeoi/Pkyko/Cdfw1TD5L0Uqc/
QYnofVkQrni42j8gCSTTHvzeag+rjmeSK/YEsjyYzVGnK3Hc+27mmMoHYTYQo7JI
k2r4nZCZINc67E/DeBb1hWEnlbjdfeKwQLrW5qAm/x9jumGPto+nfqyaNHKwfmW1
OMq9FCU+7HW9lG/FZHbOY/l0+yMlBeg3fM5YmiC0+aotmHPZiQoVMYDOThdG0ukc
z91DNBW2rsqmrfc83U8nxnNxfnYyfWuNJ03IuLIhRY6BsrsUXLKZiFRQUPjGAs7i
u+oBYngj9OUyw58ks8S5KYgoFZbqe1oWKBQ+fiXXKXqRt4CbagiSOeYcaVQPcctT
Sy9zO5MRsa0=
=l13Y
-----END PGP SIGNATURE-----

--==_Exmh_1583839139_13328P--
