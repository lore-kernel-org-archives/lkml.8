Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E0520663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkqM0MXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbgE0RqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:46:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403914AbgE0RqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Kwhca5f0j/+vobW3PAuos+qjYBVCOWNbbK1BTow0MY=; b=qkqM0MXuiQS0ZY7SeOiMolGP+o
        0mw5qXW9ubf1qN0WJA/ywlIhihp+/Cdv0wgSvKRCUiD9eDpJm6Zd905fEkj0CMpP8LrABKU4o7Ase
        t00C9TrZpwe9G9Uh7A/jQ0pC/tVWShYhwvAJSWe/NqgkZGdiu/7j0DujwPr2H+m6yziNg1oxRH+fS
        3x0GFeguB7hjI77HroTzDiUuPkctQos9Pg+0VtUvMwT8F7gSU2XMHYupwqcgR7Tq1b0lj6UsWcYzT
        uobco3917ZInMTwwTTAQQY6a3jany1B9soFuPdQ7VpYDjV/W0rOTg7osRnBsRnh49wPTQHsgH8Poy
        Np8C6lEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je05k-0004bh-EE; Wed, 27 May 2020 17:43:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6716D3060FC;
        Wed, 27 May 2020 19:43:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5506D2023E7C7; Wed, 27 May 2020 19:43:45 +0200 (CEST)
Date:   Wed, 27 May 2020 19:43:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 03/15] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200527174345.GB706478@hirez.programming.kicks-ass.net>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121922.8997-4-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:19:10PM +0300, Adrian Hunter wrote:
> @@ -2179,6 +2181,49 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
> +			     unsigned long *value, char *type, char *sym)
> +{
> +	struct kprobe_insn_page *kip;
> +	int ret = -ERANGE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(kip, &c->pages, list) {
> +		if ((*symnum)--)
> +			continue;
> +		strlcpy(sym, c->sym, KSYM_NAME_LEN);
> +		*type = 't';
> +		*value = (unsigned long)kip->insns;
> +		ret = 0;
> +		break;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

This fails on sparc64-defconfig.

In file included from ../include/linux/kprobes.h:19:0,
                 from ../kernel/kprobes.c:21:
../kernel/kprobes.c: In function 'kprobe_cache_get_kallsym':
../include/linux/rculist.h:382:49: error: dereferencing pointer to incomplete type 'struct kprobe_insn_page'

Please provide a new patch.
