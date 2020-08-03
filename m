Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471F220738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596453989;
	bh=VfEUaR+DnljClATusrvrxzlw5qpIgZNYBII1lFtt+3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JGZO+ybz7OzwD7Z2XSzWytniX/KB7Bo0jZJ9mSS/qjon4uWC7UgMhlB9FQYLFqnWC
	 YKiIXy/FVWjVbzu2Qwr1skh0WVaOx4FFLeHjLFRVN296vK58EvBruzzABc6kNZEz3w
	 G/eJJ/sQjTLnwp/RYRRz2U8xJXklWHkLDpgYRNmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHCL01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:26:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36784 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:26:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id x24so3514910otp.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RO5Yucl76wW0sFd9jwJpr6HDEHRRPSkSXyWk26a6p/U=;
        b=DDKxa+UzVTlNdqZs5skS8Q1FRJK4+Rrfp0BlMqmmHuekVXDbEWxvkugWLaAn9QczJt
         YOOwosR1Rx4y1f1Zs3FjKxg5oGpYIPBwSUkB2+1h52+0BQHlC0bOMnBGyK5dJPdB3bcU
         PIIYVuRmfwBZfHc0+AyM7pKCCjVea+lWAT7dQK3vF8aCviX3JjJzHrcgbwHzLFCywqje
         ZT3PCiuNPid6Eck3rSNU2wI6VWKaEBlJaucsfxkSruwfSHvtM/2GOAcfdExerO85bV3m
         rNXcU9bFRMndqGcoRRYN1R2vsTkAhlDM/RCcvArgFYx+Kqk0dC+vS9ynGmleevoMTpNd
         qOFQ==
X-Gm-Message-State: AOAM531+yGqQvdpdI+w40aaL9hkg7+iNAQRf/lNJzvsc+UDnnAVJ68f0
        Xmp5NSz7o+2szfDnULwMNMK30BxByVf4oO/7Ak0=
X-Google-Smtp-Source: ABdhPJwctkkwmw4qwPsWwR3jIVMwJc/gK4XhSNpsfhy2UFwwZ/ZWK7E0+GMkJ/v0KyA5EHUOBdXTXRP0NlX3kqi7tKE=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr13207633oth.262.1596453986597;
 Mon, 03 Aug 2020 04:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200803083520.5460-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200803083520.5460-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Aug 2020 13:26:11 +0200
Message-ID: <CAJZ5v0gDviFYu=m2y1Coi7Fo1bj8phM6r-BqBSB6=-VL_n-=TA@mail.gmail.com>
Subject: Re: [PATCH v1] kobject: Drop unneeded conditional in __kobject_del()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:35 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> __kobject_del() is called from two places, in one where kobj is dereferenced
> before and thus can't be NULL, and in the other the NULL check is done before
> call. Drop unneeded conditional in __kobject_del().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> It is possible after refactoring kobject_del(). Though I decided to do it in
> a separate change (no need to backport) for better test coverage.
>
>  lib/kobject.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 9dce68c378e6..ea53b30cf483 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -604,9 +604,6 @@ static void __kobject_del(struct kobject *kobj)
>         struct kernfs_node *sd;
>         const struct kobj_type *ktype;
>
> -       if (!kobj)
> -               return;
> -
>         sd = kobj->sd;
>         ktype = get_ktype(kobj);
>
> --
> 2.27.0
>
