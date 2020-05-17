Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B6207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kWafknG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgEQBy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEQBy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 21:54:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546DC05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 18:54:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g20so3073174qvb.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QqBtGMwRf4iMThT/E7Zzgq854jp3AIpzA1Y8zlAhggY=;
        b=kWafknG1HhI2nq0LzV1WNZsMtIbtpGsnnUjIJW35CsFYFMlqLGy5HA66FACPokMXhc
         /8td4xNLaqhlfun7I+onfk0qbHyvwgkIKM8bOj4UMsnD0rRDMxMFSALK5mG4ULqZwOj6
         WmoXzu7R1hOLYUxM2mStHwrkm9PL4c1U1akmER10YBtOmhSV/QJGIj1QxTJ8sHWdoxzm
         dbKcw0on4aWVPAChVGm9vwFsCT8sIV3v9jp7cvdbpBJyWqOLiLrk+mVcF4sn8GKQ2wvn
         RuI8czmKO7TExBBB9x2BribWkKTRmRWIkWPT23qn8tkEWth3IcWCMu+8xOn6mQAGy9ww
         kcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QqBtGMwRf4iMThT/E7Zzgq854jp3AIpzA1Y8zlAhggY=;
        b=dVKBkhXKk6pO4aeaNxdzLvt589gcHzTFeOyEEu5MjjbUehjGcuSeg7JY71RPLuoA68
         WTvfuhwF6kkovPamXAeBBS841m9dDRe6oLjrfXVP23+JUMdwSrBohbgSDoOjIm0BKRiS
         sGQUJV1PyDKb+cmMG4uB/PeI/dBUmqI4IYff4p9/BXonKvDsKAa2IQq5kDCd4LS3P62A
         vT+TfOguEa+ljuEp5WrIqG9SxotoVdFRYcsvjhn+GYU7vDnBhiliwaLyGpqSv9XGAGls
         kMKT8pIIdwpHYwQlvWUI16maYDgwElp3tJTJxjffF/ZlJutTWeqMdvbJOm2yzuhGDYS7
         CdXQ==
X-Gm-Message-State: AOAM533Y2+dxSzPW5lVJkBDGgclUHGgm+w+plN0LhhacAnxMbeqaZLzQ
        j2Sv92K82jz22gZpNaXEVs4Ljg==
X-Google-Smtp-Source: ABdhPJwXFqCGZrPtK8SOtTnNQZnWefQKpRMKA6723XCzFN2bp70KEacdXczdHr/cz1QgFNHfQMMwXg==
X-Received: by 2002:a0c:eb8b:: with SMTP id x11mr10102936qvo.33.1589680466545;
        Sat, 16 May 2020 18:54:26 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m33sm5978445qtb.88.2020.05.16.18.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 18:54:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/4] mm/slub: Fix sysfs circular locking dependency
Date:   Sat, 16 May 2020 21:54:25 -0400
Message-Id: <2BD2A76D-CB50-4BA8-A867-DF71B1DA5F28@lca.pw>
References: <20200427235621.7823-1-longman@redhat.com>
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
In-Reply-To: <20200427235621.7823-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
> 
> v2:
> - Use regular cmpxchg() instead of x86-only try_cmpxchg() in patch 2.
> - Add patches 3 and 4 to fix circular locking dependency showing up
>   at shutdown time.
> 
> With lockdep enabled, issuing the following command to the slub sysfs
> files will cause splat about circular locking dependency to show up
> either immediately afterwards or at shutdown time.
> 
> # echo 1 > validate
> # echo 1 > shrink
> 
> This patchset fixes these lockdep splats by replacing slab_mutex with
> memcg_cache_ids_sem as well as changing some of the lock operations
> with trylock.

For the whole series, feel free to use,

Tested-by: Qian Cai <cai@lca.pw>
