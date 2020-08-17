Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D8F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHQMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:23:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56100 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHQMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:22:59 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7eA7-000KmM-Ae; Mon, 17 Aug 2020 06:22:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7eA6-0002af-8E; Mon, 17 Aug 2020 06:22:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     willy@casper.infradead.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
        <87k1036k9y.fsf@x220.int.ebiederm.org>
        <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
        <87blle4qze.fsf@x220.int.ebiederm.org>
        <20200620162752.GF8681@bombadil.infradead.org>
        <39e9f488-110c-588d-d977-413da3dc5dfa@oracle.com>
        <87d05r2kl3.fsf@x220.int.ebiederm.org>
        <20200622154840.GA13945@casper.infradead.org>
Date:   Mon, 17 Aug 2020 07:19:20 -0500
In-Reply-To: <20200622154840.GA13945@casper.infradead.org> (willy's message of
        "Mon, 22 Jun 2020 16:48:40 +0100")
Message-ID: <87pn7pfos7.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k7eA6-0002af-8E;;;mid=<87pn7pfos7.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199PaWcWs57yQD8GGhTzO34dIM9t6NcVmw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

willy@casper.infradead.org writes:

> On Mon, Jun 22, 2020 at 10:20:40AM -0500, Eric W. Biederman wrote:
>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>> > On 6/20/20 9:27 AM, Matthew Wilcox wrote:
>> >> On Fri, Jun 19, 2020 at 05:42:45PM -0500, Eric W. Biederman wrote:
>> >>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>> >>>> Still high lock contention. Collect the following hot path.
>> >>> A different location this time.
>> >>>
>> >>> I know of at least exit_signal and exit_notify that take thread wide
>> >>> locks, and it looks like exit_mm is another.  Those don't use the same
>> >>> locks as flushing proc.
>> >>>
>> >>>
>> >>> So I think you are simply seeing a result of the thundering herd of
>> >>> threads shutting down at once.  Given that thread shutdown is fundamentally
>> >>> a slow path there is only so much that can be done.
>> >>>
>> >>> If you are up for a project to working through this thundering herd I
>> >>> expect I can help some.  It will be a long process of cleaning up
>> >>> the entire thread exit process with an eye to performance.
>> >> Wengang had some tests which produced wall-clock values for this problem,
>> >> which I agree is more informative.
>> >>
>> >> I'm not entirely sure what the customer workload is that requires a
>> >> highly threaded workload to also shut down quickly.  To my mind, an
>> >> overall workload is normally composed of highly-threaded tasks that run
>> >> for a long time and only shut down rarely (thus performance of shutdown
>> >> is not important) and single-threaded tasks that run for a short time.
>> >
>> > The real workload is a Java application working in server-agent mode, issue
>> > happened in agent side, all it do is waiting works dispatching from server and
>> > execute. To execute one work, agent will start lots of short live threads, there
>> > could be a lot of threads exit same time if there were a lots of work to
>> > execute, the contention on the exit path caused a high %sys time which impacted
>> > other workload.
>> 
>> If I understand correctly, the Java VM is not exiting.  Just some of
>> it's threads.
>> 
>> That is a very different problem to deal with.  That are many
>> optimizations that are possible when _all_ of the threads are exiting
>> that are not possible when _many_ threads are exiting.
>
> Ah!  Now I get it.  This explains why the dput() lock contention was
> so important.  A new thread starting would block on that lock as it
> tried to create its new /proc/$pid/task/ directory.
>
> Terminating thousands of threads but not the entire process isn't going
> to hit many of the locks (eg exit_signal() and exit_mm() aren't going
> to be called).  So we need a more sophisticated micro benchmark that is
> continually starting threads and asking dozens-to-thousands of them to
> stop at the same time.  Otherwise we'll try to fix lots of scalability
> problems that our customer doesn't care about.

Has anyone come up with a more sophisticated microbenchmark or otherwise
made any progress in tracking this down farther?

Eric
