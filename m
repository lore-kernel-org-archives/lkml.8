Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93AA2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C3lsODew";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UeAiZXWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgDGP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:26:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9280 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbgDGP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:26:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037FJVAE022811;
        Tue, 7 Apr 2020 08:25:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ov0JJBn8SuoSDprUs0ICLQsf381cjMDXy6+AsMOcd6I=;
 b=C3lsODew9Re9uIioUoXrUhNSRySZbUx/quk7zVHJzepQGL/4MrE1JT0DL+WJ5+h50LD/
 cXjo+uNhHexAM+JRFOVZeKBCtYsMAsEd4xFQ0JV1NcCUKb1+7F0/iAfOVQ/fz3nI2uXc
 LEjIFnCSSFqJaUcYBnhOirSBkbZ5cly0L8Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 308s0j3xy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Apr 2020 08:25:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 7 Apr 2020 08:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPW0trdu8qIVLi/G0NoDH8WrknWbageGnplFcd1Xekm8qJaEwUOmfUjA37P6xI+VEY0s3xaL0bh6BjWDjLsvqaHxJ2jfOTNJb6ukPnwqHlruwjgG5pGtezsISnF/t40yMPfQ7z0tfA/Gk5P7bWQAIMDXv1dvjz/Nnp2rU2l2ReBFHpAjxZ5UPq199TGjvP+AazmDcyNnx0WXccj+y+5na1YAKaHzRjvxJqyw5TgFn32yy4VRapvJDAPlWzXV812H+V9we/4SW7vzEImYpV1a5pIdSi6Hnpqoydoq+Is9PAc5aLN51aR8hP0vWBoBp7Nro6Kw1CNlRRj7wwdb/JKAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov0JJBn8SuoSDprUs0ICLQsf381cjMDXy6+AsMOcd6I=;
 b=FPKtriUhZTVveMLuYDH3nWYF/JiBvCh0PW66uxeJvSEP+Es/6IAWT7Ok3cqJiWFY7AdmpcqCxlT1r9eDdGM4xgiytAFx/64styNV3oMVXc3vvp6wjFkIpzmdvz2Gmal6A7/8BOpzpqebzwBKz3noTWNHhsaY+20w28LlVhJQJ3gb86AvWb1vt0bDkp7BNJYpWlLvcBYKKBhiRQKkuucjtYH1PV54X4Qg/OWJRT4d5RTUrB449NCZ9liLWe6WkTgL4rKMYb3EtKdb953o08vLIBMZwm6LmfTGv811yZbF0nbynd68cpJpJv51M0d8HuY1EboMcxqjcoYvDvQXGTQBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov0JJBn8SuoSDprUs0ICLQsf381cjMDXy6+AsMOcd6I=;
 b=UeAiZXWDvRDANorbYDdv0SVSFQ0edjye/G56TvzAlnJz4bXKhxvhIxldXg5HTGXhfgIbOGQ4Ef6aua84fd3FqvYAonFhbkIMRDTfPcKUeY/lS2n06wmJjDwAUVAF0ioVHeTWFfwOGqrfmYiNEKLz1GkCz7wntjr6RdPs3S3TNiI=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2197.namprd15.prod.outlook.com (2603:10b6:a02:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 15:25:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 15:25:49 +0000
Date:   Tue, 7 Apr 2020 08:25:44 -0700
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
Message-ID: <20200407152544.GA9557@carbon.lan>
References: <20200407010431.1286488-1-guro@fb.com>
 <20200407010431.1286488-3-guro@fb.com>
 <20200407070331.GD18914@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407070331.GD18914@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:300:95::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d8de) by MWHPR13CA0032.namprd13.prod.outlook.com (2603:10b6:300:95::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend Transport; Tue, 7 Apr 2020 15:25:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:d8de]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d387ef4c-2569-4ae5-1d61-08d7db07f350
