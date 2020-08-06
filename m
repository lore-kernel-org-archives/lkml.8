Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A37E20823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHFADe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:03:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:29418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgHFADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:03:32 -0400
IronPort-SDR: aHdnX3L72/syZirZDFydRhqQ1UoO17XmIYPPUrAukO9t+F3gMBJMxauXRkO5AhG7SUmYB+vid/
 75xAmYfe+9dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140280131"
X-IronPort-AV: E=Sophos;i="5.75,439,1589266800"; 
   d="gz'50?scan'50,208,50";a="140280131"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 17:03:16 -0700
IronPort-SDR: bDbIJxZy5z7FBTB7sYidkfJ5UZh6mHWU/yk65y1cb+4vCxmpkoZbGJ/YYfMfU30tN2bzq4k831
 842yFNkx0Eiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,439,1589266800"; 
   d="gz'50?scan'50,208,50";a="276235198"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2020 17:03:14 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3TNJ-0000yh-MH; Thu, 06 Aug 2020 00:03:13 +0000
Date:   Thu, 6 Aug 2020 08:02:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202008060838.I55KDvV0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecfd7940b8641da6e41ca94eba36876dc2ba827b
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: x86_64-randconfig-s021-20200806 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
>> drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     got unsigned int *
>> drivers/scsi/fnic/vnic_dev.c:469:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vnic_wq_ctrl *wq_ctrl @@     got struct vnic_wq_ctrl [noderef] __iomem *ctrl @@
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     expected struct vnic_wq_ctrl *wq_ctrl
>> drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     got struct vnic_wq_ctrl [noderef] __iomem *ctrl
>> drivers/scsi/fnic/vnic_dev.c:943:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *p @@     got void [noderef] __iomem * @@
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     expected void *p
>> drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     got void [noderef] __iomem *
--
>> drivers/scsi/qedf/qedf_debugfs.c:113:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user *buffer @@
   drivers/scsi/qedf/qedf_debugfs.c:113:23: sparse:     expected char *buf
>> drivers/scsi/qedf/qedf_debugfs.c:113:23: sparse:     got char [noderef] __user *buffer
>> drivers/scsi/qedf/qedf_debugfs.c:119:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user * @@
   drivers/scsi/qedf/qedf_debugfs.c:119:40: sparse:     expected char *buf
>> drivers/scsi/qedf/qedf_debugfs.c:119:40: sparse:     got char [noderef] __user *
   drivers/scsi/qedf/qedf_debugfs.c:147:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user *buffer @@
   drivers/scsi/qedf/qedf_debugfs.c:147:23: sparse:     expected char *buf
   drivers/scsi/qedf/qedf_debugfs.c:147:23: sparse:     got char [noderef] __user *buffer
   drivers/scsi/qedf/qedf_debugfs.c:196:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user *buffer @@
   drivers/scsi/qedf/qedf_debugfs.c:196:23: sparse:     expected char *buf
   drivers/scsi/qedf/qedf_debugfs.c:196:23: sparse:     got char [noderef] __user *buffer
--
>> drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const * @@     got char const [noderef] __user *buffer @@
   drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse:     expected char const *
>> drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse:     got char const [noderef] __user *buffer
>> drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user *buffer @@
   drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse:     expected char *buf
>> drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse:     got char [noderef] __user *buffer
   drivers/scsi/qedi/qedi_debugfs.c:154:41: sparse: sparse: restricted __le16 degrades to integer

vim +332 drivers/scsi/fnic/vnic_dev.c

