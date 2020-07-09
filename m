Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEB220708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="rKGoY3qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGIIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:39:23 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:19012
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgGIIjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:39:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqhX4i5VBgb0oYVoxT/lAZ2ikigUnCuwCGN/hUrCcZfgalB9uZ/5dQcrggYjNHr12o9zaJgS/Nt1e/d97GbTSV2loBUuZT7EYuzwXR66tfftiMbx17+v1XxYKyHzRAa4UNgww28x+N4RsqFzU14KuEkMgrQIqdXTxldmIks5QItx9aaRrMzDofLKyQ151aQ6qr13yqgqZ7+BwYqyeot8QreEcjEqyfXZ9ZvfM9laz0DjSdSYFt4TIS6n/LdXw6R7YAoHLM0wi70gIpgEJFaYGGmp7tjp9C/DKSZiCg4cA7gv6InzE34tzmdAZpTgVZ2CAa7eNlNrImXHkR5vj0soyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut82Z2QDXx6IumpHWDIIPy+e73IN59S9s8zS9A2EBFc=;
 b=Ipw7TEPyWFpvTRcGMoYkqyMDShRsNNPzWB8+j1MQLro0UmcmMRskLNn/VKE892adXr+mTy6ad/fQzh2yu1x8qf9bQYKRhVw9SDHu3doXL2CpBQQxmJuw7bRL1TUww62cmO8q9dqszDgsU6TtaZJmn3YRB9fOMKipl4hUnWrg8bgLs1s7DuuCVobnpiJVv9vyLp2EipysUkdKe4TemMWYNiIpeqI52IqvMldgNBoOeFvWzZx5J1ckFR/j/3OZUPLW6Lf+iAkk7ZEPc36UxASmTEJDQo/lVFumMsZ2rba/tTRyMFjvqS7AH9qYktNZr6Io4DJ0blSWxjo2K2UBsy9swA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut82Z2QDXx6IumpHWDIIPy+e73IN59S9s8zS9A2EBFc=;
 b=rKGoY3qaAsDqmf+CuEvaGJsl2N6HKWW/VPHu5T6YgndJ3+BRtK2R3n4lAFPJAOCdRJb6L0+kzkQbZnEJ6nBsZW5mM5+iS64+U//aMbgrQLOeislZj0QcqpNBwPVtPxBoQ2iU9wJ7JdUyhgYmbuyZUizDWrKEEztLbxe9JJtYQHQ=
Received: from AM6P191CA0079.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::20)
 by AM6PR10MB2567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 08:39:16 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::4f) by AM6P191CA0079.outlook.office365.com
 (2603:10a6:209:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Thu, 9 Jul 2020 08:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 08:39:15 +0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Thu, 9 Jul 2020 10:39:14 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 9DB1F13F670; Thu,  9 Jul 2020 17:39:12 +0900 (KST)
Message-ID: <f76907efa32aad1e4fa23940d86d3941ae62c01f.1594279649.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1594279649.git.Roy.Im@diasemi.com>
References: <cover.1594279649.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 9 Jul 2020 16:27:28 +0900
Subject: [PATCH v16 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(336012)(8676002)(356005)(82310400002)(54906003)(107886003)(2906002)(478600001)(6266002)(82740400003)(5660300002)(4326008)(966005)(110136005)(70586007)(70206006)(86362001)(83380400001)(47076004)(36756003)(8936002)(33310700002)(316002)(81166007)(26005)(36906005)(426003)(2616005)(6666004)(186003)(42186006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c887b760-941f-40cc-c55f-08d823e3907c
X-MS-TrafficTypeDiagnostic: AM6PR10MB2567:
X-Microsoft-Antispam-PRVS: <AM6PR10MB25670AF93CC7E78A11562F83A2640@AM6PR10MB2567.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt8GWsbDfy2gzhcH1HcPDjRqVIbCdFNYceG24aKcE8v5GSzFbZoAUMaXDNtqO7+4xKYthKNCYqhe+i1FJxWN/yqmwLHn94jeprNpxqJZYo9aCzDe/E/mn3wkZ5/uiyE9SEWVipO4nf+c6EDgBhGSCGIeFpLPUCJ2lPnXBsOAgGdm02lBaroEqgUJtjof9iX3uXiLQKCf0KltypgbZPcOqlVWS0yHZv2PPtbdTh5dW2paXQxPDCmqbXa6WbFqxRvJoz1LtgCala/EGTBM5LT5TTOXOKFTSmqOtxYdgmvJs4DNI3m/ndGXG1Zv+AG1Sv+iA3R8ZFlyrMNo+dZ0Ai/ANmhn5pB2F59NJOBYNCbAUX8trJgPRtQ2Q5M43tYZQ+zwg6EF5IicVn/H9zs8qt9mDUcTvltI5wbMei/ENCuDb65ohR1VGkexnvSBUzwgjg2JFfgtOVmjCftkpllSnfK9AcFp21iKTWFnS/egesIjLcQYYP2az2FIv7sgZ6V6luDo
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 08:39:15.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c887b760-941f-40cc-c55f-08d823e3907c
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v16: No changes.
v15: No changes.
v14: No changes.
v13: No changes.
v12: Corrected file list order.
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f..2aa7348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5002,6 +5002,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5012,6 +5013,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for PATCH v16

