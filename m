Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8F6206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sa4INENi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHZQox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:44:49 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:44:48 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x7so1021754qvi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMlIvAM6M5w9dD2eayY13lUR07MsoMvR9kGoMcT+/Vc=;
        b=sa4INENi9XADKc047/PpGSBs9OMWCrJoNYxa3t1qJ5P2krTtixPAqQnLcE52OIziLw
         CFk5ZjD/kvInASBoNghbOcXThF4viWJW1YQOOJvmsGWxWaTYxn0Yz147rbv4xMi2KWgN
         QbHm9FRDrpY3hXjAreEdCaIct/hfd7Q7eeMU7JHLXeKAR27Slz8XOGnkxa8/MREG7eEb
         jMNB0qKlQvnHrOO2WVvHSjzDNvjVs25xHHGWlMZ3mv/mzhNPpsci2lPogBR2ObtwkxC1
         gYjfNoBmaN3A/oZ6ddcGThYGqYbBWB3wmmsBWYUa4lIHN8vxzknbzsar8iqHuLfGWEEY
         o3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMlIvAM6M5w9dD2eayY13lUR07MsoMvR9kGoMcT+/Vc=;
        b=NiCOLvWfWU5BhABTtZAg6ljSe2f5BfsdEhh4VlbbwWzH4eSpCOFl7zR7QRJW0m1XSL
         GQY+8DAcjzVox7Z3DlWb7G05kY0sYzIwB+SdKrWbmE0TtbM6oMKX0PVfEhDecl7xI/Vg
         2yD0yNmxorxm1wGapST+qBRRFo+7uXCU0uFPReNcmFlbqB/v4rqg74WAkYIWQ7YDOx/L
         yuNCkfSQU5KNZJI4wkK7K+tMP8n/MOZ5ZaTTWV1c/ZTInf6nCSMAGit5ptEe4ik8rJRR
         eyNylFjs0t15J8fcAM0aH2J31bSbXDWDQi2Vk+4EqKbrxyq+4/hx8NuAdEwvakJCFy/M
         oINQ==
X-Gm-Message-State: AOAM531aHOdOpltYsIWxovSyRF5m5VF762i2Y8TKpfMGQvHP+Qu+XsZJ
        Q8tvjaSrvRCUIcxQjkWZMy2XOw==
X-Google-Smtp-Source: ABdhPJwbxQodulUoC+XsfqRwscBSrsaPaaZPNTBqFg+7kWdcvIy46YEkKl6xK5uoywWItguN9+rDIg==
X-Received: by 2002:a0c:fbd1:: with SMTP id n17mr15033373qvp.4.1598460287847;
        Wed, 26 Aug 2020 09:44:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id 73sm2396864qtf.74.2020.08.26.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:44:47 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:43:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826164332.GB995045@cmpxchg.org>
References: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:47:02PM +0800, Xunlei Pang wrote:
> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
> the target memcg doesn't have any reclaimable memory.
> 
> It can be easily reproduced as below:
>  watchdog: BUG: soft lockup - CPU#0 stuck for 111s![memcg_test:2204]
>  CPU: 0 PID: 2204 Comm: memcg_test Not tainted 5.9.0-rc2+ #12
>  Call Trace:
>   shrink_lruvec+0x49f/0x640
>   shrink_node+0x2a6/0x6f0
>   do_try_to_free_pages+0xe9/0x3e0
>   try_to_free_mem_cgroup_pages+0xef/0x1f0
>   try_charge+0x2c1/0x750
>   mem_cgroup_charge+0xd7/0x240
>   __add_to_page_cache_locked+0x2fd/0x370
>   add_to_page_cache_lru+0x4a/0xc0
>   pagecache_get_page+0x10b/0x2f0
>   filemap_fault+0x661/0xad0
>   ext4_filemap_fault+0x2c/0x40
>   __do_fault+0x4d/0xf9
>   handle_mm_fault+0x1080/0x1790
> 
> It only happens on our 1-vcpu instances, because there's no chance
> for oom reaper to run to reclaim the to-be-killed process.
> 
> Add cond_resched() at the upper shrink_node_memcgs() to solve this
> issue, and any other possible issue like meomry.min protection.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>

This generally makes sense to me but really should have a comment:

	/*
	 * This loop can become CPU-bound when there are thousands
	 * of cgroups that aren't eligible for reclaim - either
	 * because they don't have any pages, or because their
	 * memory is explicitly protected. Avoid soft lockups.
	 */
	 cond_resched();

The placement in the middle of the multi-part protection checks is a
bit odd too. It would be better to have it either at the top of the
loop, or at the end, by replacing the continues with goto next.
