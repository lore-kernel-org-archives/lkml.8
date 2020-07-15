Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352D7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059FB206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="oGkOsNf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgGOJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGOJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:30:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:30:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so4653955wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHTUG9VUsmLnML1iGH81GRFP7EhnvJ9XvrLm4g/82Vs=;
        b=oGkOsNf+DwvPXJ5x6foT8Ejrf9SYCy8hB95xWG104jbbRMOSn87hHy9i4Ka/o8dMWH
         /+bj1yb+c6C9TNZoa84VVfEm2Fj0Mvw+GW3Hlr2oUkIeZnpzdZDZLU9WaVCoYIGmyoyv
         h+9GwqamlZeYMQDTIZcLQmwNbHvZASNlDJFq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHTUG9VUsmLnML1iGH81GRFP7EhnvJ9XvrLm4g/82Vs=;
        b=adFyoaKtkqe4lVgOWd6QocC0d6gM1zyGG4fW1nSUTRf1cdgn4vizUBx+zWhoPSzJeq
         mf6kUPySWHTfErrRkYIRlzGv5KfL073PqavEwh75Q2dNAORfF/roGFkB2qoC2di2GcEx
         tAVjBOzF8iIjipreD0sdVRsV3I0FPv0tIcBvrkVOVcfUYwVcQLv9vZJOEaZWcMX+sKee
         0S//AyqdTmsdpqdEV0zb2FNZCTBLwZD2sQrssu5dboOcFJefJcylT8uSn1vhCpxf+7AN
         FdMoYUUYWe6oaii0o/OWKpvnOJYlqgrlFGSzN+qG/ammZ7vpkcdgBJDkXJ2FFyNJgvlm
         kmuA==
X-Gm-Message-State: AOAM530qCHzJc/VWymN5TSai5Z+4Bgdfi0KRybUNJm+HFA28aQgai+bL
        o9NcusbhN8lgpmrtpW/AQofufbgf/6wV0fLGhQm1vjj9KQI=
X-Google-Smtp-Source: ABdhPJySV85zpcSQqM5oPLH1ojpplvF14JeidSYEyeSqhief7CU4xpIJBpeJXCIE/2TwwiXXYQCQCA8MR02KalDFxvc=
X-Received: by 2002:a1c:d8:: with SMTP id 207mr7486300wma.81.1594805412057;
 Wed, 15 Jul 2020 02:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com> <20200704085213.444645-4-ignat@cloudflare.com>
 <CAFd5g44Hxhxjqb6WkfaMtaTDKVhs0onnkRaQ0Aq55z6oYTbJbA@mail.gmail.com>
In-Reply-To: <CAFd5g44Hxhxjqb6WkfaMtaTDKVhs0onnkRaQ0Aq55z6oYTbJbA@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 15 Jul 2020 10:30:01 +0100
Message-ID: <CALrw=nEPrPpqH+kns+S7-FHavQk88Y_cSegrPfoM8OUCwKXuVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] um: allow static linking for non-glibc implementations
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 9:44 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> > UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> > implementations, which do not rely on NSS, such as musl.
> >
> > Allow static linking in this case.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> One minor issue below. Other than that:
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  arch/um/Kconfig         | 2 +-
> >  arch/um/drivers/Kconfig | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 9318dc6d1a0c..af7ed63f9c74 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -67,7 +67,7 @@ config FORBID_STATIC_LINK
>
> Doesn't look like FORBID_STATIC_LINK is used anymore, so you should
> probably drop it as well.

Right, good catch! I will repost the series with this adjusted as well
cc Masahiro Yamada as mentioned for +1 on the changes to can-link.sh
script.
Seems I also need to rebase now to accommodate changes in
b816b3db15f68690ee72a4a414624f8e82942b25 ("kbuild: fix
CONFIG_CC_CAN_LINK(_STATIC) for cross-compilation with Clang")

> With the preceding changes, in this patchset, you can revert my patch
> like you did in the RFC - or not, your choice. I am not offended by
> people reverting my commits. I just don't like it when people break
> allyesconfig. :-)
>
> >  config STATIC_LINK
> >         bool "Force a static link"
> > -       depends on !FORBID_STATIC_LINK
> > +       depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
> >         help
> >           This option gives you the ability to force a static link of UML.
> >           Normally, UML is linked as a shared binary.  This is inconvenient for
> > diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> > index 9160ead56e33..72d417055782 100644
> > --- a/arch/um/drivers/Kconfig
> > +++ b/arch/um/drivers/Kconfig
> > @@ -234,7 +234,6 @@ config UML_NET_DAEMON
> >  config UML_NET_VECTOR
> >         bool "Vector I/O high performance network devices"
> >         depends on UML_NET
> > -       select FORBID_STATIC_LINK
> >         help
> >         This User-Mode Linux network driver uses multi-message send
> >         and receive functions. The host running the UML guest must have
> > @@ -246,7 +245,6 @@ config UML_NET_VECTOR
> >  config UML_NET_VDE
> >         bool "VDE transport (obsolete)"
> >         depends on UML_NET
> > -       select FORBID_STATIC_LINK
> >         help
> >         This User-Mode Linux network transport allows one or more running
> >         UMLs on a single host to communicate with each other and also
> > @@ -294,7 +292,6 @@ config UML_NET_MCAST
> >  config UML_NET_PCAP
> >         bool "pcap transport (obsolete)"
> >         depends on UML_NET
> > -       select FORBID_STATIC_LINK
> >         help
> >         The pcap transport makes a pcap packet stream on the host look
> >         like an ethernet device inside UML.  This is useful for making
> > --
> > 2.20.1
> >
