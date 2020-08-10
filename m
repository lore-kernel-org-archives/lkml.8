Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C93622E00
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgHJQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:50:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:61292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgHJQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:50:00 -0400
IronPort-SDR: UnPKLK1rKBIEGW9M/Na/5gZ06FUkJjtIuqE8Zgd3Y5DwZp4ss1MltxapwFX/Uf5Im9xroDc+DW
 cs3jsjwrNnCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171607965"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="171607965"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 09:40:40 -0700
IronPort-SDR: QssitV/rs5VOX0UI4uOgeuj2E4zp9MTp2GFjDzG07fiKupnfO/jK2pFJ9Zo8S0U64H25OKv/vr
 iRZSnLCCgEtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="469103572"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 09:40:38 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5Aqj-00004u-Qi; Mon, 10 Aug 2020 16:40:37 +0000
Date:   Tue, 11 Aug 2020 00:39:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Omer Shpigelman <oshpigelman@habana.ai>
Subject: drivers/misc/habanalabs/common/command_submission.c:950
 cs_ioctl_signal_wait() warn: should 'cb->id << (12)' be a 64 bit
Message-ID: <202008110054.OWuElhWL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 70b2f993ea4a79c298aac4ec1c58089020536ba5 habanalabs: create common folder
date:   2 weeks ago
config: riscv-randconfig-m031-20200810 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/misc/habanalabs/common/command_submission.c:950 cs_ioctl_signal_wait() warn: should 'cb->id << (12)' be a 64 bit type?

vim +950 drivers/misc/habanalabs/common/command_submission.c

