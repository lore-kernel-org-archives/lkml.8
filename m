Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CAEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0AE2089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593700331;
	bh=XZbrrnyS7ug333rlhU+8891jthGCcmL9Xc/58s0cUD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yusioTXn9vWoOmGeFkGVssP8oF8lkjz1SCF/Ul+N3dHAefPUma8hl4/htTDZ2jEr/
	 1R9P0agQhkRy+ax/AYb8byBEcvP32hVHqA9swrDG6fAg8ytQu5Z9sU3lZ/upN9OBQq
	 FlQ30yShvND+qOoeXM2Iv8zlhxvD8S15/Q1gGfFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgGBOcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:32:09 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E810D20899;
        Thu,  2 Jul 2020 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593700329;
        bh=XZbrrnyS7ug333rlhU+8891jthGCcmL9Xc/58s0cUD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VX0y9aAyFQxKPsDhyJZUXMRd+pZ3OxZ+jxHfPOnN2xuz/AZeJMK/PnRr3ailueakq
         qAtl9hogaBvOmN8+OozFNYD5tf6rgu/BrOniSQFTUGvpde2eXSkME0moRanaFt3Woi
         sy32Luyol4IbDMo6DnFFR0tWcH0TJpwrxSFRwbZ4=
Date:   Thu, 2 Jul 2020 16:32:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200702143206.GC27417@lenoir>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
 <20200701163504.GD9670@localhost.localdomain>
 <20200701232045.GA17670@lenoir>
 <20200702095959.GG9670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702095959.GG9670@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:59:59AM +0200, Juri Lelli wrote:
> On 02/07/20 01:20, Frederic Weisbecker wrote:
> > On Wed, Jul 01, 2020 at 06:35:04PM +0200, Juri Lelli wrote:
> > > Guess you might be faster to understand what I'm missing. :-)
> > 
> > So, did you port only this patch or the whole set in order to
> > trigger this?
> > 
> > If it was the whole set, can you try this patch alone?
> 
> Whole set. And I can't reproduce if I try with this patch alone.
> 

Missing initialization. This should go better after this:

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 25a55c043297..f36b53219768 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1969,6 +1969,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		timer_base_init_expiry_lock(base);
 	}
 }
