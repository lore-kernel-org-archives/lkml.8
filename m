Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE09C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2C8204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHQMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:33:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:37981 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgHQMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:33:28 -0400
IronPort-SDR: T8dNiCh+zS6gAADBbV4e4kp965FYeJ5yOg7ekEzPZW2+JZou1pc/lRQr95bYVdAMgEse8BC0Hq
 v+hkboj597Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134206108"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="gz'50?scan'50,208,50";a="134206108"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 05:33:26 -0700
IronPort-SDR: 5wkbdHnQY+fuueZCy7t8ienr+Ne9DrTdLGUHp4gK1OpM2TJZ7gJRxmjfiZf/TYpUhqF+byX6RX
 zK87ZyQQp42Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="gz'50?scan'50,208,50";a="296469508"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2020 05:33:23 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7eKI-0000Xw-R3; Mon, 17 Aug 2020 12:33:22 +0000
Date:   Mon, 17 Aug 2020 20:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allen Pais <allen.lkml@gmail.com>, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        heiko@sntech.de, matthias.bgg@gmail.com
Cc:     kbuild-all@lists.01.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org
Subject: Re: [PATCH 18/19] crypto: talitos: convert tasklets to use new
 tasklet_setup() API
Message-ID: <202008172016.gwrO1uLq%lkp@intel.com>
References: <20200817080941.19227-19-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20200817080941.19227-19-allen.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Allen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cryptodev/master]
[also build test ERROR on crypto/master rockchip/for-next v5.9-rc1 next-20200817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Allen-Pais/crypto-convert-tasklets-to-use-new-tasklet_setup/20200817-161307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: powerpc-mpc83xx_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/crypto/talitos.c: In function 'talitos1_done_4ch':
   drivers/crypto/talitos.c:407:33: error: implicit declaration of function 'from_tasklet' [-Werror=implicit-function-declaration]
     407 |  struct talitos_private *priv = from_tasklet(priv, t,  \
         |                                 ^~~~~~~~~~~~
   drivers/crypto/talitos.c:429:1: note: in expansion of macro 'DEF_TALITOS1_DONE'
     429 | DEF_TALITOS1_DONE(4ch, TALITOS1_ISR_4CHDONE)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c:408:3: error: 'done_task' undeclared (first use in this function); did you mean 'free_task'?
     408 |   done_task[0]);      \
         |   ^~~~~~~~~
   drivers/crypto/talitos.c:429:1: note: in expansion of macro 'DEF_TALITOS1_DONE'
     429 | DEF_TALITOS1_DONE(4ch, TALITOS1_ISR_4CHDONE)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c:408:3: note: each undeclared identifier is reported only once for each function it appears in
     408 |   done_task[0]);      \
         |   ^~~~~~~~~
   drivers/crypto/talitos.c:429:1: note: in expansion of macro 'DEF_TALITOS1_DONE'
     429 | DEF_TALITOS1_DONE(4ch, TALITOS1_ISR_4CHDONE)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c: In function 'talitos1_done_ch0':
   drivers/crypto/talitos.c:408:3: error: 'done_task' undeclared (first use in this function); did you mean 'free_task'?
     408 |   done_task[0]);      \
         |   ^~~~~~~~~
   drivers/crypto/talitos.c:430:1: note: in expansion of macro 'DEF_TALITOS1_DONE'
     430 | DEF_TALITOS1_DONE(ch0, TALITOS1_ISR_CH_0_DONE)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c: In function 'talitos2_done_4ch':
   drivers/crypto/talitos.c:436:3: error: 'done_task' undeclared (first use in this function); did you mean 'free_task'?
     436 |   done_task[tasklet_idx]);    \
         |   ^~~~~~~~~
   drivers/crypto/talitos.c:457:1: note: in expansion of macro 'DEF_TALITOS2_DONE'
     457 | DEF_TALITOS2_DONE(4ch, TALITOS2_ISR_4CHDONE, 0)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c: At top level:
