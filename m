Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F21C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAB321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0XeMD+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBFUSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:18:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:18:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so3293654pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFN1Km4dCQkq+GGDV1xBpaMwWsOvVlBXIU+KU1SLC/A=;
        b=H0XeMD+6iXBq9rEwF2gPODpAdg7UWIGBJwq+XhYAMmhdeZK7LPstfFxROA6MwmBBI5
         FbSSsifLyu2EKf+pzBKjbm4GgsS8kE//QjYl8OgteVwPzJSQ2ZnYETTxJ82hMHli9Kn0
         G/oovqUZhD8W4nl3PmX651ZoKidu2pxfnVltxCWwcaAB8W98heEjoB6LDmQLakjPJXH/
         pHVUEagfwfWpQgtbqRxS4rTNDkkCySUp6CKmIgyEsF6yOBeygw0Mbyn+udmfHiHRjBtl
         0zwUavbb4UeZ14UwzO+qo4JgGq0EECucDU++DamE8lml01QYSgwmKxY1Uk/rUQy7/DGL
         YoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFN1Km4dCQkq+GGDV1xBpaMwWsOvVlBXIU+KU1SLC/A=;
        b=ZCjlL7LZEh4Bsp/OVcr/KCgnbWNcUXNAmUmT35ZkWjZpzIih1N0jbJIv+tkUl8ryhf
         KosO73G+Ve1wi4KGMRBZwnezQcDC3JOujVs2a1ISauqfWfmGYAozpc6DI9Xk6+Kj8KSu
         nkJe+ST+n0RkC+LGTE4HOls4xnDkbgvDVFu7yIT1QFucQnJWSsvy+tTAvAH0sHSaMfvX
         /HT54y7lQx+up/bBkdITUDWg6xAcfJdhSTR719qA4RA4SneJK52GzJqmoOImrDSTqKMv
         Oq7la235zn/7JjanXdzGxIuBC9Z58bQsCs2/KjVH6mfLhlOsMg4a45RWQROr6szJ/+9a
         jjaA==
X-Gm-Message-State: APjAAAVmjBTwnoBTGQyhJ7jeum4NA+4F0DlHZYSpRCG8Ln57Tw+gH8X5
        rH3Otag80dZHg/Ho02qIsifqig==
X-Google-Smtp-Source: APXvYqzPIpbi0GjjDSfp7TxORTZt+Q5S10BztoYv26HU5J8IWsGhIVrLNsL4619q3ubPEAMBo8kv8g==
X-Received: by 2002:a63:3688:: with SMTP id d130mr5660071pga.422.1581020310775;
        Thu, 06 Feb 2020 12:18:30 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b130sm265441pga.4.2020.02.06.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:18:30 -0800 (PST)
Date:   Thu, 6 Feb 2020 12:18:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nikita Shubin <NShubin@topcon.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: warn on kick missing
Message-ID: <20200206201827.GP2514@yoga>
References: <20200206055419.15897-1-NShubin@topcon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206055419.15897-1-NShubin@topcon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Feb 21:54 PST 2020, Nikita Shubin wrote:

> .kick method not set in rproc_ops will result in:
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference
> 
> in rproc_virtio_notify, after firmware loading.
> 
> At least a warning needed on attempt to call missing method.

Is this not a fatal error only happening during development? In which
case the NULL pointer dereference will come with an oops with sufficient
information to pinpoint what's going on?

Regards,
Bjorn

> 
> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 8c07cb2ca8ba..77a81f331e3f 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -32,6 +32,12 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
> 
>         dev_dbg(&rproc->dev, "kicking vq index: %d\n", notifyid);
> 
> +       if (unlikely(rproc->ops->kick == NULL)) {
> +               WARN_ONCE(rproc->ops->kick == NULL, ".kick method not defined for %s",
> +                       rproc->name);
> +               return false;
> +       }
> +
>         rproc->ops->kick(rproc, notifyid);
>         return true;
>  }
> --
> 2.24.1
> 
> Confidentiality Notice: This message (including attachments) is a private communication solely for use of the intended recipient(s). If you are not the intended recipient(s) or believe you received this message in error, notify the sender immediately and then delete this message. Any other use, retention, dissemination or copying is prohibited and may be a violation of law, including the Electronic Communication Privacy Act of 1986.   ??
