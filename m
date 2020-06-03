Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44455C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122ED20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bO3sAFci";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KlP9QtKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFCOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:15:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgFCOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:15:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 053E9Qwq028336;
        Wed, 3 Jun 2020 07:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FiBUCa1y87rEpo2nb1sqgvjKgbp3KmwUDIsZJE+OOyg=;
 b=bO3sAFciyrHLb7KloO5MO+aL6WMTWGaTW641xjZIL4hrT8P11U2U3fy7OWJ6nFTqtL9k
 nMLNnRIOTaSEFnLtmhcQo5UonH7amYU9xT+sPzMe6menPseHLTcT60gHjCzgQg2ZZvcD
 HqhjHoQbq8DOEfAsvEUaof0Vpzyv5r/LIVU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31bk00hqee-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Jun 2020 07:13:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Jun 2020 07:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrxLDHPrLsvRuyjXdWpY+IhNvoNyGkEZ2GVoRi7keB2GIB1KoW4f9oSmcoyuT/yvX8KsUVu368wAJd4Gi3ed8RKF8LsUkmO5t8K7ZvjP1pQ1hUzNk66HMCaUY3ZgNwubUz17mh75CJzn4ufgZP/4XvITke6f6enF2lC1p4yWGEROgWwuNfcKCGvONHot21bu+uRpYEDEKIbUSUjX9z+gKzFy1fsVye8gc/JuuLolzgN8hC6PjlFTf7F7b2LF10APb/VV/wWu7+UXgxYsDHg35h+8KJGZzx7Vo0VF88gD4x6QsoMeOJ0SXco1fiWSGuGk55+OHSd+j3305+9SUXo1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiBUCa1y87rEpo2nb1sqgvjKgbp3KmwUDIsZJE+OOyg=;
 b=NXtukPCsZqa3Acctkj8Q5KWV63DezEtPzbPmnB6LpcFaG/sv4tcx0sC9lzH+m47dU5pFQr89pVhWwhEShNmiAF9qHEZZdAsJAobU5bkckkEFNLRcay4QOfinLSCUd3RCJIswlKQIC3ByIBVFBPMOrvk219GbFQe2tfPopThqkZBem7mJvjAbhGs4BOeWxpHkFoZZ3z6qJF4j7Bu2Lm+OOBBsTPPzGjeiElX2cZFYjpTRoPrUkJ+hHi/aPsbbqlemwlLdXYO4JwKSjcuIwxCzlbodOaumyDaX9TxY9KpxgjjAcVHIdeVXhsTH5lhW9mUuE9SDM5ahWbgsJl2QNpTzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiBUCa1y87rEpo2nb1sqgvjKgbp3KmwUDIsZJE+OOyg=;
 b=KlP9QtKtmQRuRXxZmOfLzYelbBG5TE+il+VV9Jm1dBTQ/2wQP0qdxU+ChV/vhbSWx/6ZCgPyhknVnw9tcKd2v1S9OyK1YHtARj9NfpaKa/C/masaITMS9Ga4L7x2uY4ycurkiz9HUQzfeWTQksWUox9GBZNBPHHZh1lWTVhFabk=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 14:13:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 14:13:45 +0000
Date:   Wed, 3 Jun 2020 07:13:42 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 2/2] mm: hugetlb: fix the name of hugetlb CMA
Message-ID: <20200603141342.GB559132@carbon.DHCP.thefacebook.com>
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
 <20200603084025.62740-3-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603084025.62740-3-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2a2b) by BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend Transport; Wed, 3 Jun 2020 14:13:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:2a2b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29072879-0060-41eb-865e-08d807c8538a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR15MB259881CD258253F2E6FCCEEFBE880@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+7zxKRgEiamcGzHBVWIj5//ZfFeX03W6uowc5pOza7x8B0bNaGM34xq62o2peJ2SQkxUNIhnDLh3chYAwbQZNxiWZ7SnP6YDeMn0VHecMMTcgB5h2Dek6hNXx5IvXa5bRtbkkjsumP8XmvyM4D7nj+UBJQ2OagDEDeGVo5XdU5s6uuaUjjD69CyDysUMCIzaNMMIsaHNkaMZaszcmiDa2S4GFnEKK4ljzp40lzNfec97CAU5ebc7tOBrDSRy94CK504CsJoIEE37LANARfua2p1QydnPx/dmXnHGbMcQldn4AzFcYY0R9AcK+CaTzUHT/yGzf/fnVGpsnvBhLOSYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(6916009)(16526019)(186003)(6506007)(66556008)(52116002)(7696005)(66946007)(83380400001)(8676002)(478600001)(8936002)(66476007)(2906002)(55016002)(33656002)(4326008)(86362001)(316002)(5660300002)(9686003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: b4iOTasch0vvvyVlz5iOY6+0eRJaG376uijMPaEz0bZPj7e3+5VXRAjaG6EHkeTSQQhUTfBkIoM/YLnjjQ0y7027MapsdW3VDbn1+8fJDKVCyYv2h5A0Lqzg38UCeyXi08lVPR9YnVS/MZrg/zpLOJhP1DgsyoziNcDGiABLscFJ2ZrwaQgS/+enFojyfuYiJAA0T0QJPDC0L7+KkDgnbAlcqqNf0UDsMub5QrUQ5jYQB8VbEfaXVkN2CdiBZzBmf0FLEUvaO3KobBCJB3xQYLWqNGKKvl4b0UOP7jF5QhPVmlDWm2BYiDgvAeJO7M7QY1Z8g8r/Wx6Mqo47GFBGDeDCUqADmRnYZPcm5xbrGFiMusKIt9DA5DOniukdFiCTfcY2HzhMICnG0/8nCI8WF5WmGKejHN4bGVk3LGMz6dmh2/iGWK4Qx5JYoM8FIdPxd3CLNM3GVRXQspGaAy0anV7/Ykg5flIU/kzw0PFxBWC0HyOy5xIPO8OSPDTaWO11lsx2CpDZmUcPuPURcgANsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29072879-0060-41eb-865e-08d807c8538a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:13:45.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTFmg6mthdG59JAVNMV73NjIc1MLuhBzGNtWrZ/wER/Ll6k6Ex3/NNkcUMgBKy26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_12:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 cotscore=-2147483648
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:40:25PM +1200, Barry Song wrote:
> once we enable CMA_DEBUGFS, we will get the below errors:
> directory 'cma-hugetlb' with parent 'cma' already present
> 
> only the first numa node will get a directory in debugfs.
> we should have different names for different CMA areas.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bcabbe02192b..4ebc4edc3b40 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5586,12 +5586,14 @@ void __init hugetlb_cma_reserve(int order)
>  	reserved = 0;
>  	for_each_node_state(nid, N_ONLINE) {
>  		int res;
> +		char name[20];
>  
>  		size = min(per_node, hugetlb_cma_size - reserved);
>  		size = round_up(size, PAGE_SIZE << order);
>  
> +		snprintf(name, 20, "hugetlb%d", nid);
>  		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> -						 0, false, "hugetlb",
> +						 0, false, name,
>  						 &hugetlb_cma[nid], nid);
>  		if (res) {
>  			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> -- 
> 2.23.0
> 
> 
> 
