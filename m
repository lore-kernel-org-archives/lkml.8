Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D2D207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403899;
	bh=oO4FMrU6lA+bjFCIsY0EI+/f2Knuo9nck0TdbWR+6nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dTxnldVGVvHa+RQOegcidjGg/j2ZqFUcuV2PXYiHrPtKKCpgLaQDiHuwCNkLOLxlb
	 E1nk+jIolzwI3mFBUVBRAs8/hpG6EuwGJR5+u2Zs1dw1BXFnRHWUN5oZBv/4joSKTg
	 Cyac6dd21/xevRgTuE+wLzTtnfN2Z90XKI7SFF+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgDTRbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:31:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so4898034lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mc3jO9WSDyywZnNARb+9PkWGxpHIG4jg9ejhfkDSd38=;
        b=QchDLI1Py7WZeTJjL0kBMpHsnCZy4/HkpyA5okV2mYSBxiG8pwAkSpKVwNzk2varGf
         Iop+XZ7oYbbjGD/oYKtJmeiMnaPkNrK06W4H4tJ3UwyICl3MgsMEAdXH9LgEYCOLs7o6
         z/2pZmpK9WozTJmz6wIhBGncpy6pUfX+flJII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc3jO9WSDyywZnNARb+9PkWGxpHIG4jg9ejhfkDSd38=;
        b=M6LdjPaMO2Q9Q1hNcLK6hjdkjIohXrml4E4ERl4q+zUYQq4CuM9AL3cLL35amIvT+3
         FwLLo/01kcjxTlanvdSRW7ybLFxOBNzZhWmkj1tg/LyUI9aliFBzc/UQTLwg5vp5xyNu
         e08DxNUEOtijQ/xa5wU+pXI/i7AqwFsciPowVKxg6v843ft2eHx5J0IEwHBY7+khGZh9
         ojwQHyL9DVufDegrfAZwGMpP5/Ys9RizBqY4Uv+dFKBjcUN8bphkjCQMniHko83KFSK3
         vKqjSc+RPgxxvntaJZf3h+qPJgN1orarFA2fwjsyz+3kwXiV8ZjzHkfLOEtJ0fk3pB73
         2+Dg==
X-Gm-Message-State: AGi0PuZX9uBFoS5AwRhENbzP076lJTp7Jkmr0N+fsasalRtsuT3AVKmT
        N4FUZwLr8eIiR+y6eicjUC2E0BU/2jY=
X-Google-Smtp-Source: APiQypLc+zrXrSGUplpc1oseXGg0MsxXT/ttYXmgI7BhYo0DCVvxPgUlIcEMGhueHORKgZiRl0xZ5w==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr10536867ljg.262.1587403895376;
        Mon, 20 Apr 2020 10:31:35 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s6sm26910lfs.74.2020.04.20.10.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:31:34 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id g4so2795914ljl.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:31:34 -0700 (PDT)
X-Received: by 2002:a2e:1418:: with SMTP id u24mr11177146ljd.265.1587403893759;
 Mon, 20 Apr 2020 10:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz> <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
 <20200414110429.GF4629@dhcp22.suse.cz> <20200420124759.GO27314@dhcp22.suse.cz>
In-Reply-To: <20200420124759.GO27314@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 10:31:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnAGzRqaKjLuhRuYLkGY4uY_H-9KxuoCOtW8DkSL38Tw@mail.gmail.com>
Message-ID: <CAHk-=whnAGzRqaKjLuhRuYLkGY4uY_H-9KxuoCOtW8DkSL38Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal signal
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 5:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Any opinion on this Linus? Should I just repost the patch?

I'm ok with the patch, but it's not exactly urgent and I was assuming
it would go the usual path through the -mm tree.

                 Linus
