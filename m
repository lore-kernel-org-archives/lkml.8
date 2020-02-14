Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0AFC3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187B222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceSd+M8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgBNIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:32:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728977AbgBNIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581669169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puQf+KTVL6jAIvEG/uc6Qjsv+wcwMQCDCgK0h7H3Qns=;
        b=ceSd+M8QbBJ4yfrWW9fE//9wXHy8p4fV1+54ML4hf+uMcMxAs3Pkk3+kc2A3V+EHwGwkol
        ZNiGgrcpcuZ3samlfsBtWYCkDjhQXmdpMzpMWeI496jY9pl27ThKAeDHaORtXvlDAH6tz7
        eVnKozz3rASp5Ddkko8b+Q2Zd59qh8Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-K-MxDvniOEC-OCDzJjyrlg-1; Fri, 14 Feb 2020 03:32:44 -0500
X-MC-Unique: K-MxDvniOEC-OCDzJjyrlg-1
Received: by mail-wm1-f71.google.com with SMTP id p2so3499030wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puQf+KTVL6jAIvEG/uc6Qjsv+wcwMQCDCgK0h7H3Qns=;
        b=bAHV9io57U1UcdXHgY8407OXadRxfFVgZKh/NmbSYhri0R7qSiIJmu+DHrJzWplw1j
         DcEGDLWhqDbet2ZA1JxzbKuc9ojMDvDj1i6lJYK+SemUrdlvFTlF0DxXYmh55Di3sisU
         cXOXGcQyfZc7LAFr6Rx4U5V0UTgwg8heDvq4vPqY+7Q7reuKWUvf0TDoQPZ9JZoJ8ho0
         cgj4KI8Al8oPScdVDFzW95eqdTaMeZWsyNNcn/tK/QFVbPAlNOdqYu7Q5XQtJhINY5zC
         jdOY0M6px3N3lHC63obQOKhXaE9fTE7fAINyVLqJC1MI+1D2WJGXy79ADK/y8A5LJ81v
         NLVA==
X-Gm-Message-State: APjAAAXnbOrTkdNamwPrEcXBfBY1sDYZM673t6Q8iUyCg3N8uhSdW5VC
        o6Y/28H7ShnfO4oKMBA0BRyhkSlv4y1r076kTtWfQvDY2O/h2An1HD+3qty5DH57bLN7ucs2pQO
        FXanjtlH2swCIAw3O0LQtHuPB
X-Received: by 2002:adf:c3d0:: with SMTP id d16mr2595587wrg.376.1581669162542;
        Fri, 14 Feb 2020 00:32:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqz61KgA2geHCRzp+UTS+Gx0cIojDpn90PUtPD75jQf8W19FKR7d4Kn4nJr8MVNgmi4pM3vUkQ==
X-Received: by 2002:adf:c3d0:: with SMTP id d16mr2595563wrg.376.1581669162340;
        Fri, 14 Feb 2020 00:32:42 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id a62sm6548573wmh.33.2020.02.14.00.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 00:32:41 -0800 (PST)
Subject: Re: [PATCH] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor
 override
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200214065309.27564-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <189a7784-3754-99b8-3f3d-560b7657c134@redhat.com>
Date:   Fri, 14 Feb 2020 09:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214065309.27564-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/14/20 7:53 AM, Kai-Heng Feng wrote:
> The Surfbook E11B uses the SIPODEV SP1064 touchpad, which does not supply
> descriptors, so it has to be added to the override list.
> 
> BugLink: https://bugs.launchpad.net/bugs/1858299
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> index d31ea82b84c1..a66f08041a1a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> @@ -341,6 +341,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
>   		},
>   		.driver_data = (void *)&sipodev_desc
>   	},
> +	{
> +		.ident = "Trekstor SURFBOOK E11B",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SURFBOOK E11B"),
> +		},
> +		.driver_data = (void *)&sipodev_desc
> +	},
>   	{
>   		.ident = "Direkt-Tek DTLAPY116-2",
>   		.matches = {
> 

