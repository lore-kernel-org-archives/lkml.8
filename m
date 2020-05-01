Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC6DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD0C2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRAIwwXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEAJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728325AbgEAJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:50:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB35C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:50:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s8so4371173pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSN/uXLfkt9QeDBMNRjLOHKj5ObcWSm4DpZ/UNYnR+s=;
        b=mRAIwwXYuvw012YcKxlesqHwYppo4C/8KTWbbVLbRqmzEU9DZVsDICONE4NG6JgNKU
         PWBfSkxawaq+lu9QZLv+t60NLjd/A5+M4OD3+GqC4sOE2+LpNzONWIBKHjtKa/YAnrya
         yFboZ7hjvfhktEBDEheqMgu4IWMmLdGy16IuGSAFmTxoDJK8M7jrpTmj/VuQFZXmKi+D
         dIvU/Jy8Ey1PEIfuZfyM+iB6tKdUINzZ7C4ZD9Gj6cKtHsZARCL79TDama4ziN9WYacn
         eBcs3+VYQDTX+AU5IXTUJyV+C1bLPDj+WdYgYnZb8/rHN7JyRNxM7bAAqKFkCaJ0BYLm
         dNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSN/uXLfkt9QeDBMNRjLOHKj5ObcWSm4DpZ/UNYnR+s=;
        b=A/4pA7x/JyLpWt28bVLscKcnUlSq9dJrH6Ost7bPf95gGLSIEpGu3C+q/xYLJepS9a
         n+If1kSQb521MWJVg9mICipegAacVGbgor/INa3rk6hodLhaMEMNhmSJnJdrCB43usz4
         5lPDq9pMesXn24Cr4vbbrHKJQyk1nDykbdo8qdTGTyLaHwf8T4I0FyhDGngJYepNWs5k
         GOyXyH58dedqEtA/Vd6QBuKvDaJQkmlUydztmXDBtfTTjFb8Jq+47rSduLDxYvTEFSP9
         QY+j478O52jrPeOC4R7x8oSxqNtc/g0NjYFoJ2Nqxes3a1whtgWpdly+TCbBzfJ2qzLY
         A0Aw==
X-Gm-Message-State: AGi0PubFGSIb6Am49WCCG8Z0lJ57MgRBsYyxQIBUoQtEVz2SYMhqS4dY
        ZETck0Azu6520yZS5SGUIeE7LR2gcUrWouBkg4s=
X-Google-Smtp-Source: APiQypLnhT57tLSV4RshVGa2uDo12bLGVyRHB51uzZVNE32LSc2WXh3Vopse607pRrP4bNpqHqj8youmiiYHAiyFXV0=
X-Received: by 2002:a63:b549:: with SMTP id u9mr3346778pgo.159.1588326637995;
 Fri, 01 May 2020 02:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200430203845.582900-1-ira.weiny@intel.com> <20200501084634.GH27858@infradead.org>
 <CAMo8Bf+Mvvg_f1-33iQhTqZPVw1civX94KS2mf4uSkcpEVx55Q@mail.gmail.com> <20200501091933.GA3084@infradead.org>
In-Reply-To: <20200501091933.GA3084@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 1 May 2020 02:50:27 -0700
Message-ID: <CAMo8BfKYii4=_rQK22x4F4n-59KYY9JHKQ6E3H5iJ-N3J63rwg@mail.gmail.com>
Subject: Re: xtensa question, was Re: [PATCH V1 00/10] Remove duplicated kmap code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ira.weiny@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 2:19 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, May 01, 2020 at 02:02:19AM -0700, Max Filippov wrote:
> > Hi Christoph,
> >
> > On Fri, May 1, 2020 at 1:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > any idea why xtensa uses PAGE_KERNEL_EXEC instead of PAGE_KERNEL
> > > for kmap_prot?  Mapping all mapped highmem as executable seems rather
> > > dangerous.
> >
> > I sure do: to allow instruction cache flushing when writing to high user
> > pages temporarily mapped with kmap. Instruction cache management
> > opcodes that operate on virtual addresses would raise an exception if
> > the address is not executable.
>
> Seems like this should use kmap_atomic_prot with PAGE_KERNEL_EXEC just
> for that case.  Which of course didn't exist on xtensa so far, but with
> this series will.

Yeah, except it's the __access_remote_vm that does the kmap and then
calls copy_to_user_page...

-- 
Thanks.
-- Max
