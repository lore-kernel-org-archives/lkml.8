Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E343C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FAF207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfJqg3ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgFZNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:45:32 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F3C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:45:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so8662589otc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sN17aCLbTayc3AS+U/b9AfFbyEW30u7uEHmtrdAAhYU=;
        b=GfJqg3ZNt4UmpVgE0QOzDzPcqu7deFiiTDzkNaPw/g2Rg2CHKjHGg0hmOXtpPvcY0/
         CBeEK2KnG9t7SWPgigJuoUTyaLeS/RKaO2EDcmIJUc0iyJOpRiHSVwOMQK779VmbvpN0
         O2yLAqYC45Ah8oTlY18xIBxXU/6btB2im0xzFtuWqyDdcGeTNtqvwHHlQE03UDSN3sac
         R9Z/Ray2QbqYiJQkICRgMkBEPZ/+gpcJsIAQS1KT6rlvGxoxc3fxdfcayyjgbEyOD3CT
         9oF1c8ge+q2xMSjbBGW1uckJYKHMACMGu/kGW4JJBFf2HZKG+6AsvSTU3exxRMzm9QrA
         gSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sN17aCLbTayc3AS+U/b9AfFbyEW30u7uEHmtrdAAhYU=;
        b=ax+Gg5rf66/SFqNviFVqRLHyRaj6hoKIBPtv0mdWOwFsZ5B0YFqqShx+2k/16fgiT+
         5PY6p5+o3XiDp+Z4oeK9+dHl5yajyzpJH7BamU8iJjD9qKqTK7GUtOLduv4ovGAG5s4Y
         2RjokJ4LO27/1hyy7RbeI7KUx21VfzEEQVpLsWRzOqBoRjSWomN6Xc92tY7LNWfM9iLl
         QsCt5o5dTlVn6Efr8rrzPaNOZyc+lv7jhk6IODKAUEsGtAhNzVQrYVz2tCmjMLMniWeQ
         uvNhFbaZz0+9EiBmVEjtxZ3UNQS8x9ehyd063FPaWPTTNNX+8668zGKO9SDV3+lPhq60
         87eQ==
X-Gm-Message-State: AOAM531Fp27+sKO5B+ZReArCV6NNr7Ulm8V4oTkVHUSSTEakx1w/6TPH
        xGk1Gt6sJe6WA/20C5OOhC+SyxbDQ7NSQHCozD8=
X-Google-Smtp-Source: ABdhPJwbpmS4V2u2bnYS1ncnxUbpIKYwdxaiYHwUwTCheGy0v9p+7bV6S3hEqDZOE4FyEZd7flC8P0FCcN41dxO/+0Y=
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr2550253ots.143.1593179131960;
 Fri, 26 Jun 2020 06:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-10-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-10-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 26 Jun 2020 16:45:04 +0300
Message-ID: <CAFCwf12-s_xCvL9XggE7C3OJdDoK79DTYc7_A_Q4zD_aH-O4ew@mail.gmail.com>
Subject: Re: [PATCH 09/10] misc: habanalabs: irq: Add missing struct
 identifier for 'struct hl_eqe_work'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 4:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> In kerneldoc format, data structures have to start with 'struct'
> else the kerneldoc tooling/parsers/validators get confused.
>
> Squashes the following W=1 warning:
>
>  drivers/misc/habanalabs/irq.c:19: warning: cannot understand function prototype: 'struct hl_eqe_work '
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/irq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
> index fac65fbd70e81..4e77a73857793 100644
> --- a/drivers/misc/habanalabs/irq.c
> +++ b/drivers/misc/habanalabs/irq.c
> @@ -10,7 +10,8 @@
>  #include <linux/slab.h>
>
>  /**
> - * This structure is used to schedule work of EQ entry and armcp_reset event
> + * struct hl_eqe_work - This structure is used to schedule work of EQ
> + *                      entry and armcp_reset event
>   *
>   * @eq_work          - workqueue object to run when EQ entry is received
>   * @hdev             - pointer to device structure
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Applied to my -fixes tree.
Oded
