Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94526C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDF9207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRL2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:28:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:13135 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgHRL0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:26:10 -0400
IronPort-SDR: D2D/VXl1MeB16Ztn+/9KdMmFq+wlnv03IyBb+6iy/uhdv40MidiCcHqL03F5t9ronnKc6r7AzP
 /+XbaY5UbTWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154140579"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="154140579"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 04:26:01 -0700
IronPort-SDR: WjISPmqnZctBWKBQWFbZyOiZZ1i7KedBZj09QGEgcCTe5BNp8mfK8e163RcAn+cKMXOi9KWjXC
 hnEPubPicPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="292735537"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2020 04:25:59 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7zkc-00019U-Pc; Tue, 18 Aug 2020 11:25:58 +0000
Date:   Tue, 18 Aug 2020 19:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/irqchip/irq-ath79-misc.c:36:36: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202008181912.lXjzdlUT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: mips-randconfig-s032-20200818 (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/irqchip/irq-ath79-misc.c:36:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void *host_data @@
>> drivers/irqchip/irq-ath79-misc.c:36:36: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-ath79-misc.c:36:36: sparse:     got void *host_data
>> drivers/irqchip/irq-ath79-misc.c:62:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-ath79-misc.c:62:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-ath79-misc.c:62:56: sparse:     got void *
   drivers/irqchip/irq-ath79-misc.c:75:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-ath79-misc.c:75:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-ath79-misc.c:75:56: sparse:     got void *
   drivers/irqchip/irq-ath79-misc.c:88:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-ath79-misc.c:88:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-ath79-misc.c:88:56: sparse:     got void *
   drivers/irqchip/irq-ath79-misc.c:120:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void *host_data @@
   drivers/irqchip/irq-ath79-misc.c:120:36: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-ath79-misc.c:120:36: sparse:     got void *host_data
>> drivers/irqchip/irq-ath79-misc.c:151:55: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *[assigned] base @@
   drivers/irqchip/irq-ath79-misc.c:151:55: sparse:     expected void *host_data
>> drivers/irqchip/irq-ath79-misc.c:151:55: sparse:     got void [noderef] __iomem *[assigned] base
>> drivers/irqchip/irq-ath79-misc.c:192:60: sparse: sparse: incorrect type in argument 6 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *regs @@
   drivers/irqchip/irq-ath79-misc.c:192:60: sparse:     expected void *host_data
>> drivers/irqchip/irq-ath79-misc.c:192:60: sparse:     got void [noderef] __iomem *regs
   drivers/irqchip/irq-ath79-misc.c:181:13: sparse: sparse: symbol 'ath79_misc_irq_init' was not declared. Should it be static?
--
>> drivers/watchdog/ath79_wdt.c:161:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__gu_ptr @@     got char const * @@
>> drivers/watchdog/ath79_wdt.c:161:37: sparse:     expected char const [noderef] __user *__gu_ptr
   drivers/watchdog/ath79_wdt.c:161:37: sparse:     got char const *
   drivers/watchdog/ath79_wdt.c:235:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ath79_wdt.c:235:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ath79_wdt.c:235:27: sparse:     got int ( * )( ... )

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +36 drivers/irqchip/irq-ath79-misc.c

07ba4b061a79896 Alban Bedel  2016-01-23   31  
07ba4b061a79896 Alban Bedel  2016-01-23   32  static void ath79_misc_irq_handler(struct irq_desc *desc)
07ba4b061a79896 Alban Bedel  2016-01-23   33  {
07ba4b061a79896 Alban Bedel  2016-01-23   34  	struct irq_domain *domain = irq_desc_get_handler_data(desc);
07ba4b061a79896 Alban Bedel  2016-01-23   35  	struct irq_chip *chip = irq_desc_get_chip(desc);
07ba4b061a79896 Alban Bedel  2016-01-23  @36  	void __iomem *base = domain->host_data;
07ba4b061a79896 Alban Bedel  2016-01-23   37  	u32 pending;
07ba4b061a79896 Alban Bedel  2016-01-23   38  
07ba4b061a79896 Alban Bedel  2016-01-23   39  	chained_irq_enter(chip, desc);
07ba4b061a79896 Alban Bedel  2016-01-23   40  
07ba4b061a79896 Alban Bedel  2016-01-23   41  	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
07ba4b061a79896 Alban Bedel  2016-01-23   42  		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   43  
07ba4b061a79896 Alban Bedel  2016-01-23   44  	if (!pending) {
07ba4b061a79896 Alban Bedel  2016-01-23   45  		spurious_interrupt();
07ba4b061a79896 Alban Bedel  2016-01-23   46  		chained_irq_exit(chip, desc);
07ba4b061a79896 Alban Bedel  2016-01-23   47  		return;
07ba4b061a79896 Alban Bedel  2016-01-23   48  	}
07ba4b061a79896 Alban Bedel  2016-01-23   49  
07ba4b061a79896 Alban Bedel  2016-01-23   50  	while (pending) {
07ba4b061a79896 Alban Bedel  2016-01-23   51  		int bit = __ffs(pending);
07ba4b061a79896 Alban Bedel  2016-01-23   52  
07ba4b061a79896 Alban Bedel  2016-01-23   53  		generic_handle_irq(irq_linear_revmap(domain, bit));
07ba4b061a79896 Alban Bedel  2016-01-23   54  		pending &= ~BIT(bit);
07ba4b061a79896 Alban Bedel  2016-01-23   55  	}
07ba4b061a79896 Alban Bedel  2016-01-23   56  
07ba4b061a79896 Alban Bedel  2016-01-23   57  	chained_irq_exit(chip, desc);
07ba4b061a79896 Alban Bedel  2016-01-23   58  }
07ba4b061a79896 Alban Bedel  2016-01-23   59  
07ba4b061a79896 Alban Bedel  2016-01-23   60  static void ar71xx_misc_irq_unmask(struct irq_data *d)
07ba4b061a79896 Alban Bedel  2016-01-23   61  {
07ba4b061a79896 Alban Bedel  2016-01-23  @62  	void __iomem *base = irq_data_get_irq_chip_data(d);
07ba4b061a79896 Alban Bedel  2016-01-23   63  	unsigned int irq = d->hwirq;
07ba4b061a79896 Alban Bedel  2016-01-23   64  	u32 t;
07ba4b061a79896 Alban Bedel  2016-01-23   65  
07ba4b061a79896 Alban Bedel  2016-01-23   66  	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   67  	__raw_writel(t | BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   68  
07ba4b061a79896 Alban Bedel  2016-01-23   69  	/* flush write */
07ba4b061a79896 Alban Bedel  2016-01-23   70  	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   71  }
07ba4b061a79896 Alban Bedel  2016-01-23   72  
07ba4b061a79896 Alban Bedel  2016-01-23   73  static void ar71xx_misc_irq_mask(struct irq_data *d)
07ba4b061a79896 Alban Bedel  2016-01-23   74  {
07ba4b061a79896 Alban Bedel  2016-01-23   75  	void __iomem *base = irq_data_get_irq_chip_data(d);
07ba4b061a79896 Alban Bedel  2016-01-23   76  	unsigned int irq = d->hwirq;
07ba4b061a79896 Alban Bedel  2016-01-23   77  	u32 t;
07ba4b061a79896 Alban Bedel  2016-01-23   78  
07ba4b061a79896 Alban Bedel  2016-01-23   79  	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   80  	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   81  
07ba4b061a79896 Alban Bedel  2016-01-23   82  	/* flush write */
07ba4b061a79896 Alban Bedel  2016-01-23   83  	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23   84  }
07ba4b061a79896 Alban Bedel  2016-01-23   85  
07ba4b061a79896 Alban Bedel  2016-01-23   86  static void ar724x_misc_irq_ack(struct irq_data *d)
07ba4b061a79896 Alban Bedel  2016-01-23   87  {
07ba4b061a79896 Alban Bedel  2016-01-23   88  	void __iomem *base = irq_data_get_irq_chip_data(d);
07ba4b061a79896 Alban Bedel  2016-01-23   89  	unsigned int irq = d->hwirq;
07ba4b061a79896 Alban Bedel  2016-01-23   90  	u32 t;
07ba4b061a79896 Alban Bedel  2016-01-23   91  
07ba4b061a79896 Alban Bedel  2016-01-23   92  	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
07ba4b061a79896 Alban Bedel  2016-01-23   93  	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
07ba4b061a79896 Alban Bedel  2016-01-23   94  
07ba4b061a79896 Alban Bedel  2016-01-23   95  	/* flush write */
07ba4b061a79896 Alban Bedel  2016-01-23   96  	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
07ba4b061a79896 Alban Bedel  2016-01-23   97  }
07ba4b061a79896 Alban Bedel  2016-01-23   98  
07ba4b061a79896 Alban Bedel  2016-01-23   99  static struct irq_chip ath79_misc_irq_chip = {
07ba4b061a79896 Alban Bedel  2016-01-23  100  	.name		= "MISC",
07ba4b061a79896 Alban Bedel  2016-01-23  101  	.irq_unmask	= ar71xx_misc_irq_unmask,
07ba4b061a79896 Alban Bedel  2016-01-23  102  	.irq_mask	= ar71xx_misc_irq_mask,
07ba4b061a79896 Alban Bedel  2016-01-23  103  };
07ba4b061a79896 Alban Bedel  2016-01-23  104  
07ba4b061a79896 Alban Bedel  2016-01-23  105  static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
07ba4b061a79896 Alban Bedel  2016-01-23  106  {
07ba4b061a79896 Alban Bedel  2016-01-23  107  	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
07ba4b061a79896 Alban Bedel  2016-01-23  108  	irq_set_chip_data(irq, d->host_data);
07ba4b061a79896 Alban Bedel  2016-01-23  109  	return 0;
07ba4b061a79896 Alban Bedel  2016-01-23  110  }
07ba4b061a79896 Alban Bedel  2016-01-23  111  
07ba4b061a79896 Alban Bedel  2016-01-23  112  static const struct irq_domain_ops misc_irq_domain_ops = {
07ba4b061a79896 Alban Bedel  2016-01-23  113  	.xlate = irq_domain_xlate_onecell,
07ba4b061a79896 Alban Bedel  2016-01-23  114  	.map = misc_map,
07ba4b061a79896 Alban Bedel  2016-01-23  115  };
07ba4b061a79896 Alban Bedel  2016-01-23  116  
07ba4b061a79896 Alban Bedel  2016-01-23  117  static void __init ath79_misc_intc_domain_init(
07ba4b061a79896 Alban Bedel  2016-01-23  118  	struct irq_domain *domain, int irq)
07ba4b061a79896 Alban Bedel  2016-01-23  119  {
07ba4b061a79896 Alban Bedel  2016-01-23  120  	void __iomem *base = domain->host_data;
07ba4b061a79896 Alban Bedel  2016-01-23  121  
a1e8783db8e0d58 Petr Štetiar 2019-04-12  122  	ath79_perfcount_irq = irq_create_mapping(domain, ATH79_MISC_PERF_IRQ);
a1e8783db8e0d58 Petr Štetiar 2019-04-12  123  
07ba4b061a79896 Alban Bedel  2016-01-23  124  	/* Disable and clear all interrupts */
07ba4b061a79896 Alban Bedel  2016-01-23  125  	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
07ba4b061a79896 Alban Bedel  2016-01-23  126  	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
07ba4b061a79896 Alban Bedel  2016-01-23  127  
07ba4b061a79896 Alban Bedel  2016-01-23  128  	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
07ba4b061a79896 Alban Bedel  2016-01-23  129  }
07ba4b061a79896 Alban Bedel  2016-01-23  130  
07ba4b061a79896 Alban Bedel  2016-01-23  131  static int __init ath79_misc_intc_of_init(
07ba4b061a79896 Alban Bedel  2016-01-23  132  	struct device_node *node, struct device_node *parent)
07ba4b061a79896 Alban Bedel  2016-01-23  133  {
07ba4b061a79896 Alban Bedel  2016-01-23  134  	struct irq_domain *domain;
07ba4b061a79896 Alban Bedel  2016-01-23  135  	void __iomem *base;
07ba4b061a79896 Alban Bedel  2016-01-23  136  	int irq;
07ba4b061a79896 Alban Bedel  2016-01-23  137  
07ba4b061a79896 Alban Bedel  2016-01-23  138  	irq = irq_of_parse_and_map(node, 0);
07ba4b061a79896 Alban Bedel  2016-01-23  139  	if (!irq) {
07ba4b061a79896 Alban Bedel  2016-01-23  140  		pr_err("Failed to get MISC IRQ\n");
07ba4b061a79896 Alban Bedel  2016-01-23  141  		return -EINVAL;
07ba4b061a79896 Alban Bedel  2016-01-23  142  	}
07ba4b061a79896 Alban Bedel  2016-01-23  143  
07ba4b061a79896 Alban Bedel  2016-01-23  144  	base = of_iomap(node, 0);
07ba4b061a79896 Alban Bedel  2016-01-23  145  	if (!base) {
07ba4b061a79896 Alban Bedel  2016-01-23  146  		pr_err("Failed to get MISC IRQ registers\n");
07ba4b061a79896 Alban Bedel  2016-01-23  147  		return -ENOMEM;
07ba4b061a79896 Alban Bedel  2016-01-23  148  	}
07ba4b061a79896 Alban Bedel  2016-01-23  149  
07ba4b061a79896 Alban Bedel  2016-01-23  150  	domain = irq_domain_add_linear(node, ATH79_MISC_IRQ_COUNT,
07ba4b061a79896 Alban Bedel  2016-01-23 @151  				&misc_irq_domain_ops, base);
07ba4b061a79896 Alban Bedel  2016-01-23  152  	if (!domain) {
07ba4b061a79896 Alban Bedel  2016-01-23  153  		pr_err("Failed to add MISC irqdomain\n");
07ba4b061a79896 Alban Bedel  2016-01-23  154  		return -EINVAL;
07ba4b061a79896 Alban Bedel  2016-01-23  155  	}
07ba4b061a79896 Alban Bedel  2016-01-23  156  
07ba4b061a79896 Alban Bedel  2016-01-23  157  	ath79_misc_intc_domain_init(domain, irq);
07ba4b061a79896 Alban Bedel  2016-01-23  158  	return 0;
07ba4b061a79896 Alban Bedel  2016-01-23  159  }
07ba4b061a79896 Alban Bedel  2016-01-23  160  
07ba4b061a79896 Alban Bedel  2016-01-23  161  static int __init ar7100_misc_intc_of_init(
07ba4b061a79896 Alban Bedel  2016-01-23  162  	struct device_node *node, struct device_node *parent)
07ba4b061a79896 Alban Bedel  2016-01-23  163  {
07ba4b061a79896 Alban Bedel  2016-01-23  164  	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
07ba4b061a79896 Alban Bedel  2016-01-23  165  	return ath79_misc_intc_of_init(node, parent);
07ba4b061a79896 Alban Bedel  2016-01-23  166  }
07ba4b061a79896 Alban Bedel  2016-01-23  167  
07ba4b061a79896 Alban Bedel  2016-01-23  168  IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
07ba4b061a79896 Alban Bedel  2016-01-23  169  		ar7100_misc_intc_of_init);
07ba4b061a79896 Alban Bedel  2016-01-23  170  
07ba4b061a79896 Alban Bedel  2016-01-23  171  static int __init ar7240_misc_intc_of_init(
07ba4b061a79896 Alban Bedel  2016-01-23  172  	struct device_node *node, struct device_node *parent)
07ba4b061a79896 Alban Bedel  2016-01-23  173  {
07ba4b061a79896 Alban Bedel  2016-01-23  174  	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
07ba4b061a79896 Alban Bedel  2016-01-23  175  	return ath79_misc_intc_of_init(node, parent);
07ba4b061a79896 Alban Bedel  2016-01-23  176  }
07ba4b061a79896 Alban Bedel  2016-01-23  177  
07ba4b061a79896 Alban Bedel  2016-01-23  178  IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
07ba4b061a79896 Alban Bedel  2016-01-23  179  		ar7240_misc_intc_of_init);
07ba4b061a79896 Alban Bedel  2016-01-23  180  
07ba4b061a79896 Alban Bedel  2016-01-23  181  void __init ath79_misc_irq_init(void __iomem *regs, int irq,
07ba4b061a79896 Alban Bedel  2016-01-23  182  				int irq_base, bool is_ar71xx)
07ba4b061a79896 Alban Bedel  2016-01-23  183  {
07ba4b061a79896 Alban Bedel  2016-01-23  184  	struct irq_domain *domain;
07ba4b061a79896 Alban Bedel  2016-01-23  185  
07ba4b061a79896 Alban Bedel  2016-01-23  186  	if (is_ar71xx)
07ba4b061a79896 Alban Bedel  2016-01-23  187  		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
07ba4b061a79896 Alban Bedel  2016-01-23  188  	else
07ba4b061a79896 Alban Bedel  2016-01-23  189  		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
07ba4b061a79896 Alban Bedel  2016-01-23  190  
07ba4b061a79896 Alban Bedel  2016-01-23  191  	domain = irq_domain_add_legacy(NULL, ATH79_MISC_IRQ_COUNT,
07ba4b061a79896 Alban Bedel  2016-01-23 @192  			irq_base, 0, &misc_irq_domain_ops, regs);

:::::: The code at line 36 was first introduced by commit
:::::: 07ba4b061a79896315a7be4b123de12df6a9d2bd irqchip/ath79-misc: Move the MISC driver from arch/mips/ath79/

:::::: TO: Alban Bedel <albeu@free.fr>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--r5Pyd7+fXNt84Ff3--
