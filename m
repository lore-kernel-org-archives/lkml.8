Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D7E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CXuqsclO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QFyg4UGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgDGQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:07:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgDGQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:07:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037Fsp44031157;
        Tue, 7 Apr 2020 09:06:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=W91KoHI58xicMOG3YTdh1EidIDTlEmxbcjasGpiZ9Ec=;
 b=CXuqsclOQh/mZxtV0AUv30pPp32Zpl7wjT8MVOy5ML/DeIJSr6U2xQ+fEtdn6SZPuSOZ
 FTGb9odq6K75LDACu76UJMg8l3Z6Qj4APvBVnyij38PqvafPES67SORYVRHJZKQ7N/sk
 SQK383Zlx5FIyelfY8NmwCIBVoDPcL83vbQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 307a8wpyah-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Apr 2020 09:06:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 7 Apr 2020 09:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0It3XIs0q4uwt1m22vcuU9jxO354UTkpN3fuoqV+Z6HEvjHCfBYLAuXAIZYHa+wtAXHjoRKp9ShLkzOt/MNBMf20oiVlfoCd7FIcH5UeJeYMELd8b6iiEg4mkpL3prMrkyLz6cehQa+TdBntTpgcQqTq4uXwYHhSTt9Md0eStVuZ/sR68YvVBOUr46onZ9t4oB1ceEVm9izzXP7DFBmD7oqa6lwl5gJkxNmZ+HpRqgEU9YrP8HEYKtZeQRV8uEfdleRmvudnenOgcNNOuwOBHTKTyAT1Ab5di7vjlO4P6WJqWu41ixTpa6mz2vvjbP8ir0T9z5jAxUTqzgynCzcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W91KoHI58xicMOG3YTdh1EidIDTlEmxbcjasGpiZ9Ec=;
 b=LhwuF9iAgx0Ay7oBUsREJGltof/86SrOZKUfdZwnh7YXQLWP3ZIspP8B4bZPRy0xgBQnGiTcbhD2vmJ3mOkYaY4NXeZOHAo7uIkF3QQkihudmEnlAdUHrjM3sA7HzzPDkr9d9f7n/UYE95Puc5KUvDAI+DawD3PTVoQit20ObvWa0nBWePi/27aLMcaPAUQWvLVeRGPIJl1jcZMjUkpb4BGg5+5y+pxxgsiZaAjlaacHcNfUoid4xKra7QEqboWV8+57okoyKE6smPFs2ReBGJ7KPT7VoB44c8prOrOHV2JJZrTkwOA25xjr9c8MPu2p0y4xOG189pxSQhDtEnzgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W91KoHI58xicMOG3YTdh1EidIDTlEmxbcjasGpiZ9Ec=;
 b=QFyg4UGqbEPWOrinbzWO1pGs0GLwZpnwcZHPlJHgpy1zUCBkjNNn1yOB0LwUEiRjORoDUbsjlBMZSfHu3LW9oR6+vnvmvkLzYilj9M6fmQaZCu4kjhi0TwdpLHOapbs2/5wHReq3yqqmZOOfIkXZHEJLq6WhdGm83AdEKR1jTAM=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2952.namprd15.prod.outlook.com (2603:10b6:a03:f9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 16:06:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 16:06:45 +0000
Date:   Tue, 7 Apr 2020 09:06:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Aslan Bakirov <aslan@fb.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH v4 2/2] mm: hugetlb: optionally allocate gigantic
 hugepages using cma
Message-ID: <20200407160640.GA11920@carbon.dhcp.thefacebook.com>
References: <20200407010431.1286488-1-guro@fb.com>
 <20200407010431.1286488-3-guro@fb.com>
 <20200407070331.GD18914@dhcp22.suse.cz>
 <20200407152544.GA9557@carbon.lan>
 <20200407154005.GT18914@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407154005.GT18914@dhcp22.suse.cz>
