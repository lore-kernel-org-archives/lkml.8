Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF0C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 04:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDCA2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 04:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="sJlfa0FJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgICE0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 00:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICE0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 00:26:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 21:26:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id np15so3118914pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNNQnTB2bzzVVpKwB6qXlFTaOV9Itbw7rVnGe9BKXq4=;
        b=sJlfa0FJy0iGf9Yz8+LLYpkmIRerR+3vw9ref3rCuEZFVw3shlzY5WxXBPCJLQClXC
         EXzOD4lRvMwyHMtYa2H+FZXE+YhQkpHoSQTiXybdDd2NGAELqWlw3ErulpozjdyzT3nG
         AeP43JnaytbUXYFNBYmKxXWrfW6OAID8E7SKHR0hHUQ5rOiLdPGUVrZKlgAXaPBIgUrh
         qhlxtTxgU+dM7jzIKD+tPNpxTwPJrMx3+9SkjGhmF08CUqm6SPcqJUQkWBZpk+1NHZo7
         C6ZR81iQGjiZbvKYU0hxY2fblbEpYtOcZ70lVMPuyjdMgv/jI08pZvA15Ih+cV97ahXw
         LG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNNQnTB2bzzVVpKwB6qXlFTaOV9Itbw7rVnGe9BKXq4=;
        b=KAQVr3bFSihIfjQshm0rCb57AwWv33pYlPfFKPyXp8wv2DBXdMaEFPZ19/NQXKjabA
         /IQom0/TFKuLOr3qbQ3FcsV+lEGYC7pDKlQOtZh4etJ88AVL+RoPfX3miiNT/QypKoSN
         HisKj+Qnmh5S9hrpR9Vu7RWkNcrKL6uStDVd9yZ663Z7pNAg/c2dLRFFcPsVKu5jIbpU
         T4aZ39+Qg5YsXg15+Ze7pcFf9CEtS4X+DrI1BusWFq/KN0nRIM4yKIb+fTnahUDOPIhP
         uTjHbtPJ6YzLhx+++FYJOg9djuYzF2XeIGkARBIUp9QjyLf/+BEXD9aoJkQMx2OJ7Ekv
         iofQ==
X-Gm-Message-State: AOAM5315bwk1JlmHeuSTBYfGZmOR71sLNHSFIy38JtDaotVASHUpGRjg
        E09nR9HGlg2ELviA+F7uN7GMHzud5AVWaKnc
X-Google-Smtp-Source: ABdhPJxtRfGq45PYlHxfkRMSCAIlYNz5dGbpz6AjsI1wmDKHjr2nziGD1zj2YOi01BPhog6rNUF/ug==
X-Received: by 2002:a17:90a:de09:: with SMTP id m9mr1249438pjv.231.1599107180628;
        Wed, 02 Sep 2020 21:26:20 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id n67sm888007pgn.14.2020.09.02.21.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 21:26:19 -0700 (PDT)
Subject: Re: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page
 shift
To:     Leonardo Bras <leobras.c@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200817234033.442511-1-leobras.c@gmail.com>
 <20200817234033.442511-2-leobras.c@gmail.com>
 <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
 <31e913d842693b6e107cb2b8e51fd45118b1bd2c.camel@gmail.com>
 <1e77a3d9-dff9-f58b-45be-77be7cbea41a@ozlabs.ru>
 <93037398c7afaabc0411890998f3f29f741c8aff.camel@gmail.com>
 <aaaf993a-d233-f5be-b809-5911a6a9872d@ozlabs.ru>
 <CAOSf1CG49ztvNoG43hcSHyLB9UY6Nc8maY_q6nvQmiyFQOAp3A@mail.gmail.com>
 <1bba12c6-f1ec-9f1e-1d3e-c1efa5ceb7c7@ozlabs.ru>
 <c381d7e60d0924e432b0f36dce9a44b89733a129.camel@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ffed8bef-443c-3794-2ba3-720c073d91f5@ozlabs.ru>
Date:   Thu, 3 Sep 2020 14:26:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c381d7e60d0924e432b0f36dce9a44b89733a129.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2020 07:38, Leonardo Bras wrote:
> On Mon, 2020-08-31 at 13:48 +1000, Alexey Kardashevskiy wrote:
>>>>> Well, I created this TCE_RPN_BITS = 52 because the previous mask was a
>>>>> hardcoded 40-bit mask (0xfffffffffful), for hard-coded 12-bit (4k)
>>>>> pagesize, and on PAPR+/LoPAR also defines TCE as having bits 0-51
>>>>> described as RPN, as described before.
>>>>>
>>>>> IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figure 3.4 and 3.5.
>>>>> shows system memory mapping into a TCE, and the TCE also has bits 0-51
>>>>> for the RPN (52 bits). "Table 3.6. TCE Definition" also shows it.
>>>>> In fact, by the looks of those figures, the RPN_MASK should always be a
>>>>> 52-bit mask, and RPN = (page >> tceshift) & RPN_MASK.
>>>>
>>>> I suspect the mask is there in the first place for extra protection
>>>> against too big addresses going to the TCE table (or/and for virtial vs
>>>> physical addresses). Using 52bit mask makes no sense for anything, you
>>>> could just drop the mask and let c compiler deal with 64bit "uint" as it
>>>> is basically a 4K page address anywhere in the 64bit space. Thanks,
>>>
>>> Assuming 4K pages you need 52 RPN bits to cover the whole 64bit
>>> physical address space. The IODA3 spec does explicitly say the upper
>>> bits are optional and the implementation only needs to support enough
>>> to cover up to the physical address limit, which is 56bits of P9 /
>>> PHB4. If you want to validate that the address will fit inside of
>>> MAX_PHYSMEM_BITS then fine, but I think that should be done as a
>>> WARN_ON or similar rather than just silently masking off the bits.
>>
>> We can do this and probably should anyway but I am also pretty sure we
>> can just ditch the mask and have the hypervisor return an error which
>> will show up in dmesg.
> 
> Ok then, ditching the mask.


Well, you could run a little experiment and set some bits above that old 
mask and see how phyp reacts :)


> Thanks!
> 

-- 
Alexey
