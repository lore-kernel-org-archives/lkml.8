Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C3FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166CD20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391401AbgEZTcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:32:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:33173 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbgEZS5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:57:05 -0400
IronPort-SDR: CbgDL+WO6Es/v0ppoG6NgY0li+9rVOB9BiVxsV8UpiAPZp828kSTUxIcG/gdjQyVb+WFtuXTu7
 cPWqexh9j9YA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 11:56:49 -0700
IronPort-SDR: /Vo4HN/8kret3AjeE1jVRax+oaQBs2NZyYkcTMx4ZMqkDZztvJKEiWxgNCBOtRzS8xN5JTEI4q
 4sB91I7n9IMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="gz'50?scan'50,208,50";a="413923179"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 May 2020 11:56:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdeko-000IxW-4v; Wed, 27 May 2020 02:56:46 +0800
Date:   Wed, 27 May 2020 02:55:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 2/2] clk: Remove CONFIG_ARCH_HISI check for subdir
 hisilicon
Message-ID: <202005270245.sb1paW0C%lkp@intel.com>
References: <1590377516-32117-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1590377516-32117-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tiezhu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v5.7-rc7 next-20200526]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Tiezhu-Yang/clk-hisilicon-Use-correct-return-value-about-hisi_reset_init/20200525-113342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_rate':
>> clk.c:(.text+0x9e): undefined reference to `clk_register_fixed_rate'
>> ld: clk.c:(.text+0xdf): undefined reference to `clk_unregister_fixed_rate'
ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_factor':
>> clk.c:(.text+0x117): undefined reference to `clk_register_fixed_factor'
>> ld: clk.c:(.text+0x158): undefined reference to `clk_unregister_fixed_factor'
ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_mux':
>> clk.c:(.text+0x1cb): undefined reference to `clk_register_mux_table'
>> ld: clk.c:(.text+0x1f2): undefined reference to `clk_register_clkdev'
>> ld: clk.c:(.text+0x21a): undefined reference to `clk_unregister_mux'
ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_divider':
>> clk.c:(.text+0x2c9): undefined reference to `clk_register_divider_table'
ld: clk.c:(.text+0x2e3): undefined reference to `clk_register_clkdev'
>> ld: clk.c:(.text+0x311): undefined reference to `clk_unregister_divider'
ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate':
>> clk.c:(.text+0x36c): undefined reference to `clk_register_gate'
ld: clk.c:(.text+0x393): undefined reference to `clk_register_clkdev'
>> ld: clk.c:(.text+0x3bb): undefined reference to `clk_unregister_gate'
ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate_sep':
>> clk.c:(.text+0x425): undefined reference to `clk_register_clkdev'
ld: drivers/clk/hisilicon/clk.o: in function `hi6220_clk_register_divider':
>> clk.c:(.init.text+0x5d): undefined reference to `clk_register_clkdev'
ld: drivers/clk/hisilicon/clkgate-separated.o: in function `hisi_register_clkgate_sep':
>> clkgate-separated.c:(.text+0xf0): undefined reference to `clk_register'
ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_set_rate':
>> clkdivider-hi6220.c:(.text+0x16): undefined reference to `divider_get_val'
ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_recalc_rate':
>> clkdivider-hi6220.c:(.text+0x8a): undefined reference to `divider_recalc_rate'
ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_round_rate':
>> clkdivider-hi6220.c:(.text+0xa9): undefined reference to `clk_hw_get_parent'
>> ld: clkdivider-hi6220.c:(.text+0xbd): undefined reference to `divider_round_rate_parent'
ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_register_clkdiv':
>> clkdivider-hi6220.c:(.text+0x1c5): undefined reference to `clk_register'
ld: drivers/clk/hisilicon/clk-hisi-phase.o: in function `clk_register_hisi_phase':
>> clk-hisi-phase.c:(.text+0x121): undefined reference to `devm_clk_register'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wc/uHfmao57/AZ0i3udtaAAA

--cNdxnHkX5QqsyA0e--
