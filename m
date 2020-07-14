Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6367C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA132255F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="sDACcKkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgGNRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:02:37 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so22948203eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d4AfpBcJtLpXBHVrNAgFwXc98hoQuW1HknqHrsLWIxQ=;
        b=sDACcKkBwX7u/hQ290Jc4o4VF3R0GDlQ5ghAIxoKl/McdLfrAD4pTbBNfsHJk3gsDf
         HaS+v0OxOjH2jMncWgaLaEa3OnebdG0T0TNA4ofWWXbCtzqLExvrjfWVzu4M8Rxx9qIS
         XeEwxdxRe/d04KxB7q1kB8Iiz/FzKu80P8PUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d4AfpBcJtLpXBHVrNAgFwXc98hoQuW1HknqHrsLWIxQ=;
        b=sENLZ27XPmbvOp3DSyM8H/104cUdsaitn5MWE9+8tmJ5J8SH9+YFeh4rDmPcSLH1CO
         HAywNQjMFB/qTVpop6L4+94b/9t0t2L4Myc+M2Q6+k3bdkOgFUV46fsOd5WqOH0sgHm+
         I4HpAo864/eZTJH5s8auesjRgo1L0RDQ8ClnnQ1ASHBvkyo/pQH/UvdazIHC80SWK9Bq
         uKU0ffZmWzUNbYBnLijQVAgX35P8b133MwyX67vKzZajAIDpL5WInRVJxNYSVOUnshhG
         q1VrCvFFb1F4ir16IwCMBmr7nu5d2pLxljEybdkC15iNU+fCuM8hQPmGZ0+4DPENQhyc
         sUfg==
X-Gm-Message-State: AOAM530ZS3j6uUjIVudkOspLFAPbCGA/QwltwTC3AF7oxTTNx3TNvMJx
        4dyaZbeDkfEI4z6EwJAFB6y3ag==
X-Google-Smtp-Source: ABdhPJzdOWvYGPmhQzsBsLACrB3xWiEVfkblIbkKkgWV3dmSgVtTGDpCnC31d8DbjRAUnxyBfE/mDQ==
X-Received: by 2002:a17:906:178b:: with SMTP id t11mr5172970eje.489.1594746155300;
        Tue, 14 Jul 2020 10:02:35 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6f85])
        by smtp.gmail.com with ESMTPSA id h15sm12893261eja.44.2020.07.14.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:02:34 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:02:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, torvalds@linux-foundation.org,
        x86@kernel.org, kernel-team@fb.com,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714170234.GD2080@chrisdown.name>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <20200714164612.GA28474@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200714164612.GA28474@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony writes:
>On Tue, Jul 14, 2020 at 05:04:48PM +0100, Chris Down wrote:
>> Borislav Petkov writes:
>> > On Tue, Jul 14, 2020 at 01:19:55PM +0100, Chris Down wrote:
>> > > That is, even with pr_err_ratelimited, we still end up logging on basically
>> > > every single write, even though it's from the same TGID writing to the same
>> > > MSRs, and end up becoming >80% of kmsg.
>> > >
>> > > Of course, one can boot with `allow_writes=1` to avoid these messages at
>> >
>> > Yes, use that.
>> >
>> > From a quick scan over that "tool" you pointed me at, it pokes at some
>> > MSRs from userspace which the kernel *also* writes to and this is
>> > exactly what should not be allowed.
>>
>> I don't think we're in disagreement about that. My concern is strictly about
>> the amount of spam caused for some of those existing use cases during the
>> transition phase. People should know that their tools would break, but there
>> shouldn't be so many messages generated that it inevitably pushes other
>> useful information out of the kmsg buffer.
>
>Maybe we just need smarter filtering of warnings.  It doesn't
>seem at all useful to warn for the same MSR 1000's of times.
>Maybe keep a count of warnings for each MSR and just stop
>all reports when reach a threshold?

That also a fine good solution, albeit more complex than just using the 
existing custom ratelimit_state infrastructure. Doing so probably also means 
we'd miss out on some of the other stuff that comes for free with it.

My only other concern with ratelimiting per-TGID or per-MSR was that the 
ratelimit cache table could become unwieldy, but if we keep it simple by 
limiting the size and not printing after we reach that, that sounds fine too.

Any solution which means that we avoid saturating kmsg for workloads which 
currently twiddle MSRs sounds fine to me. People should know that we don't 
support or encourage this, but it shouldn't be at the cost of potentially 
pushing everything else out of the kmsg buffer.
