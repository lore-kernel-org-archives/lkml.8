Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD13C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4600A20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hHXzLRff";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OgBwhS9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgFVSCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:02:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730281AbgFVSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:02:11 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MHuGvQ019573;
        Mon, 22 Jun 2020 11:02:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0CA59a8DtemSIalh7Ph72U1JASpBgG2ApuSeHSQzxtk=;
 b=hHXzLRff2d9m2EApKvTDoVb+5Zo3xhJvyLwNE2d4LsHPH6j44GXu07HbXJaFjFcHNGvp
 Q75Mlmoey434xkods99DCvjmu6aOIBzazKUb6vvYdzTZijN1SyYVe/TqyfcEchY5y8IK
 R9Zei/bCI0TUKVFoxgQz4n+pKKReF1tkRCM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31t2qpxq4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 11:02:00 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 11:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqFg/YEP47yRXmrxTl+6Zuodg6IPjOwfsTdWXA4dtvA86uo8gHSJpthLcjK5p1Lr2epQM1BKH3FKFa6bVVGgHzOQcauS4UOl130UrM4nuj8LOcOEipU1vBtaOh2lqVrrGOizUMbbs/Ij9M74XJ2VaoM1yi+XtplITYCsRGCXfj0UXLCLrx+NwseVrH1taytjp2tDSdB19agFqRE+DkF2I5kXrgdJEXnpZtYWeWxGSPxXfHfSh6jOxpKfacEADR/ujMbnGqYkAoWakjZ1HaokYLyGtHyUHuEyYHBQrx93/zMqMmj7/ccB/f4dR3XU6hA3uX1yiXeGhP0+KmXymc1MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CA59a8DtemSIalh7Ph72U1JASpBgG2ApuSeHSQzxtk=;
 b=RCXrPW9gr6/sP3D427VRVGyPXdWQNuBW128YAGYGx01TdsxKivDD8l7fwyTY+ZXL475pVyyJ1+pmJgxypwuHymCpEJ4wMg8xCdswEV0+rcsX6y0RJiXiMsB61qewFkF0q4JEPqgEPvsAVg9yJvic8CnvEM3X0UbSQ75Fsa5MFjd6nFGTpfYf0JiHMRRQ1Nhw3r6Zz2sr+s+D0MJTPC13zX8aYxA/CQNy1ADbb+Y4Jy1MiqeNMjU4eCveEoWtwtCEFK1MdanJiVO8+SKmsWbByNDuitST8m+1jc8fxsnmVaezLdCHMorgVrjHam6lTVRbreXkpIbK6afR0n+Os+qa3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CA59a8DtemSIalh7Ph72U1JASpBgG2ApuSeHSQzxtk=;
 b=OgBwhS9SpPQemoN0rAwQPj6olXYTI1lusBlfpOWx8oBjTS0Kt17lUIWR1zs6duegp1U/BexSf0oIiZn16j+alx5z6tUpTU7ovOi9fBnj/QK0B8aHTit0lIdvvi0OYQXFe/IQj4e88bo6JG4QXDXAJp2R1Duj35fEJnYxyjRM2Uc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 18:01:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:01:56 +0000
