Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC29C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E267424655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWMeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:34:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAWMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:34:45 -0500
Received: from [5.158.153.53] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iubgv-00088U-Ou; Thu, 23 Jan 2020 13:34:33 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4C8331017FA; Thu, 23 Jan 2020 13:34:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "liuchao \(CR\)" <liuchao173@huawei.com>,
        Neil Horman <nhorman@tuxdriver.com>
Cc:     linfeilong <linfeilong@huawei.com>,
        Hushiyuan <hushiyuan@huawei.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOg==?= [RFC] irq: Skip printing irq when
 desc->action is null even if any_count is not zero
In-Reply-To: <7966953BB2EC794AA37DF0A21FAD8A34021318DA@DGGEMA503-MBX.china.huawei.com>
References: <20200121130959.22589-1-liuchao173@huawei.com> <87k15jek6v.fsf@nanos.tec.linutronix.de> <20200122192856.GA2852@localhost.localdomain> <7966953BB2EC794AA37DF0A21FAD8A34021318DA@DGGEMA503-MBX.china.huawei.com>
Date:   Thu, 23 Jan 2020 13:34:33 +0100
Message-ID: <87pnfatkpy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao,

"liuchao (CR)" <liuchao173@huawei.com> writes:
> On Thu, Jan 23, 2020 at 03:29AM +0800, Neil Horman wrote:
>> > I'm not opposed to suppress the output, but I really want the opinion
>> > of the irqbalance maintainers on that.
>
> Irqbalance is an example. I mean, when this happens, users who cat /proc/interrupts 
> may be confused about where the interrupt came from and what it was used for. 
> People who use Linux may not understand the principle of this. They are not sure 
> whether this is a problem of the system or not.

Well, this has been that way for 20+ years and so far nobody got
confused. If it's not documented then we should do so.

>> Actually, irqbalance ignores the trailing irq name (or it should at least), so you
>> should be able to drop that portion of /proc/irqbalance, though I cant speak for
>> any other users of it.
>
> If irq isn't removed from /proc/interrups, it will still be parsed in
> collect_full_irq_list and parse_proc_interrupts.

Sure, and why is that a problem? Again, this is really historic behaviour.

> irq_name is used in guess_arm_irq_hints.

That's a problem of guess_arm_irq_hints() then.

Again, I'm not against supressing such lines in general, but I want to
make sure that no tool depends on that information.

Thanks,

        tglx
