Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC9C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A220782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHaMo0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:44:26 -0400
Received: from smtp.h3c.com ([60.191.123.50]:51158 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHaMoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:44:19 -0400
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 07VB44Iw027203
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:04:04 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
        by h3cspam02-ex.h3c.com with ESMTPS id 07VB3phN027079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 19:03:51 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 19:03:54 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 31 Aug 2020 19:03:54 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     kernel test robot <lkp@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()
Thread-Topic: [PATCH] nvme-pci: check req to prevent crash in
 nvme_handle_cqe()
Thread-Index: AQHWf2RcPXKUYIdfu0aQ67Gvv7x69alRcK+AgACNmNA=
Date:   Mon, 31 Aug 2020 11:03:54 +0000
Message-ID: <fa48ae527de8458aa173bb242b83a97a@h3c.com>
References: <20200831065311.40731-1-tian.xianting@h3c.com>
 <202008311754.Gbt69JQN%lkp@intel.com>
In-Reply-To: <202008311754.Gbt69JQN%lkp@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 07VB3phN027079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am very sorry, I used the wrong patch file :(
I send it again. Please review, thanks.

-----Original Message-----
From: kernel test robot [mailto:lkp@intel.com] 
Sent: Monday, August 31, 2020 5:41 PM
To: tianxianting (RD) <tian.xianting@h3c.com>; kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
Cc: kbuild-all@lists.01.org; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: Re: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()

Hi Xianting,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.9-rc2]
[also build test ERROR on next-20200828] [cannot apply to linus/master v5.9-rc3] [If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xianting-Tian/nvme-pci-check-req-to-prevent-crash-in-nvme_handle_cqe/20200831-155653
base:    d012a7190fc1fd72ed48911e77ca97ba4521bccd
config: parisc-randconfig-r004-20200831 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/pci.c: In function 'nvme_handle_cqe':
>> drivers/nvme/host/pci.c:3244: error: unterminated argument list invoking macro "dev_warn"
    3244 | module_exit(nvme_exit);
         | 
>> drivers/nvme/host/pci.c:966:3: error: 'dev_warn' undeclared (first use in this function); did you mean '_dev_warn'?
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |   ^~~~~~~~
         |   _dev_warn
   drivers/nvme/host/pci.c:966:3: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/nvme/host/pci.c:966:11: error: expected ';' at end of input
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |           ^
         |           ;
   ......
    3244 | module_exit(nvme_exit);
         |            
>> drivers/nvme/host/pci.c:966:3: error: expected declaration or 
>> statement at end of input
     966 |   dev_warn(nvmeq->dev->ctrl.device,
         |   ^~~~~~~~
>> drivers/nvme/host/pci.c:966:3: error: expected declaration or 
>> statement at end of input
   drivers/nvme/host/pci.c: At top level:
   drivers/nvme/host/pci.c:105:13: warning: 'nvme_dev_disable' declared 'static' but never defined [-Wunused-function]
     105 | static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
         |             ^~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:106:13: warning: '__nvme_disable_io_queues' declared 'static' but never defined [-Wunused-function]
     106 | static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:901:13: warning: 'nvme_pci_complete_rq' defined but not used [-Wunused-function]
     901 | static void nvme_pci_complete_rq(struct request *req)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:853:21: warning: 'nvme_queue_rq' defined but not used [-Wunused-function]
     853 | static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
         |                     ^~~~~~~~~~~~~
   drivers/nvme/host/pci.c:484:13: warning: 'nvme_commit_rqs' defined but not used [-Wunused-function]
     484 | static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
         |             ^~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:427:12: warning: 'nvme_pci_map_queues' defined but not used [-Wunused-function]
     427 | static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:403:12: warning: 'nvme_init_request' defined but not used [-Wunused-function]
     403 | static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
         |            ^~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:392:12: warning: 'nvme_init_hctx' defined but not used [-Wunused-function]
     392 | static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:379:12: warning: 'nvme_admin_init_hctx' defined but not used [-Wunused-function]
     379 | static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:371:15: warning: 'nvme_pci_iod_alloc_size' defined but not used [-Wunused-function]
     371 | static size_t nvme_pci_iod_alloc_size(void)
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:294:13: warning: 'nvme_dbbuf_set' defined but not used [-Wunused-function]
     294 | static void nvme_dbbuf_set(struct nvme_dev *dev)
         |             ^~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:282:13: warning: 'nvme_dbbuf_init' defined but not used [-Wunused-function]
     282 | static void nvme_dbbuf_init(struct nvme_dev *dev,
         |             ^~~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:241:12: warning: 'nvme_dbbuf_dma_alloc' defined but not used [-Wunused-function]
     241 | static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
         |            ^~~~~~~~~~~~~~~~~~~~

# https://github.com/0day-ci/linux/commit/e3761e6c554adb55d40e176915df361ad9e272e1
git remote add linux-review https://github.com/0day-ci/linux git fetch --no-tags linux-review Xianting-Tian/nvme-pci-check-req-to-prevent-crash-in-nvme_handle_cqe/20200831-155653
git checkout e3761e6c554adb55d40e176915df361ad9e272e1
vim +/dev_warn +3244 drivers/nvme/host/pci.c

b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3239  
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3240  MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3241  MODULE_LICENSE("GPL");
c78b47136f7ade drivers/block/nvme-core.c Keith Busch    2014-11-21  3242  MODULE_VERSION("1.0");
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20  3243  module_init(nvme_init);
b60503ba432b16 drivers/block/nvme.c      Matthew Wilcox 2011-01-20 @3244  module_exit(nvme_exit);

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
