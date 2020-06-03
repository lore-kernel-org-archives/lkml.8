Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77606C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3B020738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GarUIy3k";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a/R/QDal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgFCOPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:15:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12232 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgFCOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:59 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053EAP7H023260;
        Wed, 3 Jun 2020 07:13:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Gep5SvJR2rB4Fg3lq/X25+siBp6GshutbOP5KX7oYtk=;
 b=GarUIy3kzz0lAqTeEEkni3DOu35+IrvdZ/AEHOl3OVvRGitFekV5oMoLDyTFZ9ubCx6s
 rxxgLMww5MK6eIwOPsS4814QTtE1pHhWAj+20DqKTY7M5yrG+I0MHmFUXe9V+kRBiK6t
 Y8S3eleU16VCU8WapkhIbuOZWVNz/6iwsT4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31bn7q8fnc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Jun 2020 07:13:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Jun 2020 07:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0ATBvNB/83Wfr+TBYEw8qD9TnP1PBEQWmyw/YZ70wRceHlfDRWMXOPNB+zz9dHFjxIUk98Y9SzeOmPzzwDs3DJ/SM7fnx5nVjFZrDwQ831W7qEWVgM7bpp4HKwz/GQjj/NrdnGXPj0XjghAl4hQSA0eRNmzVVz1N3OhrNJ0DQdSSi301WpXWHv9TxBPPAd9yqtcxxyT+eaR09HkfhgjU4QXCFO7Fe3y/ZX7S0wD9JGwkkrxA9Jul6F8TDux4OBAl2XIVLP6iYnm8dTluRCvCO8VGh/jmvQNaAIHBjd9gtrxlWkTqN151RCsrTreWQCCK60s2cOv1stu4ChVQ4PvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gep5SvJR2rB4Fg3lq/X25+siBp6GshutbOP5KX7oYtk=;
 b=NRSAIij/v+EBFMfecaTRdtgMAPTJos+2DMjaWI+KT7WsG1wozi9dWvJwQFFsl2TQPjn+qmPh+Z4YaHrwnAN2IXTlHINPVbDQD0rrlcpj2axNrzXWmgBjKYFu0iH0ADClx9SZXmhN2BUSESUukY6M8XC6V8U4sdzrP480EcLQfEMMYoLMezsYJMCRmdreL4kfxlYWIe4B3oLTrlywF0W267PDCe7Fg5dwrJiOoLiuuc0yH5iCI84WKou3nMK44EVGZqXQkcX5hea+9T5zF6OHv4Hj+/NeRrbd0vo2kZpgWYt9PUpjHaa+G9gAqu6C5TEdBsQP1qKSNQPr3C4NMc6JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gep5SvJR2rB4Fg3lq/X25+siBp6GshutbOP5KX7oYtk=;
 b=a/R/QDal0I5lzegT97qbE8TnVxytNjQC1gNfAB+wTnPjl72KhQieWhYB1LTHSxSKHtrBScL8aZEpsrALYyNRxA/snKOMFaLdDPGihYiZdR1aB+YcawY+bn4dlfcShFP67+uHqC2Rg2hWptE1nCeA0CLtBbLWwegYllicoAwJEmw=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3383.namprd15.prod.outlook.com (2603:10b6:a03:10d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 14:13:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 14:12:59 +0000
Date:   Wed, 3 Jun 2020 07:12:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] mm: cma: fix the name of CMA areas
Message-ID: <20200603141256.GA559132@carbon.DHCP.thefacebook.com>
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
 <20200603084025.62740-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603084025.62740-2-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BYAPR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2a2b) by BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 14:12:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:2a2b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0fb2d0-6533-491a-b97b-08d807c837f3
