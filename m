Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC58C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A2220578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LONxmosZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kg+m5Rlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgICQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:30:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgICQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:30:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083GUQ8n019333;
        Thu, 3 Sep 2020 09:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/2jTAcGcMxeiliglYl1Xk16PK2VsIgyV+hfP1Vo9Uw0=;
 b=LONxmosZzVDAhD6dFYprRy5EbOzZ2o4T2joKMMnNraPTgSeOA5CCyAJ31O8YLejJzejU
 3a9Kws0A09HNd5yCf8evmlqOMFY8pDm6dqkR0mE8J1cIfCZj8Z23VsqQh+d2NnzzqyLV
 bAkGsrTtcifgqWDAQz2XrGBV38nUfsW/7m8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 339ws4kd0v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Sep 2020 09:30:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 09:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bepAiNuOq1llrZSieIPxGb37QhgVamRSBNH0CrKWd/s76AJY1j2QZ4cSE/pJREMJaA1It25Hl9rp8PaQuUVaiBrolPDDNSER/35rFJZ1DARV8XFi77sMAt35s3ztWiGfRWb3KyDMb8V9LpFG2jbhMHWyyzpMCfFzcHsDc7EGNGxz+9c14Bm0pS8eQGcwPe2gJodTDjeeoYI4EPBSVfH39G4NjCpGCYGDJ1tyqBed7U3afeqI/yzWYqlFhiPmy0vhXu7XyKuovxzYoGfiAzS3mptScZ3zFJqpSne98br5qQvOcx9ceZMeQFyaneXGNUToMmiDLYOD+ynoVeBhABDmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2jTAcGcMxeiliglYl1Xk16PK2VsIgyV+hfP1Vo9Uw0=;
 b=jxPNG5VLS8XT1el7s6WYoiLT36WDLGviy07BA1LOQc/PwcpbZXrjwxv4QwDBszu6sU0zqNJZE/jhq1f9K2JLw5y4wpGxs/5LDfGg/grMRBpr3ZOSVHcKgax/D6hm7AXh893ZWNyydq0ej57CX2FoCWFX8glOeHEHv+dWaLdoundi3OaPkEQ2kZsKrULHXqnam1dvtrsNzvoTYiQO/mpJLaS2Flheycci+vv7aT9AuqPd+eJmJ14P3TcH4dYEbnCWomIDkQbNFn3bLUVjDVjyYC+JjJgh52YZjlQUrRcUywZwdQEGszdawmTCxL296MXNCxsK+hja409+eDSayAHeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2jTAcGcMxeiliglYl1Xk16PK2VsIgyV+hfP1Vo9Uw0=;
 b=kg+m5RlqYi9PH56U4XFuLsdaUtwTwZKVgA1u5s6VZcPQAkp3+0c8CCbWY5xGAPZdFlIRM0K84R67AoaHpM+YyAev9r2ABz6pQzbN2CJVjyfw9I5DORZ+3hxVkfrl3O3j0HVKYWydlbeZ229gOcEXIefZzeeyJ/GyT50GqSjKN/Q=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2517.namprd15.prod.outlook.com (2603:10b6:a03:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:30:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:30:23 +0000
Date:   Thu, 3 Sep 2020 09:30:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142300.bjq2um5y5nwocvar@box>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 16:30:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:c00a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cadf02f-bb5f-4bf8-1f7e-08d85026a7f2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2517:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2517BB190B5E36D562D9A530BE2C0@BYAPR15MB2517.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlP8ZvM65FrpR54zie1SjCv05TkYwVm8OY/FH5c5LRVyQ7ShsAhobjoxNYPdZST8weMRuJYRjrV0mwFh+lfMSfNRwbTMbz9cNOZT1KdzuNtfRD/lRPpnMLUYAn9zbe5rzjQfSK8Yq+6vTSrJuoAjaPPRF0yVbX+vQoEU0i2J0GnPqM/3yAAmevX927VJBINbUvCnRMe1cVsQlmuPM4V+MHIM97RdSKpIb5JchRWJh7g5xonyWUiim8H6dyFCJCu7z4XVOAZPM2KldUMzc3DQW5Q4Alnu/QhEXA0+YyKqx1+S6LTd8FS4rC8mIyd0b1a17PClVYidhOn8lVkPCu0XbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(956004)(83380400001)(6486002)(2906002)(1076003)(316002)(186003)(7416002)(86362001)(54906003)(16576012)(4326008)(8936002)(8676002)(52116002)(9686003)(5660300002)(66946007)(66476007)(478600001)(33656002)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5BCaaMkW7hx0nCcqA3mqsM33ythU0XceOLTt8zCgUAdLIvWd9WoV07uT7sG1nMcFCL3KWB3KKI7RfUdeNcqmmINZViPngK1RehJBhTAU48GY8/TzOLc0f/9jpf/8OAXsZ/ajRkksBTF0UMlaf+ppTiOOpNzo/bVc2wfnjltUepN+EG0AbtHqqgugyRJZK9/I1fYc4hwvVdMoT52x/T+6Dbv39VuOkf8J/UPujQDUFXaQjzdkqil0naA1VOZmS8b5r0OyqYJkOxkDpM2RLKHWqbw9dpboF/pH+WoplweaLL01tlbb8hDx1j0hOvem+fDEpfoOk9mxFiCpNtH12b3OyzBq0/Eg1/rOw5iNu3wHbY3Ip3mL/DJ2Nb4tUzk4q5lPmn6x8xDJYSp8kQeZ1VdB7MYmUJwUFuXblRhuxElxwtD9uamg6G0AIJnYBU96ZK5OvKO7s1BoFdRwXfprRKAyY0kY7KVtH1Zh5ke5lORHBl7HrQodNNU9FMPVoBb9oRpYLvRJ6fB4FBPfbdgDTSUCvgY9FZ3T8OyV0s4mIA+NZb7bXRcnzTvBvmCpPsbKzhkRAhTGgP/Ncygwn2VSWnue4zidulJlXBvcb5rcGQqhHzahZLwqUXD6XuXRWmXX5FjO52kzpG0S2H8MKH9CZT8is3y+atfjR18naCyA5J/VSng=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cadf02f-bb5f-4bf8-1f7e-08d85026a7f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:30:23.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DACe01wUPMGieOTKZckxcIc+hoTa8VLzvmznxM95JAPzbDs93AP+JDogNFsa0QIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_10:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=5 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 05:23:00PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> > 
> > Hi all,
> > 
> > This patchset adds support for 1GB THP on x86_64. It is on top of
> > v5.9-rc2-mmots-2020-08-25-21-13.
> > 
> > 1GB THP is more flexible for reducing translation overhead and increasing the
> > performance of applications with large memory footprint without application
> > changes compared to hugetlb.
> 
> This statement needs a lot of justification. I don't see 1GB THP as viable
> for any workload. Opportunistic 1GB allocation is very questionable
> strategy.

Hello, Kirill!

I share your skepticism about opportunistic 1 GB allocations, however it might be useful
if backed by an madvise() annotations from userspace application. In this case,
1 GB THPs might be an alternative to 1 GB hugetlbfs pages, but with a more convenient
interface.

Thanks!

> 
> > Design
> > =======
> > 
> > 1GB THP implementation looks similar to exiting THP code except some new designs
> > for the additional page table level.
> > 
> > 1. Page table deposit and withdraw using a new pagechain data structure:
> >    instead of one PTE page table page, 1GB THP requires 513 page table pages
> >    (one PMD page table page and 512 PTE page table pages) to be deposited
> >    at the page allocaiton time, so that we can split the page later. Currently,
> >    the page table deposit is using ->lru, thus only one page can be deposited.
> 
> False. Current code can deposit arbitrary number of page tables.
> 
> What can be problem to you is that these page tables tied to struct page
> of PMD page table.
> 
> >    A new pagechain data structure is added to enable multi-page deposit.
> > 
> > 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
> >    and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
> >    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
> >    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
> >    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
> >    page[N*512 + 3].compound_mapcount.
> 
> I had hard time reasoning about DoubleMap vs. rmap. Good for you if you
> get it right.
> 
> > 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
> >    to use something less intrusive. So all 1GB THPs are allocated from reserved
> >    CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
> >    THP is cleared as the resulting pages can be freed via normal page free path.
> >    We can fall back to alloc_contig_pages for 1GB THP if necessary.
> > 
> 
> -- 
>  Kirill A. Shutemov