X-ClientProxiedBy: CO2PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:102:1::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:aff5) by CO2PR04CA0058.namprd04.prod.outlook.com (2603:10b6:102:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 16:06:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:aff5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c00e321-98d2-4fac-1b0a-08d7db0dab2d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB295249A974FE3461365C6BD1BEC30@BYAPR15MB2952.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(4326008)(52116002)(966005)(66946007)(66476007)(54906003)(1076003)(2906002)(66556008)(478600001)(33656002)(316002)(81166006)(16526019)(6506007)(55016002)(6916009)(5660300002)(8676002)(9686003)(81156014)(8936002)(186003)(86362001)(7696005);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJpayBtDUWpG1aKYO5ivYn1WkHxP5egmzJ/zQyVT6EO0wDcFTVgEjrBGI9HgJ+4bt3rZaLau9/EFFsSbE6M7MeSk8Si1OhuFMC9pAjiOBSDij9hLMOA045Ld4ZSnHjyHNaj78coFUNaOn82wPrgjmxoaqjWvq3j5JJgDZIC9BFCzVOSBnPkE1FMuettAZPeUEjQrDhfzYfduVX8GUrVGYcvBhTNBCP4Ok8rgCkSoBMVsCjxPv5h+Tu5+F2Cn0v2IU6w2TZJYvTvFBZ5hblP39Lyf2RiGmtHdDfhVW8DpsmeeZbRXSyiDii2yZPZx9R60DmuldoMybXoB8e6OU0QP38IkWQQDBeMW338RYi9bsL58BkdtmMkqkSe69kPPpWbNOL2rBZYQg798uWy1Uy4IFN0KNXpDsWOsUFiThtfYwLVbLgfzaQUug9PY0jds+XGJ3LLDLeoGu+TOR0RtMKq5l0V+BcfnanqMLebOXRo5HGfRDgwFUzk0HufxTwGqFu+gmSPNcah1LBpvp0PDdgMFGA==
X-MS-Exchange-AntiSpam-MessageData: JtQv4mTcvZvWbgSCX0GVfiWVZMSeD0Nz5X/O5zpiIMgrAdgCulFxvHGDF3WMd6P9DQOB5GHL8UDwTBjwPFpdjJ0gVCdtZGu20m+sEZWao8smd3oNtmYgY/Xcmm45KIiv+o/P30wO7lpilqTL7r14s7xcxpHWIN6oTLRMcDc2VZBhdrX8DQvLuZrxCb2B3LRA
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c00e321-98d2-4fac-1b0a-08d7db0dab2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 16:06:45.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJR0ANAp25+R5+DIMnLFXRVbWYSPsDNIwMlH+6nzGF1BHXHn/r9CBynGNIj8mpp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_07:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=814 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:40:05PM +0200, Michal Hocko wrote:
> On Tue 07-04-20 08:25:44, Roman Gushchin wrote:
> > On Tue, Apr 07, 2020 at 09:03:31AM +0200, Michal Hocko wrote:
> > > On Mon 06-04-20 18:04:31, Roman Gushchin wrote:
> > > [...]
> > > My ack still applies but I have only noticed two minor things now.
> > 
> > Hello, Michal!
> > 
> > > 
> > > [...]
> > > > @@ -1281,8 +1308,14 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> > > >  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > > >  	set_page_refcounted(page);
> > > >  	if (hstate_is_gigantic(h)) {
> > > > +		/*
> > > > +		 * Temporarily drop the hugetlb_lock, because
> > > > +		 * we might block in free_gigantic_page().
> > > > +		 */
> > > > +		spin_unlock(&hugetlb_lock);
> > > >  		destroy_compound_gigantic_page(page, huge_page_order(h));
> > > >  		free_gigantic_page(page, huge_page_order(h));
> > > > +		spin_lock(&hugetlb_lock);
> > > 
> > > This is OK with the current code because existing paths do not have to
> > > revalidate the state AFAICS but it is a bit subtle. I have checked the
> > > cma_free path and it can only sleep on the cma->lock unless I am missing
> > > something. This lock is only used for cma bitmap manipulation and the
> > > mutex sounds like an overkill there and it can be replaced by a
> > > spinlock.
> > > 
> > > Sounds like a follow up patch material to me.
> > 
> > I had the same idea and even posted a patch:
> > https://lore.kernel.org/linux-mm/20200403174559.GC220160@carbon.lan/T/#m87be98bdacda02cea3dd6759b48a28bd23f29ff0
> > 
> > However, Joonsoo pointed out that in some cases the bitmap operation might
> > be too long for a spinlock.
> 
> I was not aware of this email thread. I will have a look. Thanks!
>  
> > Alternatively, we can implement an asynchronous delayed release on the cma side,
> > I just don't know if it's worth it (I mean adding code/complexity).
> > 
> > > 
> > > [...]
> > > > +	for_each_node_state(nid, N_ONLINE) {
> > > > +		int res;
> > > > +
> > > > +		size = min(per_node, hugetlb_cma_size - reserved);
> > > > +		size = round_up(size, PAGE_SIZE << order);
> > > > +
> > > > +		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> > > > +						 0, false, "hugetlb",
> > > > +						 &hugetlb_cma[nid], nid);
> > > > +		if (res) {
> > > > +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> > > > +				res, nid);
> > > > +			break;
> > > 
> > > Do we really have to break out after a single node failure? There might
> > > be other nodes that can satisfy the allocation. You are not cleaning up
> > > previous allocations so there is a partial state and then it would make
> > > more sense to me to simply s@break@continue@ here.
> > 
> > But then we should iterate over all nodes in alloc_gigantic_page()?
> 
> OK, I've managed to miss the early break on hugetlb_cma[node] == NULL
> there as well. I do not think this makes much sense. Just consider a
> setup with one node much smaller than others (not unseen on LPAR
> configurations) and then you are potentially using CMA areas on some
> nodes without a good reason.
> 
> > Currently if hugetlb_cma[0] is NULL it will immediately switch back
> > to the fallback approach.
> > 
> > Actually, Idk how realistic are use cases with complex node configuration,
> > so that we can hugetlb_cma areas can be allocated only on some of them.
> > I'd leave it up to the moment when we'll have a real world example.
> > Then we probably want something more sophisticated anyway...
> 
> I do not follow. Isn't the s@break@continue@ in this and
> alloc_gigantic_page path enough to make it work?

Well, of course it will. But for a highly asymmetrical configuration
there is probably not much sense to try allocate cma areas of a similar
size on each node and rely on allocation failures on some of them.

But, again, if you strictly prefer s/break/continue, I can send a v5.
Just let me know.

Thanks!
