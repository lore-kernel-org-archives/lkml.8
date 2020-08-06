Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6195D221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738793;
	bh=iMAoRSaPg2/2OW1EnF3rmdcuA0+TdqdW5SyOOQmPC4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m0ZoCPwBmvpH4+W/nfHZgIuFKlPiC9+iYEpr7rzLQ3MyrLicS68bpuIKslioSJeSp
	 4BOYyGohfVkQAOabVgOaHwgOSgcbJYDlvufAK4oG0SjjuOLYJ/bH62BjgruG78D8G+
	 NCdWiUI4Q28VSOnsnGLLSW1+uqqk6peOaCuwPRmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHFSdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgHFScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:32:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6B6C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:32:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so42646789ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Af00Sko3u8Ezl+gPJCbV7BmjNT3BmtEBTcrFloNwnA=;
        b=DFus0hPOttxaAQsjZku/lbVZ4VYNVh5ObQRgCsovPMIpe9B7M1GF6NUUDJo1jk/pkb
         I6Ji2PfXuoBnNs+NvpieyLlb1LZOse1mfbKXBwiVzCeSr6cpb9kz8NcJyk68AaXmSWxz
         erFbvQZqcdnoPk8TTEHA+WcvMXssy1YK2pPYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Af00Sko3u8Ezl+gPJCbV7BmjNT3BmtEBTcrFloNwnA=;
        b=V9nDnovvq3pPD0S/1dETo67ZZ+AuDr9RBYGOnB/3omKG4/Ia1dBiypbL0lXDDvIdyg
         6ENTS9eUL0akaB8jcWLtAnNi4vxL+N7FLDYBn9ldTCQ0cFQzA036q9IEEwMv/3Ce2gHx
         4F4zG26Ka08l8DzwzSbX8RwLcS9s2REpdpdRmKi14lWeQoJaN9MQ8mwSxhzdTzTVIu83
         i1GzcQvgLB+lhc5TmO5+xKCT2NSVpF7bXqtL+n9iX1MnvOZXG7RMgFjnWKlxr9agjFRa
         MRVpLx836Z5uR93KuZ8xfaKgsmPQ/aXdCKy8kCrzknCnlEQXa986HnKrQRNuj7eyYpp8
         LjjA==
X-Gm-Message-State: AOAM530uA4n9tn2fyF2o9dQorBOTRT/NJyZnaH61HQeMI/jnSeQi2rD7
        ZLz2+npl7rPbldHg8wufb+4iCPY3/kE=
X-Google-Smtp-Source: ABdhPJx6JFEVPmgX9Qhq3UHZ6yUB9Ss7WyTVFzSa07Yop5c5x9UIQcQF15POjgDY7r98mrpATPHWFw==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr4448850ljg.159.1596738758810;
        Thu, 06 Aug 2020 11:32:38 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 203sm3067881lfk.49.2020.08.06.11.32.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 11:32:37 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w14so23059812ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:32:36 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3902152ljk.421.1596738756512;
 Thu, 06 Aug 2020 11:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
 <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com> <20200806180024.GB17456@casper.infradead.org>
In-Reply-To: <20200806180024.GB17456@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 11:32:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
Message-ID: <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 11:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> It wasn't clear to me whether Hugh thought it was an improvement or
> not that trylock was now less likely to jump the queue.  There're
> the usual "fair is the opposite of throughput" kind of arguments.

Yeah, it could go either way. But on the whole, if the lock bit is
getting any contention, I think we'd rather have it be fair for
latency reasons.

That said, I'm not convinced about my patch, and I actually threw it
away without even testing it (sometimes I keep patches around in my
private tree for testing, and they can live there for months or even
years when I wonder if they are worth it, but this time I didn't
bother to go to the trouble).

If somebody is interested in pursuing this, I think that patch might
be a good starting point (and it _might_ even work), but it seemed to
be too subtle to really worry about unless somebody finds an actual
acute reason for it.

I think the existing patch narrowing the window is good, and it
clearly didn't hurt throughput (although that was almost certainly for
other reasons).

                Linus
