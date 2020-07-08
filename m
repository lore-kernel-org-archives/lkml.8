Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8ADC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2187B20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgGHL22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:28:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGHL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:28:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE33FAD4B;
        Wed,  8 Jul 2020 11:28:26 +0000 (UTC)
Date:   Wed, 8 Jul 2020 13:28:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] spi: use kthread_create_worker() helper
Message-ID: <20200708112825.GC4751@alley>
References: <CGME20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af@eucas1p2.samsung.com>
 <20200708070900.30380-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708070900.30380-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-07-08 09:09:00, Marek Szyprowski wrote:
> Since commit 4977caef05aa ("kthread: work could not be queued when worker
> being destroyed")

This commit should disappear from linux-next soon. We did not expect
that it would cause these warnings. We first want to fix the callers
before we put it back.

> there is a warning when kworker is used without the
> internal 'task' entry properly initialized. Fix this by using
> a kthread_create_worker() helper instead of open-coding a kworker
> initialization.

But the fix is great and makes sense on its own.

The use of kthread_create_worker() simplifies the code. It uses
the kthread worker API the right way. It will eventually allow
to remove the FIXME in kthread_worker_fn() and add more consistency
checks.

I would use the above reasoning instead of the backtrace in the commit
message. And feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr Mladek
