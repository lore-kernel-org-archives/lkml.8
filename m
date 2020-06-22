Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C047C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C69206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgFVPRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:17:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgFVPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:17:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnOCV-0005Cb-Cu; Mon, 22 Jun 2020 09:17:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnOCR-0000y0-78; Mon, 22 Jun 2020 09:17:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
Date:   Mon, 22 Jun 2020 10:13:09 -0500
In-Reply-To: <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
        (Masahiro Yamada's message of "Mon, 22 Jun 2020 14:33:39 +0900")
Message-ID: <87366n3zi2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnOCR-0000y0-78;;;mid=<87366n3zi2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZgWqSSIIIXle/OLCQxkd+7UIjr08oNT0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> On Fri, Jun 19, 2020 at 11:14 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>>
>> Junxiao Bi <junxiao.bi@oracle.com> reported:
>> > When debugging some performance issue, i found that thousands of threads exit
>> > around same time could cause a severe spin lock contention on proc dentry
>> > "/proc/$parent_process_pid/task/", that's because threads needs to clean up
>> > their pid file from that dir when exit.
>>
>> Matthew Wilcox <willy@infradead.org> reported:
>> > We've looked at a few different ways of fixing this problem.
>>
>> The flushing of the proc dentries from the dcache is an optmization,
>> and is not necessary for correctness.  Eventually cache pressure will
>> cause the dentries to be freed even if no flushing happens.  Some
>> light testing when I refactored the proc flushg[1] indicated that at
>> least the memory footprint is easily measurable.
>>
>> An optimization that causes a performance problem due to a thundering
>> herd of threads is no real optimization.
>>
>> Modify the code to only flush the /proc/<tgid>/ directory when all
>> threads in a process are killed at once.  This continues to flush
>> practically everything when the process is reaped as the threads live
>> under /proc/<tgid>/task/<tid>.
>>
>> There is a rare possibility that a debugger will access /proc/<tid>/,
>> which this change will no longer flush, but I believe such accesses
>> are sufficiently rare to not be observed in practice.
>>
>> [1] 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
>> Link: https://lkml.kernel.org/r/54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com
>
>
>> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I did not report this.

Thank you for catching this.

I must have cut&pasted the wrong email address by mistake.

My apologies.

Eric
