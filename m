Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9138220738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591197411;
	bh=8vfgBSrae1Sl/Co8GuGiBgYLsvF7HA7YclCM8lPnj00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lbhCDS+F3QydRaKE8BWPdh42s6ciTQjJKafrzN61nyzd2dIdakVOlTkxfQZJRKjEq
	 D7CE3LbqEmG7w30QYxKB7LZ6y2EqDkOzO0iw4s/YqDqqMtDS43HbRfi9DPUDZBGKfp
	 9G0VClA4+mUbMQ935jznenzMHYq6LMqI9qDm42qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCPQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgFCPQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:16:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA17D206E6;
        Wed,  3 Jun 2020 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591197409;
        bh=8vfgBSrae1Sl/Co8GuGiBgYLsvF7HA7YclCM8lPnj00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m3jJeo6lRuQ/vrRynASEprCi/bRIUGaRSPi5aAhrtSctPEaYpqEArdFme9bVSBOEJ
         w4UTYgt9Ysw8WAI1PfQNDp5kCgvW93kVXGqin/tZ0rkMeOAeQJmH6wQ+A1RfXlL5nV
         mmiINRD+WgMbVywc7EV4SJqSkJ6deRbaX1mIS4sI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgV8K-00HUXD-7G; Wed, 03 Jun 2020 16:16:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 03 Jun 2020 16:16:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Saidi, Ali" <alisaidi@amazon.com>
Cc:     "Herrenschmidt, Benjamin" <benh@amazon.com>, tglx@linutronix.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <AE04B507-C5E2-44D2-9190-41E9BE720F9D@amazon.com>
References: <AE04B507-C5E2-44D2-9190-41E9BE720F9D@amazon.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <622fb6be108e894ee365d6b213535c8b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alisaidi@amazon.com, benh@amazon.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dwmw@amazon.co.uk, zeev@amazon.com, zorik@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-02 19:47, Saidi, Ali wrote:

[...]

> Looks like the x86 apic set_affinity call explicitly checks for if
> it’s activated in the managed case which makes sense given the code
> Ben posted above:
>           /*
>            * Core code can call here for inactive interrupts. For 
> inactive
>            * interrupts which use managed or reservation mode there is 
> no
>            * point in going through the vector assignment right now as 
> the
>            * activation will assign a vector which fits the destination
>            * cpumask. Let the core code store the destination mask and 
> be
>            * done with it.
>            */
>           if (!irqd_is_activated(irqd) &&
>               (apicd->is_managed || apicd->can_reserve))
> 
> My original patch should certain check activated and not disabled.
> With that do you still have reservations Marc?

I'd still prefer it if we could do something in core code, rather
than spreading these checks in the individual drivers. If we can't,
fair enough. But it feels like the core set_affinity function could
just do the same thing in a single place (although the started vs
activated is yet another piece of the puzzle I didn't consider,
and the ITS doesn't need the "can_reserve" thing).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
