Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E24206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgF2Dru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:47:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:55719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgF2Drt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:47:49 -0400
IronPort-SDR: BAvN5nzPLT7hwMmXs03/6if2/Iqpouh9OmsWmA5SPsy2Q5Jftq6RbjGAsR0D78/Rz0uq/pNh8d
 BVY/gotiTCGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147449136"
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="gz'50?scan'50,208,50";a="147449136"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 20:47:29 -0700
IronPort-SDR: phpdPScmCGV15UaDFLFIGyk9FzVbSJZKA8TszNKi5YsOENfV3QVuesUK/3+voRxELB8unyUxup
 HXeUt2bx9O7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="gz'50?scan'50,208,50";a="264718482"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2020 20:47:26 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpklS-0000mM-6C; Mon, 29 Jun 2020 03:47:26 +0000
Date:   Mon, 29 Jun 2020 11:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: arch/powerpc/platforms/powernv/eeh-powernv.c:230:18: warning:
 variable 'phb' set but not used
Message-ID: <202006291148.4oW0J4Qg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
commit: 0e4a459f56c32d3e52ae69a4b447db2f48a65f44 tracing: Remove unnecessary DEBUG_FS dependency
date:   7 months ago
config: powerpc-randconfig-m031-20200629 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/powernv/eeh-powernv.c:41:6: warning: no previous prototype for 'pnv_pcibios_bus_add_device' [-Wmissing-prototypes]
      41 | void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/powernv/eeh-powernv.c:200:6: warning: no previous prototype for 'pnv_eeh_enable_phbs' [-Wmissing-prototypes]
     200 | void pnv_eeh_enable_phbs(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/powernv/eeh-powernv.c: In function 'pnv_eeh_post_init':
>> arch/powerpc/platforms/powernv/eeh-powernv.c:230:18: warning: variable 'phb' set but not used [-Wunused-but-set-variable]
     230 |  struct pnv_phb *phb;
         |                  ^~~

vim +/phb +230 arch/powerpc/platforms/powernv/eeh-powernv.c

4cf17445589932 Gavin Shan             2015-02-16   40  
988fc3ba565327 Bryant G. Ly           2017-11-09  @41  void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
988fc3ba565327 Bryant G. Ly           2017-11-09   42  {
988fc3ba565327 Bryant G. Ly           2017-11-09   43  	struct pci_dn *pdn = pci_get_pdn(pdev);
988fc3ba565327 Bryant G. Ly           2017-11-09   44  
b905f8cdca7725 Sam Bobroff            2019-08-16   45  	if (eeh_has_flag(EEH_FORCE_DISABLED))
988fc3ba565327 Bryant G. Ly           2017-11-09   46  		return;
988fc3ba565327 Bryant G. Ly           2017-11-09   47  
1ff8f36fc770dd Sam Bobroff            2019-08-16   48  	dev_dbg(&pdev->dev, "EEH: Setting up device\n");
988fc3ba565327 Bryant G. Ly           2017-11-09   49  	eeh_add_device_early(pdn);
988fc3ba565327 Bryant G. Ly           2017-11-09   50  	eeh_add_device_late(pdev);
988fc3ba565327 Bryant G. Ly           2017-11-09   51  	eeh_sysfs_add_device(pdev);
988fc3ba565327 Bryant G. Ly           2017-11-09   52  }
988fc3ba565327 Bryant G. Ly           2017-11-09   53  
01f3bfb7804ae2 Gavin Shan             2015-02-16   54  static int pnv_eeh_init(void)
29310e5e860697 Gavin Shan             2013-06-20   55  {
dc561fb9e7e13a Gavin Shan             2014-07-17   56  	struct pci_controller *hose;
dc561fb9e7e13a Gavin Shan             2014-07-17   57  	struct pnv_phb *phb;
5cb1f8fdddb747 Russell Currey         2017-06-14   58  	int max_diag_size = PNV_PCI_DIAG_BUF_SIZE;
dc561fb9e7e13a Gavin Shan             2014-07-17   59  
e4d54f71d29997 Stewart Smith          2015-12-09   60  	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
e4d54f71d29997 Stewart Smith          2015-12-09   61  		pr_warn("%s: OPAL is required !\n",
0dae27439acc75 Gavin Shan             2014-07-17   62  			__func__);
29310e5e860697 Gavin Shan             2013-06-20   63  		return -EINVAL;
29310e5e860697 Gavin Shan             2013-06-20   64  	}
29310e5e860697 Gavin Shan             2013-06-20   65  
05b1721d9f4993 Gavin Shan             2014-07-17   66  	/* Set probe mode */
05b1721d9f4993 Gavin Shan             2014-07-17   67  	eeh_add_flag(EEH_PROBE_MODE_DEV);
29310e5e860697 Gavin Shan             2013-06-20   68  
dc561fb9e7e13a Gavin Shan             2014-07-17   69  	/*
dc561fb9e7e13a Gavin Shan             2014-07-17   70  	 * P7IOC blocks PCI config access to frozen PE, but PHB3
dc561fb9e7e13a Gavin Shan             2014-07-17   71  	 * doesn't do that. So we have to selectively enable I/O
dc561fb9e7e13a Gavin Shan             2014-07-17   72  	 * prior to collecting error log.
dc561fb9e7e13a Gavin Shan             2014-07-17   73  	 */
dc561fb9e7e13a Gavin Shan             2014-07-17   74  	list_for_each_entry(hose, &hose_list, list_node) {
dc561fb9e7e13a Gavin Shan             2014-07-17   75  		phb = hose->private_data;
dc561fb9e7e13a Gavin Shan             2014-07-17   76  
dc561fb9e7e13a Gavin Shan             2014-07-17   77  		if (phb->model == PNV_PHB_MODEL_P7IOC)
dc561fb9e7e13a Gavin Shan             2014-07-17   78  			eeh_add_flag(EEH_ENABLE_IO_FOR_LOG);
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   79  
5cb1f8fdddb747 Russell Currey         2017-06-14   80  		if (phb->diag_data_size > max_diag_size)
5cb1f8fdddb747 Russell Currey         2017-06-14   81  			max_diag_size = phb->diag_data_size;
5cb1f8fdddb747 Russell Currey         2017-06-14   82  
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   83  		/*
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   84  		 * PE#0 should be regarded as valid by EEH core
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   85  		 * if it's not the reserved one. Currently, we
608fb9c29660ac Gavin Shan             2015-10-08   86  		 * have the reserved PE#255 and PE#127 for PHB3
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   87  		 * and P7IOC separately. So we should regard
608fb9c29660ac Gavin Shan             2015-10-08   88  		 * PE#0 as valid for PHB3 and P7IOC.
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   89  		 */
92b8f137b3620b Gavin Shan             2016-05-03   90  		if (phb->ioda.reserved_pe_idx != 0)
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   91  			eeh_add_flag(EEH_VALID_PE_ZERO);
2aa5cf9e48f2f3 Gavin Shan             2014-11-25   92  
dc561fb9e7e13a Gavin Shan             2014-07-17   93  		break;
dc561fb9e7e13a Gavin Shan             2014-07-17   94  	}
dc561fb9e7e13a Gavin Shan             2014-07-17   95  
5cb1f8fdddb747 Russell Currey         2017-06-14   96  	eeh_set_pe_aux_size(max_diag_size);
988fc3ba565327 Bryant G. Ly           2017-11-09   97  	ppc_md.pcibios_bus_add_device = pnv_pcibios_bus_add_device;
5cb1f8fdddb747 Russell Currey         2017-06-14   98  
29310e5e860697 Gavin Shan             2013-06-20   99  	return 0;
29310e5e860697 Gavin Shan             2013-06-20  100  }
29310e5e860697 Gavin Shan             2013-06-20  101  
79231448c929cc Alistair Popple        2015-05-15  102  static irqreturn_t pnv_eeh_event(int irq, void *data)
4cf17445589932 Gavin Shan             2015-02-16  103  {
4cf17445589932 Gavin Shan             2015-02-16  104  	/*
79231448c929cc Alistair Popple        2015-05-15  105  	 * We simply send a special EEH event if EEH has been
79231448c929cc Alistair Popple        2015-05-15  106  	 * enabled. We don't care about EEH events until we've
79231448c929cc Alistair Popple        2015-05-15  107  	 * finished processing the outstanding ones. Event processing
79231448c929cc Alistair Popple        2015-05-15  108  	 * gets unmasked in next_error() if EEH is enabled.
4cf17445589932 Gavin Shan             2015-02-16  109  	 */
79231448c929cc Alistair Popple        2015-05-15  110  	disable_irq_nosync(irq);
4cf17445589932 Gavin Shan             2015-02-16  111  
4cf17445589932 Gavin Shan             2015-02-16  112  	if (eeh_enabled())
4cf17445589932 Gavin Shan             2015-02-16  113  		eeh_send_failure_event(NULL);
4cf17445589932 Gavin Shan             2015-02-16  114  
79231448c929cc Alistair Popple        2015-05-15  115  	return IRQ_HANDLED;
4cf17445589932 Gavin Shan             2015-02-16  116  }
4cf17445589932 Gavin Shan             2015-02-16  117  
4cf17445589932 Gavin Shan             2015-02-16  118  #ifdef CONFIG_DEBUG_FS
4cf17445589932 Gavin Shan             2015-02-16  119  static ssize_t pnv_eeh_ei_write(struct file *filp,
4cf17445589932 Gavin Shan             2015-02-16  120  				const char __user *user_buf,
4cf17445589932 Gavin Shan             2015-02-16  121  				size_t count, loff_t *ppos)
4cf17445589932 Gavin Shan             2015-02-16  122  {
4cf17445589932 Gavin Shan             2015-02-16  123  	struct pci_controller *hose = filp->private_data;
4cf17445589932 Gavin Shan             2015-02-16  124  	struct eeh_pe *pe;
4cf17445589932 Gavin Shan             2015-02-16  125  	int pe_no, type, func;
4cf17445589932 Gavin Shan             2015-02-16  126  	unsigned long addr, mask;
4cf17445589932 Gavin Shan             2015-02-16  127  	char buf[50];
4cf17445589932 Gavin Shan             2015-02-16  128  	int ret;
4cf17445589932 Gavin Shan             2015-02-16  129  
4cf17445589932 Gavin Shan             2015-02-16  130  	if (!eeh_ops || !eeh_ops->err_inject)
4cf17445589932 Gavin Shan             2015-02-16  131  		return -ENXIO;
4cf17445589932 Gavin Shan             2015-02-16  132  
4cf17445589932 Gavin Shan             2015-02-16  133  	/* Copy over argument buffer */
4cf17445589932 Gavin Shan             2015-02-16  134  	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
4cf17445589932 Gavin Shan             2015-02-16  135  	if (!ret)
4cf17445589932 Gavin Shan             2015-02-16  136  		return -EFAULT;
4cf17445589932 Gavin Shan             2015-02-16  137  
4cf17445589932 Gavin Shan             2015-02-16  138  	/* Retrieve parameters */
4cf17445589932 Gavin Shan             2015-02-16  139  	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
4cf17445589932 Gavin Shan             2015-02-16  140  		     &pe_no, &type, &func, &addr, &mask);
4cf17445589932 Gavin Shan             2015-02-16  141  	if (ret != 5)
4cf17445589932 Gavin Shan             2015-02-16  142  		return -EINVAL;
4cf17445589932 Gavin Shan             2015-02-16  143  
4cf17445589932 Gavin Shan             2015-02-16  144  	/* Retrieve PE */
8bae6a23198def Alexey Kardashevskiy   2017-08-29  145  	pe = eeh_pe_get(hose, pe_no, 0);
4cf17445589932 Gavin Shan             2015-02-16  146  	if (!pe)
4cf17445589932 Gavin Shan             2015-02-16  147  		return -ENODEV;
4cf17445589932 Gavin Shan             2015-02-16  148  
4cf17445589932 Gavin Shan             2015-02-16  149  	/* Do error injection */
4cf17445589932 Gavin Shan             2015-02-16  150  	ret = eeh_ops->err_inject(pe, type, func, addr, mask);
4cf17445589932 Gavin Shan             2015-02-16  151  	return ret < 0 ? ret : count;
4cf17445589932 Gavin Shan             2015-02-16  152  }
4cf17445589932 Gavin Shan             2015-02-16  153  
4cf17445589932 Gavin Shan             2015-02-16  154  static const struct file_operations pnv_eeh_ei_fops = {
4cf17445589932 Gavin Shan             2015-02-16  155  	.open	= simple_open,
4cf17445589932 Gavin Shan             2015-02-16  156  	.llseek	= no_llseek,
4cf17445589932 Gavin Shan             2015-02-16  157  	.write	= pnv_eeh_ei_write,
4cf17445589932 Gavin Shan             2015-02-16  158  };
4cf17445589932 Gavin Shan             2015-02-16  159  
4cf17445589932 Gavin Shan             2015-02-16  160  static int pnv_eeh_dbgfs_set(void *data, int offset, u64 val)
4cf17445589932 Gavin Shan             2015-02-16  161  {
4cf17445589932 Gavin Shan             2015-02-16  162  	struct pci_controller *hose = data;
4cf17445589932 Gavin Shan             2015-02-16  163  	struct pnv_phb *phb = hose->private_data;
4cf17445589932 Gavin Shan             2015-02-16  164  
4cf17445589932 Gavin Shan             2015-02-16  165  	out_be64(phb->regs + offset, val);
4cf17445589932 Gavin Shan             2015-02-16  166  	return 0;
4cf17445589932 Gavin Shan             2015-02-16  167  }
4cf17445589932 Gavin Shan             2015-02-16  168  
4cf17445589932 Gavin Shan             2015-02-16  169  static int pnv_eeh_dbgfs_get(void *data, int offset, u64 *val)
4cf17445589932 Gavin Shan             2015-02-16  170  {
4cf17445589932 Gavin Shan             2015-02-16  171  	struct pci_controller *hose = data;
4cf17445589932 Gavin Shan             2015-02-16  172  	struct pnv_phb *phb = hose->private_data;
4cf17445589932 Gavin Shan             2015-02-16  173  
4cf17445589932 Gavin Shan             2015-02-16  174  	*val = in_be64(phb->regs + offset);
4cf17445589932 Gavin Shan             2015-02-16  175  	return 0;
4cf17445589932 Gavin Shan             2015-02-16  176  }
4cf17445589932 Gavin Shan             2015-02-16  177  
ccc9662da5494a Gavin Shan             2016-02-09  178  #define PNV_EEH_DBGFS_ENTRY(name, reg)				\
ccc9662da5494a Gavin Shan             2016-02-09  179  static int pnv_eeh_dbgfs_set_##name(void *data, u64 val)	\
ccc9662da5494a Gavin Shan             2016-02-09  180  {								\
ccc9662da5494a Gavin Shan             2016-02-09  181  	return pnv_eeh_dbgfs_set(data, reg, val);		\
ccc9662da5494a Gavin Shan             2016-02-09  182  }								\
ccc9662da5494a Gavin Shan             2016-02-09  183  								\
ccc9662da5494a Gavin Shan             2016-02-09  184  static int pnv_eeh_dbgfs_get_##name(void *data, u64 *val)	\
ccc9662da5494a Gavin Shan             2016-02-09  185  {								\
ccc9662da5494a Gavin Shan             2016-02-09  186  	return pnv_eeh_dbgfs_get(data, reg, val);		\
ccc9662da5494a Gavin Shan             2016-02-09  187  }								\
ccc9662da5494a Gavin Shan             2016-02-09  188  								\
ccc9662da5494a Gavin Shan             2016-02-09  189  DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_dbgfs_ops_##name,		\
ccc9662da5494a Gavin Shan             2016-02-09  190  			pnv_eeh_dbgfs_get_##name,		\
ccc9662da5494a Gavin Shan             2016-02-09  191                          pnv_eeh_dbgfs_set_##name,		\
ccc9662da5494a Gavin Shan             2016-02-09  192  			"0x%llx\n")
ccc9662da5494a Gavin Shan             2016-02-09  193  
ccc9662da5494a Gavin Shan             2016-02-09  194  PNV_EEH_DBGFS_ENTRY(outb, 0xD10);
ccc9662da5494a Gavin Shan             2016-02-09  195  PNV_EEH_DBGFS_ENTRY(inbA, 0xD90);
ccc9662da5494a Gavin Shan             2016-02-09  196  PNV_EEH_DBGFS_ENTRY(inbB, 0xE10);
4cf17445589932 Gavin Shan             2015-02-16  197  
4cf17445589932 Gavin Shan             2015-02-16  198  #endif /* CONFIG_DEBUG_FS */
4cf17445589932 Gavin Shan             2015-02-16  199  
b905f8cdca7725 Sam Bobroff            2019-08-16  200  void pnv_eeh_enable_phbs(void)
b905f8cdca7725 Sam Bobroff            2019-08-16  201  {
b905f8cdca7725 Sam Bobroff            2019-08-16  202  	struct pci_controller *hose;
b905f8cdca7725 Sam Bobroff            2019-08-16  203  	struct pnv_phb *phb;
b905f8cdca7725 Sam Bobroff            2019-08-16  204  
b905f8cdca7725 Sam Bobroff            2019-08-16  205  	list_for_each_entry(hose, &hose_list, list_node) {
b905f8cdca7725 Sam Bobroff            2019-08-16  206  		phb = hose->private_data;
b905f8cdca7725 Sam Bobroff            2019-08-16  207  		/*
b905f8cdca7725 Sam Bobroff            2019-08-16  208  		 * If EEH is enabled, we're going to rely on that.
b905f8cdca7725 Sam Bobroff            2019-08-16  209  		 * Otherwise, we restore to conventional mechanism
b905f8cdca7725 Sam Bobroff            2019-08-16  210  		 * to clear frozen PE during PCI config access.
b905f8cdca7725 Sam Bobroff            2019-08-16  211  		 */
b905f8cdca7725 Sam Bobroff            2019-08-16  212  		if (eeh_enabled())
b905f8cdca7725 Sam Bobroff            2019-08-16  213  			phb->flags |= PNV_PHB_FLAG_EEH;
b905f8cdca7725 Sam Bobroff            2019-08-16  214  		else
b905f8cdca7725 Sam Bobroff            2019-08-16  215  			phb->flags &= ~PNV_PHB_FLAG_EEH;
b905f8cdca7725 Sam Bobroff            2019-08-16  216  	}
b905f8cdca7725 Sam Bobroff            2019-08-16  217  }
b905f8cdca7725 Sam Bobroff            2019-08-16  218  
29310e5e860697 Gavin Shan             2013-06-20  219  /**
01f3bfb7804ae2 Gavin Shan             2015-02-16  220   * pnv_eeh_post_init - EEH platform dependent post initialization
29310e5e860697 Gavin Shan             2013-06-20  221   *
29310e5e860697 Gavin Shan             2013-06-20  222   * EEH platform dependent post initialization on powernv. When
29310e5e860697 Gavin Shan             2013-06-20  223   * the function is called, the EEH PEs and devices should have
29310e5e860697 Gavin Shan             2013-06-20  224   * been built. If the I/O cache staff has been built, EEH is
29310e5e860697 Gavin Shan             2013-06-20  225   * ready to supply service.
29310e5e860697 Gavin Shan             2013-06-20  226   */
b9fde58db7e573 Benjamin Herrenschmidt 2017-09-07  227  int pnv_eeh_post_init(void)
29310e5e860697 Gavin Shan             2013-06-20  228  {
29310e5e860697 Gavin Shan             2013-06-20  229  	struct pci_controller *hose;
29310e5e860697 Gavin Shan             2013-06-20 @230  	struct pnv_phb *phb;
29310e5e860697 Gavin Shan             2013-06-20  231  	int ret = 0;
29310e5e860697 Gavin Shan             2013-06-20  232  
c44e4ccadaca58 Sam Bobroff            2019-08-16  233  	eeh_show_enabled();
b9fde58db7e573 Benjamin Herrenschmidt 2017-09-07  234  
4cf17445589932 Gavin Shan             2015-02-16  235  	/* Register OPAL event notifier */
79231448c929cc Alistair Popple        2015-05-15  236  	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
79231448c929cc Alistair Popple        2015-05-15  237  	if (eeh_event_irq < 0) {
79231448c929cc Alistair Popple        2015-05-15  238  		pr_err("%s: Can't register OPAL event interrupt (%d)\n",
79231448c929cc Alistair Popple        2015-05-15  239  		       __func__, eeh_event_irq);
79231448c929cc Alistair Popple        2015-05-15  240  		return eeh_event_irq;
79231448c929cc Alistair Popple        2015-05-15  241  	}
79231448c929cc Alistair Popple        2015-05-15  242  
79231448c929cc Alistair Popple        2015-05-15  243  	ret = request_irq(eeh_event_irq, pnv_eeh_event,
79231448c929cc Alistair Popple        2015-05-15  244  			  IRQ_TYPE_LEVEL_HIGH, "opal-eeh", NULL);
79231448c929cc Alistair Popple        2015-05-15  245  	if (ret < 0) {
79231448c929cc Alistair Popple        2015-05-15  246  		irq_dispose_mapping(eeh_event_irq);
79231448c929cc Alistair Popple        2015-05-15  247  		pr_err("%s: Can't request OPAL event interrupt (%d)\n",
79231448c929cc Alistair Popple        2015-05-15  248  		       __func__, eeh_event_irq);
4cf17445589932 Gavin Shan             2015-02-16  249  		return ret;
4cf17445589932 Gavin Shan             2015-02-16  250  	}
4cf17445589932 Gavin Shan             2015-02-16  251  
79231448c929cc Alistair Popple        2015-05-15  252  	if (!eeh_enabled())
79231448c929cc Alistair Popple        2015-05-15  253  		disable_irq(eeh_event_irq);
79231448c929cc Alistair Popple        2015-05-15  254  
b905f8cdca7725 Sam Bobroff            2019-08-16  255  	pnv_eeh_enable_phbs();
b905f8cdca7725 Sam Bobroff            2019-08-16  256  
29310e5e860697 Gavin Shan             2013-06-20  257  	list_for_each_entry(hose, &hose_list, list_node) {
29310e5e860697 Gavin Shan             2013-06-20  258  		phb = hose->private_data;
29310e5e860697 Gavin Shan             2013-06-20  259  
4cf17445589932 Gavin Shan             2015-02-16  260  		/* Create debugfs entries */
4cf17445589932 Gavin Shan             2015-02-16  261  #ifdef CONFIG_DEBUG_FS
4cf17445589932 Gavin Shan             2015-02-16  262  		if (phb->has_dbgfs || !phb->dbgfs)
4cf17445589932 Gavin Shan             2015-02-16  263  			continue;
4cf17445589932 Gavin Shan             2015-02-16  264  
4cf17445589932 Gavin Shan             2015-02-16  265  		phb->has_dbgfs = 1;
4cf17445589932 Gavin Shan             2015-02-16  266  		debugfs_create_file("err_injct", 0200,
4cf17445589932 Gavin Shan             2015-02-16  267  				    phb->dbgfs, hose,
4cf17445589932 Gavin Shan             2015-02-16  268  				    &pnv_eeh_ei_fops);
4cf17445589932 Gavin Shan             2015-02-16  269  
4cf17445589932 Gavin Shan             2015-02-16  270  		debugfs_create_file("err_injct_outbound", 0600,
4cf17445589932 Gavin Shan             2015-02-16  271  				    phb->dbgfs, hose,
ccc9662da5494a Gavin Shan             2016-02-09  272  				    &pnv_eeh_dbgfs_ops_outb);
4cf17445589932 Gavin Shan             2015-02-16  273  		debugfs_create_file("err_injct_inboundA", 0600,
4cf17445589932 Gavin Shan             2015-02-16  274  				    phb->dbgfs, hose,
ccc9662da5494a Gavin Shan             2016-02-09  275  				    &pnv_eeh_dbgfs_ops_inbA);
4cf17445589932 Gavin Shan             2015-02-16  276  		debugfs_create_file("err_injct_inboundB", 0600,
4cf17445589932 Gavin Shan             2015-02-16  277  				    phb->dbgfs, hose,
ccc9662da5494a Gavin Shan             2016-02-09  278  				    &pnv_eeh_dbgfs_ops_inbB);
4cf17445589932 Gavin Shan             2015-02-16  279  #endif /* CONFIG_DEBUG_FS */
29310e5e860697 Gavin Shan             2013-06-20  280  	}
29310e5e860697 Gavin Shan             2013-06-20  281  
29310e5e860697 Gavin Shan             2013-06-20  282  	return ret;
29310e5e860697 Gavin Shan             2013-06-20  283  }
29310e5e860697 Gavin Shan             2013-06-20  284  

:::::: The code at line 230 was first introduced by commit
:::::: 29310e5e860697955b9c10ddb448d61267fab0dc powerpc/eeh: PowerNV EEH backends

:::::: TO: Gavin Shan <shangw@linux.vnet.ibm.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
