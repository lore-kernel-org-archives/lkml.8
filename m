Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C132C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1772C20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFCPrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:47:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:25144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgFCPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:47:14 -0400
IronPort-SDR: Xjra4kQGoXo4jAukVnRfs0dHKC5eXZZ8E1clxbAz7yJFjN4gwXf5MJtF4xWMSOEsQxgqSXtDbX
 w9LGhB5Y7y2w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:25:12 -0700
IronPort-SDR: WsP+DTRuE5fmpwJ1Sx/ZO67QBISK/nay1ilT3ZJ4aljAiZDn4Gh4PovI19ATG8vm2hLEUbuq88
 C5p7QAxYJ9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="gz'50?scan'50,208,50";a="445146900"
Received: from lkp-server01.sh.intel.com (HELO 8bb2cd163565) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 08:25:09 -0700
Received: from kbuild by 8bb2cd163565 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgVGP-00003g-3t; Wed, 03 Jun 2020 15:25:09 +0000
Date:   Wed, 3 Jun 2020 23:24:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Arnd, Bergmann," <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <bwh@kernel.org>
Subject: drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202006032328.hPsDSdlS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d6f9469a03d832dcd17041ed67774ffb5f3e73b3
commit: 78ed001d9e7106171e0ee761cd854137dd731302 compat: scsi: sg: fix v3 compat read/write interface
date:   5 months ago
config: sh-randconfig-s031-20200603 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-244-g0ee050a8-dirty
        git checkout 78ed001d9e7106171e0ee761cd854137dd731302
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=sh CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   ./arch/sh/include/generated/uapi/asm/unistd_32.h:409:37: sparse: sparse: no newline at end of file
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:415:21: sparse:     got int [noderef] <asn:1> *
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:415:21: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:415:21: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse:     got int [noderef] <asn:1> *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:419:32: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:419:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] <asn:1> * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse:     got signed int [noderef] <asn:1> *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got signed int const *__gu_addr @@
   drivers/scsi/sg.c:425:32: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:425:32: sparse:     got signed int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse:     got int [noderef] <asn:1> *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:431:32: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:431:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] <asn:1> *[assigned] buf @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse:     got char const [noderef] <asn:1> *[assigned] buf
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got char const *__gu_addr @@
   drivers/scsi/sg.c:638:13: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:638:13: sparse:     got char const *__gu_addr
   drivers/scsi/sg.c:956:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:956:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:956:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:956:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:956:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:956:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:999:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:999:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:999:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:999:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:999:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:999:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1027:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:1027:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1027:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:1027:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1027:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:1027:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1052:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:1052:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1052:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:1052:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1052:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:1052:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1060:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:1060:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1060:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:1060:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1060:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:1060:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1068:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:1068:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1068:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:1068:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1068:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:1068:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1112:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *ip @@
   drivers/scsi/sg.c:1112:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1112:26: sparse:     got int [noderef] <asn:1> *ip
   drivers/scsi/sg.c:1112:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:1> * @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1112:26: sparse:     expected void const volatile [noderef] <asn:1> *
   drivers/scsi/sg.c:1112:26: sparse:     got int const *__gu_addr

vim +425 drivers/scsi/sg.c

   407	
   408	static int get_sg_io_pack_id(int *pack_id, void __user *buf, size_t count)
   409	{
   410		struct sg_header __user *old_hdr = buf;
   411		int reply_len;
   412	
   413		if (count >= SZ_SG_HEADER) {
   414			/* negative reply_len means v3 format, otherwise v1/v2 */
   415			if (get_user(reply_len, &old_hdr->reply_len))
   416				return -EFAULT;
   417	
   418			if (reply_len >= 0)
   419				return get_user(*pack_id, &old_hdr->pack_id);
   420	
   421			if (in_compat_syscall() &&
   422			    count >= sizeof(struct compat_sg_io_hdr)) {
   423				struct compat_sg_io_hdr __user *hp = buf;
   424	
 > 425				return get_user(*pack_id, &hp->pack_id);
   426			}
   427	
   428			if (count >= sizeof(struct sg_io_hdr)) {
   429				struct sg_io_hdr __user *hp = buf;
   430	
   431				return get_user(*pack_id, &hp->pack_id);
   432			}
   433		}
   434	
   435		/* no valid header was passed, so ignore the pack_id */
   436		*pack_id = -1;
   437		return 0;
   438	}
   439	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--
