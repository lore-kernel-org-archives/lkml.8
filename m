Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C601C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83552078E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 01:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgFVBzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 21:55:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:10019 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgFVBz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 21:55:28 -0400
IronPort-SDR: PJVz47qlVcmwkvue1QhBsIuTL35Yol498DuRt4I/kZ9o02MH03CH4hSZwPwNBKU8hoM2uUsnoc
 8y10OVAQlpsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="132066219"
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="gz'50?scan'50,208,50";a="132066219"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 18:49:58 -0700
IronPort-SDR: RFyBCHFiKS0xK3weFliLkShVYoZt7dZdVVuOwJsIAimF+KqQfy4oP2y9N60X5oA770mB46FQVw
 C50Sedk/fqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="gz'50?scan'50,208,50";a="274868201"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2020 18:49:56 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnBat-0002z0-GU; Mon, 22 Jun 2020 01:49:55 +0000
Date:   Mon, 22 Jun 2020 09:49:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pinctrl/pinctrl-single.c:242:16: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202006220904.Y3JxznDr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   48778464bb7d346b47157d21ffde2af6b2d39110
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 days ago
config: m68k-randconfig-s031-20200622 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc2-13-gc59158c8-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=m68k CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/pinctrl/pinctrl-single.c:242:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/pinctrl-single.c:247:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/pinctrl-single.c:252:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/pinctrl-single.c:257:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/pinctrl-single.c:262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/pinctrl-single.c:267:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/gpio/gpio-altera.c:47:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:50:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:65:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:68:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:111:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:125:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:146:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:167:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:175:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:200:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:201:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:202:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:227:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-altera.c:228:19: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/gpio/gpio-ftgpio010.c:61:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:70:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:72:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:81:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:93:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:94:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:95:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:149:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:192:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:201:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:203:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:207:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:217:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:220:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:302:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:303:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:304:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-ftgpio010.c:307:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/gpio/gpio-menz127.c:69:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:80:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:95:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:103:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/phy/cadence/phy-cadence-torrent.c:281:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/phy/cadence/phy-cadence-torrent.c:291:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/phy/cadence/phy-cadence-torrent.c:301:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/phy/cadence/phy-cadence-torrent.c:312:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/phy/cadence/phy-cadence-salvo.c:114:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/phy/cadence/phy-cadence-salvo.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> fs/debugfs/file.c:1054:28: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/68328fb.c:438:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *static [toplevel] screen_base @@     got void * @@
>> drivers/video/fbdev/68328fb.c:438:29: sparse:     expected char [noderef] __iomem *static [toplevel] screen_base
   drivers/video/fbdev/68328fb.c:438:29: sparse:     got void *
--
>> drivers/tty/serial/sccnxp.c:228:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/sccnxp.c:239:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/tty/serial/uartlite.c:559:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/uartlite.c:565:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/uartlite.c:502:9: sparse: sparse: context imbalance in 'ulite_console_write' - different lock contexts for basic block
--
>> drivers/tty/serial/altera_uart.c:86:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/altera_uart.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/tty/serial/digicolor-usart.c:204:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:283:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:251:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/digicolor-usart.c:412:39: sparse: sparse: context imbalance in 'digicolor_uart_console_write' - different lock contexts for basic block
--
>> drivers/tty/serial/8250/8250_aspeed_vuart.c:69:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:70:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:101:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:123:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:139:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:148:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:155:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:190:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:197:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:205:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:213:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_aspeed_vuart.c:296:12: sparse: sparse: context imbalance in 'aspeed_vuart_handle_irq' - different lock contexts for basic block
--
>> drivers/tty/serial/8250/8250_men_mcb.c:61:24: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/char/hw_random/timeriomem-rng.c:74:32: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mfd/htc-pasic3.c:41:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mfd/htc-pasic3.c:42:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mfd/htc-pasic3.c:56:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mfd/htc-pasic3.c:57:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mfd/atmel-flexcom.c:77:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mfd/atmel-hlcdc.c:45:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mfd/atmel-hlcdc.c:45:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mfd/atmel-hlcdc.c:56:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mfd/atmel-hlcdc.c:66:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> include/linux/mtd/map.h:394:26: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/mtd/map.h:396:26: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/mtd/map.h:398:26: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/mtd/map.h:414:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/mtd/map.h:416:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/mtd/map.h:418:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mtd/maps/physmap-core.c:158:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/physmap-core.c:197:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:94:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:102:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:102:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:94:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:94:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/devices/docg3.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:94:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/devices/docg3.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/spi/spi-axi-spi-engine.c:518:19: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
--
>> drivers/spi/spi-oc-tiny.c:76:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:77:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:124:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:127:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:130:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:132:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:135:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:141:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:143:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:148:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:152:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:162:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:165:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:170:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:173:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:176:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:179:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:95:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-oc-tiny.c:102:18: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/mtd/nand/onenand/onenand_base.c:201:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/onenand/onenand_base.c:213:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/onenand/onenand_base.c:779:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:779:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_base.c:779:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_base.c:817:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:817:9: sparse:     expected void const *
   drivers/mtd/nand/onenand/onenand_base.c:817:9: sparse:     got void [noderef] __iomem *
   drivers/mtd/nand/onenand/onenand_base.c:860:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/nand/onenand/onenand_base.c:860:9: sparse:     expected void *
   drivers/mtd/nand/onenand/onenand_base.c:860:9: sparse:     got void [noderef] __iomem *
