Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D421D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlikmW0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:04:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42397 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:04:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so4421753edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HbVZOQvmDLYul0lKSvQQMmCFWhXIMyG0jD9qHeDuze0=;
        b=UlikmW0lzuBMSt5Oc/ZFq3MNhzsCt5bC0Aba93HdKIJCtCGnlHvWPekf5GiVNW6lIV
         iGlx/8rBEIvVjU2KGoUFrUuHmLyC6YnTYhk60424Tp2gjjHOaReX4D3vxtXY9fg1mc43
         ZhsbXm6qygilUWFEdsgbkFOUA1s7ZgfSduXUB99GvqzGBsXeYFUSupq7AwVzhels6MOb
         S1Ulo8jVifExSZG3UToV6XVlRQXpc0p37UqCNyAMyFT7zZ8jLIA0/p0Hxv/G/11lpYLK
         VYJTfoi9D32v4+h+DBR9Lc3zlZkici+0e3OXmrK3DV6cBhYD51Iwl39qfDvluakamOH9
         o3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HbVZOQvmDLYul0lKSvQQMmCFWhXIMyG0jD9qHeDuze0=;
        b=QDUrRHGjvXTWUWjp5oRD8hcuPkUGKh4e+JIRfAdtBygtIEai3cd5uwfBkvyQJsevRP
         EgeR1VUCNxpHbBqs3yopZcYIwUgBkY2/ettXfLUXMr9Y9H6807eLLiNesRawx9UQ838V
         RTxQY/pmmKxPvzcgSDBcFIRd3pAjRoL1dr8qZk9nSyZnkZmCY7O/+RaLp3QljSjkBxDD
         Hq9YSB55eCvEpf8uRaEGOyFpcSHICi/1QVYxSNfBRcTbtZx+qt9/ZWHDbqOZq4g2OxqC
         R1dQ/hbrgg7visuoOo1krjxins5rXiNYK1cMwym2P31KFNq7J7Aua26Rhi1Xy9a4z+ah
         w9aw==
X-Gm-Message-State: APjAAAWUPUGIMbec185jl2apHKqtT14ySxISLSOdhpV7ir2Y20PnOEKr
        y0rkoBgPMwXTCdp+nAFr74oewFhN+mO3ZvI3cDa8+A==
X-Google-Smtp-Source: APXvYqz+g3XsKBoe1r6awz5wE3JqrkD3YD2kS/0bT9IOZn+i4OcdPU8HSsrlwBCCkON0WX50n+lqkzFTeklQPIQpxMY=
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr7637324ejj.189.1579806250136;
 Thu, 23 Jan 2020 11:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
In-Reply-To: <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 23 Jan 2020 11:03:44 -0800
Message-ID: <CADyq12zvTnCtkBjDZjj_dQHapFYuTh=W=KXCEa9Hy5M9DXpugg@mail.gmail.com>
Subject: Re: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

Thanks, yes, that's a much clearer description of the feature. I'll
make sure to update the description with subsequent patches and with
later man page updates.

Brian

On Wed, Jan 22, 2020 at 7:02 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Jan 22, 2020, at 5:46 PM, Brian Geffon <bgeffon@google.com> wrote:
> >
> > =EF=BB=BFMREMAP_DONTUNMAP is an additional flag that can be used with
> > MREMAP_FIXED to move a mapping to a new address. Normally, mremap(2)
> > would then tear down the old vma so subsequent accesses to the vma
> > cause a segfault. However, with this new flag it will keep the old
> > vma with zapping PTEs so any access to the old VMA after that point
> > will result in a pagefault.
>
> This needs a vastly better description. Perhaps:
>
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is set,=
 the source mapping will not be removed. Instead it will be cleared as if a=
 brand new anonymous, private mapping had been created atomically as part o=
f the mremap() call.  If a userfaultfd was watching the source, it will con=
tinue to watch the new mapping.  For a mapping that is shared or not anonym=
ous, MREMAP_DONTUNMAP will cause the mremap() call to fail.
>
> Or is it something else?
>
> >
> > This feature will find a use in ChromeOS along with userfaultfd.
> > Specifically we will want to register a VMA with userfaultfd and then
> > pull it out from under a running process. By using MREMAP_DONTUNMAP we
> > don't have to worry about mprotecting and then potentially racing with
> > VMA permission changes from a running process.
>
> Does this mean you yank it out but you want to replace it simultaneously?
>
> >
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physi=
cal
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consum=
ing
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
>
> Cute.
