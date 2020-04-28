Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B62C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F5C21841
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="F6JtusML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgD1ANi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1ANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:13:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852AC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:13:38 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ck5so2784608qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=T8w1cAu62fq3Z/o1KAR+sWAmzB/rXmhhrpuLQFBAE2o=;
        b=F6JtusMLTinzcqcUGMiUbaV2UdtlgxhuL6LAGXkeTZHk+Pr449mf/NN+OXQurRixTB
         q4taVk1n0AyKdsw8fkHxyPWrHStJ44B9LkpKzmEXsYSFT5xBk4bxXdYS/tmiiaAN077Y
         3sGnQt+B20IiZIqcvCmYTOWkrh/zocQxGAH3tQeeyd86oBSPbGIAYupBvOX1dsqmYWt1
         v8dSIy15SqYvOQ9owwKsiH3P2mH/omX7QeNRAfTuf2LVpiVaGHGw6acfvDTAWsxnOLuD
         La9kc2JCwHNei5DoPqEuqHjYb/VS7FQUmOlfJ7GOS3tUAUQy946ci3hYJLFuFB+Rlb4B
         rntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=T8w1cAu62fq3Z/o1KAR+sWAmzB/rXmhhrpuLQFBAE2o=;
        b=qc3ViOqjuWYBdkoezDO8Oh4bTZ+yCSLrJwq7judcu9gLk9wFwZJ2v0jAFodgzmsOAL
         tjbJTklE1D5+TecbzDQioczXsKK1g6H6tX+rG4XDM0Y7UZLLy1SSAA2fOVahPHb6KH7l
         8Xbd9BcyOD5CamnmGyCEc0rx/fEO7uBywvYpnQGxjSqFVWvGA53eFu7W7oIqo8UKnp4z
         xFQareNBkTvijTzom7H2Qv/+Ve9O5be8b4Zvmu8cto/Xpkbs+s1b4gWYj1kj7QGCHB92
         xapGlm3UEH3qRILJsvG1fm+D0RrjfQPPdg2w1X8maDGYQQgQiis1BwxG9SFcdkXkyFDc
         6log==
X-Gm-Message-State: AGi0PubYa3X7giR0jislqzCkcTFr4mPDXmPaFquy2gCNtEPBm6sRQAGJ
        XSVHrpzRcGvs6gWbIpb+yaneaQ==
X-Google-Smtp-Source: APiQypJn4FTOv85rWPD4nI1annl59MfgciOnHBOrcqSfE4D8IYqFhQj45SpSMByd3gG2ZRM+XnUxCg==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr25454231qvn.28.1588032817220;
        Mon, 27 Apr 2020 17:13:37 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 11sm2439712qkv.92.2020.04.27.17.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 17:13:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Mon, 27 Apr 2020 20:13:35 -0400
Message-Id: <55509F31-A503-4148-B209-B4D062AD0ED7@lca.pw>
References: <20200427235621.7823-5-longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <20200427235621.7823-5-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> A lockdep splat is observed by echoing "1" to the shrink sysfs file
> and then shutting down the system:
>=20
> [  167.473392] Chain exists of:
> [  167.473392]   kn->count#279 --> mem_hotplug_lock.rw_sem --> slab_mutex
> [  167.473392]
> [  167.484323]  Possible unsafe locking scenario:
> [  167.484323]
> [  167.490273]        CPU0                    CPU1
> [  167.494825]        ----                    ----
> [  167.499376]   lock(slab_mutex);
> [  167.502530]                                lock(mem_hotplug_lock.rw_sem=
);
> [  167.509356]                                lock(slab_mutex);
> [  167.515044]   lock(kn->count#279);
> [  167.518462]
> [  167.518462]  *** DEADLOCK ***
>=20
> It is because of the get_online_cpus() and get_online_mems() calls in
> kmem_cache_shrink() invoked via the shrink sysfs file. To fix that, we
> have to use trylock to get the memory and cpu hotplug read locks. Since
> hotplug events are rare, it should be fine to refuse a kmem caches
> shrink operation when some hotplug events are in progress.

I don=E2=80=99t understand how trylock could prevent a splat. The fundamenta=
l issue is that in sysfs slab store case, the locking order (once trylock su=
cceed) is,

kn->count =E2=80=94> cpu/memory_hotplug

But we have the existing reverse chain everywhere.

cpu/memory_hotplug =E2=80=94> slab_mutex =E2=80=94> kn->count


