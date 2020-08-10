Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC6FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A8820656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHJUQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:16:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:43643 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHJUQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:16:01 -0400
IronPort-SDR: EFaRwnGaRnwuOgKO8I176xurA5jmVHjw57RI8EORM7VVIqlSt6VuYFG0pTyljaoe43/MmJC8Jk
 NpfjFPzaGDow==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="238445479"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="238445479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 13:12:52 -0700
IronPort-SDR: DIOwE+X6NxFAJcz8icOgkd9MD/sNZ6eP1BqUhLjsxyDChAXjq/zEd9O9na0oEaC7YD95oWkHQV
 E9t+g3MTuxFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="334350197"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2020 13:12:50 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5EA5-0000BU-L4; Mon, 10 Aug 2020 20:12:49 +0000
Date:   Tue, 11 Aug 2020 04:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Omer Shpigelman <oshpigelman@habana.ai>
Subject: drivers/misc/habanalabs/common/device.c:289:3: warning: %u in format
 string (no. 1) requires 'unsigned int' but the argument type is 'signed
 int'.
Message-ID: <202008110418.fJWwQuUF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 70b2f993ea4a79c298aac4ec1c58089020536ba5 habanalabs: create common folder
date:   2 weeks ago
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/misc/habanalabs/common/device.c:289:3: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
     snprintf(workq_name, 32, "hl-free-jobs-%u", i);
     ^
>> drivers/misc/habanalabs/common/device.c:1304:24: warning: Variable 'add_cdev_sysfs_on_err' is reassigned a value before the old one has been used. [redundantAssignment]
    add_cdev_sysfs_on_err = false;
                          ^
   drivers/misc/habanalabs/common/device.c:1262:24: note: Variable 'add_cdev_sysfs_on_err' is reassigned a value before the old one has been used.
    add_cdev_sysfs_on_err = true;
                          ^
   drivers/misc/habanalabs/common/device.c:1304:24: note: Variable 'add_cdev_sysfs_on_err' is reassigned a value before the old one has been used.
    add_cdev_sysfs_on_err = false;
                          ^
>> drivers/misc/habanalabs/common/command_submission.c:720:6: warning: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
     rc = cs_parser(hpriv, job);
        ^
   drivers/misc/habanalabs/common/command_submission.c:691:7: note: Variable 'rc' is reassigned a value before the old one has been used.
      rc = -ENOMEM;
         ^
   drivers/misc/habanalabs/common/command_submission.c:720:6: note: Variable 'rc' is reassigned a value before the old one has been used.
     rc = cs_parser(hpriv, job);
        ^

vim +289 drivers/misc/habanalabs/common/device.c

