Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC2BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 11:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1A92082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 11:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Oe4m/MLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEJLK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 07:10:26 -0400
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com ([40.107.21.122]:48256
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgEJLK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 07:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1E9a8dsC7FmlFw8yHh01+WmzP1lEeAqIqHalrP55AE1xpKm+s6c2z+ua0dEee0U1vtcyPEepwwZ21/OtvAtoEZ7UjEqEduChtgYeamvAG7uxjCEdV/0skgBlwfC6e/Tw3D8GN8ktgU4iSLf5dzt2XSbf4pDtTu6UFFWAHk9CDpVm43g2frctLpEiRpwwfOZzt6YLq75jbIt+xuPfwhWo+exmbcPQDqlBH8HcL1mBIX0Q1A+YQK5cpxPlmS4f9tNDGz+b298VkPRpPY6cwuqtRxRRN5c+Zj6+Q7A0tCUgULZ40Z3QUWHb7h0lV5Oa3sWu0QVGCqQ/xh3doXyzfiNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6IEWqEgEbeKyOCpnoNevHBRugUFKf0OxCx6LeNFd94=;
 b=lUMAOeC4wjyf/AtnGJbhEgkhmKZ3wi7K26QFTnkVY4orEqKMwghXprW//YMFckZ0X+Ph2hTi6fX7ClD2jYtZC+QN021MCaLyhTpYiCXM0Qbjxl4/75qbENLaqs31YKngdJ7sBbwYpyfSsO0u9IEJG4qfeWjtNDWqGXg3bTidb67ro9vdOdjMKAKNZnrLxk8YDvF73qxZlU/X8W/BwHy7SCDvhl6ALo9LI11nMk3Qd7A8WIlZ4bWxb4dpQFP2wsKVI3qZYaS3wuCpbDlEFq/YVXZEuBzIlBzY8zHbpD5lrhQqGTZL8Nr1ZvN3plGZBc/zuchGgfDLhpqK8YCxO/rrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6IEWqEgEbeKyOCpnoNevHBRugUFKf0OxCx6LeNFd94=;
 b=Oe4m/MLS0Xjkof5HFK6SYYiLqZGlBHnjD8zIUo4wZ8Yl9keWswMeUOuCGtvqfuFmCYn2lj2TUGEJoIQpy0wUoIXziU+XifNB6taDMdV+gTsMvh8Eo/SryNNPoDp5l8wMb+uDd/vWbN147TfbRsdwlG2FEW3Z03aGqe2gCafYgU8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from AM6PR02MB5526.eurprd02.prod.outlook.com (2603:10a6:20b:e5::28)
 by AM6PR02MB4311.eurprd02.prod.outlook.com (2603:10a6:20b:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sun, 10 May
 2020 11:10:23 +0000
Received: from AM6PR02MB5526.eurprd02.prod.outlook.com
 ([fe80::9cd9:a468:735b:52f4]) by AM6PR02MB5526.eurprd02.prod.outlook.com
 ([fe80::9cd9:a468:735b:52f4%6]) with mapi id 15.20.2979.033; Sun, 10 May 2020
 11:10:22 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: check if CoreSight is supported
Date:   Sun, 10 May 2020 14:10:15 +0300
Message-Id: <20200510111015.20134-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:208:154::48) To AM6PR02MB5526.eurprd02.prod.outlook.com
 (2603:10a6:20b:e5::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by AM0PR02CA0107.eurprd02.prod.outlook.com (2603:10a6:208:154::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend Transport; Sun, 10 May 2020 11:10:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [31.154.190.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2888f2a1-3918-4385-3f2c-08d7f4d2bb8e
X-MS-TrafficTypeDiagnostic: AM6PR02MB4311:
X-Microsoft-Antispam-PRVS: <AM6PR02MB4311F733120AC8A8B1D606CBB8A00@AM6PR02MB4311.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 039975700A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmVjE8Yag4zsf0sCKmEfXoL78/Sp490uP+lxDay7gSOEeo3z4A8rS2bgV0D1XGeOBU52D0BrgUp2qcyxft38E5VnfWo0fGCcgxeq7oiszW12F/vtjHrFWAuAgTiD/9RCDq2k1hshCjqQHe/P6f2EuYv7/nAwlGy7ugx7wW0Hvv+CF812FEYKdgDpMtlmDMTTn9Bqq32LxGir+y3nC9ShzBfGttlawQUjlvUkabBNE47YN9K/elkDekiZ8hOu+g5JqIx4TrjH03hLnR0rbJ3lF3NS7mnmKswUZLPXVd7BVtf3AEQ4xhLwMyMoxLKHE9UgEnWlB3i7gwiO60Q77K/4t2H6rDy0YnNGzBfN++H1IX44UqJxWHjBUwJFlownXzV2DYYUZFP6JPq1BCsFK8nZRkPOLHIY2he6Y8nX1fpUogaMKKyK8+VRR3sV/fYQ84apuRATk6Ntxu2G+BFVev8253CR2jth1OC8Wa6+sRDELq5rxY1hVM8Ai8Qv+CGAyxgeam3UBA9MdsntRuid5fzqKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR02MB5526.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(396003)(39850400004)(376002)(33430700001)(66946007)(8676002)(6486002)(478600001)(36756003)(66476007)(6916009)(86362001)(6512007)(6506007)(4326008)(2906002)(26005)(186003)(16526019)(33440700001)(66556008)(6666004)(8936002)(1076003)(52116002)(316002)(956004)(2616005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wzL6N4L42B6iQxWMfm66HSVYJ2/ox17i11hDzA1oXNY0KZisKpHVFbgcDTNCk1Gawev01Avf2XLiHOrR6xrtHPoxrsyt3R991WmzSxRc1P549ZlG59+AVaLxPHZvFUb0+NmgAOujZtJCK5VO2N05Fhe46O/Q+0zsoSbRQlC+KPktVu1PDSJ5QSFdQyqZOcrDKu/YL0VTOs3fTFBJGAeB5ZruK60MO4qh4/iGl7LkHtnclXEdsWhO1XA+hgG1RPhDkTrkHdAQJg6krW0PpwNRJlvfkjEX/9ANsTiOKXs5jfujVIE6EGdeYpwsWtgQaI0FbC8bTTQjnsXyY6jovXC09UQGFUqONiPcfVKkEXKDaeBYAZJUXleltSS06Yusq/dwWW802+SEcqphxjoIEO1QHdAg1FncRFN5Z2yBpXaeejig+LcecxTB9QZfkmRFHO3kMkx+APezj17WrI5d80regHlcYBibXnc6QpXetpbTH0s=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888f2a1-3918-4385-3f2c-08d7f4d2bb8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2020 11:10:22.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98MSUJ0tENyd+5lXovQV7N86nqc2ne8DxvsIrbDm1Z59Qu3LSrAwECEeGU7CmW8l/9pQhjM/aLyCS8q0kRflaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight is not supported on simulator, therefore add a boolean for
checking that (currently used by un-upstreamed code).

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c  | 1 +
 drivers/misc/habanalabs/habanalabs.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b3e2354aaca2..fb2ff82e0db5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -751,6 +751,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	}
 
 	spin_lock_init(&goya->hw_queues_lock);
+	hdev->supports_coresight = true;
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a68df32094f1..cfb306daa8d4 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1415,6 +1415,7 @@ struct hl_device_idle_busy_ts {
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
  * @stop_on_err: true if engines should stop on error.
  * @supports_sync_stream: is sync stream supported.
+ * @supports_coresight: is CoreSight supported.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1498,6 +1499,7 @@ struct hl_device {
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
 	u8				supports_sync_stream;
+	u8				supports_coresight;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
-- 
2.17.1

