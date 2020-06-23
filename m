Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5129206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgFWOjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:39:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:50959 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732740AbgFWOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:39:53 -0400
IronPort-SDR: plHtbAd1A93kreKD5uGb32HAKGeRZ2ZTdinB/mFpHk86wK0MoO/50ZZe6A0iroXafMEeKYyTxa
 evQXgGKqrO+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="143157653"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="143157653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 07:39:52 -0700
IronPort-SDR: ZMaLp7genJ7qD+dzD2/GZaidcOr1u7sZDs3b+/KDkwzr4mX4wz7IKd6feFidp/0z3c37glf3ea
 0IDiIKaYCWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="263350053"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga007.fm.intel.com with SMTP; 23 Jun 2020 07:39:49 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Jun 2020 17:39:47 +0300
Date:   Tue, 23 Jun 2020 17:39:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] thunderbolt: Add support for authenticate on
 disconnect
Message-ID: <20200623143947.GE2795@lahna.fi.intel.com>
References: <20200622185758.28145-1-mario.limonciello@dell.com>
 <20200622185758.28145-3-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622185758.28145-3-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:57:58PM -0500, Mario Limonciello wrote:
> Some external devices can support completing thunderbolt authentication
> when they are unplugged. For this to work though, the link controller must
> remain operational.
> 
> The only device known to support this right now is the Dell WD19TB, so add
> a quirk for this.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         | 13 ++++++
>  drivers/thunderbolt/Makefile                  |  2 +-
>  drivers/thunderbolt/eeprom.c                  |  1 +
>  drivers/thunderbolt/lc.c                      | 14 +++++++
>  drivers/thunderbolt/quirks.c                  | 36 +++++++++++++++++
>  drivers/thunderbolt/switch.c                  | 40 +++++++++++++++++--
>  drivers/thunderbolt/tb.h                      |  7 ++++
>  drivers/thunderbolt/tb_regs.h                 |  1 +
>  8 files changed, 109 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/thunderbolt/quirks.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index 7d0500b4d58a..dd565c378b40 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -276,3 +276,16 @@ Date:		Oct 2020
>  KernelVersion:	v5.9
>  Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  Description:	Retimer vendor identifier read from the hardware.
> +
> +What:		/sys/bus/thunderbolt/devices/.../nvm_authenticate_on_disconnect
> +Date:		Oct 2020
> +KernelVersion:	v5.9
> +Contact:	Mario Limonciello <mario.limonciello@dell.com>
> +Description:	For supported devices, automatically authenticate the new Thunderbolt
> +		image when the device is disconnected from the host system.
> +
> +		This file will accept writing values "1" or "2"
> +		- Writing "1" will flush the image to the storage
> +		area and prepare the device for authentication on disconnect.
> +		- Writing "2" will run some basic validation on the image
> +		and flush it to the storage area.
> diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
> index cf7e1b42f4ad..4ab5bfad7bfd 100644
> --- a/drivers/thunderbolt/Makefile
> +++ b/drivers/thunderbolt/Makefile
> @@ -2,6 +2,6 @@
>  obj-${CONFIG_USB4} := thunderbolt.o
>  thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
>  thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o tmu.o usb4.o
> -thunderbolt-objs += nvm.o retimer.o
> +thunderbolt-objs += nvm.o retimer.o quirks.o
>  
>  obj-${CONFIG_USB4_KUNIT_TEST} += test.o
> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
> index b451a5aa90b5..3ebca44ab3fa 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -599,6 +599,7 @@ int tb_drom_read(struct tb_switch *sw)
>  		sw->uid = header->uid;
>  	sw->vendor = header->vendor_id;
>  	sw->device = header->model_id;
> +	tb_check_quirks(sw);
>  
>  	crc = tb_crc32(sw->drom + TB_DROM_DATA_START, header->data_len);
>  	if (crc != header->data_crc32) {
> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> index bd44d50246d2..828b4655d6a1 100644
> --- a/drivers/thunderbolt/lc.c
> +++ b/drivers/thunderbolt/lc.c
> @@ -366,3 +366,17 @@ int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in)
>  	tb_port_dbg(in, "sink %d de-allocated\n", sink);
>  	return 0;
>  }
> +
> +/**
> + * tb_lc_force_power() - Forces LC to be powered on
> + * @sw: thunderbolt switch

@sw: Thunderbolt switch

with capital T.

> + *
> + * This is useful to let authentication cycle pass even without
> + * a Thunderbolt link present.
> + */
> +int tb_lc_force_power(struct tb_switch *sw)
> +{
> +	u32 in = 0xffff;
> +
> +	return tb_sw_write(sw, &in, TB_CFG_SWITCH, TB_LC_POWER, 1);
> +}
> diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
> new file mode 100644
> index 000000000000..e8eace99bfcb
> --- /dev/null
> +++ b/drivers/thunderbolt/quirks.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thunderbolt driver - quirks
> + *
> + * Copyright (c) 2020 Mario Limonciello <mario.limonciello@dell.com>
> + */
> +
> +#include "tb.h"
> +
> +static void quirk_force_power_link(struct tb_switch *sw)
> +{
> +	sw->quirks |= QUIRK_FORCE_POWER_LINK_CONTROLLER;
> +}
> +
> +struct tb_quirk {
> +	u16 vendor;
> +	u16 device;
> +	void (*hook)(struct tb_switch *sw);
> +};
> +
> +static struct tb_quirk tb_quirks[] = {

Hmm, I think you missed "const" here.

> +	/* Dell WD19TB supports self-authentication on unplug */
> +	{ 0x00d4, 0xb070, quirk_force_power_link },
> +};
> +

