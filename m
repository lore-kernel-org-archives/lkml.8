Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E81C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976E42086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5+j9M80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgH1Io6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgH1Ioc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:44:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5CC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:32 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y15so137902uan.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2B1i6AAkwRUTmhr5yA7hQS42gfZuyqP5S7cfp1eETfY=;
        b=F5+j9M80/4/+TdhmpFxuKDr9MPyb0usYY3RisdpDKbxeIZsjJoGToJP6nC/xjg0Jsk
         RXgthIDyPR1Mnl/87yltYweBft6QdA0JZr2JIw8Rurfsa0xfGK6YrfWTheteJn1Y7smg
         PiOJk4KaFc+3tF9C1ECVa/1xYRWfpZP6Vpde+PbfwkahB6GPw9ZAE1aBX6w98r0NtbHt
         a3S6KyPybDoxGnqTn6F5mR/vzEbfGrnkclAHiIVf2t3dxAB+21VfdkjV7WuFhbYESO9L
         56DqOTODyMbHZBCUE66D+H5ebuNci9Qqv0XzOo6r81jIqkiactvlS5rjq2f7RRDkUT+a
         GNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2B1i6AAkwRUTmhr5yA7hQS42gfZuyqP5S7cfp1eETfY=;
        b=qyDMRkNXABMmxOJcv00bi209jyDsig72diisTTbI+KER1n9Fel9s1936cr6JctYOL5
         hJWcCPow0R869FrR5TrmDZmNJpjK0XuNUYHKVPrRXRmVQV5CpVgc4A2VSqbqzstref8h
         7N2RcdbembM08YmPgGVZh+rHgnz+SbzGCgK5hY3XjJj6UYSWFfmbzov7Qz07HdcMVP3d
         8oLFPlRk1mDEuA4pLQbm9lbc3PyUyusV3r7aC2Kh7GdGW7hfI1sgOH01SuAgw0QaLNS4
         FEPlDMyXc2hkIRuBi+geLW7SQpDXgSRI+DS8QJdBc/D6GKdeG0grWVXWORzTevV7KSMO
         erLg==
X-Gm-Message-State: AOAM532FeDzuA4Qp4m7MTWw4lN9ipFDPqvIgO1CzMyEuq2nh1qIYRhln
        pFi4WIHGPsDkIENoTXqd22xLauXbuPFQqia/wbbjIqQ1yea3ZQ==
X-Google-Smtp-Source: ABdhPJyGp+FgyMss+68uMBD2Y91ljjyJ+sYPNmACwlMkIWDkLV6ldE9XEhpq0A3bfD+18CGY1qLQorAdEwgb5rmIw24=
X-Received: by 2002:ab0:3a85:: with SMTP id r5mr322072uaw.100.1598604271920;
 Fri, 28 Aug 2020 01:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <1598230956-58523-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1598230956-58523-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:55 +0200
Message-ID: <CAPDyKFp38bB3+BASAxKkQwSLmNiDReEb8XzCrh2vrC8uE12bfQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Philipl Langdale <philipl@overt.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 03:04, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 5a2210c..a0d2c34 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -735,7 +735,7 @@ static struct attribute *sd_std_attrs[] = {
>  static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
>                                  int index)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct mmc_card *card = mmc_dev_to_card(dev);
>
>         /* CIS vendor and device ids are available only for Combo cards */
> --
> 2.7.4
>