X-MS-TrafficTypeDiagnostic: BYAPR15MB3383:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3383733ABC9341C9001995ACBE880@BYAPR15MB3383.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw3z4viIu6Twsv15vJVHRaPnetn/qubObKYJIqHeRJds7lpOrZq22kZ5ZTahjp9dFN//9/g6Yvby48xuojSfcFRlcPu4bHubvpX8Qton9h9ty2bECJ+VAaR8zlrJwp6mguGDiIdoon9S7tF0hr0TGhw+z03seTO4hzJoLTBRtHrNZRkfwbyQVEe7dz7tpg6GvYI6Bz3Zxr6qkj9y+M25GkWgRF1w39C4ZPLeAdT4QXXEExRxBS47yy/t77/jHTDH/Un6YHGZvhldtphowH1vDQ0VWaT5NJexWQOjZ0fxYL/CuCoCUeaDtDBfX1T0XIoV5hPkIwgnRZt8dBeLAqgwkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(478600001)(6916009)(316002)(33656002)(8676002)(55016002)(16526019)(9686003)(6506007)(2906002)(8936002)(186003)(1076003)(52116002)(4326008)(7696005)(5660300002)(66556008)(86362001)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: G/cgP8SjwneDbUlvielt5+Also6SYOWTrr/o0twA5+KpHQzotvbKTI+2BwXzhq8iHrFPXprO73ondQtWkjeWAY/cR0sTga1EGWdKwd0OKIBXu973mLBbm4/XHOaCnY5IV7TawK4NNBHEArPolDb48sfwN/uwGATnnrGPXpQfR7F2JBlocnboiuPrbWc6nOjoic3LMjvfR3S9eBSR/Il/FSycJavbA+INcCQVPdsMZzTPGRM5HIZqVStZeBQULrSp+nxOprXp0a1F9R+7R1F6vut5kYS3U57ZRM/aE/bs9POuxubjRzBuY5PDtVAfIigwmvviCxxgkSNgJVsv3gnaNpmmy+TDFcrMbMBaMRwQaTzWDytKbPhb5q6Ar3WSsYvOAhOqVWBjh3D6rsRGayC1gNRBQmIRTwGCP9qyDmpgcJ8c8Ec6inYkFyRVobRRqMucsaEkKSnRjfxmkjQNZ+4dXMcKtdHAhhu34imdnT72pEVVuyRxGBUR5Y8qJ+MazmNyucHtjMBspBotDodE8VhXkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0fb2d0-6533-491a-b97b-08d807c837f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:12:59.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9L1wqPHpSGM7XPD/SHh2Zk6Tpitx1+73Ksb8iM5u3ysywDjx2lo5ILBQPSI8Rix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3383
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_12:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=1
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:40:24PM +1200, Barry Song wrote:
> if users give a name saved in stack, the current code will generate magic
> pointer.
> if users don't give a name(NULL), kasprintf() will always return NULL as
> we are at the early stage. that means cma_init_reserved_mem() will return
> -ENOMEM if users set name parameter as NULL.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/cma.c | 13 ++++++-------
>  mm/cma.h |  4 +++-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 0463ad2ce06b..b24151fa2101 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -202,13 +202,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	 * subsystems (like slab allocator) are available.
>  	 */
>  	cma = &cma_areas[cma_area_count];
> -	if (name) {
> -		cma->name = name;
> -	} else {
> -		cma->name = kasprintf(GFP_KERNEL, "cma%d\n", cma_area_count);
> -		if (!cma->name)
> -			return -ENOMEM;
> -	}
> +
> +	if (name)
> +		snprintf(cma->name, CMA_MAX_NAME, name);
> +	else
> +		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
> +
>  	cma->base_pfn = PFN_DOWN(base);
>  	cma->count = size >> PAGE_SHIFT;
>  	cma->order_per_bit = order_per_bit;
> diff --git a/mm/cma.h b/mm/cma.h
> index 33c0b517733c..27d3f0e9f68f 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -2,6 +2,8 @@
>  #ifndef __MM_CMA_H__
>  #define __MM_CMA_H__
>  
> +#define CMA_MAX_NAME 64
> +
>  struct cma {
>  	unsigned long   base_pfn;
>  	unsigned long   count;
> @@ -12,7 +14,7 @@ struct cma {
>  	struct hlist_head mem_head;
>  	spinlock_t mem_head_lock;
>  #endif
> -	const char *name;
> +	char name[CMA_MAX_NAME];
>  };
>  
>  extern struct cma cma_areas[MAX_CMA_AREAS];
> -- 
> 2.23.0
> 
> 
> 
