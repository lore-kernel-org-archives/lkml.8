Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66053208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo+7UCzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgHTRJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgHTRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:07:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so2927587ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=bo+7UCzu3XtlLDsIdFcX5T2SOSSTsIkuEKVjv+td78vJUz4Qxj8E6pMzu0KujU0A8E
         wEY9X0HcNUH4MKDpEJcRCVekv731AB5t41ds1k6HDNgEAnDfiMuAYEd0JBMBCKkPIAls
         1ofwEbhEVneHVJ6n0purqzcbgSFawo2aR5Qj0bawUT6gizMqMxUdTu5Dax0QynHmnjhd
         hdB/1ctAxAaeD4O9/Pq7Bw19oxiBt6p7riIhI2gRNppDgxaBqie0QR49HWNaHkfr4pZR
         PmOswhZhm3v8rhV4eoYr9SX2GbowE+xyG+XqtRWsKplLcBdxMd2TZogrYKHaEzvA8E9/
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=hOpgN2UVWBT4yB6o+2sN2mpFnlhWKTHMCWxiK12wKoxxFBoOsRorxacv1A7boPXHFt
         TziaKmhUmbd3dqUMldo+xcPcte5CpyXCNgqq4BM5M8FzBYN9v49eQNswq5s7YB4oRYQI
         uiG5M87hLweqky8p8q/2f/+SbDNq+ZwWyEUlhZBDGOA+e5XDAcIcm0S+G+QxpLI77PlF
         HeR2FMojmw3cPrsdPSCKYI5GMB88u5zy26jVdyxiQ8QnV12jojcl4U3xjtvH1DVxhkZz
         Z/5F5aHv9s97cJgAtRz4mxhiBZCvI8/QYyTJ6SpTXgKd9zkQGqrez32tOOS9hZ5yIWCz
         FWMQ==
X-Gm-Message-State: AOAM533fS69aoo4CUK2fPgSU7G6oDkYllWrYOXDgDFr0iQFC7/DuMzBu
        n+EEJd8sYxul11WMZJkSdg2FtaPKwehXm2iCUIKO7Q==
X-Google-Smtp-Source: ABdhPJziUJGXBSB9o6ksa6wt3btAspt3JpWrpRS8ydIXvVTIxvdXw64pBpOlKiXdI5HRmfJyA09t5CJD1wgjuiuMX0o=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr2214071ljh.446.1597943215596;
 Thu, 20 Aug 2020 10:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 10:06:44 -0700
Message-ID: <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> Much of the discussion about this has died down. There's been a
> concern raised that we could generalize infrastructure across loop,
> md, etc. This may be possible, in the future, but it isn't clear to me
> how this would look like. I'm inclined to fix the existing issue with
> loop devices now (this is a problem we hit at FB) and address
> consolidation with other cases if and when those need to be addressed.
>

What's the status of this series?
