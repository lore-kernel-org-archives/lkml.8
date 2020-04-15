Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31712C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084F820732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586984176;
	bh=d2X11TcmdO6J2GN2r8rZPnahBd2RW8IgZzXqNkRCrbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dZh8tiAI0a/lPctG1Cx5gAgZMzxvXv94OUsFO5c9oeYiW1t3hXzL3MSxWSLoXTKYk
	 oAk9LjFr29uGqSmh+DrsjIDsuNjFFgSyxoq3jW6+9C+PldcVDaUxPsbo3rp5G9QeyP
	 XFY6fKfQ3HbWOk0x2DP/saaW0BTsJ0m3qvAeETpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898369AbgDOU4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438334AbgDOU4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:56:12 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2088206E9;
        Wed, 15 Apr 2020 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586984171;
        bh=d2X11TcmdO6J2GN2r8rZPnahBd2RW8IgZzXqNkRCrbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SD0oI23zduBQuEdVFec483nIIjQTio3VKITErV5+vR0ArfWwVs70VK1JZKXYdyegY
         mgrqgbrnNG97oL/+rSwEA+JZVHgVjfyS5Cf5IcWkniLR5xzuPPBfdJ6DsNJjNYgLvI
         5Hi+Jj3CYiKW8LjyGwMZ6YAgt5ts69Rz488nW++c=
Date:   Wed, 15 Apr 2020 13:56:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: add tracepoint for f2fs iostat
Message-ID: <20200415205611.GA29167@google.com>
References: <20200413161649.38177-1-jaegeuk@kernel.org>
 <838f483d-377f-e60e-5ffe-cf52b913f294@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838f483d-377f-e60e-5ffe-cf52b913f294@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Chao Yu wrote:
> On 2020/4/14 0:16, Jaegeuk Kim wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Added a tracepoint to see iostat of f2fs. Default period of that
> > is 3 second. This tracepoint can be used to be monitoring
> > I/O statistics periodically.
> > 
> > Bug: 152162885
> > Change-Id: I6fbe010b9cf1a90caa0f4793a6dab77c4cba7da6
> 
> It needs to be removed?

Yup.

> 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/f2fs.h              | 10 ++++++-
> >  fs/f2fs/sysfs.c             | 34 ++++++++++++++++++++++++
> >  include/trace/events/f2fs.h | 52 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index c2788738aa0d4..87baa09f76fb2 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2999,16 +2999,22 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
> >  		sizeof((f2fs_inode)->field))			\
> >  		<= (F2FS_OLD_ATTRIBUTE_SIZE + (extra_isize)))	\
> >  
> > +extern unsigned long long f2fs_prev_iostat[NR_IO_TYPE];
> > +
> >  static inline void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
> >  {
> >  	int i;
> >  
> >  	spin_lock(&sbi->iostat_lock);
> > -	for (i = 0; i < NR_IO_TYPE; i++)
> > +	for (i = 0; i < NR_IO_TYPE; i++) {
> >  		sbi->write_iostat[i] = 0;
> > +		f2fs_prev_iostat[i] = 0;
> > +	}
> >  	spin_unlock(&sbi->iostat_lock);
> >  }
> >  
> > +extern void f2fs_record_iostat(struct f2fs_sb_info *sbi);
> > +
> >  static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
> >  			enum iostat_type type, unsigned long long io_bytes)
> >  {
> > @@ -3022,6 +3028,8 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
> >  			sbi->write_iostat[APP_WRITE_IO] -
> >  			sbi->write_iostat[APP_DIRECT_IO];
> >  	spin_unlock(&sbi->iostat_lock);
> > +
> > +	f2fs_record_iostat(sbi);
> >  }
> >  
> >  #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index aeebfb5024a22..f34cb75cd039c 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -15,6 +15,7 @@
> >  #include "f2fs.h"
> >  #include "segment.h"
> >  #include "gc.h"
> > +#include <trace/events/f2fs.h>
> >  
> >  static struct proc_dir_entry *f2fs_proc_root;
> >  
> > @@ -751,6 +752,39 @@ static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
> >  	return 0;
> >  }
> >  
> > +static const unsigned long period_ms = 3000;
> > +static unsigned long next_period;
> > +unsigned long long f2fs_prev_iostat[NR_IO_TYPE] = {0};
> 
> These various should be per sbi, otherwise stats from different image could
> be interrupt others'.

Agreed. Let me pass it to work on it.

Thanks,

