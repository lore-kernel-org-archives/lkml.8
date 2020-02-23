Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61679C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3214E206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582493114;
	bh=UBZMLJ+hZwk33B6GKkoXn94+jtXkwzrj0yNNWPz/3zQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L5AC+IuzGC+vm+PHuQiqC7k5qusx0xEAFqpYPbzVmt3RmaKilrSIX1zKcJTrxLZ2y
	 L8RzqWuBMjIOze9+elaK7g1xJi99uMlafZTxlbiwhVYQJY/BrujHwx8+/IRf0QtDGw
	 zLvU4GR/ZtM4iV9eUkYpou4w7Tj+q530UXGz3y44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBWVZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 16:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBWVZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 16:25:08 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C7120880
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582493107;
        bh=UBZMLJ+hZwk33B6GKkoXn94+jtXkwzrj0yNNWPz/3zQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XkUKzUybg2pHtUVaVP9yJElwd741P/VdnxJGLiUaj5n3khB/T8MsfTcyiF25DQjsh
         YnLROAuTTrZYHcRiagNAXXsrOlPgTdi5pMkLJDSXFzz/thSYAmEdu9Vy2YAB9P1uvS
         NQkqe/05Dc1LUVi28ZoxakXhsEzNLJMO6ApN2c9A=
Received: by mail-wr1-f52.google.com with SMTP id g4so1707105wro.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 13:25:07 -0800 (PST)
X-Gm-Message-State: APjAAAXTl8DQW1ahKNUdrc+avBcQmo0tj8d/nfi8zvM3r1xLQHaA/pDj
        LTAaRF16NXQvF5fc+p8lx4DNU68etxTWJwjE9wQvDA==
X-Google-Smtp-Source: APXvYqx5cdb7YOSRkBl6KJs6CwbRsq8y0XEDkKBScl7E1mxta09QfvSexEeWzzLkmkDwZiaAgEBpJ9t4aXi16/X071I=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr9787955wrw.252.1582493105928;
 Sun, 23 Feb 2020 13:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20200223205435.114915-1-xypron.glpk@gmx.de>
In-Reply-To: <20200223205435.114915-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Feb 2020 22:24:54 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_NoXwpgrdnTh54SJhCODoPc1WF0CUdQKGTM-YKqsJ12g@mail.gmail.com>
Message-ID: <CAKv+Gu_NoXwpgrdnTh54SJhCODoPc1WF0CUdQKGTM-YKqsJ12g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/capsule-loader: superfluous assignment
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 at 21:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> In efi_capsule_write() the value 0 assigned to ret is never used.
>
> Identified with cppcheck.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued in efi/next, thanks

> ---
>  drivers/firmware/efi/capsule-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
> index d3067cbd5114..4dde8edd53b6 100644
> --- a/drivers/firmware/efi/capsule-loader.c
> +++ b/drivers/firmware/efi/capsule-loader.c
> @@ -168,7 +168,7 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
>  static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
>                                  size_t count, loff_t *offp)
>  {
> -       int ret = 0;
> +       int ret;
>         struct capsule_info *cap_info = file->private_data;
>         struct page *page;
>         void *kbuff = NULL;
> --
> 2.25.0
>