Ah, also for non-static functions I think it is good to have small
kernel-doc comment. Even though this one is quite straightforward to
figure out.

> +void tb_check_quirks(struct tb_switch *sw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
> +		const struct tb_quirk *q = &tb_quirks[i];
> +
> +		if (sw->device == q->device && sw->vendor == q->vendor)
> +			q->hook(sw);
> +	}
> +}
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index bbfbfebeee7f..712395f518b8 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1493,8 +1493,8 @@ static ssize_t nvm_authenticate_show(struct device *dev,
>  	return sprintf(buf, "%#x\n", status);
>  }
>  
> -static ssize_t nvm_authenticate_store(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t nvm_authenticate_sysfs(struct device *dev, const char *buf,
> +				      bool disconnect)
>  {
>  	struct tb_switch *sw = tb_to_switch(dev);
>  	int val;
> @@ -1532,8 +1532,12 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  				goto exit_unlock;
>  		}
>  		if (val == WRITE_AND_AUTHENTICATE) {
> -			sw->nvm->authenticating = true;
> -			ret = nvm_authenticate(sw);
> +			if (disconnect) {
> +				ret = tb_lc_force_power(sw);
> +			} else {
> +				sw->nvm->authenticating = true;
> +				ret = nvm_authenticate(sw);
> +			}
>  		}
>  	}
>  
> @@ -1543,12 +1547,35 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  	pm_runtime_mark_last_busy(&sw->dev);
>  	pm_runtime_put_autosuspend(&sw->dev);
>  
> +	return ret;
> +}
> +
> +static ssize_t nvm_authenticate_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret = nvm_authenticate_sysfs(dev, buf, false);
>  	if (ret)
>  		return ret;
>  	return count;
>  }
>  static DEVICE_ATTR_RW(nvm_authenticate);
>  
> +static ssize_t nvm_authenticate_on_disconnect_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	return nvm_authenticate_show(dev, attr, buf);
> +}
> +
> +static ssize_t nvm_authenticate_on_disconnect_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	ret = nvm_authenticate_sysfs(dev, buf, true);
> +	return ret ? ret : count;
> +}
> +static DEVICE_ATTR_RW(nvm_authenticate_on_disconnect);
> +
>  static ssize_t nvm_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -1606,6 +1633,7 @@ static struct attribute *switch_attrs[] = {
>  	&dev_attr_generation.attr,
>  	&dev_attr_key.attr,
>  	&dev_attr_nvm_authenticate.attr,
> +	&dev_attr_nvm_authenticate_on_disconnect.attr,
>  	&dev_attr_nvm_version.attr,
>  	&dev_attr_rx_speed.attr,
>  	&dev_attr_rx_lanes.attr,
> @@ -1660,6 +1688,10 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
>  		if (tb_route(sw))
>  			return attr->mode;
>  		return 0;
> +	} else if (attr == &dev_attr_nvm_authenticate_on_disconnect.attr) {
> +		if (sw->quirks & QUIRK_FORCE_POWER_LINK_CONTROLLER)
> +			return attr->mode;
> +		return 0;
>  	}
>  
>  	return sw->safe_mode ? 0 : attr->mode;
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 43a8ca2eb3d8..07e1cfc3a096 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -133,6 +133,7 @@ struct tb_switch_tmu {
>   * @depth: Depth in the chain this switch is connected (ICM only)
>   * @rpm_complete: Completion used to wait for runtime resume to
>   *		  complete (ICM only)
> + * @quirks: Quirks used for this Thunderbolt switch
>   *
>   * When the switch is being added or removed to the domain (other
>   * switches) you need to have domain lock held.
> @@ -171,6 +172,7 @@ struct tb_switch {
>  	u8 link;
>  	u8 depth;
>  	struct completion rpm_complete;
> +	unsigned long quirks;
>  };
>  
>  /**
> @@ -849,6 +851,7 @@ bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
>  bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
>  int tb_lc_dp_sink_alloc(struct tb_switch *sw, struct tb_port *in);
>  int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in);
> +int tb_lc_force_power(struct tb_switch *sw);
>  
>  static inline int tb_route_length(u64 route)
>  {
> @@ -941,4 +944,8 @@ int usb4_usb3_port_allocate_bandwidth(struct tb_port *port, int *upstream_bw,
>  				      int *downstream_bw);
>  int usb4_usb3_port_release_bandwidth(struct tb_port *port, int *upstream_bw,
>  				     int *downstream_bw);
> +
> +/* keep link controller awake during update */
> +#define QUIRK_FORCE_POWER_LINK_CONTROLLER       (1<<1)

I think bit 0 is fine as well? So

#define QUIRK_FORCE_POWER_LINK_CONTROLLER	BIT(0)

Then empty line

> +void tb_check_quirks(struct tb_switch *sw);

Empty line here as well.

>  #endif
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 2ac6af8e0c13..fd4fc144d17f 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -409,6 +409,7 @@ struct tb_regs_hop {
>  #define TB_LC_SNK_ALLOCATION_SNK1_SHIFT	4
>  #define TB_LC_SNK_ALLOCATION_SNK1_MASK	GENMASK(7, 4)
>  #define TB_LC_SNK_ALLOCATION_SNK1_CM	0x1
> +#define TB_LC_POWER			0x740
>  
>  /* Link controller registers */
>  #define TB_LC_PORT_ATTR			0x8d
> -- 
> 2.25.1
