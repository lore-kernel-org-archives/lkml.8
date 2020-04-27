Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45962C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B9F2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcjfFFrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD0JFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0JFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:05:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78051C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:05:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so13093448lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQq5YIVKHJKBzizbvimRgWeA7KAlaAb3K//0ivaDXEY=;
        b=GcjfFFrr40m8FSVYqgVIjAbvgzHosO3lzZ6qTIiqpDNS8HoWn5hUVL1wE7lIj1y8dW
         S/9Pd8rNKEugLVcpfWdmydm7ozGskMb7ekSFlcCVVq758OIBhhlTMGj8qEo5FB6Vyj5V
         p3xePRgtVUn0A81bArSzadfZ0CkYwrJ1HpDyK5uEW328RUlD5s/pK+Roa2dTALN5QUOq
         M8+IOy1NHV9kk9E7do/W5CwWRG7/4vwCHw/gTH2rduzbHVD6bwK1A45Jzmj64W+kF57m
         i1amVbhLKyzl8SQFdf2Fmn5SUnzcpygyL7Ms6jd8D3eEARjApbLBjF1rVj+PMCK5nAy5
         baOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQq5YIVKHJKBzizbvimRgWeA7KAlaAb3K//0ivaDXEY=;
        b=hVl3mZAFFyx0749CC6Y2uKoX+M4ELC0iVXZ+TWH+agIJB4QGMY1w0FudePkv+qoj2v
         HvSi+v2iKTSHYzCeCHpj20ZUvl/H4ytKeTHG9KZqDp/oWBiacJVc28oSC6lpfSgdhgLb
         C2mHVRYPOXppUY22+FA3VYCzaS2e+OkWuSpe9y7WfB6sitNfacZVV7YcZ4dBr+OAY+r+
         BhX1ley1c9UFLZwS+cqfiO8PE4FJ4ypfCL52mQVsCqP1eXk5FQ7AzuSY3KsZUAiDROxN
         VUQM8IcoD1+Tk4Wo9xZWKofgcxOuA+5O0Vj5hSUOu/sWocgFpUBLWZMPGsvdq88wAfQp
         WgHw==
X-Gm-Message-State: AGi0PuYP+cdFl5ECVROWzd8raAy7tDP6oSrQnvAjwYiaR2Mn8GX3NA06
        uH5nWQplCrGuf0OhCk880M+g/y6gZITFQgzK3Y3k9Q==
X-Google-Smtp-Source: APiQypJ7xTvcVAg1CVRnlMJb2+Mp058WGfk5Qxh7iUgNk5n6eBbb/kl3GThMvjCLOys+aY076SZ8xFal+6KXDL4I9B8=
X-Received: by 2002:ac2:51c9:: with SMTP id u9mr15212511lfm.184.1587978332910;
 Mon, 27 Apr 2020 02:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200427032338.73743-1-songmuchun@bytedance.com>
In-Reply-To: <20200427032338.73743-1-songmuchun@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Apr 2020 11:05:21 +0200
Message-ID: <CAKfTPtCKNRbqi7oRcj29RJwOCrPemEHVzi0936jYryxzhkW7zg@mail.gmail.com>
Subject: Re: [PATCH RESEND] sched/fair: add __init to sched_init_granularity functions
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 at 05:23, Muchun Song <songmuchun@bytedance.com> wrote:
>
> Function sched_init_granularity() is only called from __init
> functions, so mark it __init as well.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1141c7e77564d..6f05843c76d7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -191,7 +191,7 @@ static void update_sysctl(void)
>  #undef SET_SYSCTL
>  }
>
> -void sched_init_granularity(void)
> +void __init sched_init_granularity(void)
>  {
>         update_sysctl();
>  }
> --
> 2.11.0
>
