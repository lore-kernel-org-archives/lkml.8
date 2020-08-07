Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A1C433E4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AA622CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nra8smWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHGH0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGH0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:26:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E81C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:26:16 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z18so892891otk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuGyNraoSZkaqmXZxN0xTeDtESMeo0rZS6+yyQYUjVo=;
        b=Nra8smWXTUQe/7+jUQzQohhCEggGdi0HBuH1b9sGFdAUZSgjyxyReplgS1nhH2hLoq
         eww1XSHt5FvDEXwOgaVL2oJpRnxw7zdPk0PoU0uGUmb0wvqxRv0BrtLU++hdLmUDsI6L
         88cp1deBgBhhoXReVyKv3G2Hh8bwXtQxTWW77sBxeKAKoY2OlNUSr6B0TFnK8kWClFXH
         t8Jt6hIBkXcxeNaiH5vQ1kyij2fxJq88iJ3mWCsOukv+jpDKeLVKi+0V+RvsgtHnF5yg
         ZaBmZcUMxpreYKMHUcy9ck7YN3Y6EVzSg6L6mMyq0rCKkqNjAOmHmkVEgO8NMhon7uSy
         zI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuGyNraoSZkaqmXZxN0xTeDtESMeo0rZS6+yyQYUjVo=;
        b=DFRBaYBoOBdn6OCNcp1LBp9YVVOFTa4KRHhGvjnYaWA5B/smKgTFmhc+6bL2CHq1eD
         XL5ZsdwQtSVAvOIluDE45b6be3QF/4LQet1G3X2ceslJ91qq+AGlhEeiw7mFvEDOiXqf
         U0DfJ+1BSvu3XOpeU9zq3cK3cpLc1TSfCK8cRGXcsM22+52FjglEkh/BvFtZgSU9wjka
         tLLd6kwFRVu6LSyrJXXgEnd4OVDLDNq6Zwe2ItgfquQ+Ya7rOyt8xdywEmurlvOFaOKQ
         HF4wbprPozSRfQ7J8U6qq+g0DDw65WQ7emNowkSWJHxkh8rr1JqFpD42T5XM8VwLEHG+
         CoOA==
X-Gm-Message-State: AOAM530MsNyDn2fpAg4MeUyLFj/YSsZGd/7/oXtOmDbk8H2WEz9SYDeZ
        SZReGUWfGpxpcc5IhNVHXXxeNR3afNY2qlfbXso=
X-Google-Smtp-Source: ABdhPJzhdIxqaNWhGYDF1e15qchlE/mSQs7N7tgkFrMgWZmqc6H1qqtEwsOUVSlwTi3dj13zbrQ5Feei/cY6zmJ1XWY=
X-Received: by 2002:a05:6830:20d6:: with SMTP id z22mr10774644otq.94.1596785175652;
 Fri, 07 Aug 2020 00:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com> <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz>
In-Reply-To: <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 7 Aug 2020 10:25:59 +0300
Message-ID: <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial objects
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
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

On Thu, Aug 6, 2020 at 3:42 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 7/2/20 10:32 AM, Xunlei Pang wrote:
> > The node list_lock in count_partial() spend long time iterating
> > in case of large amount of partial page lists, which can cause
> > thunder herd effect to the list_lock contention, e.g. it cause
> > business response-time jitters when accessing "/proc/slabinfo"
> > in our production environments.
> >
> > This patch introduces two counters to maintain the actual number
> > of partial objects dynamically instead of iterating the partial
> > page lists with list_lock held.
> >
> > New counters of kmem_cache_node are: pfree_objects, ptotal_objects.
> > The main operations are under list_lock in slow path, its performance
> > impact is minimal.
> >
> > Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
> > Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>
> This or similar things seem to be reported every few months now, last time was
> here [1] AFAIK. The solution was to just stop counting at some point.
>
> Shall we perhaps add these counters under CONFIG_SLUB_DEBUG then and be done
> with it? If anyone needs the extreme performance and builds without
> CONFIG_SLUB_DEBUG, I'd assume they also don't have userspace programs reading
> /proc/slabinfo periodically anyway?

I think we can just default to the counters. After all, if I
understood correctly, we're talking about up to 100 ms time period
with IRQs disabled when count_partial() is called. As this is
triggerable from user space, that's a performance bug whatever way you
look at it.

Whoever needs to eliminate these counters from fast-path, can wrap
them in a CONFIG_MAKE_SLABINFO_EXTREMELY_SLOW option.

So for this patch, with updated information about the severity of the
problem, and the hackbench numbers:

Acked-by: Pekka Enberg <penberg@kernel.org>

Christoph, others, any objections?

- Pekka
