Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FEE221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596865620;
	bh=xrVQkv5zXrjsh+ypiZ3p5okFdR9ZJ5Lla8NwIloJgBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZCI9k6pR5JnpTT1wJLpyc6MJPZN21QV9XLoH3H9bLP4e1ngia8Y0GpLbhrA/xk1w
	 cvTQsb8lm2uHyDWgNCs4pzWtBGSIqDhMr/koA6bfpuuIAaGK7w9rG6/ie/S0peq/bD
	 teGLpraQxVyxlkXjIePDBP10e7GQX34tZsD4CwxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHHFq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 01:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgHHFq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 01:46:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9988B20855;
        Sat,  8 Aug 2020 05:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596865618;
        bh=xrVQkv5zXrjsh+ypiZ3p5okFdR9ZJ5Lla8NwIloJgBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgH8+piv/FhjLc1XCHrjSAoGsFzXSiTjchCTJpTmdb7KYDgvaTH4CvLKnWvs6XlaQ
         b7cOFyjsFr9xG3zkHajvVq9H68GMEHYwxveiWdsvGyuSOOnqcrKeRGmVs6acF5xJ15
         rCoVwXYodi0la1FI3AzCbhMCNMefhV5ZEA/6HVRs=
Date:   Sat, 8 Aug 2020 07:46:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Adams <jwadams@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 4/7] core/metricfs: expose softirq information
 through metricfs
Message-ID: <20200808054655.GE1037591@kroah.com>
References: <20200807212916.2883031-1-jwadams@google.com>
 <20200807212916.2883031-5-jwadams@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807212916.2883031-5-jwadams@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:29:13PM -0700, Jonathan Adams wrote:
> Add metricfs support for displaying percpu softirq counters.  The
> top directory is /sys/kernel/debug/metricfs/softirq.  Then there
> is a subdirectory for each softirq type.  For example:
> 
>     cat /sys/kernel/debug/metricfs/softirq/NET_RX/values
> 
> Signed-off-by: Jonathan Adams <jwadams@google.com>
> 
> ---
> 
> jwadams@google.com: rebased to 5.8-pre6
> 	This is work originally done by another engineer at
> 	google, who would rather not have their name associated with this
> 	patchset. They're okay with me sending it under my name.
> ---
>  kernel/softirq.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c4201b7f42b1..1ae3a540b789 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -25,6 +25,8 @@
>  #include <linux/smpboot.h>
>  #include <linux/tick.h>
>  #include <linux/irq.h>
> +#include <linux/jump_label.h>
> +#include <linux/metricfs.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
> @@ -738,3 +740,46 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
>  {
>  	return from;
>  }
> +
> +#ifdef CONFIG_METRICFS
> +
> +#define METRICFS_ITEM(name) \
> +static void \
> +metricfs_##name(struct metric_emitter *e, int cpu) \
> +{ \
> +	int64_t v = kstat_softirqs_cpu(name##_SOFTIRQ, cpu); \
> +	METRIC_EMIT_PERCPU_INT(e, cpu, v); \
> +} \
> +METRIC_EXPORT_PERCPU_COUNTER(name, #name " softirq", metricfs_##name)
> +
> +METRICFS_ITEM(HI);
> +METRICFS_ITEM(TIMER);
> +METRICFS_ITEM(NET_TX);
> +METRICFS_ITEM(NET_RX);
> +METRICFS_ITEM(BLOCK);
> +METRICFS_ITEM(IRQ_POLL);
> +METRICFS_ITEM(TASKLET);
> +METRICFS_ITEM(SCHED);
> +METRICFS_ITEM(HRTIMER);
> +METRICFS_ITEM(RCU);
> +
> +static int __init init_softirq_metricfs(void)
> +{
> +	struct metricfs_subsys *subsys;
> +
> +	subsys = metricfs_create_subsys("softirq", NULL);
> +	metric_init_HI(subsys);
> +	metric_init_TIMER(subsys);
> +	metric_init_NET_TX(subsys);
> +	metric_init_NET_RX(subsys);
> +	metric_init_BLOCK(subsys);
> +	metric_init_IRQ_POLL(subsys);
> +	metric_init_TASKLET(subsys);
> +	metric_init_SCHED(subsys);
> +	metric_init_RCU(subsys);
> +
> +	return 0;
> +}
> +module_init(init_softirq_metricfs);

I like the "simple" ways these look, and think you will be better off
just adding this type of api to debugfs.  That way people can use them
anywhere they currently use debugfs.

But note, we already have simple ways of exporting single variable data
in debugfs, so why do we need yet-another-macro for them?

thanks,

greg k-h
