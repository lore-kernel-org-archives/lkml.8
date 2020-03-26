Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19938C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D310120409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgCZM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:29:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:50361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgCZM3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:29:38 -0400
IronPort-SDR: EKfYOFoLlcbadGB+vReduWqx3ZDl8m6gBuLL39v0AtKwjMW3BXr0MPpjcfaYDHvUaflX85vC0u
 H7vVW8X4WB1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 05:29:36 -0700
IronPort-SDR: WXfIezKREiHJ8vc/KlC5KD3gtUDQCJG2dwiSAA0nSxkYW7GBs1lO9tl9Dz/MQoi9mPcYLwvyc1
 rQxJi24IBTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="446990097"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2020 05:29:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHRdd-0007Fe-Du; Thu, 26 Mar 2020 20:29:33 +0800
Date:   Thu, 26 Mar 2020 20:28:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: make signed 1 bit bitfields unsigned
Message-ID: <202003262011.LfBZcKPw%lkp@intel.com>
References: <20200325125041.94769-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325125041.94769-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v5.6-rc7 next-20200326]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Colin-King/usb-cdns3-make-signed-1-bit-bitfields-unsigned/20200326-075855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-187-gbff9b106-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/usb/cdns3/drd.c:43:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
>> drivers/usb/cdns3/drd.c:43:42: sparse:    expected void const volatile [noderef] <asn:2> *addr
>> drivers/usb/cdns3/drd.c:43:42: sparse:    got restricted __le32 *
>> drivers/usb/cdns3/drd.c:45:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
>> drivers/usb/cdns3/drd.c:45:42: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:45:42: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:47:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:47:42: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:47:42: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:49:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:49:42: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:49:42: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:71:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:71:25: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:71:25: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:81:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:81:30: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:81:30: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:114:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:114:24: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:114:24: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:124:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:124:48: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:124:48: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:141:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:141:56: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:141:56: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:144:23: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:144:23: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:154:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:154:29: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:154:29: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:156:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:156:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:178:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:178:55: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:178:55: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:182:23: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:182:23: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:197:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:197:29: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:197:29: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:219:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:219:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:219:25: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:26: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:26: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:303:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:303:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:303:25: sparse:    got restricted __le32 *
>> drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cdns3_otg_legacy_regs *otg_v0_regs @@    got void struct cdns3_otg_legacy_regs *otg_v0_regs @@
>> drivers/usb/cdns3/drd.c:326:27: sparse:    expected struct cdns3_otg_legacy_regs *otg_v0_regs
>> drivers/usb/cdns3/drd.c:326:27: sparse:    got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:25: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:25: sparse:    got restricted __le32 *
>> drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cdns3_otg_common_regs *otg_regs @@    got void struct cdns3_otg_common_regs *otg_regs @@
>> drivers/usb/cdns3/drd.c:330:32: sparse:    expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:330:32: sparse:    got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:331:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:331:32: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:331:32: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:332:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:332:17: sparse:    got restricted __le32 *
>> drivers/usb/cdns3/drd.c:336:35: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cdns3_otg_regs *otg_v1_regs @@    got void [noderestruct cdns3_otg_regs *otg_v1_regs @@
>> drivers/usb/cdns3/drd.c:336:35: sparse:    expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:336:35: sparse:    got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:339:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:339:32: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:339:32: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:340:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:340:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:345:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:345:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:345:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:368:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:368:28: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:368:28: sparse:    got restricted __le32 *
--
>> drivers/usb/cdns3/gadget.c:1157:35: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
>> drivers/usb/cdns3/gadget.c:1157:35: sparse:    expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1157:35: sparse:    got unsigned long
>> drivers/usb/cdns3/gadget.c:1173:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
>> drivers/usb/cdns3/gadget.c:1173:29: sparse:    expected restricted __le32 [usertype] buffer
>> drivers/usb/cdns3/gadget.c:1173:29: sparse:    got unsigned long long
>> drivers/usb/cdns3/gadget.c:1188:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] length @@    got 2 [usertype] length @@
>> drivers/usb/cdns3/gadget.c:1188:29: sparse:    expected restricted __le32 [usertype] length
   drivers/usb/cdns3/gadget.c:1188:29: sparse:    got unsigned long
