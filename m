Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C49C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2B92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WB+sBzmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAMM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:29:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgAMM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N53AG3XTz7zK190T6CmIQkpQjxVcmnf8umqcp8Tjl/8=; b=WB+sBzmLjVVyxPITxtXXdsdz+
        ci2VYBEB+A3+wGfdN22XHBoKEeD3OIT55Hk0+PNIqMryFVbs0qmcAtD/4PRNE7EEgNDyYepx2EquG
        wt6p5n3T4In63koDZb7usu4m0isU+nZ4ZpGL9AzYpOiF2mZPfiNu0UdG3rw48+aUm9L6sgNTx/lG1
        m6+YSF+/Mi8fIJck2LXHkvaDZ0KbEZg6UzcKrYWDnJ0YkqyBIfDUj2iEjwVKzj61B1/t9TaJ8Od5f
        k2UM7ZgeSGM+3/2g+J+NgNn+LDD55G0PZR/f/cnJmUm+Fjjs3Dm99GgjWfGA4YMfK3fTUK9hY6l6B
        hCYKnlufg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iqyqI-0003Y5-4Z; Mon, 13 Jan 2020 12:29:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB341304123;
        Mon, 13 Jan 2020 13:27:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24A9B2B6B2F92; Mon, 13 Jan 2020 13:29:11 +0100 (CET)
Date:   Mon, 13 Jan 2020 13:29:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        KarimAllah <karahmed@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        christopher.s.hall@intel.com, hubert.chrzaniuk@intel.com,
        len.brown@intel.com, thomas.lendacky@amd.com
Subject: Re: [PATCH RFC] sched/fair: Penalty the cfs task which executes
 mwait/hlt
Message-ID: <20200113122911.GE2827@hirez.programming.kicks-ass.net>
References: <1578448201-28218-1-git-send-email-wanpengli@tencent.com>
 <CANRm+Cx0LMK1b2mJiU7edCDoRfPfGLzY1Zqr5paBEPcWFFALhQ@mail.gmail.com>
 <20200113104314.GU2844@hirez.programming.kicks-ass.net>
 <2579281.NS3xOKR7ft@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2579281.NS3xOKR7ft@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:18:46PM +0100, Rafael J. Wysocki wrote:
> On Monday, January 13, 2020 11:43:14 AM CET Peter Zijlstra wrote:

> > Anyone, what will it take to get MPERF/TSC 'working' ?
> 
> The same thing that intel_pstate does.

But intel_pstate cheats, it has a FMS listing and possible 'interesting'
chips are excluded. For instance, Core2 has APERF/MPERF, but
intel_pstate does not support Core2.

Simlarly, intel_pstate does (obviously) not support AMD chips, even tho
those have APERF/MPERF.

Although I suppose Core2 doesn't have VMX and is therefore less
interesting, but then we'd need to gate the logic with something like:

	static_cpu_has(X86_FEATURE_APERFMPERF) &&
	(static_cpu_has(X86_FEATURE_VMX) || static_cpu_has(X86_FEATURE_SVM)

> Generally speaking, it shifts the mperf values by a number of positions
> depending on the CPU model, but that is 1 except for KNL.
> 
> See get_target_pstate().

I'm going to go out on a limb and guess that's the same KNL hack as
TurboStat has.

Is that really the only known case?
