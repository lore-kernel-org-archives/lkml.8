Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B1FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64223206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599638430;
	bh=+MFU+ADujEBf7YFUpPEYBMqxfDQrcIUOTsLiP1qvsQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LafApM2uw3Psj3FYMs1RKcQU6ldZwWdVBmSrLFMnTsGZztS6TgvguHx3z9k78H5DQ
	 7DWxpe1L+xe9KYKrZuVdbU6fu8OTqwug8gD2VmTxEld9On3tad1lkACah03Mt1zqNw
	 qFprZzh4JEhwWmoVNM/sqQAvTxiQh5k+7pGwbGr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgIIIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:00:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:00:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b12so1645113edz.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wBquDOMvvGBMKlLoT0ZYSQBY2ltKHLixc0AqZwGUMEg=;
        b=sLhlkDWQlawJYdG6m+Rc4jQKtlkc+q3fCT1+NzbHo2HA4xyy9xzq+zUpBXekTZfHGi
         IqiS6LPRxDogwOfWRvTyrTCUsTWr/r5m20KxnDzu9p2cJM/5oZ+GhEbeMQu6CArbqsYs
         BCBbYDWoEXvjeQbVV5nUyqP80jdT/ukV5bArjBjiCpEMCVzXVpK7TB9ZEutccviygpxV
         VXUkbGsmn0q+UN1iB2OcB22gUDAwatS5xBeQ5O1f/9B8Ttrq2bDfqRVVjGLjYidRZ50S
         QTDjgJGKEj8h7rRohjKpViTmqORKxi6dID+T5y9GDYKUPW9Ze0k1JSzLAjHS7RQCuQXe
         So8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wBquDOMvvGBMKlLoT0ZYSQBY2ltKHLixc0AqZwGUMEg=;
        b=o39s3LxOFXxST6sv8EUZrEkpHybU1c7CZiLN/Vkzj+NmQ9o7u6Ds61IVz0qVOHnonm
         lUzzqmdkXpymIveYQUV7LI3S4tigi35H3UiNQlDho4bqxomG4t9YgX0eT0pN+3VdvqFO
         dLP708VNiE6oMrGdahw2fGm2poZhGmTigeAG6TkZGMLcP8DjFPSa36CPRfpp3gx957DB
         g8GthAkCz1AnNjYGR8ZCetVMd6phlQ5zMqMXLPlU7K+LdJTL0o1nRnDTM+PzYUUJa1tf
         SEaPU6Km1xVuq0tLuK+P0LLgVr7Q7U+H3mDTW7ZDFb4N45cTsorRbDw4GDYWf2LH3y+w
         Sfkw==
X-Gm-Message-State: AOAM530JpJW2Azzo+/+9lbX56iCD1kROKDTau1G2fvQ4FaQOP/0ggvir
        WtnlOpkWMFMMAztbXS1YCU4=
X-Google-Smtp-Source: ABdhPJyCoapXaBDbIez2oa4OKqWgA9jBW5jloaJK3uy0fraUM4W0WRa2tGJj36NAlFEE0rMEbyzeSg==
X-Received: by 2002:a50:a693:: with SMTP id e19mr2753440edc.205.1599638423633;
        Wed, 09 Sep 2020 01:00:23 -0700 (PDT)
Received: from gmail.com (54007801.dsl.pool.telekom.hu. [84.0.120.1])
        by smtp.gmail.com with ESMTPSA id bz5sm1278231ejc.83.2020.09.09.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:00:22 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:00:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnaud Lacombe <lacombar@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
Message-ID: <20200909080020.GA2437694@gmail.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com>
 <20200908134350.GX1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908134350.GX1891694@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Sep 08, 2020 at 02:13:54PM +0200, Ingo Molnar wrote:
> > 
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
> > > 32-bit builds using defconfig become broken because on x86_64 build host
> > > with no ARCH provided the default behaviour is to assume 64-bit independently
> > > on the configuration file name. The crucial part is CONFIG_64BIT option
> > > that used to be explicit. Let restore the latter option in order to unbreak
> > > 32-bit builds.
> > 
> > So exactly which build method broke due to this? The typical way to do a defconfig build is:
> > 
> >   make ARCH=i386 defconfig
> > 
> > which still works fine AFAICS.
> 
> uname => x86_64
> make i386_defconfig
> 
> It was very convenient to not supply ARCH when build on multi-arch host.

Nice, TIL about the extended 'make *config' targets. :-)

Curiously, they aren't even mentioned in the 'configuration targets' 
section of 'make help' and are not discoverable unless you know their 
locations.

Anyway, your fix makes sense now to me too.

Do we need a similar for x86_64 defconfig, when built on 32-bit hosts? (not 
that anyone does that in practice, but just for completeness.)

Also, it would be nice if there was a way to annotate the defconfig for 
'make savedefconfig' preserved these ARCH choices - it currently strips out 
all non-enabled options that match their default configuration value.

Thanks,

	Ingo
