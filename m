Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C29C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58A720702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHUAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:10:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:7607 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHUAKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:10:51 -0400
IronPort-SDR: ToFZkqYjT03PnteBiMqKnyXf6OJ0ITKzPUjndZE0HK3RjsLvoTzyt8iQPmx2Wv4kxfkJMKh801
 zbReP+0KKqgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="154698658"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="gz'50?scan'50,208,50";a="154698658"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 17:04:13 -0700
IronPort-SDR: q4fyVABcTttc4s/+4zlxkzJCUYzh784scqpjabp7bKEhAqk7BKtXC21XWGWD7LIAqKGWT1X+Cw
 LibkTjc86unw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="gz'50?scan'50,208,50";a="293658864"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2020 17:04:10 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8uXR-0000LJ-Mz; Fri, 21 Aug 2020 00:04:09 +0000
Date:   Fri, 21 Aug 2020 08:03:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: drivers/scsi/qedi/qedi_fw.c:1064:45: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202008210824.4KoXeJKc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   da2968ff879b9e74688cdc658f646971991d2c56
commit: 06e85c7e9a1c1356038936566fc23f7c0d363b96 asm-generic: fix unistd_32.h generation format
date:   5 months ago
config: parisc-randconfig-s032-20200820 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 06e85c7e9a1c1356038936566fc23f7c0d363b96
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/qedi/qedi_fw.c:284:35: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:287:37: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:324:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] idx @@     got restricted __le16 [usertype] rqe_opaque @@
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse:     expected unsigned short [usertype] idx
   drivers/scsi/qedi/qedi_fw.c:360:13: sparse:     got restricted __le16 [usertype] rqe_opaque
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] opaque @@     got restricted __le32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse:     expected restricted __le16 [usertype] opaque
   drivers/scsi/qedi/qedi_fw.c:378:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:421:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:428:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:429:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:430:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:431:20: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:447:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:492:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:508:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:508:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:509:18: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse:     expected unsigned int
   drivers/scsi/qedi/qedi_fw.c:509:16: sparse:     got restricted __be32 [usertype]
   drivers/scsi/qedi/qedi_fw.c:511:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:512:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:513:28: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:518:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:519:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:520:28: sparse: sparse: cast from restricted __le16
   drivers/scsi/qedi/qedi_fw.c:543:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:558:9: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:560:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:561:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:562:23: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:585:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:625:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:626:26: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:627:20: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:631:31: sparse: sparse: cast from restricted __le32
   drivers/scsi/qedi/qedi_fw.c:634:38: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] proto_itt @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse:     expected unsigned int [usertype] proto_itt
   drivers/scsi/qedi/qedi_fw.c:739:28: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:751:19: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:809:25: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:828:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int idx @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse:     expected int idx
   drivers/scsi/qedi/qedi_fw.c:849:57: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __le16 [usertype] itid @@
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse:     expected unsigned int [usertype] tid
   drivers/scsi/qedi/qedi_fw.c:852:45: sparse:     got restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] iscsi_cid @@     got restricted __le16 [usertype] conn_id @@
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse:     expected unsigned int [usertype] iscsi_cid
   drivers/scsi/qedi/qedi_fw.c:890:20: sparse:     got restricted __le16 [usertype] conn_id
   drivers/scsi/qedi/qedi_fw.c:921:50: sparse: sparse: cast from restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:921:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:926:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] itid @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse:     expected restricted __le16 [usertype] itid
   drivers/scsi/qedi/qedi_fw.c:925:49: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] sq_prod @@     got unsigned short [usertype] fw_sq_prod_idx @@
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse:     expected restricted __le16 [assigned] [usertype] sq_prod
   drivers/scsi/qedi/qedi_fw.c:975:23: sparse:     got unsigned short [usertype] fw_sq_prod_idx
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc @@     got unsigned int @@
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] isid_tabc
   drivers/scsi/qedi/qedi_fw.c:1048:40: sparse:     got unsigned int
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] isid_d @@     got unsigned short @@
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] isid_d
   drivers/scsi/qedi/qedi_fw.c:1049:37: sparse:     got unsigned short
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] tsih @@     got restricted __be16 [usertype] tsih @@
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1051:35: sparse:     got restricted __be16 [usertype] tsih
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword @@     got int @@
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] hdr_second_dword
   drivers/scsi/qedi/qedi_fw.c:1052:47: sparse:     got int
   drivers/scsi/qedi/qedi_fw.c:1055:36: sparse: sparse: cast to restricted itt_t
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] itt @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] itt
   drivers/scsi/qedi/qedi_fw.c:1055:34: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] cid @@     got unsigned int [usertype] iscsi_conn_id @@
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] cid
   drivers/scsi/qedi/qedi_fw.c:1056:34: sparse:     got unsigned int [usertype] iscsi_conn_id
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] cmd_sn
   drivers/scsi/qedi/qedi_fw.c:1057:37: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn @@     got unsigned int [usertype] @@
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] exp_stat_sn
   drivers/scsi/qedi/qedi_fw.c:1058:42: sparse:     got unsigned int [usertype]
