Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C4920709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="EL/0ZmnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEOUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:44:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B20C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:44:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k6so4201654iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTVysy0/5xwOZqQ9WQNRID/d39HXhyeJhmjEaIIRaN0=;
        b=EL/0ZmnD4zV1ZPVNKBHoMD1mSHsptMNDFEbmH7JnUu6LaQ4VfgO5knsXEh6MYEQeTP
         x6WwPmOekh+ZPaXQD8Z+xo3BOmxB1tO9oq7+xNZt4nHq9JzRRo/kB/noGdLRWBT72wr+
         P1ivq1K9uQcrV08TEjn7FnTOvnTXXcCdBMwtjmWlzmm3YoB2Sh/3c0hh1k1Gm23ytsuc
         SJIJKF34mbRnjxY5+8yXsBpuiVzmud5klBVFPi4jXlfSxuBwHl/v8Q4opiW2U+9CU6y0
         nsxRbWhfSRRSqmGxHBA5+ptLqA/e7cg2K57L3Mzg58XskmMH/ra72iuZKIV1KdVbcQ6x
         sfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTVysy0/5xwOZqQ9WQNRID/d39HXhyeJhmjEaIIRaN0=;
        b=jqAdcx5m1HQ07XjU8p2S1eBuIGg2hZBQR+/QcFVWl/zXjdVbvZsg4PZAhdliv54HJe
         oQCS5UzY3OjqDWSXxaG6UkXCzNsYfj4iQSZjjrb3ATw2vOM7H2L0I3fJMomWZhhqEeoe
         E5y4Mwc4sxur/ldwCc9zehUVSy4rl2QYVbHJdb3lPUUmMyq+ALedmzj5d6dkAj9j+kVa
         kvac54TNtD8YvgTSkRryqwNKZSbRfLJdZRrMPDWEYO93dxpptZbE5znsS55ctBI+btmk
         WyHTbGFFhDz1oCxfkjZeG4C2co+QVrIKM5EppoGjtwzO5mD1KbMYuDcD/1DdTigR+iBT
         6ZAw==
X-Gm-Message-State: AOAM532+A8UceRaEpxbIAU4XaQCVjZo1kk+B3CvNSlpktGON5PQK1OD6
        mPjp4OB9lBVr3Y+5X7SqyDiWuc1RkcNQsG9E+wKgJCXz
X-Google-Smtp-Source: ABdhPJxkMGRph1yex/EqbfiAYz3QnSvMLGz7CWyEAilbUvr8xbLyxEr5zonPDuT1C9W5C/VYQ3poNHkI9BP8hLpTbKc=
X-Received: by 2002:a02:7611:: with SMTP id z17mr4929634jab.143.1589575474548;
 Fri, 15 May 2020 13:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRyHrDMK4o=UZZZWJMuQNjPA8Xuoj-JFF-Lsx26fBTR0WA@mail.gmail.com>
 <20200515121346.GA22919@willie-the-truck>
In-Reply-To: <20200515121346.GA22919@willie-the-truck>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Fri, 15 May 2020 16:43:58 -0400
Message-ID: <CABV8kRxD3_zh_WJy0jWVpxxNG_NSwoTJXdLd8Ym9Bm7PbHhftQ@mail.gmail.com>
Subject: Re: PTRACE_SYSEMU behavior difference on arm64
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 8:13 AM Will Deacon <will@kernel.org> wrote:
> But it also
> means that nobody is using this on arm64, so we could also consider removing
> it entirely. Did you spot this because you are trying to use it for
> something or just by inspection/unit-testing?

No, I was trying to port a tool from x86 and nothing made sense for
many hours :). (it was quite a bit of debugging, because the
syscall that it was supposed to skip installed a seccomp filter,
which then later veto'd random syscalls making the
symptoms quite confusing). Having PTRACE_SYSEMU isn't
critical, but we might as well support it.
It makes things a bit more efficient and is probably safer
(if it works correctly ;). The patch is fairly small. Will validate
and then send it here for review.


Keno
