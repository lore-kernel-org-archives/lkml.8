Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1B1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97E020708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is7/Ki7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgA3VRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:17:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgA3VQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:16:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so1827847plj.5;
        Thu, 30 Jan 2020 13:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9z1ji1XI9x2ElU3JVLNHC7IHbODO5Yx8KS5lA50OWDQ=;
        b=is7/Ki7qeNGRZqe0Km8A5jUlEAXkI1wDK/+YG7VPYiPEk29SbSYxW0Dv1mbuXSIyR6
         vuS9PsvapTy8ncL1Gzh8ldUrB39x5FSMakIuk6zDLk55zGp2aaA6JY5+Mt4XDQI9H7/J
         FSb9d1E/P50QonRK+QNen2zUVG/HObb5VrlpSc2B9+X7djx3nzepyisCOBGhBDVEwHwz
         dRXPaKYC+lLj080/rwtbf9/xG39DgqGJg36GC/6sCiSAkAE5D7l1x9mpWA9PIvvGYLcU
         Tp7Vt6YClp0RBuEWX53UEP98SWkIibYB09KVhJz3oCSIIPaoGapq24rlMO3wj8+XssRp
         NqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9z1ji1XI9x2ElU3JVLNHC7IHbODO5Yx8KS5lA50OWDQ=;
        b=TAsLT1Pvg0vSDND2ppLyHSIUZH17/FmNewMOpv1jAbxVF45aWGQHDjwzBJn1jzSCXH
         vrtrmB8OWNRFXoOMW1SDvi84sSl2PD+W0Oq9NSUGiwNdNbQanW1DwCpTgKFRRfnDLYLg
         2g2nTX4+rfW/kNHXY+GR2x/SBTp4LyCIk6vtllvzDaAGginDI+bv9G2JRFd81bmhRN+f
         GwfHuueV31EPNbg2/1gZ0BwtDP+o4ikZ/YO1M0qcjv68Zk56RpnQ8bXIqWBm0xIDFh5Q
         s6alBGB3OrlA7XJrVTVy1K6ptw5Z2LSmhe1t67dOsarjzJHD90p4zmWcsFkysz60/F0r
         AEpQ==
X-Gm-Message-State: APjAAAU5jwYASvHowXY4jHPdomJrmXT8ATCexUlywBZoNTPTAZ7V0+bT
        ypFunqqjmTY+MUo2yvRbzCzM2ydF
X-Google-Smtp-Source: APXvYqyAxiLT8RkiPIpI9BPPOn+XovBZeBsYegjSLOJM+l5K7R3lODPuNbxMhuukJ+NxGREahe2nsQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr6584659pll.72.1580419019050;
        Thu, 30 Jan 2020 13:16:59 -0800 (PST)
Received: from [192.168.0.16] ([75.167.220.149])
        by smtp.gmail.com with ESMTPSA id e6sm7694489pfh.32.2020.01.30.13.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 13:16:58 -0800 (PST)
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before resusciation")
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Heinzelmann <heinzelmann.david@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.2001231035250.1518-100000@iolanthe.rowland.org>
From:   Paul Zimmerman <pauldzim@gmail.com>
Message-ID: <482da576-e945-b804-3d36-65aee142e645@gmail.com>
Date:   Thu, 30 Jan 2020 14:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2001231035250.1518-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 1/23/20 8:50 AM, Alan Stern wrote:
> On Wed, 22 Jan 2020, Paul Zimmerman wrote:
> 
>>> Still, since there was no real connection change at the port, there's
>>> no reason to call hub_port_connect_change() here.  Let's see if the
>>> patch below fixes your problem.
>>>
>>> Alan Stern
>>>
>>>
>>>
>>> Index: usb-devel/drivers/usb/core/hub.c
>>> ===================================================================
>>> --- usb-devel.orig/drivers/usb/core/hub.c
>>> +++ usb-devel/drivers/usb/core/hub.c
>>> @@ -1216,11 +1216,6 @@ static void hub_activate(struct usb_hub
>>>   #ifdef CONFIG_PM
>>>   			udev->reset_resume = 1;
>>>   #endif
>>> -			/* Don't set the change_bits when the device
>>> -			 * was powered off.
>>> -			 */
>>> -			if (test_bit(port1, hub->power_bits))
>>> -				set_bit(port1, hub->change_bits);
>>>   
>>>   		} else {
>>>   			/* The power session is gone; tell hub_wq */
>>>
>>
>> I can confirm this fixes the issue for me, I did a couple dozen
>> suspend/resume cycles without seeing a failure.
>>
>> I see the code you removed was added by Lan Tianyu in commit
>> ad493e5e5805 ("usb: add usb port auto power off mechanism"). I
> 
> No, not really.  The set_bit() call was added by me in a much earlier
> commit (8808f00c7adf, merged in 2008).  Lan Tianyu merely added the
> "if" test, so that set_bit() doesn't always get called.  Now with this
> change, set_bit() never gets called.
> 
>> wonder if your patch would break that? I don't know what that is
>> or how to test it.
> 
> While some code review by people who are familiar with this material
> wouldn't hurt, I don't think you need to worry about any additional
> testing.
> 
>> In any case:
>> Tested-by: Paul Zimmerman <pauldzim@gmail.com>
> 
> Thank you.  I'll submit the patch soon.
> 
> Alan Stern

Ping? Unfortunately 5.5 was released with this regression, do you plan
to submit this patch soon?

-- 
Paul
