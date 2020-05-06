Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CF9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E676D208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jUbD5UxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEFR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgEFR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:28:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:28:25 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i16so2505059ils.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkDAllS86i6Alq3z4SNts3BijlYyvPsoIcv+ue8aWg8=;
        b=jUbD5UxLSRV1oJtdrH8l4vkJlOdaFnoDCwHggnvcWuO50ybSq4H19Kfsv+J6OoCZBZ
         sDkT/r8bk5c9iq3n9GXxmVUfGvmok81rpK8dWKefeIZkGtgqLk0ORLppCUm/Z83KwTqA
         pblZ2lMavzUAYyoBMy9esRjxeFbWN2wedYEoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkDAllS86i6Alq3z4SNts3BijlYyvPsoIcv+ue8aWg8=;
        b=As/3OFptF+de5A2Yvhy0Bi1w/8pbacGtKowHVYB+vwGwfhIIZ/7yvsv2p3BVf9HUu3
         X/285CJgVgy7jHuWArmeFWBKFBjFYiuqjHyAWE+YEQydrVBzaMM3cb2kZw+hpw3fH4TG
         8d1yKV/xNOX0ylnU2XJjQ8DngnCj5sBN/DxxwHCBlQTeZaGkU5tH13BssQu1ZvE5b/nX
         ufknlEffALRkqCL2kA/h9B+rPN17Zxi2d0KsV/Oc4dpEHXbKZgOR8SmecDjtj7q29v7C
         a+U1FrWLOdQlpgKTbrOX0VYRSPlK+VBF8i3hv5YX+yF8Ck35OxKmILfGeu90DRLVELTx
         8WrQ==
X-Gm-Message-State: AGi0PuayYHlewaIrRI24iVvwt46ghVkUSEWeVI1M/c7CwfmNjm2hHtK/
        IfrpaYZnheqQtplCzgDKQIpoHGlN1HuQWxp57xAmcw==
X-Google-Smtp-Source: APiQypIMN4yue9z7yuqXCPD1oqgkfK+58GpdD8IRN9D/xWCQKzyTsf/cozLhBZXGqmf1/i2LcTY2+329eepl/SQwcu0=
X-Received: by 2002:a92:3509:: with SMTP id c9mr10343042ila.262.1588786104558;
 Wed, 06 May 2020 10:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com>
In-Reply-To: <20200506172158.218366-1-bgeffon@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 6 May 2020 13:28:13 -0400
Message-ID: <CAEXW_YQ+iC9tot+HbHARiXz_o_KrDU7LjvuyPkj46DVfGvSOng@mail.gmail.com>
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

Does it need Fixes: tag, and CC to stable? Going into a stable kernel
will mean the stable kernel merges into ChromeOS also gets it.

thanks,

 - Joel

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
>         userfaultfd_unmap_complete(mm, &uf_unmap);
>         return ret;
>  }
> --
> 2.26.2.526.g744177e7f7-goog
>
