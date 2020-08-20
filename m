Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A434EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2F207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3LLQUZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHTARD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHTARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:17:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:17:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so512421eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD6I2sfjrM7WmVDgF13oHi2u8mSy5yR9cY0JUVIH+rg=;
        b=i3LLQUZx4nyJ5d3l3nMcnG3nuuf4pMY9IuD04004diC+RW1FBhhynk1uN1fkT+YHlj
         O6P89P2/0ljvDOBC4J31KdqlQsnHRXQnE3uid+q4MwfgQcj/wP/GqimWxkiJTwp1Yqzf
         DZ0pReM1kOawPpkXd0EvzBYaXrm29/9NESxqmy8LfWWl0pHJlQaskSNKhEIyBEkQTb9s
         QCaYqGwnG0A1sASXMGdjgMBMvK2BtabJJA0fd1TcWDz1jC/3BiNg49IBam5xM70JJyBu
         fEGNrRQ13xxWO/DhqsbW+mXazfEuJs+GEP+UC3kUyhQdRV8mzqHCYuHGFPNSmdrIGvFz
         ++Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD6I2sfjrM7WmVDgF13oHi2u8mSy5yR9cY0JUVIH+rg=;
        b=CQaTlPvV7vMJewvYVPxRDISrB4pHn/ZIedQnazl3ZRgUxw3OjPHrSx5rUgKDdrtqcQ
         1nyfKXE86pTRsMS8gt8hF+NnL5uBTxlr2YtJj6PAYp322JNJ1P+i2myL6Cqbu0LIVxPF
         6gM3MZDne3B3NJDohN5JF62kRycBrqFlUDW15xjLStQyzaJIQ1Lhx7tG1FXzXnbYUmxC
         0q6URRcyYEwvpzi1KEfNBAsRAVCDrdg7bMqnDkzgAM5LFrdTY/34+ROsv97eOrrhttlQ
         qBJo8S91laQ9yesTqJy+vNEnd+Dcck+HnkkMXtIpFctfySbAAcejDCONL4hCFEuogSi8
         9bmQ==
X-Gm-Message-State: AOAM530kHPF2u8CM8xj33bI3Xy1PXXyCLIzY0+m8okm+/M1zbKeDR+Vz
        uqAnON8HC+fpd1Uu3wLuF1k9bjhIsTrgD13c/4g=
X-Google-Smtp-Source: ABdhPJyjCrNJBANQhRcSAYN+Gm3Pz8l0tivSgen+dDxeCEI/OYPauzv88z3LE98Jev+9tp0teLzTi4suRmxRX+BZJU8=
X-Received: by 2002:a17:906:3993:: with SMTP id h19mr820232eje.111.1597882620894;
 Wed, 19 Aug 2020 17:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com> <20200818184704.3625199-3-yuzhao@google.com>
 <CAHbLzkr7oPFtUog1zJWs54dsS8dhwkWp6ET_Zk71nXmRMtGvDQ@mail.gmail.com> <20200819233916.GA2021304@google.com>
In-Reply-To: <20200819233916.GA2021304@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:49 -0700
Message-ID: <CAHbLzkp4eOf=jywp+wuqqJoJwqMt7338cfxUsfz1KSt=zEZUiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 4:39 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Aug 19, 2020 at 04:06:32PM -0700, Yang Shi wrote:
> > On Tue, Aug 18, 2020 at 11:47 AM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > Presumably __ClearPageWaiters() was added to follow the previously
> > > removed __ClearPageActive() pattern.
> > >
> > > Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
> > > cleared because otherwise we think there may be some kind of leak.
> > > PG_waiters is not one of those flags and leaving the clearing to
> > > PAGE_FLAGS_CHECK_AT_PREP is more appropriate.
> >
> > Actually TBH I'm not very keen to this change, it seems the clearing
> > is just moved around and the allocation side pays for that instead of
> > free side.
>
> I'll assume you are referring to the overhead from clearing
> PG_waiters. First of all, there is no overhead -- we should have a
> serious talk with the hardware team who makes word-size bitwise AND
> more than one instruction. And the clearing is done in
> free_pages_prepare(), which has nothing to do with allocations.

Oh, yes, you are right. Now I'm wondering why we have the waiter bit
cleared at the first place.
