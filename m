Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E28620838
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fhiXFHpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGQCpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:45:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:49024 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgGQCpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:45:06 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 22:45:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594953903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZOXT610xczuOMpe++wIVTdx9sxYYLDgMkXvZBCXftKU=;
        b=fhiXFHpTMeGRVqHlA0YMs12wNs7lmcVl+aIpsTsIHk1HyJrF7SJGhsTvLHbDhlewCsDRw9
        OwHgCIFZXjo0OQcf3TWgGKIga1P5nTzOWQKSD+rH8SktfUnpNs/xqI+F+hVHfgouS5w9gS
        qT8xiNRcDF75igZmU9g2cRHux08jV3w=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-Xea-ARSePESLYEeLgbWDgA-1; Fri, 17 Jul 2020 04:38:17 +0200
X-MC-Unique: Xea-ARSePESLYEeLgbWDgA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyLXA6rlv1gCzRPi3gAoqGJ07w8NqQ57wwW5s8bIOx0rSut9o+xqB1vvUezKaklmtzt30IZ2RNvjZwqwTjEqMAJOnGnSJun61/0aNrPRWkqokYqyRznhiSi6/9FDdliY6OHXrCfyO2E2Rvf8IZ7xCvgpwKLJ27ZopERmhNYmYbQw3h0lE9KtOoBWwk0yQRURn6OCsGD1W6PywiOiEbsptvzFSowoNGG+iCETOxoOXs5NoLBowUv+glKTfcBnWueZrvGNCQB+cBxsv7ta2ae31mfOBiSXcR/lndTjWLjjK5l1p1zEgcxHs/xkiYPn29C5kriVGHpCitLNNgrQVLRb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOXT610xczuOMpe++wIVTdx9sxYYLDgMkXvZBCXftKU=;
 b=doDIczDBbMUS5qqj/NtB8Dk5hCT3oOe2F2JIzIRh72SfHeUEkidF4Mh1tXGlxYfaPqkE0vMypCs93A/ZhK3AKzayrZ7Vxm0haBYibWieYHAfTMERomx7Itugd6Rs8OHQYNhDG2sYTDIzmQ1h4wm2l4Dus3ti091uCQxfKIim/EvA6lk/gASgsk0WZxE2DWQ6dXx/M7KBeFopcb7NhpC4GEHqjtVHiWaMP0GKlsruYO86rIgQz6QTxg3dzmlWGEfhM/5Gl9G4RbHnw7HLgMyPjSzz4U15i0AG2YbllPHYt6tZ6uoTpGz/NaEcNRpshhbT+D0+/UV01Bwd4RnLubyONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fasheh.com; dkim=none (message not signed)
 header.d=none;fasheh.com; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3514.eurprd04.prod.outlook.com (2603:10a6:7:83::19)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 02:38:16 +0000
Received: from HE1PR0402MB3514.eurprd04.prod.outlook.com
 ([fe80::80b2:e0fa:5159:1470]) by HE1PR0402MB3514.eurprd04.prod.outlook.com
 ([fe80::80b2:e0fa:5159:1470%7]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 02:38:16 +0000
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH] ocfs2: fix remounting needed after setfacl command
Date:   Fri, 17 Jul 2020 10:37:51 +0800
Message-Id: <20200717023751.9922-1-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To HE1PR0402MB3514.eurprd04.prod.outlook.com
 (2603:10a6:7:83::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ghe-pc.suse.asia (60.251.47.115) by HK2PR06CA0009.apcprd06.prod.outlook.com (2603:1096:202:2e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 02:38:12 +0000
X-Mailer: git-send-email 2.12.3
X-Originating-IP: [60.251.47.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30ae6d7-c0e8-4e32-b997-08d829fa74ef
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2297413C3597406D8A920F63CF7C0@HE1PR0401MB2297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgZ4czrAnKlZTS4dTI4YRmlucmgAJsNSii/AztrnKNm4QJq0hWrnVoK1l0eqtLjPq2ckPM1wZ+5bn8hafJJunr6ZjRTXX4tuVrdKJk1cglp4QVQ5YDMaT17fxtLoyFGCj31RNvC9oZlGzAj7z9VNweYTXxoCDuPkH5tMsC1aJFCZqR/9B+hmjv87otUft7vwiDc8aS1vFW4KM94Z88rDkrVLAxfY6FN/ac++jUJieKoXA6a71a5+XhsJpwEx/luYWZAYtGqYs/vIMzCHt+bdTYHh0K3UJudgg+I3N6BZOHq5pV389Ld8mH0C+qtIk6mb+nEwt1xO84UbKUTQLtq5c8E0NGABzWNWXco1y26A2vC2o2uvIT7+u+2HKULTnaw2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3514.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(6486002)(1076003)(4326008)(26005)(66946007)(86362001)(66556008)(66476007)(6512007)(5660300002)(52116002)(8676002)(16526019)(316002)(186003)(4744005)(478600001)(2906002)(6506007)(8936002)(6666004)(36756003)(2616005)(956004)(55236004)(16060500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8tfoRQ9WhgRoi5dE8zZsXptgJ/N+U4y45piIC8yvYh9asWK3ZPiNdVWzevuuZRniENeWFGsgAxfoZzKCUXUuaGEGLXSZYH2nT4GKfhiQZoZVzUnUaAIRh03/x73XXtypBrkU9BTexx0PqUhxTMaVnZEmGjVjeQ7YGkTnxVy0lap6MJ7kmMDe6RFbE8Fi5HvHJTi7JyRxkgVbsxofyG1uWZD0e9XNOgq4Udk33CRftxG1cxyzxy/cKmQ7j3NHPLeYb0T5OnuN055Z3g+CZacdGCdI2hlI75zHhx1AcX/Z7QCj5KZ7Bbcy6eTcjU7xmeFQB67Feg2HsNATavK8oK38zcjO4u34BwYwxHB4p3ytZ9jUK3TQ8nUGKAzj+/FgolVK5vsPIVyHQFCR8HtZoA7cdrJAzS1UzUUK15z3cxjRIgY7NgPId/bbtCF5Ao4dlC2rShMVOoRGW71fp6Mm05C5hTNb5rin4uBxApcIJ+7yKTI=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30ae6d7-c0e8-4e32-b997-08d829fa74ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3514.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 02:38:15.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEC5grSgCIlCxeCX5jtiLJHCcjvbESlObMF1fu6c6mRVZigFV2UogDqd4WbipPqe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use setfacl command to change a file's acl, the user cannot
get the latest acl information from the file via getfacl command,
until remounting the file system.
e.g.
setfacl -m u:ivan:rw /ocfs2/ivan
getfacl /ocfs2/ivan
getfacl: Removing leading '/' from absolute path names
file: ocfs2/ivan
owner: root
group: root
user::rw-
group::r--
mask::r--
other::r--

The latest acl record("u:ivan:rw") cannot be returned via getfacl
command until remounting.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/acl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index bb981ec76456..7b07f5df3a29 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -256,6 +256,8 @@ static int ocfs2_set_acl(handle_t *handle,
 		ret = ocfs2_xattr_set(inode, name_index, "", value, size, 0);
 
 	kfree(value);
+	if (!ret)
+		set_cached_acl(inode, type, acl);
 
 	return ret;
 }
-- 
2.12.3

