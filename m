Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E1C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5B21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrGpEq5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgATOV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:21:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36475 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgATOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:21:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so15626195pgc.3;
        Mon, 20 Jan 2020 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8E3LRqxKWSJfkkJ8nF8BrhNVWHzr4oovt9xNy2ECPZw=;
        b=MrGpEq5f95RjzKX+K9agMHoOO/DR9lCooXV9nSQor1+iUOs5bjVIMQRkZRlnrSpzEv
         r9IGrEYlAPlU0NBC0Yh/FIstYIIle18S1d5za6NJkNmqBlfXJIGUMHvPPhq6d7rl4Uem
         mkZyeuw+JXdokXpLl3ezX6lzhQr396xs350Nkk0RU7lHFDl/rBe11B//6o+udFkZ89Qi
         T3I0C1/66EvJAOelxMHyCuEGeWqIYdIVJM4Jxq54CGtGLiyD6J7AK0ZlMfi7qrUyTegz
         oSc1r+BlIINicegh2kPjvLn96/xGLBh2/gWT6tqwo1BTkI2FDhuiMJhnie+9FK6gXS9t
         udbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8E3LRqxKWSJfkkJ8nF8BrhNVWHzr4oovt9xNy2ECPZw=;
        b=V0/Ln2JaPtNF08MaIGr4OuJ6T56L7HrEYoxWmGtw3sSp5CVbB3+aO54Wf8PsmGiieK
         mWWoBj0+qU6U2YUOThrZRU3C5QW4Jpi5obvnqIkSMGKW2ozhy6nKKxsaEB/96y9pnxMO
         lMBynFwzWVN+zO2QbnZwTsiS7QItVis2y5W/m0XnCGYzXXNXNCeCLz+1dyVFBAqJcWUG
         MWKarbi0rTZqiZhz8ZkovbxoIRQG9RXNvld5WcQh3Gkjs67uyqK7Db6RswVyVdyUK1Re
         OOVx/IdEgnOfe8ccWApWnPycdUth31DBPRmQYlvZtbr4WHrk21mOSwNQU0JEW2L/VAn1
         xF4g==
X-Gm-Message-State: APjAAAV8LzO+LQOSoXE1i064Rw4v16QwD9RpHEsdF7row96VQCHpEQ1p
        G0Ptj73keU6xv0riP3lU42A=
X-Google-Smtp-Source: APXvYqy5CAGjZ7NT2LD5lX6OlrEIwIIRCga5Q5oavOeqTRD4chaXDJD4yFNzZEWW+AbQp/4/4WdGHQ==
X-Received: by 2002:a63:cb06:: with SMTP id p6mr60103196pgg.236.1579530083959;
        Mon, 20 Jan 2020 06:21:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9sm40314223pfm.150.2020.01.20.06.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:21:21 -0800 (PST)
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
 <20200120115828.GC32175@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e05b6c1f-5e00-c000-23b9-1683230fd9f7@roeck-us.net>
Date:   Mon, 20 Jan 2020 06:21:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120115828.GC32175@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 3:58 AM, Heikki Krogerus wrote:
> Hi Markus,
> 
> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>> Hi,
>>
>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>> With measured 15W+ power consumption it should use higher voltage PD modes than
>> the standard 5V USB-C mode.
>>
>> When I add the related connector node in DTS [2] the FUSB302 initializes
>> the right PD mode (e.g. 15V/3A).
>>
>> But during initialisation the PD is switched off shortly and the board has a blackout.
>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>>
>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>> during init?
> 
> I guess it's also possible that the problem is with tcpm.c instead of
> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
> you take a look at this?
> 

There was always a problem with handoff from the bootloader. tcpm_init() calls
tcpm_reset_port() which turns vbus and vconn off, which I imagine can
trigger the situation.

Unfortunately I was never able to solve the puzzle. The Type-C protocol does
not support any kind of "hand-off" from one component in the system to another.
If the state machine doesn't start from a clean state, there is pretty
much no guarantee that it ever synchronizes.

Maybe someone can find a better solution, but when I wrote the code I just
could not get it to work reliably without resetting everything during
registration.

Note that v4.4 did not include the upstream tcpm code, suggesting the
code in the vendor kernel was possibly using a different or backported
state machine. Impossible to say what was done there without access
to the code.

Guenter

> Both tcpm.c and fusb302.c create debugfs entries that have a more
> detailed log about things that are happening. Can you check what you
> have in those (when you boot with the mains cable plugged it)?
> 
>          % mount debugfs -t debugfs /sys/kernel/debug
>          % cat /sys/kernel/debug/tcpm*
>          % cat /sys/kernel/debug/fusb302/*
> 
> Which kernel are you running by the way?
> 
>> In vendor kernel (4.4) this is done somehow but the sources are too different for me to find
>> out how.
>>
>> Gruß,
>> -- 
>> Markus Reichl
>>
>> [1]
>> http://download.t-firefly.com/product/RK3399/Docs/Hardware/%E5%8E%9F%E7%90%86%E5%9B%BE%E5%92%8C%E8%B4%B4%E7%89%87%E5%9B%BE/ROC-RK3399-PC/ROC-3399-PC-V10-A-20180804_%E5%8E%9F%E7%90%86%E5%9B%BE.pdf
>>
>> [2]
>> https://lkml.org/lkml/2019/12/10/517
> 

