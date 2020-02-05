Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA665C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5FC2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580906799;
	bh=GfGSMXXeXChdHY2rFyfqEnWPYUrl7k3y4PXuksqSPxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hrJWEvAIxPFPVI9YM260Zohu38nDzVp/vS+79HI7fbHEZ0O+qw2xq+sFNvrXGSvDo
	 bEFizCp26PtEu9LoyOhWzThDoDuSgzCTpOz/9zSi9YOwPQ9UYGe68Ot2MJWQiLx6Dz
	 R9WJtJ4nTxcRjFzcwEHUhn2YgeUHMkT4G8hi5pSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBEMqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgBEMqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:46:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6FC20702;
        Wed,  5 Feb 2020 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580906797;
        bh=GfGSMXXeXChdHY2rFyfqEnWPYUrl7k3y4PXuksqSPxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MMo0yvYVxHW6Ixw5DBnn9oa1n/Z6efinNp30im/8hwmaiqSxnnz2ll2SgDS2KifNh
         SpqDffeu0rM2ygdSsyGGqC/wnOcfv28oW/XLzPxC4VpH+UnWWAfRJhWzOcVRkKJezh
         KQDjqqsYfIdPBc+UZa49K//qIZGwFqxl+vBcqCqc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izK4h-00388J-VA; Wed, 05 Feb 2020 12:46:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 12:46:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
Subject: Re: [PATCH 0/5] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
In-Reply-To: <20200204090940.1225-1-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
Message-ID: <004ca9ea2d525d5b1bcf1d78f10c61ba@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-02-04 09:09, Zenghui Yu wrote:
> Hi,
> 
> This series contains some cleanups, VPROPBASER field programming fix
> and level2 vPE table allocation enhancement, collected while looking
> through the GICv4.1 driver one more time.
> 
> Hope they will help, thanks!
> 
> Zenghui Yu (5):
>   irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
>   irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
>   irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
>   irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
>   irqchip/gic-v3-its: Remove superfluous WARN_ON
> 
>  drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++++++++++---
>  include/linux/irqchip/arm-gic-v3.h |  2 +-
>  2 files changed, 75 insertions(+), 7 deletions(-)

Thanks a lot for this, much appreciated, I'm quite happy with the 
overall
state of the series. If you can just address the couple of nits I have 
on
patch #3, I'll then queue the series and send off to Thomas together 
with
the rest of the queued fixes.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
