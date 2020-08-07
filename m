Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F13AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71445221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="V9kZN3yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgHGD6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:58:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59650 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgHGD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:58:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596772732; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=C2ucV737ExsDXpkz6QlsBVH4iT/CVHxyv0O0MJigDW0=;
 b=V9kZN3yVEDL8Ze3VH1fUfpSWi+3C47DJjRnNVWh1RoaNdnp2jMoy6TIx8WIjP+Wa/J5mgwLK
 2G3QdoozhVLeGNouI3n+B5ez6VOp2VVdCPeu8RWRtNbBoZdwd4izFyaH9EKbQVEIPdKY9V3y
 SodoIDFMz31Vk7N8pMPuvKm54nQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f2cd17b4c787f237b61d1cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 07 Aug 2020 03:58:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F6F0C433A0; Fri,  7 Aug 2020 03:58:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C83F3C433C6;
        Fri,  7 Aug 2020 03:58:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Aug 2020 11:58:49 +0800
From:   tingwei@codeaurora.org
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCHv3] coresight: etm4x: Fix etm4_count race by moving cpuhp
 callbacks to init
In-Reply-To: <20200807035221.GA6372@codeaurora.org>
References: <20200729051310.18436-1-saiprakash.ranjan@codeaurora.org>
 <20200807035221.GA6372@codeaurora.org>
