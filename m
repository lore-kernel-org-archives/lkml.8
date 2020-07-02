Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B40AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217BC2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593713464;
	bh=jAXk80oDq4+9Y/UPmiO21NEVFMikxzhxCGTvZJxc1sc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jn46ygWLDJf34AZQOtxcZplGoopOryQrf9teSWvf125gqqA24w+SjcQwgzb/HyXTR
	 yl07lWMeAAFuaz1cddIoBOn2I7Qeq+EjoRR7P6ZT9ac5zd2BKqZZqWG2aGhUN1eNUk
	 OpT6Q0kxEQD7OU2tNtU4HUxssCYyOVBRJzrWkLFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgGBSLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGBSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:11:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:11:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so16795632lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZF2RO7D0EVWwMJZ+4s9BUuPvy5hetDDT+LtkKbx5jA=;
        b=aBC7CVuq4bDi327CCmAk00uAKzXwDXFwka2t1budpO1vnfIVa2mhtpM0hyc23Ybcsc
         4Q9QSrTL8XeuvC6s7HWsM8siP9hY3nACHvOUGoA9Ud6+Hmi67VrIhRHxBHHtC9gyA+ed
         oAFRom3cS+moVq1MRyTJGXkqatICUT293Pa3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZF2RO7D0EVWwMJZ+4s9BUuPvy5hetDDT+LtkKbx5jA=;
        b=Fk3QA5gX7AzTwGQU72yMzTzdIULT4XzuRaZ0j0boPw2r6sKXDRrM0DX8K8q+ACfHeu
         p9jByWMkJkGBCIvp3dlhA9hJi2jG0693AQpKzRoq+N3pkPBYbVFgv6E27crD2LBlmjzA
         VJ47anWfkne9rpettYyD+pnXr8svNBQXV/LeNFtOLvoBubVr2HJ4BmcEaNFQxtnxu5q8
         QQKxh3Z+OXXIFrD/qjsSahr5Wbt7tZfrFnRvXNFmCXfA4ALLskCrMeaKnCMEYqLrApwl
         jvRWSOvqFiytLqJTVDL7SYnB8Di9AhAECAT18SnYduIgPyTuJRjotSdeJ9m1UUgp59Wu
         Y84w==
X-Gm-Message-State: AOAM530AM0NZGSWdAjlPQdp0cVxzuT7IwkdYv7UCWuAQazBdI1pIAC3u
        vRVvgntW9fJn0JcCHuaKC/FcpM/9LEA=
X-Google-Smtp-Source: ABdhPJwLDwdscgjLNoZf58ETKWzDuTIHL5W5gT8jkBEkxJ06DNxX0fFTR1ZFVczCgsmLtlbKpZjmMQ==
X-Received: by 2002:ac2:5548:: with SMTP id l8mr18881642lfk.188.1593713459766;
        Thu, 02 Jul 2020 11:10:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p14sm3649924lfh.32.2020.07.02.11.10.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:10:59 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f5so17524256ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:10:58 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr2189529ljc.285.1593713458587;
 Thu, 02 Jul 2020 11:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 11:10:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
Message-ID: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
Subject: Re: [RFC 0/4] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Of this patch queue, either only the first patch or all four patches can
> be applied to fix gfs2's current issues in 5.8.  Please let me know what
> you think.

I think the IOCB_NOIO flag looks fine (apart from the nit I pointed
out), abnd we could do that.

However, is the "revert and reinstate" looks odd. Is the reinstate so
different front he original that it makes sense to do that way?

Or was it done that way only to give the choice of just doing the revert?

Because if so, I think I'd rather just see a "fix" rather than
"revert+reinstate".

But I didn't look that closely at the gfs2 code itself, maybe there's
some reason you did it that way.

              Linus
