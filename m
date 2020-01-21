Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A26DC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD71F22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgAUBgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:36:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgAUBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:36:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L1Wt98020992;
        Mon, 20 Jan 2020 20:36:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyeamgq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 20:36:26 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00L1WxBO021260;
        Mon, 20 Jan 2020 20:36:26 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyeamgpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 20:36:26 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00L1aP9f027685;
        Tue, 21 Jan 2020 01:36:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2xksn6dfwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 01:36:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L1aOGc54722824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 01:36:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B549AE060;
        Tue, 21 Jan 2020 01:36:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FBDAAE05C;
        Tue, 21 Jan 2020 01:36:21 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.73.158])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 01:36:20 +0000 (GMT)
X-Mailer: emacs 27.0.60 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        mingo@redhat.com
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        x86@kernel.org
Subject: Re: [PATCH v3 2/6] mm/numa: Skip NUMA_NO_NODE and online nodes in
 numa_map_to_online_node()
In-Reply-To: <157954697957.2239526.17206272633668977957.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157954697957.2239526.17206272633668977957.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Tue, 21 Jan 2020 07:06:18 +0530
Message-ID: <87pnfdd20d.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_10:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Update numa_map_to_online_node() to stop falling back to numa node 0
> when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
> online. This makes the routine compatible with other arch node mapping
> routines.
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Link: https://lore.kernel.org/r/157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/mempolicy.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4cff069279f6..30d76db718bf 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
>  {
>  	int min_node;
>  
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> +	if (node == NUMA_NO_NODE || node_online(node))
> +		return node;
>  
>  	min_node = node;
>  	if (!node_online(node)) {


The above if condition will always be true?

-aneesh
