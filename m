Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80761C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9722071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDGyHtK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCOCVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:21:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbgCOCVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584238900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9DfqLtk0vDlWXaqjECLFoszpiCzG9j/FOTAi7CnS+c=;
        b=fDGyHtK7enDJDvPehgmvBgCbrRF5XhCZdcyVCb/oaa14YO7uygbVh9ytx6NISl7bmLFlEC
        bxK3h/L+11kVwEBdCOWRGBHfvDZ8t2SEpQRJfPBV2hjiNCPtAwfS32MVsPlFovoOR6y7ht
        6sTRmopIFT/BJXR9jv1WitNOTKGr0OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-wbA9qoJkNsOr7xpdYyYqLw-1; Sat, 14 Mar 2020 14:20:56 -0400
X-MC-Unique: wbA9qoJkNsOr7xpdYyYqLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5BE113EA;
        Sat, 14 Mar 2020 18:20:54 +0000 (UTC)
Received: from localhost (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A5B19C69;
        Sat, 14 Mar 2020 18:20:53 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -next] hugetlb_cgroup: fix illegal access to memory
References: <20200313223920.124230-1-almasrymina@google.com>
        <CAHS8izMcLx93DJtr0kyDz_qm_bNV-EOzKnPGrpQoopBHyJg9=g@mail.gmail.com>
Date:   Sat, 14 Mar 2020 19:20:52 +0100
In-Reply-To: <CAHS8izMcLx93DJtr0kyDz_qm_bNV-EOzKnPGrpQoopBHyJg9=g@mail.gmail.com>
        (Mina Almasry's message of "Fri, 13 Mar 2020 15:48:36 -0700")
Message-ID: <87zhcin6gr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> On Fri, Mar 13, 2020 at 3:39 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> This appears to be a mistake in commit faced7e0806cf ("mm: hugetlb
>> controller for cgroups v2"). Essentially that commit does
>> a hugetlb_cgroup_from_counter assuming that page_counter_try_charge has
>> initialized counter, but if page_counter_try_charge has failed then it
>> seems it does not initialize counter, so
>> hugetlb_cgroup_from_counter(counter) ends up pointing to random memory,
>> causing kasan to complain.
>>
>> Solution, simply use h_cg, instead of
>> hugetlb_cgroup_from_counter(counter), since that is a reference to the
>> hugetlb_cgroup anyway. After this change kasan ceases to complain.
>>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> Reported-by: syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com
>> Fixes: commit faced7e0806cf ("mm: hugetlb controller for cgroups v2")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: mike.kravetz@oracle.com
>> Cc: rientjes@google.com
>>
>> ---
>>  mm/hugetlb_cgroup.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index 7994eb8a2a0b4..aabf65d4d91ba 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -259,8 +259,7 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>>                     __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
>>                     nr_pages, &counter)) {
>>                 ret = -ENOMEM;
>> -               hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
>> -                             HUGETLB_MAX);
>> +               hugetlb_event(h_cg, idx, HUGETLB_MAX);
>>                 css_put(&h_cg->css);
>>                 goto done;
>>         }
>> --
>> 2.25.1.481.gfbce0eb801-goog

Acked-by: Giuseppe Scrivano <gscrivan@redhat.com>

Thanks,
Giuseppe

