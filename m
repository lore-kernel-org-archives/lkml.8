Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E2C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1243206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJRDb5WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgCPXr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:47:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43961 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgCPXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:47:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125so19807699oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mttFfSWICKfg0VDWFFFpM6bA1x4vo0nhvLSocXypSiE=;
        b=VJRDb5WO8N3vm52u9Y7VxkYqd/KhwpCssTVF/UwGUFlYgdoiGLRlnTUYkU9oIQoMQk
         m8j0d0lURsNmVvD3V1Z1Aoq8rlugoZwTRKdpUND6SgGvq4CnIajRHPg6bsOL1/XgkKzD
         Pk1/Zs30aVEax2sFOkLTEMZiUf4NPPZSy8ta9mhmquYZB0c9pSUphzMiiEREtt77WooC
         6Sr7l50eJdZBYCK2hIN3ti+zO0Nw5bYwmDfBDPpcWq9zfUUnJwtHc7duN2CeM48dCKCn
         oqF1nho6Yy7VEJIKNvggGf8WA9JuYp9O86nhacVnnp0Y5lIcN5VLRAVlwvZBy8mojr/l
         pqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mttFfSWICKfg0VDWFFFpM6bA1x4vo0nhvLSocXypSiE=;
        b=GODdS8u/DDjkVdIB0tM/ROcJjhyN+8tksq0yw+L2sZyorC/IZg+7eyFuPJ8GVyCZdk
         /6CkN0AB/dz44Q5fnSM5QOlMkENUhpIRrLjDJ+I/G0eNUmKrNnNF75VkuVy//2WK0mzU
         o11RBG43M0WryzSXpbtJ6iOKyWH1YrdDTmPrnmYONuCpBfirrclBcKi8c6Q33PrHvIso
         FtWqIlfcsbxhbUprQdQvpj1lrKlcC/NlXhOtnoT3Q+Q53oFdXaU2jiovPH8AfzlFiwOr
         ZvbgvX6B5EzToEtpGdTwY1Ki4shAMpZodEI09i0EkR8o1src+ld+108sik90AOP/n957
         4coQ==
X-Gm-Message-State: ANhLgQ2gSUDyMqV4b0YjZ+wLoQtsB4HPUeqahT1iTkSLiYI19c4cNoge
        Yznqpg1kMJPvo4+QIXI1pdSnzs6x/x+96FcvDnHp3A==
X-Google-Smtp-Source: ADFU+vvf58lvIOAfydJM85FoH4fCfYl73Pwkpod8CRWAMB79NSEFG3mZJIsM7IndHf4CMxqGHbsvsMyMno0Is2Ju4oc=
X-Received: by 2002:aca:4b56:: with SMTP id y83mr1554187oia.142.1584402448153;
 Mon, 16 Mar 2020 16:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com> <1584397455-28701-2-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1584397455-28701-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Mar 2020 16:47:15 -0700
Message-ID: <CALvZod4pn1XJN7EVV9w6t2cYkHWG++GB6pJdBzBJO+w4k8aEEw@mail.gmail.com>
Subject: Re: [v2 PATCH 2/2] mm: swap: use smp_mb__after_atomic() to order LRU
 bit set
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 3:24 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Memory barrier is needed after setting LRU bit, but smp_mb() is too
> strong.  Some architectures, i.e. x86, imply memory barrier with atomic
> operations, so replacing it with smp_mb__after_atomic() sounds better,
> which is nop on strong ordered machines, and full memory barriers on
> others.  With this change the vm-calability cases would perform better
> on x86, I saw total 6% improvement with this patch and previous inline
> fix.
>
> The test data (lru-file-readtwice throughput) against v5.6-rc4:
>         mainline        w/ inline fix   w/ both (adding this)
>         150MB           154MB           159MB
>
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Shakeel Butt <shakeelb@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
