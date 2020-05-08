Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5520C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8693221775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588958821;
	bh=R/0MJQWk9vHYdQl8erxZJv82QCLGjr2nSjG3IyBnlTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UHFpwYvwOdNLgVggfowbeSWb19YrtWMZSX6M3qm9e/c/3ZGbGx+9C7QhQtJRqMLcG
	 sFAulWor9BahAMjM9rem7GJIOPhyVtmtoQSfdJB62ayhH2+C9GaCLzeiOo4oIOQhVD
	 mvaiFHoFpG/IbYXxlRGgZO0GkRtDgaidViRuWFBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEHR1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgEHR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:27:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4812C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 10:26:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so2489187ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSXWYvM4dzawngW2S49BH0hSJ+ea5YVoLg7jA7UW0fk=;
        b=OP/MhimedbmAyEvJJB8sxmwdDt1Zo02LFgjE47ErC07NvLByZjRs0k9Qify2f96mQp
         cO7TUlMYMVqnxgqz1ScLcC2bkov8eqdVHkw5HRp0/nwI6Sadoyo7YtkRYp0iBSyjVt7E
         UfNvAXsNMx15aL1EfJ3wuLlj+Zdd24F0If9L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSXWYvM4dzawngW2S49BH0hSJ+ea5YVoLg7jA7UW0fk=;
        b=oXQSsZFtRSwkMmQd51RiTDvbGwQ7H9/IVPMgys9cA50ygqVmxN/f5SJ3ce+JW101VF
         JA6s/EhSBAB1X6Wm+hNrvm/ayLOU7zCL4GxdTfWuvFuIHXGqpz1nsVSggDHbfSyDeMMv
         Im4U3I+1hzbRApFZYYBA02NhyVA6U4Qr/9lg9oO9Rq5A4rbvH2BwOqv3WuzfNB3gZ7Uk
         dl804l0cwHugEAlrBzTSummlov/oQ9CFOJUDaIawBJGpWbXjqs6kOChNja8TuoE9Fn5Z
         8xVITcy9Jvt9DGmhk/wVrFIOEDtObkHMXSjALvXll56pBUJ7116Ac1ZlBAfrb6qbVav6
         EqJg==
X-Gm-Message-State: AOAM53396gf54IONQ8Fmi3SdXA1tNXFNlSb6SnwDhp6GsOI693tPxSI+
        oYiHFe6M8A013NYNAxbjim3HpljNKlo=
X-Google-Smtp-Source: ABdhPJwq/P6s/qiGZOX+qVzufI2jkyDVM1fblFJ0ARt1/YI4D6GwTvfGSWDno/AnQ4Blm7JgCQsmBA==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr2435372ljj.290.1588958817770;
        Fri, 08 May 2020 10:26:57 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g1sm1669470lfb.85.2020.05.08.10.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 10:26:56 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id j3so2489113ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 10:26:56 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr2445611lji.201.1588958816269;
 Fri, 08 May 2020 10:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200507192712.GA16805@embeddedor>
In-Reply-To: <20200507192712.GA16805@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 May 2020 10:26:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-Ym=onfkMyMmOZUr6cFGQUD8kMowX6OcE-A-H2efkMg@mail.gmail.com>
Message-ID: <CAHk-=wh-Ym=onfkMyMmOZUr6cFGQUD8kMowX6OcE-A-H2efkMg@mail.gmail.com>
Subject: Re: [PATCH] efi: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 12:22 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99 [...]

Why is this called an "efi" patch, when it doesn't appear to be so at all:

>  include/linux/dma/ti-cppi5.h                   |    4 ++--
>  include/linux/efi.h                            |    2 +-
>  include/linux/mailbox/zynqmp-ipi-message.h     |    2 +-
>  include/linux/platform_data/cros_ec_commands.h |    4 ++--
>  include/linux/platform_data/cros_ec_proto.h    |    2 +-
>  kernel/params.c                                |    2 +-
>  kernel/tracepoint.c                            |    2 +-
>  scripts/kallsyms.c                             |    2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)

Yes, one line of the patch is EFI code. The rest are not.

                Linus
