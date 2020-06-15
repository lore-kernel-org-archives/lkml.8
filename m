Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B71BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66D72078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgFONob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:44:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:13427 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgFONo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:44:27 -0400
IronPort-SDR: SZntHs7NpvxBNvdPWlD19gsMAXV4OutlrSbV5xDCC4gdp1lBL8Fhsf90DpW9BzI+LEBS/rtJvz
 QxOmIXUMy0ow==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 06:37:21 -0700
IronPort-SDR: 1xokNhRqT0foTwEY8wwCpCpT3DEJ+/UIQkVnkl3/DfE4+OvrPjB8xwU87H367lsOUW6jnzkj2A
 SZipichJmD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="gz'50?scan'50,208,50";a="261787585"
Received: from lkp-server02.sh.intel.com (HELO ec7aa6149bd9) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2020 06:37:18 -0700
Received: from kbuild by ec7aa6149bd9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jkpIb-000018-Kh; Mon, 15 Jun 2020 13:37:17 +0000
Date:   Mon, 15 Jun 2020 21:36:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/bnx2fc/bnx2fc_hwi.c:638:16: warning: variable 'index'
 set but not used
Message-ID: <202006152151.m4036Qw0%lkp@intel.com>
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

Hi zhengbin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b3a9e3b9622ae10064826dccb4f7a52bd88c7407
commit: 84769706dde5881b8da0dc3da666f7443be95a8a scsi: bnx2fc: remove set but not used variables 'task','port','orig_task'
date:   10 months ago
config: ia64-randconfig-r003-20200615 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 84769706dde5881b8da0dc3da666f7443be95a8a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from arch/ia64/include/asm/pgtable.h:154,
from include/linux/mm.h:99,
from arch/ia64/include/asm/uaccess.h:38,
from include/linux/uaccess.h:11,
from include/linux/crypto.h:21,
from include/crypto/hash.h:11,
from include/linux/uio.h:10,
from include/linux/socket.h:8,
from include/linux/skbuff.h:19,
from drivers/scsi/bnx2fc/bnx2fc.h:21,
from drivers/scsi/bnx2fc/bnx2fc_hwi.c:16:
arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
arch/ia64/include/asm/mmu_context.h:137:41: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
137 |  unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
|                                         ^~~~~~~
drivers/scsi/bnx2fc/bnx2fc_hwi.c: In function 'bnx2fc_process_unsol_compl':
<<                  from drivers/scsi/bnx2fc/bnx2fc_hwi.c:16:
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:638:16: warning: variable 'index' set but not used [-Wunused-but-set-variable]
638 |  int task_idx, index;
|                ^~~~~
<<                  from drivers/scsi/bnx2fc/bnx2fc_hwi.c:16:
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:638:6: warning: variable 'task_idx' set but not used [-Wunused-but-set-variable]
638 |  int task_idx, index;
|      ^~~~~~~~
drivers/scsi/bnx2fc/bnx2fc_hwi.c: In function 'bnx2fc_init_seq_cleanup_task':
drivers/scsi/bnx2fc/bnx2fc_hwi.c:1466:21: warning: variable 'index' set but not used [-Wunused-but-set-variable]
1466 |  int orig_task_idx, index;
|                     ^~~~~
<<                  from drivers/scsi/bnx2fc/bnx2fc_hwi.c:16:
>> drivers/scsi/bnx2fc/bnx2fc_hwi.c:1466:6: warning: variable 'orig_task_idx' set but not used [-Wunused-but-set-variable]
1466 |  int orig_task_idx, index;
|      ^~~~~~~~~~~~~
drivers/scsi/bnx2fc/bnx2fc_hwi.c: In function 'bnx2fc_allocate_hash_table':
drivers/scsi/bnx2fc/bnx2fc_hwi.c:2046:7: warning: variable 'hi' set but not used [-Wunused-but-set-variable]
2046 |   u32 hi;
|       ^~
drivers/scsi/bnx2fc/bnx2fc_hwi.c:2045:7: warning: variable 'lo' set but not used [-Wunused-but-set-variable]
2045 |   u32 lo;
|       ^~

vim +/index +638 drivers/scsi/bnx2fc/bnx2fc_hwi.c

