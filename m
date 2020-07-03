Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A37CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F02084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XwxLmeze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGCSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:36:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6FC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 11:36:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so19002520lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENvEJ82iZJ8k/1p4VxclPU5jsWxmJbuO8tEGgnSMZLE=;
        b=XwxLmeze6j9JIof0E9cCpQfSV+AgPdF9WzdCXwiKNdSmc9IirBHv/hWfOl4j7G/oo/
         rIhQShtIg4/rtoajnYKJ9McM1TSyqXIAiEJOYPvBzCFhbXUCpOUTOiXspXbzHUYOTYBe
         ZianoTYnE5ispJRMb3eRM3zPPAbci/bcY2NZxkknHH3cAMqHwKb33B+Yc/cj6QDpmTBq
         6hDZ3IxDRoVTGEoCm72KrNvnKgeOw56oWvM/2bAHQZoAWHF2tCdBUK4S67nzdI/taiC1
         Z4J9Gd6KCtukaDlE6lu1WJecVgL5+1bWmkQMy7CbbqWXr4uWicl1aNc+6ZeAsCsXQqUb
         c7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENvEJ82iZJ8k/1p4VxclPU5jsWxmJbuO8tEGgnSMZLE=;
        b=e83ljZ519OsIlLtQ+ZWrJa1GjNOG5W3Zgm1FawiIajnXZiLbM2Oz1opRzyPqEb1Lqx
         Oj/ljm32aoubPkdueNKzLKBP9e+bAqq5RIA0FDBzXUs8z4J1rtfIJpW3IKqXyOCTSI4m
         a5So7lXiQrYSjCeFHaiS60kS9gLkQ7+JbVScsEVI+x/i07yhCh6/JcfpbbzzfVx+Xmhh
         mOk65KRTF+4og9ThJYPhD9BX4Hn8TkpLEFhyF1hlD3cy/Swp5yKOjrwKPnbJ6KYCqo9l
         U1YVfBkuVt5ugGQ9n2QKN9c9DRZz9nATf6C9A5fSqR+nXzIcvqbLsklaZnf7DgG+lxGN
         0Myw==
X-Gm-Message-State: AOAM531/XVsy5twcLOXdmf/sJwQ3COR2h0UlJDKYJVAPuB9I3vz75YFr
        GdPeXg1vmzXXw0zDl2KRz0pNEunlohtzsE8x8w==
X-Google-Smtp-Source: ABdhPJzF2URyqJhurl9+AoFXr1fjEq65BZcVKDV/r0cgLEv/+7MX7swkIm3l0JoC1RWkRpj3GR2xvOxWiss+Yv2T6R0=
X-Received: by 2002:a19:7014:: with SMTP id h20mr22350887lfc.49.1593801388730;
 Fri, 03 Jul 2020 11:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200703155749.GA6255@pc636> <CAEJqkgiFFh8CvXkM4ZzXxNQmOJLL7WcgDL6rM83safNgEewZ9w@mail.gmail.com>
 <20200703174539.GA4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200703174539.GA4800@hirez.programming.kicks-ass.net>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Fri, 3 Jul 2020 20:36:02 +0200
Message-ID: <CAEJqkgh0samT7TkLqhBLw5x8-bV1iAX1a-PHxtgruMgpdsfvBQ@mail.gmail.com>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 3. Juli 2020 um 19:45 Uhr schrieb Peter Zijlstra <peterz@infradead.org>:
>
> On Fri, Jul 03, 2020 at 07:07:39PM +0200, Gabriel C wrote:
>
> > I boot all the boxes restricting the cores to the correct count on the
> > command line.
>
> This, because you're right about the wasted memory.
>
> > Wasted resource or not, this is still a bug IMO.
>
> Yeah, but not one we can do much about I think. It is the BIOS saying it
> wants more because it expects someone to come along and stick another
> CPU in.
>
> Possible we could say that for single socket machines overprovisioning
> is 'silly', but then, I've no idea how to detect that. You'll need to
> find an ACPI person.

I know the EPYC box got that problem too initially, it reported twice
the cores and twice the sockets,
but got fixed in some kernel versions.

https://lkml.org/lkml/2018/5/20/102

I never really looked at how this is calculated but I still believe
there is a bug somewhere.
