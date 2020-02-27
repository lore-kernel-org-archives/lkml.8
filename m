Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4BC35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00969246B4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cUeg8tSB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cVxxwq6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgB0SgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:36:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729280AbgB0SgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:36:03 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RIZkhx000701;
        Thu, 27 Feb 2020 10:35:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DlPymDQCKyaAkH9tKEOiG2ANwJ068zW9gt1+t6V2460=;
 b=cUeg8tSBxZazlduuLAimB98WNOLfUhyD14hxHZ/dTYnPpAsYYlEYrFwi/b7kfMAMmOCE
 c9L4F6w2dSGhFWMsI5fKoQwGe0HcZzYaSTQUWcsi8QtoP7YvIaWkayfUS4cZGjCgUSzx
 vvBd+ySkHEXnGF9EQLx5kmXRc5BHovwPURU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ydckyjjh9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 10:35:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 10:35:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdj9H0q7D35y1sw2ZT4tzymLHA73uNE493Pw7msx+chQ+1tyemzS/V7X9GIQ6mNh8vOhsCkBPbbqLGn0qAtFtXwPNrpqJFFW56zGO0Ep+7r1vpg7bz1rP42lehFA/zMF0pg7T/bkqA+RM2TcMg4trkhvuGaMEW6/T0jrltPtuFrHwfCACCdwiEeBpBcE4HhG7Bejrom4GDoX06DnCUe5HZ9rBdkumtlxfPKYrX0wOCVDqV3TvZeZ33nh6w0emkvDqF6dYyfmXSjboLD956m3NaOLJT8GtoRKEwNB2QHRtaUc2J/VaPRLMRaM7rjWW204RlrEE2iAbnJvYvjdkyC9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlPymDQCKyaAkH9tKEOiG2ANwJ068zW9gt1+t6V2460=;
 b=EeTBsLWM76P6GM3/A6/BqQVp4v4I9f/aaidZQpvuMQyDXUUOWEKZh5aDVorWFwYEsXvpnBs/8fwsn/8xC/rDC2MQmV80x8Avcsv4rYafitrNlRlr4hhOhVSBLGc9WxgKZ5/udm1rXYh7khcYqKeSisfFx6xw5xIR76wFOHaVM0FFpECl4zZCWeBnB1dnqMLtGR79H3vB9au9vDfJ/52w/RQ5yPD64+LbxRhy1WmUxqmszX+b3keOXu8Tgp7QPQSbPSHrhju5H3yjuoMBrNTo7mSir1+sh4UEQZVo5VIe5/ZywLoo/VDuAHgau+8da69O47d1T9VNubAoO/1hYcpVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlPymDQCKyaAkH9tKEOiG2ANwJ068zW9gt1+t6V2460=;
 b=cVxxwq6PMEGZ4rTb20XSaTGZexIVe1S+dL/3NZnko+9xPvvR6/9aQvA6Faye2tkvxALOMyFkTWzZ8hDhd2tBDJEIO+P/dFoAXMEQ4SJyEAPGhzOL2lOuBDLciLwkESJpX3MkXWluiGIeyUB5gduOPpurouVTXS0XAMxggm9u0n0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2951.namprd15.prod.outlook.com (2603:10b6:a03:f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 18:35:22 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 18:35:22 +0000
Date:   Thu, 27 Feb 2020 10:35:19 -0800
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
Message-ID: <20200227183519.GA50628@carbon.dhcp.thefacebook.com>
References: <20200222092428.99488-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2002240126190.13486@www.lameter.com>
 <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.21.2002261827440.8012@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002261827440.8012@www.lameter.com>
X-ClientProxiedBy: MWHPR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:300:103::15) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::7:83c) by MWHPR12CA0053.namprd12.prod.outlook.com (2603:10b6:300:103::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 18:35:21 +0000
X-Originating-IP: [2620:10d:c090:500::7:83c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab38f4c4-3087-4127-6e73-08d7bbb3cdf4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2951:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2951FB75ACF2504E126BC4BCBEEB0@BYAPR15MB2951.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(81156014)(52116002)(81166006)(7696005)(8936002)(316002)(66556008)(6916009)(66476007)(66946007)(54906003)(1076003)(186003)(8676002)(2906002)(478600001)(9686003)(86362001)(55016002)(6506007)(33656002)(5660300002)(16526019)(4326008)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2951;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPfRxH4oJzNkQHUPAV9+80Ybrj3e1MT670xlbPwx+w9sb/i5k06vO91RsxRksPlEuRvSAb0rXHYvClPupwAAkTbwFRJgjLr78lYmOlRbDS+4ItGSVQL8AAwblkpX7A/QXx0tj16GxDcUSbXW9I3R+ZjfiTZVYu1ymS58PrStjyVc1vu8h6CFSR+f7nl7BjpCv88k5wVIxkFLy3+ZZi4+E0DHB3cUDG5hFQczbjh4A4z6WP7YDTs2YsYuQWxnsNkkNT/pGRgq3JYDMjQadYUsLTGBO+JJJzvXtRbMXuhdFodNiLKcCFhPljPPG2T3ehpp6FkFLOpFMSOvzgGHkSn+/7f8PEJYA23WAlp6ub+Rb8uz5sL/a15FInhFbEx86A38k35bxMjrLrQ4zPlt1pvau2SEPtrh/jhejmv7OpCCCcVX0vNUGAmMsZX+MZFPpfBm5qH4n6740nQbgFsSOCRJiGlwvg2K/ax7gRt8K9Wv0IHYFvmQcozxoxartC6DsoDX
X-MS-Exchange-AntiSpam-MessageData: K9onasVvMD5eOjFXubunzUgahqD67+8Gp3k6wXG7wuv1d91Bj3zn2PhS17Y269Q/Lm/IatmXcf/gF9rvf7mhTncvpofH/fi/43SFulINvf8YONPWfMIr+91AA2g0Yrn0IxCJP9Qu6gSQaIiVfxtfUCIIJCwJbIUwfxXUCR89OU6v8JyTs7YKQspjFfdQqP2O
X-MS-Exchange-CrossTenant-Network-Message-Id: ab38f4c4-3087-4127-6e73-08d7bbb3cdf4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 18:35:22.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll7Fr7jzOROECko39pxUqK3AxH6lWGpg+n7SmmO9pbnMWiEICavoxZIowR6eB4Ua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_06:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=5 phishscore=0 lowpriorityscore=0
 mlxlogscore=546 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 06:31:28PM +0000, Christoph Lameter wrote:
> On Mon, 24 Feb 2020, Roman Gushchin wrote:
> 
> > > I suggest that you simply use the number of partial slabs and multiply
> > > them by the number of objects in a slab and use that as a value. Both
> > > values are readily available via /sys/kernel/slab/<...>/
> >
> > So maybe something like this?
> >
> > @@ -5907,7 +5907,9 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
> >  	for_each_kmem_cache_node(s, node, n) {
> >  		nr_slabs += node_nr_slabs(n);
> >  		nr_objs += node_nr_objs(n);
> > +#ifndef CONFIG_SLUB_CPU_PARTIAL
> >  		nr_free += count_partial(n, count_free);
> > +#endif
> >  	}
> 
> Why would not having cpu partials screws up the counting of objects in
> partial slabs?
> 
> 
> You dont need kernel mods for this. The numbers are exposed already in
> /sys/kernel/slab/xxx.

Stepping a little bit back, there are two independent problems:

1) Reading /proc/slabinfo can cause latency spikes in concurrent memory allocations.
   This is the problem which Wen raised initially.

2) The number of active objects as displayed in /proc/slabinfo is misleadingly
   big if CONFIG_SLUB_CPU_PARTIAL is set.

Maybe mixing them in a single workaround wasn't the best idea, but what do you
suggest instead?

Thank you!

Roman
