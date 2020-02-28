Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31CEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61DF246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582916029;
	bh=MFYr4JHDpIRMtAGtAdwhhoGsff0cKCIWBLM/1Gcb63g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P6fJvv6CLqju4+N2/vtzpnIhWnWe5MNnUkAKSSS2R3rGKEPMy8/9neEVL+soCSjZL
	 L6o+UycK/MT4mIhD6gVez/thRhAKVZMPKXxa39NjMSODFLjwsiOIOhTILGhMY001/E
	 Np0xkF3iQ2Vi/bznmfM25Q8Q3B0ih7rwUKXdVTSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1Sxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Sxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:53:48 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E1C20675;
        Fri, 28 Feb 2020 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582916027;
        bh=MFYr4JHDpIRMtAGtAdwhhoGsff0cKCIWBLM/1Gcb63g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dmQUO+iHish0Tcs0ly1N8gWrBeWUx/bWK4XIoBjBjGC42YW+8eImn1/AeKjBxJT4j
         o8CMAJ3wvo7ituwW8qUWlwcDQCUw0LbFUDBAZvTjrbG2nP6pXj4u9S3b5YDZwElzB/
         j8rz2WAx3sxeqlaueWBtRHdCCWeNPywrMNA7BWX0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j7kld-008pcH-Pj; Fri, 28 Feb 2020 18:53:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 18:53:45 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v2 PATCH] irqchip/sifive-plic: Add support for multiple PLICs
In-Reply-To: <20200221232246.9176-1-atish.patra@wdc.com>
References: <20200221232246.9176-1-atish.patra@wdc.com>
Message-ID: <6a1320aed9609788ccb61d6c66d670bb@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: atish.patra@wdc.com, linux-kernel@vger.kernel.org, jason@lakedaemon.net, linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 23:22, Atish Patra wrote:
> Current, PLIC driver can support only 1 PLIC on the board. However,
> there can be multiple PLICs present on a two socket systems in RISC-V.
> 
> Modify the driver so that each PLIC handler can have a information
> about individual PLIC registers and an irqdomain associated with it.
> 
> Tested on two socket RISC-V system based on VCU118 FPGA connected via
> OmniXtend protocol.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
> This patch is rebased on top of 5.6-rc2 and following plic fix from
> hotplug series.
> 
> https://lkml.org/lkml/2020/2/20/1220

How do you want this to be merged? I haven't really followed the hotplug
series, but given that this is a pretty simple patch, I'd rather have 
things
based the other way around so that it can be merged independently.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
