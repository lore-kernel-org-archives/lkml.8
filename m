Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF2FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E3020740
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eujV/S1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCTBSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:18:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40516 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgCTBSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:18:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so4688190ljj.7;
        Thu, 19 Mar 2020 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMYxm6j+mIIPOTy3mCj/AiqxDzaoPpHmSg1bqjbwEg4=;
        b=eujV/S1+/hFD8I3NIMRmaYqBxQ/qD6C9agLp2DzdbbmA9G9Nj7qC2HcNr5N64MhZ5C
         eF+IItDROXnCO7CJTZS8plyWouuYgee99zmGj6UbzTUriWFCu7eRZwIqXL5IeBnIiysg
         oxpF2UQVHSxAPI1pG7DaqGJJ44vtL110CBtStpuK1ObGBKWnqKcq98P6D6dyTfQ/JXb4
         TRjdCwsGWjsUkv6ev9UrkHRVb5/UECs2nSC1utUVlt+fVY72ecjzPL429dMNP484Lf0O
         UpDuF6fc58xpI/CDK50vVS49vimJ1N/9pdXCMjnA57ERcbpraIatBrMIMidEKmxRSfNu
         jKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMYxm6j+mIIPOTy3mCj/AiqxDzaoPpHmSg1bqjbwEg4=;
        b=RYq4akmfU2ZCZeqYqcKndcoWMugQdsCLpMJpoe1GamtVgRXr7VzhOvYfat5kLie8lL
         B5mE+f9InfLQVQqN2wiRPtytXmdTboNhqgrTxZlSxMPG19fYumUjj2L+v9rbVJxgyspf
         k0VcCrVdFG/UOs+nAGBjlaO/dNe+P2tGj3YY8a/LMTSQJVAlu8TZiYBxOO7tMqrfKC+7
         VSVJPYSNTUfMPtRbFzJbQkJtJFLN59uQ0yMsoe8hDieg71x0/2uvwxPKE4Bqq3C6rs9P
         gNBrsH+U3kOhN/P40AqsHbU4PQ/nIjZ9yqNk819QDxx3wjvkhVYykvzqvrhGDcXjPalW
         hNLQ==
X-Gm-Message-State: ANhLgQ04RT/oFQPVJ/QbDKfqUJxJtcaLL5FipI7hFyAejAJHGvQB3YCB
        XPNipHluhaKH7YlYh4CEbO+jiRTDgOBGUYQXegU=
X-Google-Smtp-Source: ADFU+vvmMZ6JShwQhcE6b7jCzzIRlrhXSCBuofU5ssxbnD6vsVrhizSR456+/Mut7TJGrwdGW3Vu1OzCaaeO4hN8YLc=
X-Received: by 2002:a2e:3a11:: with SMTP id h17mr3742351lja.110.1584667088457;
 Thu, 19 Mar 2020 18:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319213839.GA10669@embeddedor.com>
In-Reply-To: <20200319213839.GA10669@embeddedor.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 20 Mar 2020 09:17:57 +0800
Message-ID: <CADBw62qjK=0_UKmOyvvYszLkjgVi8LQTwAg1Vqm07-89fOU=fg@mail.gmail.com>
Subject: Re: [PATCH][next] hwspinlock: hwspinlock_internal.h: Replace
 zero-length array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 5:38 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/hwspinlock/hwspinlock_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
> index 9eb6bd020dc7..29892767bb7a 100644
> --- a/drivers/hwspinlock/hwspinlock_internal.h
> +++ b/drivers/hwspinlock/hwspinlock_internal.h
> @@ -56,7 +56,7 @@ struct hwspinlock_device {
>         const struct hwspinlock_ops *ops;
>         int base_id;
>         int num_locks;
> -       struct hwspinlock lock[0];
> +       struct hwspinlock lock[];
>  };
>
>  static inline int hwlock_to_id(struct hwspinlock *hwlock)
> --
> 2.23.0
>


-- 
Baolin Wang
