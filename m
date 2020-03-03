Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9948120717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCCEb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:31:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:55138 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgCCEb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:31:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 20:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="243458952"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2020 20:31:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j8zDl-0006TO-DM; Tue, 03 Mar 2020 12:31:53 +0800
Date:   Tue, 3 Mar 2020 12:31:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Message-ID: <202003031201.WdZ9GaGO%lkp@intel.com>
References: <20200302175135.269397-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302175135.269397-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on usb/usb-testing linus/master v5.6-rc4 next-20200302]
[cannot apply to linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/serial-sysrq-Add-MAGIC_SYSRQ_SERIAL_SEQUENCE/20200303-041809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

New smatch warnings:
drivers/tty/serial/serial_core.c:3123 uart_try_toggle_sysrq() warn: unsigned '++port->sysrq_seq' is never less than zero.

Old smatch warnings:
drivers/tty/serial/serial_core.c:298 uart_shutdown() error: we previously assumed 'uport' could be null (see line 294)
drivers/tty/serial/serial_core.c:2741 iomem_base_show() warn: argument 4 to %lX specifier is cast from pointer

vim +3123 drivers/tty/serial/serial_core.c

  3099	
  3100	/**
  3101	 *	uart_try_toggle_sysrq - Enables SysRq from serial line
  3102	 *	@port: uart_port structure where char(s) after BREAK met
  3103	 *	@ch: new character in the sequence after received BREAK
  3104	 *
  3105	 *	Enables magic SysRq when the required sequence is met on port
  3106	 *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
  3107	 *
  3108	 *	Returns false if @ch is out of enabling sequence and should be
  3109	 *	handled some other way, true if @ch was consumed.
  3110	 */
  3111	static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
  3112	{
  3113		if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
  3114			return false;
  3115	
  3116		BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= U8_MAX);
  3117		if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
  3118			port->sysrq_seq = 0;
  3119			return false;
  3120		}
  3121	
  3122		/* Without the last \0 */
> 3123		if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
  3124			port->sysrq = jiffies + SYSRQ_TIMEOUT;
  3125			return true;
  3126		}
  3127	
  3128		schedule_work(&sysrq_enable_work);
  3129	
  3130		port->sysrq = 0;
  3131		return true;
  3132	}
  3133	#else
  3134	static inline bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
  3135	{
  3136		return false;
  3137	}
  3138	#endif
  3139	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
