Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64904C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36856206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCxdljLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIDCuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgIDCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:50:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502BC061244;
        Thu,  3 Sep 2020 19:50:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c15so471764plq.4;
        Thu, 03 Sep 2020 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dALLnWDXeLa3n4o9oqixiuVAP3y8FtK3zHisHGsAjkg=;
        b=cCxdljLw6abYzVdZMWeJT2X3efusjngNxBpT5U/9IuKLkJvM6I+iLGh86/P0HttGRR
         VN1wonO7xfBctQiRs7HgNY8hxI5JzDDQ0o274LWoQxMn0Q1feDmYLxuh/ujTWTZMYd7B
         aEQ+j5PYkrVUSN6S0l22mlbQu4g+jdAPM50DcJBMhhhZIPYA2ihxU+3Dvoifi35nZJc2
         78gc22lX+4+r/XCMUNmAF3zwDDwEu+paQvVe/sbheegYxeJz0YD5ydlCy7jwSVKKJb3z
         obZvTmIxkFP52O6JK8S9olwaW7HXTYC0E1tU6weURwjzX4slL17B6gd82KsHFf93tJvK
         CLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dALLnWDXeLa3n4o9oqixiuVAP3y8FtK3zHisHGsAjkg=;
        b=uiOYI7k30FJ31vqW6oAuenQJmgCrLrr9ODCGe4sOTT1pgjqbQwznBm/dKCmxO5EwUt
         vTtN7umPXX9hWI87/c47GDW9/tVqSvX86jILr9NNssfgn3i7W2Q1cEke/1VNSgcpBd/9
         wXXb25fMs0xn3FPX3rlIV/9QXuxjkyf1Qo3Av4DNDEjyYYPogo6A3sOLK6f5TdrnZL5X
         TIL3FLKLngyeRBfOKhr9v9jxzFvaDEscVXoPCVKdEBjw8CQ3VsZYr1gq6Ottz6EAhIUM
         5HsAy2YW1BK+0zOym3549ReyXsA6qiQ3mwDNOSVLGqgFd5ascmOdShxORn6stbNuMwpI
         feWg==
X-Gm-Message-State: AOAM533L+S5US9tcPcljz+HkM+CJBa22iihfj9Gi9e5fiI8kn5eylYkK
        Kpyyqlloo6UcxMMeUVap4Cz4x/7XnYjImw==
X-Google-Smtp-Source: ABdhPJyNCt+PhtjqW5pF69ijCByqqEB5HU05I6uyD/k3VKmOC+clw8a30bzHK8dO/SHklhrouMHc5g==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr6841855plt.78.1599187817357;
        Thu, 03 Sep 2020 19:50:17 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.81.40])
        by smtp.googlemail.com with ESMTPSA id b29sm4095787pgb.71.2020.09.03.19.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 19:50:17 -0700 (PDT)
Subject: Re: [PATCH] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for
 BYD zhaoxin notebook
To:     Penghao <penghao@uniontech.com>, gregkh@linuxfoundation.org
Cc:     johan@kernel.org, hdegoede@redhat.com, dlaz@chromium.org,
        stern@rowland.harvard.edu, kerneldev@karsmulder.nl,
        jonathan@jdcox.net, tomasz@meresinski.eu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200904014854.12577-1-penghao@uniontech.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <3478d24e-aefa-1fe9-6544-4c45e35a17f2@gmail.com>
Date:   Fri, 4 Sep 2020 09:50:13 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904014854.12577-1-penghao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2020 08:48, Penghao wrote:

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

This list was sorted in a beautiful ascending order of vid, pid before 
you entered your quirk..

rgds
Lars
