Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=barpilot-io.20150623.gappssmtp.com header.i=@barpilot-io.20150623.gappssmtp.com header.b="MKGu8xBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgHZNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgHZNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:19:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:19:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so1724150iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barpilot-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bUwFpYACD42QxgeWE3X2J+SkloJfTYibKZZtGpBYro=;
        b=MKGu8xBXuUL0hWLb9wlh+CJNb/mq6JRX8wD1m7pPWqQlF5GhAjq6+R2g0sT0XYEHay
         TV8Mirg6gUHJZyyWX3WCf+C9KoYh7TkcRVOAyh0eUKTbyXcRxDHDE/pGTgectmIdyCYL
         N+d8o2vx7UppJcgXYHzY+9GKAiphMhEBmcktUkTHu+/u8CW1FWIOqHiuoInlcrIy0T2N
         fxOFKCdtpQHid5M69mLCPL+R4/qvglvlvfslAySirBIIlQK2QIDx+jRW0rPUpYej8UvT
         iw+Bw4qLKIe2L1ZVxblSGkzhksCPrHqi2+aCTLwu1Doqt4vS7GakpNdc8VhwF15843/h
         It9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bUwFpYACD42QxgeWE3X2J+SkloJfTYibKZZtGpBYro=;
        b=SNGD9gcI8CN0UpUe9Xx4MxCTIiG8gXWdr7RMfiRx4hqbZ4aOxR2VhpjDyl56mQBHML
         +TLy/2K25o43AOR/zvV9anTbf58rffThU/iCqDvbDrjLn9hmHwsPcsDwkUxSMEa8ZvRJ
         VH7Av+GJhQRDPZKllF4y6GTCW+O0VoYUNYCP1Ncy+dRnql0ylxCr1EwBhPMGM3Z4jo0q
         Lqoc1aVE1CyYfOqeikFY1kZBV07b4wGc1iQutG0fsSpFeTQ7jXpULR4JQ6hJ9om1akhU
         pfF4NurDwW2Uwzgonees+r7B4sTb71BO3ctqxc7PoIrW94KaAUfz2+p6guL5Q+l6NFXU
         9JXw==
X-Gm-Message-State: AOAM533wDOfhJrGkenx6gAQhh0hW9P6CgcvBIlFyjJydz68BVtH3evz7
        6rlT8rQNWu9RcygCYBVFsnv7daUt7zi6o1Ix/ikfIA==
X-Google-Smtp-Source: ABdhPJwcGzezTYdoMZl6prnQJJJRb+htE8S3GWQCqeoJr/SCWSoAuxxw9Po3V0R/Dmd7im1HBqH+X3edHjMwIKkwlCg=
X-Received: by 2002:a92:9fdb:: with SMTP id z88mr13012107ilk.57.1598447967035;
 Wed, 26 Aug 2020 06:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com> <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
In-Reply-To: <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
From:   Guilhem Lettron <guilhem@barpilot.io>
Date:   Wed, 26 Aug 2020 15:19:15 +0200
Message-ID: <CAGX5Wg2rzm74RprNYVzbkGBUx8WJZ5etKE_UOg8S3Eoyd=h2pg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     dedekind1@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 15:09, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 15:03 +0200, Guilhem Lettron wrote:
> > On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only
> > report "C1_ACPI", "C2_ACPI" and "C3_ACPI".
>
> Did you try to dig into the BIOS menus and check if you can enable
> more/deeper C-states?

Yes everything is enabled relative to C-states.
I find, at least, 1 people with same problem:
https://community.clearlinux.org/t/intel-idle-on-10th-ice-lake/3939/9

>
> Artem.
>

Guilhem Lettron
