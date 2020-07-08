Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB003C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D00320739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utMXir49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgGHH0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgGHH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:26:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D971C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:26:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so10875032pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKFUgFUqW5gpKv/bMbAh9j1l3R9X9P0qKmhMZ59xEwQ=;
        b=utMXir49D0P9akytQzu1StGbltgpgfN9ZuZBKD6fgZgD44VQTaNsGnhXcWFm+cGs/0
         nLMiGFHj0bFHrWS3IfMivAIsfnWj7DOvzD5wLAeDWygtxU3KVV/sKMxvuRp9f/NxM1Uy
         v4QeHIDA8EstrT57e413u0CMg12c77PUAoD5EWFyA/k2fTm1p86t0F55VabnwnVIXHuX
         OEMNtUgOZCNV3jhL1NnbK+30VCEotUhb6gPBcc3DpBYHBMeqNH+ashBDXhQRyF40GMnw
         XrWp9DO69UcVvLyPI7Q1R13c9hciBo11yes84IMUDj1ehnt41VneVHag6hRmzTnv7Y56
         jz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKFUgFUqW5gpKv/bMbAh9j1l3R9X9P0qKmhMZ59xEwQ=;
        b=i8QQ6GI3XWkU0hb9EqSuIeU28W4u8wazlaWiyJPIDSsmVZ0nX43JctIlpM5A3xEMkp
         MrHwty6ajY++AbRUjj4viVsXsUuFXy355ElMXZ16RknyGdyxNg8exYgkL+f23aJCtyOO
         KN8/FzyBpYjfjiDR6cbRnm+r+prAs3hf3IsZTwfDb1eRtrf2T3aueGi135GA9UTZ0u+o
         NQJTFoXF0Zt3rsQuaJ4zHg19C9NQZw+VQ2vW8hpFneO0CsEzp7GnCBCUJWs7WRqoR42J
         H8dogJSf25MU92F4rudgMhyaLw9UheQ16zcB+8fh3T29X/gPTmL7a9qy1f0CVXutPAlr
         mbDg==
X-Gm-Message-State: AOAM5306vjvP2kw9gia1JjKGIGk96Ct8xIPlhJF+yqUbtVqNPS8GcMOb
        nm+qul163J4WtBmlQZcqHUH7vpRnZgAsmX+3tsmX/36M
X-Google-Smtp-Source: ABdhPJwHuFHFrEqatHcREKGCAo7pP2ZEllY6EBfxvZHdqxG5bxutXfNX+a5k34Ll+QndpGLNkB+RiIpzBpAVp7akwDA=
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr15025586pfg.153.1594193183635;
 Wed, 08 Jul 2020 00:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200708062023.7986-1-vulab@iscas.ac.cn>
In-Reply-To: <20200708062023.7986-1-vulab@iscas.ac.cn>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 8 Jul 2020 00:26:12 -0700
Message-ID: <CAMo8BfJ5jCXmenR6Hnsw4QffYFLRQh7-ZrKp8OuZVu7mwKT2Ng@mail.gmail.com>
Subject: Re: [PATCH] kernel: perf_event: use for_each_set_bit() to simplify
 the code
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 11:59 PM Xu Wang <vulab@iscas.ac.cn> wrote:
>
> Using for_each_set_bit() to simplify the code.
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  arch/xtensa/kernel/perf_event.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks! Applied to my xtensa tree with a slightly edited commit message.

-- 
Thanks.
-- Max
