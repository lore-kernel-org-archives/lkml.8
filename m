Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF242C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF28B2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdDp0lZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgATI6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:58:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37970 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgATI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:58:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so15226963pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtvuAZ/43/mZHHfizo8i6GGUaKzklYrgQcNWjIYaCCE=;
        b=WdDp0lZvPJmeAzRMpIwzwDhesFmt4i0sEFxsoWiXOtYFS56QGmK9RMbCK6kw8m7QEI
         0X5HiIFpbovQKTm2dPFyoK+0BD8h+9nyX/EFDXoRsjNg9SiNa1Dw9kMgtS9ic0wJ/tEG
         oZuRKII7pM05FfYMOJ3FqF18EyzDEVz6sDyEGT2vwoMuUIYkc04jldFVMxGXrGzXmA+k
         qj0YNEJsKBVQNQVF/I6qffKSeeh1cr9HqY0z+JZtXKYILrthO4WKzF5wlkNwEJgwKAte
         f11oQtwy1F8rNTly7RHk8geriY8aPkf0JWTAO66sju9daX5QTYNgOspqFFcF7ixy3mPQ
         jYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtvuAZ/43/mZHHfizo8i6GGUaKzklYrgQcNWjIYaCCE=;
        b=cfY23+/afDzfrYh6pVOTUP9COfUePJxK/6SF19rZQZIzX+2n/IMs03QVWnqRamRsoL
         sjMFvtKL1jlsucdyDw1MLwyq9pSihz60YNiiFuvHDFowlgmDRqkpr6/8JXyJiH9D+Wa4
         08WAYOBh6EN47+h6BgBwW6Qlq/2s54VzcTCrubri+Mr4A7GKDNI+YZJ8mU1913Up8kM/
         mFRHC+wy5qvIU3iYqpr/pmy/jk3BVFE/oC5HemiHFHoV40s+8Dfks2UUjPcEVoJ0abND
         97+mbWT+ftYRb7h88d3dptY3EPfJmkdIJ/CjJgEbQb37a+YGT3WVy90BHYkvDbfyizwR
         TXIA==
X-Gm-Message-State: APjAAAVuQ4fn5BSShCL14YF9+DdnwFofWHAyZ1gYttQXGuLYzEDx0Q5p
        i4SvQrh/NK9KRp9uxYA+LjHHntDtwHePAeFqRQs=
X-Google-Smtp-Source: APXvYqxDKYl6lynrRj2aQbMI8J4UD8eLFvatdUCj7kFSIsY6n7F0dc4aX6kmUr5QAY/bvs1TX2M2j/bAQhNekoygjc0=
X-Received: by 2002:a63:220b:: with SMTP id i11mr58192051pgi.50.1579510693988;
 Mon, 20 Jan 2020 00:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20200117125834.14552-1-sergey.dyasli@citrix.com> <20200117125834.14552-5-sergey.dyasli@citrix.com>
In-Reply-To: <20200117125834.14552-5-sergey.dyasli@citrix.com>
From:   Paul Durrant <pdurrant@gmail.com>
Date:   Mon, 20 Jan 2020 08:58:02 +0000
Message-ID: <CACCGGhApXXnQwfBN_LioAh+8bk-cAAQ2ciua-MnnQoMBUfap6g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] xen/netback: fix grant copy across page boundary
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
Cc:     xen-devel@lists.xen.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 12:59, Sergey Dyasli <sergey.dyasli@citrix.com> wrote:
>
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
>
> When KASAN (or SLUB_DEBUG) is turned on, there is a higher chance that
> non-power-of-two allocations are not aligned to the next power of 2 of
> the size. Therefore, handle grant copies that cross page boundaries.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> ---
> v1 --> v2:
> - Use sizeof_field(struct sk_buff, cb)) instead of magic number 48
> - Slightly update commit message
>
> RFC --> v1:
> - Added BUILD_BUG_ON to the netback patch
> - xenvif_idx_release() now located outside the loop
>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Paul Durrant <paul@xen.org>

Acked-by: Paul Durrant <paul@xen.org>
