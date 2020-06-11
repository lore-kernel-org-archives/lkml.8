Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C374BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDE420838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqEJ5GA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFKRGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:06:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:06:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so1833528pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pI2G9x8XySR9DruVGRJidO1nAqjYW7jZcLJ0jduQuLM=;
        b=NqEJ5GA/ehM6UXoHjGGuPNm3B3rfMC1cOHvni2EJcnW9zfClcUy4MFwL3d6X4Umn1G
         gf95qNdFanqgDq/iJc7qrRLil0x0D2wngwpf5nyMmOSpv1Miw+RLTpCnQCyf6U6A9UgB
         BIjwZ5q8ylSnAuU3U7wqC1G+YIOYg5ZQMEwwIqa27NlLx4wfBto6cqvEmfhOoIkAQg2D
         OcPRn7du2QLzn0LYY7+6DIXok09q0JSmnm0eTyfsKq7lCxHphLZiuK/LRFrgjljjDgV4
         ztCU39IhEGgwqTb3durCnfrOGlFCcAyCoaR7e4UepPjSEK/zT+pqQFMs2xMPU5fiE7jk
         MPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pI2G9x8XySR9DruVGRJidO1nAqjYW7jZcLJ0jduQuLM=;
        b=kx+kJzfb+D454nt7MhuM5Pg/JcADHmNvWWVqkJpAghlhuj7RKrA0CY/TgG2+j81n4h
         9q3nwh1y7obXu7y0HQITuZM2Yllx7v6tfb9Nf60ANlJ10oi6+KFib2uiGfXkyTr9Z+xK
         8671+GOGe6c8yzEsBBW4bJv/rbJadh3WSTOkTh25Atz1h3ilbtBDeErNsjQvo20u2N4y
         EM1uhKNm7TVymvWN4EY96rvvAkRAbk4aqtf12KLnJ4g82zkZ7hi54XfcsyqWlasHxWKc
         dMxscaMUKXA0smJNyidc36/C/lmexxYxV1Jy1ZndStXskc4fLu14vsE78n+MCaszS6RW
         x9Mw==
X-Gm-Message-State: AOAM5326gIdSXS2OypfRfDiDUun3IsJI2IOt34WDB1To5o8MH/l1jLuk
        15Y1GXlBZcFWlOLML6wLDd+wyr94psp1agWuDzvlTQ==
X-Google-Smtp-Source: ABdhPJwIaddzPZfkreOWkm5D3KkSKXIx2FEPb4DMs82rwvXYSe+SfQFOSBO/0V8ZUaC6ymLwx/6gIHy0Sny57CDe07w=
X-Received: by 2002:a62:7e95:: with SMTP id z143mr8049365pfc.108.1591895189671;
 Thu, 11 Jun 2020 10:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
 <20200601231805.207441-1-ndesaulniers@google.com> <BYAPR11MB3096A0EA2D03BCB76C91F80AF0830@BYAPR11MB3096.namprd11.prod.outlook.com>
 <CAKwvOdnh6Zh+P9SM_qFiy-9u7Y21fn=byTJtG4fTTRJqqU9bcQ@mail.gmail.com>
 <9f4322a5-eea6-fb65-449c-90f3d85f753e@FreeBSD.org> <BYAPR11MB3096904AD67CC83A67A38215F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3096904AD67CC83A67A38215F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jun 2020 10:06:19 -0700
Message-ID: <CAKwvOdndPdAWVSJ530mgT5onG4zsHExqO79=QvvLvpz51D8LsQ@mail.gmail.com>
Subject: Re: [Devel] Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Jung-uk Kim <jkim@freebsd.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pcc@google.com" <pcc@google.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "will@kernel.org" <will@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 9:45 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
> > From: Jung-uk Kim <jkim@FreeBSD.org>
> >
> > Actually, I think we should let platform-specific acfoo.h decide what to
> > do here, i.e.,
>
> That's a better solution. For Linux, it would look something like this:
>
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -508,10 +508,15 @@ typedef u64 acpi_integer;
>
>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>
> +/* Platforms may want to define their own ACPI_OFFSET */
> +
> +#ifndef ACPI_OFFSET
> +#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> +#endif
> +
>  /* Optimizations for 4-character (32-bit) acpi_name manipulation */
>
>  #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> index 987e2af7c335..5d1ca6015fce 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -71,6 +71,11 @@
>  #undef ACPI_DEBUG_DEFAULT
>  #define ACPI_DEBUG_DEFAULT          (ACPI_LV_INFO | ACPI_LV_REPAIR)
>
> +/* Use gcc's builtin offset instead of the default */
> +
> +#undef ACPI_OFFSET
> +#define ACPI_OFFSET(a,b)            __builtin_offsetof(a,b)
> +
>  #ifndef CONFIG_ACPI
>

Looks good at first glance.  Wouldn't actypes.h need to include
platform/acenv.h first though?  Otherwise you put some header
inclusion order dependency on folks who include actypes.h to first
include acenv.h otherwise we're not getting the definition in terms of
__builtin_offsetof.

-- 
Thanks,
~Nick Desaulniers
