Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D91BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96A7207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fluZZrz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgEMP2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgEMP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:28:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8053C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:28:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so11254011pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4VqrDPtNrY8lU3jv4tbGJ+nxlqODxkNJ8mQ1kIusA3s=;
        b=fluZZrz+O2fICElXwhjMSYxAQrhkMhGKHiOoJDtdBYYrM6szMhqD4hxk+9S/ZftImQ
         r96KGLWZN8Gh+PeHts9jOj7MRSh4dPpzON8r9dlgXeb28GLUu6EZ/u8W3+SD8tXHoML4
         cMy4/pufmvHKH/sxSEn2bRjX5KjLt2fJTqf5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4VqrDPtNrY8lU3jv4tbGJ+nxlqODxkNJ8mQ1kIusA3s=;
        b=DEDLCXPDuScrw4eM7V8DpQTFRJs54Y33rSXRP5i2AeQptCFgjQ49OcHf5e2tT+n5UJ
         BiHNnu5QXcIvqFS7s+RIlqOWnc8S0cm+HOmYVhfusB/RucCC/CtuNVSt4viRn8OMPpjM
         HdFZSY4OgJmYKPmJg+yeYMRORJGP70OHWSWYR/2FiNTsUJTXjCYI9e7EJMkHFhzxQOU8
         2pUfAcNpe32BUs1dnuE6idolXSklcwk84ZgHv379eCsQwZhRApnzkPx1jV3pgtprNQt2
         9iC6oQ2z8kS5aYNt+8YredkrcGmkpgdTS9jdEM47C+Th8AKbP3GtLhFcwTNfXDeiBILP
         ARkw==
X-Gm-Message-State: AGi0PuY+UorAJslUV+CGgEtVoN22kNUDB9Xib77YZk+jZG+BvT8fuN3+
        C/59tvWoqsr9LoJhNxoD/Li2ZQ==
X-Google-Smtp-Source: APiQypLwE5b0n6ox/XG+aPuvmiery03Ijo0hokbmjaaas92s1E2eRupRYJZVsWYaZPW4kxRd8JXDyA==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr36669866pjj.122.1589383734237;
        Wed, 13 May 2020 08:28:54 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q3sm2710500pfg.22.2020.05.13.08.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:28:53 -0700 (PDT)
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
 <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com>
 <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513152613.GR185537@smile.fi.intel.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXnQoOxcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoHaNB/4p5GXw2Xlk4r2J0MsUAZE4Gnfc
 C4DtilufOGVR1K0/WhROYemyCAP+xuBj8bnQDBtZwB5ED37q4/p8DSmCnkEBjM5Cz12EZQzs
 utQgCV1UIgzryoiDZSF2XLslzF9LOSaOiNzpBvwEYNTZ+koEW+AOHEAgS6SbV2Hob8Zc32xF
 oQdKGwbSwcV8hS2YLL37VxKr2h8ZTtuTmhDNqxuKPzZuoAL61/4i8+BTyVZC4gUL/EUu7pG2
 rbwhg/s8TyQWWeBz18Xiw5K148TXT0LeErmTsJSPQFMqZ6AR/nuJDQzhIUiLeq/hvBs1BIQf
 REqNMShEnnMJfHjd8RFnGpdPk+hKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <2fda61f9-388f-d62b-feaf-9782cbbe37fd@broadcom.com>
Date:   Wed, 13 May 2020 08:28:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513152613.GR185537@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 8:26 AM, Andy Shevchenko wrote:
> On Wed, May 13, 2020 at 08:08:07AM -0700, Florian Fainelli wrote:
>> On 5/13/2020 5:26 AM, Greg Kroah-Hartman wrote:
>>> On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
>>>> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
>>>> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
>>>> devices and OHCI handles <2.0 devices. Currently the Makefile
>>>> has XHCI linking at the bottom which will result in the XHIC driver
>>>> initalizing after the EHCI and OHCI drivers and any installed 3.0
>>>> device will be seen as a 2.0 device. Moving the XHCI linking
>>>> above the EHCI and OHCI linking fixes the issue.
>>>
>>> What happens if all of these are modules and they are loaded in a
>>> different order?  This makefile change will not help with that, you need
>>> to have logic in the code in order to properly coordinate this type of
>>> mess, sorry.
>>
>> I believe we should be using module soft dependencies to instruct the
>> module loaders to load the modules in the correct order, so something
>> like this would do (not tested) for xhci-plat-hcd.c:
>>
>> MODULE_SOFTDEP("post: ehci-hcd ohci-hcd");
>>
>> and I am not sure whether we need to add the opposite for ehci-hcd and
>> ohci-hcd:
>>
>> MODULE_SOFTDEP("pre: xhci-plat-hcd");
> 
> JFYI: not all user space support this (alas, but that's current state of
> affairs), OTOH I don't really care about those which do not support it
> (Busybox).

I know that Gentoo's initramfs tool does not support it, however given
there are no symbols being cross referenced, I am not sure how to best
support this other than using these hints, and possibly making use of
device links too?
-- 
Florian
