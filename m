Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE37AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1242073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCFIi4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:38:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46607 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:38:56 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jA8VR-0002Ab-Fg
        for linux-kernel@vger.kernel.org; Fri, 06 Mar 2020 08:38:53 +0000
Received: by mail-pl1-f200.google.com with SMTP id b10so1049416pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ex8IIRiePP84oKL/gqanENhA2v8Yo70JDYAq5VI/5vc=;
        b=DXQtI5CUJtUpd85YvoRf4tcV8eRaxQd2LatN1y948w9kx9N25bU3aPrZ/p+l1zmPin
         GLn40JAviQdMy8OwKB7O+72NzG3VcdcbnWmLfKOeyBRbVYqcTfTnxxfNIxr+yIugvV1j
         ezaHdwdRvvkZanE8Be3fOs3pTHkA8sNVMYCXyz7qGa4YTbNrT1119Tx1zX/6dY/XLMaU
         BnHCYWhusYBF/+3RXywqDNwJ8i9LvOrWiXINn8JUk6JHvSpW4scmmgt63bbjJA8pJqvL
         /zuC+XXVXfoDKMEMQtWu8CLlag5Gl4HWVIyj4nTH8d3vUBSEeiiYDx0cNLXHeMLhfg+l
         XZTQ==
X-Gm-Message-State: ANhLgQ3FsBr1BhZfrcWEPRG6wQUvClwiMhrJnsA23oxf9Tg3mQL5vb6t
        HHA3NflEorlru/OI5JA3nSZoMa49b3SQmyhkQIYxtnLAO/EAaCpIHkofLmlxonD8wimAMc9iZwP
        T0Qf7Oa/jRlsD0ZPyMrdkqOBbN5qvYURUdVwjcDsXuQ==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr2490787pjb.194.1583483931713;
        Fri, 06 Mar 2020 00:38:51 -0800 (PST)
X-Google-Smtp-Source: ADFU+vspKcxSvdPYhawLt6BMbzG/cbc8AiNb25/tkDPDX9LvOo621FDVskkmVrPBxpMmYlx+UKAJlw==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr2490760pjb.194.1583483931244;
        Fri, 06 Mar 2020 00:38:51 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b71sm23302152pfb.156.2020.03.06.00.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 00:38:50 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] usb: core: Set port link to RxDetect if port is not
 enabled after resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.2003051357400.1298-100000@iolanthe.rowland.org>
Date:   Fri, 6 Mar 2020 16:38:47 +0800
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C747DCA1-B5B4-4AFC-B83C-791B3B860621@canonical.com>
References: <Pine.LNX.4.44L0.2003051357400.1298-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2020, at 03:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Thu, 5 Mar 2020, Kai-Heng Feng wrote:
> 
>> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
>> then connects to ASMedia xHCI's root hub:
>> 
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
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
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> 
>> P.S. This is and differnt (and should be more correct) approach to solve
>> https://lore.kernel.org/lkml/20191129174115.31683-1-kai.heng.feng@canonical.com/
>> 
>> drivers/usb/core/hub.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 54cd8ef795ec..352e33c84d6a 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -3537,12 +3537,24 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>> 
>> 	/* Skip the initial Clear-Suspend step for a remote wakeup */
>> 	status = hub_port_status(hub, port1, &portstatus, &portchange);
>> -	if (status == 0 && !port_is_suspended(hub, portstatus)) {
>> +	if (status == 0 && !port_is_suspended(hub, portstatus)
>> +	    && (portstatus & USB_PORT_STAT_ENABLE)) {
> 
> This doesn't look right.  We want to skip the step the clears the
> port's suspend feature whenever the feature is already clear,
> regardless of whether the port is enabled.
> 
> Besides, isn't this new test racy?  Suppose the port was enabled when
> we called hub_port_status above, but it got disabled in the nanoseconds
> since then?
> 
>> 		if (portchange & USB_PORT_STAT_C_SUSPEND)
>> 			pm_wakeup_event(&udev->dev, 0);
>> 		goto SuspendCleared;
>> 	}
>> 
>> +	/* xHCI 4.19.1.2.1 */
>> +	if (hub_is_superspeed(hub->hdev)) {
>> +		if (!(portstatus & USB_PORT_STAT_ENABLE))
>> +			status = hub_set_port_link_state(hub, port1,
>> +							 USB_SS_PORT_LS_RX_DETECT);
>> +
>> +		if (status)
>> +			dev_dbg(&port_dev->dev,
>> +				"can't set to RxDetect, status %d\n", status);
>> +	}
>> +
> 
> So maybe this part belongs later in the routine.  Or maybe it shouldn't
> be in the hub driver at all -- since it is xHCI-specific, shouldn't it
> go into the xhci-hcd driver?

Ok, I'll put this change into xhci instead. It should also avoid the race
you mentioned above.

Kai-Heng

> 
> Alan Stern
> 
>> 	/* see 7.1.7.7; affects power usage, but not budgeting */
>> 	if (hub_is_superspeed(hub->hdev))
>> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);

