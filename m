Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72BFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9159D20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM3W2w5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgGWOVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgGWOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:21:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B4C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:21:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x83so5105733oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho1zGHjnuSGDFtev9MLuATNuOooj2fcyX8jL11zoph0=;
        b=HM3W2w5nySJMCwxvxz7t1p2dBIIUgMKrcMzzDQiNx6rVXq5XMHQJz77XUdcWV8huvr
         QmnQuWOaTeE3CyVEcBohDEDeq3kWjQNrpJE2PwxR3iF3hxDd5nZGBlyeg4LncNnyffnK
         FQGhLwslLGdxJPUQLTM/0IdsTZppDicQb8ZUkDnLN13vP0WJbZcNv1yrFEcdedwizzKh
         u0MGb1aDWpJsR5meyYo2REC49bck50/0GsBFbZ4TC/rMdBWZjH0rAtmPLGbyUxgsR00u
         SYARW7sbNI9GUM5fzOGYGQTHJ+O/YLBfIGYTeer9YYgt3txZU53cGYoIOe2r2C33tpkZ
         Cuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho1zGHjnuSGDFtev9MLuATNuOooj2fcyX8jL11zoph0=;
        b=FeVDVKaBvY/Eb0Npvwnass5rWmGsKcXBHlrv5XIAgY0ajs9b+vfB/AHsfHSqBAC1LZ
         r1ujZY+z1DVz9r+0IkCKHsuJcOg6O6Henuie1X3T2XT5JlqRXw1uhRKEvEtz4ZbDIAMR
         uE20baq2eaSngjjby+C6TrsOf8JbzLzmMv6m/9CIk9ztAayQ2FTuSIR4/fN7poUqYZF3
         hAzbhHhQkqUvUSriotzNjXTPTq6IXXfGtimy97Q3uIiXzET7SeCwylEuKA8mpjvE9Ae5
         hnneYWPjk0vhZFyzLf4AcSBOjU5qE2hGTBxx0bD+e4RZycD8BoYsdfcumCYYH2bh6yoa
         J7pw==
X-Gm-Message-State: AOAM532fOkPqrQ+ZtHsVov76/BkZ3cngAXVHSSVrz10AIP2X+AHJOO5u
        PlvX9ONV6QgrP8TahlGKCy320FxaBwjHWjlHtqDO+cW/
X-Google-Smtp-Source: ABdhPJyPbrPOe7bzTiWgCeqX4KXaO4HdpYUmFIdSGyIrCwsrNswTXkOLWm6PAzq47W5+M40oucZFaAOrpxyBRuIeqfI=
X-Received: by 2002:aca:57c5:: with SMTP id l188mr4082203oib.154.1595514111292;
 Thu, 23 Jul 2020 07:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200723061757.12906-1-ttayar@habana.ai>
In-Reply-To: <20200723061757.12906-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 23 Jul 2020 17:21:22 +0300
Message-ID: <CAFCwf11+ZV1no4Sew8LU3sYh7V4wO=iwmPkohob9tbnBzOA-Og@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix memory leak in error flow of context init
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 9:18 AM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Add a missing free of the cs_pending array in the error flow of context
> init.
>
> Fixes: 4b49c5b118b9 ("habanalabs: Use pending cs amount per asic")
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/common/context.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
> index b75a20364fad..3e375958e73b 100644
> --- a/drivers/misc/habanalabs/common/context.c
> +++ b/drivers/misc/habanalabs/common/context.c
> @@ -138,36 +138,38 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
>                 rc = hl_mmu_ctx_init(ctx);
>                 if (rc) {
>                         dev_err(hdev->dev, "Failed to init mmu ctx module\n");
> -                       goto mem_ctx_err;
> +                       goto err_free_cs_pending;
>                 }
>         } else {
>                 ctx->asid = hl_asid_alloc(hdev);
>                 if (!ctx->asid) {
>                         dev_err(hdev->dev, "No free ASID, failed to create context\n");
> -                       return -ENOMEM;
> +                       rc = -ENOMEM;
> +                       goto err_free_cs_pending;
>                 }
>
>                 rc = hl_vm_ctx_init(ctx);
>                 if (rc) {
>                         dev_err(hdev->dev, "Failed to init mem ctx module\n");
>                         rc = -ENOMEM;
> -                       goto mem_ctx_err;
> +                       goto err_asid_free;
>                 }
>
>                 rc = hdev->asic_funcs->ctx_init(ctx);
>                 if (rc) {
>                         dev_err(hdev->dev, "ctx_init failed\n");
> -                       goto ctx_init_err;
> +                       goto err_vm_ctx_fini;
>                 }
>         }
>
>         return 0;
>
> -ctx_init_err:
> +err_vm_ctx_fini:
>         hl_vm_ctx_fini(ctx);
> -mem_ctx_err:
> -       if (ctx->asid != HL_KERNEL_ASID_ID)
> -               hl_asid_free(hdev, ctx->asid);
> +err_asid_free:
> +       hl_asid_free(hdev, ctx->asid);
> +err_free_cs_pending:
> +       kfree(ctx->cs_pending);
>
>         return rc;
>  }
> --
> 2.17.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
