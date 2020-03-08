Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4CC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F87F2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583678382;
	bh=AMd0h0/qwrlKb60N+y/bZccBrEPrwM6M0GofBq5BRyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DurnDAa3M4WvYdK37CaDJ6RkpC1T+UXEe3FfiluJUefz8VaSOD4jsyzzYi90Dwa2x
	 kz3Doefnfr4LYODM5oA+KBDUAb7eq3/JaQztapOQoNeM9M7vj9oy213OhcKsC+c8rY
	 rTDwsoD5WVSffDfqA0OkEXvJMwspwAhv1K176QKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCHOjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgCHOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:39:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2C0206D7;
        Sun,  8 Mar 2020 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583678351;
        bh=AMd0h0/qwrlKb60N+y/bZccBrEPrwM6M0GofBq5BRyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJfYi7Es7/Rk36TmElQNtAtib6Gk+L5JPtAMRh5ULtEF68pz2E3sehoE/h0BApUbK
         6jM8jMfUExCvJvhos19Fpgg4vUgjIcink8jVBn2APpB4LWyKcrLmMtvCxY/dqij0FN
         OZE4vjEBAT6ZyNPmBcBADNW0NjB1vh6c9/NWElAw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAx5B-00B39e-K4; Sun, 08 Mar 2020 14:39:09 +0000
Date:   Sun, 8 Mar 2020 14:39:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v3 1/2] irqchip/sifive-plic: Enable/Disable external
 interrupts upon cpu online/offline
Message-ID: <20200308143907.51f8eddc@why>
In-Reply-To: <20200308135931.331f9be4@why>
References: <20200302231146.15530-1-atish.patra@wdc.com>
        <20200302231146.15530-2-atish.patra@wdc.com>
        <20200308135931.331f9be4@why>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: atish.patra@wdc.com, linux-kernel@vger.kernel.org, anup@brainfault.org, aou@eecs.berkeley.edu, anju@linux.vnet.ibm.com, anup.patel@wdc.com, bp@suse.de, ebiederm@xmission.com, james.morse@arm.com, jason@lakedaemon.net, linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, rafael.j.wysocki@intel.com, steven.price@arm.com, tglx@linutronix.de, ulf.hansson@linaro.org, vincent.chen@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Mar 2020 13:59:31 +0000
Marc Zyngier <maz@kernel.org> wrote:

> On Mon,  2 Mar 2020 15:11:45 -0800
> Atish Patra <atish.patra@wdc.com> wrote:
> 
> > Currently, PLIC threshold is only initialized once in the beginning.
> > However, threshold can be set to disabled if a CPU is marked offline with
> > CPU hotplug feature. This will not allow to change the irq affinity to a
> > CPU that just came online.
> > 
> > Add PLIC specific CPU hotplug callbacks and enable the threshold when a CPU
> > comes online. Take this opportunity to move the external interrupt enable
> > code from trap init to PLIC driver as well. On cpu offline path, the driver
> > performs the exact opposite operations i.e. disable the interrupt and
> > the threshold.
> > 
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>  
> 
> Both patches queued for 5.7 (please add a cover letter when sending a
> patch series).

Apologies, there was a cover letter. I just messed my filters... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
