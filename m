Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DBC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0708D24654
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Kp1ouhgs";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="P+XYBN11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCJAai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:30:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727287AbgCJAai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:30:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02A0SdDf020560;
        Mon, 9 Mar 2020 17:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ng4I5maUaW1UglegVgdEVb9zteQkfz1em/uQcmpuP2A=;
 b=Kp1ouhgsxWqq1GtsGWoyAc7HyuRnPLtaHc4T5csrG+vd9p/LVCb52RuUq82WGNn5mRmx
 YBVzFtFrIsbVTUlo7yIktPi4MFqM+skax54twcfP/RbBuJfR5QGtBYGMRwyjhx2m9tWz
 84WJhoi+ULygefWyhFhqOjMltAcP29eSTDA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yme3vhhm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Mar 2020 17:30:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 9 Mar 2020 17:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiCkiq5czOrHFAAigo7jRL+avW3lf+U5uEMpUK3D9eA5MdYb6rtl1pZzOTAbaD9OO/ldfTsVgGv0P/DJhW3bNbTTAYysSGc/0lpRrgiEzS5XOx4lRxsR3qK2ZkvJIUZ6I++Ae4z3XAVegKaV7Q4c3pcjLfWyCTN/BTWLbnqymScEenwAsRjBmnCWlXeZ2R+QbxeTdYHUtvg2la3e4ccPHVId5mdWacZgaxMNI5ke04CyGMeDCBqVYQ71PU3UrUmg5YllhjllTjHAu6C+FIrtqEWU+zrAC9131nVA4zYTVDsOej7vPuGfPf+QW5Ihv0b2xy0XmNREu5JYP3WT0Kno4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng4I5maUaW1UglegVgdEVb9zteQkfz1em/uQcmpuP2A=;
 b=cNcf8VnE0rKUPFBhW806rSjjOjDLs276R07sQ7LOuhoSkfI9Y2mImSHow0iuym1JtHWXLOHTVm19pHWM1qUSs2CasZtCUb8Rj1b25rHxfp4DMrg3aUjuxjh8U7wdveSAphLM62TkWZ31/vpOhuOY+o4NpL4dFdSNwkrOT863aTvGT0hGGAnrk42+GnQ7JZuwQEh8tGhpSxafNrRwDGv0wFhC/2aCbLr1rNlxrApeLkp3Hck1iwc3oHSSJ01lxYVGFS+QZrW3hbg+4Fe2HEaqDNMwSQcKfSOginBHeGhyICV0bHCnEuG7rK8tqa2Ir0YcA48I7YX3f8yhB5UrKzbJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng4I5maUaW1UglegVgdEVb9zteQkfz1em/uQcmpuP2A=;
 b=P+XYBN11U8blfVQciO7S1bowWtd+k3P8a8BI9JzUS2iRiqlC0wD3ZlXJDXiwr2gzo04AUXpCr6XXSXcqnrG3aUj2oktUSNNUyClNn+32sYmp1AgEZ0FVlGkfHvxaeax34bgCf2GGLe8VFKtwxjcrcJBfEL3kCwIjm/n8oaiVIxo=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1709.namprd15.prod.outlook.com (2603:10b6:301:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Tue, 10 Mar
 2020 00:30:26 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 00:30:26 +0000
Date:   Mon, 9 Mar 2020 17:30:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310003023.GA76136@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310002524.2291595-1-guro@fb.com>
X-ClientProxiedBy: MWHPR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:300:94::17) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3515) by MWHPR19CA0055.namprd19.prod.outlook.com (2603:10b6:300:94::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 00:30:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:3515]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9606e3d-fa2b-4fdd-b31c-08d7c48a3a94
X-MS-TrafficTypeDiagnostic: MWHPR15MB1709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB170931FA7C81D09C708855A1BEFF0@MWHPR15MB1709.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(66556008)(66946007)(54906003)(7696005)(9686003)(66476007)(6506007)(966005)(81166006)(81156014)(2906002)(478600001)(52116002)(5660300002)(33656002)(8676002)(1076003)(55016002)(316002)(86362001)(8936002)(4326008)(16526019)(186003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1709;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ca8qoULVlzM6u9zWtQLqrKhsjkSrU7V17DjAGjgGkpE0OB5fhkdWnnUQ01ZcDYxCRUq2ixWCbnPK54OBQFZ5JpSF32yBZZO/aAJzx3PNGigRIdsppxwd0WrNi4HL5JFBKmEUpfrSQ9a0xrGcAS6mHQXq9B7vo5hSEEhi5hOf9IvLXuFlYIo358yzklms49QprQx3nD+xL4Cl7dhRLCY2X88nVD1FlfmHrCKkUnEEq8F9OtGWBs/Ltkv+Gu//ZRH7XnvtEpsJfySZOzc5ZtvySmWvOvNkYOVOnZGQThbr6Ak/e0IVQrQyXr+J2PLTA33tdHL706eqNnSTqu6soiZZeLxzk8TydTxDtOZvDbnLRntEkXrVnQQJ8oIRrPsh+gDrUZQtV1x7PXBFX9S6DxVq6Z6jB5Vn/sDZhYtvcICzBsJCz7L2Tij/ZfpIUWd6hJRyx7/I1Fl+xFsefts0f0chz0PwHeN+Qlex158uLW2xlKK47bLMj76zoWBcyET7xrW90SK45U74FsbaVC8y2RiEQ==
X-MS-Exchange-AntiSpam-MessageData: v1A0kB0qoqTj9VrtdMNMl/aajQXTOIRf61uazUdm4ctnpkQuzHfRBfg2+uvo06JY0Wuk+EH3B6858QuIVcRXM2eZACSISl/SPjaRtfIXQFVz+NQOu66ouF/PgzCUlBPThi/SNZ5AmMT1nkCjCWE8F05LbsMBew1dHP3H6QtndLJSshQfxqwCNSP8VA4UbrDE
X-MS-Exchange-CrossTenant-Network-Message-Id: d9606e3d-fa2b-4fdd-b31c-08d7c48a3a94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 00:30:26.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU1h97qR76vm5FAXrTILiak6ARysahBFIWTfOMS2Gff50UHnIKgI5C716mJU80nV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1709
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_13:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100000
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:25:24PM -0700, Roman Gushchin wrote:
> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> at runtime") has added the run-time allocation of gigantic pages. However
> it actually works only at early stages of the system loading, when
> the majority of memory is free. After some time the memory gets
> fragmented by non-movable pages, so the chances to find a contiguous
> 1 GB block are getting close to zero. Even dropping caches manually
> doesn't help a lot.
> 
> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex. At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a
> high probability, however the memory isn't completely wasted if nobody
> is using 1GB hugepages: it can be used for pagecache, anon memory,
> THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

Btw, if somebody wants to give it a try, please pull these two following
fs-related fixes:

1) for btrfs: https://patchwork.kernel.org/patch/11420997/
2) for ext4:  https://lore.kernel.org/patchwork/patch/1202868/

Please, make sure that you pull the ext4 fix, if, say, /boot is served
by ext4.

Thanks!
