Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE42C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F08206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGYS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:56:52 -0400
Received: from 8bytes.org ([81.169.241.247]:33470 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGYS4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:56:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E2DAA46A; Sat, 25 Jul 2020 20:56:50 +0200 (CEST)
Date:   Sat, 25 Jul 2020 20:56:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200725185648.GY27672@8bytes.org>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
 <20200723145219.GP27672@8bytes.org>
 <20200724132802.GA640628@gmail.com>
 <20200725103850.GA823877@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725103850.GA823877@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 12:38:50PM +0200, Ingo Molnar wrote:
> On a second thought, I think this recent bug might have been the 
> culprit:
> 
>   d136122f5845: ("sched: Fix race against ptrace_freeze_trace()")
> 
> Fixed in tip:sched/urgent - this is why it went away in your testing 
> perhaps?

Indeed, tip/master with this commit reverted triggers the issue again,
so it appears to be the same problem. But it leaves the question why I
couldn't trigger it with plain v5.8-rc6.

Thanks,

	Joerg
