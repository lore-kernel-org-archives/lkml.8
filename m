Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF85120776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgE2WJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:09:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:4430 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgE2WJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:09:19 -0400
IronPort-SDR: qsmP3TFKrt6mUaNlaGGDVjjvo9hE4D7aDVx0WG0PHMmHfcSubIxoXSvyWhfAd9+Kzli+UATWCw
 nojp360+3JSA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 15:09:06 -0700
IronPort-SDR: LMeTvwgpoe2f06ETWl7a91WXecthzgV16kIznhz4VBN6qIQ5nHUwr4fCwpNGyGrVs4sDzb2rNp
 XSvI4UWkpbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,450,1583222400"; 
   d="gz'50?scan'50,208,50";a="285670942"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 May 2020 15:09:03 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jenBW-0000Tp-SZ; Fri, 29 May 2020 22:09:02 +0000
Date:   Sat, 30 May 2020 06:08:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Colin, Ian, King," <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/gadget.c:1188:29: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202005300615.M9n2mKaR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   75caf310d16cc5e2f851c048cd597f5437013368
commit: 70d8b9e5e63d212019ba3f6823c8ec3d2df87645 usb: cdns3: make signed 1 bit bitfields unsigned
date:   9 weeks ago
config: i386-randconfig-s031-20200529 (attached as .config)
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
   drivers/usb/cdns3/gadget.c:1157:35: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1157:35: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1173:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] buffer @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:1173:29: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1173:29: sparse:     got unsigned long
>> drivers/usb/cdns3/gadget.c:1188:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
   drivers/usb/cdns3/gadget.c:1188:29: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/gadget.c:1188:29: sparse:     got unsigned long
   drivers/usb/cdns3/gadget.c:1191:37: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1191:37: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1191:37: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1213:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int [assigned] [usertype] control @@
   drivers/usb/cdns3/gadget.c:1213:38: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1213:38: sparse:     got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int [assigned] [usertype] control @@
   drivers/usb/cdns3/gadget.c:1215:48: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse:     got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1229:30: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1255:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1255:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int @@
   drivers/usb/cdns3/gadget.c:1255:30: sparse:     expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1255:30: sparse:     got unsigned int
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
   drivers/usb/cdns3/ep0.c:40:37: sparse:     expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/ep0.c:40:37: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:41:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] length @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:41:37: sparse:     expected restricted __le32 [usertype] length
   drivers/usb/cdns3/ep0.c:41:37: sparse:     got unsigned long
   drivers/usb/cdns3/ep0.c:44:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned long @@
   drivers/usb/cdns3/ep0.c:44:46: sparse:     expected restricted __le32 [usertype] control
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
   drivers/usb/cdns3/ep0.c:267:52: sparse:     expected unsigned char [usertype] ep_addr
   drivers/usb/cdns3/ep0.c:267:52: sparse:     got restricted __le16 [usertype] wIndex
>> drivers/usb/cdns3/ep0.c:271:47: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] ep @@     got restricted __le16 [usertype] wIndex @@
   drivers/usb/cdns3/ep0.c:271:47: sparse:     expected unsigned int [usertype] ep
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
   drivers/usb/cdns3/ep0.c:478:31: sparse:     expected unsigned short [usertype] isoch_delay
   drivers/usb/cdns3/ep0.c:478:31: sparse:     got restricted __le16 [usertype] wValue

