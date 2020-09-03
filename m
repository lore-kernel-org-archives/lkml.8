Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CDC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5684A20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3C8iJa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgICCYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:24:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD12C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 19:24:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m5so832117pgj.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ci7Fc8hANsIQl3UJ1FDEFNu8O8UW/KCOsl06HsUOVg=;
        b=r3C8iJa/LztMiNjFMz00NaLYxph+jZTflE3JatK63I0JgzZ+CHDMK/MEzY5njHH0IU
         5TTifFqY4S0I6bSeTydCnT2v2vzhxQDSKMU5ZeHJIVwQV54Nl30CGrdwnBXt+3RR/cK/
         Jo2nB+1/wFjxp2ELqshU2DTX71Bm4BKaPei5QuQp2XNhHpTN9bXBSVHU5UBF87/z5CMM
         LH+8hp3PJywM3nBiSoLTxOyyOJMiA8Duq+b9uYfi7/SsgvHI5fV0lX05fJTaBqO2GyfC
         DMlZrd9j+PNgA510LnIRcWVmAYPbhzvoojpPnW1IlSl7CW7tSgCOiR657K0JY2ltXDak
         Ibvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ci7Fc8hANsIQl3UJ1FDEFNu8O8UW/KCOsl06HsUOVg=;
        b=CG99hWAyuZHKGgra2Tp9CAZQ4fnKnSVxYJKWwjeA90rd+i0Cjnwzb3K5MFB8Mmi+8R
         c/1i/IYsFLuWeiL7+El+NXhUhnPquJncH2Spi+l9c7xeC49D1I9O+3QR4q374wGKO/Al
         5InXvhJ/lP1Y0DgLy2Wx2ZZzbSRYys3C6xsvcW/6ZHvmcTxmpQ8YA1fWXiHHNlxS+mcV
         O+JXcca1ibDEcLNNuriacwp7ssD8tGdcBz+seXMXhodRuUETPvdkv0aV9kXspBPH6ITl
         b5EmNTJMDHUEYr5xksg0MTM0GzKl96uXFxRBhSmC0CJCzmmn0LAgGjv8Zt/qifdaYB51
         O4sg==
X-Gm-Message-State: AOAM5335jR2l9tj46uSo/3UUkk8yKdy5yAFeCePUuT3MxQo16MUEvw+i
        6yRNRpU9GHg0ma5pRMP7kAVM9Q==
X-Google-Smtp-Source: ABdhPJz2IKRiAksQzIZvOPytb1hJAgyVqSzSqfcq62V8UteQFaCDtXg+u960o+qng6UXYQhxCVLBBw==
X-Received: by 2002:a62:6dc1:: with SMTP id i184mr1420075pfc.57.1599099848759;
        Wed, 02 Sep 2020 19:24:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 194sm907586pfy.44.2020.09.02.19.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 19:24:08 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:23:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     peterz@infradead.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] perf tsc: Add rdtsc() for Arm64
Message-ID: <20200903022354.GA1583@leoy-ThinkPad-X240s>
References: <20200902132131.36304-1-leo.yan@linaro.org>
 <20200902132131.36304-3-leo.yan@linaro.org>
 <20200902134805.GI1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902134805.GI1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Sep 02, 2020 at 03:48:05PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 02, 2020 at 02:21:27PM +0100, Leo Yan wrote:
> > The system register CNTVCT_EL0 can be used to retrieve the counter from
> > user space.  Add rdtsc() for Arm64.
> 
> > +u64 rdtsc(void)
> > +{
> > +	u64 val;
> 
> Would it make sense to put a comment in that this counter is/could-be
> 'short' ? Because unlike x86-TSC, this thing isn't architecturally
> specified to be 64bits wide.

Will add below comments:

According to ARM DDI 0487F.c, from Armv8.0 to Armv8.5 inclusive, the
system counter is at least 56 bits wide; from Armv8.6, the counter must
be 64 bits wide.  So the system counter could be less than 64 bits wide
and it is attributed with the flag 'cap_user_time_short' is true.

Thanks for reviewing,
Leo

> 
> > +	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
> > +
> > +	return val;
> > +}
> > -- 
> > 2.17.1
> > 
