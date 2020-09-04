Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EBC2D0E1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC732083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgIDNeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgIDNaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:30:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7267AC19;
        Fri,  4 Sep 2020 13:29:33 +0000 (UTC)
Date:   Fri, 4 Sep 2020 15:30:01 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH] syscall/ptrace08: Simplify the test.
Message-ID: <20200904133001.GA9091@yuki.lan>
References: <20200904115817.8024-1-chrubis@suse.cz>
 <20200904132121.GE4768@mussarela>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904132121.GE4768@mussarela>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> This is failing on our 4.4 and 4.15 kernels, though they passed with the
> previous test and have commit f67b15037a7a applied.
> 
> So, this is dependent on some other behavior/commit that has changed. It passes
> on 5.4, for example. I'll try to investigate further.

We are looking at it now in SUSE, looks like the initial fix to the
kernel postponed the check to the write to the dr7 that enabled the
breakpoint, so when the dr0 wasn't enabled you could write anything
there.

Also looks like somehow the EINVAL is not propagated into the POKEUSER
call to the dr7 as it should have been.

-- 
Cyril Hrubis
chrubis@suse.cz
