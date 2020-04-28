Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23481C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BF2206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgD1KHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:07:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgD1KHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:07:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A1A30E;
        Tue, 28 Apr 2020 03:07:53 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBE313F305;
        Tue, 28 Apr 2020 03:07:51 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:07:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] hw_breakpoint: Remove unused
 '__register_perf_hw_breakpoint' declaration
Message-ID: <20200428100745.GA15300@C02TD0UTHF1T.local>
References: <1588063937-5744-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588063937-5744-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On Tue, Apr 28, 2020 at 02:22:17PM +0530, Bhupesh Sharma wrote:
> commit b326e9560a28 ("hw-breakpoints: Use overflow handler instead of
> the event callback") removed '__register_perf_hw_breakpoint' function
> usage and replaced it with 'register_perf_hw_breakpoint' function.
> 
> Remove the left-over unused '__register_perf_hw_breakpoint' declaration
> from 'hw_breakpoint.h' as well.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

This is generic code, so I'm a bit confused as to why you've sent it to
us. I'd expect this to go via the perf core maintainers (cc'd).

FWIW, this looks sane to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/hw_breakpoint.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index 6058c3844a76..fe1302da8e0f 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
>  			    void *context);
>  
>  extern int register_perf_hw_breakpoint(struct perf_event *bp);
> -extern int __register_perf_hw_breakpoint(struct perf_event *bp);
>  extern void unregister_hw_breakpoint(struct perf_event *bp);
>  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
>  
> @@ -115,8 +114,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
>  			    void *context)		{ return NULL; }
>  static inline int
>  register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
> -static inline int
> -__register_perf_hw_breakpoint(struct perf_event *bp) 	{ return -ENOSYS; }
>  static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
>  static inline void
>  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)	{ }
> -- 
> 2.7.4
> 