Date:   Mon, 22 Jun 2020 11:01:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Message-ID: <20200622180153.GB301338@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-11-guro@fb.com>
 <CALvZod4Bfx3j+=spRSct5_cBL4U+XFF228iZt3EdkGqf4kokrQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Bfx3j+=spRSct5_cBL4U+XFF228iZt3EdkGqf4kokrQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:88b0) by BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 18:01:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:88b0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d6d511-54e5-489e-5546-08d816d65a45
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27102F6153EA239903D8AA89BE970@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyG2pIX8EN+i3T5q+2D/FiQZVIHayIL5DTg38kej18irQMYrxhk5LURLr+pXlFdmh0IMtj3Mll5p++CwDRZJWUEAG2rY1L0zjrCPOJRrGVcUGp+Uz9xxMneSlsc0QkXqmIbjhQuDUU7slsh/oKUlUCRmhVvld8yNLGiqmfCjFtQAUce7zl6Q6gQcI/nB+pVupzw2qCVUnEqtNNKUU3sHG07XE4ds72eAHVnQ4gubfJcdIESBi3hQ9HarVzomKBzthCISqeZtnkwJzrgo/l5+Z/r2ytzKGbZHjQTBuTqrZldKIno7tJv6qIId8nKjJ9CrdN2q/RNgl9gZWtfvk5FSzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(54906003)(9686003)(83380400001)(2906002)(1076003)(16526019)(6666004)(6506007)(55016002)(53546011)(4326008)(6916009)(186003)(52116002)(7696005)(33656002)(86362001)(316002)(66556008)(66476007)(478600001)(5660300002)(66946007)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Yl70YKRyT194VpdEyNIo8e2p5XuDdLP+iT4s0LOQd1f0p1I4pwR/A23yeEa6blOmlOlRHE5qKHkztuuI3HokNsfLGAf1zfk8YL4ljNtZFMVZES31gDDUMET7v6hhKsyNb6z+Uzq53KA76Zyz0G7naL6vtsQvumW3b7wdFJoOoQHahQzSE/Lm/k1G9RNbEezeNOECJLMt9QdP6Fm1Ln6iTtpzD5SZ/KZ18yovQtte40Bw3jBfL9SNvKeEiq0+U0NWoAeoL8zEtHZYseQXDzH59AsjTjmwnj854fkbRbo/IT1VigrVc5c73z/BfKzEBaOWRUinWrEhnsBneeZUw6d+1qpAgF4bDYV2XHZf91s8CvHsyQ1deSUvznGWSB1ANB40/YkvIrjLhXmlNiI+JRkc/UcMmdSouu9bwC+14LOsp8YSmTXFmJ4DqaJeri2lGMM/SL1ygdXwdlZ2NQz/mX2LAt6SfIAAR1PT8FbrYoA5XEHTVG6LMLzt2sDifhSHA4ThXFmsqQphnsvUpbmYFtneow==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d6d511-54e5-489e-5546-08d816d65a45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:01:56.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ+SD2t2Geuu9jiEh2wDpogFSdkPyYu8rXmbZDeeD4Wq3qqyfpsqR/AgLRiprlh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_10:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=912 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:12:46AM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Deprecate memory.kmem.slabinfo.
> >
> > An empty file will be presented if corresponding config options are
> > enabled.
> >
> > The interface is implementation dependent, isn't present in cgroup v2,
> > and is generally useful only for core mm debugging purposes. In other
> > words, it doesn't provide any value for the absolute majority of users.
> >
> > A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> > It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> > and also allows to get any additional information without a need
> > to recompile the kernel.
> >
> > If a drgn-based solution is too slow for a task, a bpf-based tracing
> > tool can be used, which can easily keep track of all slab allocations
> > belonging to a memory cgroup.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Hi Roman,
> 
> I am not against removing the memory.kmem.slabinfo interface but I
> would like to have an alternative solution more accessible than
> tools/cgroup/slabinfo.py.
> 
> In our case, we don't have ssh access and if we need something for
> debugging, it is much more preferable to provide a file to read to
> SREs. After the review, that file will be added to a whitelist and
> then we can directly read that file through automated tools without
> approval for each request.
> 
> I am just wondering if a file interface can be provided for whatever
> tools/cgroup/slabinfo.py is providing.
> 
> Shakeel

Hello, Shakeel!

I understand your point, but Idk how much we wanna make this code a part
of the kernel and the cgroup interface. The problem is that reading
from it will be really slow in comparison to all other cgroup interface
files. Idk if Google's version of SLAB has a list of all slab pages,
but if not (as in generic SLUB case), it requires scanning of the whole RAM.
So it's not suitable for periodic reading "just in case". But also
the absolute majority of users don't need this information.

If for some reason you're not comfortable with deploying drgn, it's fairly
easy to write a small standalone tool (similar to page-types), which will
do the trick. Maybe it can work for you?

Thanks!
