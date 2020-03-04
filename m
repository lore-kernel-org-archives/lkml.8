Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0651C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9912E21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583341915;
	bh=qYo4zL0bCFlNPm4vxUukmiyhsb7rAmtPrAf1sy4coTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KyffuAfQVz/x+cXWZZjvq3xWZTyzPnKgUQn5h0z0GPykVJvHFiHVAsDW4QYD7Nz2q
	 RTCrfJfBLOJUOxsG38xPqB8vZb8QjWROUF7Pqe7ij4zQxkJ2ppv1naucdW3rpkFCL2
	 fMQi3c6itHkmGakeumdjRqkeHYmE7p6FM4Ad2GBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgCDRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:11:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35806 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:11:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id v15so1935618qto.2;
        Wed, 04 Mar 2020 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kXZ0XxGADAwquLAqrLAfH2eX2Yk3KDxs3aXRaRLxHiQ=;
        b=Zcf1qSNLsGzt1D3Kh6rbWI9JNilJKbWhmur0D8f7GwPUGk2AYjV6rqQPsKmTcadRFe
         TcgN1Yo3crTqWatWOycV0xuUwIPUoO3k0J6bryztcx20U6PXcTSUqWoSDwSrm9FM9aHL
         C+W5ZOH0opIuw3Pf3gJKBSIGDDYyOImxVKXI4Z60ZWzeWA5QA6yKhNkbXyDk3QCAnxeG
         E8bQEje+fzjnQeweLh2kqldp2qUKQZyCf3Dmk530rWM5Ucs7lWPq5Q3hKmTDIfpDGjGQ
         cp3JXAOPh8HdA3RyEIbIoxcIlBIAQ0DTJcUUjMaBinz+tQD3y32+lCQX0OgHRJNzIzwM
         i14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kXZ0XxGADAwquLAqrLAfH2eX2Yk3KDxs3aXRaRLxHiQ=;
        b=MRUafnLgW+NVs8YsG5nwwliYpY9ugDvfFuwLsEqrl3fMWhfen5DUsdRQFbbGf2NVfV
         xtQMnTDzf9Tf8ekBk9fkl+rLYqFeHpv7bbeZgk769DbGHQ4jIXkVjhaxsPUWiDGBZa5i
         s1s1Y7IPjGpJTQXJsCxXYYHaEAlLFDkUPi8ZfQgZd/gOjIz6dHJ4vxBOqSumV4/tE9Db
         qoflsRh774BUvUc0Jx7H+r7Hv0lqkVo7fRfflLs3+BIXjV0VO/rwIRkOy6gBOlM5rHOI
         9oaoNsDkRIUTu4feAv3XU6dWcZc2l34XUvyyiKCvfFc6EHYfSVlvr3aY9SCgpKjtpowo
         yPpA==
X-Gm-Message-State: ANhLgQ3UZl9Z+TR489OLk9fTd1EsSpCrT0cXoLh9yZ/TQvD5iX6iUi0G
        mYwjVyoYHt5AwYIa3FHaw/k=
X-Google-Smtp-Source: ADFU+vteSVP2OcxEUxrEg2NA9r5+iSxM6GbWg5UxV+DXmWBjg5zVOar4jes1WUOfF75+m6eY670r+g==
X-Received: by 2002:ac8:7101:: with SMTP id z1mr3134585qto.333.1583341912740;
        Wed, 04 Mar 2020 09:11:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id w48sm15237595qtc.40.2020.03.04.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:11:52 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:11:51 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched/cpuset: distribute tasks within affinity masks
Message-ID: <20200304171151.GL189690@mtj.thefacebook.com>
References: <20200228010134.42866-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228010134.42866-1-joshdon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:01:34PM -0800, Josh Don wrote:
> From: Paul Turner <pjt@google.com>
> 
> Currently, when updating the affinity of tasks via either cpusets.cpus,
> or, sched_setaffinity(); tasks not currently running within the newly
> specified CPU will be arbitrarily assigned to the first CPU within the
> mask.
> 
> This (particularly in the case that we are restricting masks) can
> result in many tasks being assigned to the first CPUs of their new
> masks.
> 
> This:
>  1) Can induce scheduling delays while the load-balancer has a chance to
>     spread them between their new CPUs.
>  2) Can antogonize a poor load-balancer behavior where it has a
>     difficult time recognizing that a cross-socket imbalance has been
>     forced by an affinity mask.
> 
> With this change, tasks are distributed ~evenly across the new mask.  We
> may intentionally move tasks already running on a CPU within the mask to
> avoid edge cases in which a CPU is already overloaded (or would be
> assigned to more times than is desired).
> 
> We specifically apply this behavior to the following cases:
> - modifying cpuset.cpus
> - when tasks join a cpuset
> - when modifying a task's affinity via sched_setaffinity(2)

Looks fine to me. Peter, what do you think?

Thanks.

-- 
tejun