--
>> drivers/input/keyboard/opencores-kbd.c:31:13: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-rp5c01.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-rp5c01.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-ds1511.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1511.c:116:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-ds1685.c:47:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1685.c:60:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1685.c:78:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1685.c:79:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1685.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1685.c:92:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-ds1742.c:64:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:66:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:68:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:71:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:72:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:75:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:76:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:92:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:93:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:95:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:96:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:97:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:98:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:99:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:100:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:126:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:138:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:174:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:177:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:178:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:179:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:180:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ds1742.c:182:15: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-ftrtc010.c:71:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:72:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:73:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:74:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:75:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:92:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:93:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:95:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:99:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:100:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:165:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:166:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:167:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-ftrtc010.c:168:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-m48t59.c:49:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-m48t59.c:57:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-msm6242.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-msm6242.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-stk17ta8.c:78:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:81:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:82:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:84:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:85:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:86:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:107:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:108:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:109:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:110:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:111:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:112:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:113:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:115:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:116:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:138:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:150:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:153:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:155:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:198:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:200:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:241:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:253:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:284:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:287:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:288:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:289:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:290:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:292:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-stk17ta8.c:299:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-v3020.c:86:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-v3020.c:91:19: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/rtc/rtc-zynqmp.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:71:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:81:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:92:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:99:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:108:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:119:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:120:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:135:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:143:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:146:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:148:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:161:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:173:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:184:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:200:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/rtc/rtc-zynqmp.c:206:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/i3c/master/i3c-master-cdns.c:496:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/i3c/master/i3c-master-cdns.c:496:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:498:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:498:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:536:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:547:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:549:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:552:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:552:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:554:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:570:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:572:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:578:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:574:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:656:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:656:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:658:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:658:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:662:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:665:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:666:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:666:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:908:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:925:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:929:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:972:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:972:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:986:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:986:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1014:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1016:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1017:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1017:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1030:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1030:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1053:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1055:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1059:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1109:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1111:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1140:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1151:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1153:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1154:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1161:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1256:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1264:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1271:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1298:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1336:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1355:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1363:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1365:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1368:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1367:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1393:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1394:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1422:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1426:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1442:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1453:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1460:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1464:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1602:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1611:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1612:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1620:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1626:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1641:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1642:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/i3c-master-cdns.c:1643:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/i3c/master/dw-i3c-master.c:303:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/i3c/master/dw-i3c-master.c:303:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:309:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:309:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:393:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:396:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:401:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:402:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:430:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:434:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:434:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:460:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:467:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:504:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:504:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:539:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:541:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:542:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:546:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:556:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:577:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:583:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:585:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:586:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:586:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:616:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:618:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:620:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:622:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:624:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:625:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:626:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:632:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:642:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:643:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:646:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:646:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:786:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:907:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:919:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:948:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:961:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1056:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1070:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1085:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1087:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1088:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1095:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1158:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1161:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i3c/master/dw-i3c-master.c:1164:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/i2c/busses/i2c-designware-platdrv.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/w1/masters/sgi_w1.c:33:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/w1/masters/sgi_w1.c:49:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/w1/masters/sgi_w1.c:66:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/w1/masters/sgi_w1.c:68:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/hwmon/aspeed-pwm-tacho.c:351:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/aspeed-pwm-tacho.c:360:16: sparse: sparse: cast removes address space '__iomem' of expression
--
   drivers/usb/host/isp116x-hcd.c:114:59: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/usb/host/isp116x-hcd.c:114:59: sparse:     expected unsigned short [usertype] val
   drivers/usb/host/isp116x-hcd.c:114:59: sparse:     got restricted __le16 [usertype]
   drivers/usb/host/isp116x-hcd.c:152:34: sparse: sparse: cast to restricted __le16
   drivers/usb/host/isp116x-hcd.c:152:34: sparse: sparse: cast to restricted __le16
   drivers/usb/host/isp116x-hcd.c:152:34: sparse: sparse: cast to restricted __le16
   drivers/usb/host/isp116x-hcd.c:152:34: sparse: sparse: cast to restricted __le16
