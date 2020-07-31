Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C7721D95
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596201625;
	bh=uoVX3bcmvsWft+k3e/OzNfmAD+L1d0+lh517DnQsT3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CP/qdJ8fmJm8yT8VPhuHCB1vcamM54vqoFes7sMtA3hNKd8EnaSi6iqX24w7ZF8RR
	 B+h4kq5IXp0kCIqCpJNWGVNfTO68bO5ZnH76/mHQXMRRbj9UbCZwlkxpEKwe4ME1EC
	 AGnhiPR+GmPc/QualkOZifjKYoy4quiMbwea9FzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgGaNUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgGaNUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B268121744;
        Fri, 31 Jul 2020 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596201623;
        bh=uoVX3bcmvsWft+k3e/OzNfmAD+L1d0+lh517DnQsT3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQybmUSH4o4yjsQH3hjYptrtzYyNBgJYZX1jxcs1DCJFYTIDjSqmDX8w0ruluIazZ
         fn3x8S8I1DnNzoLKeueMDgbXg/TnEcLc/cjvj0fvHDAxixj7CJUkSs6yJ/CKkoTvT8
         Ql+71fA47Mq1Qjz4xBg7rQPn9aT9Sbt7yry84GNU=
Date:   Fri, 31 Jul 2020 15:20:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH v2] sched: Provide USF for the portable equipment.
Message-ID: <20200731132009.GA1712190@kroah.com>
References: <cover.1596196060.git.yangdongdong@xiaomi.com>
 <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:46:30PM +0800, Dongdong Yang wrote:
>  drivers/staging/Kconfig          |   2 +
>  drivers/staging/Makefile         |   1 +
>  drivers/staging/fbsched/Kconfig  |  10 ++
>  drivers/staging/fbsched/Makefile |   2 +
>  drivers/staging/fbsched/usf.c    | 346 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |   3 +
>  kernel/sched/sched.h             |  10 ++
>  7 files changed, 374 insertions(+)
>  create mode 100644 drivers/staging/fbsched/Kconfig
>  create mode 100644 drivers/staging/fbsched/Makefile
>  create mode 100644 drivers/staging/fbsched/usf.c

I asked for a TODO file, like all other staging drivers have, why did
you not include one here?

