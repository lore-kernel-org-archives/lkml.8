Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4A0206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mU+RVNgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgFAVss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgFAVsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:48:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D47C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:48:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so14197942ybn.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L6HcYQlG38MHcLNJDdcGJa98KbxQ65bOlzMXwQl4Ols=;
        b=mU+RVNgo6wcNw9/pk95S1rAM+kKpTHvgEz3LqCLf8uAS0F8+VLGxpIjO4qcHKnnBRC
         wbVteTuoCZU8x3SiK05yAPFsk70j0SjJ5OdgAZhxvs/iOOYfykauZwfHvrjLCAYbYHhZ
         KOr9jd2Qdxslxt18qo+ikPrhnldO0BZbZ8I/XewhBjOC5VJerfQ+228LwV1zlL+6fopF
         tUoferDuqDJpn2suBCF5lQhiHj8LF9Jg+2Egaza7hc5OFm4W/+59pqw4s7KgWzOd6QDp
         T8SHvdKGEzfUqX96+xl679afK/i5vZ/An/1bwCHKtS7k9nvC14Ye7W6Ej+dP1WDWz+uE
         vdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L6HcYQlG38MHcLNJDdcGJa98KbxQ65bOlzMXwQl4Ols=;
        b=El6fkLGije5JyQE9okjOBL80j02XVv2UYNdl5oYV6jHRsUompmZQRpx0PMbZ01bebC
         eI/YPRjayRq9hQm9PBOxbdfmRX6mPj1wnZN0AtduFRatWUFFESc1MYLkCc9nL0uTehKO
         k26VhDd1+Y24nvqfsnZzR+Ic6eneYOacXroy9xUtyYARS+kUT7DeOelLQoczbq2AgRaY
         aFl0bR7vHNbEf/HtL3GNevNrndPKPzi+mg0kJIDzbcoBX2/Y8L4VkwQMhrszixpzlKMA
         NvD76lRHFB10xdUsgKZkFmXqKe5APw5hyks8NLHwxfoZWllXdms+xvsU1nNAIqgJKq/j
         2vAA==
X-Gm-Message-State: AOAM531Xz+iU88VjHMmhhWZN9ZVwlfUuF8LN17+PWQp05pEEbYR3Piju
        5k748w2LieUff1G9QlS/wbukWGYwPLwK
X-Google-Smtp-Source: ABdhPJyKIQ7UhVtqxnog/5Pp9HP0Wqui5N/adkocDsMHphgdCRx19rsOUDwSDK8gHYT9gZfV7M8/Kr/osL7/
X-Received: by 2002:a25:885:: with SMTP id 127mr39408333ybi.118.1591048126707;
 Mon, 01 Jun 2020 14:48:46 -0700 (PDT)
