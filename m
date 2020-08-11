Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C85C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F8E2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgHKNCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgHKNCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9857AE54;
        Tue, 11 Aug 2020 13:02:39 +0000 (UTC)
Date:   Tue, 11 Aug 2020 15:02:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200811130218.GI6215@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh7175hj.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
> Petr Mladek <pmladek@suse.com> writes:
> > At least "crash" tool would need an update anyway. AFAIK, it checks
> > the size of struct printk_log and refuses to read it when it changes.
> >
> > It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> > needed because we would need to update the crashdump-related tools anyway.
> >
> > Well, the timing is good. We are about to switch the printk ring
> > buffer into a lockless one. It requires updating the crashdump tools
> > as well. We could do this at the same time. The lockless ring buffer
> > already is in linux-next. It is aimed for 5.10 or 5.11.
> ...
> > It would be great to synchronize all these changes changes of the
> > printk log buffer structures.
> 
> I agree that having one update is a good thing, but pretty please can we
> finally make progress with this and not create yet another dependency?

To make it clear. I definitely do not want to block lockless printk by
this.

BTW: I am not 100% convinced that storing all three timestamps is
worth it. It increases the code complexity, metadata size. It needs
an interface with the userspace that has to stay backward compatible.

Also it still will be racy because the timestamp is taken when the message
is printed. It might be "long" before or after the event that
it talks about.

There is still the alternative to print all three timestamps regularly
for those interested. It is less user convenient but much easier
to maintain.

Best Regards,
Petr
