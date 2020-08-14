Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB3FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CAE206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHNTA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:00:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1152 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgHNTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:00:25 -0400
X-IronPort-AV: E=Sophos;i="5.76,313,1592863200"; 
   d="scan'208";a="356565336"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 21:00:21 +0200
Date:   Fri, 14 Aug 2020 21:00:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: fs/ocfs2/suballoc.c:2430:2-8: preceding lock on line 2413
In-Reply-To: <878sehl5e4.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2008142059190.2441@hadrien>
References: <202008141412.mP88ccpD%lkp@intel.com> <878sehl5e4.fsf@nanos.tec.linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Aug 2020, Thomas Gleixner wrote:

> On Fri, Aug 14 2020 at 14:11, kernel test robot wrote:
> >
> > coccinelle warnings: (new ones prefixed by >>)
> >
> >>> fs/ocfs2/suballoc.c:2430:2-8: preceding lock on line 2413
> >
> > vim +2430 fs/ocfs2/suballoc.c
> >
> > 415cb800375cc4 Mark Fasheh     2007-09-16  2379
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2380  static int ocfs2_block_group_clear_bits(handle_t *handle,
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2381  					struct inode *alloc_inode,
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2382  					struct ocfs2_group_desc *bg,
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2383  					struct buffer_head *group_bh,
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2384  					unsigned int bit_off,
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2385  					unsigned int num_bits,
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2386  					void (*undo_fn)(unsigned int bit,
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2387  							unsigned long *bmap))
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2388  {
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2389  	int status;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2390  	unsigned int tmp;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2391  	struct ocfs2_group_desc *undo_bg = NULL;
> > 464170647b5648 Thomas Gleixner 2019-08-09  2392  	struct journal_head *jh;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2393
> > 42035306132802 Joel Becker     2008-11-13  2394  	/* The caller got this descriptor from
> > 42035306132802 Joel Becker     2008-11-13  2395  	 * ocfs2_read_group_descriptor().  Any corruption is a code bug. */
> > 42035306132802 Joel Becker     2008-11-13  2396  	BUG_ON(!OCFS2_IS_VALID_GROUP_DESC(bg));
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2397
> > 2f73e135b83c50 Tao Ma          2011-02-22  2398  	trace_ocfs2_block_group_clear_bits(bit_off, num_bits);
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2399
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2400  	BUG_ON(undo_fn && !ocfs2_is_cluster_bitmap(alloc_inode));
> > 0cf2f7632b1789 Joel Becker     2009-02-12  2401  	status = ocfs2_journal_access_gd(handle, INODE_CACHE(alloc_inode),
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2402  					 group_bh,
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2403  					 undo_fn ?
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2404  					 OCFS2_JOURNAL_ACCESS_UNDO :
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2405  					 OCFS2_JOURNAL_ACCESS_WRITE);
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2406  	if (status < 0) {
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2407  		mlog_errno(status);
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2408  		goto bail;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2409  	}
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2410
> > 464170647b5648 Thomas Gleixner 2019-08-09  2411  	jh = bh2jh(group_bh);
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2412  	if (undo_fn) {
> > 464170647b5648 Thomas Gleixner 2019-08-09 @2413  		spin_lock(&jh->b_state_lock);
> > 464170647b5648 Thomas Gleixner 2019-08-09  2414  		undo_bg = (struct ocfs2_group_desc *) jh->b_committed_data;
> > 94e41ecfe0f202 Sunil Mushran   2009-06-19  2415  		BUG_ON(!undo_bg);
> > 94e41ecfe0f202 Sunil Mushran   2009-06-19  2416  	}
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2417
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2418  	tmp = num_bits;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2419  	while(tmp--) {
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2420  		ocfs2_clear_bit((bit_off + tmp),
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2421  				(unsigned long *) bg->bg_bitmap);
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2422  		if (undo_fn)
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2423  			undo_fn(bit_off + tmp,
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2424  				(unsigned long *) undo_bg->bg_bitmap);
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2425  	}
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2426  	le16_add_cpu(&bg->bg_free_bits_count, num_bits);
> > 9b5cd10e4c14a1 Srinivas Eeda   2010-10-05  2427  	if (le16_to_cpu(bg->bg_free_bits_count) > le16_to_cpu(bg->bg_bits)) {
> > e75ed71be4f2f7 Changwei Ge     2018-01-31  2428  		if (undo_fn)
> > 464170647b5648 Thomas Gleixner 2019-08-09  2429  			spin_unlock(&jh->b_state_lock);
> > 7ecef14ab1db96 Joe Perches     2015-09-04 @2430  		return ocfs2_error(alloc_inode->i_sb, "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
> > 9b5cd10e4c14a1 Srinivas Eeda   2010-10-05  2431  				   (unsigned long long)le64_to_cpu(bg->bg_blkno),
> > 9b5cd10e4c14a1 Srinivas Eeda   2010-10-05  2432  				   le16_to_cpu(bg->bg_bits),
> > 7ecef14ab1db96 Joe Perches     2015-09-04  2433  				   le16_to_cpu(bg->bg_free_bits_count),
> > 7ecef14ab1db96 Joe Perches     2015-09-04  2434  				   num_bits);
> > 9b5cd10e4c14a1 Srinivas Eeda   2010-10-05  2435  	}
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2436
> > b4414eea0e7b9c Mark Fasheh     2010-03-11  2437  	if (undo_fn)
> > 464170647b5648 Thomas Gleixner 2019-08-09  2438  		spin_unlock(&jh->b_state_lock);
> > 94e41ecfe0f202 Sunil Mushran   2009-06-19  2439
> > ec20cec7a35158 Joel Becker     2010-03-19  2440  	ocfs2_journal_dirty(handle, group_bh);
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2441  bail:
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2442  	return status;
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2443  }
> > ccd979bdbce9fb Mark Fasheh     2005-12-15  2444
>
> That's clearly a false positive. Is there anything what can be done to
> help that cocci script here?

I have a better version that needs to get pushed.

But normally these pass through me.  Did you get it directly from kbuild?

julia
