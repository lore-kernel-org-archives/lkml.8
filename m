Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217DDC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7CC2192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USusKr2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgCKLbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:31:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCKLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:31:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so1685965wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+qi8Gsy+phH8WfKkqtpOwo0DUN440dJfBPdiDNKzZv0=;
        b=USusKr2+/LjqIljnqjUN7DohKHee85EjKx+StCQUGw7AqB1NylzxED+zXCPiFtcmu+
         QsaYzsXP6As1w78W81uzKwVSIfx+BiJuxH0nmYRflHGoR4iim5IFwealghWlYXNSFPWC
         AlUpFUsNRYrFg3g5899YGHoxrGl2xBzDZ9LqxfvmYhn3ai5PjbkCtqh9wzRCC6wjGbh0
         ACBnkce2FcS6nb8vwgmUxGun68fmRwpBjQjeCBhqwSh0u5MkSAY9t34GLsIMJBLJsB0P
         dq6GZpIRj/eSTPacBH+l4Co6EFwpgYAx9uVWbYn2DhgVmC4Lx2xmvZWDY2ZD3Hsb8g3Z
         /B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+qi8Gsy+phH8WfKkqtpOwo0DUN440dJfBPdiDNKzZv0=;
        b=fJKeeg2HRJyn6wc0Pu/4A9itimQZm/EuKFETPdtJx97nxgiw5viOqpeb2lFFNsWPwJ
         SPHUGs/ZlED4K4vJwPYtyM6Qfz7DxuHZNG48t6Yn/WGsx+cj97KGjcwFz+ZOz4WrKjoU
         lc2OcPCS2WDB8fX9lVRyq3EjGJ2syg+GS/azA3z7VKvXfEKASD4xKslKJE9s8DJTi7v+
         dxFU+UdzD0stbtjybSVVwNgvjwb6a2MPKLLpA/2dwJmFwwLhAvqtvc+odjZvsMHlLzzU
         GuQ0NzWcXfAju9ZRx1JDbf0wKl45tdiScgmxMOcI0w1FQVpWKQzdP5K1I0q/2ybsihHR
         nCYg==
X-Gm-Message-State: ANhLgQ20VSCbjDLcfrL54xL9fka5ufdgHA1KIzCaTjpXtFXnhWIRh8G2
        DGALCb/NPrLXptR89n8s4IH0ky46irI=
X-Google-Smtp-Source: ADFU+vu8yQwphkn83vEuD1GGYen9Zs60Do+28oOVyU/sJjeCMep301H0NxJVRU99RGuiKzeLl72aJQ==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr3399437wmf.100.1583926260082;
        Wed, 11 Mar 2020 04:31:00 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f2sm10373193wrv.48.2020.03.11.04.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 04:30:59 -0700 (PDT)
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
 <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
 <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
 <a2b24f84-0f9a-29ab-8748-dc5a26c05ffa@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dec47c3a-08e9-e9a0-707c-2610cb10fe64@linaro.org>
Date:   Wed, 11 Mar 2020 11:30:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a2b24f84-0f9a-29ab-8748-dc5a26c05ffa@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the inputs

On 10/03/2020 15:53, Pierre-Louis Bossart wrote:
> Hi Srinivas,
> 
>>>  > My recommendation would be to add a DisCo property stating the
>>> WordLength value can be used by the bus code but not written to the 
>>> Slave device registers.
>>
>> Does something like "mipi-sdw-read-only-wordlength" as slave property, 
>> make sense?
> 
> The properties can be handled at two levels.
> 
> First, you'd want to change include/linux/soundwire/sdw.h, and add a new 
> field in
> 
> struct sdw_dpn_prop {
>      u32 num;
>      u32 max_word;
>      u32 min_word;
>      u32 num_words;
>      u32 *words;
> +       bool read_only_wordlength;
> 
> Once this is added, along with the code that bypasses the programming of 
> DPn_BlockCtrl1, the implementation has two choices:
> 
> a) hard-code the field value in the codec driver.

This totally works for me.

> 
> b) read the property from firmware with the DisCo helpers.
> 

I would defer adding this for now till there is a real users for this.

> There is no requirement that all properties be read from firmware, and 
> if you look at existing code base sdw_slave_read_prop() is currently 
> unused, each codec implements its own .read_prop() callback.
> 
> We really wanted to be pragmatic, and give the possibility to either 
> override bad firmware or extend incomplete firmware to avoid coupling OS 
> and firmware too much. If you foresee cases where this implementation 
> might vary and firmware distribution is not a problem, then a property 
> read would make sense.
> 
> Just once procedural reminder that all 'mipi-sdw' properties are handled 
> by the MIPI software WG, so we'd need to have this property added in a 
> formal MIPI document update.
> 
> I suggest you talk with Lior first on this.

Sure, I will talk to him.

> 
> Hope this helps
> -Pierre