c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  241  
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  242  /*
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  243   * device_early_init - do some early initialization for the habanalabs device
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  244   *
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  245   * @hdev: pointer to habanalabs device structure
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  246   *
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  247   * Install the relevant function pointers and call the early_init function,
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  248   * if such a function exists
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  249   */
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  250  static int device_early_init(struct hl_device *hdev)
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  251  {
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  252  	int i, rc;
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  253  	char workq_name[32];
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  254  
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  255  	switch (hdev->asic_type) {
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  256  	case ASIC_GOYA:
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  257  		goya_set_asic_funcs(hdev);
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  258  		strlcpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  259  		break;
af57cb81a6df58 drivers/misc/habanalabs/device.c Oded Gabbay 2020-05-11  260  	case ASIC_GAUDI:
af57cb81a6df58 drivers/misc/habanalabs/device.c Oded Gabbay 2020-05-11  261  		gaudi_set_asic_funcs(hdev);
af57cb81a6df58 drivers/misc/habanalabs/device.c Oded Gabbay 2020-05-11  262  		sprintf(hdev->asic_name, "GAUDI");
af57cb81a6df58 drivers/misc/habanalabs/device.c Oded Gabbay 2020-05-11  263  		break;
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  264  	default:
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  265  		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  266  			hdev->asic_type);
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  267  		return -EINVAL;
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  268  	}
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  269  
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  270  	rc = hdev->asic_funcs->early_init(hdev);
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  271  	if (rc)
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  272  		return rc;
99b9d7b4970cf1 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  273  
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  274  	rc = hl_asid_init(hdev);
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  275  	if (rc)
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  276  		goto early_fini;
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  277  
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  278  	if (hdev->asic_prop.completion_queues_count) {
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  279  		hdev->cq_wq = kcalloc(hdev->asic_prop.completion_queues_count,
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  280  				sizeof(*hdev->cq_wq),
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  281  				GFP_ATOMIC);
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  282  		if (!hdev->cq_wq) {
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  283  			rc = -ENOMEM;
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  284  			goto asid_fini;
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  285  		}
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  286  	}
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  287  
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  288  	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05 @289  		snprintf(workq_name, 32, "hl-free-jobs-%u", i);
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  290  		hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  291  		if (hdev->cq_wq == NULL) {
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  292  			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  293  			rc = -ENOMEM;
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  294  			goto free_cq_wq;
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  295  		}
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  296  	}
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  297  
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  298  	hdev->eq_wq = alloc_workqueue("hl-events", WQ_UNBOUND, 0);
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  299  	if (hdev->eq_wq == NULL) {
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  300  		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  301  		rc = -ENOMEM;
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  302  		goto free_cq_wq;
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  303  	}
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  304  
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  305  	hdev->hl_chip_info = kzalloc(sizeof(struct hwmon_chip_info),
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  306  					GFP_KERNEL);
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  307  	if (!hdev->hl_chip_info) {
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  308  		rc = -ENOMEM;
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  309  		goto free_eq_wq;
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  310  	}
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  311  
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  312  	hdev->idle_busy_ts_arr = kmalloc_array(HL_IDLE_BUSY_TS_ARR_SIZE,
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  313  					sizeof(struct hl_device_idle_busy_ts),
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  314  					(GFP_KERNEL | __GFP_ZERO));
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  315  	if (!hdev->idle_busy_ts_arr) {
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  316  		rc = -ENOMEM;
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  317  		goto free_chip_info;
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  318  	}
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  319  
be5d926b5c1043 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  320  	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
be5d926b5c1043 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  321  
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  322  	mutex_init(&hdev->send_cpu_message_lock);
19734970c98b07 drivers/misc/habanalabs/device.c Oded Gabbay 2019-05-04  323  	mutex_init(&hdev->debug_lock);
8d45f1de3994c5 drivers/misc/habanalabs/device.c Tomer Tayar 2019-05-13  324  	mutex_init(&hdev->mmu_cache_lock);
eff6f4a0e70b7b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  325  	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
eff6f4a0e70b7b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  326  	spin_lock_init(&hdev->hw_queues_mirror_lock);
eb7caf84b02938 drivers/misc/habanalabs/device.c Oded Gabbay 2019-07-30  327  	INIT_LIST_HEAD(&hdev->fpriv_list);
eb7caf84b02938 drivers/misc/habanalabs/device.c Oded Gabbay 2019-07-30  328  	mutex_init(&hdev->fpriv_list_lock);
f8c8c7d5f1b0ea drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  329  	atomic_set(&hdev->in_reset, 0);
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  330  
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  331  	return 0;
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  332  
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  333  free_chip_info:
75b3cb2bb08037 drivers/misc/habanalabs/device.c Oded Gabbay 2019-08-28  334  	kfree(hdev->hl_chip_info);
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  335  free_eq_wq:
d91389bc839d72 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  336  	destroy_workqueue(hdev->eq_wq);
1251f23ae8583b drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  337  free_cq_wq:
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  338  	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  339  		if (hdev->cq_wq[i])
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  340  			destroy_workqueue(hdev->cq_wq[i]);
5574cb2194b13d drivers/misc/habanalabs/device.c Ofir Bitton 2020-07-05  341  	kfree(hdev->cq_wq);
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  342  asid_fini:
9494a8dd8d22cb drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  343  	hl_asid_fini(hdev);
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  344  early_fini:
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  345  	if (hdev->asic_funcs->early_fini)
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  346  		hdev->asic_funcs->early_fini(hdev);
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  347  
0861e41de53044 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  348  	return rc;
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  349  }
c4d66343a46a49 drivers/misc/habanalabs/device.c Oded Gabbay 2019-02-16  350  

:::::: The code at line 289 was first introduced by commit
:::::: 5574cb2194b13de78df68cd32655ddbe619b1251 habanalabs: Assign each CQ with its own work queue

:::::: TO: Ofir Bitton <obitton@habana.ai>
:::::: CC: Oded Gabbay <oded.gabbay@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
