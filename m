Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691F220838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PnZslkgp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PldAtdaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHABVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:21:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56584 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgHABVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:21:01 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07115Kwm014942;
        Fri, 31 Jul 2020 18:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UKPT51l5qJ8/O6qIhNX9owY42XfY1mL/gZf3qiVoETo=;
 b=PnZslkgpdPmn3U98S71Fg+MEsUL1PbMfx2j1gVA+rBGjSmmPzAgHOz/Zi4CVrK2n0x5R
 beZXCv72Ed/5zX0ihu+iCAvKdO6uvSgHRKbP4YI7gT8SjfuVTR6odjUA8qHf5HHVk7al
 lQ9loIDJtdjv0Ikdjn1pXkehgWPRdcuz16U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32k7hwedj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 18:20:53 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 31 Jul 2020 18:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCS6y7wni9n2d39rfjmae2EkPaZzJrv5mDIT4gyD5paBrP4587oUhY3tYkYqX8KkmXvnx07fsSzAxxMoOnaHopxe0KOs+e3ljRA70rRPWNKdMDwlDWyIMOYK4bvxyfXi+t2xe5RA1KnQmRPGIUbT8Q/LKNLIOeYkxMPanAysoVD8Sos+XdNtX1jvRCPBejPm0z08oupZSeeQm9/h3ub7iSKYYZxBQRq9Le1pIpFzm63UierGrRvuoAqV54WghG8hZ/F0yolkJLN1jOW5Q68LnwBUT+t9q6jYvgz1OsgX+l5IctXy0tCobna3NWPWmZzu28swfTzz1/YFrAaa2Ctexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKPT51l5qJ8/O6qIhNX9owY42XfY1mL/gZf3qiVoETo=;
 b=IiEKZISHrpDu8QJxyawKMpilXcc46M2iXNxFvySZpt2co7CO85knq+pOTZ8MxVvmY3CFU8dkA0P1lGiT4G2i3hFop0uw32R7kqPqn0Ae9kXAnlgjqo4Q2NsY6yr0XLtcyD1fjrzPnAY1eqv3qbkD03y91P008LZ81SiUVMiIWDnFyuUTx8XfijG7NvqHrKZ6xrmw73B36hteErWblaWp1USz4VkLm89wKOCRK7Oklcz4zYAKZtzKPpCWtuyWNeOBhF2kfn9mbj9TnNs04V9I25rikVqOLFwQctlL3CpH644o1T5DZB5DGac9dBQpAP0YA9sP/7R1mNt7dEB6jUaCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKPT51l5qJ8/O6qIhNX9owY42XfY1mL/gZf3qiVoETo=;
 b=PldAtdaFT4vmTuS8DmSQjU/F4MYn0xjFaAYBrPaAvROetY8eKQ7DSNQ22u4GC+vewFnimSc5m2m7rWQbJBTvxhlFG9JZszzoqp8jJoW1P0Lf25Bky4WV0cEJnECm6EBZ9fQv6pbUiCNwCVizgkFaaNHLpWP+9TnX+ljqTGDe/q0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3128.namprd15.prod.outlook.com (2603:10b6:a03:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Sat, 1 Aug
 2020 01:20:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.017; Sat, 1 Aug 2020
 01:20:51 +0000
Date:   Fri, 31 Jul 2020 18:20:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mm: memcontrol: decouple reference counting from
 page accounting fix
Message-ID: <20200801012048.GA860216@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2007302011450.2347@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007302011450.2347@eggly.anvils>
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:562c) by BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Sat, 1 Aug 2020 01:20:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:562c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d79efb-a7b5-4b07-0e4e-08d835b920f8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3128:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3128577F7B24052BCE0D4814BE4F0@BYAPR15MB3128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qobPMiDXr9BpiF6EDPSSXEvC/FEtVfMorIqVOzlrxPWGELiupp7y+pqLMMvBW2BbDhIyL+zwbJrwCoXa5zJ8VcCXNB8F1UU6o2ra7PaWnbapeUkJtjyw/9c9XGFuA8fidI+7oRIlVPqRhThGh8IZI+fBR5hWyOqJVRBV+Zz/EJu6IGfDAgPczuOSnU5iSEdpWfugkfVq42SlpXPAPAeV8AOzU6FpuS41ewCKsbRKT6BMX1/PaolWbKXSdbeK5QWNmqTXocqxVEos+3/KJlodL+F5t7DKA27GParfgulpODrsmfprzUa0Y1DWaCG44Qm4Ayct2WlaCQrH7lFhdne3KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(7696005)(52116002)(54906003)(186003)(16526019)(6506007)(55016002)(4326008)(6916009)(316002)(9686003)(5660300002)(8676002)(8936002)(66946007)(83380400001)(478600001)(15650500001)(1076003)(66476007)(66556008)(33656002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: U/B56ma0W8+hnscCmieKzLzOg06fmlElxZJfaEpHpzhl4CK2up0MwVJ96hqQfMTtiv+uCZ67iR/AocsNtTWTpCP0ouMyhSLFM+Ws2OGSGtrb7dhnpz4kyjo3eslw1Hm/LCha8ZIudNyYdbmL38NmfNKpB01YJIBssEjUKOm2PAGC/7pYAs7WCK+1Z1K594DtnGC4mh63wivUbR2464b5285IptF1dz6ahCe6lXp4zT5EsBQkeIXN/xKHyaG5ss7DeeoGGHIoX5k5hcmag7q6EJDxd41zD74vEY6foxNwlrCHK094N+XuWWUR9xZIGlmRtxO1N3atwHT3vDLwqkmXwqtLkhkHKsfWTqKgXjC+rYZdfGoH3FRkXBBf/KsOCYaR4jQWlx3Qb1ZWjCNqCIWLKmjdd55T0am/LL6GfyH8sR7kqmAPCrmnbo8vstJA2X5Y/PId96xquLRCfnPuYKCCPfvdGsb68tEt/pk+tDViZfrZTxINTsQ9jx+QkyyF52ow+nzbvJV617mTqhWRfkxITGvUvQ8XHOrKBkNIdLN6DlYmw1eMXtqXdSyl8fbdebN2tH9U1exXfaaXVXjK55mX1EStLDUJTFdY+ZyZbkyZFNf1rza+nil1Jqjtan4ZhcetI6SCMID5ilfSgdx4RJ3gOBV3ewq5JDhZQTfnXTtsl9M=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d79efb-a7b5-4b07-0e4e-08d835b920f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2020 01:20:51.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYqjccSvuhzd+LC2xATA+FuOpuRBzENJMkk6DYOaPIPshSvukByRo//ZBZ0VAQ0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3128
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_09:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=7
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010005
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:17:50PM -0700, Hugh Dickins wrote:
> Moving tasks between mem cgroups with memory.move_charge_at_immigrate 3,
> while swapping, crashes soon on mmotm (and so presumably on linux-next):
> for example, spinlock found corrupted when lock_page_memcg() is called.
> It's as if the mem cgroup structures have been freed too early.
> 
> Stab in the dark: what if all the accounting is right, except that the
> css_put_many() in __mem_cgroup_clear_mc() is now (worse than) redundant?
> Removing it fixes the crashes, but that's hardly surprising; and stats
> temporarily hacked into mem_cgroup_css_alloc() and mem_cgroup_css_free()
> showed that mem cgroups were not being leaked with this change.
> 
> Note: this removes the last call to css_put_many() from the tree; and
> mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-accounted-allocations.patch
> removes the last call to css_get_many(): now that their last references
> have gone, I expect them soon to be freed from include/linux/cgroup.h.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Fixes mm-memcontrol-decouple-reference-counting-from-page-accounting.patch
> 
>  mm/memcontrol.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- mmotm/mm/memcontrol.c	2020-07-27 18:55:00.700554752 -0700
> +++ linux/mm/memcontrol.c	2020-07-30 12:05:00.640091618 -0700
> @@ -5887,8 +5887,6 @@ static void __mem_cgroup_clear_mc(void)
>  		if (!mem_cgroup_is_root(mc.to))
>  			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
>  
> -		css_put_many(&mc.to->css, mc.moved_swap);
> -
>  		mc.moved_swap = 0;
>  	}
>  	memcg_oom_recover(from);

Acked-by: Roman Gushchin <guro@fb.com>

Good catch!

Thank you, Hugh!
