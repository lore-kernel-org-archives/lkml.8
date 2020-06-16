Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EF4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36613207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ32XjEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFPGQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGQp (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:16:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6EC05BD43
        for <Linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:16:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so1680514wmh.2
        for <Linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Okwoj2Qv3D7eg5PFs36q/CBi2qV+ok+9YhufbIFsWk=;
        b=UJ32XjELnBKAkAvWqVBzj+YXaoN1Gm9hpA7P0+JaKm+lpdvScgWtkC369Gu/T5oJpU
         76iV2b0EiJ4uXnNMjJ3PfsjLTUMcNCY3JkH2ueRoCjo8RSvATof/FYpT0u3QJ/0qInET
         88ubnsZUKaLhfUqnTiIem85v+Dk8o4DUnYAeaZqk53B0FGMWCShEzYLdyQBvkyjLu6Ot
         1fQ+PrQjE+gy+AlfbdVshf0TR3RW0Y08WkDLKLAz6IJI5PmZezTS1kGQz1lLJf+88K5p
         1VNM6F3Un+275BsBLjXz/Z9Z2PsvanSByGURNrJO2CMtnIVv+OUx/k0Z+r2SUCWMAGfv
         5iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Okwoj2Qv3D7eg5PFs36q/CBi2qV+ok+9YhufbIFsWk=;
        b=oleuLrLuB9bFEIVYFXIRjbTPMEN3Ur/ou/Xdhft3ShnS6ea/RHX7FJppph6+nNE13r
         RSCA0vQs1I1avHOGlQuObCV9FHutTDbEBnu1VPzWR3mvYjBmU5cKQVMpxhEIHz0Ov9xp
         XX3oliaFEujfBHmhab4eUWLsLWJjNKttpktoZd4GiC1968WiQTuKDwoQK60uP1jfEFVE
         3yHcKaoCFUR3H93rJFlK0IAAiAjw3XgRtsfnMk+3xOiCJ4Txj6buPFH0JpqtuKbMau/9
         UyEjvlWYHdS9se72xVC9ZxnGzxm0pm+fxiEtU0A30B6+/8e81a6zHI3AG6/6klOjSOaW
         y69A==
X-Gm-Message-State: AOAM530SrUX8ESvxKISS41WERGwG8xaHD2yoeXDr6pXFQ5hOXqd1sdKD
        Vuwf/tjPo9S9IkxM0gVdMUoRSQcqX8kk34+dkWahcA==
X-Google-Smtp-Source: ABdhPJyDSBwZRv/sOdvQ69VrdPnkFyHo9BlzSnrDvcrzwVx5VeWRMp9Pqb8jQJjlhRUVaOELPGRiLI2WpOF0RgM2gdk=
X-Received: by 2002:a7b:c201:: with SMTP id x1mr1484406wmi.58.1592288203274;
 Mon, 15 Jun 2020 23:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200603021818.27028-1-yao.jin@linux.intel.com> <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
In-Reply-To: <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 Jun 2020 23:16:31 -0700
Message-ID: <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Andi,
>
> Can I get an ACK for this patchset?
>
> Thanks
> Jin Yao
>
> On 6/3/2020 10:18 AM, Jin Yao wrote:
> > This patchset updates CascadelakeX events to v1.08 and
> > updates SkylakeX events to v1.21.
> >
> > The events have been tested on CascadelakeX and SkylakeX
> > servers with latest perf/core branch.

Hi Jin Yao,

could you rebase this on Arnaldo's tmp.perf/core tree?
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
I tried using git am but get:
Applying: perf vendor events: Update CascadelakeX events to v1.08
error: patch fragment without header at line 279: @@ -213,14 +220,14 @@
error: could not build fake ancestor
Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08

Thanks,
Ian

> > Jin Yao (2):
> >    perf vendor events: Update CascadelakeX events to v1.08
> >    perf vendor events: Update SkylakeX events to v1.21
> >
> >   .../arch/x86/cascadelakex/cache.json          |   28 +-
> >   .../arch/x86/cascadelakex/clx-metrics.json    |  153 +-
> >   .../arch/x86/cascadelakex/frontend.json       |   34 +
> >   .../arch/x86/cascadelakex/memory.json         |  704 ++---
> >   .../arch/x86/cascadelakex/other.json          | 1100 ++++----
> >   .../arch/x86/cascadelakex/pipeline.json       |   10 -
> >   .../arch/x86/cascadelakex/uncore-other.json   |   21 +
> >   .../pmu-events/arch/x86/skylakex/cache.json   | 2348 +++++++++--------
> >   .../arch/x86/skylakex/floating-point.json     |   96 +-
> >   .../arch/x86/skylakex/frontend.json           |  656 ++---
> >   .../pmu-events/arch/x86/skylakex/memory.json  | 1977 +++++++-------
> >   .../pmu-events/arch/x86/skylakex/other.json   |  172 +-
> >   .../arch/x86/skylakex/pipeline.json           | 1206 +++++----
> >   .../arch/x86/skylakex/skx-metrics.json        |  141 +-
> >   .../arch/x86/skylakex/uncore-memory.json      |   26 +-
> >   .../arch/x86/skylakex/uncore-other.json       |  730 ++++-
> >   .../arch/x86/skylakex/virtual-memory.json     |  358 +--
> >   17 files changed, 5198 insertions(+), 4562 deletions(-)
> >
