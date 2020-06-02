Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA35206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDLDlNa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBVcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBVcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:32:18 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE1C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:32:18 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so141007vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9kn62PqAX47M9GdWLUtWEHWFrrXZP2eF+NQ55cvCow=;
        b=SDLDlNa2JxAHtTUthkbE/nmVRXVihXNqZOfFZYLWMG5r+lFumi+7JFsdsehrTevXOO
         sCMLupns01dIukJUzu+RAzsGgJTsGMJ0hdFyNazYDLeWHUCALEfmotGmMzlzrMCgn33I
         Ur8gkspMU96YkoSIkFWxipJQ6pyHI+/nTKxZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9kn62PqAX47M9GdWLUtWEHWFrrXZP2eF+NQ55cvCow=;
        b=Lc0tztg4CS/vgLLelEp4flNK5QHtbrh2fww1co+S4UIHBtB0K7p8znOVxOdT48OgLx
         4uOFpod3/cmk+xfg21PYnDMgIzyk7mIQGXX8cLMiDgP0MbXr55dRznUDqfC71C3d83ZH
         Arc7rX1PQC65eKE490Hmjkm620Z0Z2aLPCeK4kAs+AnM/LSYpFikW9Q9RnELXoTVQmGj
         K6ki7j+D/5t+a+WGwSYDcd3PLdnhGKzeDMc1gZslLvpSjgsSuJTg8Qenw+JpN+Ycr8bK
         773buOQyA2HnFtzlb0J7lrdiSamvAiNVlNUX2AVfgKpwjTQEd6YpRnuRjxn6+Dzj59Xy
         sHNg==
X-Gm-Message-State: AOAM532Wa2j0LYmi9wZ9CoQOUo0n+irUThPOtre2XIBmISoJ4gm/fciD
        3c2TZkS/sJZ4ByfT6+MkJ9QQOeMd/8c=
X-Google-Smtp-Source: ABdhPJw2sglHWXfbXS5FYt9Mv0ePKhuKA8P9y0QwLuQ0Gq49TcY83eXVkw3IYisHwsf5jdXAJj/+cA==
X-Received: by 2002:a67:db81:: with SMTP id f1mr13470920vsk.81.1591133536883;
        Tue, 02 Jun 2020 14:32:16 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id k68sm6773vsc.32.2020.06.02.14.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:32:15 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id 59so121306uam.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:15 -0700 (PDT)
X-Received: by 2002:ab0:1684:: with SMTP id e4mr18561066uaf.22.1591133535074;
 Tue, 02 Jun 2020 14:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org> <1590751607-29676-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1590751607-29676-2-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jun 2020 14:32:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVdRcvfR-O-A2809AqFggqhJmvrTSo9qafxq=DgSbLrw@mail.gmail.com>
Message-ID: <CAD=FV=WVdRcvfR-O-A2809AqFggqhJmvrTSo9qafxq=DgSbLrw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kdb: Re-factor kdb_printf() message write code
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 29, 2020 at 4:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Re-factor kdb_printf() message write code in order to avoid duplication
> of code and thereby increase readability.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 61 +++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 924bc92..e46f33e 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
>         return 0;
>  }
>
> +static void kdb_io_write(char *cp, int len)

nit: "const char *" just to make it obvious that we don't modify the string?


> +{
> +       if (len == 0)
> +               return;

Remove the above check.  It's double-overkill.  Not only did you just
check in kdb_msg_write() but also the while loop below will do a
"no-op" just fine even without your check.


> +
> +       while (len--) {
> +               dbg_io_ops->write_char(*cp);
> +               cp++;
> +       }
> +}
> +
> +static void kdb_msg_write(char *msg, int msg_len)

nit: "const char *" just to make it obvious that we don't modify the string?


Other than those small things, this looks nice to me.  Feel free to
add my Reviewed-by tag once small things are fixed.


-Doug
