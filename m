Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7542054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xS4StaPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgH0OsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgH0ODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:03:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B0C06123F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:01:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so4586426qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dfRzlPwQNyPtrYJ/iS+qwie4ofTE9hR5y2kv8hIuyaA=;
        b=xS4StaPpTGC1Pj9KQLMY1y4Hh+DxvuykLCRhRCCR2ks3lS4BDPvs2wAKBG5COFaV+Z
         5a4iKQJRjfMzWvoEDRU+GIkjB6GHtWfHpJ/EnWEgGdhu+csIuY3GLUOjg1fPvtbeBDw/
         9kG7Tk4zkmcZbKeDMfK5TOyej+CKEs9zTCMzbx1iaTd9NO7CLzwhQUxNiMJes9ogin7K
         p8BpEdUk6FDEm+vs2kKUij8P4AbrVwzMbgEd5ySyVT+NMACU39HJ5japIJqtRQdyteCb
         vS/QIbWLJazcKT9ZK+bYjwJJ0I2rU8smS8FdNM9Y4fMY0myIX8+sxThkICielkbfW1wJ
         gykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dfRzlPwQNyPtrYJ/iS+qwie4ofTE9hR5y2kv8hIuyaA=;
        b=XYD6zVm+z4+EkH8UfY5JyhFNAThxBTtBZNV8t/6p2DWOwLZDtjOxtGStRw+sG7Bbbm
         Deof0Uq8+A70MJ02g+yNyraxR9qPU/x6/V9wIE94z83xYiL3om5oNrw1T7444lyAOG1z
         BmCVAKTzqj4kD5ML4yWcpjTsGVGW0oTYk3/1rCpwCfbqnnsEW3JKWXs+QHGExQLppWst
         iogdbwHnBnuYW6vIE08UKOItCV64ZJSsEa/AY1O2orA4F4TtNIYByTMSWwcWfHmSmK1C
         SyfGPA2pTorekJL82p0tnxcHYDuucT12U04q+Ti62C2YndZcB3KxcdSGXybxIPmbdmJp
         szGg==
X-Gm-Message-State: AOAM531+myGdeI/cQQ3DdmOjh5buj7EDzqG32NZdBdhTK2ZjMvgDim2Y
        suU+DiXsa4eVhoTGoto08phvDw==
X-Google-Smtp-Source: ABdhPJwHe/G+MpJjSZgeTDwatG8hgzZOb57B0FlRcGdq6AtF9uloUz2i4857L2RN01YtIeqdvZ25sg==
X-Received: by 2002:ac8:4c86:: with SMTP id j6mr19065010qtv.65.1598536906039;
        Thu, 27 Aug 2020 07:01:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id o47sm1860852qtk.19.2020.08.27.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:01:45 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:00:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200827140028.GA1002856@cmpxchg.org>
References: <1598495549-67324-1-git-send-email-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598495549-67324-1-git-send-email-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:32:29AM +0800, Xunlei Pang wrote:
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
> Add a cond_resched() at the upper shrink_node_memcgs() to solve this
> issue, this will mean that we will get a scheduling point for each
> memcg in the reclaimed hierarchy without any dependency on the
> reclaimable memory in that memcg thus making it more predictable.
> 
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
