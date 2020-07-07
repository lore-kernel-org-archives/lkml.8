Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D31C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DA920775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REmyZh0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGGMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:34:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2FC08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:34:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so46083908ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f2289XWaOIfW9z5LP7QS3s93Z1ZNX92UPi5LaG1e8w=;
        b=REmyZh0QiGlSAQ8o1+EPSt6Bf0fvrt6ukZ6LpMzsdMjLFMFSJm9/nHklr5nPLRSyvI
         r6ar5JhU/uYwC5nsqDYpsRmBjGCuJUWQv1OzOhdo5dBBioBuKo4wyLF2uHeCbjY8Ws5C
         Gw0U1IoEixHtq8VRVRnkSHB1eulc2XTKOvuWAeI0eS6lck672sfoZ4pwBX5Fk1TexIrW
         7uznhBNVlDLspoyxTtrq0LSocmTQMyXddkGylZfhMPIVETu8pVxGxuCRUhiECPvzz8Pq
         KZksv8VwxTVsdXasl1mjwwprYQBLGw3m9LLfVUARC6Zrcs60agzfKtXiV5cl6yxGN/VS
         mqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f2289XWaOIfW9z5LP7QS3s93Z1ZNX92UPi5LaG1e8w=;
        b=h34AxIXFliMa9W8XzRYvBw7tJ2JVMgtK0C/4AMk603kqGogZYppx1Pxs/OOwsOv+50
         DyyQVXvVpZNDEi7esK2i8caxkoRiejFxIfJ/x0nvBMgcAYhAXv3++7dvaFbLttZaI6ac
         0UiSsk/oaoq/mGvO55LOaYy044ZwY8VoefBxuAdzzNpyz1hA6B6ebH3O/k/kiQEYmQHQ
         LwwmRsotSxvXaaTZA6tHtffkT/lnm3cgC0oI34sDGJt31OdgVPATnC4zz7yX6kK6zbd5
         f4IKSzKfaypLVgoX1R2JD8KVt5n3IHfCofHLZbXKmIwYeyv0ntVVBACUd8/qGsILpHfC
         TDUw==
X-Gm-Message-State: AOAM5307kn46r52J0rc5WgF70TME29eP62JZ7s56k6AAgT9tWyFKXJqz
        skiRRkkpwjgkFjrSxUfFC9th7OpFp4xANsxKKfRM1w==
X-Google-Smtp-Source: ABdhPJwjEdZkw+eDahT+sUrZ0kdRgPaA7Y55vyrXTG6xW6wfrneSp67eE/ehBWGax8PbU9J+XvUZaq/B24TkV8j7FJ4=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr14141732ljc.104.1594125273794;
 Tue, 07 Jul 2020 05:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200624150704.2729736-1-lee.jones@linaro.org> <20200624150704.2729736-8-lee.jones@linaro.org>
In-Reply-To: <20200624150704.2729736-8-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:34:21 +0200
Message-ID: <CACRpkdZq_O_jacgAdnS_vwZe4wkuTSduUjmkG+EDQ8jQYQzSJA@mail.gmail.com>
Subject: Re: [PATCH 07/10] mfd: ab8500-debugfs: Fix incompatible types in
 comparison expression issue
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 5:07 PM Lee Jones <lee.jones@linaro.org> wrote:

> Smatch reports:
>
>  drivers/mfd/ab8500-debugfs.c:1804:20: error: incompatible types in comparison expression (different type sizes):
>  drivers/mfd/ab8500-debugfs.c:1804:20:    unsigned int *
>  drivers/mfd/ab8500-debugfs.c:1804:20:    unsigned long *
>
> This is due to mixed types being compared in a min() comparison.  Fix
> this by treating values as signed and casting them to the same type
> as the receiving variable.
>
> Cc: <stable@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
