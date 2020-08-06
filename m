Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E0C4742C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890A2221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596711921;
	bh=vsI4kjQCapr3CGUsT/Y2zI1xMOGWi0zy40+xdvh+nes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JyboJByZpxsoSVMvBFlrQrVpmgK5GEESSMcrH08g7B0FdMHidcLy9mfucMHi/jcax
	 hVsU44TLdSlvX520igbyOzXRUryLoJLY9VhHxTXEqf8KLCUa7CS80BLU4usOS5pGo5
	 TJ/WKRrgE/vCoCGOS0ujeK5HuVrIZOuuw7Ll4VuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgHFIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgHFIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:09:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEADC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:09:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so17515836edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtxbf+KzxxAKdZrZpK8qZ6M0GgUs2xeceelnbjMimXo=;
        b=B7Q04tBAwLpVa9KQyl9BvCH9GjVf224TCPiDKaxGfs3TlZWojccALd62hMPM8okUdk
         Qi63kdNUDDogSX1ytIIT8E8d8vQRwzRTg/E6vXlgHOrtuitVs1jpTubcMsqXMBeOq7AN
         mq4d0GzBWGr8/FcQ8bo7mO30x3hIIKJZOMEB5RjzajSi8tFmuMo+E0TUaEjKORTWK+h2
         DbX5zR6yH+64g5LnhPEcFTDPXYZr4baMN7M8mjWf8D4F9VqZlLy0K3aUmbMF/4eh88hH
         vQE3qBEZPHrnckTZHRxbmjlGwXGlhejpWpM8uiwgZYecooFOgVRBCQCYw9wOIuRukYoI
         wSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rtxbf+KzxxAKdZrZpK8qZ6M0GgUs2xeceelnbjMimXo=;
        b=YALNjrWc0jDNKsrqWq/trWSG7uNgFDkcVPiP/xmeUqFwc0LUZeF1Tl2Vx8L1q/ZCLT
         wZfMSsJPtNcQ1zB2bifgx5D51VlixUr6zBQcDZXpLSPn/pIjqRGVYBJSqImlAN1ZjOft
         qidobPo/en9tIabQjTERH7JYy45V0BqU8BPMOXdXAg5pzauH9xZwUtObVbFDdj1RVCOV
         WTLPh/OhyVsTWEdojVfFWS1WdZb7sayw8QACuAmPydppILfckqx/prwn2zuTGLW/1omG
         LSoMe2ikqnT0//3gY852G1xBETEM5qltVessrnXh6VPSYKiKGBs2nBBsbkF8J6r9YPg6
         Tsvw==
X-Gm-Message-State: AOAM5321ker9L6qtLjfBQUk64sbzaiqLQ5yzxxWg23pbIc2IGB9rPTQs
        hH3n0sKDvH6so49tkYOjHBA=
X-Google-Smtp-Source: ABdhPJzkz9LEL73jLhWyNmM4lEF+kHoeZMdpebhWdevnPF7bXAe85kHJVhJgL71RipZL+tWHlSsGiQ==
X-Received: by 2002:aa7:c251:: with SMTP id y17mr3041043edo.13.1596701385870;
        Thu, 06 Aug 2020 01:09:45 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t19sm2997957edw.63.2020.08.06.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 01:09:44 -0700 (PDT)
Date:   Thu, 6 Aug 2020 10:09:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v4 00/14] liblockdep fixes for 5.9-rc1
Message-ID: <20200806080941.GA1697074@gmail.com>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sasha Levin <sashal@kernel.org> wrote:

> Hi Linus,
> 
> Please consider applying these patches for liblockdep, or alternatively
> pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git tags/liblockdep-fixes-040820
> 
> The patches fix up compilation and functionality of liblockdep on 5.8,
> they were tested using liblockdep's internal testsuite.
> 
> I was unable to get the x86 folks to pull these fixes for the past few
> months:

So the primary reason I didn't pull is that liblockdep was permanently 
build-broken from February 2019 to around February 2020, despite me 
pinging you multiple times about it.

>  - https://lkml.org/lkml/2020/2/17/1089

This pull request still said that if fixes "most of" liblockdep, not 
"all of", which is the benchmark really after such a long series of 
breakage.

>  - https://lkml.org/lkml/2020/4/18/817

This still said "most of".

>  - https://lkml.org/lkml/2020/6/22/1262

Same 'most of' verbiage.

> Which is why this pull request ends up going straight to you.

So at this point I think we need to ask whether it's worth it: are 
there any actual users of liblockdep, besides the testcases in 
liblockdep itself? I see there's a 'liblockdep-dev' package for 
Debian, but not propagated to Ubuntu or other popular variants AFAICS.

Also, could you please specify whether all bugs are fixed or just 
'most'?

> Sasha Levin (14):
>   tools headers: Add kprobes.h header
>   tools headers: Add rcupdate.h header
>   tools/kernel.h: extend with dummy RCU functions
>   tools bitmap: add bitmap_andnot definition
>   tools/lib/lockdep: add definition required for IRQ flag tracing
>   tools bitmap: add bitmap_clear definition
>   tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
>   tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
>   tools/lib/lockdep: New stacktrace API
>   tools/lib/lockdep: call lockdep_init_task on init
>   tools/lib/lockdep: switch to using lockdep_init_map_waits
>   tools/kernel.h: hide noinstr
>   tools/lib/lockdep: explicitly declare lockdep_init_task()
>   tools/kernel.h: hide task_struct.hardirq_chain_key

Style nits, please use consistent titles for patches:

 - First word should be capitalized consistently, instead of mismash 
   of lower case mixed with upper case.

 - First word should preferably be a verb, i.e. "Add new stacktrace 
   API stubs", not "New stacktrace API"

Also, please always check linux-next whether there's some new upstream 
changes that liblockdep needs to adapt to. Right now there's a new 
build breakage even with all your fixes applied:

  thule:~/tip/tools/lib/lockdep> make
    CC       common.o
  In file included from ../../include/linux/lockdep.h:24,
                   from common.c:5:
   ../../include/linux/../../../include/linux/lockdep.h:13:10: fatal error: linux/lockdep_types.h: No such file or directory
     13 | #include <linux/lockdep_types.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~~

At which point we need to step back and analyze the development model: 
this comparatively high rate of breakage derives from the unorthodox 
direct coupling of a kernel subsystem to a user-space library.

The solution for that would be to use the method how perf syncs to 
kernel space headers, by maintaining a 100% copy in tools/include/ and 
having automatic mechanism that warns about out of sync headers but 
doesn't break functionality.

See tools/perf/check-headers.sh for details.

I believe this same half-automated sync-on-upstream-changes model 
could be used for liblockdep as well, i.e. lets copy kernel/lockdep.c 
and lockdep*.h over to tools/lib/lockdep/, and reuse the perf header 
syncing method to keep it synchronized from that point on.

That would result in a far more maintainable liblockdep end result 
IMO?

Thanks,

	Ingo
