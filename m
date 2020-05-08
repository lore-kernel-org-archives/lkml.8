Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BCEC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5522085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="SfTf+OO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEHCOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:14:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE66C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 19:14:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t8so65660qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLKQPqjJWCXj54K1Gh8dCITWiEhj21MmdX1oJPKn5pU=;
        b=SfTf+OO/QBzzc8u9lKYw5BVrWzbZCxzuRxuRLTiDAfE5o84rTilZ+A2VjvwHcTRha2
         GpGybnQxSAJuLCGUt5NBslWKL6ySEFyNiBzNsred3b7QFr6i/Hv4FqOCO1a7ELo+2SHt
         ECd6v5KiNMVhxQtpDRDYerix+AkveVMLPr/r6mSDQbU9gKZhvK+04z8hw+8HwUwA4j75
         roiwguGnUtYlc2jlmhGYZ4GvMeukzaBDAIy1th69XIx36AlIwazWKyo2ZXJ9J+daZ3tC
         DXMRNKvv/n8CSStQF55om0CqjWXF+5++uNaT/IVs0WxGK4eNaa7WVbRyJVO1ac79qDru
         +p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLKQPqjJWCXj54K1Gh8dCITWiEhj21MmdX1oJPKn5pU=;
        b=hV9DhprZFSbkamp+lzL+W0cSrt8R7ct8v4lQdXM9QURR23jGNrU6kjylJWzECLyf1v
         /JI49grFKP2q9HVjM50cJy22x3RacF4S9PJFe2Nw1+efySKFuGe6DKBkk0ogDN2P0MIX
         FOkIea2vj+2/CenaqNHzO/E+baZ7wLQjROnHY1lEmpZDuAAZtLq7tghupzVAIHTVwQ/q
         lzYPJKZgqO0Ax5PyEwV9iLAwAeOk39Dx9Dni7cXZqUpCtuwV6r8MVhRVjN3qG9eVwTrn
         yt/S4GC9LWsmNxPYC2cSvrYQacrIoc6YZ5wQmqTIVo5Zm6MdNdd8Of4Hui3DNYk8Ud+0
         yItw==
X-Gm-Message-State: AGi0PuYrv7SBinj70u0+TNmdUhk17UYsgGmoZ/VD4eIvmFP1N3dpGO8h
        CJeA+VGnI5T7lRLld1Zzit+r1WBZrMHleBRQD5nwbzK0XB4=
X-Google-Smtp-Source: APiQypLxlHUaHqzSMnOzFJ6rwiV35lPZDV1gcTIwFgzueXJeEYd4GHV98su8ulBIOQEVDFvPxTEqJw60MFJ8YwP2nms=
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr541590qvf.30.1588904086730;
 Thu, 07 May 2020 19:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507215946.22589-1-gpiccoli@canonical.com> <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
In-Reply-To: <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Thu, 7 May 2020 23:14:10 -0300
Message-ID: <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 8:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Could add it to vmstat?

Hi Andrew, thanks for your suggestion! I thought the same, as a second
potential solution for this..was planning to add as a comment below
the "---" but forgot heheh
I agree that would be great in vmstat, do you have a name suggestion
for it? "compaction_triggered" maybe?


> Userspace could write to /dev/kmsg when it decides to trigger
> compaction?  Although using the kernel log seems a fairly lame way for
> userspace to record its own actions...
Well...you can think that the problem we are trying to solve was more
like...admin forgot if they triggered or not the compaction hehe
So, counting on the user to keep track of it is what I'd like to
avoid. And thinking about drop_caches (that have an indication when
triggered) makes me think this indeed does make sense for compaction
too.
Cheers,

Guilherme
