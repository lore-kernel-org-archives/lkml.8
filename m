Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7510C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E68F20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596461083;
	bh=2P+e2agXRGcCDzDHK4A1fBjviZ3qjpqZf+OAaU5r/yI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cuKFpZFRmB7IO9zjKa8SpNPIIBVvLLbvy8fNT6W254wYRsE7XbO2zpbnrTYDS6lZC
	 97MhKRALXrhRwsRBKdEaNizqwn38Xc47QKQZk2yadvvA90mx4WgoV7ogNXEWZV3VKa
	 X3Y0+a8XYrsl/BpGNoj8f687T1rFzDsEI4zUGjmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgHCNYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgHCNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:24:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92F8206DA;
        Mon,  3 Aug 2020 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596461081;
        bh=2P+e2agXRGcCDzDHK4A1fBjviZ3qjpqZf+OAaU5r/yI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c9a7+KENOfxIs/9Iy0vX6YmkAbT9I0gWZfOk+2qE3wyDmUQ8+1XKIonsF9mYrgMoo
         NXZ6S1ltT2KaaZZopvvYsND60TMzjzkYAO62THhGEenXbB1aSZ/DlkQodEId8wu7J8
         QBUWGbpWbwl8wBmW5XfkMD3LuAuIHGcqpf12w/68=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k2aSF-00H7Mr-Vt; Mon, 03 Aug 2020 14:24:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 14:24:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        paulmck@kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        catalin.marinas@arm.com, Alison Wang <alison.wang@nxp.com>,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
        mw@semihalf.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ
 time accounting
In-Reply-To: <jhjime0hrvw.mognet@arm.com>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt> <20200803081625.czdfwcpw5emcd4ls@skbuf>
 <f61560f5-c4e0-a40b-5845-af3f6d98c7ad@arm.com>
 <20200803113841.pqqpo4hqfwru3upq@skbuf> <jhjime0hrvw.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <34b6cca5355f9e709554892261ac4b0c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, olteanv@gmail.com, robin.murphy@arm.com, kurt.kanzenbach@linutronix.de, paulmck@kernel.org, anna-maria@linutronix.de, catalin.marinas@arm.com, alison.wang@nxp.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, vladimir.oltean@nxp.com, tglx@linutronix.de, mw@semihalf.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03 12:48, Valentin Schneider wrote:
> On 03/08/20 12:38, Vladimir Oltean wrote:
>> On Mon, Aug 03, 2020 at 10:51:32AM +0100, Robin Murphy wrote:
>>> 
>>> Having glanced across another thread that mentions IRQ accounting
>>> recently[1], I wonder if the underlying bug here might have something 
>>> do to
>>> with the stuff that Marc's trying to clean up.
>>> 
>>> Robin.
>>> 
>>> [1] 
>>> https://lore.kernel.org/linux-arm-kernel/20200624195811.435857-16-maz@kernel.org/
>> 
>> Thanks Robin. I've applied Marc's "[PATCH v2 00/17] arm/arm64: Turning
>> IPIs into normal interrupts" series and the LS1028A I'm debugging 
>> hangs
>> in absolutely the same way.
>> 
> 
> I'm not too surprised by that, wrt accounting this mostly changes where 
> the
> stores go to and barely shuffles when they happen (slightly earlier on 
> the
> IPI handling path).

Indeed. This series is just a "let's make things be the way they should 
be",
and isn't really fixing any bug. It actually may introduce a couple...

> FWIW I've had 'stress-ng --hrtimers 1' running on my Juno and eMAG for 
> ~15
> minutes and haven't had a splat yet.

I've started a couple of VMs with that workload too. 400K irq/s on an
8 vcpu guest, nothing to report so far.

But removing IRQ_TIME_ACCOUNTING from defconfig is a resounding "no 
way!".
It looks like we have a bug, and it should be squashed, not glanced 
over.

         M.
-- 
Jazz is not dead. It just smells funny...
