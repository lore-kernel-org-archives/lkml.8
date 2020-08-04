Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69ABC21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgHDO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:58:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55488 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:57:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vqc-00CdQ1-77; Tue, 04 Aug 2020 06:15:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vqb-0005cg-A8; Tue, 04 Aug 2020 06:15:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <20200804115649.kzea757e5wwpk4k3@wittgenstein>
Date:   Tue, 04 Aug 2020 07:11:59 -0500
In-Reply-To: <20200804115649.kzea757e5wwpk4k3@wittgenstein> (Christian
        Brauner's message of "Tue, 4 Aug 2020 13:56:49 +0200")
Message-ID: <87d046sj8w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2vqb-0005cg-A8;;;mid=<87d046sj8w.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3BFn/F3Z7azq2BHX2jvvEfVaZ9j5kYhs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
>> Every namespace type has its own counter. Some of them are
>> of refcount_t, some of them are of kref.
>> 
>> This patchset introduces generic ns_common::count for any
>> type of namespaces instead of them.
>> 
>> ---
>
> I was wondering why that series never made it to me turns out there's
> some weird bug in my (neo)mutt where it sometimes marks messages as read
> when I'm deleting completely unrelated messages. That has already cost
> me a talk slot for an event I really wanted to attend and now it seems
> to start costing me patches... I need to figure this out.
>
> Anyway, thanks for sending this. I pulled this into my tree now.

Actually why in the world should the reference count be generic?

What is the point of this patchset?

What problem does it solve.  Name spaces are not the same, and
their refcounting needs are not the same so I don't have a clue how it
helps anything to have a reference count in ns_common.

Eric
