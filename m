Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD340C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865B12070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="owLtQFxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgCWV7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:59:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15952 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585000758; x=1616536758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sgyeINK52rxZQ8ra7tm0YgG8qfDH6jpwmG/cAVgAczk=;
  b=owLtQFxG2i61RDabrRtVmNTboVtArwucH5/Qo6EDJZBUt0QK2RJaEN8i
   Cz3rj9hkGzvKRANclM2K2aodaJigojFbLd1G4coV/NYwgPLkVpU+7qSIe
   663sBTpVqSnqwlJFA3RI0zPMOFbiCavHqK/gBhO5WBJ4x4zPr0Jxrz4ow
   hDJzQm06JAe9cSPLwfVOzRHmPhSeux2NW+vaREjPUipLBlQDUXKxEy71i
   wPZ6cPb9QeeHg8toDPljoFgHO+MDmqO9hljVkvTE79DyRsFddURd+gdpY
   VHjPld52HqtU6fdspib7l1LHHf20gD9CepOhGUcfvVuGMNk+0n+VgXuBm
   A==;
IronPort-SDR: tIYm7Tx9KvstwNw5pjObilqLxnTkEPiObidPrKJyI9LCUP32dgAlRjTkfI2bUqhScIH1usKXTe
 W+D75pcRGvkyc0lh2wgMJgBDd+gJvMfPtr9PsAcJttr5p6Um5W6Sv0OMnYUG1zCtSniRdqEunf
 ntkUC7Qmr2uiLT6H2IV1hmaBz0UEkA6IUHa62Yw5Dt3HghtfNQONgXJjoqTNTRzaI5ZDOG4afc
 xW2TOi3uGNYfpx9pDiKCrK94PqzXkC6Fsi61HbquVFWWKkRMK2IaC4deZTGCTgDM147HypHmG/
 /qg=
X-IronPort-AV: E=Sophos;i="5.72,297,1580745600"; 
   d="scan'208";a="235491074"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 05:59:14 +0800
IronPort-SDR: 1K/2RMsdXkTajXQwdIwjGd2NRZFOyo7rbUdxlmozYVQ7u4k9dIEXuTzSBDP5srAaV2gGKvBZVo
 2HjzQ40R8NmW+EUni6mNpgKejSBMWpCDx+7FztMSKfvdah2sPVmokeKvTtjqwsLbrjlixXa2D4
 vqOLDYygRS2MDTfXSaFDI/hxh8a+5AKshMQ7D75y7So01CktMbckcOqWmEW6RtuSf6vUf5AmqV
 ZG0aAI4KdkioMjqqFmQsMuDSiMBmhJmaDKz/bEMwypuTy8xkxlNt8e2uCCLYTZN4XJSY5aqMx3
 jAv6Z+uXhTCdcN2vlNrzVg88
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 14:50:51 -0700
IronPort-SDR: 68V/NHkQB7c1BCTxGvZJowsC/BrSsirU9U0N5Ffwcfe2Zhlj8FOgzAGEJaSfjjeFlyxHVjrR4A
 0DsDzpmCMFD3iIX1aHWKxKe1Hi99mVqZ2PMUpQex/ad3zhPpFRqTzQKw+3MBAbUWPh+NNGdC/R
 asDCvAbFz2EA88LRhjENi5JyEydeSa7A0eUmA6NgdfAqj/x7cyPy4gsg+Pp7DqyUJfxzw0rQb+
 Yzxug3Tp49xvk+pxMgwVYFhq0j2JPijj8wpT1ckTPuqFqIIcjN92X/DUlgwzsvSIaXAV6mDfez
 M+Q=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 23 Mar 2020 14:59:09 -0700
Received: (nullmailer pid 2681380 invoked by uid 1000);
        Mon, 23 Mar 2020 21:59:08 -0000
Date:   Tue, 24 Mar 2020 06:59:08 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: lockdep warning in sys_swapon
Message-ID: <20200323215908.tkihojhshwn7kail@naota.dhcp.fujisawa.hgst.com>
References: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
 <20200323153045.s7ag3lrvfe2cpiiw@e107158-lin.cambridge.arm.com>
 <20200323140615.75e3c7481f4c6aeb94c95ba9@linux-foundation.org>
 <20200323211201.GD29351@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200323211201.GD29351@magnolia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:12:01PM -0700, Darrick J. Wong wrote:
