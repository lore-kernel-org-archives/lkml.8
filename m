Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD02068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSZT6nxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgGOGgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:36:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD24C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:36:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so1138351wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KDUw/p8DtJDnQnEVAJVG2yQivQjSwBAN+u3RJMI5C9M=;
        b=LSZT6nxj4ttqP+kcl0xXx7k4ieooPzTPhig26hkGekfVkTtaH2JHD7+dmxhRfBfbm9
         uKPMX+hERxM6t42+4N6Xh0vvgnPAfsFn5um87k5Hky68u56FiBTANQ6c0XV9/ywqemtP
         CFHDRfgAs54jtev5fUuTHNM4XmDz+cyusdsqI8vFKQQipJSfmX8Cm9q8GsL8E/P6QhKi
         OlSqCFgn7c90mzyzrNpJBBX6xzzYbAhAWwoD8Q4p4gH4v4H0l4HxkwqNA2okUfvvEvek
         kJEW5+lu08HFJmq/k1o7p4bwNczt54wfoHeMEZaxoZ3WcW7Kt+Irk30DRPMp9W+2+k01
         vKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KDUw/p8DtJDnQnEVAJVG2yQivQjSwBAN+u3RJMI5C9M=;
        b=jT3agJN2Sat7XXwvOt21G81CQ6rfoNbp2e4JDqfcwoXydzBfsXKjJwIRIP1lDMgnbV
         +uzHXpSCThZ6Dmw5/zXjo9ase2mi/xZbB6RGAQ2EyAIuILpCksKitGwnFwg8coxO8hP0
         DbwV1eR0mpJQiBrxOfZIFgik23tea+2pl+koM9XuMUwUzRN7unMNzfdrHn3fEQJCAUIs
         Qb8WsVVWYhYFOPZSyAzWa9//eLpPzpyF4qFkm/ufaDUjOTE0o6X0Cv7lX4JdA5D5ey5N
         CTJKZUG8toBI6uNN9xo+K4ZkqovHZcHlsKQPbaHjJ033xd3X163K2Nsl6yO0OkbcX87l
         Q6kw==
X-Gm-Message-State: AOAM531D+NBWBLago2f3bIYCYdRpnui+C7gW/IIwBt7YwEVM6tkLxD3p
        NjWeTHbMAjT0v5Rceq/vZX8ZDQ==
X-Google-Smtp-Source: ABdhPJwP41jKAMrf4wkPV4iNxv1bwG2M4VTNHS/q1DEIPWOuxYBzr/NmcFF3W0hhLv4v0tGbkjwtPQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr10046135wrq.101.1594794969893;
        Tue, 14 Jul 2020 23:36:09 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id k126sm2040627wmf.3.2020.07.14.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:36:09 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:36:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715063607.GQ1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Olof Johansson wrote:

> On Tue, Jul 14, 2020 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > If function callers and providers do not share the same prototypes the
> > > compiler complains of missing prototypes.  Fix this by moving the
> > > already existing prototypes out to a mutually convenient location.
> > >
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
> > >  109 | int check_astate(void)
> > >  | ^~~~~~~~~~~~
> > >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
> > >  114 | void restore_astate(int cpu)
> > >  | ^~~~~~~~~~~~~~
> > >
> > > Cc: Olof Johansson <olof@lixom.net>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
> >
> > Is there no sane way we can include this file directly to the cpufreq
> > file ?
> 
> Yep. arch/powerpc seems to be in the search path for modules on powerpc, so:
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index c66f566a854cb..815645170c4de 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -22,6 +22,8 @@
>  #include <asm/time.h>
>  #include <asm/smp.h>
> 
> +#include <platforms/pasemi/pasemi.h>
> +
>  #define SDCASR_REG             0x0100
>  #define SDCASR_REG_STRIDE      0x1000
>  #define SDCPWR_CFGA0_REG       0x0100

I searched for "include.*platforms/" in drivers/, and was scared off
this method since no one else does this.

But if it's a reasonable solution, great.  Will fix.

Thanks Olof.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
