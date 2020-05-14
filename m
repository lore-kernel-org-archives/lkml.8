Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0826C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8E72065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTwAhmLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgENAep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733132AbgENAep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:34:45 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F0C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:34:43 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v23so324495vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1F1bz86BhYtSr1k2hqnfmTpTysaJBy4VwQZQPcWyybc=;
        b=bTwAhmLs3rFXc4n5b1BzgwPLaY24LOfPDqOowuTtvpOQq3Y4oIurMMd/WiwI4bE74m
         rDiDiRqykJ6JqDpH4DevmhVdJwF9bkBqDQVXI/6DaJql9SKOpUGr+1G/CjatLRVdDfnT
         FaHL8eZYeb/OJ6pLil5BJhtNXOydcFtYsrTGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1F1bz86BhYtSr1k2hqnfmTpTysaJBy4VwQZQPcWyybc=;
        b=K0aBllV6j9a8+4ukpirqj+vtX+jqwdvlhkGoEOwOvo2Vxq1I0ooLgMkAU6C/27fDIM
         dbKjlhaG54XIZc5BtkvrGuyBvEBUjViIvXzwOkz5Ln02fhVxT7NM7BKk9a3mgtkSPXi9
         y7/3gHY5ZtFzdHEi1hUcw7DoevDC8SZzvAs7AXorGkqBsvzqSW5KGPtqWQ5SZzuWD6we
         k6zhwVbR1XLFC0cycfeJ+wCevA7PVY9GCuIQJIog6rbbyqNxEqVLD2s0c0Ae8aPZALI6
         wGcj9u3lL+rg5Yvmsr2poy41MtZyhFQ4KfHoSJagyLCgdQOTaoJEdYZGcjB6vR8NOjh6
         ecCw==
X-Gm-Message-State: AOAM533PLiWIo2JRqbVBJUPtG0bBQJvRdNhmWx1i57bsTMR4xNPEeZiq
        WGGaeuG3Lbe3+9OaAcJsVzWTadWJHiQ=
X-Google-Smtp-Source: ABdhPJwuWT8P1SFR2iPyMDSTBEk7PHDS1Uakl0q2Yx7q+7Hbo2jd2DJ2HEGzOYksg5SQMFr74XbYnQ==
X-Received: by 2002:a1f:17d7:: with SMTP id 206mr1668133vkx.2.1589416482423;
        Wed, 13 May 2020 17:34:42 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id k141sm322410vka.23.2020.05.13.17.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:34:40 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id l25so956118vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:34:40 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr1585682vsk.106.1589416479714;
 Wed, 13 May 2020 17:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com>
In-Reply-To: <20200509214159.19680-1-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 17:34:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
Message-ID: <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
To:     Wei Li <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>
> This patch set is to fix several issues of single-step debugging
> in kgdb/kdb on arm64.
>
> It seems that these issues have been shelved a very long time,
> but i still hope to solve them, as the single-step debugging
> is an useful feature.
>
> Note:
> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
> https://www.spinics.net/lists/arm-kernel/msg803741.html
>
> Wei Li (4):
>   arm64: kgdb: Fix single-step exception handling oops
>   arm64: Extract kprobes_save_local_irqflag() and
>     kprobes_restore_local_irqflag()
>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
>
>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
>  4 files changed, 48 insertions(+), 30 deletions(-)

Just an overall note that I'm very happy that you posted this patch
series!  It's always been a thorn in my side that stepping and
breakpoints were so broken on arm64 and I'm really excited that you're
fixing them.  Now I'll have to get in the habit of using kgdb for more
than just debugging crashes and maybe I can use it more for exploring
how functions work more.  :-)

I'll also note that with your patch series I'm even seeing the "call"
feature of gdb working now.  That has always been terribly broken for
me.

-Doug
