Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C3DC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E332206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDVNXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:23:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45986 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgDVNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:23:45 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jRFJK-0003jN-LO
        for linux-kernel@vger.kernel.org; Wed, 22 Apr 2020 13:21:06 +0000
Received: by mail-pl1-f197.google.com with SMTP id 7so1824654ple.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T0LMZyTXWoFEf1aVh2cXDeose+ywIML9Nz9WjlzDhZo=;
        b=aansu3808Zqci7a1w4yJZIy3Z+T4ymA2YkFSom+D4Le91YJUgeBLoodAZRA6ii3vek
         PE0Ibwk7kYsSYfY83A96I6PuZmk2vgepiMJ4cKESmGNpfbTZgYvgcHe3ipBIRQNZrj1N
         7Ave67b6pnm7L3VNmFG1R/vna4n64CFSSmSujJZp1yiUnGRd+vAMBYv4dxQESWS7wuZN
         w1HiE8IrhtL3fiYKOZRU+IMs119OfRiDYRazslHF//TcXz9UJrDe7oQNFrwEdXtP7mZ1
         0XlXMUZbXJfrp5+EXj17WILNT7fcSF3z+8ay00aQBD955L6kCAlm7Ffrj3G7rqLakc1z
         APNw==
X-Gm-Message-State: AGi0PuaWsFFp0qTrutOsXBFpe1TEo0LA8rFRoL7IU6+bbUJYyEWlHdZw
        wQh6ONcRIkNvbIJh2IxAAWV7zEd/vJWGoBAWGaumVk+Lezpsf952sOJJcUYOhxjWeOs93sbx7HH
        vjOsM3hLu+CqcaQzYy1+AcXiSNCJn+H2NKxlykMk2/g==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr26137225plo.286.1587561665310;
        Wed, 22 Apr 2020 06:21:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfA2O6VBk6BTeueKPVTORTPr78NbnZL7Zb6Nrl273jlScDPEo8rwuxAVxViRLC6q6jC2RXNA==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr26137195plo.286.1587561664959;
        Wed, 22 Apr 2020 06:21:04 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w66sm5456578pfw.50.2020.04.22.06.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 06:21:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] xhci: Set port link to RxDetect if port is not enabled
 after resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <B4E44BDC-5AFE-4F8A-8498-0EEE9CDAC0E1@canonical.com>
Date:   Wed, 22 Apr 2020 21:21:01 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <635B3350-F064-4B45-B194-40F793423049@canonical.com>
References: <20200311040456.25851-1-kai.heng.feng@canonical.com>
 <B4E44BDC-5AFE-4F8A-8498-0EEE9CDAC0E1@canonical.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2020, at 19:33, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi Mathias,
> 
>> On Mar 11, 2020, at 12:04, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
>> then connects to ASMedia xHCI's root hub:
>> 
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>>   |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>           |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>> 
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
>> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
>> 
>> The port is disabled after resume:
>> xhci_hcd 0000:3f:00.0: Get port status 4-1 read: 0x280, return 0x280
>> 
>> According to xHCI 4.19.1.2.1, we should set link to RxDetect to transit
>> it from disabled state to disconnected state, which allows the port to
>> be set to U0 and completes the resume process.
>> 
>> My own test shows port can still resume when it's not enabled, as long
>> as its link is in U states. So constrain the new logic only when link is
>> not in any U state.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Do you think this is a proper fix?

Another gentle ping...

> 
> Kai-Heng
> 
>> ---
>> drivers/usb/host/xhci-hub.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index a9c87eb8951e..263f9a9237a1 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -1776,6 +1776,14 @@ int xhci_bus_resume(struct usb_hcd *hcd)
>> 			clear_bit(port_index, &bus_state->bus_suspended);
>> 			continue;
>> 		}
>> +
>> +		/* 4.19.1.2.1 */
>> +		if (!(portsc & PORT_PE) && (portsc & PORT_PLS_MASK) > XDEV_U3) {
>> +			portsc = xhci_port_state_to_neutral(portsc);
>> +			portsc &= ~PORT_PLS_MASK;
>> +			portsc |= PORT_LINK_STROBE | XDEV_RXDETECT;
>> +		}
>> +
>> 		/* resume if we suspended the link, and it is still suspended */
>> 		if (test_bit(port_index, &bus_state->bus_suspended))
>> 			switch (portsc & PORT_PLS_MASK) {
>> -- 
>> 2.17.1
>> 
> 

