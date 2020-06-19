Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73C3221F2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgFSWrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:47:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34580 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgFSWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:47:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmPmr-0003up-6O; Fri, 19 Jun 2020 16:47:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmPmq-0003DD-3a; Fri, 19 Jun 2020 16:47:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
        <87k1036k9y.fsf@x220.int.ebiederm.org>
        <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
Date:   Fri, 19 Jun 2020 17:42:45 -0500
In-Reply-To: <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com> (Junxiao Bi's
        message of "Fri, 19 Jun 2020 14:56:58 -0700")
Message-ID: <87blle4qze.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmPmq-0003DD-3a;;;mid=<87blle4qze.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/f9FJF3b8ZpMntMwzOY/uCE50xMD8xT64=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:

> On 6/19/20 10:24 AM, ebiederm@xmission.com wrote:
>
>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>>
>>> Hi Eric,
>>>
>>> The patch didn't improve lock contention.
>> Which raises the question where is the lock contention coming from.
>>
>> Especially with my first variant.  Only the last thread to be reaped
>> would free up anything in the cache.
>>
>> Can you comment out the call to proc_flush_pid entirely?
>
> Still high lock contention. Collect the following hot path.

A different location this time.

I know of at least exit_signal and exit_notify that take thread wide
locks, and it looks like exit_mm is another.  Those don't use the same
locks as flushing proc.


So I think you are simply seeing a result of the thundering herd of
threads shutting down at once.  Given that thread shutdown is fundamentally
a slow path there is only so much that can be done.

If you are up for a project to working through this thundering herd I
expect I can help some.  It will be a long process of cleaning up
the entire thread exit process with an eye to performance.

To make incremental progress we are going to need a way to understand
the impact of various changes.  Such as my change to reduce the dentry
lock contention when a process is removed from proc.  I have the feeling
that made a real world improvement on your test (as the lock no longer
shows up in your profile). Unfortunately whatever that improvement was
it was not relfected in now you read your numbers.

Eric
