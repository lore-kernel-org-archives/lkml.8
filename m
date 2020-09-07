Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4595C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BEE2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgIGPts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgIGPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C7F2ACCC;
        Mon,  7 Sep 2020 15:47:16 +0000 (UTC)
Date:   Mon, 7 Sep 2020 17:47:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200907154713.GE8084@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
 <20200904124530.GB20558@alley>
 <87y2lp4r6o.fsf@jogness.linutronix.de>
 <20200904151336.GC20558@alley>
 <87ft7xazsf.fsf@jogness.linutronix.de>
 <20200907095437.GD8084@alley>
 <87d02xj2ui.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d02xj2ui.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-07 12:36:45, John Ogness wrote:
> On 2020-09-07, Petr Mladek <pmladek@suse.com> wrote:
> > This extra metadata are not currently read by crashdump tools.
> 
> crash [0] prints dictionary data.
> [0] https://github.com/crash-utility/crash

Grr, I have missed this. It makes things more complicated.

We need to find a way that would allow to add more metadata without
breaking support for the existing ones.

I know, it works with the current dictionary. "crash" just prints it
the same way as "cat /dev/kmsg". Dict entries are printed on separate
lines. It is better than nothing. But it is not much user friendly.

If we add more metadata, people would want to see it some more
userfriendly way, e.g.:

	[2020-08-20T07:58:48][  T136] random: crng init done

instead of

	[    1.394073] random: crng init done
	 PID = 136
	 CPU = 3
	 IRQ_CONTEXT = 0;
	 TS_MONO = 234632423
	 TS_REAL = 1599211091487260162
	 [...]

For this, "crash" would need to understand the different variables
stored in dictionary. So, it would become harder to change
the format as well.


Anyway, "crash" could get the information about struct printk_ext_info
via VMCOREINFO_STRUCT_SIZE(), VMCOREINFO_OFFSET() macros.
We could extend the structure if we do not change the format
of the existing items.

I am not 100% sure that the array of struct printk_ext_info is the
best solution. But I still somehow like it more than dict ring. IMHO,
it is more reliable and much easier to work with on the kernel side.

Best Regards,
Petr
