Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9D72073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OZ1GV+zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgDAKNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:13:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgDAKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RbAvhhO0UkE4nBxfFbEQB4F30Y8t6u/Ovo8Wd/HX8/Q=; b=OZ1GV+zWAm/xYvCJ/xNXrnurtu
        F6P4U3QCJFFppLgCQqOyjE0q+90tTgrtq6WIiOFQ3bMJyUy4uHQOxo232qaMQuzsw1U6tdollpWiI
        +v8UFM/UPl/JEXSaoQrnXnkyu1Dt/+v7xY36vZCpIuXiyWuF+SodbRrjOMmUP4RFCeIhXwc5wxt3V
        32OwtFRTnWtHYfDDI9rt4rfkkeCXHPHEzGqpBBo3vFBVJ66FqCK0lMnOurfVyInDVrkBe30T7U8HT
        SY2KxGlOzJUauTKflh5ICRHo7VtgzbuvQeGBYdcBqSd9UPueZl9zLwfc2aMvBcuRbLGnjt7C88IoL
        4YR5ScRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJaNK-0002Iu-5E; Wed, 01 Apr 2020 10:13:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CCB3301631;
        Wed,  1 Apr 2020 12:13:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 850EC29DA771A; Wed,  1 Apr 2020 12:13:31 +0200 (CEST)
Date:   Wed, 1 Apr 2020 12:13:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 05/13] perf/x86: Add perf text poke events for kprobes
Message-ID: <20200401101331.GZ20713@hirez.programming.kicks-ass.net>
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-6-adrian.hunter@intel.com>
 <20200324122150.GN20696@hirez.programming.kicks-ass.net>
 <20200326105805.0723cd10325ad301de061743@kernel.org>
 <07415abd-5084-f16c-cc62-6c9a237951f3@intel.com>
 <8eb2a113-f90d-856d-8e14-509d690a2989@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb2a113-f90d-856d-8e14-509d690a2989@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:36:09AM +0200, Adrian Hunter wrote:
> Add perf text poke events for kprobes. That includes:
> 
>  - the replaced instruction(s) which are executed out-of-line
>    i.e. arch_copy_kprobe() and arch_remove_kprobe()
> 
>  - optimised kprobe function
>    i.e. arch_prepare_optimized_kprobe() and
>       __arch_remove_optimized_kprobe()
> 
>  - optimised kprobe
>    i.e. arch_optimize_kprobes() and arch_unoptimize_kprobe()
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good, but we had these nice graphs illustrating how the various
events connect, I'm thinking that would be nice to have in the
Changelog, perhaps even in a document somewhere.

These are after all 8 events here that all interplay.

