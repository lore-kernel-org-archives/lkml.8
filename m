Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A987C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DB12078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi+huNd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgCaOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:45:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39481 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgCaOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:45:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so22263918ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvKwvYHVc4M3qtK7TtEssy9WW1YebDgfSWAUAXk6VeE=;
        b=Bi+huNd8QNlGw2jB32sxivuNoz+4tjL8D4Em0M3APfL6A3KyU0M3yfcpj+pwLX6tlA
         Zym6qnZnRoxyCJ3f+XJz30qHOwjl2y5KtDGgsiwcg4yLPGGM/xMbQ+6B/fWxaKjJvEhB
         Mz83jp+lCuHg7wl1Vj+Qae34xHEKDhn/Ujx6pxFjA0Vyi+brI0v6i+KQ9gsqifzqBIl4
         56grEup1zn7i3/4L9dv7AEQjSJiKiCUscjcyURgoYz8ccNDXQopU+BUek10+X3JPOP2u
         7FfkHNYyJuSZsT5W3YIYIFt0frLmvY/ubNsaNlJJTSYzsLebuRRMtSKANskdh5p4kJYf
         dYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvKwvYHVc4M3qtK7TtEssy9WW1YebDgfSWAUAXk6VeE=;
        b=ZnKFXIKtTPeot1eWTzcTU0ou4Vo3WPj3BB1D5sjpAYxpu+iEKgSJWvVttWIcrwV92d
         tzRjLbISAV3dxaWh8scRVU1gaNlFwGHkb5feIs+bweT9S5+3rSt0XaK+I6igotEM7s1f
         EU89DkU9kNzSJ53Oo04FPU4dwDHLL6UEJgnESl8ouVjZ1lZY8Cwg+uh1zyStmI3b27AM
         rlsKA9amP18ZjaHnHHJHL6vRtc0HDXKLsK2NwW+2yXfZAn052Ha0DSQzLu8U3KZV3mcb
         9rCGz4+giU083CcWEOfaMwbWWjNW5/gCFjzaDi4EBzSOXtGuNCCll6Fd/2LXvRZD4YNA
         n0VQ==
X-Gm-Message-State: AGi0PuZCO4p1Za5+a7lhMDAheYCJ+FVI7tYLgYVfpgJcDmPCunhins+w
        LmIAacWNf5fWRGAKO8BvD5Z/GsV56GKVX8+q3TAO4Q==
X-Google-Smtp-Source: APiQypI1NWqQQGQQCZ+k2wSa1POnrOemcCyFbpH56oBK3kNBWVYi+yV909tG/yrbVrr9ZlaYp7cKoUJrCNW/V0gDjYo=
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr10614702ljo.223.1585665924643;
 Tue, 31 Mar 2020 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200331134603.13513-1-ansuelsmth@gmail.com>
In-Reply-To: <20200331134603.13513-1-ansuelsmth@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Mar 2020 16:45:13 +0200
Message-ID: <CACRpkdbkbWKBhtOQkCUOn6EW51bJB-Dg-v_4W3Cz4Pd+5XGwFA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: fix compilation error
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 3:46 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> pinctrl: qcom: use scm_call to route GPIO irq to Apps has a typo in the
> patch and introduced a compilation error.
>
> Fixes: 13bec8d4 pinctrl: qcom: use scm_call to route GPIO irq to Apps
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Patch applied!

Yours,
Linus Walleij
