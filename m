Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031ED207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qvvLJdSX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="e5NVR/GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgE0Upj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:45:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48024 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgE0Upi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:45:38 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RKceYd025339;
        Wed, 27 May 2020 13:45:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1IHb6kn45zIoI9kOY0lvDFCpXhaFHP+J0cjAKDGHLQ0=;
 b=qvvLJdSXlyCDtIh1PUE7g/jqJvhGr862DCJXAqAjOb12f3jP4JY8NveuOSdtQj9YtNDH
 hsoh5fA/N51SUjxGFkA77Da7LR04NULznvLvfaC1L8PDlEyMYao5afGxUX96kUyPOvdz
 AStCF58gd1pfDiwp+P8b02VBWFZvNLuQJbA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 319tayunpc-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 13:45:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 13:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrx/4WenJ+VfLXYTiI3drLugQQEmoseNuUxZWX97LqgKijo5f2L7FmwI18azITs47hnPmDvc/GXDvg/cALgXw583xv3eRl07AXUr062SMI8z9T7HhmOk1RFZtnikQ5rOkQGM7qFRa6w6zYTferex9dP4wNfgaVcZQl1UwfeJVGukCphvMLPJ4zHjT038HzZovldjx8RN26L7fcaFFTRqrPrdTJ1J5FjNQleD56lHRfewknBp/blsLqd2wVEZ5YBcrNLXKbT1XBmex5krtlAoyFdUjFMzLrJGsHyxVnYiPdCnPagXQLIz4blnc5gnKssFGLYemtcesDgIaH4d5ASEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IHb6kn45zIoI9kOY0lvDFCpXhaFHP+J0cjAKDGHLQ0=;
 b=fCLwWVQt/OAVZwte+WAe5wZkX68zjpOI76qbTWQJjHQ8iyMokVvRUK73AcbZg4TEMZ/J2xlT6upNQbfF1ImcThEIbB32rVFLfOTeqtVQH8Rgssg7my7pb3tDvRxUg4z7/98mDb0UvQo90A0F4m6y7YR0IslFsVBUc6+lVWS98XzE24QENMICAxcToqCAgdCU/s+I1AFEEvdSCIi5VcQqdysoNlMTSgw2ju7WgcWpeLoq350JmagTiTupV7nq6dTi+LqBbaTVPTLrAWRpGpubV4ovwoILEM65nKtCIMnXYj3tJpHbyf4qXIinQqYeINy8iyLvlvSpnmSqXNz1mcnalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IHb6kn45zIoI9kOY0lvDFCpXhaFHP+J0cjAKDGHLQ0=;
 b=e5NVR/GH1dCdFScJfrITm1kbAb1WKkpbayXGr1DXatWfih6angUNoZwqjzw/BuYt2kJwO3mbMJYak4S+pnxTRoruIXaV8LP/Yj8EtxRBJyNOnxa/efClAMFHxBhL/8ShTWrqlBbGesQpLiEGzX3rwU3y9XLmkV02fPuLrRrsUQc=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3461.namprd15.prod.outlook.com (2603:10b6:a03:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 27 May
 2020 20:45:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:45:27 +0000
Date:   Wed, 27 May 2020 13:45:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 18/19] kselftests: cgroup: add kernel memory
 accounting tests
