Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70766C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C7120409
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S4/we7Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCYQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:11:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgCYQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:11:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PG99Bm046857;
        Wed, 25 Mar 2020 16:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sVY+L2VWhH3rAV585z/4AHhGGfHGenzZphiRcmFDbV4=;
 b=S4/we7Tp8JlCIjDRt80fy6GWjerTAeJk/3JD/TiUNoZhGQ6t7gMf/DZ1OEMtAWs6IeuS
 x0fDGsrBRyCUz2NYbLxUTLcLSLT7rozQVHk/rLDcd15Hp5tclF50VapMMOa7z2qLLUuX
 QT6e/3Uu/xkHkPGNv1LuW3zu1vaEZeB3TUjPPHlH/vXM1DN9/9U/umr9ghhCv/hpmI0U
 S8kn5F9PN4TBs+/U0vmjTDL8HQF/SSbQKAbRHDIN6ehXdLl5AqDn4HA9iEnHVRvNLzbR
 AZ2tU356w6LLMPm6HsLD5IfDhZSZRGgbKOUBCUQN01jpDqX1cgXmn8aZQ4ESKoEbQEqP /Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ywavmanve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 16:11:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PG8J54088100;
        Wed, 25 Mar 2020 16:09:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3006r6ufdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 16:09:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PG90mt012540;
        Wed, 25 Mar 2020 16:09:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 09:08:59 -0700
Date:   Wed, 25 Mar 2020 09:08:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: lockdep warning in sys_swapon
Message-ID: <20200325160858.GI29351@magnolia>
References: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
 <20200323153045.s7ag3lrvfe2cpiiw@e107158-lin.cambridge.arm.com>
 <20200323140615.75e3c7481f4c6aeb94c95ba9@linux-foundation.org>
 <20200323211201.GD29351@magnolia>
 <20200323215908.tkihojhshwn7kail@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323215908.tkihojhshwn7kail@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:59:08AM +0900, Naohiro Aota wrote:
> On Mon, Mar 23, 2020 at 02:12:01PM -0700, Darrick J. Wong wrote:
> > On Mon, Mar 23, 2020 at 02:06:15PM -0700, Andrew Morton wrote:
> > > On Mon, 23 Mar 2020 15:30:45 +0000 Qais Yousef <qais.yousef@arm.com> wrote:
> > > 
> > > > On 03/23/20 15:17, Qais Yousef wrote:
> > > > > Hi
> > > > >
> > > > > I hit the following 2 warnings when running with LOCKDEP=y on arm64 platform
> > > > > (juno-r2), running on v5.6-rc6
> > > > >
> > > > > The 1st one is when I execute `swapon -a`. The 2nd one happens at boot. I have
> > > > > /dev/sda2 as my swap in /etc/fstab
> > > > >
> > > > > Note that I either hit 1 OR 2, but didn't hit both warnings at the same time,
> > > > > yet at least.
> > > > >
> > > > > /dev/sda2 is a usb flash drive, in case it matters somehow.
> > > >
> > > > By the way, I noticed that in claim_swapfile() if we fail we don't release the
> > > > lock. Shouldn't we release the lock here?
> > > >
> > > > I tried with that FWIW, but it had no effect on the warnings.
> > > >
> > > 
> > > I'll be sending the below into Linus this week.
> > > 
> > > I was hoping to hear from Darrick/Christoph (?) but it looks like the
> > > right thing to do.  Are you able to test it?
> > 
> > I had questions[1] about the patch, but nobody ever replied.
> 
> Sorry, I have overlooked that one. I'm replying here.
> 
> > Sorry to wander in late, but I don't see how we unlock the inode in the
> > success case.  Before this patch, the "if (inode) inode_unlock(inode);"
> > below out: would take care of this for both the success case and the
> > bad_swap case, but now that's gone, and AFAICT after this patch we only
> > unlock the inode when erroring out...
> > 
> > > +bad_swap_unlock_inode:
> > > +	inode_unlock(inode);
> > 
> > ...since we never goto bad_swap_unlock_inode when error == 0, correct?
> 
> Actually, this patch does not touch "if (inode) inode_unlock(inode);" below
> the "out:" label, so we still have that "inode_unlock" after this patch and
> it unlocks the inode in the success case.

