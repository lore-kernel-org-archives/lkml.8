Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9A8207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589906013;
	bh=G0hjq1FuAIUXSXt7AARyzJ7voi2NiTJEEExK1h2Iz54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EO+MJ6EV+1RAiwJwbivXxTbPmKox4+h9uWWm7caa8F36TRGGMFNWNjSDKTnO3bcoW
	 +IgvYU6RIlTJZs9ttTt6+q2F04Q3BkKTWI9p1zikV4LdVBsnhSra88s2y1i4BTFoyb
	 5F4MgLJ3CXkh1bUCwpkta+gO7e3RV2Mp+VJXnzGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgESQdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgESQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:33:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9388EC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:33:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g1so400405ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFvy+u64rADS0X9wXPVDcnjojb1U9iWCN3n097gO97s=;
        b=KITgpUd5bP2WD+I3Ft3adLmt6MH7MS4MFJexni61RXcXlzD9Gqjwa8Lmdkq9TYyfqS
         KL4aFjs9x04ZYvGYs2IsxZG5dgyhwKLIBJrjoMKhrn6xZPweQeBnKjN1RmntmQCr96TY
         jycjBR645lH/xqU7rOHokwZ9wup3usfS+9Z3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFvy+u64rADS0X9wXPVDcnjojb1U9iWCN3n097gO97s=;
        b=jVtrPhc5RQhKkX/cynKv6lRxPjfIf5/tjP14XUZJxZeSQ8YeR+JmLChJf5yqFd7vdd
         L0iGR6u8m6i/cMdNEHdrFCSAPrU6+Ii7K/5sMf9jdJLQs4Vn8RLLp3EWTLXNW+eC2nsr
         R96If2Nhsg9ehP1OzjNwTfitXuVtoVVJEjNJbzdbmcbwKpj9HCL5QWCFbA7yd+VZCMM2
         9eXOzjD77tTGYWixvmXkvcWtRq7/XjpUM6/vwE06Dosf9XzcWVdSQkYVy2dlIzeybgvA
         k05mUrMhg8rnCT51R96gq5kqwHbRn1HHx9Ql1dQ9I2Aj8CO8qg8kK9MHMaiybkrKHyjI
         zMVg==
X-Gm-Message-State: AOAM531M8QoxTkg304zu0ylIm5PFUFfkEYjihN4SrB+bfqb1tQJLY8Jz
        46R3M7zcIhpgeVkW3YsI1WiDCr8vvGs=
X-Google-Smtp-Source: ABdhPJxymYeP5KmpqzqjbQZj9VFCTDcr1FUkh38/vdM4aZ55TnlaGMERsfjkrCgf8t7dm9ITjJDRYg==
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr185628ljm.70.1589906005293;
        Tue, 19 May 2020 09:33:25 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x11sm9288064lfe.6.2020.05.19.09.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:33:23 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u15so432205ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:33:22 -0700 (PDT)
X-Received: by 2002:a2e:9641:: with SMTP id z1mr145949ljh.201.1589906002260;
 Tue, 19 May 2020 09:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-14-hch@lst.de>
In-Reply-To: <20200519134449.1466624-14-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:33:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjg6v1NU31ku2aAMfX7Yu0oDKRvKeBJVGZFQB7AjcwhAA@mail.gmail.com>
Message-ID: <CAHk-=wjg6v1NU31ku2aAMfX7Yu0oDKRvKeBJVGZFQB7AjcwhAA@mail.gmail.com>
Subject: Re: [PATCH 13/20] maccess: always use strict semantics for probe_kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +           compat && (unsigned long)unsafe_ptr < TASK_SIZE)
> +               ret = probe_user_read(dst, user_ptr, size);
> +       else
> +               ret = probe_kernel_read(dst, unsafe_ptr, size);
...
> -               ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> +               if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +                   (unsigned long)addr < TASK_SIZE) {
> +                       ret = probe_user_read(&c,
> +                               (__force u8 __user *)addr + len, 1);
> +               } else {
> +                       ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> +               }
...
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +           (unsigned long)src < TASK_SIZE) {
> +               return probe_user_read(dest, (__force const void __user *)src,
> +                               size);

If you can't make the conditional legible and fit on a single line and
make it obvious _why_ you have that conditional, just use a helper
function.

Either for just the conditional itself, or for the whole operation.
And at least for the bpf case, since you want the whole operation for
that error handling and clearing of the result buffer anyway, I
suspect it would be cleaner to have that kind of
"bpf_copy_legacy_nofault()" function or whatever.

(And see previous email why I dislike that "compat" naming in the bpf case)

                    Linus
