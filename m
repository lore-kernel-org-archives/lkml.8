Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E2B20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgESRAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:00:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:64760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbgESRAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:00:32 -0400
IronPort-SDR: lvEgJZga74tMOXWfNDhEFksX1kJc+hUAoKr24DXaRfCkTjW13A3rJohmCEt1Ygbu4TIOob/k3k
 8nsTv4Y4hQYg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:58:19 -0700
IronPort-SDR: yiPcOwAfPKpTJ7yPKForvvp3pUbNndJ7Jy0/AU73HejZWXSgZ9M0XnXYyANzHMeicSEUp4sCS8
 24nzpvzRBwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="gz'50?scan'50,208,50";a="289024014"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 09:58:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jb5ZI-000BcN-Ib; Wed, 20 May 2020 00:58:16 +0800
Date:   Wed, 20 May 2020 00:57:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vhost/vhost.c:1603:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202005200022.yczjkPeJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   642b151f45dd54809ea00ecd3976a56c1ec9b53d
commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost and vringh kconfig
date:   7 weeks ago
config: m68k-randconfig-s001-20200519 (attached as .config)
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout 20c384f1ea1a0bc7320bc445c72dd02d2970d594
        # save the attached .config to linux build tree
        make C=1 ARCH=m68k CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/vhost/vhost.c:1603:13: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got unsigned int [noderef] [usertypvoid const *__gu_ptr @@
>> drivers/vhost/vhost.c:1603:13: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1603:13: sparse:    got unsigned int [noderef] [usertype] <asn:1> *idxp
>> drivers/vhost/vhost.c:1800:21: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got int [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1800:21: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1800:21: sparse:    got int [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:937:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:937:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:937:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:922:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] [usertype] <asvoid *addr @@
   drivers/vhost/vhost.c:922:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:922:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
>> drivers/vhost/vhost.c:1014:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1014:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1014:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1014:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:1014:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1014:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
>> drivers/vhost/vhost.c:1014:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1014:16: sparse:    expected void const *__gu_ptr
>> drivers/vhost/vhost.c:1014:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:995:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:995:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:995:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:995:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:995:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:995:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:995:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:995:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:995:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:944:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:944:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:944:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1002:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1002:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:1002:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1002:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1002:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1002:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
>> drivers/vhost/vhost.c:1008:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderef] [usertypvoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1008:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:1008:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:1008:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] [usertype] <asvoid *addr @@
   drivers/vhost/vhost.c:1008:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1008:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
>> drivers/vhost/vhost.c:1008:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderef] [usertypvoid const *__gu_ptr @@
   drivers/vhost/vhost.c:1008:16: sparse:    expected void const *__gu_ptr
>> drivers/vhost/vhost.c:1008:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got restricted __virtio16 [noderevoid const *__gu_ptr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void const *__gu_ptr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *from
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
--
   drivers/vhost/scsi.c:1218:30: sparse: sparse: restricted __virtio32 degrades to integer
   drivers/vhost/scsi.c:1218:30: sparse: sparse: restricted __virtio32 degrades to integer
>> drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got unsigned int [noderef] [usertypvoid const *__gu_ptr @@
>> drivers/vhost/scsi.c:1697:21: sparse:    expected void const *__gu_ptr
   drivers/vhost/scsi.c:1697:21: sparse:    got unsigned int [noderef] [usertype] <asn:1> *eventsp

vim +1603 drivers/vhost/vhost.c

feebcaeac79ad86 Jason Wang         2019-05-24  1566  
feebcaeac79ad86 Jason Wang         2019-05-24  1567  static long vhost_vring_set_num_addr(struct vhost_dev *d,
feebcaeac79ad86 Jason Wang         2019-05-24  1568  				     struct vhost_virtqueue *vq,
feebcaeac79ad86 Jason Wang         2019-05-24  1569  				     unsigned int ioctl,
feebcaeac79ad86 Jason Wang         2019-05-24  1570  				     void __user *argp)
feebcaeac79ad86 Jason Wang         2019-05-24  1571  {
feebcaeac79ad86 Jason Wang         2019-05-24  1572  	long r;
feebcaeac79ad86 Jason Wang         2019-05-24  1573  
feebcaeac79ad86 Jason Wang         2019-05-24  1574  	mutex_lock(&vq->mutex);
feebcaeac79ad86 Jason Wang         2019-05-24  1575  
feebcaeac79ad86 Jason Wang         2019-05-24  1576  	switch (ioctl) {
feebcaeac79ad86 Jason Wang         2019-05-24  1577  	case VHOST_SET_VRING_NUM:
feebcaeac79ad86 Jason Wang         2019-05-24  1578  		r = vhost_vring_set_num(d, vq, argp);
feebcaeac79ad86 Jason Wang         2019-05-24  1579  		break;
feebcaeac79ad86 Jason Wang         2019-05-24  1580  	case VHOST_SET_VRING_ADDR:
feebcaeac79ad86 Jason Wang         2019-05-24  1581  		r = vhost_vring_set_addr(d, vq, argp);
feebcaeac79ad86 Jason Wang         2019-05-24  1582  		break;
feebcaeac79ad86 Jason Wang         2019-05-24  1583  	default:
feebcaeac79ad86 Jason Wang         2019-05-24  1584  		BUG();
feebcaeac79ad86 Jason Wang         2019-05-24  1585  	}
feebcaeac79ad86 Jason Wang         2019-05-24  1586  
feebcaeac79ad86 Jason Wang         2019-05-24  1587  	mutex_unlock(&vq->mutex);
feebcaeac79ad86 Jason Wang         2019-05-24  1588  
feebcaeac79ad86 Jason Wang         2019-05-24  1589  	return r;
feebcaeac79ad86 Jason Wang         2019-05-24  1590  }
26b36604523f4a6 Sonny Rao          2018-03-14  1591  long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1592  {
cecb46f194460d2 Al Viro            2012-08-27  1593  	struct file *eventfp, *filep = NULL;
cecb46f194460d2 Al Viro            2012-08-27  1594  	bool pollstart = false, pollstop = false;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1595  	struct eventfd_ctx *ctx = NULL;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1596  	u32 __user *idxp = argp;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1597  	struct vhost_virtqueue *vq;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1598  	struct vhost_vring_state s;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1599  	struct vhost_vring_file f;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1600  	u32 idx;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1601  	long r;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1602  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14 @1603  	r = get_user(idx, idxp);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1604  	if (r < 0)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1605  		return r;
0f3d9a17469d71b Krishna Kumar      2010-05-25  1606  	if (idx >= d->nvqs)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1607  		return -ENOBUFS;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1608  
ff002269a4ee9c7 Jason Wang         2018-10-30  1609  	idx = array_index_nospec(idx, d->nvqs);
3ab2e420ec1caf4 Asias He           2013-04-27  1610  	vq = d->vqs[idx];
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1611  
feebcaeac79ad86 Jason Wang         2019-05-24  1612  	if (ioctl == VHOST_SET_VRING_NUM ||
feebcaeac79ad86 Jason Wang         2019-05-24  1613  	    ioctl == VHOST_SET_VRING_ADDR) {
feebcaeac79ad86 Jason Wang         2019-05-24  1614  		return vhost_vring_set_num_addr(d, vq, ioctl, argp);
feebcaeac79ad86 Jason Wang         2019-05-24  1615  	}
feebcaeac79ad86 Jason Wang         2019-05-24  1616  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1617  	mutex_lock(&vq->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1618  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1619  	switch (ioctl) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1620  	case VHOST_SET_VRING_BASE:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1621  		/* Moving base with an active backend?
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1622  		 * You don't want to do that. */
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1623  		if (vq->private_data) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1624  			r = -EBUSY;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1625  			break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1626  		}
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1627  		if (copy_from_user(&s, argp, sizeof s)) {
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1628  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1629  			break;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1630  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1631  		if (s.num > 0xffff) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1632  			r = -EINVAL;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1633  			break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1634  		}
8d65843c44269c2 Jason Wang         2017-07-27  1635  		vq->last_avail_idx = s.num;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1636  		/* Forget the cached index value. */
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1637  		vq->avail_idx = vq->last_avail_idx;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1638  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1639  	case VHOST_GET_VRING_BASE:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1640  		s.index = idx;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1641  		s.num = vq->last_avail_idx;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1642  		if (copy_to_user(argp, &s, sizeof s))
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1643  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1644  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1645  	case VHOST_SET_VRING_KICK:
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1646  		if (copy_from_user(&f, argp, sizeof f)) {
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1647  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1648  			break;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1649  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1650  		eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1651  		if (IS_ERR(eventfp)) {
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1652  			r = PTR_ERR(eventfp);
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1653  			break;
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1654  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1655  		if (eventfp != vq->kick) {
cecb46f194460d2 Al Viro            2012-08-27  1656  			pollstop = (filep = vq->kick) != NULL;
cecb46f194460d2 Al Viro            2012-08-27  1657  			pollstart = (vq->kick = eventfp) != NULL;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1658  		} else
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1659  			filep = eventfp;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1660  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1661  	case VHOST_SET_VRING_CALL:
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1662  		if (copy_from_user(&f, argp, sizeof f)) {
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1663  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1664  			break;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1665  		}
e050c7d93f4adb2 Eric Biggers       2018-01-06  1666  		ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
e050c7d93f4adb2 Eric Biggers       2018-01-06  1667  		if (IS_ERR(ctx)) {
e050c7d93f4adb2 Eric Biggers       2018-01-06  1668  			r = PTR_ERR(ctx);
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1669  			break;
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1670  		}
e050c7d93f4adb2 Eric Biggers       2018-01-06  1671  		swap(ctx, vq->call_ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1672  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1673  	case VHOST_SET_VRING_ERR:
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1674  		if (copy_from_user(&f, argp, sizeof f)) {
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1675  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1676  			break;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1677  		}
09f332a589232f5 Eric Biggers       2018-01-06  1678  		ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
09f332a589232f5 Eric Biggers       2018-01-06  1679  		if (IS_ERR(ctx)) {
09f332a589232f5 Eric Biggers       2018-01-06  1680  			r = PTR_ERR(ctx);
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1681  			break;
535297a6ae4c3b7 Michael S. Tsirkin 2010-03-17  1682  		}
09f332a589232f5 Eric Biggers       2018-01-06  1683  		swap(ctx, vq->error_ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1684  		break;
2751c9882b94729 Greg Kurz          2015-04-24  1685  	case VHOST_SET_VRING_ENDIAN:
2751c9882b94729 Greg Kurz          2015-04-24  1686  		r = vhost_set_vring_endian(vq, argp);
2751c9882b94729 Greg Kurz          2015-04-24  1687  		break;
2751c9882b94729 Greg Kurz          2015-04-24  1688  	case VHOST_GET_VRING_ENDIAN:
2751c9882b94729 Greg Kurz          2015-04-24  1689  		r = vhost_get_vring_endian(vq, idx, argp);
2751c9882b94729 Greg Kurz          2015-04-24  1690  		break;
030881372460654 Jason Wang         2016-03-04  1691  	case VHOST_SET_VRING_BUSYLOOP_TIMEOUT:
030881372460654 Jason Wang         2016-03-04  1692  		if (copy_from_user(&s, argp, sizeof(s))) {
030881372460654 Jason Wang         2016-03-04  1693  			r = -EFAULT;
030881372460654 Jason Wang         2016-03-04  1694  			break;
030881372460654 Jason Wang         2016-03-04  1695  		}
030881372460654 Jason Wang         2016-03-04  1696  		vq->busyloop_timeout = s.num;
030881372460654 Jason Wang         2016-03-04  1697  		break;
030881372460654 Jason Wang         2016-03-04  1698  	case VHOST_GET_VRING_BUSYLOOP_TIMEOUT:
030881372460654 Jason Wang         2016-03-04  1699  		s.index = idx;
030881372460654 Jason Wang         2016-03-04  1700  		s.num = vq->busyloop_timeout;
030881372460654 Jason Wang         2016-03-04  1701  		if (copy_to_user(argp, &s, sizeof(s)))
030881372460654 Jason Wang         2016-03-04  1702  			r = -EFAULT;
030881372460654 Jason Wang         2016-03-04  1703  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1704  	default:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1705  		r = -ENOIOCTLCMD;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1706  	}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1707  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1708  	if (pollstop && vq->handle_kick)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1709  		vhost_poll_stop(&vq->poll);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1710  
e050c7d93f4adb2 Eric Biggers       2018-01-06  1711  	if (!IS_ERR_OR_NULL(ctx))
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1712  		eventfd_ctx_put(ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1713  	if (filep)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1714  		fput(filep);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1715  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1716  	if (pollstart && vq->handle_kick)
2b8b328b61c7999 Jason Wang         2013-01-28  1717  		r = vhost_poll_start(&vq->poll, vq->kick);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1718  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1719  	mutex_unlock(&vq->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1720  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1721  	if (pollstop && vq->handle_kick)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1722  		vhost_poll_flush(&vq->poll);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1723  	return r;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1724  }
6ac1afbf6132df0 Asias He           2013-05-06  1725  EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1726  
6b1e6cc7855b09a Jason Wang         2016-06-23  1727  int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
6b1e6cc7855b09a Jason Wang         2016-06-23  1728  {
6b1e6cc7855b09a Jason Wang         2016-06-23  1729  	struct vhost_umem *niotlb, *oiotlb;
6b1e6cc7855b09a Jason Wang         2016-06-23  1730  	int i;
6b1e6cc7855b09a Jason Wang         2016-06-23  1731  
6b1e6cc7855b09a Jason Wang         2016-06-23  1732  	niotlb = vhost_umem_alloc();
6b1e6cc7855b09a Jason Wang         2016-06-23  1733  	if (!niotlb)
6b1e6cc7855b09a Jason Wang         2016-06-23  1734  		return -ENOMEM;
6b1e6cc7855b09a Jason Wang         2016-06-23  1735  
6b1e6cc7855b09a Jason Wang         2016-06-23  1736  	oiotlb = d->iotlb;
6b1e6cc7855b09a Jason Wang         2016-06-23  1737  	d->iotlb = niotlb;
6b1e6cc7855b09a Jason Wang         2016-06-23  1738  
6b1e6cc7855b09a Jason Wang         2016-06-23  1739  	for (i = 0; i < d->nvqs; ++i) {
b13f9c6364373a1 Jason Wang         2018-08-08  1740  		struct vhost_virtqueue *vq = d->vqs[i];
b13f9c6364373a1 Jason Wang         2018-08-08  1741  
b13f9c6364373a1 Jason Wang         2018-08-08  1742  		mutex_lock(&vq->mutex);
b13f9c6364373a1 Jason Wang         2018-08-08  1743  		vq->iotlb = niotlb;
b13f9c6364373a1 Jason Wang         2018-08-08  1744  		__vhost_vq_meta_reset(vq);
b13f9c6364373a1 Jason Wang         2018-08-08  1745  		mutex_unlock(&vq->mutex);
6b1e6cc7855b09a Jason Wang         2016-06-23  1746  	}
6b1e6cc7855b09a Jason Wang         2016-06-23  1747  
6b1e6cc7855b09a Jason Wang         2016-06-23  1748  	vhost_umem_clean(oiotlb);
6b1e6cc7855b09a Jason Wang         2016-06-23  1749  
6b1e6cc7855b09a Jason Wang         2016-06-23  1750  	return 0;
6b1e6cc7855b09a Jason Wang         2016-06-23  1751  }
6b1e6cc7855b09a Jason Wang         2016-06-23  1752  EXPORT_SYMBOL_GPL(vhost_init_device_iotlb);
6b1e6cc7855b09a Jason Wang         2016-06-23  1753  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1754  /* Caller must have device mutex */
935cdee7ee15956 Michael S. Tsirkin 2012-12-06  1755  long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1756  {
d25cc43c6775bff Eric Biggers       2018-01-06  1757  	struct eventfd_ctx *ctx;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1758  	u64 p;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1759  	long r;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1760  	int i, fd;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1761  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1762  	/* If you are not the owner, you can become one */
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1763  	if (ioctl == VHOST_SET_OWNER) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1764  		r = vhost_dev_set_owner(d);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1765  		goto done;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1766  	}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1767  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1768  	/* You must be the owner to do anything else */
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1769  	r = vhost_dev_check_owner(d);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1770  	if (r)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1771  		goto done;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1772  
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1773  	switch (ioctl) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1774  	case VHOST_SET_MEM_TABLE:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1775  		r = vhost_set_memory(d, argp);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1776  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1777  	case VHOST_SET_LOG_BASE:
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1778  		if (copy_from_user(&p, argp, sizeof p)) {
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1779  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1780  			break;
7ad9c9d27048547 Takuya Yoshikawa   2010-05-27  1781  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1782  		if ((u64)(unsigned long)p != p) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1783  			r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1784  			break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1785  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1786  		for (i = 0; i < d->nvqs; ++i) {
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1787  			struct vhost_virtqueue *vq;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1788  			void __user *base = (void __user *)(unsigned long)p;
3ab2e420ec1caf4 Asias He           2013-04-27  1789  			vq = d->vqs[i];
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1790  			mutex_lock(&vq->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1791  			/* If ring is inactive, will check when it's enabled. */
ea16c51433510f7 Michael S. Tsirkin 2014-06-05  1792  			if (vq->private_data && !vq_log_access_ok(vq, base))
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1793  				r = -EFAULT;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1794  			else
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1795  				vq->log_base = base;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1796  			mutex_unlock(&vq->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1797  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1798  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1799  	case VHOST_SET_LOG_FD:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14 @1800  		r = get_user(fd, (int __user *)argp);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1801  		if (r < 0)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1802  			break;
d25cc43c6775bff Eric Biggers       2018-01-06  1803  		ctx = fd == -1 ? NULL : eventfd_ctx_fdget(fd);
d25cc43c6775bff Eric Biggers       2018-01-06  1804  		if (IS_ERR(ctx)) {
d25cc43c6775bff Eric Biggers       2018-01-06  1805  			r = PTR_ERR(ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1806  			break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1807  		}
d25cc43c6775bff Eric Biggers       2018-01-06  1808  		swap(ctx, d->log_ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1809  		for (i = 0; i < d->nvqs; ++i) {
3ab2e420ec1caf4 Asias He           2013-04-27  1810  			mutex_lock(&d->vqs[i]->mutex);
3ab2e420ec1caf4 Asias He           2013-04-27  1811  			d->vqs[i]->log_ctx = d->log_ctx;
3ab2e420ec1caf4 Asias He           2013-04-27  1812  			mutex_unlock(&d->vqs[i]->mutex);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1813  		}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1814  		if (ctx)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1815  			eventfd_ctx_put(ctx);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1816  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1817  	default:
935cdee7ee15956 Michael S. Tsirkin 2012-12-06  1818  		r = -ENOIOCTLCMD;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1819  		break;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1820  	}
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1821  done:
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1822  	return r;
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1823  }
6ac1afbf6132df0 Asias He           2013-05-06  1824  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  1825  

:::::: The code at line 1603 was first introduced by commit
:::::: 3a4d5c94e959359ece6d6b55045c3f046677f55c vhost_net: a kernel-level virtio server

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NfMbQGD5bO4N/x+rviv7geIBAA==

--d6Gm4EdcadzBjdND--
