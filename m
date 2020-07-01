Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AC9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BB5206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2zrGl7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGAFvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGAFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:51:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5BBC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:51:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so213806wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrsdbtnDHSEEqCjThvhWQtIqv3m+7T/9br2G4plX4Zc=;
        b=K2zrGl7nEOpmf6z8uDnoMX7D2tfbTThdtS0HdVEwj0ErGb9XJaqYNlHJWq+GY4HvE7
         Kc2N9afgknGJRm+0xgb0ehJDk8TfjM5A4siUjUUHDY9iR+f1qMzGDovHrV1zb0nuzzZD
         RPPdSNYnPQjjGkE4BH2TP6+xFPioW8MSrXKYFPHjjObcSgQziy2jRmGMTgEmsBqiBd9a
         GZu1J0UmhtXShKz+uUxZVag9OsUw7xlwGNtoabQHXitZOK3f4o1JfWgMFqbijdJHjxNe
         WqF/KP6C7wVH7RYdLSLIK20LD50TA7lQO8EipwM8YM7DPs7/yudJfLGCfxd7Gkz4iJgB
         Qn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrsdbtnDHSEEqCjThvhWQtIqv3m+7T/9br2G4plX4Zc=;
        b=ieMdOkykRk8qRjsfGfH1iZt+4I5hhrII0N1/eflkDwBfQtr5IgcUBhv/36/LZpK78Z
         ec+x2lgV2JC+QUEikG3icySBfmaNaQN0FYxoTaCccANF6UKq418UWM8AA54q0ICst7Ww
         y9FangwLqn7VaPTwg/cRkNx8A/STF/nCf0MLO81qckS8NkA/NP+8WNMMvRRH1Iipm0Mg
         O/+6nFF6ueNwkdVmSBhNZ3XzenoEFRYFHytIxKoCI0g1nXoZu4WznlvEnYpcO9d5A/bu
         CmmzV3Er+b9zqfJDSIlaBaT/bIo/PHpWBUePDJT1PEUY1xXjoWyGaeLVxZmqCPXP2Fzz
         UMLA==
X-Gm-Message-State: AOAM532/RIWqmxRI8tRzDAb6/8qljIYO2uXoxdXFquJoX2UqfWeobwI5
        eQRXStOmhb/DmsvxfCfcRysdhg==
X-Google-Smtp-Source: ABdhPJwasB45K4yCXyxCNULMvHcQErc/DDp+uYqd1S+ZRpmt8sqpf2/4dPZq5GLCDaa0s2mUqlTisA==
X-Received: by 2002:a5d:6786:: with SMTP id v6mr24674578wru.258.1593582658773;
        Tue, 30 Jun 2020 22:50:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id f12sm5949218wrw.53.2020.06.30.22.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 22:50:58 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: change enter_s2idle() prototype
To:     Neal Liu <neal.liu@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <1593421540-7397-1-git-send-email-neal.liu@mediatek.com>
 <1593421540-7397-2-git-send-email-neal.liu@mediatek.com>
 <9963896.lEaLCsxmBZ@kreacher> <1593571181.7383.5.camel@mtkswgap22>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a65bb456-d5f4-2208-f924-0af989b8dd5f@linaro.org>
Date:   Wed, 1 Jul 2020 07:50:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593571181.7383.5.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 04:39, Neal Liu wrote:
> On Mon, 2020-06-29 at 17:17 +0200, Rafael J. Wysocki wrote:
>> On Monday, June 29, 2020 11:05:40 AM CEST Neal Liu wrote:
>>> Control Flow Integrity(CFI) is a security mechanism that disallows
>>> changes to the original control flow graph of a compiled binary,
>>> making it significantly harder to perform such attacks.
>>>
>>> init_state_node() assigns same function pointer to idle_state->enter
>>> and idle_state->enter_s2idle. This definitely causes CFI failure
>>> when calling either enter() or enter_s2idle().
>>>
>>> Align enter_s2idle() with enter() function prototype to fix CFI
>>> failure.
>>
>> That needs to be documented somewhere close to the definition of the
>> callbacks in question.
>>
>> Otherwise it is completely unclear why this is a good idea.
>>
> 
> The problem is, init_state_mode() assign same function callback to
> different function pointer declarations.
> 
> static int init_state_node(struct cpuidle_state *idle_state,
>                            const struct of_device_id *matches,
>                            struct device_node *state_node)
> {
> ...
>         idle_state->enter = match_id->data;
> ...
>         idle_state->enter_s2idle = match_id->data;
> }
> 
> Function declarations:
> 
> struct cpuidle_state {
> ...
>         int (*enter)    (struct cpuidle_device *dev,
>                         struct cpuidle_driver *drv,
>                         int index);
> 
>         void (*enter_s2idle) (struct cpuidle_device *dev,
>                               struct cpuidle_driver *drv,
>                               int index);
> };
> 
> In this case, either enter() or enter_s2idle() would cause CFI check
> failed since they use same callee.
> 
> We try to align function prototype of enter() since it needs return
> value for some use cases. The return value of enter_s2idle() is no need
> currently.

