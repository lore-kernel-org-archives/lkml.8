Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A1C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F210222250
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587330915;
	bh=gNi+2t29glCYXfwQMb2AMaTfLjp7upmTADCRahx+0+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XHsAIO6IHQELOaE92NV7gGCTKhTWqdOovLe1E6TR4rJUM9PSIxIwf7H6NvKqob+MN
	 gkwtJjXXLfLT9l4hGs+7SHEUyCk1ax+1LMxcxe1B62bGKXEMXpSPnL+Zdysg0eG5Cm
	 6HetZtL49ItEfE8vkGlap/DQIf2MGbXeSTF2p93c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSVPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725891AbgDSVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:15:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15835C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 14:15:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s3so6239467eji.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JGN7wLVHXwvgXkhYgDE5pBGoB6Yj1cQ4trKcrvGh/o=;
        b=Tad6GT9AGCZSv2/7xBX5bjyZ5esROH/JcXlUtWQU+uUcgJtcCdw3yPJzlj7dZb5K7F
         mEO0if045eF3URAWdqTUUsLbriq/4/p58gEuhzAa8o341ht0/ri3x0YCUzwX5hCMMQyu
         7MJ5QPZiankwcVyg8JFPeMxhI9PZwurPZ4Jmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JGN7wLVHXwvgXkhYgDE5pBGoB6Yj1cQ4trKcrvGh/o=;
        b=tviZmurZS2GQOIF7WB/9kgmbC0QAkoS/zmK9tkx1S4iHPgYtzcUSUiBujNJO/vnyJ6
         eZRDJYSGYGooZg2Ya/3qJCtiO6LxNPR4LapkVtR6iznq5JkNkLd+8cJLGqSNj4f3z0SA
         eBMaABlF1ScfhjAgNEt1WBliZI/I/Lwc1d72PU0ltUUy0pszukkcjX0KKdOWdGVMOZc6
         iMrGI8hxnx7cEUYte3+HB4dGkSRysVVI1QxVIGZ5pes/4/FG4YDMZCOhLBHJ8LmvY8MJ
         Ri3s9BYhuPg/C6/gX9k9xiIsDrxgxpDj3dzKqjXXxMi0zi65JalQKGeV7gS2xbbQI+Mx
         v20w==
X-Gm-Message-State: AGi0Pubs4DVOiASg33WOrqBxVbwHpjJXCHYvijKfBAQNEB4dRR0DANnH
        ZUNQp16YF1PFEElV+29JWHPB8wfZMvM=
X-Google-Smtp-Source: APiQypKKsAv0YcR2D/o96nsvLMedOxEstDrZIycoAlEdwcWcGiVXE9SjNaV/iYHWN6ycpVzrmHsFAw==
X-Received: by 2002:a17:906:2ccc:: with SMTP id r12mr13336628ejr.47.1587330911107;
        Sun, 19 Apr 2020 14:15:11 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id l5sm3016096ejr.45.2020.04.19.14.15.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 14:15:10 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id n17so6224157ejh.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 14:15:10 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr8190138lfk.192.1587330558759;
 Sun, 19 Apr 2020 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200417172556.217480-1-bgeffon@google.com> <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
In-Reply-To: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Apr 2020 14:09:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxnvTK-n8fwNJVHB95-9whnPXZ8jJ7xDOT-dxi5biwxQ@mail.gmail.com>
Message-ID: <CAHk-=wjxnvTK-n8fwNJVHB95-9whnPXZ8jJ7xDOT-dxi5biwxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix MREMAP_DONTUNMAP accounting on VMA merge
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Sonny Rao <sonnyrao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I do have a query: would it perhaps not be a good idea to simply
> remove the "vma_merge()" call from copy_vma(), and do at the end of
> move_vma() instead?

I decided to apply the patch regardless, even if somebody does end up
deciding "yeah, let's move the vma_merge() down" later.

             Linus
