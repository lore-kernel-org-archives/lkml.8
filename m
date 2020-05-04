Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F804206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDFG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 01:06:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgEDFG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:06:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04452qkT113557;
        Mon, 4 May 2020 01:05:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s45s686b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 01:05:55 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04454KHg117006;
        Mon, 4 May 2020 01:05:54 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s45s685t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 01:05:54 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04450AvU014136;
        Mon, 4 May 2020 05:05:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 30s0g6e1qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 05:05:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04455qjY50397568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 05:05:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7CD136051;
        Mon,  4 May 2020 05:05:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE7813604F;
        Mon,  4 May 2020 05:05:52 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.125.95])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  4 May 2020 05:05:52 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 379432E3019; Mon,  4 May 2020 10:35:47 +0530 (IST)
Date:   Mon, 4 May 2020 10:35:47 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, tglx@linutronix.de, maddy@linux.vnet.ibm.com,
        cclaudio@linux.ibm.com, zhangshaokun@hisilicon.com,
        atrajeev@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
        ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] powerpc/powernv: Fix a warning message
Message-ID: <20200504050547.GA2783@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200502115949.139000-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502115949.139000-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_02:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On Sat, May 02, 2020 at 01:59:49PM +0200, Christophe JAILLET wrote:
> Fix a cut'n'paste error in a warning message. This should be
> 'cpu-idle-state-residency-ns' to match the property searched in the
> previous 'of_property_read_u32_array()'
> 
> Fixes: 9c7b185ab2fe ("powernv/cpuidle: Parse dt idle properties into global structure")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for catching this.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 78599bca66c2..2dd467383a88 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -1270,7 +1270,7 @@ static int pnv_parse_cpuidle_dt(void)
>  	/* Read residencies */
>  	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-residency-ns",
>  				       temp_u32, nr_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
>  		rc = -EINVAL;
>  		goto out;
>  	}
> -- 
> 2.25.1
> 
