Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD6F2076C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQLxrgRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIIIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:24:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59202 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgIIIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:24:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0898MOTp177688;
        Wed, 9 Sep 2020 08:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=m0A4wE6XM5B3kJLujPtoNoYr3KFzvqcm3MjYY5mxpUE=;
 b=iQLxrgRKImQPlHn9HECcNxZboFivDFA/t9NzKI5p1uRrqNfJCRL+e16KebpPTAeflpnt
 bd+AuhueZbvp+f6toyWd9K53yZM/VP08KN2ZmQXTJCi1oddOOslkvazXDiAyAlj2iCLH
 lk9ZxMaG/3IZGMnApOdHuIIy7xnVAugZ8y85QARAfIrnjqNMA7AVK2G7E8GqzFPQ8UOW
 dCuVjB3TzPPVxz9Ca2lrVXNnwn/DaUIa2OMp2m0WF96W9b3FPlgVthID9Com79QPxRgL
 eyj7jOl27xwgE4BEUbfImiRPfC/MQpBKlUppcpg9TuxkNYeUIVhL8RG/Emt3G7K8zD/3 yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33c3an03rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 08:23:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0898LRVM109843;
        Wed, 9 Sep 2020 08:23:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33cmesemjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 08:23:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0898NhCm032064;
        Wed, 9 Sep 2020 08:23:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 01:23:42 -0700
Date:   Wed, 9 Sep 2020 11:23:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ofer Levi <oferle@nvidia.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [kbuild] Re: [PATCH] ARC: [plat-eznps]: Drop support for EZChip NPS
 platform
Message-ID: <20200909082335.GX8321@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908210601.1746462-1-vgupta@synopsys.com>
Message-ID-Hash: VB56LWJLBK4YHEIDYJ5P2Z32XKJYZVRK
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

I love your patch! Yet something to improve:


url:    https://github.com/0day-ci/linux/commits/Vineet-Gupta/ARC-plat-eznps-Drop-support-for-EZChip-NPS-platform/20200909-121133 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
config: arc-randconfig-r026-20200909
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arc/Kconfig:100: can't open file "arch/arc/plat-eznps/Kconfig"
   make[2]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
   make[1]: *** [Makefile:606: oldconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> arch/arc/Kconfig:100: can't open file "arch/arc/plat-eznps/Kconfig"
   make[2]: *** [scripts/kconfig/Makefile:71: olddefconfig] Error 1
   make[1]: *** [Makefile:606: olddefconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.

# https://github.com/0day-ci/linux/commit/80d11f778086417bae2b58423840deaa2e527ce6 
git remote add linux-review https://github.com/0day-ci/linux 
git fetch --no-tags linux-review Vineet-Gupta/ARC-plat-eznps-Drop-support-for-EZChip-NPS-platform/20200909-121133
git checkout 80d11f778086417bae2b58423840deaa2e527ce6
vim +100 arch/arc/Kconfig

cfdbc2e16e65c1e Vineet Gupta      2013-01-18   96  
072eb693904a52d Christian Ruppert 2013-04-12   97  source "arch/arc/plat-tb10x/Kconfig"
556cc1c5f528dcc Alexey Brodkin    2014-01-27   98  source "arch/arc/plat-axs10x/Kconfig"
cfdbc2e16e65c1e Vineet Gupta      2013-01-18   99  #New platform adds here
966657890e874d3 Noam Camus        2015-10-16 @100  source "arch/arc/plat-eznps/Kconfig"
a518d63777a4e94 Alexey Brodkin    2017-08-15  101  source "arch/arc/plat-hsdk/Kconfig"
93ad700de2abc11 Vineet Gupta      2013-01-22  102  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
