Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C24CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD322076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596657146;
	bh=nCRN2SBkvPZonTg1NpxuAHHUjTZDmHcwxjis5v903Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T6Bu0+uJWuJF0FxQE+INSxPKVtlSqK9SUVTXV58rj3kP/7bPrgi3mJurWnEPEhz+m
	 G8Nvynn1uzgP/peDkhKmFBwQD7Z3XjKi6WrPE51Pn027tE689XDBDieGYycs1TI+zu
	 2+AYhVVAy/N4c2uPyDUXz+Odufp6EBrP/qBmNxCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgHETwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgHETwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:52:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:52:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 140so24898824lfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve0FhzqCgA+9QYmNyfddPNVbN293nU7Jwgp7NV82bPU=;
        b=cfHyS0DGB2cq5rPiD149Ll93B7yA7qPiySelNWAaUDOJtAyK3GXSHWgn7uDDGqCk1z
         Z1y9zWpOStGJHpYvR6PONBcDDxMmupVNiQEwvCghfd10X9FTZ347r/LGGFFeBCws4E9w
         mZpASVTSrMpzkz7myHqtqr20fcH5DMBwRTMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve0FhzqCgA+9QYmNyfddPNVbN293nU7Jwgp7NV82bPU=;
        b=qsRq/XEoscPwMSb4ky95UIQqpdcG+0Kn0xDSak/0eKQZk4ea+ISV+XiGGBmFkyBS+8
         AEMahWPuqkpTSsWjnn99SGW7hw/K0QkJ9yRcCjV4MdWWuCF8+XYujjoNsPYMtSibgHYy
         1bIjd3dtZa5BFx15JYD1lV7SW5/IUTIYgl00s99b/PKddPxcnFHiWbTmR/3QdweV/VAW
         b5jwi3tMUfTAHsKHC3YLceC7eo5ELzdF1l6hJSD7J7LhmrHodskRXDkU3ELA5/rUFiUc
         P84zzwa4CxfV75532+zDUecDsUB60jrFJ4lL4kviMP8woLgG8qZfM3j4GcwqDZp6UquL
         4V9A==
X-Gm-Message-State: AOAM5300ggwuqdJiVQwpCoJcjluujr5LYkTdUtlHroxWT9ebZdQ7PulZ
        OCP/NZ+pRoG592lRPW+ZgrMyP+zt4lM=
X-Google-Smtp-Source: ABdhPJwsND98+83PrxxM3WfjuOuHhtfRZVaqcgKmRajJkg9eYmuPShFz6cLTpheYl3SHE+gzqJsV3Q==
X-Received: by 2002:a05:6512:3583:: with SMTP id m3mr2243101lfr.146.1596657118962;
        Wed, 05 Aug 2020 12:51:58 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o68sm1537635lff.57.2020.08.05.12.51.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:51:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k13so24934312lfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:51:58 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr2316741lfl.30.1596657117734;
 Wed, 05 Aug 2020 12:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200728222041.5d88b2e1@Phenom-II-x6.niklas.com>
 <20200728223440.0fd8681e@Phenom-II-x6.niklas.com> <20200805125317.10bf1d34@Phenom-II-x6.niklas.com>
In-Reply-To: <20200805125317.10bf1d34@Phenom-II-x6.niklas.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 12:51:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGsj_R7pspFegPgtT4on1iYk5MmBz8uZZ3338EH3HO+Q@mail.gmail.com>
Message-ID: <CAHk-=wiGsj_R7pspFegPgtT4on1iYk5MmBz8uZZ3338EH3HO+Q@mail.gmail.com>
Subject: Re: PROBLEM: IO lockup on reiserfs FS.
To:     Hgntkwis@vfemail.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 9:53 AM <Hgntkwis@vfemail.net> wrote:
>
> It's been over 1 week since I sent this into the reiserfs-devel mailing
> list. I'm escalating this as the kernel docs recommend.
> I'm still willing to help debug and test a fix for this problem.

The thing is, you're using an ancient 4.14 kernel, and a filesystem
that isn't really maintained any more. You'll find very few people
interested in trying to debug that combination.

You *might* have more luck with a more modern kernel, but even then
... reiserfs?

              Linus
