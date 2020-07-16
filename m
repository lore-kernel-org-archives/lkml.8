Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4623C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43EB207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX64z7hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgGPT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgGPT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:57:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E7C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:57:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so8279965wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zuF/J6NOQwoT2dhyBS6YW5G5d9wUv+9M5v/x/XTOdw4=;
        b=GX64z7hYBmXlpkJjT3bZX564s4JLbS4ad23wHk5Kz8hnG4/QBrpPG0ZvaURXO7Z7Dx
         oXRcze0fyVwJ91qcV8vmyLVawhr4uzC2Ds+MBn/GaVbx95NqSp5DudZvgAsoEktfh+PJ
         5l3sIGdNy77du9U8f2N7YnbMa3AM+o2Dj+OE6YE9h/F2pPqPhQ7WjIrkO+chrKhJNpkl
         VssxVgmDDJkP4l/YXHfiYuftY5aHQRQxN0toEu25Ps6ZLMOqe5he07AQFbcvE9yuyQiV
         SZoZ4rcHBxrtRvGF4LDJXEFce6k0fhZRdbWmS+tHQGh1qde6DNvEfTh1rhlVZ4/bnkUD
         iyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zuF/J6NOQwoT2dhyBS6YW5G5d9wUv+9M5v/x/XTOdw4=;
        b=ObqzPdjJL5yKTE4ndx/C0ppbszP4sEdfRO6oPVX72Npyog+kaoLv1Gprmn2vQOCRFO
         WAL//ucBUqflwiZMGbqH1AECBXfPf8yVzTTB2A1SIxo+9PA8N0ISUTOqqqzuZmta3Os1
         zU3LDnCuu4yJ9zSbADOEEgX53QRpEuxJK2+X/kbt/qZxfp+eJM4LAvx/sbMcrUkaSDhY
         TY/RRXsACPJDxLAi2/Ab5gxZO0KsEs0oSV9RxfrskX9FLPlH2XPD4kTp7qh+Jti+kdrx
         fL2G3ztweqXYYBdGhj/FPBUyq2iqMWecd+6pC8C7nauOFxOE2k4NA2ZSOyVPcjZrwa5t
         kGQg==
X-Gm-Message-State: AOAM531synLE+BJO2CHsIMOGrTSEFVHl2Z9vrnc2zAFUDEP6+q6YvCJY
        X3mCGX45e4lGyeNbrOASWDQ=
X-Google-Smtp-Source: ABdhPJwVAt5Ue/jrkon3LxRymKFQhKB5VXiMM/Zkeouj1hAxZfGOi7i9cgqThfkPlgrgIGWkGld6+w==
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr6429841wrv.400.1594929447855;
        Thu, 16 Jul 2020 12:57:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l18sm10966895wrm.52.2020.07.16.12.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 12:57:27 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
 <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
 <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <faa53c11-3c72-9b9b-85ad-9d234f373b4d@gmail.com>
Date:   Thu, 16 Jul 2020 12:57:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2020 7:13 AM, Daniele Alessandrelli wrote:
> Hi Florian,
> 
> Thanks for you feedback.
> 
> On Wed, 2020-07-15 at 15:43 -0700, Florian Fainelli wrote:
>>
>> On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
>>> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
>>>
>>> Currently, when SMC/HVC is used as transport, the base address of
>>> the
>>> shared memory used for communication is not passed to the SMCCC
>>> call.
>>> This means that such an address must be hard-coded into the
>>> bootloader.
>>>
>>> In order to increase flexibility and allow the memory layout to be
>>> changed without modifying the bootloader, this patch adds the
>>> shared
>>> memory base address to the a1 argument of the SMCCC call.
>>>
>>> On the Secure Monitor side, the service call implementation can
>>> therefore read the a1 argument in order to know the location of the
>>> shared memory to use. This change is backward compatible to
>>> existing
>>> service call implementations as long as they don't check for a1 to
>>> be
>>> zero.
>>
>> resource_size_t being defined after phys_addr_t, its size is
>> different
>> between 32-bit, 32-bit with PAE and 64-bit so it would probably make
>> more sense to define an physical address alignment, or maybe an
>> address
>> that is in multiple of 4KBytes so you can address up to 36-bits of
>> physical address even on a 32-bit only system?
> 
> I see your point. After a quick look, I think that, practically, the
> issue is with ARM32 LPAE addresses, for which phys_addr_t is a u64. So,
> basically, for AArch32 systems with LPAE the 64-bit shmem_paddr gets
> truncated to 32-bit when it's passed to the SMC32/HVC32 call.
> 
> To solve that, I would prefer splitting the address between two SMC
> parameters (a1 = addr_lo, a2 = addr_hi), instead of imposing an
> arbitrary alignment. Would that be reasonable?

