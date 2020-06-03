Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432C420674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591204633;
	bh=veuV2+7Rkf0gWDrvSOVKN4XDxbUP4RC1xCXLM56xwWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ATrL5e3SSbDXYsNqXwfqhRhPDJbXJAbKeVDmKPKtc/t2GGNp+qCTnKr/2l/AqM6VD
	 3NezDBWGdZnWXkjwSv3TTkiZ+bDbFgmELqPEdkvw9aZFvyJXVvlYugLENjaF+d1c78
	 8Ubt/soBAvofIxJQlcVC2L8yHPKXDMQBD+HVWpyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCRRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:17:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B3C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:17:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so3746603ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHub1uTy4UEBqMa85bH4hyQo4rSo+RVKxNnJQlGH7V4=;
        b=XDY9jgsakz9p4vzjxoPfFB+n0zW+QahVTh0VzwRCUGtogxEwUvxNY4pMed/ZIldMfj
         umKugveGuh+jtvBlqfBOdxCNcs1Kn1aRu/2DZ3dNniDcMBniZGagQQco3K4c81uRmQGN
         A+XUMWe6pLQ33u12ZEnrpp9dn3mCTlzS+P45E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHub1uTy4UEBqMa85bH4hyQo4rSo+RVKxNnJQlGH7V4=;
        b=VjHzV1YXRJbf+1X1rrG4ZJ+wGQs5mzLd+gcsxHNC6IY5Kv99e7q4b1BxK9+E13I51A
         WGDgG+Y8x3E60maUoLA+FDDsXa53AxliWn2JfKbiKsSTyKnf3kSLs17bPMM0oj5S7jcJ
         9eKlkunDDBpGoLDR7C01LRKlL6tdzf214hK+DlAIJ9voLm7nU/pHNAu5UqHuG8dB5kAp
         +hBkxaqe/zFMmsuRar2St0Cd8bzlSVB4jEbSCbFEh9QpuLwRT1OaxT/iA7qct/upKt5h
         oJUqTyaHv/aoHzn0opwoQDgjhDFKrVWbxTWHYAleU1jpxtNQYQDdXCyk9w8SAYvPP9CT
         kwWw==
X-Gm-Message-State: AOAM532/GmX9Erjqr2jzz1aTajDGz4TsYfLArwJI83QAkUqjpYF2lHaG
        j53THo4h3VdFOq1IaDLMlTZRnnuduZs=
X-Google-Smtp-Source: ABdhPJxV7qEEkbeDBr1D6rKY7r4epe1pvzc0ZH1ZveEveZF8nugJ4DtYh3JNpDqC40QtrG9yHMtnBA==
X-Received: by 2002:a2e:584e:: with SMTP id x14mr135849ljd.106.1591204629186;
        Wed, 03 Jun 2020 10:17:09 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c20sm803562lfb.33.2020.06.03.10.17.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:17:08 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id n24so3696810lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:17:07 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr115613ljn.285.1591204627492;
 Wed, 03 Jun 2020 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
 <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
In-Reply-To: <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 10:16:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQr=wMrjpDXfvR=g+muNr4ST6=4O_jv6pOuTbtdbE_aw@mail.gmail.com>
Message-ID: <CAHk-=wiQr=wMrjpDXfvR=g+muNr4ST6=4O_jv6pOuTbtdbE_aw@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v5.8
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The truly boring timer and clocksource updates for 5.8:
>
>  - Not a single new clocksource or clockevent driver!

The diffstat proved that to be a filthy lie:

>  drivers/clocksource/timer-ti-dm-systimer.c         | 727 +++++++++++++++++++++

comes from

> Tony Lindgren (6):
>       clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support

Ok, ok, it's "based on existing arch/arm/mach-omap2/timer.c". So I
guess you considered it one of the device tree cleanups.

But I'm not fooled by your transparent little white lies.  We will
never ever have a release without new clocksource drivers.

Sob.

                 Linus
