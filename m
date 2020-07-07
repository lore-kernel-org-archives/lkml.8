Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63832064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGGKoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:44:34 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47823
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgGGKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:44:34 -0400
X-IronPort-AV: E=Sophos;i="5.75,323,1589234400"; 
   d="gz'50?scan'50,208,50";a="353815916"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:44:14 +0200
Date:   Tue, 7 Jul 2020 12:44:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:5025:16-34: WARNING: dma_alloc_coherent
 use in ioc -> request already zeroes out memory, so memset is not needed
 (fwd)
Message-ID: <alpine.DEB.2.22.394.2007071243270.2569@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nFreZHaLTZJo0R7j
Content-ID: <alpine.DEB.2.22.394.2007071243271.2569@hadrien>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=US-ASCII
Content-ID: <alpine.DEB.2.22.394.2007071243272.2569@hadrien>
Content-Disposition: inline

Hello,

Please lines 5025 and 5038.

julia

---------- Forwarded message ----------
Date: Tue, 7 Jul 2020 04:54:19 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:5025:16-34: WARNING:
    dma_alloc_coherent use in ioc -> request already zeroes out memory,
    so memset is not needed

CC: kbuild-all@lists.01.org
CC: linux-kernel@vger.kernel.org
TO: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c82ec00dd00c7a2b02d4b42cf59ae87592cb75f
commit: e224e03b0c6a2381ed1ea5325c846582d87d6fae scsi: mpt3sas: memset request frame before reusing
date:   11 months ago
:::::: branch date: 4 hours ago
:::::: commit date: 11 months ago
config: ia64-randconfig-c024-20200706 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/scsi/mpt3sas/mpt3sas_base.c:5025:16-34: WARNING: dma_alloc_coherent use in ioc -> request already zeroes out memory,  so memset is not needed

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e224e03b0c6a2381ed1ea5325c846582d87d6fae
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout e224e03b0c6a2381ed1ea5325c846582d87d6fae
vim +5025 drivers/scsi/mpt3sas/mpt3sas_base.c

