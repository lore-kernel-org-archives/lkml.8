Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034682067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uvvg4akv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFEAqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:46:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbgFEAqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591317996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qN6FayC+qA0+96UlgWwhkCkAADNK7Ccaqf13OR7p4ao=;
        b=Uvvg4akvlAYlIzO2D2gAThURmX5rCgXhVlgXH/ND6NBb5Ruvc4Irto/06g3GhM+BrNOyC/
        MTvKT/cCXk47XeyRPhNdGD5ntXJCS2UD2CbX1BSS6qEI6JDU4c/vlHQngAWH3u2uOxhXvi
        1vHZz/K1DIQbKa8PDCP2LzNEbFG8hJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-64GWhhW_M9apNEvChjZi1Q-1; Thu, 04 Jun 2020 20:46:28 -0400
X-MC-Unique: 64GWhhW_M9apNEvChjZi1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD567800C78;
        Fri,  5 Jun 2020 00:46:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-13.rdu2.redhat.com [10.10.114.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACEE35D9D3;
        Fri,  5 Jun 2020 00:46:23 +0000 (UTC)
Subject: Re: [PATCH v2] xfs: Fix false positive lockdep warning with
 sb_internal & fs_reclaim
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Eric Sandeen <sandeen@redhat.com>
References: <20200604210130.697-1-longman@redhat.com>
 <20200604231327.GV2040@dread.disaster.area>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cd66acb9-2129-2a21-936c-9cce3d9dba4e@redhat.com>
Date:   Thu, 4 Jun 2020 20:46:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200604231327.GV2040@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 7:13 PM, Dave Chinner wrote:
> On Thu, Jun 04, 2020 at 05:01:30PM -0400, Waiman Long wrote:
>> ---
>>   fs/xfs/xfs_log.c   | 3 ++-
>>   fs/xfs/xfs_trans.c | 8 +++++++-
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
>> index 00fda2e8e738..d273d4e74ef8 100644
>> --- a/fs/xfs/xfs_log.c
>> +++ b/fs/xfs/xfs_log.c
>> @@ -433,7 +433,8 @@ xfs_log_reserve(
>>   	XFS_STATS_INC(mp, xs_try_logspace);
>>   
>>   	ASSERT(*ticp == NULL);
>> -	tic = xlog_ticket_alloc(log, unit_bytes, cnt, client, permanent, 0);
>> +	tic = xlog_ticket_alloc(log, unit_bytes, cnt, client, permanent,
>> +			mp->m_super->s_writers.frozen ? KM_NOLOCKDEP : 0);
>>   	*ticp = tic;
> Hi Waiman,
>
> As I originally stated when you posted this the first time 6 months
> ago: we are not going to spread this sort of conditional gunk though
> the XFS codebase just to shut up lockdep false positives.
>
> I pointed you at the way to conditionally turn of lockdep for
> operations where we are doing transactions when the filesystem has
> already frozen the transaction subsystem. That is:
>
>>   
>>   	xlog_grant_push_ail(log, tic->t_cnt ? tic->t_unit_res * tic->t_cnt
>> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
>> index 3c94e5ff4316..3a9f394a0f02 100644
>> --- a/fs/xfs/xfs_trans.c
>> +++ b/fs/xfs/xfs_trans.c
>> @@ -261,8 +261,14 @@ xfs_trans_alloc(
>>   	 * Allocate the handle before we do our freeze accounting and setting up
>>   	 * GFP_NOFS allocation context so that we avoid lockdep false positives
>>   	 * by doing GFP_KERNEL allocations inside sb_start_intwrite().
>> +	 *
>> +	 * To prevent false positive lockdep warning of circular locking
>> +	 * dependency between sb_internal and fs_reclaim, disable the
>> +	 * acquisition of the fs_reclaim pseudo-lock when the superblock
>> +	 * has been frozen or in the process of being frozen.
>>   	 */
>> -	tp = kmem_zone_zalloc(xfs_trans_zone, 0);
>> +	tp = kmem_zone_zalloc(xfs_trans_zone,
>> +		mp->m_super->s_writers.frozen ? KM_NOLOCKDEP : 0);
>>   	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
> We only should be setting KM_NOLOCKDEP when XFS_TRANS_NO_WRITECOUNT
> is set.  That's the flag that transactions set when they run in a
> fully frozen context to avoid deadlocking with the freeze in
> progress, and that's the only case where we should be turning off
> lockdep.
>
> And, as I also mentioned, this should be done via a process flag -
> PF_MEMALLOC_NOLOCKDEP - so that it is automatically inherited by
> all subsequent memory allocations done in this path. That way we
> only need this wrapping code in xfs_trans_alloc():
>
> 	if (flags & XFS_TRANS_NO_WRITECOUNT)
> 		memalloc_nolockdep_save()
>
> 	.....
>
> 	if (flags & XFS_TRANS_NO_WRITECOUNT)
> 		memalloc_nolockdep_restore()
>
> and nothing else needs to change.
>
> Cheers,
>
> Dave.

Thanks for the reminder, I will look into that.

Cheers,
Longman

