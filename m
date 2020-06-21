Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 06:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E122168B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 06:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFUGqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 02:46:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:52893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbgFUGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 02:46:12 -0400
IronPort-SDR: 6dsQxrdn5jxFYoCf2Fexzo43fogM9h+zt5vJe1Oei8piVaYIr1esult/PRi3wpkkxHeb13QG4J
 Ll3zKfkHH0wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="141765463"
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="141765463"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 23:46:10 -0700
IronPort-SDR: WILjAyTYVmSEtZLcHfnONIF693I2/TRglKBuVDY9n/ywmYD7ecVHGYM5oDd2FlKEAu5hk05F/n
 Svt2ZBKcMZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="300523236"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2020 23:46:08 -0700
Date:   Sun, 21 Jun 2020 14:45:50 +0800
From:   Philip Li <philip.li@intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [kbuild-all] Re: ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200621064550.GA11465@intel.com>
References: <202006200036.E0OHtwu9%lkp@intel.com>
 <2748b074-951c-000a-4d0a-780404e26dab@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2748b074-951c-000a-4d0a-780404e26dab@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 09:41:28AM +0300, Denis Efremov wrote:
> 
> 
> On 6/19/20 7:17 PM, kernel test robot wrote:
> > Hi Denis,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
> > commit: e4a42c82e943b97ce124539fcd7a47445b43fa0d kbuild: fix broken builds because of GZIP,BZIP2,LZOP variables
> > date:   8 days ago
> > config: openrisc-randconfig-c022-20200619 (attached as .config)
> > compiler: or1k-linux-gcc (GCC) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> 
> > ERROR: modpost: "__mulsi3" [drivers/power/supply/pcf50633-charger.ko] undefined!
> > ERROR: modpost: "__mulsi3" [drivers/power/supply/max17042_battery.ko] undefined!
> >>> ERROR: modpost: "__mulsi3" [drivers/power/supply/max17040_battery.ko] undefined!
> 
> I'm not sure, but this report looks to me like the error was already in code before
> and the patch only rearranges the report.
sorry, this is a false positive report, kindly ignore it. We will resolve our
side logic issue in earliest time.

> 
> > ERROR: modpost: "__mulsi3" [drivers/power/supply/da9150-fg.ko] undefined!
> > ERROR: modpost: "__mulsi3" [drivers/power/supply/bq27xxx_battery.ko] undefined!
> 
> 
> I found a similar reports:
> https://lkml.org/lkml/2020/6/19/341
> https://lkml.org/lkml/2019/12/11/2195
> https://lkml.org/lkml/2019/12/11/1977
> 
> Thanks,
> Denis
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
