Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0613F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmaCrk1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgE0Gsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE0Gsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:48:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:48:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so82596wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7LeU+UdXoVHvFWpsdH5qXrt3tNYpvrrAzAhZwkjADGQ=;
        b=SmaCrk1LUTHh/o2KutIjiCIhUy4p30yQHnviy8ti4ZwcaHDwd6ws2zOoJXCD1GtH3d
         bHfOzstoNYWWf7Q0flomJc9/Nz+vo3BqmAUBxCS0XMXl/rFW+XzLLki0gr7egFYM4P16
         ykY1ein2Dd/+QdRZP7Lj2vHJfNOuWhM/Hhe3V8kkLDmFgm8fI4a48i9UKy0hlQC9tDmv
         +rSsqKf89zwOk29h+O6fEh8kYjKHu7igS1L3wGnbGxpU0tu1Pr4gzG9pcwYJzVZ36Zfp
         L7LGDbBn4PknYChrdqbWJYYZ9/kDIpS7Z/A+FGhPT8UEZFhhDetJW0xIkcc668cFQHu8
         g8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7LeU+UdXoVHvFWpsdH5qXrt3tNYpvrrAzAhZwkjADGQ=;
        b=e4lDYRCbRYIhNFZzMn7JR2wcxO37Z4XYptlZhXyCg1nDMjM+ZOVqiqdsukMSFL0D6c
         bhxvcaeNpd0n/55cKvVE/yNaV8Fu6BR9NfLsvL8W2AbC97V8T7UGUV5bZhtYbCMhzIDr
         Rx9J8PYnAcqTOIvaLWPHiw9RjHBfb77VOBSHbF2QCavv8/SRUeDfPJSTWG1VXM8X6GLs
         qJPj4mL7eFZdJvG0+AYLTIQQgYIl33jc3gQvyXesPNZv3nAayJEagGru5ZpNvI5Y6Nsm
         P380itSU9JYirxiX+WrzhkyhN31W8/PqaY0MFRt+yjFSIeKlwEPfPXY97XwICrfF4IDc
         M+8Q==
X-Gm-Message-State: AOAM531nKzAUDNRSBymgdMZP2IPEoKi4K7V+nthh7VbQnteK+hkNhcBj
        0522EemAyToyDa1dGdTUqOrT0Q==
X-Google-Smtp-Source: ABdhPJzRJyz8F0b7HQ/1rq5CWl6Hbi5Qoq1hArVmbFt9djqf5RvekT+nqWLxuMM5Mz4mMLZA+HquTw==
X-Received: by 2002:adf:a157:: with SMTP id r23mr9862016wrr.92.1590562121246;
        Tue, 26 May 2020 23:48:41 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id j4sm1924642wrx.24.2020.05.26.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:48:40 -0700 (PDT)
Date:   Wed, 27 May 2020 07:48:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v9] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200527064839.GO3628@dell>
References: <1587641093-25441-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587641093-25441-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Gene Chen wrote:

> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck

I changed the subject line and commit log a bit.

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig        |  12 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/mt6360-core.c  | 425 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++++++
>  4 files changed, 678 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
