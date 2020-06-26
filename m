Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9910320781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WMZJfChn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgFZLDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:03:30 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:48452
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbgFZLD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc5CuQ9scZpPNKKtQRluPnztc/LRw61OO6l7YWq6vGFf6qvk20cdZFB2aD4+Yn94X81wPEdinywfZeRc6HIWvndSj075O/ls5rhT3ghqK1CjCX3R8/BSynVoffJFpxsAhbYgtCsa+TMclnY9HoQELu1ye1VxHVvr7dGd+jHKIQ0ixgCBzJLkyraHTRS+NBPgsEf81aiQDCekaodIM4adR5dsotHu2se03ih8coUsngyasB06vTyZ4R0XabABlmwNjVHlqCvA44wPYpM720WriNuM44vI76tn/PawM33806Ehrof1JNmh/20xxTUDaN0x1bnJL8DoD1jTy/lYfUQ19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0ljPalc+eBqomCONPAW5sRlU5RzxDqkEHLR6pQZMj0=;
 b=kkdvxtJC9ZzVr5t4eBa7IGfxe4PKUqjyKyCnMWhVGoCLhkYa2tOWY1Oe9DdnLmN3XqAN0LiCU7l605ew89JMIk2FRmdp70FwZ3bu3c1n70RUARi8Ip1Z9qUZN85RR1nfTVri9Wkd5uIYQ3SO8z4tV5t4hgFh1ebq6W228SWX4s7CzLAxaEdIlkkmDct00u30GTwiakSugsJ7ETbRKOVJjOU+wwUTS/kKxYTvQXnYFS/JGBrqvG1+FMNDHURD9kS5mOUfJ7V5JCIeyc/n6aopZbFxEciLPs0PWVlE1fCmCAm1AKZJDeHNzyrmuJe4L5wAZ4TWgcez82VhWylAfAqqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0ljPalc+eBqomCONPAW5sRlU5RzxDqkEHLR6pQZMj0=;
 b=WMZJfChnGPtQXWPD4XldQ/Mngo79yHL1AZIMziwZS+Boa4PeCliaTpXNY4pxqthFv8r6+4ln1V54I/cmcQEr5gzYeLHI9CeMtfQOVD0y4ihXgU9+MpA6lAgOuI4XfWRMMZ678f6fwKBN/wRCKzCNxx3MjwUK/LQAJ0LtrC0RzII=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4952.eurprd05.prod.outlook.com (2603:10a6:20b:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 11:03:24 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 11:03:24 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Date:   Fri, 26 Jun 2020 13:03:11 +0200
Message-Id: <20200626110311.221596-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::15) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 11:03:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f0acd6b-d6b6-4d4f-4cce-08d819c08bbe
X-MS-TrafficTypeDiagnostic: AM6PR05MB4952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB495221C30A0E48C2D768BF53F4930@AM6PR05MB4952.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtVzBmIRBlLtHDVwKrJuhbPp79NeAQD+Cu9ApJIyynrrSY7phR4yDrWAFGqy3E5AeJ6roukLV3qsDbofSRL1AZXRMg1e6jXMzWQA46+nPkCPKL5kdRilNf7CoZuoDMUQ1Yu75Wwf7jQyflKBlht6a5tTbu4bdozpc3KynsSc6cSK92m+D5P866EQif2MedpwOx8cMDNcQsIzdN8YeAqr3mtp/8ifNqQgCAFpNfsBRVvvRvQzK6nnpiQtJT0K4YtiTsFNErKvl7F/dxm75FJZEVrdeoLcqd16iti64uAxGFXzEZAYpGomaczfvOTVD3UPOw9+gP22zT/8crB5STjQcegmsXb2HwCo2VQC+wXUnPv/UbyPFmG1xq4Tv2yWWqqM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(26005)(16526019)(4326008)(186003)(956004)(6916009)(66556008)(66476007)(2616005)(66946007)(5660300002)(6506007)(6666004)(52116002)(44832011)(8936002)(83380400001)(6512007)(1076003)(478600001)(6486002)(2906002)(36756003)(316002)(86362001)(8676002)(54906003)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hEjgIuMDWIRebNQ7GRqYQ3DpHcfRaXGz/HO8aqbT0q7yqtZuZr5uYJsy3LV7DjWyqzo+p8I9mTsuxjO5sofipze+OMSbgkhq2iWkHEsLGi9XA+xn18Dggj4wDtC52i7rLgFlYpS+xDNdhMvhycUtPJK3tnjlSk7SnRVzoHyb/Q16jvSdfA2QJYdUIGr3+wf7MVgP7Nx5XIB8U7fXKC+5Gyed+7eZFKAl48m2LBYpuflvmvGArTbEvO1E4Vddm5TcPlSgEQL+eQhIY59YTrwdwNtrSZ6tiB9zxFVi/l6VAudqQnOBoCbNt/p47Sx/r2/SAcgWuAckzVVcz6YSMKPhHfuYZazrgtbBmumk3NV28rbKwTFvUYziV8/PvyGpII8ZI8+h3LOeEOzl+EKcPsQjSJRXznUf+JDMgT+XsChQSH/Czvz68kjlDsnF6cSsuEmFS8RFXiVONbhvvbhq96ucPPf0HewfeAgFqz1AuMrmei4=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0acd6b-d6b6-4d4f-4cce-08d819c08bbe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 11:03:24.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq38itAEm5OueTmRj5fxxGJoCBr9dQBnQ+OSG3NMwuf6tq4xjO1Zxcgg7DBDRmMrAmZdSHwcYWWhqtuKJCAdTfaIEtDMHkwvKY51HUXmatk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hardware is in low-power-mode and one plugs in device or host
it did not switch the mode due to the early exit out of the interrupt.

This patch fixes that behaviour and lets the rest of the code check if
something has to be done. If nothing has to be done the same return
value gets returned as before.

Fixes: 1f874edcb731 ("usb: chipidea: add runtime power management support")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Hi Peter

During my investigation I found a bug in ci_irq. I would appreciate
if you could review this. From what I see this patch should be save to apply.

This patch does not solve all of our issues. When I have RUNTIME_PM
enabled on imx6ull or imx7. RNDIS still does not come up. So there
has to be another bug hiding somewhere in the Runtime PM code to prevent
RNDIS from working properly. I quickly looked through your patches
that added this stuff back in 2015 but couldn't spot anything related to
usb gadget-mode.

If you right away know where the problem could be hiding itself,
I would appreciate a hint.

Thanks,
Philippe

---

 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 9a7c53d09ab4..5159420a23a4 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -518,7 +518,7 @@ static irqreturn_t ci_irq(int irq, void *data)
 		disable_irq_nosync(irq);
 		ci->wakeup_int = true;
 		pm_runtime_get(ci->dev);
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
 
 	if (ci->is_otg) {
-- 
2.27.0

