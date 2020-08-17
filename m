Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A876FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736DE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgHQUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:10:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:30370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgHQUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:10:20 -0400
IronPort-SDR: IcqP6om48K8zGhgqMUG9XNUMOoWYXwc4M8MVe1n0M90bnViLeaLm34xt/UxAMxYwSnSwHEqjlS
 pRZndPc63ZfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154757898"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="gz'50?scan'50,208,50";a="154757898"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 13:09:44 -0700
IronPort-SDR: 3IX7wmMcPkzy0uebMcFS/+rkUDtJSKcihawy3xIHk24rtLqgZd788KP/dTt0NGEZG2U7ytF78I
 gfWnYeQ+ULLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="gz'50?scan'50,208,50";a="328735827"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2020 13:09:41 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7lRs-0000nf-Gx; Mon, 17 Aug 2020 20:09:40 +0000
Date:   Tue, 18 Aug 2020 04:09:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH v2 2/2] tty/sysrq: Add configurable handler to execute a
 compound action
Message-ID: <202008180432.QeU9MPWz%lkp@intel.com>
References: <20200817132727.14564-3-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20200817132727.14564-3-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrzej,

I love your patch! Yet something to improve:

[auto build test ERROR on 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5]

url:    https://github.com/0day-ci/linux/commits/Andrzej-Pietrasiewicz/Add-configurable-handler-to-execute-a-compound-action/20200817-212944
base:    9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
config: powerpc-tqm8xx_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/tty/sysrq.c:1158:1: error: expected identifier or '(' before '{' token
    1158 | {
         | ^
   drivers/tty/sysrq.c: In function 'sysrq_action_compound':
>> drivers/tty/sysrq.c:1163:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1163 | {
         | ^
   drivers/tty/sysrq.c:1167:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1167 | {
         | ^
   drivers/tty/sysrq.c:1173:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1173 | {
         | ^
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/rculist.h:10,
                    from include/linux/sched/signal.h:5,
                    from drivers/tty/sysrq.c:18:
>> drivers/tty/sysrq.c:1187:19: error: storage class specified for parameter 'sysrq_toggle_support'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:21: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                     ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:99:20: error: storage class specified for parameter '__kstrtab_sysrq_toggle_support'
      99 |  extern const char __kstrtab_##sym[];     \
         |                    ^~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:100:20: error: storage class specified for parameter '__kstrtabns_sysrq_toggle_support'
     100 |  extern const char __kstrtabns_##sym[];     \
         |                    ^~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:101:24: error: expected declaration specifiers before ';' token
     101 |  __CRC_SYMBOL(sym, sec);       \
         |                        ^
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:102:2: error: expected declaration specifiers before 'asm'
     102 |  asm(" .section \"__ksymtab_strings\",\"aMS\",%progbits,1 \n" \
         |  ^~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
   include/linux/export.h:67:36: error: storage class specified for parameter '__ksymtab_sysrq_toggle_support'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:67:22: error: parameter '__ksymtab_sysrq_toggle_support' is initialized
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                      ^~~~~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:67:36: error: section attribute not allowed for '__ksymtab_sysrq_toggle_support'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:67:22: warning: 'used' attribute ignored [-Wattributes]
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                      ^~~~~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/export.h:67:36: error: alignment may not be specified for '__ksymtab_sysrq_toggle_support'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1187:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1187 | EXPORT_SYMBOL_GPL(sysrq_toggle_support);
         | ^~~~~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1191:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1191 | {
         | ^
   drivers/tty/sysrq.c:1214:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1214 | {
         | ^
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/rculist.h:10,
                    from include/linux/sched/signal.h:5,
                    from drivers/tty/sysrq.c:18:
>> drivers/tty/sysrq.c:1217:15: error: storage class specified for parameter 'register_sysrq_key'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         |               ^~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:21: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                     ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:99:20: error: storage class specified for parameter '__kstrtab_register_sysrq_key'
      99 |  extern const char __kstrtab_##sym[];     \
         |                    ^~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:100:20: error: storage class specified for parameter '__kstrtabns_register_sysrq_key'
     100 |  extern const char __kstrtabns_##sym[];     \
         |                    ^~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:101:24: error: expected declaration specifiers before ';' token
     101 |  __CRC_SYMBOL(sym, sec);       \
         |                        ^
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:102:2: error: expected declaration specifiers before 'asm'
     102 |  asm(" .section \"__ksymtab_strings\",\"aMS\",%progbits,1 \n" \
         |  ^~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
   include/linux/export.h:67:36: error: storage class specified for parameter '__ksymtab_register_sysrq_key'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:67:22: error: parameter '__ksymtab_register_sysrq_key' is initialized
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                      ^~~~~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:67:36: error: section attribute not allowed for '__ksymtab_register_sysrq_key'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:67:22: warning: 'used' attribute ignored [-Wattributes]
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                      ^~~~~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
>> include/linux/export.h:67:36: error: alignment may not be specified for '__ksymtab_register_sysrq_key'
      67 |  static const struct kernel_symbol __ksymtab_##sym  \
         |                                    ^~~~~~~~~~
   include/linux/export.h:108:2: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |  __KSYMTAB_ENTRY(sym, sec)
         |  ^~~~~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1217:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1217 | EXPORT_SYMBOL(register_sysrq_key);
         | ^~~~~~~~~~~~~
   drivers/tty/sysrq.c:1220:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1220 | {
         | ^
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/rculist.h:10,
                    from include/linux/sched/signal.h:5,
                    from drivers/tty/sysrq.c:18:
   drivers/tty/sysrq.c:1223:15: error: storage class specified for parameter 'unregister_sysrq_key'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);
         |               ^~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:21: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                     ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1223:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);
         | ^~~~~~~~~~~~~
   include/linux/export.h:99:20: error: storage class specified for parameter '__kstrtab_unregister_sysrq_key'
      99 |  extern const char __kstrtab_##sym[];     \
         |                    ^~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1223:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);
         | ^~~~~~~~~~~~~
   include/linux/export.h:100:20: error: storage class specified for parameter '__kstrtabns_unregister_sysrq_key'
     100 |  extern const char __kstrtabns_##sym[];     \
         |                    ^~~~~~~~~~~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1223:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);
         | ^~~~~~~~~~~~~
   include/linux/export.h:101:24: error: expected declaration specifiers before ';' token
     101 |  __CRC_SYMBOL(sym, sec);       \
         |                        ^
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1223:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);
         | ^~~~~~~~~~~~~
   include/linux/export.h:102:2: error: expected declaration specifiers before 'asm'
     102 |  asm(" .section \"__ksymtab_strings\",\"aMS\",%progbits,1 \n" \
         |  ^~~
   include/linux/export.h:147:39: note: in expansion of macro '___EXPORT_SYMBOL'
     147 | #define __EXPORT_SYMBOL(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   drivers/tty/sysrq.c:1223:1: note: in expansion of macro 'EXPORT_SYMBOL'
    1223 | EXPORT_SYMBOL(unregister_sysrq_key);

# https://github.com/0day-ci/linux/commit/1e30be974437c14ffdccaf1af02f5b6911ec1468
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Andrzej-Pietrasiewicz/Add-configurable-handler-to-execute-a-compound-action/20200817-212944
git checkout 1e30be974437c14ffdccaf1af02f5b6911ec1468
vim +1158 drivers/tty/sysrq.c

  1157	
> 1158	{
  1159	}
  1160	
> 1161	static void sysrq_action_compound(int key)
  1162	static inline void sysrq_register_handler(void)
> 1163	{
  1164	}
  1165	
  1166	static inline void sysrq_unregister_handler(void)
  1167	{
  1168	}
  1169	
  1170	#endif /* CONFIG_INPUT */
  1171	
  1172	int sysrq_toggle_support(int enable_mask)
  1173	{
  1174		bool was_enabled = sysrq_on();
  1175	
  1176		sysrq_enabled = enable_mask;
  1177	
  1178		if (was_enabled != sysrq_on()) {
  1179			if (sysrq_on())
  1180				sysrq_register_handler();
  1181			else
  1182				sysrq_unregister_handler();
  1183		}
  1184	
  1185		return 0;
  1186	}
> 1187	EXPORT_SYMBOL_GPL(sysrq_toggle_support);
  1188	
  1189	static int __sysrq_swap_key_ops(int key, const struct sysrq_key_op *insert_op_p,
  1190	                                const struct sysrq_key_op *remove_op_p)
  1191	{
  1192		int retval;
  1193	
  1194		spin_lock(&sysrq_key_table_lock);
  1195		if (__sysrq_get_key_op(key) == remove_op_p) {
  1196			__sysrq_put_key_op(key, insert_op_p);
  1197			retval = 0;
  1198		} else {
  1199			retval = -1;
  1200		}
  1201		spin_unlock(&sysrq_key_table_lock);
  1202	
  1203		/*
  1204		 * A concurrent __handle_sysrq either got the old op or the new op.
  1205		 * Wait for it to go away before returning, so the code for an old
  1206		 * op is not freed (eg. on module unload) while it is in use.
  1207		 */
  1208		synchronize_rcu();
  1209	
  1210		return retval;
  1211	}
  1212	
  1213	int register_sysrq_key(int key, const struct sysrq_key_op *op_p)
  1214	{
  1215		return __sysrq_swap_key_ops(key, op_p, NULL);
  1216	}
> 1217	EXPORT_SYMBOL(register_sysrq_key);
  1218	
  1219	int unregister_sysrq_key(int key, const struct sysrq_key_op *op_p)
  1220	{
  1221		return __sysrq_swap_key_ops(key, NULL, op_p);
  1222	}
> 1223	EXPORT_SYMBOL(unregister_sysrq_key);
  1224	
  1225	#ifdef CONFIG_PROC_FS
  1226	/*
  1227	 * writing 'C' to /proc/sysrq-trigger is like sysrq-C
  1228	 */
  1229	static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
  1230					   size_t count, loff_t *ppos)
  1231	{
  1232		if (count) {
  1233			char c;
  1234	
  1235			if (get_user(c, buf))
  1236				return -EFAULT;
  1237			__handle_sysrq(c, false);
  1238		}
  1239	
  1240		return count;
  1241	}
  1242	
> 1243	static const struct proc_ops sysrq_trigger_proc_ops = {
> 1244		.proc_write	= write_sysrq_trigger,
  1245		.proc_lseek	= noop_llseek,
  1246	};
  1247	
  1248	static void sysrq_init_procfs(void)
  1249	{
  1250		if (!proc_create("sysrq-trigger", S_IWUSR, NULL,
  1251				 &sysrq_trigger_proc_ops))
  1252			pr_err("Failed to register proc interface\n");
  1253	}
  1254	
  1255	#else
  1256	
  1257	static inline void sysrq_init_procfs(void)
  1258	{
  1259	}
  1260	
  1261	#endif /* CONFIG_PROC_FS */
  1262	
  1263	static int __init sysrq_init(void)
  1264	{
  1265		sysrq_init_procfs();
  1266	
  1267		if (sysrq_on())
  1268			sysrq_register_handler();
  1269	
  1270		return 0;
  1271	}
> 1272	device_initcall(sysrq_init);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--SUOF0GtieIMvvwua--
