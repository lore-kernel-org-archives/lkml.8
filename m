Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047BA222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6NNeAqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgB0CEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:04:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34236 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgB0CEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:04:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so605101pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 18:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aWG0TNz5JDH1G/ImpDRtx/iO8APM9+1+UpF9HiauD8M=;
        b=W6NNeAqH3oiZEGV7FggN/AQzZ9mIRG+w5hs5ZBkuNqAOTUCY35YF0TG7CVnqj5k+cN
         TDsYhovB2X0/Vq3xpT1P7IM5j0sdF0nQFT+mLUpJZH7I0dTEXhL/RcDQijrmp1cYExAb
         qaDPcMTLHpZBhjiAn2gYeDkvYtX3JNHvHXgagRu0OSSEfVT5khEDz4L8zSb0QSH7zM0t
         rnD8bDULBaBUcmbsDP29iBbafKPE1GCMq3XXAwhY85lwoArwZXOEhujvEv5S3ektn9TS
         vRpfVt4j0ADG5K1vNqQx4GiRDItc+cr8EWxzMRFt8MBRB4+aUOQX6KB96KJy48iDPdfE
         C8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWG0TNz5JDH1G/ImpDRtx/iO8APM9+1+UpF9HiauD8M=;
        b=ISpxjc0rv/kLl0bTvlKDXxY9Ty/5M9pDl++3ypJQyiO8+ecT8rAOYynABJ/4jR9aua
         gbMWrhXsgKkKIJvt3Tc3d70ZH6h/QalJIIGy/sJU7uewHKKMJ8Jd5skJRailUL8NdDF4
         b02EcYlMG2wysRuVzT7U1+3xRqMOdK9jIKBtUFOiF+G2DsfaGG/ytuPv/mOZH2ochm62
         afMX7BzRxmSjxDFO1vgp9f8YBpEu3p2qdNtUrmdsRvO4LAsR6OUwNzsPh7cO3feB5bGh
         qfM52SlJwZII2cRMr1r746naeRibJYXo5boTxIgDSqNvyfubK6c1/KYhJMGOJtQo0FkW
         C5Eg==
X-Gm-Message-State: APjAAAVQY8vN27s6ugwyJYYRBhjFXG0xK8Vw0vC/gZnM2n0LO6yXWes0
        KGO5zudxLFG4VRtcY7biqlo=
X-Google-Smtp-Source: APXvYqz1P2UF6CkxavZM5S/0aOCtyQif+XlfpcLRmZyPqNXMYYUOBkkZT3DSvztRIBZXae/3Fs+JDQ==
X-Received: by 2002:aa7:991e:: with SMTP id z30mr1606065pff.259.1582769083273;
        Wed, 26 Feb 2020 18:04:43 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id iq22sm4123749pjb.9.2020.02.26.18.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 18:04:42 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:04:32 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
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
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200227020432.GA628749@ziqianlu-desktop.localdomain>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:51:37PM -0500, Vineeth Remanan Pillai wrote:
> On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> > threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> > into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> > socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> > cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> > the real workload).
> >
> > I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> 
> The expected behaviour could also be that 8 processes share 4 cores and
> 8 hw threads right? This is what we are seeing mostly

I expect the 8 cgA tasks to spread on each core, instead of occupying
4 cores/8 hw threads. If they stay on 4 cores/8 hw threads, than on the
core level, these cores' load would be much higher than other cores
which are running cgB's tasks, this doesn't look right to me.

I think the end result should be: each core has two tasks queued, one
cgA task and one cgB task(to maintain load balance on the core level).
The two tasks are queued on different hw thread, with cgA's task runs
most of the time on one thread and cgB's task being forced idle most
of the time on the other thread.
