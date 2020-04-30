Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CEEC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9852073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkZ25Oks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD3D7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3D7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:59:50 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE2C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:59:50 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o198so2449820ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVqognKQgntjVBKfSDEux+9/gcTYWUYxOHYZrNrsat0=;
        b=rkZ25Oks3o/VpyiWfkX3rZpnI3vPGF94ioT0xhki2b45X5ITlx6+yeuOIhWuYqUXxZ
         7L6+p/dLdoG2j3g5Ai9sAitGD169VlugxcSxdNL505Sh4Uu5USTkRTIF7nbkxTd+Xi7k
         uBnlT3HVPTH2Kh2Pn0N1NK2TES9rq4eF8T6HCxpsYK8DpRTuPJ/5dFoXDr9KKEDa4b4J
         YWTfwZ88NBLqN6jnhffMLn6OpZpK0mSm4DMIfFiojx7JDO7wN+SqbAEGdiAZGoXzn8mB
         bjs0HcoC++cwG3g+ZF/IdDpcTk9PE8S8HP85HoaUeMJTwXNrK6BoxOX3bcTXSYPyi4LZ
         RmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVqognKQgntjVBKfSDEux+9/gcTYWUYxOHYZrNrsat0=;
        b=duwPjqWLUX+OLmutMQxZK1jtHHIz9ly/S5cUEvx3yxgYI3m5knXFIEppd7CxBe2X9q
         JdT649RlMaMjVZXPJAV/R9OcgiyY7a0ewfxBnduOBuM489dr2PWITzgv9suOvi6g5auH
         HyQuGqu8LWrWCpuXkuWWzujJWX/3aZFldRhHsAUTd9fEH2IINM+v9ujQt1KkMr/uR0Zv
         B6t9FSjlkTPFuHE+dmeYeu9p0xJRWvNR1q+A4oja1+aubXwnL3+huer38QxlAYlikuUi
         ebXj/d9FR2UxsAIPaA4LfJnJTyefVCMWEMr1F2s9ruZQ+wRrtiF9N/vtyZPY1JHHzlx+
         mI/w==
X-Gm-Message-State: AGi0PuaRhQBT0qLkDT9RrUCnHqsl5BG9FsnxDj++NBqpoA6fSVtf2e0s
        AUHLlIt07lE+2RvdUxzgO6Yp4hUYMCLmRFfdNj0=
X-Google-Smtp-Source: APiQypKveNXxdXNF772LwVNMcSObYZ5pPt8kLYm89iTMNGQ5UrY0MiR1zMFeudwvyX0KOQuRHTxlUcanm+VQVwRvkeA=
X-Received: by 2002:a25:bccb:: with SMTP id l11mr2366341ybm.435.1588219190036;
 Wed, 29 Apr 2020 20:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200423062358.1810-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200423062358.1810-1-kai.heng.feng@canonical.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 30 Apr 2020 13:59:39 +1000
Message-ID: <CACAvsv6XmvsnRz7=Brd0dMBfh7FqGA0X_6rz=tTt9M_ess9Lvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/nouveau: Use generic helper to check _PR3 presence
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Thu, 23 Apr 2020 at 17:37, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Replace nouveau_pr3_present() in favor of a more generic one,
> pci_pr3_present().
>
> Also the presence of upstream bridge _PR3 doesn't need to go hand in
> hand with device's _DSM, so check _PR3 before _DSM.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_acpi.c | 44 ++++++--------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index fe3a10255c36..b84dff1b0f28 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -212,37 +212,6 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
>         .get_client_id = nouveau_dsm_get_client_id,
>  };
>
> -/*
> - * Firmware supporting Windows 8 or later do not use _DSM to put the device into
> - * D3cold, they instead rely on disabling power resources on the parent.
> - */
> -static bool nouveau_pr3_present(struct pci_dev *pdev)
> -{
> -       struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> -       struct acpi_device *parent_adev;
> -
> -       if (!parent_pdev)
> -               return false;
> -
> -       if (!parent_pdev->bridge_d3) {
> -               /*
> -                * Parent PCI bridge is currently not power managed.
> -                * Since userspace can change these afterwards to be on
> -                * the safe side we stick with _DSM and prevent usage of
> -                * _PR3 from the bridge.
> -                */
> -               pci_d3cold_disable(pdev);
> -               return false;
> -       }
> -
> -       parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> -       if (!parent_adev)
> -               return false;
> -
> -       return parent_adev->power.flags.power_resources &&
> -               acpi_has_method(parent_adev->handle, "_PR3");
> -}
> -
>  static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out,
>                                   bool *has_mux, bool *has_opt,
>                                   bool *has_opt_flags, bool *has_pr3)
> @@ -250,6 +219,16 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
>         acpi_handle dhandle;
>         bool supports_mux;
>         int optimus_funcs;
> +       struct pci_dev *parent_pdev;
> +
> +       *has_pr3 = false;
> +       parent_pdev = pci_upstream_bridge(pdev);
> +       if (parent_pdev) {
> +               if (parent_pdev->bridge_d3)
> +                       *has_pr3 = pci_pr3_present(parent_pdev);
> +               else
> +                       pci_d3cold_disable(pdev);
> +       }
>
>         dhandle = ACPI_HANDLE(&pdev->dev);
>         if (!dhandle)
> @@ -270,7 +249,6 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
>         *has_mux = supports_mux;
>         *has_opt = !!optimus_funcs;
>         *has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
> -       *has_pr3 = false;
>
>         if (optimus_funcs) {
>                 uint32_t result;
> @@ -280,8 +258,6 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
>                          (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
>                          (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
>                          (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
> -
> -               *has_pr3 = nouveau_pr3_present(pdev);
>         }
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
