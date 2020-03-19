Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E9C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7394520787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ER44yHPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCSNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:37:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41802 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgCSNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:37:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id s11so2976010qks.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bzGn7Gk/5VEP8iiNf0RI2RP1uEYAlH6euk3f2j6y39w=;
        b=ER44yHPUvm/hh/WnOk5P3sKimpp5bJ0Uzl0FlbO+RjM+gRbmYvwO6LNLLbvRfiXf/X
         51vNNRNLuVFdMpNJcVZPYBQGp/ClvS5o8pckbAdvDIQxMXJjD8nZF9zFfm4ZMDJ7H/ql
         FhLuIMRYSizr3PcZ2j0HVcE27h58yp1fN9+qv3OeS5KiJXC1Vm0QHlRkKSg05kIwuTUI
         494p/5zlzQZWVLByzpLFfG8daRQKP360jXQcdphoiuMs5RG7AgpMD3EwrNe6Sva/Oz0Q
         09MHPwzORFjJwSJ+j+f3xzh3iIorGb0sqm31so/eylT4HNZ+zz2YdgQI6Ff2hBfZM93p
         u7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bzGn7Gk/5VEP8iiNf0RI2RP1uEYAlH6euk3f2j6y39w=;
        b=ClJ7Nr+ixYySBUMOMvd7hAE9FY0fzqSNPuYvIf14nI8jnWT/3TXgIbaU074uipLu89
         rYEEls+X0Rz5Cpu8zSpXyq6rokcwBn25E6L0Ttq6tvzs6NzLT9olAnkrf/k5UaKvjuja
         aVRfFFVcR0TFtk1VQ/X1dO19ce0qhdeBIaSVXfV5k+xGuIi4SzKTr3MStA+6beUg1nxT
         ai4jcEK9QKKIFVUSnZsAJ7pfb3QjAFH8ETNtuEB640tk9lTN101BjnVPNQTh02xV3ArL
         4bAe/vv2zk6UifdYI8PjQSZRLofI6GCpuCuSkc2YkbisvSEWCUbzLMSSwQh8TueWCMmQ
         pcEg==
X-Gm-Message-State: ANhLgQ1VU0Epo0EUjdLMeD1MsJTon9W+rxznF2MDcKYNkrtsAaJqWulD
        lEjFIqPQ6BcYy9ow+6j6trQ/lg==
X-Google-Smtp-Source: ADFU+vseiJmYb7eviCZYeaPPVuhz439HV1+w/jx7c51VK1F3Gt6H+2pCESvAHgNnp+uVwYyN0c/TbQ==
X-Received: by 2002:ae9:ef92:: with SMTP id d140mr2836542qkg.412.1584625067514;
        Thu, 19 Mar 2020 06:37:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id v1sm1532669qtc.30.2020.03.19.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 06:37:47 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:37:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200319133746.GA187654@cmpxchg.org>
References: <20200316223510.3176148-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316223510.3176148-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:35:10PM -0700, Roman Gushchin wrote:
> If a task is getting moved out of the OOMing cgroup, it might
> result in unexpected OOM killings if memory.oom.group is used
> anywhere in the cgroup tree.
> 
> Imagine the following example:
> 
>           A (oom.group = 1)
>          / \
>   (OOM) B   C
> 
> Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> selects a task in B as a victim, but someone asynchronously moves
> the task into C. mem_cgroup_get_oom_group() will iterate over all
> ancestors of C up to the root cgroup. In theory it had to stop
> at the oom_domain level - the memory cgroup which is OOMing.
> But because B is not an ancestor of C, it's not happening.
> Instead it chooses A (because it's oom.group is set), and kills
> all tasks in A. This behavior is wrong because the OOM happened in B,
> so there is no reason to kill anything outside.
> 
> Fix this by checking it the memory cgroup to which the task belongs
> is a descendant of the oom_domain. If not, memory.oom.group should
> be ignored, and the OOM killer should kill only the victim task.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Dan Schatzberg <dschatzberg@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
