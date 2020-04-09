Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C35C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5722820757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="abGjDd8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDILOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:14:34 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:1463
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgDILOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:14:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2+cQu4PBAt2cZGBbtLOJyISeKaGtq2MQ2ehl1uAWxX1Lb/s10vFoW6kW3x1ZcMkM/0jMfL8ljzWi76oS5ldr3jDlmBLtLtx9qkacsDSp9oO7oxDh95sr+nWl4Bl7TYl79wqDukXeV9MW3UA9JciyTyf7PqAv125k9hJJhOZHOkZNIc2xqOKWRWm2fJLQq1Djd6rUzRG1V60yYJXTEiHjOUG3QTT9ALexHpDkp1dZgzPGMJKbFBJkBS7QcUf91xgRlP7nv8+4WcQR7vZAqHUAW3kARZUsZBm1AuPABfP4yePxX8Nnfodgv3IWkvXdbacvtebwLFxE9vKLFZbEDIEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdwtpZOMiIOE9ISKlUBixS9zkw3mScBS9rIpu6pigcc=;
 b=RuT7Hxif+wgjnFXsma9RC4tKCkxCKKgPA/6VkPBh2W3+wWvauoFOtwD4DYp5o7Yifm0h2AqK3+7Wrknq7AwiarL9OujPEnHYVg/X4WwJ2MgN9aMiRnrLDfsodshm8n84IiOApvbWgtT7eNfCCuKY00oScZ34krJcyJ2NaLKpCSv2nDD0RdzEP1QkoqWk2URm8w5gCSdORH1RWK1nYDYrUP/CJjMc0kt+dD8Sz32w89CShlUtSPUSsGpFHxDRIzwigc6kwuPAq/AekVEplzHKlVJHxxb0mp0EKf4+FjHzPdKpcPs1eMlqHUU75aa0CYnGqb+oJZ7LoA7jqB+ybiDKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdwtpZOMiIOE9ISKlUBixS9zkw3mScBS9rIpu6pigcc=;
 b=abGjDd8caRE1uQzpqO08eEcQpGQmabKJvHZTftVfK0+hNagDzVfTGJxrJwrKURr7LnM8UWRPyN0gPkwPHwHw5NVU2GOgXeDUujmtgFpHKoLvSj5nXOrh7G8ZOFAbgMmbF+cT85qZYbg6OD9Zd6nq6CyWG2Xf3NjKy0yI2+U6Qb0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@oss.nxp.com; 
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR0402MB3870.eurprd04.prod.outlook.com
 (2603:10a6:803:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 11:14:30 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::24fb:6b3f:f0e6:bd9a]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::24fb:6b3f:f0e6:bd9a%8]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 11:14:30 +0000
