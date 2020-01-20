Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A6C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D755822527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD74kdf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:26:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33276 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:26:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so246237pgk.0;
        Mon, 20 Jan 2020 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FWdyCjkkRlET0CCL1DhvvWntKUj56/PIrVm9vvf0nMA=;
        b=mD74kdf9MhMy8IVtNoV/df/QhdAdSUTMqozu2qSBE39ZQsZo4ebgn51mkiX0XR2OKk
         DUh5PFMX8rPmQQbWbBPDlzNZf3HHwH3I0t3epKZchCkwjVOSRDH4DJCfDFKCCnCxU2H/
         xNwv0ntdiCeatKj+1I6+ikOEUI7UUSokjpg0rYrXHsuN2YiQ6T/lRxU02P3XWnvHMpuq
         0RB5HYJj4y7NJKWtTiBr1X6+DvK85DPs766rt6hIBx62WTXPuUCxcWZOzOSsuHiTWBtH
         khbTgqOKIBUlgnt7RCrX+dCJLmSKL4iVstZrt8sOiFaZR9tvW6XX6zxsxcHAcG6iy/MM
         uuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FWdyCjkkRlET0CCL1DhvvWntKUj56/PIrVm9vvf0nMA=;
        b=uk4nbqMSfwrj2Biy36GGnFuaSoOnPPrKfvn0R9a40goq03hR8eE5hfUfeG+Zxxglk6
         cMBtkR2AkQjE3iMiEfQgRmXVZ5c3xif950tnzH6uznUhiNsxHghz1Zzx6mFmnAOECL7t
         wD+DWfdcNgW52kqUcY9rf26AyVX+zPlsQGoNdnUCE36usgyMzdPpZwqfrdZG1NjrhOCe
         YXvC4/oAkoQ3w9Lf6NLkHdXQW5e9SyHzFXyg5r2gA8EZ+uI5lz+nXPsLPJq3yGgIKuUH
         1mHv/KaZma7NhTXA5PsnFLQReDuwP6X82uBzY3Ln7dN+Zu2d8unmEbnZ93mGL2Ii3T3h
         ddfA==
X-Gm-Message-State: APjAAAWw49Wx2guP8ZOyGqDfG9RIFCijsncul+B+J5LwNOdsjwuBY08t
        974nZeTtx7ECQuBBhogNzn17SQQb
X-Google-Smtp-Source: APXvYqxeRGh9l99/XieO5plm+jgtMgqBf103uW8XSd9mbSEPoPbHjwGu2hAAgCbAhoMOVC8xlYOcGw==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr1516673pgb.294.1579552015414;
        Mon, 20 Jan 2020 12:26:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u26sm38535808pfn.46.2020.01.20.12.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 12:26:54 -0800 (PST)
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
 <20200120115828.GC32175@kuha.fi.intel.com>
 <e05b6c1f-5e00-c000-23b9-1683230fd9f7@roeck-us.net>
 <546a5723-a974-ed0a-93e3-b46c919b0f7e@fivetechno.de>
 <2e739a08-191b-d7c9-1273-4000cbbca423@roeck-us.net>
 <d985890e-f1a4-a9b4-8f08-1860ea4486f7@fivetechno.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d3c847f7-2c8a-3cc0-00db-f46668fd83ca@roeck-us.net>
Date:   Mon, 20 Jan 2020 12:26:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d985890e-f1a4-a9b4-8f08-1860ea4486f7@fivetechno.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 12:14 PM, Markus Reichl wrote:
> Hi Guenter,
> 
> Am 20.01.20 um 17:04 schrieb Guenter Roeck:
>> On 1/20/20 6:34 AM, Markus Reichl wrote:
>>> Hi Guenter,
>>>
>>> Am 20.01.20 um 15:21 schrieb Guenter Roeck:
>>>> On 1/20/20 3:58 AM, Heikki Krogerus wrote:
>>>>> Hi Markus,
>>>>>
>>>>> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>>>>>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>>>>>> With measured 15W+ power consumption it should use higher voltage PD modes than
>>>>>> the standard 5V USB-C mode.
>>>>>>
>>>>>> When I add the related connector node in DTS [2] the FUSB302 initializes
>>>>>> the right PD mode (e.g. 15V/3A).
>>>>>>
>>>>>> But during initialisation the PD is switched off shortly and the board has a blackout.
>>>>>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>>>>>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>>>>>>
>>>>>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>>>>>> during init?
>>>>>
>>>>> I guess it's also possible that the problem is with tcpm.c instead of
>>>>> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
>>>>> you take a look at this?
>>>>>
>>>>
>>>> There was always a problem with handoff from the bootloader. tcpm_init() calls
>>>> tcpm_reset_port() which turns vbus and vconn off, which I imagine can
>>>> trigger the situation.
>>>>
>>>> Unfortunately I was never able to solve the puzzle. The Type-C protocol does
>>>> not support any kind of "hand-off" from one component in the system to another.
>>>> If the state machine doesn't start from a clean state, there is pretty
>>>> much no guarantee that it ever synchronizes.
>>>>
>>>> Maybe someone can find a better solution, but when I wrote the code I just
>>>> could not get it to work reliably without resetting everything during
>>>> registration.
>>>>
>>>> Note that v4.4 did not include the upstream tcpm code, suggesting the
>>>> code in the vendor kernel was possibly using a different or backported
>>>> state machine. Impossible to say what was done there without access
>>>> to the code.
>>>
>>> The vendor code for fusb302 is here:
>>> https://github.com/FireflyTeam/kernel/tree/rk3399/firefly/drivers/mfd
>>>
>>
>> AFAICS the vendor code don't reset VBUS, and selectively (only) resets the
>> PD state machine in the fusb302 on startup. The tcpm state machine is embedded
>> in the fusb302 driver, making this easier to control.
>>
>> The fusb302 Linux kernel driver, on the other side, resets the entire fusb302
>> on initialization, not just PD (bit 0 of the reset register). Question is if
>> that can be changed to just reset PD (bit 1 of the reset register).
>> Maybe that would already fix the problem. Can you give it a try ?
>>
>> Guenter
> 
> I tried
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index ed8655c6af8c..6e15e7b22064 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -334,11 +334,11 @@ static int fusb302_sw_reset(struct fusb302_chip *chip)
>          int ret = 0;
>   
>          ret = fusb302_i2c_write(chip, FUSB_REG_RESET,
> -                               FUSB_REG_RESET_SW_RESET);
> +                               FUSB_REG_RESET_PD_RESET);
>          if (ret < 0)
> -               fusb302_log(chip, "cannot sw reset the chip, ret=%d", ret);
> +               fusb302_log(chip, "cannot pd reset the chip, ret=%d", ret);
>          else
> -               fusb302_log(chip, "sw reset");
> +               fusb302_log(chip, "pd reset");
>   
>          return ret;
>   }
> 
> but did not help, after mmc and ehci initializing the PD-supply gets switched off at 1.95s.

Next step to try would be to skip vbus initialization - drop tcpm_init_vbus()
from tcpm_reset_port(). Can you do that as well ?

Thanks,
Guenter
