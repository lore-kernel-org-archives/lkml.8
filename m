Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B758A20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KVBNO5WW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VSMYNsVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCJS5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:57:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgCJS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:57:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02AIt1MR013754;
        Tue, 10 Mar 2020 11:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KuNVEVHTR4A3WgLSASOCwFqCg5pWdMgDYeQ10bZV6mI=;
 b=KVBNO5WWGqXfEWEo4bh3DlifBFfmUbUvLWE1MEAKgbpbj4G4E5y68l3wDh+BjoG9x0KC
 smqdi8b9sZXuFLFkSv9PxYjlIY9NNAYXvqWgCcYg/H4xNJlInWneobkFTGfO39KmpIpH
 /5F4rI6ToXGWuUkd76Q7TRm6+F2KgExWXNc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yme3vp3vj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 11:57:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 11:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPzfTqcmayBjEMdI1ac3/nvsWmBC3pXapxGQ1yjLXhriFOdx19NoedVTyvBHEpFm4ADYNObKdvMMpdmpnZ5ojVc/TKA1lN+m83Uu4l+ISWXCedXDFmytf3qxzu5KwoJU5UYECe/56MT/h9zZ64WyH+VUnKSAwXH5sVWBIQtCVekq6GAvxL/GF9klK8IEZ34pcw5lhZBrS4sIwGBElQhc++RO8agB8rkQMoIp0xArrsDC6/ksiZFi4OQJwmmwcHR23e0uejywuP4JWL6sW/UTl+mYxu5C4jLc8LxzHtFVLt6kT2CktzlwhEKpo1DNo5YqJPLCXM5pVHGvfUprUZN/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuNVEVHTR4A3WgLSASOCwFqCg5pWdMgDYeQ10bZV6mI=;
 b=BCMxa31g+k6gr0zHU044O9Z6C74dBsq+JW4bUdEquD93VEwk15DSKA/w2TS+iWRgO2SYHAXRE3AXeS/DE9hn1N0wsDScByoH1kak7Q4QisSzYDnpMYtWMaSv2tgTv3aXuyZRuEEMAPO+ML39AR7E8SpPBbBT1aPR1TfzHW8VgM2OBzzpDMtHS3uiiJdhOYuIsuXds4+Ll2CfSQP2RR7tTv67y4MxkntrYSqfXmeSUD3CU49ODg+aXlLlaUibHpgVPxJy3vmOxLrvdrtW1exsXPoT76yAZLSXwdmCMfAQKvW/dyu2/6f7wvg418q8iY4qijSdQ5issIbi2+aV1Udo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuNVEVHTR4A3WgLSASOCwFqCg5pWdMgDYeQ10bZV6mI=;
 b=VSMYNsVpy++V4F7saxHGroyHgB8M59e8Cl8tntG6GTKDEB1dqVdG6QJURU0P2yAGD4ztNdvtIzXDEdMQxiZR4yliQIqfUhw0vFop5oogbGfINY543tYOO3fmChOrE/nYICAxlgJ9mIH9AKwnLZOXpeHeQB9vVtbS0zI8zB9jiyE=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 18:56:56 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 18:56:56 +0000
Date:   Tue, 10 Mar 2020 11:56:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andreas Schaufler <andreas.schaufler@gmx.de>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310185652.GE85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
 <1b5ada08-1baf-4f2d-3ecd-b940e7ee0e0d@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5ada08-1baf-4f2d-3ecd-b940e7ee0e0d@gmx.de>
X-ClientProxiedBy: MWHPR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:300:93::16) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5285) by MWHPR17CA0054.namprd17.prod.outlook.com (2603:10b6:300:93::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 18:56:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:5285]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4adc3047-3381-4483-2b17-08d7c524cdb9
X-MS-TrafficTypeDiagnostic: MWHPR15MB1791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1791B842C8DE7256E1DB4341BEFF0@MWHPR15MB1791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(16526019)(66946007)(66556008)(6916009)(5660300002)(66476007)(9686003)(55016002)(478600001)(186003)(1076003)(316002)(54906003)(6666004)(81156014)(81166006)(86362001)(6506007)(8936002)(33656002)(7696005)(52116002)(2906002)(4744005)(4326008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1791;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy/mN/F6ElzquYampSIh0R5ouUkXo0WqQ77C/pXDOWY6FNYD13qGWBAcDYx4ZqK/iNaXTSCjYf8Yvw1VsDGHKazhA3o6PNsKKk+Jz5G0oa0ZkSvAzfMywlmd9QJ0m44oSJPvoVc+y3WAsefbpNSdodzjSfNMHLmSasRstt/wclFkuDEunZpgmwefD+Bmzp6kp2z8yMUbYYO86AedCFu4Ep2BSqx/cq4Ha0oWnaM6sNawD1p+fOt9dgkGbClBJe9SSTawE8JBONSjLpNWehNcAaCZQjOe1zACWBElWglFCQIC9a49lAjvXt2eAV/DBBfetvnAXms+nBpxLUs4fd5HfWKBltHwgOXZ814IkmWtCe/ONyDWOVx4ZaTwKUyjDcLlrJ7kHsjwr/QTOhSsZI6VUPbovprWVxdmsPdquYSy9ukzfRldP7INLqXYrySQMz9d
X-MS-Exchange-AntiSpam-MessageData: E2TVaEROfg/pEXEhRrHZKbOz+iCy/ejErp+NEfu9a4UAsnARJxRPx46c53z+Ibc363IStbL0mApFK0JjoTzr0OwceQwpa55meKz5kTIP6z7Rdb6RgsXVLaY/gtDpGGSrnvxQP88iXWMgzK+1M6RpIy/3R+evF5mEr7Dvh+0J28vGhCcnew50MSdFhk0or+4t
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adc3047-3381-4483-2b17-08d7c524cdb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 18:56:55.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1PcyMV0YiZlrTW43AKrdSv/UHx+8psgmDVyg+AgYiUw1qwS7TTu7xhwfOEu/nMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=881 suspectscore=1
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100111
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:54:58PM +0100, Andreas Schaufler wrote:
> Hi all,
> 
> sorry for bumping into this discussion, but this is exactly the feature
> I am currently looking for on ARM64. You may browse under
> linux-arm-msm@vger.kernel.org for a message I posted there recently.
> 
> I read somewhere in this thread that it should be easily portable to
> other architectures than x86. I am ready to give it a try, but I would
> need a few pointers where to hook in in the ARM64 code.

I'll try to add arm support in the next version and will really
appreciate if you'll be able to test it.

Thanks!
