Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3060C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701472467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bXFoOW3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgBZMK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:10:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55740 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgBZMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:10:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QCAHY1055884;
        Wed, 26 Feb 2020 06:10:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582719017;
        bh=0LOC/6nXllmJ01Scp9Ne1ZHs66GMbn2DqRM1UOuEpwQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bXFoOW3gTIBp6z5gzLq/iqr4SFm6wpSfxpH7tADWcgAZYy0sf4bTDrjlTz29rds58
         KNsBweY69FCc+NDsK2/WaSPoyKVdHVN0WfENlWdCYAAa5U6VbzJSdSxdw3AKVPMFFZ
         PkgO0I+gEZhy2kXzYSW6jAjSr+DEkCoY25tgXD3k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QCAHVI077541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 06:10:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 06:10:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 06:10:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCAFZf107786;
        Wed, 26 Feb 2020 06:10:16 -0600
Subject: Re: [PATCH v3] dmaengine: Add basic debugfs support
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
References: <20200205111557.24125-1-peter.ujfalusi@ti.com>
 <20200224163707.GA2618@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <71231b0e-a9a2-4795-da71-b484f4992278@ti.com>
Date:   Wed, 26 Feb 2020 14:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224163707.GA2618@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2/24/20 6:37 PM, Vinod Koul wrote:
> On 05-02-20, 13:15, Peter Ujfalusi wrote:
>> Via the /sys/kernel/debug/dmaengine users can get information about the
>> DMA devices and the used channels.
>>
>> Example output on am654-evm with audio using two channels and after running
>> dmatest on 6 channels:
>>
>> # cat /sys/kernel/debug/dmaengine
>> dma0 (285c0000.dma-controller): number of channels: 96
>>
>> dma1 (31150000.dma-controller): number of channels: 267
>>  dma1chan0    | 2b00000.mcasp:tx
>>  dma1chan1    | 2b00000.mcasp:rx
>>  dma1chan2    | in-use
>>  dma1chan3    | in-use
>>  dma1chan4    | in-use
>>  dma1chan5    | in-use
>>  dma1chan6    | in-use
>>  dma1chan7    | in-use
>>
>> For slave channels we can show the device and the channel name a given
>> channel is requested.
>> For non slave devices the only information we know is that the channel is
>> in use.
>>
>> DMA drivers can implement the optional dbg_show callback to provide
>> controller specific information instead of the generic one.
>>
>> It is easy to extend the generic dmaengine_dbg_show() to print additional
>> information about the used channels.
>>
>> I have taken the idea from gpiolib.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since v2:
>> - Use dma_chan_name() for printing the channel's name
>>
>> Changes since v1:
>> - Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
>> - do not allow modification to dma_device_list while the debugfs file is read
>> - rename the slave_name to dbg_client_name (it is only for debugging)
>> - print information about dma_router if it is used by the channel
>> - Formating of the output slightly changed
>>
>> Regards,
>> Peter
>>
>>  drivers/dma/dmaengine.c   | 65 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/dmaengine.h | 12 +++++++-
>>  2 files changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index c3b1283b6d31..37c3a4cd5b1a 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -32,6 +32,7 @@
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>  
>>  #include <linux/platform_device.h>
>> +#include <linux/debugfs.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/init.h>
>>  #include <linux/module.h>
>> @@ -760,6 +761,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>  		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>>  
>>  found:
>> +#ifdef CONFIG_DEBUG_FS
>> +	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
>> +					  name);
>> +#endif
>> +
>>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>>  	if (!chan->name)
>>  		return chan;
>> @@ -837,6 +843,11 @@ void dma_release_channel(struct dma_chan *chan)
>>  		chan->name = NULL;
>>  		chan->slave = NULL;
>>  	}
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	kfree(chan->dbg_client_name);
>> +	chan->dbg_client_name = NULL;
>> +#endif
>>  	mutex_unlock(&dma_list_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(dma_release_channel);
>> @@ -1562,3 +1573,57 @@ static int __init dma_bus_init(void)
>>  	return class_register(&dma_devclass);
>>  }
>>  arch_initcall(dma_bus_init);
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
>> +{
>> +	struct dma_chan *chan;
>> +
>> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
>> +		if (chan->client_count) {
>> +			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
>> +				   chan->dbg_client_name ?: "in-use");
>> +
>> +			if (chan->router)
>> +				seq_printf(s, " (via router: %s)\n",
>> +					dev_name(chan->router->dev));
>> +			else
>> +				seq_puts(s, "\n");
>> +		}
>> +	}
>> +}
>> +
>> +static int dmaengine_debugfs_show(struct seq_file *s, void *data)
>> +{
>> +	struct dma_device *dma_dev = NULL;
>> +
>> +	mutex_lock(&dma_list_mutex);
>> +	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
>> +		seq_printf(s, "dma%d (%s): number of channels: %u\n",
>> +			   dma_dev->dev_id, dev_name(dma_dev->dev),
>> +			   dma_dev->chancnt);
>> +
>> +		if (dma_dev->dbg_show)
>> +			dma_dev->dbg_show(s, dma_dev);
>  do we really want a custom dbg_show()..? Drivers can add their own
> files...

They could do that already ;)

With the custom dbg_show() DMA drivers can save on the surrounding
code and just fill in the information regarding to their HW.
Again, on am654 the default information is:
# cat /sys/kernel/debug/dmaengine 
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0    | 2b00000.mcasp:tx
 dma1chan1    | 2b00000.mcasp:rx
 dma1chan2    | in-use
 dma1chan3    | in-use
 dma1chan4    | in-use
 dma1chan5    | in-use

With my current .dbg_show implementation for k3-udma:
# cat /sys/kernel/debug/dmaengine 
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan8 [0x1008 -> 0xc400], PDMA, TR mode)
 dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan8 [0x4400 -> 0x9008], PDMA, TR mode)
 dma1chan2    | in-use (MEM_TO_MEM, chan2 pair [0x1002 -> 0x9002], PSI-L Native, TR mode)
 dma1chan3    | in-use (MEM_TO_MEM, chan3 pair [0x1003 -> 0x9003], PSI-L Native, TR mode)
 dma1chan4    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
 dma1chan5    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)

For me this makes a huge difference.

> 
>> +		else
>> +			dmaengine_dbg_show(s, dma_dev);
>> +
>> +		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
>> +			seq_puts(s, "\n");
>> +	}
>> +	mutex_unlock(&dma_list_mutex);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(dmaengine_debugfs);
>> +
>> +static int __init dmaengine_debugfs_init(void)
>> +{
>> +	/* /sys/kernel/debug/dmaengine */
>> +	debugfs_create_file("dmaengine", 0444, NULL, NULL,
>> +			    &dmaengine_debugfs_fops);
> 
> Should we add a directory? That way we can keep adding stuff into that
> one

and have this file as 'summary' underneath?
I like the fact hat I can get all the information via one file.
Saves a lot of time (and explaining to users) on finding the correct
one to cat...
 - Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
