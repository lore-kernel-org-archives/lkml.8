Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CF6206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BgG/bb/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416131AbgDOQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416090AbgDOQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:32:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:32:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b62so17899441qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=haVZ1diiI4tJLpHyfasNhTx2/UrZNUjDa5tNyppMayk=;
        b=BgG/bb/DIPCtlyVG5VITN6kN+tBoGWOeqqiaspBkklPPu2weo+AZZ1jtX4JOrEfU32
         pIulksZPTY8j3lrfPuWQBS6tlXlMo/3inTg+9CalmI89VlumEFSbTGwnG59v8Tl6ZLU2
         DJ/CV5a1A9fghyjFADWXnvZLFnV8ux7nJofY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=haVZ1diiI4tJLpHyfasNhTx2/UrZNUjDa5tNyppMayk=;
        b=WIPtblLs1w1KEVVwxUIu9PUalQnnIsr3tfqnbyfyXoW97SXFqThnBHRlAvCFDiYgX7
         i56krs75nTP9sOIoerJ0w+n7xgWL5wnP7q+Yz0w35+XeAsSmeoqlkpLlFcB1r91P535p
         G9MEw9muvf5oaDk77oYwXLc+EE/+fyEhs7rYhJacabPy6NWB1laKsFQOSWaG38x5GHz/
         f/zkJWoNF/bzOWCw5jChylhRcBm9emcaCtX3a55w2BRiAlDi0e2vdw0CeKmaxa8nUhVb
         Hd0mQc8aMe+MdGMDGXeZhuZ0ZkkkFBcIgqsA1oBPDfq4EnrEfQAuTm11WgMP7JXzerVk
         dKYQ==
X-Gm-Message-State: AGi0PuaRU79qXniOpuVSsH8IdD660aKaJg7x18OB8HbBtO8cYHE/1ZzM
        n6Z/mJb3mGivIipRp314Cv7BJY+JDL0=
X-Google-Smtp-Source: APiQypIFNAwigG22UR9KYcOUTyWl0QwOWjrQlhbTzmhWZQiKZtH/gwULAvskpwkSvZLjUMXw5JRMgg==
X-Received: by 2002:a37:54e:: with SMTP id 75mr27324741qkf.257.1586968342298;
        Wed, 15 Apr 2020 09:32:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e6sm11718109qti.40.2020.04.15.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:32:21 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:32:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200415163220.GA180518@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200414142152.GV20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414142152.GV20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:21:52PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
> > TODO
> > ----
> > - Work on merging patches that are ready to be merged
> > - Decide on the API for exposing the feature to userland
> > - Experiment with adding synchronization points in VMEXIT to mitigate
> >   the VM-to-host-kernel leaking
> 
> VMEXIT is too late, you need to hook irq_enter(), which is what makes
> the whole thing so horrible.

We came up with a patch to do this as well. Currently testing it more and it
looks clean, will share it soon.

> > - Investigate the source of the overhead even when no tasks are tagged:
> >   https://lkml.org/lkml/2019/10/29/242
> 
>  - explain why we're all still doing this ....
> 
> Seriously, what actual problems does it solve? The patch-set still isn't
> L1TF complete and afaict it does exactly nothing for MDS.

The L1TF incompleteness is because of cross-HT attack from Guest vCPU
attacker to an interrupt/softirq executing on the other sibling correct? The
IRQ enter pausing the other sibling should fix that (which we will share in
a future series revision after adequate testing).

> Like I've written many times now, back when the world was simpler and
> all we had to worry about was L1TF, core-scheduling made some sense, but
> how does it make sense today?

For ChromeOS we're planning to tag each and every task seperately except for
trusted processes, so we are isolating untrusted tasks even from each other.

Sorry if this sounds like pushing my usecase, but we do get parallelism
advantage for the trusted tasks while still solving all security issues (for
ChromeOS). I agree that cross-HT user <-> kernel MDS is still an issue if
untrusted (tagged) tasks execute together on same core, but we are not
planning to do that on our setup at least.

> It's cute that this series sucks less than it did before, but what are
> we trading that performance for?

AIUI, the performance improves vs noht in the recent series. I am told that
is the case in recent postings of the series.

thanks,

 - Joel

