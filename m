Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5933C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931D6206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Xc5W+zQg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="k+6o3HJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGKCcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 22:32:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18938 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgGKCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 22:32:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B2QIFZ008146;
        Fri, 10 Jul 2020 19:32:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LN/80KJLKT4Nsf3hA+cLnFk+ND7TM9wMK+aXjJrRB8I=;
 b=Xc5W+zQgY1yOkJR1MRNfw8ynkNL5IwiUxnRZmniz58nP7XSkHABZIXl1giMc837ij4Hk
 InagdN6EBC9FKUgHMbvsbQ61rGbNWjh+WIfERGFkKUrffhkTPMHPhp5is8xZgBV9uNhQ
 sKLdex3eLaAVjUTizLwzek0xpd4sGY9nh54= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 325k2cdcae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 19:32:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 19:31:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJI6WaeNYhDHXha528qWilbO8AqN0WO/eAzypA3uHro4Cwz+uIWjKSsjc9Wx4W8JxDr5HapCv7mQHQF6TPL0yk2iiYs4R4B/3iu49tnig3J4eI2g+fYJwSS95yuMMQ2au5HYHPwboPqJBIey6Zd4qMYhxib9xzzN8iHv+rqhyKJ1QCeqKU3ci4qPd+0PhzkoYMc5n96iogs16iujXE9Iwia6TRml1dBkGWW7xByLZ6BbBo6kh1mWQHUC4wA/ELrQWqdevQYtBIcKCWyEBAmwn4Hkg5cXqJUN8Cjrjn621SWv+kHnrdnQ1GNRjFj5atsnua+LkdxHN5jtIhL/YvruwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN/80KJLKT4Nsf3hA+cLnFk+ND7TM9wMK+aXjJrRB8I=;
 b=S10KbaZZdMCW2jGgDVMSTlcWAhwV9SHtM55gC+hob3zpANEuIkj94XObUv6wssDvEARja/5fnwKSlkzhXkRsIHzsgsQG3e05r1PTFbyly9+Cb0IqxAmyJWO/qzX/LfKmbtyoAFgeoeuU/0o/3mrYs17IOCcD+KM/UxwO2RYkx09wQRYMT7oKq+TtLytq8u9nIwC5PnqaY39oFeoaZMqmpl5NUSf7gNgGVt4+6D0vKYvvYsha+01WChHJRPV5b//NHgq9FkKnfJANpZeUsiQr8AnlGbBP3nZMR0LiCK2oqQ+rAmFYEqWQzYSuTk57A9syaAHQZfMA4P7P6hyDaLH9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN/80KJLKT4Nsf3hA+cLnFk+ND7TM9wMK+aXjJrRB8I=;
 b=k+6o3HJIfaCGotqcTPcCAC17+Qn1JWf3aBMmeEEAXnkAlMnSa94ihim21uAiNfnJ9Jhzxj3dSuqpIv//1617m5ghdhbWTluh2ZfJPVkurOpHSJ4tKP/MbSgpVo0w2ZFpgx49vOCUTEm9bxumNcf3U+LidWjHs8MAMLfmS5i9zes=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Sat, 11 Jul
 2020 02:31:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3174.021; Sat, 11 Jul 2020
 02:31:55 +0000
Date:   Fri, 10 Jul 2020 19:31:51 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgrefill
Message-ID: <20200711023151.GA388137@carbon.lan>
References: <20200711011459.1159929-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711011459.1159929-1-shakeelb@google.com>
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:5bf2) by BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Sat, 11 Jul 2020 02:31:54 +0000
X-Originating-IP: [2620:10d:c090:400::5:5bf2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf62661-8026-4441-e850-08d82542939b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2279129D4A7443E2B7AC184DBE620@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT2rNOeAMuBcYiKi/TRMdUEC8kUleA+KArGaJ2NJqildOXmBgOkReZxB+Mr1uYl5Q5UXsDdp7VcMxJFtJC79CTt7GY+eTAnC8DO1bggVUPvMQ1O3geil8uE8AXTWLrPAWwTQlznV0BrrdVVGiusrZ3necMkPC5iWIb+pkbmlM1+mdGQsvpwiIT2T+Itb69OPF2oD5EykgudHqpoF0RVQA3LTp8A7fGQWjPuu0DZo3i9RRkaweXkzuWsZsOhh9YWAnCuiPGFtPZ/W2LNUnbnBESVAtzrQNPOmkrkomt8vGYfqWukgN2xIUkgoJqyS/f4d9NoLZmlr2btbFN0P32t3ByNhnYHT0XviCWG/dxBbi3bIiKxW3eg1QN+IrGRPNjWvbMVqG3LhKbEr4elZnGS3Akjzm24wAxFHLNjsPH9MXmsC7MHE/y6OGb4du4UaZCBQMMWowQ4rhSyIrfj9f+2OWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(86362001)(54906003)(6916009)(478600001)(5660300002)(9686003)(966005)(316002)(1076003)(15650500001)(8886007)(8936002)(6666004)(8676002)(4744005)(55016002)(33656002)(2906002)(36756003)(83380400001)(6506007)(186003)(16526019)(4326008)(7696005)(66946007)(52116002)(66556008)(66476007)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: suG03wQhRqWa8IdtFpr2e3dJI37mHzPlO9fLLpPSvTLIykIFQ9cxY+dYybqJdfuoRa+mA2WgQn46F7lfd0sMIwDgAVGu3CgqKSs1u63g+CKSTlKnidzV/h8hx/WiM9P6BD3f5jDDGwmzDPSDJRYS4pgJUG0j+8zOmNUzuYq7Hbfw8QceDOn+DAjZDfIAcWUHbXxjKfq34vRmtDM/L4LMGrYfUqmWGTC/Rzc6i7mOpB6jp+dIRZghryEpOSqgGMT7SL5/bdrq60PzD1B1urrkFDdIadCYQTZbcXHjV0vEwydpm22wWx4zoDe72vaNPUAFl8hEGA+prqT7MUo3vgZKlkd6YQaILW7j7l4WjTzk76+eaUV4AgFJViDj48Zzuoprv4pHXtgnFNzLPuTlvT62LoLFH1zyEMYy+DwMc4HG9u2//LEUcI8Ezr6Kw/o0LN/3XP5kOdhNm85GcU/D+bQbrgWMiNuUsuqytc0w6cwSDnShbIU1AJqEFoNwTeOCH0uWwIyvHcpgp2aBhoGnFOivug==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf62661-8026-4441-e850-08d82542939b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 02:31:54.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpoaOjF4r6E+x197xhx1bdDcpzWrE4qWYtIULFP7tQgXgzfPVvDpJAC1qcEURAlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=992
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110015
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:14:59PM -0700, Shakeel Butt wrote:
> The vmstat pgrefill is useful together with pgscan and pgsteal stats to
> measure the reclaim efficiency. However vmstat's pgrefill is not updated
> consistently at system level. It gets updated for both global and memcg
> reclaim however pgscan and pgsteal are updated for only global reclaim.
> So, update pgrefill only for global reclaim. If someone is interested in
> the stats representing both system level as well as memcg level reclaim,
> then consult the root memcg's memory.stat instead of /proc/vmstat.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

So you went into the opposite direction from the "previous version"
( https://lkml.org/lkml/2020/5/7/1464 ) ?

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
