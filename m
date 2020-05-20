Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6AB20884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YGRJUUNb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SkBoT2yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgETU6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:58:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbgETU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:58:02 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04KKuCrp022013;
        Wed, 20 May 2020 13:57:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tL/FM4Kml+MyM+TpNOARa/W+m/BaiawUCFoR4cCQrAc=;
 b=YGRJUUNbjCUQdKMV9Xl1+n/lnu7kb14IigjMk+f8ba+9cxY0IjHPfwoaLu4dytAnC+ZV
 jEThFTlWRPce2Wu+BTJWq/xek2ZhHwJ5Bie3LT2ZK3wESNKVkOSWcf7FAwm/Uue4Ll7j
 8e576AAOWYN4RiHqVN6yuI8lTN6blm2QlFk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 314h2s0rrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 13:57:52 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 20 May 2020 13:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH7WW4s5R63n9U2DeNoCSpCoKv68xar75azQqpnh1wlD7SV7DLqsSj8K/haFAgEIu4eGZ8CZ4JGKI7BXONnA1A7fpn0ZFwgbZsN3d7lBx7vlXbpeSLgiq08jacIdXROf4fJPL+Swd7543LwiiY6l7Guzb531leyyNMQqlx3j8aQk/dkp5KtD+GgsBOgoJMYwq2/EOACvdKhtx/Ge609wn5OtO138zi3288OjJijIj5zuUlOPlKsfEmWEGU7xYNv6fgAI71LL0rUA09f6M4EGLowes6TnR6s0E1QnLmVn6dO42JxpENs8FJdz2U4qaXv+R42aBf/UkDhRfcOaRq2Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL/FM4Kml+MyM+TpNOARa/W+m/BaiawUCFoR4cCQrAc=;
 b=XOm5ouUWfAn2ac1dlvsjhHINbIj2IJETfMlA2P3x68RGT14e1YyN5eipGKXnpL9O55bh3lBHYDc/jCo9CrkWfHUa+H6ZLyLRHLFPw9gs2aq1ozqxV+vVS25/bJldhBQ95zL+UevSw11fYkdE8Z+gkLf/6rwJvjDApT5CKhk4MCxngpgStJ1/2YPg+wUrDgBpy1oMhfwheSyKFQGZZYRZgUTI54VPIdVQbGd5WH/ZhWjacRhfQ1/xtR0DP7dRslYz43/vg7fYQx2jorW+O59mhkvu9ZDd6BBVv8dLwrQnT25Fc8Mb8m5oVSizqpQnPX4P2uHXitAoyBkHU2pS1PsZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL/FM4Kml+MyM+TpNOARa/W+m/BaiawUCFoR4cCQrAc=;
 b=SkBoT2yk3RgsljhJj8R6zn37/pczzpTTUOXYgfCJAG73tBYEmtsOdd464ViBTP5p1Rjw/+WPAz5Ii3cfI16imk3LWmcZ/9S+VlucUp1ZuOz8eLt3GJhQ/N0G4bzOUT2Q53nY5zm7QbWK6jadfUzRNw8x7vaT90KLQAjcAIEQnxc=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 20:57:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 20:57:48 +0000
