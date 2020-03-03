Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F76C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140A820848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJV5lLpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgCCUVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:21:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33394 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgCCUVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:21:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so4425335otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwgO9cOowU4zuHwpbJmXttNfsLky+bg1fiQ3b/r6xjA=;
        b=SJV5lLpRMKqd31yWpeqPEGc7Sx+8lMOei7OauXUe71+7Oq7FO9M3WJuZcCm3zjrVF5
         vWzuvNhyUTvPC41/K2x9nvH4SGnyNCbzuBJ912fx2tK297vn6ZG9ClXFde+Wb6KnFMk9
         c9O1HhfoiMVe9ek4vOLYS8wbQxsE/p62YekUnRw+Y5sSPCYgKxo8AIMCS/a/+DNiOt0p
         xtMbJ7UIW/2nMntgSovpI1hlJPvj+LBx19OQu9rRKnwLq+8oA3Up9QcYxIUHX2asrvcV
         JETHcas1Cl4/klj1v5oW01k9GpG+6exyIf0sjr6yLN1ht3rgahELHxkpPsZp1clAZ48w
         kNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwgO9cOowU4zuHwpbJmXttNfsLky+bg1fiQ3b/r6xjA=;
        b=O38JHTkVb7i/Eb35Zuw8fP2RiRUtngN6+kk6nziXkUObDZZ3YeRe8yuAMFCcVWvhvt
         sS5WIvBjz8jd3ZkZlqGzUPwqGszoKzgFX8cW5Z5CAZZ1deNRhpydU7LU60Nq3lxx/2C2
         h1LYWWErDbIxcKOH741YJGwcUpTD2de5Zw/iwkx1SvqRXzHQRrMEXZoj0GEhlDeNvAmY
         c9UuU+tNUCjss2phuqbkbrBBOQER57d5oxlYVqCK3tWCejZhADHfnbGZ2AevQaloFo7/
         RcpZ9S0amDogJN6uTyk6SVgACS0IxhONXbgVm5Bn6/FwuaVFQ2XMTuArskGMMDSs8n7E
         GlMw==
X-Gm-Message-State: ANhLgQ1P8H5jYpWCUn2BG2q/z8QH9lxTqQdZIN82nsGYg69HiJnQ+Avh
        qlm7Bn2JcqQj/2qcBs2Y/3mPdB+qcpf9U9BrA/dcp9JHfB4=
X-Google-Smtp-Source: ADFU+vutrvovFXnBERiCdgpZT7u3ux90PiGT6B9OmcY9VzbHdIl5QVKE7cIVwDkZWQ1bNq3jvMqyFRRxqK/WoKMs3IY=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr4880028otk.23.1583266877139;
 Tue, 03 Mar 2020 12:21:17 -0800 (PST)
MIME-Version: 1.0
References: <1583263716-25150-1-git-send-email-cai@lca.pw> <1583263716-25150-2-git-send-email-cai@lca.pw>
In-Reply-To: <1583263716-25150-2-git-send-email-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 Mar 2020 21:21:05 +0100
Message-ID: <CANpmjNOaZ7PBiQh9r06ZuvsbtyYpKjGCt+0hXTVabOJD18OXEA@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] Revert "mm/kmemleak: annotate various data
 races obj->ptr"
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 20:28, Qian Cai <cai@lca.pw> wrote:
>
> This reverts commit a03184297d546c6531cdd40878f1f50732d3bac9.
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  mm/kmemleak.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 788dc5509539..e362dc3d2028 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1169,12 +1169,7 @@ static bool update_checksum(struct kmemleak_object *object)
>         u32 old_csum = object->checksum;
>
>         kasan_disable_current();
> -       /*
> -        * crc32() will dereference object->pointer. If an unstable value was
> -        * returned due to a data race, it will be corrected in the next scan.
> -        */
> -       object->checksum = data_race(crc32(0, (void *)object->pointer,
> -                                          object->size));
> +       object->checksum = crc32(0, (void *)object->pointer, object->size);
>         kasan_enable_current();
>
>         return object->checksum != old_csum;
> @@ -1248,7 +1243,7 @@ static void scan_block(void *_start, void *_end,
>                         break;
>
>                 kasan_disable_current();
> -               pointer = data_race(*ptr);
> +               pointer = *ptr;
>                 kasan_enable_current();
>
>                 untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
> --
> 1.8.3.1
>
