Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A184C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0322B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g1NijGZB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iazXJu4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgGBQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:38:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53130 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbgGBQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:38:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062GJtNu021223;
        Thu, 2 Jul 2020 09:38:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NvfHU6vKIIveNubO6TscQFzZUq1H9mUtnca4g+5NixE=;
 b=g1NijGZBvrf+rkDRueOoFZKkeytCYy0cb/R/Ruh+hl7OmRiIv9C1OT2Oen0sRDzYoHQm
 RQdcwQxzO0Y5qaH5CT+Oi+JlYoXOmSxrbCb+XDyQI2X5JZz6zy82MCcQV0ZA/OyNR6Va
 UMCwFSrrDrRy+OMMkKoZlWiqErFsyKX73RA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 321fwks3f5-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 09:38:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 09:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA0y4qTQEzWQflpSOuI0Oig4FpBYLT9zlzAmiGruoKGQ6gkdXoFoopN+tKignTfOsRnqPrYNMbg4JnPVDK+FgHqXkKXojpCYWSawCwUg77NwYnnhIXZ4iPfjie+He1dhjzlABUVebVWwKQw2Gxj8hxvWG30TZqDL3Z1Wugef9NEiuBk2Cd7okGH3kkMxLFNNIbVhT0F2wzU4Rl7PUzD6yVTdxmr7697pnOl4hUXzB1BxVPqAvvVV77/K6mveB5nm/juljSLdFtBst6ahW6CLSYIdZa9WWE9AqnPYfbcTeydLM9JRG/P0PmqFwEAa+8ahb9KVAoN52uTkKm+P+/+4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvfHU6vKIIveNubO6TscQFzZUq1H9mUtnca4g+5NixE=;
 b=ndjYbnykcBGs+NNNEZGeXWKN/e536omnoCFRrwnYDWcX5Sq6PoQWEsw/r6H2kKypA7OdJay2GrdNrO2LwdsXl7NV35G8Zdugp11rIn5odL8qsFQ13W/DPy+MKQa47RYDqD9Z0e2M5f5IJTyuSD1s/SuMvlqmyZaMF20Ia0lWlpcHsecQkzMvn1HnFiMOFhqMXTF/I3G+6hjzNpaT/oSyPwMmEQKwQy024icXAy2b47DDNU0JH7QWKae1uNZ+FsCL4HbXyy66epGrPYLynh9Q8uJzhXE7gUm065GDXHHVQo2p3iem1G8E8NXIwt+qrleMuZrV7pOldHvT4dJ/pKVFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvfHU6vKIIveNubO6TscQFzZUq1H9mUtnca4g+5NixE=;
 b=iazXJu4wqsK7YPts1aMq2M497lAS8EWQce1o4VIR37/Ha/xMWRRQVvNgbtOBU8Du+SVqDTU5mJonb1Ew1A9+jy+6FRd+rOjHvNlgpMU4qDM5iTbpsSQVOoJBghywFzy2ypwXQKftNZbytykjwgSgjLblm95z1BNAIIRDv5hw8Ug=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2869.namprd15.prod.outlook.com (2603:10b6:a03:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 2 Jul
 2020 16:37:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Thu, 2 Jul 2020
 16:37:42 +0000
Date:   Thu, 2 Jul 2020 09:37:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702163738.GA106423@carbon.dhcp.thefacebook.com>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702162202.GI18446@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b0bf) by BYAPR07CA0020.namprd07.prod.outlook.com (2603:10b6:a02:bc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 16:37:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:b0bf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbd0cd17-2d91-4714-0496-08d81ea63d70
X-MS-TrafficTypeDiagnostic: BYAPR15MB2869:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2869331CD5D65E6E878AE295BE6D0@BYAPR15MB2869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPr59W3uYWS1k1IbFmm3TuZbiqK++F1YbK2ZebveFysMJ3fZNSdnE1n9neH+ByGm+eOG21TVd0d0nN/3sX3/JcRTDaUrNQWyUOydozbo6gmvT0IzgFlciY/flxQz9Ea2dBRkEhO1qf7yqfIpNYqAjh2PvGsYRJ4E9ItMYYZqDuyyDTmj47wgjbGCPTODcHRFPjGzyCMfB/gnsk6m9/MPs3onXmX2cjQ3oS+tI3Ea+Z1kUbHqZYJE7SuX76bo38yIzrIn/mIyxMr3uDSTQP5nyy95vJPNYO6WfNVL0t1/jTxo86G55oPxj7KymQx9wkc+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(346002)(136003)(39860400002)(1076003)(9686003)(186003)(55016002)(66476007)(66556008)(66946007)(54906003)(6666004)(316002)(52116002)(7696005)(6506007)(83380400001)(53546011)(86362001)(33656002)(4326008)(478600001)(2906002)(5660300002)(16526019)(6916009)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: n/MTSUpiYtXZmH291J+fh8i6bHuzqJNrP/2UJcv1VAfoBZQ3PcOYpw15+HnzazNcxWlS3f/yE2zQfNvYNDxngUUaNCU9otMOVkmL5J2Z7FhweO1Yw1xnU+vWv0IbcSU3vDyFAprqITQGLuxF3l3GGuLKH7Z7VuiLwcZ/AgW2Mv8cvKACnwXla9u/6SuFHqI9HbQanUT/XaogRDI8XPhCps7BCzSBGVFCeMktvCdl0JBZquKLsQQQZnu3I5yLmo/Fa4zpY4V8YRRq3ilNkGaQ6nRuWJxFudY6+/sRmaBXZ9m9iRrELXjm74W5laGt3rivRcRu4lINTq//ibb6Gn3HoiSkLUmEbo4sNN10O5I7jfcGjZe5oFMbV/qyJqUH6/NIU52kCC5d3dUixUFjKxPNKOdcC2TF++U7jvstz9YfJZaXHfLPfkEMAYTvLuUN87CDucfcl56ubPcjUxoem/XJyFmWaUDR3eII7oJTf4gFmGtCX8FCb8pW7mLBm8DXZe+5k5MMmFtDP+U+TFdxRI3LPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd0cd17-2d91-4714-0496-08d81ea63d70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 16:37:41.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0OOPOM5EuvYXJAudMXw0VM8ryEYpng4RAeDXQEvHufVM0irJJi7wRhSFVEkMtmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=1
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 cotscore=-2147483648
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007020113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 06:22:02PM +0200, Michal Hocko wrote:
> On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> [...]
> > >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Wed, 1 Jul 2020 11:05:32 -0700
> > Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> > 
> > Historically the kernel memory accounting was an opt-in feature, which
> > could be enabled for individual cgroups. But now it's not true, and
> > it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> > user has at least one non-root memory cgroup, the kernel memory
> > accounting is on. So in most setups it's either always on (if memory
> > cgroups are in use and kmem accounting is not disabled), either always
> > off (otherwise).
> > 
> > memcg_kmem_enabled() is used in many places to guard the kernel memory
> > accounting code. If memcg_kmem_enabled() can reverse from returning
> > true to returning false (as now), we can't rely on it on release paths
> > and have to check if it was on before.
> > 
> > If we'll make memcg_kmem_enabled() irreversible (always returning true
> > after returning it for the first time), it'll make the general logic
> > more simple and robust. It also will allow to guard some checks which
> > otherwise would stay unguarded.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/memcontrol.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 50ae77f3985e..2d018a51c941 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> >  	objcg->memcg = memcg;
> >  	rcu_assign_pointer(memcg->objcg, objcg);
> >  
> > -	static_branch_inc(&memcg_kmem_enabled_key);
> > +	if (!memcg_kmem_enabled())
> > +		static_branch_inc(&memcg_kmem_enabled_key);
> 
> Wouldn't be static_branch_enable() more readable?

Agree, will change, add reported-by and tested-by tags and resend.
Thanks!

Btw, don't we wanna to change memcg_kmem_enabled() definition
from static_branch_unlikely() to static_branch_likely()?