> 
> Thanks,
> 
> > +
> > +static DEFINE_SPINLOCK(iostat_lock);
> > +
> > +void f2fs_record_iostat(struct f2fs_sb_info *sbi)
> > +{
> > +	unsigned long long iostat_diff[NR_IO_TYPE];
> > +	int i;
> > +
> > +	if (time_is_after_jiffies(next_period))
> > +		return;
> > +
> > +	/* Need double check under the lock */
> > +	spin_lock(&iostat_lock);
> > +	if (time_is_after_jiffies(next_period)) {
> > +		spin_unlock(&iostat_lock);
> > +		return;
> > +	}
> > +	next_period = jiffies + msecs_to_jiffies(period_ms);
> > +	spin_unlock(&iostat_lock);
> > +
> > +	spin_lock(&sbi->iostat_lock);
> > +	for (i = 0; i < NR_IO_TYPE; i++) {
> > +		iostat_diff[i] = sbi->write_iostat[i] - f2fs_prev_iostat[i];
> > +		f2fs_prev_iostat[i] = sbi->write_iostat[i];
> > +	}
> > +	spin_unlock(&sbi->iostat_lock);
> > +
> > +	trace_f2fs_iostat(sbi, iostat_diff);
> > +}
> > +
> >  static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
> >  					       void *offset)
> >  {
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index d97adfc327f03..e78c8696e2adc 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -1812,6 +1812,58 @@ DEFINE_EVENT(f2fs_zip_end, f2fs_decompress_pages_end,
> >  	TP_ARGS(inode, cluster_idx, compressed_size, ret)
> >  );
> >  
> > +TRACE_EVENT(f2fs_iostat,
> > +
> > +	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat),
> > +
> > +	TP_ARGS(sbi, iostat),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,	dev)
> > +		__field(unsigned long long,	app_dio)
> > +		__field(unsigned long long,	app_bio)
> > +		__field(unsigned long long,	app_wio)
> > +		__field(unsigned long long,	app_mio)
> > +		__field(unsigned long long,	fs_dio)
> > +		__field(unsigned long long,	fs_nio)
> > +		__field(unsigned long long,	fs_mio)
> > +		__field(unsigned long long,	fs_gc_dio)
> > +		__field(unsigned long long,	fs_gc_nio)
> > +		__field(unsigned long long,	fs_cp_dio)
> > +		__field(unsigned long long,	fs_cp_nio)
> > +		__field(unsigned long long,	fs_cp_mio)
> > +		__field(unsigned long long,	fs_discard)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		= sbi->sb->s_dev;
> > +		__entry->app_dio	= iostat[APP_DIRECT_IO];
> > +		__entry->app_bio	= iostat[APP_BUFFERED_IO];
> > +		__entry->app_wio	= iostat[APP_WRITE_IO];
> > +		__entry->app_mio	= iostat[APP_MAPPED_IO];
> > +		__entry->fs_dio		= iostat[FS_DATA_IO];
> > +		__entry->fs_nio		= iostat[FS_NODE_IO];
> > +		__entry->fs_mio		= iostat[FS_META_IO];
> > +		__entry->fs_gc_dio	= iostat[FS_GC_DATA_IO];
> > +		__entry->fs_gc_nio	= iostat[FS_GC_NODE_IO];
> > +		__entry->fs_cp_dio	= iostat[FS_CP_DATA_IO];
> > +		__entry->fs_cp_nio	= iostat[FS_CP_NODE_IO];
> > +		__entry->fs_cp_mio	= iostat[FS_CP_META_IO];
> > +		__entry->fs_discard	= iostat[FS_DISCARD];
> > +	),
> > +
> > +	TP_printk("dev = (%d,%d), "
> > +		"app [write=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
> > +		"fs [data=%llu, node=%llu, meta=%llu, discard=%llu], "
> > +		"gc [data=%llu, node=%llu], "
> > +		"cp [data=%llu, node=%llu, meta=%llu]",
> > +		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
> > +		__entry->app_bio, __entry->app_mio, __entry->fs_dio,
> > +		__entry->fs_nio, __entry->fs_mio, __entry->fs_discard,
> > +		__entry->fs_gc_dio, __entry->fs_gc_nio, __entry->fs_cp_dio,
> > +		__entry->fs_cp_nio, __entry->fs_cp_mio)
> > +);
> > +
> >  #endif /* _TRACE_F2FS_H */
> >  
> >   /* This part must be outside protection */
> > 
