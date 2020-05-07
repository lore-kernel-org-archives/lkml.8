Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB41C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AEE208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UhtGXIkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgEGBGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEGBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:06:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 18:06:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so1992737ioh.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=of3KfhSUdjcRaAhhtS98nALCb0SeCwXToKZ3bm5aVW0=;
        b=UhtGXIkCMYXfzHwRayibTEkrHWHkG1XzIQ5y1BMZWH8G+drB3N5LHYxjP1d+TuV08f
         NJKEl1hgPTTnGXlFYqwun3zGwXx1G5gKO7J+tEu+ZX+IgVbd8hWfD7SBDJB59pKA/s/4
         FTagE+4BCKWlq95uTeYFK1eCljj71lUhvBcqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=of3KfhSUdjcRaAhhtS98nALCb0SeCwXToKZ3bm5aVW0=;
        b=PKGoSRVizmV938MreACCAW2rxoViJDEuAXddBKEQndvaDnJw7lxW3D745UMydDJosI
         HyTOIrkBxWEZ14UsBJClKZhESzHfYjepUu0dckSZUI2m+jtwonatrSDIIt/F3rYjCnoN
         X8WoXQkkX/6I1NaN7iqqI0JIbgkdAke0HhSVio0yhOKkDJYscPtGE9u414XDYBmip7MT
         YnTCAsxNbpBPVU5AAer1EujEqlV+8drVZpLrS0LRtG8MsmCWGHkaU4pjJbNiHlj3abpe
         ObR2NsrBsk/Ns+YMw9X4h2TYedddSnYk4hdo5EggfGizD5WyTzAjxHxheb4UM1DFHern
         jAZQ==
X-Gm-Message-State: AGi0PuY43BM1PxKI9jz89IPbY8WuSUp2/bxgaRNxavi1BL5nY6gb8WmH
        1JwkrBFAoYzXOmfxDx4Iz8yL6Xnsi1Muv4bsdXYkPDcVroQ=
X-Google-Smtp-Source: APiQypIhPDD2VryfsIP+QJWr3Q6Ie5B6ZGqJNucbPF/WIouLSZ5535SkF1Dox4SaU2fr+Fd//5tpVpHC7B1MreVXAAo=
X-Received: by 2002:a02:a68e:: with SMTP id j14mr11373661jam.86.1588813608862;
 Wed, 06 May 2020 18:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com>
In-Reply-To: <20200506172158.218366-1-bgeffon@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 6 May 2020 21:06:37 -0400
Message-ID: <CAEXW_YS_rAxHuj_Jr+0xWQSUyiOX3WKnJNevh2ReE=O+Xsp6SA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 1:22 PM Brian Geffon <bgeffon@google.com> wrote:
>
> A user is not required to set a new address when using
> MREMAP_DONTUNMAP as it can be used without MREMAP_FIXED.
> When doing so the remap event will use new_addr which may not
> have been set and we didn't propagate it back other then
> in the return value of remap_to.
>
> Because ret is always the new address it's probably more
> correct to use it rather than new_addr on the remap_event_complete
> call, and it resolves this bug.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c881abeba0bf..6aa6ea605068 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -794,7 +794,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         if (locked && new_len > old_len)
>                 mm_populate(new_addr + old_len, new_len - old_len);
>         userfaultfd_unmap_complete(mm, &uf_unmap_early);
> -       mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
> +       mremap_userfaultfd_complete(&uf, addr, ret, old_len);

Not super familiar with this code, but thought I'd ask, does ret need
to be checked for -ENOMEM before calling mremap_userfaultfd_complete?
Sorry if I missed something.

Thanks,

 - Joel

>         userfaultfd_unmap_complete(mm, &uf_unmap);
>         return ret;
>  }
> --
> 2.26.2.526.g744177e7f7-goog
>
