Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC279C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55EF221ED
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIKQmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgIKPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:10:04 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E29E20575;
        Fri, 11 Sep 2020 15:05:42 +0000 (UTC)
Date:   Fri, 11 Sep 2020 16:05:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal
 interrupts
Message-ID: <20200911150539.GD12835@gaia>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901144324.1071694-4-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:43:11PM +0100, Marc Zyngier wrote:
> In order to deal with IPIs as normal interrupts, let's add
> a new way to register them with the architecture code.
> 
> set_smp_ipi_range() takes a range of interrupts, and allows
> the arch code to request them as if the were normal interrupts.
> A standard handler is then called by the core IRQ code to deal
> with the IPI.
> 
> This means that we don't need to call irq_enter/irq_exit, and
> that we don't need to deal with set_irq_regs either. So let's
> move the dispatcher into its own function, and leave handle_IPI()
> as a compatibility function.
> 
> On the sending side, let's make use of ipi_send_mask, which
> already exists for this purpose.
> 
> One of the major difference is that we end up, in some cases
> (such as when performing IRQ time accounting on the scheduler
> IPI), end up with nested irq_enter()/irq_exit() pairs.
> Other than the (relatively small) overhead, there should be
> no consequences to it (these pairs are designed to nest
> correctly, and the accounting shouldn't be off).
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

In case you need an ack for the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
