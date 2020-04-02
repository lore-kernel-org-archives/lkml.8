Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A8C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A542072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="boBkZWPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbgDBPGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:06:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36303 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbgDBPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:06:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id i7so4610033edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYa3cCvl0gzc4EgAV+8fe+3EM4RpMu1aoLK0ocYUaYI=;
        b=boBkZWPUlJHdDfU35dNzrcg1AfzrDF0aVCbQp696BuwvgvyZOrArd9WMSLNww1JgBg
         +rYNv3hzZOFXzEAyPGJI8z7nlDuChH+xb0EfHMDMHFph1g5uz/xwzYu1uFKTYfH0rY7W
         y29E0JRXt77q6g8b6X0aYvhRGgcEm9Szx/7D0pi34duqvqNBh5f4rJgUs8Kb/Ixz97yh
         O6Rrb5eLhhUiJ/wMsDm0DPSO1xezPzEGb85w4Vf0H2md5OaUnYJ2x2LFQDOfYy+hTQkK
         N5e/Dej8U1qbqIsPp/zfPgJK4dKNMTRP0LH9R5J2yIyjwxvXZPPcgWvihSsXzJ1iJWvb
         8CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYa3cCvl0gzc4EgAV+8fe+3EM4RpMu1aoLK0ocYUaYI=;
        b=QugeFtsBerzF5YcpKYpYoehYyBlC9ZMHJHmt62FMmkGpco9JkjnXakO+bglR6ftslB
         BKY54Q0Od6gQs45l/4go/Q29qM8amPaGYPQdnuSE4RK+SrnUsGsNGRF6Df3P0V7Tb41h
         gWmJTIH6M1XOzi/M5GO66inUBdszl4Z0v3zF7Ba6H+msSTpcJ8vVdhSCYhO1GRvJUbR3
         1Q+QylnjY0WJ0WMgWqyKKsjM8T8ARnP8G7XdwpUcbbpRb/TLySstlxY4kHqF6HntGI3X
         mQAhjWuZHyk1vpYbs34GbMB8GVtfRxOXfPiMG6fmJa7UVpGhn67eQmkhv5Pq9MB89VYU
         DrQg==
X-Gm-Message-State: AGi0PuZSIvhzvkRRbmRxCb9szZ5UUOfNd5BXt9qfUDUgyizTX3Wp+Aoq
        uhyO6elCSL0uaNdqdnXcD3x0QZKmLCKtj27vOYlp1A==
X-Google-Smtp-Source: APiQypJQFbqhZ0gDZhzt7n/E60CAxsNY9EqEXjQuMhLkPuX5AYm0XR1q1GZ1frMSVEWbZPl3DPiCgsomgRKnVLYo+H4=
X-Received: by 2002:a50:9b53:: with SMTP id a19mr3514859edj.3.1585839966709;
 Thu, 02 Apr 2020 08:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
 <20200401225723.14164-3-pasha.tatashin@soleen.com> <8a2fbe6b-c861-9d47-9f02-72d476265359@suse.cz>
In-Reply-To: <8a2fbe6b-c861-9d47-9f02-72d476265359@suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Apr 2020 11:05:55 -0400
Message-ID: <CA+CK2bDA4YOJWr8eKff3yowVS+TS+EdsjASes43ZLRiXs2jcsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: initialize deferred pages with interrupts enabled
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> TBH I don't remember my concern anymore. Reading my mail now [1] it seems I was
> thinking the problem could happen not just in interrupt context, but with other
> kthreads as well.
> Anyway I agree with the approach of waiting for actual issues being reported and
> then eventually pre-growing more.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you.

Pasha
