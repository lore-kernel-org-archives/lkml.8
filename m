Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA3D20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDHKwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:52:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62856 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgDHKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:52:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038AaWiJ112210;
        Wed, 8 Apr 2020 06:51:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30920rf74p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 06:51:48 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 038AbFRC113350;
        Wed, 8 Apr 2020 06:51:48 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30920rf74g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 06:51:48 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 038AoaDu025127;
        Wed, 8 Apr 2020 10:51:47 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3091mdweea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 10:51:47 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038Aplq427328904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 10:51:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 005B5112065;
        Wed,  8 Apr 2020 10:51:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48776112062;
        Wed,  8 Apr 2020 10:51:46 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.92.41])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 10:51:46 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 7C8382E3024; Wed,  8 Apr 2020 16:21:40 +0530 (IST)
Date:   Wed, 8 Apr 2020 16:21:40 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        vaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        skiboot@lists.ozlabs.org, oohall@gmail.com,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 1/3] Interface for an idle-stop dependency structure
Message-ID: <20200408105140.GD950@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1583332695.git.psampat@linux.ibm.com>
 <80c7a6ae66ab25bd088beaa3bd5c69f3b1352ac2.1583332695.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c7a6ae66ab25bd088beaa3bd5c69f3b1352ac2.1583332695.git.psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

On Wed, Mar 04, 2020 at 09:31:21PM +0530, Pratik Rajesh Sampat wrote:
> Design patch to introduce the idea of having a dependency structure for
> idle-stop. The structure encapsulates the following:
> 1. Bitmask for version of idle-stop
> 2. Bitmask for propterties like ENABLE/DISABLE
> 3. Function pointer which helps handle how the stop must be invoked
> 
> The commit lays a foundation for other idle-stop versions to be added
> and handled cleanly based on their specified requirments.
> Currently it handles the existing "idle-stop" version by setting the
> discovery bits and the function pointer.

So, if this patch is applied, and we are running with an OPAL that
doesn't publish the "idle-stop" dt-cpu-feature, then the goal is to
not enable any stop states. Is this correct ?


> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/processor.h  | 17 +++++++++++++++++
>  arch/powerpc/kernel/dt_cpu_ftrs.c     |  5 +++++
>  arch/powerpc/platforms/powernv/idle.c | 17 +++++++++++++----
>  drivers/cpuidle/cpuidle-powernv.c     |  3 ++-
>  4 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index eedcbfb9a6ff..da59f01a5c09 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -429,6 +429,23 @@ extern void power4_idle_nap(void);
>  extern unsigned long cpuidle_disable;
>  enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
> 
> +#define STOP_ENABLE		0x00000001
> +
> +#define STOP_VERSION_P9       0x1
> +
> +/*
> + * Classify the dependencies of the stop states
> + * @idle_stop: function handler to handle the quirk stop version
> + * @cpuidle_prop: Signify support for stop states through kernel and/or firmware
> + * @stop_version: Classify quirk versions for stop states
> + */
> +typedef struct {
> +	unsigned long (*idle_stop)(unsigned long, bool);
> +	uint8_t cpuidle_prop;
> +	uint8_t stop_version;

Why do we need both cpuidle_prop and stop_version ? 


> +}stop_deps_t;
> +extern stop_deps_t stop_dep;
> +
>  extern int powersave_nap;	/* set if nap mode can be used in idle loop */
> 
>  extern void power7_idle_type(unsigned long type);
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 182b4047c1ef..db1a525e090d 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -292,6 +292,8 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
>  	lpcr |=  LPCR_PECE1;
>  	lpcr |=  LPCR_PECE2;
>  	mtspr(SPRN_LPCR, lpcr);
> +	stop_dep.cpuidle_prop |= STOP_ENABLE;
> +	stop_dep.stop_version = STOP_VERSION_P9;

Doesn't stop_version != 0 imply (stop_dep.cpuidle_prop & STOP_ENABLE)?

> 
>  	return 1;
>  }
> @@ -657,6 +659,9 @@ static void __init cpufeatures_setup_start(u32 isa)
>  	}
>  }
> 
> +stop_deps_t stop_dep = {NULL, 0x0, 0x0};
> +EXPORT_SYMBOL(stop_dep);
> +
>  static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
>  {
>  	const struct dt_cpu_feature_match *m;
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 78599bca66c2..c32cdc37acf4 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -812,7 +812,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
> 
>  #ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	__ppc64_runlatch_off();
> -	srr1 = power9_idle_stop(psscr, true);
> +	srr1 = stop_dep.idle_stop(psscr, true);
>  	__ppc64_runlatch_on();
>  #else
>  	/*
> @@ -828,7 +828,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
>  	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
> 
>  	__ppc64_runlatch_off();
> -	srr1 = power9_idle_stop(psscr, false);
> +	srr1 = stop_dep.idle_stop(psscr, true);
>  	__ppc64_runlatch_on();
> 
>  	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
> @@ -856,7 +856,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
>  	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
> 
>  	__ppc64_runlatch_off();
> -	srr1 = power9_idle_stop(psscr, true);
> +	srr1 = stop_dep.idle_stop(psscr, true);
>  	__ppc64_runlatch_on();
>

There is one other place in arch/powerpc/kvm/book3s_hv_rmhandlers.S
where call isa300_idle_stop_mayloss (this is kvm_nap_sequence).

So, if stop states are not supported, then, KVM subsystem should know
about it. Some KVM configurations depend on putting the secondary
threads of the core offline into an idle state whose wakeup is from
0x100 vector. Your patch doesn't address that part.

>  	fini_irq_for_idle_irqsoff();
> @@ -1353,8 +1353,17 @@ static int __init pnv_init_idle_states(void)
>  	nr_pnv_idle_states = 0;
>  	supported_cpuidle_states = 0;
> 
> -	if (cpuidle_disable != IDLE_NO_OVERRIDE)
> +	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
> +	    !(stop_dep.cpuidle_prop & STOP_ENABLE))

This can be (stop_dep.stop_version == STOP_NOT_SUPPORTED) where
#define STOP_NOT_SUPPORTED  0

>  		goto out;
> +	switch(stop_dep.stop_version) {
> +	case STOP_VERSION_P9:
> +		stop_dep.idle_stop = power9_idle_stop;
> +		break;
> +	default:
> +		stop_dep.idle_stop = NULL;

You should add a pr_warn() here that stop state isn't supported
because the kernel doesn't know about the version.



> +		goto out;
> +	}
>  	rc = pnv_parse_cpuidle_dt();
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 1b299e801f74..7430a8edf5c9 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -371,7 +371,8 @@ static int powernv_add_idle_states(void)
>   */
>  static int powernv_idle_probe(void)
>  {
> -	if (cpuidle_disable != IDLE_NO_OVERRIDE)
> +	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
> +	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
>  		return -ENODEV;
> 
>  	if (firmware_has_feature(FW_FEATURE_OPAL)) {
> -- 
> 2.24.1
> 