Message-ID: <5e6f1de80532ef401d76890969d5a0c6@codeaurora.org>
X-Sender: tingwei@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise.  Please ignore previous comment.
The change is in old patch set of my series.
This change is good to go.
On 2020-08-07 11:52, Tingwei Zhang wrote:
> On Wed, Jul 29, 2020 at 01:13:10PM +0800, Sai Prakash Ranjan wrote:
>> etm4_count keeps track of number of ETMv4 registered and on some 
>> systems,
>> a race is observed on etm4_count variable which can lead to multiple 
>> calls
>> to cpuhp_setup_state_nocalls_cpuslocked(). This function internally 
>> calls
>> cpuhp_store_callbacks() which prevents multiple registrations of 
>> callbacks
>> for a given state and due to this race, it returns -EBUSY leading to 
>> ETM
>> probe failures like below.
>> 
>>  coresight-etm4x: probe of 7040000.etm failed with error -16
>> 
>> This race can easily be triggered with async probe by setting probe 
>> type
>> as PROBE_PREFER_ASYNCHRONOUS and with ETM power management property
>> "arm,coresight-loses-context-with-cpu".
>> 
>> Prevent this race by moving cpuhp callbacks to etm driver init since 
>> the
>> cpuhp callbacks doesn't have to depend on the etm4_count and can be 
>> once
>> setup during driver init. Similarly we move cpu_pm notifier 
>> registration
>> to driver init and completely remove etm4_count usage. Also now we can
>> use non cpuslocked version of cpuhp callbacks with this movement.
>> 
>> Fixes: 9b6a3f3633a5 ("coresight: etmv4: Fix CPU power management setup 
>> in
>> probe() function")
>> Fixes: 58eb457be028 ("hwtracing/coresight-etm4x: Convert to hotplug 
>> state
>> machine")
>> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>> 
>> Changes in v3:
>>  * Minor cleanups from v2 and change to device_initcall (Stephen Boyd)
>>  * Move to non cpuslocked cpuhp callbacks and rename to etm_pm_setup() 
>> (Mike
>> Leach)
>> 
>> Changes in v2:
>>  * Rearrange cpuhp callbacks and move them to driver init (Suzuki K 
>> Poulose)
>> 
>> ---
>>  drivers/hwtracing/coresight/coresight-etm4x.c | 65 
>> +++++++++----------
>>  1 file changed, 31 insertions(+), 34 deletions(-)
>> 
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c
>> b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 6d7d2169bfb2..fddfd93b9a7b 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -48,8 +48,6 @@ module_param(pm_save_enable, int, 0444);
>>  MODULE_PARM_DESC(pm_save_enable,
>>  	"Save/restore state on power down: 1 = never, 2 = self-hosted");
>> 
>> -/* The number of ETMv4 currently registered */
>> -static int etm4_count;
>>  static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
>>  static void etm4_set_default_config(struct etmv4_config *config);
>>  static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>> @@ -1398,28 +1396,25 @@ static struct notifier_block etm4_cpu_pm_nb = 
>> {
>>  	.notifier_call = etm4_cpu_pm_notify,
>>  };
>> 
>> -/* Setup PM. Called with cpus locked. Deals with error conditions and
>> counts */
>> -static int etm4_pm_setup_cpuslocked(void)
>> +/* Setup PM. Deals with error conditions and counts */
>> +static int __init etm4_pm_setup(void)
>>  {
>>  	int ret;
>> 
>> -	if (etm4_count++)
>> -		return 0;
>> -
>>  	ret = cpu_pm_register_notifier(&etm4_cpu_pm_nb);
>>  	if (ret)
>> -		goto reduce_count;
>> +		return ret;
>> 
>> -	ret =
>> cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
>> -						   "arm/coresight4:starting",
>> -						   etm4_starting_cpu, etm4_dying_cpu);
>> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
>> +					"arm/coresight4:starting",
>> +					etm4_starting_cpu, etm4_dying_cpu);
>> 
>>  	if (ret)
>>  		goto unregister_notifier;
>> 
>> -	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
>> -						   "arm/coresight4:online",
>> -						   etm4_online_cpu, NULL);
>> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +					"arm/coresight4:online",
>> +					etm4_online_cpu, NULL);
>> 
>>  	/* HP dyn state ID returned in ret on success */
>>  	if (ret > 0) {
>> @@ -1428,21 +1423,15 @@ static int etm4_pm_setup_cpuslocked(void)
>>  	}
>> 
>>  	/* failed dyn state - remove others */
>> -	cpuhp_remove_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING);
>> +	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
>> 
>>  unregister_notifier:
>>  	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
>> -
>> -reduce_count:
>> -	--etm4_count;
>>  	return ret;
>>  }
>> 
>> -static void etm4_pm_clear(void)
>> +static void __init etm4_pm_clear(void)
>>  {
>> -	if (--etm4_count != 0)
>> -		return;
>> -
>>  	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
>>  	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
>>  	if (hp_online) {
>> @@ -1498,22 +1487,12 @@ static int etm4_probe(struct amba_device 
>> *adev,
>> const struct amba_id *id)
>>  	if (!desc.name)
>>  		return -ENOMEM;
>> 
>> -	cpus_read_lock();
>>  	etmdrvdata[drvdata->cpu] = drvdata;
>> 
>>  	if (smp_call_function_single(drvdata->cpu,
>>  				etm4_init_arch_data,  drvdata, 1))
>>  		dev_err(dev, "ETM arch init failed\n");
>> 
>> -	ret = etm4_pm_setup_cpuslocked();
>> -	cpus_read_unlock();
>> -
>> -	/* etm4_pm_setup_cpuslocked() does its own cleanup - exit on error 
>> */
>> -	if (ret) {
>> -		etmdrvdata[drvdata->cpu] = NULL;
>> -		return ret;
>> -	}
>> -
>>  	if (etm4_arch_supported(drvdata->arch) == false) {
>>  		ret = -EINVAL;
>>  		goto err_arch_supported;
>> @@ -1560,7 +1539,6 @@ static int etm4_probe(struct amba_device *adev, 
>> const
>> struct amba_id *id)
>> 
>>  err_arch_supported:
>>  	etmdrvdata[drvdata->cpu] = NULL;
>> -	etm4_pm_clear();
>>  	return ret;
>>  }
>> 
>> @@ -1598,4 +1576,23 @@ static struct amba_driver etm4x_driver = {
>>  	.probe		= etm4_probe,
>>  	.id_table	= etm4_ids,
>>  };
>> -builtin_amba_driver(etm4x_driver);
> 
>> +
>> +static int __init etm4x_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = etm4_pm_setup();
> 
> etm4_pm_setup() is called in etm4x_init(), but etm4_pm_clear() is 
> called
> in etm4_remove(). If one ETM4x device is removed, etm4_remove() would 
> be
> called and we could still have other ETM4x device alive.
> 
> Should etm4_pm_clear() be called in etm4x_exit()? It should only be 
> called
> when module exits.
> 
> Thanks,
> Tingwei
> 
>> +
>> +	/* etm4_pm_setup() does its own cleanup - exit on error */
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = amba_driver_register(&etm4x_driver);
>> +	if (ret) {
>> +		pr_err("Error registering etm4x driver\n");
>> +		etm4_pm_clear();
>> +	}
>> +
>> +	return ret;
>> +}
>> +device_initcall(etm4x_init);
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 
>> _______________________________________________
>> CoreSight mailing list
>> CoreSight@lists.linaro.org
>> https://lists.linaro.org/mailman/listinfo/coresight
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
