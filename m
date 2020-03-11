Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3035C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65BE20751
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kRRAMfrr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OjBMNSaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgCKXWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:22:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgCKXWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:22:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02BNDB3C015394;
        Wed, 11 Mar 2020 16:21:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kaJWT55L2vIYo1kJJzYQe1iYvUk2XT/+NuGizc9bja4=;
 b=kRRAMfrr8kpKJ55zD8PQJTI/u7Y7ycjYi6Nwmn4djjs6yna5p2U/WScjKSnuzAz4Am0+
 NT+9gYTua/Oxt1kl1qR9Zg77cg+OXXFlnQKDIBd08c4ounPV6zG3M1l6IF2lq0lAHmXr
 23N7M9FIgTjy2HlayFleyDaMn5CqX3yaDcM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2ypkv9dt0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Mar 2020 16:21:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 16:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGrQETu+zCspEzxuFlGkCLDD9jkZ54azHXkyKc+a+uycT8DfYUHNsEu4fQJfOQDcyczntjDSLTILDl53tu64bnLKbELv53sizCcZ1d78oN29sp7wxHl12AYar20GhT2p75+SG6zZ5bMhxJoxXI80QEPmXzDIA5YxjDbhoRwm+JVoCh1BtUIXIvj+B4orUjSmwh1PaftxHHy7oCr7hsDsBM8V1qjnbVifJXM5LAvWCSktfyyaqATXuzS55UlfXH4HY7HWPKu+Qe5y4zLmla+8WLHDshdJOU/3qvGwG9tUpxzbxxL14GzUqluQ+dIwUSED17exxP1gJ9y9Gqi6TbeXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaJWT55L2vIYo1kJJzYQe1iYvUk2XT/+NuGizc9bja4=;
 b=fcPF56pfI2NTJ1tfRyUlak9pcLgzqFGFCK/zMhFl4mz3buLdPudmC1GTUdA9POofudjyC4JQJy9kL2F+bE3oq92CCl9S21oflsf4OQDMnWE9q8Mfr6Twfkh8JdJtYMMiZSthKIAmbKXs0BK92mME+dp+fJZMmxCDcqvBS2gBis+LmoH6o/ukE2U7E7p5zGC25wZfX6SdjLLQiPePv+EMFd/zrS+QrAJ7G9ELUivQW0XbJZY8fSrq63qyy3/v2F5mHs7hgVVMWrSLeRWuKMZT9GNtxe/9b/UapyMM8h/y+Z9VzDctOSj565r4CQMM/yuPw1kadCpTrraiW+PXrOi2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaJWT55L2vIYo1kJJzYQe1iYvUk2XT/+NuGizc9bja4=;
 b=OjBMNSaGWbEKjuVM1p/wh49NXdg5r2w9A4tkkDeXzNv4fwrueUywRVgtfUu2EB3tZjOsqLy9s7+JqX1tPPP8E1R3fxmvNT0FUPiJZ1zugCSU1CiCQcfQEWSNhp7AdfXRRW1AqBolcIK3sg4gZMlOmDMnpx95kKf0OxCnHFK6W8w=
Received: from DM5PR15MB1659.namprd15.prod.outlook.com (2603:10b6:3:124::22)
 by DM5PR15MB1434.namprd15.prod.outlook.com (2603:10b6:3:d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 23:21:51 +0000
Received: from DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d]) by DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d%12]) with mapi id 15.20.2793.013; Wed, 11 Mar
 2020 23:21:50 +0000
Date:   Wed, 11 Mar 2020 16:21:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200311232141.GA181064@carbon.DHCP.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
 <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
 <5ed7f24b-d21b-75a1-ff74-49a9e21a7b39@suse.cz>
 <20200311225832.GA178154@carbon.DHCP.thefacebook.com>
 <55f366be-ed3e-7b57-0fae-54845574d98a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f366be-ed3e-7b57-0fae-54845574d98a@suse.cz>
X-ClientProxiedBy: MWHPR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:300:93::33) To DM5PR15MB1659.namprd15.prod.outlook.com
 (2603:10b6:3:124::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:bbf) by MWHPR17CA0071.namprd17.prod.outlook.com (2603:10b6:300:93::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 23:21:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:bbf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62da334f-229b-4401-d3e1-08d7c612fa2e
X-MS-TrafficTypeDiagnostic: DM5PR15MB1434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB14341B7F50A00A026453C1A4BEFC0@DM5PR15MB1434.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(2906002)(1076003)(8936002)(66476007)(66556008)(4744005)(66946007)(33656002)(6666004)(5660300002)(52116002)(53546011)(86362001)(478600001)(7696005)(316002)(4326008)(81156014)(8676002)(6506007)(186003)(16526019)(6916009)(81166006)(54906003)(55016002)(9686003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1434;H:DM5PR15MB1659.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MhiUUQfwMK2VZol0ev7AFPS9npfGXUV5sGum5nJNoDUcAWDpz+yT4ibK0AKSjSRAdBAos8x+tUruRffYUt5E31yJqOF4Oeo4GfEg6pco/ExtZCohOovOevluY4qKYWaZlEZtNVTc60odWr4tq8rhOG2yqNjj87/0XZxT7fU3zSj1nqWuNARkZJuQJEcLlC9iOA+4ELIOsGHkFfifRsKp8Aacs6/ZSftR5XzlC4uanI/GDUye20tnpM8hJkOXMj18XhCuWCopWiPhAaaUOTFmn01lDH0rTgF+lDpmh5uJdMOWFGrw7zaWSlLnQIAZPw93QPcDryA0Nipn4oC73VDGJo/WlHZ96yiLyxSTHPQmZMwy2/q3x0/ldRFEIQmQl3lcdbEH3hYFCGXxQk7hlcBRwymzDTpJcQO2K1OEFHZHT5xW+cIaXUzx1nReQL8aFNoJKDflii82ygoabEi2xeR1WavRmKa+npU/VVd4dkd5eVXEujAdF6uvR6YPg/6pOo/
X-MS-Exchange-AntiSpam-MessageData: BST5DK4117AnwZMWioJevXV1aAKHHfRv9PGHHmzg3IA1jEsLuoKp/Rg7i4BvZSssQuUnVdv/jEjNT1h/luDZZf5wreGs8fBbCU0WQhwAx5OP5xnZxgAP0wSGOChItD3OkCECN5FbSNfbmSMenVUbWml5pTAv0QOg53EThZaCM30h5/EwdC3zAz60jY0sY5gD
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da334f-229b-4401-d3e1-08d7c612fa2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 23:21:50.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV2QAqlqH9lYZ4hOUh7la+qc3Iaphs197ttk7RsZCTTL/fDxWD0xtHakbZICNpOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1434
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_11:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=1 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=993
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:03:58AM +0100, Vlastimil Babka wrote:
> On 3/11/20 11:58 PM, Roman Gushchin wrote:
> >> 
> >> I agree it should be in the noise. But please do put it behind CONFIG_CMA
> >> #ifdef. My x86_64 desktop distro kernel doesn't have CONFIG_CMA. Even if this is
> >> effectively no-op with __rmqueue_cma_fallback() returning NULL immediately, I
> >> think the compiler cannot eliminate the two zone_page_state()'s which are
> >> atomic_long_read(), even if it's just ultimately READ_ONCE() here, that's a
> >> volatile cast which means elimination not possible AFAIK? Other architectures
> >> might be even more involved.
> > 
> > I agree.
> > 
> > Andrew,
> > can you, please, squash the following diff into the patch?
> 
> Thanks,
> 
> then please add to the result
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thank you!
