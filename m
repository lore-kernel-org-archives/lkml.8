Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8043C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8415A2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaqaqRjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgGOGpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGOGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:45:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C1EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:45:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so1144635wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XztsKGJEU+CUFjtwacm0V9J4sEA12XWIOSpOScerZmI=;
        b=WaqaqRjzn3caUdJrBbRSfKtjgrOj0a5Kd+508p39G78KExPJMqlz0bYhMTxE4sIzw9
         3R+TnXkPJ4US8nRWEGdmYHEqRqB9ZgnWmKPGBQTcjPbWtxipQ5OVaZi2B9zTVIwdBGg0
         Zjbp++8q9e0kR28MklfVSmNIFXfUgl0aqVal5l9TExy8vhYYHA5nNQntaNdU5LYUDVDp
         9UF6Jqz9RcNV1/lZqoYiPFyqakM8fec25kSbwyHlDvJzNJQQnMbIRW4BEhlz3Wijn731
         DJt0zwZJ+B9/CZ2f7KtaqQjTDNLVxVOABGDAgg7O3YmHKPKdQghAyUtvyA2inv4LfBO6
         z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XztsKGJEU+CUFjtwacm0V9J4sEA12XWIOSpOScerZmI=;
        b=JEwVnkziNiOCNhW4FH2ZtGnXUooBFP5l/wkr+Y9J7YsnUH4zySrNX8rsJu0Sg16SJs
         SKazNJ9YDKVj4S3iorYtEsW5LMYC2Q3sgcIZXjFQSKjrc5RfHhplLz5xa168jLZezkIu
         yhNjS4Xhds7n6zBYfTyCUwwGhpC4fFnOkDVC423FFLWHkzcAOU+TjP41+L5KLqe7qOrj
         VPSlf8i2Cav2Xku9jwnk4AcRPJbSjZxmMJiKiT17OdqSBDnUoOqX533QicYcnm5ojexp
         Ch1T+45cJXtjI7bC6uM3vdzHSB7bDtCSg8wMpD3TN5Y5J8YjL8k5t4SDuCdwgkLchD06
         k2iw==
X-Gm-Message-State: AOAM533cHP1NKK1hgU4Y55K5BLA+zzsSnvCRJDyYQbX6Mc493PmssKse
        B7iMsaEvdmFwJ0RlJXLkREBCCQ==
X-Google-Smtp-Source: ABdhPJwQKjhVASdmaI/2VIgjKjTfPbIF9AnGWg0tSX5DecvbWwiJTEFWyH++GnO/A8tnpeliNhjhdg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr9478353wrt.174.1594795541941;
        Tue, 14 Jul 2020 23:45:41 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 5sm1911491wmk.9.2020.07.14.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:45:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:45:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715064539.GS1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 14-07-20, 15:50, Lee Jones wrote:
> > There is no need for this to be denoted as kerneldoc.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'
> > 
> > Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Cc: Jun Nakajima <jun.nakajima@intel.com>
> > Cc: Alexander Clouter <alex@digriz.org.uk>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index f99ae45efaea7..63f7c219062b9 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
> >  static DEFINE_MUTEX(gov_dbs_data_mutex);
> >  
> >  /* Common sysfs tunables */
> > -/**
> > +/*
> 
> This is an important routine with good documentation details already
> there, though internal to governors and so I would rather keep it.

It maybe documented, but it isn't kerneldoc, for 2 reasons; a) it
doesn't meet the standards required qualify as kerneldoc i.e. it's
missing descriptions for each of the function parameters, which is why
the kerneldoc checker is complaining about it and b) it is not
referenced by any *.rst file:

 git grep kernel-doc::.*cpufreq_governor.c
 /* no results */

So what is the justification for keeping it as kerneldoc?

> >   * store_sampling_rate - update sampling rate effective immediately if needed.
> >   *
> >   * If new rate is smaller than the old, simply updating
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
