Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A7920678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7TQDtx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFCMFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgFCMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:05:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ECCC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:05:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so1135777lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpCS5wGUx4CepPYyhtkjs6CunSLRyJTVuQXgd3iqq00=;
        b=K7TQDtx/VFZcR/9hoYoObYaLewpu52KoTPHJAThwyNwbBRJW27tdv6o/cY4y2n4Yf2
         Z7fef7NulYCGbU+1yOvEObHYWErTPydHxlK2xKEzEtWtVs3Kar/CUkhDPUcUNbly1fka
         nv1kD3cSg4gccNhP5G8BoK8QLC3lA4DlEGdiFy3odrf0ZM1w2C4+mGHXjT7CpavjgnX9
         neB+tZPnJyx+XLZhPIqI8wj817ucoZgG+ewarjkbYQw6tach2VQOoteNfMgVYjojEmBJ
         aR1SsPiF2bnu9k6Br7HkGACB8J3iGNwGYYj1zI6KN/o7ICFhecJ6kJ1suxahdONCjnM9
         xrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpCS5wGUx4CepPYyhtkjs6CunSLRyJTVuQXgd3iqq00=;
        b=SietxlchQDuhLoOefQ3JxxXhjoLs0OYEWDy52PGcL51elVfOQNOIT3/iW+34XHDpR+
         Ovfd+N8WTDqxUymyaFU9ZB55LLTiNdOr9BzWG5sMGBNb6iqo7w3RFC/wBAGKVZGJ5vuT
         3QafbpgiKciDICJ6PmmLD8fC/Z0r7QhxaOemx7PudlRtlOCvTlfhbHPX59TFsTXmnQaD
         s3WX1xKiAgEKMg92ysWtLNZwqqnUwX2r20sxoGnjqv6JLy4nPBei5T4Xq6aIfcdG2mZU
         jmeWsHwrvXeXjaTs3fKeKNbaVR3LYW0yuIN9ZAR47kLWn3Tol0QCAJ96SBWafgEFi4Lk
         Ni2w==
X-Gm-Message-State: AOAM532H50FdnLuOYn22a00aQSl1RQfkPgi2f5XGCYRn8lZHi/i0UJtE
        tgsGSzYxuCioo0S+sc2uZOkTxdWLOJUhve4l1+/NTw==
X-Google-Smtp-Source: ABdhPJwOlRb8PQbTugXVUL3jav6MAqGicZ1XoS2jlGOVJZWlS5lZIG5V8xiJH9X2mt8bBVAliofzeGFlXWDe3EMBtvg=
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr2387330lff.184.1591185899581;
 Wed, 03 Jun 2020 05:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200603080304.16548-1-dietmar.eggemann@arm.com> <20200603080304.16548-2-dietmar.eggemann@arm.com>
In-Reply-To: <20200603080304.16548-2-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 14:04:47 +0200
Message-ID: <CAKfTPtC6Qf9tz2VDQ_D-UmWV+91c4zwZYWSYydzdZyp+Y0_B1w@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/pelt: Remove redundant cap_scale() definition
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 10:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Besides in PELT cap_scale() is used in the Deadline scheduler class for
> scale-invariant bandwidth enforcement.
> Remove the cap_scale() definition in kernel/sched/pelt.c and keep the
> one in kernel/sched/sched.h.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/pelt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index b4b1ff96642f..dea5567e4f72 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -83,8 +83,6 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>         return c1 + c2 + c3;
>  }
>
> -#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
> -
>  /*
>   * Accumulate the three separate parts of the sum; d1 the remainder
>   * of the last (incomplete) period, d2 the span of full periods and d3
> --
> 2.17.1
>
