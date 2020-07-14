Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B85AC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C11722518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FuZ+jJRs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CuvK5dvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGNRnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:43:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgGNRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:43:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EHgq4Z032456;
        Tue, 14 Jul 2020 10:42:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Igr7RfNQJFmZun3AzuXM7wriwi71e5zdpBnQ3KVsoPU=;
 b=FuZ+jJRsk21GUevtyuEjwsAZQZR7R/LCkO3YsPXnYCrXVc+1cO2nk/mtF0Mq/jYZ7sBa
 TRfci9A6FigdbBHaka+P/SllzvRqYljF9T5uqC0rqzFVph9OxmtqcB53KkLnwOPGfECq
 78wUt6gXwcmfSUcVY0YWPU185bxDwgKhH50= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 327wppk9p1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jul 2020 10:42:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 10:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi31C0joOJzLHvH1z46hhvm1KgyT8aHmUe4zXC26Ew1d+2c71XtITmZrDJNAC/be9cS3oPqcWeLo6jDWzUrUM52W68tovCeU1aYSrOD1n+7UGGIKQzbEf8+i0Q3iMRBN3NgSCu+meufpjPllf3oqnlmfmWepZHXrwfR7hRiQ7HadH0ZF+Eaa9IOok4wQ9LGxIq7+LKtree5Iuem2cVbyoau655l9K5nv3DHdWWb1bPAyBRM6tkOeX6ZC6wDMU9yzrwrfxmd2sJzi3dp/EtPXw6c3qk8LNofDTpL2pSjibHtf+9pI/m9cdG9C2+kQWSqef5Foc4zsekUTZzonmf5KeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igr7RfNQJFmZun3AzuXM7wriwi71e5zdpBnQ3KVsoPU=;
 b=mOvjQCmlLq5F3t2+1AXwH+9rHoPBBOzM+heUf9ok8RTE6+0M4HigLqT3Qyq7UkJXozYQNIg/S2AjddEQSCgn8tlQpFcAP4sJS/0vmeksxZLTW9azrTkdQRy58NhIaA6GgJJz/ctErjAvNd0v1IRP/hYKm+wWHNGm1x5+AqHXnagJp5FTo0pD84mm+Y9g5Ux8eiXYdpFeNujabkjrK14jP1UclKcKR1OjPmYryxbXXqpAvEw+eGpnwrsywvx5va8rPRr/lDbBg2C0oZGkTW68uMXNKvLtLZZ7ceSaz/vlOFyyWZvk0xHMqCo2lYz7I4tjb2f4oaI+dMhaiXk6OdHkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igr7RfNQJFmZun3AzuXM7wriwi71e5zdpBnQ3KVsoPU=;
 b=CuvK5dvmtsByCXaSUbvn2DXPBvB0Ro4Qh18gSZl3cZJRkC8OkeXZ+QACOnSUpR2WkxEzE+jOpXytK+9h75NO2GgOgEwvudx6dpbEqt7N2tafK2suw3pFkBwgt4PE3w3WlgKTlXgN3qcoC9Yjv2KDF37oNGvuVDmdzdwxEvlrU2s=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2662.namprd15.prod.outlook.com (2603:10b6:a03:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 17:42:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 17:42:38 +0000
Date:   Tue, 14 Jul 2020 10:42:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200714174235.GA484245@carbon.dhcp.thefacebook.com>
References: <20200714173747.3315771-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714173747.3315771-1-guro@fb.com>
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:69f0) by BYAPR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 17:42:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:69f0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538a7dc2-a1e6-4f5f-ccb0-08d8281d4cd9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2662AFAB613E506A87F915D2BE610@BYAPR15MB2662.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dji6bB8sRfe9op4IW679zDizXPMIUTw/dlXjGMklcrnQSLfzdc5ijR+/+VtE0GCy6y6pLgBP3sZjBwY2O1vtOyRztcOwJ5R7Xa3+sN9EooMKvfJ42+lHCWYvEmLwrdgJh2ksrAXMR3X/0bZLCl3dl1TVSi1oQWbWCggZJElt4ICdpfdHivj5Kx3tN3IYMt9WZr0vA50/R3Wg9xX7qIu4sxgB1BL0VRSJ9bl+P7H7o1oMd5f4XuYtgHNFGuyKmj6bpNIlybWvQ17UrRL2i3a51Y2KKbmK+u6eSbWI/IVGLko/t9CtaU9NcAJ66IZ+2mChKGrDFbqtBZ9ExmBUTc1FYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(4326008)(8936002)(7696005)(52116002)(55016002)(33656002)(8676002)(54906003)(6506007)(1076003)(6916009)(66946007)(66556008)(66476007)(9686003)(5660300002)(2906002)(83380400001)(16526019)(186003)(86362001)(498600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JkNc333JZaSTOT+U9H+GlJ8GhK6gezKEu3U4kdSHr21tlKDvJjAX0hb4G4hFcev3rc78lyKAC94kjW93paCyh2vNbpEUO9q7nOgorGBreVu4lZj/YGIVZV2mUYI1rl7pPJkcr0fqhkQ2TSnBrVrtZDYhVPS9xySS6AVlsJ2z3d3jwBIZZVgl6aggOInJMgPi6dGl77KNmkV+ZnzXjpPk61XsQ+IgH9ThsKz2E4QhCCqHftrfdouQvfBnWZSkSfiJlgzzJFcDx2aqbS5TUnkf+dEGWkJXpacFWr+yJIfiIppgnVkl7IbUfSyh7W62D/vdJ29hF+nZ9f9WiJaV7+45htHOosmhEGCRMzUWEcvSNt/riSb9sgJAmEkld3fd8fW/azqsQDkQRKeTidhRHUOEbbVOnprgsRXGY7AMEpNiOIRPh9mEnq7IxFQgINlxaGLNn2lZifGdQ28/D4xmX3Zi5skLWMKRAkhHOlmZ92UCVjDvUMNDoTmODJaulwNmXOh+zXIP1SUwXLS1vDhqowpzrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 538a7dc2-a1e6-4f5f-ccb0-08d8281d4cd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 17:42:38.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+wfAXM8vss3JFHYcuf1gLNPmp3/tDEmstzzcSsrIjNehFvqy9ggVYrZ1qz82yCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2662
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_07:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=5 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140129
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:37:47AM -0700, Roman Gushchin wrote:
> I've noticed a number of warnings like "vmstat_refresh: nr_free_cma
> -5" or "vmstat_refresh: nr_zone_write_pending -11" on our production
> hosts. The numbers of these warnings were relatively low and stable,
> so it didn't look like we are systematically leaking the counters.
> The corresponding vmstat counters also looked sane.
> 
> These warnings are generated by the vmstat_refresh() function, which
> assumes that atomic zone and numa counters can't go below zero.
> However, on a SMP machine it's not quite right: due to per-cpu
> caching it can in theory be as low as -(zone threshold) * NR_CPUs.
> 
> For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
> reached 0. Then we've reclaimed a small number of cma pages on each
> CPU except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are
> slightly positive (the atomic counter is still 0). Then somebody on
> CPU0 consumes all these pages. The number of pages can easily exceed
> the threshold and a negative value will be committed to the atomic
> counter.
> 
> To fix the problem and avoid generating false warnings, let's just
> relax the condition and warn only if the value is less than minus
> the maximum theoretically possible drift value, which is 125 *
> number of online CPUs. It will still allow to catch systematic leaks,
> but will not generate bogus warnings.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Spotted a double sign-off a second after sending. Fixed in v2.
Please, ignore this version.

Thanks!
