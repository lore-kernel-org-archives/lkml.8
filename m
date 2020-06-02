Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7781720678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBCWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:22:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:19037 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgFBCWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:22:35 -0400
IronPort-SDR: 511ROlkP0TyO0Kn2SuJj9eKjmJ6xc8eHjRYNb4OBvVWSk+ecfr2O08fZUTLzTdEFis99RqPQhe
 QMcc4NZHqsEw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 19:17:05 -0700
IronPort-SDR: FVmNYEvie3JMtiT25/276pFXtGh6lwhhFnbNoITiF1j3CjAratG8XVV3hMxlGVu7+vKCfa4V/5
 ZiGSTCAGIUMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="gz'50?scan'50,208,50";a="293401203"
Received: from lkp-server02.sh.intel.com (HELO c8e1d689ed63) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2020 19:17:03 -0700
Received: from kbuild by c8e1d689ed63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfwUA-00007u-9e; Tue, 02 Jun 2020 02:17:02 +0000
Date:   Tue, 2 Jun 2020 10:16:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Colin, Ian, King," <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/gadget.c:1157:35: sparse:     expected restricted
 __le32 [usertype] control
Message-ID: <202006021010.OdKnWkTn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f359287765c04711ff54fbd11645271d8e5ff763
commit: 70d8b9e5e63d212019ba3f6823c8ec3d2df87645 usb: cdns3: make signed 1 bit bitfields unsigned
date:   10 weeks ago
config: i386-randconfig-s032-20200602 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-243-gc100a7ab-dirty
        git checkout 70d8b9e5e63d212019ba3f6823c8ec3d2df87645
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=i386 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/cdns3/gadget.c:1157:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
>> drivers/usb/cdns3/gadget.c:1157:35: sparse:     expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1157:35: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1173:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
>> drivers/usb/cdns3/gadget.c:1173:29: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1173:29: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1188:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
>> drivers/usb/cdns3/gadget.c:1188:29: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/gadget.c:1188:29: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1191:37: sparse: sparse: invalid assignment: |=
>> drivers/usb/cdns3/gadget.c:1191:37: sparse:    left side has type restricted __le32
>> drivers/usb/cdns3/gadget.c:1191:37: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1213:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int [assigned] [usertype] control @@
   drivers/usb/cdns3/gadget.c:1213:38: sparse:     expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1213:38: sparse:     got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int [assigned] [usertype] control @@
   drivers/usb/cdns3/gadget.c:1215:48: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse:     got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1229:30: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1255:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1255:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int @@
   drivers/usb/cdns3/gadget.c:1255:30: sparse:     expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1255:30: sparse:     got unsigned int
   drivers/usb/cdns3/gadget.c:1010:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:1010:29: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1010:29: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1013:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:1013:29: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1013:29: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1019:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:1019:21: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/gadget.c:1019:21: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1029:37: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1029:37: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1029:37: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1033:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int [assigned] [usertype] control @@
   drivers/usb/cdns3/gadget.c:1033:22: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1033:22: sparse:     got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:85:6: sparse: sparse: symbol 'cdns3_clear_register_bit' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:140:26: sparse: sparse: symbol 'cdns3_next_align_buf' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:151:22: sparse: sparse: symbol 'cdns3_next_priv_request' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:193:5: sparse: sparse: symbol 'cdns3_ring_size' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:263:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:263:34: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:263:34: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:264:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:264:35: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:264:35: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:348:6: sparse: sparse: symbol 'cdns3_move_deq_to_next_trb' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:514:20: sparse: sparse: symbol 'cdns3_wa2_gadget_giveback' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:554:5: sparse: sparse: symbol 'cdns3_wa2_gadget_ep_queue' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:849:49: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:848:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int @@
   drivers/usb/cdns3/gadget.c:848:51: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:848:51: sparse:     got unsigned int
   drivers/usb/cdns3/gadget.c:852:49: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:851:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int @@
   drivers/usb/cdns3/gadget.c:851:51: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:851:51: sparse:     got unsigned int
   drivers/usb/cdns3/gadget.c:839:6: sparse: sparse: symbol 'cdns3_wa1_restore_cycle_bit' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:1393:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1442:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1574:35: sparse: sparse: dubious: x | !y
   drivers/usb/cdns3/gadget.c:1907:6: sparse: sparse: symbol 'cdns3_stream_ep_reconfig' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:1928:6: sparse: sparse: symbol 'cdns3_configure_dmult' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:2552:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:2552:34: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:2552:34: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:2554:46: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2554:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:2554:35: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2554:35: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:2610:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2610:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:2610:38: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2610:38: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:2625:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2625:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:2625:38: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2625:38: sparse:     got unsigned long
--
   drivers/usb/cdns3/ep0.c:40:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
>> drivers/usb/cdns3/ep0.c:40:37: sparse:     expected restricted __le32 [usertype] buffer
>> drivers/usb/cdns3/ep0.c:40:37: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:41:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
>> drivers/usb/cdns3/ep0.c:41:37: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/ep0.c:41:37: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:44:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
>> drivers/usb/cdns3/ep0.c:44:46: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:44:46: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:45:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:45:45: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/ep0.c:45:45: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:46:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:46:45: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/ep0.c:46:45: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:47:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:47:46: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:47:46: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:50:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:50:46: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:50:46: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:267:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] ep_addr @@     got restricted __le16 [usertype] wIndex @@
>> drivers/usb/cdns3/ep0.c:267:52: sparse:     expected unsigned char [usertype] ep_addr
>> drivers/usb/cdns3/ep0.c:267:52: sparse:     got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:271:47: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] ep @@     got restricted __le16 [usertype] wIndex @@
>> drivers/usb/cdns3/ep0.c:271:47: sparse:     expected unsigned int [usertype] ep
   drivers/usb/cdns3/ep0.c:271:47: sparse:     got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:387:19: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/cdns3/ep0.c:390:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] ep_addr @@     got restricted __le16 [usertype] wIndex @@
   drivers/usb/cdns3/ep0.c:390:44: sparse:     expected unsigned char [usertype] ep_addr
   drivers/usb/cdns3/ep0.c:390:44: sparse:     got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:393:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] ep @@     got restricted __le16 [usertype] wIndex @@
   drivers/usb/cdns3/ep0.c:393:39: sparse:     expected unsigned int [usertype] ep
   drivers/usb/cdns3/ep0.c:393:39: sparse:     got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:454:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/cdns3/ep0.c:478:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] isoch_delay @@     got restricted __le16 [usertype] wValue @@
>> drivers/usb/cdns3/ep0.c:478:31: sparse:     expected unsigned short [usertype] isoch_delay
>> drivers/usb/cdns3/ep0.c:478:31: sparse:     got restricted __le16 [usertype] wValue
--
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer @@     got restricted __le32 [usertype] buffer @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] buffer
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le32 [usertype] length @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] length
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] control @@     got restricted __le32 [usertype] control @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] control
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] control
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer @@     got restricted __le32 [usertype] buffer @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] buffer
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le32 [usertype] length @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] length
   drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] control @@     got restricted __le32 [usertype] control @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     expected unsigned int [usertype] control
>> drivers/usb/cdns3/./trace.h:392:1: sparse:     got restricted __le32 [usertype] control

vim +1157 drivers/usb/cdns3/gadget.c

