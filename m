Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1046DC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA22206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgD2VHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:07:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:44895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgD2VHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:07:43 -0400
IronPort-SDR: S+KBPWIAqtmkNtqiHM/H8i7VM578yfLJxqyYUohjFKNgI3M60PTo2/rW2vLUTkLx0MNxfdze3x
 KHyYAR0awvaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 14:07:43 -0700
IronPort-SDR: fO28tMpy91+h61zlAdF7J+DLy95HhSJ1xZ91vgd72GUoJevjkgLSc21L1bQKX1nPN773x00Tq8
 TR1D9bkilTVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="258085302"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2020 14:07:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTtvf-000GLJ-0A; Thu, 30 Apr 2020 05:07:39 +0800
Date:   Thu, 30 Apr 2020 05:06:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com,
        will@kernel.org, stefano.stabellini@xilinx.com
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, vatsa@codeaurora.org,
        christoffer.dall@arm.com, alex.bennee@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <202004300425.BWcRAuHD%lkp@intel.com>
References: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srivatsa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vhost/linux-next]
[also build test WARNING on xen-tip/linux-next linus/master v5.7-rc3 next-20200428]
[cannot apply to swiotlb/linux-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Srivatsa-Vaddagiri/virtio-on-Type-1-hypervisor/20200429-032334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/virtio/virtio_bounce.c:22:21: sparse: sparse: symbol 'virtio_pool' was not declared. Should it be static?
>> drivers/virtio/virtio_bounce.c:79:8: sparse: sparse: symbol 'virtio_max_mapping_size' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
