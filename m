Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9FC4CC60
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60B423135
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="so9zJ/Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHFIh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHFIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:37:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/s+G2eGqMR8MQPfsMaNKoN8G20XvSbaDF1vueDDt9Ng=; b=so9zJ/Hf9o8jCMTBAOknq8zBhI
        K63dTVUNOzWsriGmjfplEzJEJCZdrEw0xp4kt8NtrrFAgd2P9OuS2xKrB8QUvE2698EbGeBpJDtlN
        JYEcolPNktsilJsNLu5AurQ9lshkp4eWfUiPOoCemX+ApTT3bfQKC7OqhCGER0l9n/fvQxTZM9tvy
        ki7tkEtnXUWQ/NiHCEFWWyOsbYk+Kgw9JLZ3P0QqHQkpotu2Z+YlDmqL3nYfjpS8fqXr+C+tQREB7
        5CGasY48zLonbJ8BEWI3CS1dDdCAFxAPMYt60UkZK5j4le/Rts9ehRPIhFimBHaivEY7xrIz0jN20
        1IPVUmyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3bOq-0002qH-Ml; Thu, 06 Aug 2020 08:37:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 009E9300F7A;
        Thu,  6 Aug 2020 10:37:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0AEE2B61F1C1; Thu,  6 Aug 2020 10:37:17 +0200 (CEST)
Date:   Thu, 6 Aug 2020 10:37:17 +0200
From:   peterz@infradead.org
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        g@hirez.programming.kicks-ass.net
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com
Subject: Re: [PATCH 0/2] perf: Allow closing siblings' file descriptors
Message-ID: <20200806083717.GW2674@hirez.programming.kicks-ass.net>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <32ad7700-3d4e-6c20-31c9-8b002fea5cbc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ad7700-3d4e-6c20-31c9-8b002fea5cbc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:15:08AM +0300, Adrian Hunter wrote:
> On 8/07/20 6:16 pm, Alexander Shishkin wrote:
> > Hi guys,
> > 
> > I've been looking at reducing the number of open file descriptors per perf
> > session. If we retain one descriptor per event, in a large group they add
> > up. At the same time, we're not actually using them for anything after the
> > SET_OUTPUT and maybe SET_FILTER ioctls. So, this series is a stab at that.
> 
> I am wondering if instead we should be looking at creating a kernel API that
> allows associating a multitude of tracepoints with a single event.  Thoughts
> anyone?

https://lkml.kernel.org/r/1290445737.2072.338.camel@laptop
