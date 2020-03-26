Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA95C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806992076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585241493;
	bh=WRS7dXwEeofqJh7HUcKH/2tDA/tCPxCJVqOGqM+0NQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZJ15WCmucTvefhWy4j6LfhD1sTnVw3jGA2uRkAinIOHsERqVKdeExkrLf/VPgl1xZ
	 yTsauebXY6gCa1qaGtiW2VPp2U/XFetmFSOnvX4OeBatSGAFZMg1dR1Otujpf1pYt8
	 at43QEEU7SozSYwKqNWn0r1mhd5oUqtnkzFGojp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgCZQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgCZQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:51:32 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDAB20719;
        Thu, 26 Mar 2020 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585241491;
        bh=WRS7dXwEeofqJh7HUcKH/2tDA/tCPxCJVqOGqM+0NQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kp3hy16TFHznlAeKnaobd1Y08K1gbPVGHur/Nv9M5JC9ge6ysBemLbDaB2jAPG+Yf
         w/WgqYDw0DSqL/+ZjDaB0Fnj2ufI4IVwvF4E1AKJN//lDplUWn9a72NflZ0g/IYaIU
         JTOG8rscVX0+sxjV5TUoTX073IDjHDjOBq60h4Yo=
Date:   Thu, 26 Mar 2020 17:51:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Marcelo Tosatti' <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200326165128.GC3946@lenoir>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
 <20200326162218.GB3946@lenoir>
 <76fa0270-40c5-aac7-1c53-38384fa3467d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76fa0270-40c5-aac7-1c53-38384fa3467d@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:32:51AM -0600, Chris Friesen wrote:
> On 3/26/2020 10:22 AM, Frederic Weisbecker wrote:
> > On Wed, Mar 25, 2020 at 06:05:27PM +0000, David Laight wrote:
> 
> > > How about making it possible to change the default affinity
> > > for new kthreads at run time?
> > > Is it possible to change the affinity of existing threads?
> > > Or maybe only those that didn't specify an explicit one??
> > 
> > That's already possible yes, most unbound kthreads are accessible
> > through /proc including kthreadd from which new kthread will inherit
> > their CPU affinity.
> 
> Are you sure that the new kthread will inherit the CPU affinity?
> 
> __kthread_create_on_node() explicitly sets the new thread as SCHED_NORMAL
> with a mask of "cpu_all_mask".

Ah, ok that's the part I missed. What a weird behaviour...

Anyway, I'm working on making all those isolcpus options
controllable through cpusets. So that should be possible at some
future.
