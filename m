Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C10620659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kivnDObF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbgEMRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732670AbgEMRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:46:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1BC061A0C;
        Wed, 13 May 2020 10:46:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u35so70805pgk.6;
        Wed, 13 May 2020 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3AyO9Ui8zFCawW0Lwfl84VvMEinAsSXxuQe8ws/cLpY=;
        b=kivnDObFzJc7ctBIJXaOiWWZXUlFXAUOrjfO9Z1UWpkr6wFzle7r+TadzK6PwrdZCE
         2dR9zZ6LUZlFeJfp+mFw66lM4bwWxM4IkZCvri+Tw595lnwdZeMxoL6gO+x0OCZtYNZS
         uGOY/rO4y6C7QSwq/KBHQE1coNFtesZE2SguL9VDMlXNECk3oiRpQKz0Q1nMuGh0qkRF
         10O60lgkp2ubtj/IZstkN6qlrmKweIwuIjiP3ofXwg/mvxdkxjzl04Zu043fFphUWwwI
         4G4XqjA6Lws1jiKE49zdTFS0MK1NYySJ+Yrh8xTNluXFd6RuogzHnCWrqHtJIj14xsjT
         kTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3AyO9Ui8zFCawW0Lwfl84VvMEinAsSXxuQe8ws/cLpY=;
        b=cdNlS369h2F3MjuQshJ7ohzQWiwCnjx3nWG+NmfvbbSZO5BzVF9H9AoCBgYvaOQ5qJ
         NStu8prXZV78vxeNaKOqiPHLFNluaf51D0TTHSTxWkFj9R+xt7Et8W/SIIvb4mDZNd4K
         /H5+GthDkNjiaBsBXJFiNE6ebS2N5bETqgxs96czgyh0BeHPotFc4RW+yvWOErUN/zHo
         FUV2l4wE2cbVsOebjKI9djrV2zBHjW3fzUAZlT+36a3qrvUDj47926lnoA7YVPtPo5Ds
         /Zg0YgFTc2OfEy68CwumOy1Nqb9OOfnhg28oCAw9VttekC7U128w0ohHkQFz89pN4T3G
         Z1KA==
X-Gm-Message-State: AOAM532Wm2PwmIwS7eGtRSo9T+AW/ERhDuR2gtmeVpixaHfHrmDFv7Hz
        frexM5VtgMlBR2fCIFC52Es=
X-Google-Smtp-Source: ABdhPJx1YL6wmL7k5tPrjJcHfiWPKgtVs/a0wT9J4nd19xkcUgoZmrwysYeOZSmB5DTuqeV8CggzJQ==
X-Received: by 2002:a63:e148:: with SMTP id h8mr405667pgk.313.1589391984595;
        Wed, 13 May 2020 10:46:24 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d12sm172454pfq.36.2020.05.13.10.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 10:46:23 -0700 (PDT)
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
 <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com>
 <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513162723.GF1362525@kroah.com>
 <38ff034d-a84c-2309-a8d5-f344930d9a31@gmail.com>
 <20200513170505.GB1369204@kroah.com>
 <20200513173920.GA2862@rowland.harvard.edu>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com>
Date:   Wed, 13 May 2020 10:46:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513173920.GA2862@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 10:39 AM, Alan Stern wrote:
> On Wed, May 13, 2020 at 07:05:05PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, May 13, 2020 at 09:31:11AM -0700, Florian Fainelli wrote:
>>>
>>>
>>> On 5/13/2020 9:27 AM, Greg Kroah-Hartman wrote:
>>>> On Wed, May 13, 2020 at 08:08:07AM -0700, Florian Fainelli wrote:
>>>>>
>>>>>
>>>>> On 5/13/2020 5:26 AM, Greg Kroah-Hartman wrote:
>>>>>> On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
>>>>>>> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
>>>>>>> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
>>>>>>> devices and OHCI handles <2.0 devices. Currently the Makefile
>>>>>>> has XHCI linking at the bottom which will result in the XHIC driver
>>>>>>> initalizing after the EHCI and OHCI drivers and any installed 3.0
>>>>>>> device will be seen as a 2.0 device. Moving the XHCI linking
>>>>>>> above the EHCI and OHCI linking fixes the issue.
>>>>>>
>>>>>> What happens if all of these are modules and they are loaded in a
>>>>>> different order?  This makefile change will not help with that, you need
>>>>>> to have logic in the code in order to properly coordinate this type of
>>>>>> mess, sorry.
>>>>>
>>>>> I believe we should be using module soft dependencies to instruct the
>>>>> module loaders to load the modules in the correct order, so something
>>>>> like this would do (not tested) for xhci-plat-hcd.c:
>>>>>
>>>>> MODULE_SOFTDEP("post: ehci-hcd ohci-hcd");
>>>>>
>>>>> and I am not sure whether we need to add the opposite for ehci-hcd and
>>>>> ohci-hcd:
>>>>>
>>>>> MODULE_SOFTDEP("pre: xhci-plat-hcd");
>>>>
>>>> That's a nice start, but what happens if that isn't honored?  This
>>>> really needs to work properly for any order as you never can guarantee
>>>> module/driver loading order in a system of modules.
>>>
>>> I also suggested that device links may help, though I am not sure. What
>>> do you suggest to be done?
>>
>> No idea.  device links will help if you defer the probe properly until
>> you see the proper drivers binding correctly.
> 
> I suspect that in general there is no way to do this properly.
> 
> We can't modify ehci-hcd and ohci-hcd to make them wait.  In fact, for 
> all they know, xhci-hcd will _never_ be loaded.
> 
> One thing that might be possible (although not all platforms may support 
> it) is if xhci-hcd could somehow disconnect all devices attached to a 
> peer port when it starts up.  But that would be disruptive to any 
> devices that aren't USB-3.
> 
> We faced a very similar ordering problem between ehci-hcd and 
> [ou]hci-hcd many years ago, and we never found a good solution.  
> We did arrange the link order so that ehci-hcd precedes the others, and 
> we added a warning message to ehci-hcd which gets printed if the module 
> initialization routine runs after [ou]hci-hcd is loaded.  Also, there 
> are MODULE_SOFTDEP lines in ohci-pci.c and uhci-pci.c.

Given that these modules are used on specific SoC platforms, where we
usually provide a reference implementation of user space and kernel
space and documentation, it seems to me that the MODULE_SOFTDEP(),
despite being a hint and best effort from user space module loaders is
probably acceptable.
-- 
Florian
