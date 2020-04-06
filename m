Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B654C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F459206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDFIxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:53:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:3992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgDFIxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:53:10 -0400
IronPort-SDR: lVZQZzyf4E2tq7eKqtf7kV+WPyEy4Kh2VaVvIvhIXgLg+ZBL/BJZQEza0Mlzs0GnV0ECmVQsWx
 LuPFDrSWFjdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 01:53:08 -0700
IronPort-SDR: 1OiTmSfBdClOHMmb8kC2/tRljBav3tAHaJPPd1EjVO//RkkIGht5nMK7V7t2M9mD6Ne9+FLvsR
 /fqZQSCYK7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="250828319"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2020 01:53:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jLNVC-0001c8-73; Mon, 06 Apr 2020 16:53:06 +0800
Date:   Mon, 6 Apr 2020 16:53:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Oder Chiou <oder_chiou@realtek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: idx = rt5682_div_sel(rt5682, dmic_clk_rate, div, ARRAY_SIZE(div));
Message-ID: <202004061600.kSWORDaa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a10c9c710f9ecea87b9f4bbb837467893b4bef01
commit: 9a74c44a6f675e4e991437eee39496109b601629 ASoC: rt5682: Add a property for DMIC clock rate
date:   2 weeks ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   sound/soc/codecs/rt5682.c:2394:65: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
         (pll_code.m_bp ? 0 : pll_code.m_code) << RT5682_PLL_M_SFT |
                                                                   ^
   sound/soc/codecs/rt5682.c:1240:6: warning: Redundant initialization for 'idx'. The initialized value is overwritten before it is read. [redundantInitialization]
>>  idx = rt5682_div_sel(rt5682, dmic_clk_rate, div, ARRAY_SIZE(div));
        ^
   sound/soc/codecs/rt5682.c:1234:10: note: idx is initialized
>>  int idx = -EINVAL, dmic_clk_rate = 3072000;
            ^
   sound/soc/codecs/rt5682.c:1240:6: note: idx is overwritten
>>  idx = rt5682_div_sel(rt5682, dmic_clk_rate, div, ARRAY_SIZE(div));
        ^
   sound/soc/codecs/rt5682.c:1269:6: warning: Redundant initialization for 'idx'. The initialized value is overwritten before it is read. [redundantInitialization]
    idx = rt5682_div_sel(rt5682, ref, div_f, ARRAY_SIZE(div_f));
        ^
   sound/soc/codecs/rt5682.c:1254:25: note: idx is initialized
    int ref, val, reg, idx = -EINVAL;
                           ^
   sound/soc/codecs/rt5682.c:1269:6: note: idx is overwritten
    idx = rt5682_div_sel(rt5682, ref, div_f, ARRAY_SIZE(div_f));
        ^
   sound/soc/codecs/rt5682.c:918:15: warning: The scope of the variable 'val' can be reduced. [variableScope]
    unsigned int val, count;
                 ^
   sound/soc/codecs/rt5682.c:918:20: warning: The scope of the variable 'count' can be reduced. [variableScope]
    unsigned int val, count;
                      ^
   sound/soc/codecs/rt5682.c:1085:11: warning: The scope of the variable 'btn_type' can be reduced. [variableScope]
    int val, btn_type;
             ^
   sound/soc/codecs/rt5682.c:2288:15: warning: The scope of the variable 'pll2_fout1' can be reduced. [variableScope]
    unsigned int pll2_fout1;
                 ^
   sound/soc/codecs/rt5682.c:2844:16: warning: The scope of the variable 'time' can be reduced. [variableScope]
    unsigned long time;
                  ^
   sound/soc/codecs/rt5682.c:2733:7: warning: Either the condition '!dai' is redundant or there is possible null pointer dereference: dai. [nullPointerRedundantCheck]
     if (dai->id == RT5682_AIF1)
         ^
   sound/soc/codecs/rt5682.c:2735:6: note: Assuming that condition '!dai' is not redundant
    if (!dai) {
        ^
   sound/soc/codecs/rt5682.c:2733:7: note: Null pointer dereference
     if (dai->id == RT5682_AIF1)
         ^

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