>> drivers/scsi/qedi/qedi_fw.c:1064:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] lo @@     got unsigned int [usertype] @@
>> drivers/scsi/qedi/qedi_fw.c:1064:45: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] lo
   drivers/scsi/qedi/qedi_fw.c:1064:45: sparse:     got unsigned int [usertype]
   drivers/scsi/qedi/qedi_fw.c:1066:45: sparse: sparse: too many warnings

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=06e85c7e9a1c1356038936566fc23f7c0d363b96
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 06e85c7e9a1c1356038936566fc23f7c0d363b96
vim +1064 drivers/scsi/qedi/qedi_fw.c

be086e7c53f1fac Mintz, Yuval     2017-03-11  1005  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1006  int qedi_send_iscsi_login(struct qedi_conn *qedi_conn,
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1007  			  struct iscsi_task *task)
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1008  {
be086e7c53f1fac Mintz, Yuval     2017-03-11  1009  	struct iscsi_login_req_hdr login_req_pdu_header;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1010  	struct scsi_sgl_task_params tx_sgl_task_params;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1011  	struct scsi_sgl_task_params rx_sgl_task_params;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1012  	struct iscsi_task_params task_params;
21dd79e82f00b29 Tomer Tayar      2017-12-27  1013  	struct e4_iscsi_task_context *fw_task_ctx;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1014  	struct qedi_ctx *qedi = qedi_conn->qedi;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1015  	struct iscsi_login_req *login_hdr;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1016  	struct scsi_sge *resp_sge = NULL;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1017  	struct qedi_cmd *qedi_cmd;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1018  	struct qedi_endpoint *ep;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1019  	s16 tid = 0;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1020  	u16 sq_idx = 0;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1021  	int rval = 0;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1022  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1023  	resp_sge = (struct scsi_sge *)qedi_conn->gen_pdu.resp_bd_tbl;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1024  	qedi_cmd = (struct qedi_cmd *)task->dd_data;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1025  	ep = qedi_conn->ep;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1026  	login_hdr = (struct iscsi_login_req *)task->hdr;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1027  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1028  	tid = qedi_get_task_idx(qedi);
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1029  	if (tid == -1)
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1030  		return -ENOMEM;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1031  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1032  	fw_task_ctx =
21dd79e82f00b29 Tomer Tayar      2017-12-27  1033  	     (struct e4_iscsi_task_context *)qedi_get_task_mem(&qedi->tasks,
21dd79e82f00b29 Tomer Tayar      2017-12-27  1034  							       tid);
21dd79e82f00b29 Tomer Tayar      2017-12-27  1035  	memset(fw_task_ctx, 0, sizeof(struct e4_iscsi_task_context));
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1036  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1037  	qedi_cmd->task_id = tid;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1038  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1039  	memset(&task_params, 0, sizeof(task_params));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1040  	memset(&login_req_pdu_header, 0, sizeof(login_req_pdu_header));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1041  	memset(&tx_sgl_task_params, 0, sizeof(tx_sgl_task_params));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1042  	memset(&rx_sgl_task_params, 0, sizeof(rx_sgl_task_params));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1043  	/* Update header info */
be086e7c53f1fac Mintz, Yuval     2017-03-11  1044  	login_req_pdu_header.opcode = login_hdr->opcode;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1045  	login_req_pdu_header.version_min = login_hdr->min_version;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1046  	login_req_pdu_header.version_max = login_hdr->max_version;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1047  	login_req_pdu_header.flags_attr = login_hdr->flags;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1048  	login_req_pdu_header.isid_tabc = swab32p((u32 *)login_hdr->isid);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1049  	login_req_pdu_header.isid_d = swab16p((u16 *)&login_hdr->isid[4]);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1050  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1051  	login_req_pdu_header.tsih = login_hdr->tsih;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1052  	login_req_pdu_header.hdr_second_dword = ntoh24(login_hdr->dlength);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1053  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1054  	qedi_update_itt_map(qedi, tid, task->itt, qedi_cmd);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1055  	login_req_pdu_header.itt = qedi_set_itt(tid, get_itt(task->itt));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1056  	login_req_pdu_header.cid = qedi_conn->iscsi_conn_id;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1057  	login_req_pdu_header.cmd_sn = be32_to_cpu(login_hdr->cmdsn);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1058  	login_req_pdu_header.exp_stat_sn = be32_to_cpu(login_hdr->exp_statsn);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1059  	login_req_pdu_header.exp_stat_sn = 0;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1060  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1061  	/* Fill tx AHS and rx buffer */
be086e7c53f1fac Mintz, Yuval     2017-03-11  1062  	tx_sgl_task_params.sgl =
be086e7c53f1fac Mintz, Yuval     2017-03-11  1063  			       (struct scsi_sge *)qedi_conn->gen_pdu.req_bd_tbl;
be086e7c53f1fac Mintz, Yuval     2017-03-11 @1064  	tx_sgl_task_params.sgl_phys_addr.lo =
be086e7c53f1fac Mintz, Yuval     2017-03-11  1065  					 (u32)(qedi_conn->gen_pdu.req_dma_addr);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1066  	tx_sgl_task_params.sgl_phys_addr.hi =
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1067  			      (u32)((u64)qedi_conn->gen_pdu.req_dma_addr >> 32);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1068  	tx_sgl_task_params.total_buffer_size = ntoh24(login_hdr->dlength);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1069  	tx_sgl_task_params.num_sges = 1;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1070  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1071  	rx_sgl_task_params.sgl =
be086e7c53f1fac Mintz, Yuval     2017-03-11  1072  			      (struct scsi_sge *)qedi_conn->gen_pdu.resp_bd_tbl;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1073  	rx_sgl_task_params.sgl_phys_addr.lo =
be086e7c53f1fac Mintz, Yuval     2017-03-11  1074  					(u32)(qedi_conn->gen_pdu.resp_dma_addr);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1075  	rx_sgl_task_params.sgl_phys_addr.hi =
be086e7c53f1fac Mintz, Yuval     2017-03-11  1076  			     (u32)((u64)qedi_conn->gen_pdu.resp_dma_addr >> 32);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1077  	rx_sgl_task_params.total_buffer_size = resp_sge->sge_len;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1078  	rx_sgl_task_params.num_sges = 1;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1079  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1080  	/* Fill fw input params */
be086e7c53f1fac Mintz, Yuval     2017-03-11  1081  	task_params.context = fw_task_ctx;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1082  	task_params.conn_icid = (u16)qedi_conn->iscsi_conn_id;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1083  	task_params.itid = tid;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1084  	task_params.cq_rss_number = 0;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1085  	task_params.tx_io_size = ntoh24(login_hdr->dlength);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1086  	task_params.rx_io_size = resp_sge->sge_len;
be086e7c53f1fac Mintz, Yuval     2017-03-11  1087  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1088  	sq_idx = qedi_get_wqe_idx(qedi_conn);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1089  	task_params.sqe = &ep->sq[sq_idx];
be086e7c53f1fac Mintz, Yuval     2017-03-11  1090  
be086e7c53f1fac Mintz, Yuval     2017-03-11  1091  	memset(task_params.sqe, 0, sizeof(struct iscsi_wqe));
be086e7c53f1fac Mintz, Yuval     2017-03-11  1092  	rval = init_initiator_login_request_task(&task_params,
be086e7c53f1fac Mintz, Yuval     2017-03-11  1093  						 &login_req_pdu_header,
be086e7c53f1fac Mintz, Yuval     2017-03-11  1094  						 &tx_sgl_task_params,
be086e7c53f1fac Mintz, Yuval     2017-03-11  1095  						 &rx_sgl_task_params);
be086e7c53f1fac Mintz, Yuval     2017-03-11  1096  	if (rval)
be086e7c53f1fac Mintz, Yuval     2017-03-11  1097  		return -1;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1098  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1099  	spin_lock(&qedi_conn->list_lock);
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1100  	list_add_tail(&qedi_cmd->io_cmd, &qedi_conn->active_cmd_list);
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1101  	qedi_cmd->io_cmd_in_list = true;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1102  	qedi_conn->active_cmd_count++;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1103  	spin_unlock(&qedi_conn->list_lock);
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1104  
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1105  	qedi_ring_doorbell(qedi_conn);
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1106  	return 0;
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1107  }
ace7f46ba5fde72 Manish Rangankar 2016-12-01  1108  

:::::: The code at line 1064 was first introduced by commit
:::::: be086e7c53f1fac51eed14523b28f2214b548dd2 qed*: Utilize Firmware 8.15.3.0

:::::: TO: Mintz, Yuval <Yuval.Mintz@cavium.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1q/sJpfI24GXgaKdTP8D44Aq8JwFAgA=

--J/dobhs11T7y2rNN--
