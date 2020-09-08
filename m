Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A11C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EE02067C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599590762;
	bh=5EnbF8rNLGG5aMK5Q8jyUVJ17bSgfsM7/LGaAbj29fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=di/QaQUM54keAszdEhBiT9pBSZ8cDiRFS1GYgtNAHnVqbyrS5BK/r+2ueHNka1tDH
	 e/8ohOsJfgyOMzOgH1T5bMB4RBaXwDrjoz+nFLNxG7hSYHe6exVcA2tWGItWmKjUcm
	 7UzgxYhS3/RZfoIkGoh5f6baAmX1vlDDv0CCncgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgIHSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbgIHSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:42:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE25C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:42:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so259991ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex6ni327I15z8C3RrOtZFWWRNPfspAjIP05UlmQ1nl4=;
        b=cCJaROOcsnp26K4DukJrO0BU+LT56NzAyYSPMFzM8BMKk7BWV5Pl7UCZa+6PS5tKQu
         xxI3a0RzwnjPeHxeXrwE/SnLoNnxWz3vaDJ2QF370ZSDUbmHT+Kd4HNeWX461sOlZjkF
         uEwgTWEiQSdVN9BvCS9xomWc5XghpodRjW0sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex6ni327I15z8C3RrOtZFWWRNPfspAjIP05UlmQ1nl4=;
        b=XANOkeSto5XLzYFs2Onu9TVho+w1uUAvA7qeK3DB5c7qtT6/BSnWS4jTfjm+MwaiXF
         wz1yuCMtbzSL+OTdC4kLmfx112mo7/MEFJuVnZBh1Q1bbebBEo73FsmpLc3qCvpismxu
         pg7M4hQYQRY2mKeZNhEiOfa11WfoQ8Xe/gkl4jwz79cAr2D1SHs4o5x0Pj+p0IeGUeM4
         mpXi8UId9EYiJnq9B2J66/8Kv/VPlsMAkJbNEdTgKXvCKeE3xVx+wlqIBo+68jrdrP2T
         jeSa/rndtD53hoS628uNtjosbliWzSkC/x9bJyzrwP2w21A2V/E4ulVzqbkE59MS8S6V
         1d4w==
X-Gm-Message-State: AOAM532aSngweoxd7eZbiFEspa+zZcy4osgfzmZ/Ta5Sso70gpUYpqQv
        5MY+xKwQt/4QS9zX2i+ALQtQBwCd0zGldw==
X-Google-Smtp-Source: ABdhPJwiJA+ruUmYr8Gsxn4DpPdFKdrg22oDbZuVxFHjAxiiPnuRcHzcym5vrs91Rons0JyHJUQKNA==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr12422394ljc.119.1599590537035;
        Tue, 08 Sep 2020 11:42:17 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f26sm156725ljo.57.2020.09.08.11.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c2so179105ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr5241560ljc.371.1599590536022;
 Tue, 08 Sep 2020 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200907082036.GC8084@alley> <CAHk-=wiZUYjmPLiEaN5uHM4mGyYq8RBFvk=iZKkm9=8NxvcoZQ@mail.gmail.com>
 <20200908183239.vhy2txzcmlliul7d@treble>
In-Reply-To: <20200908183239.vhy2txzcmlliul7d@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Sep 2020 11:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi==UJf0fWUGn6RhQ2hvLW7PA9Yj4GWaTJxa3roENAHDg@mail.gmail.com>
Message-ID: <CAHk-=wi==UJf0fWUGn6RhQ2hvLW7PA9Yj4GWaTJxa3roENAHDg@mail.gmail.com>
Subject: Re: [GIT PULL] livepatching for 5.9-rc5
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 11:32 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Can you share the .o file?  At least I can't recreate with GCC 9.3.1,
> which is all I have at the moment.

Done off-list in private, because I don't think anybody else wants
object files flying around on the mailing lists..

               Linus
