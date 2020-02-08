Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D81C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95B12082E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJFc15Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBHBII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 20:08:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43452 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBHBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 20:08:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so426622plq.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8Omrr9pFTToDd+rF07svRekidnIs/Si9O3nVW03Ilk=;
        b=LJFc15HhLy700n54m2oq0f+y2nBxljFHS94MUSpBpJ5KGnTqFcKidi5pQsqqmiRNsT
         p5oKYa63oxRjZORIKogqkkMIMqoXaymQ6McBlDEeLsNDNep5MwUDnKcvuzmDvM1+N3K4
         n/4Roy7lXr8+BQ0CpPjSXTYLrfIHk/X/aEAbUABFMw7UxT+/k0437V26lBDMCN8PVJyW
         QVEhABhoAfgabM2H3f6egFH9IvB02Cu/Pn+DJuIZRuh8TYwRmfaIdsDsqarAoQ4q6P63
         vkhnXPx3jAuzM5xTds5NOgIMHMZsStYTNCTtEppKKKNCtuk2u+mC0ffPIK7ZCgi1udR0
         MiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8Omrr9pFTToDd+rF07svRekidnIs/Si9O3nVW03Ilk=;
        b=bzKGk7XPUXu2b4GEchl+21X7oTj+OYc+qz8sMINKbIEhEDaGooaCUMPgjmHqQSU30c
         wxVRd6ZEP++u5PDU6n8iK/OtDZtuMGj0cnP0eIccO2sSCqP/M4PHm4zDTSPVxNle/jAH
         PSTsB2kMW7Zdr6wD9Ad4A2834sOEtcImgp+SCw8j+J4MfTXFoynK2+AIK8gC8YUYpn6r
         LqZWaDMwUzf5miZdyAi7hGKjKuF4zSYXy6Jx+5oeA3RzLy7i1D/e9PhhHEPzL/hhdlJy
         L2A5UsQqoZzvpl4mMOtYYv+qLPuNJcU/8Gzt1AmMNojwi/mhtYDupbeYuxBVCm6+EWkr
         3Y7w==
X-Gm-Message-State: APjAAAU0Y5glW/IrJ9XEHd96drOLbEwxJxCRGfsewvvhzr6x0lzzCih/
        IiZ+vrgydxtkOI7hGLqNMbZyvmlUMySCog5YMT1bvw==
X-Google-Smtp-Source: APXvYqzNnpKSPiZYsKItVTyJPLRI9g9m8Emo/1j3z598AdEoajkzBOQw5aq/73K5EKpX/Eg5JlsyWKUbcVBvPS7hm6A=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr1098572plv.297.1581124086566;
 Fri, 07 Feb 2020 17:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20200124221401.210449-1-brendanhiggins@google.com>
In-Reply-To: <20200124221401.210449-1-brendanhiggins@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 Feb 2020 17:07:54 -0800
Message-ID: <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com>
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James McMechan <james_mcmechan@hotmail.com>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 2:14 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Ping.

>  arch/um/Kconfig         | 8 +++++++-
>  arch/um/drivers/Kconfig | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..28d62151fb2ed 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,9 +62,12 @@ config NR_CPUS
>
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>
> +config FORBID_STATIC_LINK
> +       bool
> +
>  config STATIC_LINK
>         bool "Force a static link"
> -       default n
> +       depends on !FORBID_STATIC_LINK
>         help
>           This option gives you the ability to force a static link of UML.
>           Normally, UML is linked as a shared binary.  This is inconvenient for
> @@ -73,6 +76,9 @@ config STATIC_LINK
>           Additionally, this option enables using higher memory spaces (up to
>           2.75G) for UML.
>
> +         NOTE: This option is incompatible with some networking features which
> +         depend on features that require being dynamically loaded (like NSS).
> +
>  config LD_SCRIPT_STATIC
>         bool
>         default y
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 72d4170557820..9160ead56e33c 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -234,6 +234,7 @@ config UML_NET_DAEMON
>  config UML_NET_VECTOR
>         bool "Vector I/O high performance network devices"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network driver uses multi-message send
>         and receive functions. The host running the UML guest must have
> @@ -245,6 +246,7 @@ config UML_NET_VECTOR
>  config UML_NET_VDE
>         bool "VDE transport (obsolete)"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network transport allows one or more running
>         UMLs on a single host to communicate with each other and also
> @@ -292,6 +294,7 @@ config UML_NET_MCAST
>  config UML_NET_PCAP
>         bool "pcap transport (obsolete)"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         The pcap transport makes a pcap packet stream on the host look
>         like an ethernet device inside UML.  This is useful for making
> --
> 2.25.0.341.g760bfbb309-goog
>
