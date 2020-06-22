Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9902C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9063D20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgFVQwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:52:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:49479 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgFVQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:52:36 -0400
IronPort-SDR: HGZfqZIR3wo5wRsJDpNM82N/Yf9Zqs2YH8786ptZc3ZMBA8wLONMiJbaW53kTZXk0yMONUFZ0r
 msihtipWLfNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142064938"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142064938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:52:20 -0700
IronPort-SDR: VVtfvjvc0bG/Con6KYQT+RM9Pk+onc6NpInsuBMYLvBWySUWIKMJGXrAVhBS1g0K9npUQcWhhF
 BaCHHRcQVvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="310986419"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002.fm.intel.com with SMTP; 22 Jun 2020 09:52:17 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Jun 2020 19:52:17 +0300
Date:   Mon, 22 Jun 2020 19:52:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Add support for authenticate on
 disconnect
Message-ID: <20200622165217.GX2795@lahna.fi.intel.com>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
 <20200622143035.25327-3-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622143035.25327-3-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 09:30:35AM -0500, Mario Limonciello wrote:
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
>  drivers/thunderbolt/Makefile                  |  1 +
>  drivers/thunderbolt/eeprom.c                  |  2 +
>  drivers/thunderbolt/lc.c                      | 14 +++++++
>  drivers/thunderbolt/quirks.c                  | 38 +++++++++++++++++
>  drivers/thunderbolt/switch.c                  | 42 +++++++++++++++++--
>  drivers/thunderbolt/tb-quirks.h               | 16 +++++++
>  drivers/thunderbolt/tb.h                      |  3 ++
>  drivers/thunderbolt/tb_regs.h                 |  1 +
>  9 files changed, 126 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/thunderbolt/quirks.c
>  create mode 100644 drivers/thunderbolt/tb-quirks.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index 26b15cbc9881..30798f9a8f59 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -243,3 +243,16 @@ KernelVersion:	4.15
>  Contact:	thunderbolt-software@lists.01.org
>  Description:	This contains XDomain service specific settings as
>  		bitmask. Format: %x
> +
> +What:		/sys/bus/thunderbolt/devices/.../nvm_authenticate_on_disconnect
> +Date:		August 2020
> +KernelVersion:	5.9
> +Contact:	thunderbolt-software@lists.01.org

I think you can use your email address here instead.

> +Description:	For supported devices, automatically authenticate the new Thunderbolt
> +		image when the device is disconnected from the host system.
> +
> +		This file will accept writing values "1" or "2"
> +		- Writing "1" will flush the image to the storage
> +		area and prepare the device for authentication on disconnect.
> +		- Writing "2" will only flush the image to the storage
> +		area.

Also here it does the basic image validation so probably good to
mention.

> diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
> index eae28dd45250..013c5564565a 100644
> --- a/drivers/thunderbolt/Makefile
> +++ b/drivers/thunderbolt/Makefile
> @@ -2,3 +2,4 @@
>  obj-${CONFIG_USB4} := thunderbolt.o
>  thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
>  thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o tmu.o usb4.o
> +thunderbolt-objs += quirks.o
> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
> index b451a5aa90b5..32838c016c4f 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -10,6 +10,7 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include "tb.h"
> +#include "tb-quirks.h"
>  
>  /**
>   * tb_eeprom_ctl_write() - write control word
> @@ -599,6 +600,7 @@ int tb_drom_read(struct tb_switch *sw)
>  		sw->uid = header->uid;
>  	sw->vendor = header->vendor_id;
>  	sw->device = header->model_id;
> +	check_tbt_quirks(sw);
>  
>  	crc = tb_crc32(sw->drom + TB_DROM_DATA_START, header->data_len);
>  	if (crc != header->data_crc32) {
> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> index bd44d50246d2..45d2a1de2069 100644
> --- a/drivers/thunderbolt/lc.c
> +++ b/drivers/thunderbolt/lc.c
> @@ -366,3 +366,17 @@ int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in)
>  	tb_port_dbg(in, "sink %d de-allocated\n", sink);
>  	return 0;
>  }
> +
> +/**
> + * lc_force_power() - Force powers a ridge

Maybe "Forces LC to be powered on" or similar?

> + * @sw: thunderbolt switch
> + *
> + * This is useful to let authentication cycle pass even without
> + * a Thunderbolt link present

Add "." at the end of the sentence.

> + */
> +int lc_force_power(struct tb_switch *sw)

Also tb_lc_force_power() or so to follow the conventions used in the
driver.

> +{
> +	u32 in = 0xFFFF;

I prefer 0xffff instead.

> +
> +	return tb_sw_write(sw, &in, TB_CFG_SWITCH, TB_LC_POWER, 1);
> +}
> diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
> new file mode 100644
> index 000000000000..b9c5cfb97645
> --- /dev/null
> +++ b/drivers/thunderbolt/quirks.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thunderbolt driver - quirks
> + *
> + * Copyright (c) 2020 Mario Limonciello <mario.limonciello@dell.com>
> + */
> +
> +#include "tb.h"
> +#include "tb-quirks.h"
> +
> +static void quirk_force_power_link(struct tb_switch *sw)
> +{
> +	sw->quirks |= QUIRK_FORCE_POWER_LINK_CONTROLLER;
> +}
> +
> +struct tbt_quirk {

tb_quirk please.

> +	u16 vendor;
> +	u16 device;
> +	void (*hook)(struct tb_switch *sw);
> +};
> +
> +static struct tbt_quirk tbt_quirks[] = {

const?

> +	/* Dell WD19TB supports self-authentication on unplug */
> +	{ 0x00d4, 0xb070, quirk_force_power_link },
> +};
> +
> +void check_tbt_quirks(struct tb_switch *sw)

