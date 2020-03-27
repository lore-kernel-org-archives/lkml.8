Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CF1206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgC0RCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:02:53 -0400
Received: from foss.arm.com ([217.140.110.172]:49142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0RCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:02:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 836921FB;
        Fri, 27 Mar 2020 10:02:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0123F71E;
        Fri, 27 Mar 2020 10:02:50 -0700 (PDT)
Date:   Fri, 27 Mar 2020 17:02:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wang, Li" <li.wang@windriver.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mmu: no write cache for O_SYNC flag
Message-ID: <20200327170248.GC94838@C02TD0UTHF1T.local>
References: <20200326163625.30714-1-li.wang@windriver.com>
 <20200327142937.GB94838@C02TD0UTHF1T.local>
 <6fc201bf-ad0c-3dae-783e-c9c9e4ac034e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fc201bf-ad0c-3dae-783e-c9c9e4ac034e@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:47:32AM +0800, Wang, Li wrote:
> 
> 在 2020/3/27 22:29, Mark Rutland 写道:
> > On Thu, Mar 26, 2020 at 09:36:25AM -0700, Li Wang wrote:
> > > reproduce steps:
> > > 1.
> > > disable CONFIG_STRICT_DEVMEM in linux kernel
> > > 2.
> > > Process A gets a Physical Address of global variable by
> > > "/proc/self/pagemap".
> > > 3.
> > > Process B writes a value to the same Physical Address by mmap():
> > > fd=open("/dev/mem",O_SYNC);
> > > Virtual Address=mmap(fd);
> > Is this just to demonstrate the behaviour, or is this meant to be
> > indicative of a real use-case? I'm struggling to see the latter.
> > 
> > > problem symptom:
> > > after Process B write a value to the Physical Address,
> > > Process A of the value of global variable does not change.
> > > They both W/R the same Physical Address.
> > If Process A is not using the same attributes as process B, there is no
> > guarantee of coherency. How did process A map this memory?
> 
> 
> about 2 Process:
> 
> Process A:
> 
> the memory is not declared by map function, it is just a global variable.

Then it is exactly as I described previously, and Process A has it
mapped with a Normal Write-Back Cacheable mappping.

Process B requests a mapping of that memory via /dev/mem. It passes the
O_SYNC flag, and to ensure that accesses go to "the underlying hardware"
the kernel makes this mapping Normal Non-Cacheable (which means it
should not look in a cache, or be allocated into one).

The two mappings are not coherent because process A uses the cache, but
process B does not. This is the expected behaviour, consistent with the
semantic of O_SYNC. If you need the two to be coherent, they must both
use the same attributes.

Process B can be coherent with process A if it does *not* pass O_SYNC,
which would give it a Normal Write-Back Cacheable mapping that was
coherent with process A.

> if you agree that O_SYNC flag means "is transferred to the underlying
> hardware",
> 
> the arm64 does not do that:
> 
> when use O_SYNC flag under arm64 arch, it adds write cache feature,

As above, this is not the case. O_SYNC causes the kernel to use a
non-cacheable mapping, where it would normally create a cacheable
mapping. i.e. O_SYNC *removes* cacheability.

It just happens that process A is using a cacheable mapping, which is
the case regardless of what process B does.

Thanks,
Mark.
