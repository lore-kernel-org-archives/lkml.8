Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C17C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E399A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NVUuYx+Z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LuTVTuVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404123AbgDCPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:10:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403795AbgDCPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:10:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 033EqRMN031461;
        Fri, 3 Apr 2020 08:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=61rf7vfO3xR+W5M+Fk+I1BWiUbEX79Ru2YsSRH+BWwA=;
 b=NVUuYx+Zp+lzp9ieFbtfHQ7mY/lDjhPt5WUCw0bWozrFFMqVUtH8HOCWvQ+89xNWgC7B
 efpkeJmr4kNHCohCHnrE5QBK3s4eGE8HRe6kKUAZ5Hy1CacPpODTmwAFdZ7AMAUOD9fK
 grHvdR10XBkWhu8TLLDj4p28V3rkcIxLmyk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 304wbbkcpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Apr 2020 08:10:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 3 Apr 2020 08:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM0LmYHL5JrONrKi1EDK6zcBXx/+9bakzqOTxQ74LB0cojrAOBSKkd7q56jGxX5vSDsrQE06qCOFfYWDQ8eGKZ8X4vvRjN0Lu3RqTHrH1szUTiZLmtOUYseyGlATVnZkimjRsqFkmFYFGwHVkyGh1bObZ28/J5xwjhkyX/ul4oZSAJI6g0AC+seLP5QyrROW8jupF/EfvYd+oBBSEIKOEYISHPet/83GnYt5EbyzgmD5uV7veaYJQjD6qBen2l7oju8wZ0CUY40yDjww3fTHcyYBrBoi83NTnnn4lGvGLPi0K7Z+Gje5xm9KOwJS8RTzUWbkhGpLMlCesJ/g0wDrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61rf7vfO3xR+W5M+Fk+I1BWiUbEX79Ru2YsSRH+BWwA=;
 b=lnsKRI3musqnZJwdxUJmltKJZwdIrtpq10jIClKSF6IehExGmjYpWtGiaK1H8axPENO3aMPS0GwyimVO8ziR+8377DCnStKcaZg2OEACDd4MXlxPuPinCj/UKZeKvCj4bF1e0Lm3xSnP5gVrZHiVcUswwf3RctsaoAX7g77NisEbhMHC9zNiy5YnImv/xFrgGOlP3Y7gwosGIz3FKY81mc0Ufo6jkbrBY7mAQ9o7wzAC5820KuWKt51mgXvUtO57fo2fpibSyKhv1FDQbY8Dp4BhOJj4P7MZIfOp7PCxD2I8bhf4bUVP8T/due/xM1aD1c6r2JEc3VDlqD2M2PrDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61rf7vfO3xR+W5M+Fk+I1BWiUbEX79Ru2YsSRH+BWwA=;
 b=LuTVTuVGgcSKMJWWI+fyV8Uv2ttOq3nAebyzULwfJ0HBAe6Qqn5voP0CRAR4Yy5Jj1X0piOVLE97tZKSJ8lDabLkvVuKTsLKZrUS+658wX1BHXsQOyfXZO52xJLEkKaid/3XWImDh15wGJAp775nI+yQYpGs8+bj2RRtz2909A4=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2421.namprd15.prod.outlook.com (2603:10b6:a02:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 15:09:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 15:09:58 +0000
Date:   Fri, 3 Apr 2020 08:09:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Aslan Bakirov <aslan@fb.com>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <riel@surriel.com>, <mhocko@kernel.org>,
        <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/2] mm: cma: NUMA node interface
Message-ID: <20200403030424.GA220160@carbon.lan>
References: <20200326212718.3798742-1-aslan@fb.com>
 <65164fdb-38b0-e239-84cc-ab22b92214c5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65164fdb-38b0-e239-84cc-ab22b92214c5@suse.cz>
