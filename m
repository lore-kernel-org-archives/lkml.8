Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B231AC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A6820720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enSbUPCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGLBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:01:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:01:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so2113903wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W8AcEXT/rp+0zMDA+Sxx4tL9Ve5RCfDJTXhXGZXjlx8=;
        b=enSbUPCWnWIc6UKBGnavS5xw5jxPY78jfxEYeHw9vUhCuSeTfmw9VdfLV4xrU9hZfC
         d/XF/wqiGJzo4GCUFnfB6zajgD9iw4XWuep4C26Wz9H2Ki1VnKLCqKAnD6IPHVuuISjb
         ymjUz7yAc9HvbyKC9b9ZqLGb9GmbkBYpwYb7NFQGm5eJM7IUP0GWD7he6ZJKokb1sUnX
         o2aRCoUjS+U7sbPHZsOzzvlHavSBlrEpYr/KwQByVF6wxzwkHBFcFuDGVsFDQEHyRrIE
         HNPQ/22daouF06x/7PWYs02G4yQowaapqYioLIzWyrkJknkW0QYWXe7FjIPaMWW0QlWJ
         WMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W8AcEXT/rp+0zMDA+Sxx4tL9Ve5RCfDJTXhXGZXjlx8=;
        b=oj3FqZKCy+QIQnUxPSmwvauIUm+pRl9BrpLryVYsOKxdlPXjTW0yppO7dtoRkHIgnk
         DPStOUNqRF7sSzX1oWFlg5P4J8uL85bdapClXUxgbvdReThScxbcbCRQP0SRPA5BeUa5
         TJPXn0VF9cMRrPg5z/8b4se4wQPLTUX63UOuU13pT/zygEJyuiXH9Wr8OAkWRriA0o1M
         SruaMIGIWq5CDZV7DMCYf7DJ0p2G2314Y20gBI9K3V+zZIcTp2jemWaYY5IGju4APbrn
         1q3gpu97yv4q9QJvwbaHSO+VCK2U1gH5uTb9keTlWTRV1LZo8sndSFhG0FoEe5LkagCi
         oKGQ==
X-Gm-Message-State: APjAAAX+rl3sd40Kz1FDrgmZWhhLsLWBXAZ7ZxWeE0nzQmciWiYWS9bH
        7zocPZcpGMFBXe5bIQdoSqxPbA==
X-Google-Smtp-Source: APXvYqzifS46M2AvxTYMCGZrRkknhnkS07fFdufBB7Y/un81ljI3lSDr/42rzsJDCW+2O2zl1aCBPg==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr3862919wrv.291.1581073273558;
        Fri, 07 Feb 2020 03:01:13 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o4sm3094270wrw.15.2020.02.07.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 03:01:13 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:01:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v4 1/4] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200207110109.GB228234@google.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Feb 2020 at 19:19:54 (+0000), Valentin Schneider wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> Issue
> =====
> 
> On asymmetric CPU capacity topologies, we currently rely on wake_cap() to
> drive select_task_rq_fair() towards either
> - its slow-path (find_idlest_cpu()) if either the previous or
>   current (waking) CPU has too little capacity for the waking task
> - its fast-path (select_idle_sibling()) otherwise
> 
> Commit 3273163c6775 ("sched/fair: Let asymmetric CPU configurations balance
> at wake-up") points out that this relies on the assumption that "[...]the
> CPU capacities within an SD_SHARE_PKG_RESOURCES domain (sd_llc) are
> homogeneous".
> 
> This assumption no longer holds on newer generations of big.LITTLE
> systems (DynamIQ), which can accommodate CPUs of different compute capacity
> within a single LLC domain. To hopefully paint a better picture, a regular
> big.LITTLE topology would look like this:
> 
>   +---------+ +---------+
>   |   L2    | |   L2    |
>   +----+----+ +----+----+
>   |CPU0|CPU1| |CPU2|CPU3|
>   +----+----+ +----+----+
>       ^^^         ^^^
>     LITTLEs      bigs
> 
> which would result in the following scheduler topology:
> 
>   DIE [         ] <- sd_asym_cpucapacity
>   MC  [   ] [   ] <- sd_llc
>        0 1   2 3
> 
> Conversely, a DynamIQ topology could look like:
> 
>   +-------------------+
>   |        L3         |
>   +----+----+----+----+
>   | L2 | L2 | L2 | L2 |
>   +----+----+----+----+
>   |CPU0|CPU1|CPU2|CPU3|
>   +----+----+----+----+
>      ^^^^^     ^^^^^
>     LITTLEs    bigs
> 
> which would result in the following scheduler topology:
> 
>   MC [       ] <- sd_llc, sd_asym_cpucapacity
>       0 1 2 3
> 
> What this means is that, on DynamIQ systems, we could pass the wake_cap()
> test (IOW presume the waking task fits on the CPU capacities of some LLC
> domain), thus go through select_idle_sibling().
> This function operates on an LLC domain, which here spans both bigs and
> LITTLEs, so it could very well pick a CPU of too small capacity for the
> task, despite there being fitting idle CPUs - it very much depends on the
> CPU iteration order, on which we have absolutely no guarantees
> capacity-wise.
> 
> Implementation
> ==============
> 
> Introduce yet another select_idle_sibling() helper function that takes CPU
> capacity into account. The policy is to pick the first idle CPU which is
> big enough for the task (task_util * margin < cpu_capacity). If no
> idle CPU is big enough, we pick the idle one with the highest capacity.
> 
> Unlike other select_idle_sibling() helpers, this one operates on the
> sd_asym_cpucapacity sched_domain pointer, which is guaranteed to span all
> known CPU capacities in the system. As such, this will work for both
> "legacy" big.LITTLE (LITTLEs & bigs split at MC, joined at DIE) and for
> newer DynamIQ systems (e.g. LITTLEs and bigs in the same MC domain).
> 
> Note that this limits the scope of select_idle_sibling() to
> select_idle_capacity() for asymmetric CPU capacity systems - the LLC domain
> will not be scanned, and no further heuristic will be applied.
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Co-developed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
