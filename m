Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA3DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B852065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7MwXVEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgEQUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:25:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:25:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so8226933qka.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eQFoMfc4wiRHArKbIabU/xQTAzEWkb3eRCH2jQlOh7w=;
        b=L7MwXVEtX8NrbAx3rhGebDUn1YU5iyNHc4/pQtu9ATpDmBRegFBlcy6WZ5R03Ugxat
         h5rCaTHNwx0fh+9lihPP7Gcedipg1dXvJ2n3z6Z147AusTTQ3CJVmu/6pOYFaT1Ln1hZ
         srzAseYhWiJpXpBSG6zlw6O/L4x6lQU0jHtMz+ssNVjJE/JIjtg99ak7OHX1hXLhoeKK
         3nBokB0RWgX/CWtmslrkveTfacx5FNJjeHC0q5CEi/fUoRrW+GJVbFBA9bPP82paCzBH
         Ne6FKS0vR+9yQ6pvBNbL+dVyKxMDkp7HJvEDkogmN7ilWWUXSfqOMiSu+Rn/sBmRVybA
         7kWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eQFoMfc4wiRHArKbIabU/xQTAzEWkb3eRCH2jQlOh7w=;
        b=mVQ8HHu4W2hpVl0PmEsKtUO1Z1/8UU3rXK5dgfhsxLr9FNjj/rRcI/ha8QSJnhzybU
         M6v+NivavAS5KhlKapswdTYS6dmVXypO1QbhCkCfFAUCeJYw3QIfN1vLqDU0dPJ4OjGD
         wHk4R+UdOTADW6vTl7D/rwQwv4cWeDp6J47WYbccFqWhpHSO+qbRDj655ZOS4QWD1m/I
         b27dozin9VOZNXCelD1w2l7xcKZUAzmXx+7FaljtBG812X5NO93dgYxqh0w27yMJMV09
         Ie+nFoNA3Cb4fCaphb5zZp2jfx+QoRWklhi0GYrJlvRqCHNMqQHzTaEsq7ejfZKXkOPU
         RNAg==
X-Gm-Message-State: AOAM530OolbRgQsFWkMlkfbcHlN+uRHwdYrudS5lSjk+Kx7AqD3bSRjk
        +mGd3KuUSN3Jzq7yYHtbSB8XF6e6UxqFj+DirjkoBJNPEREzPg==
X-Google-Smtp-Source: ABdhPJxJAlEdlloQNNu958JM4j2/umjLem/eeMitB8IY9psUhZcJd1KidorESNBEOaegBsAPh3xxlPviRdEioxp9K3o=
X-Received: by 2002:a37:8844:: with SMTP id k65mr13146388qkd.309.1589747122417;
 Sun, 17 May 2020 13:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200517165819.136715-1-pterjan@google.com>
In-Reply-To: <20200517165819.136715-1-pterjan@google.com>
From:   Pascal Terjan <pterjan@google.com>
Date:   Sun, 17 May 2020 21:25:05 +0100
Message-ID: <CAANdO=Li7FUbVQk6m+CksZBv1zy-F+-1tN9oYZ4niYJ0utRfXA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: Merge almost duplicate code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 at 17:58, Pascal Terjan <pterjan@google.com> wrote:
>
> This causes a change in behaviour:
> - stats also get updated when reordering, this seems like it should be
>   the case but those lines were commented out.
> - sub_skb NULL check now happens early in both cases, previously it
>   happened only after dereferencing it 12 times, so it may not actually
>   be needed.
>

Hi,
I actually noticed the same duplicated code (and same late NULL check)
in drivers/staging/rtl8192e/rtllib_rx.c
drivers/staging/rtl8712/rtl8712_recv.c has only one copy of the code
but with the late NULL check
drivers/staging/rtl8188eu/core/rtw_recv.c has only one copy of the
code and doesn't do any NULL check

Now I wonder how to proceed. The code is not great so it would not
feel right to make it reusable.
Should I continue improving it on this driver only first (maybe trying
to reuse ieee80211_data_to_8023_exthdr from net/wireless/util.c for
example)?
