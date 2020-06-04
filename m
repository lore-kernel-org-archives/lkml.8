Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8520BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5798C2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591305156;
	bh=UZlijKuPTO1hH3kVRxVei3fDs4KrTnkOB0gtMTwpIcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SnzRXnru1ne7t6ZVPHwsHTzIPbUlUODbKXNUZV9UXB+IrnlXPNTV2ECSRYDYd64iw
	 KmR+bpW6L3opM+M0UHu9DcS/WrMXMZFyZdP3FXz2zjiQs5JQbHAWpmld2ti3bzejxW
	 Nul8aB0ZiaLK/HMKEfdOsLVZ0tbrVe4UjG2Obecg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFDVMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFDVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:12:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A731C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:12:34 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so9078432lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWfV8unn/jDE1IkKTi4eGizRqjMmsf8nkdeQumfmS/E=;
        b=eLzKDDXnYRS3ogKAIKxWM8vlr/7ibcc+4K80kkfpHelwK6HG/xaXBI7lZRs20yuBnj
         Q6PHndcgxKCdrbLWBQe/Arz9rHYXCpgLIyc+ywNXJz0I23n/DmY2AynhZ6lw9Y2KGg/6
         iCRx1EhfcYmsGfUulJaHdN2J3/aIshUlzi+kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWfV8unn/jDE1IkKTi4eGizRqjMmsf8nkdeQumfmS/E=;
        b=PtsUt3U7Bi8gBKt0qfETBxl73xNSXwztiFRX89EUAXxB3goFae5wUj8KnLIBHp6g9T
         3+tzhgPkuIwldBJgLlIAOdFtFPm0p96peziEpqIbep+JGGw6kjK0ZMZCYHhrgNYxZWh2
         jSTD76lAEcp2wg1ION0daAL0bC9yepE9qwT66PFffPWN5qMWTqff/3+kE23SoJ++Wmtl
         C4UG8a7pV+iUtD8g1bvtu8nbL+dVbtMU4ZT5LKuSsngyG1kippaqgnCxeauaTnE7lvSD
         TCjuYwO2cX2lSzHiJKV5Jak3QdsfDSeZ3KDMFL2O8AxGYwF1GFrq00g1QDNWLoa/3lpd
         Kwbw==
X-Gm-Message-State: AOAM5339VP1CfwVAha29pmvgahF1fdPqiy7izWUJIAzgjOsIxp6xTagQ
        9dKjdMkZ9bY4JqNgJVoyxTUvGh1flKY=
X-Google-Smtp-Source: ABdhPJwNRjyUpp2KtAy94AJ+Ct/3b6jegjbHKkmp74fD4zxvaNorMMNXB3FJKkU4IEojDJhBp3uxzg==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr3215560ljg.340.1591305152098;
        Thu, 04 Jun 2020 14:12:32 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s20sm170252lfb.48.2020.06.04.14.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 14:12:31 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c21so4489107lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:12:30 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr3473576lfo.152.1591305150398;
 Thu, 04 Jun 2020 14:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200603232311.GA205619@roeck-us.net> <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com> <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
In-Reply-To: <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Jun 2020 14:12:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
Message-ID: <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> As discussed over in
> https://lore.kernel.org/linux-mm/20200604164814.GA7600@kernel.org/,
> Mike's "mm: remove __ARCH_HAS_5LEVEL_HACK" patchset
> (http://lkml.kernel.org/r/20200414153455.21744-1-rppt@kernel.org) is
> expected to fix this.  5level-fixup.h gets removed.

Ok, even better.

That said, the commentary about "why is p.._alloc_track() in such a
core header file, when it's only used by two special cases" is
probably still true regardless of the 5-level fixup header.. I assume
Mike didn't do those kinds of changes?

Yeah, I'm probably flailing at windmills, but I do dislike how we
often end up just growing the very core headers that get included by
everybody without ever trying to fix that uncontrolled growth..

               Linus
