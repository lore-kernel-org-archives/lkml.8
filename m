Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAAA2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nayNsTd7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hzP4N36w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEUAij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:38:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbgEUAif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:38:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L0A7Y6032556;
        Wed, 20 May 2020 17:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OJDCENl2bVrZALcEYuofnk4wA2/+n/MWIP+ygeTO5rY=;
 b=nayNsTd7RM7eFu9HxwxNSls4lb+3NBe6FRa5is5ZABkvPCwt7UK84VGWXrAdQQdjgw4X
 FrIKBI7BeQYwMEiNxlGF/dj/JtOR35X3amGn2NEMquTx316toDNWxUxucK++84l61MeD
 8PjM9EY/Hlmb3rCQuVO/KDyO4sIfr+u/Pak= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3152xtq47a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 17:37:34 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 May 2020 17:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVCloC0drTFJPgyXOxCye1CumtVU9mqRnQSouRvsI0UcDE3BB7sG74RbaSIk8jnGOhmN6LiPukr9ynCeGm6b8EAl39hsYajb8TmC6fiJDrWsaszDFbvj4UP1taRjX86qwg/vLZljOuch/0WI+Ef9sGebVcXlWnUDiZeV4HzOWVk8GsHeGJX6Ub4xV9EuMCAP7ZWBeVKpPJ4to8Hq0SL2iZWIGFFL/jb9RZOd2Fp2V+ZenMtIwijX1fOxtYRTdjcl3upLgH/3n2N7F4c4+sMM3XsB/VlczQjT2uuZwcx/cU9yHDSlVOtkbfmkIvdrd62VCp93CyOwxcJhqWJ6X33/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJDCENl2bVrZALcEYuofnk4wA2/+n/MWIP+ygeTO5rY=;
 b=Va8bl9XCBEPqrUWDJfg9hW0knBMlSw4GKOJ0IwJr5z7G46HHurVzPSuilOYiuMzSi02AckRaQy7hKBpD2uAo63Nk0k2tnCHsbkbcW91ptLb5n2Ao7YYvD5hjdNYGX2n3hGjCfzqJpOro7sRBgurqLU7gVpoK0tXaQy8b8qF2n3zgEUlZ0UkCTLxFVZgbtbmPcx+fw4SDvoTIBoZ/AQvhUnFDOO8DV6eVWB1CuNUEJ8iE9hnM63an4B5Hm1hJPZPLMjwZnHGuG3q+YnU/9EBNFMpkZoZFoar3mWPopFb/Gzm9qND0aSXm36M05hrA1y9uH1Ip4IK3+e8GddzKG7RjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJDCENl2bVrZALcEYuofnk4wA2/+n/MWIP+ygeTO5rY=;
 b=hzP4N36w8r4C2s+JD5/8Kct5117jAWGQzp3GkIRRHB/kCDvqSxHSaA9aJfNeel0Xih8pJ2v/5KQs1DCbj6tHWm8s+XLPuL+CSZrzmJr+BoS6B5E//WbLoezxJV9Mx8E8Y4qc1Y1gD9bU4xFrnIZbQCYbRuXDiCzZipZBeqCXdKo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3478.namprd15.prod.outlook.com (2603:10b6:a03:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 00:37:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 00:37:20 +0000
Date:   Wed, 20 May 2020 17:37:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <js1304@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 01/11] mm/page_isolation: prefer the node of the source
 page
Message-ID: <20200521003716.GA317575@carbon.dhcp.thefacebook.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-2-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589764857-6800-2-git-send-email-iamjoonsoo.kim@lge.com>
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bc17) by BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Thu, 21 May 2020 00:37:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:bc17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d54dcf3-eaa5-4ecb-e837-08d7fd1f1ed1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3478:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34781103C99F536DF45C8406BEB70@BYAPR15MB3478.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4NmW5ajeMzdP+c80zyZG9ERHCELP8o/Xnxy/asBoM3dz0dEA0UZNHL+/8/7pcshtzWbHAwfQLPsT/+5FGbRLGblCBWuz7+wVsccf1fQmfa7N6cpy7M/m9eSXoCpLNQFBQ+SEkN4sx/3rz/gM9UQU9E7eJLLr4pEh7SEGtAgNxBAEjxCvdP5Y/XANrfB57SKD1j3tN0yKEVwN4Ntw759nBYJn0073nT1uxe4u9OXtUdRoiBzZexmsHYqMLGfpe39sMuE7fW20ZTMPggIYOCkGIHxh1HN6caf5NC687Fl9SA+us7zzRc+NY05E0N2FuCH2MQfnUX+Pl76LbbanrEaMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(8936002)(316002)(54906003)(6506007)(6666004)(1076003)(66476007)(8676002)(2906002)(55016002)(86362001)(66556008)(66946007)(9686003)(186003)(16526019)(7416002)(4326008)(52116002)(5660300002)(478600001)(33656002)(7696005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uOCSi+dlFpIsQc7zX+ceqQeqom7M1WO6TZZJ3/CqCe/dqILZdqg6dVpKSKG3j7brD7GL/DS/qj9O7uv1EYH2t1zTjHe2LQ0oEphGp0yMiL3733eVeagQE9QFwLS5ASufi/w9wl7hVWvJ6j06EHagryOnsGhOF2ETj5RNlVkVPjL0uQLo1NvPNxRq8AE39Q3yU2k5KWSrN87XHCCExs7MwQ/L+Lz+F+aePTQLo6wRnsmQ2wgUccLK4ASTluzBtOK1D74nE5TtGANJvgKCYmyLJ/35AsleTpeFpRs+vwG4SRzZbX68Act594/VhiG4j2s8gk4bRqENVTST7Vrwl1NAXdV7x6IfML77oJNc+goBq2/PGD3+9kw17sTbwqioJSwDW6pTbDd84oNF0JqJvGR4waZq14mzSNBctv8YOodevZ7B09CyqqNR6ucPmkY5T68iTdKMPQvkBRFlBEinVJBzVVVa72Wkh2HT3HHCNMOTFlaW4s6xcNHMu1oFbdCPm2V46OEOdbE+/gpoHQn6Y3NyQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d54dcf3-eaa5-4ecb-e837-08d7fd1f1ed1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 00:37:20.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJ3GbUkMpYyLtPEv5dR9JcDlxyPPc+ETDvLTFAd1RcMAfVcN0ttpNydiN2TIL4MO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_18:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=3
 cotscore=-2147483648 priorityscore=1501 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=669 lowpriorityscore=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210000
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:20:47AM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> For locality, it's better to migrate the page to the same node
> rather than the node of the current caller's cpu.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/page_isolation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 2c11a38..7df89bd 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  struct page *alloc_migrate_target(struct page *page, unsigned long private)
>  {
> -	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
> +	int nid = page_to_nid(page);
> +
> +	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);

Why not new_page_nodemask(page, page_to_nid(page), &node_states[N_MEMORY]) ?
Still fits into 80 characters.
