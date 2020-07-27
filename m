Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D419720809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595885691;
	bh=866a6hhZ+01yYr2IlzYYM4VKfpwbUMYsvmFHKGcJ3PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xgbIdsdhAwejAXd5Hgk4Ca6+OxVJDpPZgg+VxYuk9aMAC5J/ZzURxodOGlFZkmlfO
	 3+hKtDR8rXN30bCe9IMAYPWAekcdCMGnsSuQh48cA5T+TJegVtPAJFQowKftvQ+LrF
	 wMo6wDihegYsMzTYIQrUl7MAtxBtEvd7tnDpiypY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgG0Veu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Veu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:34:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE365C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:34:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c15so3574534edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4V97hvZvA5I26Zuba2zhsiecwp3cc1CvQSO+r7h56c=;
        b=c1L2iv4CgFakkeP6iB5hqF8Ke/yqNnvEz1pTYOgVRjn2ec8DMtEmkbhMUPZXfYVfFQ
         Gs+HxMgy9Zc1DZWhLiL1Y3UYgkzzmHw/1wX5KOvd9OutyiP9neggpDrpGoTrShcS2Aln
         rSmc6DUUeXtnePYoZPO9z8ag6H3L2Hsd6CjXSGp9IIRkED+4w2SJuR2yjRGUEMHh9+6o
         x+3HyFsgDpEgF1lJOvKqAvQLjfIirttooGAbl8LcsWSsDe3aSGDDC1s7qwqN+iBOdZwm
         6Cw3hXxdRoCQJSHwVm5dGWYgYCMCfNULmd/7NQxEWExUQj3hpxa5RGvUNUEDSHyD8rLS
         oSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o4V97hvZvA5I26Zuba2zhsiecwp3cc1CvQSO+r7h56c=;
        b=VYtW6eojJ6EjvyTX4rJDLCd3nGp0gLfqDPR92ePZ0ZwQ/bRCojPtXYG3WQPnQhjW32
         /l0FO7lboZfMFU7aFOgBkc8Opfb4BU3DtQ8NgNKx+ea1KZtBu1hN0a8E3xtBo9s7fYYs
         QDSDBR+6Wb9Id/0iHLaYRH+cEMOyzo221R2VL+KjA9n7ov8tNmAwDbdqxo9Au5TjXJVF
         KsIJYdNfT0XpBWaiSCkZxtJq5CwpS7WnKNbzlO5TmKX7Mqntfo7Xg1rJhFqi2MdK1z1o
         SRnbE2mFtMqRovTM5Sag/ZUK8lPRj9gX3qsvKzv03gnG0eCkl/STAhsRXkWZd97gH3+3
         blcw==
X-Gm-Message-State: AOAM532siSEpuRSJBiOUlrXBVc6hm4ji/DeHy+8t6PBkyvbBp7KOa+zY
        Yei+v23jhUf30Vu81fhsNkg=
X-Google-Smtp-Source: ABdhPJygorYCMbji9g+nTinak9IwZZpT053mfFgZL2Sv/1SCj2D53f+FmlIq4aiDdGRx/2jp5LbaGw==
X-Received: by 2002:a50:8f83:: with SMTP id y3mr23652080edy.257.1595885688477;
        Mon, 27 Jul 2020 14:34:48 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p1sm4076630ejz.50.2020.07.27.14.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:34:47 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:34:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, peterz@infradead.org,
        bigeasy@linutronix.de, namit@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] smp: Fix a potential usage of stale nr_cpus
Message-ID: <20200727213444.GB121479@gmail.com>
References: <20200721034239.72013-1-songmuchun@bytedance.com>
 <20200727114303.GA57241@gmail.com>
 <87mu3laqqi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu3laqqi.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Ingo Molnar <mingo@kernel.org> writes:
> >> -	get_option(&str, &nr_cpus);
> >> +	if (get_option(&str, &nr_cpus) != 1)
> >> +		return -EINVAL;
> >> +
> >>  	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
> >>  		nr_cpu_ids = nr_cpus;
> >> +	else
> >> +		return -EINVAL;
> >
> > Exactly what does 'not valid' mean, and why doesn't get_option() 
> > return -EINVAL in that case?
> 
> What's unclear about invalid? If you specify nr_cpus=-1 or
> nr_cpus=2000000 the its obviously invalid.

So this was the old (buggy) code:

>  {
>       int nr_cpus;
>
>       get_option(&str, &nr_cpus);
>       if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
>               nr_cpu_ids = nr_cpus;

And this was the explanation given in the changelog:

>> When the cmdline of "nr_cpus" is not valid, the @nr_cpu_ids is 
>> assigned a stale value. The nr_cpus is only valid when get_option() 
>> return 1. So check the return value to prevent this.

The answer to my question is that the bug is that the return value of 
get_option() wasn't checked properly, and if get_option() returns an 
error then the nr_cpus local variable is not set - but we used it in 
the old code, which can result in essentially a random value for 
nr_cpu_ids.

> How should get_option() know that this is invalid? get_option() is a 
> number parser and does not know about any restrictions on the parsed 
> value obviously.

But that's apparently not the bug here, 'invalid' here was meant as 
per the parser's syntax. If nr_cpus is out of range (like the 2000000 
example you gave), then nr_cpu_ids might not be set at all, and 
remains at the 0 initialized value. Which isn't good but not 'stale' 
either.

This is why I was puzzled where a 'stale' value might come from, at 
first sight I was assuming that some large value was written, like 
your 200000 example. The "stale value" happens if it's invalid syntax 
and get_option() returns an error, in which case 'nr_cpus' remains 
uninitialized.

And this is the explanation I didn't find at first reading, and which 
explanation future changelogs should perhaps include.

The new code does this:

        int nr_cpus;

        if (get_option(&str, &nr_cpus) != 1)
                return -EINVAL;
 
        if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
                nr_cpu_ids = nr_cpus;
        else
                return -EINVAL;

Which does all the proper error handling and fixes the uninitialized 
'nr_cpus' local variable usage. So I agree with the fix:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
