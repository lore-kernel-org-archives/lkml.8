Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA6BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D456A2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="uZ801dGa";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="biSxwrFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgGMNsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:48:45 -0400
Received: from smtp71.iad3b.emailsrvr.com ([146.20.161.71]:35124 "EHLO
        smtp71.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgGMNso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594648123;
        bh=ZL3NTHkoX90gLzQnZ0aZs8xRP/+7qcKArta1NiGzOzo=;
        h=Subject:To:From:Date:From;
        b=uZ801dGaFUNVS/zXEtlEWyhPXGSRfDInrDXUbwXoX4cXqyKsAtDBrVIKyl3qImXUA
         /lDhXbEqIBk/Q2W8Ee4xkJXSXdf94iwJfSiwJZY2QwXLLY2cQDEvjJnGj+9r1gbyfI
         jeWBtUMrH1kZfdcB6I5AeF7dEFLwYOH8BuzqsUUI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594648123;
        bh=ZL3NTHkoX90gLzQnZ0aZs8xRP/+7qcKArta1NiGzOzo=;
        h=Subject:To:From:Date:From;
        b=biSxwrFSDhUFuZJkjC9mbxXzvogmAU14OkdrrkjOo/BqwnCaIHyRr49wdqjXUO+Ub
         5Cij1iWBKkpuD9mpA/x0Cay+SLTaiIe1pTrdVKCz/tvacCl2R66g5dgex1Bz05AjHW
         lWppyN8OlkKj46JYx+4MHk0cWWJdmmn+SpIKCtsw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9B295601EA;
        Mon, 13 Jul 2020 09:48:42 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: s626: Remove pci-dma-compat wrapper
 APIs.
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Suraj Upadhyay <usuraj35@gmail.com>,
        gregkh@linuxfoundation.org, hsweeten@visionengravers.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
References: <20200711123533.GA15038@blackclown>
 <6f701731-d0af-1bd5-5854-42f0ba39ed35@wanadoo.fr>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <3747ce02-feb3-359f-c60d-233e412c6062@mev.co.uk>
Date:   Mon, 13 Jul 2020 14:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6f701731-d0af-1bd5-5854-42f0ba39ed35@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: 0cf2f086-3d08-420b-90a6-83a28112867a-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2020 14:38, Christophe JAILLET wrote:
> Le 11/07/2020 à 14:35, Suraj Upadhyay a écrit :
>> The legacy API wrappers in include/linux/pci-dma-compat.h
>> should go away as it creates unnecessary midlayering
>> for include/linux/dma-mapping.h APIs, instead use dma-mapping.h
>> APIs directly.
>>
>> The patch has been generated with the coccinelle script below
>> and compile-tested.
>>
>> [...]
>> @@ expression E1, E2, E3; @@
>> - pci_alloc_consistent(E1, E2, E3)
>> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)
>>
>> @@ expression E1, E2, E3; @@
>> - pci_zalloc_consistent(E1, E2, E3)
>> + dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)
> 
> This is the tricky part of this kind of cleanup, see below.
> 
> GFP_ATOMIC can't be wrong because it is was exactly what was done with 
> the pci_ function.
> However, most of the time, it can safely be replaced by GFP_KERNEL which 
> gives more opportunities to the memory allocator.
> 
>> [...]
>> diff --git a/drivers/staging/comedi/drivers/s626.c 
>> b/drivers/staging/comedi/drivers/s626.c
>> index 084a8e7b9fc2..c159416662fd 100644
>> --- a/drivers/staging/comedi/drivers/s626.c
>> +++ b/drivers/staging/comedi/drivers/s626.c
>> @@ -2130,13 +2130,15 @@ static int s626_allocate_dma_buffers(struct 
>> comedi_device *dev)
>>       void *addr;
>>       dma_addr_t appdma;
>> -    addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
>> +    addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
>> +                  GFP_ATOMIC);
>>       if (!addr)
>>           return -ENOMEM;
>>       devpriv->ana_buf.logical_base = addr;
>>       devpriv->ana_buf.physical_base = appdma;
>> -    addr = pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
>> +    addr = dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
>> +                  GFP_ATOMIC);
>>       if (!addr)
>>           return -ENOMEM;
>>       devpriv->rps_buf.logical_base = addr;
> 's626_allocate_dma_buffers()' is only called from 's626_auto_attach()'.
> In this function, around the call to 's626_allocate_dma_buffers()', you 
> can see:
>    - a few lines before, a call to 'comedi_alloc_devpriv()'
> 
>    - a few lines after, a call to 'comedi_alloc_subdevices()'
> 
> These 2 functions make some memory allocation using GFP_KERNEL.
> 
> So it is likely that using GFP_KERNEL in your proposal is also valid.

Indeed, GFP_KERNEL is perfectly fine here.  It could be done as a 
follow-up patch, or done in a v2 of this patch with a mention in the 
patch description.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
