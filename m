Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A587C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6066F20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2Z/LJOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbgF3Lgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgF3Lgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:36:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A04C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:36:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so11139184lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwFfXOGz4fxYZqVjks/MQV6KVpu2SdXqlr5+gsasvuE=;
        b=d2Z/LJOrxI2sK/tnaStkPJbMfShNAs6iVqT+bRYw0LM4swNXBIn2gO3o+QA/oDFXXu
         1H7pynjzt1f7s6oQ7MJ7ffa/nyEWclXo/+z/QgQEAqK5MR9ISJaKinJpScZQLM1BUqtD
         oItWSrmUk6BAJEfVY5q8jDk1QbUIIVylOrDDym0HHRr/4uskhZMJqxMveoFBUO7CnKi6
         tgFnwrDpCuFVoQCdrq5oOmrBbjcGyRMaKhWnlsaNWLba76yPtqZegF2oogYgqqsJ54Gb
         jNdCJGUm0ietNh0RWrauTNTxTIjpkx0LttlMXfKYPPLIk6gbIexfbYcDPL0TbzOcvABn
         n1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwFfXOGz4fxYZqVjks/MQV6KVpu2SdXqlr5+gsasvuE=;
        b=cvlMPGysdCxk1VSnsh1VgPyuVsWOxXoy0Hy+Or9hrZpGu4FDQCs7X+1ywsgGLbN/13
         nBG8SKfzyZyb57d1ndIZVJvCMUwWGVnOIXpvS43S67DXNHomN6n+xGgW2n6EwT9UlWMe
         MzbyUHtDGY2RBDQy0efd15sv4GxLrbbS2hcPR21IMsl3g/K9VO8YQkojc1h3vbfw/Mse
         H+x3AA13Xr7DLezxZJhO5v5rsTbgCJX3kwkd9ou4EgdXqDCrwjiHuAe2LGwetj8xpMNQ
         ldsSPQk4qoreC6K/ZX8thsBUpdHpHH6teSqxjiFZPmmKIHNg7fIsTtb03CvjRdZLI02t
         mNGQ==
X-Gm-Message-State: AOAM531F6jg/7hv1UJL5f4Y+FRNOAnKEVnSyvxA2GknEW+F1gP48voia
        ct6U4FK/YZzZkRa1lqEclJB+Kot7GiLhZmKDaXC8swCyfH8J8Q==
X-Google-Smtp-Source: ABdhPJy4I/6mxnpgXaNzE6Z3Ywobj35ziVNzhzkEx84vEjsqwwojs1dmBLrfTNEH+2Ne4WTLUHFLueH+JsJLBp1XV1c=
X-Received: by 2002:a19:cc93:: with SMTP id c141mr11746250lfg.15.1593517003341;
 Tue, 30 Jun 2020 04:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
 <20200630082922.28672-1-cengiz@kernel.wtf>
In-Reply-To: <20200630082922.28672-1-cengiz@kernel.wtf>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Jun 2020 17:06:31 +0530
Message-ID: <CAFA6WYPDTKQ4cm+TMmRt+qDiF+s3gggCsW1gfzCaaOdP9rJgdQ@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 at 14:00, Cengiz Can <cengiz@kernel.wtf> wrote:
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
>  kernel/debug/kdb/kdb_io.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 683a799618ad..81783ecaec58 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -545,18 +545,18 @@ static int kdb_search_string(char *searched, char *searchfor)
>  static void kdb_msg_write(const char *msg, int msg_len)
>  {
>         struct console *c;
> +       const char *cp;
> +       int len;
>
>         if (msg_len == 0)
>                 return;
>
> -       if (dbg_io_ops) {
> -               const char *cp = msg;
> -               int len = msg_len;
> +       cp = msg;
> +       len = msg_len;
>
> -               while (len--) {
> -                       dbg_io_ops->write_char(*cp);
> -                       cp++;
> -               }
> +       while (len--) {
> +               dbg_io_ops->write_char(*cp);
> +               cp++;
>         }
>
>         for_each_console(c) {
> --
> 2.27.0
>