Date:   Mon, 01 Jun 2020 14:48:43 -0700
In-Reply-To: <ffdff0be-f2b6-c7c0-debc-9c5e8a33ae4e@virtuozzo.com>
Message-Id: <xr93d06i4fus.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200601032204.124624-1-gthelen@google.com> <ffdff0be-f2b6-c7c0-debc-9c5e8a33ae4e@virtuozzo.com>
Subject: Re: [PATCH] shmem, memcg: enable memcg aware shrinker
From:   Greg Thelen <gthelen@google.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Hi, Greg,
>
> good finding. See comments below.
>
> On 01.06.2020 06:22, Greg Thelen wrote:
>> Since v4.19 commit b0dedc49a2da ("mm/vmscan.c: iterate only over charged
>> shrinkers during memcg shrink_slab()") a memcg aware shrinker is only
>> called when the per-memcg per-node shrinker_map indicates that the
>> shrinker may have objects to release to the memcg and node.
>> 
>> shmem_unused_huge_count and shmem_unused_huge_scan support the per-tmpfs
>> shrinker which advertises per memcg and numa awareness.  The shmem
>> shrinker releases memory by splitting hugepages that extend beyond
>> i_size.
>> 
>> Shmem does not currently set bits in shrinker_map.  So, starting with
>> b0dedc49a2da, memcg reclaim avoids calling the shmem shrinker under
>> pressure.  This leads to undeserved memcg OOM kills.
>> Example that reliably sees memcg OOM kill in unpatched kernel:
>>   FS=/tmp/fs
>>   CONTAINER=/cgroup/memory/tmpfs_shrinker
>>   mkdir -p $FS
>>   mount -t tmpfs -o huge=always nodev $FS
>>   # Create 1000 MB container, which shouldn't suffer OOM.
>>   mkdir $CONTAINER
>>   echo 1000M > $CONTAINER/memory.limit_in_bytes
>>   echo $BASHPID >> $CONTAINER/cgroup.procs
>>   # Create 4000 files.  Ideally each file uses 4k data page + a little
>>   # metadata.  Assume 8k total per-file, 32MB (4000*8k) should easily
>>   # fit within container's 1000 MB.  But if data pages use 2MB
>>   # hugepages (due to aggressive huge=always) then files consume 8GB,
>>   # which hits memcg 1000 MB limit.
>>   for i in {1..4000}; do
>>     echo . > $FS/$i
>>   done
>> 
>> v5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg
>> aware") maintains the per-node per-memcg shrinker bitmap for THP
>> shrinker.  But there's no such logic in shmem.  Make shmem set the
>> per-memcg per-node shrinker bits when it modifies inodes to have
>> shrinkable pages.
>> 
>> Fixes: b0dedc49a2da ("mm/vmscan.c: iterate only over charged shrinkers during memcg shrink_slab()")
>> Cc: <stable@vger.kernel.org> # 4.19+
>> Signed-off-by: Greg Thelen <gthelen@google.com>
>> ---
>>  mm/shmem.c | 61 +++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 35 insertions(+), 26 deletions(-)
>> 
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index bd8840082c94..e11090f78cb5 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1002,6 +1002,33 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Expose inode and optional page to shrinker as having a possibly splittable
>> + * hugepage that reaches beyond i_size.
>> + */
>> +static void shmem_shrinker_add(struct shmem_sb_info *sbinfo,
>> +			       struct inode *inode, struct page *page)
>> +{
>> +	struct shmem_inode_info *info = SHMEM_I(inode);
>> +
>> +	spin_lock(&sbinfo->shrinklist_lock);
>> +	/*
>> +	 * _careful to defend against unlocked access to ->shrink_list in
>> +	 * shmem_unused_huge_shrink()
>> +	 */
>> +	if (list_empty_careful(&info->shrinklist)) {
>> +		list_add_tail(&info->shrinklist, &sbinfo->shrinklist);
>> +		sbinfo->shrinklist_len++;
>> +	}
>> +	spin_unlock(&sbinfo->shrinklist_lock);
>> +
>> +#ifdef CONFIG_MEMCG
>> +	if (page && PageTransHuge(page))
>> +		memcg_set_shrinker_bit(page->mem_cgroup, page_to_nid(page),
>> +				       inode->i_sb->s_shrink.id);
>> +#endif
>> +}
>> +
>>  static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
>>  {
>>  	struct inode *inode = d_inode(dentry);
>> @@ -1048,17 +1075,13 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
>>  			 * to shrink under memory pressure.
>>  			 */
>>  			if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>> -				spin_lock(&sbinfo->shrinklist_lock);
>> -				/*
>> -				 * _careful to defend against unlocked access to
>> -				 * ->shrink_list in shmem_unused_huge_shrink()
>> -				 */
>> -				if (list_empty_careful(&info->shrinklist)) {
>> -					list_add_tail(&info->shrinklist,
>> -							&sbinfo->shrinklist);
>> -					sbinfo->shrinklist_len++;
>> -				}
>> -				spin_unlock(&sbinfo->shrinklist_lock);
>> +				struct page *page;
>> +
>> +				page = find_get_page(inode->i_mapping,
>> +					(newsize & HPAGE_PMD_MASK) >> PAGE_SHIFT);
>> +				shmem_shrinker_add(sbinfo, inode, page);
>> +				if (page)
>> +					put_page(page);
>
> 1)I'd move PageTransHuge() check from shmem_shrinker_add() to here. In case of page is not trans huge,
>   it looks strange and completely useless to add inode to shrinklist and then to avoid memcg_set_shrinker_bit().
>   Nothing should be added to the shrinklist in this case.

Ack,  I'll take a look at this.

> 2)In general I think this "last inode page spliter" does not fit SHINKER_MEMCG_AWARE conception, and
>   shmem_unused_huge_shrink() should be reworked as a new separate !memcg-aware shrinker instead of
>   .nr_cached_objects callback of generic fs shrinker.
>
> CC: Kirill Shutemov
>
> Kirill, are there any fundamental reasons to keep this shrinking logic in the generic fs shrinker?
> Are there any no-go to for conversion this as a separate !memcg-aware shrinker?

Making the shmem shrinker !memcg-aware seems like it would require tail
pages beyond i_size not be charged to memcg.  Otherwise memcg pressure
(which only calls memcg aware shrinkers) won't uncharge them.  Currently
the entire compound page is charged.

>>  			}
>>  		}
>>  	}
>> @@ -1889,21 +1912,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>>  	if (PageTransHuge(page) &&
>>  	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>>  			hindex + HPAGE_PMD_NR - 1) {
>> -		/*
>> -		 * Part of the huge page is beyond i_size: subject
>> -		 * to shrink under memory pressure.
>> -		 */
>> -		spin_lock(&sbinfo->shrinklist_lock);
>> -		/*
>> -		 * _careful to defend against unlocked access to
>> -		 * ->shrink_list in shmem_unused_huge_shrink()
>> -		 */
>> -		if (list_empty_careful(&info->shrinklist)) {
>> -			list_add_tail(&info->shrinklist,
>> -				      &sbinfo->shrinklist);
>> -			sbinfo->shrinklist_len++;
>> -		}
>> -		spin_unlock(&sbinfo->shrinklist_lock);
>> +		shmem_shrinker_add(sbinfo, inode, page);
>>  	}
>>  
>>  	/*
>
> Thanks,
> Kirill
