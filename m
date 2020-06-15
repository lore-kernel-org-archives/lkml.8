Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7815BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7F52063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="aPeEzEq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgFOPJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgFOPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:09:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC4CC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:09:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f7so17830630ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I3pYBTJCH1fWxzUVivyIxWA31KHjVQXjnfV1c/iHSQ8=;
        b=aPeEzEq8Bmncf5GDxG4bKMbLMmpAo3LrvR3mDRIGWrMYi8m0weo1We6uJeEyp/OCdf
         /K4tB062Vr1+uzaRvdUPls1EMMG+6mqPlTcGG+J0AVYmUhkuQd4uuhW8AEwLZcc4EZoB
         CSGBuXP88a9JMP/xuTmLWTkbgT6ick7fAsj5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I3pYBTJCH1fWxzUVivyIxWA31KHjVQXjnfV1c/iHSQ8=;
        b=O5bRwUEXRqUprctV4cUVyF2Gdf4EjESRcoPWfHfIQnVOeUNp2vwMk4Jrx8nc9F5G6X
         QxUsZJDAXa+tP/Ce/NOgSVZJwJKs8HLf0Kuk/sPYp+MDQqvREMGOvDp4TAr0Z/WCTO43
         HDi/hkCo9J8fZRA4SpVIQcTMiGKsNnQ8UHo3JvL9kti6cuwYje4ZArHGIAFIFeOum8l5
         mbzD6qNgVydO4VGUs1koVsorV9z0XYw0Swg9K+U/RdD98eVwxdi0pQqLpa65g/xIZ7EI
         OYfqwwwQpsTDNRwIiIH2BSthIJo4ZRw6uEcGkNTdIkE/A2uvgXF3f76yciukfRdCNP2X
         zdvw==
X-Gm-Message-State: AOAM531fBq2OXtjAy7N4S1Q1urxGLi8YCTfy8R4RzC6Xn+CflZK9OVYq
        Lsc2/z0UUqD1xAyoAPPyadWtbg==
X-Google-Smtp-Source: ABdhPJzeW4+2+GixiCcm6tt6aIOT33friuuTwTXSJQgxiQ6xtbaI4m513By7G/zR8apVHeGwbGMnMg==
X-Received: by 2002:a17:906:edb6:: with SMTP id sa22mr14094332ejb.393.1592233752926;
        Mon, 15 Jun 2020 08:09:12 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:3c3c])
        by smtp.gmail.com with ESMTPSA id s17sm9134265eju.80.2020.06.15.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:09:12 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:09:11 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: handle div0 crash race condition in
 memory.low
Message-ID: <20200615150911.GD157916@chrisdown.name>
References: <20200615140658.601684-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200615140658.601684-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>Tejun reports seeing rare div0 crashes in memory.low stress testing:
>
>[37228.504582] RIP: 0010:mem_cgroup_calculate_protection+0xed/0x150
>[37228.505059] Code: 0f 46 d1 4c 39 d8 72 57 f6 05 16 d6 42 01 40 74 1f 4c 39 d8 76 1a 4c 39 d1 76 15 4c 29 d1 4c 29 d8 4d 29 d9 31 d2 48 0f af c1 <49> f7 f1 49 01 c2 4c 89 96 38 01 00 00 5d c3 48 0f af c7 31 d2 49
>[37228.506254] RSP: 0018:ffffa14e01d6fcd0 EFLAGS: 00010246
>[37228.506769] RAX: 000000000243e384 RBX: 0000000000000000 RCX: 0000000000008f4b
>[37228.507319] RDX: 0000000000000000 RSI: ffff8b89bee84000 RDI: 0000000000000000
>[37228.507869] RBP: ffffa14e01d6fcd0 R08: ffff8b89ca7d40f8 R09: 0000000000000000
>[37228.508376] R10: 0000000000000000 R11: 00000000006422f7 R12: 0000000000000000
>[37228.508881] R13: ffff8b89d9617000 R14: ffff8b89bee84000 R15: ffffa14e01d6fdb8
>[37228.509397] FS:  0000000000000000(0000) GS:ffff8b8a1f1c0000(0000) knlGS:0000000000000000
>[37228.509917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[37228.510442] CR2: 00007f93b1fc175b CR3: 000000016100a000 CR4: 0000000000340ea0
>[37228.511076] Call Trace:
>[37228.511561]  shrink_node+0x1e5/0x6c0
>[37228.512044]  balance_pgdat+0x32d/0x5f0
>[37228.512521]  kswapd+0x1d7/0x3d0
>[37228.513346]  ? wait_woken+0x80/0x80
>[37228.514170]  kthread+0x11c/0x160
>[37228.514983]  ? balance_pgdat+0x5f0/0x5f0
>[37228.515797]  ? kthread_park+0x90/0x90
>[37228.516593]  ret_from_fork+0x1f/0x30
>
>This happens when parent_usage == siblings_protected. We check that
>usage is bigger than protected, which should imply parent_usage being
>bigger than siblings_protected. However, we don't read (or even
>update) these values atomically, and they can be out of sync as the
>memory state changes under us. A bit of fluctuation around the target
>protection isn't a big deal, but we need to handle the div0 case.
>
>Check the parent state explicitly to make sure we have a reasonable
>positive value for the divisor.
>
>Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
>Reported-by: Tejun Heo <tj@kernel.org>

Acked-by: Chris Down <chris@chrisdown.name>
