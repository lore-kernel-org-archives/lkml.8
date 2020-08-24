Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B5420738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHXR1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:27:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:49301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgHXR1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:27:08 -0400
IronPort-SDR: D4g4jGWIpGI7ZlDMPpR/vasx9EoXDC1N0CafeUDivBHScoHlKU9qOFsG3AuDlkWNjM8lnlwmsf
 A3sGMnho4q4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153368281"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="gz'50?scan'50,208,50";a="153368281"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 10:23:37 -0700
IronPort-SDR: oLZfuySETHy/T33lmLuuLl81baS8Jp30D5mZNGXhM8XsEpVpDS6tZPiJyKkffbF6mVufyuXpzc
 no7jsY1ta5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="gz'50?scan'50,208,50";a="498997726"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2020 10:23:34 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAGBx-0000HU-Tq; Mon, 24 Aug 2020 17:23:33 +0000
Date:   Tue, 25 Aug 2020 01:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/drm_bufs.c:343:36: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202008250103.0JApDdsb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d012a7190fc1fd72ed48911e77ca97ba4521bccd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   10 weeks ago
config: arc-randconfig-s032-20200824 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/drm_bufs.c:225:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:225:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:225:45: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_bufs.c:228:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:228:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:228:45: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_bufs.c:343:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *handle @@
>> drivers/gpu/drm/drm_bufs.c:343:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:343:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:360:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:360:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:536:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:536:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:536:28: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/arc/include/asm/uaccess.h:619:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *d_char @@     got void [noderef] __user *to @@
   arch/arc/include/asm/uaccess.h:619:33: sparse:     expected unsigned char *d_char
   arch/arc/include/asm/uaccess.h:619:33: sparse:     got void [noderef] __user *to
--
>> drivers/gpu/drm/drm_vm.c:276:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *handle @@
>> drivers/gpu/drm/drm_vm.c:276:44: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/drm_vm.c:276:44: sparse:     got void *handle
   drivers/gpu/drm/drm_vm.c:487:51: sparse: sparse: undefined identifier '_PAGE_RW'
   drivers/gpu/drm/drm_vm.c:571:51: sparse: sparse: undefined identifier '_PAGE_RW'
--
>> drivers/scsi/megaraid.c:4489:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/megaraid.c:4489:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4489:26: sparse:     got void *
   drivers/scsi/megaraid.c:4548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4548:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4548:26: sparse:     got void *
--
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr @@
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr
--
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/arc/include/asm/uaccess.h:619:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *d_char @@     got void [noderef] __user *to @@
   arch/arc/include/asm/uaccess.h:619:33: sparse:     expected unsigned char *d_char
   arch/arc/include/asm/uaccess.h:619:33: sparse:     got void [noderef] __user *to
--
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[assigned] emap @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +343 drivers/gpu/drm/drm_bufs.c