The low/high part would only be relevant on a 32-bit LPAE platform which
is probably a corner case, I would just pass the shmem_paddr / 4096
since that is the smallest granule size and alignment possible and it
still allows you to map up to 36-bits of physical address, which is the
maximum that the long descriptor in LPAE can support. For 64-bit we have
no such problems since we have the full register width.

> 
>>
>> What discovery mechanism does the OS have that the specified address
>> within the SMCCC call has been accepted by the firmware given the
>> return
>> value of that SMCCC call does not appear to be used or checked? Do we
>> just expect a timeout initializing the SCMI subsystem?
> 
> The return code is actually checked at the end of the function:
> https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/firmware/arm_scmi/smc.c#L118
> 
> But in the meantime scmi_rx_callback() has already been called. Not
> sure if that's intentional or a possible bug.
> 
>>
>> Given that the kernel must somehow reserve this memory as a shared
>> memory area for obvious reasons, and the trusted firmware must also
>> ensure it treats this memory region with specific permissions in its
>> translation regime, does it really make sense to give that much
>> flexibility?
> 
> Well, the trusted firmware might reserve a bigger region to be used for
> other service as well. In other words, the MMU of TF-A is not necessary
> specifically set up for this region, but, possibly, for a bigger
> general shared region.

But presumably the Linux shared memory area should be mapped in a
slightly different way than

> 
> Passing the SCMI shmem to the SMC call allows the shmem to be moved
> within such bigger shared memory without modifying the trusted
> firmware.
> 
>>
>> If your boot loader has FDT patching capability, maybe it can also do
>> a
>> SMC call to provide the address to your trusted firmware, prior to
>> loading the Linux kernel, and then they both agree, prior to boot
>> about
>> the shared memory address?
> 
> Yes, that's a possible solution, but it looks more complicated to me,
> since it adds an additional component (the boot loader) to the
> equation, while the goal of this patch was to reduce the coupling
> between components (namely the DT/kernel and the trusted firmware).
> 
> I guess my question is: if we fix the handling of LPAE addresses and
> the SMC return code, what is the drawback of having the shmem address
> passed to the SMC?

My only concern is that if somehow Linux gets assigned a shared memory
range that is completely outside of what the trusted firmware has
already mapped, or is capable of addressing, or any combination thereof,
it could be challenging to debug what is going on, especially if INVALID
PARAMETER must not be returned (assuming this is to avoid Linux
discovering where other shared memory areas pertaining to the firmware
reside?).

The other concern I have is that we are not documenting the various
SMCCC calling conventions, soon enough it will be come out of control,
and we are already allowing people to define their own function IDs and
parameters to call into the trusted firmware. This sounds like something
that is so basic that it should be standardized from the top, by ARM.

> 
> Anyway, I should have mentioned this in the commit message (sorry for
> not doing so), but I submitted this patch because initial feedback from
> Sudeep was positive [1]; but if there is no consensus around it I'm
> fine with dropping it.
> 
> [1] https://lore.kernel.org/lkml/20200710075931.GB1189@bogus/

My review is by no means authoritative however in deploying SCMI on our
Broadcom STB platforms some experience was gained in the process which
is how it piqued my interest. Thanks for providing more background to
this patch, this does help.

We have opted for a solution where the boot loader knows about all
possible reserved regions prior to booting/loading the trusted firmware
as well as the kernel, therefore it can pass that information to both
and we never really had a situation where the two need to evolve in an
uncoordinated way.
-- 
Florian