Ah, right, I don't know what I was thinking when I wrote that. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> > 
> > --D
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20200212164956.GK6874@magnolia/
> > 
> > > I think I'll add a cc:stable to this one.
> > > 
> > > 
> > > 
> > > From: Naohiro Aota <naohiro.aota@wdc.com>
> > > Subject: mm/swapfile.c: move inode_lock out of claim_swapfile
> > > 
> > > claim_swapfile() currently keeps the inode locked when it is successful,
> > > or the file is already swapfile (with -EBUSY).  And, on the other error
> > > cases, it does not lock the inode.
> > > 
> > > This inconsistency of the lock state and return value is quite confusing
> > > and actually causing a bad unlock balance as below in the "bad_swap"
> > > section of __do_sys_swapon().
> > > 
> > > This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
> > > check out of claim_swapfile().  The inode is unlocked in
> > > "bad_swap_unlock_inode" section, so that the inode is ensured to be
> > > unlocked at "bad_swap".  Thus, error handling codes after the locking now
> > > jumps to "bad_swap_unlock_inode" instead of "bad_swap".
> > > 
> > >     =====================================
> > >     WARNING: bad unlock balance detected!
> > >     5.5.0-rc7+ #176 Not tainted
> > >     -------------------------------------
> > >     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
> > >     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
> > >     but there are no more locks to release!
> > > 
> > >     other info that might help us debug this:
> > >     no locks held by swapon/4294.
> > > 
> > >     stack backtrace:
> > >     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
> > >     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
> > >     Call Trace:
> > >      dump_stack+0xa1/0xea
> > >      ? __do_sys_swapon+0x94b/0x3550
> > >      print_unlock_imbalance_bug.cold+0x114/0x123
> > >      ? __do_sys_swapon+0x94b/0x3550
> > >      lock_release+0x562/0xed0
> > >      ? kvfree+0x31/0x40
> > >      ? lock_downgrade+0x770/0x770
> > >      ? kvfree+0x31/0x40
> > >      ? rcu_read_lock_sched_held+0xa1/0xd0
> > >      ? rcu_read_lock_bh_held+0xb0/0xb0
> > >      up_write+0x2d/0x490
> > >      ? kfree+0x293/0x2f0
> > >      __do_sys_swapon+0x94b/0x3550
> > >      ? putname+0xb0/0xf0
> > >      ? kmem_cache_free+0x2e7/0x370
> > >      ? do_sys_open+0x184/0x3e0
> > >      ? generic_max_swapfile_size+0x40/0x40
> > >      ? do_syscall_64+0x27/0x4b0
> > >      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >      ? lockdep_hardirqs_on+0x38c/0x590
> > >      __x64_sys_swapon+0x54/0x80
> > >      do_syscall_64+0xa4/0x4b0
> > >      entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >     RIP: 0033:0x7f15da0a0dc7
> > > 
> > > Link: http://lkml.kernel.org/r/20200206090132.154869-1-naohiro.aota@wdc.com
> > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  mm/swapfile.c |   41 ++++++++++++++++++++---------------------
> > >  1 file changed, 20 insertions(+), 21 deletions(-)
> > > 
> > > --- a/mm/swapfile.c~mm-swap-move-inode_lock-out-of-claim_swapfile
> > > +++ a/mm/swapfile.c
> > > @@ -2899,10 +2899,6 @@ static int claim_swapfile(struct swap_in
> > >  		p->bdev = inode->i_sb->s_bdev;
> > >  	}
> > > 
> > > -	inode_lock(inode);
> > > -	if (IS_SWAPFILE(inode))
> > > -		return -EBUSY;
> > > -
> > >  	return 0;
> > >  }
> > > 
> > > @@ -3157,36 +3153,41 @@ SYSCALL_DEFINE2(swapon, const char __use
> > >  	mapping = swap_file->f_mapping;
> > >  	inode = mapping->host;
> > > 
> > > -	/* will take i_rwsem; */
> > >  	error = claim_swapfile(p, inode);
> > >  	if (unlikely(error))
> > >  		goto bad_swap;
> > > 
> > > +	inode_lock(inode);
> > > +	if (IS_SWAPFILE(inode)) {
> > > +		error = -EBUSY;
> > > +		goto bad_swap_unlock_inode;
> > > +	}
> > > +
> > >  	/*
> > >  	 * Read the swap header.
> > >  	 */
> > >  	if (!mapping->a_ops->readpage) {
> > >  		error = -EINVAL;
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > >  	page = read_mapping_page(mapping, 0, swap_file);
> > >  	if (IS_ERR(page)) {
> > >  		error = PTR_ERR(page);
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > >  	swap_header = kmap(page);
> > > 
> > >  	maxpages = read_swap_header(p, swap_header, inode);
> > >  	if (unlikely(!maxpages)) {
> > >  		error = -EINVAL;
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > > 
> > >  	/* OK, set up the swap map and apply the bad block list */
> > >  	swap_map = vzalloc(maxpages);
> > >  	if (!swap_map) {
> > >  		error = -ENOMEM;
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > > 
> > >  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
> > > @@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __use
> > >  					GFP_KERNEL);
> > >  		if (!cluster_info) {
> > >  			error = -ENOMEM;
> > > -			goto bad_swap;
> > > +			goto bad_swap_unlock_inode;
> > >  		}
> > > 
> > >  		for (ci = 0; ci < nr_cluster; ci++)
> > > @@ -3220,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __use
> > >  		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
> > >  		if (!p->percpu_cluster) {
> > >  			error = -ENOMEM;
> > > -			goto bad_swap;
> > > +			goto bad_swap_unlock_inode;
> > >  		}
> > >  		for_each_possible_cpu(cpu) {
> > >  			struct percpu_cluster *cluster;
> > > @@ -3234,13 +3235,13 @@ SYSCALL_DEFINE2(swapon, const char __use
> > > 
> > >  	error = swap_cgroup_swapon(p->type, maxpages);
> > >  	if (error)
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > > 
> > >  	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
> > >  		cluster_info, maxpages, &span);
> > >  	if (unlikely(nr_extents < 0)) {
> > >  		error = nr_extents;
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > >  	/* frontswap enabled? set up bit-per-page map for frontswap */
> > >  	if (IS_ENABLED(CONFIG_FRONTSWAP))
> > > @@ -3280,7 +3281,7 @@ SYSCALL_DEFINE2(swapon, const char __use
> > > 
> > >  	error = init_swap_address_space(p->type, maxpages);
> > >  	if (error)
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > > 
> > >  	/*
> > >  	 * Flush any pending IO and dirty mappings before we start using this
> > > @@ -3290,7 +3291,7 @@ SYSCALL_DEFINE2(swapon, const char __use
> > >  	error = inode_drain_writes(inode);
> > >  	if (error) {
> > >  		inode->i_flags &= ~S_SWAPFILE;
> > > -		goto bad_swap;
> > > +		goto bad_swap_unlock_inode;
> > >  	}
> > > 
> > >  	mutex_lock(&swapon_mutex);
> > > @@ -3315,6 +3316,8 @@ SYSCALL_DEFINE2(swapon, const char __use
> > > 
> > >  	error = 0;
> > >  	goto out;
> > > +bad_swap_unlock_inode:
> > > +	inode_unlock(inode);
> > >  bad_swap:
> > >  	free_percpu(p->percpu_cluster);
> > >  	p->percpu_cluster = NULL;
> > > @@ -3322,6 +3325,7 @@ bad_swap:
> > >  		set_blocksize(p->bdev, p->old_block_size);
> > >  		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> > >  	}
> > > +	inode = NULL;
> > >  	destroy_swap_extents(p);
> > >  	swap_cgroup_swapoff(p->type);
> > >  	spin_lock(&swap_lock);
> > > @@ -3333,13 +3337,8 @@ bad_swap:
> > >  	kvfree(frontswap_map);
> > >  	if (inced_nr_rotate_swap)
> > >  		atomic_dec(&nr_rotate_swap);
> > > -	if (swap_file) {
> > > -		if (inode) {
> > > -			inode_unlock(inode);
> > > -			inode = NULL;
> > > -		}
> > > +	if (swap_file)
> > >  		filp_close(swap_file, NULL);
> > > -	}
> > >  out:
> > >  	if (page && !IS_ERR(page)) {
> > >  		kunmap(page);
> > > _
> > > 
