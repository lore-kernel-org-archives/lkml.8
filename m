Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87CA2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGRJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:14:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgGRJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:14:10 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N0F9t-1kjr9k2unf-00xI7j for <linux-kernel@vger.kernel.org>; Sat, 18 Jul
 2020 11:14:07 +0200
Received: by mail-qk1-f180.google.com with SMTP id b185so10992021qkg.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:14:07 -0700 (PDT)
X-Gm-Message-State: AOAM5321a/2r8aJtkLcvLZ39YWucxXyzESGS32NAr+b/LJvr4qVG5Wqn
        cwPeYJfMYL5KlicDXYcOfItpM2HCssictb18Idg=
X-Google-Smtp-Source: ABdhPJxwe+rAXwuvo5qNMMmdZVywOMqejAp891L6qgqpIBl7oiKJsK6nUyLJwXrhbK4R1O2B1G5OJHYrTQLcWCrrZmc=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr12589219qko.138.1595063646520;
 Sat, 18 Jul 2020 02:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624035920.835571-1-natechancellor@gmail.com>
 <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org> <CAKwvOd=5nE6fkwp8iw0JqwQFp5KcUaC7RyEf2L6+tkbp9smsvg@mail.gmail.com>
In-Reply-To: <CAKwvOd=5nE6fkwp8iw0JqwQFp5KcUaC7RyEf2L6+tkbp9smsvg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Jul 2020 11:13:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JjQCB9HdRE6chvA5ekOGWUVpSDdPkgqQ+RGz=y06ong@mail.gmail.com>
Message-ID: <CAK8P3a1JjQCB9HdRE6chvA5ekOGWUVpSDdPkgqQ+RGz=y06ong@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZNDyoXfM9nSFTM+fJ1104zZS881vGPIyhKtH1wdgdVM7KQYjPMR
 t4vvxVCorLCuWcC5dUZ7AHuwO2tS/XrgpG4uWZg/U6gqKrnOUZ5MTL4t5CZpJR8xG9FmTRJ
 +Z5HX3QPgxnmP7DXNzXUrklXgIsAZdwtVJMWock/hKOxUTWkyr/VdQilTkyoeXSjyfnN96g
 uAOEO83PLuwxd3CLVxzmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B+RHoLKUfkk=:QRbFY4KCXidUn+mS50TbyO
 6bZulDVTAbyh14Fn6K8UMWTDaR4fNb5iQQuT6+Bgz/3qYHZ0LDl9Ooc4U/duBabXHxUrrYLZp
 GBkq8moqxrcNaF8Huo17Ge44NEymXRWiHWrLJ+QV2ruh6kG5h0ZdDrgqxWSgipjupmhRFKjog
 W+Vc4jlsfZiZ2PfGF4iqesRnRmleyRHWTKrR10I7/XOT1GrlS+OHGqf08YJQGppGVQlT4NIpK
 IsfmZGL6DFoSAmm5vqEjZNhaMWWvWBy1bGACgu2ow2DhNv1TGn8lRS0JXDEb6jck8AFO2s2yO
 MGqVmpuE9MxBzpel44eXnUXxkz35Ptu7uwIABLBO0Z4tD7FcrHSNxsUQ70Mp8M9cqGdulwcI1
 5ict4le0SRytQMSmPQM/w8baEQ7ulU/m6EIQZt5IoPGKSkoGvniBKI0QBcA22PfI+NFT+tAa3
 YHfRUcSu5PUVP1wv2Qqk4YlGMYOaaCtzQgoPrmvMc7eeSGZ1AA0VcKaOeQpczonKcc+XKJNWR
 wfwCGTCl0UxVhfcnoCpF0zrAvawTKBhAjPH8EwG5eCW2N4lSo54WxvjKWj5M5xLyNYYTZJdSP
 gdFSaL6XB7exQa91QauzN1CgrBIBaVZUObPJPSVjgAMXctDmVCxeQNu8D8FGRcLeP/Rmtz+KU
 HGFZeXf/m0uKoyX3RC7tUBCdN9M0kx64gE5qgR3PtWd2fekPNngl9qHrmx/yx3lA8PZh/Uj8T
 DXiGioEzdRWdEvHOTRzKu0VPPtXz1YTvzaIdb3LJicSEDTa34P25wWvnoXK2963NJQwm/pcDy
 CrTiec4iRZiUOMp4g2QeGwXSZz9X0F3ax+yI1elqzEHa6cU+t60eeXqctxqQT/1JuXXdXULDf
 La9f/9ZktEkowwUjUYaDIedLsyL4lOHnIadFaYSMXNdjmN8j+OzdGHK7BpZvrYFYOe9AWylRu
 hauIwSQrw0NQcaUpWJOFR2PHGGupY3FGN8IjJs/5PeWZAbMgpGBup
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:32 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Jun 24, 2020 at 6:19 PM Geoff Levand <geoff@infradead.org> wrote:
> >
> > Hi Nathan,
> >
> > On 6/23/20 8:59 PM, Nathan Chancellor wrote:
> > > These are not true arrays, they are linker defined symbols, which are
> > > just addresses.  Using the address of operator silences the warning
> > > and does not change the resulting assembly with either clang/ld.lld
> > > or gcc/ld (tested with diff + objdump -Dr).
> >
> > Thanks for your patch.  I tested this patch applied to v5.8-rc2 on a
> > PS3 and it seems OK.
>
> PS3?  Folks still have ones that can boot Linux?  Those ****ers took
> my Yellow Dog Linux away from me; I enjoyed depositing that settlement
> check!  Hopefully by now, folks have figured out how to roll back the
> system firmware?

I still have the PS3 from Hong Kong with original 1.5 (IIRC) firmware
that I demoed at LCA2006. Haven't booted it in at least 12 years, and
never used it for games or movies other than the free "Casino Royale"
they sent everyone.

      Arnd
