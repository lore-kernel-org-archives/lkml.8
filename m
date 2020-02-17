Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DAC7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F313F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBQBlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:41:31 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45982 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbgBQBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:41:31 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01H1fTib013352
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 20:41:29 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01H1fOjX016074
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 20:41:29 -0500
Received: by mail-qk1-f199.google.com with SMTP id w126so5469509qkb.23
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 17:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sv2ceZp1op4PModOTmniGKJ7V5g03pJcc68F5eGW640=;
        b=J5aStqLytn/d7PfNgO4BTn0OEuwvQ89V6xECvaIa8x/LPT6PYZcYADoNFbEDLrw/NV
         a/Q5NzHMyepNonKR5aCLJ2E1/KcOv8+jRlc0tOiAIqeEu9wnsIdtlH80rSRl7RS6TVlA
         28tg+9cfu0TkFqkNZFdAVBHRoy7mDZsl03eihF2fN26prdZXFUWchT18C9jI0g4D+y/v
         XBAeQlgflaEXaKerEJhKl7GOBbMbAb4h/qQ6kkHudrrXrnwO6Eig36kPmXxwMix/b86S
         IFu3ERYdikFj00SHk1T6fioXcqQgQY3acuku3+3lhhe27z7ktDOfDN9mzLRdR4X58QJg
         wTuQ==
X-Gm-Message-State: APjAAAWG3i0gMyMF+d9YZo1MkOgcPtATZasaSZfprLKkF9pB/5QB1NxP
        4fti4T7QLskRxk3UQuShgZpT+bBVEuAjTP+aWaBeskauQjn1V2HHe+bEl1ZBRWfhHxK2DPFaJIA
        9FE7OQOBfWuZAt4DpwqldISIWgK6pNCK7WCA=
X-Received: by 2002:a37:a5cc:: with SMTP id o195mr12277346qke.25.1581903684498;
        Sun, 16 Feb 2020 17:41:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7bWoxPayu8kgU2Bhg/GlzNU2d7s9SpWB7AsfKmq7sORME7CHUPB+YiVTvKi5yRIFYIJPPrA==
X-Received: by 2002:a37:a5cc:: with SMTP id o195mr12277322qke.25.1581903684177;
        Sun, 16 Feb 2020 17:41:24 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o19sm7721193qkh.135.2020.02.16.17.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 17:41:22 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Namjae Jeon" <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
        "'Namjae Jeon'" <linkinjeon@gmail.com>,
        "'Sasha Levin'" <sashal@kernel.org>
Subject: Re: [PATCH] exfat: tighten down num_fats check
In-Reply-To: <001b01d5e52a$7f029340$7d07b9c0$@samsung.com>
References: <CGME20200214232853epcas1p241e47cdc4e0b9b5c603cc6eaa6182360@epcas1p2.samsung.com> <89603.1581722921@turing-police>
 <001b01d5e52a$7f029340$7d07b9c0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1581903681_14173P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 16 Feb 2020 20:41:21 -0500
Message-ID: <83075.1581903681@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1581903681_14173P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Feb 2020 09:37:55 +0900, "Namjae Jeon" said:

> Could you please update error message for the reason why num_fats is allowed
> only 1?

Sure.. No problem..

> >  		ret = -EINVAL;
> >  		goto free_bh;
> Let's remove exfat_mirror_bh(), FAT2_start_sector variable and the below
> related codes together.
>
> sbi->FAT2_start_sector = p_bpb->bsx.num_fats == 1 ?
>                 sbi->FAT1_start_sector :
>                         sbi->FAT1_start_sector + sbi->num_FAT_sectors;

You might want to hold off on that part for a bit - I've asked Sasha Levin for
input on what exactly Windows does with this, and Pali has a not-obviously-wrong
suggestion on using the second FAT table.  The code tracking FAT2_start_sector
looks OK - what would be missing is doing a similar versioning on the FAT
the rest of the code references.

We may end up heaving that code over the side in the end, but let's make
sure we're doing it with more information in hand....


--==_Exmh_1581903681_14173P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXknvQAdmEQWDXROgAQLx9hAArGcsQ4heaHoCkYlLQykrtoFHMf3RgBv1
1SxDyx4wEynQMiX7+x3wmRD7Gq4QGEfQSmBBMwEDaPNtbSpFnFwIyJapareTl1zU
+r+ulf5h2/6Kbeglly89Kn+6HcH0aZ5QktqtLkgohr7x4MfZ16Tr6qCQP9w8Aovt
16hob7ql94iygjTppeE6F99tTQBY7oRHTJGuwB17RsoOrSM6XXuAb/8HKhTOjXW8
RsyxYBw4R8RNlu/qjmYqs9kk3tXJX3Vc1lG2JVMZQnSIe/Yp1nx4c79OPGPuhGqG
iKLmgOz8jiG74hOCykFctZDfoNX0CJpvRfmBRz4WkYcu1MwFxW/7LN7PJROM5Ixr
JQG32p0lzDqm7fxvUzvE+5sw+E5M5ioigPfSTfOI683QJ/kUaUOy9de/90Um8g3v
lyYKu3MdWOq5Zqtz/aBT7/BTI0FK0QjMbu+jYSXm8oDoTx6adeJEytGFpG/D2asA
B95CfG3Rh14EPxCWfXp9i+7nQ/mtHlN7qtEPHumxaHFgJXK3Irvj5P5qLRw6mQG2
PH1bLCUrbX1SF8mroSho364cdQ8J/j3vLwE2HltcXaLk+cPuKkaZbbYB3iwWYkB9
zws0G+WKsVXBPVOoeFkWfaHCGFT/7xvAY2zNM1MbPLQXG5KrZa+DIlnYRCFfbUVG
Snmb2rUl6oY=
=SS6+
-----END PGP SIGNATURE-----

--==_Exmh_1581903681_14173P--
