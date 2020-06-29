Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B443C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B11206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgF2XxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:53:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:44570 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbgF2XxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:53:11 -0400
IronPort-SDR: iCC9uP6i4kA8SViUDDMCoOLhvyFP1ASwOPSCDJHduwRfck7B2LhOMyUDQ1ZifOIwfkXsffQqDt
 JYrX4oe7zqhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144291019"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="144291019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:53:09 -0700
IronPort-SDR: iadZxWgqSRibFTXahHQrbeQvcJd3L1nYXfaawn7G8/is1kdVmHUbvu5XPZqdHD6v2Iq7WKmG4U
 GWdg1HrmEm5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="303241042"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 16:53:07 -0700
Date:   Tue, 30 Jun 2020 07:53:06 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Min Li <min.li.xe@renesas.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] ERROR: "__mulsi3" undefined!
Message-ID: <20200629235305.GA14744@intel.com>
References: <202006300646.GvouW3PU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006300646.GvouW3PU%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 06:09:49AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7c30b859a947535f2213277e827d7ac7dcff9c84
> commit: 57a10d8c1123068e3cb06434fbc9634f945d3062 ptp: Add a ptp clock driver for IDT 82P33 SMU.
> date:   4 months ago
> config: openrisc-randconfig-c003-20200629 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
Sorry for this noise, kindly ignore it, which is a false positive.

> 
>    ERROR: "__mulsi3" [drivers/iio/multiplexer/iio-mux.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/st_magn.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/bmc150_magn.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/si1133.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/tsl2563.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/max44009.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/max44000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/ltr501.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/cm3232.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/humidity/dht11.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/common/st_sensors/st_sensors.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/chemical/sps30.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/chemical/bme680_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/stmpe-adc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/qcom-vadc-common.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/palmas_gpadc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/ina2xx-adc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/hx711.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/accel/mma9553.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/accel/mma8452.ko] undefined!
>    ERROR: "__mulsi3" [drivers/extcon/extcon-palmas.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/greybus/gb-power-supply.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/greybus/gb-loopback.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/das800.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/das16m1.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/pcl730.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/pcl726.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hid/hid-waltop.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hid/hid-steam.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hid/hid-picolcd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hid/hid-logitech-hidpp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/crypto/inside-secure/crypto_safexcel.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lm3692x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-max77693.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-mc13783.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp8501.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp3952.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp3944.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mmc/host/usdhi6rol0.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mmc/host/mtk-sd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mmc/host/sdhci.ko] undefined!
>    ERROR: "__mulsi3" [drivers/watchdog/kempld_wdt.ko] undefined!
>    ERROR: "__mulsi3" [drivers/thermal/thermal-generic-adc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/max31785.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/max20730.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/lm25066.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/ibm-cffps.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/bel-pfe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/adm1275.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/pmbus_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83627ehf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/tmp102.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/smsc47m192.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/smsc47b397.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/sch5636.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/sch56xx-common.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pwm-fan.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pc87427.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ntc_thermistor.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/nct6775.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/nct6683.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/max6642.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/max6621.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ltc4261.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ltc4222.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ltc4215.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm93.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm92.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm83.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm78.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lineage-pem.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/it87.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ina3221.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ina2xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/iio_hwmon.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ibmaem.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/hih6130.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/gpio-fan.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/gl518sm.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/f71882fg.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/f71805f.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ds1621.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/dme1737.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/as370-hwmon.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ads7828.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm9240.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1177.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1025.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83791d.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83792d.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83627hf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/bd70528-charger.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/axp288_fuel_gauge.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/smb347-charger.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/ltc2941-battery-gauge.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/ds2781_battery.ko] undefined!
>    ERROR: "__mulsi3" [drivers/power/supply/axp20x_battery.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/ptp/ptp_idt82p33.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/radio/radio-wl1273.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/radio/radio-tea5764.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/radio/si470x/radio-si470x-common.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-core/dvb-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/v4l2-core/v4l2-dv-timings.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/v4l2-core/videodev.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ascot2e.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/horus3a.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mn88443x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tc90522.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/af9033.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/m88rs2000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/rtl2832.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10071.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si2165.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0910.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cxd2841er.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cxd2820r.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0367.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ix2505v.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mb86a20s.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mb86a16.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ds3000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mn88473.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/m88ds3103.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv090x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0900.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stb6000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si2168.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si21xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/atbm8830.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda665x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10048.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/au8522_dig.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/itd1000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/s5h1409.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib0090.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda8261.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10086.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cx24123.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/lg2160.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/lgdt3306a.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/lgdt330x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/s5h1420.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/bcm3510.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/or51132.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/nxt200x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0297.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10021.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/drxd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/zl10039.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/zl10036.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mt352.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ves1x93.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ves1820.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mt312.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib9000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib7000p.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib7000m.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib3000mc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/l64781.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stb0899.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0299.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dvb-pll.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/platform/vicodec/vicodec.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/platform/vim2m.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/platform/vimc/vimc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/common/videobuf2/videobuf2-v4l2.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/common/v4l2-tpg/v4l2-tpg.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/rc/rc-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18250.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/m88rs6000t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mxl301rf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/r820t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/fc0013.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/fc0012.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tua9001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/fc2580.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18212.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/max2165.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mc44s803.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mxl5007t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt2131.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/qt1010.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt2063.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt2060.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/xc4000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/xc5000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18271.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda827x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tea5761.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tea5767.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt20xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tuner-simple.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tuner-xc2028.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/st-mipid02.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/imx274.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/imx214.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tc358743.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/video-i2c.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

