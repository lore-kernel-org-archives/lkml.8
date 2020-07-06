Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2376C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E01120715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPvISo3L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJ0oiGCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgGFPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGFPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:15:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC34C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:15:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594048501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsNO+/1JsvNJbroP7auXk8XsvL1r19S8fjPApteHYN8=;
        b=EPvISo3L8lTW3nOG0l4QQjdLDPqehXQWSPg0uYBgQTwb/2KQxNxocE0nezNIW5Nq/KVq6B
        TXH102N4t2a5WS8VwMNASYBNsgk67x/zpJ7XEnRKaugcvYhV8meFiXbPG78mBYFwaeQAxv
        zg+zd4gXAqmNkBikmYsIrdMRJ2D3yFBElYFkh8HO5ujoWdFgoKJzSi53fj6vBd3nDbvLV4
        rIENbVz7M85G4SO8HBc9GLb6Wr6KwfUOfzcPy+88EuRleXoCxdVmDqMoWg1KypPYvkXwUQ
        t9MTuN+PUKLCPXmh6cKnGhfsI8DSUQpcI/eOvlW7ExDWJCmqoHnXeKP/+wTAzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594048501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsNO+/1JsvNJbroP7auXk8XsvL1r19S8fjPApteHYN8=;
        b=QJ0oiGCoBT5kpWsl8vz/8h8yGNN+XQ7VSxBpK8tMLdSxgUOfZB3+GWDcizxQgEQ4YgVBlH
        9ZrSQdbAF/oaEwDw==
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH RFC 0/7] CPU feature evaluation after microcode late loading
In-Reply-To: <20200702184216.GG3575@linux.intel.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com> <20200702184216.GG3575@linux.intel.com>
Date:   Mon, 06 Jul 2020 17:15:00 +0200
Message-ID: <87r1tor7yj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Thu, Jul 02, 2020 at 06:18:20PM +0300, Mihai Carabas wrote:
>> This RFC patch set aims to provide the ability to re-evaluate all CPU
>> features and take proper bug mitigation in place after a microcode
>> late loading.
>> 
>> This was debated last year and this patch set implements a subset of
>> point #2 from Thomas Gleixner's idea:
>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

An incomplete and dangerous subset.

> KVM aside, it wouldn't surprise in the least if there is other code in the
> kernel that captures bug state locally.  This series feels like it needs a
> fair bit of infrastructure to either detect conflicting usage at build time
> or actively prevent consuming stale state at runtime.
>
> There's also the problem of the flags being exposed to userspace via
> /proc/cpuinfo, though I suppose that's userspace's problem to not shoot
> itself in the foot.

User space is the least of my worries. Inconsistent kernel state as I
described in my mail referenced above is the far more dangerous issue.

And just reevaluating some bits is not covering the whole
problem. Microcode can bring substantial changes and as long as we don't
have any clear advise and documentation from the vendors it's all
wishful thinking.

Thanks,

        tglx
