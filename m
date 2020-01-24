Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E35C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC06206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ju32UTug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgAXLvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:51:33 -0500
Received: from mail-eopbgr50117.outbound.protection.outlook.com ([40.107.5.117]:61503
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgAXLvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:51:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKaUjMf4Ko+xpwaBgpFY8VEihL73yVqxm6vzZwG26GEWfNIAutlOQDih+PHPnr6ojOf3UJ7SXq7UEm5DY3C0WH500I3s8ULSCcE8wsrY7660BLALM4Od47fBfQFKtWJTllh5XL/WoUJn4pgJJ2dXPeu6eZS7r2c8GWbgE459SAYuB0dbYMVWQMXT1BeIJCELXQSxvnd9Lxcx7mOnLmcq4q/XUR5TT1sEert+BUqPTDXJEgy3ZqknNhllJEiV2NS7kppOBAWE5fB+0BWl/vHPBxOYmZn67Ol2O9NdovmJOLp/T684vG7Qh2f+At8YGU+gh61WKdw8V0Z4ctwpDJGl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVmann6b47NUVExFvtiBUjZ7vLLSY7TMdM9hJPja3u8=;
 b=bvkE28Uaw8O4iqcpRTqjLVtTugZgjF/EF3tVLm8Zd7Drd2nbefIdpNYbNzkfRF8spd64wbYKbKbbWcZ2DuzlBs1c8+p7Xa/l2f8vc0gglUJZNBEVDImo1lGnW0afMf5YJPsJREd3DxGUlV/KTSvM9BOTK4aWOcvMDxDwSokG+jbjEjL5QXGLVpCI10nZ+FeQCuWI1tOWnWmLpT2pvifIRR5i05bppzkUTJ7Z9Uyv3Tl1EVaV6rsVXIuD/2xX1WQkAwqjRs52Y7kJjwVO5WWuyNx1HciezUuJrXdL0IpKWIzSDPnxasLUCUNVPuXxFpadCMyFGdUuO3sAqz6wf2x8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVmann6b47NUVExFvtiBUjZ7vLLSY7TMdM9hJPja3u8=;
 b=ju32UTugcSmuWmYjUVjvZ8nN0ToPPLKqj4fuQIkvX3YVLQpwyePv8YcO01vRs69qHYr0O8OqioEywVUFqdWlmJTOLpT+eJtT4bpx9nr4V20BvvUYe/oVTcqZgEQZno/8VyJs4AfjzZYMZTRYy/IDshinV9++jFwpGY7SqOouKIc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com (20.177.203.20) by
 VI1PR07MB4237.eurprd07.prod.outlook.com (20.176.6.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Fri, 24 Jan 2020 11:51:24 +0000
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e]) by VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e%2]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 11:51:24 +0000
Subject: Re: [PATCH] cpu/hotplug: Wait for cpu_hotplug to be enabled in
 cpu_up/down
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <9bf397db-0eb8-ac30-b0ff-f8970d8b21be@nokia.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <18207c49-fa25-81e2-4ef3-df1b232809b8@nokia.com>
Date:   Fri, 24 Jan 2020 12:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <9bf397db-0eb8-ac30-b0ff-f8970d8b21be@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0341.eurprd05.prod.outlook.com
 (2603:10a6:7:92::36) To VI1PR07MB5040.eurprd07.prod.outlook.com
 (2603:10a6:803:9c::20)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.167) by HE1PR05CA0341.eurprd05.prod.outlook.com (2603:10a6:7:92::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Fri, 24 Jan 2020 11:51:19 +0000
X-Originating-IP: [131.228.32.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56ee1ea0-aa0d-48bc-8a6e-08d7a0c3bcb6
X-MS-TrafficTypeDiagnostic: VI1PR07MB4237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB42372F3FA24B97ECB6B91066880E0@VI1PR07MB4237.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(6486002)(2616005)(956004)(31696002)(8936002)(2906002)(16576012)(5660300002)(86362001)(316002)(186003)(26005)(16526019)(478600001)(36756003)(31686004)(53546011)(6706004)(44832011)(6666004)(52116002)(66476007)(81156014)(8676002)(81166006)(66556008)(66946007)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4237;H:VI1PR07MB5040.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlt5H5e+zZTSNHqm4gKoD+CpowZP+hivjC25ppMk4Cc/Ore+ifx51XSs2CVabiX9vxJzOMiXQ6cNd0RhE9TryLVNTUV4baKiLcoPuANd+h76EJo2hZRTscGgYhcoihRPxxu0gudh8j8y5xA3/6yPI/Poj9vd/7sallL08hM2hmJ20melcoLRDs3WJn28bgOeH6ymToa5ahAs31mMiVNXefrj5nLrzNcsY5IOHSmvTb7fYcnwbp3wEs/wBkdwagjrxhvu6/qBdTpYHiqdVd+UTDEjyZfF4fwhetVPUEE7waj8HGpP/H1vq6vfGSFEkU/YcjBRYUwPlFEuazOLMi7h0XNBySq70vNmz6w6ibGAZQ3xB1u92EOkQB2yg5yKVXZe9waK+TP9FGS3WD9t5nn5rhrRJKdY8XQee8+hkxE/KEO3mwSSNM2gaOtkbRm4RCskTr9VpEa4WUVm32abdhVnICBfEPHI7zZn3Bwo5yc+hCdWSDeT/1hQwWCG3GJYAG3q
X-MS-Exchange-AntiSpam-MessageData: 5kxlMK7uER9iCJj9+Bv4vT6EvvXUZ0GXSTDKlsaP+t4nhlWCo7+MFnUHjSjFFtvlIkwztjehtvdRYLQein7C6mIfCVb0KYC2iuAv4SgUHlw/GRCwFYDOoSD/DYHS/XSak3iuFRcYgCaE1ZW2fnyhbg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ee1ea0-aa0d-48bc-8a6e-08d7a0c3bcb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 11:51:24.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtNaRixlhDbLJ1Jsa6h92zNMWtcj/zlpUjcJvioMfaj8M7IVr2PVkXZTc4Xcy20f2789QEhG2XEO4RpOpYJiSmDiww1O48AobUHw7pxYtVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 24/01/2020 09:18, Matija Glavinic Pecotic wrote:
> cpu hotplug may be disabled via cpu_hotplug_enable/cpu_hotplug_disable.
> When disabled, cpu_down and cpu_up will fail with -EBUSY. Users of the
> cpu_up/cpu_down should handle this situation as this is mostly temporal
> disablement and exception should be made for EBUSY, assuming that EBUSY
> always stands for this situation and is worth repeating execution. One
> of the users of cpu_hotplug_enable/disable is pci_device_probe yielding
> errors on bringing cpu cores up/down if pci devices are getting probed.
> 
> Problem was observed on x86 board by having partitioning of the system
> to RT/NRT cpu sets failing (of which part is to bring cpus down/up via
> sysfs) if pci devices would be getting probed at the same time. This is
> confusing for userspace as dependency to pci devices is not clear.
> 
> Fix this behavior by waiting for cpu hotplug to be ready. Return -EBUSY
> only after hotplugging was not enabled for about 10 seconds.
> 
> Fixes: 1ddd45f8d76f ("PCI: Use cpu_hotplug_disable() instead of get_online_cpus()")
> Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>   kernel/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 4dc279e..2e06ca9 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -31,6 +31,7 @@
>   #include <linux/relay.h>
>   #include <linux/slab.h>
>   #include <linux/percpu-rwsem.h>
> +#include <linux/wait.h>
>   
>   #include <trace/events/power.h>
>   #define CREATE_TRACE_POINTS
> @@ -278,11 +279,22 @@ void cpu_maps_update_done(void)
>   }
>   
>   /*
> - * If set, cpu_up and cpu_down will return -EBUSY and do nothing.
> + * If set, cpu_up and cpu_down will retry for cpu_hotplug_retries and
> + * eventually return -EBUSY if unsuccessful.
>    * Should always be manipulated under cpu_add_remove_lock
>    */
>   static int cpu_hotplug_disabled;
>   
> +/*
> + * waitqueue for waiting on cpu_hotplug_disabled
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(wait_cpu_hp_enabled);
> +
> +/*
> + * Retries for cpu_hotplug to be enabled by cpu_up/cpu_down.
> + */
> +static int cpu_hotplug_retries = 10;
> +
>   #ifdef CONFIG_HOTPLUG_CPU
>   
>   DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
> @@ -341,7 +353,7 @@ static void lockdep_release_cpus_lock(void)
>   
>   /*
>    * Wait for currently running CPU hotplug operations to complete (if any) and
> - * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> + * briefly disable CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
>    * the 'cpu_hotplug_disabled' flag. The same lock is also acquired by the
>    * hotplug path before performing hotplug operations. So acquiring that lock
>    * guarantees mutual exclusion from any currently running hotplug operations.
> @@ -366,6 +378,7 @@ void cpu_hotplug_enable(void)
>   	cpu_maps_update_begin();
>   	__cpu_hotplug_enable();
>   	cpu_maps_update_done();
> +	wake_up(&wait_cpu_hp_enabled);
>   }
>   EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
>   
> @@ -1044,11 +1057,21 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>   
>   static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
>   {
> -	int err;
> +	int err = -EBUSY, retries = cpu_hotplug_retries;
>   
> -	cpu_maps_update_begin();
> -	err = cpu_down_maps_locked(cpu, target);
> -	cpu_maps_update_done();
> +	while (retries--) {
> +		wait_event_timeout(wait_cpu_hp_enabled,
> +				!cpu_hotplug_disabled,
> +				HZ);
> +		cpu_maps_update_begin();
> +		if (cpu_hotplug_disabled) {
> +			cpu_maps_update_done();
> +			continue;
> +		}
> +		err = _cpu_down(cpu, 0, target);
> +		cpu_maps_update_done();
> +		break;
> +	}
>   	return err;
>   }
>   
> @@ -1166,7 +1189,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   
>   static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
>   {
> -	int err = 0;
> +	int err = 0, retries = cpu_hotplug_retries;
>   
>   	if (!cpu_possible(cpu)) {
>   		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
> @@ -1181,9 +1204,16 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
>   	if (err)
>   		return err;
>   
> -	cpu_maps_update_begin();
> -
> -	if (cpu_hotplug_disabled) {
> +	while (--retries) {
> +		wait_event_timeout(wait_cpu_hp_enabled,
> +				   !cpu_hotplug_disabled,
> +				   HZ);
> +		cpu_maps_update_begin();
> +		if (!cpu_hotplug_disabled)
> +			break;
> +		cpu_maps_update_done();
> +	}
> +	if (!retries) {
>   		err = -EBUSY;
>   		goto out;
>   	}
> 

-- 
Best regards,
Alexander Sverdlin.
