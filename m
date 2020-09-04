Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8254206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAXXI0j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgIDCtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgIDCtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:49:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF12C061244;
        Thu,  3 Sep 2020 19:49:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so451090pls.11;
        Thu, 03 Sep 2020 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bo4/9PBXNu/1dIB9MXSEsITbBb0mlowTelVR5S5i/8w=;
        b=mAXXI0j6O4LJXriRLXXIZogwS2WEUvWNFeVokAem2wUeBSaWU30+LdknBKOgNPaYUK
         /dmKiJ5GFhYNvoNwC193IPnS5tjxJl54A4oU4mnw/9ETxuHqiCyF5QlgHVQE3wSWhTka
         aMSB0v8k0gJ+d5WBBVxSDW/HScppLnpNbbUkAYlH+PUmuecObH8yNWO4RbgaxA3atJfY
         jRmna/jDj/zqEj9OnLYCxKWzNeqwXulRoW54vwDVDFgLs0Tr1XddXsQm7Zc7BJs4Ukd/
         mOEMQl/NdQKxWzaY/hmqrfAocqgEBsXwi4m160XHBggV3yfPFRGE8BeiBEtssBA+od70
         Wdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bo4/9PBXNu/1dIB9MXSEsITbBb0mlowTelVR5S5i/8w=;
        b=Okm0C5iPGmsH9CIND1Oc+Gd3PiHnD6+uAXfrPHqYMuntDlnmIMdoFazIat56ZzZml5
         1MM3x97FzTLqFq8FP7bL/bd0ayn3OcbCklsygFBa8/JzHpNIlSN4lbU4mGv2F6LlzjhG
         PQvQgR3iDKhjSWaYWJE6nBNJlGo5gM/RcJ0oHkePPtTvaDJTlw8+eNxUzgZEKJ4Um5Ww
         SgUNNsx7tyQWFS1//6HVN7fNRFPBmnkzyeJZTkZ5cZirQv18Lym3uiSqOj1FrO1LB9PV
         51KwNWmyg5mbFXNvrJKKg3XVYy6F2oEshbCJ1LlbwKm8pp+Yntz1QtXDISGScrR/BXzE
         coaA==
X-Gm-Message-State: AOAM530L8jki+v9dre6qD0sNPmufo+9WN2cfo/8jD0E/92smZ5nuQ5aK
        KGreqm2HXXNOTYVFns0TJwb/C/4ZJ+F2qA==
X-Google-Smtp-Source: ABdhPJyS/kWT3dPVeGZLPIDezmSRou3+sDO7XgPWY/SrIPeibY6kf9NwWOOFpTr8K+q6C5mTI/BSGg==
X-Received: by 2002:a17:90a:f309:: with SMTP id ca9mr6214354pjb.0.1599187777840;
        Thu, 03 Sep 2020 19:49:37 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.81.40])
        by smtp.googlemail.com with ESMTPSA id v17sm4551312pfn.24.2020.09.03.19.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 19:49:37 -0700 (PDT)
Subject: Re: [PATCH] ALSA: usb-audio: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND
 quirk for Lenovo A630Z TIO built-in usb audio card
To:     Penghao <penghao@uniontech.com>, gregkh@linuxfoundation.org
Cc:     johan@kernel.org, jonathan@jdcox.net, kai.heng.feng@canonical.com,
        gustavo.padovan@collabora.com, tomasz@meresinski.eu,
        hdegoede@redhat.com, kerneldev@karsmulder.nl,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200904014516.12298-1-penghao@uniontech.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <9fc6c4d7-4298-0b9d-b3a0-d6eb9573575e@gmail.com>
Date:   Fri, 4 Sep 2020 09:49:32 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904014516.12298-1-penghao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2020 08:45, Penghao wrote:

> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -403,6 +403,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>   	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
>   			USB_QUIRK_DISCONNECT_SUSPEND },
>   
> +	/* Lenovo A630Z TIO build-in usb sound card */
> +	{ USB_DEVICE9(0x17ef, 0xa012), driver_info =
> +			USB_QUIRK_DISCONNECT_SUSPEND },
> +
>   	/* SKYMEDI USB_DRIVE */
>   	{ USB_DEVICE(0x1516, 0x8628), .driver_info = USB_QUIRK_RESET_RESUME },
>   
> 

This list was sorted in a beautiful ascending order of vid, pid before 
you entered your quirk..

rgds
Lars
