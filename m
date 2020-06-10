Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE3AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E141B206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uuvoVbJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgFJXxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgFJXxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:53:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D79C03E96B;
        Wed, 10 Jun 2020 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=j8YiZa/HJIdwzCS6Jp2qiCmRSoT0pw8mddCayIKBdcY=; b=uuvoVbJZStV6UP5WAvOqY1rtY5
        jxxFy8LLHV2PXa97KWOdLEWTS7RDrA+DGfhQi5+YwXe1jSB7RrWVSepChvTR0BkamDiBo7lCw/WVV
        TYKAUpbyEC50DL/kg9VdQZY/4sviSQ0KHX3A900mOEKecCzUQxmFWFc/dcU4gOv2nVSRGEzEVC9Mm
        8vwN41FgdZVzmqFSq8zxUYWteH/jl4Z8QRrrJt3WfbQXO8oWdp1v2J50GQUdkX7I4qzPySyyJoC2Z
        XU55WX9BdhRQIXB3EvzvavQdkbmqDiLNKt5CFS75DG9iAba0EpK0OkC1ltmbnnGZfZBOBRWB+BQDL
        3C2AfRiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjAXK-0000Us-36; Wed, 10 Jun 2020 23:53:38 +0000
Subject: Re: [PATCH] Documentation: Fix most typos
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <81ae0a0a-7df8-516f-7543-f1d944b9b4e2@infradead.org>
Date:   Wed, 10 Jun 2020 16:53:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 4:07 PM, Joe Perches wrote:
> These are the typos found in scripts/spelling.txt for
> most of the Documentation/ tree.
> 
> Scripted with:
> 
> $ cat scripts/spelling.txt | \
>   grep -v -P "^\s*\#" | \
>   while read line ; do \
>     from=$(echo $line | cut -f1 -d'|'); \
>     to=$(echo $line | cut -f3 -d'|'); \
>     echo "from: $from to: $to" ; \
>     git grep -w --name-only $from | \
>     xargs sed -i "s/\b$from\b/$to/" ; \
>     git checkout scripts/spelling.txt ; \
>   done
> 
> And some removal of inappropriate conversions
> in Documentation/translations and a few files
> where the conversions were incorrect.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Joe.

