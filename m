Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE872C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3685E2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbgEMQXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEMQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:23:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02247C061A0C;
        Wed, 13 May 2020 09:23:08 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYu9r-0000D7-Ds; Wed, 13 May 2020 18:22:59 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B0730100605; Wed, 13 May 2020 18:22:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com,
        dmitry.torokhov@gmail.com, ebiederm@xmission.com, hpa@zytor.com,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: WARNING in memtype_reserve
In-Reply-To: <20200513124445.GA1082735@kroah.com>
References: <000000000000f0d8d205a531f1a3@google.com> <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de> <20200513124445.GA1082735@kroah.com>
Date:   Wed, 13 May 2020 18:22:58 +0200
Message-ID: <87zhab249p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Sat, May 09, 2020 at 12:00:57PM +0200, Thomas Gleixner wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> > On Sat, May 09, 2020 at 12:20:14AM -0700, syzbot wrote:
>> >> memtype_reserve failed: [mem 0xffffffffff000-0x00008fff], req write-back
>> >> WARNING: CPU: 1 PID: 7025 at arch/x86/mm/pat/memtype.c:589 memtype_reserve+0x69f/0x820 arch/x86/mm/pat/memtype.c:589
>> >
>> > So should memtype_reserve() not do a WARN if given invalid parameters as
>> > it can be triggered by userspace requests?
>> >
>> > A normal "invalid request" debug line is probably all that is needed,
>> > right?
>> 
>> I disagree. The callsite espcially if user space triggerable should not
>> attempt to ask for a reservation where start > end:
>> 
>>   >> memtype_reserve failed: [mem 0xffffffffff000-0x00008fff], req write-back
>> 
>> The real question is which part of the call chain is responsible for
>> this. That needs to be fixed.
>
> This is caused by 2bef9aed6f0e ("usb: usbfs: correct kernel->user page
> attribute mismatch") which changed a call to remap_pfn_range() to
> dma_mmap_coherent().  Looks like the error checking in remap_pfn_range()
> handled the invalid options better than dma_mma_coherent() when odd
> values are passed in.
>
> We can add the check to dma_mmap_coherent(), again, but really, this
> type of check should probably only be needed in one place to ensure we
> always get it correct, right?

That might be correct for this particular call chain, but this check
really is the last defense before stuff goes down the drain. None of the
last line functions should ever be reached with crappy arguments.

Thanks,

        tglx
