Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9362070A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=domanski-co.20150623.gappssmtp.com header.i=@domanski-co.20150623.gappssmtp.com header.b="JaKv+viK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEQQXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgEQQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:23:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15809C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 09:23:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so5887021lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=domanski-co.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=btWWwzUkmWfIqojN7lVwmZj6smUFBDhMFndNTsnsDJs=;
        b=JaKv+viKPGjbBSD4fXaef+tk/4c71tDKhXv7Sk4pfWez1qcxR61DVFqjydLECSv08K
         uyGdaiQLx78GeOT2F+jp40qgA5DUU2HeWbLSRv3PQp9x3fPFlU6RXfGFCIAxCOu4u2xM
         otVCiIw4tnYxaBeLN1xUZbbJ6R8jlzeNFxwjo3ns4SzyZnLD9DBJSJ4kSIxUFKZ1AAYF
         uAThLlE1p8mnIrv3m/STx4mqfNS/8TnpXAOO4HHlyGMB3QsJ3vfxIJsGLcQ+yBtB6yZX
         13N41j9SbrB1Ptt3hu2nRtwwIXWZpGlaq/quvf+gLLjqK4sPkpXB145g2jXzcSaftsdZ
         KumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=btWWwzUkmWfIqojN7lVwmZj6smUFBDhMFndNTsnsDJs=;
        b=nSynXT2DnvT0S+zSRcbLDlEVYbzRYWPTiLjr3bO/cpTNAnYK5Lq5GS/C+uENrgmdcJ
         BqDJ6g1Xl59THPhJyU2FNaIxFKzNiTdxt+DC8Oip+ByEYotVmjJVwVOlV0MN2vi8Nd82
         mSYD/81pAZvs4qmZMJje4+O3qkUDt+fCp3LqaupLU/shReECai0PD8XjOZb9bNJlIb1S
         FceoC5TQUKkHrUWneXelrx0laS/OvrJlW8+gHHhf/qJbqu5JmUT8efHdQnM4S6a8kvG5
         FMJuppMK+7efakGETbYXwVBaFxiAflKwuLZdmilDDHe4XUX++GnzuSFKz3GnbfV491no
         HoPQ==
X-Gm-Message-State: AOAM533nZqyMsezqLYFm8XZvFHogkwWZcZ05Zd0R7X67Ny+fJP9CuGnr
        tRaAXNBFTyfYa5eF+WWS/+D7qA==
X-Google-Smtp-Source: ABdhPJzKKuvOcMGbvaulHPQ6vG7CMWUphLKU4KM0hMj72iF65aVTjpL8TS2yuZg0jBN9VMBafjMNAQ==
X-Received: by 2002:a19:ad49:: with SMTP id s9mr9009240lfd.9.1589732582252;
        Sun, 17 May 2020 09:23:02 -0700 (PDT)
Received: from admiral ([2a04:4540:6b00:8200:6cf2:4a52:9753:d9b6])
        by smtp.gmail.com with ESMTPSA id q125sm4356342ljb.34.2020.05.17.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 09:23:01 -0700 (PDT)
Message-ID: <1224b05db4ff4b7288ee05ca8062af3bd574531d.camel@domanski.co>
Subject: Re: [PATCH] HID: logitech-hidpp: add support for Logitech G533
 headset
From:   Kamil =?UTF-8?Q?Doma=C5=84ski?= <kamil@domanski.co>
To:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Sun, 17 May 2020 18:23:14 +0200
In-Reply-To: <4ad2e18d37772bed00f1fd7c8a62ce4f98d69fe8.camel@archlinux.org>
References: <273f52604e8cb2eae1629ba7c55020227b36b1ba.camel@domanski.co>
         <4ad2e18d37772bed00f1fd7c8a62ce4f98d69fe8.camel@archlinux.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-17 at 16:52 +0100, Filipe Laíns wrote:
> On Sun, 2020-04-26 at 17:18 +0200, Kamil Domański wrote:
> 
> *snip*
> 
> > +/* -------------------------------------------------------------------------- */
> > +/* 0x1F20: Analog-digital converter measurement                               */
> > +/* -------------------------------------------------------------------------- */
> > +
> > +#define HIDPP_PAGE_ADC_MEASUREMENT 0x1F20
> > +
> > +#define CMD_ADC_MEASUREMENT_GET_VOLTAGE 0x01
> > +
> > +/**
> > + * hidpp20_adc_map_status_voltage() - convert HID++ code to power supply status
> > + * @hidpp: HID++ device struct.
> > + * @data: ADC report data.
> > + * @voltage: Pointer to variable where the ADC voltage shall be written.
> > + *
> > + * This function decodes the ADC voltage and charge status
> > + * of the device's battery.
> > + *
> > + * Return: Returns the power supply charge status code.
> > + */
> > +static int hidpp20_adc_map_status_voltage(struct hidpp_device *hidpp,
> > +						u8 data[3], int *voltage)
> > +{
> > +	bool isConnected;
> > +	bool isCharging;
> > +	bool chargingComplete;
> > +	bool chargingFault;
> 
> We use snake case.

Will fix, thanks.

> > +
> > +	long flags = (long) data[2];
> 
> Use u8 instead. Why are we even using a variable for this?

I is analogous to how it's done in existing code for feature 0x1001 (voltage).
Besides that IMHO it greatly improves readability and the asignment
will be optimized out anyways.

> > +
> > +	*voltage = get_unaligned_be16(data);
> > +	isConnected = test_bit(0, &flags);
> > +	isCharging = test_bit(1, &flags);
> > +	chargingComplete = test_bit(2, &flags);
> > +	chargingFault = test_bit(3, &flags);
> 
> I don't think this is needed, just do it in the ifs directly.

IMHO it improves readability.
The asignments will be optimized out anyways.

> Here I would add a #define for each bit:
> 
> #define FLAG_ADC_MAP_STATUS_CONNECTED 0
> ...
> if (data[2] & FLAG_ADC_MAP_STATUS_CONNECTED)

Again, I did it analogous to existing code. I'll be glad to change
it (and perhaps in the existing code as well) if the others concur.

> > +
> > +	if (!isConnected)
> > +		return POWER_SUPPLY_STATUS_UNKNOWN;
> > +
> > +	if (chargingFault)
> > +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> 
> From the spec:
> > Only valid if 'isCharging' is 1.
> > +
> > +	if (chargingComplete)
> > +		return POWER_SUPPLY_STATUS_FULL;
> 
> From the spec:
> > Only valid if 'isCharging' is 1.
> > +
> > +	if (isCharging)
> > +		return POWER_SUPPLY_STATUS_CHARGING;
> 
> Put the two previous checks inside this if.
> 
> > +	return POWER_SUPPLY_STATUS_DISCHARGING;
> > +}
> > 

Thanks for pointing it out. I'll fix it.

> > @@ -3994,6 +4189,8 @@ static const struct hid_device_id hidpp_devices[] = {
> >  
> >  	{ /* Logitech G403 Wireless Gaming Mouse over USB */
> >  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
> > +	{ /* Logitech G533 Wireless Headset over USB */
> > +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0A66) },
> 
> Is this a receiver? If so, we need to know if it is used by other
> devices. Or better, see if it supports the DJ protocol and add it to
> hid-logitech-dj instead.

I frankly don't think it supports anything else since it self-identifies
as "Logitech, Inc. [G533 Wireless Headset Dongle]" and it only returns
feature indexes for this one headset, whether it's paired or not.
It also registers a USB audio device immediately, even if the headset
is not connected.

Thanks for all the help.

Best regards,
Kamil Domański

