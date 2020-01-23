Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC36C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ABE20665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAWVkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:40:25 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:56063 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAWVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:40:25 -0500
Received: from [62.209.224.147] (helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1iukCx-0001FH-7H; Thu, 23 Jan 2020 16:40:17 -0500
Date:   Thu, 23 Jan 2020 22:40:09 +0100
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "liuchao (CR)" <liuchao173@huawei.com>,
        linfeilong <linfeilong@huawei.com>,
        Hushiyuan <hushiyuan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUkZDXSBpcnE6IFNr?= =?utf-8?Q?ip_printin?=
 =?utf-8?Q?g?= irq when desc->action is null even if any_count is not zero
Message-ID: <20200123214009.GA17257@localhost.localdomain>
References: <20200121130959.22589-1-liuchao173@huawei.com>
 <87k15jek6v.fsf@nanos.tec.linutronix.de>
 <20200122192856.GA2852@localhost.localdomain>
 <7966953BB2EC794AA37DF0A21FAD8A34021318DA@DGGEMA503-MBX.china.huawei.com>
 <87pnfatkpy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnfatkpy.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 01:34:33PM +0100, Thomas Gleixner wrote:
> Chao,
> 
> "liuchao (CR)" <liuchao173@huawei.com> writes:
> > On Thu, Jan 23, 2020 at 03:29AM +0800, Neil Horman wrote:
> >> > I'm not opposed to suppress the output, but I really want the opinion
> >> > of the irqbalance maintainers on that.
> >
> > Irqbalance is an example. I mean, when this happens, users who cat /proc/interrupts 
> > may be confused about where the interrupt came from and what it was used for. 
> > People who use Linux may not understand the principle of this. They are not sure 
> > whether this is a problem of the system or not.
> 
> Well, this has been that way for 20+ years and so far nobody got
> confused. If it's not documented then we should do so.
> 
> >> Actually, irqbalance ignores the trailing irq name (or it should at least), so you
> >> should be able to drop that portion of /proc/irqbalance, though I cant speak for
> >> any other users of it.
> >
> > If irq isn't removed from /proc/interrups, it will still be parsed in
> > collect_full_irq_list and parse_proc_interrupts.
> 
> Sure, and why is that a problem? Again, this is really historic behaviour.
> 
> > irq_name is used in guess_arm_irq_hints.
> 
> That's a problem of guess_arm_irq_hints() then.
> 
> Again, I'm not against supressing such lines in general, but I want to
> make sure that no tool depends on that information.
> 
I think it probably makes sense to just keep it then.  I'm not sure I
see it as hurting anything to keep it around.

Neil

> Thanks,
> 
>         tglx
> 
