Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF3C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F9F20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io2c99vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgICKdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:33:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52707 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbgICKc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599129175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EBz+XNEZDprNAc71MY7Cc8HkN8faZ2EKOlhwmah+a0=;
        b=Io2c99vzF4YN54tuF9IZEV04DHs0VFpuvZM3VbHyyAv89ELKOCKDGB3s7sG0UiWE1/NKuw
        T+1TBNd3pRJUDVAuJfvAszLmt6AJDaRA7Ww8HMUHCpgdxKqgfB5DoYvvdPfCKAdgGUnM3f
        DfT4B8TYn5rFvhzMR4Do6oznOJdyGGQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-3PDtpEmrNjaHIKh7XHMXyQ-1; Thu, 03 Sep 2020 06:32:54 -0400
X-MC-Unique: 3PDtpEmrNjaHIKh7XHMXyQ-1
Received: by mail-ed1-f72.google.com with SMTP id bm14so1121033edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EBz+XNEZDprNAc71MY7Cc8HkN8faZ2EKOlhwmah+a0=;
        b=CjgiUaXc7KJPr8ytuDMc9yxRttnrfybm+wzYBftOS5RPsTK7mj6X+aaTy0ABNywV8C
         Lo4kK2YEvGM/hYzzEM+gEWzZnwtzozNPewDFqMB3hPWlXJN7v4tgK5z6/0ybzjR6Pa5i
         SgWRR13SL0Un0pvg9Cw76B4hFowOBd1KO+oYGum2BNFtfYL5Nwj9689NbwCpiLP0ufKw
         fpTb8u2Jn6brzhdm4EELDvzdvl6zdlxvZSYu/IYgMkBNb8YVvJTK9OIoWnH0Z1hXI2/i
         OqrU3pnFcdl9PNO4AgWOO5a1aUXjtD4HqxBoRrdC561liRPGlvVmi4YtvpGNPx5IrvRZ
         vjEg==
X-Gm-Message-State: AOAM533TuOvgSTzcwHLOqdDSDgABOE4T5zu1wKvLmp6FqpKWBSaVGDJz
        z2tAQBpVrW5ghIYubTFOHZlL4wgeFBNMJHCVOg+nTZrJrMWUo64qtzdQmuvETKS5PIEiBbcm//o
        MpmMfs1G7mZ3kxWGHfn7CzEU1
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr1343024ejv.221.1599129172878;
        Thu, 03 Sep 2020 03:32:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKOOQit71KDUj1vlagmzzxdVBIYpRE6M2EIk+DSgSKDROQ5nL1jX9o7MvYH4+PhPmTGlii7Q==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr1343004ejv.221.1599129172669;
        Thu, 03 Sep 2020 03:32:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id re10sm2899834ejb.68.2020.09.03.03.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 03:32:52 -0700 (PDT)
Subject: Re: [PATCH] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for
 BYD zhaoxin notebook
To:     Penghao <penghao@uniontech.com>, gregkh@linuxfoundation.org
Cc:     johan@kernel.org, dlaz@chromium.org, stern@rowland.harvard.edu,
        kerneldev@karsmulder.nl, jonathan@jdcox.net, tomasz@meresinski.eu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200903100326.5327-1-penghao@uniontech.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e9b10ea4-1f7d-4edc-daa6-32af833fea67@redhat.com>
Date:   Thu, 3 Sep 2020 12:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903100326.5327-1-penghao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/20 12:03 PM, Penghao wrote:
> Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
> This notebook come with usb touchpad. And we would like to disable touchpad
> wakeup on this notebook by default.

2 questions:

1. Why do you want to enable remote wakeup by default ?
2. Is this a HID multi-touch touchpad?

Regards,

Hans


> 
> Signed-off-by: Penghao <penghao@uniontech.com>
> ---
>   drivers/usb/core/quirks.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..5fa3f2416967 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -387,6 +387,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>   	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
>   			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>   
> +	/* SONiX USB DEVICE Touchpad */
> +	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
> +			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> +
>   	/* Realtek hub in Dell WD19 (Type-C) */
>   	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
>   
> 

