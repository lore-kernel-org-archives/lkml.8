Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CAC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB7524808
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgFUFmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:42:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:56488 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgFUFmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:42:31 -0400
IronPort-SDR: rWgPbvwZL0UCVChk/HpVMsTv86Q6BypEqtU2itTLJm32jCqrVQrD8gyHOBC/2gXoSSf4hfH52y
 0QwM8Tz+SKlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="228182900"
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="228182900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 22:42:27 -0700
IronPort-SDR: VOb1jowSTpQ2GJHLhvEm6JfOh0omChL37JVXgDqDd26JM/zaz9FgMcxKXyy9YUPPOxXpct2SSo
 RiATUh3x6j2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="478051249"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2020 22:42:25 -0700
Date:   Sun, 21 Jun 2020 13:42:07 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200621054207.GA8800@intel.com>
References: <202006211117.Z854IHoJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006211117.Z854IHoJ%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 11:35:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b6ddd10d678bebec32381f71b6b420bafc43ad0
> commit: 30428ef5d1e8caf78639cc70a802f1cb7b1cec04 lib/test_lockup: test module to generate lockups
> date:   2 months ago
> config: openrisc-randconfig-c024-20200619 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
sorry, kindly ignore this, which is more likely a false positive. We will
futher check and fix our logic issue.

> 
> ERROR: modpost: "__mulsi3" [lib/raid6/raid6_pq.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/reed_solomon/reed_solomon.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [lib/test_lockup.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/test_firmware.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/lz4/lz4hc_compress.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/math/prime_numbers.ko] undefined!
> ERROR: modpost: "__mulsi3" [lib/math/cordic.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/sunrpc/auth_gss/rpcsec_gss_krb5.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/ipack/devices/ipoctal.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/industrialio.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/temperature/mlx90632.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/proximity/srf04.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/proximity/ping.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/proximity/isl29501.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/pressure/t5403.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/pressure/ms5637.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/pressure/mpl115.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/pressure/icp10100.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/pressure/bmp280.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiostat/lmp91000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/tpl0102.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/mcp41010.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/mcp4018.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/max5481.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/ds1803.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/potentiometer/ad5272.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/magnetometer/st_magn.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/magnetometer/bmc150_magn.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/magnetometer/ak8975.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/veml6030.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/us5182d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/tsl2772.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/tsl2583.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/tcs3472.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/tcs3414.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/si1145.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/si1133.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/max44009.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/max44000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/lv0104cs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/ltr501.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/cm32181.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/apds9300.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis_lib.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis16480.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis16460.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis16400.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/humidity/dht11.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/frequency/adf4350.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/gyro/adxrs450.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/mcp4922.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/mcp4725.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/ltc1660.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/dpot-dac.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/ad5761.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/ad5592r-base.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/dac/ad5360.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/common/st_sensors/st_sensors.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/common/ms_sensors/ms_sensors_i2c.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/chemical/bme680_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/chemical/atlas-sensor.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/buffer/kfifo_buf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/amplifiers/hmc425a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/amplifiers/ad8366.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/afe/iio-rescale.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/xilinx-xadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/vf610_adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/twl4030-madc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-ads8688.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-ads1015.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-adc0832.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/stmpe-adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/max9611.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/max1363.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/max1118.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/lp8788_adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ina2xx-adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/hx711.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/da9150-gpadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad799x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7793.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7780.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7298.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7292.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7124.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad_sigma_delta.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/sca3000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/mma9553.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/mma9551_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/mma8452.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/bma400_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/adxl372.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/i2c-hid/i2c-hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/usbhid/usbhid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-wiimote.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-waltop.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/wacom.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-uclogic.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-steam.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-sony.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