X-ClientProxiedBy: MWHPR08CA0037.namprd08.prod.outlook.com
 (2603:10b6:300:c0::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:5756) by MWHPR08CA0037.namprd08.prod.outlook.com (2603:10b6:300:c0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Fri, 3 Apr 2020 15:09:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:5756]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a67373-0ae0-4a9e-6215-08d7d7e112d2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24218E2A7C69194E3F46DDAABEC70@BYAPR15MB2421.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(66946007)(1076003)(55016002)(66556008)(498600001)(8936002)(7696005)(9686003)(8886007)(16526019)(6666004)(186003)(6916009)(52116002)(66476007)(86362001)(2906002)(8676002)(81166006)(81156014)(53546011)(36756003)(4326008)(5660300002)(33656002)(6506007)(27376004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ch9em6hVsPkRhiF6IFqBXCWx8hjzG0EZlWDcZ5Jq/94CFB+Woz01TEERiFJBFSNB3qZI/c/zbcy9Ns7xeEllqvYqREjXEZtlUO5Njx+om1l14tcXA1cetbPj+t9LsmDFpPWgO63JG+14maHW2HzRW0NdsW0OA0ZyvyuYW3dhUtjn92uyDFYtq6RwYFf983nkIn58G575Q5+mkgYMVFbrM9BLzGjlXEFXIouAyH0AVhFjBSb1wGnBarTOugobQVHWEzIIrvQjsP9M+JH+fPwTNNvnUeK7XhWq1OYoxnE+hEK4YRT5gYJtUyHlXhcVbSgWC689KTSNz1m2oLn3r3yLE39jJ8oA/zfQzLRoeGxkzr7XrAWH+V8SGENif5MqxCIRmvADt0wwcoA9b94CTEfyvfcQCRcu4hRvBbgAl9ihu3nyE/czE1VqIESivSezgLRgDkLZ4NbR/+p26yUmKV9ZgFnNF2u1jjF71DJxiJconSnU2xomcrkbzxEYUp76e9C
X-MS-Exchange-AntiSpam-MessageData: DYVsmWD0nx3HzCRdZoOASnVWpO0dH9nyqEmGES1HdmmKO6G+01fEPOwTYwGrrig5xQcGnaIVQ+BVW/44rawvkEjZCLY4stxwaoTjZ6G45VMLIFbprZgq8AOpXxY5gvDN4dY/xL/7Wusuln/uugMXmHFQFSdGKdJi/TvLCgJ+QBxE+vtq6T4Gav5jMb8KOv2T
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a67373-0ae0-4a9e-6215-08d7d7e112d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 15:09:58.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl2DDb2kS6ttk1djhKNzNrI60eqn/bluPr8BatWlT0iW4NXetaF8Z+eBY7Nz8zaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_11:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030133
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:48:00PM +0200, Vlastimil Babka wrote:
> On 3/26/20 10:27 PM, Aslan Bakirov wrote:
> > I've noticed that there is no interfaces exposed by CMA which would let me
> > to declare contigous memory on particular NUMA node.
> > 
> > This patchset adds the ability to try to allocate contiguous memory on
> > specific node.

Hello, Vlastimil!

> 
> I would say more explicitly that 'try' here means it will fallback to other
> nodes if the specific one doesn't work. At least AFAICS that's what it does by
> calling memblock_alloc_range_nid() with exact_nid=false.

Hm, maybe we need exact_nid=true for this case? The whole point here is to
have a per-node cma zone, so if it's not possible to allocate one on the
specific node, maybe it's better to just skip it?

> 
> > Implement a new method for declaring contigous memory on particular node
> > and keep cma_declare_contiguous() as a wrapper.
> 
> Should there be also support for using this node spcification in the cma=X boot
> param?

I'd wait for a first real usecase. It's fairly easy to add one, and very hard to remove,
so I'd be conservative here.

Also, in the future we might want to allocate it automatically and shrink on demand.

Btw, thank you very much for gathering all patches for Michal.


Thanks!
