Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B17206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RW7lRKlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMHgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:36:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:36:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D7ZqTZ061475;
        Fri, 13 Mar 2020 02:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584084952;
        bh=PLjf14JR395choWfI7mnyRBRT0i7Bl/Wgaz1RQFuEYU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RW7lRKlx1kb8vDZn9XuWSL/lCBqAq0rWnbtVJzIlstdwEyoTI662FY5eTc0tHHQHP
         tmjYmQJs6G1jA+4krdGZ1DKuUOKxOsAMenfj5C+zUzExtm3RoDAVAHK7dcQ46M59xd
         /5nRXRaH7rAWGK3JY0YlxHsjs/7n8TCrrXLduPsg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02D7Zq0A090870;
        Fri, 13 Mar 2020 02:35:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 02:35:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 02:35:51 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02D7ZmWT007777;
        Fri, 13 Mar 2020 02:35:49 -0500
Subject: Re: [PATCH v1 1/3] driver core: Break infinite loop when deferred
 probe can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        <grant.likely@arm.com>, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
 <ad68e006-8a9f-7183-6313-77a5fc3f18f2@ti.com>
 <20200312105402.GU1922688@smile.fi.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <3b0586f4-0af4-3a17-7a4b-e73910f66bff@ti.com>
Date:   Fri, 13 Mar 2020 09:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200312105402.GU1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/03/2020 12.54, Andy Shevchenko wrote:
> On Wed, Mar 11, 2020 at 10:32:32AM +0200, Peter Ujfalusi wrote:
>> Hi Andy,
>>
>> On 09/03/2020 16.11, Andy Shevchenko wrote:
>>> Consider the following scenario.
>>>
>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>> functional dependencies on certain platform:
>>> - ULPI (tusb1210)
>>> - extcon (tested with extcon-intel-mrfld)
>>>
>>> Note, that first driver, tusb1210, is available at the moment of
>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>> won't appear till user space does something about it.
>>>
>>> This is depicted by kernel configuration excerpt:
>>>
>>> 	CONFIG_PHY_TUSB1210=y
>>> 	CONFIG_USB_DWC3=y
>>> 	CONFIG_USB_DWC3_ULPI=y
>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>> 	CONFIG_USB_DWC3_PCI=y
>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>
>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>> probed first followed by extcon one.
>>>
>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>> we will get deferred probe of USB OTG, because of ordering.
>>>
>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>
>>> ---8<---8<---
>>>
>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>
>>> ...here is the late initcall triggers deferred probe...
>>>
>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>
>>> ...dwc3.0.auto is the only device in the deferred list...
>>>
>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>
>>> ...the counter before mutex is unlocked is kept the same...
>>>
>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>
>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>
>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>
>> here dwc3 does ulpi_register_interface() which will make the tusb1210 to
>> probe as it is an ulpi_driver.
>>
>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>
>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>
>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>
>> and it probes fine as it has no dependencies.
>>
>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>
>>> ...but extcon driver is still missing...
>>
>> and the dwc3 will ulpi_unregister_interface() which makes the tusb1210
>> to be removed as a result since the ulpi bus it was sitting on disappeared.
>>
>>>
>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>
>>> ...and since we had a successful probe, we got counter mismatch...
>>>
>>> [   22.297490] driver_deferred_probe_trigger <<< 3
>>> [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
>>>
>>> ...at the end we have a new counter and loop repeats again, see 22.198727...
>>>
>>> ---8<---8<---
>>
>> Nice
>>
>>> Revert of the commit helps, but it is probably not helpful for the initially
>>> found regression. Artem Bityutskiy suggested to use counter of the successful
>>> probes instead. This fixes above mentioned case and shouldn't prevent driver
>>> to reprobe deferred ones.
>>
>> Hrm, but at 22.256292 the tusb1210 is successfully bound which would
>> increment the probe_okay?
>>
>> Ah, I see you effectively counting the probes, increment the probe_okay
>> on bound and decrement it in release of the driver.
>>
>> It surely going to balance back in your case as dwc3 registers the ulpi
>> interface (which triggers probes on the ulpi bus) and when dwc3 defers
>> it unregisters the ulpi interface (which causes the drivers to be
>> removed as well).
>>
>> I think in theory this should not break the original fix if I play that
>> (parallel probing of drivers with dependencies) scenario down in my head ;)
>>
>> Let me see, successful probe will trigger the deferred list always.
>> If any driver successfully probed between the start of really_probe and
>> the driver which is probing got deferred then the counter should
>> indicate that -> we will reprobe the driver by kicking the deferred list.
>>
>> Unfortunately I don't have a setup to test this, but I trust you and
>> Artem enough to:
>>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Thank you, Peter!
> 
> Yes, under "successful probe" we understand the one that has stayed probed
> after the deferred trigger cycle. That's why a decrement counter is essential
> to make this scheme work.
> 
> Ideally I would like to get Grant's comment on / test of this...

I fixed up Grant's email address to get his attention you are seeking for...

- Péter

