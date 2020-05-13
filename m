Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9566FC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B544205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEMD6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 23:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgEMD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 23:58:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D3X5Wc176373;
        Tue, 12 May 2020 23:58:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31016kc7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 23:58:34 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D3c6bc001878;
        Tue, 12 May 2020 23:58:33 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31016kc7kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 23:58:33 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D3oXsm022961;
        Wed, 13 May 2020 03:58:31 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3100ubufx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 03:58:31 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04D3wUsU26083764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 03:58:30 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D40F4136051;
        Wed, 13 May 2020 03:58:30 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD37136053;
        Wed, 13 May 2020 03:58:30 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.3.99])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 May 2020 03:58:30 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id A336A2E46A4; Wed, 13 May 2020 09:28:26 +0530 (IST)
Date:   Wed, 13 May 2020 09:28:26 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 2/3] powerpc/numa: Prefer node id queried from vphn
Message-ID: <20200513035826.GB5710@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200512132937.19295-1-srikar@linux.vnet.ibm.com>
 <20200512132937.19295-3-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512132937.19295-3-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 cotscore=-2147483648 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:59:36PM +0530, Srikar Dronamraju wrote:
> Node id queried from the static device tree may not
> be correct. For example: it may always show 0 on a shared processor.
> Hence prefer the node id queried from vphn and fallback on the device tree
> based node id if vphn query fails.
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
> Changelog v2:->v3:
> - Resolved comments from Gautham.
> Link v2: https://lore.kernel.org/linuxppc-dev/20200428093836.27190-1-srikar@linux.vnet.ibm.com/t/#u
> 
> Changelog v1:->v2:
> - Rebased to v5.7-rc3
> 
>  arch/powerpc/mm/numa.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b3615b7..2815313 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -719,20 +719,20 @@ static int __init parse_numa_properties(void)
>  	 */
>  	for_each_present_cpu(i) {
>  		struct device_node *cpu;
> -		int nid;
> -
> -		cpu = of_get_cpu_node(i, NULL);
> -		BUG_ON(!cpu);
> -		nid = of_node_to_nid_single(cpu);
> -		of_node_put(cpu);
> +		int nid = vphn_get_nid(i);
> 
>  		/*
>  		 * Don't fall back to default_nid yet -- we will plug
>  		 * cpus into nodes once the memory scan has discovered
>  		 * the topology.
>  		 */
> -		if (nid < 0)
> -			continue;
> -		node_set_online(nid);
> +		if (nid == NUMA_NO_NODE) {
> +			cpu = of_get_cpu_node(i, NULL);
> +			BUG_ON(!cpu);
> +			nid = of_node_to_nid_single(cpu);
> +			of_node_put(cpu);
> +		}
> +
> +		if (likely(nid > 0))
> +			node_set_online(nid);
>  	}
> 
>  	get_n_mem_cells(&n_mem_addr_cells, &n_mem_size_cells);
> -- 
> 1.8.3.1
> 
