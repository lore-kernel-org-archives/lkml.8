Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D2C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565521835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUpnAm84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWFc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 00:32:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 00:32:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so785871pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 21:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olcNFoFN1XXIUl/h/J5YSDSjEz+dlCu/0pWI28fy02Q=;
        b=jUpnAm84r9pUqF9Xu8lwVDVPb4Q0SRJNzxeioAK4yHXPnfOFRa4nbDsIBTKpJcwpTw
         QDRaIHb/x/1Zyn4ln6/aVpRJkeEofXoM2wSl+O9ohWWiokIwMyN80801O1e0QUtEwe5K
         +Atis93gqDMRkvdkZual5xlzaxtqFqYsvFcieb9OJU/u0t17jjC+lX+8QlrR5bcYAZmL
         2ESd1GLTk7Pe8jUBxGQXEDLgB153BNv63Kicx/zshBi27Q4b7QyYWxTtyYl5QqEbXxDZ
         uJ+F1NEM3dY+rCHfb/rTZYvfQ4lIMWr75mreOXm3PaYqdVmNfXQC6CweIH2AR5KYf9m4
         1b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olcNFoFN1XXIUl/h/J5YSDSjEz+dlCu/0pWI28fy02Q=;
        b=PbDAZ45t/EpNcGnIFxcfpBw8FvyfveiLvMmNPLVAVAyrIQt4oqEn8KN7pIcBVgd7UH
         RchrfK/x157c8xEc5HNf4YYytos8HhfiyQRsXjW1fERa4CtFjRyWDjoMaJbb1ej6X2Ke
         rYqxODhQfBcSyP+kHTKvMBvykfyAlsfK3TnjExJyE/R2OqwNFuczgdfUFxxo0QfHH5h3
         1IAzn/rDfUrkS7LDGpivXnURILpe6qgp68aTlkVEat0kP4xUBoS80ETDUg20ZWlXMqUh
         swbGSSnMiGVy1/XgWsfGi6w+4FuEH440MWPHBcE1p4QZqZN30tRXGC7DwoZSRE5qYjQc
         7ngA==
X-Gm-Message-State: APjAAAWy2MLQ342s/E9a/RZwCfG/t1cMluvePyF2vwCCQTnnsAKrrD24
        vLgn36JSCB9JdUyZOVpN3cVyUOm4NPA=
X-Google-Smtp-Source: APXvYqxL6WeD/cuMHW0iO6kFFQhDXGmz4F/jTs8JqzJ4Mhlg1nQXubIy+ed4mw7b90/EdBb5r7BReQ==
X-Received: by 2002:a63:447:: with SMTP id 68mr2206538pge.364.1579757574804;
        Wed, 22 Jan 2020 21:32:54 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id j5sm772505pfn.180.2020.01.22.21.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 21:32:53 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:02:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: Avoid creating excessively large stack frames
Message-ID: <20200123053251.3j7muofewhfidplw@vireshk-i7>
References: <2523300.pfpGjzY74h@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2523300.pfpGjzY74h@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-20, 00:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the process of modifying a cpufreq policy, the cpufreq core makes
> a copy of it including all of the internals which is stored on the
> CPU stack.  Because struct cpufreq_policy is relatively large, this
> may cause the size of the stack frame to exceed the 2 KB limit and
> so the GCC complains when -Wframe-larger-than= is used.
> 
> In fact, it is not necessary to copy the entire policy structure
> in order to modify it, however.
> 
> First, because cpufreq_set_policy() obtains the min and max policy
> limits from frequency QoS now, it is not necessary to pass the limits
> to it from the callers.  The only things that need to be passed to it
> from there are the new governor pointer or (if there is a built-in
> governor in the driver) the "policy" value representing the governor
> choice.  They both can be passed as individual arguments, though, so
> make cpufreq_set_policy() take them this way and rework its callers
> accordingly.  This avoids making copies of cpufreq policies in the
> callers of cpufreq_set_policy().
> 
> Second, cpufreq_set_policy() still needs to pass the new policy
> data to the ->verify() callback of the cpufreq driver whose task
> is to sanitize the min and max policy limits.  It still does not
> need to make a full copy of struct cpufreq_policy for this purpose,
> but it needs to pass a few items from it to the driver in case they
> are needed (different drivers have different needs in that respect
> and all of them have to be covered).  For this reason, introduce
> struct cpufreq_policy_data to hold copies of the members of
> struct cpufreq_policy used by the existing ->verify() driver
> callbacks and pass a pointer to a temporary structure of that
> type to ->verify() (instead of passing a pointer to full struct
> cpufreq_policy to it).
> 
> While at it, notice that intel_pstate doesn't really need to verify
> the "policy" value in struct cpufreq_policy, so drop that check from
> it to avoid copying "policy" into struct cpufreq_policy_data (which
> allows it to be slightly smaller).
> 
> Also while at it fix up white space in a couple of places and make
> cpufreq_set_policy() static (as it can be so).
> 
> Fixes: 3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS")
> Link: https://lore.kernel.org/linux-pm/CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c     |    2 
>  drivers/cpufreq/cpufreq-nforce2.c  |    2 
>  drivers/cpufreq/cpufreq.c          |  147 +++++++++++++++++--------------------
>  drivers/cpufreq/freq_table.c       |    4 -
>  drivers/cpufreq/gx-suspmod.c       |    2 
>  drivers/cpufreq/intel_pstate.c     |   38 ++++-----
>  drivers/cpufreq/longrun.c          |    2 
>  drivers/cpufreq/pcc-cpufreq.c      |    2 
>  drivers/cpufreq/sh-cpufreq.c       |    2 
>  drivers/cpufreq/unicore2-cpufreq.c |    2 
>  include/linux/cpufreq.h            |   32 +++++---
>  11 files changed, 119 insertions(+), 116 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