e21fef6f331b39 Chaitra P B              2018-04-24  4781
f92363d1235949 Sreekanth Reddy          2012-11-30  4782  /**
f92363d1235949 Sreekanth Reddy          2012-11-30  4783   * _base_allocate_memory_pools - allocate start of day memory pools
f92363d1235949 Sreekanth Reddy          2012-11-30  4784   * @ioc: per adapter object
f92363d1235949 Sreekanth Reddy          2012-11-30  4785   *
4beb4867f049ae Bart Van Assche          2018-06-15  4786   * Return: 0 success, anything else error.
f92363d1235949 Sreekanth Reddy          2012-11-30  4787   */
f92363d1235949 Sreekanth Reddy          2012-11-30  4788  static int
98c56ad32c33f0 Calvin Owens             2016-07-28  4789  _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
f92363d1235949 Sreekanth Reddy          2012-11-30  4790  {
f92363d1235949 Sreekanth Reddy          2012-11-30  4791  	struct mpt3sas_facts *facts;
f92363d1235949 Sreekanth Reddy          2012-11-30  4792  	u16 max_sge_elements;
f92363d1235949 Sreekanth Reddy          2012-11-30  4793  	u16 chains_needed_per_io;
cd33223b59a493 Chaitra P B              2018-04-24  4794  	u32 sz, total_sz, reply_post_free_sz, reply_post_free_array_sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  4795  	u32 retry_sz;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  4796  	u16 max_request_credit, nvme_blocks_needed;
f92363d1235949 Sreekanth Reddy          2012-11-30  4797  	unsigned short sg_tablesize;
f92363d1235949 Sreekanth Reddy          2012-11-30  4798  	u16 sge_size;
93204b782a88f2 Chaitra P B              2018-04-24  4799  	int i, j;
93204b782a88f2 Chaitra P B              2018-04-24  4800  	struct chain_tracker *ct;
f92363d1235949 Sreekanth Reddy          2012-11-30  4801
919d8a3f3fef99 Joe Perches              2018-09-17  4802  	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
f92363d1235949 Sreekanth Reddy          2012-11-30  4803
f92363d1235949 Sreekanth Reddy          2012-11-30  4804
f92363d1235949 Sreekanth Reddy          2012-11-30  4805  	retry_sz = 0;
f92363d1235949 Sreekanth Reddy          2012-11-30  4806  	facts = &ioc->facts;
f92363d1235949 Sreekanth Reddy          2012-11-30  4807
f92363d1235949 Sreekanth Reddy          2012-11-30  4808  	/* command line tunables for max sgl entries */
f92363d1235949 Sreekanth Reddy          2012-11-30  4809  	if (max_sgl_entries != -1)
f92363d1235949 Sreekanth Reddy          2012-11-30  4810  		sg_tablesize = max_sgl_entries;
471ef9d4e49825 Sreekanth Reddy          2015-11-11  4811  	else {
471ef9d4e49825 Sreekanth Reddy          2015-11-11  4812  		if (ioc->hba_mpi_version_belonged == MPI2_VERSION)
471ef9d4e49825 Sreekanth Reddy          2015-11-11  4813  			sg_tablesize = MPT2SAS_SG_DEPTH;
f92363d1235949 Sreekanth Reddy          2012-11-30  4814  		else
f92363d1235949 Sreekanth Reddy          2012-11-30  4815  			sg_tablesize = MPT3SAS_SG_DEPTH;
471ef9d4e49825 Sreekanth Reddy          2015-11-11  4816  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  4817
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4818  	/* max sgl entries <= MPT_KDUMP_MIN_PHYS_SEGMENTS in KDUMP mode */
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4819  	if (reset_devices)
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4820  		sg_tablesize = min_t(unsigned short, sg_tablesize,
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4821  		   MPT_KDUMP_MIN_PHYS_SEGMENTS);
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4822
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4823  	if (ioc->is_mcpu_endpoint)
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4824  		ioc->shost->sg_tablesize = MPT_MIN_PHYS_SEGMENTS;
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4825  	else {
8a7e4c24e08fce Sreekanth Reddy          2015-11-11  4826  		if (sg_tablesize < MPT_MIN_PHYS_SEGMENTS)
8a7e4c24e08fce Sreekanth Reddy          2015-11-11  4827  			sg_tablesize = MPT_MIN_PHYS_SEGMENTS;
8a7e4c24e08fce Sreekanth Reddy          2015-11-11  4828  		else if (sg_tablesize > MPT_MAX_PHYS_SEGMENTS) {
ad666a0f41d98e Sreekanth Reddy          2015-01-12  4829  			sg_tablesize = min_t(unsigned short, sg_tablesize,
65e8617fba1773 Ming Lin                 2016-04-04  4830  					SG_MAX_SEGMENTS);
919d8a3f3fef99 Joe Perches              2018-09-17  4831  			ioc_warn(ioc, "sg_tablesize(%u) is bigger than kernel defined SG_CHUNK_SIZE(%u)\n",
8a7e4c24e08fce Sreekanth Reddy          2015-11-11  4832  				 sg_tablesize, MPT_MAX_PHYS_SEGMENTS);
ad666a0f41d98e Sreekanth Reddy          2015-01-12  4833  		}
f92363d1235949 Sreekanth Reddy          2012-11-30  4834  		ioc->shost->sg_tablesize = sg_tablesize;
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4835  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  4836
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4837  	ioc->internal_depth = min_t(int, (facts->HighPriorityCredit + (5)),
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4838  		(facts->RequestCredit / 4));
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4839  	if (ioc->internal_depth < INTERNAL_CMDS_COUNT) {
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4840  		if (facts->RequestCredit <= (INTERNAL_CMDS_COUNT +
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4841  				INTERNAL_SCSIIO_CMDS_COUNT)) {
919d8a3f3fef99 Joe Perches              2018-09-17  4842  			ioc_err(ioc, "IOC doesn't have enough Request Credits, it has just %d number of credits\n",
919d8a3f3fef99 Joe Perches              2018-09-17  4843  				facts->RequestCredit);
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4844  			return -ENOMEM;
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4845  		}
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4846  		ioc->internal_depth = 10;
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4847  	}
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4848
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4849  	ioc->hi_priority_depth = ioc->internal_depth - (5);
f92363d1235949 Sreekanth Reddy          2012-11-30  4850  	/* command line tunables  for max controller queue depth */
f92363d1235949 Sreekanth Reddy          2012-11-30  4851  	if (max_queue_depth != -1 && max_queue_depth != 0) {
f92363d1235949 Sreekanth Reddy          2012-11-30  4852  		max_request_credit = min_t(u16, max_queue_depth +
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4853  			ioc->internal_depth, facts->RequestCredit);
f92363d1235949 Sreekanth Reddy          2012-11-30  4854  		if (max_request_credit > MAX_HBA_QUEUE_DEPTH)
f92363d1235949 Sreekanth Reddy          2012-11-30  4855  			max_request_credit =  MAX_HBA_QUEUE_DEPTH;
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4856  	} else if (reset_devices)
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4857  		max_request_credit = min_t(u16, facts->RequestCredit,
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4858  		    (MPT3SAS_KDUMP_SCSI_IO_DEPTH + ioc->internal_depth));
06f5f976a6ee0f Sreekanth Reddy          2017-10-10  4859  	else
f92363d1235949 Sreekanth Reddy          2012-11-30  4860  		max_request_credit = min_t(u16, facts->RequestCredit,
f92363d1235949 Sreekanth Reddy          2012-11-30  4861  		    MAX_HBA_QUEUE_DEPTH);
f92363d1235949 Sreekanth Reddy          2012-11-30  4862
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4863  	/* Firmware maintains additional facts->HighPriorityCredit number of
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4864  	 * credits for HiPriprity Request messages, so hba queue depth will be
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4865  	 * sum of max_request_credit and high priority queue depth.
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4866  	 */
fd0331b32826dd Suganath prabu Subramani 2016-01-28  4867  	ioc->hba_queue_depth = max_request_credit + ioc->hi_priority_depth;
f92363d1235949 Sreekanth Reddy          2012-11-30  4868
f92363d1235949 Sreekanth Reddy          2012-11-30  4869  	/* request frame size */
f92363d1235949 Sreekanth Reddy          2012-11-30  4870  	ioc->request_sz = facts->IOCRequestFrameSize * 4;
f92363d1235949 Sreekanth Reddy          2012-11-30  4871
f92363d1235949 Sreekanth Reddy          2012-11-30  4872  	/* reply frame size */
f92363d1235949 Sreekanth Reddy          2012-11-30  4873  	ioc->reply_sz = facts->ReplyFrameSize * 4;
f92363d1235949 Sreekanth Reddy          2012-11-30  4874
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4875  	/* chain segment size */
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4876  	if (ioc->hba_mpi_version_belonged != MPI2_VERSION) {
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4877  		if (facts->IOCMaxChainSegmentSize)
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4878  			ioc->chain_segment_sz =
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4879  					facts->IOCMaxChainSegmentSize *
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4880  					MAX_CHAIN_ELEMT_SZ;
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4881  		else
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4882  		/* set to 128 bytes size if IOCMaxChainSegmentSize is zero */
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4883  			ioc->chain_segment_sz = DEFAULT_NUM_FWCHAIN_ELEMTS *
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4884  						    MAX_CHAIN_ELEMT_SZ;
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4885  	} else
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4886  		ioc->chain_segment_sz = ioc->request_sz;
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4887
f92363d1235949 Sreekanth Reddy          2012-11-30  4888  	/* calculate the max scatter element size */
f92363d1235949 Sreekanth Reddy          2012-11-30  4889  	sge_size = max_t(u16, ioc->sge_size, ioc->sge_size_ieee);
f92363d1235949 Sreekanth Reddy          2012-11-30  4890
f92363d1235949 Sreekanth Reddy          2012-11-30  4891   retry_allocation:
f92363d1235949 Sreekanth Reddy          2012-11-30  4892  	total_sz = 0;
f92363d1235949 Sreekanth Reddy          2012-11-30  4893  	/* calculate number of sg elements left over in the 1st frame */
f92363d1235949 Sreekanth Reddy          2012-11-30  4894  	max_sge_elements = ioc->request_sz - ((sizeof(Mpi2SCSIIORequest_t) -
f92363d1235949 Sreekanth Reddy          2012-11-30  4895  	    sizeof(Mpi2SGEIOUnion_t)) + sge_size);
f92363d1235949 Sreekanth Reddy          2012-11-30  4896  	ioc->max_sges_in_main_message = max_sge_elements/sge_size;
f92363d1235949 Sreekanth Reddy          2012-11-30  4897
f92363d1235949 Sreekanth Reddy          2012-11-30  4898  	/* now do the same for a chain buffer */
ebb3024e2fd557 Suganath prabu Subramani 2016-01-28  4899  	max_sge_elements = ioc->chain_segment_sz - sge_size;
f92363d1235949 Sreekanth Reddy          2012-11-30  4900  	ioc->max_sges_in_chain_message = max_sge_elements/sge_size;
f92363d1235949 Sreekanth Reddy          2012-11-30  4901
f92363d1235949 Sreekanth Reddy          2012-11-30  4902  	/*
f92363d1235949 Sreekanth Reddy          2012-11-30  4903  	 *  MPT3SAS_SG_DEPTH = CONFIG_FUSION_MAX_SGE
f92363d1235949 Sreekanth Reddy          2012-11-30  4904  	 */
f92363d1235949 Sreekanth Reddy          2012-11-30  4905  	chains_needed_per_io = ((ioc->shost->sg_tablesize -
f92363d1235949 Sreekanth Reddy          2012-11-30  4906  	   ioc->max_sges_in_main_message)/ioc->max_sges_in_chain_message)
f92363d1235949 Sreekanth Reddy          2012-11-30  4907  	    + 1;
f92363d1235949 Sreekanth Reddy          2012-11-30  4908  	if (chains_needed_per_io > facts->MaxChainDepth) {
f92363d1235949 Sreekanth Reddy          2012-11-30  4909  		chains_needed_per_io = facts->MaxChainDepth;
f92363d1235949 Sreekanth Reddy          2012-11-30  4910  		ioc->shost->sg_tablesize = min_t(u16,
f92363d1235949 Sreekanth Reddy          2012-11-30  4911  		ioc->max_sges_in_main_message + (ioc->max_sges_in_chain_message
f92363d1235949 Sreekanth Reddy          2012-11-30  4912  		* chains_needed_per_io), ioc->shost->sg_tablesize);
f92363d1235949 Sreekanth Reddy          2012-11-30  4913  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  4914  	ioc->chains_needed_per_io = chains_needed_per_io;
f92363d1235949 Sreekanth Reddy          2012-11-30  4915
f92363d1235949 Sreekanth Reddy          2012-11-30  4916  	/* reply free queue sizing - taking into account for 64 FW events */
f92363d1235949 Sreekanth Reddy          2012-11-30  4917  	ioc->reply_free_queue_depth = ioc->hba_queue_depth + 64;
f92363d1235949 Sreekanth Reddy          2012-11-30  4918
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4919  	/* mCPU manage single counters for simplicity */
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4920  	if (ioc->is_mcpu_endpoint)
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4921  		ioc->reply_post_queue_depth = ioc->reply_free_queue_depth;
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4922  	else {
f92363d1235949 Sreekanth Reddy          2012-11-30  4923  		/* calculate reply descriptor post queue depth */
f92363d1235949 Sreekanth Reddy          2012-11-30  4924  		ioc->reply_post_queue_depth = ioc->hba_queue_depth +
f92363d1235949 Sreekanth Reddy          2012-11-30  4925  			ioc->reply_free_queue_depth +  1;
f92363d1235949 Sreekanth Reddy          2012-11-30  4926  		/* align the reply post queue on the next 16 count boundary */
f92363d1235949 Sreekanth Reddy          2012-11-30  4927  		if (ioc->reply_post_queue_depth % 16)
f92363d1235949 Sreekanth Reddy          2012-11-30  4928  			ioc->reply_post_queue_depth += 16 -
f92363d1235949 Sreekanth Reddy          2012-11-30  4929  				(ioc->reply_post_queue_depth % 16);
0448f0195124e3 Suganath Prabu Subramani 2018-02-07  4930  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  4931
f92363d1235949 Sreekanth Reddy          2012-11-30  4932  	if (ioc->reply_post_queue_depth >
f92363d1235949 Sreekanth Reddy          2012-11-30  4933  	    facts->MaxReplyDescriptorPostQueueDepth) {
f92363d1235949 Sreekanth Reddy          2012-11-30  4934  		ioc->reply_post_queue_depth =
f92363d1235949 Sreekanth Reddy          2012-11-30  4935  				facts->MaxReplyDescriptorPostQueueDepth -
f92363d1235949 Sreekanth Reddy          2012-11-30  4936  		    (facts->MaxReplyDescriptorPostQueueDepth % 16);
f92363d1235949 Sreekanth Reddy          2012-11-30  4937  		ioc->hba_queue_depth =
f92363d1235949 Sreekanth Reddy          2012-11-30  4938  				((ioc->reply_post_queue_depth - 64) / 2) - 1;
f92363d1235949 Sreekanth Reddy          2012-11-30  4939  		ioc->reply_free_queue_depth = ioc->hba_queue_depth + 64;
f92363d1235949 Sreekanth Reddy          2012-11-30  4940  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  4941
919d8a3f3fef99 Joe Perches              2018-09-17  4942  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  4943  		    ioc_info(ioc, "scatter gather: sge_in_main_msg(%d), sge_per_chain(%d), sge_per_io(%d), chains_per_io(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  4944  			     ioc->max_sges_in_main_message,
919d8a3f3fef99 Joe Perches              2018-09-17  4945  			     ioc->max_sges_in_chain_message,
919d8a3f3fef99 Joe Perches              2018-09-17  4946  			     ioc->shost->sg_tablesize,
f92363d1235949 Sreekanth Reddy          2012-11-30  4947  			     ioc->chains_needed_per_io));
f92363d1235949 Sreekanth Reddy          2012-11-30  4948
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4949  	/* reply post queue, 16 byte align */
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4950  	reply_post_free_sz = ioc->reply_post_queue_depth *
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4951  	    sizeof(Mpi2DefaultReplyDescriptor_t);
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4952
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4953  	sz = reply_post_free_sz;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4954  	if (_base_is_controller_msix_enabled(ioc) && !ioc->rdpq_array_enable)
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4955  		sz *= ioc->reply_queue_count;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4956
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4957  	ioc->reply_post = kcalloc((ioc->rdpq_array_enable) ?
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4958  	    (ioc->reply_queue_count):1,
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4959  	    sizeof(struct reply_post_struct), GFP_KERNEL);
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4960
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4961  	if (!ioc->reply_post) {
919d8a3f3fef99 Joe Perches              2018-09-17  4962  		ioc_err(ioc, "reply_post_free pool: kcalloc failed\n");
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4963  		goto out;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4964  	}
e9d984182ab8e4 Romain Perier            2017-07-06  4965  	ioc->reply_post_free_dma_pool = dma_pool_create("reply_post_free pool",
e9d984182ab8e4 Romain Perier            2017-07-06  4966  	    &ioc->pdev->dev, sz, 16, 0);
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4967  	if (!ioc->reply_post_free_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  4968  		ioc_err(ioc, "reply_post_free pool: dma_pool_create failed\n");
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4969  		goto out;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4970  	}
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4971  	i = 0;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4972  	do {
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4973  		ioc->reply_post[i].reply_post_free =
c39a4d75539393 Souptick Joarder         2018-10-02  4974  		    dma_pool_zalloc(ioc->reply_post_free_dma_pool,
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4975  		    GFP_KERNEL,
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4976  		    &ioc->reply_post[i].reply_post_free_dma);
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4977  		if (!ioc->reply_post[i].reply_post_free) {
919d8a3f3fef99 Joe Perches              2018-09-17  4978  			ioc_err(ioc, "reply_post_free pool: dma_pool_alloc failed\n");
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4979  			goto out;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4980  		}
919d8a3f3fef99 Joe Perches              2018-09-17  4981  		dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  4982  			    ioc_info(ioc, "reply post free pool (0x%p): depth(%d), element_size(%d), pool_size(%d kB)\n",
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4983  				     ioc->reply_post[i].reply_post_free,
919d8a3f3fef99 Joe Perches              2018-09-17  4984  				     ioc->reply_post_queue_depth,
919d8a3f3fef99 Joe Perches              2018-09-17  4985  				     8, sz / 1024));
919d8a3f3fef99 Joe Perches              2018-09-17  4986  		dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  4987  			    ioc_info(ioc, "reply_post_free_dma = (0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  4988  				     (u64)ioc->reply_post[i].reply_post_free_dma));
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4989  		total_sz += sz;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4990  	} while (ioc->rdpq_array_enable && (++i < ioc->reply_queue_count));
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4991
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4992  	if (ioc->dma_mask == 64) {
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4993  		if (_base_change_consistent_dma_mask(ioc, ioc->pdev) != 0) {
919d8a3f3fef99 Joe Perches              2018-09-17  4994  			ioc_warn(ioc, "no suitable consistent DMA mask for %s\n",
919d8a3f3fef99 Joe Perches              2018-09-17  4995  				 pci_name(ioc->pdev));
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4996  			goto out;
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4997  		}
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4998  	}
9b05c91ae7fbff Sreekanth Reddy          2014-09-12  4999
f92363d1235949 Sreekanth Reddy          2012-11-30  5000  	ioc->scsiio_depth = ioc->hba_queue_depth -
f92363d1235949 Sreekanth Reddy          2012-11-30  5001  	    ioc->hi_priority_depth - ioc->internal_depth;
f92363d1235949 Sreekanth Reddy          2012-11-30  5002
f92363d1235949 Sreekanth Reddy          2012-11-30  5003  	/* set the scsi host can_queue depth
f92363d1235949 Sreekanth Reddy          2012-11-30  5004  	 * with some internal commands that could be outstanding
f92363d1235949 Sreekanth Reddy          2012-11-30  5005  	 */
fd0331b32826dd Suganath prabu Subramani 2016-01-28  5006  	ioc->shost->can_queue = ioc->scsiio_depth - INTERNAL_SCSIIO_CMDS_COUNT;
919d8a3f3fef99 Joe Perches              2018-09-17  5007  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5008  		    ioc_info(ioc, "scsi host: can_queue depth (%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5009  			     ioc->shost->can_queue));
f92363d1235949 Sreekanth Reddy          2012-11-30  5010
f92363d1235949 Sreekanth Reddy          2012-11-30  5011
f92363d1235949 Sreekanth Reddy          2012-11-30  5012  	/* contiguous pool for request and chains, 16 byte align, one extra "
f92363d1235949 Sreekanth Reddy          2012-11-30  5013  	 * "frame for smid=0
f92363d1235949 Sreekanth Reddy          2012-11-30  5014  	 */
f92363d1235949 Sreekanth Reddy          2012-11-30  5015  	ioc->chain_depth = ioc->chains_needed_per_io * ioc->scsiio_depth;
f92363d1235949 Sreekanth Reddy          2012-11-30  5016  	sz = ((ioc->scsiio_depth + 1) * ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5017
f92363d1235949 Sreekanth Reddy          2012-11-30  5018  	/* hi-priority queue */
f92363d1235949 Sreekanth Reddy          2012-11-30  5019  	sz += (ioc->hi_priority_depth * ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5020
f92363d1235949 Sreekanth Reddy          2012-11-30  5021  	/* internal queue */
f92363d1235949 Sreekanth Reddy          2012-11-30  5022  	sz += (ioc->internal_depth * ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5023
f92363d1235949 Sreekanth Reddy          2012-11-30  5024  	ioc->request_dma_sz = sz;
1c2048bdc3f4ff Christoph Hellwig        2018-10-11 @5025  	ioc->request = dma_alloc_coherent(&ioc->pdev->dev, sz,
1c2048bdc3f4ff Christoph Hellwig        2018-10-11  5026  			&ioc->request_dma, GFP_KERNEL);
f92363d1235949 Sreekanth Reddy          2012-11-30  5027  	if (!ioc->request) {
1c2048bdc3f4ff Christoph Hellwig        2018-10-11  5028  		ioc_err(ioc, "request pool: dma_alloc_coherent failed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5029  			ioc->hba_queue_depth, ioc->chains_needed_per_io,
919d8a3f3fef99 Joe Perches              2018-09-17  5030  			ioc->request_sz, sz / 1024);
f92363d1235949 Sreekanth Reddy          2012-11-30  5031  		if (ioc->scsiio_depth < MPT3SAS_SAS_QUEUE_DEPTH)
f92363d1235949 Sreekanth Reddy          2012-11-30  5032  			goto out;
fd0331b32826dd Suganath prabu Subramani 2016-01-28  5033  		retry_sz = 64;
fd0331b32826dd Suganath prabu Subramani 2016-01-28  5034  		ioc->hba_queue_depth -= retry_sz;
8ff045c92708a5 Suganath prabu Subramani 2016-02-18  5035  		_base_release_memory_pools(ioc);
f92363d1235949 Sreekanth Reddy          2012-11-30  5036  		goto retry_allocation;
f92363d1235949 Sreekanth Reddy          2012-11-30  5037  	}
e224e03b0c6a23 Suganath Prabu           2019-08-03  5038  	memset(ioc->request, 0, sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5039
f92363d1235949 Sreekanth Reddy          2012-11-30  5040  	if (retry_sz)
1c2048bdc3f4ff Christoph Hellwig        2018-10-11  5041  		ioc_err(ioc, "request pool: dma_alloc_coherent succeed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kb)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5042  			ioc->hba_queue_depth, ioc->chains_needed_per_io,
919d8a3f3fef99 Joe Perches              2018-09-17  5043  			ioc->request_sz, sz / 1024);
f92363d1235949 Sreekanth Reddy          2012-11-30  5044
f92363d1235949 Sreekanth Reddy          2012-11-30  5045  	/* hi-priority queue */
f92363d1235949 Sreekanth Reddy          2012-11-30  5046  	ioc->hi_priority = ioc->request + ((ioc->scsiio_depth + 1) *
f92363d1235949 Sreekanth Reddy          2012-11-30  5047  	    ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5048  	ioc->hi_priority_dma = ioc->request_dma + ((ioc->scsiio_depth + 1) *
f92363d1235949 Sreekanth Reddy          2012-11-30  5049  	    ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5050
f92363d1235949 Sreekanth Reddy          2012-11-30  5051  	/* internal queue */
f92363d1235949 Sreekanth Reddy          2012-11-30  5052  	ioc->internal = ioc->hi_priority + (ioc->hi_priority_depth *
f92363d1235949 Sreekanth Reddy          2012-11-30  5053  	    ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5054  	ioc->internal_dma = ioc->hi_priority_dma + (ioc->hi_priority_depth *
f92363d1235949 Sreekanth Reddy          2012-11-30  5055  	    ioc->request_sz);
f92363d1235949 Sreekanth Reddy          2012-11-30  5056
919d8a3f3fef99 Joe Perches              2018-09-17  5057  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5058  		    ioc_info(ioc, "request pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5059  			     ioc->request, ioc->hba_queue_depth,
919d8a3f3fef99 Joe Perches              2018-09-17  5060  			     ioc->request_sz,
f92363d1235949 Sreekanth Reddy          2012-11-30  5061  			     (ioc->hba_queue_depth * ioc->request_sz) / 1024));
f92363d1235949 Sreekanth Reddy          2012-11-30  5062
919d8a3f3fef99 Joe Perches              2018-09-17  5063  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5064  		    ioc_info(ioc, "request pool: dma(0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5065  			     (unsigned long long)ioc->request_dma));
f92363d1235949 Sreekanth Reddy          2012-11-30  5066  	total_sz += sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  5067
919d8a3f3fef99 Joe Perches              2018-09-17  5068  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5069  		    ioc_info(ioc, "scsiio(0x%p): depth(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5070  			     ioc->request, ioc->scsiio_depth));
f92363d1235949 Sreekanth Reddy          2012-11-30  5071
f92363d1235949 Sreekanth Reddy          2012-11-30  5072  	ioc->chain_depth = min_t(u32, ioc->chain_depth, MAX_CHAIN_DEPTH);
93204b782a88f2 Chaitra P B              2018-04-24  5073  	sz = ioc->scsiio_depth * sizeof(struct chain_lookup);
93204b782a88f2 Chaitra P B              2018-04-24  5074  	ioc->chain_lookup = kzalloc(sz, GFP_KERNEL);
f92363d1235949 Sreekanth Reddy          2012-11-30  5075  	if (!ioc->chain_lookup) {
919d8a3f3fef99 Joe Perches              2018-09-17  5076  		ioc_err(ioc, "chain_lookup: __get_free_pages failed\n");
93204b782a88f2 Chaitra P B              2018-04-24  5077  		goto out;
93204b782a88f2 Chaitra P B              2018-04-24  5078  	}
93204b782a88f2 Chaitra P B              2018-04-24  5079
93204b782a88f2 Chaitra P B              2018-04-24  5080  	sz = ioc->chains_needed_per_io * sizeof(struct chain_tracker);
93204b782a88f2 Chaitra P B              2018-04-24  5081  	for (i = 0; i < ioc->scsiio_depth; i++) {
93204b782a88f2 Chaitra P B              2018-04-24  5082  		ioc->chain_lookup[i].chains_per_smid = kzalloc(sz, GFP_KERNEL);
93204b782a88f2 Chaitra P B              2018-04-24  5083  		if (!ioc->chain_lookup[i].chains_per_smid) {
919d8a3f3fef99 Joe Perches              2018-09-17  5084  			ioc_err(ioc, "chain_lookup: kzalloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5085  			goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5086  		}
93204b782a88f2 Chaitra P B              2018-04-24  5087  	}
93204b782a88f2 Chaitra P B              2018-04-24  5088
f92363d1235949 Sreekanth Reddy          2012-11-30  5089  	/* initialize hi-priority queue smid's */
f92363d1235949 Sreekanth Reddy          2012-11-30  5090  	ioc->hpr_lookup = kcalloc(ioc->hi_priority_depth,
f92363d1235949 Sreekanth Reddy          2012-11-30  5091  	    sizeof(struct request_tracker), GFP_KERNEL);
f92363d1235949 Sreekanth Reddy          2012-11-30  5092  	if (!ioc->hpr_lookup) {
919d8a3f3fef99 Joe Perches              2018-09-17  5093  		ioc_err(ioc, "hpr_lookup: kcalloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5094  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5095  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  5096  	ioc->hi_priority_smid = ioc->scsiio_depth + 1;
919d8a3f3fef99 Joe Perches              2018-09-17  5097  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5098  		    ioc_info(ioc, "hi_priority(0x%p): depth(%d), start smid(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5099  			     ioc->hi_priority,
f92363d1235949 Sreekanth Reddy          2012-11-30  5100  			     ioc->hi_priority_depth, ioc->hi_priority_smid));
f92363d1235949 Sreekanth Reddy          2012-11-30  5101
f92363d1235949 Sreekanth Reddy          2012-11-30  5102  	/* initialize internal queue smid's */
f92363d1235949 Sreekanth Reddy          2012-11-30  5103  	ioc->internal_lookup = kcalloc(ioc->internal_depth,
f92363d1235949 Sreekanth Reddy          2012-11-30  5104  	    sizeof(struct request_tracker), GFP_KERNEL);
f92363d1235949 Sreekanth Reddy          2012-11-30  5105  	if (!ioc->internal_lookup) {
919d8a3f3fef99 Joe Perches              2018-09-17  5106  		ioc_err(ioc, "internal_lookup: kcalloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5107  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5108  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  5109  	ioc->internal_smid = ioc->hi_priority_smid + ioc->hi_priority_depth;
919d8a3f3fef99 Joe Perches              2018-09-17  5110  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5111  		    ioc_info(ioc, "internal(0x%p): depth(%d), start smid(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5112  			     ioc->internal,
f92363d1235949 Sreekanth Reddy          2012-11-30  5113  			     ioc->internal_depth, ioc->internal_smid));
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5114  	/*
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5115  	 * The number of NVMe page sized blocks needed is:
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5116  	 *     (((sg_tablesize * 8) - 1) / (page_size - 8)) + 1
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5117  	 * ((sg_tablesize * 8) - 1) is the max PRP's minus the first PRP entry
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5118  	 * that is placed in the main message frame.  8 is the size of each PRP
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5119  	 * entry or PRP list pointer entry.  8 is subtracted from page_size
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5120  	 * because of the PRP list pointer entry at the end of a page, so this
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5121  	 * is not counted as a PRP entry.  The 1 added page is a round up.
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5122  	 *
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5123  	 * To avoid allocation failures due to the amount of memory that could
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5124  	 * be required for NVMe PRP's, only each set of NVMe blocks will be
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5125  	 * contiguous, so a new set is allocated for each possible I/O.
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5126  	 */
74522a92bbf003 Chaitra P B              2018-04-24  5127  	ioc->chains_per_prp_buffer = 0;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5128  	if (ioc->facts.ProtocolFlags & MPI2_IOCFACTS_PROTOCOL_NVME_DEVICES) {
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5129  		nvme_blocks_needed =
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5130  			(ioc->shost->sg_tablesize * NVME_PRP_SIZE) - 1;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5131  		nvme_blocks_needed /= (ioc->page_size - NVME_PRP_SIZE);
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5132  		nvme_blocks_needed++;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5133
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5134  		sz = sizeof(struct pcie_sg_list) * ioc->scsiio_depth;
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5135  		ioc->pcie_sg_lookup = kzalloc(sz, GFP_KERNEL);
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5136  		if (!ioc->pcie_sg_lookup) {
919d8a3f3fef99 Joe Perches              2018-09-17  5137  			ioc_info(ioc, "PCIe SGL lookup: kzalloc failed\n");
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5138  			goto out;
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5139  		}
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5140  		sz = nvme_blocks_needed * ioc->page_size;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5141  		ioc->pcie_sgl_dma_pool =
13a0640525367c Romain Perier            2017-11-20  5142  			dma_pool_create("PCIe SGL pool", &ioc->pdev->dev, sz, 16, 0);
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5143  		if (!ioc->pcie_sgl_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5144  			ioc_info(ioc, "PCIe SGL pool: dma_pool_create failed\n");
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5145  			goto out;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5146  		}
74522a92bbf003 Chaitra P B              2018-04-24  5147
74522a92bbf003 Chaitra P B              2018-04-24  5148  		ioc->chains_per_prp_buffer = sz/ioc->chain_segment_sz;
74522a92bbf003 Chaitra P B              2018-04-24  5149  		ioc->chains_per_prp_buffer = min(ioc->chains_per_prp_buffer,
74522a92bbf003 Chaitra P B              2018-04-24  5150  						ioc->chains_needed_per_io);
74522a92bbf003 Chaitra P B              2018-04-24  5151
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5152  		for (i = 0; i < ioc->scsiio_depth; i++) {
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5153  			ioc->pcie_sg_lookup[i].pcie_sgl = dma_pool_alloc(
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5154  				ioc->pcie_sgl_dma_pool, GFP_KERNEL,
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5155  				&ioc->pcie_sg_lookup[i].pcie_sgl_dma);
dbec4c9040edc1 Suganath Prabu Subramani 2018-01-04  5156  			if (!ioc->pcie_sg_lookup[i].pcie_sgl) {
919d8a3f3fef99 Joe Perches              2018-09-17  5157  				ioc_info(ioc, "PCIe SGL pool: dma_pool_alloc failed\n");
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5158  				goto out;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5159  			}
74522a92bbf003 Chaitra P B              2018-04-24  5160  			for (j = 0; j < ioc->chains_per_prp_buffer; j++) {
74522a92bbf003 Chaitra P B              2018-04-24  5161  				ct = &ioc->chain_lookup[i].chains_per_smid[j];
74522a92bbf003 Chaitra P B              2018-04-24  5162  				ct->chain_buffer =
74522a92bbf003 Chaitra P B              2018-04-24  5163  				    ioc->pcie_sg_lookup[i].pcie_sgl +
74522a92bbf003 Chaitra P B              2018-04-24  5164  				    (j * ioc->chain_segment_sz);
74522a92bbf003 Chaitra P B              2018-04-24  5165  				ct->chain_buffer_dma =
74522a92bbf003 Chaitra P B              2018-04-24  5166  				    ioc->pcie_sg_lookup[i].pcie_sgl_dma +
74522a92bbf003 Chaitra P B              2018-04-24  5167  				    (j * ioc->chain_segment_sz);
74522a92bbf003 Chaitra P B              2018-04-24  5168  			}
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5169  		}
f92363d1235949 Sreekanth Reddy          2012-11-30  5170
919d8a3f3fef99 Joe Perches              2018-09-17  5171  		dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5172  			    ioc_info(ioc, "PCIe sgl pool depth(%d), element_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5173  				     ioc->scsiio_depth, sz,
919d8a3f3fef99 Joe Perches              2018-09-17  5174  				     (sz * ioc->scsiio_depth) / 1024));
919d8a3f3fef99 Joe Perches              2018-09-17  5175  		dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5176  			    ioc_info(ioc, "Number of chains can fit in a PRP page(%d)\n",
74522a92bbf003 Chaitra P B              2018-04-24  5177  				     ioc->chains_per_prp_buffer));
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5178  		total_sz += sz * ioc->scsiio_depth;
016d5c35e27824 Suganath Prabu Subramani 2017-10-31  5179  	}
74522a92bbf003 Chaitra P B              2018-04-24  5180
74522a92bbf003 Chaitra P B              2018-04-24  5181  	ioc->chain_dma_pool = dma_pool_create("chain pool", &ioc->pdev->dev,
74522a92bbf003 Chaitra P B              2018-04-24  5182  	    ioc->chain_segment_sz, 16, 0);
74522a92bbf003 Chaitra P B              2018-04-24  5183  	if (!ioc->chain_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5184  		ioc_err(ioc, "chain_dma_pool: dma_pool_create failed\n");
74522a92bbf003 Chaitra P B              2018-04-24  5185  		goto out;
74522a92bbf003 Chaitra P B              2018-04-24  5186  	}
74522a92bbf003 Chaitra P B              2018-04-24  5187  	for (i = 0; i < ioc->scsiio_depth; i++) {
74522a92bbf003 Chaitra P B              2018-04-24  5188  		for (j = ioc->chains_per_prp_buffer;
74522a92bbf003 Chaitra P B              2018-04-24  5189  				j < ioc->chains_needed_per_io; j++) {
74522a92bbf003 Chaitra P B              2018-04-24  5190  			ct = &ioc->chain_lookup[i].chains_per_smid[j];
74522a92bbf003 Chaitra P B              2018-04-24  5191  			ct->chain_buffer = dma_pool_alloc(
74522a92bbf003 Chaitra P B              2018-04-24  5192  					ioc->chain_dma_pool, GFP_KERNEL,
74522a92bbf003 Chaitra P B              2018-04-24  5193  					&ct->chain_buffer_dma);
74522a92bbf003 Chaitra P B              2018-04-24  5194  			if (!ct->chain_buffer) {
919d8a3f3fef99 Joe Perches              2018-09-17  5195  				ioc_err(ioc, "chain_lookup: pci_pool_alloc failed\n");
74522a92bbf003 Chaitra P B              2018-04-24  5196  				_base_release_memory_pools(ioc);
74522a92bbf003 Chaitra P B              2018-04-24  5197  				goto out;
74522a92bbf003 Chaitra P B              2018-04-24  5198  			}
74522a92bbf003 Chaitra P B              2018-04-24  5199  		}
74522a92bbf003 Chaitra P B              2018-04-24  5200  		total_sz += ioc->chain_segment_sz;
74522a92bbf003 Chaitra P B              2018-04-24  5201  	}
74522a92bbf003 Chaitra P B              2018-04-24  5202
919d8a3f3fef99 Joe Perches              2018-09-17  5203  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5204  		    ioc_info(ioc, "chain pool depth(%d), frame_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5205  			     ioc->chain_depth, ioc->chain_segment_sz,
919d8a3f3fef99 Joe Perches              2018-09-17  5206  			     (ioc->chain_depth * ioc->chain_segment_sz) / 1024));
74522a92bbf003 Chaitra P B              2018-04-24  5207
f92363d1235949 Sreekanth Reddy          2012-11-30  5208  	/* sense buffers, 4 byte align */
f92363d1235949 Sreekanth Reddy          2012-11-30  5209  	sz = ioc->scsiio_depth * SCSI_SENSE_BUFFERSIZE;
e9d984182ab8e4 Romain Perier            2017-07-06  5210  	ioc->sense_dma_pool = dma_pool_create("sense pool", &ioc->pdev->dev, sz,
e9d984182ab8e4 Romain Perier            2017-07-06  5211  					      4, 0);
f92363d1235949 Sreekanth Reddy          2012-11-30  5212  	if (!ioc->sense_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5213  		ioc_err(ioc, "sense pool: dma_pool_create failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5214  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5215  	}
e9d984182ab8e4 Romain Perier            2017-07-06  5216  	ioc->sense = dma_pool_alloc(ioc->sense_dma_pool, GFP_KERNEL,
f92363d1235949 Sreekanth Reddy          2012-11-30  5217  	    &ioc->sense_dma);
f92363d1235949 Sreekanth Reddy          2012-11-30  5218  	if (!ioc->sense) {
919d8a3f3fef99 Joe Perches              2018-09-17  5219  		ioc_err(ioc, "sense pool: dma_pool_alloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5220  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5221  	}
e21fef6f331b39 Chaitra P B              2018-04-24  5222  	/* sense buffer requires to be in same 4 gb region.
e21fef6f331b39 Chaitra P B              2018-04-24  5223  	 * Below function will check the same.
e21fef6f331b39 Chaitra P B              2018-04-24  5224  	 * In case of failure, new pci pool will be created with updated
e21fef6f331b39 Chaitra P B              2018-04-24  5225  	 * alignment. Older allocation and pool will be destroyed.
e21fef6f331b39 Chaitra P B              2018-04-24  5226  	 * Alignment will be used such a way that next allocation if
e21fef6f331b39 Chaitra P B              2018-04-24  5227  	 * success, will always meet same 4gb region requirement.
e21fef6f331b39 Chaitra P B              2018-04-24  5228  	 * Actual requirement is not alignment, but we need start and end of
e21fef6f331b39 Chaitra P B              2018-04-24  5229  	 * DMA address must have same upper 32 bit address.
e21fef6f331b39 Chaitra P B              2018-04-24  5230  	 */
e21fef6f331b39 Chaitra P B              2018-04-24  5231  	if (!is_MSB_are_same((long)ioc->sense, sz)) {
e21fef6f331b39 Chaitra P B              2018-04-24  5232  		//Release Sense pool & Reallocate
e21fef6f331b39 Chaitra P B              2018-04-24  5233  		dma_pool_free(ioc->sense_dma_pool, ioc->sense, ioc->sense_dma);
e21fef6f331b39 Chaitra P B              2018-04-24  5234  		dma_pool_destroy(ioc->sense_dma_pool);
e21fef6f331b39 Chaitra P B              2018-04-24  5235  		ioc->sense = NULL;
e21fef6f331b39 Chaitra P B              2018-04-24  5236
e21fef6f331b39 Chaitra P B              2018-04-24  5237  		ioc->sense_dma_pool =
e21fef6f331b39 Chaitra P B              2018-04-24  5238  			dma_pool_create("sense pool", &ioc->pdev->dev, sz,
e21fef6f331b39 Chaitra P B              2018-04-24  5239  						roundup_pow_of_two(sz), 0);
e21fef6f331b39 Chaitra P B              2018-04-24  5240  		if (!ioc->sense_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5241  			ioc_err(ioc, "sense pool: pci_pool_create failed\n");
e21fef6f331b39 Chaitra P B              2018-04-24  5242  			goto out;
e21fef6f331b39 Chaitra P B              2018-04-24  5243  		}
e21fef6f331b39 Chaitra P B              2018-04-24  5244  		ioc->sense = dma_pool_alloc(ioc->sense_dma_pool, GFP_KERNEL,
e21fef6f331b39 Chaitra P B              2018-04-24  5245  				&ioc->sense_dma);
e21fef6f331b39 Chaitra P B              2018-04-24  5246  		if (!ioc->sense) {
919d8a3f3fef99 Joe Perches              2018-09-17  5247  			ioc_err(ioc, "sense pool: pci_pool_alloc failed\n");
e21fef6f331b39 Chaitra P B              2018-04-24  5248  			goto out;
e21fef6f331b39 Chaitra P B              2018-04-24  5249  		}
e21fef6f331b39 Chaitra P B              2018-04-24  5250  	}
919d8a3f3fef99 Joe Perches              2018-09-17  5251  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5252  		    ioc_info(ioc, "sense pool(0x%p): depth(%d), element_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5253  			     ioc->sense, ioc->scsiio_depth,
f92363d1235949 Sreekanth Reddy          2012-11-30  5254  			     SCSI_SENSE_BUFFERSIZE, sz / 1024));
919d8a3f3fef99 Joe Perches              2018-09-17  5255  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5256  		    ioc_info(ioc, "sense_dma(0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5257  			     (unsigned long long)ioc->sense_dma));
f92363d1235949 Sreekanth Reddy          2012-11-30  5258  	total_sz += sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  5259
f92363d1235949 Sreekanth Reddy          2012-11-30  5260  	/* reply pool, 4 byte align */
f92363d1235949 Sreekanth Reddy          2012-11-30  5261  	sz = ioc->reply_free_queue_depth * ioc->reply_sz;
e9d984182ab8e4 Romain Perier            2017-07-06  5262  	ioc->reply_dma_pool = dma_pool_create("reply pool", &ioc->pdev->dev, sz,
e9d984182ab8e4 Romain Perier            2017-07-06  5263  					      4, 0);
f92363d1235949 Sreekanth Reddy          2012-11-30  5264  	if (!ioc->reply_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5265  		ioc_err(ioc, "reply pool: dma_pool_create failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5266  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5267  	}
e9d984182ab8e4 Romain Perier            2017-07-06  5268  	ioc->reply = dma_pool_alloc(ioc->reply_dma_pool, GFP_KERNEL,
f92363d1235949 Sreekanth Reddy          2012-11-30  5269  	    &ioc->reply_dma);
f92363d1235949 Sreekanth Reddy          2012-11-30  5270  	if (!ioc->reply) {
919d8a3f3fef99 Joe Perches              2018-09-17  5271  		ioc_err(ioc, "reply pool: dma_pool_alloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5272  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5273  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  5274  	ioc->reply_dma_min_address = (u32)(ioc->reply_dma);
f92363d1235949 Sreekanth Reddy          2012-11-30  5275  	ioc->reply_dma_max_address = (u32)(ioc->reply_dma) + sz;
919d8a3f3fef99 Joe Perches              2018-09-17  5276  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5277  		    ioc_info(ioc, "reply pool(0x%p): depth(%d), frame_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5278  			     ioc->reply, ioc->reply_free_queue_depth,
919d8a3f3fef99 Joe Perches              2018-09-17  5279  			     ioc->reply_sz, sz / 1024));
919d8a3f3fef99 Joe Perches              2018-09-17  5280  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5281  		    ioc_info(ioc, "reply_dma(0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5282  			     (unsigned long long)ioc->reply_dma));
f92363d1235949 Sreekanth Reddy          2012-11-30  5283  	total_sz += sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  5284
f92363d1235949 Sreekanth Reddy          2012-11-30  5285  	/* reply free queue, 16 byte align */
f92363d1235949 Sreekanth Reddy          2012-11-30  5286  	sz = ioc->reply_free_queue_depth * 4;
e9d984182ab8e4 Romain Perier            2017-07-06  5287  	ioc->reply_free_dma_pool = dma_pool_create("reply_free pool",
e9d984182ab8e4 Romain Perier            2017-07-06  5288  	    &ioc->pdev->dev, sz, 16, 0);
f92363d1235949 Sreekanth Reddy          2012-11-30  5289  	if (!ioc->reply_free_dma_pool) {
919d8a3f3fef99 Joe Perches              2018-09-17  5290  		ioc_err(ioc, "reply_free pool: dma_pool_create failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5291  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5292  	}
c39a4d75539393 Souptick Joarder         2018-10-02  5293  	ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
f92363d1235949 Sreekanth Reddy          2012-11-30  5294  	    &ioc->reply_free_dma);
f92363d1235949 Sreekanth Reddy          2012-11-30  5295  	if (!ioc->reply_free) {
919d8a3f3fef99 Joe Perches              2018-09-17  5296  		ioc_err(ioc, "reply_free pool: dma_pool_alloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5297  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5298  	}
919d8a3f3fef99 Joe Perches              2018-09-17  5299  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5300  		    ioc_info(ioc, "reply_free pool(0x%p): depth(%d), element_size(%d), pool_size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5301  			     ioc->reply_free, ioc->reply_free_queue_depth,
919d8a3f3fef99 Joe Perches              2018-09-17  5302  			     4, sz / 1024));
919d8a3f3fef99 Joe Perches              2018-09-17  5303  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5304  		    ioc_info(ioc, "reply_free_dma (0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5305  			     (unsigned long long)ioc->reply_free_dma));
f92363d1235949 Sreekanth Reddy          2012-11-30  5306  	total_sz += sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  5307
cd33223b59a493 Chaitra P B              2018-04-24  5308  	if (ioc->rdpq_array_enable) {
cd33223b59a493 Chaitra P B              2018-04-24  5309  		reply_post_free_array_sz = ioc->reply_queue_count *
cd33223b59a493 Chaitra P B              2018-04-24  5310  		    sizeof(Mpi2IOCInitRDPQArrayEntry);
cd33223b59a493 Chaitra P B              2018-04-24  5311  		ioc->reply_post_free_array_dma_pool =
cd33223b59a493 Chaitra P B              2018-04-24  5312  		    dma_pool_create("reply_post_free_array pool",
cd33223b59a493 Chaitra P B              2018-04-24  5313  		    &ioc->pdev->dev, reply_post_free_array_sz, 16, 0);
cd33223b59a493 Chaitra P B              2018-04-24  5314  		if (!ioc->reply_post_free_array_dma_pool) {
cd33223b59a493 Chaitra P B              2018-04-24  5315  			dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5316  				    ioc_info(ioc, "reply_post_free_array pool: dma_pool_create failed\n"));
cd33223b59a493 Chaitra P B              2018-04-24  5317  			goto out;
cd33223b59a493 Chaitra P B              2018-04-24  5318  		}
cd33223b59a493 Chaitra P B              2018-04-24  5319  		ioc->reply_post_free_array =
cd33223b59a493 Chaitra P B              2018-04-24  5320  		    dma_pool_alloc(ioc->reply_post_free_array_dma_pool,
cd33223b59a493 Chaitra P B              2018-04-24  5321  		    GFP_KERNEL, &ioc->reply_post_free_array_dma);
cd33223b59a493 Chaitra P B              2018-04-24  5322  		if (!ioc->reply_post_free_array) {
cd33223b59a493 Chaitra P B              2018-04-24  5323  			dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5324  				    ioc_info(ioc, "reply_post_free_array pool: dma_pool_alloc failed\n"));
cd33223b59a493 Chaitra P B              2018-04-24  5325  			goto out;
cd33223b59a493 Chaitra P B              2018-04-24  5326  		}
cd33223b59a493 Chaitra P B              2018-04-24  5327  	}
f92363d1235949 Sreekanth Reddy          2012-11-30  5328  	ioc->config_page_sz = 512;
1c2048bdc3f4ff Christoph Hellwig        2018-10-11  5329  	ioc->config_page = dma_alloc_coherent(&ioc->pdev->dev,
1c2048bdc3f4ff Christoph Hellwig        2018-10-11  5330  			ioc->config_page_sz, &ioc->config_page_dma, GFP_KERNEL);
f92363d1235949 Sreekanth Reddy          2012-11-30  5331  	if (!ioc->config_page) {
919d8a3f3fef99 Joe Perches              2018-09-17  5332  		ioc_err(ioc, "config page: dma_pool_alloc failed\n");
f92363d1235949 Sreekanth Reddy          2012-11-30  5333  		goto out;
f92363d1235949 Sreekanth Reddy          2012-11-30  5334  	}
919d8a3f3fef99 Joe Perches              2018-09-17  5335  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5336  		    ioc_info(ioc, "config page(0x%p): size(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5337  			     ioc->config_page, ioc->config_page_sz));
919d8a3f3fef99 Joe Perches              2018-09-17  5338  	dinitprintk(ioc,
919d8a3f3fef99 Joe Perches              2018-09-17  5339  		    ioc_info(ioc, "config_page_dma(0x%llx)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5340  			     (unsigned long long)ioc->config_page_dma));
f92363d1235949 Sreekanth Reddy          2012-11-30  5341  	total_sz += ioc->config_page_sz;
f92363d1235949 Sreekanth Reddy          2012-11-30  5342
919d8a3f3fef99 Joe Perches              2018-09-17  5343  	ioc_info(ioc, "Allocated physical memory: size(%d kB)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5344  		 total_sz / 1024);
919d8a3f3fef99 Joe Perches              2018-09-17  5345  	ioc_info(ioc, "Current Controller Queue Depth(%d),Max Controller Queue Depth(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5346  		 ioc->shost->can_queue, facts->RequestCredit);
919d8a3f3fef99 Joe Perches              2018-09-17  5347  	ioc_info(ioc, "Scatter Gather Elements per IO(%d)\n",
919d8a3f3fef99 Joe Perches              2018-09-17  5348  		 ioc->shost->sg_tablesize);
f92363d1235949 Sreekanth Reddy          2012-11-30  5349  	return 0;
f92363d1235949 Sreekanth Reddy          2012-11-30  5350
f92363d1235949 Sreekanth Reddy          2012-11-30  5351   out:
f92363d1235949 Sreekanth Reddy          2012-11-30  5352  	return -ENOMEM;
f92363d1235949 Sreekanth Reddy          2012-11-30  5353  }
f92363d1235949 Sreekanth Reddy          2012-11-30  5354

:::::: The code at line 5025 was first introduced by commit
:::::: 1c2048bdc3f4ff3337613c27519cf608916e95a9 scsi: mpt3sas: switch to generic DMA API

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--nFreZHaLTZJo0R7j
Content-Type: application/gzip; CHARSET=US-ASCII
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2007071243273.2569@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=.config.gz

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
HxYWE3hx287Tgf8Bh9oDcCT9AQA=

--nFreZHaLTZJo0R7j--
