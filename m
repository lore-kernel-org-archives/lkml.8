Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF2C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BEC20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Gi8cC7Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGJPtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:49:52 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:30784
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbgGJPtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgb+mobSFVo5w4Ac+AStUgcfsfbc4Sv6jjP4tQDsAdVc7/URtTt66duhwPjzgkHs/pzwYU/L98uNp8/oF3JeBoLwTJKIFqzdRv4upSwpon8VCyG237IVMBp1EtEvByIiwtMtC2BDraJtbMo9UXzIR65V2pp4o3AmP4Sbb9D+6+p8ZgeQJPYFXBh9rLCRkCFpa5Yf0Q5WBC4a073MLdTFpaber2T5qTM1A6YdhQf2jcYf6jIF3swlHBI0GP41rKSYgHyxKkd3UuD9s2slg67lQgWPzud5SIaYUvOQy7qjLg+PsH+ZQzy0bS6VriGkkZQmdj/XVUf34QAi7qs+bJPVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRBZYzXnWp45ZboQyx2bYkGHj0PQVPU/PzTGdg5A5NM=;
 b=nR/whOIZnhkSFXMgazkzHd7bvaxirGXZvZ5JuKkG0UvIT3qWnUhjbYBU7zXqlXLdAsjabXMqZmmQzZ5Dk06/Q35PVaykBpxtvE8hphj2FZExAbyOL9BAcm0TRlMDYeb1SrSskwZd8RDWDB0sMNDawBggYyNhki/lGSHU/R/ZGIWJoW8oA5Q6fhe0C6ymdj4pBce2o0NIXMFq2ZcyZHZX7yfDw94F99pCfrmjkG+gwysPa2bYMFb1QkXleW4J6oiMD2B+KcXGnGf7eMd0CESFZWQzJzVDLwnUsuJDBfVc3mW3rpjMUoqUYnpz1/C99ltL6sWfQA+MggISMsOiVowyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRBZYzXnWp45ZboQyx2bYkGHj0PQVPU/PzTGdg5A5NM=;
 b=Gi8cC7Z3BV3eTAOOJsOilPaSeHFgkNeyJy2BqHpUQFY8CQbzun4WdpiS8GuHNQsE9p1w6hkUa9iVqcjRoipzha0udtgJice15m7ZLf3q6ryxrxlOtqDuC7sn1k1M2+SOVPoBD+qCwxHhb3DP96eZUH9tXW9Bx1gLvlygxexVpI0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5879.eurprd05.prod.outlook.com (2603:10a6:20b:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 15:49:44 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 15:49:44 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: chipidea: imx: support disabling runtime-pm
Date:   Fri, 10 Jul 2020 17:49:33 +0200
Message-Id: <20200710154935.697190-2-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710154935.697190-1-philippe.schenker@toradex.com>
References: <20200710154935.697190-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23 via Frontend Transport; Fri, 10 Jul 2020 15:49:44 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e28cc3-7397-4dcf-b450-08d824e8ddd6
X-MS-TrafficTypeDiagnostic: AM6PR05MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5879A0BA857A7AFAEEF93D5DF4650@AM6PR05MB5879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKgVXtSa15rpGPIDja6IS6fbtZQQR27k3u5wF1EbZZUZIW6AR3OiWsx9cNMQ1acyqpvSZjyVHaIXzMo87MN7i/wNhnr+hhXfDe8/N8Vla7qeJkzzzRf6EZ/jIeDcw5l55bpHIucKDI1ZdV9fkXjZerr/ctDan4wWpaipZbQxCtbGfQx3RwGJ33LtfE0SBXXCc7kGhm5Uc4rwvSFMvJHy/j7dF37bPLD8ObFLE9zRi8f54y5UMSX6BBXaAmvruZzGL6Ssk3TT3P/iVcGzEuYdOISdu/P74d1DXjeykkK8dQs/fRqgqf0YiamtBCXz+CTYwHqg6A6QRS+6Ldhls9gPaDBKmQTXbTpxt0727Flm5YOwdN3Uo9mzTrTcIngwrHZi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(54906003)(66946007)(86362001)(52116002)(478600001)(110136005)(1076003)(6666004)(4326008)(6486002)(316002)(6506007)(83380400001)(26005)(7416002)(2906002)(8936002)(44832011)(36756003)(5660300002)(16526019)(6512007)(8676002)(66476007)(66556008)(956004)(2616005)(186003)(4744005)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mM1vZzn/o8uZum0qTCXYZe9irbClIWkAqTFgBTczpuV4xTTlCV/s6B9aA/FDFW7vTb7ZNXjK53N/sBXuawOrUOJQpZRHR5jKoqf18PJPrUlFI9AWQIv1iDcJWgHlT4CmUgrbdJXUlDVXLh2dHaCHOPX2Yn1wKOoveJpyHVg7ye9JyAGndY/iCJ9mAzu09EKqdWbResqhNbStMx1xFTPVlD+sS7TEanvMXM/U7zigkADiNayDlM5zdY7LRDtSETqbDRLc9JXTEBysquuNLd8JorE1nzBGp4CkHX4OF0WV9E0/mXQhk7zwYeU3KylS1j95TIsRmksXrm43dpIQV6wtqZdw2uSFMbF75wmHm4SJgg/Zj0+Q3hWVZMxl1mZ7Sn5O5roiNYYu5JV2Eq7aVVLeHOAx2MacRh51tUG8+imEuBS9aPocJoRAI8pRLlckYzPFJ2GrrWSr9Z9wKkrvkqMdFduxo5bERuKHmYY2orxG7I8=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e28cc3-7397-4dcf-b450-08d824e8ddd6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 15:49:44.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjtnirtwbXSi0BOa4IBT78WW7q8MCSQxjQcpzf6zdDoZphsQB9mJRessXwR1KXGvw6Ps7AAMSoUo3DBsN3R6tKzgamKpjHUuYFZqxr4MSh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chipidea depends on some hardware signals to be there in order
for runtime-pm to work well. Add the possibility to disable runtime
power management that is necessary for certain boards.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 5ae16368a0c7..5078d0695eb7 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -434,6 +434,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		usb_phy_init(pdata.usb_phy);
 	}
 
+	if (of_property_read_bool(np, "disable-runtime-pm"))
+		pdata.flags &= ~CI_HDRC_SUPPORTS_RUNTIME_PM;
+
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
 		data->supports_runtime_pm = true;
 
-- 
2.27.0