> ---
>  Documentation/ABI/testing/debugfs-driver-genwqe        |  2 +-
>  Documentation/ABI/testing/procfs-diskstats             |  2 +-
>  .../ABI/testing/sysfs-bus-event_source-devices-events  |  4 ++--
>  Documentation/ABI/testing/sysfs-bus-umc                |  2 +-
>  Documentation/ABI/testing/sysfs-devices-system-cpu     |  2 +-
>  Documentation/ABI/testing/sysfs-driver-tegra-fuse      |  2 +-
>  Documentation/ABI/testing/sysfs-fs-xfs                 |  2 +-
>  Documentation/RCU/RTFP.txt                             |  8 ++++----
>  Documentation/RCU/UP.rst                               |  4 ++--
>  Documentation/admin-guide/bcache.rst                   |  2 +-
>  Documentation/admin-guide/device-mapper/dm-crypt.rst   |  4 ++--
>  .../admin-guide/device-mapper/dm-integrity.rst         |  2 +-
>  Documentation/admin-guide/device-mapper/dm-raid.rst    |  2 +-
>  Documentation/admin-guide/device-mapper/verity.rst     |  2 +-
>  Documentation/admin-guide/device-mapper/writecache.rst |  4 ++--
>  Documentation/admin-guide/mm/index.rst                 |  2 +-
>  Documentation/admin-guide/sysctl/vm.rst                |  4 ++--
>  Documentation/admin-guide/tainted-kernels.rst          |  2 +-
>  Documentation/arm/interrupts.rst                       |  2 +-
>  Documentation/arm/sunxi/clocks.rst                     |  2 +-
>  Documentation/arm64/booting.rst                        |  2 +-
>  Documentation/arm64/elf_hwcaps.rst                     |  2 +-
>  .../bindings/arm/marvell/cp110-system-controller.txt   |  6 +++---
>  .../devicetree/bindings/clock/sprd,sc9863a-clk.yaml    |  2 +-
>  Documentation/devicetree/bindings/clock/ti/mux.txt     |  2 +-
>  Documentation/devicetree/bindings/display/msm/dpu.txt  |  2 +-
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml |  2 +-
>  Documentation/devicetree/bindings/fpga/fpga-region.txt |  2 +-
>  .../devicetree/bindings/iio/adc/maxim,max1238.yaml     |  2 +-
>  .../devicetree/bindings/iio/adc/maxim,max1363.yaml     |  2 +-
>  .../bindings/interrupt-controller/arm,gic-v3.yaml      |  2 +-
>  .../interrupt-controller/socionext,synquacer-exiu.txt  |  2 +-
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt     |  2 +-
>  Documentation/devicetree/bindings/misc/ge-achc.txt     |  2 +-
>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt    |  2 +-
>  .../devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt   |  2 +-
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  2 +-
>  .../bindings/pinctrl/qcom,sm8150-pinctrl.txt           |  6 +++---
>  .../bindings/pinctrl/renesas,rza1-pinctrl.txt          |  2 +-
>  .../devicetree/bindings/reset/ti-syscon-reset.txt      |  2 +-
>  Documentation/devicetree/bindings/sound/cs35l35.txt    |  4 ++--
>  .../devicetree/bindings/sound/mt2701-afe-pcm.txt       |  2 +-
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt         |  2 +-
>  Documentation/devicetree/bindings/sound/sprd-pcm.txt   |  2 +-
>  .../devicetree/bindings/sound/tlv320adcx140.yaml       |  2 +-
>  .../devicetree/bindings/timer/lsi,zevio-timer.txt      |  2 +-
>  Documentation/driver-api/gpio/driver.rst               |  2 +-
>  Documentation/driver-api/md/md-cluster.rst             |  2 +-
>  Documentation/driver-api/md/raid5-cache.rst            |  2 +-
>  Documentation/driver-api/nvdimm/nvdimm.rst             |  6 +++---
>  Documentation/driver-api/thermal/intel_powerclamp.rst  |  4 ++--
>  Documentation/driver-api/usb/usb3-debug-port.rst       |  2 +-
>  Documentation/fb/udlfb.rst                             |  2 +-
>  Documentation/filesystems/ext4/super.rst               |  2 +-
>  Documentation/filesystems/fsinfo.rst                   |  2 +-
>  Documentation/filesystems/orangefs.rst                 |  2 +-
>  Documentation/filesystems/proc.rst                     |  2 +-
>  Documentation/filesystems/spufs/spu_create.rst         |  2 +-
>  Documentation/filesystems/spufs/spu_run.rst            |  2 +-
>  Documentation/filesystems/ubifs-authentication.rst     |  2 +-
>  Documentation/firmware-guide/acpi/acpi-lid.rst         |  4 ++--
>  Documentation/firmware-guide/acpi/gpio-properties.rst  |  2 +-
>  Documentation/gpu/todo.rst                             |  2 +-
>  Documentation/hid/hid-transport.rst                    |  8 ++++----
>  Documentation/hwmon/abituguru-datasheet.rst            |  2 +-
>  Documentation/input/devices/elantech.rst               |  2 +-
>  Documentation/isdn/credits.rst                         |  2 +-
>  Documentation/kernel-hacking/hacking.rst               |  2 +-
>  Documentation/locking/lockdep-design.rst               |  2 +-
>  Documentation/networking/ip-sysctl.rst                 |  2 +-
>  Documentation/networking/snmp_counter.rst              |  4 ++--
>  Documentation/openrisc/openrisc_port.rst               |  2 +-
>  Documentation/powerpc/vas-api.rst                      |  2 +-
>  Documentation/process/clang-format.rst                 |  2 +-
>  Documentation/process/embargoed-hardware-issues.rst    |  6 +++---
>  Documentation/process/submitting-patches.rst           |  4 ++--
>  Documentation/security/keys/core.rst                   |  2 +-
>  Documentation/sound/designs/seq-oss.rst                |  2 +-
>  Documentation/sparc/oradax/dax-hv-api.txt              | 18 +++++++++---------
>  Documentation/spi/spidev.rst                           |  2 +-
>  Documentation/trace/hwlat_detector.rst                 |  2 +-
>  Documentation/usb/usbip_protocol.rst                   |  2 +-
>  Documentation/userspace-api/media/v4l/hist-v4l2.rst    |  2 +-
>  Documentation/virt/kvm/api.rst                         |  2 +-
>  Documentation/virt/kvm/halt-polling.rst                |  2 +-
>  Documentation/virt/kvm/running-nested-guests.rst       |  2 +-
>  86 files changed, 118 insertions(+), 118 deletions(-)


-- 
~Randy

