Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E239DC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFD8221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGzqBcT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgDQJXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgDQJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:23:18 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A45C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z17so905892oto.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJOO3sCXHry7MojuN8dC/zdHSghVm7s+SjPlK2NGqPk=;
        b=dGzqBcT2y0IjKDKTVvVFAsz8Z3c+NzAWRaa6mFH97szt18huctYQ+urwQ/WBIZpYNF
         o5kLlcb2pD9Na8XSfp8sM60n6rfnS3EeXrxed9f8pPJSx58Y6xfx0pNtoDw2BvAlNQ6K
         Bx2cDUVQFg6rOnM4UZNTqAW6BAf5FayM+52vgXPERu45WRs74QoycE3WdHMUchBoNpn8
         OWHCKdiFBio9nlHyx33h9L8lFIjGmw14sgr2NFEBERtGl921TUiI8wT8eyFWXOtG2aG8
         btVikN9XxSF3nlLGI+Vs7dwj//gpFxGghAxdbcYK+EKKWCr+7WkeyK08S6BV/IAsATfe
         f+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJOO3sCXHry7MojuN8dC/zdHSghVm7s+SjPlK2NGqPk=;
        b=M7wL0RvN21Kp4o5yam78wDl1P37JQS/lgYKb+At/D9PAP+Ay0Xqwp/73R0yVJGUkyx
         83RYiNe+OiwTdieKeg9LRmJiM1tMnnFjFUfV+HxN7BvyWjEcl0caIvqB8PDjOrbn5P2k
         KSol87G+lQliiewXeX4YPwX6DRfHkwsZvmxOLoqGv9qLp3GylZhd0js78fd4gxljBV3i
         frUm72C+azJCQ2Pi+2nThjDqqFNlG5K0cj47VdNVMrsl5hC1LIQmM0Wbd9LHfXq1smYR
         2rZSaEDh2ZbMnd5iSM/hrEcemAXye3lMX07EaK29XAGvteqPtA9b5s+iybYhsi6EPoMY
         F5Yg==
X-Gm-Message-State: AGi0PuY53HOd46U6HYbK+ecbASNXY7MzP2YgpKp21gbfxBm5TR3rgkov
        QZgrsSmIMgFBv9X2pvjeGeegpZcfDIRPNg90/tMV0Q==
X-Google-Smtp-Source: APiQypJ6P4R14L+BloZcUqibhX35g0AtcFu1WBId+MZ06WADLOcDKE0n9sK0Y2ibzLELvmCEpRglyRh0BrZloK5jCLA=
X-Received: by 2002:a9d:509:: with SMTP id 9mr1919206otw.17.1587115397215;
 Fri, 17 Apr 2020 02:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200417025837.49780-1-weiyongjun1@huawei.com>
In-Reply-To: <20200417025837.49780-1-weiyongjun1@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Apr 2020 11:23:05 +0200
Message-ID: <CANpmjNMzwqFaaA-zQh0Nv4SUdoJUFO_yTmTjfbMFqyxBea1U+Q@mail.gmail.com>
Subject: Re: [PATCH -next] kcsan: Use GFP_ATOMIC under spin lock
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 at 04:56, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> A spin lock is taken here so we should use GFP_ATOMIC.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Good catch, thank you!

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  kernel/kcsan/debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index 1a08664a7fab..023e49c58d55 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -230,7 +230,7 @@ static ssize_t insert_report_filterlist(const char *func)
>                 /* initial allocation */
>                 report_filterlist.addrs =
>                         kmalloc_array(report_filterlist.size,
> -                                     sizeof(unsigned long), GFP_KERNEL);
> +                                     sizeof(unsigned long), GFP_ATOMIC);
>                 if (report_filterlist.addrs == NULL) {
>                         ret = -ENOMEM;
>                         goto out;
> @@ -240,7 +240,7 @@ static ssize_t insert_report_filterlist(const char *func)
>                 size_t new_size = report_filterlist.size * 2;
>                 unsigned long *new_addrs =
>                         krealloc(report_filterlist.addrs,
> -                                new_size * sizeof(unsigned long), GFP_KERNEL);
> +                                new_size * sizeof(unsigned long), GFP_ATOMIC);
>
>                 if (new_addrs == NULL) {
>                         /* leave filterlist itself untouched */
>
>
>
>
>
