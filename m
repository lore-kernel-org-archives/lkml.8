Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB33A22363
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XBQnAsgW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gcU4Wu/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgFUXfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:35:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgFUXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:35:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05LNS4Ij024719;
        Sun, 21 Jun 2020 16:34:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=jxf6sA6sbwyV/6aen3GMzk1NxqhwOkxnUnYdxjHvdDE=;
 b=XBQnAsgW7i7B3cGigqnCxGsg7NlKJBViY9NOGgmIgjOdrMNHPBthBLEERk6t058k8I0o
 lLt1ErTrJhu4k7k3WbNL5TBrsHXEeE+iSy01rduyVvJvEOApfXH9kaJ9ff1k42Zw0/id
 1Lr/CEtURU+/UVL89mL3wCtVGrgwdvb7BLE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4nd5f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Jun 2020 16:34:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Jun 2020 16:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx+KskucWgWutegV72dL1l6nxS+3BC+FgFaix4JyRQCD1sWJx3UD0bzEBOuTqeJIBzmyBNgiaYYn7IVs1Tlh0JSRMvm159LkVOnq3/4Y0oIGIiY2hNlTQ58SftSLI1SMNLkPG4d2bGwOa3QdjCTBEqEUYegKP0ok142vQ4TqqbA6xf28MR6keQ0PMnWWAxAU5GoV8dKB3REPCb7912OYWoSDjNc6bsTwuzNTBFs31x4iPwIldZTCuOWj15fR/OVodIAO8Wk00dppEu57VdP4r8QVqdas3KItYr3YTo8wnd+6aszJosNFbgwoOn9mwzxJoUVPZMMzkMII8FjNeRe81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxf6sA6sbwyV/6aen3GMzk1NxqhwOkxnUnYdxjHvdDE=;
 b=Bun0UL5jjdqzH0nK9/ABERF6D1BmCpWhJNvOM/4TrzJGJ20NLDWPpYoD1yGePbFHg9GhWr4etIZuBWaKDKYRnnTCSe0z6qA0NXKfVvkZuTSh/0vVuNFzIr36mmWtR6bip8ZeFJp9x0cWjg4S+IiewuN7ga/O0S5shFZD8sGkK6S52CY1tgtaRvIZ9pl2TX8quTGZFgW+phWHyQKD1PMaU/C2rUrfeBun8F5DsLBfYRBCBUXzcUCOr58og9h7AqphA+xvyQixjhOfjxpftXPpn2l6ZWEuNn0b4SJDBocAhThBo2GKiYe7ZPWWjn1Hp1V9pvUnZmQt9qcHbNitAj9oDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxf6sA6sbwyV/6aen3GMzk1NxqhwOkxnUnYdxjHvdDE=;
 b=gcU4Wu/uOc9d7ySek8ofbC6xfMAlpArAA7heXatMPX9ANqhWIcsWuHvOcz1rCF5Yo9/rodV4pT8zqEbS4qNwBxxxKT44ncGgAYaqZKaIn3A25FBCe9piW7ob6Sclv68dGVhNEvFfFuXMk9Z1Q11H55U5gPOmPrS+8YoQOgpwrsE=
