Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFD520787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOv5Kvfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgEZQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgEZQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:06:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:06:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n15so21622pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3lKumICFqyFYrifsebtGoakO5VK89B9abdeZRmwK6ew=;
        b=HOv5KvfbMqTD/xQ/ROlpU3bcOVjFptEwe2f/EQw/HAma8s4kRySgfWHZ9e8m+4QrgE
         HW1GWv4ZRcMmEpC83PhRkRwJEk2/0BkcTX3OrzQrJ/iQNGfaYnUeJEApneVQniuqAowy
         2D0Djf5m/KmGOZMjkbPEKneQ/xhUdS9YyEz9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lKumICFqyFYrifsebtGoakO5VK89B9abdeZRmwK6ew=;
        b=M2DVH7ZZ/lajUYbC+IArGp0uzxi19D67u2iospQ3sevXURe2G4bFtJK5+L1hUFSDOQ
         G1aITXPNxDJk3XyCS+WuVefLPGBnGvsrh6A1ulS8lH0nL2UwSYP3S/o6UoQdigfKnQQx
         jqcCGriVTJPJwhEXnk3df/6H7fAqNnrtg7fX1ndYyJYcQiP5G7SdKR5Kq4KFKpWHmauK
         6NqgjWpIvCjaBSCl4+MpMh6dSDb4dEBWbPG1XYOasNVZ2RIxt2nTqCLnhKR919f/mNJ6
         Gf6fKUNhFEHt4jRv84CgeuAGg0qT29cfCo5dhnW42yQDdoNWUy+wNmMSkWsTINmB/cj4
         /kbQ==
X-Gm-Message-State: AOAM533I932dvS8IcKvljtwb5ElNn1YeBy9LHUm1SfJyYjYnq2wR3Xr6
        DddjbJTY0PVWW3/K6YBGq1F62g==
X-Google-Smtp-Source: ABdhPJyPU/803MdN1gbwFuM5w5uPEtmyalLAnfyY5sqqxosrq91XftBIrLkRGJKuctZsiaK1FtyNrA==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr1703283plo.246.1590509164803;
        Tue, 26 May 2020 09:06:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 128sm23369pfd.114.2020.05.26.09.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 09:06:03 -0700 (PDT)
Date:   Tue, 26 May 2020 09:06:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200526160602.GE4525@google.com>
References: <1590464108-1333-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590464108-1333-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:35:08AM +0800, Zijun Hu wrote:
> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 3ea866d..49e5aeb 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -74,10 +74,10 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  
>  	ver = (struct qca_btsoc_version *)(edl->data);
>  
> -	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
> -	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
> -	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
> -	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
> +	bt_dev_info(hdev, "QCA Product:0x%08x", le32_to_cpu(ver->product_id));
> +	bt_dev_info(hdev, "QCA Patch  :0x%08x", le16_to_cpu(ver->patch_ver));
> +	bt_dev_info(hdev, "QCA ROM    :0x%08x", le16_to_cpu(ver->rom_ver));
> +	bt_dev_info(hdev, "QCA SOC    :0x%08x", le32_to_cpu(ver->soc_id));

nit: Now that these messages become more visible you could consider making the
order a bit more consistent/hierarchical. Not sure what is the product ID vs.
the SoC ID (product is a variant of the SoC?). IMO it would make sense to
start with HW information, going from more generic to more specific, then do
the same for firmware.

  SoC ID
  Product ID	  // assuming this is a variant of the SoC
  ROM version
  Patch version	  // assuming this is a patch of the ROM firmware (?)

Sorry if I got any of the concepts wrong, from the names they are not entirely
clear to me.

In any case it's just a suggestion, feel free to ignore.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
