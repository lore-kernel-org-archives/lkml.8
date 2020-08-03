Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D32620738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgHCLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:48:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHCLsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:48:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1775F30E;
        Mon,  3 Aug 2020 04:48:42 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F5C3F71F;
        Mon,  3 Aug 2020 04:48:40 -0700 (PDT)
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <20200803081625.czdfwcpw5emcd4ls@skbuf> <f61560f5-c4e0-a40b-5845-af3f6d98c7ad@arm.com> <20200803113841.pqqpo4hqfwru3upq@skbuf>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        paulmck@kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        catalin.marinas@arm.com, Alison Wang <alison.wang@nxp.com>,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
        mw@semihalf.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-reply-to: <20200803113841.pqqpo4hqfwru3upq@skbuf>
Date:   Mon, 03 Aug 2020 12:48:35 +0100
Message-ID: <jhjime0hrvw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/08/20 12:38, Vladimir Oltean wrote:
> On Mon, Aug 03, 2020 at 10:51:32AM +0100, Robin Murphy wrote:
>> 
>> Having glanced across another thread that mentions IRQ accounting
>> recently[1], I wonder if the underlying bug here might have something do to
>> with the stuff that Marc's trying to clean up.
>> 
>> Robin.
>> 
>> [1] https://lore.kernel.org/linux-arm-kernel/20200624195811.435857-16-maz@kernel.org/
>
> Thanks Robin. I've applied Marc's "[PATCH v2 00/17] arm/arm64: Turning
> IPIs into normal interrupts" series and the LS1028A I'm debugging hangs
> in absolutely the same way.
>

I'm not too surprised by that, wrt accounting this mostly changes where the
stores go to and barely shuffles when they happen (slightly earlier on the
IPI handling path).

FWIW I've had 'stress-ng --hrtimers 1' running on my Juno and eMAG for ~15
minutes and haven't had a splat yet. 

> -Vladimir

