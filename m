Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50793C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E9120848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgBMGOP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:14:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgBMGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:14:15 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j27lM-0005gY-Gv
        for linux-kernel@vger.kernel.org; Thu, 13 Feb 2020 06:14:12 +0000
Received: by mail-pl1-f200.google.com with SMTP id k16so2583757pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 22:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iFTWL0F6XbEgUZzdQsa4Lq7XsI2j5FghOEFQx5EWTBU=;
        b=aPzLdpa4yrNk2r37vrqygD8gubHuD4+xDOa0N8w+dWPdV0W8vn7lYxB5ecLMusVm/Y
         D7UJ4srYUHcFgYQLIRZ1l8AW43Bw8313kYtkgxsrSsQhmRLksJ2YYF/1tSx2vnUhaRr5
         IdSwL/ZJpmd8wyoUEADO9NknOt++tyidiiBKuS3CWloXtYaUmpP5cvz7AvHw+MVo3g0R
         0aujhe+4eX1ILziV2EtiVLGNP/kMAn3XmsG1j/765iTvGx0LH9L4xu815T5KlOzNhA/p
         NC6sOXsq1WGkAXQ34Gfippp+OHhIgInk2R8klBzS5mdFt2JJpRwkUm1CMXuSXnHC5psb
         BLMA==
X-Gm-Message-State: APjAAAVgyITYEsgB0kc4y/A1O/UJ+u4EIVMvJMyTyljNCK1iEft8c030
        lvpbTZ9AmGH6mLAAhARyiDJBRHQ58I7V5dIgA3TlHqxOOpp2vsICAx7aaS6e5HAOz3ubGas1vCt
        58mMP/fFolrFm49uKRXqIUzMkd9ZKmNnPJJPJPM9AUQ==
X-Received: by 2002:a63:34e:: with SMTP id 75mr13066833pgd.286.1581574450422;
        Wed, 12 Feb 2020 22:14:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzT9Z2iW42XtrLIqYPUNuKLar0Sh4sU/tNHkIS51us6U+ljOu3YmbnxZJEs456aej2kx9cetw==
X-Received: by 2002:a63:34e:: with SMTP id 75mr13066806pgd.286.1581574450017;
        Wed, 12 Feb 2020 22:14:10 -0800 (PST)
Received: from 2001-b011-380f-3214-1cc0-4d67-0ea8-9f12.dynamic-ip6.hinet.net (2001-b011-380f-3214-1cc0-4d67-0ea8-9f12.dynamic-ip6.hinet.net. [2001:b011:380f:3214:1cc0:4d67:ea8:9f12])
        by smtp.gmail.com with ESMTPSA id i27sm1141022pgn.76.2020.02.12.22.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 22:14:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: SFP+ support for 8168fp/8117
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <02F7CBDE-B877-481C-A5AF-2F4CBF830A2C@canonical.com>
Date:   Thu, 13 Feb 2020 14:14:06 +0800
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <80E9C881-91C8-4F29-B9CE-652F9EE0B018@canonical.com>
References: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
 <20200102152143.GB1397@lunn.ch>
 <DC28A43E-4F1A-40B6-84B0-3E79215527C9@canonical.com>
 <c148fefc-fd56-26a8-9f9b-fbefbaf25050@gmail.com>
 <02F7CBDE-B877-481C-A5AF-2F4CBF830A2C@canonical.com>
To:     Chun-Hao Lin <hau@realtek.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Hao,

> On Jan 3, 2020, at 12:53, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On Jan 3, 2020, at 05:24, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> 
>> On 02.01.2020 17:46, Kai-Heng Feng wrote:
>>> Hi Andrew,
>>> 
>>>> On Jan 2, 2020, at 23:21, Andrew Lunn <andrew@lunn.ch> wrote:
>>>> 
>>>> On Thu, Jan 02, 2020 at 02:59:42PM +0800, Kai Heng Feng wrote:
>>>>> Hi Heiner,
>>>>> 
>>>>> There's an 8168fp/8117 chip has SFP+ port instead of RJ45, the phy device ID matches "Generic FE-GE Realtek PHY" nevertheless.
>>>>> The problems is that, since it uses SFP+, both BMCR and BMSR read are always zero, so Realtek phylib never knows if the link is up.
>>>>> 
>>>>> However, the old method to read through MMIO correctly shows the link is up:
>>>>> static unsigned int rtl8169_xmii_link_ok(struct rtl8169_private *tp)
>>>>> {
>>>>>     return RTL_R8(tp, PHYstatus) & LinkStatus;
>>>>> }
>>>>> 
>>>>> Few ideas here:
>>>>> - Add a link state callback for phylib like phylink's phylink_fixed_state_cb(). However there's no guarantee that other parts of this chip works.
>>>>> - Add SFP+ support for this chip. However the phy device matches to "Generic FE-GE Realtek PHY" which may complicate things.
>>>>> 
>>>>> Any advice will be welcome.
>>>> 
>>>> Hi Kai
>>>> 
>>>> Is the i2c bus accessible?
>>> 
>>> I don't think so. It seems to be a regular Realtek 8168 device with generic PCI ID [10ec:8168].
>>> 
>>>> Is there any documentation or example code?
>>> 
>>> Unfortunately no.
>>> 
>>>> 
>>>> In order to correctly support SFP+ cages, we need access to the i2c
>>>> bus to determine what sort of module has been inserted. It would also
>>>> be good to have access to LOS, transmitter disable, etc, from the SFP
>>>> cage.
>>> 
>>> Seems like we need Realtek to provide more information to support this chip with SFP+.
>>> 
>> Indeed it would be good to have some more details how this chip handles SFP+,
>> therefore I add Hau to the discussion.
>> 
>> As I see it the PHY registers are simply dummies on this chip. Or does this chip
>> support both, PHY and SFP+? Hopefully SFP presence can be autodetected, we could
>> skip the complete PHY handling in this case. Interesting would be which parts of
>> the SFP interface are exposed how via (proprietary) registers.
>> Recently the STMMAC driver was converted from phylib to phylink, maybe we have
>> to do the same with r8169 one fine day. But w/o more details this is just
>> speculation, much appreciated would be documentation from Realtek about the
>> SFP+ interface.
>> 
>> Kai, which hardware/board are we talking about?
> 
> It's a regular Intel PC.
> 
> The ethernet is function 1 of the PCI device, function 0 isn't bound to any driver:
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device [10ec:816e] (rev 1a)
> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 22)

Would it be possible to share some info on SFP support?

Kai-Heng

> 
> Kai-Heng
> 
>> 
>>> Kai-Heng
>>> 
>>>> 
>>>> Andrew
>>> 
>> Heiner
> 

