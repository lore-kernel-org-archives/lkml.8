Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65191C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E31E20739
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 05:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgFUFpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:45:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:30503 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgFUFpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:45:31 -0400
IronPort-SDR: BnHchPwPs/leXbeousWc+sH6GyNLD+aV2BzpJH/g663A28M0E3Ng96bse3aX9tzbT1lWjvK9gX
 4PbipRh3gbOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="123761495"
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="123761495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 22:45:30 -0700
IronPort-SDR: xk8vDmhHZDBi2CeiHx+c6rr43gU38WVq5ZMgK2SUtGOCz5/UPcNeBAj9ivTSaZSBJaGoq7CYA0
 +1ZGLjNb6BwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="309817160"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2020 22:45:28 -0700
Date:   Sun, 21 Jun 2020 13:45:10 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan Bakker <xc-racer2@live.ca>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [kbuild-all] ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200621054510.GB8800@intel.com>
References: <202006210903.rP7H6ri6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006210903.rP7H6ri6%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 09:32:06AM +0800, kernel test robot wrote:
> Hi Jonathan,
Sorry Jonathan, kindly ignore this report, which is a false positive.
We will fix our side problem.

> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b6ddd10d678bebec32381f71b6b420bafc43ad0
> commit: 0383024f811aa469df258039807810fc3793a105 power: supply: max17040: Correct voltage reading
> date:   6 weeks ago
> config: openrisc-randconfig-r003-20200620 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 0383024f811aa469df258039807810fc3793a105
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "__mulsi3" [drivers/iio/light/si1133.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/tsl2563.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/max44009.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/max44000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/lv0104cs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/ltr501.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/isl29018.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/cm32181.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/bh1750.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/light/apds9300.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis_lib.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis16460.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/adis16400.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/humidity/hts221.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/frequency/adf4350.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/frequency/ad9523.ko] undefined!
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
> ERROR: modpost: "__mulsi3" [drivers/iio/common/hid-sensors/hid-sensor-trigger.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/common/hid-sensors/hid-sensor-iio-common.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/chemical/sps30.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/chemical/bme680_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/buffer/kfifo_buf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/amplifiers/hmc425a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/amplifiers/ad8366.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/afe/iio-rescale.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/xilinx-xadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/vf610_adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti_am335x_adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-ads8688.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-ads1015.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ti-adc084s021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/qcom-vadc-common.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/qcom-spmi-iadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/max1118.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ina2xx-adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/hx711.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/da9150-gpadc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad799x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7923.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7292.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad7192.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/adc/ad_sigma_delta.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/sca3000.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/mma9551.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/mma9551_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/bma400_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/iio/accel/adxl372.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/i2c-hid/i2c-hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-sensor-custom.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-sensor-hub.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-tmff.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-steam.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-picolcd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-prodikeys.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-magicmouse.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-logitech-hidpp.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-lg-g15.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/pps/pps_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/ipack/devices/ipoctal.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/devfreq/governor_simpleondemand.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-dac124s085.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-wm8350.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-tlc591xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-tca6507.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-pwm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-pca9532.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-max77650.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lp8501.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lp3952.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3697.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3692x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3533.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-is31fl32xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-is31fl319x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-gpio.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-da9052.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-an30259a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/core/mmc_test.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/core/mmc_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/mmc_spi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/mtk-sd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/sdhci.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/bd70528-charger.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/axp288_fuel_gauge.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/smb347-charger.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/rt9455_charger.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/power/supply/max17040_battery.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/da9150-charger.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/da9030_battery.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/lego_ev3_battery.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/ltc2941-battery-gauge.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/ds2780_battery.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/ds2760_battery.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/power/supply/wm8350_power.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/cec/cec.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/platform/cadence/cdns-csi2tx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/m88rs6000t.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/mxl301rf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/r820t.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/it913x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/fc0013.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/fc0012.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/mt2131.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/mt2060.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/tuners/msi001.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/st-mipid02.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/imx214.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/mt9m001.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tvp7002.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tvp514x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tda1997x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/tvaudio.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/media/i2c/m5mols/m5mols.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-wm8350.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-s5m.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-rv3028.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-rc5t619.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-pcf8523.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rtc/rtc-m41t93.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/mousedev.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/input-leds.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/misc/max8997_haptic.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/misc/ad714x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/colibri-vf50-ts.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/wacom_w8001.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/tsc2007.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/tsc200x-core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/pixcir_i2c_ts.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/goodix.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/cyttsp4_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/touchscreen/ad7879.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joystick/walkera0701.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joystick/sidewinder.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joystick/iforce/iforce.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joystick/gf2k.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joystick/analog.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/keyboard/mpr121_touchkey.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/keyboard/lm8323.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/gameport/lightning.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hsi/clients/hsi_char.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/spi/spi-sc18is602.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mfd/iqs62x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/echo/echo.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/altera-stapl/altera-stapl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/apds990x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/bh1770glc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/lis3lv02d/lis3lv02d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/etnaviv/etnaviv.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/vgem/vgem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/scheduler/gpu-sched.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/drm_mipi_dbi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/drm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/drm_kms_helper.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/tiny/st7586.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/tiny/repaper.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/ti-tfp410.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/ti-sn65dsi86.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/tc358768.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/sii902x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/cdns-dsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/synopsys/dw-hdmi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-samsung-s6e8aa0.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-ilitek-ili9322.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-arm-versatile.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/i2c/tda998x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/i2c/ch7006.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/rcar-du/rcar_lvds.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/tpm/tpm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/hw_random/rng-core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/fsl_lpuart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/altera_uart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/reset/reset-ti-syscon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/wm8994-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/wm8350-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/vctrl-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/tps65132-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/qcom_spmi-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/mt6323-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/mpq7920.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/max77693-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/max8997-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/max1586.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/ltc3589.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