>On Mon, Mar 23, 2020 at 02:06:15PM -0700, Andrew Morton wrote:
>> On Mon, 23 Mar 2020 15:30:45 +0000 Qais Yousef <qais.yousef@arm.com> wrote:
>>
>> > On 03/23/20 15:17, Qais Yousef wrote:
>> > > Hi
>> > >
>> > > I hit the following 2 warnings when running with LOCKDEP=y on arm64 platform
>> > > (juno-r2), running on v5.6-rc6
>> > >
>> > > The 1st one is when I execute `swapon -a`. The 2nd one happens at boot. I have
>> > > /dev/sda2 as my swap in /etc/fstab
>> > >
>> > > Note that I either hit 1 OR 2, but didn't hit both warnings at the same time,
>> > > yet at least.
>> > >
>> > > /dev/sda2 is a usb flash drive, in case it matters somehow.
>> >
>> > By the way, I noticed that in claim_swapfile() if we fail we don't release the
>> > lock. Shouldn't we release the lock here?
>> >
>> > I tried with that FWIW, but it had no effect on the warnings.
>> >
>>
>> I'll be sending the below into Linus this week.
>>
>> I was hoping to hear from Darrick/Christoph (?) but it looks like the
>> right thing to do.  Are you able to test it?
>
>I had questions[1] about the patch, but nobody ever replied.

Sorry, I have overlooked that one. I'm replying here.

> Sorry to wander in late, but I don't see how we unlock the inode in the
> success case.  Before this patch, the "if (inode) inode_unlock(inode);"
> below out: would take care of this for both the success case and the
> bad_swap case, but now that's gone, and AFAICT after this patch we only
> unlock the inode when erroring out...
> 
> > +bad_swap_unlock_inode:
> > +	inode_unlock(inode);
> 
> ...since we never goto bad_swap_unlock_inode when error == 0, correct?

Actually, this patch does not touch "if (inode) inode_unlock(inode);" below
the "out:" label, so we still have that "inode_unlock" after this patch and
it unlocks the inode in the success case.