>> drivers/usb/cdns3/gadget.c:1191:37: sparse: sparse: invalid assignment: |=
>> drivers/usb/cdns3/gadget.c:1191:37: sparse:    left side has type restricted __le32
>> drivers/usb/cdns3/gadget.c:1191:37: sparse:    right side has type unsigned long
>> drivers/usb/cdns3/gadget.c:1213:38: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got unsignrestricted __le32 [usertype] control @@
   drivers/usb/cdns3/gadget.c:1213:38: sparse:    expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1213:38: sparse:    got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got unsignrestricted __le32 [usertype] control @@
   drivers/usb/cdns3/gadget.c:1215:48: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1215:48: sparse:    got unsigned int [assigned] [usertype] control
   drivers/usb/cdns3/gadget.c:1229:30: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1229:30: sparse:    right side has type unsigned long
>> drivers/usb/cdns3/gadget.c:1255:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1255:30: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got  [usertype] control @@
   drivers/usb/cdns3/gadget.c:1255:30: sparse:    expected restricted __le32 [usertype] control
>> drivers/usb/cdns3/gadget.c:1255:30: sparse:    got unsigned int
   drivers/usb/cdns3/gadget.c:1010:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
   drivers/usb/cdns3/gadget.c:1010:29: sparse:    expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1010:29: sparse:    got unsigned long long
   drivers/usb/cdns3/gadget.c:1013:29: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
   drivers/usb/cdns3/gadget.c:1013:29: sparse:    expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:1013:29: sparse:    got unsigned long long
   drivers/usb/cdns3/gadget.c:1019:21: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] length @@    got 2 [usertype] length @@
   drivers/usb/cdns3/gadget.c:1019:21: sparse:    expected restricted __le32 [usertype] length
   drivers/usb/cdns3/gadget.c:1019:21: sparse:    got unsigned long
   drivers/usb/cdns3/gadget.c:1029:37: sparse: sparse: invalid assignment: |=
   drivers/usb/cdns3/gadget.c:1029:37: sparse:    left side has type restricted __le32
   drivers/usb/cdns3/gadget.c:1029:37: sparse:    right side has type unsigned long
   drivers/usb/cdns3/gadget.c:1033:22: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got unsignrestricted __le32 [usertype] control @@
   drivers/usb/cdns3/gadget.c:1033:22: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:1033:22: sparse:    got unsigned int [assigned] [usertype] control
>> drivers/usb/cdns3/gadget.c:85:6: sparse: sparse: symbol 'cdns3_clear_register_bit' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:140:26: sparse: sparse: symbol 'cdns3_next_align_buf' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:151:22: sparse: sparse: symbol 'cdns3_next_priv_request' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:193:5: sparse: sparse: symbol 'cdns3_ring_size' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:263:34: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
   drivers/usb/cdns3/gadget.c:263:34: sparse:    expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:263:34: sparse:    got unsigned long long
   drivers/usb/cdns3/gadget.c:264:35: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/gadget.c:264:35: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:264:35: sparse:    got unsigned long
>> drivers/usb/cdns3/gadget.c:348:6: sparse: sparse: symbol 'cdns3_move_deq_to_next_trb' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:514:20: sparse: sparse: symbol 'cdns3_wa2_gadget_giveback' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:554:5: sparse: sparse: symbol 'cdns3_wa2_gadget_ep_queue' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:849:49: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:848:51: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got  [usertype] control @@
   drivers/usb/cdns3/gadget.c:848:51: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:848:51: sparse:    got unsigned int
   drivers/usb/cdns3/gadget.c:852:49: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:851:51: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got  [usertype] control @@
   drivers/usb/cdns3/gadget.c:851:51: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:851:51: sparse:    got unsigned int
>> drivers/usb/cdns3/gadget.c:839:6: sparse: sparse: symbol 'cdns3_wa1_restore_cycle_bit' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:1393:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:1442:21: sparse: sparse: restricted __le32 degrades to integer
>> drivers/usb/cdns3/gadget.c:1574:35: sparse: sparse: dubious: x | !y
>> drivers/usb/cdns3/gadget.c:1907:6: sparse: sparse: symbol 'cdns3_stream_ep_reconfig' was not declared. Should it be static?
>> drivers/usb/cdns3/gadget.c:1928:6: sparse: sparse: symbol 'cdns3_configure_dmult' was not declared. Should it be static?
   drivers/usb/cdns3/gadget.c:2552:34: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
   drivers/usb/cdns3/gadget.c:2552:34: sparse:    expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/gadget.c:2552:34: sparse:    got unsigned long long
   drivers/usb/cdns3/gadget.c:2554:46: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2554:35: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/gadget.c:2554:35: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2554:35: sparse:    got unsigned long
   drivers/usb/cdns3/gadget.c:2610:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2610:38: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/gadget.c:2610:38: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2610:38: sparse:    got unsigned long
   drivers/usb/cdns3/gadget.c:2625:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/cdns3/gadget.c:2625:38: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/gadget.c:2625:38: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/gadget.c:2625:38: sparse:    got unsigned long
