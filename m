Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503AAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A0B221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvNI74fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHGR2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:28:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F0C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:28:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z18so2176693otk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcPljqLlsSaByEgdnjwhb5jRujI3GPfRCMC3xF366sQ=;
        b=lvNI74fMbQTw+8M58BgwRChxDSXnuBaigD7ycw6XMt5W1E6aOHaOc1QKCKumH60SwS
         cSpZz92jRmTtH8YU80yP119KbtH9tkQPB4gsNsdTYot8Q5jFfuM5B4BZ3Qk1IA+KLQOv
         kf5UMHXHl8BxAggENKovoflSBpi8OYVS7LW2YXeLEBTzrUdEvM6BYJRWHLmyNz9r50c0
         yOIXS2Sdl6To0nDBGs5rdC83Ui3dQtr12tLqKXFn/Qfg1zK+mc++zTtg2gJnEo76nKT3
         /TLWkZVePhsgkD5gJjrLYh9ehJd2tbhP3EWS+2dWSXVd89xlEROPK64FDJau2tiA1HjP
         Srdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcPljqLlsSaByEgdnjwhb5jRujI3GPfRCMC3xF366sQ=;
        b=aNOVCkjhxBAReVN3G5KJ3bySxCyYQQKhW8DFfAjjLm2sbgDn/TWdAcYZe5bRax6ICO
         p90HNd43JVpndGKaDN5v4MdCvPQ0X2ix+APN3KwYIBEQ4F5qJVUwJWlf0JVkK7+dzjH4
         NjSKN3oJ45guo4sRFiDj9PUU57rmDXxXRoBhYM9U6xW5Xh6AtlpktZtYIkWrun4hvvTJ
         h5sukmnSAZ4Votp66LxF60cc2IQOwJtP3uXgkb0vkHlUiNE6hE8QRk2+HT9t0G9r47sS
         VQV2zvs+QPKBn6IIJ8IT7G65jfsa1rrz/Yxm9esVD2HAMcVaj2rHzN58DMj11eQPaNWA
         4wgw==
X-Gm-Message-State: AOAM5338PT/pgkrzNS3Lsi22b2XA3wmlTrwSzuFe2y4mH3EE02qJ7Mr6
        yygI6jQPeoQky2t4ujn2W7wdbFN2y8FIvb11/VfWt3IeK/E=
X-Google-Smtp-Source: ABdhPJyhRNkJ7IwFovJWB4fr/hjEdbgkIhGpcwsemu7+FnTI1YphMimo6fZOrfenJDcYeti2RNOLqc2dB+aC9WrUFY8=
X-Received: by 2002:a9d:3d77:: with SMTP id a110mr12761833otc.11.1596821326081;
 Fri, 07 Aug 2020 10:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz> <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
 <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com>
In-Reply-To: <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 7 Aug 2020 20:28:27 +0300
Message-ID: <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial objects
To:     Christopher Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

On Fri, 7 Aug 2020, Pekka Enberg wrote:
> > I think we can just default to the counters. After all, if I
> > understood correctly, we're talking about up to 100 ms time period
> > with IRQs disabled when count_partial() is called. As this is
> > triggerable from user space, that's a performance bug whatever way you
> > look at it.

On Fri, Aug 7, 2020 at 4:02 PM Christopher Lameter <cl@linux.com> wrote:
> Well yes under extreme conditions and this is only happening for sysfs
> counter retrieval.

You will likely get some stall even in less extreme conditions, and in
any case, the kernel should not allow user space to trigger such a
stall.

On Fri, Aug 7, 2020 at 4:02 PM Christopher Lameter <cl@linux.com> wrote:
> There could be other solutions to this. This solution here is penalizing
> evertu hotpath slab allocation for the sake of relatively infrequently
> used counter monitoring. There the possibility of not traversing the list
> ande simply estimating the value based on the number of slab pages
> allocated on that node.

Why do you consider this to be a fast path? This is all partial list
accounting when we allocate/deallocate a slab, no? Just like
___slab_alloc() says, I assumed this to be the slow path... What am I
missing?

No objections to alternative fixes, of course, but wrapping the
counters under CONFIG_DEBUG seems like just hiding the actual issue...

- Pekka