Let's call it

tb_check_quirks() or tb_detect_quirks() following USB.

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tbt_quirks); i++) {
> +		struct tbt_quirk *q = &tbt_quirks[i];
> +
> +		if (sw->device == q->device &&
> +		    sw->vendor == q->vendor)

I think you can write it like this:

		if (sw->device == q->device && sw->vendor == q->vendor)

> +			q->hook(sw);
> +	}
> +}
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 4c476a58db38..0576fe7c0054 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -16,6 +16,7 @@
>  #include <linux/vmalloc.h>
>  
>  #include "tb.h"
> +#include "tb-quirks.h"
>  
>  /* Switch NVM support */
>  
> @@ -1542,8 +1543,8 @@ static ssize_t nvm_authenticate_show(struct device *dev,
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
> @@ -1581,8 +1582,12 @@ static ssize_t nvm_authenticate_store(struct device *dev,
>  				goto exit_unlock;
>  		}
>  		if (val == WRITE_AND_AUTHENTICATE) {
> -			sw->nvm->authenticating = true;
> -			ret = nvm_authenticate(sw);
> +			if (disconnect) {
> +				ret = lc_force_power(sw);
> +			} else {
> +				sw->nvm->authenticating = true;
> +				ret = nvm_authenticate(sw);
> +			}
>  		}
>  	}
>  
> @@ -1592,12 +1597,36 @@ static ssize_t nvm_authenticate_store(struct device *dev,
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
> +	int ret = nvm_authenticate_sysfs(dev, buf, true);
> +
> +	if (ret)
> +		return ret;
> +	return count;

Hmm,

perhaps like this:

	int ret;

	ret = nvm_authenticate_sysfs(dev, buf, true);
	return ret ? ret : count;

> +}
> +static DEVICE_ATTR_RW(nvm_authenticate_on_disconnect);
> +
>  static ssize_t nvm_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -1655,6 +1684,7 @@ static struct attribute *switch_attrs[] = {
>  	&dev_attr_generation.attr,
>  	&dev_attr_key.attr,
>  	&dev_attr_nvm_authenticate.attr,
> +	&dev_attr_nvm_authenticate_on_disconnect.attr,
>  	&dev_attr_nvm_version.attr,
>  	&dev_attr_rx_speed.attr,
>  	&dev_attr_rx_lanes.attr,
> @@ -1709,6 +1739,10 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
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
> diff --git a/drivers/thunderbolt/tb-quirks.h b/drivers/thunderbolt/tb-quirks.h
> new file mode 100644
> index 000000000000..6b644eaaac40
> --- /dev/null
> +++ b/drivers/thunderbolt/tb-quirks.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Thunderbolt driver - quirks
> + *
> + * Copyright (c) 2020 Mario Limonciello <mario.limonciello@dell.com>
> + */
> +
> +
> +#ifndef _TB_QUIRKS
> +#define _TB_QUIRKS
> +
> +#define QUIRK_FORCE_POWER_LINK_CONTROLLER       (1<<1)
> +
> +void check_tbt_quirks(struct tb_switch *sw);

I think we can put these two lines into tb.h for now.

> +
> +#endif
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 222ec19737fa..22937be69a1f 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -118,6 +118,7 @@ struct tb_switch_tmu {
>   * @depth: Depth in the chain this switch is connected (ICM only)
>   * @rpm_complete: Completion used to wait for runtime resume to
>   *		  complete (ICM only)
> + * @quirks: Quirks used for this Thunderbolt switch
>   *
>   * When the switch is being added or removed to the domain (other
>   * switches) you need to have domain lock held.
> @@ -155,6 +156,7 @@ struct tb_switch {
>  	u8 link;
>  	u8 depth;
>  	struct completion rpm_complete;
> +	unsigned long quirks;
>  };
>  
>  /**
> @@ -784,6 +786,7 @@ bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
>  bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
>  int tb_lc_dp_sink_alloc(struct tb_switch *sw, struct tb_port *in);
>  int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in);
> +int lc_force_power(struct tb_switch *sw);
>  
>  static inline int tb_route_length(u64 route)
>  {
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index c29c5075525a..9a2fab9c5346 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -379,6 +379,7 @@ struct tb_regs_hop {
>  #define TB_LC_SNK_ALLOCATION_SNK1_SHIFT	4
>  #define TB_LC_SNK_ALLOCATION_SNK1_MASK	GENMASK(7, 4)
>  #define TB_LC_SNK_ALLOCATION_SNK1_CM	0x1
> +#define TB_LC_POWER			0x740
>  
>  /* Link controller registers */
>  #define TB_LC_PORT_ATTR			0x8d
> -- 
> 2.25.1
