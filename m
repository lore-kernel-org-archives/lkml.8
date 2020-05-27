Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973EA20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgE0PfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:35:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:20458 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgE0PfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:35:04 -0400
IronPort-SDR: huMKgE7xiPxuJPymovmBoV3o4MayGtvRIT/hbMoQhutBl9SNLxfV9wMdVvHM4XWpRRH23NznKj
 qpB3lh3Ob7Sw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 08:34:57 -0700
IronPort-SDR: Mwtc5Op92tlTuWfEIyCknT8qEsT/vXV75fZHXovIHM2I4NLCaXQ42XuGdGdU+ni58wupz9ZuDE
 0Vmh+XB/X3Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="gz'50?scan'50,208,50";a="256794701"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2020 08:34:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdy51-000Hua-JC; Wed, 27 May 2020 23:34:55 +0800
Date:   Wed, 27 May 2020 23:34:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:WIP.sched/core 7/9] smp.c:undefined reference to
 `irq_work_single'
Message-ID: <202005272334.U8mnIlfl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
head:   68a1740c687d4a75b9e9dea0ab0aae61f167c880
commit: 5033cfdeb4a2a51fa847b1a3f5f6eee65dda6c75 [7/9] irq_work, smp: Allow irq_work on call_single_queue
config: s390-allnoconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5033cfdeb4a2a51fa847b1a3f5f6eee65dda6c75
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

s390-linux-ld: kernel/smp.o: in function `flush_smp_call_function_queue':
<< kernel/smp.c:799: warning: cannot understand function prototype: 'struct smp_call_on_cpu_struct '
>> smp.c:(.text+0x110): undefined reference to `irq_work_single'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7q/z/B02yWn/R9k0qIuZVPx/AWPMv1XUWAAA

--yrj/dFKFPuw6o+aM--
