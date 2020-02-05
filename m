Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49528C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293F5217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBELmP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:42:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBELmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:42:13 -0500
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1izIno-0003RY-Qg
        for linux-kernel@vger.kernel.org; Wed, 05 Feb 2020 11:25:05 +0000
Received: by mail-pj1-f70.google.com with SMTP id hi12so1117418pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6zUnAJw/Y6vVvW2xmbH05AyrYz3QZAGIOapSC7+i3Mc=;
        b=q/374D7ERbdRt0c5YEsGJaDXkn0yXyNfoXBVVni95Dy8UjJ9N5QIDKWp3z3dKuMa7F
         QvyFbBbRJ6KyicbCxTYuKbHIRJtH8QGMFWrIEFuI8SG/8UHPkpuRowmON8DZhZNQR3tT
         o8rkXn4EXqEgeGNvfk7K5bQPYa102HIzWpWlze1FIf5+tKXmn7WFZVu4AYIKgH8obkEh
         ardzBFkFLMYscbZe5fxlD5154Jo0gHlUbrhSxVWRw0RY4cj5+E1gQ/GxaEvT5HnZpe1c
         onU+8lgNilD8MenCZansFMVwE0t3Iqj3TMEAwEfqDDIWcq4pi+NXQhf1C1+xMXc95+Bi
         wI4w==
X-Gm-Message-State: APjAAAVf79Aen8N+wqgg4yC7A2fRidfVbP/wa+29c/SzfN4/eXRhM/m6
        xkxAS0zVMaTM2InK75kukmgYjVPBOxwuAfqDS6FO6ljtaByIymmSWqwp2/YKLejcV8I+NGyVYcW
        zQdarVpf746it2DL04PIj0v4GtzfxH9t2WynPySZOsw==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr5081661pjx.54.1580901903209;
        Wed, 05 Feb 2020 03:25:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzs8jEUWVsPGPIqrQGiyIxOU5NsCKAV2kLJxc/sS5hZH+c4Gr+g9ys+WG+0DEuEOGh1dzscQg==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr5081630pjx.54.1580901902766;
        Wed, 05 Feb 2020 03:25:02 -0800 (PST)
Received: from 2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net (2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:4cfd:361b:ac7d:6a8c])
        by smtp.gmail.com with ESMTPSA id u12sm27695654pfm.165.2020.02.05.03.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 03:25:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2 1/3] xhci: Ensure link state is U3 after setting
 USB_SS_PORT_LS_U3
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200205112228.25155-1-kai.heng.feng@canonical.com>
Date:   Wed, 5 Feb 2020 19:24:59 +0800
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <08A214EC-F78D-41E1-B080-2A03782E41C1@canonical.com>
References: <20200205112228.25155-1-kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 5, 2020, at 19:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> The xHCI spec doesn't specify the upper bound of U3 transition time. For
> some devices 20ms is not enough, so we need to make sure the link state
> is in U3 before further actions.
> 
> I've tried to use U3 Entry Capability by setting U3 Entry Enable in
> config register, however the port change event for U3 transition
> interrupts the system suspend process.
> 
> For now let's use the less ideal method by polling PLS.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please ignore this series. Some patches are missing changelog, will resend one.

Kai-Heng

> ---
> v2:
> - Remove some redundant debug messages.
> - Use msleep loop outside if spinlock to stop pegging CPU.
> 
> drivers/usb/host/xhci-hub.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 7a3a29e5e9d2..d3c5bcf76755 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1313,7 +1313,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> 			xhci_set_link_state(xhci, ports[wIndex], link_state);
> 
> 			spin_unlock_irqrestore(&xhci->lock, flags);
> -			msleep(20); /* wait device to enter */
> +			if (link_state == USB_SS_PORT_LS_U3) {
> +				int retries = 10;
> +
> +				while (retries--) {
> +					msleep(10); /* wait device to enter */
> +					temp = readl(ports[wIndex]->addr);
> +					if ((temp & PORT_PLS_MASK) == XDEV_U3)
> +						break;
> +				}
> +			}
> 			spin_lock_irqsave(&xhci->lock, flags);
> 
> 			temp = readl(ports[wIndex]->addr);
> -- 
> 2.17.1
> 

