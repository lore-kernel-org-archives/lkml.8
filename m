Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A3C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199DF20776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AsXfCxXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgDWSKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:10:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F1C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:10:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so1859741pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrjNM8BIB5l9RDDyP/w9uL8SShDah7FJKmQ5DvjnKE8=;
        b=AsXfCxXazLdQ4m4tFsITnoDFMxqGenJRkSF+hQa764+Ie951E0z1+86ZtMDbqQeqN9
         EoMfgJun6N/RY0LSGQ4n6KcyLtyLxeE6qI0AYgv5QA60oCmP8THtiezL2RHowJtIe/7X
         ibS7aUydBcFHYotXKrT/7B5h0McBa7t+WrF0Kod6rl8RAR3VRpE2rebAt0ODkRKw89rM
         h2swOx8HZH8pTN3Epi4K0wNbez+NDF2bsW3xtSPJjsFeLdq7yB50zmj/WTJb0qBWc6sq
         zELPZtUFYAhh1kh05HOxNhOi2RPJGDPjiDAXuUVBTAZRVjZr8kCBRFN0xdbZ/Wq5/FTF
         rGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrjNM8BIB5l9RDDyP/w9uL8SShDah7FJKmQ5DvjnKE8=;
        b=te39BuHmKBZonDFZcZL6/5w5fVorM2jTTXYy8hbMS7Z8/WPwMUocFNGKeWDMt7AHGS
         jTneGTimsjHDIYKCVfBsB0sr/FqrSLejMzgfLhjVVyRgBG9+jdnkFBM3JM0lJ0durEY8
         i4Rop4HmiTJ3rIRvT4dznZQR2upMKKtS6ex3x0HfZJJqf2hM8Ybl/ZedYHY6TRi/zVO5
         6HFuat172eqBiQgUus0QigoYKlquSlmE1hWKX76QLXVluZyQoY2sVVRvjuNcoUS/fkHz
         3mZHkHQam6o2LBZBsTsmpd9VNRECg4TZTyRkbEypxtFZEh5a62VU4Av1dQ98crZhw64M
         NFtA==
X-Gm-Message-State: AGi0PuYHDDu5zmW3vo0REzCW58TKvXNZ32s1DNJocIGYc/Nmf7oxxsZv
        I4oOzjsKiZd/MDLgKmfpK4BtisAyBbrR1yqBbIwj5w==
X-Google-Smtp-Source: APiQypJxSAw4KraboivCNfbdVu5dxs22Lp01yJChZEKk7LuJohXkK/zLo28qdyZgNXxQMSdqcAn9Gjof2vvDu8FLAOQ=
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr4756081plr.119.1587665437124;
 Thu, 23 Apr 2020 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200423162923.10886-1-natechancellor@gmail.com>
In-Reply-To: <20200423162923.10886-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Apr 2020 11:10:25 -0700
Message-ID: <CAKwvOdnP247LJpqo5ZZfGXUktjtXKzhDwQU=aTOrFi-y_px9mA@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: udc: s3c2410_udc: Remove pointless NULL
 check in s3c2410_udc_nuke
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 9:30 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/usb/gadget/udc/s3c2410_udc.c:255:11: warning: comparison of
> address of 'ep->queue' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (&ep->queue == NULL)
>              ~~~~^~~~~    ~~~~
> 1 warning generated.
>
> It is not wrong, queue is not a pointer so if ep is not NULL, the
> address of queue cannot be NULL. No other driver does a check like this
> and this check has been around since the driver was first introduced,
> presumably with no issues so it does not seem like this check should be
> something else. Just remove it.
>
> Commit afe956c577b2d ("kbuild: Enable -Wtautological-compare") exposed
> this but it is not the root cause of the warning.
>
> Fixes: 3fc154b6b8134 ("USB Gadget driver for Samsung s3c2410 ARM SoC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1004
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!  If anything, I'd be happy to see some more NULL
checks against `ep`, though the callers of s3c2410_udc_nuke() also
seem quite confident that the pointer is not NULL.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
> index 0507a2ca0f552..80002d97b59d8 100644
> --- a/drivers/usb/gadget/udc/s3c2410_udc.c
> +++ b/drivers/usb/gadget/udc/s3c2410_udc.c
> @@ -251,10 +251,6 @@ static void s3c2410_udc_done(struct s3c2410_ep *ep,
>  static void s3c2410_udc_nuke(struct s3c2410_udc *udc,
>                 struct s3c2410_ep *ep, int status)
>  {
> -       /* Sanity check */
> -       if (&ep->queue == NULL)
> -               return;
> -
>         while (!list_empty(&ep->queue)) {
>                 struct s3c2410_request *req;
>                 req = list_entry(ep->queue.next, struct s3c2410_request,
>
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200423162923.10886-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
