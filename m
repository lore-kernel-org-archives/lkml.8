Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54167C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE4D206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WO701ktw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Hc7tpuD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgDMQgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:36:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731558AbgDMQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:36:33 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03DGZGwM005651;
        Mon, 13 Apr 2020 09:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JM1MHwQ8iffjjEnw/2k7DgVnTwAUyXSKeCI+IcTfUL4=;
 b=WO701ktwHuVyOMpsvXLEafzX3KsM5SDjz3aYk+fTBpitSCOEIAh8BeM9XhFlry7NQS6F
 AGrInGCvrrILySRAy93zmx4cSMlz1JCNQ8a2/IUrb9kOijnq+ZVq3yXe9jxcsG478MDd
 wAiD+JCtDSzgVB++3W3WYBAVE0W5nYIeqqY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30bwwpdhwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Apr 2020 09:36:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 13 Apr 2020 09:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIHpuqW+qdUXoEiNCH2DRhwvnMm2aQ8nX1yh5Bivjt+S0BdxN2QSRTyJq6KFcQROEGnR65SUuVZJiX+MCjYCbZW8qujXVg7XfMbAw5rCCf05EJxRehPxQdrWfp7WyvlumZLktNtF5h6jYYG7GOvWFAcrFm7P85WHoEcijS1kJDYBO4TldrHnsiHLXxEZpbFSGYg3sjg3TSiEaLUVogBil1fGiXM5C3wcNWJbea1LOjSaYwRSsV3cRNGoaTgc1cb/MpjEVfqS9ynOCUS7r/b8k8LCzPk0c0vURW664GWnF0uFimp7D7XnCLGJyqpivuQHadGz/NBM5fnKlGphJ5vbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM1MHwQ8iffjjEnw/2k7DgVnTwAUyXSKeCI+IcTfUL4=;
 b=eAK7N83bPE9Zpo9DUtGjtl7PguHjPn/E0ENTon/EOMffhiPk9j/MNT4RwI7utHkFeHTHJPnZvrXXHm2+g0xDDLCVXC0BmaCf+mCRYXBTeurGP6M2SUTPgwMcTY6PD1X56ym6hlBveXSFQ1LxTqMbcMWEPYyu+phhT0IhhKDGXMCOgB2U2fkhWJGyuiEww9OpOXAhsXJpB7qF+Hs6CmpuOt1jbfH+67sJpxoac4ggwarIYpfOqBLFWPCrxtsEo7HbQdnwqJPXkvUlhZLhViKT8RWgemP4DHwFPYe6oHl7IDMlmBfQ/fnLwxkdF4uMhW6fxrxk2XvHzFJe7LaLOOwpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM1MHwQ8iffjjEnw/2k7DgVnTwAUyXSKeCI+IcTfUL4=;
 b=Hc7tpuD3VgtbKkoa1eOEy+SL4bq4npZluqpIWb0ylebECOKglurIKtjYZjHjITn2ntWRqNk15yo28XeY7BcEG76DcYVsPCPG4gKXuJzEF0sPer9hFRpaCMT62HzTk+XgPsEFz/d1MBInAi1i9I8AyNoQfywq2CEgi+TBxMxNZdc=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3189.namprd15.prod.outlook.com (2603:10b6:a03:103::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 16:36:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 16:36:12 +0000
Date:   Mon, 13 Apr 2020 09:36:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
Message-ID: <20200413163608.GA42877@carbon.lan>
References: <20200408194119.1076232-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408194119.1076232-1-guro@fb.com>
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:1979) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 16:36:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:1979]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16771062-102d-4c4e-87c0-08d7dfc8c6f1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3189DAA9511351309F1A9AEABEDD0@BYAPR15MB3189.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(55016002)(1076003)(9686003)(33656002)(2906002)(4326008)(66946007)(66556008)(8886007)(6916009)(66476007)(316002)(54906003)(6506007)(186003)(5660300002)(478600001)(8936002)(81156014)(7416002)(86362001)(16526019)(36756003)(7696005)(8676002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCi1ZoDUCRMRTpmDXiZ+ESKBVvNT47P1IUsP9wT9Qu9q+s4yfXRh/StR2CxHPmNTmcOjJYDA45gq8O3p/Wp2JIEGCZ3qwMEGF7YITa1MVd+LTRFCuOtQiFmqEMeB6wNU0LDEa87jb7ThtHGh5CEavkGvEzz8L76DbBlxyHvi96iA71vA99/tW/L2OIUReW4wSTOI0hxi0LSitgO5UEw/FMkUuMEgmDTqsUZeGchL+7LCZxQKXrtWQu9DM/fdwyMfLAcaak9skJfEN1HxCjw9SJVvjORJ5DEB3hot8OJgZQZtAhqZX70ieZvvTZ/bHSV80wdWlmv5XRyvWafrO99B0mWhX/EPsbMj/ClrB1Qp+WKs5a4wBbSJWu1qyRgYf+y/LkWevDOgLAnLMs9LxMsqp2eDhgP1waOSem5WYCnnKp06AO0L+04G09erDM53AHMt
X-MS-Exchange-AntiSpam-MessageData: IfXbgp4jhTc8pujBIG4Ib616Kb7sI072kKk0cF/WySCZHkeFup1fHKUNjPnA7Af+rWctZuxzn5YdTH2wAaSI89+ziD8Fd3kcRn3YgpZHGH0sB440J/+DWakn5opS17cYa2KutIUPg2GNm5ZA29Raabqh3/jPhDuRofsW3s+Wt5g1XrxfDJg3Mcg767nOsTRb
X-MS-Exchange-CrossTenant-Network-Message-Id: 16771062-102d-4c4e-87c0-08d7dfc8c6f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 16:36:12.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAFwCbGTDnxMyIfjgnnUc3iUD/IgA8LkENNFGmWTBeeZvJz+jMuX8wnOP2gXBUTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_08:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=871 malwarescore=0 suspectscore=1 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130128
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:41:19PM -0700, Roman Gushchin wrote:
> Compaction does treat cma pageblocks on pair with any movable
> pageblocks. It means it can easily move non-cma pages into a cma zone.
> 
> It can create problems for the cma allocator.
> 
> The particular problem I'm looking at is related to btrfs metadata
> pages, which are allocated without __GFP_MOVABLE, but beside that
> are generic pagecache pages. In fact, they are sometimes movable
> and sometimes not, depending on whether they are dirty and also
> on the extent buffer reference counter.
> 
> Compaction moves them to the hugetlb_cma area, and then sometimes
> the cma allocator fails to move them back from the cma area. It
> results in failures of gigantic hugepages allocations.
> 
> Also in general cma areas are reserved close to the end of a zone,
> and it's where compaction tries to migrate pages. It means
> compaction will aggressively fill cma areas, which makes not much
> sense.
> 
> So to avoid it, let's preserve non-cma pages from being moved into
> a cma area. Because cma areas are usually quite large and the number
> of areas is small, it should not significantly affect the memory
> fragmentation.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Friendly ping... Any thoughts, comments, ideas?

Thanks!

Roman
