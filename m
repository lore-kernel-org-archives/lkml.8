Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9033AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D651208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OiJf16/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGCGjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:39:31 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:37507
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgGCGj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:39:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkZjszVDReb0XlQlB6CudcFYH8T/FxtKsFjOdOWa9MDNX37kvRvjcChc6gBI5esaEWi74VoVK2vA24DAagRUQNjfvGMVmJXQWFQbakdlmIUSP6apxVc7YvDxn59PipsAcy8qXXS7GADHwxd0gHAm+y7U8BjpJTxKUnfqn97+InQkQvD2BLFZK4x4zkcwEL8PtzR5r7f7sP9ZX1X2jB1MPcimSFSfivPf/QABbVM3RwTo/bkw0n/HtRmMNVD97gf37IG2rnXgnJGxqCPbW2nhOWmdb7vU2YNOc5o5HzAPtoGxP+32WknUYLl0cO/rEtRwqltsQ6bjT1dLhSmN55yzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAPzKuzw4ayzBd056Xbq/A2N7maCnPQS9yAEov9muyo=;
 b=lnK/nHfO/pMFpBtUARRn/RklAE7x0oOMLQ8h2m9npBV+v++2QrbZxapK3FN+zpWETt1aWx19lLomelQZHnMeT0C07tsMbJynht9CIQR9Zsot1mYrkrLbR9rujzDgWNhBCic89oHP3BeDXraLNFtAUt64yF/vF08Gx690s6IIxvYCZ5b6UF2TNUIjEr0WSLRvd7t2qYy+iKCgYTzmty9R5o9anuNJiYGre8cB/85ltVvQKbrzF3YJtugulRFXCT7mCg402SlsbPaNlqjf5+24KvnzZOi+WWyTrO+jc8yCdcI1m7SXl3Xoy8zmG4Q1aVpkfaNJdlwRjow5XHGCVcAwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAPzKuzw4ayzBd056Xbq/A2N7maCnPQS9yAEov9muyo=;
 b=OiJf16/DUN4DVuV9bdX4fjHdIwALyd7Vp5sIM+t/VYq3VWvXQ+bfQwoYC/vxjdoI7DnPUWoCscmcPPf+eJYipdnoIKFqu6WErmVaPvfctJOuBen+dFCuBjL3GuDptQGJEYboYBLTZ4RMHlY0zdnoQq+svOcGImb0l850W1BdFHA=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5736.eurprd04.prod.outlook.com (2603:10a6:20b:a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 06:39:26 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 06:39:26 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, ran.wang_1@nxp.com,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] MAINTAINERS: add freescale USB PHY driver entry
Date:   Fri,  3 Jul 2020 14:39:24 +0800
Message-Id: <20200703063924.29799-1-peter.chen@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To AM7PR04MB7157.eurprd04.prod.outlook.com
 (2603:10a6:20b:118::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29397-desktop.ap.freescale.net (119.31.174.67) by SG2PR03CA0099.apcprd03.prod.outlook.com (2603:1096:4:7c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Fri, 3 Jul 2020 06:39:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5460e83-f4a4-49f4-8779-08d81f1bd422
X-MS-TrafficTypeDiagnostic: AM6PR04MB5736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5736B52A59CF391004C5BF438B6A0@AM6PR04MB5736.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5Jc0TNtbd4fkc/YYRlSk5MuFsPFn1J8DtCIBmKqz4374Ewr6P7og99UJVfwH33SEc+9/DzJ1NabKy3iPdjJbvUTRQDo8qrXDxVn6nqAatNojXGMFP2JsTJpqIqpqW1EgrQpkJpOdU3omdc+Sa/D1xqjlYxg5GWGaF/UzN8vbfujrVEIBnGXjNVHo89IljARBmVJiZ6Y2iUKGg0AVvwW78hL32CleGYrKSLscj/a+u7nUle9oml2h9cGWaoRCKKqj+qZPs+fdMTYRGh3erwYTcgYe2NL5tPVZzdxsYIaXOl2CcjSvj0ZLTnZHY0dZ2okQrHuKyUz+27MDFL9fa75sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(1076003)(2616005)(36756003)(956004)(86362001)(6486002)(4326008)(316002)(44832011)(4744005)(16526019)(6512007)(186003)(52116002)(26005)(8936002)(66946007)(66556008)(66476007)(6506007)(478600001)(5660300002)(6916009)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5/h/RI3RAJS/csFU6A74dlnAkjA336cO7xweqXugooS4v5PuN5gP3vDax8dJa9iBUR1PqGg000QLDtS5VPz66Hjog90e15Kr79Hn+DuuAwqrSXpAOhpTtsOdvUPkKhNwXnaaBmiWXqbrbxdq+B/hEJRDYqSjrVDrHOo0LPxzaF44ffGshe18osq4X+w6Xpdogjh+aeGoKZchIAhL82sDuTqGBdXWFlk6jWeAmkT6CXdfIJNhZ5rjHJZRw8vjYWUn9+E60Bevwc3SznWVjbbHvBKxCpE4wYIcO19dzOjRBVRzLmj95EKY75oeDBm0y0L2s/qiqvtFQeZDtlu1ZErRl0+nVP6QQij/OP112RRqcuQi/qe7qGqJm6iLXxahBm8oaGtiI6RdZ7toeWZFPDpDJt68lhOCPv/DzThlZfZaqakDbiCHtmIV2FacR7szU6616A4+ZruKYn8VLf0Cuoa/G4vE6jY6AJgIACD2Pc56klvDA/eBPe+3KC9xJV2c+eQz
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5460e83-f4a4-49f4-8779-08d81f1bd422
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 06:39:25.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfKIxrPF8ldCg7RQugNUquDmUaAny2jhNhQPqy5P1ZQS6nemxMJWHdFZ1HSkaxsAVExAOJVt8YHT5RBFjqxZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add freescale USB PHY driver entry

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..3d3779a5ef9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6970,6 +6970,13 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/usb/gadget/udc/fsl*
 
+FREESCALE USB PHY DRIVER
+M:	Ran Wang <ran.wang_1@nxp.com>
+L:	linux-usb@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/usb/phy/phy-fsl-usb*
+
 FREEVXFS FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
-- 
2.17.1

