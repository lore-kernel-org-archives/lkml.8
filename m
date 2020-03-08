Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC0F2084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583675977;
	bh=0i5E1+7qOjaVYmSole07kk9HeR7FiaaKRB5ktGbe5Yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VwXbGkWfwzRl9ZegnwFTFcHBr52L6CWEpTY1opZnukF5SBrGlD7Dtr5Rd/5kiZPV6
	 vbjhOI9A9kR3XRmNBDH3VA/UL9/yGIOniRKOCw/e2Shdl4lfoEcBhpkWiU4mi34ckv
	 5gPBS4+OerzWFbeZaLiGosNUuHc1jsHUqmlgSDJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCHN7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHN7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:59:35 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED2B206D7;
        Sun,  8 Mar 2020 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583675975;
        bh=0i5E1+7qOjaVYmSole07kk9HeR7FiaaKRB5ktGbe5Yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXqNv88mZHtri4Ucddv3jFGd4GBjlGH80ugf1qToiHrGx+fqNeeXR3WK3AcnuJhJg
         FlOkPEEUt7qjSOBlo+VLTAlja1dXtIA2hAtdH3k13gJerWGaWfYNYOtJbFN7nqZcoG
         yU10gC12p7X9We8Y61AmHLmd3K16OrJZ8M6S7ft4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwSr-00B2jV-Jn; Sun, 08 Mar 2020 13:59:33 +0000
Date:   Sun, 8 Mar 2020 13:59:31 +0000
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
Message-ID: <20200308135931.331f9be4@why>
In-Reply-To: <20200302231146.15530-2-atish.patra@wdc.com>
References: <20200302231146.15530-1-atish.patra@wdc.com>
        <20200302231146.15530-2-atish.patra@wdc.com>
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

On Mon,  2 Mar 2020 15:11:45 -0800
Atish Patra <atish.patra@wdc.com> wrote:

> Currently, PLIC threshold is only initialized once in the beginning.
> However, threshold can be set to disabled if a CPU is marked offline with
> CPU hotplug feature. This will not allow to change the irq affinity to a
> CPU that just came online.
> 
> Add PLIC specific CPU hotplug callbacks and enable the threshold when a CPU
> comes online. Take this opportunity to move the external interrupt enable
> code from trap init to PLIC driver as well. On cpu offline path, the driver
> performs the exact opposite operations i.e. disable the interrupt and
> the threshold.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Both patches queued for 5.7 (please add a cover letter when sending a
patch series).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
