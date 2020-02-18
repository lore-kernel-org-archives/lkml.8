Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFEFC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB81F24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBRUI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbgBRUIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:08:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4DC22B48;
        Tue, 18 Feb 2020 20:08:52 +0000 (UTC)
Date:   Tue, 18 Feb 2020 15:08:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218150850.224d9b8e@gandalf.local.home>
In-Reply-To: <20200218195035.GN14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
        <20200218131158.693eeefc@gandalf.local.home>
        <20200218195035.GN14449@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 20:50:35 +0100
Borislav Petkov <bp@alien8.de> wrote:

> True story, thanks for that hint!
> 
> static_key_disable()
> |-> cpus_read_lock()
> |-> percpu_down_read(&cpu_hotplug_lock)
> |->might_sleep()
> 
> Yuck. Which means, the #MC handler must switch to __rdmsr()/__wrmsr()
> now.
> 
> I wish I could travel back in time and NAK the hell of that MSR
> tracepoint crap.

Can we create a per_cpu variable that gets set when we enter the MC
handler, and not call the msr trace points when that is set?

Now, is jump labels bad in these cases (note, it is possible to trigger
a breakpoint in them, does an iret disable the MC as well, which means
we could get nested MC handlers corrupting the IST stack?).

You could have the msr_tracepoint_active() check this per cpu variable?

msr reading and writing is rather slow, and I'm sure reading a per_cpu
variable is going to be in the noise of it.

-- Steve
