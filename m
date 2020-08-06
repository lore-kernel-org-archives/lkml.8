Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7EDC43458
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5388E22D2C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHFGEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:04:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:43922 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHFGEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:04:49 -0400
IronPort-SDR: p/3qmjFwIoBm7JTj2yCnQxe9DMkutEIZiajDseKnDZs/qyUpswoK8Kjz4LnDTlRfVzozGysIMf
 CVkvRKh8RD/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214247590"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="214247590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 23:04:48 -0700
IronPort-SDR: +Kbpvy8yFe+JO1SZPtnPemvUJulfKmGNbHp7B3gQMETDw0cCHy28Rx8o7ZVJncPLDjZ7Aoy44A
 yoO10tAWXQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="331134303"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2020 23:04:46 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3Z1C-00018K-5w; Thu, 06 Aug 2020 06:04:46 +0000
Date:   Thu, 6 Aug 2020 14:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: fs/fuse/virtio_fs.c:1009:6: warning: Variable 'err' is reassigned a
 value before the old one has been used.
Message-ID: <202008061415.sHRFePnn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
commit: a62a8ef9d97da23762a588592c8b8eb50a8deb6a virtio-fs: add virtiofs filesystem
date:   11 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/fuse/virtio_fs.c:1009:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = -ENOMEM;
        ^
   fs/fuse/virtio_fs.c:1003:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -EINVAL;
        ^
   fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   fs/fuse/virtio_fs.c:1020:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = fuse_fill_super_common(sb, &ctx);
        ^
   fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = -ENOMEM;
        ^
   fs/fuse/virtio_fs.c:1020:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = fuse_fill_super_common(sb, &ctx);
        ^

vim +/err +1009 fs/fuse/virtio_fs.c

   979	
   980	static int virtio_fs_fill_super(struct super_block *sb)
   981	{
   982		struct fuse_conn *fc = get_fuse_conn_super(sb);
   983		struct virtio_fs *fs = fc->iq.priv;
   984		unsigned int i;
   985		int err;
   986		struct fuse_fs_context ctx = {
   987			.rootmode = S_IFDIR,
   988			.default_permissions = 1,
   989			.allow_other = 1,
   990			.max_read = UINT_MAX,
   991			.blksize = 512,
   992			.destroy = true,
   993			.no_control = true,
   994			.no_force_umount = true,
   995		};
   996	
   997		mutex_lock(&virtio_fs_mutex);
   998	
   999		/* After holding mutex, make sure virtiofs device is still there.
  1000		 * Though we are holding a reference to it, drive ->remove might
  1001		 * still have cleaned up virtual queues. In that case bail out.
  1002		 */
  1003		err = -EINVAL;
  1004		if (list_empty(&fs->list)) {
  1005			pr_info("virtio-fs: tag <%s> not found\n", fs->tag);
  1006			goto err;
  1007		}
  1008	
> 1009		err = -ENOMEM;
  1010		/* Allocate fuse_dev for hiprio and notification queues */
  1011		for (i = 0; i < VQ_REQUEST; i++) {
  1012			struct virtio_fs_vq *fsvq = &fs->vqs[i];
  1013	
  1014			fsvq->fud = fuse_dev_alloc();
  1015			if (!fsvq->fud)
  1016				goto err_free_fuse_devs;
  1017		}
  1018	
  1019		ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
  1020		err = fuse_fill_super_common(sb, &ctx);
  1021		if (err < 0)
  1022			goto err_free_fuse_devs;
  1023	
  1024		fc = fs->vqs[VQ_REQUEST].fud->fc;
  1025	
  1026		for (i = 0; i < fs->nvqs; i++) {
  1027			struct virtio_fs_vq *fsvq = &fs->vqs[i];
  1028	
  1029			if (i == VQ_REQUEST)
  1030				continue; /* already initialized */
  1031			fuse_dev_install(fsvq->fud, fc);
  1032		}
  1033	
  1034		/* Previous unmount will stop all queues. Start these again */
  1035		virtio_fs_start_all_queues(fs);
  1036		fuse_send_init(fc);
  1037		mutex_unlock(&virtio_fs_mutex);
  1038		return 0;
  1039	
  1040	err_free_fuse_devs:
  1041		virtio_fs_free_devs(fs);
  1042	err:
  1043		mutex_unlock(&virtio_fs_mutex);
  1044		return err;
  1045	}
  1046	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
