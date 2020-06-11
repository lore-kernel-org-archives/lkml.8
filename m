Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD91C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A9F20691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgFKNTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:19:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:29861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgFKNTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:19:45 -0400
IronPort-SDR: 9voUOXe7qsMnfFK//Btx9y89I78M7i++tD95md3NOn5mjhZROh6+ALRoS4hFPUFQMX3QbzZw87
 zQ4m4lvDr69Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 06:19:44 -0700
IronPort-SDR: k7j8rBE6g9HgGKgYAvKDrfmefDcOCD9VFXguJSUm6m9ifxfsULo+j802pwh81qXpwFOTCJOuVK
 +Ly896XRD+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="419097065"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 06:19:42 -0700
Date:   Thu, 11 Jun 2020 21:19:07 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] cc1: error: arch/um/include/uapi: No such file or
 directory
Message-ID: <20200611131906.GA11739@intel.com>
References: <202006112008.S05RwFCJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006112008.S05RwFCJ%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 08:39:12PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b29482fde649c72441d5478a4ea2c52c56d97a5e
> commit: c348c16305280fe3e6c1186378f96c8634c149f9 lib: make a test module with set/clear bit
> date:   6 days ago
> config: um-allmodconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout c348c16305280fe3e6c1186378f96c8634c149f9
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> cc1: error: arch/um/include/uapi: No such file or directory [-Werror=missing-include-dirs]
> cc1: all warnings being treated as errors
sorry, kindly ignore this report, which is a false positive.

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

