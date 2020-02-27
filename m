Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA3C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D71024692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kamb1Svg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgB0TJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:09:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35163 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgB0TJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:09:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so320655pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIUUVcQLz6sKgnI4FMJ5K8CICSDgtCiRkSBsjamGD9Y=;
        b=kamb1SvgHjKpHDE2bI4ssBm6ppGKIYLQW8CB/VKMuWpje4X3p0ABYhNqT8Q8OrY3p3
         SD03xX7rd42L4qjgC5R8SIb8LTUpAeYQGAdcxxEzHXQ3zd9heKlJdAz9TDq8VOZEiHXj
         xkflMXzdsfl+deb7jTrFqNIiqtcmiiJK4ovTsj8gjmSgkXAQzj98kirEyTSSMngtvjua
         bK81ZjivSYkfBjOVGaHgjKkyHsWr6En05jS0Caa2grWMDP2j6hvlSrdF9s200l0w5i4n
         YvT7vFcRKmbXvfhXyGstsPh499/7Q7oNCDoLFRFffYrGabJ5/fgCDrJn9lgo6OnNMj5F
         3usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIUUVcQLz6sKgnI4FMJ5K8CICSDgtCiRkSBsjamGD9Y=;
        b=FEEYvghGNjUfXJPO0rrO3EyC/Cz8lcL69R3cDdmCepNSXNmJywB90Ye6Pz5GVYcp8r
         41PKKaCIYLnSvlpDJpSGooifq6g0nqRwbLaUd5ODn8KEWxfi+Lq85lFXTlzRFkKOPK9E
         /XtHx8ovE/XNZMl5i4BdH78HHj+zxjjPfwGb3tjBCmyE1NdLt/3rL/S7TCw/nHU6oi5O
         DDQauco6QuP8jmt+u8hL5VA1OdMsBl0na/9uG9CmR88e1ucf7bxAuF5o8190lTEjjK/z
         fS7L+5c8oOWfZ9l2SkK+szTZX1vPHO1BsI7FVAnisp4JPpkr10lsvByx9euRwtBKbFMq
         cq7Q==
X-Gm-Message-State: APjAAAUDuqI52fm/eI95HrIqAfITzL4kO5km60oW8VL6lssmxXqLeBsL
        7Dg9AShYO5DIc6vgQQsCG3YcKkk1mIAV97Z3ZYMLSg==
X-Google-Smtp-Source: APXvYqwL5WUTEQIP+OmDIHANztEsdOXpvCEsbIQeLplseT4CbT7bofbj4v5PpzMUcT4ZBNy05I2zhYWtDaVif3rnQEs=
X-Received: by 2002:a63:4453:: with SMTP id t19mr724146pgk.381.1582830576299;
 Thu, 27 Feb 2020 11:09:36 -0800 (PST)
MIME-Version: 1.0
References: <1582822342-26871-1-git-send-email-hqjagain@gmail.com>
In-Reply-To: <1582822342-26871-1-git-send-email-hqjagain@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Feb 2020 11:09:25 -0800
Message-ID: <CAKwvOdm_6cBtRexkmbkj-NF3WTTDc+UzcZkQXfa05BaYvaLX=A@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Fix a typo in a comment
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 8:52 AM Qiujun Huang <hqjagain@gmail.com> wrote:
>

Thanks for the patch.
s/slots slots/slots/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/kcsan/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 065615d..4b8b846 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
>  };
>
>  /*
> - * Helper macros to index into adjacent slots slots, starting from address slot
> + * Helper macros to index into adjacent slots, starting from address slot
>   * itself, followed by the right and left slots.
>   *
>   * The purpose is 2-fold:
> --

-- 
Thanks,
~Nick Desaulniers
