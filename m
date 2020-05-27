Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABA220888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6DH88/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgE0Kvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbgE0Kvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:51:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E1C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:51:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so18832149otr.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1OfjJtStUDpLG+yMvZjSfWSgDroVWfrlb3y+y/FM2U=;
        b=H6DH88/U9qiHO/47A2bPsPmDMF4TNNax4fhe+WHG0cMGK7edl+mp+LGMxcLwnoICl3
         dhQDz+9z3Wl4RH7ubxTvXnZJY+BGdWfmjIIoh6GqV0RlUEZxNdNRinBGLLS/eZ4xhxfc
         gpKudpxLtNv7SSQgP+u5ZrDwq4Ps0m5s9PKkFosGa5UYdCQvjpZUSNIsyHonRM09Jabe
         yxcHefBAmXJapVg2xw5iVFLCM6Wd9qb/4EmiZtOSdOqlFrnZOH8WFHbh0P951R7Ep7L0
         m113Y5WbL6T7XiT8b9hjovLe55rWd/4A1fC3dE5lhP3Q4v0Lr43UBw+eavgejCqx1xAr
         XTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1OfjJtStUDpLG+yMvZjSfWSgDroVWfrlb3y+y/FM2U=;
        b=J3AxM5oKu9SPPdLswWbyEVV2GP4rCI9XDFqIqsWRhc+DonOQkwzDNlAzd6TDPPRM7D
         +FTgbXv6KE7uxf+a2z05UOnYAf/T7/b0UO/M1s1yd5YAMq3g+AHO8BahGyMTiprRrTDK
         Tl7PcXeVVHGZgdcAI8vr1Qb45iYHpBOCbG5BmK/K7GCUC6V4rY5jI1XGJaxj98L4VUm0
         Nyi0hqm6aSnGp+l+7NpxatcvTb1jbzyT6zjFi9Pw+8eIRaua8askeVR5wbLhwt6Of2g5
         uC324YuCSLX3BY7iisyRzzgUxARt4aXnc1brFBZB/iLwArkrPeHBDvle6LpLtlxlnubu
         eRXQ==
X-Gm-Message-State: AOAM531RYClPVKRMnW/gSIm2CkJ6xocdaR8YMCJYE+D6O9u8NCCWFyhg
        v8XHKUQKmRjFkIUwGBM6YHCgmYRXcfZPqS4hGv3Xs1z0
X-Google-Smtp-Source: ABdhPJybsMlkpIjMB/QF4s+x5tFX4ZQ6WYhexPp3eSHoTEMNFpbe71kefkuj8/qoNwkAwEKtX+xvfj0OP/UbLQzbp70=
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr4414092ots.143.1590576708211;
 Wed, 27 May 2020 03:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527080029.28989-1-ttayar@habana.ai>
In-Reply-To: <20200527080029.28989-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 27 May 2020 13:51:21 +0300
Message-ID: <CAFCwf12AG+LYQA=eesdv5gnUqVJSqy-to-w9XPyYj4A3rMNBzw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix static analysis error
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     SW_Drivers@habana.ai,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:00 AM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Fix the following smatch error in unmap_device_va():
> error: uninitialized symbol 'rc'.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 4b8eed1ca513..47da84a17719 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -1023,7 +1023,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
>         struct hl_va_range *va_range;
>         enum vm_type_t *vm_type;
>         bool is_userptr;
> -       int rc;
> +       int rc = 0;
>
>         /* protect from double entrance */
>         mutex_lock(&ctx->mem_hash_lock);
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -fixes
