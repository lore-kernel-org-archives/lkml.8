Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91348C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2A2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uwpIB3Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgHKJVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgHKJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:21:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hm4JdNf7SM0QMQOFD/GVqjWP012kTgNDcYqFU8vfr/U=; b=uwpIB3NtbdqSI+ux4wqwNcFt1S
        n1zKP3ACsnDJQpYDLP+p6yoYmCE2G3vyYa2Rp9BEOTJuP4mwZR0X6NoUcCOXsXzWBOjtSYLUneDmV
        XfDgrNRL75yJb0MH9RXp30nGJxhgREaLVjZG1cOiuBKJpLYpnXyj3CmdXrCUwv4TNa21R4gMiU/TN
        zqE1QbNg3KdDlK4btbqYQnPsCRYQRzrj//c/HlUhbOdWb2B6UVwB7s0u4TodxyBBp+XzYAwfLOnsN
        nmw7lqNXFp0sYzAE5//4+e13eMMHcfZUGGB73WZC4myB4WtFAJ2uQLg+fFPV8jb33Bji1fLEzo7RL
        BABqdmMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5QSn-0001tP-Lq; Tue, 11 Aug 2020 09:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28822300DAE;
        Tue, 11 Aug 2020 11:20:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1982020BFC4E5; Tue, 11 Aug 2020 11:20:54 +0200 (CEST)
Date:   Tue, 11 Aug 2020 11:20:54 +0200
From:   peterz@infradead.org
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200811092054.GB2674@hirez.programming.kicks-ass.net>
References: <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:38:50AM +0200, Jürgen Groß wrote:
> In case you don't want to do it I can send the patch for the Xen
> variants.

I might've opened a whole new can of worms here. I'm not sure we
can/want to fix the entire fallout this release :/

Let me ponder this a little, because the more I look at things, the more
problems I keep finding... bah bah bah.
