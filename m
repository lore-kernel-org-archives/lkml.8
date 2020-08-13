Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E46C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6449F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMDZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:25:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:12838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMDZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:25:36 -0400
IronPort-SDR: 8+6AVFieao2MvkTXCEzILH8nuLvungDlYEVuPGKRWVrh/eAZO0/BJ3GpRNYaV4JPeUjnb8xy+b
 2GdCtsiwCO0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="154118527"
X-IronPort-AV: E=Sophos;i="5.76,306,1592895600"; 
   d="scan'208";a="154118527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 20:25:35 -0700
IronPort-SDR: /N+snecoYOyufz4f/9cjP8OdC9GKwYdjkD8OCYNp6iRffh5Ar30dghL00IDP6/6rKOElFnJIqn
 EfebgRDJEpIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,306,1592895600"; 
   d="scan'208";a="495723043"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2020 20:25:33 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k63rw-0000PH-ND; Thu, 13 Aug 2020 03:25:32 +0000
Date:   Thu, 13 Aug 2020 11:24:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heinz Mauelshagen <heinzm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        Damien Le Moal <DamienLeMoal@wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: drivers/md/dm-ebs-target.c:264:4: warning: Variable 'r' is
 reassigned a value before the old one has been used.
Message-ID: <202008131154.Nz5YMTHY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc06fe51d26efc100ac74121607c01a454867c91
commit: d3c7b35c20d60650bac8b55c17b194adda03a979 dm: add emulated block size target
date:   3 months ago
compiler: sparc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/md/dm-ebs-target.c:264:4: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
    r = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &ec->dev);
      ^
   drivers/md/dm-ebs-target.c:237:4: note: Variable 'r' is reassigned a value before the old one has been used.
    r = -EINVAL;
      ^
   drivers/md/dm-ebs-target.c:264:4: note: Variable 'r' is reassigned a value before the old one has been used.
    r = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &ec->dev);
      ^

vim +/r +264 drivers/md/dm-ebs-target.c

   208	
   209	/*
   210	 * Construct an emulated block size mapping: <dev_path> <offset> <ebs> [<ubs>]
   211	 *
   212	 * <dev_path>: path of the underlying device
   213	 * <offset>: offset in 512 bytes sectors into <dev_path>
   214	 * <ebs>: emulated block size in units of 512 bytes exposed to the upper layer
   215	 * [<ubs>]: underlying block size in units of 512 bytes imposed on the lower layer;
   216	 * 	    optional, if not supplied, retrieve logical block size from underlying device
   217	 */
   218	static int ebs_ctr(struct dm_target *ti, unsigned int argc, char **argv)
   219	{
   220		int r;
   221		unsigned short tmp1;
   222		unsigned long long tmp;
   223		char dummy;
   224		struct ebs_c *ec;
   225	
   226		if (argc < 3 || argc > 4) {
   227			ti->error = "Invalid argument count";
   228			return -EINVAL;
   229		}
   230	
   231		ec = ti->private = kzalloc(sizeof(*ec), GFP_KERNEL);
   232		if (!ec) {
   233			ti->error = "Cannot allocate ebs context";
   234			return -ENOMEM;
   235		}
   236	
   237		r = -EINVAL;
   238		if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1 ||
   239		    tmp != (sector_t)tmp ||
   240		    (sector_t)tmp >= ti->len) {
   241			ti->error = "Invalid device offset sector";
   242			goto bad;
   243		}
   244		ec->start = tmp;
   245	
   246		if (sscanf(argv[2], "%hu%c", &tmp1, &dummy) != 1 ||
   247		    !__ebs_check_bs(tmp1) ||
   248		    to_bytes(tmp1) > PAGE_SIZE) {
   249			ti->error = "Invalid emulated block size";
   250			goto bad;
   251		}
   252		ec->e_bs = tmp1;
   253	
   254		if (argc > 3) {
   255			if (sscanf(argv[3], "%hu%c", &tmp1, &dummy) != 1 || !__ebs_check_bs(tmp1)) {
   256				ti->error = "Invalid underlying block size";
   257				goto bad;
   258			}
   259			ec->u_bs = tmp1;
   260			ec->u_bs_set = true;
   261		} else
   262			ec->u_bs_set = false;
   263	
 > 264		r = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &ec->dev);
   265		if (r) {
   266			ti->error = "Device lookup failed";
   267			ec->dev = NULL;
   268			goto bad;
   269		}
   270	
   271		r = -EINVAL;
   272		if (!ec->u_bs_set) {
   273			ec->u_bs = to_sector(bdev_logical_block_size(ec->dev->bdev));
   274			if (!__ebs_check_bs(ec->u_bs)) {
   275				ti->error = "Invalid retrieved underlying block size";
   276				goto bad;
   277			}
   278		}
   279	
   280		if (!ec->u_bs_set && ec->e_bs == ec->u_bs)
   281			DMINFO("Emulation superfluous: emulated equal to underlying block size");
   282	
   283		if (__block_mod(ec->start, ec->u_bs)) {
   284			ti->error = "Device offset must be multiple of underlying block size";
   285			goto bad;
   286		}
   287	
   288		ec->bufio = dm_bufio_client_create(ec->dev->bdev, to_bytes(ec->u_bs), 1, 0, NULL, NULL);
   289		if (IS_ERR(ec->bufio)) {
   290			ti->error = "Cannot create dm bufio client";
   291			r = PTR_ERR(ec->bufio);
   292			ec->bufio = NULL;
   293			goto bad;
   294		}
   295	
   296		ec->wq = alloc_ordered_workqueue("dm-" DM_MSG_PREFIX, WQ_MEM_RECLAIM);
   297		if (!ec->wq) {
   298			ti->error = "Cannot create dm-" DM_MSG_PREFIX " workqueue";
   299			r = -ENOMEM;
   300			goto bad;
   301		}
   302	
   303		ec->block_shift = __ffs(ec->u_bs);
   304		INIT_WORK(&ec->ws, &__ebs_process_bios);
   305		bio_list_init(&ec->bios_in);
   306		spin_lock_init(&ec->lock);
   307	
   308		ti->num_flush_bios = 1;
   309		ti->num_discard_bios = 1;
   310		ti->num_secure_erase_bios = 0;
   311		ti->num_write_same_bios = 0;
   312		ti->num_write_zeroes_bios = 0;
   313		return 0;
   314	bad:
   315		ebs_dtr(ti);
   316		return r;
   317	}
   318	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
