Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC542C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FB72084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583676091;
	bh=X3YvXzX7p6Ena+DgRT3/4dg6a/xcfDnFXVT37QOa1t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gOpryDRF8g//X8/YpNrY0KstIwXznp/F6+VAH+iNxExqvK87Cz1RnhsrjWV8JAiBF
	 J2kkO05jJvPGQovIL+OkxF3p/RfeSyf7o7VhTzKLOP1ueFZ5AFT/n9DCA4BAeNzRv7
	 fWCaWIfTKLgddt+2mZHOTVTwepQoBnpMklzUjZs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCHOBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHOBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:01:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B948F206D7;
        Sun,  8 Mar 2020 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583676089;
        bh=X3YvXzX7p6Ena+DgRT3/4dg6a/xcfDnFXVT37QOa1t0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0+C0xjMF5e5x/1FyYpy5P875i3pPVeznQWDKtAAldnctqZQn8BO/DgTmPci/Mxt+N
         xfv5rS0GoWgeRbwzxNKf9pQ670cNSbzEP/7DOpbfLKO+RNg9tBelLbBJZw8cUwn2rt
         4cuDghu5elNBeuXkHvfCtHbK/rCRysRRtUDXAUgA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwUi-00B2ko-1R; Sun, 08 Mar 2020 14:01:28 +0000
Date:   Sun, 8 Mar 2020 14:01:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Jason Cooper <jason@lakedaemon.net>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] irqchip: xilinx: Switch to generic domain
 handler
Message-ID: <20200308140126.51eeebc4@why>
In-Reply-To: <cover.1582545908.git.michal.simek@xilinx.com>
References: <cover.1582545908.git.michal.simek@xilinx.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, jason@lakedaemon.net, mubinusm@xilinx.com, stefan.asserhall@xilinx.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 13:05:12 +0100
Michal Simek <michal.simek@xilinx.com> wrote:

> Hi,
> 
> this series is based on cascade mode patch sent by Mubin
> (https://lkml.org/lkml/2020/2/11/888 - v3 series).
> 
> The first patch is just fixing error patch. The second is converting microblaze
> do_IRQ() to generic IRQ handler with appropriate changes in xilinx intc driver.
> 
> Also removes concurrent_irq global variable which wasn't wired
> anywhere but it stores number of concurrent IRQs handled by one call. There
> is option to get it back if needed but I haven't seen it in other archs
> that's why I have removed it too.

Queued for 5.7.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
