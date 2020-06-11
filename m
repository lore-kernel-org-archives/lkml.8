Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3732074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591916447;
	bh=fpXBct85M7YMNzdjuE/p3J94/BvpSvWQ9ehY7kS1kPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fNXjZERUlaMBG8Jw/WLlWddZ7i94Kb4wS3qlnqd+DFUYZQZUV/kXisJU4MlK6Wubg
	 DVl7hb8IjmPfuJlFz7v3M2tSLQfdPb9Rodxy+cigmmcHjzMjhiT2Py8tHdRklipmNA
	 zJ8BzE3tepMEOqR85nfk6djq//lzwUbsQF8K42NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFKXAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgFKXAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:00:45 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F3F20656;
        Thu, 11 Jun 2020 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591916444;
        bh=fpXBct85M7YMNzdjuE/p3J94/BvpSvWQ9ehY7kS1kPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hl9lJDj5hMdqfdtxhXFJMgSjHN+Z/CraRbwwWCcLiVymydsNmB3cZjwGuB4HpozmD
         Bwdrx6KXC9oXmmBvLpv8srDeA6srkbd+0SKpM5r7oOmSaSupEhK8YLaTS/PTUxucLE
         /PbDlt1kdiPZHwwHWmdMy+l/uBsPPESB0Wm6GXaU=
Date:   Thu, 11 Jun 2020 16:00:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200611230043.GA18185@gmail.com>
References: <20200611031652.200401-1-daeho43@gmail.com>
 <20200611162721.GB1152@sol.localdomain>
 <CACOAw_zKC24BhNOF2BpuRfuYzBEsis82MafU9HqXwLj2sZ3Azg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zKC24BhNOF2BpuRfuYzBEsis82MafU9HqXwLj2sZ3Azg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:49:12AM +0900, Daeho Jeong wrote:
> 2020년 6월 12일 (금) 오전 1:27, Eric Biggers <ebiggers@kernel.org>님이 작성:
> >
> > On Thu, Jun 11, 2020 at 12:16:52PM +0900, Daeho Jeong wrote:
> > > +     for (index = pg_start; index < pg_end;) {
> > > +             struct dnode_of_data dn;
> > > +             unsigned int end_offset;
> > > +
> > > +             set_new_dnode(&dn, inode, NULL, NULL, 0);
> > > +             ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> > > +             if (ret)
> > > +                     goto out;
> > > +
> > > +             end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> > > +             if (pg_end < end_offset + index)
> > > +                     end_offset = pg_end - index;
> > > +
> > > +             for (; dn.ofs_in_node < end_offset;
> > > +                             dn.ofs_in_node++, index++) {
> > > +                     struct block_device *cur_bdev;
> > > +                     block_t blkaddr = f2fs_data_blkaddr(&dn);
> > > +
> > > +                     if (__is_valid_data_blkaddr(blkaddr)) {
> > > +                             if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> > > +                                     blkaddr, DATA_GENERIC_ENHANCE)) {
> > > +                                     ret = -EFSCORRUPTED;
> > > +                                     goto out;
> > > +                             }
> > > +                     } else
> > > +                             continue;
> > > +
> > > +                     cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
> > > +                     if (f2fs_is_multi_device(sbi)) {
> > > +                             int i = f2fs_target_device_index(sbi, blkaddr);
> > > +
> > > +                             blkaddr -= FDEV(i).start_blk;
> > > +                     }
> > > +
> > > +                     if (len) {
> > > +                             if (prev_bdev == cur_bdev &&
> > > +                                     blkaddr == prev_block + len) {
> > > +                                     len++;
> > > +                             } else {
> > > +                                     ret = f2fs_secure_erase(prev_bdev,
> > > +                                                     prev_block, len, flags);
> > > +                                     if (ret)
> > > +                                             goto out;
> > > +
> > > +                                     len = 0;
> > > +                             }
> > > +                     }
> > > +
> > > +                     if (!len) {
> > > +                             prev_bdev = cur_bdev;
> > > +                             prev_block = blkaddr;
> > > +                             len = 1;
> > > +                     }
> > > +             }
> > > +
> > > +             f2fs_put_dnode(&dn);
> > > +     }
> >
> > This loop processes the entire file, which may be very large.  So it could take
> > a very long time to execute.
> >
> > It should at least use the following to make the task killable and preemptible:
> >
> >                 if (fatal_signal_pending(current)) {
> >                         err = -EINTR;
> >                         goto out;
> >                 }
> >                 cond_resched();
> >
> 
> Good point!
> 
> > Also, perhaps this ioctl should be made incremental, i.e. take in an
> > (offset, length) like pwrite()?
> >
> > - Eric
> 
> Discard and Zeroing will be treated in a unit of block, which is 4KB
> in F2FS case.
> Do you really need the (offset, length) option here even if the unit
> is a 4KB block? I guess this option might make the user even
> inconvenienced to use this ioctl, because they have to bear 4KB
> alignment in mind.

The ioctl as currently proposed always erases the entire file, which could be
gigabytes.  That could take a very long time.

I'm suggesting considering making it possible to call the ioctl multiple times
to process the file incrementally, like you would do with write() or pwrite().

That implies that for each ioctl call, the length would need to be specified
unless it's hardcoded to 4KiB which would be very inefficient.  Users would
probably want to process a larger amount at a time, like 1 MiB, right?

Likewise the offset would need to be specified as well, unless it were to be
taken implicitly from f_pos.

- Eric
