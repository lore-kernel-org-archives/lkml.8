Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7155C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D9B20738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QS9QO1x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgIHRe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbgIHQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:15:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0CC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:14:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so19716568wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYj2kwCEYY4tdbHxlRk9vou/mFIHHkfUJ8u/A93HB4M=;
        b=QS9QO1x/9lgbsJU6BTLcNyYHtJ9WFpeN5pi0xJG2me3PX33RBPE+c0n525yXe6oQdJ
         uaLRImemaRtSoMGyoRIWgiIvo2dvBFsyN4TbtTMseNgXiWmvvB55h18xlAZnDR2QZEDT
         flDb7TOCag10jJs+v5zRDrlSRvQ4nGprHN4zBQMc0613mOkXR+VI57xCoTClyosNV93C
         nGBzCod/Od9AepmU4go6SBSN3VFxU8efzbxV0BtPGUh68MrdymX9OPUJjpOLKU2pUxkb
         gSONWBTfoo9aovSVPwCj9m8gDVIgK4Xlg2JxFPvp023w/WvsdDWRNIVrdw06eUGkqQht
         H2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYj2kwCEYY4tdbHxlRk9vou/mFIHHkfUJ8u/A93HB4M=;
        b=TnEafWXaDnr1fuTsBCJr/GBDX/98NyAGD0A51/WKaIGfSq2jii9pBEcfu7MSYYa7ju
         1Gh7mgvvznST64Usz7Y1jMBTQ5Afsyoo6n+7XX+pQ+4O9x2uvODvs9i0v0rPAIZiuvPh
         8C6MFRvLVKHXMItqHkbY0eQq0fF4irf4rqNAPaO6fk2WlSokSafOg6NzfTZjzdB9BBCW
         zrwhojGjOhX+RIanK4qu+4ehb2Tqf+7fCHfJQWAr4tCMJlF8BJNP/JRXtF3inMzMcQe2
         Jiu4gnYB6kdBASkENxOasd1/o6zIWVkBugGxqclGiOhb8ihGyJsTyce8kknPxdtYxZeo
         bOgA==
X-Gm-Message-State: AOAM530QzDilRs4ZY/nzjKlIVNv3YvqD4O/LkPqlx8hkmzS9d5ZvGytP
        DkJdBpqgvX7mVY0shxj9qY+SMA==
X-Google-Smtp-Source: ABdhPJyJIxgShgMR+/VmIkSkZNiJraMvDiBMk8Xb1BrfHZpXoQzGv7wnDPpDTm1CJvMdkrVu3mNk+g==
X-Received: by 2002:adf:e481:: with SMTP id i1mr351083wrm.391.1599581673254;
        Tue, 08 Sep 2020 09:14:33 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id l19sm33290410wmi.8.2020.09.08.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:14:32 -0700 (PDT)
Date:   Tue, 8 Sep 2020 18:14:26 +0200
From:   Marco Elver <elver@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 09/10] kfence, Documentation: add KFENCE documentation
Message-ID: <20200908161426.GD61807@elver.google.com>
References: <20200907134055.2878499-1-elver@google.com>
 <20200907134055.2878499-10-elver@google.com>
 <3e87490e-3145-da2e-4190-176017d0e099@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e87490e-3145-da2e-4190-176017d0e099@intel.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:54AM -0700, Dave Hansen wrote:
> On 9/7/20 6:40 AM, Marco Elver wrote:
> > +The most important parameter is KFENCE's sample interval, which can be set via
> > +the kernel boot parameter ``kfence.sample_interval`` in milliseconds. The
> > +sample interval determines the frequency with which heap allocations will be
> > +guarded by KFENCE. The default is configurable via the Kconfig option
> > +``CONFIG_KFENCE_SAMPLE_INTERVAL``. Setting ``kfence.sample_interval=0``
> > +disables KFENCE.
> > +
> > +With the Kconfig option ``CONFIG_KFENCE_NUM_OBJECTS`` (default 255), the number
> > +of available guarded objects can be controlled. Each object requires 2 pages,
> > +one for the object itself and the other one used as a guard page; object pages
> > +are interleaved with guard pages, and every object page is therefore surrounded
> > +by two guard pages.
> 
> Is it hard to make these both tunable at runtime?

The number of objects is quite hard, because it really complicates
bookkeeping and might also have an impact on performance, which is why
we prefer the statically allocated pool (like on x86, and we're trying
to get it for arm64 as well).

The sample interval is already tunable, just write to
/sys/module/kfence/parameters/sample_interval. Although we have this
(see core.c):

	module_param_named(sample_interval, kfence_sample_interval, ulong,
			   IS_ENABLED(CONFIG_DEBUG_KERNEL) ? 0600 : 0400);

I was wondering if it should also be tweakable on non-debug kernels, but
I fear it might be abused. Sure, you need to be root to change it, but
maybe I'm being overly conservative here? If you don't see huge problems
with it we could just make it 0600 for all builds.

> It would be nice if I hit a KFENCE error on a system to bump up the
> number of objects and turn up the frequency of guarded objects to try to
> hit it again.  That would be a really nice feature for development
> environments.

Indeed, which is why we also found it might be useful to tweak
sample_interval at runtime for debug-kernels. Although I don't know how
much luck you'll have hitting it again.

My strategy at that point would be to take the stack traces, try to
construct test-cases for those code paths, and run them through KASAN
(if it isn't immediately obvious what the problem is).

> It would also be nice to have a counter somewhere (/proc/vmstat?) to
> explicitly say how many pages are currently being used.

You can check /sys/kernel/debug/kfence/stats. On a system I just booted:

	[root@syzkaller][~]# cat /sys/kernel/debug/kfence/stats
	enabled: 1
	currently allocated: 18
	total allocations: 105
	total frees: 87
	total bugs: 0

The "currently allocated" count is the currently used KFENCE objects (of
255 for the default config).

> I didn't mention it elsewhere, but this work looks really nice.  It has
> very little impact on the core kernel and looks like a very nice tool to
> have in the toolbox.  I don't see any major reasons we wouldn't want to
> merge after our typical bikeshedding. :)

Thank you!

-- Marco
