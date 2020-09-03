Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3506920665
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgICFqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:46:21 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:49112 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:46:20 -0400
Date:   Thu, 3 Sep 2020 01:46:18 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-ID: <20200903054617.GW3265@brightrain.aerifal.cx>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
 <20200828163057.GY3265@brightrain.aerifal.cx>
 <82b625c2-23cb-69a4-7495-39427430c306@physik.fu-berlin.de>
 <20200828170259.GZ3265@brightrain.aerifal.cx>
 <20200829004939.GB3265@brightrain.aerifal.cx>
 <b0e38ede-3860-eb83-615e-ad77f619a3a6@physik.fu-berlin.de>
 <20200903035603.GV3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903035603.GV3265@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:56:04PM -0400, Rich Felker wrote:
> On Sat, Aug 29, 2020 at 01:09:43PM +0200, John Paul Adrian Glaubitz wrote:
> > Hi!
> > 
> > On 8/29/20 2:49 AM, Rich Felker wrote:
> > > This restored my ability to use strace
> > 
> > I can confirm that. However ...
> > 
> > > and I've written and tested a minimal strace-like hack using
> > > SECCOMP_RET_USER_NOTIF that works as
> > > expected on both j2 and qemu-system-sh4, so I think the above is
> > > correct.
> > 
> > The seccomp live testsuite has regressed.
> > 
> > [...]
> > Test 58-live-tsync_notify%%001-00001 result:   FAILURE 58-live-tsync_notify 6 ALLOW rc=14
> 
> This is similar to 51.
> 
> I think the commonality of all the failures is that they deal with
> return values set by seccomp filters for blocked syscalls, which are
> getting clobbered by ENOSYS from the failed syscall here. So I do need
> to keep the code path that jumps over the actual syscall if
> do_syscall_trace_enter returns -1, but that means
> do_syscall_trace_enter must now be responsible for setting the return
> value in non-seccomp failure paths.
> 
> I'll experiment to see what's still needed if that change is made.

OK, I think I have an explanation for the mechanism of the bug, and it
really is a combination of the 2008 bug (confusion of r0 vs r3) and
the SECCOMP_FILTER commit. When the syscall_trace_entry code path is
in use, a syscall with argument 5 having value -1 causes
do_syscall_trace_enter to return -1 (because it returns regs[0], which
contains argument 5), which the change in entry-common.S interprets as
a sign to skip the syscall and jump to syscall_exit, and things blow
up from there. In particular, SYS_mmap2 is almost always called with
-1 as the 5th argument (fd), and this is even more common on nommu
where SYS_brk does not work.

I'll follow up with a new proposed patch.

Rich
