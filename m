Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A99C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9106206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g700hgH0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QUH1fMIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCMAzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:55:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29066 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgCMAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:55:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02D0nVZX016606;
        Thu, 12 Mar 2020 17:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=h6lk9tvoBlRBW8iOwSnNQdtcIc0tP2DUrU5IUG1cNFI=;
 b=g700hgH0w8kDAAo+l47vMo9NQ4aEhlaBkvoVU/N67E2A0FMbLlT5DuddRXyfw1CKlJkY
 xKHTTNLqQ4B8+hmDNDIkXDmggN+eKWDkoqXHVsnCMebBbFgODYi1wFO4Sdxa0JfSHiFz
 sSC6famaxBKKcrjrw0e9zeD/AFN5iIYdfs0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt79hpuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Mar 2020 17:55:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 17:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUAVZPDjjwnPPobzznB3zSmFHpibupQCQRAdzAP/EkvkUhGp/F4ZH2yLX9gSW0Pa0aoB3fMGlUPcMOxIsCKRbmW6eu7PaG4ohc7xHQK3auUjUiufRDsJlHsBRT+81Zul1qV8k3pr+vr+B+kSfA/2oRzVdgPS+8FNOfamrXbB3qz2u5MUtfMI8Kptu0Nn6JR9GzKSWa1QN5n4bKvvctV/ytvd7J5NO4H6AxuZPKbiknqGfwWYlCWkqjYM2CLvMlMqGcA1xduCsSEp7gb0VPzb+5X7kN+Uf7zMYqDtp6NfYNrChY0k/tDJzFAjRcSUfgI+WI5UUfJzDbElVOiEIVbJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMP2ZaZvurm2QsoWbRadtUUddbBLR6WTW0vSEmlosb4=;
 b=Jz1qS1AdQtv0RbRORItu8JwsYUBuFvS1Z/mEx0b/i8L9+4S42FTldJTSRiXrAwYKCCjj6jwfycMgq2usQgdY7gp2zsjrFpstIdaoAutaBr/q3rclgh9hjKDzTtz3KBeog5o5dE66Bk6z2trDjQRder0uTCw+PsO1yYAaVc9QCuiD/dJl2us0HEZAtzZc6dESnZAUDNJkbtaY29UoR9T/fX21Zzqer/B0qRESStiNw/10tqADeCp1FsE6KzoIG77rP1JHRYzkRS1PyuPApcOd++6dbMcgh2kjTyisgoQrWXKI3AOYcUbvt8RpYJQpPL6CcX6+oEYHGahC9z0vc3Cu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMP2ZaZvurm2QsoWbRadtUUddbBLR6WTW0vSEmlosb4=;
 b=QUH1fMIYh32mrAvZvMmd831hbujbV8bLJqpTH5HfJs4a1+iPBLdB4uyXsLNcJF00Y4EN6agtWinDkSY1dVHmrgWj7q1njOagr9xx4LLxvTQBKfKxhnROxteXlRgjqj7W2cATVBsF9JB/IYefxA6QenDqPYDYS+K0jbzaa/mE2tY=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1600.namprd15.prod.outlook.com (2603:10b6:300:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 00:55:04 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 00:55:04 +0000
Date:   Thu, 12 Mar 2020 17:55:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200313005500.GB5764@carbon.DHCP.thefacebook.com>
References: <20200311220920.2487528-1-guro@fb.com>
 <1584020000.7365.178.camel@lca.pw>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1584020000.7365.178.camel@lca.pw>
X-ClientProxiedBy: CO1PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:101:1f::33) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:344c) by CO1PR15CA0065.namprd15.prod.outlook.com (2603:10b6:101:1f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 13 Mar 2020 00:55:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:344c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb1c3b9-009a-4e98-8025-08d7c6e92a69
X-MS-TrafficTypeDiagnostic: MWHPR15MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB16005CD55BA7543F201635D7BEFA0@MWHPR15MB1600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(9686003)(54906003)(316002)(55016002)(1076003)(52116002)(4326008)(2906002)(7696005)(66556008)(478600001)(66946007)(16526019)(6506007)(53546011)(186003)(81166006)(66476007)(8676002)(6916009)(81156014)(5660300002)(86362001)(8936002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1600;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgkH05FbvZyhcuAtMD/7jPCN3jxn3RDJxg1fG/h7XzH2PRlZpWYjwWQzxJJCIe+C/ETL/zroxmluNsvisb0n+K/hHqbV5/WVE08Zqgxdbd4FOrqou4AMKBUtQnJs6tjooZkKixtbkzGsI/KKfl0vpLD1PnQC5IUYsIOYZSHcw7nk332KMM+2/1/Fqa3xgdk81ixC6UohsKoYHKjdM6wigKrqr46+1HmX8LMycec/b+5nZ55DSNVtD7xxP0jQjIucsNtR91NaSGNvRI62MpFewu3x+SnpFpFlqSZRkPBAX9thSDU4bc0Kreiur3JMgem/0HdbXVZsV3moC79K2xssCAPu6j0GADgopqf5iHcNKQwjfXxYaLOacIrmHnXEup28pWSc+XjKDrFWi3oO+PlCmE9gIUcZw7rMBBLWd8S+ejCUXY4vmiFFqhF/jhWh/Zf+
X-MS-Exchange-AntiSpam-MessageData: h5tInr4BkAkrgLbTVlifCoSSX3pHCBMA5mTwkN/It0jeCc+mYiLYjwuBViX2dyi84RFIUn8W2epvOPNN3fVvFg1eyvVnYEk03vqXwOZ72XI5hn1rVND9jWmM/Fy4HsQF/ZYYVJcg/MYWnf1atILroQw0kYluj59bKfTt9djzT5aPU48qyGbX8I0p8NCX1wGZ
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb1c3b9-009a-4e98-8025-08d7c6e92a69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 00:55:04.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Embp8Y59kJSn6SbFkD8hVb1p1+jdSycL+Pc9fQPYvYJVa+0idN2EZpePPHeyVmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1600
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_19:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=56 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=696 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130002
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:33:20AM -0400, Qian Cai wrote:
> On Wed, 2020-03-11 at 15:09 -0700, Roman Gushchin wrote:
> > +#ifdef CONFIG_CMA
> > +static unsigned long hugetlb_cma_size __initdata;
> > +
> > +static int __init cmdline_parse_hugetlb_cma(char *p)
> > +{
> > +	unsigned long long val;
> > +	char *endptr;
> > +
> > +	if (!p)
> > +		return -EINVAL;
> > +
> > +	val = simple_strtoull(p, &endptr, 0);
> > +	hugetlb_cma_size = memparse(p, &p);
> > +	return 0;
> > +}
> > +
> 
> Here will generate a compilation warning,
> 
> mm/hugetlb.c: In function 'cmdline_parse_hugetlb_cma':
> mm/hugetlb.c:5548:21: warning: variable 'val' set but not used [-Wunused-but-
> set-variable]
>   unsigned long long val;
>                      ^~~
> Also, the comments for simple_strtoull() in lib/vsprintf.c said,
> 
> "This function is obsolete. Please use kstrtoull instead."
> 

Hello Qian!

Thank you, you're absolutely right.
The following patch should solve both problems:

--

From d45741afdb9a760e48915c2d19e750f53019e19c Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 12 Mar 2020 17:40:04 -0700
Subject: [PATCH] mm: cleanup cmdline_parse_hugetlb_cma()

Remove unused code.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/hugetlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 66bfc2bdc203..7a20cae7c77a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5409,13 +5409,6 @@ static unsigned long hugetlb_cma_size __initdata;
 
 static int __init cmdline_parse_hugetlb_cma(char *p)
 {
-       unsigned long long val;
-       char *endptr;
-
-       if (!p)
-               return -EINVAL;
-
-       val = simple_strtoull(p, &endptr, 0);
        hugetlb_cma_size = memparse(p, &p);
        return 0;
 }
-- 
2.24.1

