Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A370C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F94A20716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAZUMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:12:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:34229 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgAZUMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:12:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 12:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="401166249"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2020 12:12:12 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivoGR-0006gg-Mg; Mon, 27 Jan 2020 04:12:11 +0800
Date:   Mon, 27 Jan 2020 04:11:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 06/22] staging: vc04_services: get rid of
 vchiq_platform_use_suspend_timer()
Message-ID: <202001270446.AI1Wgghb%lkp@intel.com>
References: <20200124144617.2213-7-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124144617.2213-7-nsaenzjulienne@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on linux/master linus/master v5.5-rc7 next-20200121]
[cannot apply to anholt/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/staging-vc04_services-suspend-resume-cleanup/20200125-193041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fc157998b8257fb9cfe753e7f4af1411da995c9b
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-153-g47b6dfef-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1239:60: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1239:60: sparse:    expected struct vchiq_header *header
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1239:60: sparse:    got void [noderef] <asn:1> *[addressable] msgbuf
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1508:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1508:13: sparse:    expected int enum vchiq_status ( *__pu_val )( ... )
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1508:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1510:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1510:13: sparse:    expected void *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1510:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1636:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1636:13: sparse:    expected void *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1636:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1638:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1638:13: sparse:    expected void *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1638:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1713:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1713:13: sparse:    expected struct vchiq_completion_data *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1713:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1716:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1716:13: sparse:    expected void **__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1716:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1763:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1763:13: sparse:    expected struct vchiq_completion_data *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1763:13: sparse:    got struct vchiq_completion_data [noderef] <asn:1> *[assigned] completion
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1793:59: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1793:59: sparse:    expected void [noderef] <asn:1> *uptr
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1793:59: sparse:    got struct vchiq_header *[addressable] header
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1795:45: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1795:45: sparse:    expected void [noderef] <asn:1> *uptr
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1795:45: sparse:    got void *[addressable] service_userdata
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1797:45: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1797:45: sparse:    expected void [noderef] <asn:1> *uptr
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1797:45: sparse:    got void *[addressable] bulk_userdata
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1851:13: sparse: sparse: incorrect type in assignment (different address spaces)
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1851:13: sparse:    expected void *__pu_val
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1851:13: sparse:    got void [noderef] <asn:1> *
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2257:1: sparse: sparse: symbol 'vchiq_videocore_wanted' was not declared. Should it be static?
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2879:1: sparse: sparse: symbol 'vchiq_dump_service_use_state' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