>> drivers/usb/host/isp116x.h:389:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:406:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:408:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:396:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:398:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:372:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/usb/host/isp116x.h:389:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/usb/host/isp116x.h:389:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/usb/host/isp116x.h:389:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/host/isp116x.h:380:15: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/usb/gadget/udc/net2272.h:493:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.h:494:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.h:497:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.h:514:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.h:515:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.h:518:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/usb/gadget/udc/net2272.c:406:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:415:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:511:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:521:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:1782:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/gadget/udc/net2272.c:1782:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/gadget/udc/net2272.c:1782:17: sparse:     got restricted __le16 *
   drivers/usb/gadget/udc/net2272.c:1783:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/gadget/udc/net2272.c:1783:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/gadget/udc/net2272.c:1783:17: sparse:     got restricted __le16 *
   drivers/usb/gadget/udc/net2272.c:1784:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/gadget/udc/net2272.c:1784:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/gadget/udc/net2272.c:1784:17: sparse:     got restricted __le16 *
   drivers/usb/gadget/udc/net2272.c:1814:68: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] wIndex @@     got restricted __le16 [addressable] [assigned] [usertype] wIndex @@
   drivers/usb/gadget/udc/net2272.c:1814:68: sparse:     expected unsigned short [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1814:68: sparse:     got restricted __le16 [addressable] [assigned] [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1815:46: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/net2272.c:1818:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/net2272.c:1818:48: sparse:     expected unsigned short [usertype] status
   drivers/usb/gadget/udc/net2272.c:1818:48: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/net2272.c:1820:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] status @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/net2272.c:1820:48: sparse:     expected unsigned short [usertype] status
   drivers/usb/gadget/udc/net2272.c:1820:48: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/net2272.c:1824:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:1831:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/net2272.c:1838:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:1844:40: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/net2272.c:1849:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/net2272.c:1866:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] wIndex @@     got restricted __le16 [addressable] [assigned] [usertype] wIndex @@
   drivers/usb/gadget/udc/net2272.c:1866:60: sparse:     expected unsigned short [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1866:60: sparse:     got restricted __le16 [addressable] [assigned] [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1884:72: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/net2272.c:1893:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] wIndex @@     got restricted __le16 [addressable] [assigned] [usertype] wIndex @@
   drivers/usb/gadget/udc/net2272.c:1893:60: sparse:     expected unsigned short [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1893:60: sparse:     got restricted __le16 [addressable] [assigned] [usertype] wIndex
   drivers/usb/gadget/udc/net2272.c:1902:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/net2272.c:1995:33: sparse: sparse: context imbalance in 'net2272_handle_stat1_irqs' - unexpected unlock
--
>> drivers/usb/gadget/udc/pxa27x_udc.c:2035:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2047:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:105:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:124:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:124:45: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:126:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:126:45: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:127:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:180:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:192:52: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:192:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:198:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:199:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:333:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:334:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:337:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:339:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:350:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:351:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:354:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:356:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:414:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:434:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:436:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:452:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:455:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:469:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:470:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:484:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:484:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:546:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:620:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:643:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:810:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:846:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:850:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:852:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:881:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:915:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:983:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1026:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1296:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1447:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1461:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1702:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1703:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1714:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1723:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1640:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1641:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1846:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1851:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1879:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1944:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:1945:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2093:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] wValue @@     got int config @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2093:20: sparse:     expected restricted __le16 [assigned] [usertype] wValue
   drivers/usb/gadget/udc/pxa27x_udc.c:2093:20: sparse:     got int config
   drivers/usb/gadget/udc/pxa27x_udc.c:2122:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] wValue @@     got int alt @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2122:20: sparse:     expected restricted __le16 [assigned] [usertype] wValue
   drivers/usb/gadget/udc/pxa27x_udc.c:2122:20: sparse:     got int alt
   drivers/usb/gadget/udc/pxa27x_udc.c:2123:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] wIndex @@     got int iface @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2123:20: sparse:     expected restricted __le16 [assigned] [usertype] wIndex
   drivers/usb/gadget/udc/pxa27x_udc.c:2123:20: sparse:     got int iface
   drivers/usb/gadget/udc/pxa27x_udc.c:2142:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2143:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2147:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2157:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2188:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2203:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2218:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2220:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2242:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2246:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2271:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2272:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2273:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:2306:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2306:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2306:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2307:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2307:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2307:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2308:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2308:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2308:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2309:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2309:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2309:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2310:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2310:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2310:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2311:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned int @@
   drivers/usb/gadget/udc/pxa27x_udc.c:2311:17: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/pxa27x_udc.c:2311:17: sparse:     got unsigned int
   drivers/usb/gadget/udc/pxa27x_udc.c:2474:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:680:39: sparse: sparse: context imbalance in 'req_done' - unexpected unlock
   drivers/usb/gadget/udc/pxa27x_udc.c:401:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:401:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/usb/gadget/udc/pxa27x_udc.c:401:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/crypto/inside-secure/safexcel.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:52:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:53:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:54:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:57:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:58:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:69:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:95:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:104:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:112:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:135:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:144:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:146:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:147:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:153:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:172:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:176:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:186:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:188:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:198:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:201:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:207:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:244:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:246:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:251:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:256:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:276:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:277:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:280:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:285:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:289:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:293:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:299:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:305:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:319:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:366:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:375:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:384:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:440:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:499:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:501:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:504:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:515:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:518:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:547:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:549:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:552:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:556:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:565:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:569:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:573:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:575:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:594:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:596:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:600:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:607:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:610:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:617:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:622:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:633:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:636:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:639:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:642:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:648:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:655:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:659:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:681:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:684:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:687:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:697:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:700:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:702:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:709:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:713:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:716:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:720:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:723:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:725:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:728:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:735:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:738:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:742:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:745:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:747:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:751:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:757:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:761:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:766:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:769:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:773:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:802:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:877:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:881:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:1092:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/crypto/inside-secure/safexcel.c:1098:24: sparse: sparse: too many warnings