9a18664506dbce drivers/char/drm/drm_bufs.c Dave Airlie            2005-06-23  136  
abee5491db9f33 drivers/gpu/drm/drm_bufs.c  Benjamin Gaignard      2020-03-06  137  /*
f77d390c9779c4 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  138   * Core function to create a range of memory available for mapping by a
f77d390c9779c4 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  139   * non-root process.
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  140   *
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  141   * Adjusts the memory offset to its absolute value according to the mapping
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  142   * type.  Adds the map to the map list drm_device::maplist. Adds MTRR's where
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  143   * applicable and if supported by the kernel.
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  144   */
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  145  static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
c60ce623bd1613 drivers/char/drm/drm_bufs.c Dave Airlie            2007-07-11  146  			   unsigned int size, enum drm_map_type type,
55910517af381e drivers/char/drm/drm_bufs.c Dave Airlie            2007-07-11  147  			   enum drm_map_flags flags,
55910517af381e drivers/char/drm/drm_bufs.c Dave Airlie            2007-07-11  148  			   struct drm_map_list **maplist)
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  149  {
f77d390c9779c4 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  150  	struct drm_local_map *map;
55910517af381e drivers/char/drm/drm_bufs.c Dave Airlie            2007-07-11  151  	struct drm_map_list *list;
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  152  	unsigned long user_token;
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  153  	int ret;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  154  
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  155  	map = kmalloc(sizeof(*map), GFP_KERNEL);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  156  	if (!map)
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  157  		return -ENOMEM;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  158  
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  159  	map->offset = offset;
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  160  	map->size = size;
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  161  	map->flags = flags;
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  162  	map->type = type;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  163  
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  164  	/* Only allow shared memory to be removable since we only keep enough
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  165  	 * book keeping information about shared memory to allow for removal
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  166  	 * when processes fork.
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  167  	 */
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  168  	if ((map->flags & _DRM_REMOVABLE) && map->type != _DRM_SHM) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  169  		kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  170  		return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  171  	}
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  172  	DRM_DEBUG("offset = 0x%08llx, size = 0x%08lx, type = %d\n",
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  173  		  (unsigned long long)map->offset, map->size, map->type);
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  174  
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  175  	/* page-align _DRM_SHM maps. They are allocated here so there is no security
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  176  	 * hole created by that and it works around various broken drivers that use
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  177  	 * a non-aligned quantity to map the SAREA. --BenH
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  178  	 */
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  179  	if (map->type == _DRM_SHM)
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  180  		map->size = PAGE_ALIGN(map->size);
b674137755bbe2 drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-05-18  181  
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  182  	if ((map->offset & (~(resource_size_t)PAGE_MASK)) || (map->size & (~PAGE_MASK))) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  183  		kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  184  		return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  185  	}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  186  	map->mtrr = -1;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  187  	map->handle = NULL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  188  
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  189  	switch (map->type) {
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  190  	case _DRM_REGISTERS:
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  191  	case _DRM_FRAME_BUFFER:
4b7fb9b5746554 drivers/gpu/drm/drm_bufs.c  Jordan Crouse          2010-05-27  192  #if !defined(__sparc__) && !defined(__alpha__) && !defined(__ia64__) && !defined(__powerpc64__) && !defined(__x86_64__) && !defined(__arm__)
8d2ea6258123d7 drivers/char/drm/drm_bufs.c Dave Airlie            2006-01-11  193  		if (map->offset + (map->size-1) < map->offset ||
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  194  		    map->offset < virt_to_phys(high_memory)) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  195  			kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  196  			return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  197  		}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  198  #endif
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  199  		/* Some drivers preinitialize some maps, without the X Server
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  200  		 * needing to be aware of it.  Therefore, we just return success
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  201  		 * when the server tries to create a duplicate map.
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  202  		 */
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  203  		list = drm_find_matching_map(dev, map);
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  204  		if (list != NULL) {
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  205  			if (list->map->size != map->size) {
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  206  				DRM_DEBUG("Matching maps of type %d with "
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  207  					  "mismatched sizes, (%ld vs %ld)\n",
b5e89ed53ed8d2 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-25  208  					  map->type, map->size,
b5e89ed53ed8d2 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-25  209  					  list->map->size);
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  210  				list->map->size = map->size;
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  211  			}
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  212  
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  213  			kfree(map);
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  214  			*maplist = list;
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  215  			return 0;
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  216  		}
836cf0465c422e drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  217  
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  218  		if (map->type == _DRM_FRAME_BUFFER ||
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  219  		    (map->flags & _DRM_WRITE_COMBINING)) {
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13  220  			map->mtrr =
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13  221  				arch_phys_wc_add(map->offset, map->size);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  222  		}
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  223  		if (map->type == _DRM_REGISTERS) {
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13  224  			if (map->flags & _DRM_WRITE_COMBINING)
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13 @225  				map->handle = ioremap_wc(map->offset,
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13  226  							 map->size);
ff47eaf24d01b5 drivers/gpu/drm/drm_bufs.c  Andy Lutomirski        2013-05-13  227  			else
004a7727421fd2 drivers/char/drm/drm_bufs.c Christoph Hellwig      2007-01-08  228  				map->handle = ioremap(map->offset, map->size);
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  229  			if (!map->handle) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  230  				kfree(map);
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  231  				return -ENOMEM;
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  232  			}
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  233  		}
0769d39c993145 drivers/char/drm/drm_bufs.c Scott Thompson         2007-08-25  234  
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  235  		break;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  236  	case _DRM_SHM:
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  237  		list = drm_find_matching_map(dev, map);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  238  		if (list != NULL) {
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  239  			if (list->map->size != map->size) {
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  240  				DRM_DEBUG("Matching maps of type %d with "
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  241  					  "mismatched sizes, (%ld vs %ld)\n",
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  242  					  map->type, map->size, list->map->size);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  243  				list->map->size = map->size;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  244  			}
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  245  
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  246  			kfree(map);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  247  			*maplist = list;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  248  			return 0;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  249  		}
f239b7b0cac068 drivers/char/drm/drm_bufs.c Thomas Hellstrom       2007-01-08  250  		map->handle = vmalloc_user(map->size);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  251  		DRM_DEBUG("%lu %d %p\n",
04420c9c6a6d02 drivers/gpu/drm/drm_bufs.c  Daniel Vetter          2013-07-10  252  			  map->size, order_base_2(map->size), map->handle);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  253  		if (!map->handle) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  254  			kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  255  			return -ENOMEM;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  256  		}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  257  		map->offset = (unsigned long)map->handle;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  258  		if (map->flags & _DRM_CONTAINS_LOCK) {
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  259  			/* Prevent a 2nd X Server from creating a 2nd lock */
95c081c17f284d drivers/gpu/drm/drm_bufs.c  Daniel Vetter          2016-06-21  260  			if (dev->master->lock.hw_lock != NULL) {
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  261  				vfree(map->handle);
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  262  				kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  263  				return -EBUSY;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  264  			}
95c081c17f284d drivers/gpu/drm/drm_bufs.c  Daniel Vetter          2016-06-21  265  			dev->sigdata.lock = dev->master->lock.hw_lock = map->handle;	/* Pointer to lock */
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  266  		}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  267  		break;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  268  	case _DRM_AGP: {
55910517af381e drivers/char/drm/drm_bufs.c Dave Airlie            2007-07-11  269  		struct drm_agp_mem *entry;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  270  		int valid = 0;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  271  
d9906753bb997d drivers/gpu/drm/drm_bufs.c  Daniel Vetter          2013-12-11  272  		if (!dev->agp) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  273  			kfree(map);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  274  			return -EINVAL;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  275  		}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  276  #ifdef __alpha__
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  277  		map->offset += dev->hose->mem_space->start;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  278  #endif
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  279  		/* In some cases (i810 driver), user space may have already
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  280  		 * added the AGP base itself, because dev->agp->base previously
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  281  		 * only got set during AGP enable.  So, only add the base
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  282  		 * address if the map's offset isn't already within the
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  283  		 * aperture.
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  284  		 */
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  285  		if (map->offset < dev->agp->base ||
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  286  		    map->offset > dev->agp->base +
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  287  		    dev->agp->agp_info.aper_size * 1024 * 1024 - 1) {
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  288  			map->offset += dev->agp->base;
47a184a80800dd drivers/char/drm/drm_bufs.c Eric Anholt            2007-11-22  289  		}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  290  		map->mtrr = dev->agp->agp_mtrr;	/* for getmap */
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  291  
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  292  		/* This assumes the DRM is in total control of AGP space.
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  293  		 * It's not always the case as AGP can be in the control
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  294  		 * of user space (i.e. i810 driver). So this loop will get
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  295  		 * skipped and we double check that dev->agp->memory is
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  296  		 * actually set as well as being invalid before EPERM'ing
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  297  		 */
bd1b331fae2813 drivers/char/drm/drm_bufs.c Dave Airlie            2007-05-26  298  		list_for_each_entry(entry, &dev->agp->memory, head) {
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  299  			if ((map->offset >= entry->bound) &&
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  300  			    (map->offset + map->size <= entry->bound + entry->pages * PAGE_SIZE)) {
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  301  				valid = 1;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  302  				break;
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  303  			}
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  304  		}
bd1b331fae2813 drivers/char/drm/drm_bufs.c Dave Airlie            2007-05-26  305  		if (!list_empty(&dev->agp->memory) && !valid) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  306  			kfree(map);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  307  			return -EPERM;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  308  		}
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  309  		DRM_DEBUG("AGP offset = 0x%08llx, size = 0x%08lx\n",
41c2e75e60200a drivers/gpu/drm/drm_bufs.c  Benjamin Herrenschmidt 2009-02-02  310  			  (unsigned long long)map->offset, map->size);
54ba2f76e28128 drivers/char/drm/drm_bufs.c Dave Airlie            2007-02-10  311  
a2c0a97b784f83 drivers/gpu/drm/drm_bufs.c  Jesse Barnes           2008-11-05  312  		break;
812c369dbf3b5a drivers/gpu/drm/drm_bufs.c  Pekka Paalanen         2009-09-17  313  	}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  314  	case _DRM_SCATTER_GATHER:
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  315  		if (!dev->sg) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  316  			kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  317  			return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  318  		}
d1f2b55ad2c11f drivers/char/drm/drm_bufs.c Dave Airlie            2005-08-05  319  		map->offset += (unsigned long)dev->sg->virtual;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  320  		break;
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  321  	case _DRM_CONSISTENT:
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  322  		/* dma_addr_t is 64bit on i386 with CONFIG_HIGHMEM64G,
9c8da5ebbf6f87 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  323  		 * As we're limiting the address to 2^32-1 (or less),
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  324  		 * casting it down to 32 bits is no problem, but we
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  325  		 * need to point to a 64bit variable first. */
8e4ff9b5695728 drivers/gpu/drm/drm_bufs.c  Chris Wilson           2020-02-02  326  		map->handle = dma_alloc_coherent(&dev->pdev->dev,
8e4ff9b5695728 drivers/gpu/drm/drm_bufs.c  Chris Wilson           2020-02-02  327  						 map->size,
8e4ff9b5695728 drivers/gpu/drm/drm_bufs.c  Chris Wilson           2020-02-02  328  						 &map->offset,
8e4ff9b5695728 drivers/gpu/drm/drm_bufs.c  Chris Wilson           2020-02-02  329  						 GFP_KERNEL);
8e4ff9b5695728 drivers/gpu/drm/drm_bufs.c  Chris Wilson           2020-02-02  330  		if (!map->handle) {
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  331  			kfree(map);
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  332  			return -ENOMEM;
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  333  		}
2d0f9eaff8e1d0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  334  		break;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  335  	default:
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  336  		kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  337  		return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  338  	}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  339  
94e3370eb9fc00 drivers/gpu/drm/drm_bufs.c  Davidlohr Bueso        2010-08-11  340  	list = kzalloc(sizeof(*list), GFP_KERNEL);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  341  	if (!list) {
85abb3f95010b2 drivers/char/drm/drm_bufs.c Amol Lad               2006-10-25  342  		if (map->type == _DRM_REGISTERS)
004a7727421fd2 drivers/char/drm/drm_bufs.c Christoph Hellwig      2007-01-08 @343  			iounmap(map->handle);
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  344  		kfree(map);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  345  		return -EINVAL;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  346  	}
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  347  	list->map = map;
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  348  
30e2fb18819490 drivers/char/drm/drm_bufs.c Dave Airlie            2006-02-02  349  	mutex_lock(&dev->struct_mutex);
bd1b331fae2813 drivers/char/drm/drm_bufs.c Dave Airlie            2007-05-26  350  	list_add(&list->head, &dev->maplist);
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  351  
d1f2b55ad2c11f drivers/char/drm/drm_bufs.c Dave Airlie            2005-08-05  352  	/* Assign a 32-bit handle */
30e2fb18819490 drivers/char/drm/drm_bufs.c Dave Airlie            2006-02-02  353  	/* We do it here so that dev->struct_mutex protects the increment */
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  354  	user_token = (map->type == _DRM_SHM) ? (unsigned long)map->handle :
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  355  		map->offset;
f1a2a9b6189f9f drivers/gpu/drm/drm_bufs.c  David Miller           2009-02-18  356  	ret = drm_map_handle(dev, &list->hash, user_token, 0,
f1a2a9b6189f9f drivers/gpu/drm/drm_bufs.c  David Miller           2009-02-18  357  			     (map->type == _DRM_SHM));
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  358  	if (ret) {
85abb3f95010b2 drivers/char/drm/drm_bufs.c Amol Lad               2006-10-25  359  		if (map->type == _DRM_REGISTERS)
004a7727421fd2 drivers/char/drm/drm_bufs.c Christoph Hellwig      2007-01-08  360  			iounmap(map->handle);
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  361  		kfree(map);
9a298b2acd771d drivers/gpu/drm/drm_bufs.c  Eric Anholt            2009-03-24  362  		kfree(list);
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  363  		mutex_unlock(&dev->struct_mutex);
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  364  		return ret;
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  365  	}
8d153f7107ff2c drivers/char/drm/drm_bufs.c Thomas Hellstrom       2006-08-07  366  
1545085a28f226 drivers/char/drm/drm_bufs.c Thomas Hellstrom       2007-02-08  367  	list->user_token = list->hash.key << PAGE_SHIFT;
30e2fb18819490 drivers/char/drm/drm_bufs.c Dave Airlie            2006-02-02  368  	mutex_unlock(&dev->struct_mutex);
^1da177e4c3f41 drivers/char/drm/drm_bufs.c Linus Torvalds         2005-04-16  369  
2ff2e8a3e1898e drivers/gpu/drm/drm_bufs.c  Ben Skeggs             2009-05-26  370  	if (!(map->flags & _DRM_DRIVER))
95c081c17f284d drivers/gpu/drm/drm_bufs.c  Daniel Vetter          2016-06-21  371  		list->master = dev->master;
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  372  	*maplist = list;
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  373  	return 0;
7ab984012a879a drivers/char/drm/drm_bufs.c Dave Airlie            2005-07-10  374  }
89625eb186b9b0 drivers/char/drm/drm_bufs.c Dave Airlie            2005-09-05  375  

:::::: The code at line 343 was first introduced by commit
:::::: 004a7727421fd202bbdfcc0231a3359085199a52 drm: remove drm_ioremap and drm_ioremapfree

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Dave Airlie <airlied@linux.ie>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qYEO1PMBAA==

--IS0zKkzwUGydFO0o--
