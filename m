Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B82720757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRPWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:22:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgCRPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:22:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IF2kHf011811
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:22:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8adbhmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:22:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <svaidy@linux.ibm.com>;
        Wed, 18 Mar 2020 15:22:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 15:22:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02IFM65d64749614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 15:22:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B628311C04C;
        Wed, 18 Mar 2020 15:22:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BA9411C054;
        Wed, 18 Mar 2020 15:22:04 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.107.162])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Mar 2020 15:22:04 +0000 (GMT)
Date:   Wed, 18 Mar 2020 20:52:02 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        psampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: Re: [PATCH v5 2/3] powerpc/powernv: Introduce Self save support
Reply-To: svaidy@linux.ibm.com
References: <20200317141018.42380-1-psampat@linux.ibm.com>
 <20200317141018.42380-3-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200317141018.42380-3-psampat@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20031815-0012-0000-0000-0000039342C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031815-0013-0000-0000-000021D0259D
Message-Id: <20200318152202.GB5273@drishya.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_06:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pratik Rajesh Sampat <psampat@linux.ibm.com> [2020-03-17 19:40:17]:

> This commit introduces and leverages the Self save API which OPAL now
> supports.
> 
> Add the new Self Save OPAL API call in the list of OPAL calls.
> Implement the self saving of the SPRs based on the support populated
> while respecting it's preferences.
> 
> This implementation allows mixing of support for the SPRs, which
> means that a SPR can be self restored while another SPR be self saved if
> they support and prefer it to be so.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>


> ---
>  arch/powerpc/include/asm/opal-api.h        |  3 ++-
>  arch/powerpc/include/asm/opal.h            |  1 +
>  arch/powerpc/platforms/powernv/idle.c      | 22 ++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-call.c |  1 +
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index c1f25a760eb1..1b6e1a68d431 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -214,7 +214,8 @@
>  #define OPAL_SECVAR_GET				176
>  #define OPAL_SECVAR_GET_NEXT			177
>  #define OPAL_SECVAR_ENQUEUE_UPDATE		178
> -#define OPAL_LAST				178
> +#define OPAL_SLW_SELF_SAVE_REG			181
> +#define OPAL_LAST				181
>  
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9986ac34b8e2..389a85b63805 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -203,6 +203,7 @@ int64_t opal_handle_hmi(void);
>  int64_t opal_handle_hmi2(__be64 *out_flags);
>  int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
>  int64_t opal_unregister_dump_region(uint32_t id);
> +int64_t opal_slw_self_save_reg(uint64_t cpu_pir, uint64_t sprn);
>  int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
>  int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
>  int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 03fe835aadd1..97aeb45e897b 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -279,6 +279,26 @@ static int pnv_self_save_restore_sprs(void)
>  					if (rc != 0)
>  						return rc;
>  					break;
> +				} else if (preferred & curr_spr.supported_mode
> +					   & SELF_SAVE_STRICT) {
> +					is_initialized = true;
> +					if (curr_spr.spr == SPRN_HMEER &&
> +					    cpu_thread_in_core(cpu) != 0) {
> +						continue;
> +					}
> +					rc = opal_slw_self_save_reg(pir,
> +								curr_spr.spr);
> +					if (rc != 0)
> +						return rc;
> +					switch (curr_spr.spr) {
> +					case SPRN_LPCR:
> +						is_lpcr_self_save = true;
> +						break;
> +					case SPRN_PTCR:
> +						is_ptcr_self_save = true;
> +						break;
> +					}
> +					break;
>  				}
>  				preferred_sprs[index].preferred_mode =
>  					preferred_sprs[index].preferred_mode >>
> @@ -1159,6 +1179,8 @@ void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>  		if (!is_lpcr_self_save)
>  			opal_slw_set_reg(pir, SPRN_LPCR,
>  					 lpcr_val);
> +		else
> +			opal_slw_self_save_reg(pir, SPRN_LPCR);
>  	}
>  }
>  
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 5cd0f52d258f..11e0ceb90de0 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -223,6 +223,7 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
>  OPAL_CALL(opal_handle_hmi2,			OPAL_HANDLE_HMI2);
>  OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
>  OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
> +OPAL_CALL(opal_slw_self_save_reg,		OPAL_SLW_SELF_SAVE_REG);
>  OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
>  OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
>  OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
> -- 

The new opal_slw_self_save_reg() call and related interface are more
ideal to provide backward compatibility and simplifies implementation
for future platforms.

--Vaidy

