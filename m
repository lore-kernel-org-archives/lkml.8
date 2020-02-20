Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF9C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87056207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBTLV1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:21:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgBTLV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:21:26 -0500
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4jtT-0006Wy-BT
        for linux-kernel@vger.kernel.org; Thu, 20 Feb 2020 11:21:23 +0000
Received: by mail-pj1-f70.google.com with SMTP id ds13so933719pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 03:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WSsVKe5m/fI49zLSWZeeXgxmZuAkrbCjOSeJyTky1JM=;
        b=BggoX3GOnC4IlUqNNB4oiNkhjOjbV47dYxVoGXp6pLams53zAX7SKRvY/cIb+AH95U
         7XDX4mMeiPtpkDbF9PSV93yW9EtPr6/zou2JAheqbRg3tfaKm5QT+b++tkmrgSj8YgXn
         uT4VyERWK4sqDaEY0KU1j/oT2cCnmZ/umMizWn5YCSOPnP/WFgZtUzWP53Ha1U0+DsQ0
         RczdXSepI/SA8HiPhhv8tjzTVHXgNfzfh1kz9S9+zpEyCPR795pKkv5vcksOfxnKtKct
         dipJ3Vw5Q3SWmxQepYmpB/zWPEzkhGD07PXfozRcS+kBcAzmKowNmXZLkX2qV3ABz6Tt
         dAog==
X-Gm-Message-State: APjAAAU3t7ltpq0mREvVSJSBZg7D5Cf5V+UmqeoCDmRwiRkO1gO32V9d
        4JZG09y73Ju9EhDRNpRSiaQRvXwpowntxT0NUCYTLQRmMbPII/lW6pxNc/BJXLIgvVP67BcqGG4
        pg5jVaI5HPoMBcXdFTta5asRTA9dsIe7Odc9lnBIpNg==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr31362169plf.78.1582197681512;
        Thu, 20 Feb 2020 03:21:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyOojlmbrBEfU+UtdeK3OKApDHQEphuC9Anq0405U24Th2wQQ/B3DkQ1V9+saRUPwRC1RdxA==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr31362145plf.78.1582197681120;
        Thu, 20 Feb 2020 03:21:21 -0800 (PST)
Received: from 2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net (2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net. [2001:b011:380f:3214:b828:48d4:ee3d:9937])
        by smtp.gmail.com with ESMTPSA id 84sm3445110pgg.90.2020.02.20.03.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 03:21:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0in-v9iu88Wj0gAg_th-E-QWDSHZ_XvgyoOuqE=CZPtqQ@mail.gmail.com>
Date:   Thu, 20 Feb 2020 19:21:18 +0800
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <73F7D94E-65B1-4069-AA97-5A34617308B9@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
 <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
 <CAJZ5v0jXvo0ceNMp=kstTi24Ne7F-ZGMcD0T0TSMpcZZWsJsUA@mail.gmail.com>
 <CA007B3C-C084-429E-B774-70264A9E609F@canonical.com>
 <CAJZ5v0in-v9iu88Wj0gAg_th-E-QWDSHZ_XvgyoOuqE=CZPtqQ@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 20, 2020, at 18:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Thu, Feb 20, 2020 at 11:25 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Feb 20, 2020, at 18:12, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> 
>>> On Thu, Feb 20, 2020 at 9:08 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> Hi Srinivas,
>>>> 
>>>>> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>>>>> 
>>>>> Hi Kai,
>>>>> 
>>>>> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
>>>>>> Hi Srinivas,
>>>>>> 
>>>>>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
>>>>>> asking you the issue I am facing:
>>>>>> Once a laptop has a HDD installed, the power consumption during
>>>>>> S2Idle increases ~0.4W, which is quite a lot.
>>>>>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
>>>>>> to do proper power management for HDDs?
>>>>> What is the default here
>>>>> cat /sys/power/mem_sleep
>>>>> s2idle or deep?
>>>> 
>>>> It defaults to s2idle.
>>>> 
>>>>> 
>>>>> Please follow debug steps here:
>>>>> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
>>>>> 
>>>>> We need to check whether you get any PC10 residency or not.
>>>> 
>>>> Yes it reaches PC10. It doesn't reach SLP_S0 though.
>>>> The real number on S2Idle power consumption:
>>>> No HDD: ~1.4W
>>>> One HDD: ~1.8W
>>>> 
>>>> If the SoC doesn't hit PC10 the number should be significantly higher.
>>>> That's why I think the issue is the power management on HDD itself.
>>> 
>>> I'm assuming that you mean a non-SSD device here.
>> 
>> Yes, it's spinning rust here.
>> 
>>> 
>>> That would be handled via ata_port_suspend() I gather and whatever
>>> that does should do the right thing.
>>> 
>>> Do you think that the disk doesn't spin down or it spins down, but the
>>> logic stays on?
>> 
>> The spin sound is audible, so I am certain the HDD spins down during S2Idle.
> 
> OK
> 
>> How do I know if the logic is on or off?
> 
> Well, if it were off, it would not draw power. :-)
> 
> So IMO it is reasonable to assume that the logic on the drive stays
> on.  I'm not aware of anything that can be done to turn it off,
> however.

Okay, thanks for the info.
I'll ask vendors the possibility to handle it at system firmware level.

Kai-Heng
