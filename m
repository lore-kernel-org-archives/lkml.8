Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F53C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4D220661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UEcN8lJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEHIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:08:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7940 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgBEHIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:08:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CCMy2cvlz9vC0w;
        Wed,  5 Feb 2020 08:08:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UEcN8lJl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Y1E3cpL1tbsk; Wed,  5 Feb 2020 08:08:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CCMy1Z4Xz9vC0v;
        Wed,  5 Feb 2020 08:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580886526; bh=wk1eSZfKa/uCgbSeaHgMYGqmJFfEX4IDkxY2j1qLt5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UEcN8lJl+hLeHllKoyJOwY62yfGvvpmIqaeajwXBqXqBdkh2b1rqwxDMOC6P57IRn
         3w1aFHGTQBExTzJaDV7Etbho4vLzNy5nTSwMEQSCiODyjwktRyijUsuLyYoZpRc621
         k8X4gKws4MWvQRplmTxxdcKt7iEUv8gGqfMo7lCA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03A518B820;
        Wed,  5 Feb 2020 08:08:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SuJQpOUhv6DV; Wed,  5 Feb 2020 08:08:46 +0100 (CET)
Received: from [172.25.230.107] (unknown [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B90FA8B778;
        Wed,  5 Feb 2020 08:08:46 +0100 (CET)
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
 <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b26cedb0-8b12-71b6-63d2-990186cd49e5@c-s.fr>
Date:   Wed, 5 Feb 2020 08:08:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/11/2019 à 13:01, Gautham R. Shenoy a écrit :
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On Pseries LPARs, to calculate utilization, we need to know the
> [S]PURR ticks when the CPUs were busy or idle.
> 
> The total PURR and SPURR ticks are already exposed via the per-cpu
> sysfs files /sys/devices/system/cpu/cpuX/purr and
> /sys/devices/system/cpu/cpuX/spurr.
> 
> This patch adds support for exposing the idle PURR and SPURR ticks via
> /sys/devices/system/cpu/cpuX/idle_purr and
> /sys/devices/system/cpu/cpuX/idle_spurr.

Might be a candid question, but I see in arch/powerpc/kernel/time.c that 
PURR/SPURR are already taken into account by the kernel to calculate 
utilisation when CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected.

As far as I understand, you are wanting to expose this to userland to 
redo the calculation there. What is wrong with the values reported by 
the kernel ?

Christophe

> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/sysfs.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 80a676d..42ade55 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -1044,6 +1044,36 @@ static ssize_t show_physical_id(struct device *dev,
>   }
>   static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
>   
> +static ssize_t idle_purr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	unsigned int cpuid = cpu->dev.id;
> +	struct lppaca *cpu_lppaca_ptr = paca_ptrs[cpuid]->lppaca_ptr;
> +	u64 idle_purr_cycles = be64_to_cpu(cpu_lppaca_ptr->wait_state_cycles);
> +
> +	return sprintf(buf, "%llx\n", idle_purr_cycles);
> +}
> +static DEVICE_ATTR_RO(idle_purr);
> +
> +DECLARE_PER_CPU(u64, idle_spurr_cycles);
> +static ssize_t idle_spurr_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	unsigned int cpuid = cpu->dev.id;
> +	u64 *idle_spurr_cycles_ptr = per_cpu_ptr(&idle_spurr_cycles, cpuid);
> +
> +	return sprintf(buf, "%llx\n", *idle_spurr_cycles_ptr);
> +}
> +static DEVICE_ATTR_RO(idle_spurr);
> +
> +static void create_idle_purr_spurr_sysfs_entry(struct device *cpudev)
> +{
> +	device_create_file(cpudev, &dev_attr_idle_purr);
> +	device_create_file(cpudev, &dev_attr_idle_spurr);
> +}
> +
>   static int __init topology_init(void)
>   {
>   	int cpu, r;
> @@ -1067,6 +1097,8 @@ static int __init topology_init(void)
>   			register_cpu(c, cpu);
>   
>   			device_create_file(&c->dev, &dev_attr_physical_id);
> +			if (firmware_has_feature(FW_FEATURE_SPLPAR))
> +				create_idle_purr_spurr_sysfs_entry(&c->dev);
>   		}
>   	}
>   	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
> 
