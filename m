Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87843C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671AE20890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0ZS/3pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgE0QX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390490AbgE0QX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:23:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C69C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:23:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so9312044plv.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZ5uOqXyVXycGXVAAgCgn38z+gYbg3o20gbO6GOtv1M=;
        b=F0ZS/3paUKZ2S+N/oD7CL1NsyxysZEsjL/PolDB300xaGPVujsGLK0IMW9DueeYS6T
         jbmflghQBj/BbaTKCvB9hR2gBDeHhjGYS0coxyovWAHu9bjXYVih5Xwfe+ag96Xsm87o
         ArKg5clL8GUpl1+lTibxjUMgikyciqFi2xXRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZ5uOqXyVXycGXVAAgCgn38z+gYbg3o20gbO6GOtv1M=;
        b=V+ZNQmFfNScD5wLA5Fb0ort/h1NIwrFK9l3MguR8q1ODtxBB0tY0HnxwGpCF4naLsj
         bb+ctgJePbEHQq7bIMl7e0HUx2RJZJxY19NTFl+kscUGeLI64JV0m750WEGmslzOjfjR
         klWGBr4y1qAnDCchUyF/oHiNlQuntwGZnm/FQ9YskBKpMDQOFH7XT+sEYHSTD1e31NH8
         fkPnS7uKv636GfeeGmaC5dT/qtjUKFxsAiAGgxVQIJ3ZsiAy+ZSuoEpn45VtcoXFPpvW
         Oz02EH3yehlUGUN1iJbNAgYDrUEiaZJSYfx4LtIVBLfXsNfeJwfPaKn/MLhdEUeflN9m
         Akcw==
X-Gm-Message-State: AOAM530AnN7t4qCaIGV27oTo00+F1tlcgOJUNJ2/qf/iVuo8iPEcAsha
        9R2gLVkIEzJIe9+dDD5x9zn2Ww==
X-Google-Smtp-Source: ABdhPJynzniNYj9eCfx/pxIRIBDyJ1ubE3Hoi6fUeIRvXUQGBcqJ5Fhsb9/gwkzxC+/t+WEUu62JKA==
X-Received: by 2002:a17:90a:d506:: with SMTP id t6mr5426147pju.134.1590596636292;
        Wed, 27 May 2020 09:23:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x22sm2363680pfn.26.2020.05.27.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:23:55 -0700 (PDT)
Date:   Wed, 27 May 2020 09:23:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200527162353.GG4525@google.com>
References: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:57:09AM +0800, Zijun Hu wrote:
> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 3ea866d..94d8e15 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -74,10 +74,14 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  
>  	ver = (struct qca_btsoc_version *)(edl->data);
>  
> -	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
> -	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
> -	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
> -	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
> +	bt_dev_info(hdev, "QCA Product ID   :0x%08x",
> +			le32_to_cpu(ver->product_id));
> +	bt_dev_info(hdev, "QCA SOC Version  :0x%08x",
> +			le32_to_cpu(ver->soc_id));
> +	bt_dev_info(hdev, "QCA ROM Version  :0x%08x",
> +			le16_to_cpu(ver->rom_ver));
> +	bt_dev_info(hdev, "QCA Patch Version:0x%08x",
> +			le16_to_cpu(ver->patch_ver));
>  
>  	/* QCA chipset version can be decided by patch and SoC
>  	 * version, combination with upper 2 bytes from SoC

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
