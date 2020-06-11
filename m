Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E48C2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgFKHlp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:41:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgFKHlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:41:45 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jjHqI-0007l7-Fn
        for linux-kernel@vger.kernel.org; Thu, 11 Jun 2020 07:41:42 +0000
Received: by mail-pj1-f71.google.com with SMTP id cq18so3645513pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6D0vKGSY/N7oIxUPHQyoMhvqF95dT5zEOAoFd29m+A0=;
        b=rbP7QY1ls0KbMcxmbnL+rAD+wLoN28svsuJe5sR3IYVnySdEucDxMR7vCmCJJtZagy
         ylqqa22dOv3oPVBn2Cdiz4/UdpUVCkNX5aaHgqCmvPyybVrWf046MK6/k/thjCiWZa3Q
         UxXlUfsimkyQ5+ACk8F5LPWdoOHRQ733LNRtFboY++SQaLhZE8w8jh/bef/jj35pSJTW
         4/HnXymcTE5MLUcgcYR1+HFIPsE9xWTFzU5nti5aOQy9KNgLAkcadOF3zF25QROg8mYo
         HfjeY1tawBPQu1AsoZKdfVl8x49Uf0xinBdiRTGqqF1Cfwfb0faPLLqghVA9wDgHwHQn
         KNNw==
X-Gm-Message-State: AOAM5308AMDfXx6skHU/tslEEPTr8pevkcm1ASgxdo1u0BiGbtHIewJN
        IVp8YrXUoa09dlKYyOcJAkf+eMDvV4RkmEpBVBqzZiHyc1NpGlFMhLVxSkApn5EBI7EXPpVjyTw
        +UWTMIx2xcpKHCDUaQ9lwdKN7gsBfdtYcnUjNTk6N0w==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr5607987pgs.91.1591861301083;
        Thu, 11 Jun 2020 00:41:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfecsDSsRnjakGhEFhDzibSywqp2cwGjA93pZwZxkEHx2CQMcEXcMiVyjFjt6Mb1TP60VRRA==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr5607966pgs.91.1591861300687;
        Thu, 11 Jun 2020 00:41:40 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id gp4sm1777950pjb.26.2020.06.11.00.41.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 00:41:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] xhci: Suspend ports to U3 directly from U1 or U2
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <9d7842de-9813-becd-80a0-a422e59c1e94@linux.intel.com>
Date:   Thu, 11 Jun 2020 15:41:37 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <91BDD35C-6144-4761-AA4F-1F4D1A9E36F1@canonical.com>
References: <20200610064231.9454-1-kai.heng.feng@canonical.com>
 <20200610143220.GC11727@rowland.harvard.edu>
 <591D2A1F-9645-4B0B-896C-99544F06DFAA@canonical.com>
 <9d7842de-9813-becd-80a0-a422e59c1e94@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 10, 2020, at 23:58, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> 
> On 10.6.2020 18.43, Kai-Heng Feng wrote:
>> 
>> 
>>> On Jun 10, 2020, at 22:32, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> 
>>> On Wed, Jun 10, 2020 at 02:42:30PM +0800, Kai-Heng Feng wrote:
>>>> xHCI spec "4.15.1 Port Suspend" states that port can be put to U3 as long
>>>> as Enabled bit is set and from U0, U1 or U2 state.
>>>> 
>>>> Currently only USB_PORT_FEAT_LINK_STATE puts port to U3 directly, let's
>>>> do the same for USB_PORT_FEAT_SUSPEND and bus suspend case.
>>>> 
>>>> This is particularly useful for USB2 devices, which may take a very long
>>>> time to switch USB2 LPM on and off.
>>> 
>>> Have these two patches been tested with a variety of USB-2.0 and USB-2.1 
>>> devices?
>> 
>> I tested some laptops around and they work fine.
>> Only internally connected USB devices like USB Bluetooth and USB Camera have USB2 LPM enabled, so this patch won't affect external connected devices.
>> 
> 
> Took a fresh look at the USB2 side and it's not as clear as the USB3 case, where
> we know the hub must support transition to U3 from any other state. [1]
> 
> Supporting link state transition to U3 (USB2 L2) from any other U state for USB2 seems
> to be xHCI specific feature. xHC hardware will make sure it goes via the U0 state.
> 
> I have no clue about other hosts (or hubs), USB2 LPM ECN just shows that link
> state transitions to L1 or L2 should always goes via L0.
> It's possible this has to be done in software by disabling USB2 LPM before suspending the device.

Is there any host or hub other than xHCI support USB2 LPM? Seem like only xHCI implements it.

> 
> So I guess the original suggestion to wait for link state to reach U0 before
> is a better solution. Sorry about my hasty suggestion.
> 
> Kai-Heng, does it help if you fist manually set the link to U0 before disabling
> USB2 LPM (set PLS to 0 before clearing the HLE bit). Does it transition to U0
> any faster, or get rid of the extra port event with PLC:U0?

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 03b64b73eb99..0b8db13e79e4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4385,7 +4385,7 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
        struct xhci_hcd *xhci = hcd_to_xhci(hcd);
        struct xhci_port **ports;
        __le32 __iomem  *pm_addr, *hlpm_addr;
-       u32             pm_val, hlpm_val, field;
+       u32             portsc, pm_val, hlpm_val, field;
        unsigned int    port_num;
        unsigned long   flags;
        int             hird, exit_latency;
@@ -4463,6 +4463,15 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
                /* flush write */
                readl(pm_addr);
        } else {
+               portsc = readl(ports[port_num]->addr);
+               if ((portsc & PORT_PE) && ((portsc & PORT_PLS_MASK) == XDEV_U1 ||
+                                       (portsc & PORT_PLS_MASK) == XDEV_U2)) {
+                       xhci_set_link_state(xhci, ports[port_num], XDEV_U0);
+                       spin_unlock_irqrestore(&xhci->lock, flags);
+                       dev_info(&udev->dev, "DEBUG: SLEEP\n");
+                       msleep(100);
+                       spin_lock_irqsave(&xhci->lock, flags);
+               }
                pm_val &= ~(PORT_HLE | PORT_RWE | PORT_HIRD_MASK | PORT_L1DS_MASK);
                writel(pm_val, pm_addr);
                /* flush write */

If there's a long enough delay for U0 before clearing HLE, then the PLC can be avoided.
It's not any faster though.

Kai-Heng

> 
> -Mathias
> 
> 
> [1]
>    USB3.1 spec (10.16.2.10) Set Port feature:   
>   "If the value is 3, then host software wants to selectively suspend the
>    device connected to this port. The hub shall transition the link to U3
>    from any of the other U states using allowed link state transitions.
>    If the port is not already in the U0 state, then it shall transition the
>    port to the U0 state and then initiate the transition to U3.

