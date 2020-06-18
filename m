Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6009C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8991620885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyiK1wNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgFRCGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgFRBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22188C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 18:22:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so5211063ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaWvn+LzUrHwIuJUNTAyXF6UGUzwalmGorSr6oFx2Pg=;
        b=kyiK1wNG4Lc1N0Lxuahc3vmiBcgTlXg4PJWgxJSP5mw4VmYChXwPMuSZstk/LEiGCy
         Wqeg2Aokh4FaOjKTEVe9x30C9v7tMTr7LNZz2iCJI5Nh8Liv2/uxRsMncj7yAYUznsNT
         rauLfl+HFjPm5dxjEnqpV8cTxuJNK0oXK6Ar/JfTFMYx+uIlN6NNeqXukmkZ99Xas6TN
         mVDPyUvRHnviXRzZG+J/umdq7z4z4bNmn8E26TAo1DA9+9eQ8oc6GjZc6BiXb1T65MqJ
         BPzITKaqERM550cWLj1oAJSPULjZtit035usTjlJd5F5Ugq4+q6E1JMaNhj/KaSrIGie
         +xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaWvn+LzUrHwIuJUNTAyXF6UGUzwalmGorSr6oFx2Pg=;
        b=B5WFI/qenH9buOcwZ3OO+Y3sEOUhBATe7I7ctZFVRHgBGO3hCG5oQ7eumlFMMKN4Of
         JW1kGFC3CQj/jwEI9/wUvWChG7ry1W7MRgFkIavuVxXvZO25k593QL4JuDz8UAETtBbh
         KP18FibJzVWen+xOe29UEZiIxL+6Aaz7yzpdKK9QCGAEmqMkC2J3e0AduoFUJ1EmoT3S
         9kzz6ksWk2sfg8eW1f8niEPYDSs2Tcn/TSFaSxfQT5BbLSeDs/tefv+aly81uTABnP/Q
         P9s4mgx9gkyC0h0N4wHkVbVvnzzK0Lqfj3g1r1FJR8w48Jvqp9EQQtOIr6GfBXHqA7qq
         dz/w==
X-Gm-Message-State: AOAM531f9k0IGvSovRZJzyHV7KCKBmIPMgnJH9dzijtgPpGemgW5aBX+
        bXI0rsMVE3NMxtgp4FztssPFrS07SK3zOLRxJN/MPw==
X-Google-Smtp-Source: ABdhPJwfnBt/yiNef2EujnYSVQGXdREHugwntNCW5jy9ouvVu3ePlXzbuRHAY1CGfVcxCsQcNgeKwMv/f+M6q59Bx00=
X-Received: by 2002:a2e:9e86:: with SMTP id f6mr875898ljk.95.1592443346675;
 Wed, 17 Jun 2020 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 18 Jun 2020 03:22:15 +0200
Message-ID: <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Thu, Jun 18, 2020 at 12:02 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 21aed0981edf..e368384445b6 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -5,20 +5,20 @@
>  #ifndef __ASSEMBLY__
>
>  #ifdef __CHECKER__
> -# define __user                __attribute__((noderef, address_space(1)))
>  # define __kernel      __attribute__((address_space(0)))
> +# define __user                __attribute__((noderef, address_space(__user)))

I guess `__kernel` moves to the first place since it uses the first
address space?

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
