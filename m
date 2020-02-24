Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA97C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146D820836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XmrLKy1t";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bzq0EGsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBXQ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:59:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727644AbgBXQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:59:00 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OGwd8f018659;
        Mon, 24 Feb 2020 08:58:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cFGH9Gb7AqQkHT7XJzDU0ZuJUXF6HTB5rFqcAor6bE4=;
 b=XmrLKy1tBA6zH7ouasfOOougCVOzsMFXhUhwfEe9LH9RZgAOhNNvs8gK3JaC2eAYO6Mp
 ogPXl0AYiYmsHIQ3c1H3BAJBg1EXSSLWx4G3R2nc3Wiq9SomOxyvmulzrf8ziiks48XM
 l8kjZn3axjy7P6ugtE09v+9xHvtECcJYNoc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ybn985we3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Feb 2020 08:58:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Feb 2020 08:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgBiZ4s6NMoGQozrVeW4EPgNQ3zKXeTWFnS7UnBArKKkF03BJlQ0TrU4XmYlF2G7XK7e283r2kBtKxuFJm70NlvemmpHBjkXtCujaVFS86V57B3LMKCLFZaMabRv/h298KloM8Uo//Iszhn9K3PFqH+A1qm3AmTN67PyglE0A1V0N6RvzKnv6z4lH6OdJJOmaJl5t4oYVNEQFwBgb1FMyVlHAHn8iFiTfjMXc5GhS0UEiwAEhhbn+tu4G2bb3n5wzZRCs6o7h+kJh+x41s8K2lyxkC8ySzWrsXWPSJdYwp9Ymexgt7tlp9U9mVkw8+AfUFOOiGEs/PbwfKLVeaqEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFGH9Gb7AqQkHT7XJzDU0ZuJUXF6HTB5rFqcAor6bE4=;
 b=JDx/5CBFKJAJWUPWnUxSS1+Y94mjJZlnntUjU1QXyZAdq0pN07h5BpDXHOUPOBpPCyDe8YObgbxaY/eHi9y/QhPF9OAcgo1UYi/lSxAU6srcxJwxYK5mGrfl1s+LqZ3nqVqQQESqvzVrwXi3DavarQOkVCDlZXoU5uZXMh3XvTPnl55wpdqBR90ND4WsgOr9iOUf2yBv40rbT2QLQhIm5VOjd9X0sdPAety2g7Ccz/vLX7br0424XT+RPvYJZM0Ahzj4ZyZgTfAH3R8dsO8xXjy6+4YCM+fNTB6t4zwb09mLOFc9Wx5FBXTXrE2at5yF1uKEl1jE3pFSMuBCkoB5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFGH9Gb7AqQkHT7XJzDU0ZuJUXF6HTB5rFqcAor6bE4=;
 b=bzq0EGslyUOG2ZlSpnO9+GsNVyscg63QxtblwHdNKJ0EN6oas5Q/9dmPJQbJbwyW9RD+4OpFp6wkihoT9fjidULVKfCON78jK7MjhWYFf0IbNpyvITZev4+ZIlr3vBUBO/oMEiasGy/mDIr5ZmUlghMpLU2odUtsw3E/nhqQUps=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2472.namprd15.prod.outlook.com (2603:10b6:a02:8b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 16:58:01 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 16:58:01 +0000
Date:   Mon, 24 Feb 2020 08:57:50 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: improve count_partial() for
 CONFIG_SLUB_CPU_PARTIAL
Message-ID: <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
References: <20200222092428.99488-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2002240126190.13486@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002240126190.13486@www.lameter.com>
X-ClientProxiedBy: MWHPR17CA0087.namprd17.prod.outlook.com
 (2603:10b6:300:c2::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::5:ee6) by MWHPR17CA0087.namprd17.prod.outlook.com (2603:10b6:300:c2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 16:58:00 +0000
X-Originating-IP: [2620:10d:c090:500::5:ee6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 978567b5-6c45-4df6-a219-08d7b94ab4fd
X-MS-TrafficTypeDiagnostic: BYAPR15MB2472:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2472A0B8DFD43EA07A2F07D0BEEC0@BYAPR15MB2472.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(33656002)(6666004)(6916009)(2906002)(316002)(81166006)(8676002)(54906003)(81156014)(4326008)(86362001)(5660300002)(8936002)(16526019)(186003)(6506007)(9686003)(55016002)(1076003)(66556008)(478600001)(66476007)(66946007)(52116002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2472;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rogg/I0puHduQmEtZe4JbRL0rC33ffrzOUBQ8LKIvqylOfrmO2GvtzWmMRgFXgoCuTngageQWelMmu+70ZDtnyy5tBx3COvxb+DgCP8X3pFn88SXp1LkYrCISP6xyeEQZAn766I8uatYYsWlifp2tFJZctQDbglDhjvmbCtG+koxHPp4afPYLgeJ0psSvGrmwLvlc6an7oINxL/WJT+Nhc+n6FIG/ynh8wI/BdievhUWktMezShAp3O3gvIcxzZPj583OfSLsmg4KOtgi8YPmzEXAHGyS1eprmPuEPqxwsEnY8UsoQt0cX/tgddbmpNQF8kk1uJlpJRbtLCDqzJKqjlf/fVm2DpUw1qpbDmGn2Mr+Q7Kcp8B5NHfYCJHRnQxeuUdWZEuTjJAL1dXV9HQsEbDXKGvucmIu1OId0ZWmVd7RBZMNoRQzAs7i9BOlYUE
X-MS-Exchange-AntiSpam-MessageData: VUUktkCO8ePt7ZOjV3OaK+GuXXbEbIrXuemFtRazX/43EVnuCGHjd+judStzFiyRivNBbI3gPXuObTu4vwFgTLEhYi4vTmSepQVAj833sS9dHkaWUW9fv7E1i20UCz9ylmLJuaux05WmDcEEpUApUMnazV87UiPxpSgwqdFcvsJyAdMLxn2OjjurzCRWUEKQ
X-MS-Exchange-CrossTenant-Network-Message-Id: 978567b5-6c45-4df6-a219-08d7b94ab4fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 16:58:01.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA8dFl/LEtY+dYPLHEqOaf3Ec2ttMQMFgxi3iPYcREGMSzXyggFxO2QzccBt5uOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2472
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_07:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=591
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240130
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:29:09AM +0000, Christoph Lameter wrote:
> On Sat, 22 Feb 2020, Wen Yang wrote:

Hello, Christopher!

> 
> > We also observed that in this scenario, CONFIG_SLUB_CPU_PARTIAL is turned
> > on by default, and count_partial() is useless because the returned number
> > is far from the reality.
> 
> Well its not useless. Its just not counting the partial objects in per cpu
> partial slabs. Those are counted by a different counter it.

Do you mean CPU_PARTIAL_ALLOC or something else?

"useless" isn't the most accurate wording, sorry for that.

The point is that the number of active objects displayed in /proc/slabinfo
is misleading if percpu partial lists are used. So it's strange to pay
for it by potentially slowing down concurrent allocations.

> 
> > Therefore, we can simply return 0, then nr_free is also 0, and eventually
> > active_objects == total_objects. We do not introduce any regression, and
> > it's preferable to show the unrealistic uniform 100% slab utilization
> > rather than some very high but incorrect value.
> 
> I suggest that you simply use the number of partial slabs and multiply
> them by the number of objects in a slab and use that as a value. Both
> values are readily available via /sys/kernel/slab/<...>/

So maybe something like this?

@@ -5907,7 +5907,9 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
+#ifndef CONFIG_SLUB_CPU_PARTIAL
 		nr_free += count_partial(n, count_free);
+#endif
 	}
 
 	sinfo->active_objs = nr_objs - nr_free;


Thank you!
