Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BA7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7B206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XVJBlTCt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XG4viJC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0OmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:42:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727505AbgC0OmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:42:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02REZu69021737;
        Fri, 27 Mar 2020 07:42:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7hEtRLJykbHGto8wyLK0QKqbT3ymv87iGB0eqdADA/g=;
 b=XVJBlTCtzeiLgIKFpRKDIgf7ahOr/1Nm8N6eceqmNk4oOyN45h1SJWYia+ukBBKTvFW8
 DbR+PIUzXnnc1GkJvkYKqvNGdMkrr5y3WCNbDw6ypVIGeCH+LHWDLo8LfmOh+IpP3FCI
 hkrsq5s/tCzvxJ++YgGf9Z8wPvXPYkbkmE8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 301jxw85eu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Mar 2020 07:42:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 27 Mar 2020 07:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGwGq31vD3FTlLXnfhhdDsS26sJO6WFtfI/AFhNhFnhh/ZxQO/wB4gVHcb3GC60TJ5ToOibBlw28THoXE1GLNoCcvtSL5GDfuIQBRxc8Mr5p5DM+sQFPE3qNFDlPCFRortO1JCbB0dV9fFKyQJ1bWiu3Kc2dwrfHQAzp8asy6Xza66MSm/sKy88hVwDrCfeNVBpU2LJXbYQsoob1UyQIJt3bqkk/EFjOZUDpBamxqKlmRY1ykbR5WKWZLPXayvkywdzts6Kcg7ZhL3veM6RTBL+PoJzhB0NttVcWb66fh42GscQtWCal8Nh8IcT1gx4Hq3srIUP4d8wltr6Xo6RxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hEtRLJykbHGto8wyLK0QKqbT3ymv87iGB0eqdADA/g=;
 b=U6EtPqOxDQ9jPZ/TsIywvf/fbHYByZP51EbGGNmiWEdNwjJanOwXxTrIvt2S38sxiieh9EMPSF1/PaiMq6OAds7EBucquAv0+2S4ZolxyI9Mf4+lBs1paeh6h5Yg3pY0oTQJnthAz+edmKvnXk5iO9k36O71GoaZDRNZ4UfzqoptM8afZFKVtwoxtUip2sTLWdFMr/PEbigGAqBZfA2oNsEP0GcgdANiE16R6qINddju1n64s+IA4k36BnfXmwdQZaHPSMzxsOc28Txj5vBWehEDTRmgQ8tjKN4PhsHDWnqUCHlHTIXUj5YzDRhwfkGQlz0kxycG7BtmSIZcg9LonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hEtRLJykbHGto8wyLK0QKqbT3ymv87iGB0eqdADA/g=;
 b=XG4viJC7EBemYl4dRI6IqQMHqIbnkzlfn2MCH6ArAoV/ZgroB2y8pdIersIanp2OzqGFvC9FlwPIJ78xzLOjHulXhwjSZdo0ztFsYIWDbI5SSI+ybJsAeSkoZRUqP4Inf0o7u7RWFtWuPB8Gn9XrnbazDVjmMaEt5UFP7CdPaGk=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2600.namprd15.prod.outlook.com (2603:10b6:a03:150::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 14:42:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 14:42:00 +0000
Date:   Fri, 27 Mar 2020 07:41:55 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Aslan Bakirov <aslan@fb.com>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <riel@surriel.com>, <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Message-ID: <20200327144155.GA194089@carbon.DHCP.thefacebook.com>
References: <20200326212718.3798742-1-aslan@fb.com>
 <20200326212718.3798742-2-aslan@fb.com>
 <20200327080610.GV27965@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327080610.GV27965@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:300:117::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:56f3) by MWHPR03CA0013.namprd03.prod.outlook.com (2603:10b6:300:117::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Fri, 27 Mar 2020 14:41:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:56f3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825c2b90-7074-4df3-1664-08d7d25d01b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB260029AF1B6971F608FAF3EBBECC0@BYAPR15MB2600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(66476007)(66556008)(66946007)(186003)(16526019)(4326008)(33656002)(5660300002)(55016002)(7696005)(52116002)(2906002)(478600001)(316002)(8676002)(6916009)(8936002)(9686003)(6506007)(6666004)(81166006)(86362001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2600;H:BYAPR15MB4136.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x06egVOX/Zq2BKEEvuGqQr6ISxmdf7s9sNgdMocqboOvke+JQjd5SMZ+EJRGA1E04TNsAyV4iOIU629HmhEEW9ce9nX4/4DsRRhwAf6s8qoy7U5L084aAtUbs/3ab0aJXfchblXI5uUb3ECy2IpjrlxM/M5+sgidqsvetU/pVIEnfLZExXd1xXCugHDoCcxFKqNRufUhOmZ/GpdGvWVc1qS5S753CUQVgzkEwHEkLlnxvzMeeerupyC+/3Zo6fwtL0pJpS1qI78K0Kj177XKA+AS3hOnSyWGxpJ9UK5fEVuF3HRgbqBntsxCndA6FtSxEP+nh4pOfjjZuo1wYLFHKaaoeLTuwp271wUB2yM4yn+n9eEYVrzBRSVm9XfRRxxp0nBcemtaIucuPtxwnmmf46ZRc/hSSa3qvS07zmoD4SwWwxil1MuWvcjm3c4ygGOQ
X-MS-Exchange-AntiSpam-MessageData: 1wQRyrMD4ZPTvoAPA/isksdg5b/hMlclhtSRBRJZIwVAWLlZgL8qq42kby7ndT0VZ2lFCw35sMLnnKOmGk2YbYbOXi/VkUkgbtB8Krgsr8HQRGd0jVQEYeWA+BA/qHQJMmJ6GC75wAbjLb+uX2o3SG9QZyu4FI142hFFPsyH7epaMdZcAYeb7EFMxyJuin7T
X-MS-Exchange-CrossTenant-Network-Message-Id: 825c2b90-7074-4df3-1664-08d7d25d01b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 14:42:00.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wieQkKK1l7khvSj30wDdZjNTPQxANH+1jEgjJKyFqfCC1s5BeHQKg1X6W6cac6Cm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2600
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_05:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:06:10AM +0100, Michal Hocko wrote:
> On Thu 26-03-20 14:27:18, Aslan Bakirov wrote:
> > With introduction of numa node interface for CMA, this patch is for using that
> > interface for allocating memory on numa nodes if NUMA is configured.
> > This will be more efficient  and cleaner because first, instead of iterating
> > mem range of each numa node, cma_declare_contigueous_nid() will do
> > its own address finding if we pass 0 for  both min_pfn and max_pfn,
> > second, it can also handle caseswhere NUMA is not configured
> > by passing NUMA_NO_NODE as an argument.
> > 
> > In addition, checking if desired size of memory is available or not,
> > is happening in cma_declare_contiguous_nid()  because base and
> > limit will be determined there, since 0(any) for  base and
> > 0(any) for limit is passed as argument to the function.
> 
> This looks much better than the original patch. Can we simply squash
> your and Roman's patch in the mmotm tree and post it for the review in
> one piece? It would be slightly easier to review that way.

I'm glad you liked it! I agree, it's much nicer now, thanks to Aslan!

I think it's simpler to keep it as a separate patch, because there was
already a fix by Randy Dunlap on top of my original version.

> 
> > Signed-off-by: Aslan Bakirov <aslan@fb.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> 
> Thanks!
> 
> > ---
> >  mm/hugetlb.c | 40 +++++++++++-----------------------------
> >  1 file changed, 11 insertions(+), 29 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index b9f0c903c4cf..62989220c4ff 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5573,42 +5573,24 @@ void __init hugetlb_cma_reserve(int order)
> >  
> >  	reserved = 0;
> >  	for_each_node_state(nid, N_ONLINE) {
> > -		unsigned long min_pfn = 0, max_pfn = 0;
> >  		int res;
> > -#ifdef CONFIG_NUMA
> > -		unsigned long start_pfn, end_pfn;
> > -		int i;
> >  
> > -		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > -			if (!min_pfn)
> > -				min_pfn = start_pfn;
> > -			max_pfn = end_pfn;
> > -		}
> > -#else
> > -		min_pfn = min_low_pfn;
> > -		max_pfn = max_low_pfn;
> > -#endif
> >  		size = min(per_node, hugetlb_cma_size - reserved);
> >  		size = round_up(size, PAGE_SIZE << order);
> > -
> > -		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
> > -			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu MiB\n",
> > -				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
> > -					   nr_online_nodes / 2 / SZ_1M,
> > -					   PAGE_SIZE << order));
> > -			break;
> > -		}
> > -
> > -		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> > -					     PFN_PHYS(max_pfn),
> > +		
> > +		
> > +#ifndef CONFIG_NUMA
> > +		nid = NUMA_NO_NODE
> > +#endif		
> > +		res = cma_declare_contiguous_nid(0, size,
> > +					     0, 
> >  					     PAGE_SIZE << order,
> >  					     0, false,
> > -					     "hugetlb", &hugetlb_cma[nid]);
> > +					     "hugetlb", &hugetlb_cma[nid], nid);		
> > +
> >  		if (res) {
> > -			phys_addr_t begpa = PFN_PHYS(min_pfn);
> > -			phys_addr_t endpa = PFN_PHYS(max_pfn);
> > -			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap)\n",
> > -				__func__, res, nid, &begpa, &endpa);
> > +			pr_warn("%s: reservation failed: err %d, node %d\n",
> > +				__func__, res, nid);
> >  			break;
> >  		}
> >  
> > -- 
> > 2.17.1
> 
> -- 
> Michal Hocko
> SUSE Labs
