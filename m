Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1520709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mUQnLFU7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UFr364pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOWNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:13:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgEOWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:13:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FMBI03006041;
        Fri, 15 May 2020 15:13:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sgvaCFCbzx12OZlw6/ZIUc76iTc/1YQFQ0/cPUbpKtU=;
 b=mUQnLFU7pPcHkrfWh4ODwGh1Drrn9lT/L9Hr9kYjjS1+aBGx24nlD/UmHB4WAITjqe8Z
 Aa0WofM01nC6lfF/itN+C12ugFglAXiCOLIhRvbjXf812Kv1fYz7UexpspNAoEx9ipmq
 TJRQMow7nKA119tEkWvNXD0fyXhHbn6bngU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 311v2b2p5w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 15:13:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 15:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTs+K86PC5JKyv+nyu5vHg6tAAPcY+jlSdML374SfLcJjCCl8c0y+VOm0ey3dIbyVHbqzMHqZ0KWyXRGC4VH2lWKUNkKUxoHkDwVKYmapDpIIm56d67HjrFSNW2xciqIDG9nxL0C+mevBlWZoRKAUdmiRlBKTJ3qo5GpEfG5GfIvIxiiCzVMy6YxHd6bLwJrE+s8jLU+khFevez+BfCZMT+cumm1lAuedu5Udc0z1rBoahCtpuKiFtwFDats0t5TcefKICzaeFsJtsnztGN1JmPd2JcixiVC6AKdXWuofPMEGqnk808aCxhJPezDWoFzIAEJYIY4z5Y87zcyNLjiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvaCFCbzx12OZlw6/ZIUc76iTc/1YQFQ0/cPUbpKtU=;
 b=N8F64UarsQ3Li2UhQHA4IzCUvv/C0c1FArBp9H7ANpNnoggdHsnH3lkQl++zFYc9564kGVQM4OY2/Wqvng7mH6TJFvQ6m1kJxXuW//V0tFpsuUnfx+8BLpuXwYLCAeO020BjloDaP4JASoHKq5d1lX4qccQEtPdLHp6wk9glyNxWV0BsePTamuCz/qyaEXjtvUOiG2V7mccBHzaI/4UTIWb/FqUDm93jiHoICMuzsn8gUBocXxYjlOS48mR7qu8NREGMwcwDplv3TAtlJPFwGBdKji6oL+PfjGh619xR0hdarAQkYTe0AGJ6iyqhT22tFkRmHlPp5KRJgztc6R4G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgvaCFCbzx12OZlw6/ZIUc76iTc/1YQFQ0/cPUbpKtU=;
 b=UFr364pf+rvJfpCiiS+miQH3xTXDU+1IB2inQMRERc+9mkJ9gdck4fASDdAz3Libsm8lNgr2EZzQG4tDDC4DdJM0RFI4O3YNOD+r847bYpZCsNYFUCCm1iLn9mbsW+aTgio4ZomU15/uOHFAFH76EwtGgCwp8x5sFzQoxX5t42U=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2405.namprd15.prod.outlook.com (2603:10b6:a02:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 22:12:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 22:12:58 +0000
Date:   Fri, 15 May 2020 15:12:55 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200515221255.GE94522@carbon.DHCP.thefacebook.com>
References: <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
 <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005152142570.119998@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005152142570.119998@www.lameter.com>
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:aa2e) by BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 22:12:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:aa2e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8944d5-ff65-4ffc-5004-08d7f91d2000
X-MS-TrafficTypeDiagnostic: BYAPR15MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB240595A1DC7A0E07AF275A38BEBD0@BYAPR15MB2405.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoPr5HrFxMlBntVe6pCrO8VTV23p9V6mQCiJo+HCd1UbOL1gYdV78lBpfptBGb+4ArZcKVbop1DW+hWx1srBAt89Zp3GxEnZGYkICmffJHiZECPjNz2tIYUed7QEG6g2FiQk4KkF79WCZ3bdbjgq877DHZHreI5xT0FGO3JAieWHR9EhzQoH0iKeU9s7qUtAy4wcV9OL/wK59fNWooxLv/vPFG4pItthH0Yb0LknfllnQGe8dlFBnfpRZBtFC1Tp44MuooCDN2DDHiQ7A2PRPIwGRNT7InnOktwXQr4ggUhrbgEKubkhEiAFpmKCqjmn6MMAD38ZyReB/iErxZnkCF6mm/Qn4IJQQSFnMDQcKEO+Q032dShdALcioke0vyM6v7cnVHKdZs7bCocN+SKTZ6PD+5D/EXAtUhar7p4o5xvt1PxtOn5M45nFLN/xZAeN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(6506007)(186003)(1076003)(16526019)(52116002)(86362001)(66946007)(6916009)(7696005)(478600001)(4326008)(54906003)(8676002)(9686003)(2906002)(5660300002)(66556008)(33656002)(66476007)(8936002)(55016002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tuxGDY0jw2TZn/FkRVUYuC0wS/eG/7boRveD1lQoptiMNKDhhpU5BH72e7gZ+J6KUrcnI/UHfzZkFNy2iVnKi+ISXaYr2BQ4dEdfIv0xk1zAAIld/Ds0cYyix5SoyINWvbjfot5cEBX84UcCk9ssWGrzg9ltneVdqloCru++r/FZfKnHu+jFroTn8mxk/3wYETQn8J8h8/V4fcvsnXI3qiN/xoP7ykLwzVQWtBh+0x1BdPInlZj2n1l7YeCMwyw8uSxyJlhH2lw/KNYDoGQfcG+bF006OHUF1tmhz3ACEHvLf703vlmEHYHF9vbsyF6sqi+Ae5fTqCRq+pD5UsC2XgAPELNsEiEJE8/TCwjfGD8R+emmbomkQ0YoDKI1joHj8FUIlGjkDGXhFe7J/Ro2xGE5KzdykV3fi76Piq0m08rufnhWpFhlzv0YoI9CJJcGh7G5JYPYK7oEmK+/VfPPU8h6DsH7Tha5tIeftBo++hBg8oOc3e10rX2LzSCQzFGj6zHbXqYz3ODTmJ8YpbUSSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8944d5-ff65-4ffc-5004-08d7f91d2000
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 22:12:58.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrjNg1cJwxWeDzzBkiAN2nMnBBXPpCKE1jovr0MK61cLXxr9mnuAApButz9oOT7C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=1 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150187
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:45:30PM +0000, Christoph Lameter wrote:
> On Tue, 12 May 2020, Roman Gushchin wrote:
> 
> > > Add it to the metadata at the end of the object. Like the debugging
> > > information or the pointer for RCU freeing.
> >
> > Enabling debugging metadata currently disables the cache merging.
> > I doubt that it's acceptable to sacrifice the cache merging in order
> > to embed the memcg pointer?
> 
> Well then keep the merging even if you have a memcg pointer.
> 
> The disabling for debugging is only to simplify debugging. You dont have
> to deal with multiple caches actually using the same storage structures.
> 
> > Figuring out all these details will likely take several weeks, so the whole
> > thing will be delayed for one-two major releases (in the best case). Given that
> > the current implementation saves ~40% of slab memory, I think there is some value
> > in delivering it as it is. So I wonder if the idea of embedding the pointer
> > should be considered a blocker, or it can be implemented of top of the proposed
> > code (given it's not a user-facing api or something like this)?
> 
> Sorry no idea from my end here.

Ok, then I'll continue working on the embedding the pointer as an enhancement
*on top* of the current patchset. As I showed in my other e-mail, switching
to a different way of obj_cgroup storage is fairly trivial and doesn't change
much in the rest of the patchset.

Please, let me know if you're not ok with it.

Thanks!
