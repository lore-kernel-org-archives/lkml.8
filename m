Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22EF20644
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgFPO5V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgFPO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:57:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:57:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jlD1Q-0007u0-7x; Tue, 16 Jun 2020 16:57:08 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 76D76100F18; Tue, 16 Jun 2020 16:57:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: Re: [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de> <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
Date:   Tue, 16 Jun 2020 16:57:07 +0200
Message-ID: <87ftav2h4s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On Jun 16, 2020, at 1:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> ﻿kernel test robot <rong.a.chen@intel.com> writes:
>>> FYI, we noticed the following commit (built with gcc-9):
>>> 
>>> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> 
>> Is the head of linux.git exposing the same problem or is this an
>> intermittent failure, which only affects bisectability?
>
> It sure looks deterministic:
>
> ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"

Hahahaha. But not only LTP, also LKP-tests makes assumptions:

  monitors/irq_exception_noise:[ "$exception" -eq "1" ] && export ftrace_filters='__do_page_fault do_divide_error do_overflow do_bounds do_invalid_op do_device_not_available do_double_fault do_coprocessor_segment_overrun do_invalid_TSS do_segment_not_present do_spurious_interrupt_bug do_coprocessor_error do_alignment_check do_simd_coprocessor_error do_debug do_stack_segment do_general_protection'

stable-api-nonsense.rst comes to my mind.

Thanks,

        tglx