Subject: Re: [PATCH 03/10] bus/fsl-mc: add support for 'driver_override' in
 the mc-bus
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        bharatb.yadav@gmail.com
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
References: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
 <20200319154051.30609-4-diana.craciun@oss.nxp.com>
 <99ef2746-6be8-5427-26af-0a34c17f8fd2@nxp.com>
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <a0af9de5-a234-dbd6-1365-29a1e19ee1aa@oss.nxp.com>
Date:   Thu, 9 Apr 2020 14:14:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <99ef2746-6be8-5427-26af-0a34c17f8fd2@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::48) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.122] (86.127.44.112) by AM0PR01CA0107.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Thu, 9 Apr 2020 11:14:28 +0000
X-Originating-IP: [86.127.44.112]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce215523-2fb4-480c-7bea-08d7dc772bfe
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3870:|VI1PR0402MB3870:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB387049BAA5BA636476AC0F12BEC10@VI1PR0402MB3870.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(66476007)(5660300002)(81156014)(8936002)(53546011)(956004)(16526019)(186003)(6486002)(8676002)(6666004)(2616005)(2906002)(26005)(478600001)(52116002)(316002)(31686004)(81166007)(16576012)(86362001)(66556008)(4326008)(66946007)(31696002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNS6tgc7JXgCixiBoDdYwmMaQJ2MzrLlXqJ7t+J2f1+t6PiQ2PWUyJFyuXQi4tNfHOkG8jA6iOvtg6ucMs7qSgbQg4gA6VcfVvdHhLvmTkRVCuHAphAcvgBOmaIJY+47U5HwxgXF90j+1i1suAgikBuej6cSOIEc/yAzGPe7gYbsLiqj8leJXGMCVxLvoX+2rADfhxAafXaF1ZArSTlJK/gtuzCXVga0EvKRIX8rjvbzAyoisZKEGe0Aq80DUFzM0bHPv00OezEWQmVFCKKJsj3YoU5dZq6wARoihsyR4b4/PMIOLwJmXnNoDW9qI6+a95B2BdS+OV4Eo9+1ynIUZ0zQD9sLaptQpmuKblC1/dGpVWbqu0OBda3d6/Hgdi4wTMke4NvqCxM1xhAw3bIWp2HAplB18y9VyfZSYEyexAcWcCPKDTfHVKh9t2hKnf35
X-MS-Exchange-AntiSpam-MessageData: UYE+ffBGkzM5hCcThBCkd9iJp2nYhIVvLIz0pErSe8KlZY9rL32o2lCarbB/N7b898nGKHnDcjS+5Rw+/EWYwcLphjhRV+8FHNzfqtRfSbocO+6gaHAYo7W6OoiBNQ3hdYuq0gRVOOs7TxkCJFavgg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce215523-2fb4-480c-7bea-08d7dc772bfe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 11:14:30.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWb+P3om0/ZPwvZd0h0Zg2vkOE4H74wWmq2nwsT+1+QN7IJt4Fzm8yVnbB3TuTQ8ouk/p1U81qu29hdb6UvHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2020 2:30 PM, Laurentiu Tudor wrote:
>
> On 3/19/2020 5:40 PM, Diana Craciun wrote:
>> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>>
>> This patch is required for vfio-fsl-mc meta driver to successfully bind
>> layerscape container devices for device passthrough. This patch adds
>> a mechanism to allow a layerscape device to specify a driver rather than
>> a layerscape driver provide a device match.
>>
>> Example to allow a device (dprc.1) to specifically bind
>> with driver (vfio-fsl-mc):-
>>   - echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.1/driver_override
>>   - echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
>>   - echo dprc.1 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind
>>
>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
>> ---
>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 54 +++++++++++++++++++++++++++++++++
>>   include/linux/fsl/mc.h          |  1 +
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> index c78d10ea641f..baf8259262a9 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -3,6 +3,7 @@
>>    * Freescale Management Complex (MC) bus driver
>>    *
>>    * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
>> + * Copyright 2019-2020 NXP
>>    * Author: German Rivera <German.Rivera@freescale.com>
>>    *
>>    */
>> @@ -83,6 +84,12 @@ static int fsl_mc_bus_match(struct device *dev, struct device_driver *drv)
>>   	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(drv);
>>   	bool found = false;
>>   
>> +	/* When driver_override is set, only bind to the matching driver */
>> +	if (mc_dev->driver_override) {
>> +		found = !strcmp(mc_dev->driver_override, mc_drv->driver.name);
> I think we can use sysfs_streq() here and ...

I would prefer to maintain consistency with other buses and store the 
driver_override string without the terminating newline.

>
>
>> +		goto out;
>> +	}
>> +
>>   	if (!mc_drv->match_id_table)
>>   		goto out;
>>   
>> @@ -147,8 +154,52 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RO(modalias);
>>   
>> +static ssize_t driver_override_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t count)
>> +{
>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>> +	const char *driver_override, *old = mc_dev->driver_override;
>> +	char *cp;
>> +
>> +	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
>> +		return -EINVAL;
>> +
>> +	if (count >= (PAGE_SIZE - 1))
>> +		return -EINVAL;
>> +
>> +	driver_override = kstrndup(buf, count, GFP_KERNEL);
>> +	if (!driver_override)
>> +		return -ENOMEM;
>> +
>> +	cp = strchr(driver_override, '\n');
>> +	if (cp)
>> +		*cp = '\0';
> drop this strchr() ...
>
>> +	if (strlen(driver_override)) {
>> +		mc_dev->driver_override = driver_override;
>> +	} else {
>> +		kfree(driver_override);
>> +		mc_dev->driver_override = NULL;
>> +	}
>> +
>> +	kfree(old);
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t driver_override_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
> and also the terminating '\n' here.
>
>> +}
>> +static DEVICE_ATTR_RW(driver_override);
>> +
>>   static struct attribute *fsl_mc_dev_attrs[] = {
>>   	&dev_attr_modalias.attr,
>> +	&dev_attr_driver_override.attr,
>>   	NULL,
>>   };
>>   
>> @@ -704,6 +755,9 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_add);
>>    */
>>   void fsl_mc_device_remove(struct fsl_mc_device *mc_dev)
>>   {
>> +	kfree(mc_dev->driver_override);
>> +	mc_dev->driver_override = NULL;
>> +
>>   	/*
>>   	 * The device-specific remove callback will get invoked by device_del()
>>   	 */
>> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
>> index 54d9436600c7..88095fd30c80 100644
>> --- a/include/linux/fsl/mc.h
>> +++ b/include/linux/fsl/mc.h
>> @@ -194,6 +194,7 @@ struct fsl_mc_device {
>>   	struct fsl_mc_device_irq **irqs;
>>   	struct fsl_mc_resource *resource;
>>   	struct device_link *consumer_link;
>> +	const char *driver_override;
> We probably don't want const here.

OK

>
> ---
> Best Regards, Laurentiu
>
>>   };
>>   
>>   #define to_fsl_mc_device(_dev) \
>>

Diana
