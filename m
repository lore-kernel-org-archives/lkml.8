Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B25C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D3C207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkGLCi0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgHTQ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbgHTQ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:27:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463ADC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:27:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so3201421eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eM1zOn+FR2yFJ0AIl1j1XjtlYy3Z0GppqAmGTNPlYdw=;
        b=gkGLCi0TAZy8OtR7kqtCVPj9RrcD2K6WpI6S3OnyUKOo53ddYAKRUuT1ExoiMt6FW/
         V93Tvta7cuDpo/0Q5i3Tj8AprcriwlmeUdtk0fEu1dYQgD/em/zC+zvWv2NbPjg37sY+
         rbkPfhHThJOy8UEiUar8Sfm6nzBjwoilAk4uaEa8nKuYKxrB5YtLsnQvulVim1Qk5Upu
         L8bxSxqtIcNyGJLFbv3fd6JmcgMUFiaTDImhYaYjCKmK6BlwxNerQmyLQ3/mw8Ry2D15
         mF0nSZ66EbDkAsbauTX4Aw5m4OGSZAlxKThn3DBNVzcBzLEFXBOBTipVNcm+Lmb2CVCz
         WXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eM1zOn+FR2yFJ0AIl1j1XjtlYy3Z0GppqAmGTNPlYdw=;
        b=iFP9CKA58td/5sKYq1wAw/TRoxdOHrNRaxjPduKe9YU5hvM+YUmjwOcVP2R2S3HPvq
         1qC2GyELI0FycoJT31G1RlIRIjeh3VnEQOq5drD2TdsnFkairOrCIYyri8GTHl0oe0Rh
         uLx6TRDqaXpeAvwHONBIDLIo7nUQrtyPvALEU8XHAU7wFR2dpM7yQuhyq9eQFhuIV+NH
         r7mTlVeStPknXVA6YgSJMb9fI1miTZqu5Tb7MoNnagLNs0XMngugxNmHM1rwXbidfKBs
         pb5FyYa5YWURGrojRviGAX9vt3zXhQ6+RNmqDIgsMkRzz5Gqnhek0AYCaHD95pAc0O2R
         TBGQ==
X-Gm-Message-State: AOAM53184M1by5mXIaeM0tzOEKVRd7KNM7/vz79yZR5qI/4pkIySbZgR
        tScjVnlE1q1w3TcQjEm9dc+aWYfr/ey+ISw/OvQhX+BQ3GINBg==
X-Google-Smtp-Source: ABdhPJzIt71V2sZLGyr1YL/5rldNRwaxAE5Ib2Ga+VF9Px2vVt8VjP861EQXb+xUXh1yEWcxOzliynbXtKA2VdL404o=
X-Received: by 2002:a17:906:3b8d:: with SMTP id u13mr3924409ejf.383.1597940829251;
 Thu, 20 Aug 2020 09:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184131.C972AFCC@viggo.jf.intel.com>
 <87lfi9wxk9.fsf@yhuang-dev.intel.com> <6a378a57-a453-0318-924b-05dfa0a10c1f@intel.com>
In-Reply-To: <6a378a57-a453-0318-924b-05dfa0a10c1f@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 09:26:57 -0700
Message-ID: <CAHbLzkrjxm38VV+ibQxoQkC4nW7F13aJcL5RypUchX30rqUstA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 8:22 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/20/20 1:06 AM, Huang, Ying wrote:
> >> +    /* Migrate pages selected for demotion */
> >> +    nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
> >> +
> >>      pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
> >>
> >>      mem_cgroup_uncharge_list(&free_pages);
> >> _
> > Generally, it's good to batch the page migration.  But one side effect
> > is that, if the pages are failed to be migrated, they will be placed
> > back to the LRU list instead of falling back to be reclaimed really.
> > This may cause some issue in some situation.  For example, if there's no
> > enough space in the PMEM (slow) node, so the page migration fails, OOM
> > may be triggered, because the direct reclaiming on the DRAM (fast) node
> > may make no progress, while it can reclaim some pages really before.
>
> Yes, agreed.

Kind of. But I think that should be transient and very rare. The
kswapd on pmem nodes will be waken up to drop pages when we try to
allocate migration target pages. It should be very rare that there is
not reclaimable page on pmem nodes.

>
> There are a couple of ways we could fix this.  Instead of splicing
> 'demote_pages' back into 'ret_pages', we could try to get them back on
> 'page_list' and goto the beginning on shrink_page_list().  This will
> probably yield the best behavior, but might be a bit ugly.
>
> We could also add a field to 'struct scan_control' and just stop trying
> to migrate after it has failed one or more times.  The trick will be
> picking a threshold that doesn't mess with either the normal reclaim
> rate or the migration rate.

In my patchset I implemented a fallback mechanism via adding a new
PGDAT_CONTENDED node flag. Please check this out:
https://patchwork.kernel.org/patch/10993839/.

Basically the PGDAT_CONTENDED flag will be set once migrate_pages()
return -ENOMEM which indicates the target pmem node is under memory
pressure, then it would fallback to regular reclaim path. The flag
would be cleared by clear_pgdat_congested() once the pmem node memory
pressure is gone.

We already use node flags to indicate the state of node in reclaim
code, i.e. PGDAT_WRITEBACK, PGDAT_DIRTY, etc. So, adding a new flag
sounds more straightforward to me IMHO.

>
> This is on my list to fix up next.
>
