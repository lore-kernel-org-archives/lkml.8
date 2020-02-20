Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B84C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CBA24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry1+5B0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBTJhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:37:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41435 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBTJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:37:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so2522206lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtNE7R1cdzCgHkHKWaIDSRv/qlQEr1YAvY7nMPkuk3E=;
        b=Ry1+5B0ku60NPbwBKgGCnuePw+cTx/ek7sW352LJcn8GbGrHTAcNzmTlA/NDM3t/mV
         S3TTYcV6QyTgFknQD2AnJGiRgVo96WZNrX0PB4iElIh7eYy6mU3/S9EUWr91PM/KOtiA
         dB2cmmLMY8DV5AK5GeLhf92jeaZNd5CZWSajL06XvYOe65dKAKZTWErzx5/NwOFrhQOV
         CqGY45IDazBJPe/lSyLwZSqL3AyYU/JvoUjc+ycYLsXpsvxlgoXhn9XKM6gnEPCFVb3W
         yqOkC+5SkIgh7o6YOXT156Ou19EoHmoTrHca4+trYo3R8Bawhz2GMLMWMIZm2qAryraj
         3QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtNE7R1cdzCgHkHKWaIDSRv/qlQEr1YAvY7nMPkuk3E=;
        b=IKqILN2f/8bOEiymXxoLAnYDM6mLKSvvSis+fJlQV1LfoFTRDx/Em3YBxTSyaSW8hQ
         iw/+3F+Ov5LuK1z81RzIigWMi3O0P7k+4YLikXUWkIpKYPwdHqX0JK2yxREbmE3E0Y/p
         34line2zVpsximFpC20mzhy4G0cA+4tthVGbFiUrs7Z8Q9WL2tGSH0bsfebPZ+uqggtD
         K5x1aosnICTTONkSX3vUyNOHDIQwIVMKd6P7ytqV8rO28uQ9+TeJU4bGadhpqc9vQ4wS
         gh9yC1R7SlwxNoM0ZNt4ebL9zAbYJdzm7dQS/imBdIWtC3dhUYBCUK1+fJlKYqGX29Ts
         OiAw==
X-Gm-Message-State: APjAAAUKzbG8YxuQ3C4b6ODzBxhYUwND1OXXKoUk1Zhy4xsWXwpN+Tzo
        iVRZChsEsOt4P7IERFGKytKJ+T9+a8qV946YT1TQgA==
X-Google-Smtp-Source: APXvYqypvwI9StShfZl4pc+4p+Cq9CV0B0ehnFtCEhozz3HoJoBuLGpcbVviHu6TWXs2BmdXbej/SzC6UWmX39VWoAI=
X-Received: by 2002:a19:4a:: with SMTP id 71mr16259055lfa.50.1582191437103;
 Thu, 20 Feb 2020 01:37:17 -0800 (PST)
MIME-Version: 1.0
References: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com>
 <20200219012736.20363-1-almasrymina@google.com> <CANiq72=DUyJA0u7buHv6gJiHib22ix-1Krgacx-vCkU27j_Qzw@mail.gmail.com>
 <CAHS8izOBDxoDqyOQ2RkndRJ09yf2qZfoUvKdVqqfMXuKsYRjVg@mail.gmail.com>
In-Reply-To: <CAHS8izOBDxoDqyOQ2RkndRJ09yf2qZfoUvKdVqqfMXuKsYRjVg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Feb 2020 10:37:06 +0100
Message-ID: <CANiq72kvVzonsJX0Ggs-tLwXNd1hhZndeP1+ZG4+FLGZobfg6A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: Fix file_region entry allocations
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:28 AM Mina Almasry <almasrymina@google.com> wrote:
>
> I figured it was related to that, but it's still annoying as
> clang-format works perfectly for me aside from handling the
> list_for_each_* macros. I tried digging into clang-format docs to find
> the setting to add to the .clang-format but I couldn't find one. It
> would be nice if someone fixed that.

Yep, there are a handful of things clang-format does not do as we
would like (yet). Nevertheless, it is always good to hear people is
taking advantage of the config! :)

Cheers,
Miguel
