Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDCC20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTgQ328Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFDIRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFDIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:17:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC6CC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:17:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f187so7169178ybc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dBhjvQ74rk87+xvmHCHMByl/N/LCyKOoeijL1Gf/O4E=;
        b=PTgQ328YnDam3JMX89/M53yQXWYuipuKp4wnwdFku6bBvCivR7xb1c6eFbsE+H+Kf4
         kUz2G12JgF+LiQiAvLcWiRPuS0BSKFkpjKDRGWJQU89Um5iJXLvZzIIvV6LxQ283D9F+
         UfAsuYZVjO+4tzvsTuDLhBPoFbJSSRZDif7PNa+4qrRuQYyG41Ts9TU6opuqooH4lOEn
         ldJUeiGFtsgSHv/VsJ3A4ZpuG5nrBSLfJ7WXy6/KT4T1L6RxrFlTuKyHPs0hOqWc9Bql
         KpLW0eUirQTTztYWMtEFOJdK3aCJjOX6KyAN15F4dJAqw+nrHapuFvPs4ZDklaAw/JBl
         uhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dBhjvQ74rk87+xvmHCHMByl/N/LCyKOoeijL1Gf/O4E=;
        b=eHK0VZivHfGU6KdFDat+x8MEDtMBIm/18hta67IYsJQlSSVVlDwIcxShUGCtUp1/X7
         mB0/13UZ5Qek/oX8vqK0dj9HyI6h30ogtSixFa2x7x5DrnFWfeleBkbKK23RP1pgEFnS
         mQpr57+qHYw2B1R44a13ZQXgzIlmWdWv4GTyR3dIYYXxRQskDHsj75OZVG+TFWkZsiAZ
         orUYoZy2pMLPfg74mLV5pg5eablvOvpqVvMUE6q2I64NmQSIto3IzmiTJP71SKTLoTUC
         muQOTdFxVNi0jpfmC8i8aRGrnrQB01BT3IdQpL2eAbVh1S4HV42EU/uu1O62//n5PxnJ
         KQQw==
X-Gm-Message-State: AOAM532jId0Ubjup7i8+aJGb7QrDiEHCifiOZIKCqdc2QWA2DmXwZo3P
        a/fmY5FXuIw3/k1mMY443ihRKZLqX58E
X-Google-Smtp-Source: ABdhPJw8DqlSWOZDSYtk3HzYUQDUrhkIKVQXAMPIq2tKNiuSr8cBaTwCXqaZggl1HvweWqrSm1EDwrkxlI++
X-Received: by 2002:a25:cb48:: with SMTP id b69mr1168096ybg.252.1591258624144;
 Thu, 04 Jun 2020 01:17:04 -0700 (PDT)
Date:   Thu, 04 Jun 2020 01:17:01 -0700
In-Reply-To: <CAHbLzkq84qtOqfvP5SmPoAyL+Pyffd9K3108AOYk5yKF03jBmw@mail.gmail.com>
Message-Id: <xr937dwn454y.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200601032204.124624-1-gthelen@google.com> <CAHbLzkq84qtOqfvP5SmPoAyL+Pyffd9K3108AOYk5yKF03jBmw@mail.gmail.com>
Subject: Re: [PATCH] shmem, memcg: enable memcg aware shrinker
From:   Greg Thelen <gthelen@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> wrote:

> On Sun, May 31, 2020 at 8:22 PM Greg Thelen <gthelen@google.com> wrote:
>>
>> Since v4.19 commit b0dedc49a2da ("mm/vmscan.c: iterate only over charged
>> shrinkers during memcg shrink_slab()") a memcg aware shrinker is only
>> called when the per-memcg per-node shrinker_map indicates that the
>> shrinker may have objects to release to the memcg and node.
>>
>> shmem_unused_huge_count and shmem_unused_huge_scan support the per-tmpfs
>> shrinker which advertises per memcg and numa awareness.  The shmem
>> shrinker releases memory by splitting hugepages that extend beyond
>> i_size.
>>
>> Shmem does not currently set bits in shrinker_map.  So, starting with
>> b0dedc49a2da, memcg reclaim avoids calling the shmem shrinker under
>> pressure.  This leads to undeserved memcg OOM kills.
>> Example that reliably sees memcg OOM kill in unpatched kernel:
>>   FS=/tmp/fs
>>   CONTAINER=/cgroup/memory/tmpfs_shrinker
>>   mkdir -p $FS
>>   mount -t tmpfs -o huge=always nodev $FS
>>   # Create 1000 MB container, which shouldn't suffer OOM.
>>   mkdir $CONTAINER
>>   echo 1000M > $CONTAINER/memory.limit_in_bytes
>>   echo $BASHPID >> $CONTAINER/cgroup.procs
>>   # Create 4000 files.  Ideally each file uses 4k data page + a little
>>   # metadata.  Assume 8k total per-file, 32MB (4000*8k) should easily
>>   # fit within container's 1000 MB.  But if data pages use 2MB
>>   # hugepages (due to aggressive huge=always) then files consume 8GB,
>>   # which hits memcg 1000 MB limit.
>>   for i in {1..4000}; do
>>     echo . > $FS/$i
>>   done
>
> It looks all the inodes which have tail THP beyond i_size are on one
> single list, then the shrinker actually just splits the first
> nr_to_scan inodes. But since the list is not memcg aware, so it seems
> it may split the THPs which are not charged to the victim memcg and
> the victim memcg still may suffer from pre-mature oom, right?

Correct.  shmem_unused_huge_shrink() is not memcg aware.  In response to
memcg pressure it will split the post-i_size tails of nr_to_scan tmpfs
inodes regardless of if they're charged to the under-pressure memcg.
do_shrink_slab() looks like it'll repeatedly call
shmem_unused_huge_shrink().  So it will split tails of many inodes.  So
I think it'll avoid the oom by over shrinking.  This is not ideal.  But
it seems better than undeserved oom kill.

I think the solution (as Kirill Tkhai suggested) a memcg-aware index
would solve both:
1) avoid premature oom by registering shrinker to responding to memcg
   pressure
2) avoid shrinking/splitting inodes unrelated to the under-pressure
   memcg

I can certainly look into that (thanks Kirill for the pointers).  In the
short term I'm still interested in avoiding premature OOMs with the
original thread (i.e. restore pre-4.19 behavior to shmem shrinker for
memcg pressure).  I plan to test and repost v2.
