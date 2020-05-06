Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF7C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DEC20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEFCDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:03:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:64217 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgEFCDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:03:06 -0400
IronPort-SDR: YPT0p9Zvr4gsBkQGrEzPKCYSxrvuorkGFFzfjGoUjT+pEZbjaPUdsMml18juorpjqcD1u8YmIJ
 2n4HYMh7PnkA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 18:58:02 -0700
IronPort-SDR: lsOzih7Xf4VNajXYKrDCmIjj/dMzfltz+0HwKcHKa915wiW/cJGPp33hKpfFDQeMZ/i3OC7buB
 hr/v2V7n1s8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="gz'50?scan'50,208,50";a="259952769"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2020 18:58:01 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jW9Jw-0005Gu-A2; Wed, 06 May 2020 09:58:00 +0800
Date:   Wed, 6 May 2020 09:57:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:tglx.2020.05.05a 48/140] arch/um/include/asm/irqflags.h:5:
 Error: no such instruction: `extern int get_signals(void)'
Message-ID: <202005060909.cmc31JbI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx.2020.05.05a
head:   e6d36eed49b863bbe393e3c07cae737cd9c475e3
commit: 1af1a839cb2f00c8d7533102ece276ac315ecef2 [48/140] x86/entry/64: Check IF in __preempt_enable_notrace() thunk
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        git checkout 1af1a839cb2f00c8d7533102ece276ac315ecef2
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/um/include/asm/irqflags.h: Assembler messages:
>> arch/um/include/asm/irqflags.h:5: Error: no such instruction: `extern int get_signals(void)'
>> arch/um/include/asm/irqflags.h:6: Error: no such instruction: `extern int set_signals(int enable)'
>> arch/um/include/asm/irqflags.h:7: Error: no such instruction: `extern void block_signals(void)'
>> arch/um/include/asm/irqflags.h:8: Error: no such instruction: `extern void unblock_signals(void)'
>> arch/um/include/asm/irqflags.h:11: Error: no such instruction: `static inline unsigned long arch_local_save_flags(void)'
>> arch/um/include/asm/irqflags.h:12: Error: no such instruction: `{'
>> arch/um/include/asm/irqflags.h:13: Error: no such instruction: `return get_signals()'
>> arch/um/include/asm/irqflags.h:14: Error: junk at end of line, first unrecognized character is `}'
>> arch/um/include/asm/irqflags.h:17: Error: no such instruction: `static inline void arch_local_irq_restore(unsigned long flags)'
   arch/um/include/asm/irqflags.h:18: Error: no such instruction: `{'
>> arch/um/include/asm/irqflags.h:19: Error: invalid character '(' in mnemonic
   arch/um/include/asm/irqflags.h:20: Error: junk at end of line, first unrecognized character is `}'
>> arch/um/include/asm/irqflags.h:23: Error: no such instruction: `static inline void arch_local_irq_enable(void)'
   arch/um/include/asm/irqflags.h:24: Error: no such instruction: `{'
   arch/um/include/asm/irqflags.h:25: Error: invalid character '(' in mnemonic
   arch/um/include/asm/irqflags.h:26: Error: junk at end of line, first unrecognized character is `}'
>> arch/um/include/asm/irqflags.h:29: Error: no such instruction: `static inline void arch_local_irq_disable(void)'
   arch/um/include/asm/irqflags.h:30: Error: no such instruction: `{'
   arch/um/include/asm/irqflags.h:31: Error: invalid character '(' in mnemonic
   arch/um/include/asm/irqflags.h:32: Error: junk at end of line, first unrecognized character is `}'
>> include/asm-generic/irqflags.h:26: Error: no such instruction: `static inline unsigned long arch_local_irq_save(void)'
>> include/asm-generic/irqflags.h:27: Error: no such instruction: `{'
>> include/asm-generic/irqflags.h:28: Error: no such instruction: `unsigned long flags'
>> include/asm-generic/irqflags.h:29: Error: junk at end of line, first unrecognized character is `('
>> include/asm-generic/irqflags.h:30: Error: no such instruction: `arch_local_irq_restore(0)'
>> include/asm-generic/irqflags.h:31: Error: no such instruction: `return flags'
>> include/asm-generic/irqflags.h:32: Error: junk at end of line, first unrecognized character is `}'
>> include/asm-generic/irqflags.h:37: Error: no such instruction: `static inline int arch_irqs_disabled_flags(unsigned long flags)'
   include/asm-generic/irqflags.h:38: Error: no such instruction: `{'
   include/asm-generic/irqflags.h:39: Error: no such instruction: `return flags==0'
   include/asm-generic/irqflags.h:40: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/irqflags.h:61: Error: no such instruction: `static inline int arch_irqs_disabled(void)'
   include/asm-generic/irqflags.h:62: Error: no such instruction: `{'
   include/asm-generic/irqflags.h:63: Error: no such instruction: `return arch_irqs_disabled_flags(arch_local_save_flags())'
   include/asm-generic/irqflags.h:64: Error: junk at end of line, first unrecognized character is `}'

vim +5 arch/um/include/asm/irqflags.h

65e62974a8a615 include/asm-um/irqflags.h      Jeff Dike     2006-06-04   4  
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  @5  extern int get_signals(void);
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  @6  extern int set_signals(int enable);
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  @7  extern void block_signals(void);
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  @8  extern void unblock_signals(void);
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18   9  
3e938957357459 arch/um/include/asm/irqflags.h Daniel Wagner 2016-06-12  10  #define arch_local_save_flags arch_local_save_flags
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @11  static inline unsigned long arch_local_save_flags(void)
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @12  {
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @13  	return get_signals();
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @14  }
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  15  
3e938957357459 arch/um/include/asm/irqflags.h Daniel Wagner 2016-06-12  16  #define arch_local_irq_restore arch_local_irq_restore
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @17  static inline void arch_local_irq_restore(unsigned long flags)
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  18  {
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @19  	set_signals(flags);
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  20  }
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  21  
3e938957357459 arch/um/include/asm/irqflags.h Daniel Wagner 2016-06-12  22  #define arch_local_irq_enable arch_local_irq_enable
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @23  static inline void arch_local_irq_enable(void)
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  24  {
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  25  	unblock_signals();
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  26  }
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  27  
3e938957357459 arch/um/include/asm/irqflags.h Daniel Wagner 2016-06-12  28  #define arch_local_irq_disable arch_local_irq_disable
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18 @29  static inline void arch_local_irq_disable(void)
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  30  {
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  31  	block_signals();
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  32  }
a34978cbd977ab arch/um/include/asm/irqflags.h Al Viro       2011-08-18  33  

:::::: The code at line 5 was first introduced by commit
:::::: a34978cbd977ab62c744f63daacd9dc1474482be um: kill system-um.h

:::::: TO: Al Viro <viro@ftp.linux.org.uk>
:::::: CC: Richard Weinberger <richard@nod.at>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+HP7ph2BbKc20aGI--
