Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB60C2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylZ7LAUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgGODvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgGODvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:51:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D425C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:51:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so1567675plk.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XL4t1R7KO+iiuMm12j+xjnscuEfFndInUHw84PmBU/0=;
        b=ylZ7LAUr7v3nNsUSJz4QBwWUkMu5K8QLciZp5z1a5hp2fILGp0VPgza+2a7vL1RduE
         2orVyqzcsKEpygHUPltAqLIr7lS8ANkLD2UvrG3NeNrUr0iCJuegFHD/qgy9qiev1Ofh
         biJRAcpw2pf18vEbtOTRXsI0rlMQ8Hg0QHQi+R8s274ANV6PYW+FcTW8YAdnq+d2YVnn
         7Gjf2vX/8npSCLhwZnlk9c96vbwS9kVfhGLc9PZZmZOftJba8Va7Y+G1Dd4sIjKVt/IK
         TMd5jMtoM77db2UokF5JBiagwoOdQ5RHgFSmN+6T5mxXMd7VFZ8dMnyFpWHhRT7YVrCs
         lt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XL4t1R7KO+iiuMm12j+xjnscuEfFndInUHw84PmBU/0=;
        b=GItD0VKNk64H18qJDzcTKis1d7w/91DY6goYhdgcPxBrQLjQLoVgb8jEL4tSMzyKkr
         JNgoTQiORpmRtNbqkXyXo4jR+zz8r61pl20k/fjHFIgcD8BSrAcQoe2peE9vXh3ko3JH
         M8NotBxnUPo2tUMwDjyisBheSP17K/qiYRyET/aMl6HyR04p6maJOFqsTekzvEeiOPeE
         SPLszNR48iPQvf11J2k8t/s6TBa+/AaYFeOcRKpc/nbSAhgixi1g49RnN6F766EIc7WT
         3EodonZPOH5FQgtc04oE+5ZbgtXZI7w6yeR60owDDt0RyZ3ylYR4jOZ3Jv0wrWaSrYgS
         w0zw==
X-Gm-Message-State: AOAM531lpIuFXrdcCxQ4+kw5D4XNwAL7/W5ipeAETQG1Oke7lpW0QzXI
        oCcBDdezKals5jqkc/qGVa4Q9w==
X-Google-Smtp-Source: ABdhPJz/fr4UJ94q97HnzrCpojOj2P5clVmMzwu1+0cWBhjM/jhe2/UJORYoOQc0tflEF8L9/1W8yQ==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr6492581plr.246.1594785090510;
        Tue, 14 Jul 2020 20:51:30 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id r17sm546201pfg.62.2020.07.14.20.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:51:29 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:21:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715035128.3j7xegbdz4bourxz@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 20:49, Olof Johansson wrote:
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

Fantastic. Thanks.

-- 
viresh
