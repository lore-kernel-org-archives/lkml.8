Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54550C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F69820756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgERPFU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:05:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:7416 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERPFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:05:20 -0400
IronPort-SDR: RPi5WN4YIME6icihqCrtdOj9blRAS6E00f+qP0OL5TmnP4HEyxPXfBdL5fImO88lzJEPdvOVaL
 5/ssjvwVEHwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:05:19 -0700
IronPort-SDR: vYeuVaHY6bfVlfrSTh938g8Ib9JKENzqjnI/jrBwyPiJiVFiprMSuWYEvxXPx6ORdZuiT0VAOT
 C9kqr5E44sog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="267545577"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 08:05:18 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 08:05:18 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 08:05:18 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.245]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.178]) with mapi id 14.03.0439.000;
 Mon, 18 May 2020 23:05:16 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     lkp <lkp@intel.com>, Colin Ian King <colin.king@canonical.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: RE: [kbuild-all] drivers/usb/cdns3/drd.c:332:17: sparse: sparse:
 too many warnings
Thread-Topic: [kbuild-all] drivers/usb/cdns3/drd.c:332:17: sparse: sparse:
 too many warnings
Thread-Index: AQHWLReJ+4ZtRXFMCEiV5pgP4fMbo6it8SGA
Date:   Mon, 18 May 2020 15:05:16 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662495263DD2B@shsmsx102.ccr.corp.intel.com>
References: <202005182134.F6Wme8zd%lkp@intel.com>
In-Reply-To: <202005182134.F6Wme8zd%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [kbuild-all] drivers/usb/cdns3/drd.c:332:17: sparse: sparse: too many
> warnings
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
> commit: 70d8b9e5e63d212019ba3f6823c8ec3d2df87645 usb: cdns3: make signed
> 1 bit bitfields unsigned
> date:   8 weeks ago
> config: arc-randconfig-s001-20200518 (attached as .config)
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-193-gb8fad4bc-dirty
>         git checkout 70d8b9e5e63d212019ba3f6823c8ec3d2df87645
>         # save the attached .config to linux build tree
>         make C=1 ARCH=arc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
Sorry, kindly ignore this, which is a false positive.

