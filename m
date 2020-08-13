Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D18DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B6620838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wT9av0mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMXhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMXhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:37:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A34C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:37:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so8058676ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=608qNLHC5/4osjXyTeWl015DQW4m7Dc2t3DShU7YJe0=;
        b=wT9av0mbZ1q5xaMLNh0532iGn6upLZ8tbnSY+oa8bj1AUaRnxl4mj2HgbqZ9zzCL/q
         WXU14AgUuY89PCDZzKvDXTsX9uMR1mr9Fl2fKh1kOu+rBKwk2UKaxZOdTfeP32iYuQyG
         vpqjlVk+8245L7AmSDXKv3dpb7pTpGa/qY5GNElF+ggw60/QodN15ToWL19U1GsUk2N9
         QODItuWKoDQXNuQ+nvxhzcQJxnazMa2b1+1TlQ1Xk60piGbGRcXskOkeqA2Ysep3tmxq
         xF5HuCDuslwRdKXMQA1NcKB2KYzJSsMGBKQBjmvugFSduD7M6Zl2ZlFrzIVouseF8sum
         J4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=608qNLHC5/4osjXyTeWl015DQW4m7Dc2t3DShU7YJe0=;
        b=K2/I/OmnlMnQ3ze4rr8R3H/Sa4BNMZJ4rS1qKHAAx4Mcb5ULgi2vuyJvlUfUm/ttG7
         cSQ+BneQAL46HcQSE0+ncDGIlxFhfhOAa94TDSmqr0iMVLKrHa8nzLP6hJFHMMgFm2s3
         /hOlECa+sbliMBmlMA9Bp/ME5VVP7O/3Vl7tSCYuiLFLWBue2FXjPkzXNVvyUoeOHjli
         86Olss+fZggxUiCLE6HDAICuTUMhSjJCtQrCCJ/URyW+c/NZL2zSEAqI72BKUmi2n3iM
         /t8N3RDfRef1YZxPi26IxjJRmovSGz1qcDVyhcoRgZK/ZKyxbeTfGvmGar1eTeF6erqs
         YvlQ==
X-Gm-Message-State: AOAM53061X4N9AJ2zGNv1EZMvtM00RM5j3HqkcKe3GaJ/4CgqhQasb3C
        8lw2Py/b1ceumv9g4rw0k3k7K4W9eVmc9QPQqt6QYw==
X-Google-Smtp-Source: ABdhPJz/N/QhGvrjNkKDJBnq7G6b2eeC8exYaKf58GjxIDjquW/9Kwm9ycvqMLAOa+c6qDW9G/snY9ypTomL5/irUMQ=
X-Received: by 2002:a17:906:413:: with SMTP id d19mr7407867eja.523.1597361859855;
 Thu, 13 Aug 2020 16:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils> <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
In-Reply-To: <CAHk-=whYLHtbeF6BFmoiik9PTjP2+pnpWxXLE9f0ccnT0LAd5A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Aug 2020 16:37:28 -0700
Message-ID: <CAPcyv4jfcXJtCQRXLNxhEoQseMyUxgZxhgz5EaEE9sVjFaqHLg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: fix debug_dma_assert_idle(), use rcu_read_lock()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 12, 2020 at 8:17 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
> > improved unlock_page(), it has become more noticeable how cow_user_page()
> > in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
> > contention on DMA debug's radix_lock in debug_dma_assert_idle().
>
> Ooh.
>
> Yeah, that's ridiculously expensive, and serializes things for no good reason.
>
> Your patch looks obviously correct to me (Christoph?), but it also
> makes me go "why are we doing this in the first place"?
>
> Because it looks to me like
>  (a) the debug check is wrong
>  (b) this is left-over from early debugging
>
> In particular, I don't see why we couldn't do a COW on a page that is
> under writeback at the same time. We're not changing the page that is
> doing DMA.
>
> In fact, the whole "COW with DMA" makes me feel like the real bug may
> have been due that whole "ambiguous COW" thing, which was fixed in
> 17839856fd58 ("gup: document and work around "COW can break either
> way" issue")
>
> That debug thing goes back almost 7 years, and I don't think it has
> caught anything in those seven years, but I could be wrong.
>
> The commit that adds it does talk about a bug, but that code was
> removed entirely eventually. And google shows no hits for
> debug_dma_assert_idle() since - until your email.
>
> So my gut feel is that we should remove the check entirely, although
> your patch does seem like a big improvement.
>
> Christoph?
>
> (And Dan too, of course, in case he happens to be relaxing in front of
> the computer away from a newborn baby ;)
>

I can at least confirm that it has not caught anything in a long while
except a false positive that needed a fix up.

https://lore.kernel.org/lkml/CAPcyv4hy_nNe8G0o8sMrz9A8HcdRzAuKgXmvdjKusAAA3Fow4g@mail.gmail.com/

Part of me says it's not doing anything worthwhile upstream, but I
wonder if it is keeping some people from submitting patches that play
these page reference shenanigans? I know they're out there. The land
of gup and truncate is where questionable kernel changes go to die.

Outside of that, Hugh's patch looks like a definite improvement so I'd
be inclined to run with that, but rip the whole facility out at the
next sign of a false positive.
