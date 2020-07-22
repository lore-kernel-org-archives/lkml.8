Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E9AC433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D281E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6mG0UxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGVFfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgGVFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:34:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466EC0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:34:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so580152pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmIwK4uHHxiwR6vWkfEn+UVqSIx9AzZysrf8JFFSTH0=;
        b=x6mG0UxUYRnEEGsc/Q2cDlHN/Tuf3fHpzAp6uBD8RQniav+BShOs2iQP5UR0ISQ321
         yMuXUrtUUJDDMxBVbm/QC3Zsc9CkyFqF7BHe/TNA2t9Ih/h4ghi/7nsfNdXALgSziOT4
         i1KbsnMRS74/4aiJbA2vaBss0IdIkd+yoesbos7irAM0IX8RymW10ex1zyhBswuQKsMJ
         pAJL57wDLxp7fPWBEhROZHb4I8tlDO28nCa1Xh0DqWDN94VvD0gz9hyBf+rY8qYsr12p
         tiDMzY4UbobhT3mqQhQZ5l7vOn0+l8+gaciicSZJmKQGDMZIqSYYM7UlWzfs10QCn/bk
         W3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmIwK4uHHxiwR6vWkfEn+UVqSIx9AzZysrf8JFFSTH0=;
        b=re34cmFQJBiyxwetc0N5WZ1GRr3hbisG0yZBV8aH1A3DbClkms+oEh94FPJjVxCulv
         XeO23fcCYhzQ730eOE+xVYHp/yB0uTDOeHlmMkv8rAnGEVn5/tkLnPBb+pbj7xYClqoz
         W3HAUlGzElGTr6h6OBljiTgsUbkwzPCtmQVJtLIaERqyzffBeWI5RKj319+n2Nw6GoqT
         uc4wS+xHafvDMOzxLhvQhVhd1LCAtEU1NEoRTp3SkRZAEx9LuFlUNwl5yFnNIz1+2y0e
         uMyqdw+y9rWK20+fSzfAjHv2dJSjhCMpC7OfdZsoCxBL4fpJ+3yCmwjXGFruOJWNjGls
         Mmcg==
X-Gm-Message-State: AOAM531WBsvH2LKMdnjxWseTq8lTg5l49aqnf9Fw4YcZp0mj259bmFs3
        MF510I6IEsASj1Kuey0+efy690SCWzo=
X-Google-Smtp-Source: ABdhPJxPmJgxOvlVvy+R9CPXupEfLpDpw2rAzf849OvVpE62QHXdQnC/+UvCAC+w7rdW5+ZAqB5lrA==
X-Received: by 2002:a65:6916:: with SMTP id s22mr26088099pgq.128.1595396097809;
        Tue, 21 Jul 2020 22:34:57 -0700 (PDT)
Received: from localhost ([182.77.116.224])
        by smtp.gmail.com with ESMTPSA id 137sm20210432pgg.72.2020.07.21.22.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 22:34:56 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:04:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4.19 123/133] thermal/drivers/cpufreq_cooling: Fix wrong
 frequency converted from power
Message-ID: <20200722053453.xmfcezyiabz2e2dd@vireshk-mac-ubuntu>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152809.664822211@linuxfoundation.org>
 <20200721114344.GC17778@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721114344.GC17778@duo.ucw.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-20, 13:43, Pavel Machek wrote:
> On Mon 2020-07-20 17:37:50, Greg Kroah-Hartman wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > commit 371a3bc79c11b707d7a1b7a2c938dc3cc042fffb upstream.
> > 
> > The function cpu_power_to_freq is used to find a frequency and set the
> > cooling device to consume at most the power to be converted. For example,
> > if the power to be converted is 80mW, and the em table is as follow.
> > struct em_cap_state table[] = {
> > 	/* KHz     mW */
> > 	{ 1008000, 36, 0 },
> > 	{ 1200000, 49, 0 },
> > 	{ 1296000, 59, 0 },
> > 	{ 1416000, 72, 0 },
> > 	{ 1512000, 86, 0 },
> > };
> > The target frequency should be 1416000KHz, not 1512000KHz.
> > 
> > Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
> 
> Wow, this is completely different from the upstream patch.

Right, I have mentioned this in the patch I sent for stable.

https://lore.kernel.org/lkml/bc3978d0b7472c140e4d87f61138168a2a7b995c.1594194577.git.viresh.kumar@linaro.org/

> There the
> loops goes down, not up. The code does not match the changelog here.

Yes, the order is different in earlier kernels but I would say that
the changelog still matches as it doesn't necessarily talks about any
ordering here.

> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -278,11 +278,11 @@ static u32 cpu_power_to_freq(struct cpuf
> >  	int i;
> >  	struct freq_table *freq_table = cpufreq_cdev->freq_table;
> >  
> > -	for (i = 1; i <= cpufreq_cdev->max_level; i++)
> > -		if (power > freq_table[i].power)
> > +	for (i = 0; i < cpufreq_cdev->max_level; i++)
> > +		if (power >= freq_table[i].power)
> >  			break;
> >  
> > -	return freq_table[i - 1].frequency;
> > +	return freq_table[i].frequency;
> >  }
> 
> 
> Something is very wrong here, if table is sorted like described in the
> changelog, it will always break at i==0 or i==1... not working at all
> in the old or the new version.

As I understand from the other email you sent, this works fine now.
Right ?
-- 
viresh
