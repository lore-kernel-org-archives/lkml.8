Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10450C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E347D2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2+fVb9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHSIOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:14:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31075 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgHSIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597824859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwngKvWWwMw9NOqOeW4sapwtCnNBwWN8oyQLQyDidWE=;
        b=J2+fVb9ipslVdnOqw1Fow/e+ZemD0xWiAogrlfHdDi6lYUbiwNfs1C1DeE0bQE4KPdHKVK
        bIHCLV3rugmZm6cUbqNCjyFZzGo4CYxt9Yc6pssSCNNrSsmrsQjp2+K2zW3NVktmyr6+Ya
        2DT0tkSyRxz+xU6mcjNJwn5yvE+b/Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-pm1-b9fWNfGEzD5MupzoHg-1; Wed, 19 Aug 2020 04:14:16 -0400
X-MC-Unique: pm1-b9fWNfGEzD5MupzoHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E587E85C70A;
        Wed, 19 Aug 2020 08:14:14 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BE777DFDD;
        Wed, 19 Aug 2020 08:14:12 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Xu Wang <vulab@iscas.ac.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
        <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
Date:   Wed, 19 Aug 2020 10:14:11 +0200
In-Reply-To: <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
        (Andrew Morton's message of "Tue, 18 Aug 2020 18:40:36 -0700")
Message-ID: <87eeo32gto.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 18 Aug 2020 06:43:33 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:
>
>> Replace a comma between expression statements by a semicolon.
>> 
>> ...
>>
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -655,7 +655,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
>>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>>  	cft->seq_show = hugetlb_events_show;
>> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
>> +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
>>  	cft->flags = CFTYPE_NOT_ON_ROOT;
>>  
>>  	/* Add the events.local file */
>> @@ -664,7 +664,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>>  	cft->seq_show = hugetlb_events_local_show;
>>  	cft->file_offset = offsetof(struct hugetlb_cgroup,
>> -				    events_local_file[idx]),
>> +				    events_local_file[idx]);
>>  	cft->flags = CFTYPE_NOT_ON_ROOT;
>>  
>>  	/* NULL terminate the last cft */
>
> Fixes: faced7e0806cf4 ("mm: hugetlb controller for cgroups v2")

Xu, thanks for spotting it.  Was this code causing any issue or have you
found by inspecting it?

> Wow, why does this code even work.  Presumably the initial value of
> cft->file_offset simply doesn't matter.  Giuseppe, could you please
> check?  We might have some unneeded code in there.

I think in this case having two expressions as part of the same
statement is equivalent to having two separate statements.  Both
cft->file_offset and cft->flags get the expected value.

Regards,
Giuseppe

