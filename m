Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730EE2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baBZ/42W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgATQEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:04:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39122 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:04:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id e11so7409259pjt.4;
        Mon, 20 Jan 2020 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6RxjFM/GfKD5nyo9iA2+9b4lmEgTQWkl8cQBrKwCqZs=;
        b=baBZ/42WJWI6QSYxH+wVyJ6ueuMXRsDRjwuDLiKmzBE8yYQBWc/dX0suG7sywu0bJX
         7J1AJmQ28lW0dNoBwWupBCEr8EZLYZjjpKmz3LOtuinAavVoNblnG1O3KUMYuxgLQ91x
         1X+mNDtAgaZBM1jtiUMy3rXdpxywElcY6Yj4IlZ3lZqwiXYanHcD+zG7EjihroeLY/Kd
         XLApWQENwqJqVpyYHrGzvk2FNQ4+0aMV8rclnbQW1i5VUiW5PtaUUwPMpiB8OMpxLFC/
         2p3AjZ9+YarLjLWfRYHakMPCDUwNQOpTQBzKKXUnWKFkC1e3X2q7O1W1p1k8D4jqKaCI
         pUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6RxjFM/GfKD5nyo9iA2+9b4lmEgTQWkl8cQBrKwCqZs=;
        b=ozP+jA0u22M8l1uH/OqPJKT+BFWJTgWpz4wCzbTOElu9QUYHdy7T6lQhlmELnN2Dvp
         rOvadEgj9YdQ1tBltJKw3EkR08ENNMNDRZsFbL5QwAOqgtwvLBAtDSf6vMBDhlrOdawt
         Tg9xiwacW0Vg9x+476EmogK/dvP/WY2SGtsfy6fPSP255SUZRqplPxGO/VtwkV6wSH7I
         W0c0YGu61MGUQzsUto7FNuwkxh1AfEpZBsAgdehAMd0D+j+yYuCg19iq76yQhg50RIwj
         0aUD3uSkSBZqWHqrBDTtHqUBYoxIDyLrmgUESDA+xRxKCKfly4ody9goZpGWxqQvOkgK
         1a4A==
X-Gm-Message-State: APjAAAVKj1+ufhXsUqwtczLE1yJiTieidAKyB0z1eZGlG8msRaiZn1tm
        lvb9Q10kDE+JKZtpVxym/ewzVgoV
X-Google-Smtp-Source: APXvYqy+etnS5/3xrC+jjUrFU6lqSkzhah2jdFw43oEIu9cb2x9nHMTrcuxahaQB+/qkjeH7eaLfHw==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr291512pjx.54.1579536284631;
        Mon, 20 Jan 2020 08:04:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c22sm39332864pfo.50.2020.01.20.08.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:04:43 -0800 (PST)
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e739a08-191b-d7c9-1273-4000cbbca423@roeck-us.net>
Date:   Mon, 20 Jan 2020 08:04:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <546a5723-a974-ed0a-93e3-b46c919b0f7e@fivetechno.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 6:34 AM, Markus Reichl wrote:
> Hi Guenter,
> 
> Am 20.01.20 um 15:21 schrieb Guenter Roeck:
>> On 1/20/20 3:58 AM, Heikki Krogerus wrote:
>>> Hi Markus,
>>>
>>> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>>>> Hi,
>>>>
>>>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>>>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>>>> With measured 15W+ power consumption it should use higher voltage PD modes than
>>>> the standard 5V USB-C mode.
>>>>
>>>> When I add the related connector node in DTS [2] the FUSB302 initializes
>>>> the right PD mode (e.g. 15V/3A).
>>>>
>>>> But during initialisation the PD is switched off shortly and the board has a blackout.
>>>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>>>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>>>>
>>>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>>>> during init?
>>>
>>> I guess it's also possible that the problem is with tcpm.c instead of
>>> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
>>> you take a look at this?
>>>
>>
>> There was always a problem with handoff from the bootloader. tcpm_init() calls
>> tcpm_reset_port() which turns vbus and vconn off, which I imagine can
>> trigger the situation.
>>
>> Unfortunately I was never able to solve the puzzle. The Type-C protocol does
>> not support any kind of "hand-off" from one component in the system to another.
>> If the state machine doesn't start from a clean state, there is pretty
>> much no guarantee that it ever synchronizes.
>>
>> Maybe someone can find a better solution, but when I wrote the code I just
>> could not get it to work reliably without resetting everything during
>> registration.
>>
>> Note that v4.4 did not include the upstream tcpm code, suggesting the
>> code in the vendor kernel was possibly using a different or backported
>> state machine. Impossible to say what was done there without access
>> to the code.
> 
> The vendor code for fusb302 is here:
> https://github.com/FireflyTeam/kernel/tree/rk3399/firefly/drivers/mfd
> 

AFAICS the vendor code don't reset VBUS, and selectively (only) resets the
PD state machine in the fusb302 on startup. The tcpm state machine is embedded
in the fusb302 driver, making this easier to control.

The fusb302 Linux kernel driver, on the other side, resets the entire fusb302
on initialization, not just PD (bit 0 of the reset register). Question is if
that can be changed to just reset PD (bit 1 of the reset register).
Maybe that would already fix the problem. Can you give it a try ?

Guenter
