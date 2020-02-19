Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7756DC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9FA24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="odCt4KGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:08:42 -0500
Received: from mail.efficios.com ([167.114.26.124]:41672 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:08:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E5651249A6C;
        Wed, 19 Feb 2020 11:08:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mqm3EyzAw8q0; Wed, 19 Feb 2020 11:08:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9CFC0249D3F;
        Wed, 19 Feb 2020 11:08:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9CFC0249D3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582128519;
        bh=gm+uOkF6FbD5Qx6WLJ5PceGGH4S/trnMWToBF+XAeXA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=odCt4KGKzyE+ngKubwyUTKzgWkT5ju+1dJp+LvC9suDjrI4reZ+FKogUt8lcXNCgQ
         YBEK4v2sUbtJoVPaqf6PjRyfiepGY3AoITCkGUn/auLvZpBfmpFHwR1JfL1wNvZvCK
         E4XvGKdp9dlZ4shVssFRIEYiuYeAWKeOcFUKIbLCnELvx4LTXxPHjMDUsQVw3boeBf
         xIU9umdFguRhs3BY0upjrKFnd4yNlbMD8Up9rBChsPyzPEMWTzCYvINCVy00eBtT8+
         XTkdMFs7FqFU67y8WHOogfSCv+BosoWRmRocXhiNAXrIpQdF9A2qoHKjoYoXdmQePt
         MAShvnTfvhR4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GRYadLaTM8rb; Wed, 19 Feb 2020 11:08:39 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 908B2249D3B;
        Wed, 19 Feb 2020 11:08:39 -0500 (EST)
Date:   Wed, 19 Feb 2020 11:08:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200219155202.GE698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com> <20200219151922.GB698990@mtj.thefacebook.com> <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com> <20200219154740.GD698990@mtj.thefacebook.com> <59426509.702.1582127435733.JavaMail.zimbra@efficios.com> <20200219155202.GE698990@mtj.thefacebook.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: B54bRcUcopY8FSuDtFuH9/RXMk4Dbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 19, 2020, at 10:52 AM, Tejun Heo tj@kernel.org wrote:

> On Wed, Feb 19, 2020 at 10:50:35AM -0500, Mathieu Desnoyers wrote:
>> I can look into figuring out the commit introducing this issue, which I
>> suspect will be close to the introduction of CONFIG_CPUSET into the
>> kernel (which was ages ago). I'll check and let you know.
> 
> Oh, yeah, I'm pretty sure it goes way back. I don't think tracking
> that down would be necessary. I was just wondering whether it was a
> recent change because you said it was a regression.

It's most likely not a recent regression, but it has unfortunate effects
on the affinity mask which directly affects my ongoing work on the
pin_on_cpu() system call [1].

The sched_setaffinity vs cpu hotplug semantic provided by CONFIG_CPUSET=n
if fine for the needs on pin_on_cpu(): when a CPU comes back online,
those reappear in the affinity mask, but it is not the case with
CONFIG_CPUSET=y.

I wonder if applying the online cpu masks to the per-thread affinity mask
is the correct approach ? I suspect what we may be looking for here is to keep
the affinity mask independent of cpu hotplug, and look-up both the per-thread
affinity mask and the online cpu mask whenever the scheduler needs to perform
"is_cpu_allowed()" to check task placement.

Then whenever sched_getaffinity or cpusets try to query the current set of
cpus on which a task can run right now, it could also look at both the task's
affinity mask and the online cpu mask.

Thanks,

Mathieu

[1] https://lore.kernel.org/r/20200121160312.26545-1-mathieu.desnoyers@efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