--
>> drivers/usb/cdns3/ep0.c:40:37: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
>> drivers/usb/cdns3/ep0.c:40:37: sparse:    expected restricted __le32 [usertype] buffer
>> drivers/usb/cdns3/ep0.c:40:37: sparse:    got unsigned long long
>> drivers/usb/cdns3/ep0.c:41:37: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] length @@    got 2 [usertype] length @@
>> drivers/usb/cdns3/ep0.c:41:37: sparse:    expected restricted __le32 [usertype] length
>> drivers/usb/cdns3/ep0.c:41:37: sparse:    got unsigned long
>> drivers/usb/cdns3/ep0.c:44:46: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
>> drivers/usb/cdns3/ep0.c:44:46: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:44:46: sparse:    got unsigned long
   drivers/usb/cdns3/ep0.c:45:45: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] buffer @@    got __le32 [usertype] buffer @@
   drivers/usb/cdns3/ep0.c:45:45: sparse:    expected restricted __le32 [usertype] buffer
   drivers/usb/cdns3/ep0.c:45:45: sparse:    got unsigned long long
   drivers/usb/cdns3/ep0.c:46:45: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] length @@    got 2 [usertype] length @@
   drivers/usb/cdns3/ep0.c:46:45: sparse:    expected restricted __le32 [usertype] length
   drivers/usb/cdns3/ep0.c:46:45: sparse:    got unsigned long
   drivers/usb/cdns3/ep0.c:47:46: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/ep0.c:47:46: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:47:46: sparse:    got unsigned long
   drivers/usb/cdns3/ep0.c:50:46: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] control @@    got 2 [usertype] control @@
   drivers/usb/cdns3/ep0.c:50:46: sparse:    expected restricted __le32 [usertype] control
   drivers/usb/cdns3/ep0.c:50:46: sparse:    got unsigned long
>> drivers/usb/cdns3/ep0.c:267:52: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned char [usertype] ep_addr @@    got restunsigned char [usertype] ep_addr @@
>> drivers/usb/cdns3/ep0.c:267:52: sparse:    expected unsigned char [usertype] ep_addr
>> drivers/usb/cdns3/ep0.c:267:52: sparse:    got restricted __le16 [usertype] wIndex
>> drivers/usb/cdns3/ep0.c:271:47: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [usertype] ep @@    got restrunsigned int [usertype] ep @@
>> drivers/usb/cdns3/ep0.c:271:47: sparse:    expected unsigned int [usertype] ep
   drivers/usb/cdns3/ep0.c:271:47: sparse:    got restricted __le16 [usertype] wIndex
>> drivers/usb/cdns3/ep0.c:387:19: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/cdns3/ep0.c:390:44: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned char [usertype] ep_addr @@    got restunsigned char [usertype] ep_addr @@
   drivers/usb/cdns3/ep0.c:390:44: sparse:    expected unsigned char [usertype] ep_addr
   drivers/usb/cdns3/ep0.c:390:44: sparse:    got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:393:39: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [usertype] ep @@    got restrunsigned int [usertype] ep @@
   drivers/usb/cdns3/ep0.c:393:39: sparse:    expected unsigned int [usertype] ep
   drivers/usb/cdns3/ep0.c:393:39: sparse:    got restricted __le16 [usertype] wIndex
   drivers/usb/cdns3/ep0.c:454:21: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/cdns3/ep0.c:478:31: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [usertype] isoch_delay @@    got resunsigned short [usertype] isoch_delay @@
>> drivers/usb/cdns3/ep0.c:478:31: sparse:    expected unsigned short [usertype] isoch_delay
>> drivers/usb/cdns3/ep0.c:478:31: sparse:    got restricted __le16 [usertype] wValue
--
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] buffer @@    got restrunsigned int [usertype] buffer @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] length @@    got restrunsigned int [usertype] length @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] control @@    got restrunsigned int [usertype] control @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] control
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] control
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] buffer @@    got restrunsigned int [usertype] buffer @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] buffer
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] length @@    got restrunsigned int [usertype] length @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] length
>> drivers/usb/cdns3/./trace.h:392:1: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] control @@    got restrunsigned int [usertype] control @@
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    expected unsigned int [usertype] control
>> drivers/usb/cdns3/./trace.h:392:1: sparse:    got restricted __le32 [usertype] control

