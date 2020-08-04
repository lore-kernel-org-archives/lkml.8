Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1745C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A712086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHDNz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:55:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHDNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:55:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2xQ1-00CoGG-PV; Tue, 04 Aug 2020 07:55:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2xQ1-0005we-3Y; Tue, 04 Aug 2020 07:55:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
        <875z9ysit5.fsf@x220.int.ebiederm.org>
        <49106051-be26-7b89-f9e8-7c441dbda18a@virtuozzo.com>
Date:   Tue, 04 Aug 2020 08:52:38 -0500
In-Reply-To: <49106051-be26-7b89-f9e8-7c441dbda18a@virtuozzo.com> (Kirill
        Tkhai's message of "Tue, 4 Aug 2020 15:48:34 +0300")
Message-ID: <87sgd2o6vt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2xQ1-0005we-3Y;;;mid=<87sgd2o6vt.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DDYsCTuxeTfwrL2mTkDzmE3hz8kApqFE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/8] ns: Add common refcount into ns_common add use it as counter for net_ns
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> On 04.08.2020 15:21, Eric W. Biederman wrote:
>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>> 
>>> Currently, every type of namespaces has its own counter,
>>> which is stored in ns-specific part. Say, @net has
>>> struct net::count, @pid has struct pid_namespace::kref, etc.
>>>
>>> This patchset introduces unified counter for all types
>>> of namespaces, and converts net namespace to use it first.
>> 
>> And the other refcounts on struct net?
>> 
>> How do they play into what you are trying to do?
>
> I just don't understand you. Different refcounters are related to different
> problems, they are introduced to solve. This patchset changes only one refcounter,
> and it does not touch other of them. What do you want to know about others?
>

Why net::count not net::passive?  What problem are you trying to solve?

They both are reference counts on the network namespace.

I don't understand what you are trying to do, other than take a bunch of
things that look similar and squash them all together.

What semantics does this magical common reference count have?
Why is it better for the count to live in ns_common rather than it
it's own dedicated field of struct net?

Given that decrementing still requires code per namespace to handle
the count going to zero.  How does this benefit anyone?

Has the effect of cache line placement of the move of the reference
count been considered?

All I see in the patch in question is switching a location that the
count lives.  Which does not seem useful to me.

I am not fundamentally oppossed but I don't see the point.  At this
point it looks like you are making things harder to maintain by making
things common that are merely similar.

Eric
