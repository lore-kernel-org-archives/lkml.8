Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56521C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309CE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsvMUPLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD1XJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgD1XJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:09:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92199C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:09:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v38so243646qvf.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=E34KFh73pSkJa2DRTDrDuu2OnqOCVfxHnB82WTUMpLQ=;
        b=DsvMUPLr2BXCwYEJNjVAYJEsLj+Sv9Fvy96fJikjwqB67IHXMB6qjCTd5Nt1CTV2DM
         7mEGJglDpBpm/u7EPlfyCWRVlHCHAZ5IS93SCJzsnivww+FcDK1Ea/JFstTgwwKhVwG+
         vqGS4CSeSz0K1Wz/00kcwqXb+iLBr3PKqR+tujeNncp9ggG39d3rFrV8J1CYcT4q0UzJ
         nKks5ype7bNad8iprb90a75Ayzil5CNv7BBtVuVWXSpKmk7Fu6K4w/ykFFBqjjwg389P
         7UKEdqcgJTaCUKpGS9wyVUQQpKZYKPp3cm1FBb6gig4ilzuh6YeQMadPeNqQ4yE5+jMH
         bJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=E34KFh73pSkJa2DRTDrDuu2OnqOCVfxHnB82WTUMpLQ=;
        b=k7FD7ho6w0Y8ShaPJX+OKlQsYamnHlHdm4qziOLHMlMdfUz07k9rvbE+/ODHGZu6BL
         7c0Y40EEnhZQF+RY6E87RUgcn65F3Sgj0Fpz09f7FwceXCkwGXqBfZAgGRHVDaKG9Of2
         7KO/Vq8ff3EQF3PPOeqCVaG3gZh8htCHg7+Ec1bSfwbqoKTDAj9XAkiqZiFuJRv9z0P4
         w/EGvmajR8otfHtmwKs5pXmHWvXQOYkWIjC4pF7nMFWyjXHzUpa+C7+WGpi9dar5xiKX
         +owR3sWwR3VQ8rZCXh/v4RQ+FXfM9Hx2M9GTGsUQGqoKB/xi9ETyrMhplzavM+c5p6D0
         wEXA==
X-Gm-Message-State: AGi0PuZHi/Q8Zf46uzRDyZjxtUMz0VcNX/qH1Dl7dzOwHNSkJD6+18MU
        TcjUsgPgn27S5DXur4yjQFc=
X-Google-Smtp-Source: APiQypLf0Q12QWupyVdf1Ie+vr0NfD2dhUkVNAYlbsbFGryFWBhSonUDQd6fkwOFdQXJz4t24INC/A==
X-Received: by 2002:ad4:42c9:: with SMTP id f9mr28865871qvr.228.1588115345853;
        Tue, 28 Apr 2020 16:09:05 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i56sm15536862qte.6.2020.04.28.16.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 16:09:05 -0700 (PDT)
Date:   Tue, 28 Apr 2020 20:08:35 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <d367cca3297fc07f5fc155f1e0b9b0e93c1b3cdf.camel@perches.com>
References: <1587904265-865-1-git-send-email-zou_wei@huawei.com> <20200428175046.GD5460@kernel.org> <d367cca3297fc07f5fc155f1e0b9b0e93c1b3cdf.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] perf script: remove unneeded conversion to bool
To:     Joe Perches <joe@perches.com>, Zou Wei <zou_wei@huawei.com>
CC:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <5388E360-C450-4F54-B4B5-00568165FBC2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 28, 2020 6:58:46 PM GMT-03:00, Joe Perches <joe@perches=2Ecom> wr=
ote:
>On Tue, 2020-04-28 at 14:50 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Sun, Apr 26, 2020 at 08:31:05PM +0800, Zou Wei escreveu:
>> > This issue was detected by using the Coccinelle software:
>> >=20
>> > tools/perf/builtin-script=2Ec:3285:48-53: WARNING: conversion to bool
>not needed here
>> > tools/perf/builtin-script=2Ec:2839:36-41: WARNING: conversion to bool
>not needed here
>> >=20
>> > The conversion to bool is unneeded, remove it
>>=20
>> Thanks, applied,
>
>Did you read the patch?
>It's broken, unless some other patch was applied=2E

Of course I read it, but yeah, I made a mistake, thanks for pointing out, =
I'll remove it, thanks=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
