Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE326C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94EC206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GlzuPKzb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aySIBPWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCWXg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:36:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgCWXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:36:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NNaHHD023186;
        Mon, 23 Mar 2020 16:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DpQ8yB+nNwXMGvKhbGkwCz1608cukHEBXg+MhvQ1UjU=;
 b=GlzuPKzbQG+0862X1Kt4ib16SR/jbblcvVGkbE7wByMO1hndU5hQxKSBnAAqkxqxjGRU
 iXY6m/u59nYYA6kGhbiujmBstJQoGpxlFV7vq0ac0Xspt3nkBwcyyhuvr47rcX6SzVE4
 agKPbX78iEUa098LzooIx/qnFxLGIZFv7Mg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ywgektsqt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 16:36:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 16:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpvUb1xmajb+xTJkKkCQJAqq5QuD6Iz399uyhePvF7mOyrWC5XfQFMCLuUtpduP76kZQJ3+E0Il6eYxxD5EdlQb4lTSJzzT+W7uENBsTI7EDvp/DME1OaMg191ay4Y7W3ZIBl4AqVic2rlTedknacaZQKENZOYFGiY0Tcpz1YRX4TbDOaAjGBb+pWV4LSn/qFS0wo+mnoWBEO0MX5fJq6Mi0/i3LndflAx39z72Ui2OBLFqfs1iv/96LoZ6djQjfl+2owfMMJE0rU0UP0Q22uf58nTWVtS9t71UgG5jstLD77AEoyDYr3HSOtXRt556BshRqFEKPcGPKHLDNZDecYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpQ8yB+nNwXMGvKhbGkwCz1608cukHEBXg+MhvQ1UjU=;
 b=gSjIJ1HEaUr3LtvYlBwyVy3Y1uT0N4574z1WY6ZnuSeFzViNTF3sraznkYsUba9GmDAxyS6ZBpcGUNJiFNQBR8jeu3Y4KiJ68kD7hsZT8+W/JZSCfhar3OlOp4cMkwL3fLkwsOqR3XV4ySd/gs8hglZwafEPoK1F5i1Jo/B437aX3d1qghmsIYUCgvaWOfMRtILAW4tGYLytmwUGaP/dQa3Ps07vHds3ixpwfZ00L9AUxyJ/AAABTK64PHxeqndJUUP7eIw4zQTLd4aABH7mCuJbczhmCMYBHv9j2ZRAuorNSRBOkdJmUfd9ehkHRhCEPTa+7xe8WoQCVNkemUIIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpQ8yB+nNwXMGvKhbGkwCz1608cukHEBXg+MhvQ1UjU=;
 b=aySIBPWhCAHVd6Epbzi3lCTIiis3gonOHd+jqdKwlfAsNxgtIpAnyQIR+SHWHKN4hI9X+RIYHLLTGWE9efLE7uKGMbxuo/7KbfRQ49+shQ9vQCuQ4NsFYrrbGfMX9lrLKi82mmJVgAvw6nTT7GLHwGQPXf1FMBdDnrAZG037hac=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2536.namprd15.prod.outlook.com (2603:10b6:a03:159::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 23:36:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 23:36:08 +0000
Date:   Mon, 23 Mar 2020 16:36:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [Potential Spoof] [PATCH] mm: hugetlb: fix per-node size
 calculation for hugetlb_cma
Message-ID: <20200323233601.GA30285@carbon.dhcp.thefacebook.com>
References: <20200323221411.2152675-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323221411.2152675-1-guro@fb.com>
X-ClientProxiedBy: MWHPR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:301:1::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f6ef) by MWHPR11CA0023.namprd11.prod.outlook.com (2603:10b6:301:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Mon, 23 Mar 2020 23:36:06 +0000
X-Originating-IP: [2620:10d:c090:400::5:f6ef]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cabd7574-ec0d-4232-fb81-08d7cf82f61a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2536B5616427A75C9554EC4EBEF00@BYAPR15MB2536.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(55016002)(1076003)(316002)(4744005)(6506007)(6916009)(54906003)(9686003)(33656002)(66946007)(66556008)(6666004)(86362001)(66476007)(8676002)(8936002)(81156014)(4326008)(81166006)(2906002)(16526019)(7696005)(52116002)(186003)(5660300002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2536;H:BYAPR15MB4136.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mUE3AkKGDRxJmO5Z7m8wXWSVoqtFj7GBHY2MT4XPgqFCT3E0xHH/nEUFc92iGSukU9HydAno/C5u09v+ZptiVY70a4Egieb41uYQP1uOs8SgcWmZfJGCVP+BbmsjyMWwgLBCY/yNm5+E4azDjKth+T7C1aWGo99dNgGcwtdx2mu7/N/EQw3E6jNZJzuuXlkIw0G0VHSL+QOwWNnT050NB+ZRxa23FGla4L73F9HQxqg71+yWw9oA/V86jUJxsuU9wwGRirKM19KPJClun66m12+KuTq0c1mSTTQ0rN9gg7+NPCfomtXSxy4ruuJD1nHdA6DH/v1lat5H0rirRpgD9k+K4ZB/6ptC8vOU11yG49c5SPj+I9ihw0pscPkrIPJBZDLf8JN99TttSU3IvUFKbHJ/uUSpkbY2e/sr+S6hX9v9P00//vH9JxWnSvEcta0
X-MS-Exchange-AntiSpam-MessageData: 8U73ZxU8huXXt7axnvtXMPxUxLgoazMnJigej6EoDQ/SbAIh9GjSHNC/sz3WV/UpXpUxQbU+MeXrIXvIL08QtcXgdbGoFuRnyt6XMwd49yg1U4Axd1pR46jv9m3JORC4M8oZSzuz41qBMm5N64dyaRI7qVgZ2GCnXsv6A5XQ+bLmWAyIBixBbQb+1e3vmPEk
X-MS-Exchange-CrossTenant-Network-Message-Id: cabd7574-ec0d-4232-fb81-08d7cf82f61a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 23:36:08.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkaqN8YgEeqzK4YLipzwzvY3MMhXJQn9RlRBgZA8HkmN3jYTxIEteI8qxELJ1MYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2536
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_10:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003230117
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 03:14:11PM -0700, Roman Gushchin wrote:
> Aslan found a bug in the per-node hugetlb_cma area size calculation:
> the total remaining size should cap the per-node area size instead
> of be the minimal possible allocation.
> 
> Without the fix:
> [    0.004136] hugetlb_cma: reserve 2048 MiB, up to 1024 MiB per node
> [    0.004138] cma: Reserved 2048 MiB at 0x0000000180000000
> [    0.004139] hugetlb_cma: reserved 2048 MiB on node 0
> 
> With the fix:
> [    0.006780] hugetlb_cma: reserve 2048 MiB, up to 1024 MiB per node
> [    0.006786] cma: Reserved 1024 MiB at 0x00000001c0000000
> [    0.006787] hugetlb_cma: reserved 1024 MiB on node 0
> [    0.006788] cma: Reserved 1024 MiB at 0x00000003c0000000
> [    0.006789] hugetlb_cma: reserved 1024 MiB on node 1
> 
> Reported-by: Aslan Barkirov <aslan@fb.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>

I'm deeply sorry, I've made a typo in Aslan's name.

v2 fixes this.

Thanks!
