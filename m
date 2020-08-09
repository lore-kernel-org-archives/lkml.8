Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C773C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661FB206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597002936;
	bh=2rAR+M5zs3J36b2LT6iT34FnFrmyMvuYFf/H5HRm2D0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nQuTpjjMB9Y+BSa25fDDjYYbgdCgYkzpxdBxXQWX17/tNRnRSJpEBoORg+qW3dDlm
	 Rdyjk6Qbepk97vTU4zqIiJZuR4tEojLZbOl/IRbAxnTvTDBjMHwm57RQR2n1a5gSW+
	 k2u3o6+8wqyllUYpuvljhbFZ0+c4kfSWUSFXISf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHITzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgHITzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:55:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D2C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 12:55:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j22so3629898lfm.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gb6GBTcn1DdG5c+MbfZGxeWOEsq1soV0Ir9YyDDSzao=;
        b=h1FboOCE7RlnYs62A2tbSEYOTjOhRbOyxysffdQzD97v64yqUYH+LkI3uaTSf73Ffz
         F/Wk/pzRKYDgYSUQJrPlZr627hNEwmRCKd7HGP8+n5OpijIXum4wlwitfZWSyD14YYsD
         OGw9ZyXnBt2185IQ/b/Xc6NtGDoeXKNyqsp6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gb6GBTcn1DdG5c+MbfZGxeWOEsq1soV0Ir9YyDDSzao=;
        b=AtgAzRB0bHzfkLnqQ/xjYNqODr9Hc8lBP59FfplKvsv4M2Ea2/y/StsBfHgpiIAQL1
         ySF8053GA/F7P7l5odURVPsCLGT9fr5FIonY0Ureq7RUiOR0lCnDH6DxPs3rT1lTV+9y
         8M1DioCOvI2BN3I6Qp3OwZa+dROIRLYzDkAZCZFXyLiYR+ZDvlOYekcO9z59JMI3usSx
         6df0+mFy4wSbFdzbCIZ9Mt/LUFulFk8pL6ogKEf0A6aqVNOSErFA7Ydkjxzuf7cNNbYg
         7pucmBnMjddKn+oF3+cn6JTrjHR4EshxFgWWdIvx8sb3Ppa1mlc4rVRnmkSO1XYIBr8F
         neYg==
X-Gm-Message-State: AOAM531zQpGet8jvEvafE8xPqNXCFzQSJdV5srDXjORZVNMJCv94eKVL
        0kFKNPJvM9R5ncpKggUAsMbIeMDTfSI=
X-Google-Smtp-Source: ABdhPJy6eSxdUSjwXBGUpnaN9S4faYaBsktqJPO5ki4Z+GsqXtlCF0yG/fWPNTKiyWUVfRtLmkuIHw==
X-Received: by 2002:ac2:5f64:: with SMTP id c4mr11862667lfc.170.1597002929503;
        Sun, 09 Aug 2020 12:55:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h6sm9386008lfc.84.2020.08.09.12.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 12:55:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z14so7413250ljm.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:55:28 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr9469780ljk.421.1597002927878;
 Sun, 09 Aug 2020 12:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
In-Reply-To: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Aug 2020 12:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHNkPHvGG_Ca_f8=+w5od9_XTQ8yD55+v-3WCKhvKviw@mail.gmail.com>
Message-ID: <CAHk-=wjHNkPHvGG_Ca_f8=+w5od9_XTQ8yD55+v-3WCKhvKviw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control changes for the v5.9 kernel cycle
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 6:06 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Driver improvements:
>
> - Linear improvement and cleanups of the Intel drivers for
>   Cherryview, Lynxpoint, Baytrail etc. Improved locking among
>   other things.

I'm having a hard time parsing that. What does "Linear improvement" mean?

Anyway, pulled and explanation left as-is.

              Linus
