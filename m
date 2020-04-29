Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9EC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0E82076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2JKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:10:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2JKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:10:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T95Jaq115608;
        Wed, 29 Apr 2020 05:10:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjy7b303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 05:10:24 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03T95JQD115557;
        Wed, 29 Apr 2020 05:10:24 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjy7b2y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 05:10:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T9ACnL014806;
        Wed, 29 Apr 2020 09:10:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7wkd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 09:10:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T9AJ5p50135132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 09:10:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 109C5AE051;
        Wed, 29 Apr 2020 09:10:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC484AE045;
        Wed, 29 Apr 2020 09:10:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Apr 2020 09:10:13 +0000 (GMT)
Subject: Re: [PATCH v7 5/5] powerpc/hv-24x7: Update post_mobility_fixup() to
 handle migration
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200327063642.26175-1-kjain@linux.ibm.com>
 <20200327063642.26175-6-kjain@linux.ibm.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <55ef7993-fcb3-6bd7-f787-78423f0b302b@linux.ibm.com>
Date:   Wed, 29 Apr 2020 14:40:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200327063642.26175-6-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_03:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 12:06 PM, Kajol Jain wrote:
> Function 'read_sys_info_pseries()' is added to get system parameter
> values like number of sockets and chips per socket.
> and it gets these details via rtas_call with token
> "PROCESSOR_MODULE_INFO".
>
> Incase lpar migrate from one system to another, system
> parameter details like chips per sockets or number of sockets might
> change. So, it needs to be re-initialized otherwise, these values
> corresponds to previous system values.
> This patch adds a call to 'read_sys_info_pseries()' from
> 'post-mobility_fixup()' to re-init the physsockets and physchips values.

Changes looks fine to me.
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/mobility.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index b571285f6c14..226accd6218b 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -371,6 +371,18 @@ void post_mobility_fixup(void)
>   	/* Possibly switch to a new RFI flush type */
>   	pseries_setup_rfi_flush();
>
> +	/*
> +	 * Incase lpar migrate from one system to another, system
> +	 * parameter details like chips per sockets and number of sockets
> +	 * might change. So, it needs to be re-initialized otherwise these
> +	 * values corresponds to previous system.
> +	 * Here, adding a call to read_sys_info_pseries() declared in
> +	 * platforms/pseries/pseries.h to re-init the physsockets and
> +	 * physchips value.
> +	 */
> +	if (IS_ENABLED(CONFIG_HV_PERF_CTRS) && IS_ENABLED(CONFIG_PPC_RTAS))
> +		read_sys_info_pseries();
> +
>   	return;
>   }
>

