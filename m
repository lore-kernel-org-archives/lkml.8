Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E0B206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGE5Cdik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIGHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgIGHAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:00:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D56C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:00:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so7593914pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZB01nxLyQQ2oxAI+dDxfZXKWbIvB8x5H0InVProFwEk=;
        b=iGE5Cdikz2WDHv2brLa0kGSf0Oyke/kI5FiddDBhh+ZQu4j85gbU3TlsK0oCn2Lu0w
         hqcU3iLfW5vzpOogIiR3dfTDtzFuE76qTO2JIgH6nMQmsEZEWDgI0wqCE6WIRGk6A27+
         1RLgd92imZ0HxzZxA9lXP9kFMJFZRW2WZpfLSgwQSrhJ00/4+p08wqADrOPRtjaDnyvr
         SJrJ1nKQ3a8Ey7Uov3UZhW+p/Oc/7YDmr1VHA8eib4ofkHMi4By9OyXHwRJnI9g4DPNO
         PaxzkYx0GVXvR/OOkgOhvBGUApvewi6a7MRXJ2P5p/2ZqGjOng2enxCX/DFGsnxbGP/X
         io8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB01nxLyQQ2oxAI+dDxfZXKWbIvB8x5H0InVProFwEk=;
        b=MgbMDPlOLF6yAmCNvCV9rM4y1qDw3Stkgc1jDwzXudFEvsC4c3cO3G6MGHcou5c2v6
         rA1Qp6XMiFbr3TIEjWQQwBEnKtl+dbmNg3g9ZJwYtgqFqKBBXiyTQHkBKgiEfbgbo5ZS
         oEhJ2CdAoHU/wQ7P5/D4nnt2q2ovo6wHF1Ctd8p3wNFJCmNped3q6QfwZQD+FDnnTeJb
         u+OCeB2IGwV/HnBTIFwfznIpyryGmqpDfhk7yqYP9H+z7vT7npV6Pca8+lIvzZ14C2ru
         kxoJl3e+1ri7phAaqmpzIkMHN5CBhfmjwFf42kHK2auBuvkH23c3SWKNi5F5zo6HlsM5
         Rpow==
X-Gm-Message-State: AOAM533iZMCkMx85ZxKzTov19bdu9a7RHy82lU2z71bvET0mGYQPqSJr
        fvG1aAiOIXzoBr4ja8gdz5C1bsnmPbwdXivBzA9tJRD5AjX/Fw==
X-Google-Smtp-Source: ABdhPJxuNIxHplTBaOBAdYC4reZOx0YehpPyyImzvd9PJ/q1QoVrRnICkvZUEj+F6D3F2KJO1GuoRJoMsZo/pllt2kA=
X-Received: by 2002:aa7:8756:: with SMTP id g22mr18657106pfo.37.1599462025620;
 Mon, 07 Sep 2020 00:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de>
In-Reply-To: <20200904155025.55718-1-xypron.glpk@gmx.de>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 7 Sep 2020 10:00:14 +0300
Message-ID: <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> In the memory map the regions with the lowest addresses may be of type
> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> rest of the memory. So for calculating the maximum loading address for the
> device tree and the initial ramdisk image these reserved areas should not
> be taken into account.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index c2484bf75c5d..13058ac75765 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
>         map.map_end = map.map + map_size;
>
>         for_each_efi_memory_desc_in_map(&map, md) {
> -               if (md->attribute & EFI_MEMORY_WB) {
> +               if (md->attribute & EFI_MEMORY_WB &&
> +                   md->type != EFI_RESERVED_TYPE) {

shouldn't the type here be CONVENTIONAL?

>                         if (membase > md->phys_addr)
>                                 membase = md->phys_addr;
>                 }
> --
> 2.28.0
>
