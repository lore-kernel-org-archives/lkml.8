Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC12206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGCH2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:28:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCH2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:28:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E160CAF43;
        Fri,  3 Jul 2020 07:28:18 +0000 (UTC)
Date:   Fri, 3 Jul 2020 09:28:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Don't cancel a work that is being cancelled
Message-ID: <20200703072818.GC11587@alley>
References: <20200702044324.32927-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702044324.32927-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-02 12:43:24, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> When canceling a work, if it is found that the work is in
> the cancelling state, we should directly exit the cancelled
> operation.

No, the function guarantees that the work is not longer running
when it returns. This is why it has the suffix "_sync" in the name.

We would need to add kthread_cancel_work() without the "_sync"
wrappers that would not wait for the work in progress. But it
might be dangerous. The API users usually want to make sure
that the work in not longer running to avoid races.

What is the use case for the non-sync behavior, please?

Best Regards,
Petr
