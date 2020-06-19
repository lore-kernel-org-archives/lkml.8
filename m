Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB89C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FF0217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392776AbgFSPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:24:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:48526 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392951AbgFSPWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:22:08 -0400
IronPort-SDR: L1JnTSKHJAfOJiFFHNfMEKZCmg4uIYnwWqTL9iGtxwrWYhR6OuhnDEAiOMcv//az91tTcvIDsR
 3j1mutv/mTpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="141256142"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="141256142"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 08:22:06 -0700
IronPort-SDR: UOAZzNfm73LvBhLJCeTtqjAZjbZhJUo8dWyEzUvTqoVAgK3qSL44Gp2EuAvE+s7B1gTw+re4Ca
 V0EVtOj6eVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="477662607"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2020 08:22:04 -0700
Date:   Fri, 19 Jun 2020 23:21:43 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [kbuild-all] ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200619152143.GA4170@intel.com>
References: <202006191955.JOKsWlS2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006191955.JOKsWlS2%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:44:00PM +0800, kernel test robot wrote:
> Hi Jessica,
Sorry Jessica, there's code bug that leads to multiple false positive
to you. Kindly ignore these noises.

> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
> commit: 93c95e526a4ef00eb3d5a1e0920ba5a22f32e40d modpost: rework and consolidate logging interface
> date:   3 months ago
> config: openrisc-randconfig-c022-20200619 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__mulsi3" [lib/zstd/zstd_decompress.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/zstd/zstd_compress.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/bch.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/reed_solomon/reed_solomon.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/xxhash.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/lz4/lz4hc_compress.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/lzo/lzo_compress.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/math/cordic.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/mux/mux-mmio.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/mux/mux-adg792a.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/i2c-hid/i2c-hid.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-wiimote.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-steam.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-picolcd.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-multitouch.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-magicmouse.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-logitech-hidpp.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-lg-g15.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid-alps.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/hid/hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/zl6100.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/max31785.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/lm25066.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/ibm-cffps.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/adm1275.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pmbus/pmbus_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83l785ts.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83627ehf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp401.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp103.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp102.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/thmc50.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/amc6821.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/stts751.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/smsc47b397.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/smm665.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/shtc1.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sht21.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pwm-fan.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pc87427.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pc87360.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ntc_thermistor.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/mcp3021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/mc13783-adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6697.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6650.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6642.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max197.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max1619.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4261.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4260.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4245.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4215.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4151.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm95245.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm95241.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm93.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm92.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm90.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm87.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm83.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm80.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm63.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lineage-pem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ina209.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ibmpex.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/hih6130.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gl520sm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gl518sm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/g760a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f75375s.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f71805f.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc6w201.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc2103.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc1403.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds1621.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds620.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/aspeed-pwm-tacho.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7475.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7470.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7411.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7x10.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm9240.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1031.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1026.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83791d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83793.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83792d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83773g.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83627hf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/hwmon-vid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/uio/uio_dmem_genirq.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/sm_ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ssfdc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/rfd_ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtdblock.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtd_blkdevs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_nandecctest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_torturetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_subpagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_stresstest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_speedtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_pagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_oobtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/nandcore.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/raw/diskonchip.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/raw/nand.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/block2mtd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/slram.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/docg3.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/maps/physmap.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/gen_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