Message-ID: <20200527204522.GE396660@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-19-guro@fb.com>
 <d980935c-fecc-9682-7dab-bdcf33c12a9c@suse.cz>
 <20200526154508.GA364753@carbon.DHCP.thefacebook.com>
 <63bc0cb9-b803-d3d9-5e61-706f81fb8a78@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bc0cb9-b803-d3d9-5e61-706f81fb8a78@suse.cz>
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e713) by BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:45:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:e713]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7e05a3-a674-45a7-76b6-08d8027ee2d0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB346188FC0D92CC4C163A0114BEB10@BYAPR15MB3461.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHTzvIYL1W3gbwPN+Pz4lgH4yplE75zKxCtGbGaEJEe10Q5dtNSQEpCX+ql6DzLCTXddnw7HsUvMVwN1fFdP3xYAWLGWuF1mVbrrjVRM3J7I+RlOVqbkRgeN3FIivuimFFvBrGWeOYsus013hs6Vl6CDAMyfcXsNZHogck75h083cXosd3oyGowtocuJri3AnJ9+LeR/hJG6QVkgyhO+xEyTJRN3wvV2kOsdxtSbK0NqypW5m+odjQNTekTu/U7kor27CKbuwssOedxJX3hCwBfFdG/0fFH9vsW7H7iwO3fiKI7JThJJqfRmRwniWikyX1CwCRiKdaz2+bAtNtRDxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(6666004)(55016002)(9686003)(66946007)(86362001)(316002)(66556008)(8676002)(2906002)(66476007)(7696005)(53546011)(6506007)(8936002)(52116002)(6916009)(1076003)(5660300002)(4326008)(186003)(83380400001)(54906003)(478600001)(33656002)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zSB1H0Slzaf/QILGjSNTTnzhY4AUeleY0UeBjBwaSdM7FX4SIf3mJxXsX8LkB1IJJKRi+X/acNgrmpW/i9ytYl2j0nAjhyMmQ3uy7d7rnu8DUQqWNgi4zVBnWbeSAHxzikT6iFK1GqHpibtiaUWgNVhaphav6S4a1F8FrgXWfXPc4gPlN3Vavblyo4C3pTF2hLvjczn4WHTZNxLQp185paTJL8wL8mWfyD/5/0bbyiISDcAtuymp4RHuDM1G1zijgv56NKkj3tT0Uru/QIHfKpoYQVd+0NxNWwID400hKYqZvlfuTkk/Ixchb/OwJeC2iRaykqCAptuMveOiD2cgJeTDmjzfQviFim4V4hoeZ9oalpMXftoGWv52Js1k5LZPf7JafP+fecQjplal8qWXsN4IVxOh/Uly6mwF7NG/sWzZUev2tVZurb0AjQF9lU518yp+M9bIRfFPykYK9rM59/p88jf9wqlClI7k/RBiRBC9DWWRN76seSed1ekWJizwKOFruYKRnNETZsEoe41JGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7e05a3-a674-45a7-76b6-08d8027ee2d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:45:27.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cID6zSOiEp5TuaDicLYwY+ZtdO5wyJ8qd7UBXn7Cx9h56DJoY5tnXpT1eT/QaEhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=980 cotscore=-2147483648 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=1 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 07:00:30PM +0200, Vlastimil Babka wrote:
> On 5/26/20 5:45 PM, Roman Gushchin wrote:
> > On Tue, May 26, 2020 at 05:24:46PM +0200, Vlastimil Babka wrote:
> >> 1 << 20 ?
> >> 
> >> Anyway I was getting this:
> >> not ok 1 test_kmem_basic
> >> ok 2 test_kmem_memcg_deletion
> >> ok 3 test_kmem_proc_kpagecgroup
> >> not ok 4 test_kmem_kernel_stacks
> >> ok 5 test_kmem_dead_cgroups
> >> 
> >> Adding some debugging into kmem_basic I found I get memory.stat == 0 at this
> >> point thus it fails the fixed test (otherwise it was failing the <= 0 test after
> >> writing to memory.high). But it's just a VM spinned by virtme which has a very
> >> simple init, so perhaps things are not as initialized as expected.
> > 
> > Hm, it's strange, do you have any values in memory.stat::slab for any cgroups?
> > Or can you send me your config (and kvm setup), I'll take a look.
> 
> Config is attached, KVM setup is just running virtme [1] on the git gree where I
> compiled the kernel:
> 
> virtme-run --mods=auto --kdir /path/to/linux.git/

Thanks!

So, test_kmem_kernel_stacks fails because there is not enough memory in your setup:
it tries to spawn 1000 threads, and virtme-run sets the total memory in 100M,
which is not enough. Adding --memory 4G option makes the test pass.

> 
> So there's only the cgroup the test creates, and the memry.stat::slab is zero
> after alloc_dcache(). Although I can see by strace that it does all those
> stat()'s. Also /proc/slabinfo also doesn't seem to be increasing number of
> dentries. Could be that because root fs is 9p in virtme?

The basic test seems to fail because of 9p. It also fails on the unpatched
kernel, so it's definitely not a regression.

So, maybe it's better to allocate kernel memory in the test using a different
method? I'm open for any ideas here.

Thanks!
