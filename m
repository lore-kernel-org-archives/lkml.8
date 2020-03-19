Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B2C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A0C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQxiGA25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCSP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:28:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCSP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:28:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so1614371pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fQqai2gqFpYcX1wUjo6UxR57b9P4LhGEX1peb8WMV4=;
        b=aQxiGA25wruzqIUlSjkHFPlp8jQiKXfdQk3Tzb9B4tbtPocSloNGmKZRsqvcfaPoc2
         0EzAtmA7xylTfRzBRrrxyFG9dmRUQg3TH1mYwWP4YMihKsqHd0RUK4xr45JKZHzq474d
         MlkWwSdxIkI0u1UnhJVF+tad8UZoJJPXDQHqcWxbvGv9v+WpOcaCwt3ZFFyFHNgIz99G
         Az/Oz0lMwXPk7CCugBuxphriTn5DUjdK1tvdBbfGqPTeLzipe8vlCcd1h6m6r8B09azr
         NrhB0bIRInRdP4zF+0RLHrQ47TFhcGcBMv8dyNYpWM1S6bM07wrjtS3HSDhRVQ0iDgbx
         03mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9fQqai2gqFpYcX1wUjo6UxR57b9P4LhGEX1peb8WMV4=;
        b=tDCsPekPC6OxFaS7JQnEQlt1Q8g9wj3R7DH10nYXRjUwTHCBE/qdS9WQOAJITgayBO
         wqZ8zVa0Jz77Zv1yI41AkLOWweOuQB0xi+N7S6Tysrk7SbM/rgB/65tZROs+GRc6uGPe
         LeMS50o9laH+P3fB+ngy1oHyRQHLdyToJ2s6q4X6tC7BS1llPLWOkXCg6SrCUn1dRYoj
         6bNx0egkFac7Xs4NAwSLjbxKxiyarDH+OYsNtT0HFWep8kU0drKWSzUIPwJl8+PXxhRa
         NAFp2dDEpZrsNttF4pSkL5A7koZyZLKLLLPph8vmUKvDLp3Y+tQeqfFFT6nT3I3L5fFw
         Ff1g==
X-Gm-Message-State: ANhLgQ3WUsLRHuGIgBuAlfTFVUB8xGgqXKe8GlkiGAaeYR1RZdlZbdz1
        hWxQ401Qf4Sxr/4cImfDXxQ=
X-Google-Smtp-Source: ADFU+vt6KSAHQ3Rp5U6Z5bUs+O0j+x8Gc6RZPnoYUwavDCKzRie5eXX2KymgGNEx+9FXsnOZjDPLpA==
X-Received: by 2002:a62:30c6:: with SMTP id w189mr4618556pfw.257.1584631708743;
        Thu, 19 Mar 2020 08:28:28 -0700 (PDT)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z6sm2808906pfn.212.2020.03.19.08.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:28:27 -0700 (PDT)
Date:   Thu, 19 Mar 2020 23:28:21 +0800
From:   Orson Zhai <orson.unisoc@gmail.com>
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
        Mark Rutland <mark.rutland@arm.com>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of
 DYNAMIC_DEBUG_CORE
Message-ID: <20200319152820.GA2793@lenovo>
Mail-Followup-To: Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
 <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Mar 18, 2020 at 05:18:43PM -0400, Jason Baron wrote:
