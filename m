Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B1820734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MSLGlXby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFBVcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:32:40 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B3C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:32:40 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g129so159857vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpqJtgJSFRDp8mokBqnXanuthBlrx2rMpY1VZAOmix8=;
        b=MSLGlXbyKVLKRJdq44VL52EhA0CqJZM/Q/CGoU/TLgbpjhlranokA8+viVfJqdRaQ/
         Lo8STw/xH1+ahM5+c7UWguyxBS9+rWrNdDXipwRTa0lIo/5FlaRkiIpF5bxFYv9pjWlX
         AtJQMtKDD8U0fbLnYWgGkA7zLz4/v7LoZYw24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpqJtgJSFRDp8mokBqnXanuthBlrx2rMpY1VZAOmix8=;
        b=kskVe6zv1/se3NDJCm6Gh/ThINUd+xdGC23uOt3eV9RejrV2eyn5P6Jd46Tq1aHHc7
         VCj1aUCrLP5m6X7jLoQI3uHzthTtLd+B3jLLJbCNL5jJZorJ4ETbgprdIaIYd+bCXhXI
         iWDLPgTu+Z8bJjRzKXAwOrI+g0Vj9f2Vu4+6e97zEp8nRQtkEQpto600QheCRWD7z9Xy
         9YJFFoKQceiRsB2QjEQWCJXRT6czTm8xRN2iquX2JWtUN5o41ILX9Yy4rJdfuvFE7OYw
         8OJW1IInNk8pFNS3qH8Nvvl8AB+d83d/LAzyKg9QXADovC+vh5Q3rOh3Ip72hLCZcgtj
         CgWw==
X-Gm-Message-State: AOAM533clLg3vwBz7llXX9SZYkyJK4R6wRfT2lbQZFtoI2AJUee6FEK5
        4hQadr3akJLchsiqG1sE8Nj7oscwwlc=
X-Google-Smtp-Source: ABdhPJwuV0LNjLA8UqGdF2QQJDXWZEO9brIgjogzvL0HiHpJDz6WtvZG0cikBzSoIDHKwCSPii3l7w==
X-Received: by 2002:a67:2c52:: with SMTP id s79mr19964014vss.23.1591133559460;
        Tue, 02 Jun 2020 14:32:39 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id m73sm31396vke.11.2020.06.02.14.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:32:38 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id a68so147267vsd.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:38 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr20338985vsx.169.1591133558298;
 Tue, 02 Jun 2020 14:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org> <1590751607-29676-4-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1590751607-29676-4-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jun 2020 14:32:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xx4VAUMaEvFt+mjDmsricaQXJFLrHMgbk2jMcGEGY6Fw@mail.gmail.com>
Message-ID: <CAD=FV=Xx4VAUMaEvFt+mjDmsricaQXJFLrHMgbk2jMcGEGY6Fw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kdb: Make kdb_printf() console handling more robust
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
> While rounding up CPUs via NMIs, its possible that a rounded up CPU
> maybe holding a console port lock leading to kgdb master CPU stuck in
> a deadlock during invocation of console write operations. A similar
> deadlock could also be possible while using synchronous breakpoints.
>
> So in order to avoid such a deadlock, set oops_in_progress to encourage
> the console drivers to disregard their internal spin locks: in the
> current calling context the risk of deadlock is a bigger problem than
> risks due to re-entering the console driver. We operate directly on
> oops_in_progress rather than using bust_spinlocks() because the calls
> bust_spinlocks() makes on exit are not appropriate for this calling
> context.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index fad38eb..9e5a40d 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -566,7 +566,18 @@ static void kdb_msg_write(char *msg, int msg_len)
>         for_each_console(c) {
>                 if (!(c->flags & CON_ENABLED))
>                         continue;
> +               /*
> +                * Set oops_in_progress to encourage the console drivers to
> +                * disregard their internal spin locks: in the current calling
> +                * context the risk of deadlock is a bigger problem than risks
> +                * due to re-entering the console driver. We operate directly on
> +                * oops_in_progress rather than using bust_spinlocks() because
> +                * the calls bust_spinlocks() makes on exit are not appropriate
> +                * for this calling context.
> +                */
> +               ++oops_in_progress;
>                 c->write(c, msg, msg_len);
> +               --oops_in_progress;

This seems sane to me, especially when combined with your next patch
that tries really hard not to run this flow.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
