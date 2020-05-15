Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F203204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEOCbH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:31:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgEOCbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:31:06 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jZQ7r-0007iT-GP
        for linux-kernel@vger.kernel.org; Fri, 15 May 2020 02:31:03 +0000
Received: by mail-pj1-f70.google.com with SMTP id o9so652846pjw.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s8tcOcdPYeTodwqSl1QkZZy/pKZuDq5Dfiay8LkuQI4=;
        b=F5fWCrwa8e/Ukt9BoGQDIAsZi21z+HlRJahrSoJ2NyG9877PostQcPHmIFcmilYolA
         9KplWeU68KBMpzIaO3UUfKTdt+x6IKm7oym9vde3Nmo6rBWl31Bp2Ns9F1CCGO+5DWSN
         ch+25V34w7c2D2Rj0JVE6on72lrquPpCP2ot6T1qOlfGUmOyIRsyUae9H307iasdYrT2
         CfQbVxS+VFzo4taWMCTYFmTlNZrKq68oeQWNTneMCeoCvuYI5n8f9QKpz5Cf0HjP+nfQ
         o+Cp8WMsQVBcMmWO+dYX/b3WemX5J0BDHraF8PpV7uxwOZ3rjWrKfVXdhptuZxYN3BsE
         2xzA==
X-Gm-Message-State: AOAM530nRFKjkIE0Y02y092DmniNqFpY8iW5D2QJ9mP0ZjBHYqp/dP3C
        hsRTouN89aTJlJiEoiTC9lohKgcjfk48eDTNgCiEeOOVu1sTw7629eI4JJDrk5NDhUjrH1KeTQ6
        5Ougcu7nghXBAp/7xOor/0YzrrqP/RjiAFGGri9lARw==
X-Received: by 2002:a17:902:b401:: with SMTP id x1mr1530869plr.334.1589509862028;
        Thu, 14 May 2020 19:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbeP3r9puf7vMybibvhliGHuQC/LsBElDPmuxYS58JCZt6ir1uAtpEWJco+HN6Kzp8W3KFFQ==
X-Received: by 2002:a17:902:b401:: with SMTP id x1mr1530832plr.334.1589509861600;
        Thu, 14 May 2020 19:31:01 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id c22sm459697pfc.127.2020.05.14.19.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 19:31:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] usb: core: hub: limit HUB_QUIRK_DISABLE_AUTOSUSPEND to
 USB5534B
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200514220246.13290-1-erosca@de.adit-jv.com>
Date:   Fri, 15 May 2020 10:30:57 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FB436128-70A8-4558-808C-E068834EBF4F@canonical.com>
References: <20200514220246.13290-1-erosca@de.adit-jv.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 15, 2020, at 06:02, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> 
> On Tue, May 12, 2020 at 09:36:07PM +0800, Kai-Heng Feng wrote [1]:
>> This patch prevents my Raven Ridge xHCI from getting runtime suspend.
> 
> The problem described in v5.6 commit 1208f9e1d758c9 ("USB: hub: Fix the
> broken detection of USB3 device in SMSC hub") applies solely to the
> USB5534B hub [2] present on the Kingfisher Infotainment Carrier Board,
> manufactured by Shimafuji Electric Inc [3].
> 
> Despite that, the aforementioned commit applied the quirk to _all_ hubs
> carrying vendor ID 0x424 (i.e. SMSC), of which there are more [4] than
> initially expected. Consequently, the quirk is now enabled on platforms
> carrying SMSC/Microchip hub models which potentially don't exhibit the
> original issue.
> 
> To avoid reports like [1], further limit the quirk's scope to
> USB5534B [2], by employing both Vendor and Product ID checks.
> 
> Tested on H3ULCB + Kingfisher rev. M05.
> 
> [1] https://lore.kernel.org/linux-renesas-soc/73933975-6F0E-40F5-9584-D2B8F615C0F3@canonical.com/
> [2] https://www.microchip.com/wwwproducts/en/USB5534B
> [3] http://www.shimafuji.co.jp/wp/wp-content/uploads/2018/08/SBEV-RCAR-KF-M06Board_HWSpecificationEN_Rev130.pdf
> [4] https://devicehunt.com/search/type/usb/vendor/0424/device/any
> 
> Fixes: 1208f9e1d758c9 ("USB: hub: Fix the broken detection of USB3 device in SMSC hub")
> Cc: stable@vger.kernel.org # v4.14+
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
> drivers/usb/core/hub.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 2b6565c06c23..fc748c731832 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -39,6 +39,7 @@
> 
> #define USB_VENDOR_GENESYS_LOGIC		0x05e3
> #define USB_VENDOR_SMSC				0x0424
> +#define USB_PRODUCT_USB5534B			0x5534
> #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
> #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
> 
> @@ -5621,8 +5622,11 @@ static void hub_event(struct work_struct *work)
> }
> 
> static const struct usb_device_id hub_id_table[] = {
> -    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR | USB_DEVICE_ID_MATCH_INT_CLASS,
> +    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
> +                   | USB_DEVICE_ID_MATCH_PRODUCT
> +                   | USB_DEVICE_ID_MATCH_INT_CLASS,
>       .idVendor = USB_VENDOR_SMSC,
> +      .idProduct = USB_PRODUCT_USB5534B,
>       .bInterfaceClass = USB_CLASS_HUB,
>       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
>     { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
> -- 
> 2.26.2
> 

