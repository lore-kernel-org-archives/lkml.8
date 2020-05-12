Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887BC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EF32072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GOYRuq3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgELKJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:09:47 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:63393
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgELKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJMLlC1cPeOr/QgIG/ZlPunvVZR2p3CygY7bGt7Q7uCDp+6wT6iLOCVxiR1uyFECaXDKEWHlKSjZoywbxlhLa3R5sxcJhajCH8Bz8/gyHt0A7U4E/IaAIqQcASoX44wArWeqomPfbrtETD9qwPIUZknV+PGHEM52WnCgnO+jPlPvQCk5F6X5e2Sz3TAisBN21GbEz7Q2ap/bbgtVWiYfnn2hQy93owa9lQeLe/WiW6AIO0nhFo9lI7TGETrxmCWUqmm+4ttOhzsYZvxKemZLVh75k9fga8I1h54bwf7ClFwQohl30PlRrxOxmmADFRkMBx2Is/vYgV61siGGlGiikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFkQkgUlW2AmGjwfOSn5kwX9+ZwjPY2rffOeSZOViCA=;
 b=LKgREaf1CYXfZKkCjDvRqf85Iu2D3rbYHI095Ra2jKHLZk2DLjMJ0SHMRzWI8jILkP4dTgHXDm2FunIuvOLJ8F79jMJs3H8Hhv88VEsqu/OZ5jYRHcxh5jwbB8qzJj+RgdtSeYl7ahA8iyEEHIRRu0MoiyyzRmOvPoM9PJEQ2MKmq5rOVLpJk2jRSc00dJLlfLBPyBFPtJiEBrsY9bDhkONIWeWyAsoQxJ7iolRz6xqecM4wMTTzFF/J5/uc4BQKZXDppMsabxC/KsamffbaBQRmUx4yePL+75gRTEH9tbeBnxyP70BDVJkVZhR3SACti/8dhlJcB9Aox2tCLAasSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFkQkgUlW2AmGjwfOSn5kwX9+ZwjPY2rffOeSZOViCA=;
 b=GOYRuq3y2r/OQQ6u/xyLVWUNW24sNlM7q1GLcAwm9xrs0dN6gJwIZ14YwIFZ2Y/aHet2cHTS7ceCTZqEZFpopjB9z/fny38JMOmJgYY437HJ5TWFtRo1cLE0y+uJCAgKBM0uwSAUB+A1UNETtVklqBT5MMNekHUGVyjEt0r1A9o=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB5379.eurprd05.prod.outlook.com (2603:10a6:20b:57::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Tue, 12 May
 2020 10:09:43 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 10:09:43 +0000
Date:   Tue, 12 May 2020 13:09:36 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH rdma-next 0/2] Fix kasan compilation warnings
Message-ID: <20200512100936.GJ4814@unreal>
References: <20200512063728.17785-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512063728.17785-1-leon@kernel.org>
X-ClientProxiedBy: AM3PR07CA0056.eurprd07.prod.outlook.com
 (2603:10a6:207:4::14) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM3PR07CA0056.eurprd07.prod.outlook.com (2603:10a6:207:4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend Transport; Tue, 12 May 2020 10:09:42 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 647f244d-d82e-49d0-8e5c-08d7f65c971e
X-MS-TrafficTypeDiagnostic: AM6PR05MB5379:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5379F2737C9E86093E334A7AB0BE0@AM6PR05MB5379.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vkq3mV0PYDIXOr7OAcYhoV+gPxU7OkLA4cv0PDIepDmpbPWhkbzuba2NSz0LhYP+9LY8IiVxItBxESp5wVvnFAQwKxh3m+W7dGs96w0ytWgIAVX7ArgjarCJbF7Q1rwYdP5KATaa+wZl7pMvU0PeX1UsgeYYAL9ScYVM2UBXHr/B7BuDnYnNIeiSr8yNlLRR0FYaNFtwKNNBjMbb25oahOYnfeUBgE45xGIqhefBSyvrFPfz0brQJhCn3Rw6Pi/IYafTK5n+qohlGCFyubOd7El5TzNBDvu0yYcSnQDSkd/eny94dSD41DH79jI7vVK4WN3E4OUBhLvzLruC9uLu6Af9OzAcb6w4tH6zSAXndzEDXW6fxSiYFi4HlPJgT/cYL92zmUS+AvizMJvFlQmASUwWH52ZqSLDTft3nIFB4YC44uWt5W8ihoPXmAn3QiiuAphG27GDzacRTZ7dnkhHRzV13vTuoV8biMAeZPEErc7xJYh2cvd8B/0b1RVlb1JpqO7qg4v3G6t60KoRdxCJ+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(33430700001)(4744005)(1076003)(4326008)(110136005)(5660300002)(316002)(33656002)(54906003)(6486002)(16526019)(6666004)(52116002)(33440700001)(186003)(478600001)(66946007)(8936002)(6496006)(9686003)(86362001)(2906002)(33716001)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AydzaXdGbyxpKz3wnTvoZeDjW55nJLimufSBx1AUu5/2OuJMO0QnEr1bIRWZB1LtPjQzCGt0R6r78rFcFzXKDl5U6g7Vg1Y4MspbA/9bM3QDezwFa4lUlzgQI1oFKWwoVgTeCsqr4unG/YSVdLHH9m/ww5UnCeQXwrv4HiTM0GMhgVx5QdbrS/q3lXj1RICKU6RvJeCna4lRLUqi6bDOvscQOVbaZHXLwB3Mci4o5VxYR0doUw9SSKXKw9dD4dHwrYT6KtgvI78WuAZFwsm5IXG6GrCEVIuXVBAoItIfIaOC+SkUTBs8r2khlw64nPVw1EtVpoBwPsf6M9pQEZO3f7OV2ag+SFIofrp1eGxE6oiP6gFIciZl0j/2TfDLlyeJt39iTaSpWp2gX3YL9pWtPmIvySNQGgVg+oQa2X5ZONzYzvzzWZtcGEMTY2Zuj6TP6vvMyOyetq8Z3PpMnCMC/gpxDN840/9YAN2uEdYL5g3xrCfkIktNiNPS0uLBgUolDzW9XZOC6gGgV7buC6nkgg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647f244d-d82e-49d0-8e5c-08d7f65c971e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 10:09:43.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U23lSluncczgnM5D1/1pPsqGez/QA6C2XSO/P8LrcZ1vxyvKDuMJ2G+xHcDiOgqDC0gLOIBgZGf+WXwEgM5y2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:37:26AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Hi,
>
> The following two fixes are adding missing function prototypes
> declarations to internal kasan header in order to eliminate compilation
> warnings.
>
> Thanks

Sorry for forgetting to clean subject, the patches are not "rdma-next"
but MM related.

Thanks

>
> Leon Romanovsky (2):
>   kasan: fix compilation warnings due to missing function prototypes
>   kasan: add missing prototypes to fix compilation warnings
>
>  mm/kasan/common.c |  3 ---
>  mm/kasan/kasan.h  | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
>
>
