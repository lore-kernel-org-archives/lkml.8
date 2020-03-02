Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18376C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E387A208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz48/6Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCBKQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:16:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbgCBKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583144203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXo+jOnMJnVg0BdBfAq0eKhEwbhNb8AEFiily5Isa3s=;
        b=Lz48/6MrklQ1TgrAYgUnMvL5H84FnwqamDiw5QpMRvpI+KhLtT1OYWTXsdQKZb4YrC553c
        pjGPssl6LbEcGWewxswEoLeP2tbCoQn2oasM5FaaNaSExMpoWniYULBixvqkNzdj+wCSl+
        W1q7crQ1fFotjylPUNKyInhDV5VEHTs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-9l02Ge80Nl22PEqgJcRN4Q-1; Mon, 02 Mar 2020 05:16:41 -0500
X-MC-Unique: 9l02Ge80Nl22PEqgJcRN4Q-1
Received: by mail-qk1-f197.google.com with SMTP id d2so8550682qko.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXo+jOnMJnVg0BdBfAq0eKhEwbhNb8AEFiily5Isa3s=;
        b=NPFSZCVY3kRXW4LFp3xL0UXQfG/iA1BevLnQYjUMlVhsyJDuB+Fi2WLXbPdKOJ/m7c
         0P/LEEartp/60MbNBbNO6wOTNuCuXoRJK4ko+jlnbqD6HhZ3M2BC04979xBdXrBDmhHm
         NRBDykKn+OBv41fg7NrekMDiHPZZvVXzAteR7LIYLMACpMVsnZ5r+jcxv+mWs4tFPP0e
         nhHXjFT1ti16Fl4VlXpoAzyS3SfHRRf85E5Gg9siXi8XiCPt8zR8i/yV46msAnS2TZil
         DQLLhPuneMjV/E7FF7kaTfRTO7AC7zvvYD6BPb1NuOC190Ddy/nYQ2hoSmfjf7x1v+SX
         o1vw==
X-Gm-Message-State: ANhLgQ3jZU3QSKU4lesiL7DtI+9rqxZtjNapnXehks4RBYE+5YYpn/Ue
        7bRVivu/tbxeAoRxJH17ksv3OV7F59GyVLF5t2EgQXoTyhmums6Ks7DUBxIFSKOcjkznqnwgXud
        YpInaas7dalTHbORbqlLJwmRke172vSQZmoDeYTaB
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr7903639qkk.459.1583144201401;
        Mon, 02 Mar 2020 02:16:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvciVC+XX0L/bTNhtxk+6Nmcqb4gcKNRf+REB1cVh+9NmujV8iEZpeEbQ7bkpaxLzOlPc2RTSKI9C/8YAO1yK4=
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr7903622qkk.459.1583144201197;
 Mon, 02 Mar 2020 02:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20200229173007.61838-1-tanure@linux.com>
In-Reply-To: <20200229173007.61838-1-tanure@linux.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 2 Mar 2020 11:16:30 +0100
Message-ID: <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
To:     Lucas Tanure <tanure@linux.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 6:30 PM Lucas Tanure <tanure@linux.com> wrote:
>
> Fix below warnings reported by coccicheck:
> drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
>
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Sasha, do you prefer taking this through your tree or through the HID
one. I don't think we have much scheduled for hyperv, so it's up to
you.

Cheers,
Benjamin

>  drivers/hid/hid-hyperv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index dddfca555df9..0b6ee1dee625 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -193,8 +193,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
>                 goto cleanup;
>
>         /* The pointer is not NULL when we resume from hibernation */
> -       if (input_device->hid_desc != NULL)
> -               kfree(input_device->hid_desc);
> +       kfree(input_device->hid_desc);
>         input_device->hid_desc = kmemdup(desc, desc->bLength, GFP_ATOMIC);
>
>         if (!input_device->hid_desc)
> @@ -207,8 +206,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
>         }
>
>         /* The pointer is not NULL when we resume from hibernation */
> -       if (input_device->report_desc != NULL)
> -               kfree(input_device->report_desc);
> +       kfree(input_device->report_desc);
>         input_device->report_desc = kzalloc(input_device->report_desc_size,
>                                           GFP_ATOMIC);
>
> --
> 2.25.1
>