--
>> drivers/mcb/mcb-parse.c:54:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:54:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg1 @@     got unsigned int __v @@
   drivers/mcb/mcb-parse.c:54:14: sparse:     expected restricted __le32 [usertype] reg1
   drivers/mcb/mcb-parse.c:54:14: sparse:     got unsigned int __v
   drivers/mcb/mcb-parse.c:55:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:55:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg2 @@     got unsigned int __v @@
   drivers/mcb/mcb-parse.c:55:14: sparse:     expected restricted __le32 [usertype] reg2
   drivers/mcb/mcb-parse.c:55:14: sparse:     got unsigned int __v
   drivers/mcb/mcb-parse.c:56:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:57:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:59:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:60:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:61:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:62:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:63:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:64:22: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:93:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:94:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:126:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:127:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:150:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:150:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] reg @@     got unsigned int __v @@
   drivers/mcb/mcb-parse.c:150:21: sparse:     expected restricted __le32 [usertype] reg
   drivers/mcb/mcb-parse.c:150:21: sparse:     got unsigned int __v
   drivers/mcb/mcb-parse.c:152:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/mcb/mcb-parse.c:198:25: sparse: sparse: cast to restricted __le16
   drivers/mcb/mcb-parse.c:198:25: sparse: sparse: cast to restricted __le16
   drivers/mcb/mcb-parse.c:198:25: sparse: sparse: cast to restricted __le16
   drivers/mcb/mcb-parse.c:198:25: sparse: sparse: cast to restricted __le16
   drivers/mcb/mcb-parse.c:25:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:25:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mcb/mcb-parse.c:25:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/iio/adc/men_z188_adc.c:59:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/men_z188_adc.c:88:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/men_z188_adc.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/men_z188_adc.c:93:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/men_z188_adc.c:96:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/iio/adc/vf610_adc.c:286:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:287:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:301:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:302:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:307:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:319:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:329:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:337:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:338:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:444:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:445:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:553:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:578:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:644:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:734:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:736:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:744:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:755:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:757:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:762:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/vf610_adc.c:783:20: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/iio/dac/vf610_dac.c:49:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:56:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:58:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:70:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:75:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:125:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/dac/vf610_dac.c:152:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/fpga/altera-pr-ip-core.c:39:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:90:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:99:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:116:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:123:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:126:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:129:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-pr-ip-core.c:188:15: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/fpga/altera-freeze-bridge.c:50:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:54:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:56:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:65:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:69:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:95:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:108:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:116:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:132:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:134:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:150:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:152:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:225:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:241:18: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/fpga/xilinx-pr-decoupler.c:67:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/xilinx-pr-decoupler.c:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/xilinx-pr-decoupler.c:29:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/fsi/fsi-master-aspeed.c:95:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:96:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:99:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:100:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:102:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:102:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:106:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:143:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:149:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:149:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:153:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:155:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:158:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:451:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:452:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:456:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:458:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:459:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:462:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:465:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:466:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fsi/fsi-master-aspeed.c:473:9: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +242 drivers/pinctrl/pinctrl-single.c

