Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F996C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97972076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZx1Jl3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406669AbgFYTfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405815AbgFYTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:35:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:35:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so7041050wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=338KiFmHj0j9aEP9OnwhZQhzwCpeImYEtfOmTA/bECk=;
        b=cZx1Jl3kF6Z3T9JrekfYLiqxZZVEEyfVJwWfYCcpEu7dOn5mjB2XQbR4eZrpFUZKE7
         FhQzgOFEXpD5Z8Ifa6k8GcVLaj61pIP/S3PrvFi29pspMw8uW3p4Q7RskTgmCh9hN924
         vmL5PYWJfs+a0CnZKLfNob1DXN4Rpj2LvM/3zFXIhDa7Cx6IboTCUVntFxntCuUphqJv
         KrHCVa6RvJm0YffFTkvt7fviIOH6l9iKr/zG2YNwonNvC66EO6ayWkZ8r00F0L0vbKw6
         pYglt3O4wOUUfrEZhbpLT3kWHjBFwQsUlCIx3C4gYO3D3qMUkAz5YG+nvpHvq9fV4rpb
         4LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=338KiFmHj0j9aEP9OnwhZQhzwCpeImYEtfOmTA/bECk=;
        b=aYgCVTzzAAZZcY5JOKVdJWETLCC2SksTLQF1jY4LF1Cbn4HT5FMK5XkOq3I6rDmzbJ
         OafzaTqQ0gAQYhU8LlmfY0neMuF/pIpGoVR5iT0dqhLVYprCJ4sybINacSZLYWrRA8JW
         KJC4ZMiN3ohVKk3hBk+mtAk+8hnRwRaJZYNajftzmREJWDNoykpbRPsJgDZggoG8GlZy
         f1eF5tyEhpCETswLRN6b/rJiw4TF5UwlFAg3XQplSthS0Itin/s6UOszT+SNs4raTxPT
         4cpixBZmDjUswbtrcAplEx/xrhQDS6x6W+3RkJ4tun/1h854oxxZZnIY2ZCEeZtQ5vmc
         ZK4Q==
X-Gm-Message-State: AOAM5332a80gMG4R6jaAfOHSOqrnx1b9VeqAEumMqYalvtj/bd8F9a0v
        u4udlwigoxwMPX84DzVlNGdSng==
X-Google-Smtp-Source: ABdhPJxXQCiliAoYKTeewMcMPDSdS7kEFDo4jnOWAuwf5M8B9OiUbIFbW63E/C7X/4+hYX6z+i4l8g==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr33140763wrq.184.1593113739967;
        Thu, 25 Jun 2020 12:35:39 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id t4sm7862891wmf.4.2020.06.25.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:35:39 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:35:33 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [rcu:rcu/next 35/35] kernel/rcu/tree.c:251:8: error: implicit
 declaration of function 'arch_atomic_add_return'; did you mean
Message-ID: <20200625193533.GA235320@elver.google.com>
References: <202006250300.ic32FsdY%lkp@intel.com>
 <20200624203025.GJ9247@paulmck-ThinkPad-P72>
 <CANpmjNO5uBSZj0gHy0t+O2VhD+UjG58+zON0AFX8i7MNSO5a6Q@mail.gmail.com>
 <20200625112926.GO4781@hirez.programming.kicks-ass.net>
 <20200625141125.GE117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625141125.GE117543@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 04:11PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 01:29:26PM +0200, Peter Zijlstra wrote:
> > I fear the same. Let me see if I can quickly modify the atomic scripts
> > to generate the required fallbacks.
> 
> Something like so ought to work, I suppose.
> 
> ---
> Subject: locking/atomics: Provide the arch_atomic_ interface to generic code
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jun 25 15:55:14 CEST 2020
> 
> Architectures with instrumented (KASAN/KCSAN) atomic operations
> natively provide arch_atomic_ variants that are not instrumented.
> 
> It turns out that some generic code also requires arch_atomic_ in
> order to avoid instrumentation, so provide the arch_atomic_ interface
> as a direct map into the regular atomic_ interface for
> non-instrumented architectures.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/atomic-fallback.h       |  236 +++++++++++++++++++++++++++++++++-
>  scripts/atomic/gen-atomic-fallback.sh |   31 ++++
>  2 files changed, 266 insertions(+), 1 deletion(-)

Thanks, looks reasonable!

If noinstr becomes important on architectures that don't implement
atomics using arch_ themselves, there might be a problem with
CONFIG_TRACE_BRANCH_PROFILING, because unlikely() is used throughout
this file. Probably not something to worry about now.

Thanks,
-- Marco