> 
> 
> On 3/18/20 3:03 PM, Orson Zhai wrote:
> > There is the requirement from new Android that kernel image (GKI) and
> > kernel modules are supposed to be built at differnet places. Some people
> > want to enable dynamic debug for kernel modules only but not for kernel
> > image itself with the consideration of binary size increased or more
> > memory being used.
> > 
> > By this patch, dynamic debug is divided into core part (the defination of
> > functions) and macro replacement part. We can only have the core part to
> > be built-in and do not have to activate the debug output from kenrel image.
> > 
> > Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
> 
> Hi Orson,
> 
> I think this is a nice feature. Is the idea then that driver can do
> something like:
> 
> #if defined(CONFIG_DRIVER_FOO_DEBUG)
> #define driver_foo_debug(fmt, ...) \
>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #else
> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #enif
> 
> And then the Kconfig:
> 
> config DYNAMIC_DRIVER_FOO_DEBUG
> 	bool "Enable dynamic driver foo printk() support"
> 	select DYNAMIC_DEBUG_CORE
> 
I highly appreciate you for giving this good example to us.
To be honest I did not really think of this kind of usage. :)
But it makes much sense. I think dynamic debug might be a little
bit high for requirement of memory. Every line of pr_debug will be
added with a static data structure and malloc with an item in link table.
It might be sensitive especially in embeded system.
So this example shows how to avoid to turn on dynamci debug for whole
system but part of it when being needed.

> 
> Or did you have something else in mind? Do you have an example
> code for the drivers that you mention?

My motivation comes from new Andorid GKI release flow. Android kernel team will
be in charge of GKI release. And SoC vendors will build their device driver as
kernel modules which are diffrent from each vendor. End-users will get their phones
installed with GKI plus some modules all together.

So at Google side, they can only set DYNAMIC_DEBUG_CORE in their defconfig to build
out GKI without worrying about the kernel image size increased too much. Actually
GKI is relatively stable as a common binary and there is no strong reason to do 
dynamic debugging to it.

And at vendor side, they will use a local defconfig which is same with Google one but add 
CONFIG_DYNAMIC_DEBUG to build their kenrel modules. As DYNAMIC_DEBUG enables only a
set of macro expansion, so it has no impact to kernel ABI or the modversion.
All modules will be compatible with GKI and with dynamic debug enabled.

Then the result will be that Google has his clean GKI and vendors have their dynamic-debug-powered modules.

Best Regards,
-Orson

> 
> Thanks,
> 
> -Jason
> 
> 
> > ---
> >  include/linux/dynamic_debug.h |  2 +-
> >  lib/Kconfig.debug             | 18 ++++++++++++++++--
> >  lib/Makefile                  |  2 +-
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> > index 4cf02ec..abcd5fd 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -48,7 +48,7 @@ struct _ddebug {
> >  
> >  
> >  
> > -#if defined(CONFIG_DYNAMIC_DEBUG)
> > +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
> >  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> >  				const char *modname);
> >  extern int ddebug_remove_module(const char *mod_name);
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 69def4a..78a7256 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -97,8 +97,7 @@ config BOOT_PRINTK_DELAY
> >  config DYNAMIC_DEBUG
> >  	bool "Enable dynamic printk() support"
> >  	default n
> > -	depends on PRINTK
> > -	depends on DEBUG_FS
> > +	select DYNAMIC_DEBUG_CORE
> >  	help
> >  
> >  	  Compiles debug level messages into the kernel, which would not
> > @@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
> >  	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
> >  	  information.
> >  
> > +config DYNAMIC_DEBUG_CORE
> > +	bool "Enable core functions of dynamic debug support"
> > +	depends on PRINTK
> > +	depends on DEBUG_FS
> > +	help
> > +	  Enable this option to build ddebug_* and __dynamic_* routines
> > +	  into kernel. If you want enable whole dynamic debug features,
> > +	  select CONFIG_DYNAMIC_DEBUG directly and this option will be
> > +	  automatically selected.
> > +
> > +	  This option is selected when you want to enable dynamic debug
> > +	  for kernel modules only but not for the kernel base. Especailly
> > +	  in the case that kernel modules are built out of the place where
> > +	  kernel base is built.
> > +
> >  config SYMBOLIC_ERRNAME
> >  	bool "Support symbolic error names in printf"
> >  	default y if PRINTK
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 611872c..2096d83 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
> >  
> >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >  
> > -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> > +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> >  
> >  obj-$(CONFIG_NLATTR) += nlattr.o
> > 
