Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9254F2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpMzciTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgFRBgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:36:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732455AbgFRBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592444171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gejkrN5Zp7w7zKRAqkoNukEDEUYMInBLOaoxRpvDba8=;
        b=MpMzciTs9U9XF5QcGAnYsCjPYSidVx61uSfrNm+txTlXcnJ9e2IPpaWOl0ywOcGcqFeNd8
        vBwpd9gbcabtQTfQxGeJvFM2+RahFpfzh9bhRbPO7vaHyklAwN/u0Hb1b+aZtxhlsctKam
        fA2sSZbxL88wavsHjUElqQdrQB2BVt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-yic8CQtKNKWzf_I-QLQlpg-1; Wed, 17 Jun 2020 21:36:09 -0400
X-MC-Unique: yic8CQtKNKWzf_I-QLQlpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0A91800D42;
        Thu, 18 Jun 2020 01:36:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-167.rdu2.redhat.com [10.10.117.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7C51100164C;
        Thu, 18 Jun 2020 01:35:59 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] xfs: Fix false positive lockdep warning with
 sb_internal & fs_reclaim
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Eric Sandeen <sandeen@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200617175310.20912-1-longman@redhat.com>
 <20200617175310.20912-3-longman@redhat.com>
 <20200618004505.GG2005@dread.disaster.area>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <45b32195-3ed8-0242-68a2-10a1b6d29fe6@redhat.com>
Date:   Wed, 17 Jun 2020 21:35:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200618004505.GG2005@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 8:45 PM, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 01:53:10PM -0400, Waiman Long wrote:
>>   fs/xfs/xfs_log.c   |  9 +++++++++
>>   fs/xfs/xfs_trans.c | 31 +++++++++++++++++++++++++++----
>>   2 files changed, 36 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
>> index 00fda2e8e738..33244680d0d4 100644
>> --- a/fs/xfs/xfs_log.c
>> +++ b/fs/xfs/xfs_log.c
>> @@ -830,8 +830,17 @@ xlog_unmount_write(
>>   	xfs_lsn_t		lsn;
>>   	uint			flags = XLOG_UNMOUNT_TRANS;
>>   	int			error;
>> +	unsigned long		pflags;
>>   
>> +	/*
>> +	 * xfs_log_reserve() allocates memory. This can lead to fs reclaim
>> +	 * which may conflicts with the unmount process. To avoid that,
>> +	 * disable fs reclaim for this allocation.
>> +	 */
>> +	current_set_flags_nested(&pflags, PF_MEMALLOC_NOFS);
>>   	error = xfs_log_reserve(mp, 600, 1, &tic, XFS_LOG, 0);
>> +	current_restore_flags_nested(&pflags, PF_MEMALLOC_NOFS);
>> +
>>   	if (error)
>>   		goto out_err;
> The more I look at this, the more I think Darrick is right and I
> somewhat misinterpretted what he meant by "the top of the freeze
> path".
>
> i.e. setting PF_MEMALLOC_NOFS here is out of place - only one caller
> of xlog_unmount_write requires PF_MEMALLOC_NOFS
> context. That context should be set in the caller that requires this
> context, and in this case it is xfs_fs_freeze(). This is top of the
> final freeze state processing (what I think Darrick meant), not the
> top of the freeze syscall call chain (what I thought he meant).
>
> So if set PF_MEMALLOC_NOFS setting in xfs_fs_freeze(), it covers all
> the allocations in this problematic path, and it should obliviates
> the need for the first patch in the series altogether.
>
OK, I will try that and run my test. If it pass, I will post a new patch 
with the suggested change.

Thanks,
Longman

