Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70057C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE6C20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDGS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:26:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:41987 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgDGS0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:26:52 -0400
IronPort-SDR: urXE5R3gCi8824SEk9+8X4SodfFT2gSQlCWhnomx7SZBzsBLFfDLNIBSeA+TipBVHkUnWjsw+V
 oTPV//PRcH2Q==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:26:49 -0700
IronPort-SDR: 7RU9XkLPjcHUGLvgHxdygZouiWMK78Ke7IPHl/jDXeIeSjY74bC74CDv7gv3e+Ajygei5Aw5NS
 9mB/D/KkRuDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="gz'50?scan'50,208,50";a="452553818"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2020 11:26:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jLsvr-0004F0-7j; Wed, 08 Apr 2020 02:26:43 +0800
Date:   Wed, 8 Apr 2020 02:26:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com,
        peterz@infradead.org, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <202004080206.POVqN6ir%lkp@intel.com>
References: <20200407111007.352324393@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20200407111007.352324393@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/auto-latest]
[also build test ERROR on linus/master next-20200407]
[cannot apply to jeyu/modules-next tip/x86/core v5.6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/x86-module-Out-of-tree-module-decode-and-sanitize/20200408-011239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ee8bac724cc7767dcf9480afb656318994f22c3d
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/x86/um/../kernel/module.o: in function `decode_module':
>> module.c:(.text+0x26): undefined reference to `split_lock_enabled'
>> /usr/bin/ld: module.c:(.text+0x39): undefined reference to `insn_init'
>> /usr/bin/ld: module.c:(.text+0x6b): undefined reference to `insn_get_length'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FqBk7PHYuri3POK0AfR/Z9Jw+DuDAAA=

--oyUTqETQ0mS9luUI--
