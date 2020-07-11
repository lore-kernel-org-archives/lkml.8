Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82760C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF520725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JpbZOZFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgGKSWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgGKSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:22:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01195C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=O4vjkbDm1sMfQr4f2tnez5VnmMDKCxziIGN8kPzcby0=; b=JpbZOZFmfvINWxOyXDbYeOnyHn
        Is7RyrIe4BfsbSG7bpScYKXWVw4IRr8cVsvXEgSlAc/LFUkaz/zrjKbwBaFp3ar+RT7eBJSRopOQ2
        2pFpWqderBy5ozavOCFOpJ8I5ZBAEsbSgRRX40KEZvXzDj1zDqmRX/kNVcLrO5AIwlWlmH/0pLfjo
        /tW3mUKJk3xeW61x53CYEIwj4lgf0CvQhVqBPO+ok2NphSbd5ObR/ZiNWdZib5r5qnRBUVjP2NDUJ
        y+QR/FsdOjwdDzfIdQSFGt8dvPDYX13tPljdMXegv4e7W/g500MzVgcI9BbkuiaSHjDgdQjjZH6g7
        Vcm+1/OQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juK8N-0006VV-N7; Sat, 11 Jul 2020 18:22:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41B39304E03;
        Sat, 11 Jul 2020 20:21:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 280992367D09C; Sat, 11 Jul 2020 20:21:58 +0200 (CEST)
Date:   Sat, 11 Jul 2020 20:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     pbonzini@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        xiaoyao.li@intel.com, fenghua.yu@intel.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kvm crash on 5.7-rc1 and later
Message-ID: <20200711182158.GF597537@hirez.programming.kicks-ass.net>
References: <9178ae3e-db32-c64b-7caf-737f3bc3ba8e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9178ae3e-db32-c64b-7caf-737f3bc3ba8e@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:15:31AM -0400, Woody Suwalski wrote:
> I am observing a 100% reproducible kvm crash on kernels starting with
> 5.7-rc1, always with the same opcode 0000.
> It happens during wake up from the host suspended state. Worked OK on 5.6
> and older.
> The host is based on Debian testing, Thinkpad T440, i5 cpu.
> 
> [   61.576664] kernel BUG at arch/x86/kvm/x86.c:387!
> [   61.576672] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   61.576678] CPU: 0 PID: 3851 Comm: qemu-system-x86 Not tainted 5.7-pingu
> #0
> [   61.576680] Hardware name: LENOVO 20B6005JUS/20B6005JUS, BIOS GJETA4WW
> (2.54 ) 03/27/2020
> [   61.576700] RIP: 0010:kvm_spurious_fault+0xa/0x10 [kvm]
> 
> Crash results in a dead kvm and occasionally a very unstable system.
> 
> Bisecting the problem between v5.6 and v5.7-rc1 points to
> 
> commit 6650cdd9a8ccf00555dbbe743d58541ad8feb6a7
> Author: Peter Zijlstra (Intel) <peterz@infradead.org>
> Date:   Sun Jan 26 12:05:35 2020 -0800
> 
>     x86/split_lock: Enable split lock detection by kernel
> 
> Reversing that patch seems to actually "cure" the issue.
> 
> The problem is present in all kernels past 5.7-rc1, however the patch is not
> reversing directly in later source trees, so can not retest the logic on
> recent kernels.
> 
> Peter, would you have idea how to debug that (or even better - would you
> happen to know the fix)?
> 
> I have attached dmesg logs from a "good" 5.6.9 kernel, and then "bad" 5.7.0
> and 5.8-rc3

I have no clue about kvm. Nor do I actually have hardware with SLD on.
I've Cc'ed a bunch of folks who might have more ideas.
