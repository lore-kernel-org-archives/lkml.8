Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C942065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgEOFeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:34:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:18658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgEOFeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:34:16 -0400
IronPort-SDR: 8qFklpnb/1JJC2nfv4a+bwILfNy7OvgUxstd+dI4u3adXtfMR4tAbpMjA3OoGcnqNaqIPRYC9p
 VyeeOp9ZrF1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 22:34:11 -0700
IronPort-SDR: uXufvtbniNnroduGJRKqmguWgO7u5amVn2dGMryEBVmoJLuY1ceHizxjTL0+pWKPKwz7qze9Z+
 Zcao8twYoWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="266493650"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 22:34:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZSz3-000FC1-9S; Fri, 15 May 2020 13:34:09 +0800
Date:   Fri, 15 May 2020 13:33:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vhost/vhost.c:1014:16: sparse: sparse: cast to restricted
 __virtio16
Message-ID: <202005151312.W9HdqsHa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ae7efb388540adc1653a51a3bc3b2c9cef5ec1a
commit: 20c384f1ea1a0bc7320bc445c72dd02d2970d594 vhost: refine vhost and vringh kconfig
date:   6 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout 20c384f1ea1a0bc7320bc445c72dd02d2970d594
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

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
>> drivers/vhost/vhost.c:1014:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1014:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:1014:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1014:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
>> drivers/vhost/vhost.c:1014:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:995:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:995:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:995:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:995:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:995:16: sparse: sparse: cast to restricted __virtio16
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
   drivers/vhost/vhost.c:1002:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1002:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:1002:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1002:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:1002:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:1008:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:1008:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] [usertype] <asvoid *addr @@
   drivers/vhost/vhost.c:1008:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1008:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:1008:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:989:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void *addr @@    got restricted __virtio16 [noderef] <asvoid *addr @@
   drivers/vhost/vhost.c:989:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:989:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:989:16: sparse: sparse: cast to restricted __virtio16
   drivers/vhost/vhost.c:900:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:1> *addr @@    got n:1> *addr @@
   drivers/vhost/vhost.c:900:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:900:42: sparse:    got void *addr
   drivers/vhost/vhost.c:753:17: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
   drivers/vhost/vhost.c:753:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:753:17: sparse:    got void *

vim +1014 drivers/vhost/vhost.c

7b5d753ebc22c5 Jason Wang 2019-05-24  1010  
7b5d753ebc22c5 Jason Wang 2019-05-24  1011  static inline int vhost_get_used_idx(struct vhost_virtqueue *vq,
7b5d753ebc22c5 Jason Wang 2019-05-24  1012  				     __virtio16 *idx)
7b5d753ebc22c5 Jason Wang 2019-05-24  1013  {
7b5d753ebc22c5 Jason Wang 2019-05-24 @1014  	return vhost_get_used(vq, *idx, &vq->used->idx);
7b5d753ebc22c5 Jason Wang 2019-05-24  1015  }
7b5d753ebc22c5 Jason Wang 2019-05-24  1016  

:::::: The code at line 1014 was first introduced by commit
:::::: 7b5d753ebc22c5b6935a70ce9a857dc6220784f8 vhost: fine grain userspace memory accessors

:::::: TO: Jason Wang <jasowang@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
