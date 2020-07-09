Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E27C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710C0205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGIK61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:58:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgGIK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:58:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069AW0U8138271;
        Thu, 9 Jul 2020 06:58:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325uqvagpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 06:58:04 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 069AevYf178504;
        Thu, 9 Jul 2020 06:58:04 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325uqvagpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 06:58:04 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069AtYQI030714;
        Thu, 9 Jul 2020 10:58:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 325k1nq01p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:58:03 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069Aw2bU52494804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 10:58:02 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20AE8BE054;
        Thu,  9 Jul 2020 10:58:02 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B36F6BE051;
        Thu,  9 Jul 2020 10:58:01 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.58.93])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 10:58:01 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 4DCB62E2EB8; Thu,  9 Jul 2020 14:31:11 +0530 (IST)
Date:   Thu, 9 Jul 2020 14:31:11 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [PATCH 1/2] powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on
 P9 and above
Message-ID: <20200709090111.GA24354@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200703124640.42820-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703124640.42820-1-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_05:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007090079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 06:16:39PM +0530, Pratik Rajesh Sampat wrote:
> POWER9 onwards the support for the registers HID1, HID4, HID5 has been
> receded.
> Although mfspr on the above registers worked in Power9, In Power10
> simulator is unrecognized. Moving their assignment under the
> check for machines lower than Power9
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Nice catch.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 2dd467383a88..19d94d021357 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -73,9 +73,6 @@ static int pnv_save_sprs_for_deep_states(void)
>  	 */
>  	uint64_t lpcr_val	= mfspr(SPRN_LPCR);
>  	uint64_t hid0_val	= mfspr(SPRN_HID0);
> -	uint64_t hid1_val	= mfspr(SPRN_HID1);
> -	uint64_t hid4_val	= mfspr(SPRN_HID4);
> -	uint64_t hid5_val	= mfspr(SPRN_HID5);
>  	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
>  	uint64_t msr_val = MSR_IDLE;
>  	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
> @@ -117,6 +114,9 @@ static int pnv_save_sprs_for_deep_states(void)
> 
>  			/* Only p8 needs to set extra HID regiters */
>  			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
> +				uint64_t hid1_val = mfspr(SPRN_HID1);
> +				uint64_t hid4_val = mfspr(SPRN_HID4);
> +				uint64_t hid5_val = mfspr(SPRN_HID5);
> 
>  				rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
>  				if (rc != 0)
> -- 
> 2.25.4
> 
--
Thanks and Regards
gautham.