Authentication-Results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2711.namprd15.prod.outlook.com (2603:10b6:a03:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 23:34:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Sun, 21 Jun 2020
 23:34:32 +0000
Date:   Sun, 21 Jun 2020 16:34:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200621233429.GA293939@carbon.DHCP.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200621225752.GB2034@lca.pw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621225752.GB2034@lca.pw>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:72f4) by BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sun, 21 Jun 2020 23:34:31 +0000
X-Originating-IP: [2620:10d:c090:400::5:72f4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10323d0-95f1-4935-081e-08d8163ba62f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27116E0DFC25052DE97DD272BE960@BYAPR15MB2711.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsaSnbPYJ11p75IpdTPiF1BgJ4OpfwA+qDtDmjMb5SUM9CpeHru9Q5TLiQgt26BQ8rKITOPcBfSJgLaliig74xGnLasfeCoo6CwWKVOYUNDPtRpneNelVOSbAuBlhvo4fWIBLUgdo0vc++QgWEV4zH/UzQRl3/3KcAWI7pg6/VfmVj4uMYvQtcaFdXPbbmHeMp4TwalZVW3nZSnt55gFD9C+0QOaXooI3hrzXBajz11SiHh9s+ZVqnfPzLkp9A3px2pJlU4asR60t6drFUSxnIKJg0gui7W8gOUPCOhGjSSG873JDNnTfKLbLEvpDbpeVUa4ApN12X8srnevMPwmkwUmFiLNy/QxK4k7Tj7zukvi5ncYfBzPqsgafh/x1TlE/2q5YudMjGh12uccFUFXrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(7696005)(5660300002)(478600001)(1076003)(4326008)(316002)(55016002)(9686003)(7416002)(66946007)(186003)(16526019)(52116002)(54906003)(66476007)(66556008)(2906002)(83380400001)(6506007)(966005)(86362001)(33656002)(6916009)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SVSgqzlQPJOXJmsr/5yKFbf8+4s24MEQCL8qBu5WhnnBWzgJRYKMgbmhE3yo28Dq/ZENxjLByiPTsGRdeg24+Wg3AYiF4JK6U4igIo+UGAmaWN82DC7xaozmAs3YqNCCAftUimf2qXURRP9fuQN2ndWnz+IlaXy2DAsoNnz321enb3E91yLM4wXwhbQ+RHdsDhmOywbGka4BX4/5d6szFbvnNyEt3NxqDtI5RcZluyZzagFbZ6w9t1m0p3tNLk4R2XfOfUi4oetR8rnhf/lVrP1gFoXGnz+kuVAEpUbwqHLYRZ/9C7QVUJFe3jFtgKIFY7d+ZZt4ZoZmOAukwbysrI3M7PfloaazCrA2Nwbi1V4dHYCswVA6m5X//TCHehJFo7Czfb2eo/Uv8SBkTvo5Vm4+uRF1AKVWQRMkBDIPMWOP5PF7BtlareziG1krKdZCFwlZslWQ9AKCupGRSFHWmZF1HCq+8UsQig35Fsd1hEy/B5ECujst7magKvZQFI16EIv3gh5r0daU5YIDJ1XdxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d10323d0-95f1-4935-081e-08d8163ba62f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 23:34:32.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M5Z1nazsFSTMKRihAJDi4kVU2uO2qAaSXgB3b/vYf3ZBmKIJK1ZaZdbBrupAkLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2711
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_12:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=6 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210187
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 06:57:52PM -0400, Qian Cai wrote:
> On Mon, Jun 08, 2020 at 04:06:35PM -0700, Roman Gushchin wrote:
> > This is v6 of the slab cgroup controller rework.
> > 
> > The patchset moves the accounting from the page level to the object
> > level. It allows to share slab pages between memory cgroups.
> > This leads to a significant win in the slab utilization (up to 45%)
> > and the corresponding drop in the total kernel memory footprint.
> > The reduced number of unmovable slab pages should also have a positive
> > effect on the memory fragmentation.
> > 
> > The patchset makes the slab accounting code simpler: there is no more
> > need in the complicated dynamic creation and destruction of per-cgroup
> > slab caches, all memory cgroups use a global set of shared slab caches.
> > The lifetime of slab caches is not more connected to the lifetime
> > of memory cgroups.
> > 
> > The more precise accounting does require more CPU, however in practice
> > the difference seems to be negligible. We've been using the new slab
> > controller in Facebook production for several months with different
> > workloads and haven't seen any noticeable regressions. What we've seen
> > were memory savings in order of 1 GB per host (it varied heavily depending
> > on the actual workload, size of RAM, number of CPUs, memory pressure, etc).
> > 
> > The third version of the patchset added yet another step towards
> > the simplification of the code: sharing of slab caches between
> > accounted and non-accounted allocations. It comes with significant
> > upsides (most noticeable, a complete elimination of dynamic slab caches
> > creation) but not without some regression risks, so this change sits
> > on top of the patchset and is not completely merged in. So in the unlikely
> > event of a noticeable performance regression it can be reverted separately.
> 
> Reverting this series and its dependency [1], i.e.,
> 
> git revert --no-edit 05923a2ccacd..07666ee77fb4
> 
> on the top of next-20200621 fixed an issue where kmemleak could report
> thousands of leaks like this below using this .config (if ever matters),
> 
> https://github.com/cailca/linux-mm/blob/master/x86.config
> 
> unreferenced object 0xffff888ff2bf6200 (size 512):

Hi Qian!

My wild guess is that kmemleak is getting confused by modifying the lowest
bit of page->mem_cgroup/obhj_cgroups pointer:

struct page {
	...
	union {
		struct mem_cgroup *mem_cgroup;
		struct obj_cgroup **obj_cgroups;
	};
	...
}

We're using the lowest bit to distinguish between a "normal" mem_cgroup
pointer and a vector of obj_cgroup pointers.

This pointer to obj_cgroup vector is saved only here, so if we're modifying
the address, I guess it's what makes kmemleak think that there is a leak.

Or do you have a real leak?

Thanks!
