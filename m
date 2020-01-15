Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7278C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F472187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAOGkL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:40:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49548 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:40:11 -0500
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ircLZ-00029H-Ck
        for linux-kernel@vger.kernel.org; Wed, 15 Jan 2020 06:40:09 +0000
Received: by mail-pf1-f200.google.com with SMTP id v14so10342429pfm.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ks+FKtYdipfmIovpRk0e6E//v9CS+XKOemaSP1iQ0A8=;
        b=oLRWyTYKqcaJTvPd+o0jwNAuPIfotznoJdsCIkK2QSSb0y6E2grvGNRJpszgTMGSnM
         OwmFyAzFh6AfYOSmhMY2gPLea89Q0eWYvPTC2WkMZwf3ZAdBkOOsfDvFBFLu9LUL2Ua9
         tGr0SoowURxrjMxIS83Bq9M2H3VfJhiF+U9wnVAx4VU5ybY4ZCzuDlFNO23ab6gJzrT5
         JRhaGblEHcfzuzwOiRDOlsbTKvDmEJ1yVIrhJUiDK2AXI/263h/Utzgb9aDKQAH2V5oB
         QJd7VJ9AN7Pm7L2H7zCOeZDnDoP60aV/Mv3MS0zYKTAsdC+OomTHcMIJcr+qlUaXoDXu
         8acw==
X-Gm-Message-State: APjAAAWHT09h9x7HRCFIi66oEEr1kRI2nLJmTnjTTCFLyKsp46dVrG3e
        lJObTyGtkODaHODF4UdgLKSM+gWo9hEL5IebTJm48kH0YAiUo2nq+BPcu6zLlkT/3CdnJawxNQ5
        Tp2lktMcFGL5aCl5MYqNBV03WyJsNwbklOuHpzoucOw==
X-Received: by 2002:a63:d141:: with SMTP id c1mr26072645pgj.397.1579070407858;
        Tue, 14 Jan 2020 22:40:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCAlUxgFq4p9aUmqfpZAip45/nK5+OQYN5+5gQPity3Khdrn/uFB+ajTrWkrsHEqOLOxPIzg==
X-Received: by 2002:a63:d141:: with SMTP id c1mr26072612pgj.397.1579070407423;
        Tue, 14 Jan 2020 22:40:07 -0800 (PST)
Received: from [10.101.46.91] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id l14sm17861129pgt.42.2020.01.14.22.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 22:40:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] r8152: Add MAC passthrough support to new device
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <d8af34dbf4994b7b8b0bf48e81084dd0@AUSX13MPC101.AMER.DELL.COM>
Date:   Wed, 15 Jan 2020 14:40:03 +0800
Cc:     David Miller <davem@davemloft.net>, hayeswang@realtek.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        pmalani@chromium.org, grundler@chromium.org,
        "<David.Chen7@dell.com>" <David.Chen7@Dell.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <430A264A-27E0-489D-B7B1-8E78AAD528D7@canonical.com>
References: <20200114044127.20085-1-kai.heng.feng@canonical.com>
 <d8af34dbf4994b7b8b0bf48e81084dd0@AUSX13MPC101.AMER.DELL.COM>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 4:33 AM, Mario.Limonciello@dell.com wrote:
> 
> 
> 
>> -----Original Message-----
>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Sent: Monday, January 13, 2020 10:41 PM
>> To: davem@davemloft.net; hayeswang@realtek.com
>> Cc: Kai-Heng Feng; Jakub Kicinski; Prashant Malani; Grant Grundler; Limonciello,
>> Mario; Chen7, David; open list:USB NETWORKING DRIVERS; open list:NETWORKING
>> DRIVERS; open list
>> Subject: [PATCH] r8152: Add MAC passthrough support to new device
>> 
>> 
>> [EXTERNAL EMAIL]
>> 
>> Device 0xa387 also supports MAC passthrough, therefore add it to the
>> whitelst.
> 
> Have you confirmed whether this product ID is unique to the products that
> support this feature or if it's also re-used in other products?

This is unique for Lenovo product.

> 
> For Dell's devices there are very specific tests that make sure that this
> feature only applies on the products it is supposed to and nothing else
> (For example RTL8153-AD checks variant as well as effuse value)
> (Example two: RTL8153-BND is a Dell only part).

Hayes, do you know how macpassthru on Lenovo dock works?

Kai-Heng

> 
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1827961/comments/30
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/usb/r8152.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index c5ebf35d2488..42dcf1442cc0 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -6657,7 +6657,8 @@ static int rtl8152_probe(struct usb_interface *intf,
>> 	}
>> 
>> 	if (le16_to_cpu(udev->descriptor.idVendor) == VENDOR_ID_LENOVO &&
>> -	    le16_to_cpu(udev->descriptor.idProduct) == 0x3082)
>> +	    (le16_to_cpu(udev->descriptor.idProduct) == 0x3082 ||
>> +	     le16_to_cpu(udev->descriptor.idProduct) == 0xa387))
>> 		set_bit(LENOVO_MACPASSTHRU, &tp->flags);
>> 
>> 	if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x3011 && udev->serial
>> &&
>> --
>> 2.17.1
> 