5df6d737dd4b0f Abhijeet Joglekar 2009-04-17  318  
363f4d937501ba Jason Yan         2020-04-15  319  static int vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
0a2fdd2215e1fa Satish Kharat     2019-01-18  320  		int wait)
0a2fdd2215e1fa Satish Kharat     2019-01-18  321  {
0a2fdd2215e1fa Satish Kharat     2019-01-18  322  	struct devcmd2_controller *dc2c = vdev->devcmd2;
0a2fdd2215e1fa Satish Kharat     2019-01-18  323  	struct devcmd2_result *result;
0a2fdd2215e1fa Satish Kharat     2019-01-18  324  	u8 color;
0a2fdd2215e1fa Satish Kharat     2019-01-18  325  	unsigned int i;
0a2fdd2215e1fa Satish Kharat     2019-01-18  326  	int delay;
0a2fdd2215e1fa Satish Kharat     2019-01-18  327  	int err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  328  	u32 fetch_index;
0a2fdd2215e1fa Satish Kharat     2019-01-18  329  	u32 posted;
0a2fdd2215e1fa Satish Kharat     2019-01-18  330  	u32 new_posted;
0a2fdd2215e1fa Satish Kharat     2019-01-18  331  
0a2fdd2215e1fa Satish Kharat     2019-01-18 @332  	posted = ioread32(&dc2c->wq_ctrl->posted_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  333  	fetch_index = ioread32(&dc2c->wq_ctrl->fetch_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  334  
0a2fdd2215e1fa Satish Kharat     2019-01-18  335  	if (posted == 0xFFFFFFFF || fetch_index == 0xFFFFFFFF) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  336  		/* Hardware surprise removal: return error */
0a2fdd2215e1fa Satish Kharat     2019-01-18  337  		pr_err("%s: devcmd2 invalid posted or fetch index on cmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  338  				pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  339  		pr_err("%s: fetch index: %u, posted index: %u\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  340  				pci_name(vdev->pdev), fetch_index, posted);
0a2fdd2215e1fa Satish Kharat     2019-01-18  341  
0a2fdd2215e1fa Satish Kharat     2019-01-18  342  		return -ENODEV;
0a2fdd2215e1fa Satish Kharat     2019-01-18  343  
0a2fdd2215e1fa Satish Kharat     2019-01-18  344  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  345  
0a2fdd2215e1fa Satish Kharat     2019-01-18  346  	new_posted = (posted + 1) % DEVCMD2_RING_SIZE;
0a2fdd2215e1fa Satish Kharat     2019-01-18  347  
0a2fdd2215e1fa Satish Kharat     2019-01-18  348  	if (new_posted == fetch_index) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  349  		pr_err("%s: devcmd2 wq full while issuing cmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  350  				pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  351  		pr_err("%s: fetch index: %u, posted index: %u\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  352  				pci_name(vdev->pdev), fetch_index, posted);
0a2fdd2215e1fa Satish Kharat     2019-01-18  353  		return -EBUSY;
0a2fdd2215e1fa Satish Kharat     2019-01-18  354  
0a2fdd2215e1fa Satish Kharat     2019-01-18  355  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  356  	dc2c->cmd_ring[posted].cmd = cmd;
0a2fdd2215e1fa Satish Kharat     2019-01-18  357  	dc2c->cmd_ring[posted].flags = 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  358  
0a2fdd2215e1fa Satish Kharat     2019-01-18  359  	if ((_CMD_FLAGS(cmd) & _CMD_FLAGS_NOWAIT))
0a2fdd2215e1fa Satish Kharat     2019-01-18  360  		dc2c->cmd_ring[posted].flags |= DEVCMD2_FNORESULT;
0a2fdd2215e1fa Satish Kharat     2019-01-18  361  	if (_CMD_DIR(cmd) & _CMD_DIR_WRITE) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  362  		for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
0a2fdd2215e1fa Satish Kharat     2019-01-18  363  			dc2c->cmd_ring[posted].args[i] = vdev->args[i];
0a2fdd2215e1fa Satish Kharat     2019-01-18  364  
0a2fdd2215e1fa Satish Kharat     2019-01-18  365  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  366  
0a2fdd2215e1fa Satish Kharat     2019-01-18  367  	/* Adding write memory barrier prevents compiler and/or CPU
0a2fdd2215e1fa Satish Kharat     2019-01-18  368  	 * reordering, thus avoiding descriptor posting before
0a2fdd2215e1fa Satish Kharat     2019-01-18  369  	 * descriptor is initialized. Otherwise, hardware can read
0a2fdd2215e1fa Satish Kharat     2019-01-18  370  	 * stale descriptor fields.
0a2fdd2215e1fa Satish Kharat     2019-01-18  371  	 */
0a2fdd2215e1fa Satish Kharat     2019-01-18  372  	wmb();
0a2fdd2215e1fa Satish Kharat     2019-01-18  373  	iowrite32(new_posted, &dc2c->wq_ctrl->posted_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  374  
0a2fdd2215e1fa Satish Kharat     2019-01-18  375  	if (dc2c->cmd_ring[posted].flags & DEVCMD2_FNORESULT)
0a2fdd2215e1fa Satish Kharat     2019-01-18  376  		return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  377  
0a2fdd2215e1fa Satish Kharat     2019-01-18  378  	result = dc2c->result + dc2c->next_result;
0a2fdd2215e1fa Satish Kharat     2019-01-18  379  	color = dc2c->color;
0a2fdd2215e1fa Satish Kharat     2019-01-18  380  
0a2fdd2215e1fa Satish Kharat     2019-01-18  381  	dc2c->next_result++;
0a2fdd2215e1fa Satish Kharat     2019-01-18  382  	if (dc2c->next_result == dc2c->result_size) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  383  		dc2c->next_result = 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  384  		dc2c->color = dc2c->color ? 0 : 1;
0a2fdd2215e1fa Satish Kharat     2019-01-18  385  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  386  
0a2fdd2215e1fa Satish Kharat     2019-01-18  387  	for (delay = 0; delay < wait; delay++) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  388  		udelay(100);
0a2fdd2215e1fa Satish Kharat     2019-01-18  389  		if (result->color == color) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  390  			if (result->error) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  391  				err = -(int) result->error;
0a2fdd2215e1fa Satish Kharat     2019-01-18  392  				if (err != ERR_ECMDUNKNOWN ||
0a2fdd2215e1fa Satish Kharat     2019-01-18  393  						cmd != CMD_CAPABILITY)
0a2fdd2215e1fa Satish Kharat     2019-01-18  394  					pr_err("%s:Error %d devcmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  395  						pci_name(vdev->pdev),
0a2fdd2215e1fa Satish Kharat     2019-01-18  396  						err, _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  397  				return err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  398  			}
0a2fdd2215e1fa Satish Kharat     2019-01-18  399  			if (_CMD_DIR(cmd) & _CMD_DIR_READ) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  400  				rmb(); /*prevent reorder while reding result*/
0a2fdd2215e1fa Satish Kharat     2019-01-18  401  				for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
0a2fdd2215e1fa Satish Kharat     2019-01-18  402  					vdev->args[i] = result->results[i];
0a2fdd2215e1fa Satish Kharat     2019-01-18  403  			}
0a2fdd2215e1fa Satish Kharat     2019-01-18  404  			return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  405  		}
0a2fdd2215e1fa Satish Kharat     2019-01-18  406  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  407  
0a2fdd2215e1fa Satish Kharat     2019-01-18  408  	pr_err("%s:Timed out devcmd %d\n", pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  409  
0a2fdd2215e1fa Satish Kharat     2019-01-18  410  	return -ETIMEDOUT;
0a2fdd2215e1fa Satish Kharat     2019-01-18  411  }
0a2fdd2215e1fa Satish Kharat     2019-01-18  412  
0a2fdd2215e1fa Satish Kharat     2019-01-18  413  
363f4d937501ba Jason Yan         2020-04-15  414  static int vnic_dev_init_devcmd1(struct vnic_dev *vdev)
0a2fdd2215e1fa Satish Kharat     2019-01-18  415  {
0a2fdd2215e1fa Satish Kharat     2019-01-18  416  	vdev->devcmd = vnic_dev_get_res(vdev, RES_TYPE_DEVCMD, 0);
0a2fdd2215e1fa Satish Kharat     2019-01-18  417  	if (!vdev->devcmd)
0a2fdd2215e1fa Satish Kharat     2019-01-18  418  		return -ENODEV;
0a2fdd2215e1fa Satish Kharat     2019-01-18  419  
0a2fdd2215e1fa Satish Kharat     2019-01-18  420  	vdev->devcmd_rtn = &vnic_dev_cmd1;
0a2fdd2215e1fa Satish Kharat     2019-01-18  421  	return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  422  }
0a2fdd2215e1fa Satish Kharat     2019-01-18  423  
0a2fdd2215e1fa Satish Kharat     2019-01-18  424  
363f4d937501ba Jason Yan         2020-04-15  425  static int vnic_dev_init_devcmd2(struct vnic_dev *vdev)
0a2fdd2215e1fa Satish Kharat     2019-01-18  426  {
0a2fdd2215e1fa Satish Kharat     2019-01-18  427  	int err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  428  	unsigned int fetch_index;
0a2fdd2215e1fa Satish Kharat     2019-01-18  429  
0a2fdd2215e1fa Satish Kharat     2019-01-18  430  	if (vdev->devcmd2)
0a2fdd2215e1fa Satish Kharat     2019-01-18  431  		return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  432  
0a2fdd2215e1fa Satish Kharat     2019-01-18  433  	vdev->devcmd2 = kzalloc(sizeof(*vdev->devcmd2), GFP_ATOMIC);
0a2fdd2215e1fa Satish Kharat     2019-01-18  434  	if (!vdev->devcmd2)
0a2fdd2215e1fa Satish Kharat     2019-01-18  435  		return -ENOMEM;
0a2fdd2215e1fa Satish Kharat     2019-01-18  436  
0a2fdd2215e1fa Satish Kharat     2019-01-18  437  	vdev->devcmd2->color = 1;
0a2fdd2215e1fa Satish Kharat     2019-01-18  438  	vdev->devcmd2->result_size = DEVCMD2_RING_SIZE;
0a2fdd2215e1fa Satish Kharat     2019-01-18  439  	err = vnic_wq_devcmd2_alloc(vdev, &vdev->devcmd2->wq,
0a2fdd2215e1fa Satish Kharat     2019-01-18  440  				DEVCMD2_RING_SIZE, DEVCMD2_DESC_SIZE);
0a2fdd2215e1fa Satish Kharat     2019-01-18  441  	if (err)
0a2fdd2215e1fa Satish Kharat     2019-01-18  442  		goto err_free_devcmd2;
0a2fdd2215e1fa Satish Kharat     2019-01-18  443  
0a2fdd2215e1fa Satish Kharat     2019-01-18  444  	fetch_index = ioread32(&vdev->devcmd2->wq.ctrl->fetch_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  445  	if (fetch_index == 0xFFFFFFFF) { /* check for hardware gone  */
0a2fdd2215e1fa Satish Kharat     2019-01-18  446  		pr_err("error in devcmd2 init");
0a2fdd2215e1fa Satish Kharat     2019-01-18  447  		return -ENODEV;
0a2fdd2215e1fa Satish Kharat     2019-01-18  448  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  449  
0a2fdd2215e1fa Satish Kharat     2019-01-18  450  	/*
0a2fdd2215e1fa Satish Kharat     2019-01-18  451  	 * Don't change fetch_index ever and
0a2fdd2215e1fa Satish Kharat     2019-01-18  452  	 * set posted_index same as fetch_index
0a2fdd2215e1fa Satish Kharat     2019-01-18  453  	 * when setting up the WQ for devcmd2.
0a2fdd2215e1fa Satish Kharat     2019-01-18  454  	 */
0a2fdd2215e1fa Satish Kharat     2019-01-18  455  	vnic_wq_init_start(&vdev->devcmd2->wq, 0, fetch_index,
0a2fdd2215e1fa Satish Kharat     2019-01-18  456  			fetch_index, 0, 0);
0a2fdd2215e1fa Satish Kharat     2019-01-18  457  
0a2fdd2215e1fa Satish Kharat     2019-01-18  458  	vnic_wq_enable(&vdev->devcmd2->wq);
0a2fdd2215e1fa Satish Kharat     2019-01-18  459  
0a2fdd2215e1fa Satish Kharat     2019-01-18  460  	err = vnic_dev_alloc_desc_ring(vdev, &vdev->devcmd2->results_ring,
0a2fdd2215e1fa Satish Kharat     2019-01-18  461  			DEVCMD2_RING_SIZE, DEVCMD2_DESC_SIZE);
0a2fdd2215e1fa Satish Kharat     2019-01-18  462  	if (err)
0a2fdd2215e1fa Satish Kharat     2019-01-18  463  		goto err_free_wq;
0a2fdd2215e1fa Satish Kharat     2019-01-18  464  
0a2fdd2215e1fa Satish Kharat     2019-01-18  465  	vdev->devcmd2->result =
0a2fdd2215e1fa Satish Kharat     2019-01-18  466  		(struct devcmd2_result *) vdev->devcmd2->results_ring.descs;
0a2fdd2215e1fa Satish Kharat     2019-01-18  467  	vdev->devcmd2->cmd_ring =
0a2fdd2215e1fa Satish Kharat     2019-01-18  468  		(struct vnic_devcmd2 *) vdev->devcmd2->wq.ring.descs;
0a2fdd2215e1fa Satish Kharat     2019-01-18 @469  	vdev->devcmd2->wq_ctrl = vdev->devcmd2->wq.ctrl;
0a2fdd2215e1fa Satish Kharat     2019-01-18  470  	vdev->args[0] = (u64) vdev->devcmd2->results_ring.base_addr |
0a2fdd2215e1fa Satish Kharat     2019-01-18  471  				VNIC_PADDR_TARGET;
0a2fdd2215e1fa Satish Kharat     2019-01-18  472  	vdev->args[1] = DEVCMD2_RING_SIZE;
0a2fdd2215e1fa Satish Kharat     2019-01-18  473  
0a2fdd2215e1fa Satish Kharat     2019-01-18  474  	err = vnic_dev_cmd2(vdev, CMD_INITIALIZE_DEVCMD2, 1000);
0a2fdd2215e1fa Satish Kharat     2019-01-18  475  	if (err)
0a2fdd2215e1fa Satish Kharat     2019-01-18  476  		goto err_free_desc_ring;
0a2fdd2215e1fa Satish Kharat     2019-01-18  477  
0a2fdd2215e1fa Satish Kharat     2019-01-18  478  	vdev->devcmd_rtn = &vnic_dev_cmd2;
0a2fdd2215e1fa Satish Kharat     2019-01-18  479  
0a2fdd2215e1fa Satish Kharat     2019-01-18  480  	return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  481  
0a2fdd2215e1fa Satish Kharat     2019-01-18  482  err_free_desc_ring:
0a2fdd2215e1fa Satish Kharat     2019-01-18  483  	vnic_dev_free_desc_ring(vdev, &vdev->devcmd2->results_ring);
0a2fdd2215e1fa Satish Kharat     2019-01-18  484  err_free_wq:
0a2fdd2215e1fa Satish Kharat     2019-01-18  485  	vnic_wq_disable(&vdev->devcmd2->wq);
0a2fdd2215e1fa Satish Kharat     2019-01-18  486  	vnic_wq_free(&vdev->devcmd2->wq);
0a2fdd2215e1fa Satish Kharat     2019-01-18  487  err_free_devcmd2:
0a2fdd2215e1fa Satish Kharat     2019-01-18  488  	kfree(vdev->devcmd2);
0a2fdd2215e1fa Satish Kharat     2019-01-18  489  	vdev->devcmd2 = NULL;
0a2fdd2215e1fa Satish Kharat     2019-01-18  490  
0a2fdd2215e1fa Satish Kharat     2019-01-18  491  	return err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  492  }
0a2fdd2215e1fa Satish Kharat     2019-01-18  493  

:::::: The code at line 332 was first introduced by commit
:::::: 0a2fdd2215e1fa3b417792bd6e9cb719822cbfb6 scsi: fnic: Adding devcmd2 init and posting interfaces

:::::: TO: Satish Kharat <satishkh@cisco.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/I4kBIEW1OSOcofn8qceMP4f9eA9H8OiAgA=

--OXfL5xGRrasGEqWY--