54c4c69f0baa43 Jayshri Pawar  2019-12-13  1079  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1080  /**
7733f6c32e36ff Pawel Laszczak 2019-08-26  1081   * cdns3_ep_run_transfer - start transfer on no-default endpoint hardware
7733f6c32e36ff Pawel Laszczak 2019-08-26  1082   * @priv_ep: endpoint object
7733f6c32e36ff Pawel Laszczak 2019-08-26  1083   *
7733f6c32e36ff Pawel Laszczak 2019-08-26  1084   * Returns zero on success or negative value on failure
7733f6c32e36ff Pawel Laszczak 2019-08-26  1085   */
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1086  static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
7733f6c32e36ff Pawel Laszczak 2019-08-26  1087  				 struct usb_request *request)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1088  {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1089  	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1090  	struct cdns3_request *priv_req;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1091  	struct cdns3_trb *trb;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1092  	dma_addr_t trb_dma;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1093  	u32 togle_pcs = 1;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1094  	int sg_iter = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1095  	int num_trb;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1096  	int address;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1097  	u32 control;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1098  	int pcs;
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1099  	u16 total_tdl = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1100  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1101  	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1102  		num_trb = priv_ep->interval;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1103  	else
7733f6c32e36ff Pawel Laszczak 2019-08-26  1104  		num_trb = request->num_sgs ? request->num_sgs : 1;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1105  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1106  	if (num_trb > priv_ep->free_trbs) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1107  		priv_ep->flags |= EP_RING_FULL;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1108  		return -ENOBUFS;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1109  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1110  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1111  	priv_req = to_cdns3_request(request);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1112  	address = priv_ep->endpoint.desc->bEndpointAddress;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1113  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1114  	priv_ep->flags |= EP_PENDING_REQUEST;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1115  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1116  	/* must allocate buffer aligned to 8 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1117  	if (priv_req->flags & REQUEST_UNALIGNED)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1118  		trb_dma = priv_req->aligned_buf->dma;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1119  	else
7733f6c32e36ff Pawel Laszczak 2019-08-26  1120  		trb_dma = request->dma;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1121  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1122  	trb = priv_ep->trb_pool + priv_ep->enqueue;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1123  	priv_req->start_trb = priv_ep->enqueue;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1124  	priv_req->trb = trb;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1125  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1126  	cdns3_select_ep(priv_ep->cdns3_dev, address);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1127  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1128  	/* prepare ring */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1129  	if ((priv_ep->enqueue + num_trb)  >= (priv_ep->num_trbs - 1)) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1130  		struct cdns3_trb *link_trb;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1131  		int doorbell, dma_index;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1132  		u32 ch_bit = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1133  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1134  		doorbell = !!(readl(&priv_dev->regs->ep_cmd) & EP_CMD_DRDY);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1135  		dma_index = cdns3_get_dma_pos(priv_dev, priv_ep);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1136  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1137  		/* Driver can't update LINK TRB if it is current processed. */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1138  		if (doorbell && dma_index == priv_ep->num_trbs - 1) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1139  			priv_ep->flags |= EP_DEFERRED_DRDY;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1140  			return -ENOBUFS;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1141  		}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1142  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1143  		/*updating C bt in  Link TRB before starting DMA*/
7733f6c32e36ff Pawel Laszczak 2019-08-26  1144  		link_trb = priv_ep->trb_pool + (priv_ep->num_trbs - 1);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1145  		/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1146  		 * For TRs size equal 2 enabling TRB_CHAIN for epXin causes
7733f6c32e36ff Pawel Laszczak 2019-08-26  1147  		 * that DMA stuck at the LINK TRB.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1148  		 * On the other hand, removing TRB_CHAIN for longer TRs for
7733f6c32e36ff Pawel Laszczak 2019-08-26  1149  		 * epXout cause that DMA stuck after handling LINK TRB.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1150  		 * To eliminate this strange behavioral driver set TRB_CHAIN
7733f6c32e36ff Pawel Laszczak 2019-08-26  1151  		 * bit only for TR size > 2.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1152  		 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1153  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC ||
7733f6c32e36ff Pawel Laszczak 2019-08-26  1154  		    TRBS_PER_SEGMENT > 2)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1155  			ch_bit = TRB_CHAIN;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1156  
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1157  		link_trb->control = ((priv_ep->pcs) ? TRB_CYCLE : 0) |
7733f6c32e36ff Pawel Laszczak 2019-08-26  1158  				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1159  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1160  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1161  	if (priv_dev->dev_ver <= DEV_VER_V2)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1162  		togle_pcs = cdns3_wa1_update_guard(priv_ep, trb);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1163  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1164  	/* set incorrect Cycle Bit for first trb*/
7733f6c32e36ff Pawel Laszczak 2019-08-26  1165  	control = priv_ep->pcs ? 0 : TRB_CYCLE;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1166  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1167  	do {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1168  		u32 length;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1169  		u16 td_size = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1170  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1171  		/* fill TRB */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1172  		control |= TRB_TYPE(TRB_NORMAL);
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1173  		trb->buffer = TRB_BUFFER(request->num_sgs == 0
7733f6c32e36ff Pawel Laszczak 2019-08-26  1174  				? trb_dma : request->sg[sg_iter].dma_address);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1175  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1176  		if (likely(!request->num_sgs))
7733f6c32e36ff Pawel Laszczak 2019-08-26  1177  			length = request->length;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1178  		else
7733f6c32e36ff Pawel Laszczak 2019-08-26  1179  			length = request->sg[sg_iter].length;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1180  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1181  		if (likely(priv_dev->dev_ver >= DEV_VER_V2))
7733f6c32e36ff Pawel Laszczak 2019-08-26  1182  			td_size = DIV_ROUND_UP(length,
7733f6c32e36ff Pawel Laszczak 2019-08-26  1183  					       priv_ep->endpoint.maxpacket);
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1184  		else if (priv_ep->flags & EP_TDLCHK_EN)
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1185  			total_tdl += DIV_ROUND_UP(length,
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1186  					       priv_ep->endpoint.maxpacket);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1187  
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1188  		trb->length = TRB_BURST_LEN(priv_ep->trb_burst_size) |
7733f6c32e36ff Pawel Laszczak 2019-08-26  1189  					TRB_LEN(length);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1190  		if (priv_dev->gadget.speed == USB_SPEED_SUPER)
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1191  			trb->length |= TRB_TDL_SS_SIZE(td_size);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1192  		else
7733f6c32e36ff Pawel Laszczak 2019-08-26  1193  			control |= TRB_TDL_HS_SIZE(td_size);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1194  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1195  		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1196  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1197  		/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1198  		 * first trb should be prepared as last to avoid processing
7733f6c32e36ff Pawel Laszczak 2019-08-26  1199  		 *  transfer to early
7733f6c32e36ff Pawel Laszczak 2019-08-26  1200  		 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1201  		if (sg_iter != 0)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1202  			control |= pcs;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1203  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1204  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1205  			control |= TRB_IOC | TRB_ISP;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1206  		} else {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1207  			/* for last element in TD or in SG list */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1208  			if (sg_iter == (num_trb - 1) && sg_iter != 0)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1209  				control |= pcs | TRB_IOC | TRB_ISP;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1210  		}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1211  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1212  		if (sg_iter)
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1213  			trb->control = control;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1214  		else
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1215  			priv_req->trb->control = control;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1216  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1217  		control = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1218  		++sg_iter;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1219  		priv_req->end_trb = priv_ep->enqueue;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1220  		cdns3_ep_inc_enq(priv_ep);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1221  		trb = priv_ep->trb_pool + priv_ep->enqueue;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1222  	} while (sg_iter < num_trb);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1223  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1224  	trb = priv_req->trb;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1225  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1226  	priv_req->flags |= REQUEST_PENDING;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1227  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1228  	if (sg_iter == 1)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1229  		trb->control |= TRB_IOC | TRB_ISP;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1230  
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1231  	if (priv_dev->dev_ver < DEV_VER_V2 &&
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1232  	    (priv_ep->flags & EP_TDLCHK_EN)) {
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1233  		u16 tdl = total_tdl;
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1234  		u16 old_tdl = EP_CMD_TDL_GET(readl(&priv_dev->regs->ep_cmd));
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1235  
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1236  		if (tdl > EP_CMD_TDL_MAX) {
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1237  			tdl = EP_CMD_TDL_MAX;
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1238  			priv_ep->pending_tdl = total_tdl - EP_CMD_TDL_MAX;
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1239  		}
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1240  
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1241  		if (old_tdl < tdl) {
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1242  			tdl -= old_tdl;
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1243  			writel(EP_CMD_TDL_SET(tdl) | EP_CMD_STDL,
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1244  			       &priv_dev->regs->ep_cmd);
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1245  		}
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1246  	}
54c4c69f0baa43 Jayshri Pawar  2019-12-13  1247  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1248  	/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1249  	 * Memory barrier - cycle bit must be set before other filds in trb.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1250  	 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1251  	wmb();
7733f6c32e36ff Pawel Laszczak 2019-08-26  1252  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1253  	/* give the TD to the consumer*/
7733f6c32e36ff Pawel Laszczak 2019-08-26  1254  	if (togle_pcs)
7733f6c32e36ff Pawel Laszczak 2019-08-26 @1255  		trb->control =  trb->control ^ 1;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1256  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1257  	if (priv_dev->dev_ver <= DEV_VER_V2)
7733f6c32e36ff Pawel Laszczak 2019-08-26  1258  		cdns3_wa1_tray_restore_cycle_bit(priv_dev, priv_ep);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1259  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1260  	trace_cdns3_prepare_trb(priv_ep, priv_req->trb);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1261  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1262  	/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1263  	 * Memory barrier - Cycle Bit must be set before trb->length  and
7733f6c32e36ff Pawel Laszczak 2019-08-26  1264  	 * trb->buffer fields.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1265  	 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1266  	wmb();
7733f6c32e36ff Pawel Laszczak 2019-08-26  1267  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1268  	/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1269  	 * For DMULT mode we can set address to transfer ring only once after
7733f6c32e36ff Pawel Laszczak 2019-08-26  1270  	 * enabling endpoint.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1271  	 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1272  	if (priv_ep->flags & EP_UPDATE_EP_TRBADDR) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1273  		/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  1274  		 * Until SW is not ready to handle the OUT transfer the ISO OUT
7733f6c32e36ff Pawel Laszczak 2019-08-26  1275  		 * Endpoint should be disabled (EP_CFG.ENABLE = 0).
7733f6c32e36ff Pawel Laszczak 2019-08-26  1276  		 * EP_CFG_ENABLE must be set before updating ep_traddr.
7733f6c32e36ff Pawel Laszczak 2019-08-26  1277  		 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1278  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir &&
7733f6c32e36ff Pawel Laszczak 2019-08-26  1279  		    !(priv_ep->flags & EP_QUIRK_ISO_OUT_EN)) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1280  			priv_ep->flags |= EP_QUIRK_ISO_OUT_EN;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1281  			cdns3_set_register_bit(&priv_dev->regs->ep_cfg,
7733f6c32e36ff Pawel Laszczak 2019-08-26  1282  					       EP_CFG_ENABLE);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1283  		}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1284  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1285  		writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
7733f6c32e36ff Pawel Laszczak 2019-08-26  1286  					priv_req->start_trb * TRB_SIZE),
7733f6c32e36ff Pawel Laszczak 2019-08-26  1287  					&priv_dev->regs->ep_traddr);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1288  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1289  		priv_ep->flags &= ~EP_UPDATE_EP_TRBADDR;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1290  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1291  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1292  	if (!priv_ep->wa1_set && !(priv_ep->flags & EP_STALLED)) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  1293  		trace_cdns3_ring(priv_ep);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1294  		/*clearing TRBERR and EP_STS_DESCMIS before seting DRDY*/
7733f6c32e36ff Pawel Laszczak 2019-08-26  1295  		writel(EP_STS_TRBERR | EP_STS_DESCMIS, &priv_dev->regs->ep_sts);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1296  		writel(EP_CMD_DRDY, &priv_dev->regs->ep_cmd);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1297  		trace_cdns3_doorbell_epx(priv_ep->name,
7733f6c32e36ff Pawel Laszczak 2019-08-26  1298  					 readl(&priv_dev->regs->ep_traddr));
7733f6c32e36ff Pawel Laszczak 2019-08-26  1299  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  1300  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1301  	/* WORKAROUND for transition to L0 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  1302  	__cdns3_gadget_wakeup(priv_dev);
7733f6c32e36ff Pawel Laszczak 2019-08-26  1303  
7733f6c32e36ff Pawel Laszczak 2019-08-26  1304  	return 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1305  }
7733f6c32e36ff Pawel Laszczak 2019-08-26  1306  

:::::: The code at line 1157 was first introduced by commit
:::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence USB3 DRD Driver

:::::: TO: Pawel Laszczak <pawell@cadence.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEqy1V4AAy5jb25maWcAlFxdc9w2r77vr9hJb9qLtv5I3PSc8QVFUVp2RVEhpbXXNxrX
2aSeJnZef7xt/v0BSGlFUpDT0+lkvAT4DQIPQFDff/f9ij0/3X++frq9uf706evq4/5u/3D9
tH+/+nD7af+/q1yvat2uRC7bn4G5ur17/ueX29O3Z6s3P5/9fPTTw82vq83+4W7/acXv7z7c
fnyG2rf3d999/x38/z0Ufv4CDT38z+rjzc1Pv61+yPd/3F7frX77+RRqH5/+6P8CXq7rQpY9
5720fcn5+dexCH70W2Gs1PX5b0enR0cH3orV5YF0FDTBWd1Xst5MjUDhmtmeWdWXutUkQdZQ
R8xIF8zUvWK7TPRdLWvZSlbJK5EHjLq2rel4q42dSqV5119oEwwi62SVt1KJvmVZJXqrTTtR
27URLIdRFBr+ARaLVd0ylm5bPq0e90/PX6bFwsH0ot72zJQwXyXb89MTXPVxWKqR0E0rbLu6
fVzd3T9hC2PtjjWyX0OXwjiWaSSV5qwa1/XVK6q4Z124im5mvWVVG/Cv2Vb0G2FqUfXllWwm
9pCSAeWEJlVXitGUy6ulGnqJ8BoIh6UJRhWuTEp3Y3uJAUf4Ev3yilj4aKzzFl8TVXJRsK5q
+7W2bc2UOH/1w9393f7HV1N9u7Nb2XByNI228rJX7zrRCaJ1brS1vRJKm13P2pbx9bSKnRWV
zMKRsg7UAdGMW29m+NpzwIBAXqpRhuE4rB6f/3j8+vi0/zzJcClqYSR3p6UxOgvOX0iya31B
U0RRCN5K7Loo4JzazZyvEXUua3ck6UaULA1rUdxJMl+H0osluVZM1lRZv5bC4Crs5m0pK+kx
DIRZs9EYWWtgF2FJ4RyCqqG5jLDCbN1ceqVzEQ+x0IaLfFA1sCIT1TbMWLG8QrnIurKwTg72
d+9X9x+SHZ20suYbqzvoCFRny9e5Drpx4hGy5KxlL5BRxQWKNqBsQQtDZdFXzLY93/GKEB2n
bLeTJCZk157Yirq1LxL7zGiWcxYqSYpNwfaz/PeO5FPa9l2DQx6PRHv7ef/wSJ2KVvJNr2sB
Yh80tb4CSTZS55KH57HWSJF5JcjD78jUcZXlGsXFLZKJdnY2sECVGCFU00KrNd3dyLDVVVe3
zOyIrgeeaWZjJa6hzqzYn0sPKJrul/b68a/VEwxxdQ3DfXy6fnpcXd/c3D/fPd3efUwWESr0
jLt2vbwfBopS7eRjIpMTymyOmokL0JHA2pJMaK1ty1pLzdbKYEpw0kdtnkuLOCAPl/5fTPBw
GmBq0uqKhQtkeLeyhEDBSvZAmy95VAg/enEJQhZsgo04XENJEc593g4sR1UhCFGhWkVKLUAH
WVHyrJLhUUFawWrdORwzK+wrwYrz47Np1ZGWaW3pPXFdaZ7hQsUMw1rHa3XQkxv/R6A5N4c1
0zws9ugp0B2VRixUgLmSRXt+chSW43YpdhnQj0+mzZB1uwEAVYikjePTyLx2gDQ9duRrWESn
fMattzd/7t8/A9pefdhfPz0/7B+n/e8ALKtmBJVxYdaBAgPt5Q/fm2l9iAYjRX3B6rbPUMfD
ULpaMeigyvqi6mwAIHhpdNcEi9SwUvjORGDEAH7wMq3lpzmVFkyanqTwArQ0q/MLmbfr8Jib
NqxA4eBpaTxnWHsYRiNzS8rYQDf5Ag4c6AWcmithKOzlGdZdKWDtgvk0ALxCs4Syh+MYKMQg
c7GVnMR3ng4VUX9R0xOmeGn4WVMsN+uQQWSPAKACnACFSbe5FnzTaBB4tD4AZKghe/FGJ2O2
JWDNYa9zAQoMcBC5pUZULIBfWbXBxXFgwgQy434zBa15TBH4LiZPXBYoSDwVKIkdFCgI/RJH
18nvyAsB1YUmD/+mlpf3GmyfAl8TcZvbJG0Uq7mItjBhs/AHtaCAgdoAAnltIvPjs0DTOx4w
AFw4owvKnnGR1Gm4bTYwGjA7OJxglZti+pEakaQnBeZPghgH59/CAUD03s/Qmt/wWXGxhuMe
gj7v5RzQTKRa0999rQKj7AV4ZJhNcNowBhC56KqKWOCia8VlMDr8Cec1WJJGR7OSZc2qIhBH
N/KwwKHKsMCuQUtGrpjU5BmTuu9MAmjGKvlWwiyG5bRha9B4xoyRpKLaIPdOBSs7lvTRthxK
3WLhSUTnLBKT+V6iKDhMFM7W2RiMwEzjgpo1QGnQGZGKt+IdMWKoJfI8NBJegKGr/gD6J9zK
j48i19vZ1CG41ewfPtw/fL6+u9mvxH/3dwDIGNhIjpAMkPJkZxcadzrSE2Gq/VY5L44EJf+y
x7HDrfLdjQY16hYjQAxMtNmQUmIrli0QuozSIZWOAgFYHzbHgDkfIC1Vad0VBQAWZ/UJ5xVk
oRXK+YEYy5OF5COgDXwKXciKlmeno5w5iVyYOGQ2Ml++PetPAx0Ov0Nz4KN4qPlywcF5DoYJ
+LMBCOo0cHv+av/pw+nJTxgJfRWJK6zDgB5fXT/c/PnLP2/PfrlxkdFHFzft3+8/+N9hWG0D
1qy3XdNEAUFAenzjpjenKdUlB0Uh/DI1mCnpPdHzty/R2SUiaZJhlJpvtBOxRc0d4gaW9Xlo
IUdCpG99q2w3mpe+yPm8CugLmRn09/PYuB+0BOJrVDeXFI0BnsCQsHD2keAA+YLT0zclyFqb
aAyAWx4keW/SiGBKzpcZSU7jQFMGIxLrLgxAR3zuLJBsfjwyE6b2MRwwalZmVTpk21kMai2R
HTJ3S8eqObYcWnAiZUfdBENypzM6HHBYequapaqdi9gFJqEAAyyYqXYcw08iQAdN6f2WCrQV
WJ2D5zME2S3DrUGBx/UX3KsIp4Kbh/ub/ePj/cPq6esX7xLP/ZsrDfUjWYuGjVMpBGs7Izw8
jUmqcdGvUOWUusoLade0ZylaMOZyIQKCLXphBDhlqkWeTJYwyEWyuGxhh1FqBiSyyAm6DyPH
jaUBN7IwNbWz7ChIbYteZTIKkwxlXk6ISoOYSCMj2+MRvFYSlCaAbDjZqKNJaLHewcEAVALo
teyimwjYFraVJvJZxrL5gOYstpG1ixlSgAZMZ9KdDz82HcbSQCyrNoZszTbyLLEBf3gKeuEP
w3ghzJSyjh79BMpevz2zl2T7SKIJb14gtJa+JECaUgs9nS01CFoIkLyS8hvkl+m0bI/U1zR1
szCkza8L5W/pcm46q+mjrEQBeETomqZeyBqvBvjCQAbyab7QdsVqQhRUKQB6lJfHkRS4wr5a
2B6+M/JycZG3kvHTnr7IcsSFBUOcvVALMNyyPhps9oKucFqgxtl4q+zjXK9Dlup4mQY4oKwV
It7QoUQKCHZcwFVzydfl2etE24PfrzrldHTBlKx2529CujvT4AgrG+A/yUDHoQnpIzca+bfq
cmZcQuiKkWN0zEUlOIWQcRxgUr0ajyJArtjtbYRaRwoo9XnheleG8dZDK7BirDNzAgDM2ioB
6JvqolOcLL9aM30Z3lStG+H1XNBFHvrYtYM+tofuAPxkooTaJzQRzN4EOkfS4GHMCFOBtzhW
hRDaFSk+N0wwr8bE3nMogHjV3bNGJhIFfvW80AgD3oGPvmRGb0TtIzvSvItEwclebHc9wAlc
vc/3d7dP9w/RPUbgUw6mvqsHF3iRw7CmisRwxsHxumLhCidgdsBBX8R2++BlLQw9nnMlSsZ3
cEwWbIhf2KbCf0QMc0YfT4MiyFgES95uFvbOCFx9QKJR0FlJDicxuhA9FB1O3qTfDiSYP60B
DxwAFL1OKxgJqty2h6pkwIcyj4KmGu/jADIv3NQB5XXgNG2VbSqAVqdR5HUqxZggOe6R5YRG
ThP5my0c0zgGzq8uCoxQH/3Dj/x/yUTSpWCI/FtpW8mDHXNgrADMCjVAJTDCCXKofZnsFO6Y
14CX4YF2lRWKZTWiUrxO7sT50TRNHGuzcEDcsDGMDRhe48WJMZ2LmC6KJF7K49XOxfnZwZqp
1phI6OA3OkKylVfpeQsaA6ebCuvhjEF95jpZXgv+elwCcCwp8RqhtZdulXD/Ur2VctCAiODE
ED7JKwpJTMMKjnGFsPv1VX98dES2AaSTN4uk07hW1NxRYLmuzo8DGfXmYW3w9jiIaopLEVkR
bphd93kXO3DjKVjvrEQLAnJt8CAcD+cg8CBdIAyl9qX6DuxA/ZP4GOm2qTpnjIO4Kig99CJU
SA6m6T2VhJZGCre5pXeLq9xFT6AX2qGFzZbFrq/ydozu0gbjBWc+EmV/osfDOwz7EBK4/3v/
sAKzc/1x/3l/9+TaYbyRq/svmH4YBAaGQEkACYbIyXAlNyfYjWxcnDmwr6q3lRDNvGQIM0ym
UzmJdzRqY1V/wTbCuaRRY4fSIY/vOBSWiF5SuLpRySCWnHUg8SqQ64t33rr3ztGRCKtHoBU0
iHi+HFToku45BIVwHwJNPPs14gEn/DBfrTddGmFSoHzbIaEMqzRhSNCVDGFjP3gHZWwQJZ0u
SJDXLUZJhh58Ww03fjhpJ8Omx80hpC/sHBWFPEZse70VxshchEG6uCXBx7yqpXZYOu+MtWCu
dmlp17ZxyNwVb6F3CuI6YsHmFVpGox2/jCB/S405X8oIkCZrk7FNHpCHnItkmc824ECcjVQ2
irIfjhbrx/nm+e5YWRqQxFYvbmK7BjjKqmRMvLPg/Pa5BVVXyCq8NT5Ek4fFRA3WNaVheTqx
lEYI7PJGNBxFU5MwwI1Qg68H2toknY7rIvXgxMTN2owOY/m64gXJGJYEvMi1foHNiLzD9MM1
M/kFMwgjKio9bDr3rBGB9ojLhyvcuAskkAPIm7agHJmDXpR4jw4CIRewzbiy8Dd5XB00UwcX
eHI3SZzjIhnAjlY72KVGRT96sP7g6Lnr0bklQ4ZcT9h3GmrjgxtpSmBYTwKIZ7s+q1i9Sevi
PcAFArlonmP+3ap42P/neX9383X1eHP9KXJVRzUQBwycYij1FnOLMQ7SLpAPuWIT7BjJqDlo
YDJyjEl12FCQKvH/qITCYUHE/n0V3BeX6fLvq+g6FzAw+pSQNYA2pPRuyeQeqo4DsV0rq4WV
jnNJSI5xNcjtWJw8xThOeXHXp/ktsITTOYjhh1QMV+8fbv8b3cYDm1+aWOKGMnchkost7es0
y/ERd9TxmYlvavnSZbCMKVPYDC5zDadtkwQzJ8Kvi4QEXLnQ66XTE4DU0lmB8hA5YCYfCjSy
Xop9TYwyfAcQk2yse93AXvvLC6WplKwh6OGWvnZp6CdpA5WuS9Mte5ZIX4OIL9+YTVJrZprr
8c/rh/37uYMQzyt56hAT3e0yZl2yxrv/pItDq8iD2Mr3n/axwoxxz1jiBL9ieR6bk4isRN0t
KpIDVysWfLqQabztIs2xJ403Y+dxurKfURCZc8dnno4+eoDf9N3cUmXPj2PB6gcAPKv9083P
P/pVHEw2oKBSYwCG8nMcUSn/M3KOHCWXRiykcnsGVpOJ60DzVQPvDcqWOuJ1dnIEK/yukws5
OJgjkXXUFIbsCQw4B2ErG15xcwwMpL/XZg5CdNVQbiOrZJAtUYv2zZuj46mgFDoE8yrv6/np
2NkiIzd6YQf97t7eXT98XYnPz5+uk/M4RCJOT0Ixm/PHmBDQJ+abaB/rcl0Utw+f/4Yjv8pT
qyDySDnCT4x4kbtTSKMcUlUC816IJcyVjAO5UOAzFmlm2CSGzwn5GsMpta4xEAa+WFVlLAw4
FRc9L4bcR7p0jMmEnZdal5U4DJsYAvY2ZmiMS9XuPz5crz6MC+bNqKOM70FohpE8W+poczbb
ANTiHXeH7ydnOV7ARm4B3rKDUjeaBu5bfBKHovsC1b9vwzdg+C7URR9m5mHMF8Osrdun/Q2G
pH56v/8CU0QlNTMbPv4XX8O4IGFSNvpc0bWUWxfts9oC3rEEPZv5Gd74ZBtiT3/vFFguloXx
bRdR5zCkncVAeBG/8HQDmEI+Xe0CjZhxzdE7TqIxmLKILzxbWfeZvWDpS04JM8asMCJ1apNm
CPlSTKChCLqhy4dmAEr2BZWUXHS1z9tzggIm6HfB4+d8ji1K+p2eK7oW11pvEiJqX/SlZdnp
jnghZmHZnQH17+mSVXNZZdq0GBYd8svnDOAMDTHOBaK3Nr2aLbofuX8z7PMW+4u1BNMrZxkt
mA1m+3xXM9SS7qGDr5HwnZ5kskVd2KfbiM+jAdcNj3/T3QGv2fYMQ6eYwDXIUGy3PJ8NPcN4
4/AJ82LFKGTpStYXfQZT9+8IEpqSCNImsnUDTJicSw1i2JkatDBskgzDJWmiMCE5GMRAuOte
QPiMNVeDaoTof8wFNsOi4U0CtcPU2aaoRKa1Ul1fMgxiDeEmDHmTZHwpRbEMkuhPjn+dNORU
pBvkS/29+QIt191CoqJseO+fn46PzompDjdDQ6JmoOgWyoOauMAVSENCnKUbjqp9SEmMyO7B
Y6ReybpJJThmuk4Xy09ctoAAhs13CXKphBDvE1NB1yhIKk1wH3VajfejqN4xARQvZqm1Rxq2
0VsQ6FStwpEfb1oFx8zsQHp03mH4Hm0DmBcUP0KDOYq7lIyybqdhRlnJqX26BG1Eqta41ttY
3HSzG/ViW4XfY/BIO1Yv4LHirRZsAuClPODGW30ryyHodjojMJ4CmANwRSWKG7d0U+KFCwxI
Oz76NxeXoQgtktLqfhPI6hRpWvYGtuv0ZLyFjFX6weSDXaLsOiq98M1BWnV4sQF4i5ude+Tr
ARbX25/+uH4EH/wv/8Thy8P9h9s4fohMw8yJVh11xEj+/ciEfBMasfiOxSfw96/7X0P/4qXB
Hfw8gHH4vB8QJefpZy7wIyWegXyF8A1UOTZlYN/w3VCoC9wzGosPRs6Pk8MXzn/YbxdZgS1a
uMcZuLr6JY7Ryr/UgjX88CWQ9Ko34ZT0TcZAxlNjxELm8sDj49FKWosfcTg8L+ylcjeOxFZ3
NQgwnNOdynSoA0at5V4xH24eD/1l1cIVl60Dtxi/AuOfEjQgD109ZOyG0jpdhnrPFNyxYBDu
aZirDMunL6KLGnNh4ewsEN3RW6Adjq37ykc+pT5PLMuUtLK5oKvOyieNND7M6jNRjHcW8Qco
pht3pxDEP/ub56frPz7t3ceGVi6R7ClwsTJZF6pFGzK1AT9i/2pgstzI8IMCQzHITJy1ofEO
Kk26Hw7r0oDcaNX+8/3D15Wa4lbzVIOX8o3GRCbF6o5FmmvKYvI0Qv6GynFrvcuh9fUC6Dg1
513A1KQL5aR8qD1zKwr8mkbZRQ1itlfTulou43LKYPJTzfCAxsZwKPJGkS+kRk3E4HDMv8Ti
U+g1Gu/IH7ZUrtx4C+Iggv8eR27OXx/9dnid9DIyoqiggC7YLuqcZFP+bSWVwJiwuzw5l+Ic
QhHB6rEsSLxhRHtXjdaBcF1lXQCRrk4LACnBb6vGlz1TcHJ4jgOr1NAvEsZaTozmvq+LIY2e
fwCy8vGpHzrVmwiz+mcg2xExh+mmLq04/XzGZNvxCTrAibViC1FUh/bwNhmQX+MScemUilFb
Na3wmHY4ioMGWD7kYwu1OACaev/09/3DX3jxNKmCaVIMP6pAmqYw5oq/QHlF6TuuLJeMtpuA
aekLkMIop3RJKowbY0F0zbzprXbfgKDC0HX8sQHZ+Nfb+DUcOqLd4BtjvFoEe4GJ0VR+BTA1
dSg37nefr3mTdIbFLrdtqTNkMMzQdJy3bBa+8uWJpcE3haq7JIbpOfq2q+s4QRjMHagvvZEL
HznwFbctnYyA1ELTVzcDbeqW7gC3pWf08zRHA4y0TASPW5OZi456mG5YiAKZFLW8GYvj5ru8
WRZgx2HYxTc4kAr7gh40LbbYO/xZHqSN0rsjD++y0BSOVmKkn7+6ef7j9uZV3LrK31jy0wyw
s2exmG7PBllH14q+S3BM/lMNmOnc/x9nV/PlOIrk/5U87Zs51GvLX2kf5oARsqnUVwlsy3XR
y67Kns63OVn1MrNnev/7JQBJgAK7dw/VnY4IEEIQBEHEjzRigcPbr6992vXVb7tGPq7fhoLX
eCC+5gZj1mUJLidvrWjdusH6XrPLVFlg2taQl5pNSpuRdqWpoGnq3AImRmaCFtS9H+cLtl93
+fnW87SYWmYiGXK1GhWxSQtQj+CMiq5RvUx9uGj3gFrvinDtdYWNQwvl7uorTKU4UhppJ0S2
0ogqbSIQNzKGKqhsUpSezyNP2DU83WPmkXExwqQXXpKHJeFHOzkpu81snuDxFymjsUOhPKd4
VhuRJMe/XTtf4VWRGkdQqA9V7PFrtZmtCR7mwBlj8E4rPOUR+mMCYzS+MsVAG9IS/N+iAuTO
f/zLtdCl2m+A8kQrq2pWnsSZS4orohNiMbjtBPjVuIYv6siyBm9YRrKuDyJu25iWpgx/GZDI
FwAOCRr6mlRJBab+GjeVqMk0EJy7Qra1j7thkJGgwjDJDJOhORGCYzpUL5UAGSYunZ+LvPvi
2SOAqvIZReXU9gT4T0xguW+83n08vVvQPK8b6gepDP1oL6VNpVbHquQyPJW1hvSk+oDhGs3O
ByZFQ9JYf0WmzA6fZSRTHdfENFfWPVBs93jmjdrEC/9jZnuYksnkyHhgvD49fX+/+/hx9+uT
ek9wIHwH58GdWke0wOgi6Cmw2YGNyEEjwmlICife/8wVFdfR2QNHfZvwVbaOPW1+660zr0KV
uq2vRBhTwiNYYKw+QHwUPiqyCPKsUItcDJgSDNEM52FLda/Q4ETf3zqrqaSaF6AZZYTn1Qnd
fTB5kGoD3eup8NzBTqZ+rqRP/37+hsSRGGHuL1nwO7bC1dQFggx+WOzXAJOIM/Aj4gFCwCXC
DRnuKVgOx8C7Hufqi4Ej8y8J3wi4BUG16camnA6fEkFfxPBwgadjqcJuiie8QKy8PO78OoiH
rEchE4P4/ah9raAKbMx3+DxenSJPUxo/FK4Jrt71c4KzXRsvYobHqBpHso76xBdIR4hCxBUy
Dh0RcahpP8ZB+tuP14+3Hy+A9zhG0nrvkUn13wRNqwO2CbYJAD8HhvUchWOyawHZqZ1o1/Tp
/fmfr2cIK4LG0R/qD/HHz58/3j6c1GioID37M0AR9BOnVC+Dy9IgCBinRirRrElNJupxfw4/
vbLzw4QCuxRee0HT8Y/fnyCxWnGfnI8DuLxYN1CSMi+e26Vi79KzkB5wWX1R/6t5Egx3qN9+
gSEoFB9+w9Bkr99//nh+9V8ZIrr6+A+vz3s6mq7hSypNH8Lje40aHjw05f0/zx/ffscni6tz
ztYmlTZv1Kk0XsVYAyUuUmVNC8pJ+Fuf83WUO7oMihk/uW3wp2+Pb9/vfn17/v5PFy/pAnAQ
br9pQlfhGyPDVJO3OiBT33Clo8INRc132OCzkD5m8/dvk67v51vHubSZz7Zz7/divXJ89NT1
5di+CMDjTQ9C1EZ4DNKQmqe8mhA67aqAnbkGIJ6FbJuRqsxx2Xb6dA+pooDX3nvXSAw85sGe
jdUeCzjkRZrYgce7nJL1sWdHTeqCQX1+/Pn8XRnOwoysyYjsS0rBV/et+92HR9WiayNGp1N4
jWPouLUoPY+Pol6oabXQAp10kTcZYzSfv1lL7K6aet2PJi7hwPIaNfxUl8mizgJsRkNTG5pj
iW8m1BAqU5JfgTzXjx2ihfV1GJMVbQiTffmhFOPb+HWys57J7mnuQNKHKSkAQjuHoK1syPA0
JxRhLKUjy0w3YJU6bDz22Mr1p/OeXX025jf6+cJ3HDZWRGcWn4YTWLdGc77vciMuHchgTxt+
ini+rAA7NRFXoREAhW+r6RoGQVS43wvEiD7XtsJaxSCjasAoBHTAo6wi91gA+3TMAZRvp2we
yd0wj4btvYM087vjczqhKYObT4hF4ak0W9q9zaEvrUZ5CvtcxxuutJYO/9LjLPPDjoGZ6aVe
h8miXz0yMYdEju96B+UelXPYFUK+ZH+o6yQN9NLO1rNSe0GKZ+ruSzdeGX51anBz/4xdkwtA
WNesSDWqWU02lnY5x107YRTSC/xXP/WYmSZN1o9vH8/QJXc/H9/ePcUMhUhzD+GP7noC5B5y
AWFVGUZV30/jDl1hmWhifWavo1Y+JX77vSp0WLgOEEPPVqbycAoLh7CevTN5d90lR/XnXfED
0OUNsK18e3x9N8kdd/nj/wSbD/3SVY3tgoEFj+cQNADATtrJNyyMpPilqYpfspfHd2Vx/f78
c7o46s7OuN9jn1nKaDCRga4mc2hq2PLgStXnO5W/ie/ZZQWh85E3AIGdWjgucDBtIuwnFeQO
H/eqWsE9qwom0Zs3QAS0wI6UD53Gyu8S/00C7vwqdzntBZ4gtKAWtQlFhGAHpZY2pGOLVMh0
SlfLMplSbZ6oP64J5nrQnKoIhclOsNAQ6K2T+HAyUUKPP386majaC6ilHr8B7Ekw5ipQgm0f
gzEZNIACgycdAVfsaLdvW//9TQYYIDVkOXEvYdDvVaT367ZxAYKAzOmhRXqBid28iYD86dY/
bGbLNpDwmrKbd30rvJIlkx9PL5Fi+XI52wdv5bnKDMHfDo20jiiL/1J46Rr6JfX2/ARh3M2k
n9UWNhggY0TIjQ9qLt54evntE+zmHp9fn77fqTrtGob5UfQTC7paJbGOyxsSfKL6MCGpfyEN
sH9kJQF2CBzKbsyT5SrLQ1gE5GS+sX6W5/f//lS9fqLwVhNXp9dsNaz2uNV+uwfctpdEw0c3
gQ5V6rs0aeK+3jdkAw5+6c4Nl5gR5ooiriaXHQSTIBLzFpT8ftLrmskohe39gSiby41vigh0
oqC+EAQ/lF5CfFh0pzOv7dbuP7+opfPx5UXNGZC5+80on9Gf4qsVXU/KIKULeYBhTKeUy0zl
ZMrqL0ayWMcbvlitFi1SbdFOv4X5TnXksGeQwLCPp+3qHV9GBz+/f/N7RBQTr+RQGP6jrFGE
o90dWCdx8VCV/pVwCNNYCUNwyl+TTfVma3ZbFNDprle520k9VfpuyWtV+91/mf/P75S6vPuX
CXeLKClTAJvtt6tyG3bcBUNNEbpzrnM0xAEiFQNNpQV2bGdPLOezkAcxqt5mqWfs8yMLn6bB
pXfuepBKZz5WHtSdMqyPJZeRGzMVFwJvpZcjpYgP1e6zR7Cpdh6t/7guzdufqd+lC41SZf25
vUeDI60pAL4DmGWSqfzrAmKErvb98ZY63SVNRACnn2cYhoQjoU+P3H2pw5u4NC2LtJvN/XY9
ZagVazmllpV9iZ7uRhXqkEK95y9U15M9Gx2jbz8+fnz78eKNei6IKoG/dlnHkAbK2sJwmIP1
U8Gcc4rx4NulD3rK2RmP3pB0NV+1XVqjAE/psSgu/sDhuwISNJ3XPpBS+had5Fmhl1wsUIuK
7WIuljMPcVqp1LwSgGkM6CycopnHh7rjufN9SZ2K7WY2J/5RLBf5fDubLbCHa9bcAyNU5reo
GtFJxVutsNOmXmJ3SO7vXQQES9ft2M7c3KeCrhcrD3MkFcl6M0dqP1kv3jSsvYbcqcMxcmsK
vsvwTiT8NGxz9NWJNGOuiQB+aLWfdlpfn2pSugqFzv35bH6r0aHaQJpunqxm/YhkrAYrfXJo
ZOgdkXPvUipLnqbJ+/yCtOvN/QopuV3Qdh0vqPaN3WZ7qJn7fpbHWDKbLV33QdB4xyW0u09m
kxFt4Qz+fHy/46/vH29//EvfnGOxXz7AxwD13L0oM/Xuu5qAzz/hT3f6SdhXosve/6Pe6ZjO
uViAVw/pIAIhfRoL18duNnuXIgJsNnC7IhL/OAjIFpv+drSfCjooMf4KGzS1gqlF/u3pRV8I
Phk/p6ruvHVVEZwf+sy36e/c7K+MvVLxMBbooQomA8kpZFd7Nms/SWLko3DO/A9kR0q1OeRu
YzwFPEpC6m06mE0CAsLsXmbSBcDseqylfiuEFHCc50cR5MKYDmeM3SWL7fLub9nz29NZ/fv7
9HEZb5jvue0pXXXw4wUGRiwKcRSoxAUd7lfbNPQ3oWp8VQCFq33kvhOD0I4VR9iNs53EMoBU
68xlJM4w0hFxwQ1fu0pf4Iw79WFFRDnwfvsjafBwSfZFA5FcSZiQLPQKjC92ymMhnHWUdWpj
HNiwRo4h9pFgWtUGwfCgK9V29ZcyHfEaGx6NTZUR+C1F7076w2golUjFJyYjwaI6DC06Fsu8
iIEuNmEUb++z+Hh7/vUPUB/2oJA4GbbejqaPtviLRQYtBMAInj0Or39SC7nSRAvqW1csX6DN
X9BVggcOW2+VErjHQ31Hgc0W71O13jP8wFZe6kOFZtw570BSUksf09qSNGo16IcbFeyZP0mZ
TBZJLIumL5QTCrtS6nkFRa722gIzML2ikoUYt0wZRfjAMWupRLPx3EoL8tWvlKl1ov/4t8p6
vir1c5MkSRebBPmV6DhV6wI/NLfjoCxoTHeUfI2PMQDsavfoiaX7FkoNlpITdKCr+YfToYMq
T9kTmcei6vMkysA7BDix73prgB2bqvEiWwylK3ebDRq55hQ217z7c3u3xCfojhagtXGNtitb
vDNobMBKvq/CkAinMnyiGxBssPxjBW8MYfXCNAAg3pVY/KpTZnS3uWsRlnrgFTrxY4GOJXpg
ufCDlC2pk/jAGdh4fw1s/MON7BN2q7HbMt40fs4xFZvtnzcGEVUmaOVrFI6Z+24RgIkqvVG7
Z3BNEaqJxta0ELeK89Kb6iv1lb9J/Ms55hp3S9mA6fFB+Txyu+ixTEOVN61P2Yc58yKSdmx+
s+3sq/W/jp2sKV1Zw2WUpVqb9BVR4QSd1pQdP3MpPJxwq3Kz4vQ52dxQNwZwz/twKEqvU+Rw
JGfmB/fymyOEb+artkXnz+TyGoZH6DJ77YUnN4vsGfe4i0PRT5HsxjZWJFyCfE6sumWsZYoR
KxNZXrMimUXAN/e4Mv6Mgvc4fV6Q5sR8AJriVMRSV8TDHm+ZeLhg/if3QeoppKy8CVLk7bKL
ZOco3mriFXG54nyVnZ1vtIfTxh9tD2KzWeKLHbBWiaoWdyU/iK+qqN7A335oFU541S33y8WN
6alLCubdQ+ZwL36oPvxOZpFvlTGSlzceVxJpHzaqVUPCLTexWWzmN5YT9Sf40D0bVcwjI+3U
ovmVfnVNVVaFp7PK7IbWL/134squZP83PbtZbGeIkiVtdFPI4NKbGOshHDVhxXU0/fOYywZP
KT2nm9mfmJPa7YkTT7m3UmvIpTSw+qcFq4cgLeTQxRQjXKNwYz0w8BI21tgzUQ5Eg8uiFV8Y
RFpm/MbWsGalANA2dNJ8yau9f5z7JSeLNhI7/CWPWryqzpaVXYz9BQ06cxtyBLdg4RnrXyi5
V6OmO5KISfyFgps5luDdFDfHcZN6796sZ8sbE7hhsBn1L1mI+HQ2yWIbydwGlqzwWd9skvX2
ViPUMCEC/aINZPI2KEuQQplxXvKTgFU73OQiJZmL9ekyqpw0mfrnaSARyR9UdAhQpre8GYLn
/nU2gm7nswUWY+OV8q8s5mIbUTmKlWxvfGhR+GBToqDbZHvVvaNFVEtxNVBzGrv5DJ61TZLI
thCYy1sLi6goOAJb3MUlpF47vfeRhfbo3vz0x9JXSHV9KVjkPBmGF8O9rBSyosvI0smPNxpx
Kata+KBN6Zl2bb4PZv+0rGSHo/S0taHcKOWXgBQ8ZWwB2oOIQE5I/AJgp86Tv9Son11ziN07
DtwTIDpyiR3cOdWe+dfSR/UxlO68ig24QQC/Vc+p3BxqupXbY07S8rjqtTJ5rvr65gdqeRN4
aex8Asa8xoP/szSNpE3yOpJQqZEFdknMDilMWs8ptvFQ3z6WL13nEUyiusbpAt+ZH8XOZuRP
Tl+ARYnEuxuYD2ofGvFVArtmeyKOeF8Cv5H5JoncvjjycdUGfDDgNxGzAfjqX9SEU2xeH3BN
dA5Wgj6nX5l3mIcZxEefeGFWaownD/4Sfrh2TZc8rCYmKlpp4Sb/uizHF4lweycTwgqukQ5Z
jfDDo+GcNhJPXjdcFD4UCVLpuBfGmExZy9E+bYiffu/xBrMJY7oJ4y7Dja5w6TIi//WSulaR
y9J+cVb6bjmrZxpyodM8D6axH+7OzwDf8Lcp1MXfASPi/enp7uP3XgqJvTvHTg8L2CvhLk/r
xeoieU9qvizjp2/6DFZwfBHW8CEIksLoQxEpcp79+vOPj+ixOS/ro/Od9M8uZy78sqFlGUBM
5l7YnOEAGEpwdZNhGPjLBzxu3ogURDa8fXDuCoFslBe4h+b59ePp7bfHICLLFoNj7AA7xhP4
XF1MkzwqO6HE3XibqemsGMqEKfDALrvKpASP/hNLU2oLWy8ddr1abTZjGwLOFuPIh12K0L/I
ZLaaRRj3M7R5X+Q8WWNGwyCRWrSgZr1ZIXXnD3hjIHw4QtYDhGGFJCXrZbLGOZtlskHfwYyZ
a++QF5vFfIG1XjEWi0it7f1ihW3dRhH3SuyRWjfJPEHrLNlZRk7TBxkAdwIvIK4tBjG7+7vW
PCGrMzm74agj61iaz4ZULIsa81ONDVSTc4kWlXShRuzVLyGLeSerIz0oCvaZz/lytsDGcBsZ
9JTUaqvVIpwdLcKprdWEE5AEP7tazBFSR3IfN2rk7C5oyt3AByeM+n9dY9WqvQ+p7WXqSN0D
W20UcWSZUZZeaj9q2WkCz9jOXJqCPETDv+qYx6v1sxwWWfeeuSnPNDPyLgysHY7pP6ctejD4
4IUjN4M7K+A5uI0/yJ0K/ffVJ/Ut9RiTvFFNVbvinOmWhRw1qFbb++W0tfRCauxw1nChu/x8
YZ9ueUGdA3cyFgJBNbqDc2aPDQNyVyA9TJNkVkfB5kHkJNq2JfEX89W87dNhDCNvPDJNEGCw
kKt1GgA4I0dCWkTDTUbgbY0AfDhBGxY5h7G6QFnpyGs1BV9OQtw0EQ8M1Sz1fcb31JRstphS
9GirAvo8tfGnoXySTCjzkOKqSktZhpTVqjdmDo9v3zUAAP+lugOzzwNI95qGJC4EEvpnxzez
5Twkqv/6EdCGTOVmTu+TWUhXVmGwGFk6BTWK9Llhq+27Ud1BsYZg52SGZ0OPPJVvHybmRYDK
ZYs0tLvWDFLvkOqMnePSj0H/7UnB/F7qKV0plOXntmTg5NiGb+Cy4pjMHhKkxqzY2AwCG3KH
DYUxEBjZIBib+/fHt8dvHwCKE6IGSHnxvGExeO3tpqvlxdHD9sb5GNHcY/KP+WrtfxiSW/yY
Mo0FkZbV1yp2utftBb6n0kAKnVA2L17wCF4w1IeXa4wawJgAgA7Pt8lOBcMB8U8P5u4Am6v6
9vz4Mk2Ct+/rXA3oMzbz1QwlqgcoE0GDBDjZ74icycwJO1izkvVqNSPdiShSGcEUdeUzcGRg
F3W4QtSEwEYaXZBIK91ocpfBWtLE2k9vN7lgpbLlsSgpV6ps9NGVc8WCy23gFqiCDSLog1gr
WZlGIGJdQaIvtu1O4VkZ1lvn4F5cn3nzUY2cb9BIGldI2cKRkVPwieZWLADBQLJDTRbWj9dP
UFRR9HDXyRnvTlaWXxV0QY6nFVsJP1vZITrDLKz1c2T6W7bgGY/EfPcSlJZtxB3cSyRrLu4j
XlQrpMbMjjUpiURtWym7bH2WZB89PfVFb4nBEfctGev2r8VNSbVGXmM3Ne5ptuxM5GqA3XqG
luJllrP2liiFozMNasT3nCp1jHvHrDTM/q/JIojTHZLnPZUcDLKCyiYPbGDLAsQkb7/h0HUp
tYjY5X9ce9RyVzdKf+Jrj2ah0Fl1HfjbbFA/nWYa9DZwXXBl2ZVp7p4uaypchJsy6l0PpBka
TjAlkoR0SH8zt455Bv3Ig3vPUF+FeaA+pTEO8IxQNqlERLKrNE9wLFJU884EcKerfdheQE+t
sswj764243C2V+XhRsEJzy5MpXs3JmwqeXA0Jqry4p9vWWhA8GTffUPMrbHopaTaNUcxLwEA
7AGE+HLmXkI9Upd+Uidt5ktcT/G6P6NB50e0pc5G8hyDqLWIKCHSQD+o6eZ+sf4zmF6lsrEs
Zfw6NRoZoob3Xl8FP9zX288zqv652LyawEWwkljqVAy25MHpkMtSSoqXQTqEyy+Pp0qiQRMg
VfqBCkDSz8KtVbofHhcVoA1+zgm8kwSE4KZqMYu2b7SQi8XXer6cvm7P8Xf6kuXUv3hNzS1/
r6PWlvwSeI56mgYxjR1EG4kqQ0fjdH/i7OH1/FX2/RGAcGssRMETAeysAfnPnAXMKXJe4r44
JJvrT1wps3vvXZQFVO2XVJ/LG7zAMNdT4vMP2HCfLX64objFse1bWPzx8vH88+XpT9UD0FqN
G4OYVnoANzuzS1W15zkr0eBEW/9kxo10/G6enp9LulzM1n43AKOmZLtaJlidhvW/jF1Jl9w2
kv4rdZrXffA0l+R28AEJkll0cRPBXKou+cpSydJryaVXknvc/34QABcsAaYOtirjC2JfIoBA
xN/O1hA8VQub6CYP7wFHyUREoTkNrAhNfaF9naNjbLON9aQmJ46gEjpKMp9JLuOLfPnj9e3z
j09fv2tDjIt1h25fjXpDArGnJUYkqrJvJLxkthwCgGe/dZhMW9AdLxynf3r9/mPTo67MtPKj
MDJLwolxaDawIF9QfwOANnkSxdY3gnpluzTFRcmJCR55beHXpsdOcsSqnXrWcOQKvSPUjwAb
bNcBqK+qy85MrBXGqK7spe0qn1BHvRFZxaIoiyxirB79TbQsvpiZnirs7HZCemFDJrpb+C1H
LrxFyrSxRRSxGP73+4+Xr3e/g1/IyQfXP77y4fLlv3cvX39/+fDh5cPdvyauX7jWB865/qkP
HAqrub7DyxnKqkMr3r7re7IBzkqmWW2FhdUEffVhpqS/0TbQPXkcB1JhzimBszgEnjE3i6Y4
BWaKDkkHoIei6dXAgGIXEfeAOo1PbWet+4urs4eH0BoarGpGxyNlgB2u34u/+fb6J1eJOM+/
5Arx/OH52w/XypBXHdxiHNVtUtDr1mqeyW+Mqw7dvhvL49PTteMyv/ntSDrGdRBcQBcMVfsI
dw5OhlMFzog64zRRVLr78Umu9lONlRGv1xZ6Rwad0EVcQvdmgUtTq1EWa3RhNnpvPGIHVgKC
EW/1di0iYkiXHa4mkP54nG9QVhbYZG6wWDdWSv2QKoWOE4QeM9OavOyuCgAaGKjXL3D5T2ck
inbsJ3a5+fXs7v2Xz9KPiC0+QUpc94LHFQ9CtcDV9ZVLHA3jJZxZbC9QKzatj0vR/hCRq3+8
vtm79tjzgr++/zdabF5JP0rTKzVDKasWUpNhJFjcOKOiKaZSzx8+CBeyfEUQGX//X3eWcOqE
a5FWsZdWWIS0iTA7bJ6Aq4jUpAYMqVopENv8INmVx5Ya5+CQEv8Lz0ICykk+DG1E+tSLeyWX
PvAyPQ9B15+lz+SG9kHIvHQjRQivrR6YL/SLH6m+lBb62JQIeXhIvcgmd7SouxErGrbzWUxc
yx6Gx1NV4MfNM1v92F4sswM7R66NuqxklgxJ23ZtTR4cxr0zW5ETCH7jOE+buPKiPRXDrSzl
o9+bWVa8JW/x1MW5YvvjgNunLj14bIeKFbcbbKwO4HbuAZNyliw7et+SAxnsvm9AxyU2nbJd
UvvIYBFA6AKyABtGxbsjlyf2Q3XEDspggZO3GDpBeBPswZxXuhuM/GDm6EpDbBS67OTtzUil
Gt7pLiHlNEa+Z4+sZAZtdViqBhv/+vztGxdvhURniQLiu2R3ucyu39eb3H65hUb7VOJN3mNS
kFTXzVAygpqfSb+3MoJ7MXc25Qj/eD5uJq7WHb3MMTgHh3Ar0Pv6nBslrlTjGkERj9dO1KpF
s09jlmDHDBIu2ic/SMyeJA2J8oAPwG5/NDFxu2N3PVUPbATxdEmjyKAtbyiMLruWk+MUPWA1
NlDkXs33uV8mFG7hjaFk9FXi47d0si3H1Kq/7sVlpoU+6gVGwOeqBV9ORkJn5sd0l6o12yz5
oh0K6svf37gkgdVosnx1FYbkqrNIOcQgvlNuDw8w1EQfvqxwcME/Cy6wOLg+FSdRof3pRDc/
NZnKNHKP2rGvaJD6nnlOY7SaXHLK3G5NNbF9zodHkFoF3edZlPjNGTs6lMsGybwoMNcSIJqj
ftLXVNJvpH26jmNtkE1NVs7tPsx2oUVMkyiOkK7JjfVRG8VgoGp947Y9nZqbxZGXxvZ3AAS+
cxyO75pLGhsFt8xUBfVI9/7OM6nnJg0jhJhlmjNFpI+XsFa3ZpJ97qUNgjG9mMtVwwWVzlx/
e2TJEOH04CmVj7mNnFkKyaPeEAhoyGkY+GbmrMvJqaqne3kl9hZWf9DYb9QfV9yXlJEUzPHG
dZMj9ibh7M+7vv/L/32e9PHm+fsP81mIP8evBVv0DhuFK0vOgl2mDAgdSTXxScX8MxoVdeEw
z+hXhB3wowakUmpl2Zfn/6gmXjxBeYoAfm8aIyuJMNzOacGhhqr+oQOpExDhS6ZASHauwONj
B8p6KrEjefVlgAqkzpKGngvwXUDoLHkYXqnDfkLnw8N7qTxcE7zRCknqKHqS+q4SpoWHP5TW
mfxka5BNg2lRGUQEU3JShG3x/J/2qoYimIaCqa7+FKIhwZsI/DmSwfFtPdIg050Oq/D0LaZS
KVyL0IimIdHF3gC7cSxEiJ5GM7aYPkMxcFXd4NASFLavH+0SSfrGs0iN7f7coBfUfU4ko31a
QnIKccv5eqM87OBCVpoF0fLNOnTErijp+OU0RPiy4Amc8rmmad+ksadJaHBZeoCxxeVLL8Z2
xflrGPWxZgehIikmUWoMylzX6IFNr4sD18ZOIZYZ2+MWinNFXLh08eLG5/T374LE5QJkKTcX
+UJcD1RZIuz2SmHwVUFHnIFd7K4HeppeyyPEZCVH9N55TpOPHz+Rxio4EmAtKrAAVXTmRlVG
joFwuZ2PG329nrGK9ZDpZneJIY+6U585LOlxBkAeVhXZma4vc2tGov+RZMYwjnys/NAwuyhJ
NgqXF6OIQiZ54yjGMuY1zFIb4CNt50dImwogQ2oMQBAlWFkBSnSrPJuDi/xIqqzZh7vEHjNi
tMmFf4e2zzBmuwh32DmzHCnzPQ+bB2LNXDMVP7lsqimskjhds9zrXgOkcezzD65GY8cAi/v8
fTUeD8cBM2CxeBTJZsHyZOdrl9MaggsZK0vjewG2qOocEZYvALELyByAKlGpgJ8kKJAFOw8D
xuTiO4Cdj0Y4kNB2XTlHHDhSRWMfCABrHRYmeCkYTeLNFn9Iwc+oneSD7+FASRo/ujf38TU8
Q18XMiwSUpg97r9wZQC7dSTR8dL7WIo5i1FfOCvuxwEyBPKirvk8bxBE7FMgjjgwpPWr6IFr
0XukqRKfawElDqRBecDqVCZRmESYVebM0VA/TNIQL2TJ6H2DtOGhjvyUITXmQOChABdvCFZC
DuAPmiZYnDgaPpsm7L66j32HqLA0574hDr9BCkvv8JC9sMC5sSmH2lxR5HLDNHHAdTZMhO1k
xhTbFWf4N7pDpjmfQYMfBMg8h+CgfHPGGnC5idnITm5RyECVALLyTYBujqiBGVbMkfING52Y
AAU+tv1qHEHg/HiHb6QaT7zddZJna/EDKSX2YqSpBOJnWPEE5IiWrfJkW0OCM4R+EqKLNgRg
MRZtnCfE/AtoHNi4E0CE9KcAMmR4yMJmeGFpH3o3CjvSGPU1s6RRtGXg7xu6SEF2XzYx7h9l
ZUgwqVmBsQnRJAmeW4Id6a5wik0HrpSiVDTj1JEx6opOgfEZ02Tblc+iQH3aqwE7ZIOUAFJw
aVaP1B6AXYBWqh2pPPSr2Oh8TDOx0pFPre2eBp4k2VpbOAdXwJGhD0DmIQ3R9rRJ1HPutVpl
GmVKC/WN8S5n4jMdGajSZrBZ2j3XZPuysNOE6F+0LHsku6pl/ZFrlD1D0SGMAkzu4UDqxUj9
q6FnkREmbMFYHadc4tgcYAHXehHpXOwdSYqOWQmBofWxJrcGBucO080NZVrLkcpxJPDcay3H
0Iit+uqHzWJAdjtMYwAlN1Yd8yzj5FLwfQX5YuzZztsFyKDlSBTGCboXHWmeeZsyNXAEHlr3
S94XXADZ+Pip5mVFv+3PDch4m33G7sfNHuN4gI44DoS4Bb/CQbf6zLJ7XmT4puDbLrpMFVyu
3nnbaw/nCXz0eEbhiM8BPpPAe+cuaTYLPrFkyECQ2D7Etmg2jiyJkCnPtZxYvyRdVybqB2me
3lTaWZIGW9sh4VVO0eWmJdKOzV5TOHLBnw0vDCG6hI00Qab4eN9QTKQZm9730C1TIFsdKRjQ
lYsjfKnc/nSHlr3pIx+REcC9J+2PuL7NwTiNUUXsNPrB5hHDaUwD7AjknIZJEh5wIPUR9RGA
zAkELiDEii2QrYWBM9R8wR2RrU1CcYuqzhyMg+QejyGgMxW3uMQNg3XA5nrosEwFeMLlvpZY
2MYHz/exZVvISUR7VjSRIHbTWIF7G+xsYGYqmmI4FC14v5jujeCwgzxeGyX48MxsnDnOZD1w
7kyFkMPgO+c6DlW/VYS8KMmxHq+H7sTLXPTXc8UKLEWVsSTVwFd14rAdxz4BlyjgFNDhonX+
xJ06wrhZXmDYk/Yg/nczzxvF4/N9ZsdxYfK8xbF2OchPlesJ58QFpoQow7tuqN5tZgTnXnGA
sSghJeGNw1fN/cjyvQxTKcYjrYnjKEUysY5e85E58xLzj7OGO+9yI0tgwas1XS1vpmWVnt5v
JoY3gmIpotxzbrX1/OgcWx3Bc2/HWLXXXJ+owTCBhcEbDZ3U00rE7ES/nlGTCC+zN7+aGXS6
dFcMiQofGsrH6yposTlqOzHpF1h72hCkTEA2mGTpaeXgXnCMzAeiQV5LrNZFQKysCcOf+qmf
gnvyK23weaox4rawkqVQ/IuK16Qf//rzPbyhmH0uWfbETZlbPskEjcvIpuMKBSZ0TLNdhFsa
CwYWJo4HkzMcOELfNWIq9FEUOPxvw/dkDNLEjgSsM8Hj9iu49aCOl0kr131NUXeqwCE883nq
CYCgzhaQOlneTWM0w2ddmVv28SvN5rVs5hdiGNmdx8mpu/ekNT0mYqyoomOIHhH3+BeEqBp5
wufTLYlVAfOGZKbFgVl8QcXE7wnUbAEETbMgFa1IfQhOghLtot1XMZfJRZXUsnA98toTVlFc
7wOYJ2W85laSlbvDuyMZHpY3mmvGdU91S3UgGLbV68YHZbuxN4oeoffj+WcZYbvB/Z+spQf3
TEJy/Rk+3PM5MAmDXtp0uebTkQOmSS/QhAWF52HECCHG5nSbbRHMcQV22Um8sapIBjT0/Arr
lr4rPcNHycKQ7jYZ0szDTtEWNLBmuTSW2PwoS62Pxjh0fzOftevtuVrBmqkNxYgZCwCkGLvM
K8ZE0e8mF6o+OyaLZ+ONtshzsfzVizJGXuhu4YFGY5S6FhV4u5Ya2bTRGPsGkRUUKRGrdkl8
QbdR1kToaYDAHh5TPk6NlWsKJzNRyP4Sra2wGjrtQ9+zdz81mcmUXXr/G5vP799eX768vP/x
9vrn5/ff76Qv5mp2fK44IF9FMWAxfZOu7qt+Pk2tXMZbGKCN1ZU0YRhxkZxRbXAAutj3aw0L
Bk0pfjg1JVk3Ryfck7ohuG0bWO37XuQIsSxs/XHlXECJsRRhjwNWeuZeiqbHA8kmQ7pLNlKo
RCOhsfIUPIojpMiBb60cgp7GeMMsDJnjzZfCEDj83U4sfOVXj6UmkzZk2s0IOea6eToHID7X
1vQ4136QhEiidRNGoTXacF96KoN8I2IU0HjgIdZS/dmXyFJ5QKlLpkP11LXEnoJqRZp054pT
I+HQv2w0uPmGZKXZYtLytERdJrv7Rj4SuthL8oRxcRA7ItY/D8yldgQxxTeJ8unxks0gngb0
iB6g+tRxaUFz0ss1k5b0THQ+7V85yuoCPjW7epSmGRYDeM07Sv+B7NgUjozgWEicCi18aMeu
H3D552BMSYxHl6YMKPYSDAMNL1XXBgXKo1CXLBSs5f/gpzgK0zSw67zDNkebkY8EMB9HC2Po
Wytiq20KZj9rM0D0BkLlsbQ/ZcDMuhI2mCxjZxcTrr/pTPFPpBSg+5XB4mP1KEkbhVGEDgJd
XFvpUpdyI6coRMdixeos9NCs4JI5SHyCN+iW1ZPCxaWIBC2WQAJH2mA2je94OlOEXVkYLPpN
mwLKzeNWLpwrTrCnciuPovigWKTuRhqUxrsML50A0TguOo+hoBjgzREvuFArHYNHtQ7XoFk1
wzHN5EPBpiMByy2/xpGgioPOk2aOMdTQ3ueyHnaVrjD1aRplaAn7d0kWeI60uTbnOGVbmWYN
a7MAfXl8Koz7fAU9pal3YxAInhSd2wLKXGmf8bO5lUM83wLHPDf4hBZ3i0eqdZs1AaEEqwYL
mp546CICEPN9vIYsatIkxkV5hWtSBzeLxupD5Hv4bm5JTArEk/Zi4oDSYIdukmBc4sehY1yD
NB+EDjNLnY2PflwzN9nQR+0mEz7LBeZvFdbxFltjmpUPLAmpbtyox8nhvmflMCVuDdHk64Ha
6xK9No6wfXXleOo50Mnp8oBrvAI/VdQRF0rE8hOv9wwHauKs4PD2/O0TKP+IVyhywF4+nw4E
PISu1ZwIsE6Dk0L2q68EZACQnasR/AA54iDniCd4wmmqZ+P5Wk8hz3eGd/8gf334/HpHX/u3
Vw58f337J//x58fPf/z19gxqg5bCT30gvijfnr++3P3+18ePL29TnDfl4qXcX2kDEdAUfYHT
2m6sykeVpPxdDY3wGch7JNe+ytVDE/5bvOE8FWzpNw2l/L+yquuhoDZAu/6R50EsoGq4brOv
K/0T9sjwtABA0wJATWvpRygVH+7Vob0WLR9z2CvROcdONW2EBijKYhi4DqYKpZx+X9Dj3sif
DynNIxC0F6EPNYSk0ajwCHbytKrnNla1KP1Ytct1m9bbn2Yve8j1MzRnNQxoBC6O9U1gNAqn
8CYuuyu4euvalrc0/il93BdD4OmbuEqHcYJ/SgZ9ABFW1RCUQyNWDRvNHuONifpvAKhgesu3
O32HhP454FeIHEKj1Snd6OfzFY/6lXR2in8yVCdisAPJeb4y4y79f8bx0VMlqvEnJ9RF6kW6
vSt0Dtdx6xpiC7UUi2sL41B4fjC+k0SuGYOHZcP3FcYHwa/eHbHzq5XpoA9/STTihylJkpMj
DBY0DMldjsNheI2PPnomJDEjPwKxehxjHrDDRR+7nIR3CQuNn9PCqWbGyImgD4cBq/R1gP++
hp5n0/zInCauMdkWHV8LK7MUD48DvtlxLMxLXCWFfLou79BDFQDHNA70JhiHKi+MaU6GB+13
3+jf8BHbmNvWRON7MWmuxUk3UtNAemSj4zaep3Mo+JrraPyG0WNpToNjjklbMP32DR8Y4y4y
+mc6iTOHdMGHdNs1rvmx5y130YfZRBNGJAdrGM3oxtrCqqZ3BGcBlPH1Db0SFG2R+HKbmMQS
VNYQu87++f2/v3z+49OPu/+5q2nujM7LsSutCWOTMLjWFRDFL/BEXWaY+dVqtbJwTAZOuG3L
wiWP3jHbljUrdbHE83KpkyuHPJ37CSaHT4KZBTn1WEHx1vVGHkKvPdcFZj+wcjFyT1QjESWP
vE9T082EBia4p4mZB3NyobSk+9xA67Q49NDiCSjD0677NIowZU/JHkIm4BVXbk6x0dY7rBmV
7E9R4CU1rkitbPs89j1cb1caeqAX2joMt9YczdBc08S9MT0VHQlMfLX5VXemp+QpTUsnm1Nh
3VF1wseMH2YwEyD1aqhbIOQNKdoDLOcWdH/Oi14nDeTccIFMJ/5G1AAeM2UKnmmEGwK0Ywzs
WJHRMpUQK/j9gBDzx5aA8QvfjjpVpgcM1E+IYsN+DQM9/0mHunZ1zuc1fgolSjJ04HzbUc4T
2FBAaFQRhsmso0vGFF9KZ1tWP1zZYX8szZRYwcW8lqLebUQ9++PO80XgLT3Frq/Dq6YZTdSd
TT1dbBqhWXKFcwZqVU6YLroa5syYnRgDTbTRTNAlOb3mrDeJfmxTpbN0rRwkB//Tru4juZ/6
MSanzegutVKsmcNtAYBPox+rVxoTMQj92EoIyLi/Ao7SpkpD9YZ0IaqXKYLIdoF+grVQY2fN
C+bHDmOKCcavw0Tj01g7jwTa4ciEUFBRi15cxqFoCovOZ59ZaBEuyx3hSeW4shGNsSiWlqcn
u7lhrDOCPm9rZUDLLLisfY5gS0ObmGokKeZbNXTWILYHsDWN9+SM2j7PA56y3vqGUdK7mwta
quRiLhr3EUoqFrGqbQmtjR4S0Nqn+rJH7Rge9/kv4pBMPTpbaNoyDW6/hoJwqQ7iRjwVv3p6
6kZcBQUpq6GACGJ6SWeqvaTkmlQr+utSns1FY1IatTKINLvhwRHvk3Psi33nXlmWMkHUQA/1
pKexjYR3ZOOoV9ONR6yApfGaRN8iaUV+NVbwvqMPhbEH9LmwplEj/4iB1VGLINd7/cHzhMwP
GjZkBWAbu77jQswjknQD24m5zE8AfeLSeRL4WXPJ0jBK+M6tmtEarMMYxbtog4fnE/5trNHC
JBytdFM9DB1s4t3Ymb2gRHWpAmbNCfZK7+TJ8cfXN66xvbx8f//85eWO9sfvc5QF+vr16/8z
dm3NbeNK+q+oztNM1U6tSIkSdbbmgSIpCSPeQpCWnBeWx+ZkXHEsr63UmeyvXzRAULg0pLwk
Vn9N3NFoAI3u06vCenqDA+UP5JN/a7Z6Q/EglGVEa+yUT2WhEbGrBkD+CelOnmib5OSIY0wo
OIAqIfZI4lDqLgKJNySzMZIfeSnao7rxvdqo2sz2wcPMwvfAsIlakpNngD/cGnFhQE0hDDzb
3N2lLo30woyPOoHxN2CbmqRFkt0zZb7Ydkw5TdGi5c2+WzfxHcW2ipKJlpuxZFgigBuyGuUx
rb0RlhLpVaAnkHdZDd4ejRikKmNRckURu1ZCuCHIZ9yA77GOR11ExqjIXTx/cUHdsW4LlliJ
CJYLk9TTSWWtdDojD7oFbPCGiJiP7JyfpQV/Kcl/bCjbcrAqXc9o+GK8/uGBxH8qLyjcJivL
hDu9vJ5LnTYRKUCPBuuzhilq17PA21CMbWUYXjFAnvkT9tnkgU9f9f7wqokx+pVdsSHEsCGI
cSa+5kF/5tydH9ZOAyeXaFdn0LHZVNvIzHdk+3zsmgRzZDwKBwgnB3/zcBODjGdTBYndrq7D
ct9lYmw979qGZMiUAcxbTj0XcnQiiyuI4SdKQZdTze2KinieqRErSLc7YD0ywrhx68i2n3ue
tW8bkHng3vUMLEGAO+VUWBaoh2iVYY5VfB/MQlvtF0gQoE4VJEMWB9pJvgTWiR/iQMM2auY2
hNFjOguyGVI6ASApCWCOlVtA6ON9jWOBpTr3M93lqgYF3o1uFlxoRQBwZblEazj3FwFOX04d
dGRGCDo+HwA7HpFBPwDmrZsCz5w+8hSeOer5QWVY4ckHs2zmOoXgHOASx0cUQa6SI60pVHWE
nts7SaCndOnNUIdgFwbdLdVID8W5CkI3j04udFdDb5t8gfvxGJW4ooTgh1NsOI82qR3F9hAR
27hMQ6RMHGFbGuvkagSD6bW24SyLpfPrlY+fZuv5487StCyQaZDTPFx5i+4QJ2AFnpVbtBgK
F+yGm+iaFs22jd4itI6zJLQMVzfEAudaIcN1AFzdD3C4cF/fKXyz6WJ6uxRsaIYRWgyOXClH
4Pn/3EifDUN0iNfZwjqj4vSGyZCwo8kBw4IFNo2AjqcF+2uMvjSPBUfykLNVWwZ6HoBX2xy4
ApPLVEW3TRZY55IcIds8so+QFQSX2CNap+wP++iNs8CFbhexf8mGOA/gBWu9GdROh+Ym9852
LjT3Z9NrqyxwLDBdawAcFaT5PMBlB22ime88AB4Ygin+KelodE0HbyLqB9jKzYGFA1hiKzED
dPNQFVh61gnzCDkP3gcOpsChGk/DVre5h3ralBybaBUu0cW2ye5m/jQisT+7Mb9Hzpl3RGTZ
BfaP8xsw3vcXFryN6Czy/aX7ZFkwCd3lWj2AJUCK2CaRN5shwCEPAw/paaD7M6ysHLm2RgJD
iI5Vhixxl1kKAyZngY7JRk5f4nRMhQF6gNd2GSC6FdCXyHAHeogq0wwJp/Mbww3skKd4drqD
TIW+cLXoCvcHrTAsHUku0V0bIOE16XegURjic/0z3+qvFhXu2FDRcJYBOmXhvQXuD1JlQMvN
EPwZjWQoojYM5kjvAxBik4ADPtrPAro2DZoqAm/bkWZGpJ80aJ+ItQ0uyNHzhAusA2KN29ZR
tZOoVthjiFmPKlcL4jqJJLbF0s4IgECSS+CTpk6LbYPZUzK2OlL0nnan2lJDIkZUTvrWPz4/
vPAyWGcwwB/Nm1S3RuLUOG6bskVtOgVeq8GER1K32VhJmbZEJkZqIyGq+5vltBZu2VAJzlsu
zfYEN2IRcFNWHRpoiMNku04LUXSFLIL3mjTCfpnEsqaRWYu4bLWoskDLozjKMuPrqi4Tsk/v
qfE9f7lg0Crf83yzbWLWNA2Ba+T1lE1BRyXj+6pOqZEJG0zbkkfTVRO9UI0207JNc+pu0jTT
veQLWmp4MtLA0uL/zFrFmf02zdekxm4UOLrRA7EBbVdmTbp3fdAswlltfsIKYM0CneEeVysA
a2MeuNWJH6LM9dgYYIgaTcuCYGsdL/F9zX3jmWUmEAjXmSppXHPxj2hdG+OtOZBiZ3fkPi0g
6naDXhkAQxYbMTQ4MbUEXpYW5R1u7cZh1nwgnJwM3PY4L1vqqlPOmri2myiP7t1+zYChTsUc
cCVL4rqk5aYxpjdcPNTpvZVdmzXk+jgqHK6MBFYTzLgKsLJmQ9rMr4oKcMSXlc7pUaUFa7bC
KH+VNhGEIjeoTOJlsdV3A7nb4IYDKstoR3iTE2wIb/KkCX45oTLFBNu/cg4mmWBMkJiacpgY
ZjxiJDBm1Kibo2UcR0YrsqVA9IlGy2mre3blZLaUOFLm8WIyUpgJNWlkCTZGTDPKVn30tQnn
aIsqa40K1znRCds6TYuIqqvOSLJWR5pHdfNHea+nq1IRXYAtU5j7Pw6VFdVC5HDijskZq77N
rm5pI8wKHam1oCZ1lfpkQojcuLSSOxCSl06xeCRsqpiffE7rEqro+ObzfcK0IS3oFbQYd5Hb
7do1ShdPC4Zflv6TVcagl7eMiH43xodFFU8GdJbWWKmEgUPasirhYtUEx3jWei5jseEqECCs
1NZno5WVmoFSnHIXkw7erDE1XTyv04trPRRsVRPMsUxAZfKjMyWqxtBmFQH13cnA/ixcniwB
j+p41+0i2u1ivVX14mn+Ofl3RcGEcpx2RXqQj1qlHp8/fzz2Ly8Pr/3p+wfvi8G2Rm1ySET6
EYZnf4TiIpfzacbETraycTcUw7rDjkm7zMjI4FlnfAGgjT72h86gvDd4CDm6tjsxYvsQtiFg
K1Yi/D3/7uulMAIhXQb/6eMMD1vP76eXF3hXYj9m5J25WB6nU+gqZz2PMPiuMaS3GMpj63vT
XWUyKSwQQtFbHK0x021YE4LdjwWUQ67mAJd0p7mMxkRRC0U9Hev5DJ8mjuxbb+ZfqSfNQs+z
KzOSWUOUZpICRL2DA1yH0WIRsD03UhpIEbzLOj4dWgD7igdazY21fxxd4pXSJH55+PjA3sny
oRtjux0+9Wtu/Ks3wSExWrjJx218wRaof094WzRlDU/8nvo3JjM/JmBvF1My+fP7ebLO9iA3
OppMvj38kFZ5Dy8fp8mf/eS175/6p/9hZem1lHb9yxu3P/t2eu8nz69/neSXUFHy7eHL8+sX
5T26OveSONQf7DIqsR1aqfMtKdRVeSR12yjZpqYE54juivlCh7drhzqqdCznHZjUsdmpAiid
oorjYynsTxNwgVWXmT0gqpeHM2vAb5Pty/d+kj386N9lE+Z8sLDx9+301KsDhCcJ8eTKIsN3
uTzPQ4xdZw6Qb5YTaFYVhaeDh6cv/fm/k+8PL78xgdjz8kze+//9/vzeiwVFsMjld3Lmg6Z/
ffjzpX+yVhnIiC0xpGIbDfQSdOQam03vJpGC7nL68o0zGvPIAmZke7Z6UZqCIr25slzvCFNv
UpcI4LFr1SthhWjLqREAV9pDrbTcJIMYSNZ4QXndIwv6hfeGdXbHRS2lS9+cfh3sBBAH85CU
rkU4xFaaE/TUe8DUUKVcyiVto54FiiLc0XRrLvXbstGPBTjZltnDURX7fxk7YqMJNu5u3t26
ietogC+rTULkMZVaGziRTFjHgKahlIvTu3xDug3bd4igt64VjjB9ZX23jcx6oa6WuaCHF6FM
31vXphs/Xo/yENU1cYSR4t+nVxS9dAch1/lqtiHHpnVKZvF6YHMw879nn2D3Yjzxz7wtj77e
ikzPg//9wDsaCt+OMp2T/TELpjMcmS+mc6vl2Ea4Yz0CQaJTRLrB2K7+/vHx/Mi2Qlz+4hOm
2imHr0VZCfUuTsmdmSMP9Xm3Rrd4curOhlhIygbJUQj1S3yFGcTFdcGnMoHfEnS/bzNSvaEH
ECrX8dsEH0EH5aAr2pzthTYbcCLiK43dvz+//d2/s5peVGxTkGygn9H3Zape26reX3gJapsm
VTxjB3WM/OXRWqzv4HvXIs/Amal7FpXhS1VSWTpc+zU0DCiKtfauk/hKvlGeBMFsYVWsSBvf
X/ooEV6gmLlwKHS16bbct3pS6dafNmj/C5tga/lt8/ze3suoQxztek2kkzXbenOzcqNNNx28
ljREQjv6wNU4zWG76doo9mAZieJ7BPJNmv50V9BQxVv8uaFmW0g6sqLifIbCjzOVa0d8X42r
+Jmk0p9k6mi7ZovAbd66YEvfTySZujY2I8uGdXNHKd7Qsnfx1EVH385AHw5X0sK9Nxp8MFp+
hs840sKZLsNslJiDdv323j+evr2dPvqnyaPqdctYqeCE0TwIMRxFD/PYbCx98W/wOwcuB8xB
ZskIu5M2bRHDpdMVdXuLTBdVeLJ2Rvd6W6XV9MZPwJPcIE+uZGsdNmposkb9ufHFJTqoq7Ii
62532iWb5r5KXdIfdPvBEZxZO4Do8PAEDprQKuQ56gE7zSFomnJFIClGLJ2e7ex/0PPz41ck
hI78pC1otEk7pnm3eYp9+hMHamNiDdnkXY6pJyPLH/wWrehmoe56W+I1W2OvfQ8GAU26149R
LbRVT13hXBVOHC8Ufv7IXwZjtI7fEqql49i6BkW5gC3K7sC2l1Gx1f1j8CYBnxnIDounIF2X
oJ3NOaKo8Xw0yI2Ai9nUD1aRVbaowuMGCJDOFkbYI61ecb7QLHEv1MCkcnc3Uyt7Tsa67YLO
sI8W82sfLVaqzf5Inep2UpxexdHKKIHO4PSvIpKFcA2Y4dGIqraeAzEIuA9e87JhRB0xxC84
dsQzonqEoYEc4oE5JKqZuA/jOb0ruzxS36ZeGixwNGRwvNFewLVAgzRw2PQWyom2f/GR7HC0
LLI6YIsVh1QP+NrQTXzNczInyoewcyN2sGi7ZhY4QuFw3O1PWdxkxBH4gTVybLI4WGm2r+Ns
CP4xiGXjT80GUwPb6MXZN4m/QMWkqCqdeZts5q3s1h4gw+LVEFz8VPjPl+fXr794v/IFsd6u
J4MzoO+vT4wDuX+c/HK5uv3VEn1r2MvjaivHRYgVV43y7BhrEZcktU63Vh3hjbI7o4LEy3Dt
HLoiBotzWoNQWqJN17w/f/miLbHqJZe5zsi7L8Pdj4aVbKnZlY0DzZvEKp7EdmlUN+s0wlV/
jRU10sAY46p1lCRiquEdae4d8OBzH89eXlsil3nPb2c4g/6YnEXLXgZf0Z//en45s7+EVjb5
BTrg/PDOlLZf8fbnZ22UCK+BeFHiiHWFc5GUXFVUEHtCSpRt05P07narV9zk0zncx5Y1df8o
jlOI/Mj28A1+e0DYvwVZRwW2XUmTKO6YwIQLYBrX6q0sh5D370BHUqqbWPdVAgQIN74IvdBG
DFULSLu4Kek9TpR++f71fn6c/utSGGBhcFPuXGUyXtMDqbhj2qFUbBlh8ixjPWkKGrCyNWID
GTi2OSML+MxyFIDjhjswld61JO0cjsF4Beo7+ex9tLSAQlsKvGS2o8lpiO4nT0LReh18Tinq
XX9kScvPKzvVaH0MsdwSCp4fXfQuZlOvVc1qVVw1ptfp3SFpUGxhRL8YkN19HgZoGEbJkUfH
xcoIGXCBwDeis+9HnhXqkv3CYQXck5jl7N/EaRDP1GNBCRCaeb4a7U0HfOcn6rWNRI6MHtjk
Kt4M71MwYLpwIbPFDKsrx652BecIkWTzuddoQRk0Oj4m1p9m/t4mDw7wsQJKz/lX+5uyrctq
ii0LkmOTw+NmO+eazRMPpwehh/P7SLekOdvzIROrvmN0ZETUELcCaVQa5AgxYZMzlMKGVsQt
bBAfD8D/8Pp0W0gldObP0AkrEBG4/WpHsMHie46XwFqTrPSDP/2mXi+llUCcl27RP0geP8R9
0iksAfogS2UIkA4CqRYG3SbKSXaPtxUwXE95Ea4cny59R3BdlWf+EzzhrTIs546u9ufoQ/CR
QQbmtT+1QkshDLgYos3eWzaRI8TKKFjC5ka3AgvqJkJlCJAFM6f5wp8jAnr9aa4H+JGjuAri
KSIgYHCjgkxst2/NHmc4nYHl833xKa/k1D69/sY0/uuzGl4cFLr75FEoNuyvqSOs4tgyIo7R
dflb3F2fkfVypp+JjG+vaP/6wTayV6ugGOLCVuzS6AmEtJammGOmF6p9ZcvzBZMfK2oGeD0V
LuW09C/x9XZRUaTq6zRAwaOVTlHdF8ExZx2xwbVN1DDxyaGLjgS41dAI4LpMYxOHIYTRForq
VcU78+6xyo5AQnuAe4LeQSJdvs2xDeSFQythwsPGazevA9VmM0yFGDl1lWfA4BPUqpu2nVYS
yhR5QRi7Ln557l/P2tIQ0fsi7hqrGS79MqjrVmd3dcTNq2Xq63ajWO/KQkDqcKev1pIeOB27
VRDpaNmx32wMZxsohzlaAdulkcOK3CjUOLbaI2IKs0vm8yV6Bb2nbKYrmoj43fGt5PSf2TI0
AGnPO1DjTbSFVXWubBovNNaKTfq7Px2Hbg59EhMymBDJ0jXeYq8Fbo5q7v+YbdjTTCWznxL8
fWqQ65J3RaBMAA6Iw/4uZ5tvPM4CWAbxNy8Zm6Xa+wcVwTUchcN6nqSWQmkd8cWF0Gr36OCf
QXVhCIQKpN02LUj9SQcStju+AJc7KgZF+MUWQ2haxyWdmR/wqAK223yFo0ibo1GwutXuixkp
3yx0zwUgKK/4YwZYPycRFDhBbS0Rzd2zfZz+Ok92P97699/uJl++9x9n7C3D7r5K6zt06txK
RZZtW6f3mrvRgdClVHUS0URbEZZH9nAJ70C1ccQpTpfbIyzO07hMIJ/Tbr9mc2ceXmFj+1WV
c2plmRMaY61v8hEa/QwbDBJ3X45M4PxV8pnt0sVrpvFR7k/YwhjAZExMkcYrAP3UgTMX1Kpc
Z0tI6c+dCWXRuopvJZPDVLSL+KmN4IEj5FJhOLfIGatuDYFmFXrY4f8lX5YAhPzGEk5Uo02N
DBaOSHYC5J5krnXrXb4Pp6gjjYEh9FUnGhdigBI73RH6gOzF/4ZDdKT/rTRZozSqkLyQ67Id
QmIpumUWeisfv1JloMshex0uPd+WOISUk4/zYE8/aqIilNvjY//Sv5++9We5JZUx23REcL8+
vJy+gIn20/OX5/PDCxyAs+Ssb6/xqSlJ+M/n356e33sRb9pIUyoFSbOceQtUGP5kaiK5h7eH
R8b2+thfqciY6dILMJWDAcu5OGKTXiBupiv0MF4w9p+A6Y/X89/9x7PWfE4e8SajP//n9P6V
V/rH//Xv/zUh3976J55xrNZiLGqwGm6/h/R/MoVhgJzZgGFf9u9ffkz4YIBhRGK9mdJlaLp8
HMeRKwFxIN5/nF7gzu/moLrFOT7yQ0b7uBPhUYD41bB0U/Hw9fsbpPMBrxM+3vr+8W/NnSrO
oejKYukUER+tqRe9Pr2fnp90hX6Xo4ZsxqN69pNfNjD1CDRox8AXydvFWZdRjdslsY1bxzZt
S3/uCIglfaZfMT/c0g4ctkLERNz2qSCs6LSK8ItQcbvZxdm+O2bFEf44fHYUN8dfzkg1xrDh
lGQoWV3mNqA9QZVEI+jZSC63GLGs1losFokYzgckWXOcIomK0b1Z8pok2zQZbMYvLT7Ajvef
EtYcVY0FO+RYUhDMBO9dyaC/0Rse9Hx87c9YmFADkYU4kgyOBCiPxqgWY0PSLOHG4PqNpdyr
VbGv+aIbCMbGXVK1iksiYsh84KZ96wh3MNIe8IX1U4buugqwZ08h4lK305zb7SojwMmIHMPF
+LARiyArN1y5uChVE8034HSlBNNadAfIxns6pq0qdRxh32VRpbnxHoEKzO61E4ARatY57koE
KYmO7dfcacINNwx5mmVRUR7HgmNVy/Zwc8lm3r5Vir+DGCYgQ6o6ZZIm1ZSrQb5IQT+ECIhf
To9fRdw3WAFVsQwJ7WiyvyWw5PUargAqXKt5GGBFEpdwhnIpMUoC3A2twRN4aNIM8ubupFET
M51F9RCoIHESp8vpwokZId1UlIpZi1nBqlmPscBtbHQM68gCN9FSGO5ivCfWTL0Lj0cU25Aj
G7x5PmzspZaHjyNl5h9oRQpW4r0lOsVH9PT9/bG3T4RZnrSOO8I2H8opEqOmd41J5T+hWfYa
5zpLRs7LBANzV3iL2FWkWczXqB6BFk2mDNZ761JppVF+5TstqEoVY4JJnhRrSQxpWh72CeuA
1hk3u+6/nc792/vpETlRT8GbBlhGqP2FfCFSevv28QW9iatyOhwcb/nzL0b4f9aeZblxXNf9
fEWqV+dUzdyx/Iq9mIUsybbaekWSHScblTtxd1yTxCnHOTM9X38BUpRACnT3uXUXXR0DEN8E
ARIPXtcShPKihx1TvYrmpgWzydUJeOoEJx+vj7cg8ZN7+1aaU9TyxrwzIEXqXf2r+P5+3r9c
pbAsnw5v/0YR9eHw9fBALKWlLPoCShKAMfsH7bmSJRm0/A5l3kfrZ12sTKF5Ou4eH44vtu9Y
vFRwttnvbU6Sm+MpvLEV8iNSacj1P/HWVkAHJ5A3H7tnaJq17Sy+nWEPVH01vdvD8+H1b6Og
VjTC9Agbb02XLPdFo4381HyTHSlkjHke3HDWWNvSEyqHaGjw9xl0HBVgwDfbKolB0/NUJsLW
RKtGbbP+hDMuqfHzwoUjkRwvNdy0z6vB9RNRUg6GU+6wrcngoHWGo+vrTrGAGAzo5U4Nz8pk
5Iy6zcjLyfR64HbgRTwa0VfSGqycNQlLAwZEDYxCioQftT8jBwOBlAWjmX+aoGOE8dlKpDbX
HmIQXNvtodDF1CX/pP5t5JsOqai1QGf7hqRPSQoVK0b/EsBtifwVkzoX/G00oEGwa4Auygsg
tUiqATrVLHYdurTg97DX+W1+48E6ECaNEQ/V6X23T6vw3QEVV0DVyP2eZnQlQVycY4FxtLd0
8hAs6x5wBpRihEtFgWqVMfpl23ITv9oW/tT4aUZQX229zyunx6bmiL1Bn9oZxbF7PaQbrAaY
ZSLYCOJKcZMhmzEYMNPRyDG0vRpqAohoFG89mOmRBhhrl7xFuZoMnL4OmLl1JO7/++1nsz6v
e1Mn18RhgPWnvJ0XoMa9cRViIjp8FnSjKODvXIByOuWvbJD19jDzIq+OSc5sopXc6IGq2nMQ
qy1ed4r7YJHZCvWjpG8pMkhkQitgEGXgGaEFllsjXHQr+yUuJv/my4xKrz+81pIaCBBrCyQw
1GsbT4kBNSBE/WxM92/sZYMhNWOMg6S6d+Sw0VoTd3096XFLVgiNG1e6DWpJWAWmyOKwCl3q
id3CNxY4gOnS9cUBHKe+6XdSlDGMt1ZIKb7uTRwTVsAGH+mwGI7KrdnT2nQRxsqyBIBgjAT2
RbKZj52eZUY3YYZJwzA2stbuWiraqtb8t28K89Px9XwVvD6STYm8MQ8Kz63tHPQyyRe1oPz2
DAJVRz5uoFJEf9q/iJgL0s6HsoAycuHkXLZB9ZrDJRjrxxT+1o8ZzysmdGGG7o3OA0HvuO5p
kcYxLmourosXmW5qWmQFm5hmcz+ZahkBO52RVkyHR2XFhLfqUvn9RYvjXJ9ZUmjQV72BbsWC
NuweWz6dtLioi1BXm1LtKTL1XdOmVkbuII0TUi+Qx9VDXj/ZyPUGS28nFwzP90c9aswEvwd0
ruH3cDjWfo+mfXSAKQIDqgcEBtB4OrZEn/eztAReTcWUYijzLig+Nu4PaK4q4HwjR2eNo0lf
54TD677OIKCG0Yima5IbW1ZM3q0uDFTzEvn48fLyvVZt9B1ax0MXsSC0SwEDVwWbICm5a9MO
ZSMHa89DWhNEw+YYkmr/+vC9eW37B13KfL/4PYsipUHLa5IFvmXtzsfT7/7h/Xw6fPnAh0a6
BC/SSYPgp937/rcIyEB3jo7Ht6t/QT3/vvratOOdtIOW/d9+qb77QQ+1lf7t++n4/nB828PY
Kt7WzMYsXjhsTP751i36IEzQbdXCTLGQcIfFXZ4a8m4rIWbrQW9kyxVU71pZACsOCxQjDYfl
YqA8MY3l2+29ZIb73fP5iXB7BT2dr/LdeX8VH18PZ/0gmAfDoR5WCNXSnu1xoEb22fsktiaC
pI2TTft4OTwezt/JJKp2xf0BFQH8ZelootXSR6mQFza1mLIYVsHiCbYsi77FBXlZrvtsQojw
WpPd8Xdfm6NOnyRbgY12RnfQl/3u/eO0f9nDef4BY2Qs3NDpZp1q36O2aTG57tmW2ire0gyO
YbLBtTkWa1PT9CmCOWGiIh77xdYGb7aJYlf2rknXz8O3pzO3TdF8t3Ijjku6/meYQk19df31
1pFjrSDRALPbEEDmF9MB1aoFZEp9vmdLR8vFgr/pIejFg75DnU8QoDtmAGTAeqZ76Ho/MkjH
4xG/xBZZ382gQ26vxyULaGSAIupPe1oiTQ1DHVwExKEnI1Xao07yiBqT5Sm/kT4XrtNnDany
LO+N+noGt7pZMpYBq/PkmsVVtAFOMqTGXcBdgBvRCawhmsdGkroOnykrzUqYfq1VGfSg30Mo
28MidJwB79aOqCHv6wH6+GBgMd2HjbLehEWfa1/pFYOhQ0QfAdD99NQwljCXI0uQP4Fjne0R
c00vowAwHNEkRuti5Ez6xMRg4yWRPugSMtBW8iaIhSrFieoCRZ/lNtFYu+y6h4mBWdCCwuls
Qdqd7r697s/yRoM5ElZ6TiHxm17OrXrTKeUY9UVZ7C4SFqgzP4AAv+mxWwepgzKNgzLIKxok
LY69wahPs/vUvFKUz5/3qmoTrSZ+GXujyXBgRRipvmpkHsOC7NngJs9mR1rOwcfz+fD2vP/b
eHUSqs56y5772jf1cffwfHi1zSRVuxIPdGk6shyDkte4VZ6WrpmPmxxDTJWiMSruwNVvaHX1
+ghy/+tel+uXuQgzwF81i9hL+TorNQWREJRoO4BWN4rAJgei3zSnZfIt1ATet+MZztUDNYNs
ta/+Ncej/cLR3BxRjxpqihboUdrJggCNWZRZhNIeJ4MaDWIbC50503APcTZ1erxIq38iNZDT
/h0FCoYVzLLeuBdrFqmzODPC/5GLwCUwKO622s9AyOD3vEoKRCxmejw3BmXOcUYWoQyQwFbo
bW8x0q/1xG+DFwGMJpirOYeRp4hC9e/L0bA30Nve74255t1nLkg3ROmvASbD6MxFK9q9ohkj
Fe8og9eQ9awe/z68oICMfrGPh3dpkNqZYyHL6PJC6Ls55joIqg1dxTOnT1d1Zpoqz9ES1lRZ
FJvM53zm3S3UrV9UASX3driJRoOo15GKf9DN/1/LUsnm9i9vqM3rO4Zjp2UQc7YucbSd9sZU
PJEQOrhlnPX0NyQBuWZFkbuCTp/43fc1vsc0WZEnJY1PVs5gU2jeHggKfc7wEjEypFxJM7Ai
GNdGllI3EoSWaRoZdEE+79TeMQUR32LUFNMURC2NOKDZ7uDn1ex0ePy25yLEIbHnTh1vO+SX
KhKUIJQO2VUIyLm7CrS6jrvTY/edfBOHSA1az4hS257VkRbjBZENdhtrP+S5poPQoXJeGnQi
htjAhBVFF2I6NbZwuw0e0oioW5OR+al4e7B8Ut5Gev0AqFNySVEmv7l6eDq8dfPFAAatlqhC
Ws1DTaT00a5I+Y0pQcUskAgTGYZu52MrA5cPSnz2LvM0iuh8SMws9+ICFqR8RDCx0lZhoYWw
lhhM5NuJLCU59fLuqvj48i6MOdpu1+5reshoAqziEPR637AOnnlxtUoTV0S/RjJ2jePntc80
7Mo8DxJuX1EqX2sGxRQhSG2ujsNlGcbbSXxTxz/Uao7DLQxS03xrC7OtW/UnSSwic1va19Bg
f40GwirN9PiLonY3y5ZpElSxH4/H+uGD+NQLohTv/3OfN8gFmjqdFlOpXABBHOunlDbFDT2a
iXs0fYT8OnezyHjubhGaUOxHaA/2OfC46YupLQn8MAJVAiDKmoeUbH/CsBTi8HyRl4qaH6Lq
yAWyZie4etTdoaqjdYFQGznx85Sa4deAahYmsKVhn3o2HGWExlfKW/7TlwMG6fr16a/6j/+8
Psq/Ptnra/yX6fR1nSt8l/MvUwGe6E+Ta9dAfNItfLcJB7W8vTqfdg9CjDMZYEEZPPzAi6Qy
xfciPQBYi8LIVdySQAr1qEJARbrOYScDpDASShDs5VBucoGawX7VXW23c6p6dB6hFdY2ohlO
hi2LC35TxYtcEXsbsoUEUrpO0BNDEM7zILgPOtj6nTnDpeOl60zj+qK8PFiE9EEznfNwAfTn
URdSzWlMBwrFnlgwTUPbq2mKlrXbBgip3PmaKVrjA3Nd3IOfKvtXlfB5B5FE5r4z7N4IQubZ
0kqtMa5ILMjfuwNVYWRo1ZGzAM3dOCE4aEQy+JOz1KTghgHHVZpp7hpFaLmiLaIw5gUGcW0B
fyfAhdux8DC7pbaOYCfdrF3fD/SXUl0clE+QB3QvE2cFjd3hud4yqG7T3K+j75GLQBeVNlDY
5gWaDmliJILSItzCR2RdBlsUpvX42gpWzdCgHIaG6y6GJRAG55qXeAycFO1Q7ix4jNmeePld
Vur7hYJhly4KfdVUG5B2Si5F5bxI0jKcE0bmm4BQApRU3RbrSgRnuLNOS40dCQB69wgLcDHV
aJ/FiQUYO7ymv3XzxNCOJcLmMy+xZR5om/1mHpfVhnsekxgieogCvFKTDjBx3bwYVnP25Ucg
tRwH8zXmW6buQms9LXMdy4AtL4WZitw77fsWhvlswxw2SOXTNNUcgRvdunB6zUH4Tm9ZUjyr
tywmDmAQ0uxOsQJv9/BEw9/MC7GH6PqTm6oo3dJYehKxDIsyXeQupwgpGhXpsfNxOkPJrDKT
ExJHYdE8KX+97z8ej1dfYet3dj66Mhj5CgRoZTkfBRKVjZKqXAjMMKNKnCahZjImUKBiRT4o
AuYXmPsT00niENHoEasgT+hkG2IOaIJ6iwWg5UT8e4ug2bplyaZVXS9gH85oLTVI9Iswo0A6
yAVuqbmC4X9qzbcSbXfgm3Iw3ITIciOcb+nKzjEKS1uWYqCClVWWoJ2f5/Oiz++e9Sw0NqOC
VK6/wdxMvshAkDME0b2erlDB722xAVqKomRTSQi8izf1TFpT9bGYJbbiIvDWFq7d9mpdLkHp
DL1OBnEPNhs7RnkaG2MkIehViHbud3UgYg2J5v8U2vVvlBCMQxLhASpGGc5WbltJShjvhsos
GJDDi8ilR9FmIybDPtsAkw4n7idaeqEhbRdUBBamObQziuxSs/T+cV/w7Wua8On5n+OnDpFS
SnQ4Ol11gLlL1a+gBGFpxe/gxFhL+JseqOK3drcvISbvosjhHy8G+bCyxPRM07Ky5TCRTRNH
iBWPR7XMPANyD7cEFBGyaVDMgEjvmx8W7gwktbWfccGWgYRjDXASonE6CGUpDYEO0p75E0dD
q9C0CS3WSU7Ve/m7WsByJaNYQ+1ZybwgW/I81QNWQ4vC3/KgZyPWCJ6HMgfIF4KDqQHWmBNS
3QYueppigmU+t42gWmceFGfH2045geyIFC2Uv7Ru8ajfZzDtd5bQR4LwJ9p3aQV6qe/aTjlX
fMuiphk/UwkNOAg/Wn5weD9OJqPpb84niobqAyHJDMXjXbtoKe56wD2W6CTUrEHDTEY9a8ET
S44Ig4izSzFIrm21jy/UPuY5ikHELXGDZGCtfWjFjC60i3PNM0imloKng7ENc2EippYsKzrR
cPoT43XNvU0iSVikuACriaV9Tv9CAwHJKW9II+IG6mWqqhwe3OfBAx48NBulELZlqfBjvrxr
Hjy1dGFgq9750UA7nSW2SsNJxXHKBrnWW4HBOkH6cxOzJBHsM4hK9jGhJQAlf01znzWYPAVp
leZrbTB3eRhF9ElKYRZuwMNB1V91waGHCWF9BpGsw9LSzZDvabnOVyEbwxEp1uVcizzhR2wm
tiTE1ayJ+RJUJWkeu1F4LwT45tac1XO1+yzptrF/+Djho30nCikeXFTJvMOrgZs1Jo9Vunsr
dgZ5Abo1TBgS5mGy4M+dWV0Sd2+Yr6EAX1XbanLyVqrGsKUCovKXVQqtEGPAFa9UIYxtWYiX
wDIPPU3S4rSlDtJyoM5BasMbLnlDz973Q9M8cQOGieSXQZTRq0EWjSlBln98+v39y+H194/3
/QkTdf/2tH9+Iw8nKmxj20HqeRIVMcjyx4c/H49/vf76ffey+/X5uHt8O7z++r77uocGHh5/
xeQX33AR/Prl7esnuS5W+9Pr/vnqaXd63AuTlnZ9/NJmg7s6vB7QEvrwz672t6jrDZMQE8fi
426SJtpaEShxxwjiqSXZS4cY3wustMooj2+SQtt71HgpmXuhkQRxBabNXdbp+9v5ePVwPO2v
jqcrOR8kaIggxitUlwZr1sD9LjxwfRbYJS1Wnsi1bkV0P1nK3HVdYJc010KONjCWkGisRsOt
LXFtjV9lWZd6lWXdElBZ7ZIC+3UXTLk1XLdnlygzKRT7YaOfqVDKOtVi7vQn8TrqIJJ1xAO5
lmTif3tbxH/M+hB3Nx5ToHkCGAsljLuFLaI1Pi0KxrMVqUrkdejHl+fDw29/7r9fPYiF/+20
e3v63lnvuRGcU0J97tSrcYHndRoReH53oQZe7hduBwz8bhP0RyNnqtrqfpyf0KbyYXfeP14F
r6LBGHDyr8P56cp9fz8+HATK3513nR54XgxaqjEoXtytdwnHn9vvZWl0h2b5zLZdhJgTortB
gxuRXtzs3tIFPrdRvZgJTzXk9e/dNs642fbmbOzTGll2N4XHrOSAGinUsCi/ZapLL1WXySbq
wC1TH5zat7nb3d/J0j6wPkhY5bo7JZgAqxm/5e79yTZ8GE/enOOlFmRetZjrxkZSKsvf/fu5
W0PuDfrsHAlEN2YQS3eJEwAaBjmSPMf8eru134VIilnkroI+fx+tkbA3OU0jSqfn03jiar+w
J411QmN/2JmO2B9pl0U1NIRdImyVbOHtJBeKfdh4P6KwRL5oKfojPvFHSzHoc44hap8vXae7
+YFnjMYceOQwh/zSHXSBMQPDt8pZ2j20y0XuTLnD5jYbOd10OJ7I5N7dMm7Q3boAk+GUuuAk
lEu8i0zWs5ApKveGTBtnUXo7Dy+vZEzOB7oel4GhoUBlpZO2kWA5JZygx8xnhi2aiZ7/4Chf
Ld1712fKLdyocC+tKnXuMMdK0D3OQbbJZGpDFl4VRdCvRhNmQcbD7loKusdveZviDNng9nFX
BCM9YOMvdUzINzS8V87b5tCLpyH7EBkvcDV0wmYUbj7pdlc8nzAFmc900qZ99/p4fLlKPl6+
7E/KwVxThpodUISVl3ECtp/PRHSTNY+pT6jOcAjcD/i9IPL4C+6WolPv5xCzUQZoe5vdMXWj
7FyBJvPD+htCpZ38FDEM0k/RoYZk7xm2DbNfmqrb8+HLaQeq4un4cT68MnJCFM5YxifgkmN1
EfWxqSyDL9GwOLm/yedmr1uiC8sZaRrB+GJbNPm5iwY+1zmbEa4Oc5D4w/vgD+cSyaXqiVBg
72grZV/ucnO4mkUtbzmTm+IujgO8ABJ3R+VdRi0UW2S2nkU1TbGeWcnKLOZptqPetPICvBrC
9/WgtQhrb85WXjFBk6UN4rEUScPdkNXVmGZlWMS1ykNjwaI+iB+TG6dwkWBI60DaiaF517w1
ApC7Bd3cvwpt6l3kf34/fHuVvisPT/uHPw+v34hprAyLTq7xcs3urIsv/vhE8rjW+GBboh1p
O2a227g08d38zqyPu3mTBcPOw5jHRWltWksh+Ab+JVuojIR+YjhUkbMwwdYJU7S5Gs+oy3ba
deAKOz2m/bMQJDxM+0EWlnI+AOEv8bK7ap6nseGzQkmiILFgMVr2ugzps59CzcPEx8DzMB6z
ULOnzH26peWdK3XAaFwjvBCDx1IdT6EMsLBrglGvMN9IBapNGWZRqN/meKCgw6GkgRxjy8Ne
FHoJyyyg1nJd6QUM+sZP3epcxwAvCGZ3Nu2CkLAhnSWBm99KWyjjSxhiW7ljS3GG3Oxxr6zA
GxuNtKXU3htyN/HTmPScKQYtmPAgjTQ7Lt7+BqFovd2FcwY5HUscQs2Vsr2vfOrjJn/XF1ZN
n2qocOvIuDemmiCUue7M71zW3apFlst1PGO+w+QKF2qbeZ87DTcSxTU9rhb31NGKIGaA6LOY
6F5LqtcitvcW+tQCH3Z3rLiu1wPcgeLpV0UapZo5CYXi683EgoIKL6AcopjMPKJlbN08d+8k
j6CncZF6IXCiTVAJghaFbAXYDXUHkSCRCk5jQwjX0gEmolUygR8w0UW5pLMuMjJm9vxbxSKS
w0Y23zLwVuLsdcu1Ed4/W8duscJcceLhhNv02brKtRb7N5TvRulM/0W5mepSVJsLqjKj+6p0
aazb/AZlM1JunIVa9nb4MafpltFvBz0g4KjRxh3mQq2ejV+k3TW1CEq0bUznvst41uE3FWXQ
GkIYRVJbqnmKWq1pJSmgk7/pchIgtLqGwdE8BZR1rbe6dSPyJoxPhcmC9UfqHOn645mSkQT0
7XR4Pf8pvaNf9u/fuk+uQlxYqayjxMRYgNFKiH+wkIZ5mBslAkkhap5lrq0UN+swKP8YNjNc
C4+dEobk7RYt5eqmiGyN7Hnl3yVuHDJ2Yo2sFc9SFKqDPAdKmu5T2EzBvw2GoPzfyq6st20j
CP8VP7ZAa0hJELQPfqApSmItHuFhpU+C4wiG0doxLLnwz+98M7vkHkPZeUq8O1qSu3PvHK1X
FHJy6wanwf2/+9+P9w9GFTsw6K2MP8cbLc8ylmE0hhD4Ps08J40z25JqogtrB2ixTZrlp7eg
Lju958lqQaSbNnmtVtTLSr6QKnp4t8BQHNxuaE856+FiPvvgnB5wuCY2iSy4YqJ7LtnSvDBB
aUHfGZJ7EfRPJOKyh6omhEW3wLzc5KWnWcunkrbOoQlF3hZJ5zLzcIbffFeVfq9rWWVZIfdN
Qv5QnrsOWrGN3SDehwyMOuyuub+1FLvYf3u54y5V+ePh+PzyYDq/WjJJVjnH87sNM53B4YZa
Tuhi9jofv8KFi9s4+Z/aBmyUOdMVYYW7LfhbM26tLt1ftklJGmeZdzgd78x4LvjzFOiuxNU1
ia1CfIpjogAMSwZRT+Nd++t/vMTJhjiEDABrR5mL/mExh4GCiZEJieqrrk4ia2DWyuMAuYYp
S1wng6zxlGpbTviyeLqu8rYq8wk31vhQojrNWhGAplokyEbyBPhgXXWIL3UMff47yFY2g7yc
i1WyvqTFtPF2mImJYCIVFBEa7wDjqkM6//EBETA+uTEWqEl75kvTX0CsAlqTSQJ8c0H/9Efn
FlOhwU9SJTfEhcLNfGscyTCEFtVmJ36zz7PZLHzrAfaNTR/ghpCY5TQWDcDQeUisJBFhSKBO
3yZ+imtLwmVhJrNyIbJm8jHXRbjsdcE3pn6i1zDVXCqD9YpszJWbUW65mQGR9ujRL/Vhaf/A
QUQRLxARAv0/Iot1vloH9sJw+rwbSHRbSlJccDDetKaqpfwxVwl4auQdlWFe42IeBTaN/C56
6holNsKLCYY/q348HX47Q23alyeRhOubx7vA91QSPyExXOmJpt48Mlz7zOuSDRco1PjeaZ6N
1IO+dqvNW6Sqlt3kJHRMFNwvXDB+wntgzKs5RNssgkcFdW4UCO1BDtjky4Qww8s4Z4Un7NYo
V9GRpafs9PYLaUCkBy2qlav+nj5JieMkVef7C/QbRSwKIdtUBm/Q14F5bEzBtHFxytohCgIB
rrKs1n2YhuZIRBR1N7hDEeYyagS/HJ7uHxH6Qh/58HLcv+7pP/vj7fn5+a9ORTXkQ/Ny3FIz
svfqhqgvznrmn+HDQlqHC6Dvsq9ZxAVsz7CIqejg263M7FqifA7cDJ+0bb28JxnlFwucBJy2
k9UxdzETkxuM7oTQMTdZVmsPwo7xVZwR622wQYT+8EpEZZ/GbzsVXPwz52kf23EaE3GvgO0z
D+RJ7z1gHdBm7foSd96EvuK8PCUpRbJPMMd/RC39fnO8OYM+egtvfmQn8k1ArDKG2cQ+9kRW
EKe6517nctY8yh0reaS3oeKizcH0KH/iNf31U7JakcgpVW/lajrtVS2ZaaRJ/UZxdjDKkrZH
5SOHNRrpB+CpEc5gwv2JsiJAIIPZnhxEyId5sEijp/ljLvviZmjZ0nHeV4fHRixWLMlGsSGt
lKaXWhNj34hE52RUrkKledhpukz/9pp48vX0iMIxlyq5ciZNOeKGlYxlX4pFfHp21ST1Woex
DpilpZ7pyd0279bw3IXmpgZmigLACRWCG7CClWxaDzdEAQhy4PmQAUm2UdmFi6Tmh7LKOClr
pz4nZn9c2E+LOxAwvMf6cXRkEpoCedGmGaEEr6f6ctF6ZkDL1VxGuOqRV74gs3Gd5vOPf35i
5zEUU/1+M0G/BLVaxKgPc/mi3ORKjuXbXv/4rBG9z2ljlEQTXON5Y62m9+RPljQbc52pd2M1
xKXVYlpUPdlUQaC40Ro2l8tN7wYRMS6gw2dIOeNdC70oLitQJuqkfZpX4qfczb5OlEl1IDK1
tZed7/kf9y2GKaQ3TEoB8ZlCP/SM7LRWCpAEW4nQGy1x3wiTIld8+7I17EGqnVCiukcWBZSD
OJ21L7dScUs8h4z9qp08AK56mzJv+K2PcK4DvNsfjlAFoKumP/7bP9/c7V3D46qfIgArLOEm
5qLJf4mnUE++YRNYhfHNLrKu0urakELtuYEaYjq4UcCGSuv4slcWIpILrwBOfmuUfCI3Av8D
YRzYo7r6AQA=

--ZPt4rx8FFjLCG7dd--
