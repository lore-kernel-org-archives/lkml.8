Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD8420772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JCIWj9l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgGBOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGBOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:20:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49165C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x2l3UQ1LnNvnh7vdkqLglXGyJtnaXge3J21AHjk9zjY=; b=JCIWj9l8B+Tkd7lJF/AyeT9+BF
        RE6tfRd4AZ6VMNSVcHPf3mREt1c9NTlTdSrI3OJxTW4qfr2HjatHBF+md1xyY7COPSmCM08LqS9rX
        46tgLGVKgvisjJJ59JE7pXxYAbWWSyPa1A9/AtQT5Ce+Z150U7OR3Ho/cxE/DPbFPesf0VaoMTEea
        gT8ErM8gDJLKmotbXSApWrFto551L1nceFKLrkVyLoQITk6lW0Aqwo6jUo5fVB4WFL7/lxflBnah/
        bEiG0As7gRldfVNsHvoSUhtcHPsXWm1zoy6sxkShVn1WGJDFKuoGDKkzvTL5Nn6RojGhYCd6hfjSV
        XhSMO8PA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr04y-00013f-Ck; Thu, 02 Jul 2020 14:20:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E9293059DE;
        Thu,  2 Jul 2020 16:20:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0657820108659; Thu,  2 Jul 2020 16:20:43 +0200 (CEST)
Date:   Thu, 2 Jul 2020 16:20:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 3/7] sched/topology: Verify SD_* flags setup when
 sched_debug is on
Message-ID: <20200702142042.GI4817@hirez.programming.kicks-ass.net>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701190656.10126-4-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 08:06:51PM +0100, Valentin Schneider wrote:

> @@ -29,6 +29,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>  				  struct cpumask *groupmask)
>  {
>  	struct sched_group *group = sd->groups;
> +	int flags = sd->flags;

	unsigned long flags = sd->flags;

>  
>  	cpumask_clear(groupmask);
>  
> @@ -43,6 +44,22 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>  		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
>  	}
>  
> +	for (; flags; flags &= flags - 1) {
> +		unsigned int idx = __ffs(flags);

	for_each_set_bit(idx, &flags, SD_MAX_BIT) {

Yes, it's a bit yuck, but far more readable imo.

> +		unsigned int flag = BIT(idx);
> +		unsigned int meta_flags = sd_flag_debug[idx].meta_flags;
> +
> +		if ((meta_flags & SDF_SHARED_CHILD) && sd->child &&
> +		    !(sd->child->flags & flag))
> +			printk(KERN_ERR "ERROR: flag %s set here but not in child\n",
> +			       sd_flag_debug[idx].name);
> +
> +		if ((meta_flags & SDF_SHARED_PARENT) && sd->parent &&
> +		    !(sd->parent->flags & flag))
> +			printk(KERN_ERR "ERROR: flag %s set here but not in parent\n",
> +			       sd_flag_debug[idx].name);
> +	}
> +
>  	printk(KERN_DEBUG "%*s groups:", level + 1, "");
>  	do {
>  		if (!group) {
> -- 
> 2.27.0
> 
