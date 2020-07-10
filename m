Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78424C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWVyxLVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGJUg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:36:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEEC08C5DC;
        Fri, 10 Jul 2020 13:36:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so2718548pls.4;
        Fri, 10 Jul 2020 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBeOH8xn997iN4AWW1cm6Q7EpJLMNZfyo6PWOD7fGV0=;
        b=FWVyxLVdbt50VvwsbdoJOl5kguGk80kYfbE9yz1SBzDDzd7YvKTABMonsDlaDK+DY8
         c2FgUdOCvrNbv8D5FLfB1pyQtPOknA+3uLlOEGb5y+5ICfvJxjU/vSRMEC+8Q4M5AXp1
         LsLJj9zlIVspRMfSLaFhCfoeBvICxkRtfo3p+p1e9NZMxdKDfyQ8XIPBX/PAE1BQsnh1
         kc1Gev815pieKt1a364W1rME65HciMphubQ+VNE7bm3P+sihsaM/jh21D1NEtud0xm9b
         eVj+ZwG74/G1VksxjZqKuNe22/yfR00UxCyUxocbmaHkY9dIuTIdYYa9gF8P9U3CL301
         b1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBeOH8xn997iN4AWW1cm6Q7EpJLMNZfyo6PWOD7fGV0=;
        b=tjl00UluAszRUoYzMNUy8sqqW+HJZe2tQJsZ0hzP29y0USK+SC4+yl9PMea1VpgdtF
         7MoAwWpYGVPGbsvVxNUI3/aldYFtnWXI9ZbivCKC6k2F3+vIgcWpAGIcqlpidyrgpEtE
         QZ4WApgRaQGc3wOEw7JHOy/UHsoQZPkWqnEumqUHxH9IxMG6yMbDyUgHYbc2jMD/AzJW
         /eUmjfBIjZHch0CQKts5VFbfOMjzrsZT2hXSDOAtCnBl7p9dasbzWD2rd0iNPCE8TyZ0
         z3ZEmw0jkiBrBMYadFk7d77eywj0dBjH9JFeY5otd5uRevMfwYffg/eCLhzBcdQoWDfy
         b6TA==
X-Gm-Message-State: AOAM531Qq3niJYuVhV0aPt/xvFWeGpiccNQ1QDg79LvAxjdmihD6hCxV
        tVVQTKYjEBHfPWuXULN2wWkBFCncEonlqMF1N/k=
X-Google-Smtp-Source: ABdhPJwaudV8tXyCRsPfnZ9NnDzY+/0o7ua2r2Wku8+nR2tKGXe27SsKXfqTtQIxQDU/5xxT08RNKVdwxYKXN7m3oSg=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr7850296pjb.129.1594413388823;
 Fri, 10 Jul 2020 13:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200624175138.3835436-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200624175138.3835436-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:36:12 +0300
Message-ID: <CAHp75VdXQW9NdXi6MNZQOJf0xg3yZxSQKaqpw79fSyaNp1L2Uw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ISST: Add new PCI device ids
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 8:52 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added new PCI device ids for supporting mailbox and MMIO interface for
> Sapphire Rapids.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel_speed_select_if/isst_if_common.h   | 3 +++
>  drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c | 1 +
>  drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c     | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
> index 1409a5bb5582..4f6f7f0761fc 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
> @@ -13,6 +13,9 @@
>  #define INTEL_RAPL_PRIO_DEVID_0        0x3451
>  #define INTEL_CFG_MBOX_DEVID_0 0x3459
>
> +#define INTEL_RAPL_PRIO_DEVID_1 0x3251
> +#define INTEL_CFG_MBOX_DEVID_1  0x3259
> +
>  /*
>   * Validate maximum commands in a single request.
>   * This is enough to handle command to every core in one ioctl, or all
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> index d84e2174cbde..95f01e7a87d5 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
> @@ -147,6 +147,7 @@ static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
>
>  static const struct pci_device_id isst_if_mbox_ids[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_0)},
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CFG_MBOX_DEVID_1)},
>         { 0 },
>  };
>  MODULE_DEVICE_TABLE(pci, isst_if_mbox_ids);
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> index 3584859fcc42..aa17fd7817f8 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> @@ -72,6 +72,7 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
>
>  static const struct pci_device_id isst_if_ids[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0)},
> +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_1)},
>         { 0 },
>  };
>  MODULE_DEVICE_TABLE(pci, isst_if_ids);
> --
> 2.25.4
>


-- 
With Best Regards,
Andy Shevchenko
