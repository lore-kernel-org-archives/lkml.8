Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C1DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581350576;
	bh=Q1XxZ284hQvopL8PCMcaI9qTASKF2EAuLbBnEBfyQnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zAtzsvJ2xQYqQEJpwVtMMhU3ZnZQ0JMKEMoSlFvMAudrAaZC34tOvZsRMNFPA6JTY
	 SCg5ZIehNh9xhkDbTLFNcFIKe+bCqk0gJW/OWonZ9CV4OCLRNgxIxszC4cdurPkQnU
	 LobaAkDrEV+pq7ywP7o1G5kzgdW6BJqsqsN/At1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBJQCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:02:55 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D901F20714;
        Mon, 10 Feb 2020 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350574;
        bh=Q1XxZ284hQvopL8PCMcaI9qTASKF2EAuLbBnEBfyQnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH79nf1ri/XHVY4R08gLMdl57id1OmMitFv2f+ol0fy7pY7cWZ3eP/UroEDbgXJKC
         skHb6ZOkWkdrSCibg/ncszrU/hE5GupyfQkgS7OsiL/+ezry2keuJql93DC2kWK1BG
         DM7mu/rpb+He9yFdZBNE3M7KXS9hCm7Hndj7d1Io=
Date:   Mon, 10 Feb 2020 08:02:52 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] drivers base/arch_topology: Remove 'struct sched_domain'
 forward declaration
Message-ID: <20200210160252.GA702121@kroah.com>
References: <20200210152420.10608-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152420.10608-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:24:20PM +0100, Dietmar Eggemann wrote:
> The sched domain pointer argument from topology_get_freq_scale() and
> topology_get_cpu_scale() got removed by commit 7673c8a4c75d
> ("sched/cpufreq: Remove arch_scale_freq_capacity()'s 'sd' parameter")
> and commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd' parameter
> from arch_scale_cpu_capacity()").
> 
> So the 'struct sched_domain' forward declaration is no longer needed.
> Remove it.
> 
> W/o the sched domain pointer argument the storage class and inline
> definition as well as the return type, function name and parameter list
> fit all into one line.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/arch_topology.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3015ecbb90b1..c507e9ddd909 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -16,9 +16,7 @@ bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>  
>  DECLARE_PER_CPU(unsigned long, cpu_scale);
>  
> -struct sched_domain;
> -static inline
> -unsigned long topology_get_cpu_scale(int cpu)
> +static inline unsigned long topology_get_cpu_scale(int cpu)
>  {
>  	return per_cpu(cpu_scale, cpu);
>  }
> @@ -27,8 +25,7 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>  
>  DECLARE_PER_CPU(unsigned long, freq_scale);
>  
> -static inline
> -unsigned long topology_get_freq_scale(int cpu)
> +static inline unsigned long topology_get_freq_scale(int cpu)

You are doing two different things in this patch :(

Reformatting the function names are fine, but that has nothing to do
with dropping the "struct sched_domain;" line.  Please split into 2
different patches.

thanks,

greg k-h