Date:   Wed, 20 May 2020 13:57:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200520205745.GB278395@carbon.dhcp.thefacebook.com>
References: <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
 <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
 <88972cc2-2120-4257-ae8d-141e014c54e4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88972cc2-2120-4257-ae8d-141e014c54e4@suse.cz>
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e80) by BY5PR16CA0018.namprd16.prod.outlook.com (2603:10b6:a03:1a0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Wed, 20 May 2020 20:57:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:e80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14a174c-0e8a-4e8d-e0f3-08d7fd0073e1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2263DE1959921EF7A264069BBEB60@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OC6dFo1NoKgzctZQK+bdBayeYrDb15av88WtthSKtY+qZtZUUTDrhvs8RzunAQXoTLbXIbY5zX6m9dS/mPf5pnaPHa4oUmj/xEUw1jXE7o1GlJ1iygIQ2yYZIRRB85AJWXTqYZUAFJ09W0ZGjlr3ym6XwpVABdN17oiYCwlyRUrLk1yVglpUOhBa07XI+rfnsz1FFOL57n1WdJ1CQsZvfwC/1tqFGy+yinXF3HxduuB4zjKKblDu8KOtOaBf0nZ6z5+YQAesrFG2ECEi0ttUXf7v3emTwkTJMXiQeiceoa251OKlhgO449W0dmgvj5bk0RgXOMTZGi4UFsmEYHTB4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(86362001)(5660300002)(8676002)(316002)(2906002)(478600001)(8936002)(6916009)(54906003)(6506007)(7696005)(52116002)(55016002)(9686003)(53546011)(33656002)(4326008)(66476007)(66946007)(1076003)(16526019)(186003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: afD53kIS4c6BIhskzPb1Tf+US8wBMI9Tp4w4dYQyOCxRaUmTEPmfBCK+pgB0CqSsGqzaYrevRcxCb3aJIkah1gjWst9EAkOHppwYN/nOLIMSaEqvTf5IHkc0oMYoVD4MqEEALPz4SqUdt1JtOOKi9V77PI2tt+m+z1Z8rf7VOiP9YrOCMbnQy0H6/9CwVOVltBPZ5TXqOsVM3sJU7Gu+/h5UQtTTMcPE/4jVDFeCWppwBQtCcm5HdjfqlG1wJ1Iff2Sxt4u8rwddBGkftQaVew9kveMSMgv9VzKnNh6uPIm6ttEvPseejC3jyyWbXPxR4InyKh3CljS0Yy7c6OWY714j9AOA7fGzs0dgXirLrau66Xnfzfbspjw+AzGm296EyAaRaSaZ+MW7LpNHnMK4m4O2FTx+n0/Fx4Gx/gpYe8hRDSeytoFWat4tzQVmRzX2dZ4ctKZLC1OwXiw0doSNRilJ6PP8v4OLdN8jJ/UPyqR8dwr7wb8mFUKC9Bdqg5TQ7SKQPvfTK9IazOquXvmG1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a174c-0e8a-4e8d-e0f3-08d7fd0073e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 20:57:48.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2lcqz8gyyq3leCWWixc/GbziA+OWHasPOBDTsDixU3GxHCfUTGHeOD5SN5VGYOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_16:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 suspectscore=1 spamscore=0 cotscore=-2147483648
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200167
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:51:51AM +0200, Vlastimil Babka wrote:
> On 5/13/20 2:57 AM, Roman Gushchin wrote:
> > 
> > Btw, I'm trying to build up a prototype with an embedded memcg pointer,
> > but it seems to be way more tricky than I thought. It requires changes to
> > shrinkers (as they rely on getting the memcg pointer by an arbitrary
> > kernel address, not necessarily aligned to the head of slab allocation),
> > figuring out cache merging, adding SLAB support, natural alignment of
> > kmallocs etc.
> 
> Is the natural alignment of kmallocs a problem right now? As kmalloc()
> allocations are AFAIK not kmemcg-accounted? Or does your implementation add
> memcg awareness to everything, even if non-__GFP_ACCOUNT allocations just get a
> root memcg pointer?

There is at least a dozen of accounted kmallocs as now, please search for kmalloc
with GFP_KERNEL_ACCOUNT.

Natural alignment is not an issue with the proposed implementation, but it becomes
a problem as soon as we try to embed the memcg pointer into the object
(as Christopher is suggesting). I'm actually not opposing his suggestion, just
want to settle down the memcg part first, and then discuss the best way
to store the memcg metadata information. As I shown, the required changes to switch
between different ways of storing the data are minimal and do not affect
the rest of the patchset.

Thanks!
