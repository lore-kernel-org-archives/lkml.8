Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB5AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59CD20874
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/FIIOuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGEFYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGEFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 01:24:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E3C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:24:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so817461pgm.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 22:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/d0fVnkkMj8AqjSj3lBRC3Gn3NS10oGmVycuIL3B8SU=;
        b=H/FIIOuI+LgP/oYZqzk1uF4CUjbh3SidudmmGTAMb6jZEcFjT3AC5y24LPBZaBd6eD
         RU1e9Srm+BcANmkr3q0wEfdS3zQziFNWSHCCVRQ81AN+79KmhEaqQpmziG/SZnwYotgu
         NbsEvpzAaBiU28WDhjxO6xj5x1CgjR3wlPstnF5FMQQ2jxlnyvz2O6+wHEA6mN2kGSij
         NykuilDWYnpf5IMAdX35MaXODOIrw4+xGwIlqpB6DARCq5XWwyM1k2TCLXvzQ91O0ciS
         KH/gi2k3CXQwQk11K/y2C09ZMRs/SccrehXKRwyHnj4HdHR10ABJKItdJnSFH+l6Eyi0
         l80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/d0fVnkkMj8AqjSj3lBRC3Gn3NS10oGmVycuIL3B8SU=;
        b=c0XrSlexQgE9N3vcjAT4SNxB595LIbbxXPgUAkPY/F8lzJMJriMUUYA7f4w98R1+oF
         olwydzR3fB3VYb9MpukcNQozE2ldFwJ0V0Cm4TkeZfT5ZrORz5yh/sT++UqZiFbko6Nz
         it/t+QMBOpx+3jhcsOnHQwsXmP0v0qFP45U4WIjNxonItyOfTmlzAds48p1HnEPFkPN1
         lk+pHsRDkTQw6MRKElQJkCid7Y2pCjiutN0zvNtt0kciTsoLlU1ijY+ovNPVUUyHHeCv
         x8gxMVOo3eZkC7c9CWnF1x8yyskNoMR8TpUYhAb0PKNGT8MVx2KIrB8f70pUvBRe2oQ+
         pKmg==
X-Gm-Message-State: AOAM532s3oWWJpWbT4Qf/9bZLl/u9qphPAuHkHX70XapX2HJ/vZPDGfE
        j5k1TCJF214WHAPgfGviJpe8Tw==
X-Google-Smtp-Source: ABdhPJwQVWd+xcc5oTk71j+2DNUJ61EGqtXZ8Fc7mnfUkHaXRItOp8NtIwrsMlobGAPypEQkyWzU8A==
X-Received: by 2002:a62:8688:: with SMTP id x130mr39800756pfd.280.1593926664017;
        Sat, 04 Jul 2020 22:24:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y27sm15883257pgc.56.2020.07.04.22.24.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 22:24:23 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:24:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] perf tools: Fix record failure when mixed with ARM
 SPE event
Message-ID: <20200705052414.GC14142@leoy-ThinkPad-X240s>
References: <20200623123141.27747-1-liwei391@huawei.com>
 <20200623123141.27747-3-liwei391@huawei.com>
 <20200702230322.GB471976@xps15>
 <5d872f6f-3665-5abd-7251-13926a70f793@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d872f6f-3665-5abd-7251-13926a70f793@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:06:15PM +0800, liwei (GF) wrote:

[...]

Thanks for Mathieu's looping and agreed with his comments.

> > Last but not least do you know where the memory allocated for array arm_spe_pmus
> > is released?  If you can't find it either then we have a memory leak and it
> > would be nice to have that fixed.
>
> Yes, we have a memory leak here indeed, i forgot to free it in this function.
> As 'arm_spe_pmus' is defined as static, i think the author meant to assign it only at the first call,
> but this function is only called once when we executing 'record', should i go on fixing it
> or just drop the patch 1?

I personally think patch 1 is reasonable.  So for fixing memory leak,
I did a quick check, it's good to release the array "arm_spe_pmus" in
the function auxtrace_record__init(), since the array is only used in
this function.

Thanks,
Leo