>> drivers/crypto/talitos.c:458:46: error: macro "DEF_TALITOS2_DONE" requires 3 arguments, but only 2 given
     458 | DEF_TALITOS2_DONE(ch0, TALITOS2_ISR_CH_0_DONE), 0
         |                                              ^
   drivers/crypto/talitos.c:432: note: macro "DEF_TALITOS2_DONE" defined here
     432 | #define DEF_TALITOS2_DONE(name, ch_done_mask, tasklet_idx)  \
         | 
>> drivers/crypto/talitos.c:458:1: warning: data definition has no type or storage class
     458 | DEF_TALITOS2_DONE(ch0, TALITOS2_ISR_CH_0_DONE), 0
         | ^~~~~~~~~~~~~~~~~
>> drivers/crypto/talitos.c:458:1: error: type defaults to 'int' in declaration of 'DEF_TALITOS2_DONE' [-Werror=implicit-int]
>> drivers/crypto/talitos.c:458:49: error: expected identifier or '(' before numeric constant
     458 | DEF_TALITOS2_DONE(ch0, TALITOS2_ISR_CH_0_DONE), 0
         |                                                 ^
   drivers/crypto/talitos.c: In function 'talitos2_done_ch1_3':
   drivers/crypto/talitos.c:436:3: error: 'done_task' undeclared (first use in this function); did you mean 'free_task'?
     436 |   done_task[tasklet_idx]);    \
         |   ^~~~~~~~~
   drivers/crypto/talitos.c:460:1: note: in expansion of macro 'DEF_TALITOS2_DONE'
     460 | DEF_TALITOS2_DONE(ch1_3, TALITOS2_ISR_CH_1_3_DONE, 1)
         | ^~~~~~~~~~~~~~~~~
   drivers/crypto/talitos.c: In function 'talitos_probe':
   drivers/crypto/talitos.c:3390:4: error: implicit declaration of function 'tasklet_setup' [-Werror=implicit-function-declaration]
    3390 |    tasklet_setup(&priv->done_task[0], talitos1_done_ch0);
         |    ^~~~~~~~~~~~~
>> drivers/crypto/talitos.c:3395:39: error: 'talitos2_done_ch0_2' undeclared (first use in this function); did you mean 'talitos2_done_ch1_3'?
    3395 |    tasklet_setup(&priv->done_task[0], talitos2_done_ch0_2);
         |                                       ^~~~~~~~~~~~~~~~~~~
         |                                       talitos2_done_ch1_3
>> drivers/crypto/talitos.c:3398:39: error: 'talitos2_done_ch0' undeclared (first use in this function); did you mean 'talitos1_done_ch0'?
    3398 |    tasklet_setup(&priv->done_task[0], talitos2_done_ch0);
         |                                       ^~~~~~~~~~~~~~~~~
         |                                       talitos1_done_ch0
   cc1: some warnings being treated as errors

# https://github.com/0day-ci/linux/commit/0007edb339f5f9e0882f5503565ec00b1e835c03
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Allen-Pais/crypto-convert-tasklets-to-use-new-tasklet_setup/20200817-161307
git checkout 0007edb339f5f9e0882f5503565ec00b1e835c03
vim +/DEF_TALITOS2_DONE +458 drivers/crypto/talitos.c

   456	
   457	DEF_TALITOS2_DONE(4ch, TALITOS2_ISR_4CHDONE, 0)
 > 458	DEF_TALITOS2_DONE(ch0, TALITOS2_ISR_CH_0_DONE), 0
   459	DEF_TALITOS2_DONE(ch0_2, TALITOS2_ISR_CH_0_2_DONE, 0)
   460	DEF_TALITOS2_DONE(ch1_3, TALITOS2_ISR_CH_1_3_DONE, 1)
   461	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2lfZHvwV5h/72hJWGj4BAA==

--Kj7319i9nmIyA2yE--
