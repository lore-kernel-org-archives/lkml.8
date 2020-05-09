Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB27C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A781221655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEINl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:41:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36917 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726782AbgEINl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:41:56 -0400
Received: (qmail 4958 invoked by uid 500); 9 May 2020 09:41:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2020 09:41:55 -0400
Date:   Sat, 9 May 2020 09:41:55 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <dmitry.torokhov@gmail.com>, <ebiederm@xmission.com>,
        <hpa@zytor.com>, <jeremy.linton@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <luto@kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <syzkaller-bugs@googlegroups.com>, <x86@kernel.org>
Subject: Re: WARNING in memtype_reserve
In-Reply-To: <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
Message-ID: <Pine.LNX.4.44L0.2005090939210.4307-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020, Thomas Gleixner wrote:

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

What about all the other ways in which a reservation request could be
invalid?  The MM core already checks for these; what point is there in
duplicating these checks in many places higher up the call chain?

Alan Stern