X-MS-TrafficTypeDiagnostic: BYAPR15MB2197:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2197BDA4E6ADF10580E0AF0ABEC30@BYAPR15MB2197.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(36756003)(52116002)(186003)(7696005)(66476007)(5660300002)(66946007)(316002)(6506007)(33656002)(4326008)(55016002)(9686003)(54906003)(66556008)(6916009)(8936002)(966005)(6666004)(2906002)(81166006)(1076003)(86362001)(16526019)(8676002)(81156014)(478600001)(8886007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k/dDXLrAy1yHQO9HLztiEwCJRZhmAa/mCJdOa6sQwt2CAHTrqxTcUPXfOkLb9EqDP5deUIgEyWIwAmLRGCk5abXJ+5sUSZZ8haqHJrhOdHByvwKXWgAkftSignlSwNFp9uFMS86UyY2QYA7N8w+5W26TBuKsyGtENLZXbjDUY7jjTULlwjr8tVE61jbV4k5nc0kPf2275BjNKnXAHFWfKPdKZmtfTAgQglG3XFkaKxNy3zBbD+yMT2sS9E3vZDF7R3yZgwxtqE2GrtHANIDvuJcHVKZMGnLGDgxeEFrOHYM7fGukGV12lGa1X1/K4xhKAq7oVeZIg00S3MTa5Y5Wxl5fLPr3dzwpqlN8GOgw0B6brBXGanpF5sVlP506U1RQxchYjEm4XVUBClfWNZM9jOVGPFmde0KNUJxVsEwFKwadHoE19924LPGFegZIsoTUwQBEDCZzsTCikqCJrfc+nC5eemu0K6fZQwAKQdr2G00y1nMbYdqy/bPiadbjDO0vR3TxnjOiVjplj88MoQdJg==
X-MS-Exchange-AntiSpam-MessageData: aLD/H/4E1AiQcucHL4/5j7O6KoicCWeIL6LVgVjVIlnsuOPtb8vncePW27vfrYQvL3LNJ30HLbOEoNGyuFD/w+mheB+PzrTiIO1lLa5EvO4k1Dn4iR3+gQ1rzpZdt/Ii34DSChOQPIB8pP6GJT9Fnl0ZS/Gbls0zdzQCtaOmlZ48S/jV+X7J4sXAoXbYwnp7
X-MS-Exchange-CrossTenant-Network-Message-Id: d387ef4c-2569-4ae5-1d61-08d7db07f350
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 15:25:49.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lliWYoMBqgUIou8BpZX3okJHy/hk06nUvBlXp/XF/u0GP6Geq0KYGoTIVNXHZBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_07:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 phishscore=0
 mlxlogscore=804 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070129
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:03:31AM +0200, Michal Hocko wrote:
> On Mon 06-04-20 18:04:31, Roman Gushchin wrote:
> [...]
> My ack still applies but I have only noticed two minor things now.

Hello, Michal!

> 
> [...]
> > @@ -1281,8 +1308,14 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> >  	set_page_refcounted(page);
> >  	if (hstate_is_gigantic(h)) {
> > +		/*
> > +		 * Temporarily drop the hugetlb_lock, because
> > +		 * we might block in free_gigantic_page().
> > +		 */
> > +		spin_unlock(&hugetlb_lock);
> >  		destroy_compound_gigantic_page(page, huge_page_order(h));
> >  		free_gigantic_page(page, huge_page_order(h));
> > +		spin_lock(&hugetlb_lock);
> 
> This is OK with the current code because existing paths do not have to
> revalidate the state AFAICS but it is a bit subtle. I have checked the
> cma_free path and it can only sleep on the cma->lock unless I am missing
> something. This lock is only used for cma bitmap manipulation and the
> mutex sounds like an overkill there and it can be replaced by a
> spinlock.
> 
> Sounds like a follow up patch material to me.

I had the same idea and even posted a patch:
https://lore.kernel.org/linux-mm/20200403174559.GC220160@carbon.lan/T/#m87be98bdacda02cea3dd6759b48a28bd23f29ff0

However, Joonsoo pointed out that in some cases the bitmap operation might
be too long for a spinlock.

Alternatively, we can implement an asynchronous delayed release on the cma side,
I just don't know if it's worth it (I mean adding code/complexity).

> 
> [...]
> > +	for_each_node_state(nid, N_ONLINE) {
> > +		int res;
> > +
> > +		size = min(per_node, hugetlb_cma_size - reserved);
> > +		size = round_up(size, PAGE_SIZE << order);
> > +
> > +		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> > +						 0, false, "hugetlb",
> > +						 &hugetlb_cma[nid], nid);
> > +		if (res) {
> > +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> > +				res, nid);
> > +			break;
> 
> Do we really have to break out after a single node failure? There might
> be other nodes that can satisfy the allocation. You are not cleaning up
> previous allocations so there is a partial state and then it would make
> more sense to me to simply s@break@continue@ here.

But then we should iterate over all nodes in alloc_gigantic_page()?
Currently if hugetlb_cma[0] is NULL it will immediately switch back
to the fallback approach.

Actually, Idk how realistic are use cases with complex node configuration,
so that we can hugetlb_cma areas can be allocated only on some of them.
I'd leave it up to the moment when we'll have a real world example.
Then we probably want something more sophisticated anyway...

I have no strong opinion here, so if you really think we should s/break/continue,
I'm fine with it too.

Thanks!
