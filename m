Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC2DC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F3C24948
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ma2mHEms";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hrVLvEaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgDFRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:25:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58130 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgDFRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:25:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036HKtOo013344;
        Mon, 6 Apr 2020 10:25:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ti86zN6FUTimkKvCsyp1FGIZ+MKw9E43HzbJn1iExF0=;
 b=ma2mHEms4zN7b1CflKToojmLNGqqvOZ4IdxhKLnCJw4fqrrAl/qdsLjXnixVDVHW+0La
 XhG8KGoDdsGMhdrwk6Pj9Ag1BopFkmf6GasdUCyf/8NVulctGuaiGBfoMB9zS/tXOQ/t
 zZoCIXb+3yggYP1QSgBZXJasXcY9LL/hBT8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 307acx3f4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Apr 2020 10:25:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 10:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR7diA2L+2OaYBHPspisL1OaDwUuqkAiKkuHLtYVtloN3Ezz/Pc8HlSRUtb7AJLqeMAcvkLQ/1/81K1okabRsR2Nz2OWPW2t6Cn/w+lMtt29GTq+iiHfU03Bi/lBKMJoiT8OzxeW5O6ms9l4gTgUEbW/f99mdK4zSE6kr4byAdmKujOYYfHyMV+MD9FkChzwa2ym0EAK8oZFGpZtF9Y4Yp9P4lgVm8FrnwU6mm6rx9yhpJsB5AYErf59krUNY/N6Y14YJ9bqrX+lh3gk8ar9mQWq0zw7+P5LbivrEaajnbKdtj2szg2K3mgw7msJP8McABQ5P5weS6QZ9IE2FTBPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti86zN6FUTimkKvCsyp1FGIZ+MKw9E43HzbJn1iExF0=;
 b=mRW82iKkyLXaqfs/PuObjma7pA3SihwB+rk+IPayS2b2hU4h/DD7LJWOCgjJyWqQDoOUzOvTddQGU/zcQLVoPu8IAqeuroKCi5qoSjaZVPD7IQmbANZ6Vq8CFIchaM1vrhx8I4e5Qdv5Hr6LXeLsZy64a57mkzXY5ZRo8SKcSHBlzDxFilcebFHe90gQ4WSYyu24Omx0pBLR4r5tdzyXlt2FYV8/eLLlULRqyA5/4+GX0iiMKOqHcomO7C73wy4LJwfk4Im6khgstrVNLSBGiy31C5oaEOmczLklNcT4rNv+0o85DGmajPP6ZUys9gfkLEd0mqzT3+7Gxd/URUHKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti86zN6FUTimkKvCsyp1FGIZ+MKw9E43HzbJn1iExF0=;
 b=hrVLvEaWzeWS24J+w6uhwYVyD354P2Cz3MsY5iFN0W8tlF83mMA9efeeon0mexKXAMjPK6C1sXOPKwZf7yKLHIyA+N0XNMhZrm82TzHSygtKVRwwhc0gGOwTP/mPaKIzBjglAohqcL8+hN/hGjKo7f3zazOmKAx6bC+u0n/w5Pg=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3494.namprd15.prod.outlook.com (2603:10b6:a03:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 17:25:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 17:25:30 +0000
Date:   Mon, 6 Apr 2020 10:25:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        <andreas.schaufler@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, <js1304@gmail.com>,
        <lkft-triage@lists.linaro.org>
Subject: Re: mm/hugetlb.c:5580:3: error: implicit declaration of function
 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'
Message-ID: <20200406172525.GA338360@carbon.DHCP.thefacebook.com>
References: <CA+G9fYtfG4nZs0ON=bBNarPaycNOgGNvhXxcdrGzM1epDDBt7A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtfG4nZs0ON=bBNarPaycNOgGNvhXxcdrGzM1epDDBt7A@mail.gmail.com>
X-ClientProxiedBy: MWHPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:300:115::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9e6d) by MWHPR11CA0045.namprd11.prod.outlook.com (2603:10b6:300:115::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend Transport; Mon, 6 Apr 2020 17:25:28 +0000
X-Originating-IP: [2620:10d:c090:400::5:9e6d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1110e538-71b1-4305-0aa5-08d7da4f8119
X-MS-TrafficTypeDiagnostic: BYAPR15MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34944C7A95C7BDA76AEAFD1BBEC20@BYAPR15MB3494.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(376002)(346002)(396003)(366004)(136003)(6506007)(1076003)(2906002)(7696005)(4326008)(54906003)(52116002)(7416002)(6916009)(186003)(16526019)(33656002)(9686003)(55016002)(66556008)(66476007)(66946007)(8676002)(966005)(5660300002)(6666004)(86362001)(8936002)(81156014)(81166006)(478600001)(316002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJPntkNsq9H7tprVXL79nawaWHbxl2PVvjfs2pxwynXbTZqyYWTlFFJmlO/r4EV2YEG9JQ9GDoirNu9ckSp+XHKbSdRqzwdAk4oqL1bIT/2dA6c+W24LGqdki6yhUzyqmMInLAfEzbgoFVE6bTbm3Vj8ghpm32kCOQ8RBfRTw4YSO3XBHu57ixA3bAPHRLLKwfa195rUJfWs8E+aFXtGuMdlbmVW927POmKEbIkyLkxwhZcaeQ28aCdkzHuxqpQNbV8xnfLI6mzpX9I3n66TXEVv7CKyr5xZqE8nc2DGSQLE0GiE02CDPjOoakiupIxwmNhbN3qGapGbdlI0BrcV5x9rbbK+sJR7IkMEUVGMARbkglDkmshhXmtVvfpXeNBVMYc7mZPUUXFapLSCDrv9Ftm8QP4Ei15/BZOK4GoNsmrHONN4I6KtpGnpxahnupmk6z0E4xMYAP0LFjus29vtNv8P4CoiojDk8hjbFgT6RGbRqfGIz75AqEaYGvVQ7tKo00tAyzhwg3KX1HqzIoC6nw==
X-MS-Exchange-AntiSpam-MessageData: 01v9L0jBx7lAhzHjZwJ9Rj46IdYOuhJJNrgGNRVH+JOv9EkP9ZdoOwq6zuSN/lvTFStQgPBWUB9UmqzZzjEpFzZs6ZyItdlFdjZbhrHAJexUrBQXHqv1f4/5aMf7FFqvn8iZNIdMctwYe9iuU+Nb0y8EmSSe+JiCpPOISBdPFsl8NYrqILTCF3ZvzhprYo4D
X-MS-Exchange-CrossTenant-Network-Message-Id: 1110e538-71b1-4305-0aa5-08d7da4f8119
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:25:30.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN2g0XC6XAql8/f9TARhai3mGyld9r0ii80T0zERrGhQVUKNaBypNDYcI2hmq5Pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3494
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 suspectscore=0
 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=1
 bulkscore=0 mlxlogscore=209 mlxscore=1 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 07:48:54PM +0530, Naresh Kamboju wrote:
> While building Linux-next master for arm beagle board x15 the following
> build error was noticed.

Hello Naresh!

There was a number of cleanups and fixes to the original hugetlb_cma
patch, and it looks like some parts were lost.
I'm going to gather all changes and resubmit a new version later today.
Sorry for the inconvenience.

Thanks!

> 
> mm/hugetlb.c: In function 'hugetlb_cma_reserve':
> mm/hugetlb.c:5580:3: error: implicit declaration of function
> 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
> [-Werror=implicit-function-declaration]
>    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>    ^~~~~~~~~~~~~~~~~~~~~~
>    for_each_mem_range
> mm/hugetlb.c:5580:62: error: expected ';' before '{' token
>    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>                                                               ^
> Few more details about build test,
> 
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> 
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> # CONFIG_CMA is not set
> 
> Kernel config link,
> https://urldefense.proofpoint.com/v2/url?u=http-3A__snapshots.linaro.org_openembedded_lkft_lkft_sumo_intel-2Dcore2-2D32_lkft_linux-2Dmainline_2591_config&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=UExtNmMVvgxP1D5SQnPuvrZmT1KYfONSBf9zENyfrs4&s=O436GE4UqAvqVk0stawAOhOUm1bNCFpZzxiVeNSs-ck&e= 
> 
> Build log,
> https://urldefense.proofpoint.com/v2/url?u=https-3A__ci.linaro.org_view_lkft_job_openembedded-2Dlkft-2Dlinux-2Dnext_DISTRO-3Dlkft-2CMACHINE-3Dam57xx-2Devm-2Clabel-3Ddocker-2Dlkft_743_consoleText&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=UExtNmMVvgxP1D5SQnPuvrZmT1KYfONSBf9zENyfrs4&s=nuGZRu4xyY-99ohWh1uNDTo6NeV62n7kSsyoefxEGvI&e= 
> 
> --
> Linaro LKFT
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkft.linaro.org&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=UExtNmMVvgxP1D5SQnPuvrZmT1KYfONSBf9zENyfrs4&s=uYemxk7TXD2Qie6H7zY9UjuE7zlN5ILjbD_1UD3jo4A&e= 
