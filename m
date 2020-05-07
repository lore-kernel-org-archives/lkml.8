Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55745C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401C6208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGEwg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 00:52:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgEGEwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:52:35 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jWYWP-0000T6-BD
        for linux-kernel@vger.kernel.org; Thu, 07 May 2020 04:52:33 +0000
Received: by mail-pl1-f199.google.com with SMTP id k23so4143233pll.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 21:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w4FDbx+sqaj7/I18BPPgkxjRI2IWGp9DxRd9OXfc4I8=;
        b=sgrRqdiD+2VUZ1HBk9dx3cRXdUMuOISmE8+D0bDYcwEa+qpAQipb7qFl21T59st9CA
         lvS0ZTF8QV3bTPfYCs1RqHwSS2VH/LU2URxB++WIhZHPYmoDsJbKzOm3B7791Gk/SNt7
         d9vTkfEnPmoAu3hrCzTBpE+chuM0mAhIsCKk9zgP9TcVmcWWWd0t+/dy/57QVatVwJ1i
         9Cv7q7q5pcu3HIpONXWCrujzBMYRMCkZSyaniSbtiaHIgZ/CCtyhQ9BYA9UjHZLR9AXi
         /r8X7rZeEB/67spuIulIWO5I7Os2YJxnErs8NlHXL0KKkiSrHxaOLCkGY+yzIxko2wE+
         Lfuw==
X-Gm-Message-State: AGi0PuZyoYKjZo3uqLbt9KXzv1xhnWUu/EE2eF7xFIsBrmikeOFgt5Lp
        9dwMkWHaoj3PMcWA9XxOXpgKOMMj4ICBorcbyuNyg4UylM9JSWppJbUUWVQGhFJFxEvX6wRpf+B
        6zSJUbG43hYAR1RMIOQazd5EetL+0YFvX27BpUB/lqA==
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr11737736pll.147.1588827151903;
        Wed, 06 May 2020 21:52:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKd1OFSTF85NtleoC+pgFpSup5vc27PkUDpOeKCJJnN6mB3hBbdRvincDHIf2zmxpakc3zpnw==
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr11737714pll.147.1588827151405;
        Wed, 06 May 2020 21:52:31 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w13sm3396670pfn.192.2020.05.06.21.52.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 21:52:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] xhci: Set port link to RxDetect if port is not enabled
 after resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <a4311a60-ad12-e9a8-d391-f34832f65ef5@linux.intel.com>
Date:   Thu, 7 May 2020 12:52:28 +0800
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <79060777-FF5B-4394-9A05-8573B6EF6578@canonical.com>
References: <20200311040456.25851-1-kai.heng.feng@canonical.com>
 <B4E44BDC-5AFE-4F8A-8498-0EEE9CDAC0E1@canonical.com>
 <635B3350-F064-4B45-B194-40F793423049@canonical.com>
 <35fbb517-31b1-7bba-8e07-795ab18af1ff@linux.intel.com>
 <47BCEDDA-2E91-4CE3-AA45-B2EEB1DA111D@canonical.com>
 <a4311a60-ad12-e9a8-d391-f34832f65ef5@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2020, at 00:49, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> 
> On 27.4.2020 12.05, Kai-Heng Feng wrote:
>> 
>> 
>>> On Apr 23, 2020, at 19:25, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
>>> 
>>> Was this roothub port forcefully suspended xhci_bus_suspend()?
>>> i.e. was a bit set in bus_state->bus_suspended for this port?
>> 
>> No, it's a USB3 device so it was set to U3 via USB_PORT_FEAT_LINK_STATE.
> 
> Logs show port was first forced by xhci_bus_suspend() to U3  ("port 0 not
> suspended" message)
> and only later set to U3 by USB_PORT_FEAT_LINK_STATE.
> Seems line wrong order or race.

The "port 0 not suspended" is actually for 3-1, if we print bus num and port + 1:
[  213.732977] xhci_hcd 0000:3f:00.0: port 3-1 not suspended

For port 4-1 it's always suspended before suspend the bus.
I'll send a patch to adjust the debug message for better clarity.

> 
> while suspended we get a port event about a connect status change,
> showing port link state is in disabled.
> Cherry picked messages:
> 
> [ 1330.021450] xhci_hcd 0000:3f:00.0: port 0 not suspended
> [ 1330.036822] xhci_hcd 0000:3f:00.0: Set port 4-1 link state, portsc: 0x1203, write 0x11261
> [ 1331.020736] xhci_hcd 0000:3f:00.0: Port change event, 4-1, id 1, portsc: 0x20280
> [ 1331.020738] xhci_hcd 0000:3f:00.0: resume root hub
> [ 1331.020741] xhci_hcd 0000:3f:00.0: handle_port_status: starting port polling.
> 
> If we force the port link state to U3 in xhci_bus_suspend() maybe it would make
> sense to try and recover it in xhci_bus_resume(). But only for that forced
> port.
> 
> None of the previous suspend/resume cycles in the logs went smooth either.
> Each time device 4-1 was forced to U3 bus xhci_bus_suspend(), and at resume the
> link was stuck in polling until timeout, after which it went to compliance mode,
> and had to be warm reset to recover.

If my observation above is true, port 4-1 is indeed suspended by usb_port_suspend() rather than xhci_bus_suspend().

> 
> We could add the code to recover USB3 ports from disabled state in case we
> forced them to U3, but the rootcause of theus suspend/resume issues should
> be found as well

Seems like the issue doesn't happen if the host system use S2Idle instead of S3.
However, I can't see any difference in xHCI driver with different suspend methods.
Maybe the root cause is that, ASMedia controller and SMSC hub are just quirky?

> 
> Limiting your code to USB3 devices that xhi_bus_suspend forced to U3 would look
> something like this:
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 9eca1fe81061..0f16dd936ab8 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1789,6 +1789,15 @@ int xhci_bus_resume(struct usb_hcd *hcd)
> 			case XDEV_RESUME:
> 				/* resume already initiated */
> 				break;
> +			case XDEV_DISABLED:
> +				if (hcd->speed >= HCD_USB3) {
> +					portsc = xhci_port_state_to_neutral(
> +						portsc);
> +					portsc &= ~PORT_PLS_MASK;
> +					portsc |= PORT_LINK_STROBE |
> +						XDEV_RXDETECT;
> +				}
> +				/* fall through for both USB3 abd USB2 */
> 			default:
> 				/* not in a resumeable state, ignore it */
> 				clear_bit(port_index,

This doesn't work because port 4-1 isn't suspended by xhci_bus_suspend().

Maybe we can restrict the case to ports that are suspended by USB_PORT_FEAT_LINK_STATE.
Is the following patch looks good to you?

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f37316d2c8fa..dc2e14ea308d 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1787,6 +1787,16 @@ int xhci_bus_resume(struct usb_hcd *hcd)
                        clear_bit(port_index, &bus_state->bus_suspended);
                        continue;
                }
+
+               if (bus_state->suspended_ports & (1 << port_index)) {
+                       if ((portsc & PORT_PLS_MASK) == XDEV_DISABLED &&
+                           hcd->speed >= HCD_USB3) {
+                               portsc = xhci_port_state_to_neutral(portsc);
+                               portsc &= ~PORT_PLS_MASK;
+                               portsc |= PORT_LINK_STROBE | XDEV_RXDETECT;
+                       }
+               }
+
                /* resume if we suspended the link, and it is still suspended */
                if (test_bit(port_index, &bus_state->bus_suspended))
                        switch (portsc & PORT_PLS_MASK) {


Kai-Heng

> 
> -Mathias

