Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38CC10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93120863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUKhJlpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIHer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:34:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34282 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCIHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:34:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so933752plm.1;
        Mon, 09 Mar 2020 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N9OpmY3uVY3I6hvA+AwXfGDfvLoWIEqL/Dsj+7HVasI=;
        b=lUKhJlpNffhc8z2PIF5tOfpdjG5Sz1KWgVHmBCfg8XH35i0xfGXMK5isdLuQmVSm9c
         pYGEI/CCzH6K8/BIQzhOmWPW7by6Nq6rBlLMPDNnxrNjCSdH6bUaXZG+5FpskzlGAs2X
         l1g7A7uI07EVLD4gdufEEYHmbfO6GUTJNBncosTC03StlB0k0Z8v5HKpW6H0X95pwSZU
         2KsYM/R1n+ANKlJ0iNRhT1oS6MLaag8/o6G7cja32cOg32fuWLEkrhijd4nrU+coCIpt
         qcE308RdlZbU+vRBOs3Z+QjkVv9wI7IIYVAFE1XfO8huStez5PXEfzAmny5Byq/hxbzk
         vIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N9OpmY3uVY3I6hvA+AwXfGDfvLoWIEqL/Dsj+7HVasI=;
        b=ATZhz3mmmQs+96s4wMXc2dMFFsMvMPg5VMk2KCeZ2l0cSfA2syw76nEZDM1VOGq9kX
         dyso9TmpQebUWVSZmy3WnwN3SYbSSH9ppdgg8CKRDAtISUTO/pv0u2ary5vOaANV6QzO
         eWJd/PqLMPQYBRMBgJkKt4QAZFsdXKUCsUJGpWk8WUBsxFtJ7x1AL1SPv/b6FQgy3zZf
         hzlhGJdqiMhxdZv7BlDwCDguWMG+u5fFZO4ryz4RyC7sn0wmJBAOuYL3Kv0IPiXnGGMo
         W3iQg0GIOCuhQAsiUNkBIR8PBEogBf0Dg3y8kPqbblLeQa1t6GTKQChItFJEzaH57xp5
         fU1g==
X-Gm-Message-State: ANhLgQ1g4rfpD+eZqiZolkKHcvVWum3qzKWIitvslsSIODBrLJZEAD4q
        MuFHjHlM58rXtvsRfKUoUzrGdLKiUiQii2QdWiT3rG78
X-Google-Smtp-Source: ADFU+vsaBwkGyYtFDA7D4nQ8h5mXCaXNxwLMVsW5zq6k+AsrhyRI0PNNCsYU/18e73tP36lN9EdwFyfh6ZewfgSd8AQ=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr15038556plo.18.1583739284543;
 Mon, 09 Mar 2020 00:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200308211519.8414-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200308211519.8414-1-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Mar 2020 09:34:37 +0200
Message-ID: <CAHp75VfX0hWGaWqJcrShYW6SOi9B24LGm=02BGZXg7qOevgZBg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Move Intel Many Integrated Core documentation
 (mic) under misc-devices
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 11:17 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> It doesn't need to be a top-level chapter.
>
> This patch also updates MAINTAINERS and makes sure the F: lines are
> properly sorted.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for MAINTAINERS change.

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v2:
> - Run scripts/parse-maintainers.pl to sort the lines in the MAINTAINERS
>   entry, as suggested by Andy Shevchenko
>
> v1:
> - https://lore.kernel.org/lkml/20200305214747.20908-1-j.neuschaefer@gmx.n=
et/
> ---
>  Documentation/index.rst                                | 1 -
>  Documentation/misc-devices/index.rst                   | 1 +
>  Documentation/{ =3D> misc-devices}/mic/index.rst         | 0
>  Documentation/{ =3D> misc-devices}/mic/mic_overview.rst  | 0
>  Documentation/{ =3D> misc-devices}/mic/scif_overview.rst | 0
>  MAINTAINERS                                            | 8 ++++----
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/{ =3D> misc-devices}/mic/index.rst (100%)
>  rename Documentation/{ =3D> misc-devices}/mic/mic_overview.rst (100%)
>  rename Documentation/{ =3D> misc-devices}/mic/scif_overview.rst (100%)
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index e99d0bd2589d..6fdad61ee443 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -131,7 +131,6 @@ needed).
>     usb/index
>     PCI/index
>     misc-devices/index
> -   mic/index
>     scheduler/index
>
>  Architecture-agnostic documentation
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-de=
vices/index.rst
> index f11c5daeada5..c1dcd2628911 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -20,4 +20,5 @@ fit into other categories.
>     isl29003
>     lis3lv02d
>     max6875
> +   mic/index
>     xilinx_sdfec
> diff --git a/Documentation/mic/index.rst b/Documentation/misc-devices/mic=
/index.rst
> similarity index 100%
> rename from Documentation/mic/index.rst
> rename to Documentation/misc-devices/mic/index.rst
> diff --git a/Documentation/mic/mic_overview.rst b/Documentation/misc-devi=
ces/mic/mic_overview.rst
> similarity index 100%
> rename from Documentation/mic/mic_overview.rst
> rename to Documentation/misc-devices/mic/mic_overview.rst
> diff --git a/Documentation/mic/scif_overview.rst b/Documentation/misc-dev=
ices/mic/scif_overview.rst
> similarity index 100%
> rename from Documentation/mic/scif_overview.rst
> rename to Documentation/misc-devices/mic/scif_overview.rst
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b229788d425..722b2e5d495b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8570,15 +8570,15 @@ M:      Ashutosh Dixit <ashutosh.dixit@intel.com>
>  S:     Supported
>  W:     https://github.com/sudeepdutt/mic
>  W:     http://software.intel.com/en-us/mic-developer
> +F:     Documentation/misc-devices/mic/
> +F:     drivers/dma/mic_x100_dma.c
> +F:     drivers/dma/mic_x100_dma.h
> +F:     drivers/misc/mic/
>  F:     include/linux/mic_bus.h
>  F:     include/linux/scif.h
>  F:     include/uapi/linux/mic_common.h
>  F:     include/uapi/linux/mic_ioctl.h
>  F:     include/uapi/linux/scif_ioctl.h
> -F:     drivers/misc/mic/
> -F:     drivers/dma/mic_x100_dma.c
> -F:     drivers/dma/mic_x100_dma.h
> -F:     Documentation/mic/
>
>  INTEL PMC CORE DRIVER
>  M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> --
> 2.20.1
>


--=20
With Best Regards,
Andy Shevchenko
