Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4112BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235152068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFLJaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:30:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgFLJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:30:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A4B5ADC5;
        Fri, 12 Jun 2020 09:30:02 +0000 (UTC)
Date:   Fri, 12 Jun 2020 11:29:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Ilias Stamatis <stamatis.iliass@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: remove incorrect comment in
 kthread_create_on_cpu()
Message-ID: <20200612092958.GD4311@linux-b0ei>
References: <20200611135920.240551-1-stamatis.iliass@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611135920.240551-1-stamatis.iliass@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-11 16:59:21, Ilias Stamatis wrote:
> Originally kthread_create_on_cpu() parked and woke up the new thread.
> However, since commit a65d40961dc7 ("kthread/smpboot: do not park in
> kthread_create_on_cpu()") this is no longer the case. This patch removes
> the comment that has been left behind and is now incorrect / stale.
> 
> Signed-off-by: Ilias Stamatis <stamatis.iliass@gmail.com>

Good catch!

Fixes: a65d40961dc7 ("kthread/smpboot: do not park in kthread_create_on_cpu()")
Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
