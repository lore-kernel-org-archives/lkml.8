Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F121206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Tqpge43y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgD1VRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgD1VRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:17:03 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394FEC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:17:03 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so109452qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WE6fRMNAlJdivHdtcAIHzYCELiaeahloDmul9mg0d04=;
        b=Tqpge43yY2XClplBd6Cuaaz88Fy6z2Qetea0T++CdEVcloY1WyqWjq9GfNzvdloNf+
         QCyDC7llMs9FBzVbURzA6D2Q7zKZX469Z0F+4Nio7TMivfGJKk8UlmDymTXKq+4dgRsO
         BKbEtWpnzOKtWZMiirCI3Ybp9zHdbKYkkOj3efyJeOoZQARwk13IewUWv53ivh3bZHLE
         2sI3P6Qod7o/TOvQCgAECFhN2fPYIXf0l1/OaiDqILqzJXcoiR4TfBzmdOZ880OwlFop
         grO3SdOEeWLC3XC9c3Td6B2frG8r/+tjxUjk9EGVq9WX7g1l58zDfeurHDEdNkYGStkr
         ciSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WE6fRMNAlJdivHdtcAIHzYCELiaeahloDmul9mg0d04=;
        b=lDHkd65A04OfBCfZwzmi0ihjMA94/fy6W3Wq5yJ5aSSFl4hh4gxj0gaUaVmfg0DNsM
         b5EuLATM0hZ4jRnDrakxn4mdkbvYhvEmJjfdSVraJSxui1UXFPPRvYj3clgty/mbYglb
         VpG6iitrsn1nPNT5sb642IF7J8iDfAywjR0AQB7FxsXRMVau3fTrtHU92rxrbg9+O/bz
         ScYumJmye4HzGv7q15pM1ucbziX3d0gGcmuPljtFyemt1vru6k6MCoqNZC0v0MzIK/x+
         v1HgYjgZxAaG/a6wu/ytWVVoeuhmgMBCGEzW4fbY0wOasf6eA6l+onml9YATcaA5dCuj
         Ew+A==
X-Gm-Message-State: AGi0Puad+4LO19SBhzzksPhX+A34yS0OMtAw6j1jOw1TBgnHvETvXQnm
        7yQzf7vr97mo78hS/V6oSsQroA==
X-Google-Smtp-Source: APiQypJWl8lRQzqib+jNVx+26p3v6+O+XdKVsDcIn39jYHtyA8sdXsPU0dP7yEIFCdl0sSPFRPzytQ==
X-Received: by 2002:a0c:8ecf:: with SMTP id y15mr30805391qvb.44.1588108622306;
        Tue, 28 Apr 2020 14:17:02 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u7sm14035646qkj.51.2020.04.28.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:17:01 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:16:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200428211651.GA400178@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 07:26:47PM +0100, Chris Down wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> 
> A cgroup can have both memory protection and a memory limit to isolate
> it from its siblings in both directions - for example, to prevent it
> from being shrunk below 2G under high pressure from outside, but also
> from growing beyond 4G under low pressure.
> 
> Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> implemented proportional scan pressure so that multiple siblings in
> excess of their protection settings don't get reclaimed equally but
> instead in accordance to their unprotected portion.
> 
> During limit reclaim, this proportionality shouldn't apply of course:
> there is no competition, all pressure is from within the cgroup and
> should be applied as such. Reclaim should operate at full efficiency.
> 
> However, mem_cgroup_protected() never expected anybody to look at the
> effective protection values when it indicated that the cgroup is above
> its protection. As a result, a query during limit reclaim may return
> stale protection values that were calculated by a previous reclaim cycle
> in which the cgroup did have siblings.
> 
> When this happens, reclaim is unnecessarily hesitant and potentially
> slow to meet the desired limit. In theory this could lead to premature
> OOM kills, although it's not obvious this has occurred in practice.
> 
> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> 
> [hannes@cmpxchg.org: rework code comment]
> [hannes@cmpxchg.org: changelog]
> [chris@chrisdown.name: fix store tear]
> [chris@chrisdown.name: retitle]

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
