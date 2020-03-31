Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A302C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41DA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5BLvCbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgCaIQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:16:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbgCaIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585642588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KEXjDpdkfzHGYc11MseadUyHXSxJBFAffB+nwY1U/g=;
        b=H5BLvCbc4lzazQ+uW9HiGB5uSl91PhU6u4B+J4h3aSSTSQTxohUVxJditmIdW8rNndY28J
        PkpbIOndhj3bo8RYJFdJ/YrgOY0DHw4ZxJeEXLY/qde46xPJmZ1tYRE+/51TXEuCkHUwUD
        gyyZdtaigMu7X2PoH662qRqR0e7ha28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218--y23brlYPJK2NCbc-u9h2w-1; Tue, 31 Mar 2020 04:16:27 -0400
X-MC-Unique: -y23brlYPJK2NCbc-u9h2w-1
Received: by mail-wr1-f72.google.com with SMTP id j12so12560080wrr.18
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KEXjDpdkfzHGYc11MseadUyHXSxJBFAffB+nwY1U/g=;
        b=HaJzLgn4w+qVzywQIqwzx40rcOjU+gNtb4HROnkxTacR0c+CO9guzxYFmdAKYt+cVq
         Yus4YdganvmH6hw5VCkpHFH+3EsIT6+4F3k6khAeh7zVA/Qljk6ef5ZbPOfikb77UZoK
         +MIIrOCJm830h7bFbwsCVh/Fl0p8wd0QZgs2fJ0yQ9UiN5mQGiHc1rKGHPN3pl4K9w5k
         FGcpp9RvuHpUas9vW26BG0LLJjHK1hX0Dy7yscgVH4SrBsnjU3Y6ucZB90922eRNJY2N
         /XoERyfSmrwnI+CybQZESdPD/X35SekTdJYBxvKiIWpySaP37SF4oJcU+ksw0ZPjVjg3
         LAUw==
X-Gm-Message-State: ANhLgQ38BOKY2h2Yg751rhqQ9PbwfNIh29boqJeCvAvfzeYZrryD/M0i
        1cn2zzlrRJsgkWJtQ25s9ypWLcF8wjiPpBLvNo6IR6Z7TQOHPZy2qbfgr+FnqzXqpVZ5YdZmCnN
        saa/XgsSx+e9xWr+my7yLuJSc
X-Received: by 2002:a1c:b657:: with SMTP id g84mr2164607wmf.107.1585642585529;
        Tue, 31 Mar 2020 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv0D8PbQSNyZJuByypmQwlp7VqNiGfkNYGvcYmg07TfkZmLPoOr3o3JKc2z0GnUlCHHAhkomA==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr2164596wmf.107.1585642585366;
        Tue, 31 Mar 2020 01:16:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id q9sm2195041wrp.84.2020.03.31.01.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 01:16:24 -0700 (PDT)
Subject: Re: [PATCH] ACPI; update docs for "acpi_backlight" kernel parameter
 options
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c292826f-0a41-910d-1973-e6b613fbce7e@redhat.com>
Date:   Tue, 31 Mar 2020 10:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/20 2:17 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Update the Documentation for "acpi_backlight" by adding
> 2 new options (native and none).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>

Thanks!

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   Documentation/admin-guide/kernel-parameters.txt |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200330.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20200330/Documentation/admin-guide/kernel-parameters.txt
> @@ -22,11 +22,13 @@
>   			default: 0
>   
>   	acpi_backlight=	[HW,ACPI]
> -			acpi_backlight=vendor
> -			acpi_backlight=video
> -			If set to vendor, prefer vendor specific driver
> +			{ vendor | video | native | none }
> +			If set to vendor, prefer vendor-specific driver
>   			(e.g. thinkpad_acpi, sony_acpi, etc.) instead
>   			of the ACPI video.ko driver.
> +			If set to video, use the ACPI video.ko driver.
> +			If set to native, use the device's native backlight mode.
> +			If set to none, disable the ACPI backlight interface.
>   
>   	acpi_force_32bit_fadt_addr
>   			force FADT to use 32 bit addresses rather than the
> 

