Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB552166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgCDPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:22:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDPWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:22:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73D74AC62;
        Wed,  4 Mar 2020 15:22:00 +0000 (UTC)
Date:   Wed, 4 Mar 2020 16:21:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-03-03 20:30:02, Sergey Senozhatsky wrote:
> However, only printk_safe/printk_nmi do make sure that
> per-CPU areas have been initialised and that it's safe
> to modify per-CPU irq_work. This means that, for instance,
> should printk_deferred() be invoked "too early", that
> is before per-CPU areas are initialised, printk_deferred()
> will perform illegal per-CPU access.
> 
> Lech Perczak [0] reports that after commit 1b710b1b10ef
> ("char/random: silence a lockdep splat with printk()")
> user-space syslog/kmsg readers are not able to read new
> kernel messages. The reason is printk_deferred() being
> called too early (as was pointed out by Petr and John).
> 
> Fix printk_deferred() and do not queue per-CPU irq_work
> before per-CPU areas are initialized.
> 
> [0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reported-by: Lech Perczak <l.perczak@camlintechnologies.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Now, the question is whether to hurry this fix into 5.6 or if
it could wait for 5.7.

I think that it could wait because 5.6 is not affected by
the particular printk_deferred(). This patch fixes a long-term
generic problem. But I am open for other opinions.

Best Regards,
Petr
