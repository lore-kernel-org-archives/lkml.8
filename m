Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AAAC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3FD20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EDE1qhVO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="F3ITSOOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGW3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:29:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgEGW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:29:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047MLVFL005129;
        Thu, 7 May 2020 15:29:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UDbtAIFjEXHKVl26AKa8dZMXw9dz2JTdPz7l7c7Z+tY=;
 b=EDE1qhVOY1hpPdh0VdZ9ZIV5xGBuCPpk/P09+rWz+YL/h0URB+6ZckvOXBvRQajkbU5D
 g6Kwirhqe55RaOJpmdpLOaw49lhBD9LXBMxOXsNCahrrOR/Pw3TVvQODBWiyqVlpnLMV
 ddc/JjUvUNez5nfhS04OccrlquBwZH2AcXI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30vte4g8bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 May 2020 15:29:02 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 7 May 2020 15:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7kz8iV4VE2wTm4VZRlK/wzBVkaKGoDnJVr51JAZ/PyNlUqi/uOs1hfUvnfHxIVGgyEq8DdpRzALLgJs5ETKSpUH6WqQOI72YS15XToG1Ljbw86BhJH5R7EwhLAiLrrsIMPYh2ga3q0OInvEhfUU90OBGSSB6nFyjWjdFhOiSIoDJm21IWXbhW1Dwo9OpsoUr22oOLeQnsJD2N+HB61RYJCvz+2O6Q4RqHMAIssbRJVXlWvRG0kJKcpepvbMRTE7Sh+HtBoWv8fbAoE/3PpoZgf7psKyMOGOMkR/vAPeYJx2L+fZkg9IvYduqKchZ3++lSnl9tr4mPeySph6J3bCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDbtAIFjEXHKVl26AKa8dZMXw9dz2JTdPz7l7c7Z+tY=;
 b=E6mbHmuHXPSWbaL6dHzdOzmCQEy+gELFkI14fRm1nQ6meU3VZazvC+xPoDZfQwCxIA3nfFlFHwCaBZKzlL3rD23uHUiOPMijpxv1/uHfDBlxnypu3UUGG8wUXeYs8If8jX24CIHAoHHtC621Ly/Hg1RolcnCthUFXY1IATt8wlH8PMyJgnjvMjvAo24y7eqSSI23psqjxDZ8SVHYBBtbmN4IhjTtrycMx6L/hV7GpPJ43P0F7nlPnvs3Gi/MJIOFk3ySOdVihKSaZaiztGXW58gE1Pa4dYKYsqHsVu2r+IHcMlGWrzoYTVfNibK9kHIIfUaKa8ndJT/mSEXRqZj5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDbtAIFjEXHKVl26AKa8dZMXw9dz2JTdPz7l7c7Z+tY=;
 b=F3ITSOORr+fAXfdQHxsxC1pZLeqcc1CaPqoQe7Rx/J4HFkcHUFq6BN3HVOl8ihmXjqKq6I72fCAWwY/Rogv7FAJhh6yAqIVXZ/3TqyWzpuWoNN3N3RhqM/Ki9QbBd/GnhPaUF6ZOWZHwclQOVL/L2axCCPw2J4do6qoy+gf2hTE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2358.namprd15.prod.outlook.com (2603:10b6:a02:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 22:29:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 22:29:01 +0000
Date:   Thu, 7 May 2020 15:28:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
Message-ID: <20200507222856.GB81857@carbon.dhcp.thefacebook.com>
References: <20200507204913.18661-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507204913.18661-1-shakeelb@google.com>
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5b44) by BY5PR17CA0066.namprd17.prod.outlook.com (2603:10b6:a03:167::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 22:28:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:5b44]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec02bb3-b24b-466a-dcdd-08d7f2d60997
X-MS-TrafficTypeDiagnostic: BYAPR15MB2358:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2358523606ED30454A860A29BEA50@BYAPR15MB2358.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJ4jHD3vT1zMwzlBVYmLqYH27KOaxTwXkhgrV3VC3qzSWNpK3R6+5osE0Pa/WUS0f3h5j0Fthj3fq3Pm6jPGa2Ux7QFUZ/Ln3jlNF1xQ7OqsL5jxOBC/mBiE99m+233WAp3DA0i0S+K0aIwAXL3iq7WLmdfTKoByc7yNUb3Ownjj02bhjLWeFRpTwVyTndiO9QLOgYBVFxqH+zX/fX9IS0Tvd1+0hvoLXmSoT7sF2DlXsqfpoo18dQy5GTmcv7TQ1IzyBI1cEDioPZQN/AroX15A0TdN2lHSsNhCPU8TCquYGMkD5Tnk00OBZfkGbWn+3k7K1PutCJiQDt+8TT7P89UexK2aNNDdQUD3eGksQL0ZwNVrprhK5+pJ4293upoEj+cz/el2+tWsFqmtmtIjVf6ArbiQ8VnVhkkOqGvsZX9jAYmwh/3N0q+ud3Gxkl8hzjKbY+EczScF1JXTuUTooAAAhSv3hbNUU1sKKVF+aPLDhoRY/x8evMt8RQhzUHR2PBn8L36MY/PrCdkoy6IJGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(366004)(39860400002)(396003)(33430700001)(33440700001)(66556008)(66476007)(66946007)(8936002)(8676002)(1076003)(2906002)(5660300002)(54906003)(15650500001)(6666004)(6916009)(33656002)(6506007)(9686003)(16526019)(86362001)(55016002)(316002)(7696005)(52116002)(186003)(478600001)(83280400001)(83320400001)(83290400001)(83310400001)(83300400001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 061DS4Um+xcFsFCfPxwcP8uDt/yqPEDn7ORRF7UpyFMEZi1SPBSo8lQAGnYC4XT+lWnzgyJwcxHIOavUNizihkt3F29//R+kpq/AsNEn3tl6qJo0OACxREsBdsF1EQ0EfFTP3+FGY/676Wy3fRv/p4oAsmlmP4YbWkWsMDu9js0Okkhqd+RutHydC+ctiiqEpAOtcv3GfbO8HaD5McxByNo5NL3t6TG8GlFEl3vZXHUHK1RqJpqWUd2foXfoUU2BSGenHRs4ShfLTqapDvoLQXHPN9tMx9gk8S2zeo99h7sYWgfNEik4yvLRcZwAe+6B+mGgkQlnxwQTBTpRzFQajbhQM9v+7BKukAonhdKLros/PQi9m2KldKqjfuJJ5mkqOkdSnBkUXK2A3SsKGF2wQ5Kv6vYLM+AWEPoF1OkGJOK8c7tOh3z2tXfAQ/zSOXia14LRrCNWXcUM/DiY1h7g4qL/cdNoayP4I+F+Kp3Y3e/p10VfgGVby3e1Q2pRsh9B4DrINMNH3ax58VQBW2T9/tAAS1rKZfZkx465vltILb4Erd47BXboDknODtiH3IRUmhD5uHWDCcs+/vzsHPQ0RcnfwBeozkygQXFfHX6oa6Tq3HrJdoeU+FFLX3A0L+rWWP+ZUHZq2xWeBM0SDQv2SMwTUS3tzEumA3BigFTmTaKlst01Cs+AeXCuxcJ8Xqb0ShedGsDVzM/QF82dKYzkI+htQpMn+9Qaef2d8R0XoZD7lN4HkkOQ1MlCyLZv2FPBUefZ0yoxWbKySSnkXZDgNe9W21jliZEA3Ww3Sa1uP0PX5m7RT5QUwNpk3ertGN/IXlZXDO7eaPNNPZccg/npRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec02bb3-b24b-466a-dcdd-08d7f2d60997
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 22:29:00.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZKmVd8Otv5Mm/c/yK8OE5HSSzU6DgnCmGH8SoTnkPpwPVuCqNhgRnJEJSRs3Uxf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2358
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_16:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=976 mlxscore=0
 bulkscore=0 suspectscore=1 phishscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070178
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:49:13PM -0700, Shakeel Butt wrote:
> One way to measure the efficiency of memory reclaim is to look at the
> ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> not updated consistently at the system level and the ratio of these are
> not very meaningful. The pgsteal and pgscan are updated for only global
> reclaim while pgrefill gets updated for global as well as cgroup
> reclaim.
> 
> Please note that this difference is only for system level vmstats. The
> cgroup stats returned by memory.stat are actually consistent. The
> cgroup's pgsteal contains number of reclaimed pages for global as well
> as cgroup reclaim. So, one way to get the system level stats is to get
> these stats from root's memory.stat but root does not expose that
> interface. Also for !CONFIG_MEMCG machines /proc/vmstat is the only way
> to get these stats. So, make these stats consistent.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