> 
>>> Fixes: 58b116bce136 ("drivercore: deferral race condition fix")
>>> Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>> Cc: Grant Likely <grant.likely@linaro.org>
>>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Felipe Balbi <balbi@kernel.org>
>>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  drivers/base/dd.c | 39 +++++++++++++++++++++------------------
>>>  1 file changed, 21 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index b25bcab2a26b..43720beb5300 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -53,7 +53,6 @@
>>>  static DEFINE_MUTEX(deferred_probe_mutex);
>>>  static LIST_HEAD(deferred_probe_pending_list);
>>>  static LIST_HEAD(deferred_probe_active_list);
>>> -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>>>  static struct dentry *deferred_devices;
>>>  static bool initcalls_done;
>>>  
>>> @@ -147,17 +146,6 @@ static bool driver_deferred_probe_enable = false;
>>>   * This functions moves all devices from the pending list to the active
>>>   * list and schedules the deferred probe workqueue to process them.  It
>>>   * should be called anytime a driver is successfully bound to a device.
>>> - *
>>> - * Note, there is a race condition in multi-threaded probe. In the case where
>>> - * more than one device is probing at the same time, it is possible for one
>>> - * probe to complete successfully while another is about to defer. If the second
>>> - * depends on the first, then it will get put on the pending list after the
>>> - * trigger event has already occurred and will be stuck there.
>>> - *
>>> - * The atomic 'deferred_trigger_count' is used to determine if a successful
>>> - * trigger has occurred in the midst of probing a driver. If the trigger count
>>> - * changes in the midst of a probe, then deferred processing should be triggered
>>> - * again.
>>>   */
>>>  static void driver_deferred_probe_trigger(void)
>>>  {
>>> @@ -170,7 +158,6 @@ static void driver_deferred_probe_trigger(void)
>>>  	 * into the active list so they can be retried by the workqueue
>>>  	 */
>>>  	mutex_lock(&deferred_probe_mutex);
>>> -	atomic_inc(&deferred_trigger_count);
>>>  	list_splice_tail_init(&deferred_probe_pending_list,
>>>  			      &deferred_probe_active_list);
>>>  	mutex_unlock(&deferred_probe_mutex);
>>> @@ -350,6 +337,19 @@ static void __exit deferred_probe_exit(void)
>>>  }
>>>  __exitcall(deferred_probe_exit);
>>>  
>>> +/*
>>> + * Note, there is a race condition in multi-threaded probe. In the case where
>>> + * more than one device is probing at the same time, it is possible for one
>>> + * probe to complete successfully while another is about to defer. If the second
>>> + * depends on the first, then it will get put on the pending list after the
>>> + * trigger event has already occurred and will be stuck there.
>>> + *
>>> + * The atomic 'probe_okay' is used to determine if a successful probe has
>>> + * occurred in the midst of probing another driver. If the count changes in
>>> + * the midst of a probe, then deferred processing should be triggered again.
>>> + */
>>> +static atomic_t probe_okay = ATOMIC_INIT(0);
>>> +
>>>  /**
>>>   * device_is_bound() - Check if device is bound to a driver
>>>   * @dev: device to check
>>> @@ -375,6 +375,7 @@ static void driver_bound(struct device *dev)
>>>  	pr_debug("driver: '%s': %s: bound to device '%s'\n", dev->driver->name,
>>>  		 __func__, dev_name(dev));
>>>  
>>> +	atomic_inc(&probe_okay);
>>>  	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
>>>  	device_links_driver_bound(dev);
>>>  
>>> @@ -481,18 +482,18 @@ static atomic_t probe_count = ATOMIC_INIT(0);
>>>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>>>  
>>>  static void driver_deferred_probe_add_trigger(struct device *dev,
>>> -					      int local_trigger_count)
>>> +					      int local_probe_okay_count)
>>>  {
>>>  	driver_deferred_probe_add(dev);
>>>  	/* Did a trigger occur while probing? Need to re-trigger if yes */
>>> -	if (local_trigger_count != atomic_read(&deferred_trigger_count))
>>> +	if (local_probe_okay_count != atomic_read(&probe_okay))
>>>  		driver_deferred_probe_trigger();
>>>  }
>>>  
>>>  static int really_probe(struct device *dev, struct device_driver *drv)
>>>  {
>>>  	int ret = -EPROBE_DEFER;
>>> -	int local_trigger_count = atomic_read(&deferred_trigger_count);
>>> +	int local_probe_okay_count = atomic_read(&probe_okay);
>>>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>>>  			   !drv->suppress_bind_attrs;
>>>  
>>> @@ -509,7 +510,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>>  
>>>  	ret = device_links_check_suppliers(dev);
>>>  	if (ret == -EPROBE_DEFER)
>>> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
>>> +		driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> @@ -619,7 +620,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>>  	case -EPROBE_DEFER:
>>>  		/* Driver requested deferred probing */
>>>  		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
>>> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
>>> +		driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
>>>  		break;
>>>  	case -ENODEV:
>>>  	case -ENXIO:
>>> @@ -1148,6 +1149,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>>  		dev_pm_set_driver_flags(dev, 0);
>>>  
>>>  		klist_remove(&dev->p->knode_driver);
>>> +		atomic_dec(&probe_okay);
>>> +
>>>  		device_pm_check_callbacks(dev);
>>>  		if (dev->bus)
>>>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
