Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D0C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938E421835
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5vk5y4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGNQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgGNQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:50:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5324C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:50:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so23760374ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dG7FA7iDSIWnXeiGt3K6ODixwTg6YeYMJpgbEySOgvU=;
        b=R5vk5y4+TZQXz2QtyjTQ5Zn8WHBr1gqVTWqRwg+UYo0TaI0LkhKP30WVBRyqDQJ1xD
         k3OlvwAEp6EL86KzHrE+CtDXddwMtGtzzsYvqDpHrAxh/3rVwXsrZikUvryvleK3pBC5
         KI9h8s006nwI9a2IBwYbbkxi8Uh4BVHh556TJ5YDceshyU8ht5Oejn40eSR8ptAQ/vhk
         0NFF19rMP/pmtQFBtTB7HaQLuQzcVUKsQ++Y7OSSFN0O3/Z3ta6avdJjD0EmB+lbSKMI
         TjA+49nqRBQSjSb6OG1fhA8hmgfIdz+Cd16VVDPQbTPw92hPeZKYYRmIQ+UJr7bonGSu
         SthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dG7FA7iDSIWnXeiGt3K6ODixwTg6YeYMJpgbEySOgvU=;
        b=i3X4CvKFdJTwchOeR+k7EaupIrqSz0WR/c0DsjlFONMHlkjMDveprfZDXREamy8O5t
         DGAN90edZGDq2U5SC9wZ5b5mbKdlYzTqYJVIQT4jsLCJxjtj7tzjjWFuuLHCvaBVg82K
         NMkXMBGnMrD9n1+caIPpwhMOg/RVRtvb4TQHHT4RV81pqhGbW0JnumcCJonjfL4VJKoZ
         C4D9kWwVwf8fveYt/dDgvjPwWXcuyrW3hcVXLRk3clagSPCHfiHHkvglvSuXPLhoScJe
         wbezMkZGP2BM6yp9ZG9LG4D6lh0oJphKtVp1xoxHKriZpDIKWqrPn8j/CTC0AlDG2v56
         5r/Q==
X-Gm-Message-State: AOAM533VWfrvTcP7HlyxPQ62G/ePZGURLYSBN7E6Um314W2ysTqLr1ua
        +2WZNkstkHbqH2Nq7x3s9mwgqreebLDTQM9Ryc9R1w==
X-Google-Smtp-Source: ABdhPJx81doPrro1bqy5wsunMqncB7CNTiXI9D7TmBuGV1FhagfTlWt0NoFPA1DCBaWcOBbJzvhBR0vjJ2mBf5LMAY0=
X-Received: by 2002:a2e:9251:: with SMTP id v17mr2564999ljg.138.1594745408013;
 Tue, 14 Jul 2020 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com> <20200714161415.3886463-3-christian.brauner@ubuntu.com>
In-Reply-To: <20200714161415.3886463-3-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Jul 2020 18:49:41 +0200
Message-ID: <CAG48ez3fTQMEU71C91pGOUbSnFkMsCXOM26kLHB7-0vG423tDw@mail.gmail.com>
Subject: Re: [PATCH 1/4] namespace: take lock_mount_hash() directly when
 changing flags
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 6:16 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Changing mount options always ends up taking lock_mount_hash() but when
> MNT_READONLY is requested and neither the mount nor the superblock are
> not already MNT_READONLY we end up taking the lock, dropping it, and
> retaking it to change the other mount attributes. Instead of this,
> acquire the lock once when changing mount properties. This simplifies
> the locking in these codepath, makes them easier to reason about and
> avoids having to reacquire the lock right after dropping it.
[...]
> diff --git a/fs/namespace.c b/fs/namespace.c
[...]
> @@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
>  {
>         int ret = 0;
>
> -       lock_mount_hash();
>         mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
>         /*
>          * After storing MNT_WRITE_HOLD, we'll read the counters. This store
> @@ -497,15 +496,12 @@ static int mnt_make_readonly(struct mount *mnt)
>          */
>         smp_wmb();
>         mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> -       unlock_mount_hash();
>         return ret;
>  }

It might be a good idea, instead of completely removing the locking
calls here, to replace them with lockdep_assert_held(...).
(Currently that doesn't appear much in core VFS code though.)
