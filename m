Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35805C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1296B20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Dyhz804e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEOTOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgEOTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:14:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B32C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:14:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k19so3102759edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEcYbavgX8JtqJsaFfda+512xKGwZ/fm/kUZY43XBic=;
        b=Dyhz804eVJkifn7MrOk3lXA2cYeO07Wo2pl7mf5YjMFBNH39vMrrhMJ/rIJJabb4dV
         guEH+JGaq2EM2INQSVaVgsuHj0/xRby9hVLII3mauZmrrfgywAQhkpHYiGp/aL59oUW3
         ZskkLFWhScXljJGuVqfdxvI3oQqIPrVtmrQns7kskcjtHK7z8vgsq0bQogumhdMa6aae
         VX9ngNS7wwbyJGWrDeaoO3gxjUUHkHB6XPPl+bx8d3H83IGpB6xBxF5RiluqLnlDU4P1
         jpMhUqIxQYqRBHzlxVjqr6F/k7yqBDkIivvA7gyYKw7NnCA9p0M/HzdhEyOFmn9up+6j
         g+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEcYbavgX8JtqJsaFfda+512xKGwZ/fm/kUZY43XBic=;
        b=WzYeb+hXAYhwr9QB2cq/u0XD9cUDG9JF23MACsmWrCyS/QasH5jCwH2juKNZjyDDix
         USoHWSw2TnUwCmtCy9hvKbVglrqkU8yZx1EobXc/XJC44HtX++2JfaIccILYXecfMzak
         +ObgEFoO6K44Eu21kcJycbghSx+TCSCldzuA5gjLW50T2qL8A1g/zXXRGqZGnei/UO3V
         EHvcDgwmPpaXZjg0Psvs7Z3Kn7H5kL05LRogEbcPWbyfvK/OLtxPCRS0ycCgL3Cs8yEj
         ZZB1BATae+6myVt6f/XAlLQPKMbnjdQ0708oRloirf+85vzYYO7x8VC8ba9VdbGfyBlG
         4MhA==
X-Gm-Message-State: AOAM531zTu5kcanDc6kwjIHRpBNancMlwkUombj9c24B5CEGkElV8XTC
        a8SCSxpcQo7KWmLytjjzCflKAEI5hzMm1ruHw5vCMA==
X-Google-Smtp-Source: ABdhPJzRuccajda0lvZX2w/+DdXmexWrUFl/B2OFA4hS4ryIA7/8/FI38g9Sc/H55qlMNSQAqFa8Wmrf7GbHja6mIt4=
X-Received: by 2002:a05:6402:31b1:: with SMTP id dj17mr4444751edb.142.1589570040580;
 Fri, 15 May 2020 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200515184434.8470-1-keescook@chromium.org>
In-Reply-To: <20200515184434.8470-1-keescook@chromium.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 15 May 2020 15:13:24 -0400
Message-ID: <CA+CK2bAo163NzFn=t+MXBYcTEHPqkptFw6K0d_yMbhwROdGy2A@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] allow ramoops to collect all kmesg_dump events
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 2:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hello!
>
> I wanted to get the pstore tree nailed down, so here's the v4 of
> Pavel's series, tweaked for the feedback during v3 review.

Hi Kees,

Thank you, I was planning to send a new version of this series later
today. Let me quickly review it.

Pasha

>
> -Kees
>
> v4:
> - rebase on pstore tree
> - collapse shutdown types into a single dump reason
>   https://lore.kernel.org/lkml/CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com/
> - fix dump_oops vs max_reason module params
>   https://lore.kernel.org/lkml/20200512233504.GA118720@sequoia/
> - typos
>   https://lore.kernel.org/lkml/4cdeaa2af2fe0d6cc2ca8ce3a37608340799df8a.camel@perches.com/
> - rename DT parsing routines ..._size -> ..._u32
>   https://lore.kernel.org/lkml/CA+CK2bCu8eFomiU+NeBjVn-o2dbuECxwRfssNjB3ys3caCbXeA@mail.gmail.com/
> v3: https://lore.kernel.org/lkml/20200506211523.15077-1-keescook@chromium.org/
> v2: https://lore.kernel.org/lkml/20200505154510.93506-1-pasha.tatashin@soleen.com
> v1: https://lore.kernel.org/lkml/20200502143555.543636-1-pasha.tatashin@soleen.com
>
> Kees Cook (3):
>   printk: Collapse shutdown types into a single dump reason
>   printk: Introduce kmsg_dump_reason_str()
>   pstore/ram: Introduce max_reason and convert dump_oops
>
> Pavel Tatashin (3):
>   printk: honor the max_reason field in kmsg_dumper
>   pstore/platform: Pass max_reason to kmesg dump
>   ramoops: Add max_reason optional field to ramoops DT node
>
>  Documentation/admin-guide/ramoops.rst         | 14 +++--
>  .../bindings/reserved-memory/ramoops.txt      | 13 ++++-
>  arch/powerpc/kernel/nvram_64.c                |  4 +-
>  drivers/platform/chrome/chromeos_pstore.c     |  2 +-
>  fs/pstore/platform.c                          | 26 ++-------
>  fs/pstore/ram.c                               | 58 +++++++++++++------
>  include/linux/kmsg_dump.h                     | 12 +++-
>  include/linux/pstore.h                        |  7 +++
>  include/linux/pstore_ram.h                    |  2 +-
>  kernel/printk/printk.c                        | 32 ++++++++--
>  kernel/reboot.c                               |  6 +-
>  11 files changed, 114 insertions(+), 62 deletions(-)
>
> --
> 2.20.1
>
