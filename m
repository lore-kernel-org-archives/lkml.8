Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B68020786
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C9X9nH2K";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BgDyUZvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgFRTya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:54:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728960AbgFRTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:54:28 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IJpn1k029131;
        Thu, 18 Jun 2020 12:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dcqvG26RrqnqezZ2klNiFwkeFMObt0Ollf5WmHyyZNU=;
 b=C9X9nH2KgnM0Yjit026/mzIKsTRiCUwwhB9Do3ZV6Mad85BBaSX8lCz/d/Bj7NB/WF6A
 GJl28XiJ0mqsULXBQCPG14Kvv8mglX109ryZvR8K3qaRHKjh3XZdX8qJXb26+ux1ak77
 KfdWTxf9V5FSN8pRTbFRY+tlGiqX501qxN0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660x5qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 12:54:18 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 12:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDAnZWiTo7qngR/9axSFwj5k4eURyTa07m/vFrPOyaomqmUkOQivkTtJKdJBFI8G5eixiqKXIzDq1z3i86w0RmRfInAq6b5ymKTNYb12Ket7btgo3GYZ/Q30BmHK9RDasBfRJZ6iW+AjZ739t8LikjBrGzY+m56LXWo5WwSHsqSK+WanvHdp/heozTRM/bRVxvIvJTwYIVDwZyJeuOe3bXAYT9TheYJxHMnI2MZVkfQXkAxjkptpM2bwB2F6wqxR/fxicANDFESa/uOd2iUNMOgCmuLFe6OxbUqmpSghsjbVuYpLdaNkdUyyIrn9AZ6eAZVAa1VAPS/M8Y0HgXGI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcqvG26RrqnqezZ2klNiFwkeFMObt0Ollf5WmHyyZNU=;
 b=KTh2SWlo7/H91lkkwcsXuxhodNjH3YZM7NSG6Ri5MiagA/g9Js9BOo/0wXKs8/Og4S4BuFD7Stl5Xvbx8kKYyU+++HwjcugyEkScmSeaf0xIIEgxRSZMn450TBlj9ZpWbWJR/xachh1RNsClvxcoI4ZMSjic6ebp9hU1Y84SC4IfI/D+cvBFxt3QCNd3M4lmSmXPnibAIup2jyD8cIz7KaXXDigECLOrfHb4ssKTVnPSZnlSSpXVjPnBjufsZ0LHcjFwr8niOKKeQixvcmPEPoWQZorfomMHYtMTfxgidwnPXLR+4cDvRRS1Scyp4eovhuVZnKsqnRWZ734RdzXEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcqvG26RrqnqezZ2klNiFwkeFMObt0Ollf5WmHyyZNU=;
 b=BgDyUZvF+H4A11Kkfj99EJ+bw8ewDzL/mWfDqhdPFriBuCpEVfXq0w+ns9ENHZVBoZH8mZz+YLz6yhWr3UBVvj8x1BGlNFKx4gQwIlKDhbC0M7Nk3GJdZyy3lE0neDgWP9xe9feFPJcZDKrohg6Kwy+AZs174dC8r9JmUFZ0Lxo=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2934.namprd15.prod.outlook.com (2603:10b6:a03:f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 19:54:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:54:14 +0000
Date:   Thu, 18 Jun 2020 12:54:09 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200618195409.GC110603@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <20200617163528.a4477749b172c387e01c3996@linux-foundation.org>
 <20200618003515.GB24694@carbon.DHCP.thefacebook.com>
 <36879e8d-dca7-caf9-71d6-918474ace53e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36879e8d-dca7-caf9-71d6-918474ace53e@suse.cz>
X-ClientProxiedBy: SN4PR0501CA0146.namprd05.prod.outlook.com
 (2603:10b6:803:2c::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:632d) by SN4PR0501CA0146.namprd05.prod.outlook.com (2603:10b6:803:2c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.13 via Frontend Transport; Thu, 18 Jun 2020 19:54:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:632d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea33e633-b0e7-40bf-1349-08d813c160a9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2934A0731D72923BE379C1DBBE9B0@BYAPR15MB2934.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTP9ya5OBKHsshrBuYL62yfyIgwOtnIBVImIVWWJpyRP7Wlu1uVJg0oSHDCPBnoTX4vHx726sp9Am9KdI3txV4cd1ph4D/tCLdkpBsTtkr9NYMA4VhI4+thE/l2h9b8nAR1ZZMyOp9F/Jjc8LERZ1c9wNXTKxjPe57BNvsIjPvTSdeEqT8TDX0qWozzJgz5EqHx2ZzdX1Padg7gv7wCrUi0dD407wFSkM+0mxdBPsgjphx0YzrEUBe9d5PRkHgjBwMg5tHxO5fNzvDLjStHoRezYpaNtunh7a8R+wUKSE28BD70EIqiydaf+9i2THN22ji0DcXlaxTw6X+gI202J3dBiLDC6A3nt1Z+XGY+AecBghpmFp9Ya5gVyn0NzGo44h+sotb1yXcEmo3B5L51+1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(33656002)(83380400001)(8676002)(4326008)(316002)(478600001)(2906002)(52116002)(54906003)(9686003)(7696005)(8936002)(55016002)(1076003)(66476007)(186003)(5660300002)(6666004)(6916009)(53546011)(6506007)(86362001)(16526019)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3pIkSdcBj/CFv3nb2Ij+gy1Wx4LV67bRHHeOLBsYduC6vudoTKoDMkk/qR9k0z5tivPKU9DJWzfP/IMjiMgujlsD0OCAxREy6nWp78VQklmkiJeH7vPwfl8fsfKKmVGNG9X/Ybph/mdbCDxjqkBoJ3ia1aJCqOQLbbrUVj5AN3ZfRclc1S0d7RmxSs0+azURcX1W24D4CxLEQJFZjIqsP7pxJQYLEXO0yrtMuOaB3w35sS1nEdxSktWJkO1ScJPqrwtrVt6cJnEW9ET9c4Ba42fk11dmWOkZc20aZB3mgJ/uwkSJqCtjrVjRsF1FCXen3uIDre12FyronKoNzqN2jWeCpGnMST0xf4rktBRyZSibSv9xoPkFRrxMPu4NjqKw1UZftW3rIFAJAr/S3GlcAdGLgE/2yWcuRggk2DkytpFaI35V9Rhl138AXXPDBrZZQ3DoUL9W99xj5g5Xq3amDLTPX+XYjuqj/y9Y0QoSMSQsgYa43rIVlCUUR9ujXG1Np9mnJMEy62J1fHPe5/h8iA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea33e633-b0e7-40bf-1349-08d813c160a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:54:14.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEhuiRdUR8Rrep9mepmQOhhHuNoVb2yOeCYL/lRBTwzWKoWQMFiE1H8WdVOrAagM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2934
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=898 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:33:08AM +0200, Vlastimil Babka wrote:
> On 6/18/20 2:35 AM, Roman Gushchin wrote:
> > On Wed, Jun 17, 2020 at 04:35:28PM -0700, Andrew Morton wrote:
> >> On Mon, 8 Jun 2020 16:06:52 -0700 Roman Gushchin <guro@fb.com> wrote:
> >> 
> >> > Instead of having two sets of kmem_caches: one for system-wide and
> >> > non-accounted allocations and the second one shared by all accounted
> >> > allocations, we can use just one.
> >> > 
> >> > The idea is simple: space for obj_cgroup metadata can be allocated
> >> > on demand and filled only for accounted allocations.
> >> > 
> >> > It allows to remove a bunch of code which is required to handle
> >> > kmem_cache clones for accounted allocations. There is no more need
> >> > to create them, accumulate statistics, propagate attributes, etc.
> >> > It's a quite significant simplification.
> >> > 
> >> > Also, because the total number of slab_caches is reduced almost twice
> >> > (not all kmem_caches have a memcg clone), some additional memory
> >> > savings are expected. On my devvm it additionally saves about 3.5%
> >> > of slab memory.
> >> > 
> >> 
> >> This ran afoul of Vlastimil's "mm, slab/slub: move and improve
> >> cache_from_obj()"
> >> (http://lkml.kernel.org/r/20200610163135.17364-10-vbabka@suse.cz).  I
> >> resolved things as below.  Not too sure about slab.c's
> >> cache_from_obj()...
> > 
> > It can actually be as simple as:
> > static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> > {
> > 	return s;
> > }
> > 
> > But I wonder if we need it at all, or maybe we wanna rename it to
> > something like obj_check_kmem_cache(void *obj, struct kmem_cache *s),
> > because it has now only debug purposes.
> > 
> > Let me and Vlastimil figure it out and send a follow-up patch.
> > Your version is definitely correct.
> 
> Well, Kees wants to restore the common version of cache_from_obj() [1] for SLAB
> hardening.
> 
> To prevent all that back and forth churn entering git history, I think the best
> is for me to send a -fix to my patch that is functionally same while keeping the
> common function, and then this your patch should only have a minor conflict and
> Kees can rebase his patches on top to become much smaller?

Sounds good to me!

Thanks!
