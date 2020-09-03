Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10678C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB55220716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5+eMttK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RPnv78iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgICOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgICORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:17:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73910C06124F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:20:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599139235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlmKNWMgLecZ7IZVjKa2uNGFu74idhqEN3ZR1C/9OfE=;
        b=d5+eMttKFsL0mRRdhiTxA5U3GUpBwPSu4rEMWvLVxE+Nmpk/iQBb3ZEHZRcy4uc2ZUia2X
        FeH0zmOitqZQ2ssdtqdTlJyjUc0IC6I3Wm3CE0Om8ADX5k/vylOxoWd17K+hQJV63QXrnO
        LuIXZW7eazCCjQQHgcpjH7U966raD5Apm67AZFxiqgOPMYz4IIXZLkirP2Vqa4VF4kWKKO
        24wCjuLsnI0O/906DXpZYc58XSTJdauzATO7lSmhAOcd32MwrbRRDOqJ7RtqyztyMPKvhf
        Ks/3dk7VeyF1MHtHpkKZk1xp1xcKrl0N2LQ1jgLm2pvNrVLogcuwtXyktrnO8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599139235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlmKNWMgLecZ7IZVjKa2uNGFu74idhqEN3ZR1C/9OfE=;
        b=RPnv78iHZRi8ksW21XdT39Z9PjbFJdVijhwbsn4sD4ZCpNtfr+9NnfgP6ZNnDsIXtcB9oG
        qn8joOhJd+bEzODQ==
To:     Joel Fernandes <joel@joelfernandes.org>,
        Dario Faggioli <dfaggioli@suse.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?Q?benbjiang=28=E8=92=8B=E5=BD=AA?= =?utf-8?Q?=29?= 
        <benbjiang@tencent.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide protection of kernel-mode
In-Reply-To: <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com> <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com> <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com> <875z8xl0zh.fsf@nanos.tec.linutronix.de> <20200902012905.GB1703315@google.com> <87h7sgk41y.fsf@nanos.tec.linutronix.de> <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com> <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
Date:   Thu, 03 Sep 2020 15:20:35 +0200
Message-ID: <87wo1buhcs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03 2020 at 00:34, Joel Fernandes wrote:
> On Wed, Sep 2, 2020 at 12:57 PM Dario Faggioli <dfaggioli@suse.com> wrote:
>> 2) protection of the kernel from the other thread running in userspace
>> may be achieved in different ways. This is one, sure. ASI will probably
>> be another. Hence if/when we'll have both, this and ASI, it would be
>> cool to be able to configure the system in such a way that there is
>> only one active, to avoid paying the price of both! :-)
>
> Actually, no. Part of ASI will involve exactly what this patch does -
> IPI-pausing siblings but ASI does so when they have no choice but to
> switch away from the "limited kernel" mapping, into the full host
> kernel mapping. I am not sure if they have yet implemented that part
> but they do talk of it in [1] and in their pretty LPC slides.  It is
> just that ASI tries to avoid that scenario of kicking all siblings out
> of guest mode.  So, maybe this patch can be a stepping stone to ASI.
> At least I got the entry hooks right, and the algorithm is efficient
> IMO (useless IPIs are avoided).  ASI can then come in and avoid
> sending IPIs even more by doing their limited-kernel-mapping things if
> needed. So, it does not need to be this vs ASI, both may be needed.

Right. There are different parts which are seperate:

1) Core scheduling as a best effort feature (performance for certain use
   cases)

2) Enforced core scheduling (utilizes #1 basics)

3) ASI

4) Kick sibling out of guest/host and wait mechanics

#1, #2, #3 can be used stand alone. #4 is a utility

Then you get combos:

A) #2 + #4:

   core wide protection. i.e. what this series tries to achieve.  #3
   triggers the kick at the low level VMEXIT or entry from user mode
   boundary. The wait happens at the same level

B) #3 + #4:

   ASI plus kicking the sibling/wait mechanics independent of what's
   scheduled. #3 triggers the kick at the ASI switch to full host
   mapping boundary and the wait is probably the same as in #A

C) #2 + #3 + #4:

   The full concert, but trigger/wait wise the same as #B

So we really want to make at least #4 an independent utility.

Thanks,

        tglx





