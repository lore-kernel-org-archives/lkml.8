Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A534C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4068F207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lfh1np1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGJNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGJNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:21:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC74C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:21:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so5115651qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jgg9a+wNuaByaM8m8spDFI4u6Tz5SQd7zmlaEogWrcg=;
        b=lfh1np1Npp8Y0McpJPnqEC+BEN77yS7UxExMxSPgmDPP2HzUkdcuyLklR44E7rFUOg
         bvRPbmQrccwm5XJumpZID2QOARfZ/Q8sP6Bmb522REXT78YQMOLrmhm20iwgzjowvWvK
         naN7WxYOhFE21tiP4pd1WNHxKEOUGFbUh3T/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgg9a+wNuaByaM8m8spDFI4u6Tz5SQd7zmlaEogWrcg=;
        b=i0USSDaFlVLFAuhKUDS7XbLWkZAMzx1fH8xa/2cNLGc0QTY1u8x/BSObXXRPGRUv1P
         8PhUuZjgzHUa4DNcNKph6ThodJHkv1c38GGIzq/KFyEALvn0oKrJ1r0o6eaAHSdxf2uZ
         gFrOQOiev+Aw1unzDjA3ZNcQX7qewp8McuP9xB1BYMgxCXVVIc7FoSzl3Y5CpVNowQ4x
         jgF1Ned7NiQqV9q3RACrBt6FebNdYF50fBGrzBYPGY20i7LLvMfW6NwBUPZ9XOpbcnps
         Xc/nIM1ol7ZpsblDpJBw8W3iPBOPuwW7wMfUvqPkH3Llb7UsTxi+R3xUX20BKS4oQIjS
         KkFg==
X-Gm-Message-State: AOAM533C84hJcDmNDkfEbIoaaPRNpYt9O32a6ntNAh5GeZ1lkYSurR+j
        zgu1h2FG85MshHgpw+XQZt33wg==
X-Google-Smtp-Source: ABdhPJxNJJu55GMBgAvbl3+Af/VrLkatLoTC23priaMD3kvVC7Ux31GUQkx4NT1wmD+XFZ4UuWXbNQ==
X-Received: by 2002:ae9:f444:: with SMTP id z4mr67887427qkl.80.1594387290664;
        Fri, 10 Jul 2020 06:21:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b186sm7532732qkd.28.2020.07.10.06.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:21:30 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:21:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
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
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
Message-ID: <20200710132129.GA303583@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:19:24PM +0800, Li, Aubrey wrote:
> Hi Joel/Vineeth,
> 
> On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > With current core scheduling patchset, non-threaded IRQ and softirq
> > victims can leak data from its hyperthread to a sibling hyperthread
> > running an attacker.
> > 
> > For MDS, it is possible for the IRQ and softirq handlers to leak data to
> > either host or guest attackers. For L1TF, it is possible to leak to
> > guest attackers. There is no possible mitigation involving flushing of
> > buffers to avoid this since the execution of attacker and victims happen
> > concurrently on 2 or more HTs.
> > 
> > The solution in this patch is to monitor the outer-most core-wide
> > irq_enter() and irq_exit() executed by any sibling. In between these
> > two, we mark the core to be in a special core-wide IRQ state.
> > 
> > In the IRQ entry, if we detect that the sibling is running untrusted
> > code, we send a reschedule IPI so that the sibling transitions through
> > the sibling's irq_exit() to do any waiting there, till the IRQ being
> > protected finishes.
> > 
> > We also monitor the per-CPU outer-most irq_exit(). If during the per-cpu
> > outer-most irq_exit(), the core is still in the special core-wide IRQ
> > state, we perform a busy-wait till the core exits this state. This
> > combination of per-cpu and core-wide IRQ states helps to handle any
> > combination of irq_entry()s and irq_exit()s happening on all of the
> > siblings of the core in any order.
> > 
> > Lastly, we also check in the schedule loop if we are about to schedule
> > an untrusted process while the core is in such a state. This is possible
> > if a trusted thread enters the scheduler by way of yielding CPU. This
> > would involve no transitions through the irq_exit() point to do any
> > waiting, so we have to explicitly do the waiting there.
> > 
> > Every attempt is made to prevent a busy-wait unnecessarily, and in
> > testing on real-world ChromeOS usecases, it has not shown a performance
> > drop. In ChromeOS, with this and the rest of the core scheduling
> > patchset, we see around a 300% improvement in key press latencies into
> > Google docs when Camera streaming is running simulatenously (90th
> > percentile latency of ~150ms drops to ~50ms).
> > 
> > This fetaure is controlled by the build time config option
> > CONFIG_SCHED_CORE_IRQ_PAUSE and is enabled by default. There is also a
> > kernel boot parameter 'sched_core_irq_pause' to enable/disable the
> > feature at boot time. Default is enabled at boot time.
> 
> We saw a lot of soft lockups on the screen when we tested v6.
> 
> [  186.527883] watchdog: BUG: soft lockup - CPU#86 stuck for 22s! [uperf:5551]
> [  186.535884] watchdog: BUG: soft lockup - CPU#87 stuck for 22s! [uperf:5444]
> [  186.555883] watchdog: BUG: soft lockup - CPU#89 stuck for 22s! [uperf:5547]
> [  187.547884] rcu: INFO: rcu_sched self-detected stall on CPU
> [  187.553760] rcu: 	40-....: (14997 ticks this GP) idle=49a/1/0x4000000000000002 softirq=1711/1711 fqs=7279 
> [  187.564685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 14
> [  187.564723] NMI watchdog: Watchdog detected hard LOCKUP on cpu 38
> 
> The problem is gone when we reverted this patch. We are running multiple
> uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> This is 100% reproducible on our side.

Interesting. I am guessing you are not doing any hotplug since those fixes
were removed from v6 to expose those hotplug issues..

The last known lockups with this patch were fixed. Appreciate if you can dig
in more and provide logs/traces. The last one I remember was:

HT1                                  HT2
                                     irq_enter()
				     	- sets the core-wide flag
<softirq running>                    
      acquires a lock.
  <gets irq>
  irq_enter() - do nothing.
  irq_exit() - busy wait on flag.
                                     irq_exit()
				       <softirq running>
				       acquire a lock and deadlock.

The fix was to call sched_core_irq_enter() when you enter enter a softirq
from paths other than irq_exit().

Other than this one, we have not seen lockups in heavy testing over the last
2 months since we redesigned this patch to enter the 'private state' on the
outer-most core-wide sched_core_irq_enter().

thanks,

 - Joel

