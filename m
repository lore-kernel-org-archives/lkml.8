Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19017C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39172075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHA4dY32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgH1U4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1U4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91138C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7J1O6k6tR7A5+V7f8slNjLba3lybqtmnEjLaRhAAaas=; b=NHA4dY32oqry9fBpFXAnG1HCYE
        +4KQHv7KlXrMaJgxMc8eojReRGyhg18wwlMS/f2p/6WRMHIjJ3cOKfNWzyDBT0L9TXMSwTPcBp/Zn
        2R1k/z+EEWoriFYn/zIHaiLiJxmmL859CzgYBU09vdkKqeFCofRWbWr02Ap3xrSiEmNG757l6vqtg
        znV8mleBIeKnYgb4nPjsRgwnVVKv6zjQ7yuaYAbCwIsujx6CvNaQ8pSlanUUXmsrFttbQKyxScPaC
        fc9x8roP0C91KbsMuucBuAsRO2YEojeEwSdQveo7kfTuOsIG0SyY3pH0vCssH4RLfA5wBmpsWpalD
        2k68iWxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBlPD-0000Ov-0b; Fri, 28 Aug 2020 20:55:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 996C9980DC7; Fri, 28 Aug 2020 22:55:26 +0200 (CEST)
Date:   Fri, 28 Aug 2020 22:55:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200828205526.GC29142@worktop.programming.kicks-ass.net>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:51:09PM -0400, Julien Desfossez wrote:
> +		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> +			rq_i->core_forceidle = true;

Did you mean: rq_i->core_pick == rq_i->idle ?

is_idle_task() will also match idle-injection threads, which I'm not
sure we want here.
