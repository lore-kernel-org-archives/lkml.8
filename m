Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30859C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0467E20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7ryttcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgBKKQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:16:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43165 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgBKKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:16:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so12243641oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsA40FNHXnwLHh7IKmzOeNQWBgQCJUOT8ocz3FCyoBA=;
        b=H7ryttcSvSi2c/NOyUxx2HNIADaLVIIiHGrsf3P7Kn2+W5EkpMUgTJu7CkRD22Rv21
         +GYrszbQPgsAP+gPTQsD0LnwSneb5Xb2Qd7dpUSy6qcFF3Nhi4tW8p18lFO35l7B45/1
         /JEptDTHdevfE9O5k/AAdPwF9CMS71pMWVHJvufWEI1P6MmWg/gERLChPEW9PK7kM63q
         6KgsbLyyWT4UBJArNFc35q4J6748QMwOqz5nNkN5Epz1i2fHrDirawIiRZod08cbhLEZ
         O+dSxR3N7ngFieDWORjCFQS3VEZgx3mryuvsTNJZWDmkxORwoyNNlN/8keMjist73zG+
         /0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsA40FNHXnwLHh7IKmzOeNQWBgQCJUOT8ocz3FCyoBA=;
        b=nydTbT+WukriZMUZcDdu+OhFT8bldGlhCBDahUAnD1q5OrUnT5dl56Q4PJUY/fP7A2
         WvC4YBE04MKUkLVWVgKx4AAu7ACsVzkqukzrWyi3PiMR5XbQd5uT73s8XQJB3au+AL9I
         vg7BRiHhNqCV+EZiOFOXc7KOPuOTdlVFPGwUwxfkQOs2fZWxXK3WWtHJmz4elRzC/38Q
         aQZ+lh3p3Vk02B2VsqVLQH5YgnX+kFuAChoyodeDs71rYkO10pGkFx3nHYHQbKTccnT3
         8QNe2L9RlHOcaVgS5MD1Zms0MfeW+P/Mzx8x9vjdO+TX0zzeWlGf20mYy9q7uT5dgcgQ
         N5QQ==
X-Gm-Message-State: APjAAAVIqVHczDaAZFNSGC92KjAQz/PZ2ztTbQPyLDXG5PUigaYW8UYC
        7fxQTsKUsqYyByX7KYjSxK/t0TM8fIVqMX+TWSuTgLSTomc=
X-Google-Smtp-Source: APXvYqw2B3pRY9MF1dFTffoobcC6Y+kYzR8zLeIW330fSpUi4VWItgwKGGgo8RxmjgVW4FqCTplSsAZ8sj+d1AsFemM=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr2430494oig.172.1581416176894;
 Tue, 11 Feb 2020 02:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20200211040651.1993-1-cai@lca.pw>
In-Reply-To: <20200211040651.1993-1-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 11 Feb 2020 11:16:05 +0100
Message-ID: <CANpmjNPWCu+w3O8cg++X4=viVFsWNehTXzTuqbwV8-DcXXpFng@mail.gmail.com>
Subject: Re: [PATCH -next] locking/osq_lock: annotate a data race in osq_lock
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 at 05:07, Qian Cai <cai@lca.pw> wrote:
>
> prev->next could be accessed concurrently as noticed by KCSAN,
>
>  write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
>   osq_lock+0x25f/0x350
>   osq_wait_next at kernel/locking/osq_lock.c:79
>   (inlined by) osq_lock at kernel/locking/osq_lock.c:185
>   rwsem_optimistic_spin
>   <snip>
>
>  read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
>   osq_lock+0x196/0x350
>   osq_lock at kernel/locking/osq_lock.c:157
>   rwsem_optimistic_spin
>   <snip>
>
> Since the write only stores NULL to prev->next and the read tests if
> prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
> shattered, the code is still working correctly. Thus, mark it as an
> intentional data race using the data_race() macro.

I have said this before: we're not just guarding against load/store
tearing, although on their own, they make it deceptively easy to
reason about data races.

The case here seems to be another instance of a C-CAS, to avoid
unnecessarily dirtying a cacheline.

Here, the loop would make me suspicious, because a compiler could
optimize out re-loading the value. Due to the smp_load_acquire,
however, at the least we have 1 implied compiler barrier in this loop
which means that will likely not happen.

Before jumping to 'data_race()', I would ask again: how bad is the
READ_ONCE? Is the generated code the same? If so, just use the
READ_ONCE. Do you want to reason about all compiler optimizations? For
this code here, I certainly don't want to.

But in the end it's up to what maintainers prefer, and maybe there is
a very compelling argument that I missed that makes the fact this is a
data race always safe.

Thanks,
-- Marco

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/locking/osq_lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 1f7734949ac8..3c44ddbc11ce 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -154,7 +154,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>          */
>
>         for (;;) {
> -               if (prev->next == node &&
> +               if (data_race(prev->next == node) &&
>                     cmpxchg(&prev->next, node, NULL) == node)
>                         break;
>
> --
> 2.21.0 (Apple Git-122.2)
>