>
>--D
>
>[1] https://lore.kernel.org/linux-fsdevel/20200212164956.GK6874@magnolia/
>
>> I think I'll add a cc:stable to this one.
>>
>>
>>
>> From: Naohiro Aota <naohiro.aota@wdc.com>
>> Subject: mm/swapfile.c: move inode_lock out of claim_swapfile
>>
>> claim_swapfile() currently keeps the inode locked when it is successful,
>> or the file is already swapfile (with -EBUSY).  And, on the other error
>> cases, it does not lock the inode.
>>
>> This inconsistency of the lock state and return value is quite confusing
>> and actually causing a bad unlock balance as below in the "bad_swap"
>> section of __do_sys_swapon().
>>
>> This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
>> check out of claim_swapfile().  The inode is unlocked in
>> "bad_swap_unlock_inode" section, so that the inode is ensured to be
>> unlocked at "bad_swap".  Thus, error handling codes after the locking now
>> jumps to "bad_swap_unlock_inode" instead of "bad_swap".
>>
>>     =====================================
>>     WARNING: bad unlock balance detected!
>>     5.5.0-rc7+ #176 Not tainted
>>     -------------------------------------
>>     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
>>     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
>>     but there are no more locks to release!
>>
>>     other info that might help us debug this:
>>     no locks held by swapon/4294.
>>
>>     stack backtrace:
>>     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
>>     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
>>     Call Trace:
>>      dump_stack+0xa1/0xea
>>      ? __do_sys_swapon+0x94b/0x3550
>>      print_unlock_imbalance_bug.cold+0x114/0x123
>>      ? __do_sys_swapon+0x94b/0x3550
>>      lock_release+0x562/0xed0
>>      ? kvfree+0x31/0x40
>>      ? lock_downgrade+0x770/0x770
>>      ? kvfree+0x31/0x40
>>      ? rcu_read_lock_sched_held+0xa1/0xd0
>>      ? rcu_read_lock_bh_held+0xb0/0xb0
>>      up_write+0x2d/0x490
>>      ? kfree+0x293/0x2f0
>>      __do_sys_swapon+0x94b/0x3550
>>      ? putname+0xb0/0xf0
>>      ? kmem_cache_free+0x2e7/0x370
>>      ? do_sys_open+0x184/0x3e0
>>      ? generic_max_swapfile_size+0x40/0x40
>>      ? do_syscall_64+0x27/0x4b0
>>      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>      ? lockdep_hardirqs_on+0x38c/0x590
>>      __x64_sys_swapon+0x54/0x80
>>      do_syscall_64+0xa4/0x4b0
>>      entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>     RIP: 0033:0x7f15da0a0dc7
>>
>> Link: http://lkml.kernel.org/r/20200206090132.154869-1-naohiro.aota@wdc.com
>> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Darrick J. Wong <darrick.wong@oracle.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  mm/swapfile.c |   41 ++++++++++++++++++++---------------------
>>  1 file changed, 20 insertions(+), 21 deletions(-)
>>
>> --- a/mm/swapfile.c~mm-swap-move-inode_lock-out-of-claim_swapfile
>> +++ a/mm/swapfile.c
>> @@ -2899,10 +2899,6 @@ static int claim_swapfile(struct swap_in
>>  		p->bdev = inode->i_sb->s_bdev;
>>  	}
>>
>> -	inode_lock(inode);
>> -	if (IS_SWAPFILE(inode))
>> -		return -EBUSY;
>> -
>>  	return 0;
>>  }
>>
>> @@ -3157,36 +3153,41 @@ SYSCALL_DEFINE2(swapon, const char __use
>>  	mapping = swap_file->f_mapping;
>>  	inode = mapping->host;
>>
>> -	/* will take i_rwsem; */
>>  	error = claim_swapfile(p, inode);
>>  	if (unlikely(error))
>>  		goto bad_swap;
>>
>> +	inode_lock(inode);
>> +	if (IS_SWAPFILE(inode)) {
>> +		error = -EBUSY;
>> +		goto bad_swap_unlock_inode;
>> +	}
>> +
>>  	/*
>>  	 * Read the swap header.
>>  	 */
>>  	if (!mapping->a_ops->readpage) {
>>  		error = -EINVAL;
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>  	page = read_mapping_page(mapping, 0, swap_file);
>>  	if (IS_ERR(page)) {
>>  		error = PTR_ERR(page);
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>  	swap_header = kmap(page);
>>
>>  	maxpages = read_swap_header(p, swap_header, inode);
>>  	if (unlikely(!maxpages)) {
>>  		error = -EINVAL;
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>
>>  	/* OK, set up the swap map and apply the bad block list */
>>  	swap_map = vzalloc(maxpages);
>>  	if (!swap_map) {
>>  		error = -ENOMEM;
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>
>>  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
>> @@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>>  					GFP_KERNEL);
>>  		if (!cluster_info) {
>>  			error = -ENOMEM;
>> -			goto bad_swap;
>> +			goto bad_swap_unlock_inode;
>>  		}
>>
>>  		for (ci = 0; ci < nr_cluster; ci++)
>> @@ -3220,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>>  		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
>>  		if (!p->percpu_cluster) {
>>  			error = -ENOMEM;
>> -			goto bad_swap;
>> +			goto bad_swap_unlock_inode;
>>  		}
>>  		for_each_possible_cpu(cpu) {
>>  			struct percpu_cluster *cluster;
>> @@ -3234,13 +3235,13 @@ SYSCALL_DEFINE2(swapon, const char __use
>>
>>  	error = swap_cgroup_swapon(p->type, maxpages);
>>  	if (error)
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>
>>  	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
>>  		cluster_info, maxpages, &span);
>>  	if (unlikely(nr_extents < 0)) {
>>  		error = nr_extents;
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>  	/* frontswap enabled? set up bit-per-page map for frontswap */
>>  	if (IS_ENABLED(CONFIG_FRONTSWAP))
>> @@ -3280,7 +3281,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>>
>>  	error = init_swap_address_space(p->type, maxpages);
>>  	if (error)
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>
>>  	/*
>>  	 * Flush any pending IO and dirty mappings before we start using this
>> @@ -3290,7 +3291,7 @@ SYSCALL_DEFINE2(swapon, const char __use
>>  	error = inode_drain_writes(inode);
>>  	if (error) {
>>  		inode->i_flags &= ~S_SWAPFILE;
>> -		goto bad_swap;
>> +		goto bad_swap_unlock_inode;
>>  	}
>>
>>  	mutex_lock(&swapon_mutex);
>> @@ -3315,6 +3316,8 @@ SYSCALL_DEFINE2(swapon, const char __use
>>
>>  	error = 0;
>>  	goto out;
>> +bad_swap_unlock_inode:
>> +	inode_unlock(inode);
>>  bad_swap:
>>  	free_percpu(p->percpu_cluster);
>>  	p->percpu_cluster = NULL;
>> @@ -3322,6 +3325,7 @@ bad_swap:
>>  		set_blocksize(p->bdev, p->old_block_size);
>>  		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>>  	}
>> +	inode = NULL;
>>  	destroy_swap_extents(p);
>>  	swap_cgroup_swapoff(p->type);
>>  	spin_lock(&swap_lock);
>> @@ -3333,13 +3337,8 @@ bad_swap:
>>  	kvfree(frontswap_map);
>>  	if (inced_nr_rotate_swap)
>>  		atomic_dec(&nr_rotate_swap);
>> -	if (swap_file) {
>> -		if (inode) {
>> -			inode_unlock(inode);
>> -			inode = NULL;
>> -		}
>> +	if (swap_file)
>>  		filp_close(swap_file, NULL);
>> -	}
>>  out:
>>  	if (page && !IS_ERR(page)) {
>>  		kunmap(page);
>> _
>>
