Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E97C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994822065C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597424479;
	bh=32dsAfPl6aOK5JToUz3GssUw76AqOJ4D3MzB5L6Fd+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J4ZSIWY3Y9kzuQrNGY2nKixoGRLhBX2saQXOyKhyWp+NN3s+x9Z3ZcjV3XYGs3JA8
	 DvhfOsYZiGTZj7BQDY4gJItszetY19dCa98jr2P/wZoLceI4ZfXUAaOIpGy24wd3wA
	 qLKA+/HVF3ra2/vcU+H7dx/Cul+ewAVlFlkKqXtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHNRBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:01:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D39C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:01:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so5169985lfs.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nizDAhVzGoyUTNelDQzkgPTXNiaz1M5pIsGVkewPp+Q=;
        b=WnoM8GbslOnVvT6dmQv2qeyabfGpLfkl3M+87saW+EFeN+qxqIaHQ2TT2BoepFPmJC
         L6PB+4TIG3L6SyzX2Guv0S6tYvwT+0t23wuFqmAbNPoScZ01R9z4a2gF9KXvJKxkUhC5
         p0On3StYRnYmr0oLkA8Xxxn/+1bZBxePS8Shc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nizDAhVzGoyUTNelDQzkgPTXNiaz1M5pIsGVkewPp+Q=;
        b=EjQSEkp4U7ia1YYB6NpM2QaEbti4WKYsnzyRLAo6b/R/Wd5s/eImeWrOKWjUi3pABH
         zJT2DX4ADQ50NwINSs8aZd7jtio8d73x9rhezlIQGNOvyYsgF2MqZjh8AcmMB6wzznnd
         hLsN7Vx6ITFXKFBcRuWmmrYrbSuSvAQqG1g9YPGb5z0ciPzrJdC6CTC265Z/hUb/oJLu
         QGH76CvLi/aIwzYu0OnyOs5wL9aaZEZ/41iehMVQ0LXtgmJihkxMGvu+UFz9gdXevFoa
         9RrOfSiVSlLNRJ+atiYDbC7TzW0vJ7CZbTO8/dck2cP+uqg3mipCHqyedKEQQSxPFkDc
         gxxw==
X-Gm-Message-State: AOAM531FZkSc+tXY89UQSrjvrWYl3F1oXxOBV6laJtQdOllL+gIV7DHL
        jxwAgW7CCAc6BOvR4k8kGfIMEHrSX3A/Fw==
X-Google-Smtp-Source: ABdhPJzwgemHan/oMwds7GSQLf93skgf7ZyDkPlWYdHuxFZBwF0ct/EiU0+X4Br7YAfHj/B9KW6NyQ==
X-Received: by 2002:a05:6512:1048:: with SMTP id c8mr1627402lfb.101.1597424462879;
        Fri, 14 Aug 2020 10:01:02 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t205sm1995720lff.8.2020.08.14.10.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:01:01 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v9so10669230ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:01:01 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr1801662ljf.285.1597424460838;
 Fri, 14 Aug 2020 10:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200814141327.GJ7488@shao2-debian>
In-Reply-To: <20200814141327.GJ7488@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 10:00:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8oc=wCvqcMdpKM8cceEYmicpf++rNDWC_5A6qYDP9QQ@mail.gmail.com>
Message-ID: <CAHk-=wj8oc=wCvqcMdpKM8cceEYmicpf++rNDWC_5A6qYDP9QQ@mail.gmail.com>
Subject: Re: [mm] 3e38e0aaca: WARNING:at_mm/memcontrol.c:#mem_cgroup_alloc
To:     kernel test robot <lkp@intel.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:14 AM kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 3e38e0aaca9eafb12b1c4b731d1c10975cbe7974 ("mm: memcg: charge memcg percpu memory to the parent cgroup")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

This should have already been fixed by commit 9f457179244a ("mm:
memcontrol: fix warning when allocating the root cgroup").

But I forget what the syntax is to report that to the kernel test
robot. Would it be possible for lkp automatically look for "Fixes:"
tags, perhaps?

                 Linus
