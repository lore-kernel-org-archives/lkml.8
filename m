Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7502C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B37321744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHEHuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:50:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:19337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEHuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:50:37 -0400
IronPort-SDR: tYgnDghZUpx3cHh3jKsm5G/rrDG4EYtEcpwCrvu2gDZUH5xWL1F/5q1bzUCSjb82tEA5vO9zc8
 wGYMPfrokBPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="216855835"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="216855835"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:49:56 -0700
IronPort-SDR: +IYOMjJFPPnGv6gxw2E09ge5NtT+sWfK92HRKcVfAJRQw5Ih4ekVx4I1Nm14ts8OuBMmWQ6RkA
 1MZoqBhLiCTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="292861992"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2020 00:49:54 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3EBN-0000eo-IL; Wed, 05 Aug 2020 07:49:53 +0000
Date:   Wed, 5 Aug 2020 15:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vhost/vhost.c:937:16: sparse: sparse: restricted __virtio16
 degrades to integer
Message-ID: <202008051533.Ces1Osqx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost and vringh kconfig
date:   4 months ago
config: riscv-randconfig-s032-20200805 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 20c384f1ea1a0bc7320bc445c72dd02d2970d594
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
>> drivers/vhost/vhost.c:937:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:937:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:937:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:937:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:937:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:937:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
>> drivers/vhost/vhost.c:937:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:937:16: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vhost.c:937:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:922:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:922:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:922:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:922:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] [usertype] <asn:1> * @@
   drivers/vhost/vhost.c:922:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:922:16: sparse:     got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:922:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:922:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:922:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:1014:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1014:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1014:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1014:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:1014:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:1014:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1014:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1014:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1014:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:989:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:989:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:989:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:995:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:995:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:995:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:995:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:995:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:995:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:995:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:995:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:995:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:944:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:944:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:944:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:944:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:944:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:944:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:944:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:944:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:944:16: sparse: sparse: cast from restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1002:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1002:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1002:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] <asn:1> * @@
   drivers/vhost/vhost.c:1002:16: sparse:     expected void *addr
   drivers/vhost/vhost.c:1002:16: sparse:     got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1002:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1002:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *addr @@     got void *addr @@
   drivers/vhost/vhost.c:900:42: sparse:     expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:     got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void * @@
   drivers/vhost/vhost.c:753:17: sparse:     expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:     got void *
   drivers/vhost/vhost.c:1008:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1008:16: sparse: sparse: restricted __virtio16 degrades to integer
   drivers/vhost/vhost.c:1008:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1008:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got restricted __virtio16 [noderef] [usertype] <asn:1> * @@

vim +937 drivers/vhost/vhost.c

