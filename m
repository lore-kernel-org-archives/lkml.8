Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270DBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 13:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DF92074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hBxIwCoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgFFN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 09:28:10 -0400
Received: from mail-db8eur05on2121.outbound.protection.outlook.com ([40.107.20.121]:23583
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgFFN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 09:28:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaY2d5jj8+N1oYm/oYcfZtmtzv/HOQuidUZ+99cxZg31XvaaA0G0r4ht0msw3wK1zS4lzC2821HhMPskrYFUoQVpge9WcJ4Pr+NqX+8Vo7vJK24lbS5BjZsWSeZ9HYt2ao4PurOOw+NS4N13PKw3TmXQSbq/jweBJ0qz/93PeesFlEsa+J7uhBTw9y6T1P/VhlbUbroFRhaWfCMTMZs/mhLI1kWM1hgKNjRBUbjs+BCcXMkNZPvk25gDiLVL+An+4IbMf5KaW1KJmVxZ/9WQa9YXHFbub9qeD/YZu2pZo3EzBqDEc9O86i/I5qptbZaNAfYAuLM/r/lncMTjxem0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tQu/+U+RiR3o1XbXMXm/y3rifPMPNR6XMErWrp41Js=;
 b=Eh7717LbE4vvz/j0OLoF79EvtpokSN1f8Etnja2xhMkYaCxrgyNyu20hYtX6VIb+Ve4viFVMC00LxOlXQCxu9Ey7k9XGMvm7J5SWYth2V/piAnoswY9m7xp4QrKOZ7nhXhLybPLvKex9SqkPjcqC3J3n4Sg6w0zBMHAUZb5mWEDx+wBP7HB+pViAOzY4y5UENZnYuhzWVQl5gzAKd6INuMbloLNDrq19zyXwimfeG/oBbALInLPhxZIKVE7cgBVNwgiGTqdvYDWVPC7hIsZa0kvvRAghnsx6lZnBatiiFxJPWmMgJav5hxm0wtAEId9NMmDQe/XDnxbVY0TJYlWLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tQu/+U+RiR3o1XbXMXm/y3rifPMPNR6XMErWrp41Js=;
 b=hBxIwCoOVXmAOgC7tyGHUxq24tj+pkSsOHrQ7KmSKi4jM05j1Owh+FLmR6PmIjSgJPKJE48K4AdLfHm6nOfSVxarBbpTwb0ROnMzc9lBwEtlq63QXMiojzi6CU/pcvqmRKJNFl3nq+CTflT+gbJ07sGaR0Svx/09llZpPMd3hkU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB3987.eurprd08.prod.outlook.com (2603:10a6:208:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 13:28:04 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2%6]) with mapi id 15.20.3066.022; Sat, 6 Jun 2020
 13:28:03 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Message-ID: <e109dba0-eaa8-aa21-3b97-f999c76a72a4@virtuozzo.com>
Date:   Sat, 6 Jun 2020 16:28:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:208:122::17) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:208:122::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 13:28:03 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e3c6061-3697-43c9-6332-08d80a1d70da
X-MS-TrafficTypeDiagnostic: AM0PR08MB3987:
X-Microsoft-Antispam-PRVS: <AM0PR08MB398727EA13CE12D5BC752669AA870@AM0PR08MB3987.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOctHLxpIBenbztGi1mwIo6HUWkGYc/CTzAAlXOnHX4PekyWSWeZoveX+lXK2Qzx6WtN/bx5iOMztNuYWKAB3Ik3BucQArOmyY1vSFc4Bd25B9KLgwKZyU3K8zHvaS6IlleYeizb1/2bbcnUxPIf6RbkYyBzt+cgS3VM+QUw3NH0Esd9byEjG/DiJGZhfagelPn1jR6jm0AMuFSmb+qpA6SA076kGPd/0nBOIcgK96VMFG/GcwOTzCIPmf/y9aBmDxmhdVYGpqOIFz3Bjbh+y0gF70kviZSqtxriLQ0Oq+9mpa/8aBUuyFb032QKW8BwBIAz5s1pMSM/dmH5gjGtKp3RPY4fMc5N+mJFE1NMdRMP5sffWeDtnsVNSUeu4cJOlE5V0G6//ecmQ1iOUEY63RPz0d5TO3hEFwzzr+qu8DmjlDKtx/w4k0Hgla/g86SQjH4aCIj+xur7a/XehxHlHbCLpbWCGNPG8SuLfqPUsIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(4326008)(478600001)(6916009)(36756003)(83380400001)(966005)(54906003)(2906002)(16576012)(316002)(52116002)(26005)(8936002)(956004)(2616005)(6486002)(4744005)(86362001)(66946007)(66556008)(31686004)(8676002)(66476007)(16526019)(186003)(5660300002)(31696002)(41533002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KfoDA2lZcwhqYfOs/vUNRqnbgK5EBb6AWYjeExMcAw1Mi2HTVQnTEw9/z7qnJSDtqEazDYlXbtkH07ynSQAoChKMyLZWl/5PdaCe0s/o5Yp1fWyubAQWDtgMQ3kwekWt025OO8p+woc6oSyjXXm7o3IyM0pSqi1/T/0qlhhxcIOUeJujXAoMaEGtGWIdtg2ixtBJTQVIzW14BeXxlwZramSLm1CbK0Yq0Y4MSZe+MN4l0F1b1WelhMvaDHx3nXqDrK5/EqjWOFnvDet7S8zN+nelM9qSIvEDzTPeEbAUxoU1VC7owXEx21cOwypO5CSc4fsqAXTb6mbBoewoabqjrNhc/XvXJTKzy5qLDcWaR3beKRSbD68AUxzDhgfnZDWeJNAEkRYRTsB4o5SsDLf8L6rE5tiVHskOJKY7zxQ19APo8bpVMprcI//EpgrEVEZQ7WXZTHZn9QVdXFY7Smb9cXKJ/4UxCNNcw0nkFmJGbOk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3c6061-3697-43c9-6332-08d80a1d70da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 13:28:03.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltDzdooo/0nXoIa+bZzAZn3FvBx20ZNtvUmQvs36H+kIC1zhVrsuUcamDBxu1Hw78QyekgzPcjzXppQ9BG8jyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by smatch:
lib/lz4/lz4_decompress.c:150 LZ4_decompress_generic() warn: maybe use && instead of &
It was realy incorrectly copied from
https://github.com/lz4/lz4/commit/45f8603aae389d34c689d3ff7427b314071ccd2c
line 1431

Fixes: 2209fda323e2 ("lib/lz4: update LZ4 decompressor module")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 lib/lz4/lz4_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad..f7f7dca 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -147,7 +147,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		    * strictly "less than" on input, to re-enter
 		    * the loop with at least one byte
 		    */
-		   && likely((endOnInput ? ip < shortiend : 1) &
+		   && likely((endOnInput ? ip < shortiend : 1) &&
 			     (op <= shortoend))) {
 			/* Copy the literals */
 			memcpy(op, ip, endOnInput ? 16 : 8);
-- 
1.8.3.1