vim +1188 drivers/usb/cdns3/gadget.c

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
7733f6c32e36ff Pawel Laszczak 2019-08-26  1157  		link_trb->control = ((priv_ep->pcs) ? TRB_CYCLE : 0) |
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
7733f6c32e36ff Pawel Laszczak 2019-08-26  1173  		trb->buffer = TRB_BUFFER(request->num_sgs == 0
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
7733f6c32e36ff Pawel Laszczak 2019-08-26  1191  			trb->length |= TRB_TDL_SS_SIZE(td_size);
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
7733f6c32e36ff Pawel Laszczak 2019-08-26  1213  			trb->control = control;
7733f6c32e36ff Pawel Laszczak 2019-08-26  1214  		else
7733f6c32e36ff Pawel Laszczak 2019-08-26  1215  			priv_req->trb->control = control;
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
7733f6c32e36ff Pawel Laszczak 2019-08-26  1255  		trb->control =  trb->control ^ 1;
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

:::::: The code at line 1188 was first introduced by commit
:::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence USB3 DRD Driver

:::::: TO: Pawel Laszczak <pawell@cadence.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICF6C0V4AAy5jb25maWcAlDzbctw2su/5iinnJXmIo5sV55zSAwiCM8gQBA2Qoxm9sBR5
7KjWknxG0m7896cbIEgABMfZra1Yg27cGn1Hgz/+8OOCvL48Pdy+3N/dfvnybfF5/7g/3L7s
Py4+3X/Z/+8il4tKNguW8+YtIJf3j69//3p//v5y8e7t5duTXw53vy3W+8Pj/suCPj1+uv/8
Cr3vnx5/+PEH+P+P0PjwFQY6/M/i893dL78vfsr3f97fPi5+f3sOvU/Pf7Z/AS6VVcGXHaUd
192S0qtvrgl+dBumNJfV1e8n5ycnA25JquUAOvGGoKTqSl6tx0GgcUV0R7TolrKRSQCvoA+b
gK6JqjpBdhnr2opXvOGk5Dcs9xBlpRvV0kYqPbZy9aG7lspbRNbyMm+4YF1DspJ1WqpmhDYr
xUgOqygk/AdQNHY1ZFyaY/myeN6/vH4diYWL6Vi16Yhawn4Fb67Oz5Dqblmi5jBNw3SzuH9e
PD694AiudykpKR313rxJNXek9Wll1t9pUjYe/opsWLdmqmJlt7zh9YjuQzKAnKVB5Y0gacj2
Zq6HnANcjIBwTQNV/AX5VIkRcFnH4Nub473lcfBF4kRyVpC2bLqV1E1FBLt689Pj0+P+54HW
+pp49NU7veE1nTTgv7Qpx/Zaar7txIeWtSzdOnYZuUdJrTvBhFS7jjQNoavEklvNSp75/UgL
yiKBac6JKLqyGDghKUvH4SAsi+fXP5+/Pb/sH0YOX7KKKU6NLNVKZt7yfZBeyes0hBUFow3H
qYsCpFivp3g1q3JeGYFNDyL4UpEGxSQJpiuf67Ell4LwKmzTXKSQuhVnCsmym5mbNAqOCUgF
cgkKJo2lmGZqY9bYCZmzcKZCKsryXsHATj2OqYnSbH7nOcvaZaHN+e4fPy6ePkUnNepiSdda
tjARKMyGrnLpTWOO3UfJSUOOgFGxeerVg2xA90Jn1pVENx3d0TLBEkbFbkYOi8BmPLZhVaOP
ArtMSZJTmOg4moBTJPkfbRJPSN21NS7ZsXpz/7A/PKe4fXUDvKi4zDn1JaqSCOF5yZIqxYCT
kBVfrpA1DEGUDnH645ysZuxeK8ZE3cAEVXpmh7CRZVs1RO0SYt/jeGqn70Ql9Jk0WyGzvkPd
/trcPv9r8QJLXNzCcp9fbl+eF7d3d0+vjy/3j59HyjWcrjvo0BFqxrVMPiwUWdkwxQhObijT
OaoZykDzAWqTRELDrBvS6NRuNffnhZ+DUs+5RqOfJ0/hH+x1kAbYJdeyJD6tFG0XespQDRC1
A9iU+kEj/OjYFljPOw8dYJiBoiYkw3QcoExZoushfHWJkIqBDtJsSbOS+6KCsIJUsjXey6Sx
Kxkprk4vR6oiLJNSp4/HTCVphoRK0jqk1aAn1/YPT3OuB5pJ6jevQIuCOF09jC4T+kYFmCFe
NFdnJ347HpcgWw9+ejYeBq+aNThUBYvGOD0PzGYL/qX1GOkKiGiUjzt6fffX/uMr+NiLT/vb
l9fD/tlKT2+fwUkWtTmsJDESvQOtfE2qpstQocO8bSUIjFVmXVG2euVp6KWSbe1p05osmZVw
5lkscCboMvoZ+TRjGzi2Rl5i2Br+8WUsK9f9/Al5tABLtnGggnDVhZDR7SlA75Mqv+Z5k3J4
VDPb07bXPE9phh6qct/Z7RsLkK4bn1DANJo1OlAlwIQ4dg9Lsn4/XM42nLL5NcAIqNwmywAF
UEwas7pIbNL4BYkZtKTrAcfa+NFOgUcL/gYo19TSVoyuawnygAYL/BzPrFumx1DEDOyPCTYe
zitnoNbAOwqVqzswVhLPt0J2AQIZF0N5PGF+EwGjWU/Di3BUPgkioGkSQIygPqLxscNowUeV
EWY6NAB9hyYz1FAQoEowmQKiUfTxzAFKJUhFWXBmEZqGP1JnF0UNVvPw/PQyiDAAB4wFZcZW
g2EglEV9aqrrNawGTBQux6N97fFXbHCimQTYTA6c7kmFXrIGPfhu4tlZNpg0FysQ5HIS8lhv
yLeJqIbj310luB/6enRnZQFn4bPodMujfiLgYBdtWSZIXrQN23rrxZ8g5N5MtQz2yZcVKQuP
bc1e/Abjk/oNemUVptPq3IuduexaFQQEJN9wzRwpPSLBIBlRivsHskaUndDTli44h6HV0AIF
EiOygC+8wxspB81/8AbGuiY73ckqHX8q41/5WzaWC1M346Jh/IpGhwaRzwd/PqPUTGtiIhiJ
5blvRSyvw/TdEEuM2pqengRibGxynymr94dPT4eH28e7/YL9e/8Ifh4Ba0zR0wNffHTfZga3
6zRA2H63ESY4TJr3fzjjOPZG2Amd8dZJQ6PLNpvagBDcW3Ijmcmjw/QUAefCZMi8viRLKScY
MkSTaTSCMyvwPnq/Ox7bGFt0QDsFykGKuUEGtBVROQRzganXq7YowB0zbs4Qms8s27iAEGdj
3jBQWQ0TxkhiCpMXnEYpBrD4BS8D6TTa1ljJICQP04MOefv+sjv3cm4mC9DlO7DDEJgWkeYG
bN8Y2nwmavicUZn7Ug8+eQ1uubE0zdWb/ZdP52e/YE74TSB/QP/eXr25Pdz99evf7y9/vTM5
4meTQe4+7j/Z337qcQ22vNNtXQepUfB+6doseAoToo0kX6CXqiow0dxG51fvj8HJFqOLJIJj
0e+ME6AFww25FE26wPNzgMCu2FHJzpnRrsjptAuoSZ4pzIHkoWszqD1kONSy2xSMgDeFyXFm
/IAEBjAdCH5XL4EBm0jdgedpHUUbbCvmbcnEdw5k1CUMpTBLs2r9VHyAZyQoiWbXwzOmKpvX
AuOteVbGS9atxgTeHNgEMIZ0pOxWLbgQZTYZwbCUdooVlmRkOhAOEKVOi3qua2uyk54lLMDR
YESVO4opOd8C10sby5WgaMHCDtFgf92gCR4NMjzSn1Gb8zP2oz483e2fn58Oi5dvX22awIv5
+mFuJPQPeC1YNm6lYKRpFbMeeQgStckIelwny7zgfrCnWANeSXBTgj0t04F7qAIjjqCML2EN
CfWIQLZt4PiQJRLOEyK4FSRNDSKAOmQlyGf+HYwPLVHr7+CUtU6bPEQhYlxlIsoa001SF53I
+OxAKqfnZ6fbWTjwWgVsA1xQ5WB+ZigHWFzxwDWwoZIU4DUVEM2AEkFjwVKmabUDGQRnDwKC
Zcv8hAxwANlwFZhO13bE6g8ouuaVSdkmZl2DgxFNZ7O/dYsJTpCAsul93nHgTfrscSwrskX6
zIYVHcn9xagutzIMIi7eX+r0USEoDXh3BNBoOgsTYmamy7kBQfdBnCR4mtlG8HG4OAq9SEPX
M0ta/zbT/j7dTlWrZVqSBCvAMWKh/zhCr3mFly90ZiE9+DytGARYyJlxlwxcnuX29Ai0K2dO
iu4U30b0drANJ/S8OwvYC9tmCIbhSvqOEjyvpOtq9KX1E0LtbLRAheu2DoBNM176KOXpPAxc
jmUlMC7wY/RRbWIYRmW9C2EYndRgxWx2R7ciBIMgRCZEyE1kjnjFRSuMcSnAby134bqM+NOm
FNpzUDkBzYg2rgvyGYi/EduJ9QtSbEyjQtSsZDR1iYnrAJtvdx3k60yzOfvA6XYQMB3TxtVu
6Tv8wyhAZ9KqKQA84EoLBhFDaopW0GT7zYrIrX8buaqZVYkqiCpFimUr46ZpDJbAUcvYEgY6
SwPBio8OsgO5KCwGjA3WZGnRTO2YoDMsbmoUOlJPuFy6xtDcMgVBi01+ZUquWWXzaVx9SNko
w3hhCq1vwiR9yZaEpm66epyYN1yz5YDQn6goR5kSyWyt64jXtnoFTtB0TF79AXw6XkQYqVox
CMxKCCoD19HLADw8Pd6/PB2CCzQv1eBEuopSXBMMReryGJziLdnMCMaVktc9C/Zx7Mwig5M3
1Ac59sPV8BeinV5m/g2y8TN1DT75+Vl8CFzWJf4HqJY4hEaCNszISGL+fj1lL+QmGLytU+wE
0TYoFnspPypw12hplVbyAw5Q6zsYwB5WxxdknplAST6ESzdu18ytMt4eQ+CSch0t5CK4Y+0b
Ly/S3uFG6LoEt/T8e2DMVR9FOTs+wtlkhAjh1Iu4TfgpiwLi2quTvy9O7P+ifcZxDkHHvOG6
4dSLnowbW0B0AD36u6s4WDSh1TzYGB1XcYNVHJ508RI5v3T+PNZBtOzqJCR/3cwdvTHAEIdJ
jTlQ1dZhqskEacDD6AULt4IR0XYP0W3FCd5bXl9dXngs2ahUtGF2aDNusfhoQerkiRoXQvB5
oFUzjd4aauE5zmw/RqwmSiBEwLumVA64CG734SdwQpvMQzKKSaFAPm6605OTdJ3GTXf2bhZ0
HvYKhjvxrPrN1anHu2u2ZYEhpIroVZe3yUC8Xu00R5sKnK1QFE5DSVDM5DhDrrXHibdKmNcP
2cMkeUwv/6LFzWLcSZjlLBQ3YMCyNY5LcA0wMKaHkKaWjQbn0BwhbLZuk+vg6o2K3GTFYLrU
VQ3wBS92XZk3wVWFs1xHMjOBCFjJdyLWrzRSBBMcBX9thvqh+uk/+8MCrOTt5/3D/vHFzEZo
zRdPX7H2Nrj/77NjM+VBQ3ItHT6no0IML5a9gpqT9CEvhuvytjf55Qy6YS0N2kSu2zjJJkC1
NX39IHap/ayoaemT6cahMMoZhhoTxWNpIuIaHlkmUyJ2rJqqznF62BUDhELbaea6K7bp4LCU
4jlL5SQRh1GvsM4HEOobaNOUkQb0fcrftOC2aUCdPQSNG5hbRm0FqaLJcunrdNNkwizFPnS1
jpc2BkexWxeBeT7Z7wCcUJTXyajDwEJ1kJ6MLJcKGAgd3XC7vRcc76/VEDd3uQYpLnjpX/IP
6W/b3UhgWy8Vyad8EECTMjJy2jy4phyvsVKuil2shDAQNNKUao4yVkN8j35choGS5fJMT1ht
layf8AkHsedK5tFQ2TIhZYrlLdac4u3ZNVFoc8vUSkepJjXzdEPY3t/Fh1MgIG0F6qaYFdIa
L79kDVwTeEAUNEyOlaMThHBS+3cxFzbWYhpY6yJYpqttXBSH/f+97h/vvi2e726/BNGYk8Mw
mDeSuZQbrMbGHEUzA46L7wYgCm6i2VUoYt+5EpIkLpJYw0Gli5FSXTBPZGqA/nkXWeUM1pM2
YckeAOurof+bpZmUQ9vwlE0LyBuSKInhCDMDH6gwA3dbnj3fcX8zKMNmrsZi2sWnmOEWHw/3
/7YVBz5tLGnSQdjoLNfGDMwi1fgMx441f5/S25yjSIaYlbzuZtLNIU46k2rSolvjDIHbMosC
rhLLwZOwKTjFq/QbjhCV0/mbqRFLi/nboPrC3jocW5o7lsrc4qeTwjYzVi1Vm/bnHHwFPD+L
wEbuVRO19fzX7WH/MfAzxwLmhEIbWI9//LIP1VvoJrgWw7wlyfOoGnIECla1M6CGyVhnDTB3
r5Q0QRbk7qB8v35Y+xCHG96P0b7vkhtKZK/PrmHxE5j/xf7l7u3PvvShT7CUGKenPXIDFsL+
PIKSc8VmytctgizrVHLVAknlJfKxCRcUttgJwja3rrAVZwqy7NBGq+zsBE7mQ8vDG1lHZU3A
s/Xf0tn6Cczu+mNBc7oAiWJomRi4X4z3q9vK03fQIfQvSp6+3alY8+7dyWliZExoVkGJklEA
O11k4Ug9y8zwguWT+8fbw7cFe3j9cuskLQxe+zSmG2uCH7pR4LphDYoUptLaTFHcHx7+A8K8
yAcT4MK7PMhTw884sTLACq6Ece7AEZ1L4hTXHS36OrAE2YATlyUbRvLrDgwAc9AmV28jsocI
jEVmYA2lAQ1zukHxBjxriwJrTfpx5pcwDjUgT6bb1PnVgyUgA6/uJ/b3y/7x+f7PL/uRoBxL
6j7d3u1/XujXr1+fDi8ebQsIzoj/dABbmPbrmRwOGlhMwHv7ikDx05J0tA59FF57C9giSeV+
EKMga3eK4Urw6YIDjnc2/qDXitS1racNJkUClhJfSphIRiWzKohISa1brIcxyOH0DmYUhS3g
gPhzFSLh+9aQoorys2kMj5CeVFaHxQ88e3H6b442OMe+3MfJWLP/fLhdfHK9rbPlG80ZBAee
yGgg1etNkEnF4oUWHyZP8jnBC2Isxbt/2d9hauqXj/uvMBXaq9GiOz1jsoXhDZBJKUZtLsiM
7u+kLV5MpaPN4h3c08V9C4Z6QwzlJh6Kq4YJ/mhFDY5ClkxBybqJy7H6IcC1nlQ+mgWZOgNz
GddWJjuJLw4oZhmiZBTeaeM76IZXXRa+XVljZVQ0rxmcA8mwVjBRULdOdpgdKbEzf5jZ7RVt
Zas5mVKYozH3hkEAbNCCkvfxwa4ZcSXlOgKiRUbZ5stWtom3lBrOyHhg9uVpRElTayhVg2nV
/s3FFAGi3D7NMQO0jkgXKC5v5fZNva1m7a5XvGHh47OhRlAPlbGNeWJgekR452cZb9AadvEx
4ucDwH3vn83Hp6PYUncQz9myvp6vel8mwNN+yB8eHD7xn+1Iy/hoVtddBlu3T2oimOBb4O4R
rM0CIySMUbHUr1VVV0k4pKDyP659T3AOZn4wqjGvhWwdY/TCaBwkMb8rb1c90fDiInXCoyI4
Dk08OxCi7ZYEM4V9Rg9rvpNgfFOYQuk50UqOfcdHRb2lq2W8mF6l9IyI147xEdp+trRhBpbL
dqbAFV/926fc7oMOCWL0l1J9ge+IMdfu9cQjKIFfIuCkTNVZj76UNQCbd8TerDN9o05AMVlN
yGk2zpsVr3r2ML7eRO9On/3GoiCR1UT8qsNpvQqvbNEoYOFweGgj7RGGY3R6FXiw/QS5u/xl
FIv8Pf6SeYt3HmhR8EWR8ll40HEG4i7aUssMqtljq7YFfZVUvmGv9yG7yXrnNGdTRlEYhGWh
AqIlFhxncAjgwOceNpYkaL7sb6DOJwDiLNAYsbvgBtUsHtzc9ZJlLjAxjfughrre+iw0C4q7
20NIdk+BRrLXcFznZ+5iNFT6g6MAlitl+VEt+s9s4q7906WOVVTtzNt568NRufnlz9vn/cfF
v+y7nq+Hp0/3YeoYkfqdJ0Y1UOdpRc+tYlgqVEIU+/Cju+h+82PQY4sb0gHgKeIXL6RuKI0/
IYOf+bEIybct33Fc3VAKzg1f0fm6wLw60/hK6uo0Ej5///1522cyGIykb4ERp60QPtvZgtMV
O6OTMAfHcbSiwyd4ypnqoB5zJg/Ug1GkFNPJuiSLgU8drsEn0Bq/gTI80u24MDe4/ibbCpga
ZHcnMlmmhgTBEQ5rHb4MdNrOfEkgvubNyuAuEt/oaqrxFulDWCvuXu9mOqg98ppLniXpMb77
bdhS8WZ3FAsfUaQP0Dw370sFjMVVs2jXWSrdYKewVevxHpBusiblJHyrbw8v98jpi+bb1/CF
v3lZZl3EfIOXEkm+1bnUI2oYP/vNY0ozmtFfvviA8bNTS1yOXxHwIkhA4tLWceZgScIHIx5w
vcvC+zIHyIoPyfA8nG/QLST6poyuTsdf+OEu++apBgXUViG/RSULNl2mhPdJIaNTbGcgtLyu
fD9JXWtQ1jNAo+tnYIOdMN9gyseHEyPKPCTurK7TXSftowl0T2K7jBX4D7rb4deDxi8T2KTX
3/u715dbTIrg9+EWplrzxTv0jFeFaNBp8VisLPqcgWfoMXuFvrlLYaGb039XIyUzdlhNFa+D
PEMPAO2VymbjNH3cMCZ3ZrZg9if2D0+HbwsxJvIniZF0ld6Y7uwLAAWpWpIyoWMRoEXx3A4H
iV1IOxWqcebHcuNIphyRTrsZtdqZqv9pfFzgB5SWbfjtDZzI/7hMCJmUK4Xt/YoCsxgiuNOW
RhhTempa8zTsFms368ZsyVSQX4zHDG5jlM5IfLKLmkxFFz3ty8AB8zMP9r2QDK8f1to7FLcJ
40Lbbz/l6uri5PfhZcLxyCEF7d+4+6T7f86+bLlxHFn0Vxzn4cbMQ58WJWvxjagHiAQllLiZ
oBbXC8NT5Zl2jGuJsnum++8vEuCCBBKU+05ETVuZiYVYMxO5kGS58c8nr15MrmVM7c9hs+pc
XRAdbFyySsBqQJNF7SAcyEL9nLBqGbCkph+wqntMflj3oE9VWVob4NP2mIx63E+LFGzex98y
76duvPs6V0o1ExXt19WXcmwfeg2VVtn2+jl0CSW9ezcovw505cbFbjC0H7vFa+18EQgStYOw
Koq33+cM+75riQsMZZT0VWlvBXIkhwO8ariRKxkyRgyfYn0NhW07on4ormhXI10nALkDk4et
8dbsdVz6zCye3v77/ee/wZyAsD9UG/PAKTZI3ciWXAW/1PGONNoalghGjTyIpdbDiPoZjnoD
yKa07VNTOygJ/AKdXsfR21CW7dCLsgYeQyyfxpI2+JhEHrctONDSTiRAYQ4vp8ek0blps3Jt
jWH2DpysP6l0kB4nupAFDg25MItm3CGVidEC8fEo8mrgR1vtfVM7hVOxBXmBB7dJ30CVdfFS
bU1EZSrtKFizJ3BKgtqWtmHygIkzpsSdBGGqonJ/t8k+rpxuA1hbJJMT3BHUrKZOU73TKjtY
pIHs9Ftefry4iLY5FkiQH+itXflQqKutPAguXbpTIzDomNBVpuXRA4zNo5UCy6BlVGQsjVHC
ozWKHWTYXl9djNousVtgWM42UC90t+saQwJhDTutqYYoMAwJAa7ZuQfjTwegmixQS1L7C1pR
f+6GxW/d+z1qK+KxtQEaHw18PNR6zFm1di4DxkED1V79dYVCXid52GZs6rNOfMck8U3Fifgk
MJPHLgMDKqvITz3xgnK8GPAPnO0Rk9QjRKY4ylKQSomeJolhsVHNxgnN0YxTtqVsSXtOsB8U
yw/BIGr6c3p0X/2H//nP078eX//H7nGeLCWKRlidVvgoOq26gxVEA9pAQxOZ2F9wcbRJQCsF
K3vl7GoHqTbrBNbs2XAfclHR1nsaK8g1Z2r2tjcUQAebhkjRoK3awdoVGT1Bo4tESY1aOmoe
Ku7URzaLzl0NQQdnD6EL+3eZ09vjFnRjtFrQ1KCnO/Q5ku9WbXYe2nZqB6xiOCkxeSRwgv2p
CQg9secVOrj1T2+NGii06sUgt9uAIOnwCJUz0hgMTt2qqbpLO31AN5UuW+0f9HOB4iTyCj3y
KAr3VWsA2Uf0qFCoRaKY/oHIt9z+/vMJeN5/Pr+8Pf30ot57jVCcdYeC4YUg9V/RaGBkOAyt
T6oVPu+kzUr6xPMpS0l51RUQAa8otHCEPiDVkUxVYcWPXynXdvIPhQIFrAzgjBsOWqg22rxI
019n08GKURvqfYR6aV37Hr1ZnF43+u2nVJePvV9sjIybAEbxJploePBLGRiJ0xaQiC4NcKuI
aL+YL65TiZoOXoKI1OxrV9PAGweilUXg3sBTXr3nEyB00juoAh6leM6dMUOzM27cEVywxv0N
TjCOmWyHyJlUm7XzLRpR3c2At1PnGSdJKXrECyzTD3CzE/ESUl9wzHecthIHNBn7AhApvBWN
3DwuZCIGhitVg6uTVAQpgocS4NySFg6G0x78buQxyEwQqtPclYFKy+1HxVa5Re6PZRPacdDs
x5DZtRkBeN8OovcsEOQKkCAABZFGdA+inSMcj4E6ai70Y5iu+aGYImiTY0Uc9qiKd5Ck52Ty
ytDLzqj69Dr/SuIs8HCLXYY9pW/vi9b8v958/v71H8/fnr7cfP0O70hIZWUXbl2ehKaCpe1S
ovbeHn/+6+kt3EzD6h1vBhbneot9AaLhyQL7v0QNWlBti/nuEl6A+ynaqzzISBvmDUdSd4cT
1RQQQThw/FPk6V/pY5G+hwMb6UHHN8EW+/R8wq2DHrT+mnl3EdWj99PGVY4tC9Ca//r49vm3
ya3VQDKYJKlB/rreqqFXIsp7Sf2o8JPU2VEGry+CvMwhHtb7yYti+9AExLtAAU/4ulogfL3S
Bd53Goz0mjl6dwGcgCFMqHnj0M7tSPjpL81mIgOqLoKWxwFOiCANaEEIUrjN/9J87HlWvX/9
7d+9MCZ0MyS1jub1vonL5s21ict4sWsCbA1B/VcGzNFmTJO+f50bRU1Zv7sfRfoOIX2gDjJj
BCmYi7yX2H9SmqQ+NH/l1J1ge33id99rHTlnWYC1pYhj59QN02rBenp1TjHOBHXQ4zlArLWu
7y9Qh/ISEdT+5TtJ7RjTTtEeF457ce8LO6X5stWNrqxqo04+vyCq//sOhVoKWvOaaW3lrSMi
m1nUmJCcYsQcj8QXo6F2R1gGAWai7kY/ZU42buoOPApi8cb/uivNa32bU7WLnipuZNbQyKgp
UzSi8lUTBtMxcYGXA4skdMnaNE1DX2qGxlfIOgQdW0qJrIjOkRNQ4SssM6KdECYQ3STf3n9/
sQs4cBqCmp0nsJLHx6BNqyFRK8TMIbm3p/Zgt0n/s5rapvR2pN980HZcXduOq8B2DNU9bMdA
zXizrejNFuz4uFuCJN2Go5oX1Sq8nVbv2E8WDT+KFb2pERmcmdepyiqgMUdUAZ4T0cCXG0PO
67T5Oz4zwIYhGllPVjR5cKyunBx+ixM7dTW9VVehvYopvPNp9VcOKJu4cENpDtt9ajeTd+6q
V6ElPP729Paus0CRFlov0u5qtj1mbpKUoT/X6qRuU/NSd12TP0HXP/alLd9Sh2NPVvkraDxb
8cOOsRGJR1sTM2YKcBPHInkN8TddRS0QzY0VpWN4NKAX9BCGmhg70CUD2j9+/rdxGfKqJ2w7
7eqdCqy+4zcs+NUm2x3o0OPCCezcjEbfxmzJPBDnyZIY3yC53LPoXfW6yUtteqd95wOI5uxJ
Ni06JkI1mfuvETgECvxuc8UVMHjiI9ecJtHeX6Q9DGCx1RJrkPGk+tnGWeClC5AZI8cFUNt6
vtogLnSEqskObgatDfjT/uWHOdTQ08IBCCSnaRAnsy9Ku4Wd4mksEwT7h9nZxMO+2OVqtRZl
6doLu4QnNUDdzUEb/xq3X9jtEiXBMYCvDkCdWrt2M5tH9zSK1XeLRUTjtnWc90HdggQTRaua
gwcmTbGTZz36BCr4HTyIyZsDjTjIT44oPqBKiKseEOkHovs40KKaprvFbEEj5UcWRbMljVTX
g8i49Uqop9zM0Z8+rN2d7BVmIXKEMJcetgbT16Ax1qL2TWb5I6gfc3tXs8waUXBNY1WVcQwW
VZJUzk9wHrV9Pi7zpd2njFVU3OJqX5r3tYFwpdjlilH52wTnHAZgiQTmEdoWWfeHTvUoQF3O
AhzkWGhCI6MOYkMUWCt9RlZ9s93//vT7k7qlfu18xZCTbEfdxluUALAH7xtqbAZsKmO8ogAK
568HrGpRuste9ipGOuRdT1KTfnw9VqZbql6ZUqkLe2zD7x27Xw3dujZf3dBQN1mP5U3qf23D
Qt+7q8PPgpogkRPGX0Cg/ms7Rg3l6prqfH4PPZkav8O266v72fvywH3wfXrvNx5r5y+PNr0P
YWJ24H416b1Pud8T41sJTn2sak9hJj6WdO7QFSJnrnFuJTWHHXPlqe/il8fX1+d/Pn/2TeAU
B+K0qgDgju3kt+8QTSyKhF8CXwIU+gi99atMz3i0AHZcWOdoB3BTHHdQxw6tb0yePKeKHk7q
FvrOQEh8rzbzGOl3E0wuPSBUYd9MPVyLu+DHjjBcgx3fnUEJHR+stOoWKs4rqppWP1OSGDSi
Fhwy0pCIhl8aEhGzQiQkBvw7vc9mseOuxMBEDt47nI4CHOJKWIHbmLGm2/oV5KJWx5JfgWR5
lREVe10DIDb76rumWHsCLIU75Bp62NLkMSRM8qCqb9KHAjfiQ721pavtnn0JTCOKtCR7mJfE
QImUGCVjUwXeR1QDGKYq0JV7vekQ/hHdIbqTwj2mmrj3UZs4DVORWhmQk9haGUkBoZBkmZ1s
g+GtutqZ9q6nYP2fyMTORmf0u5lFkgRswiySgn5FsijygB+W3Y4rjLk4EqMjNwY+DjQstHRU
KonjpEQLOJisWbLAwBRMF2xPF7SsUWFe8BMKjnjq/NfoqdemzFhi1jsJnQoAUQJRiWn0rQNW
5RiqjgNjao8WaGEHJ9xL5ww3nTf2mBY4W4BaDx7hXFNNqDGWVIj8urI6X6dSBwez007ZeHP5
6Or0nqIQnk+cllku4Aj90OI05Fubj+yydGOAbGrO8i5AhuNaBvp3/c7/AXuQ3rw9vb45iind
40Pj2KpayKQuq1YJxqJ3we30VV6dDsJ2Vx2mi+U1S/TwdEE3Pv/76e2mfvzy/B2i2bx9//z9
xQoFwECmsrUk6rfazDmDDNKnAEdWlzlSGJXYm1s3zC7/O1/efOs+4cvTf54/P1GxuvODCDwB
ryrHTmeYm3sOEc3GZbllD3GZtxBoLU0uJHxvwx+Y6X83nJNdHVaZvYvVD1CRY8DWVmAAYHe2
RwkgH6O7xZ3PfSrRNDGtJkQwcziY40CWR428TGFlFpOSL+Bgp6IexyyLIZoWOFsVSHkL2DTj
k03t6ins4cRgIqpY8JQWpCrDVQVriKex8XpNZ9QBrNCBWItAy0CRT9ZecXaY6rse6o8MUg6F
8WXqZm4d5v8olbjeh2b15n8DShNNEqia53IaLxPA0zHX9dxNl+8mb4okj7dskkAP4RTB0ZuA
3mrDHyBc0sQiMt7z9OMwsceGU8Li6LYNxJRMkECuYHUKqkuafVElCk4ZRShMnGPrHQXaiyRA
vJdOq2ToWQ23Q9QpgORZ2pgYU3Z5Io6FCc398vvT2/fvb7/5x/JY2GSARANjn28wKA3G72Ox
bdQ0uR/cgXVCMiKVE0G5xUEUbFTekFeCRVE3mV/4yGqSsTTl4nw+W1y8j6nUdr4QX5M6ixhh
T+ofqimvT3icWLNfHOz7JzgfwyWdKiamxu8vPSz0TD/idZzcNitRGOAe673S1ZdDwMFWlTnE
VCrFAKMEJgz1EYU8OIuaZ0iNE6c70IeidzCjc420vyUEJ6Jur64Y7HmeQeLL9szqQp2uaBMN
ZDGHGL3CRDlsy+JIRnfpqSFkm+opxKUrdAq4XbL1u6wDV/XxGYEEBEbi04YnvYpGOgLN2Oc6
YVQGsIHg7AiJrpKZCvHfo0Cros17dXR0CXE5rUSMZ6GgZNV1ehBkWEVgZO+cqBB3lSuTxUyk
mCkSqf9iayML4/v1FQGdUybmFZjdkgrv1NZzp/DiuBMNyzCw0HvWenvXoDZwagB675eQ+ySL
vcO2eHr8eZM+P718uYm/f/36+7dOyXjzN1Xm792Of7WNBGNQsriVwyKIyHQQgE2Tyi2gQK2Y
U67SurpiuVjgMdCgbmQ9sKoJg/Gp1kPciRng4Z7Ipht9D+Y3WlwqcqoMeKqRRXqui6XTigF2
zVjC1bsmrK+polRtoFUaX8POri99D+l81Ttooj7bCXa1g7zjPHNlfNAStLl09N5qm2iPzvEA
ZiIrTzhojZKcmrLMenVC6E2YjxKxsb1wxRNELCSKsMWdlCY2rYm5ODD8+EeblDnrY6eOYA6L
f3sMppPhTAbSPAKyrZogUg0ipZcAjM7W4PZkInCYzoRHJ1IFFIR8g5uvS77m1itK2rEQcFVN
p13SOCYFxU3pJruA4kOBPoIdZGpxjymAff7+7e3n95eXp5+UoA5Vpo36/1AGWCCAsLh9YLLw
jFyEWnsXrw/J0+vzv76dIVsEdEfbao/pR0Yzngky0+HHL0+Qflthn6yPer15tSqz+xOzhBex
WikZa/Qn0CLE1WqHuKP0YA4Dzb99+fFdCTPu8CrOWAezJ5tHBYeqXv/7/Pb5t3dMnTx3mruG
x8H6w7XZlcWspjnEmlUiwW+WY+KO58/d8XFT+iHWjiaStO8+1J+N/NTklc0m9ZA2B5dtZEbV
QESBjLaZqmrT0pD2B/JgDA/uQ7aSl+9qsn+O51x69lK7DCAdYi9RFdnxQi9NzcaMQGOY6LGU
zgtgPtjuPUmgjvIs24bc1sYiVKRkPxVL93GDLKCDJ4OGAcUaHcZZi9a1OAUmppO8ay79YsDB
d2VbEwyTMgQDIqYDuXakOhGI9f7VBTqEeIQgRBq0FwcR0Kdjpn6wrTpgGhRMTDHoKHyo+a3v
fhemLhPhAc+RB8pzWwvdV1jf+xXGscVUQcIRHWVfL5kUzz4gU30W6Xwl5DwGdtOQnW1kKVGi
roFxGdnmUjEhsWfP2g9rQUfcbqxXNPVDT9/gmz5GXP7x+PMVx1JuIIvAWkdqlrgKKxY1frcH
ZJkaON0XsDHRubWIanuU8VyAmKwmRvcvUbACnTlHR8O3o575ZBDlEoJc2up6/9v1kBzVnze5
cdG/YYq0+fn47dUkObvJHv909eGqLd1NWrLrsW1N53VMA+4nRQghgpg6TYLVSZkm9AUv82Ah
PZtlFQgar5BuAFeEHCJ8q41jXpq8e6Zm+a91mf+avjy+qlvst+cfvmpLr7dU4JXykSc8dk4d
gKujZTiMUGdUDfrxEOKSOWHwLSrY/FtWHJQ8nTT7NsIrysHOJ7G3GAvti4iAze3TZICCLo9+
UR4+Jlfih7OzAa4uU+ZDdVZWvNdY7o6RmolAg2yro0BbQtfEzJmg1o8/fljJXiHitaF6/Aw5
653pLUEiu/QRdSUepmr/IOEq+EoAu+gmZAEYirr5MPtjM9P/o0gyXnwgETCTeiI/zJ1V3RGU
tEOtTbKrRKlDDYRGNU/Wq4vzNgcIEe8vzmQgPJfb+RQ+Pmxmt5M1yHg7h7DhkrJ3BgIlbr49
vbgdy25vZztaz6Q/PKYFH/1NOofpCRLyhMYDuPkav/RdW0Z6rcmnl3/+Aizwo46uoqqaer6E
hvJ4uSSVbTA0mekDmlAPpP65MPW7bcqGZUY7Z8fm7rCK0YGkIICN5hvikphD3z0p6/n137+U
336J4bvDz45QSVLGO9pT4/oYodmHvGGxkwhS3wYFLxj5HDAU43EMssue5Tm2X6AJ1P0TOxc3
O2vCcNGtNjwzN8jjf39Vt/ejkn1ebnTX/mlOpFHcw2eNrkdJjywT7sdZKHcpB6iShqwjZint
+zNSyOVyQRkdDhT5xQ7YOoDhTCHAsHUgRU6gO1pa9hZW/vz62V1BugD8nxTh00MTKQ6+pD3g
xlES8lAW8R57hOgmswrOxf9j/jtXsmx+89VEECcZAE2Gv/se7Masy75b6Ncrtis5bh3GQgHa
c6YTUck9hIJ3trEm2PJtZ0wyn+HPBizkOKCTnvYUu+zIt97y0zW7jKSF3z8owRIyBIySSWPn
FU7tvyGQedOgNDZlqhNFNCiZnAKacPQkSo1u7gEP5fYjAnQ5DBEMrj30bqRgSNQq9UsB+p0n
tnxWgt8rpJwH9tE2wzYIsJdDMFCcZszN2JiL3b7pNZnAkrqPMx2I0jwUSK7Wobm1kJyrD2M7
7r/TVr65jioFKbmt11+T7Ae9eHb5f4pjlsEP+tm6IwqYM/RoUI9JCfeTqBbzC3XEfHJYP/jd
nmvR8KDCQpN0aTKo1AReN46KeJIgU3LFJEFSb6e/tLiCl5fNJF59Em3YkKhFD/ZfcXIKvKs2
TK82113Mb+JKF2t58ZWqxSnnSIvqfvcpFFVDIdo0EPkDcMY/l2QPUKPD5eA/dikxQJa1VKef
XGSn2dy6pFmynC8vbVKV6FK0wO57z6hEOeb5AxwPtMC7zSHVKa2d3rOiCfC5jUhzzcTQtcby
bjGXt2RedXVdZqU8wouyOoDARgWp5atWZJSjB6sSebeZzZltLS1kNr+baWexsXENm1Ovg/0I
N4pkuZyN9fSI7T5arwm4bvxuZllF7PN4tVha5vOJjFabud0RsOCq9kfaxEeGtoit+vaCLHc0
5smglUnKbf4Ool/XjbR6WZ0qVuAg9PHcPZJNIigO95H1KNDPloarbTm/HavtgBnfsfjBrrxD
5Oyy2qwp99+O4G4RX1AYiA6uhMJ2c7evuKQO146I82g2u7X5Eqfz1sdu19HMW6ddLu8/Hl9v
xLfXt5+/Q0qV15vX3x5/Kvb9DTRSUM/Ni2Lnb76ovfr8A/60D4wGlAHkbv//qJc6APB7LwOv
VQZCd5Whta4Fv5zTouGAbQOn2kjQXGiKk3kXOOXEKxkkT3+5UcyJ4gh/Pr08vqmPJB6VTmXV
eu+VfdiCiSqGWY/3yAVNL3OWxWUdlon7nRASNQa880S/Z1tWsJYJsrfo2EYPuSJBjlwi8dcb
pD/sxUJvl+nciOCSYdseMZG0wDfSKkLpWJGP0ijRELpf6SELJKPoo5IGTvr0KKnk9OD+eRMt
7m5v/pY+/3w6q39/9786FTUHIyj04tPB2nJPTt2Ad1xyR3gpH+i1NtWnYWWA+0NTyn33+oLz
ibK45fkxL4+Sb5uAAXtnd2kfy07Oli53Xs96lEWCItzrCxtbie2OrEZrYwBOvMHz+6MSoz/R
US7SreuV0HBGaihZjF2RANAw5JysPaezBcrmgwtB5hq7jPEDQY9WtsSxayrUoLSvOdVZ9ZeS
UVzfyQ7ai0z09GC/B+2NoCA6lVyt/rDfNJuj9QWm++O+OBbtSU9mXUpJG6eeeINSmxRZXoa8
Hk418tlV4lVBhgeHuA3jyrSBetV8tUFObpQuRoR7tllYXoRxsL+MaWOQ5BML2JYAUnEhoDIO
4tXNv17Pl7RNNhCwfMuUaJgEHuiAZF/W4lNJm63rNuijT3+e2pPz2Yw+5HTdYZRadCV9RhuD
PjNdlOrx7efzP36HO08aUwNmpUQm7JCXlpGa+qFl+q56ZJgLKNCRB9+pgUIxoNuxsI3gdcI9
h2GIsbCN1cem9BT1NK7s6aKVSCHuQzEq8ma9XMwI+Gmz4avZikIJtQNBCwYBKYIxNRDV3e16
/Q6SwRRuinCzvqPYXNzxy+US+iaFandZuWXZHJ9KmKRqKh8dijByH7ONm4NEIyAuZ8MPrcyp
m7WnkrlijsYgHF4tNj5kZUiRag0UUd9JKClHKh5TxusFfGunbiUv8fdumoF5BN+owk2OeFIC
lmIfF2q52KfuSQlGnH6BaR6qfRk+vU19LGFVw7FhugHp5zI4Qq9UsOOYG+JNtIhC/vN9oYzF
oGCK0WUjMxGXpM0CKtrwLkl0399YXQLUlHYSSCO9iAV9XTn7dHWAcsTFqJ+bKIqCqp4KLkE3
dulYtr3sttcGVPFA6sBh5PSrS5aGw5opEefHmix0M2VREBG6MrKIVtWwjF58dt+OdVkH4/b2
VNu6ZElMvjhjqphhwWVbXK2bePCgiE7imJOjG+95JgXKwtmB2oYeygFNZ7MZ0HTsxBF9ItMe
WT1TUiHqV2Ar2EXUiSEKZnOyuSjEeOzYipeLEmUZxdQlBXf86LvqE+6F1WiOTgwwolRn+Dyq
ALM5rXqWxyJhVydTiTwZv6BlwudFOMjyUO6T+zrl0+zKcpdxcqHsj+zMBYkSm/nycqFR2lPL
nkTaUQDAM5cuwP+JHa3DU/BTIE3fJVTEPbNGzG2wdfq0+Jhfmbec1SduSzv5qXsFGhfAIRBI
UR4e5ldqV1WzokTrIs8ut20gC5HCLcN6BIWV50l0er7SH8WW2W4FB7nZ3Fr6Wfi9jFRNaHUA
C7e59fRE1HIe+L53EUoeZLJ6sodaoMFTv6NZYD5SxboVVxiBgjXQKjoxDIjusdwsNqSa3K6T
Q7g8zCPIuaDN7U6XUPhOVGFdFmU4ePlAeGX4Nou7GT4c54eAus+u9SQSgfwzFKsZ84QOTmgV
LA9oYEG3H9rJqq7yyr1hkmirrbIThfP+ofgotcjIih84GCen4gqXVfFCMvUXeT7eZ+UOB2u6
z5hiu2nO4z6LnTvQnqoLL9oQ+j4Y7azvyBF0uDliwO8hQAGnc1rWeeiWrBP0PfVqdntlVXeC
kF1qEy3uAglGANWU9JKvN9Hq7tpSrrmaZHaFF68h2AkyfzaQa5VLlqtrPJhlYCDjPBRJrqco
MyWjqH+II5SBR08JXnUwg1cWoxRG02fpre/mswX1MIhKoU2hft4F/GwUKrq7Mt0ghqKrvhJx
yG8HaO+iiN4OGnl77cyUZQyGuZfG5d16fKNviCuVHAt8LFTVQ84D0RZhAQRsAmKIARPQ6xUi
kM5n6MRDUVbSduNNznF7yXZqi9qs7Qi9fgI3fH9s0FlqIFdK4RKijSvFL0CaWBlIqNRkZKQP
q86TLReqH229V6cxAeqdG8aLTmHA0zqmo35bbZzFJ6R9ML/b8zLS3KcLXcxm9rh28O1RthMJ
BywqUfh0PhUrHgJL0/dFG+/JJKFXkeKIqtDsya1ms0ddvtZY6hcSiy0FINheOZA4B0Mrs9QQ
QjRbZr+Y9BW0+fFCQ41pH42Cya15oLohyfPFVpNqiq7KkX8D4F5IoZg1+grTFI5WUcPUsRLD
OxElsKs1jlOTaoDlgS/PCmJ3JONJ29RitwPnoT1aoMb6RIgbgIfiXcgUvxskonDrQWoYB9dj
OtULoFF1l81mfbfaBoqpWV9rjefeegNTwM2aAJr3G2c8euWH2zBUcrvZRIGGYxGzxOttJ+AH
yiRMreSuJVveroCznocKKWwTb6LIbUsXu91MFNus1l0hBLzDwFRceOL2ScRVppY0XbexA7ic
2QOuKZOgyohmURQ7iEuDAZ2sSQOVVON+q5HWAt0ZNey4ugHcRAQGBB33qwsd4oKFGgJf+QYi
Sndry3o+28wWDux+aGAA9Qp15+M6fi/QKLB1w8eNuxhU5U49suHR7EJpUEAXq9a+iCXuUK9L
d4ahsxfaqZ0/r+H/aXVrRfO/ktY4QXgZE7DNeY4ERMwadMwB7MDOIU0voCu+Y5IMRdIFstlE
yxluxQDnGKju/fXGfnEBoPqHxIe+83AaReuL29URdddG6w3lwN+TxUnsBGCzMC3nOY0oYgJh
VF5hPCDyrSAwSX63mkU+XNZ3a/sCtuAbEq6W4Xrpjl6PuSMxu2w1nzEfXsDRsSEagZNo64Pz
WK43ixk1F7Xia6TnjE6MjjxupRascfpgn8RtBTwO8uUq8NqgKYr5ek4LDTpME88OglZ96dJ1
rvbgkeatgIBXsizmm80m8IWHeB5hjUf/UZ/YsQ7Egxi++7KZL6JZIAdDT3VgWS6IibxX5975
bNtz9Bh1cSyjS+QOJgyzCTwfaE1Ue8c4AqBS8LpmbUi1DCSnbEWqc4cP3Svpklhy7D6OItTP
syMfGCvIb5Dp9ub8DBF//uZHlvz7zdt3Rf108/ZbT+WxT2cs76pmdGIQotMQImc8u+CXjqPo
QVozVjbUe6vQ0JR67NcYdbZ/6DNm/+98+avOFtAZP0GZL8+v8OVfnEAJaiyVDEhLHay40JJX
FSsxJqQwSVkNzu0Ug5PZkW/gF9iRftgMN+S2QG4d8Nuw5+AuTXE1Yw4CwpjrlF/gdZEolx4/
ikYeW47DMiuxRQonfrMVVKZvVCYF/qXuQttHAX4Zf3aCTHEySZLxM7MtxHJd51f0s01k5YKy
qBTDLH8F0M1vjz+/6CgHlLOeLrRP4wkrSkOgB3maJBTJ0BCwU57Wovk0QSIrzpM0EGfLkAj1
d8ED9j2G5Lxa3dEnuMGrOftIHkrFCSki1c+2crxFOpvXH7+/Bc04RVEdLWFf/zQBCr9iWJqC
x4cO/uZgwBoNhfgyYKnjyR1Q1AaDyZmS9S4dZvCxf3n89gWH0MSFwITR8ZTBGAjldKQeHBwy
qfh4XrSXD9FsfjtN8/Bhvdpgko/lg/lYpxf8pMD0a1iHd6werckJRWcyJQ/8YVs61pQ9TIm6
tLLTIqiWyw3t++IQ3RFjN5I0hy3dhXvFMy1pLgPRBKK7WjTzaHWFJuliaNerzXKaMjscAu42
AwmoQ65T6PUdSB0yEDYxW91GdDpGm2hzG12ZCrM5rnxbvlnMadMCRLO4QqMuq/ViST8GjEQx
zaiNBFUdzWk7iIGm4OcmcAwONBBaHZ5TrzQ39XowTlyZJamQ+1ZHC7pWY1Oe2ZnR6qKR6lhc
XVGlOtNom45xEeTztimP8V5BpikvzdX2QIfQuvGgPCJWgbpgmmhLRga1TkXrcoef6rCdEyAl
lNhRMkf49gEdHiMCHvfUfyvSQXagUgwYq0B5QNU9IJXEh5WyA0n8UHX+p0QXtAujF7jLI+Ng
CcrtJCc+LtwDiJjBM9st1uqAXg+iobtXZhWpmh0I0jIGpQ62phvRp1z/PT2+VLclrwXLXKjJ
/QU9RtoxjVOraHm3pnJjGXz8wCrmF4PRC9hlGoKTvFwuKJCJBjve76bTw2Jw1dYOmg4CPFzy
kDXdisXYQ5RMzdSSpRCLxG5uhAceIQaCuNwG7OMGkl06p9zAR3wtKqJLAG7tfC8j5ijUpZZj
38wBC8pVtSdomXagkiLhZ8iBQolwA1WT47fusRFtxjDdhJIqahEwnx+IcrbThj1Xelsp+aWs
qTnHNFtmGyCNOAj9buvMxi88i0T9IEfy054X+yMlSY/rQy5nUUTUC5ymCebmYi4VS4gCAFZ8
eqBAH3bc72R1qamtN+BTKdhq63LxOlmtJTqY30ZzFPOYod1gI0XVcNq4z6LaNTGZdHSk2LPi
zHCSAwt7gGS61xoJ6287InMCqmUYl/mtK+DoM9AICtYojEAIl1BB3GpsLmNTsGS9WVNsNyaK
6fpZrSSYyD3nEEWTg7dkIMw0ojwqRldcYkFvNpt0e5xHs4hmLT26Oc1d2nTwslAWvBVxsVlE
lDIxRL2cLUNfHj9s4ibfRREtUGDSppGVZ8kXpLztQ+FMUCBXWJsAPL3UuggtiD3LK7kXAZtC
m5LzgIIDEe1YxiiR2Cfqb3uy1/wCCrIZjeyUT6GZ2JVlIq71Ya/uEl6FqhCZUEvpWh1yJR/W
qyjYj2Px6doE80OTzqP5OlQHD10zmIiWKm0afaK0582MjDfgUwbXkxLhomgzC361kt6WM1L/
jKhyGUW3wTp4ljLZ5qKiODtEafjCwOIW+WV1zNpGUrcNIiz4RQT3SH5YR7TGDB2+vNCRZa/N
eNK0abO8zFb0+Oq/a4gaM4FXXFDgBtAnKl3ynDTaQmDi+NYPE2VelVI015au/ls082hBd0WN
ut7iZRA9n80uE0ebobidQgb3TYduRUDhYtPWeUsGC0VbXWTcZoEwToa3i2yiuZ1BEuPyFIcv
RdjLZrWkZXv0pZVcLWfrgEuWRfiJN6t5QImD6MJsMhq1cp93Ny71QIB21700j6KuHlWQG7PO
hXvjaZCzbjVMiZGhGtKZtTB7SLciccXzpAsr4dJHkQeZu5DFzIPcupClD1n2muh9//wgfi1v
QFWOot2g7UMElHIo9M9WbGa3cxeo/r8LPYXAcbOZx+sIvSgbTBWDmoQYXYPOxBZpZAwUvc0Z
UOcVRxArEDybICtWU6SO26m2WaXb9rpstKdkwaMzUjuWczcUVw9rC7lcUmzhQJChq2sA8/wY
zQ60ZnIgSvPNzCHpHDeppTBGASEeVcxT1W+PPx8/v0HodTdaUtMgE5cT+dRciMvdpq0a24TV
RK0JAtXuhBDq8+UKz4CSXIqyMOHUAxHfi/JTGXK2aHeBKEv6KVCdswUtxem4ZU1DazcHxWxD
2qFmiQ6VcmxKiIhuGfHyEwr6pn4fDKAL+fnz+fGFsAs0o6BD2sVlgVe8Qmzmtn2OBVQNVDXX
YaT7GME0nRMVzkZFq+VyxtoTU6CQDtqmT0HtQql5bKJ4iCNBdTpngV7aiTpsBL+wOtT/XLOP
1IFuUxW1TrMjP9xS2FotTJHzgYRsiF8aXiSBJxabkOkn1/YUyOuDhuJsLCzJepLz1abqZr7Z
UBKHTZRVMrAscpEQjUMIRcJV3MR5+/7tFyiqIHotazMHIjZRVxUMQUZzhR0FjtliAa015Nb6
MbDjO7QUqTgFvO86ijguLgGbvJ4iWgm5DrxHdERqzWx5nbBssrHuKvvYsJ27IgKk18jAR+oa
TWeZWMmrlKwOOKIYdF3RUkyHTmWmFti1NjSVKCC15zXSGDw81EmkU2jF6oClVT0dNez+T9Fi
SV6NznnrLLI8burMMzbvkPC6HsoFpO4EyJZTkDkCRZULUPolma2F1VCd9yVhDfKSMxiIJWce
AUNVGtt+o/NOmZ3NXaOlcAFSpA7oDGnjk3Lndqs887pMMfV2osH9WXFsRVLmBAj2BPBMOSex
TrrHEQEBDAjwjpcJ1bJ2MRkNhk5OcFB4/BFxIMKiLIuHKmB1c2aBg6OKN+vF6g/vMb7vgWIH
umeeUdRgZyJQzIDeV6S9jFo6u3jPQWEPI4nkvFj9q6gHUDWosc45YXMemHFX50H2gF7PegjE
4LVC/vmc4SCEdDNcHyGFWHW0lzHCQQYLkyrGuz/g+cy37rHTo0DgWYAohqbmO2GzQwDV78AQ
RBltIoUwMfWp7QPIvSqFjH8UEJxaOqOu/PeXt+cfL09/qM+GLuqo5VQ/1Wm5NRKDqjLLeLFD
0ca7asM2GyNBThsBdfisiW8XWtvjFa1idre8pRRymOIP72vbShRw6PkIcNNxmkq4VWLyW/Ls
EldZQh7BkwOLq+pyEAFXHfg28/z7dVxJ7OVf338+v/329dWZpGxXbu1E6z2wilP88QbI7A3g
VDw0NghakOZmXBtdjqwb1TkF/+3769uVNFmmWREt3VvLxa9otcuAv0zg82S9pO18OjTEh5nC
t3ng3ge88IRRGylj2hfBIHP69gdkJcSF1l0BttAqpnCnjAe62lnHIIkUSka/Cw+7wq8W9FNM
h75b0RwhoE+BMGgdrqr9lGVw2IXWiIxzIjQonJ9/vr49fb35B2Rb6jJM/O2rWncvf948ff3H
05cvT19ufu2oflH8OqSe+Ltbewwnf+A2M9sf0tLqGKVYq+YgqRj+DonMQreqW1fAXhbI+G4+
C68cnvNTeGVMfOaB5+rocjtfegZe9iqNmf3VNubCPEAn1KLq6wOZRcEssRwCXTn9CWQy5H+o
a/qb4nAVza/m/Hn88vjjDZ079lCLEkxYjnOvgSQrKP2X7my5LZv0+OlTW0qcVRewDQPTrhNp
lQVoUTzgZK9mM0BOAG0s2h3m5dtv5oLoPsNa2/gTOlOytst1aivz4j/mMyV8k6oAKJpK4R7z
5JGOpqM5On3XixlfLBrUxVD2twHE3g/H8x5I4CK6QhKM9WvxVFa5RUCsI32KcTa6vcQ/ENdl
FNBSONlKRvDLM0RntrK3qgqAARsHsqpwylMlpYbDrRZNBRTe6gdY1xaZclNVGmcCsjAeNCtN
8/UjlVbqXSNyj5KhJ/+CdHmPb99/+rxBU6l+fv/8b5+hVKg2Wm42bc+9D02C/+nqdhZ0D8Yl
4SkykLcW01Ux5abkEB1OlgrTbShpYpTryP+6oWTHbKJgtJBBsUNA2uGjbYap4MjP3KIHNjM9
qmJYxQk1qb/oJhDC7CCvS31XTPw8B5jH1XwhZxtr3XYYKYpdhhj/AXOJlqQJwEDQ5OnFr7E+
bGZLH1zGPCsbv2tb9tDUTBBfomTHun44CX72a8seios2IPWL9dG93Hbq8tLYItjQDCuKssjY
gRM4nrBa3Y5oQffIhBdKIg5ZWQ9LQ0d7g+onhlKowYEO+N/Jz0Juj/WOmLljUQvJzSh42Ebs
IB0L9VH8/qgu4W2Nou/BaYBc5DuAzqajpNF9l3BnGc17ijJ1QiaYfGso20pfi6jvwY7IXcVE
efkg7ay1Gtbthf7Ezk0+oa+PP34o/lCfY94Nq8utby8mdsM4PqaPWjnpAvOkahxYF8jQgSZn
VqGQ8BoKmn36BQawaQP/mUWUYYj9jSM/5gxB7SplNHifnWktvsYK8ozUKB3i6RQ7X5ZvNyuJ
XZ0NnBefovk6VJlkOVsmc7XCyu3RqdKosNEzowGX1NnSL4FYR+jFRU6XzZIKpKuRhq/0p7RN
O/OYXooPrx1zxalz/5cOC8+QE6srXUebjT9Wotmsw1MSkih75CIUV0gTnEUBseBDg3CW0Sq+
3aBLbep7BjlMQ5/++PH47Yv/nZ1Dkzu2SVF53747t576BK0j8H8hjaNG9NydRa0DWvjQdLMk
lmpTiXi+ca0QLf7S+VZzoqTJlTHQUcOZsym3yd1yHeXnk9eLgBSicb6gZnZktVkvV8EFDmOz
Xi1nxAeDAcyGVpGMFPOAH9RIcRcFu9zc55fNyl5XxIgNKda9kcSNTalszLA2m8BrlRkJdV8G
Mt91K2MSKVpIud4GfMd6Im6o5rQSR1PVSbyYT+1WWULwl8x9U7PSx1MjCG4SV0ZwlDrJmoka
8FJS7O/Ruot1qm7dSPTLf587GTJ/fH1z2j5HXR5h7TNHnt8jSSLnt3c4UhXCbajFZpNEZ+Ru
O6ICOpCRQO6EfeQTH2V/rHx5/I9tNKLqMWIwROyw1CIDXKIXoQEMH2UzvhixCSJ0amzI/OZ8
7UgTUQZmuJaVM9AjKmDxZtMofv1aA7aVF0ZEgQ9bLIJdWizaOPBSi+koGySbQskndLfWdkgR
jAj0d8Nnt3RdGx6t7ZMPL5uBuYanx5adLNZVR6qMK/TwZcggryKZ8VBj5bGqMivsjw01fHMA
tz/nSMCBUFWAt27OjslkSawEr0ZtFmQgBanETBGic6D3gHBhwA7MVtYwdhUpzr/Z3N0umY+B
gV+hs8DGbCh+ABFEwaLUIdITZHynuPKTZQXZY8DBz4fKreVp33+tAY7PqqxgHZhcv31d2/v5
OhQwtacBS/I1HYfUIZn7Q6ox6vaxp6/vs5AVlJqYQ1V6c6ftQ73CwIaQnH5P4MohY516aCZK
Zs1itYzospfodrmeajbhDY+bsqNdLVeBejSTNP3piuRuQRVXs3YbLal7DVHczfx1Aoj5ck0j
1otloLnlhgxMOqy+fLu4Xfuzv2PHHYeX1fndLbETe5s/H1M3y9mC/Pa6UXuXugd6Aq2vVqxF
ZemXetwxlv+PsytrjhtH0n9FTxs7ERMxvI+HeUCRrCq6CJIiWVSpXxhaW+5WrC05fMxO76/f
TPACwATVsQ+2JHwJEDcygTxsy5KmqbYViT+BbUn1pOlSebwaGNWynn6CcEK9JC2BFtPQs6nZ
rRBIB+6aztF+S9WblSGq+SpFYCo1NgDy+SgDthxfRgJiOMwpoAtvtgHwdO1lGaLZbIUmoBWN
JQoy3KUAfAJo3VDR8ZyTkzCgO/8SdSAS7Vb0Ylvv0hwZt/3z9vzathoNqltO6d6vtUWvpGS3
CpXIvazdrSabmbbBbsRRjA7qENMlRf+IreoFe8Zy/4JRr/b7JbSBw6ODEMg0kXOkny1WIt8N
feoxcaFok7Os/jSnnwrfjlpOAo5FAsAwMKoXAdibr+PNjOZOesLO+Tmw3b0hyA+cZZz6LCB1
RqunTgR4GzftesQw+eStx4zjqxrO7+2ywdukbe98SDyHqiXM/cZ2dmcZOsJiqqrPAonzZG8T
HCmICk2AbqOiwORJJ1HA0UvMfgQcm9hnBOCQ3SCg9xriOQGxrY0AUQ9kOwIrICoiEJs4AAQQ
RFQNEYopdkcicO3QJWqIgXPJfUIALl2PIJCZSAXwyW1OQH+hhjFVw6R2LaqGXRL4HkGflUfH
PvBkWkDbQeGBS6WGLjn6nAwrLMHUBOYhOVAFjwxO4FcCSjyXYGru8iikv7a/SIA9MGSjpXyJ
wHfcPZ5JUHjU+hOAT+42QpN0r8JI4Tnhdlsru2S8X8lb4Ompwsukg7Wz3yykCUNaCUqiAQnT
pPi90sSkwLRQ1MLnNLW3i4vomOazan4gvR3MedtzR21tkEwtH0h2/031FQDJPqO3py628Bk8
gx2HfruYaTKe2J61PypA49jW3qIAiuDBsUguCX3IeiF/pzkTkcGRn0p2cHf3sbbr2tA31IUH
wX6nsTSxnSiNSDcKK1EbRg65vzDoisihVGAXDqBkjhWTPAkgRrOOhcR1DL7C1l2ZdCC0wGee
+MQu3/HatsjtSCD7c0SQ7HUZEHgWdYRAOi1FAOKTN6UzAUZkSOqr4LOI/AAHUUB5jlkoOtsR
JrHbvB36zt3J+hC5YeieqO8iFNkmW6yVJrb3pA5B4RCstwDIc1IgeyclEBRh5HctWSpAQXki
ocAJz0fDJwHLzoowsqs+uqwT1KU3XU2uotfFsm1J+BRHjOxRa0rAWJtd3qr+zWYs41lzyko0
9ZzsSVAEY48Db/9p6cQbln8GKiqS4Aw+NLlweIMxGFQFspkizY7sWnTDqerRx3s9POSkRzGK
/sjyBs4EpkbpoSjRKnh0wrRT9PtF/tVKIh2G5RjU2BwyvNZIumUS+lrrWK6qZVl/bLL7Gdr5
MsYnFH7+qeqjhgiRN2WxFTjLd2dl/defz1/Qt/P3r4oB7FLqGChBTJ2kYIY7i1sUDPUFb9x5
TVVfK62tkiHtWopyXT1A6nrW7Z26IQn9xel9Y7esTTOT825hdG9RzxHE8M5WXtSKR2dSVdvm
B82skvQxd0g4k8mlZOmKFInQfbx4I6apF1z+5gq0ZEw3gY/mU6pdsAyIwEgJLzcFz7jJDGck
0lVOV1Ogz79eP6JfcmMoF35MZ9PV9ZkD04BjdKnjAUHprUfJhJd/hjvHGXZonq3mYiLUvm9w
oC/ys86JQsvkOkqQCA9caJ6pRW5ewXORpKTrw2M6OlS05BAGIpVS9BAF3mrHuplcKR4Xh6GD
5kgZIY5mZbSdhegM3H9cg7NryI6w7+if3pKYhnDc3tR2ijRXbySk2uSbigCL0tm0LLExXOBO
t5zzANg40U7p0QCEwpq1eaLUAFOhIJNeEZY27kX3V9ZcSCuJhbioE10pTsFaUmFu3YPFuCTn
DverXO26kUg1UFfTZ9VIouoCNvpYB7IPrPwNtocqJU8qpFi0iqS0KKp5pF5jr8m0XLPgAan7
O87b8bFOL3Z8WSMvH1dYliTW1CigUuPNTBTpkUfLFhNBFFu0DLvgjrnpAo/fyR/TmlQC7wJa
2hTgfM+lNlayIVFmTpN1V70D6uTowwo1dwChlCSjm+c/kZr4nU/eYgn0ElnRJkvpd4FBowzx
Nkv2Nuk298Jg8X2l5uS+wSJPoJfHCCafwX+/yG6wfGCHm29tTw41M8iQxiqPSqna8u1ykOBd
17+hxy2Ta3gkLGo33pm3+OpOhnWZPlLw7VRgBWcGs/66DWzLN/jEEvqCpCLy7EtLnZ+zgqFe
gTE9Np/Wk96heTVhw6DhpAmZhPvyrbtU8GZWivTIYNe4EMRk2yXYIb4GqRv/xiMGG6xLT9ju
ofAsd2fOAQEGot1bKQ+F7YSuZrgoZgx3/e1SfsePhyBJXD+KjV0+anpq03yjeq1O3io5l+zE
KNFcMEm68qyUSHVq0nph4ZBOrbFHuI/3TloNMdU4rg8cN/Vtlt2tHGDPEAB2gl17w+JsSHzr
PZI4pnVMxTYrnMyloW1SiJWJgBs0t2YtaYeo7ZDBoe6xpt3xeNPH6iFJY9fTKidbzJvkj7nk
JjuhaF6pYY3nxK1ks6EYQxn2VdHhs+afW4I+b7rr6I6lvXJZHW6lwWsHceuwUpHVAdbopG0w
FI3Oda0gCk4RqeWt0qiKdBKW+m4cGcou4Qd937ASzQLOe2SzxPMO3ShF7DZnESooxJG1WjTE
ppAjK0Es9X0KU82J1vRR2qByjEjvu4bhytsidkn1WIUmcEKb0SXAPh0YpDiJCLiDkFp3Golj
+Abq7O1PSnGOkp22OWElaDwrTFAQBhREyQcq6qvWChSNJiooWBR4ZJ0EFBhzxb5jgDQJRMdi
cvKOsohFl5nUNtSfxuoo8mND59T3YUxKUBINiBj00qiP198y27Tz1H0UWeRrrUYTkT0ooNhQ
tlB1RsPr3dJnSWILzGLJBmmLk6+Gh5YwEAWswLDsAIwcb39NAPPm24FLjhIyfY5LT6aR8XXI
Cm9ZaB1TGWkNtd39vZTifDWUNuORjkPVbjiZJLW1wphSVl1+zOWgdY1OBgkYUGz5u8ibRCFP
s6RKtYh6eTOU2QLRN94NCqTvkwTvkXzo3/0QOtB6l4aVjxVFJJGcWVPPJPLQ5LgVZMPlkL73
lRuv97+Rj+qy1CeahPOdzGIo+jxRoyJAKgP5qsGYJAaPDs2QlUbonN/8c2rwVDJWdw9Dn2Im
HLrMFCsQc3fApBmiJuQN4dRTmXzXvjJZbGNPZmnDOoMzIhjnrskY/43RPBYQTPaZe/XLT1VT
F9fTXgtPV2DlTGjXQdbcMNBFVdXClkidIaMxs7lSo5GfwR8QtFt4EjSihnKhOrdDdRvSnnq4
FgFPheXK6NxtfbH4+vzp5enu49t3InrimCthHJ1LrplXkUTgY8igoetnElriEbTom7FDD5h/
hbhhaBRI0KmNShtz3XB3ff9DSEXGiJngquwajJLXEB9YMJjO91c06WGko5Q+T7NqephQknqv
cDAEMnqOVOKSrjCZZXR+t1RnRFja73hEGWlGEY7nJfICrDwZPICIjxwL1p4xtM6QwG+UctVI
9lCO/hYnjwE4pagAp6LLRGDhd8cEnwX3qOC7i/X+HE3WSMgz7sC/d+mESdYeEU62va+O7prH
dfT86Y7z5B8tviJM7pWU3piCtsF4NBzdWJkmzeF6dDR3t2s6MT1EOrS2kn2kSDk4K4pKcu+A
g/X0+vHly5en73+unsF+/nqFn3+H6rz+eMNfXpyP8Ne3l7/fff7+9vrz+fXTj79tRxdnctML
b3xtVmQJtXDHeYh7r7iOWgzjs9ePb5/ERz89z79Nn7/D8KlvwtvTH89fvsEP9E62+A9ivz69
vEm5vn1/+/j8Y8n49eXfyivsWIGuZ9dUdlcxJacs9GQ+dUmOI09hyScgw+CYPrV/SASOpRfI
29r1LKLApHVdi743mgl8l1S4XuHCddimBUXvOhbLE8c96Ng1ZbarqrmPwAOPQlLDd4VlLehp
g6qdsOX1bVuc4AEP3RGEr61fsiZtlzGUZ9aUlbFAC/UqiPqXT89vO/lgT0SbDGMTRtzd1hUB
L6LP6ZUiIFVZVzyienUC8OQxZj50kb3pWUj0AyIx2CReWksL9TNNuyIKoNYB9W62dHRo25v5
OibfNrMKby1gwRALY0J2W9n1tW9721Ix2adWW1+HlkUJXRP+4ERyGJc5NUYLzG1pmE5dj6zw
tiP6+uY6Yj1L8w+3mSdlF9K3G9F/IbEmkpvjR6plqlTw8+tOcU5IjpKsBS9N8pDozxGgnxtW
CtejHiwlPDasH9+mLtpmPHajeLMVsUsU2UQ3dec2cqxtNyVPX5+/P00HxTYsxVRo3eUl+l8s
Nh3Gc1bXE6J98pz7Bm+o0xHGb45NPyisBGRwjxUOve13MZ20TVhg147JbC6pgTLCVe8E1AGG
6YYwySvBzgYq4M2Mq3rf8DVI35tvgoB+xpwJAtrqeM0fbhatSPXp6hhU9WeC0PHpJ8eFgL4P
XuDAI6oTkpUMQ4o2ilQL7Dk9DkiD9hX2icJsN/KjzZ7WBoFDzETexZyO4ibhW2YJk23bJsur
LVJ5e8E7S1ZFX5Ntm/pMr0QXlZJd4thFwOQMZ9oNGsu16oS0WxwpyqoqLVvQEB/weVUY5AtB
0HzwvdLc/Na/BGzDuIlUl0j1suS0OToh3T+wI73P6alZF2WXaD7KCthDtzqL827tRw51gFxC
d/f8SB/ikLQgX+DICodeuIcUtTh+efrxh7SRb44VvO43n0f4Vh8QFcW3IS8wnLIvX0Fk+Nfz
1+fXn4tkoTLIdQqLzbU3gzMCgn9cRZF/jKV+fINiQQ7BF1myVORpQ985L97JQcC8E5KXTo+S
J2dw3IhNbBTdXn58fAap7fX5DT2Iq2KRfnSGrrWZQdx3wpjoKdMb+lRnjKVW56lu5iV5/fp/
CHJj6+tcb8calEPH1Eua7lqK+5lxvvz68fPt68v/Pt91/didsgruSo9uk+tC1vWQMBD4bBFB
yYRGTrwHKpo9m3JD24jGkWyFrIAZ88PAlFOAhpy8cyw1Kp6Oko9VGyLXWLwjiyAaZruGOt93
tmUbOvGWOJYTmTBfeadSMc/S1DDl2twKyEra1W/Jws7QpMTz2sgydQYuU0WLajP6tqFdx8Sy
1GNzg1Kiz4bIULPp4w6NZp6xT48JsLEGjEdR0waQ1dBZ3ZXFypGuLkDH9kNTg/Mutml9NYmo
gWOp2xlu17IbyjxImYfcTm3oOM/QNQI/WGOA0DXkCbHNyPvPj+e7tD/cHefrsvm2qnt7+/Lj
7ieKiv96/vL27e71+X/WSzV50zMVJGhO35++/fHykfRizU41dUCeGAYika4FxwScshgAof2n
LQXZQ7B9yDt0DVyRNjuy41T4Q5wLQ9oqeteYntYDu97maCrk2SLIhH8aTjmFRzi7jSEN8e01
a7tW/faYuc2KI4LrMCJ24e0UJkSeJ2suqB9vMeR5XRXV6XFosiPNxGGWo7iqX2ycDJXFODYD
zKB0ud8lOoW+GEHwlPFBWLqMtf5Tb40Jw3ztGe+6KbRfQgriKT3dLNy9be5UpSxjFJzQUp3e
zUibF3ZAC8AzSXmrxaEWk/HmNlTTnY/ETJiqOXJbDd+K/KKTKli/SnwWmVStZsOAr6GfKRFm
PNWCg8xmYHf/OV48J2/1fOH8N/jj9fPL77++P6EinryY/1oG9dtlde0zRkcmEX0X25TALwb7
lGnLs4eZo49izx9OR/qOU8wnzmhnKghe00IvjrX0c43YHU7s5BiUPBFP8qa5tsM9LC3DB5uE
NSAwDOeU5/qXBVb0qXnh3t/oV1XEDlVypngCxGpWCh/nYizTlx/fvjz9eVcD2/1Fm3OCEPZT
6NWsaWF3UH29rySHKhvOOapJAQNOW9qsxLttGklGNnav+sMxyx/RGPT4aIWW46W5AyKllar7
5EiaY+TFC/4ATtROSJKyrAoM82SF8W8Jo0g+pPlQdPAxnlkqs7bSXPLylOZtjfa+l9SKw1S+
upW6IGMpVqnoLlDUOQUmJqZ7tipynt2GIknx1/J6y0vDyTVnQLfuXZach6pDRdKYbEzVpvgP
mNUOGKFw8N1us5JGSviftRWG5ev7m20dLdcrjQtozNKwtj6g9304PKVI1nT5DXtM8ytMdx6E
dkzdJJC0eHNKNaypkoto/Yez5YdQ01hlnWXK8lANzQFGNDXEOpImJOPtFWZbG6R2kP516sw9
M4rBJWkD94N1k5lwkipijGx5m+WXavDch/5on+gmj5pGxT0Me2O3N4OlzIa+tdywD9MH8tqM
oPbczi4ymUOWV3YHHZ/fQOoOQwMJPqmx5OY5HrvUFEXXXIvHoexc34/D4eH+dmJ0g2G11Bl0
262uLd9PnJAW8bU9UP7goclTWTFc2vNmRNlG0WT5++enj893h+8vn37XT/EkLVvBUOps25Uf
BH+aMhMHhdvmgFpa2gbGMbD0Oa/RF0la39By8pQNh8i3enc4PqjEyJbUXel6wWYOIdMw1G0U
qF6xEASuCP7lEW2eN1LksSX7Xp8THVfbALtzXqJ35CRwoUW2pV7SCoqqPecHNj237XBjGiF9
xS4IYR861h5p4THhbRn4MC7RhisctYFgwrLyFtCv1DpZGN20nljQtNbLF2HmjA9LYm4s/ME2
cWDnw6C9+stwMsXQ0ib6dpaqlcq6kvV5b2prk9Snq94QfmuPtFLayHfZztU1GGcLvu1Q3cR9
nGn6i/jpuszRpTu8XmMbrFUm5s1cF0MAOzGpWc9O+6wJHMFZ2Qlhari/5s1Fk+wwpMkUOHba
PY7fn74+3/3Xr8+fQRpIdfb/eADxKEXXe2s5kCa0bB/lJLl3ZilNyGxEdbFQ+HfMi6LJkk4p
GYGkqh8hO9sAwOadskORq1nax5YuCwGyLAToskAgzvJTOWRlmqu+GAE8VN15QsgxQhL4saVY
cfheV2Rr8VorFD0jLI4llyI/nSUZHFI57MSTTNpqVUQ+GRvVATe4kbKUof5jjrtGKJdhdwsB
wtTMmtP6s5jxEfgv4JCoDQ9g1iRalRls8Rj23lRgztvOCMK5ZYiHgGDWUl6RAMmOuVaL0uRx
FrCzYb0CVMEZbwpUiINqp8KhgP4xESbTVGaT90YsDz16H8O5lUXAd9LbDs6aTegD5aNmuR3H
qHs0bWgjaoJaWiUZkc1mpqC5ce6Zdkjs16yCVZ3TLy6AXx4b2r0CYK5pO8dPVlVaVcb50XfA
nhgb2gGzlpmnN2tonW+xyoyFgoDOc4OOO8AiZrexb3mbXM2NvaaUPyKcewc4S2+dB2KjNp9n
t910vsmMUT60cTpmyI1X3FhNDOmkeYmT54d4bFKr0YJU6Rp8KIh2hzbNhJNnoNgQD08f//vL
y+9//Lz7jzsQhGdb0I16NwrJQq13sliQa4bYrOhKtGbZ4/UCNvgaTWwpewVHs2qy7SuRcCC9
WwdhEPVQZClVgZaBnKXIO1LRaR1FAb05aVQhHTlAasnoDZbIbwihImXufccKC0l2W7FDGthW
aKh+k9ySkt4ApdIzOnDNO9NEeSrWTu8JEmz28hdw7Epwdfx7EHcwcPiTtzAShTgT1bImJCmu
neN4coyZzcPH8kheXUvZKx/+OVRtq6lPq+lDDUxYwXLpsrRVSimFpb9syoxJdcI3CUNWpEop
IjHPktiP1PQ2u58XjVJIwx44nLNqItQUnxvUEnh+yxqEtrUYE5eBkJIHNIbJS9JL6kQ1NvVP
NXv6WDL0xiOsBgyq8diqUWF/gK1VN4NQa9NUGFfXUIseHbS0OC552V3UVmsRWZakOZMKJV0x
9KzI09kbnZyNs6E9Ha7HzcBcMQpho/egGLEr54+GWi8Zt2OCWXFUh6zP5PCRMqZ/jjAuUAYq
14eIpXYU0Vp8Ai5a13D3PsGetYvnvmdQgxN4m593Bhz6P78ZAgossJARuJnoGm0izWmwQV6e
YcO1pYAfDM5tEfutc10DJ4n4oYtCg2NYnIPMsi2a3Rcwz/+Ps2dbbhzX8f18hes8zVTt7MR3
Z7fmgbrYVlu31sVW+kWVSTRp1yRx1nHXTs7XL0BSEkmBzpx96bQB8CISBAESBGyhqPjSr+5g
B7WXzmeTlX1WAL2wxayNZdA5+5iImHT8tMROU1Rre+89loXsyqRseLhdKzpkd1eLi+rpA6+u
ejtaVG/Hw65Fa+1C/NpxvrtNppbsDjFGIfMCS9LuHn1lzAWB9+XTGuwz31Zhp4ANZ3yzs7OW
xF+pIM7H06V98gT+SgP5+HZqX3SIXtjR62hlOa5H7NbL7cIIkXYpBDv2eKCSm/grTMVD0K0q
+7i0BPYu7JJsM55c6UOYhHbmDKvFbDGzPPrjnM38HMwcS0hpoXkwy6s8RMfRxOI0L3auamtJ
GIPqT5AWgcUK5PjIn9q/G7C39pY51hLMTOzEllhWHBnky5uxfXvlV377wLkyrtdsaq72BGxl
jTDe4z/ZJbnhmuR26bGvJpagoIi9i9bGdsRNyq33C3dc0IJF87XCBMOSFkZX6h9GEdC4+SNE
GNZv/m83ep22t9p8WQeZfwgsAb7EPNAHKYirVkPv323gDQ1jAKrqGPzs09YVmR9vCjqoJRAa
D+0loiRqlIbxoEf5W/NwvH/mPRu4YmNBNsML216L5DA3KysCVK/Xqp7I4aY5rWNzMoUCR5U4
a3ojjh/ugliHiUzyJiyAXyYQTAkWZObAuEm5sST3RnTEXOAdSgtHLFgWXrDz73KjKe7MN2hJ
vMC1VAVzuUl41nf1rqiFiZFVyP0oR5jWLD6ATSID9g26p4M2fuQE2ZBD1hm9zhEJlXBfATvB
nX2WDyw0YlcpyH3gH7g4Mzp5lwkrSoMGmLTdABW++SVfmGOJvYvY4hDEW8v1hPjUOA9g0ZG+
dkgQukbmTQ70PRMQJ/vEgCWbYLiaWij+SLUbyA6zpjN8IT4rIyf0U+ZNDCqFZnM7u9E4CIGH
re+HObFk+flwlJRkuHdBEOLBpP4VEbvjz/fNyeBhNzbWwQQzP4P9Y10YtSUg5jOTc6MyLALO
hzo8VgP2IiDJCn+ng1IWYxjyMMmUiVKAxECkfsHCu5jeIzkBiBk8y7IIh5DF3J3CNcRDmqEz
lg4D0SS6rDUgHUusHeD56sIgps/HOUXhM/uyBizwAGwM5O0MpyjjNCyND8h0fzi+XtGHCMxy
6jaJ1xOBEvcluZOV9TulArexOV+1wZ460+OoJM19fyDP0JVhQ50mC2RW5oXIKa0WVOH0esLS
JW68dZpPzTYPQWCG3FGwVRBHhkT45meJPr4tZCDxv915sMmay06kx6i3pUPCXfgaDN/Ff5m9
ZWFq6I/t4xdCKejyl+s6TFchxtnYknfZYqV47W16W4dzArL0fLqcHk5kQgOscedQNSKGCyj1
mPaTek2y7jC39U8mdTP0/2i1KcVJWKPt9E+1VqWnydYNbLfaSnQSHQgbuZF8BKEYGgUUeypo
JqLLMA1qR19gorI4tt0LIJ5luPuwvN66ntYNvU9aggNeLo6TMnb9OvYPShwq4rkYjvrpDT2O
B1Pc5izBw/7A4s/L6T4/FOajXWzqwxaEaWhUZtA4Ib+yyAu+drTPglHO+TDz9Le5w2fnRftw
jDdSgvTlB8Ihu/ttovMmrtKe20/vF3S7vpxPz894fWbq2XyOFsvq5obPgNZUhdwj5kX7Tg73
nI3LKM2qoxjMmYDKuzYd5bdNvQygWZLwgaqLgihTFMgBOajiHoHFLgxrXOchAd0qF4E6OqnK
yfhmmw47iCmxx4uKGqQ1zDSUQpSdYWS7VoKSIFDR4+mEajsPV+Px1YqzFVss0EfSXjmOh0xl
oktagPPwQZFxi90xnbijHbnP9+/vNunKXGp/5EsdL0NUHReBBy8y+1FEQ5Myhh3wv0Z8CIok
Qw+Gx+YN3xGNTq+j3M2D0e8/LiMn3KHIqHNv9HL/0b5Vun9+P41+b0avTfPYPP43VNpoNW2b
57fRH6fz6AVDiB1f/zi1JfGbg5f7p+PrE/WYly9Lz12RTjcYdC01bu0EbE8tiR5eo2jIf1sR
yBg2ZVD8xjoKU8kM6io912CeILUGR+aywovzqT43HFRvmLfxC5MTBQ6bvlYfj4F1yNSwj3zQ
OLt5mdlFibBXyvF0hzjKw7jNWRIO2Td9vr/AHL+MNs8/mlF4/9Gc21mOOGtHDOb/sVEe2XKe
DZI6icM7XQR5B3dqto+wa13neLrrHPV3uy4EfRuhS5f3vKKBdBY9Y3resA6RrIm3FyYZ5dDO
J3mLz6h9ZvCNhELdFsRAfHeYId/2uCuji/J6ubjRP1wCBxpIj8AkTDjmZpMtgZivwbSQtPYJ
RP7CybKJzGG4xK6YrvFYyvtRsKDPQyV2QsUH4sLaK4uyMlRHf5/7G1Moh/4mKayZ0jmFdcNp
w8S5d0t3MTV00jueyMtsLvBshwV8Cy7wJjo0lV5+Ligf4/QYDq2jNagHYILhA86NrzMfqIjw
Z78x2Dg0dIIiY6CX7gMnYyIHrdrf5MCyLDDB8h2nPh/bHFiKb7TroCpKMmyeYCx0flH9+RF6
BwUqQ8v5xgelmuhgVK3g72Q+rhwDk4POC/+ZzvWIUipuZkQF0+c6iHd4+eiLd6xW6cCSXDsq
5LNUGCoiP3AQJzA6a1R4AKwXLn22Cf1BFRX8g0BFQU6/f7wfH8Dg5LJ+eA7NpftW4ZM4SUVd
rh/sTYHAA57u6eS8BdvuE27ZvAxAQsQ4d61FMpRDU5nWVjElLV1XS9IbiRRX17Z5lQTdt/1c
75KOp5E4DniOfNAtFImValUdlxHYjes1+ltNlHlpzse3780ZPq83X0yJtkbmtKlVnQYu9gq1
BxmHGRzdqsQ2tbRiEz2mGVcn9liVTQ0B5NTYU/KY0PY4FOrh9sdAY8Fe2XZWBwqJ79N1AHLf
R2LDn4avtMibz6cL+3fEfjGZLA2xIYHoXWRWyFGW/OZ8/JMd/c6XS6nN5MZuiUvmqQIQLZTz
qdDuouhOas76giF5SpPlgeMmUZrkeLSvzVBZ+7gDmUDjhQ1nuzp2Dbmzrv0hKN0mMFBm2bx0
cr8wac0Vtq5L5k7MsuXeNcl0FzsB2wbeoC/S5jLOgfC/64E+2MKvxW/W6AxbjyZKHN82oR3N
YGA7jBhfumbAyWH9vBdZ7Fl82/UqfZv12pHI6bV1KkJn4ta0/LS9dR2iA/VnbUpGsdUBPEN7
ihB08lnV5y1yRqQnRbKfDTngQ7VWk5UVXM+s3W6xuX98ai6jt3ODgahO783j6EGNNTDQhfGo
26bsyiXd0UuZY46eKrOKrTnsAPqEmZDCzkebIbOLfgxEQRm7eFu5zo113sGp7inYQS9pMsK9
ne9Of4ePN4SoUOtAj1Gpqrzog9DPtXGsgGkjpKC+0myc7CzeawIPkqmO7FO0Edd+1ikSHGwU
8ZwN7XIl0AffcZlt1vFupxsIbe/6nMOVm6S7lAy3wlsAy1PGutH5CBG5zBuKB7Xqh0URHTM+
wlTnO41Swmypg5uX0/kjvxwf/iQyBrdlyzhna78GY7CM9PzBeZoltYN5u8kRjvIhctCu/Uh8
+BVFsLYySEf0hV8kx/XUEkG5I8xoPa7H+yzE4A+ajYD3G3groNyg4x0Bf41CwUQke+15AuKc
DK3EGO3r7QFNrnijv5YQYRF9whWHl2esGE/0EHoCHk9vJvNb6u5V4PPpwkjoLPrjRgvD1XiA
5k8J9GL8HQ2l8PdYRS3qgdNBB3iQRPo4pMPfTugZ7QhuyJSoHJ267HbYGQltU4rpNdrzC/P2
MNUnFV2yw84Hn57O51XVXugNRgCTYlNbWo8lhg3AZGI2iV3N1dgNLXC1GHIOHwpLMtGOYEEG
RePoPsPfgLc8sD7sfSymczX1lrhycxnmVzKhoTu/Hatv9jl4mEdMAd+SrDaf/2XrT1JMbm6M
lUyk9OXwXeFNgCsHnBPk0/E6nI5vrwynpDEcL41lzy84fn8+vv750/hnvvFkG2ckH1b9eMXo
VMQN/ein3uvhZ0NwOHgIFA3GROS9tfc2CiuYYDseMyvaRjQO3OXKqQZtioS3cjmQg1Ccj09P
Q+EnL2RNedve0xpvpjQcGAH5NikGM9bio4I6DtVItj7LCsdnxfCDJEX3BO6zqty0tHwDAz1v
HxR3FrSeAlFDtZfo3GWAj+Tx7XL/+3PzPrqI4ex5J24ufxyfLxjZjCsvo59w1C/3Z9BtTMbp
RjdjcY5xEyzti6w91gFOGbDDZ+MClhomrLGNb8p9Yik/Mn0M9cMA5rqw3QYORpnS4lME8G8c
OCympt73GKbQStDfIHcz1UGAowYuG1nh4rmFDojc8WyxGq8kpmsacbYEN17EekeKAax7kNbV
peD2tLqHt2WDoBX4HM2PN1rQCoR1+VRBN4n9UO9Em+RegSSKkxLqTRkDTW3jRWpYq0PNqgCp
9bAGeQhjGVE6i9B/A0AutPAzqbutjRI9LqysOP5gd4v11dEmotZnT6F83oH32TgolFBtCiSh
4ckusdu8rLV6czCeBaCbHvf52LxeNO2X5XexWxeDj+rH3og72U0o2C+9sxWAnXKtuN60ncDa
8UhZ6deBQzVbShYn2wdEF/9Sj04mcCAxLe5lRqc6/imrwYXQ1pvNlmoo2CDCsXGDAO+wFJe3
YrzYqWkmUx7rRajYsJPnuZZAOJVx8ZKiw/3zn/0X4MUTPkl3QmBw2idRJaFkkoJvbQEdoxjZ
+klHydO50a0iLsWERxs/DrKvlHkJFB4G5BQUZsXMpx8sIA42czexRKPgDbsB9YxAowEZTms/
vIKszC12PmCj9cLykAmF0vVkWkCANfjxMG5mdHw4n95Pf1xG24+35vzLfvT0owHjk3Bh3ILJ
nu1Jlv2slnb4N5l/56junBJQ+7liF+QFg5WqyXEXA4gOX8IEYIy8X6RXS2cTioCgDw8NmM6n
l6ZL9dVG/tQxgvr1/vn0xKMAH5+OF1AdYfOH6gZlr9GpNbXo34+/PB7PjcgDbtTZLmyvWE7N
GDR6e5/VJlOvvN0/ANnrQ3PlQ7pGl+M5ff0BqOWM7s7nTch4cthH+CPQ+cfr5XvzftRG0koj
nKSay/+ezn/y7//4V3P+j1Hw8tY88oZd9YO6PoO9NFUPpP5mDZJXLsA7ULI5P32MOF8gRwWu
PmL+cjWf0dNkrUCk0mreT89ouXzKX59Rdl62BOMrygMPVaJPb/uc6f7PH29YJbTTjN7fmubh
uxbYn6YwlqYIx60uUJmrIC2nuAcN5cz76aF+0HMDGev19fF8Oj7qmzzGTqY0IDV8AAYqA0ut
4FGWWar6PLd1mr13EpZpp6KgmtWgli2NtMn9gMqXbvYz4jaAjVSwlbo3eb1ONwx3U2pDigPo
fJ4y5WJLGH+gA+/qKowx6Mbu8E1/kRTR/kOtODW0/BaMfcjUJ1AtwngR14IH9tqQIqFu53ts
l5LVwBhPhFowXsQT/WgdVa40JQJaetwPgqjB4t3dokXqw0GpkpGpTjs0PwMV0d/v3/9sLppn
ZRseRce0dVRBiHo/xp1bK1brOvBDj/skqLlJtxEeYmKbOfdf722KzK0kRk2M+qIWTLMETDlf
s8x3qWsGWNOuAA78AsNhFjXrYHkTKpeXX61ZUVuCtn8NyQCEMTpj+LGHjzVSdfls0zHpPVGt
FkryT9MmZBj6A1ds6OvhVxCx9SidHR9b1iFLi0QPc+l6DiNNUT8MQcw6QaLoMxKYrFZG5F6E
Zw4VSntdfgkKsIK6pg14wZxQvXTapMDlibuDAVsz9blLyq35UIN0Q6Dq9jIk8vBbxTuYHF8F
p9QnC8sT9MgwUVy5+MDRY50G9SGizD58lFRgiHDRh48eLqKiOkWdrXeBmiCuRZnun7wVN0qp
AxRpKscFMPuk3vMTIjU9NEfzd6B74zG4RrF3Cu2tiazWtN80bBoJ25gmcaI6K6h9pErG89oH
Qa0IzTZ+sskhLfzrWAunJrwEN1FJHUuLzmWqbSxA/KUZQGKMgTkYI/yagBzivMzWsKhQzExB
OBWF+gRLFoZNrsDiPSIKK/Uhg9Gauy08F49C00MGQ099xsQV955QAhgpLgKmP3RNXWHug+BM
S+qcXagMy4U4tekN40icbGk7eLu3p0FKya5o7dX4TLP2XdWOhZ3W7z5SY1mBgwIp3kpTVXYU
hXbAPmxFAMwNrAWH5JS1WJiyIjHq2jn8sS4VN7QtJhOHaB/UtoclHEZt1C3J3nGpkvxwzrJl
tDRCPG1L50r1MK2q9wEHw2aW8nfEGzNpeBiyOKmuxdZLYAj1EQ93+C4DVJtdqQiuLdv7XGNL
Mx+UOZ/S5tpTJ/f08gL2m/t8evhTRA5ES6U3ZrCabe7tSI1Q3OCslPROOvJ2pmZ/VHDZbnWz
IjF5MJ/OxlbUXEuBpCPJVHI6yWxmq1nPgKrgXM/1l5YwTQbZ7YTOdqeS5ajr1C71EEwh27v0
uMkM7ZHU6ltLmJ7Djh0OeRrEeM/fTTqnzE8/zg/N8P4aGsozWMaryXyq8Zq/L0wo/1nLuntK
J/SI8lir7HvL9egJgA8RQJwVi5mjfRXVSWXBsCB0EnJbgfEqlXN/oRSjPXx8GHHkKL1/avid
i+L42WvJn5AqOwRviRAX0tJ+OV0aTDhOvTDIfHx+jPHuSCueKCwqfXt5fyLrS6O8PV6ja9RK
dlsPRjxEhakdKBjw18fD8dwoNxECAT39Kf94vzQvowS47fvx7Wc0yR+Of8BgeYYF/fJ8egJw
fnK1zrbGMIEW5dDGf7QWG2JFXNPz6f7x4fRiK0fixdlOlf66PjfN+8M9zPDX0zn4aqvkM1Jx
lfefUWWrYIDjyK8/7p+ha9a+k/h+9lA1aaeuOj4fX/8yKuptvADM971bqmuMKtGdvvyt+e51
FTR81pn/tbvPED9HmxMQvp7UzkgUKDN7+UqqTmLPj5gaXVMlSv0M90R8KKJbMgoJWvE57Hyk
CFYp8So8T0FPJA0ppUaW58Heb83q9nsGT4L7T5dhHPsLyAq12HZA/L8uDyCm5WvPQTWCuGag
bX5hqjyViHXOYD/VtimJsRwoSGxnd0xnt8pOLbGwS49n8+WSqBZQUyNrNEHCXTjsradFbKZr
l5isWN0up9SNmSTIo/n8ZjLocftuZDBAgHA7rbTX7kHOZso1VaCWhB/yMQUFq12HBKNDWBKj
s51RbIcHKLUWORTB8r4bNVmiLfFfVVFUygxIeas5LoiOZKJsSHg31L7vp609QSHLDvYs4qai
teS8KpzO5mYKWBWrPnmQAGkMSKATsbHOwQCZkUcqYGoA28hThA8KyqtW73aZ7Q2Fx6Z0ThAw
M70bZU0IgJ5ACkFkvhMldIfoz1Q7t+QDXbQoPF4j6thVuXfbfx7/qQ/ZrnK/7MZ63k53OtFT
TEcRW87mtrlB7EJNUwOA1Ux1fgPA7Xw+FvfnJtQEqD3hGVW13OkAWkwsQiMvdqupLToh4Bxm
3gL9/2/JOjZc3tyOM62LAJuQ+bEAsVDZQfyuA3GmwDIWhuqRFqBvbxVfN9cdg24/RgmuOCGE
8USH+PHeD5PUh1Va+K725HFbLfUcrximtKqwPO3ZVbiTmSVSJset6IngOPLlFm4H04Xmkod2
3MKSTiJy0+lsQjvpxvW38WrFv713zmXlcqXKdO7NsWfCPT1Sr1I4Jk+joA60Knr4XhvWHg5g
xXrKPb6lRonXeT9KTMFJb0Qiu+6TODSHFWfJXL5ejG+sE7IPUow2DSLDJNHVsIrJ99j/7lUu
T/Q68ttksIqsyfzcZeZ7ar16pbBU0t+eQZkb6OYdVLTxvXnhzyZzkadbWVxFyPDhTh+zqBPT
/kL1BBG/dcHmuvlqrAiXgH3VxQ9WGmT8Rm2T6vIuT3NLdOL9t5Xp09mak+Zn8I/bHh8lgF9j
Ckv6H1pURSnjxf4rHYNpdLshKze/dP3qnh7l3VG3GB9hbOVpW67rU6+ZD5BqhbDp6BXSODnY
8o5cMB3w371gFdtF/fzGkkYMUFPL9guo2Yx6Kg+I+e0E3THVSIocOs00gHbGhL9vFwY3oS8N
U+VumhQc0m/u+Ww2Uc5/osVkqvqbg5ybj5eG5JuvSI9vkHuz5WRuyA1obj5fUvRCaojuKF4H
V0a9cyl5/PHy8iGtM5UJBrh/iKRIzf/8aF4fPjonhn+hv7Hn5b+mYdha5+JohZ9z3F9O51+9
4/vlfPz9h5mX9iqdeED7/f69+SUEMrDLw9PpbfQTtPPz6I+uH+9KP9S6/92SfXaTq1+o8fPT
x/n0/nB6a+Q9v8bMTrQZWzJ8rCuWT2AzJ9UpZdFv7rJEqH0tX6Tl/7H2JM1t7Dzev1/hymmm
Ku972i0dcqC6W1JHvbkXWfaly7H1EtWLl7Ll7yXz6wcgewFJUMlUzSEVC0BzJwiQWMYDauje
ANidqL5GyZBH4btCi+5ZfbkeW6lyjQVld1vxusPd99M3wsZb6OvpIr87HS7i56fjSefwq2Ay
oZlXUSccDPX3xAbGJ6NhiydI2iLVnvfH48Px9JNMWduYeDQeanvO35SsYL/xURTTDNq1AHzo
QFeygWLLYjQih5L6rc/epqxGmpBWhJcgBHPPOoAYaVmrrc6pbQ7764QuAo+Hu7f318PjAY7p
dxgsY72GsF5NGZ+s2bSYQ0McSsA23s/oaZvscG3O5Nqk5hkaglm0URHP/GLvgnePPy2XcndN
ORHINDP2VOM7qoj0F1z/M0whr8kJv9oP1Vi3kAiY+4DYNovMLxZjmutWQhZUMVpuhpf6XQVC
5pz258Xj0XCuv0YAaMzJwoAY665BHvpCcUsGETP9kWOdjUQGfRODAW8C0Z32RTRaDIacj5hO
MpprHAVhQ8fTBVVyI2fgUUWQ5SlZF58LgaHoaU15lg94D6q2fZ3vWaeo5Lp/1A4YzcQrDPYz
cWYoaZALps4kFcPxgGgKaVbC+tDGPoM+jAYIZbf3cKg7yiGETWwK2u14PNRl2LKudmEx4shL
rxhPhoTtSsClNpjtkJUwfdMZdwMnMXMymgi4pJc0AJhMx2R8q2I6nI/Igbbzkmii5ehWkLHG
h3dBHM0GrJ+hQl3SAqLZkCoHtzDuMMhauBadLSjj4LuvT4eTugJgGMZ2vrgkAyZ/61r/drBY
sMyjuVSKxZqI9gRoPmgDDLgQv97IdsBPgzKNA4xPO+ZcV+LYG09HE2oyr5iprJWXDNoG2ZJB
ZzATe9P5ZOw4B1qqPB4P6bTqcJONs4OvpuX9++n48v3wQ7t2kYpNtdeKoITNsXf//fjkmlGq
WyUeaM3dSLL6l7ryrPO0bGORkzOIqUe2oHVfu/gDDVifHkAIfzqYirV0qM+rrOQuTenk4Gs/
pwPytWiC6svzCQ7GY3/t2qs6WiAZv4CtQy/gQEOZaEoMKCZwBOgAbYuXWYTCGqeIGK1gWwg9
OFF3vzhbDAeDwbni1CdKXXg9vKEYwGzgZTaYDWItQNoyzkbs4etHG2Aq9K0oKwz2qp1LjlD+
mTaUWTQcTs3f1t7PItj7HM+Oi+lsONS97xHiupQF5PjS2t6yrTxUF8fK6YS2fpONBjOCvs0E
yCIzC2BubGtCeqnsCe25qd5EebOGbKb2+cfxEWVbWOIXD8c3ZZnPKF5S4Jg6kvBgSrYcQzAH
9Y69V1wOR3TBZ+ic0f3KV+gvQC8Yi3w1mBDPqf1iqrE9QJPdsoum42hgSbG/6Nv/r1294kyH
xxdUutm9QtZ2GcTECC+O9ovBbKh54ikYK5eWcTag993yN1mTJbA0Kn3J3yMtTBTXzr7upOSN
c3dxUC8d+Ziza830SZ0U+dXF/bfjCxP0O79C8xHN5DCqVyFvVGGV0xWTCW/bmDP37Efe45aZ
F1oKd3doogU+fJ16JWuJD/s2KKk1NHUtlbhl7sVFuWyub9laFKF6xl1fnyEpQ8ZNXG3Ozc1F
8f7lTb7m96PXuIjpAfsIsI5D0MN8he7HxYvrbZoIGQURyZiO48eYAAQjjpdpnqvshv0kE7T/
6xKKEE5gzcUDseiWGsb7eXyFLXEUgckwI9IPoxHZXtSjeRLL+IyOIjoa7C/hPNjAzBOZHn9E
VioyGc6qjv14NqP8BrGpF0QpXsTmflDoKPmIocJFmi0lKGdLS8CD0jUwv1VrJzDC0vTsTVsd
5FM0qeCDlsfeUmMy3tL0qdVwhu2nWpOHVwy9Jznpo7oa0jz92sadISMbQDijEk2smnv3npZl
JH6e0uhaDaBehokPMieaC1MOo2HZbKVGAa1PwIcvR/Tr//jtn+aP/zw9qL8+uKvuXHfPuRP5
NEsJGoVygHobB8TjJtnhz5/aT9NotQHiu1rhi7i1ZdlcX5xe7+6lFGDy5KLUzKjhp7LuxXt+
dun2FFB5TdOgAkJGJzTLK9IqB74AkMIVQ5iQdQEhHHU3ZKsyFzTrrto1pZYmp4U5V3tHgFdY
Tpt3wK/LjV0VNIevLi44d42+NWXIfmaFGehvIu0JbEtFDzH9QJXBAjJcjG43Avyqjtd5S+7t
OL4hqZR/lBWNYJUHwW3QYruxaZ5MM9xFXlplmlORLC8P1qGegCNdUYyrHf4q0sIcNLB6FXOm
YR1arCr2Mz6owKogcRjgR5uAo05SP9AxTS4b3biJIFTmmL7iHiNksF9+XoAKZAI+oqRELgM0
W+Lkw6CzCoU/OeNECu6OBnSFgFnay3kyLwmYMGYVGjisLxcjcluLwMZDhkCk8TB/p2A1I4vr
NCNG8UVIbyfxV9064xFwFMaaUxsC1NHrlXlk7rHcUz4qDqvvCkn4lxrdBlA93R3RxVWewdRU
0hPeJqivMe2VCpDSN65JYA2cq0DzlIKaiwEoTGOhScbBvhy5XOEANz6Dm5zFbaVTjYwu4RBP
wwIPSlchny1Uu/clgg47Qq6qtOTDhyAWgxzCivJ4YRopHClKEZUmEcblkIFknETXIucjMSGS
YbmtYL0qnMOfejayFbfL3BqFFvaLznZksIRAv8Elu86Nly+bOK+SuhAwozdnplRRuzur8KKA
eedHu68uWGGO9nDFNysJozPjthq5VxW2T3AOAnTcqBUp+gvoAWFbmAqTCAyFmyCMzSJdIFSc
iJZfgSCH9kY3DjzGGU28/CbTE9ADGAdDD4DUAZ0xyHuKZRUC/4UZDNeJwDD4BS08SUsYaM1s
UoFY6UJipL00KUPYZbSwhkOhdWocFsBjE2685Paln0sAet3K+PeSsa5482wZ3rShx12ojagC
t2GXNGCZB+SsvVrFZb0bmoCR8ZVXktWBaaRWxaSmYWMVTAs2vaowAai2Vz0j4QIxFpOhUNhN
n8JsRuJGK7uHYabGMIeDp4b/NLmHIRHRtQCxepVGUcqloCXfoMqxZyuMAxiPNLvpPIju7r/R
IFWrQp5Tuniijq6iFCW7bRr8JizKdJ2LmK5ThbJCaLWIdPkZu2bmDevHHKlkGH7eFky1XvXE
/yNP4z/9nS9P4P4AJveV6QK0eBebqfyVhWrr4ctWF+tp8edKlH8mpaveuAAaV627M27tSckw
xVby4KtVGvnb4f3h+eIvrTndzks9bTVKwFaPuCVheAVFd44EZpi6IE7hUElzA+VtwsjPg8T8
ArMeYrI7XD+VWbGXVfLKDIWy3nw6yBPaREOVLeNM5+4S8IsjVNHsRVk6Eg9Xa+BbS3YTg+Ys
vXEDUWo+mPifwTdgse5E3oYjb68+7Pnoig4LFRRMuQ5r3UpzjKTlPheFfwa3cuMCeVq5sBv3
h4BSaTIdosSZti7PNOecPHlGZKiWoftLD/iQA1VcVaLYuLbj3l1mHCawwFyCX3xm3DI37irZ
T85iZ25szlTabi7pBE42m/yNMSsjVDQwhniudJD+llCRRLdph+Yv9lu6ye/SbbzfopxPRr9F
d1uUPkuok5E+nh8EO/mMUUJH8OHh8Nf3u9Phg0Uo76+sAtCVkxlidUHlbjmeofSi7KbYOTfB
mX2Vp24kCGmgim4p6+FMa2g0SvjRD8Tx7Xk+ny7+GH6gaC/1A3lCTOiTqIa5BMxPHnM5pWOl
4eaOsGIGEe+SYhBxj74GiWY9rOMclqYGEWeeYpCMztTBBwQ0iDgveYNk6piE+WzmmIT5bOH4
ZjGeOadnMeVe943PR66CJwtXYy4nOgYkOFx19dzxwXA0HbhRQ3PEZVBL51C3lfHv25SCe5Ol
+DHfC0fnjElrwTOe+pKnXphz1fXGvbY6Et4zQCPhrQyRZJuG85qzremQlTkPGMkVzjLBXfC2
eC8AbdjTx0DBQc2s8pQr08tTUYbni73JwyjS03u0uLUIIvadoyMAbXSrjz+CQw9z7/kMIqnC
0tn58w0tq3wb0pimiKjKFTF68COiesEPU4WuktBTd9X98aFAdYJO2VF4K22uuncq7i4hra+v
qGyr3XYql5fD/fsr2lhYEXC3wQ05T/AXyP5XFab6U1onPSpVamqYXSTMw2TtECybkpi2Ntcy
gd9W3H0Ev2t/U6dQiewx93UReJW6qomDQr7Ml3noESGhJbAhunbSFdScubxQ2hJlotwwrZGh
YGSMnAT6U8m4sdlNLaIo9YTSxXpx0yTjlPY0lxc96smMdAHN7jz5JaY53gRRRi+NWLRs86cP
f759OT79+f52eMVEsX98O3x/wedQu4sFrOdfjEKZxukNnxOioxFZJqAVvDrXUUWp8LOQv+bt
iG6EI4x132axQtOMkH+bIbV5Wz+9TtCM3vHOtzYvBTtgf9XHv0g62hjsuKra6PT9MqZeVdC8
Tx/QKejh+Z+njz/vHu8+fn++e3g5Pn18u/vrAOUcHz4en06Hr7iTP355+euD2tzbw+vT4fvF
t7vXh4O0Hes3+b/6hDMXx6cjegsc/+eucUXq+hpiBkQ00klSGghdIjBqAi5oPbS+QYGvizpB
/4zEV96i3W3vHPJM1tW9X6S5ujomt4aSuaTdRdrrz5fT88U95sh+fr1Qq5/E4pHE0L21oPHc
NfDIhgfCZ4E2abH1wkxL1Gcg7E82eozsHmiT5vR+toexhLY61Tbc2RLhavw2y2zqLX0ObEtA
Xc0mhWNVrJlyG7j9gbwjf+Spaz8sMG6iek2xPl2vhqN5XEUWIqkiHmhXn8n/rQbI/5iVUJWb
IPEsuB6mvl0HYWyXsI4qNKuQXHw/n1n4Jl9B8/ybvX/5frz/4+/Dz4t7udy/vt69fPtprfK8
EFZJvr3UAs+zWhl4/oYB5n4h7FGp8l0wmk6Hi3YTivfTNzRVvgcd/eEieJKtxLDW/xxP3y7E
29vz/VGi/LvTndVsjyaeaweIgXkbEFbEaJCl0Y30PLF36DoshqO5PQfBVbhjxmEjgLvt2l4s
pbcmHqJvdhuX9nR7q6UNK+1F75UW94K67W+j/NqCpaul9W3GNWbPVALilkxyb+2BTTeE5ifC
B3G4rGK7wRjLpx2pzd3bN9dAxcJeXZtYMC3murFTn7em84e3k11D7o1HzGxIsDLdYTayN9YU
fwqHAY2AfzCHedvSvWTZZqHLSGyDkT0/Cm4zKqisHA78cGV9sWaPBOc6j/0JA2PoQljh0nrT
npI89rmdgmCar74Hj6Y2mwLwmDoNttttI4YWLQC5IgA8HTLH6kaMbWA8tuvCp8llurYQ5Tof
Lrg5v86megwVJUfITL32ehaBHu2zg9ZsnkaCT8JmMVpsKqmWIVtq7vFXAN3CSq8xduk5GsxO
BIo1Fxaqo0C9z0rRRrCsY2WPnllj7Qf2al+pI9USIjbiVvhMxYWICmDuZ6pu2L+9LILAZ1h+
nmmxxHR4XRTBqJ4yR28RT+y1FNgHK+iUOBc2rYK7R7glgMrtVfj8+IIeJZrw3g2yvD63j43b
1GrEfGJvqejW7ph8JLCgeNHfMuH87unh+fEieX/8cnhtQxm0YQ7MdV2EtZeBKOqeRD9fytg2
ldU8iWEPCoXhOKTEcEcuIizg5xCzagXoS5DdWFiUQGtOSWgRNXsIdFiiCJgD09GcHZqOSmof
zAZx2AEQBQIzfZma0ffjl9c70M5en99PxyfmxI7CZcPlbHhzlJFkvE4aFqf27NnPFQmP6gTN
8yVQedRGc8wJ4e3xCmJzeBt8Gp4jOVe985jue3dGZkUix9G4scVBtHvNhN/EizVXCMHijJ7Z
hYSw2AhHUesg9fkrEUK0CVdJfbmYcnZihEyUcRNxzj47Wiynl/RYHKTBRDAbA2k8j8+BTEiu
RAna0Hwx/eHxESAMWm+83/MZREzCmSNtq6PynSPNFlP9b5JCA3ZcGgRChxdpe4+RRtTooX0X
O/ZxlK5Dr17vbaHawJvX3qK4ieMAL2/lvS8miWaRWbWMGpqiWupk++lgUXsB3pmGHr4dm2a6
2dYr5mjWtkMsltFQPFKKyzb1Wf99f+Et8ai64+fchXS4xkvdLFCGiNLUEhsT9pFJPQzS8ZdU
f99kRtO349cn5dR3/+1w//fx6Stx71D5bcq8Kpo78lwzw7PxhZaxrcEH+xK9BPqx4e/S08QX
+c0vawMmjjHii/I3KORJg3+pZrW2Wr8xBm2RyzDBRklrxFU7iJHzoMIsf7M6uyJ+qg2kXgaJ
B0JDTsK9oiui1oFlCDoCJlQjC6t10gP1IfGym3qVS+8wurQoSRQkDizmOqnKkD7Yt6hVmPiY
bQiGDJpANl6a+/QsgWGIgzqp4iWmfCV9xCUmIrtgzE7XGqcbKAMsDcBgvuoVCv2NZ0GoX8x5
sP1BMqLb2xvO9DPBq5XmyvIYqLWsak3URm1bLwDUbO55yyQBThAsb7gQLBrBhCld5NfGLjAo
YBL4cmeaYOxpyrVHczSHS/vywSNKdHNRQJ1UReKnsaPzDQ21v+lLRig67JjwW5QYQM7TdYFb
JekYUGpTRLpxm7IlU8siSk3tiDQ4LaV3lKdWQgaYo9/fItj8rd+KNjDpT6m7EjaYUDjC6jV4
kfP+Oz263MD+YyanocCkXp7VoKX32YIZuUq7Htfr25DsTIKIbrVcrBSR2jucPj22iwwU4LpI
o1QLrkih+CY75z/ACglq6REdp4RDpgiQifQEPazeUt95Al/GLHhVEPhe5Lm4USyJigVF6oXA
+HZBLQl6FHIx4G7U4VKB0MOg1rgewrU8tInsr8ocC6wcXQf78Y7R5t2LhLQn20gFka4wxHuO
J0CZKBg9ox1eBcU6UvOlsausikWxxXSr8kWO40lonat1yb+i50CULvVfvYsrMX5Am1vCqaJb
TD/VA8L8CnUXUm6chVpiZ/ix8glfR7da9AiEE5FMTOUVIzwktTNXvpu3S3bnF8xCXgclJjJP
V75gvOfxm3o8ciBKeWJSv4EU73TMVNUSOv8xnBkgdDyAEQuoWUFrK+1tr0VExAkJ8oMspSYI
cJRo06O6T2eBhPswxBr9PbcVDiX05fX4dPpbBcl4PLx9tU05pMi0lf3XhFgF9jDCMpuwRxlK
Yt6cCEShqHsrvHRSXFVhUH6adGujEaCtEjoKmWK4aYgfaKmN/ZtEYH5xyx8BtIBlitJ/kOdA
wmcUgG9q+LfDyMCF6nYzts7x6i7Tjt8Pf5yOj40M+iZJ7xX81R5dVVdziWLB0CWk8gIt2STB
FiBZ8bINIfKvRb7ijypCtSx5vW/tL9G1LswcTmVBIt9J4wpveNFljbNAyWGcpfPPp+FgNKEr
OAP+iw7sMdlYeSB8WSigaMc3AMdA+jJlV8Q9nqQZrNLwNgCSKNQ9jVRXQTuRZk9xWMSipGeM
iZHNRd9CsqZUP7JUujuZRa9SdEi/DsRWRvoHfkqXzW8vjH/RzDfNlvUPX96/ylyt4dPb6fX9
sUln3u4Tgeow6Ez5FWGsPbAzoVBz9WnwY0gs3QmdMztp08PCYLbqRIYVQmcJfzNFdGpBtSxE
46yIMyUizaFbYpnP1VciAsU4bk9LI/fP2cHSe4JeJ0Fkbyp00bAuyBtTk65cwhmRO4GwgVGv
dWd2VRzi5VnM2X/jt+l1YtwMyAuDNMQMi+zFbV8wOmGaazBPfYGucyrwhHGKZaVfxeQAUb9r
wx1IAZv8SHaXlBeXw9siqpbOK2O5YJrRB4kqgn1il95izjArZVFU4cHAST/AgvyGJgBVWHIk
ux7WjKpboQ1NmJcVVYXPglXKEmm5RPagAkpHS9CA8cSRofE+qxyJ+pQqnoFSZWEWvgnXG0MK
7QZT9hW9/laYVNPqqYbmTmlPdnkrcHtZV84KLMv4NLSMr/odYTDZTZj3KYWQ6CJ9fnn7eIGR
o99fFOPb3D19pUKGwJSiwH/TlPZfA6PzfEVuzRVSCnRV+WnQiZCpt62yPlVDz+LTVelEoiiB
+SJiSiZr+B2armmaZaZRmWNVI7LeYCLOEmR0Zo6ur+AwgiPJT9eU750fWWWfCyfNwzseLwz3
UnvFuEFVQF0ckTC5r2n1XNnm6sO52QZBdpaXgWYYZ13SN+wJ4eH/9fZyfEIjGejk4/vp8OMA
fxxO9//+97//m4Q0xFcFWZxMIGwJ5VkOW4D4c3fNVM8RJRtmpmGpeIcFGmVg7UqSoU9nBTz5
9bXCAJtMr6UZrcm8r4sgtj5TLyuNQkdaDeqBvdsbhLMzmJkUT/soCDKuIhw8+bDYKBWFXieG
BUObVeOA6XvG6SL/h/nsFHj0mUJlcRWJNXUORUakIv6QrktBDUaorhJ8loflq27AzhwiW3WM
WUe92lJ/K0Hi4e50d4ESxD3eKFsiu7yNNsYwa4AmE3av/vZs0KPY4UGb1PIsh+MZA5kaIXEM
JuBosV6VB7pEgJlu5cXx/zZ2JMltw7AvNW0mkx5lWbI01hYtsX3S9JDpqaf20OcXCykBJKj0
lAkBcxOInSBH2vPF1GvouIy5qpmzNUZXuP1XM4kDf4BPwa0bYQiA/InRI6KgTCR1f2P0X58k
PCIHbCzezDoXvpijWnVwSt+cIj/uKry2CukggNKHsSjTuQsTrkBONCx96fIh1RIUZwlau/yh
Xq6mUPxO4DEP6/qBFyuEFukB5dKx6XIMvYzZUNk43lYu/Wamgeutniv0yIS2gIXmqhmgiyBE
d2gtVdyB/jBAEaDgpXT67ohJRlfUCSZWPILG3PXGXQsnIq0cy++uwTJ5Krnm5eRcCd9+o7cC
CV/ZlviBkSImWHUe77Hoijj5DRClJ8dJQHSOmWuNxvMafTiQQzScUsGKUZEhf1bUdUxMG/2b
lGQxtgQ1fU5I/09D21yAK2GIVN9bQUllbE3hdxr4zuWi7vDuX4A+sXzYb3wDZa+MOty6CtpZ
gYqO2Q3OvLGnWB0rdUPY7YI7BlNEyVMHpkLVxyTuAZtNocmNuz2BkARa5f0LtCIFK+j6hmXB
OnDWdVjBG59KpN/p7EXXV0wtO0Zzpbg+vcZkb8UVxjoV+7fZnQ0SgDKzi7dz9y1IZGOU01BG
n9+TZNiemhD24SaFVtdYnw8+bYL7+WOsAwwYBneVynVFDOqKOROblpZs3viKFb6WDEqCozGy
BidFSQnGIJccX2B1VLGd/p1/OHqeMxD6QyTzdwEuZpNCjs8tuX8jJWN6dMBDeHOAa6b6kWS0
4YXKD3zKta/y+unb92cKw6Cxb/kgMnwdV6qt1CA/lIhFKiC7shNADk6FMKfKqkU7CC3KvO/I
CNUNTmeRXYku4o6xwmDUyv+V8QLeS3w/AM9xe8bkBpGjLhwrVJm0nlgMFmfJtfHGpcMQ3LeP
IKS4/n19sRRXbTjEcvD++rI6nz7JwEXX2svGxmWIWGZ4UdbrcJlX50UL9MKblY127pdTE16R
cqZxcyqbRSaYkvayCQQx+T10DNPHWC0WmT3MbMCX1eg8fLmbxfgFXMcWNsBCf447D+VCqClT
cAbdJYm6LUOWjGJyD4F65yymttbVddXmkJ96WMwBByp5iDZwctylu3EN39DVvxkPmvJkYG3+
+P0HTVz0weT4gPaPnx/iQjQOLk/pXoDRnCyDi7vjADbfMj2LqjZdX5J4SWOL6G0xc43TQ6xN
80oOybEGE1A3U5OpaAG2sTs7cpRrnDa7Fv4KeRqr7r2ZaEldxCjRU5GcrBHpcL/q/GLEgPqn
wngDCTjbQVF2t06gE4GsdExfeHZG0AdIL4dVkgqg0tab63lWETFKIaQEualP1GwklCTUyQhZ
O9LW0Xa7FI7egew+4d2YA7jMAkmzLzx0qGwcdwbqLWq3STh7u16ej3klbVBV3JGtH+wgR9v5
/qQlUz3WlA+q9DVneQJg7i0JQWCXlPhLNbp4f9gVNMPpbOzL6YSxLImr6wTlJJg03IoVaIwR
E85mjCQe7GeWuDJE0Pps3RViYr62wT68t+z91K3kLqHqhsGuDdE+YhJphXkGwN1UsUPMlYTt
3FXe1KTKemxvmXzolr+2r5on82Sh5TPWzjmvxzi8yEgIa2KjAg2UrKsndm37c0Q4KnyVHhOU
rBxM1cOjQNmuicQD30lCOQZIWBb/UHxGF/o5eeUf5VYrG4pdAgA=

--ZGiS0Q5IWpPtfppv--
