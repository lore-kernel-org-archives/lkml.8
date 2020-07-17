Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C796C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238C02076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/HdDOsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGQSBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQSBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:01:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3CC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:01:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so4292065pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VL238xlzE0uThNd8yw3z5huUTHioHBP8n+FhWhde0QQ=;
        b=R/HdDOsh3SNE89aT+fxmoojuDw1sCd0hX3T4xZhEzvX6qhKsQCOUWq2QqB4wzy6kbv
         ieX+loghMB4LL4K5thbiV0rXahs4FCPHz115AEXf9uL9pwDzZ8dCb8bGdh5S9L209vI6
         Vh3pEgtmyuy7VWsheZlEVt+U+izK7omWQyf2hR+mDoLzRLM+3OrouvVqj1lqeLQR3LPL
         76cHS5mpmyzwNdxqxKN3YBY5iR4ctzoH81J6Jhi6EIUZkX5XPgSYB3faLcodnZpkQtXd
         hZIpZ9uNmqOZprTml6CmvPZGsVyjrHt4NsWJ5Ukf/WZmyZ8tWbINOnfH/GWcTL+Eo0RW
         Bb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VL238xlzE0uThNd8yw3z5huUTHioHBP8n+FhWhde0QQ=;
        b=ArcVdbiZlCMQzv3iXiFtIaoFQT4iMr/ZxGw6NqjpBM/8RcbAocLzQMxIkvZoBFiaKx
         /V2vIxTZvQK21unS8M8x4jTol8xmLXHsuDztMKqbR4gIzxG7N6lse/pIwm1TV7M6Bd9x
         fQg0FDqSIvCQRaWHf/FaGJu6j0vRLSnfmJ0Aw5G948WEfNPo3cv6Ba66pfW/wg6jBWUU
         JiF9Ta5wBTbFE6NDme2XZzAATaRVxOrhIFL8E8e2ggaNKi56KXrFhruoP7KZY9zRFYiS
         TeYdjGxG3oPUFBr2mIR5e7eiy2dWE4gqs44xZVrTyevuyXMbJ59ApWttX3JyyRlHU0fN
         g+LA==
X-Gm-Message-State: AOAM530EVEBhgqb1aWTHlJHUFOpVGLqVheVnaeRXXGcoLBDWhBxOrOTt
        oV0RiFhxgJ0fZi5G1hH0fzgNXPE5
X-Google-Smtp-Source: ABdhPJwQBChusqU0m9hhRZGXsSSAwKKD+iMeLeYTuNQxzKk76Bvli6co32p1Y4fVKVHh1RsYOB7gzw==
X-Received: by 2002:a17:902:c206:: with SMTP id 6mr8986437pll.30.1595008878209;
        Fri, 17 Jul 2020 11:01:18 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d65sm8098061pfc.97.2020.07.17.11.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 11:01:17 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
 <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
 <20200717094555.GA24501@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dce7c86e-1b3f-f9f9-d872-de84a352346d@gmail.com>
Date:   Fri, 17 Jul 2020 11:01:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717094555.GA24501@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 2:45 AM, Sudeep Holla wrote:
> On Wed, Jul 15, 2020 at 03:43:24PM -0700, Florian Fainelli wrote:
>>
>>
>> On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
>>> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
>>>
>>> Currently, when SMC/HVC is used as transport, the base address of the
>>> shared memory used for communication is not passed to the SMCCC call.
>>> This means that such an address must be hard-coded into the bootloader.
>>>
>>> In order to increase flexibility and allow the memory layout to be
>>> changed without modifying the bootloader, this patch adds the shared
>>> memory base address to the a1 argument of the SMCCC call.
>>>
>>> On the Secure Monitor side, the service call implementation can
>>> therefore read the a1 argument in order to know the location of the
>>> shared memory to use. This change is backward compatible to existing
>>> service call implementations as long as they don't check for a1 to be
>>> zero.
>>
>> resource_size_t being defined after phys_addr_t, its size is different
>> between 32-bit, 32-bit with PAE and 64-bit so it would probably make
>> more sense to define an physical address alignment, or maybe an address
>> that is in multiple of 4KBytes so you can address up to 36-bits of
>> physical address even on a 32-bit only system?
>>
> 
> Good point, I had forgotten about LPAE. Thanks for pointing it out.
> 
>> What discovery mechanism does the OS have that the specified address
>> within the SMCCC call has been accepted by the firmware given the return
>> value of that SMCCC call does not appear to be used or checked? Do we
>> just expect a timeout initializing the SCMI subsystem?
>>
> 
> Agreed, we need to add the check for proper return value then and
> definitely document it very clearly as we are trying to standardise
> a call to vendor SiP FID space of SMCCC.
> 
>> Given that the kernel must somehow reserve this memory as a shared
>> memory area for obvious reasons, and the trusted firmware must also
>> ensure it treats this memory region with specific permissions in its
>> translation regime, does it really make sense to give that much flexibility?
>>
> 
> I expect so and this comes as shmem property from DT already. We are
> just passing the value obtained from there as is. This is just to help
> TFA or the firmware to identify the specific channel/shmem as SMC/HVC
> otherwise has no way to do so.

OK, that is fair enough.

> 
>> If your boot loader has FDT patching capability, maybe it can also do a
>> SMC call to provide the address to your trusted firmware, prior to
>> loading the Linux kernel, and then they both agree, prior to boot about
>> the shared memory address?
>>
> 
> Yes, but we definitely can't rely on such mechanism in the kernel. It is
> more a platform choice as they run different bootloaders.
> 

That argument can be be used the other way too if this is a platform
choice, the platform boot loader can ensure that both ends of the SMC
agree on the shared memory region. I do see an advantage to the approach
being suggested here that the shared memory does not necessarily need to
be mapped by the TF prior to Linux booting, but it can be deferred until
when Linux makes the first SMC call but that may require more complexity
on the TF side to issue an appropriate MMU update, so maybe from a
security perspective this is more dangerous..

Alright, I am convinced now this is useful :)
-- 
Florian
