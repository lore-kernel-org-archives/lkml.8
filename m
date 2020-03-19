Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A622EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F320752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2qP4Xqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgCST4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:56:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43565 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgCST4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:56:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id t3so1093500vkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLBNTBHIjEyXTiw55gKa/omvhkGIw8WPWOA9rE0GXXs=;
        b=n2qP4XqtmbRkwTffuQFwXJ8Kyni1t5QKf1wQ8bKFluTixABW8LclzLmeroCG6blV/l
         awphaC3e1tqOhhxG8oIRoFCgEHirN44udIlHn+jv7e/H0fLrNxw2T9El9mTkJTlcv2RH
         kaN8TRp+3RuLDIfeopbdNQOj1rMzW0u0soesEQnHj/Q2gMVVlWsC6l51kX3+W5spG3/M
         tSNiUojk//lSCskPzJvYQXr6JAidCMkL64aYox05L2ttTMQf7wFZIVJiuVZHwgdFPkWJ
         5sFDbFx/h68TUjJujkzCTnqXHGiDDOZe0V5D/GioJ4LrIYoyAsPTvsoQLMLVns2QxzHQ
         /L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLBNTBHIjEyXTiw55gKa/omvhkGIw8WPWOA9rE0GXXs=;
        b=heIY5qyL5aALSCFepoKyTQ4wv7itaPPTK6+Ji2U8/kK5w/qw+KKwTHhq8EOC1FqQrw
         Ddc4O5GKYVJUQ7XP/2XEdfIkookcBIOZf9EqtnykM2KJNKbARBDhxXkBbZABXWV+nHw1
         0ajjRaSVGv+fuzPJKRdi1D1tCUq/ibPQvBu+TMqzY3CK1A7UY9seMUj/MQXR2l2RXysA
         zxqeM61mjTni+b8RZqHkDQ1hTDlsvN8LdKuYuK1fUS27ZrOkYYj5tB1f4bJHQKK/J2Cy
         JcpRvJH7rbJDy9VC2dDHcWWraZlyJBPgTRPxYilQghfsztNQU2U5LMTlDwI00Vq3MpKd
         9UQQ==
X-Gm-Message-State: ANhLgQ2yOGj3J5iBwi8pGd0SWe/PVFdZBFDkeLVWXm8C4fV9aWzSY6Lt
        5RiQncfbu/pK15YY2E1Gyl25wK+qK8sbtBJFLryY/b2L
X-Google-Smtp-Source: ADFU+vsaENDE48G+5hFTrdcp8SdOg6jmNmlEKUXleLosv38MNvy4urf9d4m7YrrZOIG7TGgcaOW4KO2DKYZxBmH4lSc=
X-Received: by 2002:a1f:e004:: with SMTP id x4mr3982623vkg.79.1584647781469;
 Thu, 19 Mar 2020 12:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200319184838.GA25767@embeddedor.com>
In-Reply-To: <20200319184838.GA25767@embeddedor.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Mar 2020 01:26:10 +0530
Message-ID: <CAHLCerN0itdrifCGr95aynjYGOmH9EiJbR+7QCGN174aRTELZA@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom: tsens.h: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 12:18 AM Gustavo A. R. Silva
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

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/qcom/tsens.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index e24a865fbc34..92503712596a 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -488,7 +488,7 @@ struct tsens_priv {
>         struct dentry                   *debug_root;
>         struct dentry                   *debug;
>
> -       struct tsens_sensor             sensor[0];
> +       struct tsens_sensor             sensor[];
>  };
>
>  char *qfprom_read(struct device *dev, const char *cname);
> --
> 2.23.0
>
