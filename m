Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F11EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4872067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfTd6y8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGAKd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgGAKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:33:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD75C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 03:33:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so10210854wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hewe4JI7d2uWaZ6U5ruXrOYCzIOeGQYejvEgeCsdjtE=;
        b=ZfTd6y8QgSzsSH6FxtqUI4HgS6iNRziQFdUNWniFv0dcZrF2Uf7IOWnfoZHcs2SHBj
         NXBPF9sea7VKntNrEAX9DcjoJBpspfjOIxX5g4ChLSjvdMMyxwoZwaISmb2cU3ASNxow
         HBnsQC2cJc7O0EOYrG3qdmgepvyxyiH3B3nf+Ao5IKRF8bb1egF+O/fAH6coHzppvApg
         AF1gKcE5KjvYAZ9voIdY2UT26quq00pVp4qjUWrKVvBU1nF3aVeBFP/CAK6qfLqLh67B
         9mTHuhhY9HbUbkBqcQt81sbJrYL1YXi4JwrR85xKcScm3GulxP1CcOuXNfM1ixq9Stfi
         Unrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hewe4JI7d2uWaZ6U5ruXrOYCzIOeGQYejvEgeCsdjtE=;
        b=gWerq1SOYmkc70IIQ96PZ4on6sh0N+/biQSXHcvh8lUteTchBeIKsiEqQ7YXILY1Z/
         YeWn3rYG1QzpHI8zMm8wshIGiEKuXgudKn+cEZHMvjMzEBJ9/Ip/KPS/YdqFnd3ItyD2
         4PSmrcNOvwbBzY/Veub9coN4RNtgByApP6H2/OH/ogFEKZ8ZrHZw6wLt0lR62+1bJ9FT
         TnTaHFVJMl3aM8Bp2Pw/Dfq9j/CmSaUkb85HwistYqNKX1cVt1urKiViS3xG6bJXRRia
         vt6AziSU027P0N6bOuH+f9egYJaO8wR2W8n9/98/M1CT4lpYbvH15Iqej2x5QRynsWoB
         El1A==
X-Gm-Message-State: AOAM53369BFH1GXONQHWhzVjpHkxV6PV5VmqPD7HPX9Fe6PqgeHCHuy1
        hpXpED5qMs5cuQgskovUAYQUIwiss0g=
X-Google-Smtp-Source: ABdhPJz7JIgkZAG8K6/gyDFLRFcHusOCn5Tb1ln0F2cKOhJl1bhSZP7Oe2blmfhX1Yphbq8H68qZzA==
X-Received: by 2002:a1c:a589:: with SMTP id o131mr24537790wme.12.1593599634210;
        Wed, 01 Jul 2020 03:33:54 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id i17sm7177549wrc.34.2020.07.01.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:33:53 -0700 (PDT)
Date:   Wed, 1 Jul 2020 11:33:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>
Subject: Re: [PATCH v2 07/30] misc: vmw_vmci_defs: Mark 'struct vmci_handle
 VMCI_ANON_SRC_HANDLE' as __maybe_unused
Message-ID: <20200701103351.GE1179328@dell>
References: <20200701083118.45744-1-lee.jones@linaro.org>
 <20200701083118.45744-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701083118.45744-8-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Lee Jones wrote:

> vmw_vmci_defs.h is included by multiple source files.  Some of which
> do not make use of 'struct vmci_handle VMCI_ANON_SRC_HANDLE' rendering
> it unused.  Ensure the compiler knows that this is in fact intentional
> by marking it as __maybe_unused.  This fixes the following W=1 warnings:
> 
>  In file included from drivers/misc/vmw_vmci/vmci_context.c:8:
>  include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
>  162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
>  | ^~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/misc/vmw_vmci/vmci_datagram.c:8:
>  include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
>  162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
> | ^~~~~~~~~~~~~~~~~~~~
> 
> Cc: George Zhang <georgezhang@vmware.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-omap2/mmc.h              | 4 ----
>  drivers/mmc/host/omap.c                | 1 -
>  include/linux/platform_data/mmc-omap.h | 3 +++
>  include/linux/vmw_vmci_defs.h          | 2 +-
>  4 files changed, 4 insertions(+), 6 deletions(-)

Drop this please.  Something went wrong.

I will resend it separately in a few days.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
