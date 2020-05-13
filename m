Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71ECA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA60206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589373890;
	bh=uAIR238kltra+SBbeNiqUTosaKpQQwrCI0UhLqBMhnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zEMMPBVBmeUHz3369xGhNSRsNzuUoojOH0Qh2he4f4FQI+Ar+U3S34pVmSH4voJkq
	 WISE4juZcMsQfSrIkQTdYkxbvYR/lzO2WF4EwkZFupVVyxU75gO7XfBDsapfUNFZud
	 Hgx39ByXW85TTMFkrurh2Q7EOmRTjbQ0Ay8LwBgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgEMMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731920AbgEMMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:44:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B004A20659;
        Wed, 13 May 2020 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589373887;
        bh=uAIR238kltra+SBbeNiqUTosaKpQQwrCI0UhLqBMhnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS6FBz46UEP++I50dUNoB0NMigkqgm0GsqkbCmMBH+OLPseBPy4v+vkKyXXh9pT8Y
         q+kwjMN/3H9lm8+xXLI58GOjhp74Vs6tgjLWAGiLxGmuuqoMK6IQtCqcb3WgogOSNt
         NuzBaMt+peaSTLT0lA1hFACP0VX8EZS+5muWFAr4=
Date:   Wed, 13 May 2020 14:44:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com,
        dmitry.torokhov@gmail.com, ebiederm@xmission.com, hpa@zytor.com,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: WARNING in memtype_reserve
Message-ID: <20200513124445.GA1082735@kroah.com>
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509074507.GC1831917@kroah.com>
 <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:00:57PM +0200, Thomas Gleixner wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Sat, May 09, 2020 at 12:20:14AM -0700, syzbot wrote:
> >> memtype_reserve failed: [mem 0xffffffffff000-0x00008fff], req write-back
> >> WARNING: CPU: 1 PID: 7025 at arch/x86/mm/pat/memtype.c:589 memtype_reserve+0x69f/0x820 arch/x86/mm/pat/memtype.c:589
> >
> > So should memtype_reserve() not do a WARN if given invalid parameters as
> > it can be triggered by userspace requests?
> >
> > A normal "invalid request" debug line is probably all that is needed,
> > right?
> 
> I disagree. The callsite espcially if user space triggerable should not
> attempt to ask for a reservation where start > end:
> 
>   >> memtype_reserve failed: [mem 0xffffffffff000-0x00008fff], req write-back
> 
> The real question is which part of the call chain is responsible for
> this. That needs to be fixed.

This is caused by 2bef9aed6f0e ("usb: usbfs: correct kernel->user page
attribute mismatch") which changed a call to remap_pfn_range() to
dma_mmap_coherent().  Looks like the error checking in remap_pfn_range()
handled the invalid options better than dma_mma_coherent() when odd
values are passed in.

We can add the check to dma_mmap_coherent(), again, but really, this
type of check should probably only be needed in one place to ensure we
always get it correct, right?

thanks,

greg k-h
