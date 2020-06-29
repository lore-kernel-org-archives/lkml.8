Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA6E206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQSpfw6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgF2VQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgF2VQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:16:54 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F42C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:16:53 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id e3so5806466uan.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Glv9KPcU1i2kTi/iXapQFW9l12MhBnrThVYjifxz8EM=;
        b=iQSpfw6Tm/KPuTk+bUTfK5sUy4UnMTGDe2HrdR0LJ5iy/NBxQZbLKaAMr5P8IsFaKS
         jlx65KlHQsr6onY+QHMDKYDN0o/+INkFidVgT0E/5uY2DgBuPiWIVZPfHlo/wnPJUZ6E
         9jTXUZ6lxK0iNtd4wO6o08CCwbn+1DdmLYhvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Glv9KPcU1i2kTi/iXapQFW9l12MhBnrThVYjifxz8EM=;
        b=eZSOLjfLCLNTPgakZUZGP6Gs13hcaSC7hRC3n8cQPip+HqeoKu+MfJqT7/0kv0dj0C
         jI1nbb8zwJw7PH57wIEFGz+1UFcnyJq1s9yLP4i4l/djl4ymVVnlECQB2tE/NTEQb8cH
         S9LBOv7ZWT0AkXKqrIpuxwuH59eAkmnAybY3ou1ynUZ2B1dSap8Khd4widhw6K7ABF30
         D0DMuxbS3NsHTQJRZMU6GBmm3avhix7nzou2K1HSrqEj7lLSlg+C1LVNdNmSwkeCi5xs
         A2G+WNwz3HwYwXbWJoeRX6bI4QbLmjFw6Z0Ca3qQGkdIAMpGKfZAolYxnPUOvUba93+u
         Si2w==
X-Gm-Message-State: AOAM533X/WRAfqBH15rnEms2H6CVkMt6dwc6uknh8w+a+8rjOZOccmCD
        1nHBHEjiHqIb4JfAQYV69qTxd/0o3UE=
X-Google-Smtp-Source: ABdhPJzVSmtEtrcVFXXzdPcfzeT/wrFBA5UMHTzNqDsKEMzgXcV2FzMH9sJyDDmHCjq/qZWxY+0FMQ==
X-Received: by 2002:ab0:3055:: with SMTP id x21mr12245784ual.106.1593465412330;
        Mon, 29 Jun 2020 14:16:52 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b9sm89814vsp.24.2020.06.29.14.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 14:16:51 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id q15so5595845uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:16:51 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr12275723uaq.120.1593465411383;
 Mon, 29 Jun 2020 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200629153756.cxg74nec3repa4lu@holly.lan> <20200629205012.3263-1-cengiz@kernel.wtf>
In-Reply-To: <20200629205012.3263-1-cengiz@kernel.wtf>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 14:16:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWYKqHEMDt-0PYHty_syJ9MO6Oz8DVBbacNZS5zGXk9A@mail.gmail.com>
Message-ID: <CAD=FV=XWYKqHEMDt-0PYHty_syJ9MO6Oz8DVBbacNZS5zGXk9A@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: remove unnecessary null check of dbg_io_ops
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 29, 2020 at 1:50 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> `kdb_msg_write` operates on a global `struct kgdb_io *` called
> `dbg_io_ops`.
>
> It's initialized in `debug_core.c` and checked throughout the debug
> flow.
>
> There's a null check in `kdb_msg_write` which triggers static analyzers
> and gives the (almost entirely wrong) impression that it can be null.
>
> Coverity scanner caught this as CID 1465042.
>
> I have removed the unnecessary null check and eliminated false-positive
> forward null dereference warning.
>
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  kernel/debug/kdb/kdb_io.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 683a799618ad..4ac59a4fbeec 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -549,14 +549,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
>         if (msg_len == 0)
>                 return;
>
> -       if (dbg_io_ops) {
> -               const char *cp = msg;
> -               int len = msg_len;
> +       const char *cp = msg;
> +       int len = msg_len;

kernel/debug/kdb/kdb_io.c:552:14:
warning: ISO C90 forbids mixing declarations and code
[-Wdeclaration-after-statement]

-Doug
