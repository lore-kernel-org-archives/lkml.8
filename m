Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA7FC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFD620702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY3pxJvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBEOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:33:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42737 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBEOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:33:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so2065322otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2Q+FJJ7ymzq1vpGgV7nlcxJJEeDcXgTcSuun2ahR3E=;
        b=dY3pxJvID6PLcV83rCPo28gm7GHN2YwlG9xrPqmyMSuFgvc3NLlLykZMCsM8jGbpLJ
         2nUSXqHjCfPticf1Ouuch3siGfCW9d2R1hftHLXQrirh8PW4V1MAGhy+XiV3orr5hy5e
         STSNinpP5wR3wE3otHFW1enNLMrXOv3jGHFReBD0xq0zRXMw3m6UO8BqgirsvOy8ajfn
         JzmhY11rg74Z8Fq/PChhoYF/W5WJyfumAyudYtHKtKr0dsBpXueicdoaQlSboii4z7Lv
         xqJOrooZqbc8kMTVwR8YMKdba8dvf/GialehxZAajunNc1cyG1Nab6FKV0VHy+dZ+MV8
         XM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2Q+FJJ7ymzq1vpGgV7nlcxJJEeDcXgTcSuun2ahR3E=;
        b=cNDD2CpWXoBbXpjV+HA3FpC5jhSQEf9jJQiF4yEcamgHZS3nQkig07W73YxxOKovjN
         K6vx280C16qLIvxhYRDCeZNxGAkHQlsCBrg6WGuKpF9ZmHO6CeNzD7G92d3fpdtfP4m1
         y6CbVTBMyZ3xBBsq5JgiG5fpnCy6vXlf07iwWgDJJFQUEAMtjbZrClY+lN56UNNPTET4
         Q+W2iCxKvSAbszcJBZbLu+w8Nl7tpM7P/YSrgnambvc4boFxNFm/OsO1N6f1YeHHV5FN
         S2nf7U78YB8zilvuqgLed5j5YSE4pu/+N7ZU7E0ibpYPMry/lTqtRhQIK1L6rAoxHUFT
         JLjA==
X-Gm-Message-State: APjAAAUpXDcfLHlj8LIjz9z441f2wv4ojaC8Z66q2za69lNhs5iBksPr
        qBh5ZhvBHG5X4O+LfgTPIQ==
X-Google-Smtp-Source: APXvYqzxVnLjQYctWfjtUnn4bSqM/ku6JsnRwW3/SfU1UZn46nnAsfDbo0KLkuaDg+9BpOjdzSqFag==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr26380657otp.339.1580913223228;
        Wed, 05 Feb 2020 06:33:43 -0800 (PST)
Received: from [172.31.9.147] (ausvpn.amd.com. [165.204.77.11])
        by smtp.gmail.com with ESMTPSA id j45sm8895622ota.59.2020.02.05.06.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:33:42 -0800 (PST)
Subject: Re: [PATCH] powerpc/drmem: cache LMBs in xarray to accelerate lookup
To:     Scott Cheloha <cheloha@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200128221113.17158-1-cheloha@linux.ibm.com>
 <87pnf3i188.fsf@linux.ibm.com>
 <20200129181013.lz6q5lpntnhwclqi@rascal.austin.ibm.com>
 <4dfb2f93-7af8-8c5f-854c-22afead18a8c@gmail.com>
 <20200203201346.deqkxwgfmkifeb5s@rascal.austin.ibm.com>
From:   "Fontenot, Nathan" <ndfont@gmail.com>
Message-ID: <081c4f0e-5d7a-93c1-2075-608790f8e35f@gmail.com>
Date:   Wed, 5 Feb 2020 08:33:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203201346.deqkxwgfmkifeb5s@rascal.austin.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2020 2:13 PM, Scott Cheloha wrote:
> On Thu, Jan 30, 2020 at 10:09:32AM -0600, Fontenot, Nathan wrote:
>> On 1/29/2020 12:10 PM, Scott Cheloha wrote:
>>> On Tue, Jan 28, 2020 at 05:56:55PM -0600, Nathan Lynch wrote:
>>>> Scott Cheloha <cheloha@linux.ibm.com> writes:
>>>>> LMB lookup is currently an O(n) linear search.  This scales poorly when
>>>>> there are many LMBs.
>>>>>
>>>>> If we cache each LMB by both its base address and its DRC index
>>>>> in an xarray we can cut lookups to O(log n), greatly accelerating
>>>>> drmem initialization and memory hotplug.
>>>>>
>>>>> This patch introduces two xarrays of of LMBs and fills them during
>>>>> drmem initialization.  The patch also adds two interfaces for LMB
>>>>> lookup.
>>>>
>>>> Good but can you replace the array of LMBs altogether
>>>> (drmem_info->lmbs)? xarray allows iteration over the members if needed.
>>>
>>> I don't think we can without potentially changing the current behavior.
>>>
>>> The current behavior in dlpar_memory_{add,remove}_by_ic() is to advance
>>> linearly through the array from the LMB with the matching DRC index.
>>>
>>> Iteration through the xarray via xa_for_each_start() will return LMBs
>>> indexed with monotonically increasing DRC indices.> 
>>> Are they equivalent?  Or can we have an LMB with a smaller DRC index
>>> appear at a greater offset in the array?
>>>
>>> If the following condition is possible:
>>>
>>> 	drmem_info->lmbs[i].drc_index > drmem_info->lmbs[j].drc_index
>>>
>>> where i < j, then we have a possible behavior change because
>>> xa_for_each_start() may not return a contiguous array slice.  It might
>>> "leap backwards" in the array.  Or it might skip over a chunk of LMBs.
>>>
>>
>> The LMB array should have each LMB in monotonically increasing DRC Index
>> value. Note that this is set up based on the DT property but I don't recall
>> ever seeing the DT specify LMBs out of order or not being contiguous.
> 
> Is that ordering guaranteed by the PAPR or some other spec or is that
> just a convention?

From what I remember the PAPR does not specify that DRC indexes are guaranteed
to be contiguous. In past discussions with pHyp developers I had been told that
they always generate contiguous DRC index values but without a specification in
the PAPR that could always break.

-Nathan

> 
> Code like drmem_update_dt_v1() makes me very nervous:
> 
> static int drmem_update_dt_v1(struct device_node *memory,
>                               struct property *prop)
> {
>         struct property *new_prop;
>         struct of_drconf_cell_v1 *dr_cell;
>         struct drmem_lmb *lmb;
>         u32 *p;
> 
>         new_prop = clone_property(prop, prop->length);
>         if (!new_prop)
>                 return -1;
> 
>         p = new_prop->value;
>         *p++ = cpu_to_be32(drmem_info->n_lmbs);
> 
>         dr_cell = (struct of_drconf_cell_v1 *)p;
> 
>         for_each_drmem_lmb(lmb) {
>                 dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
>                 dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
>                 dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
>                 dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
> 
>                 dr_cell++;
>         }
> 
>         of_update_property(memory, new_prop);
>         return 0;
> }
> 
> If for whatever reason the firmware has a DRC that isn't monotonically
> increasing and we update a firmware property at the wrong offset I have
> no idea what would happen.
> 
> With the array we preserve the order.  Without it we might violate
> some assumption the firmware has made.
> 
