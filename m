Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F788C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0B020714
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvDBDquH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFCl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:41:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42440 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCFCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:41:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so361066pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ybwuAO+dxcFKGdRu+UMo3hrueD2iw1ldBlmuuV7eqeo=;
        b=lvDBDquHuWLf//VjlWapEVpykhcml4E40Z4woVLPUjf7T9rfmfs+JqNe+LPYcoAddm
         G3ofnRUuT0BhRDTVLuddKrSFf14y7AokRrnFbP1XhIvODq+8cAPmlOtKLTMqmiIqT+4i
         OC2Yf6jtH//bC1NBuktFeswv0zT8Br4uEXbs+cRnf/fZmBbm0KJhBHojKi7d3umxcBG7
         wJQRZDNipvmAhPoBXVfqGcIVrU3RV3VIy2h793viWWg1fwK3MdXthBJzTsdlN0Z5fp9X
         nWv2aK6R+0gW/UjB2hEEHBKUxvCphLQgcHulTARBx/acgwzch0Yks3jPn9DoSbSa5HLU
         a5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ybwuAO+dxcFKGdRu+UMo3hrueD2iw1ldBlmuuV7eqeo=;
        b=uJOzlEQVA7XpPUmgDaTh7TjGEYjVi6ga/8ByNw5SdP1WuYiYfD1bRENSVJYSgnddFU
         606vnS+vqwBrhjXZe720YPsMWuQ4Y5zfx3iBaR9+1KQj6kw04mEAJaw/dDGW9aNKPqWa
         wRvA5+YEL2EcaY7qTNG1Bma7KgzCXJIYpZxjAHXt0ozXn5th85n3sIqAsF0j9TYZzNS5
         o4XVvWtL+SYpxvsU4O2ssS8Ab2/H8E2QEPBP2EmC3GlJlH8qHEE1SK3yUFkSqj6YGmi8
         CDwM07F12FN5YPWZD/9cE+BkYYJRa7ZfndPowBnQf03qC/uKZ7wxf9DhSBeYXsMx1+yu
         Vkzg==
X-Gm-Message-State: ANhLgQ2rwjy9WgXYdqo+k0bKVpLLy0SUAwoIYAejUpLBRVvdtmnWnt9S
        f7NtIfZJWRoJgcLDmx0NqjA=
X-Google-Smtp-Source: ADFU+vtBSVoaXvM2y4RkXJrZpfpCILIHtsfS0tQ51RwCnyApHGwq6c/WkoPnjpJCBWqKdwuH7kQfFw==
X-Received: by 2002:a63:1044:: with SMTP id 4mr1190082pgq.412.1583462486335;
        Thu, 05 Mar 2020 18:41:26 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id q8sm7631575pje.2.2020.03.05.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:41:25 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:41:16 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
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
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200306024116.GA16400@ziqianlu-desktop.localdomain>
References: <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain>
 <20200227141032.GA30178@pauld.bos.csb>
 <20200228025405.GA634650@ziqianlu-desktop.localdomain>
 <CAERHkrunq=BqB=NmS2b_BfjePX2+nNpbv1EfTWw5rExbvYHyJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrunq=BqB=NmS2b_BfjePX2+nNpbv1EfTWw5rExbvYHyJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:45:15PM +0800, Aubrey Li wrote:
> On Fri, Feb 28, 2020 at 10:54 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
> >
> > When the core wide weight is somewhat balanced, yes I definitely agree.
> > But when core wide weight mismatch a lot, I'm not so sure since if these
> > high weight task is spread among cores, with the feature of core
> > scheduling, these high weight tasks can get better performance.
> 
> It depends.
> 
> Say TaskA(cookie 1) and TaskB(cookie1) has high weight,
> TaskC(cookie 2) and Task D(cookie 2) has low weight.
> And we have two cores 4 CPU.
> 
> If we dispatch
> - TaskA and TaskB on Core0,
> - TaskC and TaskD on Core1,
> 
> with coresched enabled, all 4 tasks can run all the time.

Although all tasks get CPU, TaskA and TaskB are competing hardware
resources and will run slower.

> But if we dispatch
> - TaskA on Core0.CPU0, TaskB on Core1.CPU2,
> - TaskC on Core0.CPU1, TaskB on Core1.CPU3,
> 
> with coresched enabled, when TaskC is running, TaskA will be forced
> off CPU and replaced with a forced idle thread.

Not likely to happen since TaskA and TaskB's share will normally be a
lot higher to make sure they get the CPU most of the time.

> 
> Things get worse if TaskA and TaskB share some data and can get
> benefit from the core level cache.

That's a good point and hard to argue.

I'm mostly considering colocating redis-server(the main workload) with
other compute intensive workload. redis-server can be idle most of the
time but needs every hardware resource when it runs to meet its latency
and throughput requirement. Test at my side shows redis-server's
throughput can be about 30% lower when two redis-servers run at the
same core(throughput is about 80000 when runs exclusively on a core VS
about 56000 when runs with sibling thread busy) IIRC.

So my use case here is that I don't really care about low weight task's
performance when high weight task demands CPU. I understand that there
will be other use cases that also care about low weight task's
performance. So what I have done is to make the two task's weight
difference as large as possible to signal that the low weight task is
not important, maybe I can also try to tag low weight task as SCHED_IDLE
ones and then we can happily sacrifice SCHED_IDLE task's performance?
 
> > So this appeared to me like a question of: is it desirable to protect/enhance
> > high weight task performance in the presence of core scheduling?
> 
> This sounds to me a policy VS mechanism question. Do you have any idea
> how to spread high weight task among the cores with coresched enabled?

Yes I would like to get us on the same page of the expected behaviour
before jumping to the implementation details. As for how to achieve
that: I'm thinking about to make core wide load balanced and then high
weight task shall spread on different cores. This isn't just about load
balance, the initial task placement will also need to be considered of
course if the high weight task only runs a small period.
