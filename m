Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B03220747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgDHKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:55:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgDHKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:55:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038AYN00014801;
        Wed, 8 Apr 2020 06:54:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30920sragj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 06:54:51 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 038Aaqlr021223;
        Wed, 8 Apr 2020 06:54:51 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30920sraga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 06:54:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 038AoaT9006587;
        Wed, 8 Apr 2020 10:54:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3091mdnekx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 10:54:50 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038Asm9f15663740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 10:54:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E137FC6057;
        Wed,  8 Apr 2020 10:54:48 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8638EC605D;
        Wed,  8 Apr 2020 10:54:48 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.92.41])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 10:54:48 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id CA57F2E3026; Wed,  8 Apr 2020 16:24:43 +0530 (IST)
Date:   Wed, 8 Apr 2020 16:24:43 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        vaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        skiboot@lists.ozlabs.org, oohall@gmail.com,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 3/3] Introduce capability for firmware-enabled-stop
Message-ID: <20200408105443.GE950@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1583332695.git.psampat@linux.ibm.com>
 <55fa5021e4de901f05ded8b669777711bf2a9724.1583332695.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fa5021e4de901f05ded8b669777711bf2a9724.1583332695.git.psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

On Wed, Mar 04, 2020 at 09:31:23PM +0530, Pratik Rajesh Sampat wrote:
> Design patch that introduces the capability for firmware to handle the
> stop states instead. A bit is set based on the discovery of the feature
> and correspondingly also the responsibility to handle the stop states.
> 
> The commit does not contain calling into the firmware to utilize
> firmware enabled stop.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat at linux.ibm.com>
> ---
>  arch/powerpc/include/asm/processor.h | 1 +
>  arch/powerpc/kernel/dt_cpu_ftrs.c    | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 277dbabafd02..978fab35d133 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -430,6 +430,7 @@ extern unsigned long cpuidle_disable;
>  enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
> 
>  #define STOP_ENABLE		0x00000001
> +#define FIRMWARE_STOP_ENABLE	0x00000010


This could be made a bit in the "version" variable.

> 
>  #define STOP_VERSION_P9       0x1
>  #define STOP_VERSION_P9_V1    0x2
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 63e30aa49356..e00f8afabc46 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -313,6 +313,14 @@ static int __init feat_enable_idle_stop_quirk(struct dt_cpu_feature *f)
> 
>  	return 1;
>  }
> +
> +static int __init feat_enable_firmware_stop(struct dt_cpu_feature *f)
> +{
> +	stop_dep.cpuidle_prop |= FIRMWARE_STOP_ENABLE;

  	stop_dep.cpuidle_version |= FIRMWARE_STOP_V1; or some such
  	variant.


> +
> +	return 1;
> +}
> +
>  static int __init feat_enable_mmu_hash(struct dt_cpu_feature *f)
>  {
>  	u64 lpcr;
> @@ -608,6 +616,7 @@ static struct dt_cpu_feature_match __initdata
>  	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
>  	{"idle-stop", feat_enable_idle_stop, 0},
>  	{"idle-stop-v1", feat_enable_idle_stop_quirk, 0},
> +	{"firmware-stop-supported", feat_enable_firmware_stop, 0},
>  	{"machine-check-power8", feat_enable_mce_power8, 0},
>  	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
>  	{"data-stream-control-register", feat_enable_dscr, CPU_FTR_DSCR},
> -- 
> 2.24.1
> 
