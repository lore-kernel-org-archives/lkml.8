Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A5C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C1B2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgGWI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:59:53 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:31288 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgGWI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:59:53 -0400
Received: from [192.168.43.110] ([93.23.16.85])
        by mwinf5d15 with ME
        id 6Yzp2300S1q71ed03Yzqlf; Thu, 23 Jul 2020 10:59:51 +0200
X-ME-Helo: [192.168.43.110]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 23 Jul 2020 10:59:51 +0200
X-ME-IP: 93.23.16.85
Subject: Re: [PATCH 1/2] misc: hpilo: switch from 'pci_' to 'dma_' API
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200718070224.337964-1-christophe.jaillet@wanadoo.fr>
 <20200723073433.GA1273491@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <15e5f2e4-a623-3fc2-36b6-4132ee316220@wanadoo.fr>
Date:   Thu, 23 Jul 2020 10:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723073433.GA1273491@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/07/2020 à 09:34, Greg KH a écrit :
> On Sat, Jul 18, 2020 at 09:02:24AM +0200, Christophe JAILLET wrote:
>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>
>> The patch has been generated with the coccinelle script below and has been
>> hand modified to replace GFP_ with a correct flag.
>> It has been compile tested.
>>
>> When memory is allocated in 'ilo_ccb_setup()' GFP_ATOMIC must be used
>> because a spin_lock is hold in 'ilo_open()' before calling
>> 'ilo_ccb_setup()'

        ^
        |

>> [...]
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>>     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
>> ---
>>   drivers/misc/hpilo.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
>> index 10c975662f8b..c9539c89a925 100644
>> --- a/drivers/misc/hpilo.c
>> +++ b/drivers/misc/hpilo.c
>> @@ -256,7 +256,8 @@ static void ilo_ccb_close(struct pci_dev *pdev, struct ccb_data *data)
>>   	memset_io(device_ccb, 0, sizeof(struct ccb));
>>   
>>   	/* free resources used to back send/recv queues */
>> -	pci_free_consistent(pdev, data->dma_size, data->dma_va, data->dma_pa);
>> +	dma_free_coherent(&pdev->dev, data->dma_size, data->dma_va,
>> +			  data->dma_pa);
>>   }
>>   
>>   static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
>> @@ -272,8 +273,8 @@ static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
>>   			 2 * desc_mem_sz(NR_QENTRY) +
>>   			 ILO_START_ALIGN + ILO_CACHE_SZ;
>>   
>> -	data->dma_va = pci_alloc_consistent(hw->ilo_dev, data->dma_size,
>> -					    &data->dma_pa);
>> +	data->dma_va = dma_alloc_coherent(&hw->ilo_dev->dev, data->dma_size,
>> +					  &data->dma_pa, GFP_ATOMIC);
> 
> This is being called from open() so it can be GFP_KERNEL.  Can you fix
> that up and resend a new version?
> 
> thanks,
> 
> greg k-h
> 

The call chain is:
    .open	                       (file_operations)
       --> ilo_open
	  spin_lock(&hw->open_lock);   (around line 782)
          --> ilo_ccb_setup	       (hw->open_lock is still hold)

So I think that GFP_ATOMIC is needed here, or the code should be 
reworked to avoid holding the spin_lock when ilo_ccb_setup is called.

CJ
