Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C058C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149BE207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O1greGcF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HPqqRWKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEUVGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:06:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729756AbgEUVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:06:34 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04LL3Cjv006444;
        Thu, 21 May 2020 14:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DQsTLKuzussdNJKqZpCsPKbkMiWOK/tUfqBsu5wFy6c=;
 b=O1greGcFUEcc7stZG8O6kihCWNmh3sZn2wPbiTQ47HR2jhI0vdYVGQU0kxeP4MGI7ec4
 61G4Egg5Yc21BNPJbFSDcTW2GLGbNSEJaUE5arcCYAzW3JbmDbDYUOt607w2LZ8jUV+l
 c4IDd1i3S3/WT7D1QYD7kVYbYKR6BqHgOlc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 314jubjmxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 May 2020 14:06:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 May 2020 14:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKBSIQ5cB+In12tArsdRgN9lwfWQ2XKINBWGwRE8WH6d7XseWui4gTs5gLPt0Hnq/v5bacjihZdTsXL9J2YN8ROogVpqU67jm1F341RkvfIom8XBpYfPzPoSAy0W6o0jfVdmpFlWQlw6aWzK5IGfHofkyTWfFH5oSoy4Sc2BfkBsGCZipuWj8sWCd+b1XkGVsYYvvaJj0SzODaRKtzYikBavZY1ZQWt7zuxsk1Q9bCybgz6+GbW0mQKBD+QxLFdso7fILEipNMP9GxEJ6O1yF/gbY6nxVZ0WB18SybbRi2FE0fF16JAwleBCt/k9+S33zN/ZUzLF/bFl0vh4vkyyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQsTLKuzussdNJKqZpCsPKbkMiWOK/tUfqBsu5wFy6c=;
 b=AZ0Zh7mDdcHNda7DOnrml3l7ONN/0H5GqOTLuAONZJrW3TATsId53ITTUbBjDBtqYhwGd/NcIAZu50AcSNvtP1L+W5wuFp+nQ4Nh4m1IJiiyOqW251SZxycI+0XmiN8h5JmdUQcYAV5h6lzJCrdz3lY5a5G1pNPR/6ZMGr4wNNPgovAmCbAnCguXmbUeFx+pWJfPij68pjXzTYvazMEcxYSEZJRxzctpd6awVTSWpDd1mPmcDH1X61nH87jHwG09UaC3jEKbY/dMUon58GGcmimMDr838pBucI44Nq6emQV7FcnmFyQ8yyuIuPw4ePj8u4X5SLsjytlMuxMKq13h5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQsTLKuzussdNJKqZpCsPKbkMiWOK/tUfqBsu5wFy6c=;
 b=HPqqRWKs1x6yz6sZXaS8y4LuL60wiKKKQlQbkVeJXyP22Mcq1b2cWne5Z3fEOoAph7/7BeXIaWwWRCqQi1ayGX4iq8iR7HauqBAHeb52aQB/P1+LCWINZSj2t9kEvNQeTpIcJN5w4ZDNXU6KX0OG7Km1ViPe2ri4SXHZbhL0IfQ=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (20.177.229.24) by
 BYAPR15MB2310.namprd15.prod.outlook.com (52.135.198.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Thu, 21 May 2020 21:06:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 21:06:20 +0000
Date:   Thu, 21 May 2020 14:06:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200521210616.GA339999@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <0e0616f2-6c5a-8911-7d37-6f2027c2930b@suse.cz>
 <20200520210040.GC278395@carbon.dhcp.thefacebook.com>
 <266af2b2-41d0-368c-1896-1a7637389054@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266af2b2-41d0-368c-1896-1a7637389054@suse.cz>
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:84a2) by BYAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend Transport; Thu, 21 May 2020 21:06:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:84a2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b278c95-3ba6-4bd3-e413-08d7fdcacf24
X-MS-TrafficTypeDiagnostic: BYAPR15MB2310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2310C0502AFE479889FD374FBEB70@BYAPR15MB2310.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDkaYJjXpmA0jcU5+czAcfBKwZUH+YYYcWXU6H1LxhfQFkMET7RQxghXVjKvOtwb0GO1CAM+f3SaVqe1p2Dyx/oimIl+jeykErZOQslRmGjCf7uOgZioH0Q819LxC2CEI8/tb+LYFKNUwz/5Wc1Pn4YzHxvU3RBxa7ZJbmLhTewLTm7qGQlLoFCCxue0sdrBpzv/cH296ovv8Ih655H1UNaziJmdcfWOZUiGHVAmzznXwQ6VHtm4osZtL2rqt7B6W5Iw7NpbNqLxpa+gQE4ODsuH8Rvynd+wxUxz0AIxu8O4DVW0BXruT//pvIgP7vE6rrdGE1YLibct1vhbJYtdCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(53546011)(6916009)(5660300002)(6506007)(52116002)(186003)(7696005)(9686003)(86362001)(6666004)(4326008)(16526019)(1076003)(316002)(54906003)(33656002)(55016002)(66556008)(8936002)(66476007)(66946007)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Q0o/0WC4Vr10mXE8W+YD7MN5W0GuqDdCKUt7F9ohpF2uffJDeh2P+yO4RHe/V2Vk+vgGr9CcrRRrDhPEnYIDifQoL6VM8lCFjaz3b4XRuIo1ogzWHktC0Oy6NkPMdpCP5WPIdysiJ2mspuseDWxVblZYLQ/+2AMzpGkUAzI1bJLMo1ESi3CGLTrbhRNHiaFFR4c/gQWigP1uJhKFZ9T+GfwQgMlFFotQ4EdVQ2eln+jhTSG2MA/C8aRpZVLYrXvZbe60S80gavl6DL5b1lJKGS5vzcmyW1IZnjbJtKmkq7Ytifm0CgwOrFoFyCIPneKw/7guQC/SIQb6Tgyk9F6k0ZZc3mBVQl5Lnrzet7tqRhIa2xmh9BLc9h3nfKIacc61emI+EveYVzws1u/DXf90bwwzHf8beKIjya/ITT8Y5bYSL0RqNvxaLC/A1E1gTSvvMpE8l6/y9kmHpyuw5ZYceUgQdUILdtD0SfLO6y+9GGt03fRN5+vet/k3WamIgiV6GkbSc+f5qBXY1X3To0ufSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b278c95-3ba6-4bd3-e413-08d7fdcacf24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 21:06:20.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rabqyd7f1L3uOA7D6acxSpSkmGbb2yin15jnKb8f1wgCC0xz6kW1BFSFuvM1Q3mc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2310
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_14:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 cotscore=-2147483648 mlxlogscore=750 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=1 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210157
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:01:38PM +0200, Vlastimil Babka wrote:
> On 5/20/20 11:00 PM, Roman Gushchin wrote:
> > 
> > From beeaecdac85c3a395dcfb99944dc8c858b541cbf Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Mon, 29 Jul 2019 18:18:42 -0700
> > Subject: [PATCH v3.2 04/19] mm: slub: implement SLUB version of obj_to_index()
> > 
> > This commit implements SLUB version of the obj_to_index() function,
> > which will be required to calculate the offset of obj_cgroup in the
> > obj_cgroups vector to store/obtain the objcg ownership data.
> > 
> > To make it faster, let's repeat the SLAB's trick introduced by
> > commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> > divide in obj_to_index()") and avoid an expensive division.
> > 
> > Vlastimil Babka noticed, that SLUB does have already a similar
> > function called slab_index(), which is defined only if SLUB_DEBUG
> > is enabled. The function does a similar math, but with a division,
> > and it also takes a page address instead of a page pointer.
> > 
> > Let's remove slab_index() and replace it with the new helper
> > __obj_to_index(), which takes a page address. obj_to_index()
> > will be a simple wrapper taking a page pointer and passing
> > page_address(page) into __obj_to_index().
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Looks good!
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