eff6f4a0e70b7b drivers/misc/habanalabs/command_submission.c Oded Gabbay     2019-02-16  768  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  769  static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  770  				void __user *chunks, u32 num_chunks,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  771  				u64 *cs_seq)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  772  {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  773  	struct hl_device *hdev = hpriv->hdev;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  774  	struct hl_ctx *ctx = hpriv->ctx;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  775  	struct hl_cs_chunk *cs_chunk_array, *chunk;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  776  	struct hw_queue_properties *hw_queue_prop;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  777  	struct dma_fence *sig_fence = NULL;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  778  	struct hl_cs_job *job;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  779  	struct hl_cs *cs;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  780  	struct hl_cb *cb;
21e7a346344959 drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-05-14  781  	enum hl_queue_type q_type;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  782  	u64 *signal_seq_arr = NULL, signal_seq;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  783  	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  784  	int rc;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  785  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  786  	*cs_seq = ULLONG_MAX;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  787  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  788  	if (num_chunks > HL_MAX_JOBS_PER_CS) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  789  		dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  790  			"Number of chunks can NOT be larger than %d\n",
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  791  			HL_MAX_JOBS_PER_CS);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  792  		rc = -EINVAL;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  793  		goto out;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  794  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  795  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  796  	cs_chunk_array = kmalloc_array(num_chunks, sizeof(*cs_chunk_array),
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  797  					GFP_ATOMIC);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  798  	if (!cs_chunk_array) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  799  		rc = -ENOMEM;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  800  		goto out;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  801  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  802  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  803  	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  804  	if (copy_from_user(cs_chunk_array, chunks, size_to_copy)) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  805  		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  806  		rc = -EFAULT;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  807  		goto free_cs_chunk_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  808  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  809  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  810  	/* currently it is guaranteed to have only one chunk */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  811  	chunk = &cs_chunk_array[0];
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  812  	q_idx = chunk->queue_index;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  813  	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
21e7a346344959 drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-05-14  814  	q_type = hw_queue_prop->type;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  815  
3abc99bb7dcbc0 drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-06-23  816  	if ((q_idx >= hdev->asic_prop.max_queues) ||
21e7a346344959 drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-05-14  817  			(!hw_queue_prop->supports_sync_stream)) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  818  		dev_err(hdev->dev, "Queue index %d is invalid\n", q_idx);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  819  		rc = -EINVAL;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  820  		goto free_cs_chunk_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  821  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  822  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  823  	if (cs_type == CS_TYPE_WAIT) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  824  		struct hl_cs_compl *sig_waitcs_cmpl;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  825  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  826  		signal_seq_arr_len = chunk->num_signal_seq_arr;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  827  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  828  		/* currently only one signal seq is supported */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  829  		if (signal_seq_arr_len != 1) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  830  			dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  831  				"Wait for signal CS supports only one signal CS seq\n");
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  832  			rc = -EINVAL;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  833  			goto free_cs_chunk_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  834  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  835  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  836  		signal_seq_arr = kmalloc_array(signal_seq_arr_len,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  837  						sizeof(*signal_seq_arr),
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  838  						GFP_ATOMIC);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  839  		if (!signal_seq_arr) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  840  			rc = -ENOMEM;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  841  			goto free_cs_chunk_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  842  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  843  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  844  		size_to_copy = chunk->num_signal_seq_arr *
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  845  				sizeof(*signal_seq_arr);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  846  		if (copy_from_user(signal_seq_arr,
05c8a4fc44a916 drivers/misc/habanalabs/command_submission.c Oded Gabbay     2020-06-01  847  					u64_to_user_ptr(chunk->signal_seq_arr),
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  848  					size_to_copy)) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  849  			dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  850  				"Failed to copy signal seq array from user\n");
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  851  			rc = -EFAULT;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  852  			goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  853  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  854  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  855  		/* currently it is guaranteed to have only one signal seq */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  856  		signal_seq = signal_seq_arr[0];
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  857  		sig_fence = hl_ctx_get_fence(ctx, signal_seq);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  858  		if (IS_ERR(sig_fence)) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  859  			dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  860  				"Failed to get signal CS with seq 0x%llx\n",
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  861  				signal_seq);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  862  			rc = PTR_ERR(sig_fence);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  863  			goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  864  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  865  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  866  		if (!sig_fence) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  867  			/* signal CS already finished */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  868  			rc = 0;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  869  			goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  870  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  871  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  872  		sig_waitcs_cmpl =
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  873  			container_of(sig_fence, struct hl_cs_compl, base_fence);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  874  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  875  		if (sig_waitcs_cmpl->type != CS_TYPE_SIGNAL) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  876  			dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  877  				"CS seq 0x%llx is not of a signal CS\n",
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  878  				signal_seq);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  879  			dma_fence_put(sig_fence);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  880  			rc = -EINVAL;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  881  			goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  882  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  883  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  884  		if (dma_fence_is_signaled(sig_fence)) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  885  			/* signal CS already finished */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  886  			dma_fence_put(sig_fence);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  887  			rc = 0;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  888  			goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  889  		}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  890  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  891  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  892  	/* increment refcnt for context */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  893  	hl_ctx_get(hdev, ctx);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  894  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  895  	rc = allocate_cs(hdev, ctx, cs_type, &cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  896  	if (rc) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  897  		if (cs_type == CS_TYPE_WAIT)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  898  			dma_fence_put(sig_fence);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  899  		hl_ctx_put(ctx);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  900  		goto free_signal_seq_array;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  901  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  902  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  903  	/*
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  904  	 * Save the signal CS fence for later initialization right before
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  905  	 * hanging the wait CS on the queue.
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  906  	 */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  907  	if (cs->type == CS_TYPE_WAIT)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  908  		cs->signal_fence = sig_fence;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  909  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  910  	hl_debugfs_add_cs(cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  911  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  912  	*cs_seq = cs->sequence;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  913  
21e7a346344959 drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-05-14  914  	job = hl_cs_allocate_job(hdev, q_type, true);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  915  	if (!job) {
db491e4f08a9fd drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-06-18  916  		ctx->cs_counters.out_of_mem_drop_cnt++;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  917  		dev_err(hdev->dev, "Failed to allocate a new job\n");
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  918  		rc = -ENOMEM;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  919  		goto put_cs;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  920  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  921  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  922  	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  923  	if (!cb) {
db491e4f08a9fd drivers/misc/habanalabs/command_submission.c Ofir Bitton     2020-06-18  924  		ctx->cs_counters.out_of_mem_drop_cnt++;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  925  		kfree(job);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  926  		rc = -EFAULT;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  927  		goto put_cs;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  928  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  929  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  930  	if (cs->type == CS_TYPE_WAIT)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  931  		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  932  	else
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  933  		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  934  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  935  	job->id = 0;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  936  	job->cs = cs;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  937  	job->user_cb = cb;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  938  	job->user_cb->cs_cnt++;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  939  	job->user_cb_size = cb_size;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  940  	job->hw_queue_id = q_idx;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  941  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  942  	/*
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  943  	 * No need in parsing, user CB is the patched CB.
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  944  	 * We call hl_cb_destroy() out of two reasons - we don't need the CB in
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  945  	 * the CB idr anymore and to decrement its refcount as it was
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  946  	 * incremented inside hl_cb_kernel_create().
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  947  	 */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  948  	job->patched_cb = job->user_cb;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  949  	job->job_cb_size = job->user_cb_size;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07 @950  	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  951  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  952  	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  953  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  954  	list_add_tail(&job->cs_node, &cs->job_list);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  955  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  956  	/* increment refcount as for external queues we get completion */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  957  	cs_get(cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  958  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  959  	hl_debugfs_add_job(hdev, job);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  960  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  961  	rc = hl_hw_queue_schedule_cs(cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  962  	if (rc) {
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  963  		if (rc != -EAGAIN)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  964  			dev_err(hdev->dev,
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  965  				"Failed to submit CS %d.%llu to H/W queues, error %d\n",
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  966  				ctx->asid, cs->sequence, rc);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  967  		goto free_cs_object;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  968  	}
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  969  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  970  	rc = HL_CS_STATUS_SUCCESS;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  971  	goto put_cs;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  972  
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  973  free_cs_object:
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  974  	cs_rollback(hdev, cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  975  	*cs_seq = ULLONG_MAX;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  976  	/* The path below is both for good and erroneous exits */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  977  put_cs:
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  978  	/* We finished with the CS in this function, so put the ref */
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  979  	cs_put(cs);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  980  free_signal_seq_array:
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  981  	if (cs_type == CS_TYPE_WAIT)
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  982  		kfree(signal_seq_arr);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  983  free_cs_chunk_array:
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  984  	kfree(cs_chunk_array);
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  985  out:
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  986  	return rc;
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  987  }
b75f22505ac97e drivers/misc/habanalabs/command_submission.c Omer Shpigelman 2020-05-07  988  

:::::: The code at line 950 was first introduced by commit
:::::: b75f22505ac97ea680bcc3e23dcd56f421252b43 habanalabs: add signal/wait to CS IOCTL operations

:::::: TO: Omer Shpigelman <oshpigelman@habana.ai>
:::::: CC: Oded Gabbay <oded.gabbay@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qRue1ezLYBZGz06PDttzSjaHl/8DIbJDu/zDAQA=

--EeQfGwPcQSOJBaQU--
