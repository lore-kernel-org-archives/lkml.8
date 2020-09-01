Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C357C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6618E2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IIdq1oxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgIARWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgIAPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:12:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7174C061244;
        Tue,  1 Sep 2020 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6unLGz/K0Xi97iOgvmL4jkedni3nkjF3cbJ5LtOhorw=; b=IIdq1oxI0R2/tVl44InM34VN2x
        bSsHmh6hRGYBpebTvbeJNSycXTm1GJqhYFhsM3QpFOk8CUXmHdegyJANZ8Y5sj3s9mRqUERT82eXO
        RdUW1qbjaHDOxPoVs7nYvIiM+RhPOCC4YHz23GgpVeHiD/ZbFwwwIzwP8XioglwMPsQxuAWApc4dx
        BW9SZx/XxIc6Qutaf8qrAo9qmmVvVt5D6BHfvAdOCYIsqIC8gJ4Up8kxPw3NvXwFJ37c/ZCwV2/fv
        O7OaZKOJleirX1ljS3VgMAAcxDfAIwqL+PknhgeQsBPttiqOMVsWMu9QBfF4JihcWr2YU+uPs3d88
        qkT4uaNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD7x9-0000Kf-Ap; Tue, 01 Sep 2020 15:12:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A0A9300F7A;
        Tue,  1 Sep 2020 17:12:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57CD820BEB3E2; Tue,  1 Sep 2020 17:12:04 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:12:04 +0200
From:   peterz@infradead.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Al Grant <al.grant@foss.arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200901151204.GE2674@hirez.programming.kicks-ass.net>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
 <20200901150630.GB1424523@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150630.GB1424523@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:06:30PM -0300, Arnaldo Carvalho de Melo wrote:

> Also you mixed up tools/ with include/ things, the perf part of the
> kernel is maintained by Ingo, PeterZ.

Right, it helps if the right people are on Cc.

> Peter, the patch is the one below, I'll collect the
> tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
> please consider taking the kernel part.

Al, can you resend with the right people on Cc? Also see below.

> ---
> 
> From:   Al Grant <al.grant@foss.arm.com>
> Subject: [PATCH] perf: correct SNOOPX field offset
> Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
> Date:   Mon, 24 Aug 2020 10:28:34 +0100
> 
> perf_event.h has macros that define the field offsets in the
> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> were both 37. These are distinct fields, and the bitfield layout
> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> 

This needs a Fixes: tag.

> Signed-off-by: Al Grant <al.grant@arm.com>
> 
> ---
> 
>   include/uapi/linux/perf_event.h       | 2 +-
>   tools/include/uapi/linux/perf_event.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> ---
> 
> diff --git a/include/uapi/linux/perf_event.h 
> b/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..3e5dcdd48a49 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> 
>   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
>   /* 1 free */
> -#define PERF_MEM_SNOOPX_SHIFT  37
> +#define PERF_MEM_SNOOPX_SHIFT  38
> 
>   /* locked instruction */
>   #define PERF_MEM_LOCK_NA       0x01 /* not available */
> diff --git a/tools/include/uapi/linux/perf_event.h 
> b/tools/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..3e5dcdd48a49 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> 
>   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
>   /* 1 free */
> -#define PERF_MEM_SNOOPX_SHIFT  37
> +#define PERF_MEM_SNOOPX_SHIFT  38
> 
>   /* locked instruction */
>   #define PERF_MEM_LOCK_NA       0x01 /* not available */
