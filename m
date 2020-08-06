Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0947E206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734769;
	bh=B3qaF/LW4hqIEzwkV+J5gu1FY2z8WeZyMWUUanR4sYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TTiJjz5YlTh7n3RasE3W7cJZAbgPaemRe3JD+5VtMdN6F8rxiz1hcW7SbXFLWiIYE
	 n30GgfKPlzjfmuFdG7Z1LyiigwfqWW/29uil7RPeA7KBZIqEGbrzIdjGc6IJCMmEiZ
	 vssh7IQBACRLZE1dkSuDYsMsZl1kvubtnlPoYSK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgHFR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgHFRCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08431C0A888A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 07:20:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so35720388ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmb1iEsk02Ktbby15UBHnv6Nn0dAPG2lRhmD1yH0a80=;
        b=sWE7THrjlHNLdtN4mIh5h4fTj8KCy3mVPv1JEAB/wX9MgwhCEmWMjH/DqccDYjeTE7
         MtDnU6Zm5PvCdRpb3rJU8nVpMIgdMxDmkYFgJkZ/c9U/P+bi3EEiiY05oudV1m1zMfrt
         TvwBOBlsfE6kicwzKDs+Zxx5WlG8sIHf+kDoWEq7EgcKbCOG2/+t/cCRCo1yLBV6hfhq
         s5MJg7YHAQoixFsAwZL/djN1KuAXP7CjO0BtPruHxhS9GAPQwavznxEzo74/HimtM6Om
         vdxUhwCoGgEq+E5ze89pDEX/fzZBMA1sKcDwuxiU6Md/vzrKxgyNnynKnJX5osAKz60+
         EMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pmb1iEsk02Ktbby15UBHnv6Nn0dAPG2lRhmD1yH0a80=;
        b=Cm4G3rSmTFZHbtrxVgb+GR2AsgbU6S7ACxbLYvcQkUhpO+dOf7qMhbfGrxzT47ZHv4
         nN4iXLwxn227mdicHqxOXNVRtVW2Z/Smv0FFJdIFkfsKSwLjlNtuGk3k2glJNQ8pYB6/
         IFWnbXCKdQwyz/ZmiKW+ueMAlr9svZVjn055rx9Qm9P3EsxzLgdHHdMFq6vtvS6j8gL4
         1F5BI82ZTyFPxw3DNRo30/EQlsfsEroyIzcfQisM0TIECgKA7QpczmwcAXmEt5tt5+EI
         5VmuaOLJzOcjfrWpXnXDmJICLja/0MKnUlMx/R+2GtORhgHlal7hRVMQy+u/w7Vsssk1
         mkiQ==
X-Gm-Message-State: AOAM533U/Yhhk5eplnwbVsLunuj/Cnxva5eeq9coSINb8iU7hJ2siqOt
        7IDxVtDhECBOuQk7uAa7N/U=
X-Google-Smtp-Source: ABdhPJxtEf/TMq+OtbgjEnfVmr1L884FceniIKzXmMKSw7kOAIBmsNSevXnhSG4VlvtUFycjHcOV3g==
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr4570218ejy.168.1596723628805;
        Thu, 06 Aug 2020 07:20:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v13sm3917056ejq.59.2020.08.06.07.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:20:27 -0700 (PDT)
Date:   Thu, 6 Aug 2020 16:20:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 03/10] sched/topology: Propagate SD_ASYM_CPUCAPACITY
 upwards
Message-ID: <20200806142025.GD2077896@gmail.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
 <20200731115502.12954-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731115502.12954-4-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> We currently set this flag *only* on domains whose topology level exactly
> match the level where we detect asymmetry (as returned by
> asym_cpu_capacity_level()). This is rather problematic.
> 
> Say there are two clusters in the system, one with a lone big CPU and the
> other with a mix of big and LITTLE CPUs (as is allowed by DynamIQ):
> 
> DIE [                ]
> MC  [             ][ ]
>      0   1   2   3  4
>      L   L   B   B  B
> 
> asym_cpu_capacity_level() will figure out that the MC level is the one
> where all CPUs can see a CPU of max capacity, and we will thus set
> SD_ASYM_CPUCAPACITY at MC level for all CPUs.
> 
> That lone big CPU will degenerate its MC domain, since it would be alone in
> there, and will end up with just a DIE domain. Since the flag was only set
> at MC, this CPU ends up not seeing any SD with the flag set, which is
> broken.
> 
> Rather than clearing dflags at every topology level, clear it before
> entering the topology level loop. This will properly propagate upwards
> flags that are set starting from a certain level.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 865fff3ef20a..42b89668e1e4 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1985,11 +1985,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	/* Set up domains for CPUs specified by the cpu_map: */
>  	for_each_cpu(i, cpu_map) {
>  		struct sched_domain_topology_level *tl;
> +		int dflags = 0;
>  
>  		sd = NULL;
>  		for_each_sd_topology(tl) {
> -			int dflags = 0;
> -
>  			if (tl == tl_asym) {
>  				dflags |= SD_ASYM_CPUCAPACITY;
>  				has_asym = true;

I'd suggest ordering all patches with potential side effects at the 
end, to make them easier to bisect.

I.e. I'd reorder this series to do:

 - Obviously correct renamings & cleanups

 - Convert the code over to the new instrumented sd-flags method. This 
   will presumably spew a few warnings for problems the new debugging 
   checks catch in existing topologies.

 - Do all the behavioral changes and fixes like this patch, even if we 
   think that they have no serious side effects.

In that sense it might make sense to order the two ARM patches to the 
later stage as well - but I suppose it's OK to do those two first as 
well.

Nice series otherwise, these new checks look really useful and already 
caught bugs.

Thanks,

	Ingo
