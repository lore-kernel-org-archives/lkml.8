Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2880FC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F046E2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQfyW/TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgAJMMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:12:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32986 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgAJMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:12:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so4274005wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 04:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PbLS8+CBS7HYER+f3f/RHxsRY9Q8q0B8TRW1+q98Z4A=;
        b=dQfyW/TB0LdtH31ZM/dsMU6OGeB9k8z8Upm5IgOBDNeDz+y8xV6T6aYpdGkgoIW3S5
         XCukLIzmrVXKDtYTZQhf1qYINfhSfklO6vcJUVBt19OMfRdfmDNMeJVdeqZZxDXJP/LA
         R6T3m2yEBU4dzHnNC4R+6dSXWGl2ZVJb8WhEq77eV1+KcIfgCHa5USib4fQiRAS1Gr24
         kkds2xe5tA+oZZwTde5hJ+JlXo3gFkXlgwP2bfMsiSrLoiIbKZkBvXIEfME7NDYRqp5/
         EIBirhm9EGHEjxTbVpHSGxO0elM8HnIOtJNc0BvSG5lxqRcne+lztEmRejNNCJCHBN44
         8K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PbLS8+CBS7HYER+f3f/RHxsRY9Q8q0B8TRW1+q98Z4A=;
        b=LZ19vTg0k9X1JFDKcHow5POYms3C7HWNERe0drNqvyHos++/NpFeS9PvuKoSkEqsyo
         Jm13cjV9J3opeIZVzpJvLxitNYKyX28lGWB5JaogXmo2z93xdy7zg8GChVka7SJEkYrI
         Qf9Goibv/chWA7LhwIFzso9eKo+BcQkwmf6BEgY5Lo6Cob3GOddRCZnxYRHdlsfCFwQ3
         OoKu9z72jLo53iHKKJ6teeeMu3QpKnkwAvSjWhoxowYLmiy9l2NZg3tOfylfEXtxShDD
         8ED5uEPWOLJUqhXqhWwiPaKBoX/3wtQGEr/xN+cpUXH9WSEqO6x14DvBBk6G5UGzsEh9
         w9wA==
X-Gm-Message-State: APjAAAV0dOzq2sJEkNpEnjaSCgrlIIFU+B5Hed1YQNiTjnFTblcSHZnx
        tUhO+VvZBS2DSJjtmbe0wMSS6QFtBqc=
X-Google-Smtp-Source: APXvYqzIASqp7May83PDLm1BQr+QIyfmrPfepqhskPM02Q4ODS5KUUSOL1TYCNsq/yO/UopKoKkKhA==
X-Received: by 2002:a1c:486:: with SMTP id 128mr4066673wme.163.1578658353503;
        Fri, 10 Jan 2020 04:12:33 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q11sm2032269wrp.24.2020.01.10.04.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 04:12:32 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v5 2/2] soundwire: qcom: add support for
 SoundWire controller
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
 <20191219092842.10885-3-srinivas.kandagatla@linaro.org>
 <c791e241-cd71-4c05-dac5-04e3ecaaf995@linux.intel.com>
 <a5315861-d9b8-0852-8a3a-012f60cc3a44@linaro.org>
Message-ID: <4dab7ee8-dc0e-bf61-24db-3e227c459575@linaro.org>
Date:   Fri, 10 Jan 2020 12:12:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a5315861-d9b8-0852-8a3a-012f60cc3a44@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2019 17:14, Srinivas Kandagatla wrote:
>>> +
>>> +    if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>>> +        ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>>> +        dev_err_ratelimited(ctrl->dev,
>>> +                    "CMD error, fifo status 0x%x\n",
>>> +                     value);
>>> +        ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>>> +    }
>>> +
>>> +    if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>>> +        sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
>>> +        schedule_work(&ctrl->slave_work);
>>> +
>>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
>>
>> is it intentional to clear the interrupts first, before doing 
>> additional checks?
>>
> 
> No, I can move it to right to the end!

Reason why I did this was that if we run complete() before irq is 
cleared complete might trigger another read/write which can raise an 
interrupt. And with interrupt status not cleared we might miss it. This 
is very much timing dependent specially with the threaded irq.

So code needs no change atm!

> 
>> Or could it be done immediately after reading the status. It's not 
>> clear to me if the position of this clear matters, and if yes you 
>> should probably add a comment?
> 
> Am not 100% if it matters, but Ideally I would like clear the interrupt 
> source before clearing the interrupt.
> 
> 
>>
>>> +
>>> +    if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
>>> +        spin_lock_irqsave(&ctrl->comp_lock, flags);
>>> +        if (ctrl->comp)
>>> +            complete(ctrl->comp);
>>> +        spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>>> +    }
>>> +
>>> +    return IRQ_HANDLED;
>> The rest looks fine. nice work. 

Thanks,
srini
