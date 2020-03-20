Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE3C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934AA2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG+ISksH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCTSas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:30:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44651 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:30:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so1496933lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfCEg6jyW4rMddIRvWAX/VKW3u1IK74f94P15G8A+YU=;
        b=NG+ISksHKXiylTdpQtYPaHtiWBMaj0a6ivrgsEw1vCx9CdXSMGh/AZYOUFGgYyLjvL
         VCUmyYUGNCOXWpb0UyRcoUPCp6M6SlxkpwgmMI1pimhiOdMqfUYsn7uad2MvWodnoV6z
         GfaSDoy9kJQV0lMAZifJQ1VEeQCa4n6laTHFRNDMCVs1muuMwU51JeShye2JP9XiW0Ut
         R66bTaWHLKNhQlRy/P6TjshxrDcqk4NYp+PkJm+zc+9iJeeTVJMsR3tCZHlAm2+5L/6A
         IW0xPiyI43UVSltCEQGPPJUedLFm6QOgK7XfWEfv7lx0oILQnQzxpGsLUMEEGfOEsjpO
         0U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfCEg6jyW4rMddIRvWAX/VKW3u1IK74f94P15G8A+YU=;
        b=AxRAZNSaD0Azxe94FQ56uMTPQiMFagu8yH8u0o0HcuEJjix57FxQhDPIVmlkkk8Uzw
         HKC9gXISK0/Nl54j9+8v7SJ7jPcbz8/HtxF1K4d/AIjbQXDvFRqbB4q9TF5WIognuAy3
         walZIqEcOYNwV1FI/UK0dpkPNZ7DXaYTs/efAM3pj0fC0EaaIIESqE1UJ2NBAoLNMWqj
         mciBuBMkdT2Xdt1aylOpp3cg1DMWOqXJfbZr6u6wL+OTohlJqyyNsL956HhzKbaz9jpf
         s6uy2E22wsjlvmDANpkIvazcxfH4xHbfM9KJwYys5KGy4wBmKNr0yuqNFRnBm4am7U6+
         YYEw==
X-Gm-Message-State: ANhLgQ2Rm/SRy636RE5u5DEfmqcxeXSJT2vQL5wWAzPR43uJWrN2k7fc
        xcO0vSTKdNirIFepI3re7Rmp/+6dEk7sBf7VbB8=
X-Google-Smtp-Source: ADFU+vs8+Lru4coS6YsOISQO5wP3kQBM9FcAjYvg62Pj6Ip0cabTJIej9E2zjkUB0cYxuNJQPe0U7wMRz4+nUlwz8/0=
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr1532513lfq.16.1584729043191;
 Fri, 20 Mar 2020 11:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
 <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com> <20200319152820.GA2793@lenovo>
 <d8474138-6f8f-8a99-351d-5e5b37999373@akamai.com>
In-Reply-To: <d8474138-6f8f-8a99-351d-5e5b37999373@akamai.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sat, 21 Mar 2020 02:30:31 +0800
Message-ID: <CA+H2tpFF-Kn+QpBFZzbsSYK59A4qLrTWoM+nfQw_ZaOyak54Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
To:     Jason Baron <jbaron@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 4:19 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 3/19/20 11:28 AM, Orson Zhai wrote:
> > Hi Jason,
> >
> > On Wed, Mar 18, 2020 at 05:18:43PM -0400, Jason Baron wrote:
> >>
> >>
> >> On 3/18/20 3:03 PM, Orson Zhai wrote:
> >>> There is the requirement from new Android that kernel image (GKI) and
> >>> kernel modules are supposed to be built at differnet places. Some people
> >>> want to enable dynamic debug for kernel modules only but not for kernel
> >>> image itself with the consideration of binary size increased or more
> >>> memory being used.
> >>>
> >>> By this patch, dynamic debug is divided into core part (the defination of
> >>> functions) and macro replacement part. We can only have the core part to
> >>> be built-in and do not have to activate the debug output from kenrel image.
> >>>
> >>> Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
> >>
> >> Hi Orson,
> >>
> >> I think this is a nice feature. Is the idea then that driver can do
> >> something like:
> >>
> >> #if defined(CONFIG_DRIVER_FOO_DEBUG)
> >> #define driver_foo_debug(fmt, ...) \
> >>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> >> #else
> >>      no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> >> #enif
> >>
> >> And then the Kconfig:
> >>
> >> config DYNAMIC_DRIVER_FOO_DEBUG
> >>      bool "Enable dynamic driver foo printk() support"
> >>      select DYNAMIC_DEBUG_CORE
> >>
> > I highly appreciate you for giving this good example to us.
> > To be honest I did not really think of this kind of usage. :)
> > But it makes much sense. I think dynamic debug might be a little
> > bit high for requirement of memory. Every line of pr_debug will be
> > added with a static data structure and malloc with an item in link table.
> > It might be sensitive especially in embeded system.
> > So this example shows how to avoid to turn on dynamci debug for whole
> > system but part of it when being needed.
> >
> >>
> >> Or did you have something else in mind? Do you have an example
> >> code for the drivers that you mention?
> >
> > My motivation comes from new Andorid GKI release flow. Android kernel team will
> > be in charge of GKI release. And SoC vendors will build their device driver as
> > kernel modules which are diffrent from each vendor. End-users will get their phones
> > installed with GKI plus some modules all together.
> >
> > So at Google side, they can only set DYNAMIC_DEBUG_CORE in their defconfig to build
> > out GKI without worrying about the kernel image size increased too much. Actually
> > GKI is relatively stable as a common binary and there is no strong reason to do
> > dynamic debugging to it.
> >
> > And at vendor side, they will use a local defconfig which is same with Google one but add
> > CONFIG_DYNAMIC_DEBUG to build their kenrel modules. As DYNAMIC_DEBUG enables only a
> > set of macro expansion, so it has no impact to kernel ABI or the modversion.
> > All modules will be compatible with GKI and with dynamic debug enabled.
> >
> > Then the result will be that Google has his clean GKI and vendors have their dynamic-debug-powered modules.
> >
>
>
> static int __init dynamic_debug_init(void)
> {
>         struct _ddebug *iter, *iter_start;
>         const char *modname = NULL;
>         char *cmdline;
>         int ret = 0;
>         int n = 0, entries = 0, modct = 0;
>         int verbose_bytes = 0;
>
>         if (__start___verbose == __stop___verbose) {
>                 pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>                 return 1;

Oh, I forgot this.
If return error here, "ddebug_init_success = 1;" will be never
executed and there will be no debugfs
or /proc operation interface for user.

>         }
>
> ...
>
> I wonder if we should just remove it now.

I think we could keep it by adding "... &&
IS_ENABLED(CONFIG_DYNAMIC_DEBUG)" into the condition.
Then do the comparison again to __start_verbose and __stop_verbose.
If no entries we set ddebug_init_success = 1 and return immediately.

I will make patch V2 if you agree with this.

Best,
-Orson

>
> Thanks,
>
> -Jason
>
