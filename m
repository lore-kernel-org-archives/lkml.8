Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C9C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D5E2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhhM7Wd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgH1PN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgH1PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:13:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48FC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:13:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so795855pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKjrrvGukms7oApav7erWoo0oPTGMcbx8gjhXd3ukgs=;
        b=NhhM7Wd+6AXFxeOeMWRB148tGgNlOMcALtzVTyDpKSNCuzc3VWYLfJz/pX5kXgMHGL
         9yWWnDA5z/smkM1Md/N/OArnjuz3dkLQV4msTL+jLALnqY9rkSCrrIw3nio1scj68TCz
         kmbApPm0zBAt0F7neVf0zLYRSsyNM0OCcLf+HpLOhoJcFqOK+xSHUgVdylKhSuEnIixE
         rpId1DnDwsD41p0iGXpblh/s1NjnVMFJ/HXYO3mQuwurIrfBJTzxcGKgRyueLjGR9ZhD
         r9pYDJDfQwYo++eOmCF7TQpboaZRr/hNx95K1YSvRQpGo5gRDwPlVae/L9cg29T3IQBh
         8lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKjrrvGukms7oApav7erWoo0oPTGMcbx8gjhXd3ukgs=;
        b=cNMAubD3rU5vNVar0rv3qVoEIwruNiZTM6bvB5WeUgpeFlclDkOyuLl4EwBYsM6G5m
         ZckdLM9PNwHDw7+0zrGGDm5dVPrQxX/B1A8uPENL/aibMapHnnrkVvRdi2gPsGl2IsMg
         pYuTCsfVpjSjxPLLNjPLVenuDS3m3XHQy05HVga1JhP4T/AmX1JRcRjVAu/zZrzHXWTx
         WalZMNK1k//B+lsQzVC3W+3MNVMcXo+pJrQjZxIEekqRYFB86aponRSuwoh+p2M61ITD
         ElrJmZSsK8h/wWKmRGyA39j2979b3PBD9Fb5XCIJgMoiEgPlbIQO0zmqpzWg5UCy4PkG
         YM8w==
X-Gm-Message-State: AOAM5320ldwcCEctz9uvfcItzx5LaPVHGXWKFCN8UODT505NM/8bR2of
        JWtfToDwiXrTpX5LIsVT7cuLOSmwu3gsPjl86q/MJQ==
X-Google-Smtp-Source: ABdhPJzBRHZpU27bCnEfRWEIjU42rJu3H1xXxc3QjqEmLrHzIIwqgmaz4ebaoH3M0cNLgMndZvXGFvpUlnmrLB9iN0o=
X-Received: by 2002:a62:1514:: with SMTP id 20mr1712792pfv.62.1598627593154;
 Fri, 28 Aug 2020 08:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200828145518.26324-1-trix@redhat.com>
In-Reply-To: <20200828145518.26324-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Aug 2020 08:13:02 -0700
Message-ID: <CAKwvOd=S=aw6KoRvzhUMi4fR799kaPwAKoigjuR9fS-JSYSGPA@mail.gmail.com>
Subject: Re: [PATCH] media: ov7670: check status of ov7670_read
To:     trix@redhat.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 7:55 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis flags this representative problem
>
> drivers/media/i2c/ov7670.c:1463:9: warning: Assigned
>   value is garbage or undefined
>         *value = gain;
>                ^ ~~~~
>
> gain is set by a successful call to ov7670_read()

Indeed, it looks like gain is only valid if the return value from
ov7670_read() is >= 0.  Would it be simpler to just initialize gain to
0 in ov7670_g_gain?

Side question; I'm super happy to see someone sending patches for
things identified by clang's static analyzer.  I'm curious, Tom, how
did you run it?  Did you use the recently landed in kbuild-next
support for the make target `make clang-analyzer`?

>
> So check that ov7670_read() is successful.
>
> The remaining static analysis problems are false positives.
> There appears to be a limitation with checking the
> aggregated returns.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/media/i2c/ov7670.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> index b42b289faaef..001d4b09db72 100644
> --- a/drivers/media/i2c/ov7670.c
> +++ b/drivers/media/i2c/ov7670.c
> @@ -929,6 +929,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
>         ret =  ov7670_write(sd, REG_HSTART, (hstart >> 3) & 0xff);
>         ret += ov7670_write(sd, REG_HSTOP, (hstop >> 3) & 0xff);
>         ret += ov7670_read(sd, REG_HREF, &v);
> +       if (ret)
> +               return ret;
>         v = (v & 0xc0) | ((hstop & 0x7) << 3) | (hstart & 0x7);
>         msleep(10);
>         ret += ov7670_write(sd, REG_HREF, v);
> @@ -938,6 +940,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
>         ret += ov7670_write(sd, REG_VSTART, (vstart >> 2) & 0xff);
>         ret += ov7670_write(sd, REG_VSTOP, (vstop >> 2) & 0xff);
>         ret += ov7670_read(sd, REG_VREF, &v);
> +       if (ret)
> +               return ret;
>         v = (v & 0xf0) | ((vstop & 0x3) << 2) | (vstart & 0x3);
>         msleep(10);
>         ret += ov7670_write(sd, REG_VREF, v);
> @@ -1460,6 +1464,8 @@ static int ov7670_g_gain(struct v4l2_subdev *sd, __s32 *value)
>         unsigned char gain;
>
>         ret = ov7670_read(sd, REG_GAIN, &gain);
> +       if (ret)
> +               return ret;
>         *value = gain;
>         return ret;
>  }
> @@ -1470,11 +1476,14 @@ static int ov7670_s_gain(struct v4l2_subdev *sd, int value)
>         unsigned char com8;
>
>         ret = ov7670_write(sd, REG_GAIN, value & 0xff);
> +       if (ret)
> +               return ret;
>         /* Have to turn off AGC as well */
> -       if (ret == 0) {
> -               ret = ov7670_read(sd, REG_COM8, &com8);
> -               ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
> -       }
> +       ret = ov7670_read(sd, REG_COM8, &com8);
> +       if (ret)
> +               return ret;
> +       ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
> +
>         return ret;
>  }
>
> --
> 2.18.1
>


-- 
Thanks,
~Nick Desaulniers
