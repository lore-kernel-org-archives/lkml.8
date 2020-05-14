Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47651C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199262065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1CqEws0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgENTvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgENTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:51:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAABC061A0C;
        Thu, 14 May 2020 12:51:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so207893wrn.6;
        Thu, 14 May 2020 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GHAkvo3C1Root8SQChzVWlpWixRXLm7GQ8ZrDiIy7bo=;
        b=l1CqEws0Bp07cLGIXwGNWUY3YaJjMynyz9gjJqGWB5B41vzHwIJD04UIqEXrbsjRrS
         AvRQbwJqBgoDl1Y/XHWGRKYHKEd8AfnhfEiJ5U2BUjgF2/1fIskg3uUa+UCUITmheHnQ
         Hp2vtby50vW0U9r0/ACSuP8PC4qj2eHmNFjsCg9gRpiXp+nzNIusXLep0XUIZKtwNin0
         pyA+BXUFCmPUjoiDQ8aUwRL0XGyPPrCIEWzW+jF+Kbc2C5F7DVVOtYkWhu/gKevztS51
         TwCozh+M+YOXu91yYW91fVur5k5qkbjumy60sM7j0RHMojK2hAqDD9wah0RAWLmpsLMO
         rOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHAkvo3C1Root8SQChzVWlpWixRXLm7GQ8ZrDiIy7bo=;
        b=PV6OLzMmheyBTv0xOaoNs5iM3wFxIJQ3tMsMCv1DsaPi/zleMB893zoZrrez9KuOfx
         GMJogwwI4PXz5gv7oHNzHzU2yjLGzw0Jhj9mcdrdeYK3t+iNrQrZ9HJJ5jmgbxG7qzCS
         wGIbaydD09Sw2k0khJtXVqnYAlv5Gr70GiPY6+w8XHaPutrT0cwmYfMHWa84ehBSzQGy
         z30HMnNnC33yG0DrVUQ7uqVO5s6qIvJJBB1/85Xuu0NBvBwMb2jW+Vdua15hrOXeZeqG
         ZpWfbg+X23KafXKpOMsNwK9ABdMy1CnwfldQbFJ13LW8bgv6dX+QrQ/slm+x6lWXr5ac
         /msw==
X-Gm-Message-State: AOAM530TMhS4H9LT/kOeO6Ifk1KvwcwylG4zTB9yb3no5yJZNfaAHlrG
        F6lPibynCM2Lnb7h09MCZYsmrBvn
X-Google-Smtp-Source: ABdhPJxrrxPCczNT+mmqxUAK57nR7ttXGCVNCAdgaM8QbeOlojyvMplYV40gRmPb1n9P9jFfhMPh5w==
X-Received: by 2002:adf:decb:: with SMTP id i11mr102252wrn.172.1589485861980;
        Thu, 14 May 2020 12:51:01 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:5200:44a3:4c94:7927:e2e6? (p200300EA8F28520044A34C947927E2E6.dip0.t-ipconnect.de. [2003:ea:8f28:5200:44a3:4c94:7927:e2e6])
        by smtp.googlemail.com with ESMTPSA id c125sm161823wma.23.2020.05.14.12.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 12:51:01 -0700 (PDT)
Subject: Re: [PATCH] net: phy: realtek: clear interrupt during init for
 rtl8211f
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200512184601.40b1758a@xhacker.debian>
 <7735a257-21ff-e6c0-acdc-f5ee187b1f57@gmail.com>
 <20200513145151.04a6ee46@xhacker.debian>
 <a0aac85d-064f-2672-370b-404fd83e83f3@gmail.com>
 <20200514142537.63b478fd@xhacker.debian>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <bbb70281-d477-d227-d1d2-aeecffdb6299@gmail.com>
Date:   Thu, 14 May 2020 21:50:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514142537.63b478fd@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2020 08:25, Jisheng Zhang wrote:
> On Wed, 13 May 2020 20:45:13 +0200 Heiner Kallweit wrote:
> 
>>
>> On 13.05.2020 08:51, Jisheng Zhang wrote:
>>> Hi,
>>>
>>> On Tue, 12 May 2020 20:43:40 +0200 Heiner Kallweit wrote:
>>>  
>>>>
>>>>
>>>> On 12.05.2020 12:46, Jisheng Zhang wrote:  
>>>>> The PHY Register Accessible Interrupt is enabled by default, so
>>>>> there's such an interrupt during init. In PHY POLL mode case, the
>>>>> INTB/PMEB pin is alway active, it is not good. Clear the interrupt by
>>>>> calling rtl8211f_ack_interrupt().  
>>>>
>>>> As you say "it's not good" w/o elaborating a little bit more on it:
>>>> Do you face any actual issue? Or do you just think that it's not nice?  
>>>
>>>
>>> The INTB/PMEB pin can be used in two different modes:
>>> INTB: used for interrupt
>>> PMEB: special mode for Wake-on-LAN
>>>
>>> The PHY Register Accessible Interrupt is enabled by
>>> default, there's always such an interrupt during the init. In PHY POLL mode
>>> case, the pin is always active. If platforms plans to use the INTB/PMEB pin
>>> as WOL, then the platform will see WOL active. It's not good.
>>>  
>> The platform should listen to this pin only once WOL has been configured and
>> the pin has been switched to PMEB function. For the latter you first would
>> have to implement the set_wol callback in the PHY driver.
>> Or where in which code do you plan to switch the pin function to PMEB?
> 
> I think it's better to switch the pin function in set_wol callback. But this
> is another story. No matter WOL has been configured or not, keeping the
> INTB/PMEB pin active is not good. what do you think?
> 

It shouldn't hurt (at least it didn't hurt for the last years), because no
listener should listen to the pin w/o having it configured before.
So better extend the PHY driver first (set_wol, ..), and then do the follow-up
platform changes (e.g. DT config of a connected GPIO).

>> One more thing to consider when implementing set_wol would be that the PHY
>> supports two WOL options:
>> 1. INT/PMEB configured as PMEB
>> 2. INT/PMEB configured as INT and WOL interrupt source active
>>
>>>  
>>>> I'm asking because you don't provide a Fixes tag and you don't
>>>> annotate your patch as net or net-next.  
>>>
>>> should be Fixes: 3447cf2e9a11 ("net/phy: Add support for Realtek RTL8211F")
>>>  
>>>> Once you provide more details we would also get an idea whether a
>>>> change would have to be made to phylib, because what you describe
>>>> doesn't seem to be specific to this one PHY model.  
>>>
>>> Nope, we don't need this change in phylib, this is specific to rtl8211f
>>>
>>> Thanks,
>>> Jisheng
>>>  
>> Heiner
> 

