Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FAFC4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C258624656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="ZJTJIMJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgBZSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:06:00 -0500
Received: from vps.xff.cz ([195.181.215.36]:40690 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgBZSF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1582740357; bh=qi8MEtrKr/sWZR+O6l2J1/qC6eHb/hKK65bpZ3OS4FU=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=ZJTJIMJQSsgtphhAyhQ04XTUba/vmVKSTL/sO5rZNUmAXr1T+DYuGXjjFvKcvENjI
         90/YNQQUT3Wv9N0+WZaKvfkoTyiqxt9EIjysKsWo8kwgOwLmbZaziGr4knTmXGpDwT
         p9TGWAqbZ0gBJEchbLkEkMmx91FyNRZQtcxIdO88=
Date:   Wed, 26 Feb 2020 19:05:57 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
Message-ID: <20200226180557.le2fr66fyuvrqker@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <bec3798b-f861-b132-9138-221027bb5195@huawei.com>
 <b1eb9b22-b570-41ab-5177-2c89105428a2@huawei.com>
 <20200224135837.k54ke4ppca26ibec@core.my.home>
 <20200224140349.74yagjdwewmclx4v@core.my.home>
 <20200224143149.au6hvmmfw4ajsq2g@core.my.home>
 <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
 <20200225120814.gjm4dby24cs22lux@core.my.home>
 <20200225122706.d6pngz62iwyowhym@core.my.home>
 <72d28eba-53b9-b6f4-01a5-45b2352f4285@huawei.com>
 <20200226121143.uag224cqzqossvlv@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226121143.uag224cqzqossvlv@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:11:43PM +0100, megi xff wrote:
> On Wed, Feb 26, 2020 at 09:58:03AM +0800, Chao Yu wrote:
> > On 2020/2/25 20:27, Ondřej Jirman wrote:
> > > So this time it just took several times longer to appear (8-20mins to the hang):
> > > 
> > > https://megous.com/dl/tmp/dmesg1
> > > https://megous.com/dl/tmp/dmesg2
> > 
> > Alright, I still didn't see any possible deadlock in f2fs.
> > 
> > Can you try below patch? I'd like to see whether spinlock can cause the same issue.
> 
> Uptime 60 minutes and it didn't hang so far. I applied it on top of the previous
> patch:
>   
>   https://megous.com/git/linux/log/?h=f2fs-debug-5.6

No issue after 7h uptime either. So I guess this patch solved it for some
reason.

regards,
	o.

> regards,
> 	o.
> 
> > From 3e9e8daf922eaa2c5db195ce278e89e10191c516 Mon Sep 17 00:00:00 2001
> > From: Chao Yu <yuchao0@huawei.com>
> > Date: Wed, 26 Feb 2020 09:53:03 +0800
> > Subject: [PATCH] fix
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/compress.c | 4 ++--
> >  fs/f2fs/data.c     | 4 ++--
> >  fs/f2fs/f2fs.h     | 5 +++--
> >  fs/f2fs/file.c     | 4 ++--
> >  fs/f2fs/super.c    | 1 +
> >  5 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index b4ff25dc55a9..6de0872ad881 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -906,10 +906,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >  	f2fs_put_dnode(&dn);
> >  	f2fs_unlock_op(sbi);
> > 
> > -	down_write(&fi->i_sem);
> > +	spin_lock(&fi->i_size_lock);
> >  	if (fi->last_disk_size < psize)
> >  		fi->last_disk_size = psize;
> > -	up_write(&fi->i_sem);
> > +	spin_unlock(&fi->i_size_lock);
> > 
> >  	f2fs_put_rpages(cc);
> >  	f2fs_destroy_compress_ctx(cc);
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index cb41260ca941..5c9b072cf0de 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2651,10 +2651,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> >  	if (err) {
> >  		file_set_keep_isize(inode);
> >  	} else {
> > -		down_write(&F2FS_I(inode)->i_sem);
> > +		spin_lock(&F2FS_I(inode)->i_size_lock);
> >  		if (F2FS_I(inode)->last_disk_size < psize)
> >  			F2FS_I(inode)->last_disk_size = psize;
> > -		up_write(&F2FS_I(inode)->i_sem);
> > +		spin_unlock(&F2FS_I(inode)->i_size_lock);
> >  	}
> > 
> >  done:
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4a02edc2454b..1a8af2020e72 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -701,6 +701,7 @@ struct f2fs_inode_info {
> >  	struct task_struct *cp_task;	/* separate cp/wb IO stats*/
> >  	nid_t i_xattr_nid;		/* node id that contains xattrs */
> >  	loff_t	last_disk_size;		/* lastly written file size */
> > +	spinlock_t i_size_lock;		/* protect last_disk_size */
> > 
> >  #ifdef CONFIG_QUOTA
> >  	struct dquot *i_dquot[MAXQUOTAS];
> > @@ -2882,9 +2883,9 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
> >  	if (!f2fs_is_time_consistent(inode))
> >  		return false;
> > 
> > -	down_read(&F2FS_I(inode)->i_sem);
> > +	spin_lock(&F2FS_I(inode)->i_size_lock);
> >  	ret = F2FS_I(inode)->last_disk_size == i_size_read(inode);
> > -	up_read(&F2FS_I(inode)->i_sem);
> > +	spin_unlock(&F2FS_I(inode)->i_size_lock);
> > 
> >  	return ret;
> >  }
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index fdb492c2f248..56fe18fbb2ef 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -938,10 +938,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  		if (err)
> >  			return err;
> > 
> > -		down_write(&F2FS_I(inode)->i_sem);
> > +		spin_lock(&F2FS_I(inode)->i_size_lock);
> >  		inode->i_mtime = inode->i_ctime = current_time(inode);
> >  		F2FS_I(inode)->last_disk_size = i_size_read(inode);
> > -		up_write(&F2FS_I(inode)->i_sem);
> > +		spin_unlock(&F2FS_I(inode)->i_size_lock);
> >  	}
> > 
> >  	__setattr_copy(inode, attr);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 0b16204d3b7d..2d0e5d1269f5 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -957,6 +957,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
> >  	/* Initialize f2fs-specific inode info */
> >  	atomic_set(&fi->dirty_pages, 0);
> >  	init_rwsem(&fi->i_sem);
> > +	spin_lock_init(&fi->i_size_lock);
> >  	INIT_LIST_HEAD(&fi->dirty_list);
> >  	INIT_LIST_HEAD(&fi->gdirty_list);
> >  	INIT_LIST_HEAD(&fi->inmem_ilist);
> > -- 
> > 2.18.0.rc1
> > 
> > 
> > 
> > 
> > > 
> > > thank you and regards,
> > > 	o.
> > > 
> > >> thank you and regards,
> > >> 	o.
> > >>
> > >>> Thanks,
> > >>>
> > >>>>
> > >>>> So it's probably not inode locking.
> > >>>>
> > >>>>> root@tbs2[/proc/sys/kernel] # dmesg | grep down_read | wc -l
> > >>>>> 16
> > >>>>> root@tbs2[/proc/sys/kernel] # dmesg | grep up_read | wc -l
> > >>>>> 16
> > >>>>>
> > >>>>> regards,
> > >>>>> 	o.
> > >>>>>
> > >>>>>> thank you,
> > >>>>>> 	o.
> > >>>>>>
> > >>>>>>>> Thanks,
> > >>>>>>>>
> > >>>>>>>>> [  246.758190]  r5:eff213b0 r4:da283c60
> > >>>>>>>>> [  246.758198] [<c0435578>] (f2fs_write_single_data_page) from [<c0435fd8>] (f2fs_write_cache_pages+0x2b4/0x7c4)
> > >>>>>>>>> [  246.758204]  r10:da645c28 r9:da283d60 r8:da283c60 r7:0000000f r6:da645d80 r5:00000001
> > >>>>>>>>> [  246.758206]  r4:eff213b0
> > >>>>>>>>> [  246.758214] [<c0435d24>] (f2fs_write_cache_pages) from [<c043682c>] (f2fs_write_data_pages+0x344/0x35c)
> > >>>>>>>>> [  246.758220]  r10:00000000 r9:d9ed002c r8:d9ed0000 r7:00000004 r6:da283d60 r5:da283c60
> > >>>>>>>>> [  246.758223]  r4:da645d80
> > >>>>>>>>> [  246.758238] [<c04364e8>] (f2fs_write_data_pages) from [<c0267ee8>] (do_writepages+0x3c/0xd4)
> > >>>>>>>>> [  246.758244]  r10:0000000a r9:c0e03d00 r8:00000c00 r7:c0264ddc r6:da645d80 r5:da283d60
> > >>>>>>>>> [  246.758246]  r4:da283c60
> > >>>>>>>>> [  246.758254] [<c0267eac>] (do_writepages) from [<c0310cbc>] (__writeback_single_inode+0x44/0x454)
> > >>>>>>>>> [  246.758259]  r7:da283d60 r6:da645eac r5:da645d80 r4:da283c60
> > >>>>>>>>> [  246.758266] [<c0310c78>] (__writeback_single_inode) from [<c03112d0>] (writeback_sb_inodes+0x204/0x4b0)
> > >>>>>>>>> [  246.758272]  r10:0000000a r9:c0e03d00 r8:da283cc8 r7:da283c60 r6:da645eac r5:da283d08
> > >>>>>>>>> [  246.758274]  r4:d9dc9848
> > >>>>>>>>> [  246.758281] [<c03110cc>] (writeback_sb_inodes) from [<c03115cc>] (__writeback_inodes_wb+0x50/0xe4)
> > >>>>>>>>> [  246.758287]  r10:da3797a8 r9:c0e03d00 r8:d9dc985c r7:da645eac r6:00000000 r5:d9dc9848
> > >>>>>>>>> [  246.758289]  r4:da5a8800
> > >>>>>>>>> [  246.758296] [<c031157c>] (__writeback_inodes_wb) from [<c03118f4>] (wb_writeback+0x294/0x338)
> > >>>>>>>>> [  246.758302]  r10:fffbf200 r9:da644000 r8:c0e04e64 r7:d9dc9848 r6:d9dc9874 r5:da645eac
> > >>>>>>>>> [  246.758305]  r4:d9dc9848
> > >>>>>>>>> [  246.758312] [<c0311660>] (wb_writeback) from [<c0312dac>] (wb_workfn+0x35c/0x54c)
> > >>>>>>>>> [  246.758318]  r10:da5f2005 r9:d9dc984c r8:d9dc9948 r7:d9dc9848 r6:00000000 r5:d9dc9954
> > >>>>>>>>> [  246.758321]  r4:000031e6
> > >>>>>>>>> [  246.758334] [<c0312a50>] (wb_workfn) from [<c014f2b8>] (process_one_work+0x214/0x544)
> > >>>>>>>>> [  246.758340]  r10:da5f2005 r9:00000200 r8:00000000 r7:da5f2000 r6:ef044400 r5:da5eb000
> > >>>>>>>>> [  246.758343]  r4:d9dc9954
> > >>>>>>>>> [  246.758350] [<c014f0a4>] (process_one_work) from [<c014f634>] (worker_thread+0x4c/0x574)
> > >>>>>>>>> [  246.758357]  r10:ef044400 r9:c0e03d00 r8:ef044418 r7:00000088 r6:ef044400 r5:da5eb014
> > >>>>>>>>> [  246.758359]  r4:da5eb000
> > >>>>>>>>> [  246.758368] [<c014f5e8>] (worker_thread) from [<c01564fc>] (kthread+0x144/0x170)
> > >>>>>>>>> [  246.758374]  r10:ec9e5e90 r9:dabf325c r8:da5eb000 r7:da644000 r6:00000000 r5:da5fe000
> > >>>>>>>>> [  246.758377]  r4:dabf3240
> > >>>>>>>>> [  246.758386] [<c01563b8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > >>>>>>>>> [  246.758391] Exception stack(0xda645fb0 to 0xda645ff8)
> > >>>>>>>>> [  246.758397] 5fa0:                                     00000000 00000000 00000000 00000000
> > >>>>>>>>> [  246.758402] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > >>>>>>>>> [  246.758407] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > >>>>>>>>> [  246.758413]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b8
> > >>>>>>>>> [  246.758416]  r4:da5fe000
> > >>>>>>>>> .
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> _______________________________________________
> > >>>>>>>> Linux-f2fs-devel mailing list
> > >>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
> > >>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >>>>>>>>
> > >>>> .
> > >>>>
> > > .
> > > 
