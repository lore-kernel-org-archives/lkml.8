Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC202C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C098820B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFElbCjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgFZVWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:22:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F45C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:22:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so5148995pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPaM2QLp1Lnyo/tFOjZRrBK9GEiSK4tLpveqTF1QTWw=;
        b=TFElbCjpLxOIFHGP0g+klWMfLi0l2Mun3MxomGTHA0v9jh/9cfSmaHKqFtA4RT6jRm
         4xzaHn3a057w+xMpnbwSdQNls0bvhcqTTFxuifRkxMCIho8BIk5JWH0r+EJJml6d8S5N
         IsXJvYxj2SL3HF4o5D1uBwhALv9jY3C3tWulumPnGm8T4x7r1RmHVZS5Ug2DclvsP0xR
         sFOIwsCxvF6aV1Nj1SOAJunuK7BRTUwezp0PPzwRLdniCcRaiK5RCcSn7cJhUKWnHoFm
         wpmGYvCAqzTEprPMaK7A1ERbYa7IUuNMzW2ZkRudy2BcDJa9pWbc0YGeu0tzrYO4kW1e
         IXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPaM2QLp1Lnyo/tFOjZRrBK9GEiSK4tLpveqTF1QTWw=;
        b=CLOn9mMUap5hgbR1w3XLU8K3ilsv0zutpL+4nNPdPujCDOmkosKpmACtXSJNGAOxVH
         T0Txz+rAfAaqetT+FcNg0lv/xDM4KBlYmaXBwnd6nd0s8bEWaLGimfnibfxna0cNaeSz
         6Bjav8o3sfAgbCiD2EfeDntjK+C12cIqenRrb3dRWwFUCilD174j2OgiSAEFgAF6vigD
         10inE7z73KBS4G/ooKbtS1nrKQzkUF1Yq3LYysMqrKv8xKmRNsbrdKejNq1YeW6mu5dw
         POtCqg1MQUT+eEhU+wrS7Dj0sfaCr9F1ycFotcDIAz6LoInS4PYnLblsUNIy3GUiqGLu
         qufw==
X-Gm-Message-State: AOAM533Pdy4Q2P8sF0EM7siKZz3c7sSUBSgSh4bOm1q3PvYfgCu2y/m6
        UrDW+ijkHX/YmCWzWYAPaG64ZqOKVtsQbJmy3nL8Ag==
X-Google-Smtp-Source: ABdhPJxiKEYutNObsmIBYphNH4Rjrm9h5SZbvVD0vbhM3XAclfw4B+ryQw8//QlKHbH2sO6uKDOQuVwPIVH3OMEUjA0=
X-Received: by 2002:a63:d501:: with SMTP id c1mr631501pgg.159.1593206542565;
 Fri, 26 Jun 2020 14:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com> <202006261416.F4EAAE47E3@keescook>
In-Reply-To: <202006261416.F4EAAE47E3@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Jun 2020 14:22:11 -0700
Message-ID: <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit test suites
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, monstr@monstr.eu,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> > Add a linker section where KUnit can put references to its test suites.
> > This patch is the first step in transitioning to dispatching all KUnit
> > tests from a centralized executor rather than having each as its own
> > separate late_initcall.
> >
> > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7d..4f9b036fc9616 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -881,6 +881,13 @@
> >               KEEP(*(.con_initcall.init))                             \
> >               __con_initcall_end = .;
> >
> > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
>
> Nit on naming:
>
> > +#define KUNIT_TEST_SUITES                                            \
>
> I would call this KUNIT_TABLE to maintain the same names as other things
> of this nature.
>
> > +             . = ALIGN(8);                                           \
> > +             __kunit_suites_start = .;                               \
> > +             KEEP(*(.kunit_test_suites))                             \
> > +             __kunit_suites_end = .;
> > +
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  #define INIT_RAM_FS                                                  \
> >       . = ALIGN(4);                                                   \
> > @@ -1056,6 +1063,7 @@
> >               INIT_CALLS                                              \
> >               CON_INITCALL                                            \
> >               INIT_RAM_FS                                             \
> > +             KUNIT_TEST_SUITES                                       \
> >       }
>
> Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
> architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
> uses INIT_DATA.

Oh, maybe that would eliminate the need for the other linkerscript
patches? That would be nice.

Alright, will fix.
