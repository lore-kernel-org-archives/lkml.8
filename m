Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3BC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120BE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="WiY3pb7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBUXVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:21:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38329 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgBUXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:21:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so3479284qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mpe0qtwY2gMuskKZj3H+pQ6GlWYhtea/PlocoE1R970=;
        b=WiY3pb7h03Vv3q0IsnMCBXn8NZOUgznakTQ6UgKI/sXcmj3tJ/yjl7e0Y+Fkm9sNS7
         MFP8RDGZt6IFrdOlE4SsnzINByjRflmJR0q23nA2teiDndsG2FXtVUS9eQxnNX+SDgHw
         7+rx82C3dakNBu+nLTLt59vr7LMVYB9jL7S7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mpe0qtwY2gMuskKZj3H+pQ6GlWYhtea/PlocoE1R970=;
        b=uZPPr1omg8wiIBh1XnypoAdeZftb2l+ZDFiYC+CJqqIKOI8apzqyC3EzlLgeKwHoql
         DxRl9lzigYQ552vJ1NvB2xtTadoalQBqaIQf+aNmR6W/zn1an8JGDJ0gS4OgQF1EbRek
         yiQOwujcsrZf/PQ+kNwd7Whl8hmzvPKEley3mFBsx2W75QxCR1NSPbyOTa0iacOsH7zv
         xU+u5prT3VKNCOAY1GoawgQezVAc6V95B/B3t2C8f868WnL3uLcRl0CmOOd4q43T0l6u
         5Ml6AHzrTeIjckIum9VHuzOilcPqC8KHphss9faNB2Z8Z8GhCj6izoNgrcJt/Na2zFb4
         vXwg==
X-Gm-Message-State: APjAAAU4JPePmemfYFFljzFb1jBNs9S/eY1gD08Yg9+2yhKiIE6wHCo+
        FxnX1py0fFBG+zAaAb9Ku1ewcg==
X-Google-Smtp-Source: APXvYqzsskusGoG46JELopQqDjVdTpUcWHjwZRz0jkHSYN+oGRXt6/B7TpZlZkk7Snwb0ZEHDK7EVg==
X-Received: by 2002:a37:aa4d:: with SMTP id t74mr8540085qke.241.1582327263516;
        Fri, 21 Feb 2020 15:21:03 -0800 (PST)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id h9sm2289479qtq.61.2020.02.21.15.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 15:21:02 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:20:57 -0500
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200221232057.GA19671@sinkpad>
References: <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Feb-2020 04:58:02 PM, Vineeth Remanan Pillai wrote:
> > Yes, this makes sense, patch updated at here, I put your name there if
> > you don't mind.
> > https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2-rc2
> >
> > Thanks Aubrey!

Just a quick note, I ran a very cpu-intensive benchmark (9x12 vcpus VMs
running linpack), all affined to an 18 cores NUMA node (36 hardware
threads). Each VM is running in its own cgroup/tag with core scheduling
enabled. We know it already performed much better than nosmt, so for
this case, I measured various co-scheduling statistics:
- how much time the process spends co-scheduled with idle, a compatible
  or an incompatible task
- how long does the process spends running in a inefficient
  configuration (more than 1 thread running alone on a core)

And I am very happy to report than even though the 9 VMs were configured
to float on the whole NUMA node, the scheduler / load-balancer did a
very good job at keeping an efficient configuration:

Process 10667 (qemu-system-x86), 10 seconds trace:
  - total runtime: 46451472309 ns,
  - local neighbors (total: 45713285084 ns, 98.411 % of process runtime):
  - idle neighbors (total: 484054061 ns, 1.042 % of process runtime):
  - foreign neighbors (total: 4191002 ns, 0.009 % of process runtime):
  - unknown neighbors  (total: 92042503 ns, 0.198 % of process runtime)
  - inefficient periods (total: 464832 ns, 0.001 % of process runtime):
    - number of periods: 48
    - min period duration: 1424 ns
    - max period duration: 116988 ns
    - average period duration: 9684.000 ns
    - stdev: 19282.130

I thought you would enjoy seeing this :-)

Have a good weekend,

Julien
