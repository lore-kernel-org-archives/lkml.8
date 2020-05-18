Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF31C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00B120657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W2MmwePb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgERNsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:48:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERNsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:48:22 -0400
Received: from zn.tnic (p200300ec2f06e8006d2513699c1ec3e6.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:e800:6d25:1369:9c1e:c3e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B64C61EC011B;
        Mon, 18 May 2020 15:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589809700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr/IVXCwsh0+cseGpLd9ZaZKuurJGFMlWPphXz979TM=;
        b=W2MmwePbiDvOwpghD0Ohf9OU0mgiNCo5yd2QNcryZurMhoVcXYJjUAHYs4QYiuZYL+H5Md
        F+hdNligUmZsirqo5R6twNhLBlZkwU0Z8v5GAOh8dhp8/hgEWuBy5ttYT6SevNx5Igtg0k
        qJ+5mQ8jpi6vICCd7mqsX6oCA+dmgYk=
Date:   Mon, 18 May 2020 15:48:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200518134813.GC25034@zn.tnic>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

lemme try to reply to three emails at once.

First of all, the two of you: pls do not top-post.

On Sat, May 16, 2020 at 6:52 PM Luck, Tony <tony.luck@intel.com> wrote:
> But the guest isn’t likely to do the right thing with a page fault.
> The guest just accessed a page that it knows is poisoned (VMM just told
> it once that it was poisoned). There is no reason that the VMM should
> let the guest actually touch the poison a second time. But if the guest
> does, then the guest should get the expected response. I.e. another
> machine check.

So Jue says below that the VMM has unmapped the guest page from the EPT.
So the guest cannot touch the poison anymore.

How is then possible for the guest to touch it again if the page is not
mapped anymore?

The guest should get a #PF when the page is unmapped and cause a new
page to be mapped.

On Sun, May 17, 2020 at 07:36:00AM -0700, Jue Wang wrote:
> The stack is from guest MCE handler's processing of the first MCE injected.

Aha, so you've flipped the functions order in the trace. It all starts
at

  set_mce_nospec(m->addr >> PAGE_SHIFT);

Now it makes sense.

> Note before the first MCE is injected into guest (i.e., after the host MCE
> handler successfully finished MCE handling and notified VMM via SIGBUS with
> BUS_MCEERR_AR), VMM unmaps the guest page from EPT.

Ok, good.

> The guest MCE handler finished the "normal" MCE handling and recovery
> (memory_failure() in mm/memory_failure.cc) successfully, it's the aftermath
> below leading to the stack trace:
> https://github.com/torvalds/linux/blob/5a9ffb954a3933d7867f4341684a23e008d6839b/arch/x86/kernel/cpu/mce/core.c#L1101

On Sun, May 17, 2020 at 08:33:00AM -0700, Jue Wang wrote:
> In other words, it's the *do_memory_failure -> set_mce_nospec*  flow of
> guest MCE handler acting on the *first* MCE injection. As a result, the
> guest panics and resets *whenever* there is an MCE injected, even when the
> injected MCE is recoverable.

So IIUC that set_mce_nospec() thing should check whether m->addr is
mapped first and only then mark it _uc and whatever monkey business it
does. Not this blanket

  if am I a guest?

test.

Imagine a hypervisor which doesn't set X86_FEATURE_HYPERVISOR, i.e.,
CPUID(1)[EDX, bit 31]?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
