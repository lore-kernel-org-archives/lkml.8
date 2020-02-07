Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB594C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7611F20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UDQZ1bHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGJWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:22:25 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6219
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgBGJWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgQUyOfmQMQ6LGgdbfU32xR2AXGMrYI8i76MGg7ln8rGq7/y3CoCzpac3eTT8mYQaUuUx0lsmoszIAoY9wahaQTgnv47f+QsDQ4JsKF0Jp0MXO44SOvV8M9O//QNNOSibJ+VJAReBa244QpaCuDS/vvOagmldSZkV/1l1QHhKwmuxPHyC3lfi6HtT1RhHr93CzCIQjgvMBWM/LVSRjCog6KmOWGsSkgNu8qs+OBtKLpBBumZng8sSdr7neq3O6X6HJ3V9GF5baZlcfrrbU6+mW2E0ZWmcDEo+Q56XRHJi7hq6OF7sV4l+KON4SUlzqv+e2VF4Lpjf8PoqyqS9uZBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07f0cI0GmQTJEGwYTbHa5UJQxIVJ9iQWZdvQaLfpFVo=;
 b=X6HMH/WOo+T8lpE83KkjA280bCW93IAxZs3PM58IYNfzeZ5qgWSMhd4Z871CvmVqKNlgCOUoGHBxW4lVFIiyf0Q8j1b6ipdgNCLKPYAGchYSulldVuOqNdIa5ZCekadbRm/TOjSVgY2+r8BhPT3MeGsL84QqobNNH7c9993sJrZE74oEdeBC9o3Ja1cxkQYvk5RD1Sa0rZmFNx5BHUNIEEJvDKNM0DOhfmrcOeejUpsfrV5XU6Pjq8OiVCFPLVm/K16JnRL7jQaEEDh580//ByIUSuaVI9OKuQ5CMK9MeHMTVSDowVLS5WY+vGJMG4wWwB6KWRDc+ijySR+8uyf5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07f0cI0GmQTJEGwYTbHa5UJQxIVJ9iQWZdvQaLfpFVo=;
 b=UDQZ1bHLr5nXNCT3+o8awEz4pwfGQz0RgPdsTbMR7A7ILontC68VqUUjYX0Cer3QFzwVZAO34LmH2/g2cJPfxNUYZCxGjtoT5A9ZPDnkWgkGZt8RPUSOq3SXhZg0dRjcY2PmSev9J6NgF/3UHZjfeTzi0TC0+oivROx3yVtmQcs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3168.namprd12.prod.outlook.com (20.179.81.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 09:22:21 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 09:22:21 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     Shyam-sundar.S-k@amd.com, jdmason@kudzu.us
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] MAINTAINERS: update maintainer list for AMD NTB driver
Date:   Fri,  7 Feb 2020 03:21:58 -0600
Message-Id: <1581067318-103927-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::11) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 09:22:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1582d2a2-f224-4aa4-8056-08d7abaf3ba0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3168:|MN2PR12MB3168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3168AF361A45AF5198722F23E51C0@MN2PR12MB3168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(2616005)(956004)(6486002)(86362001)(8936002)(316002)(52116002)(7696005)(81166006)(2906002)(8676002)(81156014)(66556008)(36756003)(66476007)(186003)(6666004)(4326008)(4744005)(5660300002)(66946007)(16526019)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3168;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q2sQtW474kroca7ryGxUtZPcZDs/+CSAi/UHRmW5ftXY/9S0smXxu0G1oZfhch68rK1bUF8NFl3PF7vPbxiH3pZFlnIzbkJoK75Cjx8d47NgkgbzyvbjzEslhpoy+6/j9bUoR/hl9A0IoAVbdFDJ3UibvX2mzC6TyaexYMd6qCfIuRiaMjVHQkaLsKs+XJQQP1G2Owr4NzSj5gELJfMs5VNgU8qXjN5y8DydbQaq9dLQEFJ0aQ5NttWPJlsnGCzIpdmfEevR9MhITN8/9JAn9V6I6wV9JGvrbh9OhkfS45wGY7FO4E2KGBbBXAmHjOh2kDWT0PuaoHsIjPxs/8NKSfuQSARL+EAzFjnRcoJggavx+2zbV363TiOtC84HkAcWMJdBVsf651znCgpPRgcX2Umlyz60yQROcx0GjYCDWWQeiCOc5p/cHWxMfJS2k00
X-MS-Exchange-AntiSpam-MessageData: p0M72BWB4B09pb92fSsMf9uD8hbKOh8oY8llQ7AMIyvFBVAfk2bIeyTxdS0n7NUXLVOk8Eyv3HMt9oUboPpuF9zsrnrAHeI1SsYm04Vcdq2ZP2uy1YWq8maZtlvVlPHEN2SLY81m9HuEhfsrcbsGiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1582d2a2-f224-4aa4-8056-08d7abaf3ba0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 09:22:21.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrfVLgLE+VSudLqEPgi56/9XMyLFEg1k9C1G01Gm9fLf52RY3hEgM+Lp7SctF5jneoBxoKIFg2VIQFrqJRtxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

updating with my email address.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9a8d15..040ac53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11734,6 +11734,7 @@ F:	scripts/nsdeps
 F:	Documentation/core-api/symbol-namespaces.rst
 
 NTB AMD DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	linux-ntb@googlegroups.com
 S:	Supported
-- 
2.7.4