853e2bd2103aaa Bhanu Gollapudi         2011-02-04  625  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  626  static void bnx2fc_process_unsol_compl(struct bnx2fc_rport *tgt, u16 wqe)
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  627  {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  628  	u8 num_rq;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  629  	struct fcoe_err_report_entry *err_entry;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  630  	unsigned char *rq_data;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  631  	unsigned char *buf = NULL, *buf1;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  632  	int i;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  633  	u16 xid;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  634  	u32 frame_len, len;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  635  	struct bnx2fc_cmd *io_req = NULL;
aea71a024914e8 Bhanu Prakash Gollapudi 2011-07-26  636  	struct bnx2fc_interface *interface = tgt->port->priv;
aea71a024914e8 Bhanu Prakash Gollapudi 2011-07-26  637  	struct bnx2fc_hba *hba = interface->hba;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04 @638  	int task_idx, index;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  639  	int rc = 0;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  640  	u64 err_warn_bit_map;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  641  	u8 err_warn = 0xff;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  642  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  643  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  644  	BNX2FC_TGT_DBG(tgt, "Entered UNSOL COMPLETION wqe = 0x%x\n", wqe);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  645  	switch (wqe & FCOE_UNSOLICITED_CQE_SUBTYPE) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  646  	case FCOE_UNSOLICITED_FRAME_CQE_TYPE:
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  647  		frame_len = (wqe & FCOE_UNSOLICITED_CQE_PKT_LEN) >>
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  648  			     FCOE_UNSOLICITED_CQE_PKT_LEN_SHIFT;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  649  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  650  		num_rq = (frame_len + BNX2FC_RQ_BUF_SZ - 1) / BNX2FC_RQ_BUF_SZ;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  651  
686959736a8543 Nithin Sujir            2011-03-17  652  		spin_lock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  653  		rq_data = (unsigned char *)bnx2fc_get_next_rqe(tgt, num_rq);
686959736a8543 Nithin Sujir            2011-03-17  654  		spin_unlock_bh(&tgt->tgt_lock);
686959736a8543 Nithin Sujir            2011-03-17  655  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  656  		if (rq_data) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  657  			buf = rq_data;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  658  		} else {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  659  			buf1 = buf = kmalloc((num_rq * BNX2FC_RQ_BUF_SZ),
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  660  					      GFP_ATOMIC);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  661  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  662  			if (!buf1) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  663  				BNX2FC_TGT_DBG(tgt, "Memory alloc failure\n");
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  664  				break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  665  			}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  666  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  667  			for (i = 0; i < num_rq; i++) {
686959736a8543 Nithin Sujir            2011-03-17  668  				spin_lock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  669  				rq_data = (unsigned char *)
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  670  					   bnx2fc_get_next_rqe(tgt, 1);
686959736a8543 Nithin Sujir            2011-03-17  671  				spin_unlock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  672  				len = BNX2FC_RQ_BUF_SZ;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  673  				memcpy(buf1, rq_data, len);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  674  				buf1 += len;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  675  			}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  676  		}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  677  		bnx2fc_process_l2_frame_compl(tgt, buf, frame_len,
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  678  					      FC_XID_UNKNOWN);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  679  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  680  		if (buf != rq_data)
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  681  			kfree(buf);
686959736a8543 Nithin Sujir            2011-03-17  682  		spin_lock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  683  		bnx2fc_return_rqe(tgt, num_rq);
686959736a8543 Nithin Sujir            2011-03-17  684  		spin_unlock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  685  		break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  686  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  687  	case FCOE_ERROR_DETECTION_CQE_TYPE:
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  688  		/*
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  689  		 * In case of error reporting CQE a single RQ entry
686959736a8543 Nithin Sujir            2011-03-17  690  		 * is consumed.
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  691  		 */
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  692  		spin_lock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  693  		num_rq = 1;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  694  		err_entry = (struct fcoe_err_report_entry *)
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  695  			     bnx2fc_get_next_rqe(tgt, 1);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  696  		xid = err_entry->fc_hdr.ox_id;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  697  		BNX2FC_TGT_DBG(tgt, "Unsol Error Frame OX_ID = 0x%x\n", xid);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  698  		BNX2FC_TGT_DBG(tgt, "err_warn_bitmap = %08x:%08x\n",
619c5cb6885b93 Vlad Zolotarov          2011-06-14  699  			err_entry->data.err_warn_bitmap_hi,
619c5cb6885b93 Vlad Zolotarov          2011-06-14  700  			err_entry->data.err_warn_bitmap_lo);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  701  		BNX2FC_TGT_DBG(tgt, "buf_offsets - tx = 0x%x, rx = 0x%x\n",
619c5cb6885b93 Vlad Zolotarov          2011-06-14  702  			err_entry->data.tx_buf_off, err_entry->data.rx_buf_off);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  703  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  704  
0eb43b4bb081a1 Bhanu Prakash Gollapudi 2013-04-22  705  		if (xid > hba->max_xid) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  706  			BNX2FC_TGT_DBG(tgt, "xid(0x%x) out of FW range\n",
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  707  				   xid);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  708  			goto ret_err_rqe;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  709  		}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  710  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  711  		task_idx = xid / BNX2FC_TASKS_PER_PAGE;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  712  		index = xid % BNX2FC_TASKS_PER_PAGE;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  713  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  714  		io_req = (struct bnx2fc_cmd *)hba->cmd_mgr->cmds[xid];
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  715  		if (!io_req)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  716  			goto ret_err_rqe;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  717  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  718  		if (io_req->cmd_type != BNX2FC_SCSI_CMD) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  719  			printk(KERN_ERR PFX "err_warn: Not a SCSI cmd\n");
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  720  			goto ret_err_rqe;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  721  		}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  722  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  723  		if (test_and_clear_bit(BNX2FC_FLAG_IO_CLEANUP,
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  724  				       &io_req->req_flags)) {
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  725  			BNX2FC_IO_DBG(io_req, "unsol_err: cleanup in "
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  726  					    "progress.. ignore unsol err\n");
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  727  			goto ret_err_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  728  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  729  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  730  		err_warn_bit_map = (u64)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  731  			((u64)err_entry->data.err_warn_bitmap_hi << 32) |
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  732  			(u64)err_entry->data.err_warn_bitmap_lo;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  733  		for (i = 0; i < BNX2FC_NUM_ERR_BITS; i++) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  734  			if (err_warn_bit_map & (u64)((u64)1 << i)) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  735  				err_warn = i;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  736  				break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  737  			}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  738  		}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  739  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  740  		/*
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  741  		 * If ABTS is already in progress, and FW error is
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  742  		 * received after that, do not cancel the timeout_work
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  743  		 * and let the error recovery continue by explicitly
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  744  		 * logging out the target, when the ABTS eventually
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  745  		 * times out.
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  746  		 */
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  747  		if (test_bit(BNX2FC_FLAG_ISSUE_ABTS, &io_req->req_flags)) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  748  			printk(KERN_ERR PFX "err_warn: io_req (0x%x) already "
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  749  					    "in ABTS processing\n", xid);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  750  			goto ret_err_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  751  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  752  		BNX2FC_TGT_DBG(tgt, "err = 0x%x\n", err_warn);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  753  		if (tgt->dev_type != TYPE_TAPE)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  754  			goto skip_rec;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  755  		switch (err_warn) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  756  		case FCOE_ERROR_CODE_REC_TOV_TIMER_EXPIRATION:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  757  		case FCOE_ERROR_CODE_DATA_OOO_RO:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  758  		case FCOE_ERROR_CODE_COMMON_INCORRECT_SEQ_CNT:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  759  		case FCOE_ERROR_CODE_DATA_SOFI3_SEQ_ACTIVE_SET:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  760  		case FCOE_ERROR_CODE_FCP_RSP_OPENED_SEQ:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  761  		case FCOE_ERROR_CODE_DATA_SOFN_SEQ_ACTIVE_RESET:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  762  			BNX2FC_TGT_DBG(tgt, "REC TOV popped for xid - 0x%x\n",
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  763  				   xid);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  764  			memcpy(&io_req->err_entry, err_entry,
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  765  			       sizeof(struct fcoe_err_report_entry));
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  766  			if (!test_bit(BNX2FC_FLAG_SRR_SENT,
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  767  				      &io_req->req_flags)) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  768  				spin_unlock_bh(&tgt->tgt_lock);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  769  				rc = bnx2fc_send_rec(io_req);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  770  				spin_lock_bh(&tgt->tgt_lock);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  771  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  772  				if (rc)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  773  					goto skip_rec;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  774  			} else
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  775  				printk(KERN_ERR PFX "SRR in progress\n");
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  776  			goto ret_err_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  777  			break;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  778  		default:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  779  			break;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  780  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  781  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  782  skip_rec:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  783  		set_bit(BNX2FC_FLAG_ISSUE_ABTS, &io_req->req_flags);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  784  		/*
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  785  		 * Cancel the timeout_work, as we received IO
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  786  		 * completion with FW error.
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  787  		 */
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  788  		if (cancel_delayed_work(&io_req->timeout_work))
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  789  			kref_put(&io_req->refcount, bnx2fc_cmd_release);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  790  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  791  		rc = bnx2fc_initiate_abts(io_req);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  792  		if (rc != SUCCESS) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  793  			printk(KERN_ERR PFX "err_warn: initiate_abts "
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  794  				"failed xid = 0x%x. issue cleanup\n",
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  795  				io_req->xid);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  796  			bnx2fc_initiate_cleanup(io_req);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  797  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  798  ret_err_rqe:
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  799  		bnx2fc_return_rqe(tgt, 1);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  800  		spin_unlock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  801  		break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  802  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  803  	case FCOE_WARNING_DETECTION_CQE_TYPE:
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  804  		/*
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  805  		 *In case of warning reporting CQE a single RQ entry
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  806  		 * is consumes.
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  807  		 */
686959736a8543 Nithin Sujir            2011-03-17  808  		spin_lock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  809  		num_rq = 1;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  810  		err_entry = (struct fcoe_err_report_entry *)
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  811  			     bnx2fc_get_next_rqe(tgt, 1);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  812  		xid = cpu_to_be16(err_entry->fc_hdr.ox_id);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  813  		BNX2FC_TGT_DBG(tgt, "Unsol Warning Frame OX_ID = 0x%x\n", xid);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  814  		BNX2FC_TGT_DBG(tgt, "err_warn_bitmap = %08x:%08x",
619c5cb6885b93 Vlad Zolotarov          2011-06-14  815  			err_entry->data.err_warn_bitmap_hi,
619c5cb6885b93 Vlad Zolotarov          2011-06-14  816  			err_entry->data.err_warn_bitmap_lo);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  817  		BNX2FC_TGT_DBG(tgt, "buf_offsets - tx = 0x%x, rx = 0x%x",
619c5cb6885b93 Vlad Zolotarov          2011-06-14  818  			err_entry->data.tx_buf_off, err_entry->data.rx_buf_off);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  819  
0eb43b4bb081a1 Bhanu Prakash Gollapudi 2013-04-22  820  		if (xid > hba->max_xid) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  821  			BNX2FC_TGT_DBG(tgt, "xid(0x%x) out of FW range\n", xid);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  822  			goto ret_warn_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  823  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  824  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  825  		err_warn_bit_map = (u64)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  826  			((u64)err_entry->data.err_warn_bitmap_hi << 32) |
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  827  			(u64)err_entry->data.err_warn_bitmap_lo;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  828  		for (i = 0; i < BNX2FC_NUM_ERR_BITS; i++) {
d0c0d902339249 Colin Ian King          2019-05-04  829  			if (err_warn_bit_map & ((u64)1 << i)) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  830  				err_warn = i;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  831  				break;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  832  			}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  833  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  834  		BNX2FC_TGT_DBG(tgt, "warn = 0x%x\n", err_warn);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  835  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  836  		task_idx = xid / BNX2FC_TASKS_PER_PAGE;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  837  		index = xid % BNX2FC_TASKS_PER_PAGE;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  838  		io_req = (struct bnx2fc_cmd *)hba->cmd_mgr->cmds[xid];
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  839  		if (!io_req)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  840  			goto ret_warn_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  841  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  842  		if (io_req->cmd_type != BNX2FC_SCSI_CMD) {
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  843  			printk(KERN_ERR PFX "err_warn: Not a SCSI cmd\n");
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  844  			goto ret_warn_rqe;
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  845  		}
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  846  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  847  		memcpy(&io_req->err_entry, err_entry,
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  848  		       sizeof(struct fcoe_err_report_entry));
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  849  
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  850  		if (err_warn == FCOE_ERROR_CODE_REC_TOV_TIMER_EXPIRATION)
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  851  			/* REC_TOV is not a warning code */
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  852  			BUG_ON(1);
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  853  		else
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  854  			BNX2FC_TGT_DBG(tgt, "Unsolicited warning\n");
7b594769120b43 Bhanu Prakash Gollapudi 2011-07-27  855  ret_warn_rqe:
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  856  		bnx2fc_return_rqe(tgt, 1);
686959736a8543 Nithin Sujir            2011-03-17  857  		spin_unlock_bh(&tgt->tgt_lock);
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  858  		break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  859  
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  860  	default:
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  861  		printk(KERN_ERR PFX "Unsol Compl: Invalid CQE Subtype\n");
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  862  		break;
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  863  	}
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  864  }
853e2bd2103aaa Bhanu Gollapudi         2011-02-04  865  

:::::: The code at line 638 was first introduced by commit
:::::: 853e2bd2103aaa91d1ba1c0b57ba17628d836f03 [SCSI] bnx2fc: Broadcom FCoE offload driver

:::::: TO: Bhanu Gollapudi <bprakash@broadcom.com>
:::::: CC: James Bottomley <James.Bottomley@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WZ4lxQus1o6OJDDZgN/rjPF/pE3PfftbAgA=

--d6Gm4EdcadzBjdND--