Thanks for the clarification, you may add this description along with
the changelog.


>>> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
>>> ---
>>>  drivers/acpi/processor_idle.c   |    6 ++++--
>>>  drivers/cpuidle/cpuidle-tegra.c |    8 +++++---
>>>  drivers/idle/intel_idle.c       |    6 ++++--
>>>  include/linux/cpuidle.h         |    6 +++---
>>>  4 files changed, 16 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>> index 75534c5..6ffb6c9 100644
>>> --- a/drivers/acpi/processor_idle.c
>>> +++ b/drivers/acpi/processor_idle.c
>>> @@ -655,8 +655,8 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
>>>  	return index;
>>>  }
>>>  
>>> -static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>>> -				   struct cpuidle_driver *drv, int index)
>>> +static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>>> +				  struct cpuidle_driver *drv, int index)
>>>  {
>>>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>>>  
>>> @@ -674,6 +674,8 @@ static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>>>  		}
>>>  	}
>>>  	acpi_idle_do_entry(cx);
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>>> index 1500458..a12fb14 100644
>>> --- a/drivers/cpuidle/cpuidle-tegra.c
>>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>>> @@ -253,11 +253,13 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>>  	return err ? -1 : index;
>>>  }
>>>  
>>> -static void tegra114_enter_s2idle(struct cpuidle_device *dev,
>>> -				  struct cpuidle_driver *drv,
>>> -				  int index)
>>> +static int tegra114_enter_s2idle(struct cpuidle_device *dev,
>>> +				 struct cpuidle_driver *drv,
>>> +				 int index)
>>>  {
>>>  	tegra_cpuidle_enter(dev, drv, index);
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  /*
>>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>>> index f449584..b178da3 100644
>>> --- a/drivers/idle/intel_idle.c
>>> +++ b/drivers/idle/intel_idle.c
>>> @@ -175,13 +175,15 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>>>   * Invoked as a suspend-to-idle callback routine with frozen user space, frozen
>>>   * scheduler tick and suspended scheduler clock on the target CPU.
>>>   */
>>> -static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
>>> -					struct cpuidle_driver *drv, int index)
>>> +static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>>> +				       struct cpuidle_driver *drv, int index)
>>>  {
>>>  	unsigned long eax = flg2MWAIT(drv->states[index].flags);
>>>  	unsigned long ecx = 1; /* break on interrupt flag */
>>>  
>>>  	mwait_idle_with_hints(eax, ecx);
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  /*
>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>> index ec2ef63..bee10c0 100644
>>> --- a/include/linux/cpuidle.h
>>> +++ b/include/linux/cpuidle.h
>>> @@ -66,9 +66,9 @@ struct cpuidle_state {
>>>  	 * suspended, so it must not re-enable interrupts at any point (even
>>>  	 * temporarily) or attempt to change states of clock event devices.
>>>  	 */
>>> -	void (*enter_s2idle) (struct cpuidle_device *dev,
>>> -			      struct cpuidle_driver *drv,
>>> -			      int index);
>>> +	int (*enter_s2idle)(struct cpuidle_device *dev,
>>> +			    struct cpuidle_driver *drv,
>>> +			    int index);
>>>  };
>>>  
>>>  /* Idle State Flags */
>>> -- 
>>> 1.7.9.5
>>>
>>
>>
>>
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
