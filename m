Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED21C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF30206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgF2Xyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:54:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:65094 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgF2Xyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:54:31 -0400
IronPort-SDR: /pZJRiuXne/hztxYF+JvgZTuTUrZlK6NeQvTmaaOWCG7QjAPHXpqqE/iQEB8Or8rBCmld0AbEK
 mXXHP5p6MxVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="134403332"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="134403332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:54:26 -0700
IronPort-SDR: 4RiDsnd8r0BTnypNvOG3JoVPDA1xL/9/XSpvdvcdXJL9Iuah+YS2O3FkNLoR3Ckw4OnIecrm2f
 f4DYWSpMLOrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480967055"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 16:54:24 -0700
Date:   Tue, 30 Jun 2020 07:54:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [kbuild-all] ERROR: "__mulsi3" undefined!
Message-ID: <20200629235422.GB14744@intel.com>
References: <202006292035.u1fyeb7A%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006292035.u1fyeb7A%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:04:37PM +0800, kernel test robot wrote:
> Hi Sebastian,
Sorry for the noise, kindly ignore this report, which is a false positive.

> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
> commit: 9b8303fc6efa724bd6a90656434fbde2cc6ceb2c nvmem: core: fix nvmem_cell_write inline function
> date:   8 months ago
> config: nios2-randconfig-r033-20200629 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9b8303fc6efa724bd6a90656434fbde2cc6ceb2c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "__mulsi3" [lib/zstd/zstd_decompress.ko] undefined!
>    ERROR: "__mulsi3" [lib/zstd/zstd_compress.ko] undefined!
>    ERROR: "__mulsi3" [lib/reed_solomon/reed_solomon.ko] undefined!
>    ERROR: "__mulsi3" [lib/842/842_compress.ko] undefined!
>    ERROR: "__mulsi3" [lib/xxhash.ko] undefined!
>    ERROR: "__mulsi3" [lib/lz4/lz4hc_compress.ko] undefined!
>    ERROR: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
>    ERROR: "__mulsi3" [lib/lz4/lz4_compress.ko] undefined!
>    ERROR: "__mulsi3" [lib/lzo/lzo_compress.ko] undefined!
>    ERROR: "__mulsi3" [lib/math/cordic.ko] undefined!
>    ERROR: "__mulsi3" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
>    ERROR: "__mulsi3" [drivers/fpga/dfl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/soundwire/soundwire-bus.ko] undefined!
>    ERROR: "__mulsi3" [drivers/bcma/bcma.ko] undefined!
>    ERROR: "__mulsi3" [drivers/pcmcia/pcmcia.ko] undefined!
>    ERROR: "__mulsi3" [drivers/target/loopback/tcm_loop.ko] undefined!
>    ERROR: "__mulsi3" [drivers/target/target_core_file.ko] undefined!
>    ERROR: "__mulsi3" [drivers/target/target_core_iblock.ko] undefined!
>    ERROR: "__mulsi3" [drivers/target/target_core_mod.ko] undefined!
>    ERROR: "__mulsi3" [drivers/ata/libahci.ko] undefined!
>    ERROR: "__mulsi3" [drivers/ata/libata.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mux/mux-mmio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mux/mux-gpio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwtracing/intel_th/intel_th_gth.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwtracing/intel_th/intel_th.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/temperature/mlx90614.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/proximity/srf08.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/proximity/isl29501.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/pressure/t5403.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/pressure/bmp280.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/potentiometer/tpl0102.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/hmc5843_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/st_magn.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/mmc35240.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/mag3110.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/bmc150_magn.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/magnetometer/ak8975.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/tsl2772.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/tcs3472.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/si1145.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/opt3001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/max44009.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/max44000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/ltr501.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/cm3232.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/light/apds9300.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/health/afe4404.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/dac/ad5064.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/twl4030-madc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/qcom-spmi-iadc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/max9611.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/max1363.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/hx711.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/adc/ad799x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/accel/mma9551.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/accel/mma9551_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/iio/accel/mma8452.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/most/dim2/most_dim2.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/ni_labpc_common.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/ni_routing.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/ni_tio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/quatech_daqp_cs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/ni_mio_cs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/ni_atmio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/dmm32at.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/dt282x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/dt2811.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/das1800.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/das16.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/das16m1.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/pcl812.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/pcl730.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/staging/comedi/drivers/pcl724.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/drivers/comedi_8254.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/kcomedilib/kcomedilib.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/comedi/comedi.ko] undefined!
>    ERROR: "__mulsi3" [drivers/staging/iio/impedance-analyzer/ad5933.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/staging/iio/addac/adt7316.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lm3697.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-is31fl32xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-is31fl319x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-max77693.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-pwm.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-pca963x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-tca6507.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp8501.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp5521.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp3952.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lp3944.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-pca9532.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-lm3533.ko] undefined!
>    ERROR: "__mulsi3" [drivers/leds/leds-aat1290.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mmc/host/usdhi6rol0.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mmc/host/mtk-sd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/zl6100.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/max34440.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/max31785.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/lm25066.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/ibm-cffps.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/adm1275.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pmbus/pmbus_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83l786ng.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83627ehf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/tmp421.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/tmp401.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/tmp103.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/tc74.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/sch5636.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pwm-fan.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/pc87360.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ntc_thermistor.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/nct6683.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/mcp3021.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/max6639.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/max6621.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/max1668.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ltc4261.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ltc2990.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm95245.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm95241.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm95234.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm90.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lm73.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/lineage-pem.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/it87.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ina2xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ina209.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/iio_hwmon.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/gl520sm.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/emc6w201.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/emc2103.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ds1621.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ds620.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/atxp1.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/asc7621.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adt7470.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adt7x10.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ads7828.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1031.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1029.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1026.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adm1025.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/adc128d818.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ad7418.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/ad7414.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83781d.ko] undefined!
>    ERROR: "__mulsi3" [drivers/hwmon/w83793.ko] undefined!
>    ERROR: "__mulsi3" [drivers/w1/slaves/w1_ds28e17.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/cec/cec.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-core/dvb-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/v4l2-core/v4l2-dv-timings.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/v4l2-core/videodev.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/mc/mc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/helene.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ascot2e.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mn88443x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tc90522.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/af9033.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/m88rs2000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10071.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si2165.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mxl5xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv6111.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda18271c2dd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/drxk.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cxd2841er.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0367.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ix2505v.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/drx39xyj/drx39xyj.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mb86a16.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ts2020.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ds3000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/m88ds3103.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv6110x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv090x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0900.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv6110.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stb6000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si2168.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/si21xx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cx24120.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cx24117.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/af9013.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/atbm8830.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda665x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cx24113.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10048.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/itd1000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/s5h1409.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib0090.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda8261.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda826x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/cx24123.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/lg2160.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/lgdt3306a.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/s5h1420.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/bcm3510.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/or51211.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/nxt200x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stv0297.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/tda10023.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/zl10039.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/zl10036.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mt352.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/ves1x93.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/mt312.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib9000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib8000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib7000p.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dib3000mc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stb6100.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/stb0899.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/dvb-frontends/dvb-pll.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/platform/xilinx/xilinx-video.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/platform/video-mux.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/platform/m2m-deinterlace.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/common/videobuf2/videobuf2-v4l2.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/common/siano/smsdvb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/common/siano/smsmdtv.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18250.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/m88rs6000t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mxl301rf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/r820t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/fc0012.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tua9001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/fc2580.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18212.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mc44s803.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mxl5007t.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mxl5005s.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt2131.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/qt1010.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/mt2063.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/xc4000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/xc5000.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda18271.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tda827x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tea5761.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/tuners/tuner-xc2028.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/st-mipid02.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/imx355.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/imx274.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/imx214.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/lm3560.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/s5k5baf.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/s5k6aa.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/rj54n1cb0c.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/mt9v111.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9v011.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/mt9t001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9m032.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9m001.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov13858.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov9650.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov8856.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov7740.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov772x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov7670.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov7251.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov5675.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov5645.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/ov2680.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/sony-btf-mpx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/wm8739.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tvp514x.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/media/i2c/tvp5150.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/bt819.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv7842.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv7604.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv748x/adv748x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/saa6752hs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/saa717x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tvaudio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/aptina-pll.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/m5mols/m5mols.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/cx25840/cx25840.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/msp3400.ko] undefined!
>    ERROR: "__mulsi3" [drivers/i2c/i2c-stub.ko] undefined!
>    ERROR: "__mulsi3" [drivers/i2c/busses/i2c-xiic.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/misc/max8997_haptic.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/input/joystick/turbografx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/tmdc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/interact.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/grip_mp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/gamecon.ko] undefined!
>    ERROR: "__mulsi3" [drivers/auxdisplay/panel.ko] undefined!
>    ERROR: "__mulsi3" [drivers/auxdisplay/charlcd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/cdrom/cdrom.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/rfd_ftl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/inftl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_torturetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_subpagetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_stresstest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_speedtest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_pagetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_oobtest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/nand/raw/nandsim.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/nand/raw/diskonchip.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/lpddr/lpddr_cmds.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/lpddr/qinfo_probe.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/mtd/chips/jedec_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/gen_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_util.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvmet-fc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvme-loop.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvmet.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/ses.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/ch.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/virtio_scsi.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/libsas/libsas.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mfd/si476x-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/misc/echo/echo.ko] undefined!
>    ERROR: "__mulsi3" [drivers/block/virtio_blk.ko] undefined!
>    ERROR: "__mulsi3" [drivers/block/pktcdvd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/xillybus/xillybus_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/tpm/tpm.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/pcmcia/synclink_cs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/ppdev.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/hw_random/rng-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/lp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/tty/serial/altera_uart.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/wm8994-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/twl6030-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/twl-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/s5m8767.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/pv88090-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/pv88080-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/qcom_spmi-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/mcp16502.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max77693-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max8907-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max8660.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max1586.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp8788-ldo.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp8788-buck.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp873x-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp872x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/88pg86x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/soc/xilinx/xlnx_vcu.ko] undefined!
>    ERROR: "__mulsi3" [drivers/dma/idma64.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/fbdev/ocfb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/fbdev/metronomefb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/pwm_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/lp8788_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/lm3630a_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/gpio/gpio-dwapb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/pinctrl/pinctrl-single.ko] undefined!
>    ERROR: "__mulsi3" [block/kyber-iosched.ko] undefined!
>    ERROR: "__mulsi3" [crypto/tcrypt.ko] undefined!
>    ERROR: "__mulsi3" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>    ERROR: "__mulsi3" [fs/gfs2/gfs2.ko] undefined!
>    ERROR: "__mulsi3" [fs/befs/befs.ko] undefined!
>    ERROR: "__mulsi3" [fs/nilfs2/nilfs2.ko] undefined!
>    ERROR: "__mulsi3" [fs/orangefs/orangefs.ko] undefined!
>    ERROR: "__mulsi3" [fs/overlayfs/overlay.ko] undefined!
>    ERROR: "__mulsi3" [fs/fuse/fuse.ko] undefined!
>    ERROR: "__mulsi3" [fs/cifs/cifs.ko] undefined!
>    ERROR: "__mulsi3" [fs/sysv/sysv.ko] undefined!
>    ERROR: "__mulsi3" [fs/fat/vfat.ko] undefined!
>    ERROR: "__mulsi3" [fs/fat/fat.ko] undefined!
>    ERROR: "__mulsi3" [fs/nls/nls_euc-jp.ko] undefined!
>    ERROR: "__mulsi3" [fs/nfs/nfsv4.ko] undefined!
>    ERROR: "__mulsi3" [fs/quota/quota_tree.ko] undefined!
>    ERROR: "__mulsi3" [mm/zsmalloc.ko] undefined!
>    ERROR: "__mulsi3" [mm/zpool.ko] undefined!
>    ERROR: "__mulsi3" [kernel/rcu/rcutorture.ko] undefined!
>    ERROR: "__mulsi3" [kernel/locking/locktorture.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

