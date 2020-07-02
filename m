Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D877BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB3720874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b194pnNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOAaJfzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGBJs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGBJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:48:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 02:48:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593683304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7KSu5ePUYPphRAI7CrnncN0j8iV5PRQYus725BOSco=;
        b=b194pnNo1apqKXU+4NuTWop6ZQHVnbRuVqKDFhpeGiDSoN+NQMtWjIjmISQWEPxgynBc2q
        OusK/TwI76vdv5o2nNkxFrWFWO3FvafdFcsgT+K0+eZhA6OV+CyZBjjRoS4XvnVi9oVBi4
        j2fFsgDlUpFTGV4y1wkBSueKk8yqD1tY2iyARCCyjXMUPKOGsVThdXyvTKNIfanR6Nrt5Q
        yYYPZbLYN0crtAF0drCd0tBU4WVPAOjcJDHfcE+5Wf0zTopp9gqbkB/Pd58CbsEHkEUGwT
        S30sWTX2C+0fD6qBInLwCLOQzndQ2t1Oq0UIcedjhD37MbbzAknFP8ltxklbyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593683304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7KSu5ePUYPphRAI7CrnncN0j8iV5PRQYus725BOSco=;
        b=nOAaJfzPAWxVHMyUanA1ZLP605ez5M0ySgJLrnD1usftFoTh/KuJzn2ET6lHATao8o7yuk
        wFakN5Ho2qUURAAg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
In-Reply-To: <20200701011030.14324-2-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org> <20200701011030.14324-2-frederic@kernel.org>
Date:   Thu, 02 Jul 2020 11:48:23 +0200
Message-ID: <87sgea9riw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> When a timer is enqueued with a negative delta (ie: expiry is below
> base->clk), it gets added to the wheel as expiring now (base->clk).
>
> Yet the value that gets stored in base->next_expiry, while calling
> trigger_dyntick_cpu(), is the initial timer->expires value. The
> resulting state becomes:
>
> 	base->next_expiry < base->clk
>
> On the next timer enqueue, forward_timer_base() may accidentally
> rewind base->clk. As a possible outcome, timers may expire way too
> early, the worst case being that the highest wheel levels get spuriously
> processed again.

Bah. Nice catch.

> To prevent from that, make sure that base->next_expiry doesn't get below
> base->clk.

That wants a Fixes: tag and a CC stable.

Thanks,

        tglx
