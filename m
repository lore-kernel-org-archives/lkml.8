Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53762177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgG1IBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:01:34 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:39027 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgG1IBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:01:34 -0400
Received: from [192.168.43.110] ([93.23.107.187])
        by mwinf5d84 with ME
        id 8Y1M2300G42dCi503Y1PRA; Tue, 28 Jul 2020 10:01:31 +0200
X-ME-Helo: [192.168.43.110]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 28 Jul 2020 10:01:31 +0200
X-ME-IP: 93.23.107.187
Subject: Re: [PATCH 2/2] media: bt8xx: avoid a useless memset
To:     Joe Perches <joe@perches.com>, mchehab@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200727135151.54757-1-christophe.jaillet@wanadoo.fr>
 <0897d9bec8865859694c917f3f72ab8fd12321ff.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <b883b856-af1e-a017-6af2-2aca575c24d5@wanadoo.fr>
Date:   Tue, 28 Jul 2020 10:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0897d9bec8865859694c917f3f72ab8fd12321ff.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/07/2020 à 18:09, Joe Perches a écrit :
> On Mon, 2020-07-27 at 15:51 +0200, Christophe JAILLET wrote:
>> Avoid a memset after a call to 'dma_alloc_coherent()'.
>> This is useless since
>> commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")
> []
>> diff --git a/drivers/media/pci/bt8xx/btcx-risc.c b/drivers/media/pci/bt8xx/btcx-risc.c
> []
>> @@ -73,7 +73,6 @@ int btcx_riscmem_alloc(struct pci_dev *pci,
>>   		dprintk("btcx: riscmem alloc [%d] dma=%lx cpu=%p size=%d\n",
>>   			memcnt, (unsigned long)dma, cpu, size);
>>   	}
>> -	memset(risc->cpu,0,risc->size);
>>   	return 0;
>>   }
> 
> Likely NAK.
> 
> This is not useless as risc->cpu may be reused
> and the alloc may not have been done.
> 
> 
> 
Agreed.
This 2/2 patch should be NAK'ed.

I've been a bit too fast on this one.
Thanks for the review Joe.

CJ
