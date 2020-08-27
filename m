Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5CBC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1A920825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4/JagsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgH0H7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgH0H6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:58:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212BC06121A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:58:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so5340962ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuLXNyha0lqg7j7m5Rp3XaQtWaFfjLEZX3AWiS0341M=;
        b=a4/JagsE2d5QDKSxVUQKXCpZL4FC89bC9TWNbX1lSIb17nBaIcDTktu3KI+Mw25azd
         C26KqfmBedaDszcC0j4ZbqJy/BNQayw5YlU6Pwn977XvM96gavPPEUeHrGT1YBsqPx/R
         mqYv+aZZDkVMtTr9FZr39qmMP9Bfahe3jZs+rVgSLUIszdzCNjQI/IcEr/buFP7qN3JX
         weCFnSrrik63sRfWyDm5mjoIA8NTXBfc0SfjZIufIhxm1xRIOz6IpnPp5YvuNvgaNRyc
         IN/Yj4aFfzs0bUBkbdNFu3oUH0j+yxlOo4IM+OWhcAogpMhvcGOeg7oaHl0TKXnqADZZ
         F/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuLXNyha0lqg7j7m5Rp3XaQtWaFfjLEZX3AWiS0341M=;
        b=EBG7gDZhm2Au8hZ0BW5sRIYpI1IjorjN7iUTvRtJsatT1tp2s/gp49nGy57UOc4PW8
         FG4RSrEU9zJTi1GvsZDxrW1pf3oy/7DW9rLraBSdb8aY/eq3xXl81fKB08lgrJ06ol92
         RRYO04Z7veeDI5Z7SrIuUVzkaCYLuZxRU0l1cMYhBFD/eAuSpVdqzb5008v8AbMYSABc
         j8k45Tmbz3mJa9UFlE+ruInBrWXtLM2sTI2blVlFFuyl4fC/sOcTF+BOd3nDO4tus2EY
         rsuwL8FNRj6N5UGqjJ3xWfLO8qAbnjAbZrYZ/nQ+bSYMbkQwftmoGy5c3v1fWrFdkUpK
         b3EA==
X-Gm-Message-State: AOAM532nq9a1f9wyoMjryFhePps7sOR5OBK3bw1J/uiV448RhmW4ltXE
        qf9+8/wfsqXioona8FTljIUMmp03XoJvlk0uPik=
X-Google-Smtp-Source: ABdhPJyr0/Lz4DoZFMD/P+AdG59h1FF8Cj9Eb7ii7Fr3krwiJR9gsMV3iJf/Ezhgd9n2T/cZFeXrmyO74yRwaN1QaBQ=
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr8115988ljg.95.1598515088235;
 Thu, 27 Aug 2020 00:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200825143540.2948637-1-ndesaulniers@google.com>
In-Reply-To: <20200825143540.2948637-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Aug 2020 09:57:57 +0200
Message-ID: <CANiq72n_c2NQaTezik6ozA-Q_Pow0CrnuHo8xKf8KMSe=3X71Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add LLVM maintainers
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Nominate Nathan and myself to be point of contact for clang/LLVM related
> support, after a poll at the LLVM BoF at Linux Plumbers Conf 2020.
>
> While corporate sponsorship is beneficial, its important to not entrust
> the keys to the nukes with any one entity. Should Nathan and I find
> ourselves at the same employer, I would gladly step down.

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
