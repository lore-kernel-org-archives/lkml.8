Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F65C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAFB204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOFXTXHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgG1PHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbgG1PHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:07:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD506C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:07:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so11176660lfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqKK7cF3q5e7l52iOkJoCa4f73ZLky3ZxfyYCXCSh3Y=;
        b=fOFXTXHHi/1EGMPH8IGLT8Q44caG1seCiZf4b2tdKys5AN6daPLz58LLMJX2ebJ/cc
         AQWC5c4ocJTpnfJFPSoc9f2APOdbHKeBKRbmx26YbLYcFgcQ4x8dhAWpuF+7u2iPFY1y
         hcTYR5Ha1vBv1AOWloZ+DogIi8d6LX27zvjrDSpvIvCtx8hdJDz/dP15WzCSY/sO3Cnr
         +E4ZT8HUyUEWOz8342hH7kQ4UBQzZQ8DX3y2lVOe3wKTNsIC83j0ioCKaKTmjKmgg2ZL
         /voZUK3EQaTO8pYbpQ6KZXZttUyFTwVzu9WJ7YQxGnR/PgyJd7V01NwF5FUNLNdykiPk
         41Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqKK7cF3q5e7l52iOkJoCa4f73ZLky3ZxfyYCXCSh3Y=;
        b=ksQPc7Q0Jnwbc7EGrMENsGPlFWp69zacJ44z2RLI1SfptqyX0DuJrYOgjShqqqAb3T
         D6Vjcf9XIvQtl37uvOc5Qjuz4XCb0YZHoZ+ZfSvAi/UMXCbgW6vz/XwFYAs03nNtoJ8W
         sV6mP+3ZbjgIaTxB+9jcSqMUWCojSq63EPyregD8l9MNUY75W0cAzpgX3/OuDgUcjqFo
         o3p/lcU3TLElMKAGuOzsLMLujpozs4ZmXwYcmvQ2Jma9TnfJIkNHqh02w+i4MVzE0FKf
         EUHvzq3ijgGHrX5kdRorJWgbkD4ENGY8QNhlG0fRvouQoEiriX8uDAqncZWbuQxWVRVd
         9W9A==
X-Gm-Message-State: AOAM531pV97KE+2ygB0kfD4mgIa9ZKeqrolBDNkVDjZHvPiwHdQ7aBEN
        9sp2+9oBzDtlJOMcN3rsshv1FEQCqULX63KO5VprPg==
X-Google-Smtp-Source: ABdhPJwIh3m74SedjEVVOSC5JheogTUjYarQ9WQzCix4/nEg36/t3dfTMvCQXXbABOOu0en98FtXPHRAOIdXI5/E5V8=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr14432710lff.189.1595948841057;
 Tue, 28 Jul 2020 08:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200728135210.379885-1-hannes@cmpxchg.org>
In-Reply-To: <20200728135210.379885-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jul 2020 08:07:09 -0700
Message-ID: <CALvZod6nFiUvcCViwwiHY9x5xw=JCYM_NUOQCkLMeLD8-JNCaw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: restore proper dirty throttling when
 memory.high changes
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 6:53 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
> memory.high") inadvertently removed a callback to recalculate the
> writeback cache size in light of a newly configured memory.high limit.
>
> Without letting the writeback cache know about a potentially heavily
> reduced limit, it may permit too many dirty pages, which can cause
> unnecessary reclaim latencies or even avoidable OOM situations.
>
> This was spotted while reading the code, it hasn't knowingly caused
> any problems in practice so far.
>
> Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
