Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4882067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGQLYmHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFOG4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgFOG4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:56:17 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03457C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:56:17 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so14977577oik.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73Ts2qMXH6Mk0E17JEUm55xx1LaHy8Bs/ltMabJ68jY=;
        b=nGQLYmHsueXWbxKG1kVYjE+24DHTJ1ewdv03cNfzLy+XeY8rnytRjaQr8YfZym/h24
         WBM8IoMdVHwVqVyx4h6ymeDbFZ6BmWCpZO0i+AgHqWWI6YYvsbqZKABIsqKKZVjOnSwf
         nn9cIYjQpdNmDgG/0lHuk2LURO3+cVqXubJ8+UaQUtgtH+ivNhxIw8wHUqEV8EEHjiBu
         zOF+OMqhXpKKkcU84svhWgH1IViNzpFr+/yUb6/hSIFaMkcE+L10+Mjrzy2KArqH2RTs
         uP8jrzzshwSjvheMU09gmz3GMnmr3jzTmK6ZUIw5a9aHlZlx4FJBMVTqFpm4GqZS00uz
         edLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73Ts2qMXH6Mk0E17JEUm55xx1LaHy8Bs/ltMabJ68jY=;
        b=jkNuQNnhnXe/6qIoRqQzBkZOt3n2+aQblRZML4ZAnGtuYY/7NT2Qi8/iKymSxtzW0t
         tvn1PeeCtO0fr47iQjoijsC0vd23qfiJqixQvFg+PFqxBVM/MNSgiHB2IAdirznVAgYN
         2EdKZAZ7gGIZNfcb5owyzRNt9pNmo2Ybnp3y+A8WZPcZrXjK1XzPrVd6LlZ2P/ltgACs
         sNlzXX8SABqN5lRRqFfEEMRMoXbUjU4OZUPEn/EpERKe/m8PAxyJk+wRnwbEk39lh2KK
         qKIni7X8ohx4QmyGgaPcbt6L8rcOTCEDUTMqzGJLmRE5By0LfMr9NXQU975O9Jh2PZef
         WQVg==
X-Gm-Message-State: AOAM531qsPvU5fWxHCnU0jEbNEUgzn9Pr5vq2nG1n8yR7WtUk3McyQ/V
        QnoIuDu6Vpy1hEHsGVpsufAiVnC7hFPAzlImobRhNA==
X-Google-Smtp-Source: ABdhPJxQ7ISL53JwI1Q9I8Kl5dM4xMqKpvsGJQSzXU/a/+efq0V4MqOryLsRXU0rF5e6a6/v71OlDfykhZ8OQeQ6ETI=
X-Received: by 2002:a05:6808:34f:: with SMTP id j15mr8004157oie.121.1592204176060;
 Sun, 14 Jun 2020 23:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592203542.git.mchehab+huawei@kernel.org> <019097f1fe10e38a04b662f1d002ecc0ce8bef8a.1592203542.git.mchehab+huawei@kernel.org>
In-Reply-To: <019097f1fe10e38a04b662f1d002ecc0ce8bef8a.1592203542.git.mchehab+huawei@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 15 Jun 2020 08:56:05 +0200
Message-ID: <CANpmjNOG2PmMoCQgNk3cJrm+ZFP0+VYpBWma=xRfqoyxbLZp9A@mail.gmail.com>
Subject: Re: [PATCH 09/29] kcsan: fix a kernel-doc warning
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 at 08:47, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> One of the kernel-doc markups there have two "note" sections:
>
>         ./include/linux/kcsan-checks.h:346: warning: duplicate section name 'Note'
>
> While this is not the case here, duplicated sections can cause
> build issues on Sphinx. So, let's change the notes section
> to use, instead, a list for those 2 notes at the same function.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  include/linux/kcsan-checks.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index 7b0b9c44f5f3..c5f6c1dcf7e3 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -337,11 +337,13 @@ static inline void __kcsan_disable_current(void) { }
>   *             release_for_reuse(obj);
>   *     }
>   *
> - * Note: ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
> - * checking if a clear scope where no concurrent accesses are expected exists.
> + * Note:
>   *
> - * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
> - * fit to detect use-after-free bugs.
> + * 1. ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
> + *    checking if a clear scope where no concurrent accesses are expected exists.
> + *
> + * 2. For cases where the object is freed, `KASAN <kasan.html>`_ is a better
> + *    fit to detect use-after-free bugs.
>   *
>   * @var: variable to assert on
>   */
> --
> 2.26.2
>
