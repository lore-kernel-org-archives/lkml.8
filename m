Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427FEC4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A91821556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ksFQBlVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBZQyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:54:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guM4OpdFkzMxFs+PgFy8AJyhxiplRkgPA//Rl2LhLTY=; b=ksFQBlVYLER9KPti8/cCDfbJY0
        HpPbiGwPavhqc1Lszn93ZzT5WznkCmFdxT/abi5oz9nf+5XAtNjy/UJRppcPJsGodZdutQq+SUeB5
        AB8gW8gvJl9nKxXtGzCQgaDBriCIROrQDVMd8jFeVZ6+6Xxk7BX7dsRlyQnRnz4RumXcgkUBipbXF
        PmG+YbU/zT9DkPxPUNNNMs8wvCcNEcQv3XcSm5tvG4SuWgV7jZsjL3FvwwEBJA16ZMzDQsWZYRg6u
        Ky2mzPqYf//wE0fbAKAc0DoU5TWqg0DJwejK1hqy/yKFAozI5LWmAhuUyepj9Ag3YXSqdF2d3zBcL
        AQQqCQHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zwn-0001sE-Ui; Wed, 26 Feb 2020 16:54:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23647300130;
        Wed, 26 Feb 2020 17:52:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DC962B756CD9; Wed, 26 Feb 2020 17:54:07 +0100 (CET)
Date:   Wed, 26 Feb 2020 17:54:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Geary <patrickg@supermicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Drake <drake@endlessm.com>,
        Michael Zhivich <mzhivich@akamai.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/tsc: Add kernel options to disable CPUID and MSR
 calibrations
Message-ID: <20200226165407.GB18400@hirez.programming.kicks-ass.net>
References: <20200226164308.14468-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226164308.14468-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:43:08AM -0500, Prarit Bhargava wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dbc22d684627..0316aadfff08 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4942,7 +4942,7 @@
>  			See Documentation/admin-guide/mm/transhuge.rst
>  			for more details.
>  
> -	tsc=		Disable clocksource stability checks for TSC.
> +	tsc=option[,option...]	Various TSC options.
>  			Format: <string>
>  			[x86] reliable: mark tsc clocksource as reliable, this
>  			disables clocksource verification at runtime, as well
> @@ -4960,6 +4960,12 @@
>  			in situations with strict latency requirements (where
>  			interruptions from clocksource watchdog are not
>  			acceptable).
> +			[x86] no_cpuid_calibration: Disable the CPUID TSC
> +			calibration.  Used in situations where the CPUID
> +			TSC khz does not match the actual CPU TSC khz
> +			[x86] no_msr_calibration: Disable the MSR TSC
> +			calibration.  Used in situations where the MSR
> +			TSC khz does not match the actual CPU TSC khz.

Do we want to mention that these situations are mostly broken firmware?
Also do mention that if you disable these you might not boot due to not
having a PIT/HPET at all?

As it stands, I find this text a little too encouraging.

>  	tsx=		[X86] Control Transactional Synchronization
>  			Extensions (TSX) feature in Intel processors that
