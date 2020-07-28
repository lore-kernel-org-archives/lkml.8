Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B45C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CFB206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2hUeavO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgG1PEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgG1PEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:04:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB9C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:04:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r19so21462067ljn.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/P1RjJpCb35GTdXwmZama92miIfq20CiqjQcC8AgAQ=;
        b=r2hUeavOspQPDYUPCBYkcJ2t+SMHCVWUjhVCsn95Ke4mIVcywTVe3IycEi48ReFcwU
         kcAOO4zPa99rNHCsHrWLtD4PXhyPCUyPjdEP7NYt3nvm6ux90bPxF1FWXFiyakhvkdkO
         VnOh0VAy/vHFlRk7yxNZKDWh+hlim9Bu5/Ou/OLzZclgir2QQrrtAFl89Rm8azwsMtvy
         bjqK7LiMwhx43GT7gM6KUsyOcNHjLhKYiMBjFxnZga7trt3rZuSkz4MImI29UhrVr7tV
         BsLP4fsDZpp6Mz+5Zk0E9362Kt408Wx7KJyjNDFq8OmfFzxE+bdGWKGRvhP7xee39zg1
         a6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/P1RjJpCb35GTdXwmZama92miIfq20CiqjQcC8AgAQ=;
        b=mLTul3VHNwQrVk7MhKXZIFfDr0uKYNMpYZn+pv/X2DV+Blu8PTolwiqu3NK9qEG4GO
         3fZ0ihDc4lzRoriSWSg+6V0kuhLX/BAnLL4yF/qRKTEso1lnMaHsZymKAuehyRaBLRt4
         x12YnfhA82eBZAHEqZKUu5DuMDWxzTZV6DUkrLo6f8s9EaTkiQYIzhwUP+e3KAERVzuE
         9y2YH8nWis4YhSExrnM2BnVa6GuSvWh94/enYGNYoeWPJPlqtqYyKcqGBIAywiD3I3CN
         3CRxGIX24Hyh0YnhJPKOT2MRx2PnwlHRrHsTWIALMWGGGoVnQqOfL8X6/i403BMDVLMe
         Ofww==
X-Gm-Message-State: AOAM530pNHtSPU2sTSFQXQYAzbGUp6zR71LNkhOYvv9NfntsPGPXliZc
        MHmqTo/15mbNJXwdkSRgEfuzc5VnixtuF6704KnLyw==
X-Google-Smtp-Source: ABdhPJyBtXIozdbRd6lEJqYK3D9Y3Dhz5EcMC+1cVuW0HGWZuwxdBZ1H2dci/1QsDlmowJpXZTB1/6V9w3F9GuQ7V0E=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr13868230lji.446.1595948648596;
 Tue, 28 Jul 2020 08:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200728135210.379885-2-hannes@cmpxchg.org>
In-Reply-To: <20200728135210.379885-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jul 2020 08:03:56 -0700
Message-ID: <CALvZod6X1QNvxZB-5oUaY0CeZENz-K04bSnx95M4JpUcvKh0mQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't count limit-setting reclaim as
 memory pressure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 6:53 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When an outside process lowers one of the memory limits of a cgroup
> (or uses the force_empty knob in cgroup1), direct reclaim is performed
> in the context of the write(), in order to directly enforce the new
> limit and have it being met by the time the write() returns.
>
> Currently, this reclaim activity is accounted as memory pressure in
> the cgroup that the writer(!) belongs to. This is unexpected.

Indeed this is unexpected.

> It
> specifically causes problems for senpai
> (https://github.com/facebookincubator/senpai), which is an agent that
> routinely adjusts the memory limits and performs associated reclaim
> work in tens or even hundreds of cgroups running on the host. The
> cgroup that senpai is running in itself will report elevated levels of
> memory pressure, even though it itself is under no memory shortage or
> any sort of distress.
>
> Move the psi annotation from the central cgroup reclaim function to
> callsites in the allocation context, and thereby no longer count any
> limit-setting reclaim as memory pressure. If the newly set limit
> causes the workload inside the cgroup into direct reclaim, that of
> course will continue to count as memory pressure.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