3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  743  
f889491380582b4 Jason Wang         2017-02-28  744  static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
f889491380582b4 Jason Wang         2017-02-28  745  					       u64 addr, unsigned int size,
f889491380582b4 Jason Wang         2017-02-28  746  					       int type)
f889491380582b4 Jason Wang         2017-02-28  747  {
f889491380582b4 Jason Wang         2017-02-28  748  	const struct vhost_umem_node *node = vq->meta_iotlb[type];
f889491380582b4 Jason Wang         2017-02-28  749  
f889491380582b4 Jason Wang         2017-02-28  750  	if (!node)
f889491380582b4 Jason Wang         2017-02-28  751  		return NULL;
f889491380582b4 Jason Wang         2017-02-28  752  
f889491380582b4 Jason Wang         2017-02-28 @753  	return (void *)(uintptr_t)(node->userspace_addr + addr - node->start);
f889491380582b4 Jason Wang         2017-02-28  754  }
f889491380582b4 Jason Wang         2017-02-28  755  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  756  /* Can we switch to this memory table? */
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  757  /* Caller should have device mutex but not vq mutex */
ddd3d4081ffa806 Stefan Hajnoczi    2018-04-11  758  static bool memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  759  			     int log_all)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  760  {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  761  	int i;
d47effe1be0c4fc Krishna Kumar      2011-03-01  762  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  763  	for (i = 0; i < d->nvqs; ++i) {
ddd3d4081ffa806 Stefan Hajnoczi    2018-04-11  764  		bool ok;
ea16c51433510f7 Michael S. Tsirkin 2014-06-05  765  		bool log;
ea16c51433510f7 Michael S. Tsirkin 2014-06-05  766  
3ab2e420ec1caf4 Asias He           2013-04-27  767  		mutex_lock(&d->vqs[i]->mutex);
ea16c51433510f7 Michael S. Tsirkin 2014-06-05  768  		log = log_all || vhost_has_feature(d->vqs[i], VHOST_F_LOG_ALL);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  769  		/* If ring is inactive, will check when it's enabled. */
3ab2e420ec1caf4 Asias He           2013-04-27  770  		if (d->vqs[i]->private_data)
a9709d6874d5513 Jason Wang         2016-06-23  771  			ok = vq_memory_access_ok(d->vqs[i]->log_base,
a9709d6874d5513 Jason Wang         2016-06-23  772  						 umem, log);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  773  		else
ddd3d4081ffa806 Stefan Hajnoczi    2018-04-11  774  			ok = true;
3ab2e420ec1caf4 Asias He           2013-04-27  775  		mutex_unlock(&d->vqs[i]->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  776  		if (!ok)
ddd3d4081ffa806 Stefan Hajnoczi    2018-04-11  777  			return false;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  778  	}
ddd3d4081ffa806 Stefan Hajnoczi    2018-04-11  779  	return true;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  780  }
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  781  
6b1e6cc7855b09a Jason Wang         2016-06-23  782  static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
6b1e6cc7855b09a Jason Wang         2016-06-23  783  			  struct iovec iov[], int iov_size, int access);
bfe2bc512884d0b Jason Wang         2016-06-23  784  
72952cc0614b616 Michael S. Tsirkin 2016-12-06  785  static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
bfe2bc512884d0b Jason Wang         2016-06-23  786  			      const void *from, unsigned size)
bfe2bc512884d0b Jason Wang         2016-06-23  787  {
6b1e6cc7855b09a Jason Wang         2016-06-23  788  	int ret;
6b1e6cc7855b09a Jason Wang         2016-06-23  789  
6b1e6cc7855b09a Jason Wang         2016-06-23  790  	if (!vq->iotlb)
bfe2bc512884d0b Jason Wang         2016-06-23  791  		return __copy_to_user(to, from, size);
6b1e6cc7855b09a Jason Wang         2016-06-23  792  	else {
6b1e6cc7855b09a Jason Wang         2016-06-23  793  		/* This function should be called after iotlb
6b1e6cc7855b09a Jason Wang         2016-06-23  794  		 * prefetch, which means we're sure that all vq
6b1e6cc7855b09a Jason Wang         2016-06-23  795  		 * could be access through iotlb. So -EAGAIN should
6b1e6cc7855b09a Jason Wang         2016-06-23  796  		 * not happen in this case.
6b1e6cc7855b09a Jason Wang         2016-06-23  797  		 */
6b1e6cc7855b09a Jason Wang         2016-06-23  798  		struct iov_iter t;
f889491380582b4 Jason Wang         2017-02-28  799  		void __user *uaddr = vhost_vq_meta_fetch(vq,
f889491380582b4 Jason Wang         2017-02-28  800  				     (u64)(uintptr_t)to, size,
7ced6c98c7ab7a1 Eric Auger         2018-04-11  801  				     VHOST_ADDR_USED);
f889491380582b4 Jason Wang         2017-02-28  802  
f889491380582b4 Jason Wang         2017-02-28  803  		if (uaddr)
f889491380582b4 Jason Wang         2017-02-28  804  			return __copy_to_user(uaddr, from, size);
f889491380582b4 Jason Wang         2017-02-28  805  
6b1e6cc7855b09a Jason Wang         2016-06-23  806  		ret = translate_desc(vq, (u64)(uintptr_t)to, size, vq->iotlb_iov,
6b1e6cc7855b09a Jason Wang         2016-06-23  807  				     ARRAY_SIZE(vq->iotlb_iov),
6b1e6cc7855b09a Jason Wang         2016-06-23  808  				     VHOST_ACCESS_WO);
6b1e6cc7855b09a Jason Wang         2016-06-23  809  		if (ret < 0)
6b1e6cc7855b09a Jason Wang         2016-06-23  810  			goto out;
6b1e6cc7855b09a Jason Wang         2016-06-23  811  		iov_iter_init(&t, WRITE, vq->iotlb_iov, ret, size);
6b1e6cc7855b09a Jason Wang         2016-06-23  812  		ret = copy_to_iter(from, size, &t);
6b1e6cc7855b09a Jason Wang         2016-06-23  813  		if (ret == size)
6b1e6cc7855b09a Jason Wang         2016-06-23  814  			ret = 0;
6b1e6cc7855b09a Jason Wang         2016-06-23  815  	}
6b1e6cc7855b09a Jason Wang         2016-06-23  816  out:
6b1e6cc7855b09a Jason Wang         2016-06-23  817  	return ret;
bfe2bc512884d0b Jason Wang         2016-06-23  818  }
bfe2bc512884d0b Jason Wang         2016-06-23  819  
bfe2bc512884d0b Jason Wang         2016-06-23  820  static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
72952cc0614b616 Michael S. Tsirkin 2016-12-06  821  				void __user *from, unsigned size)
bfe2bc512884d0b Jason Wang         2016-06-23  822  {
6b1e6cc7855b09a Jason Wang         2016-06-23  823  	int ret;
6b1e6cc7855b09a Jason Wang         2016-06-23  824  
6b1e6cc7855b09a Jason Wang         2016-06-23  825  	if (!vq->iotlb)
bfe2bc512884d0b Jason Wang         2016-06-23  826  		return __copy_from_user(to, from, size);
6b1e6cc7855b09a Jason Wang         2016-06-23  827  	else {
6b1e6cc7855b09a Jason Wang         2016-06-23  828  		/* This function should be called after iotlb
6b1e6cc7855b09a Jason Wang         2016-06-23  829  		 * prefetch, which means we're sure that vq
6b1e6cc7855b09a Jason Wang         2016-06-23  830  		 * could be access through iotlb. So -EAGAIN should
6b1e6cc7855b09a Jason Wang         2016-06-23  831  		 * not happen in this case.
6b1e6cc7855b09a Jason Wang         2016-06-23  832  		 */
f889491380582b4 Jason Wang         2017-02-28  833  		void __user *uaddr = vhost_vq_meta_fetch(vq,
f889491380582b4 Jason Wang         2017-02-28  834  				     (u64)(uintptr_t)from, size,
f889491380582b4 Jason Wang         2017-02-28  835  				     VHOST_ADDR_DESC);
6b1e6cc7855b09a Jason Wang         2016-06-23  836  		struct iov_iter f;
f889491380582b4 Jason Wang         2017-02-28  837  
f889491380582b4 Jason Wang         2017-02-28  838  		if (uaddr)
f889491380582b4 Jason Wang         2017-02-28  839  			return __copy_from_user(to, uaddr, size);
f889491380582b4 Jason Wang         2017-02-28  840  
6b1e6cc7855b09a Jason Wang         2016-06-23  841  		ret = translate_desc(vq, (u64)(uintptr_t)from, size, vq->iotlb_iov,
6b1e6cc7855b09a Jason Wang         2016-06-23  842  				     ARRAY_SIZE(vq->iotlb_iov),
6b1e6cc7855b09a Jason Wang         2016-06-23  843  				     VHOST_ACCESS_RO);
6b1e6cc7855b09a Jason Wang         2016-06-23  844  		if (ret < 0) {
6b1e6cc7855b09a Jason Wang         2016-06-23  845  			vq_err(vq, "IOTLB translation failure: uaddr "
6b1e6cc7855b09a Jason Wang         2016-06-23  846  			       "%p size 0x%llx\n", from,
6b1e6cc7855b09a Jason Wang         2016-06-23  847  			       (unsigned long long) size);
6b1e6cc7855b09a Jason Wang         2016-06-23  848  			goto out;
6b1e6cc7855b09a Jason Wang         2016-06-23  849  		}
6b1e6cc7855b09a Jason Wang         2016-06-23  850  		iov_iter_init(&f, READ, vq->iotlb_iov, ret, size);
6b1e6cc7855b09a Jason Wang         2016-06-23  851  		ret = copy_from_iter(to, size, &f);
6b1e6cc7855b09a Jason Wang         2016-06-23  852  		if (ret == size)
6b1e6cc7855b09a Jason Wang         2016-06-23  853  			ret = 0;
6b1e6cc7855b09a Jason Wang         2016-06-23  854  	}
6b1e6cc7855b09a Jason Wang         2016-06-23  855  
6b1e6cc7855b09a Jason Wang         2016-06-23  856  out:
6b1e6cc7855b09a Jason Wang         2016-06-23  857  	return ret;
6b1e6cc7855b09a Jason Wang         2016-06-23  858  }
6b1e6cc7855b09a Jason Wang         2016-06-23  859  
f889491380582b4 Jason Wang         2017-02-28  860  static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
f889491380582b4 Jason Wang         2017-02-28  861  					  void __user *addr, unsigned int size,
f889491380582b4 Jason Wang         2017-02-28  862  					  int type)
6b1e6cc7855b09a Jason Wang         2016-06-23  863  {
6b1e6cc7855b09a Jason Wang         2016-06-23  864  	int ret;
6b1e6cc7855b09a Jason Wang         2016-06-23  865  
6b1e6cc7855b09a Jason Wang         2016-06-23  866  	ret = translate_desc(vq, (u64)(uintptr_t)addr, size, vq->iotlb_iov,
6b1e6cc7855b09a Jason Wang         2016-06-23  867  			     ARRAY_SIZE(vq->iotlb_iov),
6b1e6cc7855b09a Jason Wang         2016-06-23  868  			     VHOST_ACCESS_RO);
6b1e6cc7855b09a Jason Wang         2016-06-23  869  	if (ret < 0) {
6b1e6cc7855b09a Jason Wang         2016-06-23  870  		vq_err(vq, "IOTLB translation failure: uaddr "
6b1e6cc7855b09a Jason Wang         2016-06-23  871  			"%p size 0x%llx\n", addr,
6b1e6cc7855b09a Jason Wang         2016-06-23  872  			(unsigned long long) size);
6b1e6cc7855b09a Jason Wang         2016-06-23  873  		return NULL;
6b1e6cc7855b09a Jason Wang         2016-06-23  874  	}
6b1e6cc7855b09a Jason Wang         2016-06-23  875  
6b1e6cc7855b09a Jason Wang         2016-06-23  876  	if (ret != 1 || vq->iotlb_iov[0].iov_len != size) {
6b1e6cc7855b09a Jason Wang         2016-06-23  877  		vq_err(vq, "Non atomic userspace memory access: uaddr "
6b1e6cc7855b09a Jason Wang         2016-06-23  878  			"%p size 0x%llx\n", addr,
6b1e6cc7855b09a Jason Wang         2016-06-23  879  			(unsigned long long) size);
6b1e6cc7855b09a Jason Wang         2016-06-23  880  		return NULL;
6b1e6cc7855b09a Jason Wang         2016-06-23  881  	}
6b1e6cc7855b09a Jason Wang         2016-06-23  882  
6b1e6cc7855b09a Jason Wang         2016-06-23  883  	return vq->iotlb_iov[0].iov_base;
6b1e6cc7855b09a Jason Wang         2016-06-23  884  }
6b1e6cc7855b09a Jason Wang         2016-06-23  885  
f889491380582b4 Jason Wang         2017-02-28  886  /* This function should be called after iotlb
f889491380582b4 Jason Wang         2017-02-28  887   * prefetch, which means we're sure that vq
f889491380582b4 Jason Wang         2017-02-28  888   * could be access through iotlb. So -EAGAIN should
f889491380582b4 Jason Wang         2017-02-28  889   * not happen in this case.
f889491380582b4 Jason Wang         2017-02-28  890   */
f889491380582b4 Jason Wang         2017-02-28  891  static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
f889491380582b4 Jason Wang         2017-02-28  892  					    void *addr, unsigned int size,
f889491380582b4 Jason Wang         2017-02-28  893  					    int type)
f889491380582b4 Jason Wang         2017-02-28  894  {
f889491380582b4 Jason Wang         2017-02-28  895  	void __user *uaddr = vhost_vq_meta_fetch(vq,
f889491380582b4 Jason Wang         2017-02-28  896  			     (u64)(uintptr_t)addr, size, type);
f889491380582b4 Jason Wang         2017-02-28  897  	if (uaddr)
f889491380582b4 Jason Wang         2017-02-28  898  		return uaddr;
f889491380582b4 Jason Wang         2017-02-28  899  
f889491380582b4 Jason Wang         2017-02-28  900  	return __vhost_get_user_slow(vq, addr, size, type);
f889491380582b4 Jason Wang         2017-02-28  901  }
f889491380582b4 Jason Wang         2017-02-28  902  
6b1e6cc7855b09a Jason Wang         2016-06-23  903  #define vhost_put_user(vq, x, ptr)		\
6b1e6cc7855b09a Jason Wang         2016-06-23  904  ({ \
6b1e6cc7855b09a Jason Wang         2016-06-23  905  	int ret = -EFAULT; \
6b1e6cc7855b09a Jason Wang         2016-06-23  906  	if (!vq->iotlb) { \
6b1e6cc7855b09a Jason Wang         2016-06-23  907  		ret = __put_user(x, ptr); \
6b1e6cc7855b09a Jason Wang         2016-06-23  908  	} else { \
6b1e6cc7855b09a Jason Wang         2016-06-23  909  		__typeof__(ptr) to = \
f889491380582b4 Jason Wang         2017-02-28  910  			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
f889491380582b4 Jason Wang         2017-02-28  911  					  sizeof(*ptr), VHOST_ADDR_USED); \
6b1e6cc7855b09a Jason Wang         2016-06-23  912  		if (to != NULL) \
6b1e6cc7855b09a Jason Wang         2016-06-23  913  			ret = __put_user(x, to); \
6b1e6cc7855b09a Jason Wang         2016-06-23  914  		else \
6b1e6cc7855b09a Jason Wang         2016-06-23  915  			ret = -EFAULT;	\
6b1e6cc7855b09a Jason Wang         2016-06-23  916  	} \
6b1e6cc7855b09a Jason Wang         2016-06-23  917  	ret; \
6b1e6cc7855b09a Jason Wang         2016-06-23  918  })
6b1e6cc7855b09a Jason Wang         2016-06-23  919  
7b5d753ebc22c5b Jason Wang         2019-05-24  920  static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
7b5d753ebc22c5b Jason Wang         2019-05-24  921  {
7b5d753ebc22c5b Jason Wang         2019-05-24  922  	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
7b5d753ebc22c5b Jason Wang         2019-05-24  923  			      vhost_avail_event(vq));
7b5d753ebc22c5b Jason Wang         2019-05-24  924  }
7b5d753ebc22c5b Jason Wang         2019-05-24  925  
7b5d753ebc22c5b Jason Wang         2019-05-24  926  static inline int vhost_put_used(struct vhost_virtqueue *vq,
7b5d753ebc22c5b Jason Wang         2019-05-24  927  				 struct vring_used_elem *head, int idx,
7b5d753ebc22c5b Jason Wang         2019-05-24  928  				 int count)
7b5d753ebc22c5b Jason Wang         2019-05-24  929  {
7b5d753ebc22c5b Jason Wang         2019-05-24  930  	return vhost_copy_to_user(vq, vq->used->ring + idx, head,
7b5d753ebc22c5b Jason Wang         2019-05-24  931  				  count * sizeof(*head));
7b5d753ebc22c5b Jason Wang         2019-05-24  932  }
7b5d753ebc22c5b Jason Wang         2019-05-24  933  
7b5d753ebc22c5b Jason Wang         2019-05-24  934  static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
7b5d753ebc22c5b Jason Wang         2019-05-24  935  
7b5d753ebc22c5b Jason Wang         2019-05-24  936  {
7b5d753ebc22c5b Jason Wang         2019-05-24 @937  	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
7b5d753ebc22c5b Jason Wang         2019-05-24  938  			      &vq->used->flags);
7b5d753ebc22c5b Jason Wang         2019-05-24  939  }
7b5d753ebc22c5b Jason Wang         2019-05-24  940  

:::::: The code at line 937 was first introduced by commit
:::::: 7b5d753ebc22c5b6935a70ce9a857dc6220784f8 vhost: fine grain userspace memory accessors

:::::: TO: Jason Wang <jasowang@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sG8891tlxfofmbcXixK2AQA=

--M9NhX3UHpAaciwkO--
