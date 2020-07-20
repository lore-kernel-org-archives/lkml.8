Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E980DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B2F22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBAuFIAt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvNQHsAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGTIUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:20:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:20:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595233247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uV35zE6Qu7KCAMZlz46iC3uSUkXeF78C2Fgm6xYGxv4=;
        b=LBAuFIAtcHGfriAPEwgGKrOg+VTbpmBWLGiTQD1jJSdqSqwiFrueczjk3ckuoH+XbVeICE
        05ui2+THBxoLgXciGrEEPuTyLw/AJXrwdDBcuFYLmeV5avgUhXR0dGIntMLHFxdn1o9Jxz
        OKg1D/DGEySEsbCmsFqrVGGAXJziHwMJ10+hh5vvK5ICQb9H+bdJARTukybLSNqzl1TJkW
        e5DAJrNXGZkda428/2+miL9byh1KXUbss/hUsDE4Ta0K5J6nz+wLGfn2kETtF+eIUmhIAt
        oxgonFotei+R0f9XplvDcQ8kNtp859g63NOlWPvEfQQTWJ+iAi/fL/5dGPXknQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595233247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uV35zE6Qu7KCAMZlz46iC3uSUkXeF78C2Fgm6xYGxv4=;
        b=tvNQHsAmSaK96tu7ExPVT8bJjlQIVZKAswyi3T0rBdci/PoEA2AKUZH20tRdtaBiwlSl/Q
        NhMBQzEKonVrPwDg==
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of IRQ and softirq
In-Reply-To: <20200720035359.GA4187092@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com> <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com> <871rl9r9xr.fsf@nanos.tec.linutronix.de> <20200720035359.GA4187092@google.com>
Date:   Mon, 20 Jul 2020 10:20:46 +0200
Message-ID: <877duyoaw1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

Joel Fernandes <joel@joelfernandes.org> writes:
> On Sat, Jul 18, 2020 at 01:36:16AM +0200, Thomas Gleixner wrote:
>> 
>> The entry case condition wants to have a TIF bit as well, i.e.
>> 
>>     if (thread_test_bit(TIF_CORE_SCHED_REQUIRED) {
>>           sched_ipi_dance() {
>>              if (other_sibling_in_user_or_guest())
>>                 send_IPI();
>>           }
>>     }
>
> I did not understand this bit. Could you explain more about it? Are you
> talking about the IPIs sent from the schedule() loop in this series?

Nah, let me try again. If two tasks are out in user space (or guest
mode) and they fall under the isolation rule that they either are both
in user space or both in the kernel then you tag both with
TIF_CORE_SCHED_REQUIRED or whatever bit is appropriate.

So in entry from user you do:

	if (thread_test_bit(TIF_CORE_SCHED_REQUIRED))
		sched_orchestrate_entry();

void sched_orchestrate_entry(void)
{
	if (other_sibling_in_user_or_guest())
        	send_IPI_to_sibling();
}

That IPI brings the sibling out of user or guest mode.

On the way back to user/guest you do:

	if (thread_test_bit(TIF_CORE_SCHED_REQUIRED))
		sched_orchestrate_exit();

void sched_orchestrate_exit(void)
{
	while (other_sibling_in_kernel())
        	twiddle_thumbs();
}

Hope that clarifies it.

Thanks,

        tglx
