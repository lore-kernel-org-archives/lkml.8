Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D07CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18119206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgFELhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgFELhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:37:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1854AAD76;
        Fri,  5 Jun 2020 11:37:03 +0000 (UTC)
Date:   Fri, 5 Jun 2020 13:36:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, bobo.shaobowang@huawei.com,
        huawei.libin@huawei.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org
Subject: Re: [RFC PATCH] panic: fix deadlock in panic()
Message-ID: <20200605113658.GL22497@linux-b0ei>
References: <20200603141915.38739-1-cj.chengjian@huawei.com>
 <20200604082947.GB22497@linux-b0ei>
 <7b6f8522-f9b2-29e8-2dde-3bbfac19335b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6f8522-f9b2-29e8-2dde-3bbfac19335b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-06-05 18:42:57, chengjian (D) wrote:
> Hi, Petr
> 
> On 2020/6/4 16:29, Petr Mladek wrote:
> 
> > It might cause double unlock (deadlock) on architectures that did not
> > use NMI to stop the CPUs.
> > 
> > I have created a conservative fix for this problem for SLES, see
> > https://github.com/openSUSE/kernel-source/blob/SLE15-SP2-UPDATE/patches.suse/printk-panic-Avoid-deadlock-in-printk-after-stopping-CPUs-by-NMI.patch
> > It solves the problem only on x86 architecture.
> > 
> > There are many hacks that try to solve various scenarios but it
> > is getting too complicated and does not solve all problems.
> 
> I have read your conservative fix and I have some question,
> 
> 1-- does the console_sem need to be reinitialized ?

No, it is not needed:

  + printk() itself does try_lock() and skips console handling when the
    semaphore is not available.

  + panic() tries to push the messages later in console_flush_on_panic().
    It ignores the semaphore. Also most console drivers ignore their
    internal locks because oops_in_progress is set by bust_spinlocks().


> 2-- Other architectures without NMI, is there no such problem ?

The situation is more complicated when NMI is not used. Non-stopped
CPUs are in unknown state, most likely in a busy loop. Nobody knows
whether printk() is repeatedly called in the loop. When it was called,
re-initializing any lock would cause double unlock and deadlock.

It would be possible to add some more hacks. One problem is that
there are two groups of users. One prefer to risk a deadlock and
have a chance to see the messages. Others prefer to always
reach emergency_restart() and reboot the machine.

This is one big motivation for working on lockless printk().

Best Regards,
Petr
