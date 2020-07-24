Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA03C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEE520825
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXBTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:19:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:30984 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgGXBTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:19:22 -0400
IronPort-SDR: PFjec2rJ5vJAH3ap2NyinRZ4Kpn69oE/1TPCBbXQmdKpgNf+QZwJvw+kUyfKdN+pY6Uv3ObdmC
 rWQ79VxXbhew==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212178962"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="gz'50?scan'50,208,50";a="212178962"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 18:19:08 -0700
IronPort-SDR: 4Rqbd8AbwAXjOwtqTHK8K5mavy1TxHUEVzhVmbmWc/9s7K7ebc9eMFWVOU00eHmxgaKWCLd34e
 bVuMR6Un5aVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="gz'50?scan'50,208,50";a="488569845"
Received: from lkp-server01.sh.intel.com (HELO bd1a4a62506a) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:19:06 -0700
Received: from kbuild by bd1a4a62506a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jymMc-0000fT-2v; Fri, 24 Jul 2020 01:19:06 +0000
Date:   Fri, 24 Jul 2020 09:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/dnfb.c:159:16: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007240947.RyOeXTRn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: m68k-randconfig-s032-20200723 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/dnfb.c:159:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/dnfb.c:243:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char [usertype] * @@
>> drivers/video/fbdev/dnfb.c:243:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/dnfb.c:243:27: sparse:     got unsigned char [usertype] *
   drivers/video/fbdev/dnfb.c:283:12: sparse: sparse: symbol 'dnfb_init' was not declared. Should it be static?
--
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char *buf @@
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected void const volatile [noderef] __user *
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got char *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *buf @@
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const volatile [noderef] __user *
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got char const *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf

vim +/__iomem +159 drivers/video/fbdev/dnfb.c

^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  151  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  152  	int incr, y_delta, pre_read = 0, x_end, x_word_count;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  153  	uint start_mask, end_mask, dest;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  154  	ushort *src, dummy;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  155  	short i, j;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  156  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  157  	incr = (area->dy <= area->sy) ? 1 : -1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  158  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16 @159  	src = (ushort *)(info->screen_base + area->sy * info->fix.line_length +
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  160  			(area->sx >> 4));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  161  	dest = area->dy * (info->fix.line_length >> 1) + (area->dx >> 4);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  162  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  163  	if (incr > 0) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  164  		y_delta = (info->fix.line_length * 8) - area->sx - area->width;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  165  		x_end = area->dx + area->width - 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  166  		x_word_count = (x_end >> 4) - (area->dx >> 4) + 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  167  		start_mask = 0xffff0000 >> (area->dx & 0xf);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  168  		end_mask = 0x7ffff >> (x_end & 0xf);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  169  		out_8(AP_CONTROL_0,
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  170  		     (((area->dx & 0xf) - (area->sx & 0xf)) % 16) | (0x4 << 5));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  171  		if ((area->dx & 0xf) < (area->sx & 0xf))
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  172  			pre_read = 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  173  	} else {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  174  		y_delta = -((info->fix.line_length * 8) - area->sx - area->width);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  175  		x_end = area->dx - area->width + 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  176  		x_word_count = (area->dx >> 4) - (x_end >> 4) + 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  177  		start_mask = 0x7ffff >> (area->dx & 0xf);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  178  		end_mask = 0xffff0000 >> (x_end & 0xf);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  179  		out_8(AP_CONTROL_0,
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  180  		     ((-((area->sx & 0xf) - (area->dx & 0xf))) % 16) |
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  181  		     (0x4 << 5));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  182  		if ((area->dx & 0xf) > (area->sx & 0xf))
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  183  			pre_read = 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  184  	}
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  185  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  186  	for (i = 0; i < area->height; i++) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  187  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  188  		out_8(AP_CONTROL_3A, 0xc | (dest >> 16));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  189  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  190  		if (pre_read) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  191  			dummy = *src;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  192  			src += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  193  		}
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  194  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  195  		if (x_word_count) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  196  			out_8(AP_WRITE_ENABLE, start_mask);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  197  			*src = dest;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  198  			src += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  199  			dest += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  200  			out_8(AP_WRITE_ENABLE, 0);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  201  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  202  			for (j = 1; j < (x_word_count - 1); j++) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  203  				*src = dest;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  204  				src += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  205  				dest += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  206  			}
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  207  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  208  			out_8(AP_WRITE_ENABLE, start_mask);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  209  			*src = dest;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  210  			dest += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  211  			src += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  212  		} else {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  213  			out_8(AP_WRITE_ENABLE, start_mask | end_mask);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  214  			*src = dest;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  215  			dest += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  216  			src += incr;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  217  		}
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  218  		src += (y_delta / 16);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  219  		dest += (y_delta / 16);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  220  	}
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  221  	out_8(AP_CONTROL_0, NORMAL_MODE);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  222  }
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  223  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  224  /*
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  225   * Initialization
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  226   */
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  227  
48c68c4f1b54244 drivers/video/dnfb.c       Greg Kroah-Hartman 2012-12-21  228  static int dnfb_probe(struct platform_device *dev)
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  229  {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  230  	struct fb_info *info;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  231  	int err = 0;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  232  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  233  	info = framebuffer_alloc(0, &dev->dev);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  234  	if (!info)
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  235  		return -ENOMEM;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  236  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  237  	info->fbops = &dn_fb_ops;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  238  	info->fix = dnfb_fix;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  239  	info->var = dnfb_var;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  240  	info->var.red.length = 1;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  241  	info->var.red.offset = 0;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  242  	info->var.green = info->var.blue = info->var.red;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16 @243  	info->screen_base = (u_char *) info->fix.smem_start;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  244  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  245  	err = fb_alloc_cmap(&info->cmap, 2, 0);
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  246  	if (err < 0)
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  247  		goto release_framebuffer;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  248  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  249  	err = register_framebuffer(info);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  250  	if (err < 0) {
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  251  		fb_dealloc_cmap(&info->cmap);
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  252  		goto release_framebuffer;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  253  	}
3ae5eaec1d2d9c0 drivers/video/dnfb.c       Russell King       2005-11-09  254  	platform_set_drvdata(dev, info);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  255  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  256  	/* now we have registered we can safely setup the hardware */
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  257  	out_8(AP_CONTROL_3A, RESET_CREG);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  258  	out_be16(AP_WRITE_ENABLE, 0x0);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  259  	out_8(AP_CONTROL_0, NORMAL_MODE);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  260  	out_8(AP_CONTROL_1, (AD_BLT | DST_EQ_SRC | NORM_CREG1));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  261  	out_8(AP_CONTROL_2, S_DATA_PLN);
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  262  	out_be16(AP_ROP_1, SWAP(0x3));
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  263  
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  264  	printk("apollo frame buffer alive and kicking !\n");
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  265  	return err;
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  266  
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  267  release_framebuffer:
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  268  	framebuffer_release(info);
6b04e9f2564a609 drivers/video/fbdev/dnfb.c Markus Elfring     2017-11-09  269  	return err;
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  270  }
^1da177e4c3f415 drivers/video/dnfb.c       Linus Torvalds     2005-04-16  271  

:::::: The code at line 159 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--uAKRQypu60I7Lcqm--
