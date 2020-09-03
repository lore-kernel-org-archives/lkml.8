Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B4C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827762072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNZA82e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICRry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:47:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14DC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:47:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so4191020wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8S7isXkUj3bLvtNXZySoYFOuDkIeaQxGbsF9szDaW8=;
        b=PNZA82e5Uaf4y6EZW2MKdDyZDEl8oYGfgmjd37OgS6AMxSbJzKwSbXqZilgWKqRl61
         uQT/2BoUT/mCYvrF2xdmnZ4mxSuhVypOXIFXkQtwTfeBGdhPpWgNG7/i4B7LAwf3IKKl
         q6Lf0VnGtNyd30Srz07K2GMOCVENgclcqCqXNYSQ6eCH3pUBHqNb1O6xAX1SmfJrBPjG
         acfbLGAqdaH7PDLjgANzQTahlrugl+iba5qzf0KIE0bPU7VXV6vAYUP35EDOiAsnEXm8
         lNf87liFfkqZirgrwl/LrQXlyYFdjJbQF+0Dyyekw59W5eaK7ix038+2/C7RMOMQnGOi
         GB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8S7isXkUj3bLvtNXZySoYFOuDkIeaQxGbsF9szDaW8=;
        b=HpFfNquKDKrTG/rhfjnCqB+D7ay0aHpezVlzQLYl59wH9JN3yYsZ2jPMN+uFw2evir
         tP1oSdXvp4hK59y75C3B97lMf6kanT7YCny/Ki24s5Xx9DAiLkXN9psdYJaT8wqdBQfY
         scbDRFlXKvKJ/VPdAz9BYAugSt3ptMJ+Jje1aOMFjMdffGTqOLZnX2N0gEFBj58ddeqm
         kRIVjWQu9y9p/aq8oKJpnhd5EWvSWvnJnHp2hVwRb6jkGX6gt56y9smeX8Ep/l38MQh1
         OlTEyD+GrxkqkdF7WKKHwIssR11O+qLkXnX64mvz/rFyxBLK8SgWU02R7DmrHZCwO6Jd
         kvKg==
X-Gm-Message-State: AOAM53295i5vUVlRLrskjX8QUYmYiYRuODcUSwmKCWuHTO7/LCblXUo/
        BfjKWqVFPKZ2+dnWjYQeDw4pXwLiYSJbqOeJaCy9yw==
X-Google-Smtp-Source: ABdhPJzfLyLOg0BALcdMUCdPxBZtQQP//z2tb+/eQczqsBdOEl/B6mJpNK01Ab4q2+iAgeycA90YgYk9iG3zznU+mY8=
X-Received: by 2002:a5d:608a:: with SMTP id w10mr3493326wrt.48.1599155271412;
 Thu, 03 Sep 2020 10:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200903152510.489233-1-namhyung@kernel.org>
In-Reply-To: <20200903152510.489233-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 10:47:39 -0700
Message-ID: <CAP-5=fULG7CbwB0vOBkStsRV5j7=XX_F0x+fzK7KHyqp-9Y0_g@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Fix suspicious code in fixregex()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 8:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The new string should have enough space for the original string and
> the back slashes IMHO.
>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Definitely looks like the right fix. I'm surprised this hasn't shown
up in sanitizer testing.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..fc9c158bfa13 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -137,7 +137,7 @@ static char *fixregex(char *s)
>                 return s;
>
>         /* allocate space for a new string */
> -       fixed = (char *) malloc(len + 1);
> +       fixed = (char *) malloc(len + esc_count + 1);
>         if (!fixed)
>                 return NULL;
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
