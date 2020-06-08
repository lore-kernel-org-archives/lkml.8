Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C561C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B52076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFHD6F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:58:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgFHD6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:58:04 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ji8vC-00026m-OU
        for linux-kernel@vger.kernel.org; Mon, 08 Jun 2020 03:58:02 +0000
Received: by mail-pl1-f197.google.com with SMTP id y10so11429191pll.16
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 20:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kiKeONk+XKAoJnjoYfDC/7s0+/Uf2k9m+TjoRzs9nGY=;
        b=cZS0AoAF1Zo6WuZ7NyxtrFAtGPLP5LpSkbFOoER8XSRp8XMC3ZZ5/u9PfceJSAsvCR
         sHEYtW78Dnrzz05xsQdUb9oKxiXxU9LAn1xF5Lctk/1ItD0LWmccRHtehcTZIssaZFHt
         ByG83GF9fMYp+LKtBCkXYukM0Q7pJWebHJJostiejcYSWctfaZQ/noA1oS06Dm3g4Nio
         DKVXq9pTco150JJ4xXVLoakCqcfB69Ujsp0v7NUL9fazBfnBTV9ONuQvqRa/eLQx/acX
         r9p+KMA4EaaZIiCkcPaaB2DiXQPRi9w109U0rwmHo48eBxl4+e0C04E5eSBdZsNtnagO
         l8oA==
X-Gm-Message-State: AOAM531c9z+pEKInGkK5BwGcofKH9sl3kEN1QpXfckeOMqAvV9+c+ZGs
        jl+vwHZHc6q8v9bLSuNskyJ1k/CUwRjGqQwJthyXAIunj5Otg3ZsC3Ov1GGq0fosXGnfHLMlNWE
        w8z075qHpgfv7FE7kvysHNFn/T+pXntjoN2dvxZ0WZw==
X-Received: by 2002:a63:1323:: with SMTP id i35mr19099545pgl.311.1591588681054;
        Sun, 07 Jun 2020 20:58:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYLhjxqcqk7bf6M5WtwXiaQKO3W3BBSLZ6hH23cBvCmm/hUgJ5I2jXj6lYXtQ8XakOK2Cgag==
X-Received: by 2002:a63:1323:: with SMTP id i35mr19099534pgl.311.1591588680674;
        Sun, 07 Jun 2020 20:58:00 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mw5sm15018161pjb.27.2020.06.07.20.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 20:58:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] xhci: Make debug message consistent with bus and port
 number
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <938b0ce5-cb56-a356-dec8-3a6adc502752@linux.intel.com>
Date:   Mon, 8 Jun 2020 11:57:57 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mathias.nyman@intel.com,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E6AD21DC-A086-44B9-98F5-7FB320E9B457@canonical.com>
References: <20200507061755.13280-1-kai.heng.feng@canonical.com>
 <20200507064510.GA787064@kroah.com>
 <C4A734C8-D1C6-45BC-9C0A-92364EAEE3C0@canonical.com>
 <20200507073119.GA876666@kroah.com>
 <90D5B23E-B037-49D2-BD44-7F9B0B2FC155@canonical.com>
 <20200507082149.GE1024567@kroah.com>
 <938b0ce5-cb56-a356-dec8-3a6adc502752@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2020, at 18:35, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> 
> On 7.5.2020 11.21, Greg Kroah-Hartman wrote:
>> On Thu, May 07, 2020 at 03:58:36PM +0800, Kai-Heng Feng wrote:
>>> 
>>> 
>>>> On May 7, 2020, at 15:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>> 
>>>> On Thu, May 07, 2020 at 03:15:01PM +0800, Kai-Heng Feng wrote:
>>>>> 
>>>>> 
>>>>>> On May 7, 2020, at 14:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>>>> 
>>>>>> On Thu, May 07, 2020 at 02:17:55PM +0800, Kai-Heng Feng wrote:
>>>>>>> Current xhci debug message doesn't always output bus number, so it's
>>>>>>> hard to figure out it's from USB2 or USB3 root hub.
>>>>>>> 
>>>>>>> In addition to that, some port numbers are offset to 0 and others are
>>>>>>> offset to 1. Use the latter to match the USB core.
>>>>>>> 
>>>>>>> So use "bus number - port index + 1" to make debug message consistent.
>>>>>>> 
>>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>> ---
>>>>>>> drivers/usb/host/xhci-hub.c | 41 +++++++++++++++++++++----------------
>>>>>>> 1 file changed, 23 insertions(+), 18 deletions(-)
>>>>>>> 
>>>>>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>>>>>> index f37316d2c8fa..83088c262cc4 100644
>>>>>>> --- a/drivers/usb/host/xhci-hub.c
>>>>>>> +++ b/drivers/usb/host/xhci-hub.c
>>>>>>> @@ -1241,7 +1241,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>>>>>> 			temp = readl(ports[wIndex]->addr);
>>>>>>> 			/* Disable port */
>>>>>>> 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
>>>>>>> -				xhci_dbg(xhci, "Disable port %d\n", wIndex);
>>>>>>> +				xhci_dbg(xhci, "Disable port %d-%d\n",
>>>>>>> +					 hcd->self.busnum, wIndex + 1);
>>>>>> 
>>>>>> Shouldn't xhci_dbg() show the bus number already?  
>>>>> 
>>>>> It's the PCI bus number, different to USB2/USB3 root hub bus number...
>>>> 
>>>> But if this is using dev_dbg(), and it is, then you know how to look
>>>> that up by seeing where that device is in sysfs at that point in time.
>>>> 
>>>> So why add this again?
>>> 
>>> xHCI has two HCD, one for USB2 and one for USB3.
>>> If both of their port with same number are in use, for instance, port 1, then they are port 1-1 and port 2-1.
>>> Right now the debug message only show "Port 1", we still can't find the corresponding port via sysfs with insufficient info.
>> 
>> Look at the full kernel log line, the xhci hcd device should be showing
>> you unique information.  If not, something else is wrong.
>> 
> 
> What Kai-Heng suggest here makes sense, and is useful.
> We use similar style debugging in other places, and it is helpful as it matches
> usb core debugging style.
> 
> This might seem odd but reason is that the xHC controller is one device which
> doesn't really separate USB2 and USB3.
> All ports are for example in one long array.
> 
> On the xhci driver side things look very different. We register two HCD's,
> one for usb 2 and one for USB 3. In many cases the debugging is not tied to a HCD
> in any way,  (starting, stopping controller, command completion interrupts etc),
> other cases the debugging is very much tied to a specific hcd,
> for example when we are handling a port requsts for the roothub.

A gentle ping...

> 
> Thanks
> -Mathias

