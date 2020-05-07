Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB80C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E12084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588855761;
	bh=31pqcdlKcDRpHUSplqujtBg+s8YvDSiNTvR/6s8xihQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1p1x6BOAwiUVfVYTd9oEt7Pf1TtVADR/efJDTEFgKpuNSeBhIgZbS8Swg9a82IBL4
	 9qYHbpjCPu6fbb9P/ITDkVDuSwMk0+OXrkL/App4+ztKLvvbJFjEMfpMk8Xs5EA3mE
	 TgWeJn/OVruXz740IKpnOwnHzQF/4IFM/UDfpaLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEGMtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgEGMtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:49:20 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF5C2063A;
        Thu,  7 May 2020 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588855759;
        bh=31pqcdlKcDRpHUSplqujtBg+s8YvDSiNTvR/6s8xihQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfNqKzqGfJYbM7KCZSAyfWsclW0AoCBnVvcFi0AE1zUrGQ9rVX4RZbD+wUPBOXIqN
         +z0ml/tT9SmT6DJaxsc3G+dnf030lQ7Lp+KFs0pT/gzFp3WC8zCF8EB8YC1TtpmIhu
         nN4evojy8b5/nvc6c7k0Kzzbs2zSUqyl/QFvqnvs=
Date:   Thu, 7 May 2020 05:49:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: shrink spinlock coverage
Message-ID: <20200507124919.GA197114@google.com>
References: <20200506104542.123575-1-yuchao0@huawei.com>
 <20200506150521.GE107238@google.com>
 <f577a7a8-298f-cdda-7627-1273f83c261c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f577a7a8-298f-cdda-7627-1273f83c261c@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07, Chao Yu wrote:
> On 2020/5/6 23:05, Jaegeuk Kim wrote:
> > On 05/06, Chao Yu wrote:
> >> In f2fs_try_to_free_nids(), .nid_list_lock spinlock critical region will
> >> increase as expected shrink number increase, to avoid spining other CPUs
> >> for long time, it's better to implement like extent cache and nats
> >> shrinker.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2:
> >> - fix unlock wrong spinlock.
> >>  fs/f2fs/node.c | 15 +++++++++++----
> >>  1 file changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index 4da0d8713df5..ad0b14f4dab8 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -2488,7 +2488,6 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
> >>  int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
> >>  {
> >>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >> -	struct free_nid *i, *next;
> >>  	int nr = nr_shrink;
> >>  
> >>  	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
> >> @@ -2498,14 +2497,22 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
> >>  		return 0;
> >>  
> >>  	spin_lock(&nm_i->nid_list_lock);
> >> -	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
> >> -		if (nr_shrink <= 0 ||
> >> -				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
> >> +	while (nr_shrink) {
> >> +		struct free_nid *i;
> >> +
> >> +		if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
> >>  			break;
> >>  
> >> +		i = list_first_entry(&nm_i->free_nid_list,
> >> +					struct free_nid, list);
> >> +		list_del(&i->list);
> >> +		spin_unlock(&nm_i->nid_list_lock);
> >> +
> >>  		__remove_free_nid(sbi, i, FREE_NID);
> > 
> > __remove_free_nid() will do list_del again. btw, how about just splitting out
> 
> Oh, my bad.
> 
> How about moving __remove_free_nid into .nid_list_lock coverage?
> 
> > given nr_shrink into multiple trials?
> 
> Like this?

Yes.

> 
> 	while (shrink) {
> 		batch = DEFAULT_BATCH_NUMBER; // 16
> 		spinlock();
> 		list_for_each_entry_safe() {
> 			if (!shrink || !batch)
> 				break;
> 			remove_item_from_list;
> 			shrink--;
> 			batch--;
> 		}
> 		spin_unlock();
> 	}
> 
> Thanks,
> 
> > 
> >>  		kmem_cache_free(free_nid_slab, i);
> >>  		nr_shrink--;
> >> +
> >> +		spin_lock(&nm_i->nid_list_lock);
> >>  	}
> >>  	spin_unlock(&nm_i->nid_list_lock);
> >>  	mutex_unlock(&nm_i->build_lock);
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