Please review and possibly fold the followup patch.

vim +43 drivers/usb/cdns3/drd.c

7733f6c32e36ff Pawel Laszczak 2019-08-26  22  
7733f6c32e36ff Pawel Laszczak 2019-08-26  23  /**
7733f6c32e36ff Pawel Laszczak 2019-08-26  24   * cdns3_set_mode - change mode of OTG Core
7733f6c32e36ff Pawel Laszczak 2019-08-26  25   * @cdns: pointer to context structure
7733f6c32e36ff Pawel Laszczak 2019-08-26  26   * @mode: selected mode from cdns_role
7733f6c32e36ff Pawel Laszczak 2019-08-26  27   *
7733f6c32e36ff Pawel Laszczak 2019-08-26  28   * Returns 0 on success otherwise negative errno
7733f6c32e36ff Pawel Laszczak 2019-08-26  29   */
7733f6c32e36ff Pawel Laszczak 2019-08-26  30  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
7733f6c32e36ff Pawel Laszczak 2019-08-26  31  {
7733f6c32e36ff Pawel Laszczak 2019-08-26  32  	int ret = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  33  	u32 reg;
7733f6c32e36ff Pawel Laszczak 2019-08-26  34  
7733f6c32e36ff Pawel Laszczak 2019-08-26  35  	switch (mode) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  36  	case USB_DR_MODE_PERIPHERAL:
7733f6c32e36ff Pawel Laszczak 2019-08-26  37  		break;
7733f6c32e36ff Pawel Laszczak 2019-08-26  38  	case USB_DR_MODE_HOST:
7733f6c32e36ff Pawel Laszczak 2019-08-26  39  		break;
7733f6c32e36ff Pawel Laszczak 2019-08-26  40  	case USB_DR_MODE_OTG:
7733f6c32e36ff Pawel Laszczak 2019-08-26  41  		dev_dbg(cdns->dev, "Set controller to OTG mode\n");
7733f6c32e36ff Pawel Laszczak 2019-08-26  42  		if (cdns->version == CDNS3_CONTROLLER_V1) {
7733f6c32e36ff Pawel Laszczak 2019-08-26 @43  			reg = readl(&cdns->otg_v1_regs->override);
7733f6c32e36ff Pawel Laszczak 2019-08-26  44  			reg |= OVERRIDE_IDPULLUP;
7733f6c32e36ff Pawel Laszczak 2019-08-26 @45  			writel(reg, &cdns->otg_v1_regs->override);
7733f6c32e36ff Pawel Laszczak 2019-08-26  46  		} else {
7733f6c32e36ff Pawel Laszczak 2019-08-26  47  			reg = readl(&cdns->otg_v0_regs->ctrl1);
7733f6c32e36ff Pawel Laszczak 2019-08-26  48  			reg |= OVERRIDE_IDPULLUP_V0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  49  			writel(reg, &cdns->otg_v0_regs->ctrl1);
7733f6c32e36ff Pawel Laszczak 2019-08-26  50  		}
7733f6c32e36ff Pawel Laszczak 2019-08-26  51  
7733f6c32e36ff Pawel Laszczak 2019-08-26  52  		/*
7733f6c32e36ff Pawel Laszczak 2019-08-26  53  		 * Hardware specification says: "ID_VALUE must be valid within
7733f6c32e36ff Pawel Laszczak 2019-08-26  54  		 * 50ms after idpullup is set to '1" so driver must wait
7733f6c32e36ff Pawel Laszczak 2019-08-26  55  		 * 50ms before reading this pin.
7733f6c32e36ff Pawel Laszczak 2019-08-26  56  		 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  57  		usleep_range(50000, 60000);
7733f6c32e36ff Pawel Laszczak 2019-08-26  58  		break;
7733f6c32e36ff Pawel Laszczak 2019-08-26  59  	default:
7733f6c32e36ff Pawel Laszczak 2019-08-26  60  		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
7733f6c32e36ff Pawel Laszczak 2019-08-26  61  		return -EINVAL;
7733f6c32e36ff Pawel Laszczak 2019-08-26  62  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  63  
7733f6c32e36ff Pawel Laszczak 2019-08-26  64  	return ret;
7733f6c32e36ff Pawel Laszczak 2019-08-26  65  }
7733f6c32e36ff Pawel Laszczak 2019-08-26  66  

:::::: The code at line 43 was first introduced by commit
:::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence USB3 DRD Driver

:::::: TO: Pawel Laszczak <pawell@cadence.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
