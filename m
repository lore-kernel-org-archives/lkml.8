Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3941421707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgF0MXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:23:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgF0MXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:23:37 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jp9ro-0001ja-RZ; Sat, 27 Jun 2020 12:23:32 +0000
Date:   Sat, 27 Jun 2020 14:23:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org, lkp@lists.01.org
Subject: Re: [fork] 11689456e6: ltp.clone302.fail
Message-ID: <20200627122332.ki2otaiw3v7wndbl@wittgenstein>
References: <20200622234326.906346-2-christian.brauner@ubuntu.com>
 <20200627082748.GM5535@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200627082748.GM5535@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 04:27:48PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 11689456e6df828b7917a558a36212e68fa9aa69 ("[PATCH 01/17] fork: fold legacy_clone_args_valid() into _do_fork()")
> url: https://github.com/0day-ci/linux/commits/Christian-Brauner/arch-remove-do_fork-and-HAVE_COPY_THREAD_TLS/20200623-080105
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/sparc.git master
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: syscalls_part1
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> <<<test_start>>>
> tag=clone302 stime=1593153327
> cmdline="clone302"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_buffers.c:55: INFO: Test is using guarded buffers
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> clone302.c:92: PASS: invalid args: clone3() failed as expected: EFAULT (14)
> clone302.c:92: PASS: zero size: clone3() failed as expected: EINVAL (22)
> clone302.c:92: PASS: short size: clone3() failed as expected: EINVAL (22)
> clone302.c:92: PASS: extra size: clone3() failed as expected: EFAULT (14)
> clone302.c:92: PASS: sighand-no-VM: clone3() failed as expected: EINVAL (22)
> clone302.c:92: PASS: thread-no-sighand: clone3() failed as expected: EINVAL (22)
> clone302.c:92: PASS: fs-newns: clone3() failed as expected: EINVAL (22)
> clone302.c:92: PASS: invalid pidfd: clone3() failed as expected: EFAULT (14)
> clone302.c:92: PASS: invalid childtid: clone3() failed as expected: EFAULT (14)
> clone302.c:88: FAIL: invalid parenttid: clone3() should fail with EFAULT: EINVAL (22)

In short, this is a change in failure behavior for clone3() I did expect
and am willing to risk. Here's why in the short form:
- clone3() is extremely new
- this failed before
- setting both CLONE_PIDFD and CLONE_PARENT_SETTID is extremely rare
  (haven't seen it in any codebases I know that use clone3())
- setting both CLONE_PIDFD and CLONE_PARENT_SETTID __and__ pointing them
  to the same adress doesn't work
  (haven't seen it in any codebases I know that use clone3() but see
  some more notes on that below)
- the change makes a special case go away and simplifies multiple
  call-sites

So a few notes about the test. I did stare at it for a while and was
confused why you expect EFAULT to be returned when CLONE_PARENT_SETTID
is set to an invalid memory address. Because that doesn't make sense.
When the parent tid is written to the memory location for
CLONE_PARENT_SETTID we're past the point of no return of process
creation, i.e. the return value from put_user() isn't checked and can't
be checked anymore so you'd never receive EFAULT for a bogus parent_tid
memory address. This is not something new. This has been the case since
the introduction of pid namespaces and specifically since commit
30e49c263e36 ("pid namespaces: allow cloning of new namespace").

But then it dawned on me. You're setting CLONE_PIDFD |
CLONE_PARENT_SETTID and you're pointing:
- args->parent_tid	= <invalid-address>
- args->pidfd		= NULL
so the EFAULT you've seen so far in your test-suite has never been for
CLONE_PARENT_SETTID but for CLONE_PIDFD since that value is written
before the point of no return and consequently put_user() is checked and
the EFAULT is surfaced. So independent of that issue here you might want
to adapt that test so it really tests what you want. :) (And maybe it's
worth documenting on the manpage for clone{3}() that failures for
CLONE_PARENT_SETTID and CLONE_CHILD_SETTID are not seen.)

(Also, note that for some reason, args->pidfd and pargs->parent_tid
must've ended up pointing to the same address in your test-suite. So my
guess is that args->pidfd pointed to garbage which got turned into a
useable address after tst_get_bad_addr() returned &invalid_address.
Maybe I'm missing something subtle though.)

Christian
