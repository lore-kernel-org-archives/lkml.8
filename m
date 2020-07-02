Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2161120780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGBNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:32:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgGBNcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:32:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0F89BC6C;
        Thu,  2 Jul 2020 13:32:33 +0000 (UTC)
Date:   Thu, 2 Jul 2020 15:31:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     lijiang <lijiang@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
Message-ID: <20200702133110.GE14288@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-02 17:43:22, lijiang wrote:
> 在 2020年07月02日 17:02, John Ogness 写道:
> > On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
> >> About the VMCOREINFO part, I made some tests based on the kernel patch
> >> v3, the makedumpfile and crash-utility can work as expected with your
> >> patch(userspace patch), but, unfortunately, the vmcore-dmesg(kexec-tools)
> >> can't correctly read the printk ring buffer information, and get the
> >> following error:
> >>
> >> "Missing the log_buf symbol"
> >>
> >> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
> >> in the makedumpfile and crash-utility.
> > 
> > Yes, a patch for this is needed (as well as for any other related
> > software floating around the internet).
> > 
> > I have no RFC patches for vmcore-dmesg. Looking at the code, I think it
> > would be quite straight forward to port the makedumpfile patch. I will
> 
> Yes, it should be a similar patch.
> 
> > try to make some time for this.
> > 
> That would be nice. Thank you, John Ogness.
> 
> > I do not want to patch any other software for this. I think with 3
> > examples (crash, makedumpfile, vmcore-dmesg), others should be able to
> 
> It's good enough to have the patch for the makedumpfile, crash and vmcore-dmesg,
> which can ensure the kdump(userspace) work well.

I agree that this three are the most important ones and should be
enough.

Thanks a lot for working on it and testing it.

Best Regards,
Petr
