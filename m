Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2DBC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938B62064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xbl0pzAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAQPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:17:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sBS1drMzIhipzCNVy8OKMGnYXRx1U8GXiDqx0O3pTls=; b=xbl0pzABN8FSNelcDT6OE28U8
        HtKNAW5hqWR2aK0rwRmivz6TD2a1dOR4KBEyFdUexiwybn4+TrVTs2blfRtmRRWowiYvGEkvQwBk6
        qKzlb8f4+R+GRzo9aHjcTzk/cemxdltFEgpH8q8UVw8rGy5CHop4vm0lsXn9Fda5VHKXg+oME3YIf
        P/vAxSvt6eoTYznz+6FmU7sd48hb7XN0PqyS3hkI19lQF1YpGqPTtO3ZrZpciCneGvlidVhA0b3gv
        fYnMLparMSSo+FiqTeQkk5kSfRCPP72WIZjZN72rk2XLjTziEeKubyP98Ud2xX+Z3MH+vkrN94gcb
        iQ/g18erg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isTMq-0000eo-Fx; Fri, 17 Jan 2020 15:17:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CA8E304123;
        Fri, 17 Jan 2020 16:15:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 784C320261863; Fri, 17 Jan 2020 16:16:58 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:16:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <James.Clark@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <Al.Grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Message-ID: <20200117151658.GH14879@hirez.programming.kicks-ass.net>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
 <20200117140143.GD14879@hirez.programming.kicks-ass.net>
 <1231fd60-79cd-fcdf-8b99-a3be746bf2d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1231fd60-79cd-fcdf-8b99-a3be746bf2d1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:00:37PM +0000, James Clark wrote:
> Hi Peter,
> 
> Do you mean something like this?

Yes.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 43d1d4945433..f74acd085bea 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10812,6 +10812,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>                 goto err_pmu;
>         }
>  
> +       if (event->attr.precise_ip &&
> +               !(pmu->capabilities & PERF_PMU_CAP_PRECISE_IP)) {
> +               err = -EOPNOTSUPP;
> +               goto err_pmu;
> +       }
> +
>         err = exclusive_event_init(event);
>         if (err)
>                 goto err_pmu;
> 
> 
> Or should it only be done via sysfs to not break userspace?

So we've added checks like this in the past and gotten away with it. Do
you already know of some userspace that will break due to it?

An alternative approach is adding a sysctl like kernel.perf_nostrict
which would disable this or something, that way 'old' userspace has a
chicken bit.

