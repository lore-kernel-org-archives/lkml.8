Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E3D205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5jar91q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbgE1NE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389949AbgE1NE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:04:57 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69EC05BD1E;
        Thu, 28 May 2020 06:04:56 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p9so205082oot.12;
        Thu, 28 May 2020 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXvaWSVcWI+s2rivrPO3m0AhkrEjwrLISc3YJtC2j14=;
        b=s5jar91qveoXsSmBnvJBdN6BXNkjNpmgqkD0I8+dlVOqaPVHIc0Qw5eCo/TCcJGgqp
         o+510nC/x4mxgwJVDRetJ7bF36F+Ry4m9vUd3D233ZVFWQn2++PSAMHFb/QKm8OufiiZ
         vRNnOgmZsXixMKQYqZe7JN1Y1KnHAlOP7M6E9rlqVLocqc7TN/DSTMqjMaFOBhYKhLca
         YhfFNPbqx/hA3EqrrbvSRWM4YVV3oMxU6seI/QxxMSlyD5ncrJA9+FlXyRkHeY80nqto
         RPM5oFI6IjrcXrsM4+E2eZMrqRNKRlV3TvY5wPLJQe+ZeQnsYXvjuXaUBB4BCAs+FrPi
         6jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXvaWSVcWI+s2rivrPO3m0AhkrEjwrLISc3YJtC2j14=;
        b=jgLzdHUoxdQji47ytjtXn1zDxWmRLRhHtvT+rAauzE1vbagMjrMkHCBULFA6FtbgE/
         Bh+A+Nxk8UyZHx5MQ5cQnr3xSLTmLtShoIWiyL1O8Me8d/zSabjs3Zvpu7Jqv1xIjlvr
         KAErfdYoT7qozEnFWYt5ajgXmIISO+7uZG2tIKNWFik47dkyXQuBA84M4bNopEi9jKKJ
         2FbcerA7JliecVPp78POFsslf6haWhCnnayjjeFCJQWv6OhW8jrICW2vVB/CSgd2JE+P
         aUKylx8jkgWeraY6YANdMH+ofzLaukAdFK1VpWJaUqhT6lhuylk4LsIQv9XgNQfRIefd
         q+1Q==
X-Gm-Message-State: AOAM533KtIbPDfcCvZqm4SBKtXbJiq1reCtSRqMWN3hg1bEL/ONZBkip
        1LQmv694te3sOqBp+b6ZX6wTbi/5hYxRiOxvSUs=
X-Google-Smtp-Source: ABdhPJzyKhFsbHsoUArICsjrlH/FRsLsBzb83SSuwMvyuJNbabfEHdxpBOmN/SFsVOgT/6UMtLY91WnIexORQ4O1rDE=
X-Received: by 2002:a4a:874c:: with SMTP id a12mr2388682ooi.77.1590671095963;
 Thu, 28 May 2020 06:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528123726.GB1219412@mwanda>
In-Reply-To: <20200528123726.GB1219412@mwanda>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 28 May 2020 16:04:29 +0300
Message-ID: <CAFCwf11CwBwHm5MVN6Mg8wXy0O09yKb-RtYqSa4Z3Wv+SrfcvQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix error code in unmap_device_va()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, we already have a patch ready for that in -fixes branch that
will be applied in 5.8-rc2
Oded

On Thu, May 28, 2020 at 3:39 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Smatch complains that "rc" can be uninitialized on certain paths.
>
> Fixes: 8ff5f4fd40df ("habanalabs: handle MMU cache invalidation timeout")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/habanalabs/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 4b8eed1ca5130..47da84a177197 100644
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
> 2.26.2
>
