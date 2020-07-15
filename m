Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2DC20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594816859;
	bh=7ctoNTZ+7FhSCaNfw2A5qppDyG1GeMNDMMlqzOuxsPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lqS7dS20w0mZwN7PL8CV6+FRIoEmF73cOSkiZz9uw4Sbr9odWZ561LpSBA/CZcK/r
	 Hk3Jtt3p3L262To90tTEHkIwmWY1/m+WMpnLXZcWDwNlguw3Thy7AQZnFgIuSEjh5Z
	 hf7TDC0Zw8q1eHd78sC0Zp/nYYLcXCxqrHjxeNXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgGOMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgGOMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:40:58 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6365620578;
        Wed, 15 Jul 2020 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594816857;
        bh=7ctoNTZ+7FhSCaNfw2A5qppDyG1GeMNDMMlqzOuxsPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeTQkv3fkCVEj4SCT/Ud2YXrFMXek7zhjHNPuPf1cRwIOg+W/qE0fDWWMnwsQub9B
         w+CT9UcQWY9UUUBHqO4ZaU1muHYCDz8WDRKP5GaA5sUMvSYzNvCpk+rLCXq6OyAHHu
         O3YIPr0yO6JpwIguDSL+ZrrlIw07XjnRiY/3fKv4=
Date:   Wed, 15 Jul 2020 14:40:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] timers: Use only bucket expiry for base->next_expiry
 value
Message-ID: <20200715124053.GA16227@lenoir>
References: <20200714072924.6810-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714072924.6810-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:29:24AM +0200, Anna-Maria Behnsen wrote:
> The bucket expiry time is the effective expriy time of timers and is
> greater than or equal to the requested timer expiry time. This is due
> to the guarantee that timers never expire early and the reduced expiry
> granularity in the secondary wheel levels.
> 
> When a timer is enqueued, trigger_dyntick_cpu() checks whether the
> timer is the new first timer. This check compares next_expiry with
> the requested timer expiry value and not with the effective expiry
> value of the bucket into which the timer was queued.
> 
> Storing the requested timer expiry value in base->next_expiry can lead
> to base->clk going backwards if the requested timer expiry value is
> smaller than base->clk. Commit 30c66fc30ee7 ("timer: Prevent base->clk
> from moving backward") worked around this by preventing the store when
> timer->expiry is before base->clk, but did not fix the underlying
> problem.
> 
> Use the expiry value of the bucket into which the timer is queued to
> do the new first timer check. This fixes the base->clk going backward
> problem.
> 
> The workaround of commit 30c66fc30ee7 ("timer: Prevent base->clk from
> moving backward") in trigger_dyntick_cpu() is not longer necessary as the
> timers bucket expiry is guaranteed to be greater than or equal base->clk.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks a lot!
