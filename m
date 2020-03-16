Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4583C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D86B206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584348438;
	bh=1tLbDYlqlB6pPxS950lezICdCwJX/DkBWBo6RPPowVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ArIxOBiVtmEhJ95Sm2tSvm2JY0xXKCYGDmZ0xR8k8D5OXcclhdielLo7JFFCOtP6V
	 XzP4g7LBBRMt4zc8l4ecVloKH9uW8gcuSkWnsvrGecAEbFh98NZVGw/mtHfZnXPq/c
	 qxc4mnuZCuYf8FmrP2C3/yDM4Gzw93i1MPgzcPxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgCPIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbgCPIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:47:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6866D20663;
        Mon, 16 Mar 2020 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584348436;
        bh=1tLbDYlqlB6pPxS950lezICdCwJX/DkBWBo6RPPowVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXkiHRnGStNQyTlodxWkuHXastLZkGJkb7OLk/FHj1hl/UCQ6j2bYI62EmkG4J7TR
         D2kJ/P+rnMxDsnFgzM4UIyrq9WVXg2lAglGP9ZG6LlyPOBneyi6atsl8TaUcrmmx5q
         l0XJq2Snnpt9K9hq67O0stHiozFAX6xosSezw0j0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDlP0-00D1q7-Ow; Mon, 16 Mar 2020 08:47:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Mar 2020 08:47:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gic-v4: Fix non-stick page size error for setup
 GITS_BASER
In-Reply-To: <fd58dac2-ec20-14b7-53c5-96d798f4ffed@hisilicon.com>
References: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
 <9a00642020fe660e005045913b57fd20@kernel.org>
 <fd58dac2-ec20-14b7-53c5-96d798f4ffed@hisilicon.com>
Message-ID: <f077895c10ba57ac2973e49ec452b269@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org, tangnianyao@huawei.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaokun,

On 2020-03-16 05:48, Shaokun Zhang wrote:
> Hi Marc，
> 
> On 2020/3/13 20:00, Marc Zyngier wrote:
>> Shaokun, Nianyao,
>> 
>> On 2020-03-13 08:46, Shaokun Zhang wrote:
>>> From: Nianyao Tang <tangnianyao@huawei.com>
>>> 
>>> There is an error when ITS is probed if hw GITS_BASER<2>
>>> only supports psz=SZ_16K while GITS_BASER<1> only supports psz=SZ_4K.
>>> In its_alloc_tables, it has updated GITS_BASER<1>.psz and uses
>>> psz=SZ_4K for setup GITS_BASER<2>, and would fail in writing
>>> GITS_BASER<2>.psz=SZ_4K. 4K PAGE is the smallest and shall stop retry
>>> for other page sizes.
>>> 
>>> That latter GITS_BASER<n>.psz is larger than former, will lead
>>> to similar error.
>>> 
>>> [    0.000000] ITS@0x0000000660000000: Virtual CPUs doesn't stick:
>>> ba1f0824404004ff ba1f0824404005ff
>>> [    0.000000] ITS@0x0000000660000000: failed probing (-6)
>>> [    0.000000] ITS: No ITS available, not enabling LPIs
>>> 
>>> From GIC SPEC document, it's allowed for this implematation, the 
>>> latter
>>> GITS_BASER<n>.psz is larger than the former.
>> 
>> I was really hoping nobody would build an ITS with disjoint sets of
>> page sizes. Oh well...
>> 
>>> Let's fix this error with following patch.
>>> 
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>>> ---
>>>  drivers/irqchip/irq-gic-v3-its.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>> 
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>>> b/drivers/irqchip/irq-gic-v3-its.c
>>> index 83b1186..59bf8d6 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -2341,7 +2341,6 @@ static int its_alloc_tables(struct its_node 
>>> *its)
>>>          }
>>> 
>>>          /* Update settings which will be used for next BASERn */
>>> -        psz = baser->psz;
>>>          cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
>>>          shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
>>>      }
>> 
>> I think this just papers over the problem, and I'd rather tackle it 
>> fully
>> by forcing the probe of the supported page sizes for each GITS_BASERn
>> register. See the patch below (which I've only boot-tested once on 
>> pretty
>> standard HW as well as a guest).
>> 
>> This, in turn, simplifies the way we perform the allocation (no nested
>> retry loop). This is of course a much more patch invasive, but at 
>> least
>> it doesn't leave too much cruft behind.
>> 
>> Please let me know whether this solves your issue.
>> 
> 
> Thanks your quick reply.
> With your following fixed patch, it can work for Nianyao, So:
> Tested-by: Nianyao Tang <tangnianyao@huawei.com>

Thanks for the quick feedback. I've now added this patch to the 5.7 
queue.

         M.
-- 
Jazz is not dead. It just smells funny...
