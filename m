Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6658C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CCB20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTjGSjVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGHXOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:14:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:14:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k71so238909pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYR6IzEE3oz+7wpFFvhpcTfqtHDsZd22LZz7dy8Rcrs=;
        b=rTjGSjVlJBB4jdk6XG0IoWtkdWEPchWM3kX0LUZqK+QG3RfYTKSh1HcjjG4R+e1Age
         9wC+YLJjGetare/KcKfoZRMy2G7Y3XktJSg/EvKyT2Y0Dcj6NrjWSPA3QJfX794lFLzJ
         /msYFXN5tisnhghC2UgmzFTKkbh1sgTrRsEiNGAcG3Uu/ZH9rLBvjuVi0wkFfGqOpbiZ
         uHMwi/tUA3/BNrV9msotuLeSv/cUDRmQHtepVUmJNx/XBEjS8IXDLT3Y00kUUV8DB5yG
         /S6aAefIn9xwlJazqRIwL8sg67hvU9nQHC4L5U4IHQpVEsnQvNVfDnU+IltJjtCZYmap
         aL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYR6IzEE3oz+7wpFFvhpcTfqtHDsZd22LZz7dy8Rcrs=;
        b=IZj9jOsVGjb1jszOqRhTxhdnA6pG0dsxSnmyKL19gEtZhDTVy0iREGsT0AnEiFCtZw
         rRXwTN15PmZpTYgnGzHYuAgdA48oFyNUIXMMIcGNrl6MjyxaW6NwMLxabdDfrWa2sWCH
         TBokE5QpkLfdmY79YjhZLkq/K5YhhTQBSs29RtWj/oXMBkGF54I0l9gXt0hu1u6zRzHp
         pDIDkAYxcBtMGXPx+sM4TDZc8k/cLAhgWQ7l+MzoMUztu/b84y0AxgaiU7q/2aGG8w0m
         YibBKyqKNwAAJIMsTpdnWkUZztrYQstcpFGkzPmHqxlUWu4+jzo1UHe8cLt3zKx9qo9y
         Luzw==
X-Gm-Message-State: AOAM531TspvZYv4ahO87MWS4Nlo5S1r6w3AKLGL///hIToB+eHBVb974
        Lg888qlNNRrXsePsnqVwkwM9SEzGBnPRGhliJMiBPA==
X-Google-Smtp-Source: ABdhPJyWcE2sHGr6AH9cytVw+nIBQUYGxbilZCX6xRQxheRVwQBKF7gOxauthBDHsPRnr2wxHNeDZOCqINBLQjHgsZ4=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr12309187pjc.101.1594250046373;
 Wed, 08 Jul 2020 16:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200622231536.7jcshis5mdn3vr54@google.com> <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com> <202007020856.78DDE23F4A@keescook>
In-Reply-To: <202007020856.78DDE23F4A@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jul 2020 16:13:54 -0700
Message-ID: <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This looks good to me. Do you want me to carry it as part of the orphan
> series? (It doesn't look like it'll collide, so that's not needed, but I
> can if that makes things easier.)
>
> Acked-by: Kees Cook <keescook@chromium.org>

If you would be so kind, I'd owe you yet another beer!
-- 
Thanks,
~Nick Desaulniers