39c3fd58952d75 Andrew Lunn   2017-12-02  230  
8b8b091bf07fa7 Tony Lindgren 2012-07-10  231  /*
8b8b091bf07fa7 Tony Lindgren 2012-07-10  232   * REVISIT: Reads and writes could eventually use regmap or something
8b8b091bf07fa7 Tony Lindgren 2012-07-10  233   * generic. But at least on omaps, some mux registers are performance
8b8b091bf07fa7 Tony Lindgren 2012-07-10  234   * critical as they may need to be remuxed every time before and after
8b8b091bf07fa7 Tony Lindgren 2012-07-10  235   * idle. Adding tests for register access width for every read and
8b8b091bf07fa7 Tony Lindgren 2012-07-10  236   * write like regmap is doing is not desired, and caching the registers
8b8b091bf07fa7 Tony Lindgren 2012-07-10  237   * does not help in this case.
8b8b091bf07fa7 Tony Lindgren 2012-07-10  238   */
8b8b091bf07fa7 Tony Lindgren 2012-07-10  239  
8b8b091bf07fa7 Tony Lindgren 2012-07-10  240  static unsigned __maybe_unused pcs_readb(void __iomem *reg)
8b8b091bf07fa7 Tony Lindgren 2012-07-10  241  {
8b8b091bf07fa7 Tony Lindgren 2012-07-10 @242  	return readb(reg);
8b8b091bf07fa7 Tony Lindgren 2012-07-10  243  }
8b8b091bf07fa7 Tony Lindgren 2012-07-10  244  

:::::: The code at line 242 was first introduced by commit
:::::: 8b8b091bf07fa7ef7f13c1ac40b30bcf74050b60 pinctrl: Add one-register-per-pin type device tree based pinctrl driver

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--T4sUOijqQbZv57TR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