> 
>    drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:182:23: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:195:17: sparse: sparse: incorrect type in argument 2
> (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr
> @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:195:17: sparse:    expected void volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:195:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:219:9: sparse: sparse: incorrect type in argument 2
> (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr
> @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:219:9: sparse:    expected void volatile [noderef] <asn:2>
> *addr
>    drivers/usb/cdns3/drd.c:219:9: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:303:9: sparse: sparse: incorrect type in argument 2
> (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr
> @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:303:9: sparse:    expected void volatile [noderef] <asn:2>
> *addr
>    drivers/usb/cdns3/drd.c:303:9: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment
> (different address spaces) @@    expected struct cdns3_otg_legacy_regs
> *otg_v0_regs @@    got void struct cdns3_otg_legacy_regs *otg_v0_regs @@
>    drivers/usb/cdns3/drd.c:326:27: sparse:    expected struct
> cdns3_otg_legacy_regs *otg_v0_regs
>    drivers/usb/cdns3/drd.c:326:27: sparse:    got void [noderef] <asn:2> *[assigned]
> regs
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment
> (different address spaces) @@    expected struct cdns3_otg_common_regs
> *otg_regs @@    got void struct cdns3_otg_common_regs *otg_regs @@
>    drivers/usb/cdns3/drd.c:330:32: sparse:    expected struct
> cdns3_otg_common_regs *otg_regs
>    drivers/usb/cdns3/drd.c:330:32: sparse:    got void [noderef] <asn:2> *[assigned]
> regs
>    drivers/usb/cdns3/drd.c:331:17: sparse: sparse: incorrect type in argument 2
> (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr
> @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:331:17: sparse:    expected void volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:331:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:332:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:332:17: sparse:    got restricted __le32 *
>    drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1
> (different address spaces) @@    expected void const volatile [noderef] <asn:2>
> *addr @@    got [noderef] <asn:2> *addr @@
>    drivers/usb/cdns3/drd.c:332:17: sparse:    expected void const volatile [noderef]
> <asn:2> *addr
>    drivers/usb/cdns3/drd.c:332:17: sparse:    got restricted __le32 *
> >> drivers/usb/cdns3/drd.c:332:17: sparse: sparse: too many warnings
> 
> vim +332 drivers/usb/cdns3/drd.c
> 
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  306
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  307  int cdns3_drd_init(struct cdns3
> *cdns)
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  308  {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  309  	void __iomem *regs;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  310  	int ret = 0;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  311  	u32 state;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  312
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  313  	regs =
> devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  314  	if (IS_ERR(regs))
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  315  		return
> PTR_ERR(regs);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  316
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  317  	/* Detection of DRD
> version. Controller has been released
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  318  	 * in two versions. Both
> are similar, but they have same changes
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  319  	 * in register maps.
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  320  	 * The first register in old
> version is command register and it's read
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  321  	 * only, so driver should
> read 0 from it. On the other hand, in v1
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  322  	 * the first register
> contains device ID number which is not set to 0.
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  323  	 * Driver uses this fact to
> detect the proper version of
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  324  	 * controller.
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  325  	 */
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  326  	cdns->otg_v0_regs =
> regs;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  327  	if (!readl(&cdns-
> >otg_v0_regs->cmd)) {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  328  		cdns->version  =
> CDNS3_CONTROLLER_V0;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  329  		cdns-
> >otg_v1_regs = NULL;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  330  		cdns->otg_regs =
> regs;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  331  		writel(1, &cdns-
> >otg_v0_regs->simulate);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26 @332  		dev_info(cdns-
> >dev, "DRD version v0 (%08x)\n",
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  333
> readl(&cdns->otg_v0_regs->version));
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  334  	} else {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  335  		cdns-
> >otg_v0_regs = NULL;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  336  		cdns-
> >otg_v1_regs = regs;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  337  		cdns->otg_regs =
> (void *)&cdns->otg_v1_regs->cmd;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  338  		cdns->version  =
> CDNS3_CONTROLLER_V1;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  339  		writel(1, &cdns-
> >otg_v1_regs->simulate);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  340  		dev_info(cdns-
> >dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  341
> readl(&cdns->otg_v1_regs->did),
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  342
> readl(&cdns->otg_v1_regs->rid));
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  343  	}
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  344
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  345  	state =
> OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  346
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  347  	/* Update dr_mode
> according to STRAP configuration. */
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  348  	cdns->dr_mode =
> USB_DR_MODE_OTG;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  349  	if (state ==
> OTGSTS_STRAP_HOST) {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  350  		dev_dbg(cdns-
> >dev, "Controller strapped to HOST\n");
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  351  		cdns->dr_mode =
> USB_DR_MODE_HOST;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  352  	} else if (state ==
> OTGSTS_STRAP_GADGET) {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  353  		dev_dbg(cdns-
> >dev, "Controller strapped to PERIPHERAL\n");
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  354  		cdns->dr_mode =
> USB_DR_MODE_PERIPHERAL;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  355  	}
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  356
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  357  	ret =
> devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  358
> 	cdns3_drd_irq,
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  359
> 	cdns3_drd_thread_irq,
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  360
> 	IRQF_SHARED,
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  361
> 	dev_name(cdns->dev), cdns);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  362
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  363  	if (ret) {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  364  		dev_err(cdns-
> >dev, "couldn't get otg_irq\n");
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  365  		return ret;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  366  	}
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  367
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  368  	state = readl(&cdns-
> >otg_regs->sts);
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  369  	if
> (OTGSTS_OTG_NRDY(state) != 0) {
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  370  		dev_err(cdns-
> >dev, "Cadence USB3 OTG device not ready\n");
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  371  		return -ENODEV;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  372  	}
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  373
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  374  	return ret;
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  375  }
> 7733f6c32e36ff Pawel Laszczak 2019-08-26  376
> 
> :::::: The code at line 332 was first introduced by commit
> :::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence
> USB3 DRD Driver
> 
> :::::: TO: Pawel Laszczak <pawell@cadence.com>
> :::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
