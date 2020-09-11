Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F1FC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F58C2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgIKKcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKKcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:32:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E77BAD2F;
        Fri, 11 Sep 2020 10:32:34 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:32:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [POC] printk: Convert dict ring into array
Message-ID: <20200911103217.GJ3864@alley>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
 <20200904124530.GB20558@alley>
 <20200911095035.GI3864@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911095035.GI3864@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-11 11:50:35, Petr Mladek wrote:
> This is POC how the printk() code would look when dict ring
> gets converted into an array of extended info structures.
> 
> It applies on top of the patchset ("[PATCH printk v4 0/6]
> printk: reimplement LOG_CONT handling"), see
> https://lore.kernel.org/r/20200908202859.2736-1-john.ogness@linutronix.de
> 
> It compiles and even seems to work. But it would need quite
> some love and discussion to get ready for merging.

[...]

> Well, there is only small step to bundle these values into the existing
> struct printk_info.

My opinion:

I would like to go this way in the long term because it looks like the most
easy and reliable solution. But I do _not_ want to block pushing printk
rework [0][1] into mainline because of this.

Handling more information for each stored message is tangential to the
printk rework. It would make it easier for crashdump related tools
when the log buffer format is not modified many times. But it
might block the rework indefinitely.

The lockless ringbuffer is almost ready for merging into mainline.
It will be a huge change on its own. The printk rework is very
important effort. It is cleaning up the printk design and
helps with many historical problems, like deadlocks or soft-lockups.

I do not want to complicate it much more with adding more meta
information and yet another format change that would deserve
more investigation and discussion.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=printk-rework
[1] https://lore.kernel.org/r/20200908202859.2736-1-john.ogness@linutronix.de

Best Regards,
Petr
