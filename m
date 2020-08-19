Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38229C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D24207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll89NYVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHSHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHSHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:50:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5281C061389;
        Wed, 19 Aug 2020 00:50:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so10422024plr.7;
        Wed, 19 Aug 2020 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke+wFCJWvMAP2+w0IdS/4S5iRQrwezKZ5RtTFmjUQBA=;
        b=ll89NYVbW1bVNVi/IhBgduKZYfYR6hzxQFxy5h+jb5/5FqiPqYdShpyzlBVvUmjIdg
         al7qRr7ln8bD0cNQ31/19TceKoI55k4TmwJprVcBP0wfOiOppn4bAQT4NjXwDf0Bgbx4
         jJdiLd6aq0g7AWEIllQNE+jNP4bzBvJTOe/BVAGfSCkPbH/w84F5qUVQDYIs16vu83Nj
         iUmieID+X+lLha+LtxueDQh1fzK4p9xjm2DepQoENKKOCcxNm5McKBwg5aIHIXiKf1qA
         o1B5AxHNAwdHbNPDNauWJv9+g2C6koHVJdbaDsRGecLoGuZoRilAWVsWcRH0q76np0c1
         mf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke+wFCJWvMAP2+w0IdS/4S5iRQrwezKZ5RtTFmjUQBA=;
        b=bmxc0FcQPSHYQa1mw2dxSLmab0/67MCm1AyrMmHMr31DQdyyr50nXhl1dqx5sFHllk
         9HOYuwkzNTqFsG/WanumcWjK0MhI8jsTBF5kQArCuEP1BlTWd0z12GtvJ0yum2Y9Ipva
         gVQFOmcUQyq7IZeXq335AzoICnEvfolHhLDA0d11cQ9rGqMCVDRLDEJjT0DhUBLRIwT/
         QUpuQg4AKBRGCGHSc9UiEGo/Bp+J3mFMJsjFzNlIlj19K0w1g8ZHHKzpC34/X8RORBL1
         u4An57s30IfMMnXmXiKaIxKbU2UiRP6l/X4xKRqwUwRh6062O2O/XcNhmWbL8J1iIH9+
         86mw==
X-Gm-Message-State: AOAM531Ah3ubvQky+BHeRkZThmN5aDo0Zn6bVPwHvTMUzKkEzn9p3FDS
        28TQBDpWwdeptoPaMB/wGstXJLFt/bEMWHDPoAgLZt5sbmB2NQ==
X-Google-Smtp-Source: ABdhPJzguy6Y47uqQoTztAlR1Ib+TDOaev40sCIeYf0eQCMUO4xIa6Al45JJW1//72glFVcXMnB7DuWOkT0WRWiIwUs=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr3003273pjv.181.1597823429126;
 Wed, 19 Aug 2020 00:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200818180223.14282-1-kenneth.t.chan@gmail.com>
In-Reply-To: <20200818180223.14282-1-kenneth.t.chan@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 10:50:12 +0300
Message-ID: <CAHp75VdWhSTqCikgnF5vvgw5x96QV5MXBDOWnL4gWt+Z-QK0MQ@mail.gmail.com>
Subject: Re: [PATCH] add support for battery charging threshold, mute.
 correctly save ac/dc brightness to hardware registers
To:     Kenneth Chan <kenneth.t.chan@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harald Welte <laforge@gnumonks.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 9:03 PM Kenneth Chan <kenneth.t.chan@gmail.com> wrote:
>

Thank you for a patch, but it misses few crucial points:
 - it should have good description as commit message (body of this letter)
 - it should have signature of origin (Signed-off-by tag) that I can
proceed (I see, it's in wrong position, use `git commit -s` to fix
this)
 - it should be split per one logical change in a patch, e.g. 1)
replacing ACPI prints by pr_*() macros, 2) split MODULE_AUTHOR() by
one author per macro call, 3) etc...


> Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>



-- 
With Best Regards,
Andy Shevchenko
