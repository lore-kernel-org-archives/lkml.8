Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE89C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540B2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ON06sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA1Aq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:46:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34337 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Aq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:46:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so10388869otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAMZ8Aw/a/sq7vYMNuydKAQ+vHD5b05Zm+cMKCnvvbE=;
        b=X4ON06sk4JCxWSzl6IyivPOV6QC6kyFa7EI/UrPdBL9l5GEVsV7qtSSKimkqt3CbtK
         WspgLPX8kJTVWlG6PCRAq632TiDYSewzIDQbh79DQU0hRMDb6ExTuIKNR45b9PI16NnX
         /g04KWqGgguKcPK8yEJ8h/t9kwND19nNLnUTrwza4YTdzPmf7/dTsT3B67JqSVR7xAPk
         83D4pomEorKigx8pWW/nUo97P9A2t83O+WrAzxRYRqhDgyyE3qjPhM/7p52bYIDiHu+9
         cQq4YA6ByW/C333B6qdpiE1ozu0nfBINO0G8I3a0/vZo8Gnig3BwvmXJv/JgT4LpxpSN
         h8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAMZ8Aw/a/sq7vYMNuydKAQ+vHD5b05Zm+cMKCnvvbE=;
        b=cPbgyCb7F/MUtRL8ViWS3kp/vdBe1BmGApT+v7rEbLTfDuYap9ZZWanRDHBwOwe9Cv
         EZZTTAvs3YLVtVGKfJ8P5sBxvbajaho7m77B4XMSi9qWOjTIkjgH3Bng7qvumn2X3xmD
         1xHcFE/98DJu9VVNiSZohn8XbqlJ36z2zz9hce+wK+uQC/GnVa9WmJmrgLgXbhAU8r9i
         ye7yOjvCNrr2TB5xBwcS/LQQQzM9R8wwoiVSoIjOaR+ZyM1ZZTYDybjaOjkAJGvQHhI8
         xJRo47oxKSHfDLz33D0URjQV+xbhM7l3NOdu6H4uJjdxM/v356nw+8gTc25F20I2U/kF
         YMTA==
X-Gm-Message-State: APjAAAUSTnESjo+cTlW02iNc7O/xAwvH1HL8xdqwBDD82qEv5Y+MCSJ5
        wpk2wET+hEUY9jDEQ3MpFbExlR7FrT1SMu+/pJR2LPH/eZw=
X-Google-Smtp-Source: APXvYqzsZxz1kv92CbfpsiaZOUVTkIIwHUagpMF6gc9UEUNm/CAy7Iuj+SOwdeBhMsBZMV94Ijn46VAg+xm3ctypNb0=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr14168249otk.189.1580172387271;
 Mon, 27 Jan 2020 16:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz> <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz> <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200127144931.GM1183@dhcp22.suse.cz>
In-Reply-To: <20200127144931.GM1183@dhcp22.suse.cz>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 27 Jan 2020 16:46:16 -0800
Message-ID: <CAM_iQpXGqGse1pybMW+dCi_vp05W9GTRWtS-3O2hdsY-hR=Yng@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:49 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 26-01-20 11:53:55, Cong Wang wrote:
> > On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > > > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > > > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > > > too:
> > >
> > > So it seems that you are condending on the page lock. It is really
> > > unexpected that the reclaim would take that long though. Please try to
> > > enable more vmscan tracepoints to see where the time is spent.
> >
> > Sorry for the delay. I have been trying to collect more data in one shot.
> >
> > This is a a typical round of the loop after enabling all vmscan tracepoints:
> >
> >            <...>-455450 [007] .... 4048595.842992:
> > mm_vmscan_memcg_reclaim_begin: order=0 may_writepage=1
> > gfp_flags=GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE
> > classzone_idx=4
> >            <...>-455450 [007] .... 4048595.843012:
> > mm_vmscan_memcg_reclaim_end: nr_reclaimed=0
>
> This doesn't tell us much though. This reclaim round has taken close to
> no time. See timestamps.
>
> > The whole trace output is huge (33M), I can provide it on request.
>
> Focus on reclaim rounds that take a long time and see where it gets you.

I reviewed the tracing output with my eyes, they all took little time.
But of course I can't review all of them given the size is huge.

For me, it seems that the loop happens in its caller, something
like:

retry:
  mm_vmscan_memcg_reclaim_begin();
  ...
  mm_vmscan_memcg_reclaim_end();
  goto retry;

So, I think we should focus on try_charge()?

More interestingly, the margin of that memcg is 0:

$ sudo cat /sys/fs/cgroup/memory/system.slice/osqueryd.service/memory.usage_in_bytes
262144000
$ sudo cat /sys/fs/cgroup/memory/system.slice/osqueryd.service/memory.limit_in_bytes
262144000

Thanks!
