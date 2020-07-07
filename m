Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C81C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945CD2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljk5Cgum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGGMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:33:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33053C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:33:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so46080954ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPF0JvFJGRu0MJDb+xo/+g0FOnfGSe89EWgDZnv/5qM=;
        b=ljk5CgumTgOD4AurgcmJGCpCoc0SmL4X+mF3OtZln8cT9mLEF8oyiEC8nmqLtzRYKD
         FLYSSULnop3FJv0+vwRTIgXvktKapS93Nl+iA6UhhJNh1Is5Zi0ox/381H72KYn9tTqz
         4SmnmnSwd5DBCzJ8SZY3qUsMFmznlQcF+q+fvZKeXShMVFvJ+WJdVGgpmaTKrueR4dDw
         h2U2VaMhGO4m9vK84x+tbQpduvLzMf1aBu/8KCukU5lk/XHpUEtYo1DwYlCWZGAiDrN6
         MG0uaAoRfdz52ZNtkioWfOnUEGE0K0tLoD1eDVJo1u3ffBkebdkpb9LR423pP47PiB+j
         l8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPF0JvFJGRu0MJDb+xo/+g0FOnfGSe89EWgDZnv/5qM=;
        b=j7PtT6Zbl2cr9j99DtNv/vFbsUidfy2sGbcHwZc61vuhohLmWjR8L86wP5jj0vBj53
         K6gwPWxnO23kkToNy4ctpikjvnnGVBcqUMsavLIS028ryeCmGjK8Ann2AGhwt7Tyd8cx
         m+HrAmOoJQvh9zoFNISiERcgsOK1de43ipHkn356kZoDX5/rULk87i0ThIcOpn/+Etsx
         JhXzYqXxX+ihgRYmqmIocRrJEIdorYGe/btXxmyhBwhEh7T/dNxZJnmrwfREFdQK1ZGV
         WE5/HoVIYJmx7lxhWQkbHN7TI/iFpNlgZAHqLfZe3WfpstKUNfU/GchVVOa+bpCqMynW
         z+Bw==
X-Gm-Message-State: AOAM532KF+VJZasqF5rmDyD5YvJ6TYh5CFr1UCPtC7wJzLxhpcRjHtoq
        Vsy8yWkA1svDVjopT5j2cwMezwslN9M3f6nrfd/gxw==
X-Google-Smtp-Source: ABdhPJwm9uSvCy1ijsZZSaxkzwPkbMSb8dX86U9xsSnugGgEuoIv9dKGoYNkQ+OlwWcP85adtm2cZNokYOnEBnsAhZs=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr8689552ljj.283.1594125227640;
 Tue, 07 Jul 2020 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200624150704.2729736-1-lee.jones@linaro.org> <20200624150704.2729736-7-lee.jones@linaro.org>
In-Reply-To: <20200624150704.2729736-7-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:33:36 +0200
Message-ID: <CACRpkdYV-gUZJPtwdUhsrbN9hD9Eg6er5-kpOcPJ1vST8gDqTQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] mfd: ab3100-core: Fix incompatible types in
 comparison expression warning
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
>  drivers/mfd/ab3100-core.c:501:20: error: incompatible types in comparison expression (different type sizes):
>  drivers/mfd/ab3100-core.c:501:20:    unsigned int *
>  drivers/mfd/ab3100-core.c:501:20:    unsigned long *
>  drivers/mfd/ab8500-debugfs.c:1804:20: error: incompatible types in comparison expression (different type sizes):
>  drivers/mfd/ab8500-debugfs.c:1804:20:    unsigned int *
>  drivers/mfd/ab8500-debugfs.c:1804:20:    unsigned long *
>
> Since the second min() argument can be less than 0 a signed
> variable is required for assignment.  However, the non-sized
> type size_t is passed in from the userspace handlers.  In order
> to firstly compare, then assign the smallest value, we firstly
> need to cast them both to the same as the receiving size_t typed
> variable.
>
> Cc: <stable@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
