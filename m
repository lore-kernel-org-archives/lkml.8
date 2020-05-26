Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E45C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3492070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Wb1IEIDg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dFpyAF5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbgEZSut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:50:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388499AbgEZSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:50:48 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QIjNF8027385;
        Tue, 26 May 2020 11:50:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1m7Bbv9tsZFiL51h2P8yYBH9DBbgwbQTAl3ElngHTRo=;
 b=Wb1IEIDgtXaxZBO2wgOZtKQ8CBqAYxD75fI9cdzvkWIGwPkmgY/BQTHkbxE14gHoXgFX
 Dd1LFec8IEVoPIkv8WHNiYKMbMXAzqcet3LHIV1zhmnOQXeHBJnjEVwpKpEaOOMFAPpX
 krFjVH6YAS38D+hDEiQ+vKP9PsywJHGHcGw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 317kp3mugp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 11:50:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 11:50:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxkuJsI9lXlL/aRE0JB4MVrqe6XC2PH2qvnW40i1jD2BU593MZrEE7vjwRGUiAA2xA01e553cju3YOvhmd0CzjDM9sNjDE/ztjNsncpDKtJ0bWK0jWh1VpjDfB2M6O7lOZbEgKkshuspON+9H45Kdt+7O+rTqXtzxfu59AgrJiefwMk9Jx1uvEI4uG73K+xTITnkh7CfDAmA9e6liEqOS44WOlAtxvbUYO3R3ONJMDPBTpxUntEgAk4D5eqSzC3v7bDrq6zypK8F2xPNm6knq+LrYLOlXvMLiIHOGqP+jxCxE2/jGe2KKdIyYHvRYSFsCqltqEo0NNqH77sxLVhZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m7Bbv9tsZFiL51h2P8yYBH9DBbgwbQTAl3ElngHTRo=;
 b=AXnJFMTKuC3A14MD/OeIcfIqSbB8pHHy2AOIBadtRphdHZCfaGktbILk6B6aT00Smf7pG/BrZc/uz3lZJkzO2IxfGWCpWqeQgD9K3nga2qTCMhZ2bFCEnHq1wmx8fn4p+Ldzi2oTqObI40IbUYOEiqhYIs42mPzMko6An+YYuLn0mW4/f8W1pWUcXDRBeZnOAhUKlSvLavgcvu6BnLyQmw4fCpui6vSXHEWoadlorqwt3EyhbA4NZK0clpM0QA6+nmajgB3FLi5C0fDHd+TJafDNatfRcQWGQmgoCXncmMb4kBImZg3u40RqON79Eyz276PtV/35SRyoJKjwmJyIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m7Bbv9tsZFiL51h2P8yYBH9DBbgwbQTAl3ElngHTRo=;
 b=dFpyAF5zmx7hFr2/jbs5Hpd5wZpbCrie7AUb+v3QpEMLZTa4AXwCr8aENyrLAJEZNUpscR5A0ZSpZcMBN0dokqOUYimxv3/MjlKm9VrCHjaVdtgFzSbq9/CgY+INUkCV5NsiKzJnEj5NZP6H3ylmqJuCEP8NbQJKobNc7knaBMI=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2175.namprd15.prod.outlook.com
 (2603:10b6:805:d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 18:50:37 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 18:50:37 +0000
Date:   Tue, 26 May 2020 11:50:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 15/19] mm: memcg/slab: deprecate slab_root_caches
Message-ID: <20200526185027.GD377498@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-16-guro@fb.com>
 <613dda66-4fa6-1820-50c4-c7b28235e687@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613dda66-4fa6-1820-50c4-c7b28235e687@suse.cz>
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fbe3) by BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Tue, 26 May 2020 18:50:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:fbe3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f453e38-15cc-428a-9f47-08d801a5adcd
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21756D7A9C369155FFD0C22ABEB00@SN6PR1501MB2175.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MMWV6FU8AGSkFDXhCi0trkULPbiK4+WjFpiwGimOwabTsRbIEYHfbpigg9a5o8uL6H3Mr1HC+gqGwCzu6rqi2LKsQhstQLGa8de/uIMDIPiEdWFhNt4tWPiZgroi/9Bx7PSG2XnQ62DCjr1YG8rFaqF3WigkHFd+llMaPigZg2kjMyMhtN2TPo4G9xtYsAr1Wy5BlsaWwXKE3Lq02pUmJP98XJKd21rN4hAmKbQyS5EA8aqB+6X93l7X6TwslDLGxjEiieN2PxdRVPPBBgJTM2FrATZGPe4lUIFQcViVNlhUlf78+EmcHaUkhJrnGwk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(6666004)(86362001)(2906002)(316002)(53546011)(7696005)(52116002)(5660300002)(186003)(16526019)(54906003)(66476007)(66556008)(478600001)(66946007)(8936002)(9686003)(4326008)(1076003)(8676002)(33656002)(6506007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KEZns79DQf2qCq3d5Kdu9LcRONNKaVaRLW+uPn1uKWKHxHaH4iAsj3nnHMLDs9Zokhms6ICIBOkrFXDcqCGo4jI2b0+xfa4QRVzbVCQc5vVWk+rfvBSAgoNtxaBmaEUeYMVYMDHBKLyFxowKL5VTQC0BSGXHBW6Rokb83jlUTkddJDCFpGoGK4dOGsnm0KfzyIUxQODzKO/UPlz9hla3C38zajiD11icX0s63kxW6Ui4eKxXlNWb84SraCxcVulks8bdFYuSLYQPLiCfmseXkfJn0vTYNCmleAKJmfVL5ptlvz9CySLL/KchXQ+yndJv6uC+UNWCpFF6Enc52QakSggxZfudJaw9h9yK0Q6Nuwqd/CZZJ8zMcBgWtzKbI//04AgMSenriJ8A7xXh8sQONYmAewjB09oIOjGcYqPH5aEVC4265/pRKVW4PUEQngRXjWioxmpZTIe6tVvkuUv0C/xXFuJKiP2t0lgQrrus+xbSpw98IL3+3BcR1B43z71i+XRvTDbQ4gNVgsYH8rcMHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f453e38-15cc-428a-9f47-08d801a5adcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 18:50:37.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFx/NbV0uvdypTedtVE2RjJ2CMe8A2CySFO4V3HfIrAJEc+yM+jkaNw2huiL1hhA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=759 suspectscore=2 priorityscore=1501 cotscore=-2147483648
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:52:24PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:47 PM, Roman Gushchin wrote:
> > Currently there are two lists of kmem_caches:
> > 1) slab_caches, which contains all kmem_caches,
> > 2) slab_root_caches, which contains only root kmem_caches.
> > 
> > And there is some preprocessor magic to have a single list
> > if CONFIG_MEMCG_KMEM isn't enabled.
> > 
> > It was required earlier because the number of non-root kmem_caches
> > was proportional to the number of memory cgroups and could reach
> > really big values. Now, when it cannot exceed the number of root
> > kmem_caches, there is really no reason to maintain two lists.
> > 
> > We never iterate over the slab_root_caches list on any hot paths,
> > so it's perfectly fine to iterate over slab_caches and filter out
> > non-root kmem_caches.
> > 
> > It allows to remove a lot of config-dependent code and two pointers
> > from the kmem_cache structure.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> 
> > @@ -1148,11 +1126,12 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
> >  
> >  static int slab_show(struct seq_file *m, void *p)
> >  {
> > -	struct kmem_cache *s = list_entry(p, struct kmem_cache, root_caches_node);
> > +	struct kmem_cache *s = list_entry(p, struct kmem_cache, list);
> >  
> > -	if (p == slab_root_caches.next)
> > +	if (p == slab_caches.next)
> >  		print_slabinfo_header(m);
> > -	cache_show(s, m);
> > +	if (is_root_cache(s))
> > +		cache_show(s, m);
> 
> If there wasn't patch 17/19 we could just remove this condition and have
> /proc/slabinfo contain the -memcg variants?

Sure, it's an option too. But because it's a user facing option, I'd keep it
as it is now at least until everything will settle down a bit.

Thanks!
