Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2152078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591801378;
	bh=PXOXPvrJV7xGGbzYC9/oZT86BtGS3IQuSBt+aeT7chk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jP2hx6O3I1LQ4LL1d6eWsWUkg1m9tDIdYPXzwdZpiJhirbDxh+OGECqPeFEZYxXOa
	 jdQTimy5uYLzFVSTilt403XOGjOJKhPxPr+5P4FH+Dy85ym9f+6NxgTt5QeDJC/9Uy
	 L4fvD0EbOq5AO23nqKx8wGyXpHdZbLwikRfDqKjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgFJPC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgFJPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:02:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EFAF2072F;
        Wed, 10 Jun 2020 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591801375;
        bh=PXOXPvrJV7xGGbzYC9/oZT86BtGS3IQuSBt+aeT7chk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=miZS9oRoEjrNMU1meThJvdtBXhi0h+mnI4aLe1ZvYLzne2pS5A2ymCsWzRULdvM9S
         0ypO5Pvib76X09QkaaLDBbZ8rIOJhHK3/OMNBf2gitnzI5QSV7LbgGkbH0NuXtBbdN
         zyZai7/svsw881Su3czNZ57SY+WVUFfSJTBhNs0c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jj2Fi-001ofe-4F; Wed, 10 Jun 2020 16:02:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jun 2020 16:02:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com,
        wangjingyi11@huawei.com
Subject: Re: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix
 sleep in atomic
In-Reply-To: <4a9822bd-0362-7ffe-6e56-3f05a7816d9e@huawei.com>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
 <4a9822bd-0362-7ffe-6e56-3f05a7816d9e@huawei.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <2bff9c0af0aa5eeef44b381ee0f8a542@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com, wangjingyi11@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-06-10 14:59, Zenghui Yu wrote:
> Hi Marc,
> 
> Sorry to ping you in the merge window, but ...
> 
> On 2020/6/5 13:23, Zenghui Yu wrote:
>> readx_poll_timeout() can sleep if @sleep_us is specified by the 
>> caller,
>> and is therefore unsafe to be used inside the atomic context, which is
>> this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
>> irq_set_vcpu_affinity() callback.
> 
> this seems like an urgent thing to me. Without this patch, CPUs are
> easily to get stuck on my board with GICv4.1 enabled. So it'd be good 
> if
> you can have a look and take this as a fix (if it is correct).

No worries. I've earmarked the patch for -rc1 already, just haven't got
a chance to build the branch yet (a bit busy on the KVM side).

I'll probably update the branch tonight or tomorrow.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
