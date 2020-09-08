Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA32E2078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599558323;
	bh=tfoO6sBrCFwjFEDiVadFmL4RK2FiO10DeRPjiK99h2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lofw6v/4RcCs+TNPjrrBrjjQUNPSc/yV3ajghg1griD9uPt/pVYhJxkrB83UTdSfX
	 p2vRFHxfbpM9N4dvYsfFTjv6RteEBiHZZG4M1Epqb8RsU10LYuLxAN+pHKADeDIVS6
	 0DjdPanQrW1qrkFYICBzQudp51ICiqDEV6OzsbNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgIHJpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgIHJpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:45:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4152076C;
        Tue,  8 Sep 2020 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599558319;
        bh=tfoO6sBrCFwjFEDiVadFmL4RK2FiO10DeRPjiK99h2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n8/ttHz2cIWHhRQ34jw+ezIerfI/nf+9zyLGaoAyQ43agt6zo9p/VEu7kLupn4EkA
         taepdfy8/ZEKf5DExEy2wkoU5gSHEMaPym6qlfrCgQvR0bew8CCrRDT6aItt0ZTx8Z
         tW5ckCd+38b0UxEGz7M8a23U7Mz3SHp2E+MRcJKk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kFaBh-00A1El-C9; Tue, 08 Sep 2020 10:45:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 08 Sep 2020 10:45:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 2/3] irqchip: dw-apb-ictl: support hierarchy irq domain
In-Reply-To: <0e860ff8-3e72-1099-c28c-c5a0bc28f2c4@huawei.com>
References: <20200908071134.2578-1-thunder.leizhen@huawei.com>
 <20200908071134.2578-3-thunder.leizhen@huawei.com>
 <8f6e4cc51a53f580538b879cafcd06c3@kernel.org>
 <0e860ff8-3e72-1099-c28c-c5a0bc28f2c4@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <0622508a42d5a5b25582a6ebd69ec1d2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: thunder.leizhen@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com, lvhaoyu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-08 10:40, Leizhen (ThunderTown) wrote:
> On 2020/9/8 15:41, Marc Zyngier wrote:
>> On 2020-09-08 08:11, Zhen Lei wrote:
>>> Add support to use dw-apb-ictl as primary interrupt controller.
>>> 
>>> Suggested-by: Marc Zyngier <maz@kernel.org>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> Tested-by: Haoyu Lv <lvhaoyu@huawei.com>
>>> ---
>>>  drivers/irqchip/Kconfig           |  2 +-
>>>  drivers/irqchip/irq-dw-apb-ictl.c | 75 
>>> +++++++++++++++++++++++++++++--
>>>  2 files changed, 73 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index bfc9719dbcdc..7c2d1c8fa551 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -148,7 +148,7 @@ config DAVINCI_CP_INTC
>>>  config DW_APB_ICTL
>>>      bool
>>>      select GENERIC_IRQ_CHIP
>>> -    select IRQ_DOMAIN
>>> +    select IRQ_DOMAIN_HIERARCHY
>>> 
>>>  config FARADAY_FTINTC010
>>>      bool
>>> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c
>>> b/drivers/irqchip/irq-dw-apb-ictl.c
>>> index aa6214da0b1f..405861322596 100644
>>> --- a/drivers/irqchip/irq-dw-apb-ictl.c
>>> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/irqchip/chained_irq.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_irq.h>
>>> +#include <asm/exception.h>
>>> 
>>>  #define APB_INT_ENABLE_L    0x00
>>>  #define APB_INT_ENABLE_H    0x04
>>> @@ -26,6 +27,30 @@
>>>  #define APB_INT_FINALSTATUS_H    0x34
>>>  #define APB_INT_BASE_OFFSET    0x04
>>> 
>>> +/*
>>> + * irq domain of the primary interrupt controller. Currently, only 
>>> one is
>>> + * supported.
>> 
>> By definition, there is only one primary interrupt controller.
> 
> OK, I will delete the comment "Currently, only one is supported".
> Should I replace it with your commend above?

No, just delete it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
