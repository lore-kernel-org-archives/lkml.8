Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F2AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5228322B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMVWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:22:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360B820791;
        Thu, 13 Aug 2020 21:22:41 +0000 (UTC)
Date:   Thu, 13 Aug 2020 17:22:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peiyong Lin <lpy@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        prahladk@google.com, android-kernel@google.com
Subject: Re: [PATCH] Add power/gpu_frequency tracepoint.
Message-ID: <20200813172239.18ccc4f4@oasis.local.home>
In-Reply-To: <20200813210357.146936-1-lpy@google.com>
References: <20200813210357.146936-1-lpy@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 14:03:57 -0700
Peiyong Lin <lpy@google.com> wrote:

> +/**
> + * gpu_frequency - Reports frequency changes in GPU clock domains
> + * @state:  New frequency (in KHz)
> + * @gpu_id: GPU clock domain
> + */
> +TRACE_EVENT(gpu_frequency,
> +
> +	TP_PROTO(unsigned int state, unsigned int gpu_id),
> +
> +	TP_ARGS(state, gpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, state)
> +		__field(unsigned int, gpu_id)

Both of the above entries are unsigned int.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->state = state;
> +		__entry->gpu_id = gpu_id;
> +	),
> +
> +	TP_printk("state=%lu gpu_id=%lu",
> +		(unsigned long)__entry->state,
> +		(unsigned long)__entry->gpu_id)

Why typecast to (unsigned long) to use it in %lu? Why not just have:

	TP_printk("state=%u gpu_id=%u",
		__entry->state, __entry->gpu_id)

?

-- Steve


> +);
>  #endif /* _TRACE_POWER_H */
>  
>  /* This part must be outside protection */

