Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D796206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404201AbgDCSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:25:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404021AbgDCSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:25:20 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jKR02-0002M3-Dc; Fri, 03 Apr 2020 20:25:02 +0200
Date:   Fri, 3 Apr 2020 20:25:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200403182502.woqrxpydt3n6l6ie@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <20200327232959.rpylymw2edhtxuwr@linutronix.de>
 <20200403174500.75rwuijdri5ewl5c@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403174500.75rwuijdri5ewl5c@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-03 13:45:00 [-0400], Daniel Jordan wrote:
> Why would preemption prevent it?  Interrupts are still enabled.
> 
> What am I missing?  :-)

Preemption is disabled which means no other task is allowed to be
scheduled.

Sebastian
