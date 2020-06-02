Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2B206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ciixlNC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFBVc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:32:55 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0060C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:32:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o2so174256vsr.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rCy6JhciRmnrRJ+3cwFrQGHFe5sBy1qAr/EQNm0QcM=;
        b=ciixlNC0q8jiB9c1y5NKtCxgjskcRH5ZADVDSGiuv1LafL24gHJAWjAAOzHUwhxFaP
         yuVuXTSwK7lwK5QiEtlqu46S7j17gkm8Ki1FB/8j7VTmrdi57wfGjUZ74VcpqclUvGbU
         8N9UENxO7x0eTZsNRlRFUZLK5q7WoDrzvPCIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rCy6JhciRmnrRJ+3cwFrQGHFe5sBy1qAr/EQNm0QcM=;
        b=cVmLvqlsWTq7Mp3gnPh0MhAGHlBYc7fq8sX827/F/WmjATiSYknNoBIEq5WiFG8n3E
         Ze1hiZ6C6nvt+ay7iH0mwysCK5O8Nq3GsLD7nHWNXCXey89+ZphQvBneCgZieRzY9nXU
         zy8jIUVhQJAbRrw6mGMGkapBWOtrmhMJO+SANfN8aNBnoR4xMrQ6+qvk8NscRz0u/EZl
         iSCUPTIyGBp6tIn57fAsoj7NQWjqLaoqmO0+RmiYlEQ1o4ffTcjDK5dk+mZ3xYjg0pBb
         vQWE2bfPmKKeAhicKlTSM9wj50d8GvhdWNGibb+2my1tOUaO2wnlDYcCYWAkFcMSuqJZ
         5hyw==
X-Gm-Message-State: AOAM531/9MkKPGEnz6j7ccKeNfPJqx5MciIIpQ1mPTbMnsk+5vlhKehn
        ry6ezLD2YXM5WAc0JgQFF8YZOaPuNoY=
X-Google-Smtp-Source: ABdhPJy0C38rKewSL5RCalDWfIKE1n1Lrf0DjqX5zXj8rRcEhmzwZFvipk+0nL/zpH9pincU4RJGow==
X-Received: by 2002:a05:6102:126c:: with SMTP id q12mr19358890vsg.173.1591133574405;
        Tue, 02 Jun 2020 14:32:54 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id p75sm32683vkf.1.2020.06.02.14.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:32:53 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id r1so123396uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:32:53 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr22707773uav.0.1591133572856;
 Tue, 02 Jun 2020 14:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org> <1590751607-29676-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1590751607-29676-5-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Jun 2020 14:32:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZwUx0SKO96g6vqh3qgwq5xeaAOoT-Qgx3JnEB3c1AkQ@mail.gmail.com>
Message-ID: <CAD=FV=WZwUx0SKO96g6vqh3qgwq5xeaAOoT-Qgx3JnEB3c1AkQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
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
> In kgdb context, calling console handlers aren't safe due to locks used
> in those handlers which could in turn lead to a deadlock. Although, using
> oops_in_progress increases the chance to bypass locks in most console
> handlers but it might not be sufficient enough in case a console uses
> more locks (VT/TTY is good example).
>
> Currently when a driver provides both polling I/O and a console then kdb
> will output using the console. We can increase robustness by using the
> currently active polling I/O driver (which should be lockless) instead
> of the corresponding console. For several common cases (e.g. an
> embedded system with a single serial port that is used both for console
> output and debugger I/O) this will result in no console handler being
> used.
>
> In order to achieve this we need to reverse the order of preference to
> use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> store "struct console" that represents debugger I/O in dbg_io_ops and
> while emitting kdb messages, skip console that matches dbg_io_ops
> console in order to avoid duplicate messages. After this change,
> "is_console" param becomes redundant and hence removed.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/kgdb_nmi.c | 2 +-
>  drivers/tty/serial/kgdboc.c   | 4 ++--

I don't think this will compile against the "kgdboc_earlycon" patches
that landed, will it?  Specifically when I apply your patch I still
see "is_console" in:

static struct kgdb_io kgdboc_earlycon_io_ops = {
  .name = "kgdboc_earlycon",
  .read_char = kgdboc_earlycon_get_char,
  .write_char = kgdboc_earlycon_put_char,
  .pre_exception = kgdboc_earlycon_pre_exp_handler,
  .deinit = kgdboc_earlycon_deinit,
  .is_console = true,
};


> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb..bc0face3 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -273,8 +273,7 @@ struct kgdb_arch {
>   * the I/O driver.
>   * @post_exception: Pointer to a function that will do any cleanup work
>   * for the I/O driver.
> - * @is_console: 1 if the end device is a console 0 if the I/O device is
> - * not a console
> + * @cons: valid if the I/O device is a console.

optional nit: add "; else NULL"


Other than that this looks great.  Feel free to add my Reviewed-by:
tag once you've fixed the error that the bot found and resolved with
kgdb_earlycon.


-Doug
