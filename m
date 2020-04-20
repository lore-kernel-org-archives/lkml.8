Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD4C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C282C2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjvBif89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTJMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:12:40 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5DC061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:12:38 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i22so3324204uak.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D5DA0AVUZZnTAM/ihh6DaspZ07iKnTCzkRsZBNpa07A=;
        b=SjvBif89YfnXbxd7GMu3X4fKAtX67zD5cErAA7NiHKnyJkwnzfakr8aAAIV61e7w9Z
         ERxCnvn1GrcWslAHcKeTA7asLTGzhcPZ4nCZNkGFF3JyR/VNAj2ernqKXumLcTEye6wA
         5SgUPv/JoDvH1m4NcP+Tslfp4zsn+Obm0yQiberdVeuXLYZWbl1NWoPR49/rhM5mjE+b
         0RoHnM7I1IduNjfr/cv888TzQ/f6uMb243BTOHRcgl9qtoF6nI/bqXjh51XjKq/7u2Dm
         CDBEcI6SlHjjIiJVRhktMVjX8H3BOhlaOv+wBHBtjhcLKXL/QUgmCAXg8gw1lTMaBaKl
         Pfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D5DA0AVUZZnTAM/ihh6DaspZ07iKnTCzkRsZBNpa07A=;
        b=OGSyU91HJcEl/6Cu/GSOkWVqnX2noya7MV4kK5INDPvoHgjfVq4CMiTsz1WUYYBwvr
         JHtL734MzUM10Vo9XXaAnGnkZf+1HicvF8o5W2Jd6wMRzjk6tyPeBui+V5MxOMmROzj2
         OhJGxoTzz0eNp00Hm/4n9i7NK7R01rxwCVcrfuex1wBFMmWHp0vcYZGyQMEHIxiNe/FQ
         W77isI0VaMAz/OKqQXBcw+pzC52mrvgEjIXSJmPo4G+qwe8dQ/Kd5crHuQinqHTmtNGG
         bvx0GSPi6fcN9Duce/O4QxrFBHGuTY+8H7cXMTNEcLmuefHy4pqUG9m4ScMy+e5Elzfb
         FuJQ==
X-Gm-Message-State: AGi0PuYvOniTtGx8dEYpcByQb1JS8zvGJXOrMpQEC0V85tU9vlQFEmD6
        EmRaCKTshgZzPW1P8CoHvsT7P7cGhEVIjF7KAuwZhA==
X-Google-Smtp-Source: APiQypLZ6PMekSmOqs+25OFvhsfT/B2tJOUATSybOBWpLf9Vtag2Vy3uH6+F6Ux4iwrWqEhjf4LFpwze/AE3L9GCJ8s=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr6973297uaa.15.1587373957934;
 Mon, 20 Apr 2020 02:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200417145017.3932443d@canb.auug.org.au> <995a958c-15a1-cb05-e276-065c7f6e57fd@infradead.org>
In-Reply-To: <995a958c-15a1-cb05-e276-065c7f6e57fd@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 11:12:02 +0200
Message-ID: <CAPDyKFqE7zfaKSbpBoBbrSCEnx+70dOrWs+=QG_x2G-Fpt6=ng@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 17 (mmc/host/sdhci-of-at91.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Masahiro Yamada, Adrian Hunter

On Fri, 17 Apr 2020 at 16:48, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/16/20 9:50 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200416:
> >
>
> on i386:
>
>   CC      drivers/mmc/host/sdhci-of-at91.o
> In file included from ../include/linux/build_bug.h:5:0,
>                  from ../include/linux/bitfield.h:10,
>                  from ../drivers/mmc/host/sdhci-of-at91.c:9:
> ../drivers/mmc/host/sdhci-of-at91.c: In function =E2=80=98sdhci_at91_set_=
clks_presets=E2=80=99:
> ../include/linux/compiler.h:394:38: error: call to =E2=80=98__compiletime=
_assert_63=E2=80=99 declared with attribute error: FIELD_PREP: value too la=
rge for the field
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ../include/linux/compiler.h:375:4: note: in definition of macro =E2=80=98=
__compiletime_assert=E2=80=99
>     prefix ## suffix();    \
>     ^~~~~~
> ../include/linux/compiler.h:394:2: note: in expansion of macro =E2=80=98_=
compiletime_assert=E2=80=99
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98=
compiletime_assert=E2=80=99
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/bitfield.h:49:3: note: in expansion of macro =E2=80=98BU=
ILD_BUG_ON_MSG=E2=80=99
>    BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>    ^~~~~~~~~~~~~~~~
> ../include/linux/bitfield.h:94:3: note: in expansion of macro =E2=80=98__=
BF_FIELD_CHECK=E2=80=99
>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>    ^~~~~~~~~~~~~~~~
> ../drivers/mmc/host/sdhci-of-at91.c:185:11: note: in expansion of macro =
=E2=80=98FIELD_PREP=E2=80=99
>   caps1 |=3D FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
>            ^~~~~~~~~~
>
>
> Full randconfig file is attached.
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for reporting! I have looped in the relevant people, let's see
how we move forward with this.

I assume the offending commit is this one:
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Apr 8 16:21:05 2020 +0900
mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks

Kind regards
Uffe
