Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DF6208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxEPrEvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCENp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:45:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCENp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:45:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id e18so6118711ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfRXCkijjGukN/t07iDLcTZPJvbGA5z5Fo+H7p/ksAc=;
        b=uxEPrEvkE9IKadewACdH/6OJXeQ+idS/CjBdkFtEQIy58nLJkZ/tvR9ZGKzrUcjHht
         EjoWw2/Lxg5wiE6V3xMln8zVpCMW4CyT+t/ha175mEseW1aQeXepH6lpMoYYA4nUoDvr
         oR63e3aqiwaPIM4vj0tbPHLU6LgxLKHE5WF2xv9q6P6kTXCurB7DRn+NggdficjcHOWL
         0JCegqo30T6C93TDb9rHGtVqurhRfXlVffztDAJjAB/nA3Tdne2Va+POOU/11iEBrNzX
         mFOujBXOW113jSUKvjUG/VOSwlJpXsgzjVKxdvM3PNUCR0jlW69UXG4zqv8UPHekagRG
         6Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfRXCkijjGukN/t07iDLcTZPJvbGA5z5Fo+H7p/ksAc=;
        b=hKwuPvV7LhwdQFC1RMrhpThpQBn9OhpzKwhPEIE1UEQMyTlxnsi5TofV4RerQGJyZi
         HI2WYzsP5kWL4WafaRNP74qxx6B584owWCCbVukgc/W0ZOGuhttAqpJYmPSTTUCMoSuO
         b3tTBYmLX1B/Ficr3Q+b3aaoGPeX750+lXnKmW5dCPjqeiAT++sHOn+BJemZ4Ve/TWDT
         OqRWryN2ri9oBGM4ZbemoEK/T5hEK3wHZINMQaKNFXyw/Jq5IvRTWe52xbekh8A+j3PK
         O7nNZ4RYQyf9IrXMTCgGn8jz23rk0oNpc9cG8TpTJx6ris/jgwRDUdA/VmPVFHXZ3UQt
         GhSg==
X-Gm-Message-State: ANhLgQ1p8V9HfkEkcPLIO8Y+ZhGtE+ZwFA94qZe5XPEZqc7Jp8GhA0WP
        3ZirbjKuP3SKKZ19cN8YDCRxjjbX1BDfeeIelMQ=
X-Google-Smtp-Source: ADFU+vvYhk6BJxrpW1hYOLoYPpjEh3XdRBTbSw50IRau2jY50kd0NsHTRx2JqB8hosgi5HW01+Q6QQfJyzzUpofnFFQ=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr1366333ljg.137.1583415927033;
 Thu, 05 Mar 2020 05:45:27 -0800 (PST)
MIME-Version: 1.0
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain> <20200227141032.GA30178@pauld.bos.csb>
 <20200228025405.GA634650@ziqianlu-desktop.localdomain>
In-Reply-To: <20200228025405.GA634650@ziqianlu-desktop.localdomain>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 5 Mar 2020 21:45:15 +0800
Message-ID: <CAERHkrunq=BqB=NmS2b_BfjePX2+nNpbv1EfTWw5rExbvYHyJw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:54 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> When the core wide weight is somewhat balanced, yes I definitely agree.
> But when core wide weight mismatch a lot, I'm not so sure since if these
> high weight task is spread among cores, with the feature of core
> scheduling, these high weight tasks can get better performance.

It depends.

Say TaskA(cookie 1) and TaskB(cookie1) has high weight,
TaskC(cookie 2) and Task D(cookie 2) has low weight.
And we have two cores 4 CPU.

If we dispatch
- TaskA and TaskB on Core0,
- TaskC and TaskD on Core1,

with coresched enabled, all 4 tasks can run all the time.

But if we dispatch
- TaskA on Core0.CPU0, TaskB on Core1.CPU2,
- TaskC on Core0.CPU1, TaskB on Core1.CPU3,

with coresched enabled, when TaskC is running, TaskA will be forced
off CPU and replaced with a forced idle thread.

Things get worse if TaskA and TaskB share some data and can get
benefit from the core level cache.

> So this appeared to me like a question of: is it desirable to protect/enhance
> high weight task performance in the presence of core scheduling?

This sounds to me a policy VS mechanism question. Do you have any idea
how to spread high weight task among the cores with coresched enabled?

Thanks,
-Aubrey
