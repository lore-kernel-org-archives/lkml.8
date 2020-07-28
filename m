Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1260C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBE3207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="T9uJ9mFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgG1TpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732971AbgG1Tou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:44:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8514C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:44:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so1364208ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkoR8SRsEyrF2DTHYAGqExugDiMhFbQnq4qppceRyxQ=;
        b=T9uJ9mFokE3Rom3E92aAP07PvouUaqSFqQVv02w73ZLda3GVnG9dqeQ8A6++cuDNaG
         JhR9XROOwvBKmnM22qrgiEQ4q/UEWLMu9MpmZl+5FAbsRjf9z2a4fw5GWPmPvAaQetrb
         lpIr7cCLzsyFxEF9sP3U7dtZf6wz53vufxdjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkoR8SRsEyrF2DTHYAGqExugDiMhFbQnq4qppceRyxQ=;
        b=skSogDqqkU+CuxO94mO3AdhVHCAnQYfnmGKxk2Um4iXjMXeECNpthPX54WJa3bip+R
         +9E+KdNqqn/V+NLKOsseSvGdWu+tl1UE4JG1IIgUQTz1aNZ1wEaHByzr5eop1HDk91CZ
         OgEIRA1mLShoc2ADfGhg6QCSSoPaQ0qevIzhqT6WcpDhOsDE7wSiolpzXGBugjwL4D3o
         Nien/naGzI6RyawspKAeiUkfz36VbeX0cDCePZQ+6YIbocc7R4aTAreM+28ozinrm9x1
         fJcZQf8wUaEmPtcRNppxNlr/3ObpqIJ0ZWhiEPsI8vT2UeDdc7L3Q6gYtMmWQ9X/BGVE
         IvzA==
X-Gm-Message-State: AOAM531NNrO3NraLkSruztXJaIK5RYeHMn4gKT0YiZz56st+6wX8WCGc
        cT3tE+sneoeGvLdIIYtDLW6h7g==
X-Google-Smtp-Source: ABdhPJyy+UbCRh/ek39ITwXBTt5sWdRD3rTd9LGjRFT9wh6vIF12fOXqlhthXA//uTNtq/f+Fm92Og==
X-Received: by 2002:a17:906:2851:: with SMTP id s17mr27794849ejc.347.1595965488560;
        Tue, 28 Jul 2020 12:44:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f8d8])
        by smtp.gmail.com with ESMTPSA id i5sm9663975ejc.114.2020.07.28.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:44:47 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:44:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: don't count limit-setting reclaim as
 memory pressure
Message-ID: <20200728194447.GB196042@chrisdown.name>
References: <20200728135210.379885-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>When an outside process lowers one of the memory limits of a cgroup
>(or uses the force_empty knob in cgroup1), direct reclaim is performed
>in the context of the write(), in order to directly enforce the new
>limit and have it being met by the time the write() returns.
>
>Currently, this reclaim activity is accounted as memory pressure in
>the cgroup that the writer(!) belongs to. This is unexpected. It
>specifically causes problems for senpai
>(https://github.com/facebookincubator/senpai), which is an agent that
>routinely adjusts the memory limits and performs associated reclaim
>work in tens or even hundreds of cgroups running on the host. The
>cgroup that senpai is running in itself will report elevated levels of
>memory pressure, even though it itself is under no memory shortage or
>any sort of distress.
>
>Move the psi annotation from the central cgroup reclaim function to
>callsites in the allocation context, and thereby no longer count any
>limit-setting reclaim as memory pressure. If the newly set limit
>causes the workload inside the cgroup into direct reclaim, that of
>course will continue to count as memory pressure.

Seems totally reasonable, and the patch looks fine too.

>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Chris Down <chris@chrisdown.name>
