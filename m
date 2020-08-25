Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5878EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3795920715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyqzKxzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCNaNP2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgHYKoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYKob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:44:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B2C061574;
        Tue, 25 Aug 2020 03:44:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598352270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaSnuDwRn2e4Hta1oGrGIYC52mweFdeQMzeRaFMJpUs=;
        b=oyqzKxzp4iU6QuQ0GvCsPc3e1Pvw3TzzsZ5d97IJLH1aVK87mkMueHJYx5tla8JmQI1M7B
        uKh8POxc0FNwluI0oKUnBX0wiGsWWdV+7Vk1IoBeMfkPYNALWOFbTHYhq3421trHlDPpVY
        87EKt5gW7BESzx5jDDcmsTfBAWw6G+qMH4fp4DpX4qhzujXRqWHh5PO+yUltGdhjUpxgFr
        uQg1wIIC0ApI0PKLOc5N17dUUmYxRfHU5X66D+c31qI5M+Z/jlZ+tzBq2EjGx6pjszvR0E
        S6MIbkbmNZGG7H1V1/6iyIKEocYXUwCKr4kN/Kg7+Oy9zISB8YrtvGhIOyJevA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598352270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaSnuDwRn2e4Hta1oGrGIYC52mweFdeQMzeRaFMJpUs=;
        b=hCNaNP2MxvMZjWhc53F6DQIOmBWGvvCn/J67GUDqPauRKOVVHV+xjeUOdGwXcgEf5HCWgf
        2SLLTCBMSRM1dyAQ==
To:     Brian Gerst <brgerst@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM
In-Reply-To: <CAMzpN2h79bi5dd7PxjY45xYy71UdYomKa1t2gNxLtRpDkMs+Lw@mail.gmail.com>
References: <20200821105229.18938-1-pbonzini@redhat.com> <20200821142152.GA6330@sjchrist-ice> <CAMzpN2h79bi5dd7PxjY45xYy71UdYomKa1t2gNxLtRpDkMs+Lw@mail.gmail.com>
Date:   Tue, 25 Aug 2020 12:44:29 +0200
Message-ID: <874kor57jm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21 2020 at 11:35, Brian Gerst wrote:
> On Fri, Aug 21, 2020 at 10:22 AM Sean Christopherson
>> >  .macro GET_PERCPU_BASE reg:req
>> > -     ALTERNATIVE \
>> > -             "LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
>> > -             "RDPID  \reg", \
>>
>> This was the only user of the RDPID macro, I assume we want to yank that out
>> as well?
>
> No.  That one should be kept until the minimum binutils version is
> raised to one that supports the RDPID opcode.

The macro is unused and nothing in the kernel can use RDPID as we just
established.

Thanks,

        tglx

