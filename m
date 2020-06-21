Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81349C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5883B23899
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFUFqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:46:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:19738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgFUFqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:46:10 -0400
IronPort-SDR: ZZQbfp+WyUzePUAHO42Nu0BfHScLGAEL4CxXSDjhPSAY2HMrTzCxmUR+3KpTYMzGW3ektREiX0
 C08sjWal+4Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="130874925"
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="130874925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 22:46:02 -0700
IronPort-SDR: Vv5nd3jZRH5I9mnzAEWxGWD4kCylLX5U1joAMMfZjDlnSNKSQinF5s8cNR1ZrTBuK57O5JXQ/k
 h170drO995UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="422292546"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2020 22:46:00 -0700
Date:   Sun, 21 Jun 2020 13:45:42 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [kbuild-all] ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200621054542.GC8800@intel.com>
References: <202006210825.AhNPD7rQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006210825.AhNPD7rQ%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 08:58:31AM +0800, kernel test robot wrote:
> Hi Subbaraman,
Sorry, kindly ignore this false positve report. We will look into
it to resolve our logic issue.

> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
> commit: 62a1d3f623ac0338912fdfbdda9bdac4cadcbc75 backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs
> date:   7 weeks ago
> config: openrisc-randconfig-r036-20200619 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 62a1d3f623ac0338912fdfbdda9bdac4cadcbc75
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "__mulsi3" [drivers/ipack/devices/ipoctal.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/platform/goldfish/goldfish_pipe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-tlc591xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lp5562.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lp5521.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lp3952.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3697.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3692x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3533.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-an30259a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/thermal/thermal_mmio.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/platform/cadence/cdns-csi2tx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/mn88443x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/m88rs2000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/mxl5xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/stv0910.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/drxk.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/cxd2841er.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/mb86a20s.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/drx39xyj/drx39xyj.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/ts2020.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/m88ds3103.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/stv090x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/stb6000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/si2168.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/af9013.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/atbm8830.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/lgs8gxx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/tda665x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/dib0090.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/dib0070.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/tda8261.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/tda10086.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/lgdt3305.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/s5h1420.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/stv0297.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/tda10021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/zl10039.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/ves1x93.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/mt312.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/dib9000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/cx24110.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/dvb-frontends/stb6100.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/m88rs6000t.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/fc0012.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/e4000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/max2165.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/mt2131.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/tea5761.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/st-mipid02.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/imx274.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/imx214.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tc358743.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/s5k5baf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/s5k6aa.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/sr030pc30.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/mt9m032.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/ov7670.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tvp7002.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/ths7303.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/bt819.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/adv7842.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/adv7604.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/adv748x/adv748x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/saa6752hs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/et8ek8/et8ek8.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/msp3400.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/i3c/i3c.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/gameport/lightning.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/auxdisplay/panel.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/auxdisplay/charlcd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/slimbus/slim-qcom-ctrl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mfd/iqs62x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/echo/echo.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/isl29003.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/enclosure.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/apds990x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/bh1770glc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/ics932s401.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/vgem/vgem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/ti-sn65dsi86.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/cdns-dsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-samsung-s6e8aa0.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/i2c/tda998x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/i2c/ch7006.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/ppdev.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/lp.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/virtio_console.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/goldfish.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/fsl_lpuart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/xilinx_uartps.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/altera_jtaguart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/altera_uart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/8250/8250_men_mcb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/dma/idma64.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/fbdev/vfb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/fbdev/ocfb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/fbdev/goldfishfb.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/video/backlight/qcom-wled.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/backlight/adp8860_bl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpio/gpio-menz127.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/tcrypt.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/blowfish_common.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/cts.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fuse/virtiofs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fuse/cuse.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fuse/fuse.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/jffs2/jffs2.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/cifs/cifs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/nls/nls_euc-jp.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/nfs/nfsv4.ko] undefined!
> ERROR: modpost: "__mulsi3" [mm/zsmalloc.ko] undefined!
> ERROR: modpost: "__mulsi3" [mm/zbud.ko] undefined!
> ERROR: modpost: "__mulsi3" [kernel/torture.ko] undefined!
> ERROR: modpost: "__mulsi3" [kernel/rcu/rcuperf.ko] undefined!
> ERROR: modpost: "__mulsi3" [kernel/locking/test-ww_mutex.ko] undefined!
> ERROR: modpost: "__mulsi3" [kernel/locking/locktorture.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

