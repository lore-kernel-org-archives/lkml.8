Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82030C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA8E208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593804400;
	bh=76yHUN/r/M34AoxxUFxuMv6hAiEc/KHzLywCRTY0t+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WhXi4kV/uhEyA7NgyxFY6Sfvcu3zPyim41vNU8gt1VWj/11E1RaiM3FWaBIIp7m8q
	 cT7KtT//me4O5GwcBBFa43W1PhWk1nn7upkUrppx4XjosyroqCrP6JNjqyF+4TdmWP
	 WZOMPWh4luwYvngQU7ChA93pyfZ3/orKf1Qwipew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGCT0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgGCT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:26:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87FC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:26:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so38245358ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mo/Lr6vtY0FHiwQhfz60EO8eUAwTqrdef24sgk/B+aw=;
        b=CvUdAxIUjjv3eTbj/BWheCVE2Pg7nWLLM86PV0t6XiWuayCHWPxFfaZ8EbZpon319V
         VCY8rg7b8q5a4X3vnWEWulRKh9vC5zcI8uKUn93TOfwMf1XNkpMYMf+ksYc9LPXSKWyw
         o64QSDIrjSME00hQS6hVsF2vNMnsXDtOFTpv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mo/Lr6vtY0FHiwQhfz60EO8eUAwTqrdef24sgk/B+aw=;
        b=fyld4wry9oSbXlMmtqT349zhwSknnwB/7TNOWN43iNaT1R9yGZydA7daV/y6cqaD2A
         8dH4Z3uKZlxQDBuMVIWYr3yIBbZHalgDN16m3YBXbDQuQDsUk6tTJqqCQd8FI34IbuBA
         5K2XmYU1QWxLgPL+j57nloA/yoYCgUK40M+WyPf0Oey+wsOGfPGJSc1jF7dlYCQgT4mw
         YmI5IwTtearmtXWJbhgihkkiAkxq5PxssZbpAFflR6F+zTRLJo03w1G58Re8PN/AbpLE
         23EYV7cKaisDDZc9TWrWG45NFrzD46u/SQHfwjdw/HYz6PVyUJlvnYNAuwT1+HWzSSkD
         q98Q==
X-Gm-Message-State: AOAM532I8mjFtvuiBh05/8tOW8ujOf+SUPHzHYEtJ5myAcwoVTqDyS6c
        m8qAvVGOGksl0Q54AFhVUfvermxN3eg=
X-Google-Smtp-Source: ABdhPJyJd723DBk+huB3EZKNq9rOnZZpIIovIwlPVHQn0yI6TOAq75DuDNF6g9wS/JfJAb3Q/KMiXg==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr16969656ljg.61.1593804395470;
        Fri, 03 Jul 2020 12:26:35 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w19sm3200817ljm.120.2020.07.03.12.26.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id m26so19090136lfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr23140481lfq.125.1593804394241;
 Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com> <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
In-Reply-To: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBk-jYM6_HBXbu6+gs7Gtw3hWg4iSLncQ0QTwShm6Jaw@mail.gmail.com>
Message-ID: <CAHk-=whBk-jYM6_HBXbu6+gs7Gtw3hWg4iSLncQ0QTwShm6Jaw@mail.gmail.com>
Subject: Re: [RFC v2 0/2] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 12:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I see nothing wrong with this [..]

Again, I didn't actually look at the gfs2 parts, but I assume you've
done all the testing of the deadlocks etc.

The IOCB_NOIO patch you can add my acked-by to, fwiw.

          Linus
