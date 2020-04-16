Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0BC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87EF206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wL7Q0gPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895193AbgDPNYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895194AbgDPNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:23:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31751C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:22:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 198so5570985lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ghI5WBqdl870WOE8SE5UO5Yl3nEjaDEWsi+NZM23pY=;
        b=wL7Q0gPf1pOG5mpwohfKkO+zHQJzeFIgDMOlXgthXC9kCDgo3A7DD5pysOL3BHoeod
         9XSu8hDaxyyuh7eoujNL7pHKDV5/1LuFvn2pDWwWZ4jc6neNJ8uKftpodRcTX67KUlsx
         fexJIz75CoqVryD54Bsk8MrFrBwykj61Qb8mG4kNMDVQ6FRzkxckoxDdAu/ami5maQeV
         c5Uba+Lu/rQG7nrGTdwIukGU4NevTWa2wQxjDbrZBOeeWlug+8NVsPwTpTRyofKSwXoY
         qpK1Bzc6r7+rQqoSa1wuwKVOL3bQXczAy72GWXvV5vrM16D2iGMDg7xTX41johkrwoo/
         JeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ghI5WBqdl870WOE8SE5UO5Yl3nEjaDEWsi+NZM23pY=;
        b=YIuJ+MDEJRRr6cxVkDi7ZM3LYXFHwFM1INW3+SCC7r/hV+6N4yuXBGPANav5CL59SO
         wHuSUCGIBGzdO+G/ygv+r2BugBn+xM2T0YM/JZT/bukip31nFT/epFeByEIsPAPV05so
         dQl6i2tOH+40E3RchxcvcU40aNo/S7X13FnuxQoGj0YR0A8tv8/eT3ZqVYzXtWKolbt4
         WLSmQaTsT39uLH3dIRY8zgKPEj+MLBXD1/UnBY4AblSEcM0lmmKIpHC2tAVT3vbEms+F
         0lUWuUDFefBt+CudANlj5bwlXloAqG8SfcMV6TpDavgXwSPBYWlnFCHofGP0fbQY+dQu
         IL4Q==
X-Gm-Message-State: AGi0PuYtXQsxZuXFEMEpwws3kD5UCnAqlWMc1ljLAfr9OwjwX6FrMfWq
        C1I9tZkV+m567dZTkuHFhI+GBgoIKf/6lRVJ7KbMyhPT
X-Google-Smtp-Source: APiQypI8lGR85RQI+rU+pCf9V2Sn5n7Mvg4Ykbb7nhe56xJbWhdmIJaMewqk1OlOrMbaRXyV8387wTS3UaZFas2e/P8=
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr6011166lfq.108.1587043371445;
 Thu, 16 Apr 2020 06:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200415222312.236431-1-jannh@google.com> <20200416030232.15680-1-hdanton@sina.com>
In-Reply-To: <20200416030232.15680-1-hdanton@sina.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 Apr 2020 15:22:24 +0200
Message-ID: <CAG48ez2TPqUnDpuQOmmTw7WeMH3+zOJWG=zYzExEb8yPYQQ3uQ@mail.gmail.com>
Subject: Re: [PATCH] vmalloc: Fix remap_vmalloc_range() bounds checks
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 7:02 AM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 16 Apr 2020 00:23:12 +0200 Jann Horn wrote:
> > remap_vmalloc_range() has had various issues with the bounds checks it
> > promises to perform ("This function checks that addr is a valid vmalloc'ed
> > area, and that it is big enough to cover the vma") over time, e.g.:
[...]
> > @@ -3082,8 +3090,10 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
> >       if (!(area->flags & (VM_USERMAP | VM_DMA_COHERENT)))
> >               return -EINVAL;
> >
> The current kaddr is checked valid by finding area with it despite
> there is room for adding change in checking its boundary in a valid
> area.

I have no idea what you're trying to say. Could you rephrase, please?
