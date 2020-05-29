Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF785C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6039C2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="u6Lq6jLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgE2XFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:05:18 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com ([40.107.20.101]:10081
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgE2XFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnOI9GD5WEfsYW2Ah5NpA5GH2MNalSEAROqfOsJjFQBFhknFq8IYwJDKCnrjv9kuk30VVqs1sA9nDt5sFORGNocAT6wOrZxJJin8lneLZmgb2msyXeiIN8iWB/T/zWxRn9+qumCYoeoJS9gY8OHQuTm+Mupxaexp6yHJHRTry/LKQC3b/gc20mu8vSTV5V4lugPrJEvC1T4Fc5aUfAwTyuhahXsXtgnCKKUKhCjA5h42Rr5IxQJzB0Z9MHwuRM1QD1l6+MwhDyLr3uiXZLbRp94LeBX7v5jMOdVmHRFk3e+DX6Jy0z4SnW1uMzFzDoZgSqSqNR9r9u8YIi0sdjpd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMb6i7BIv+JOTCXgQyCbnKWlTvzRmAYvuMXfNaxItl0=;
 b=a1y+onrPvj5t0kKcPKShBLLQFoFOJWuMG4Jmne+zBaLs25hTBjPT4fR4ln+20FRik/BNShu1vkxnzcrxVSZO9xdkuZfase7acMnLULMKdSse58SrWPmfifhl7PQ3+hcgJQtukBNFcJohAvwl2VhU0elHpugGxeUYJ/F1x7SYEBVorPLFcYrYtDuANDYSp0dwc/wDKdY9Qs8fruqOG4YjL08B4vE4RLQNY49GhYoMR/2/wzfg/hxNwZ8HTRXTiBqvjP/QwXZ3aebygw9oo612TTot+uWweWv3R1pjNvaS8azxNy3TFobnSV+iOwRLkJfHxtgEcStqSlvQn5GXaJvVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMb6i7BIv+JOTCXgQyCbnKWlTvzRmAYvuMXfNaxItl0=;
 b=u6Lq6jLEOofYfPVpgGer0TNCC3BVKgunm5oSs2gCdsLaeQp3xFvluE6ry4F+YpCqV33UPZDRrcPSUp5xy8aDD1jbFF3X6nJZd7ih89WvPkoES3aBvq9yXTZhpGR450FpAmt1ZCFt0DYrNFA9JQvzVWsUYARQrzEgJgIwMHDAihw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0622.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:12d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 23:05:13 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 23:05:13 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 0/2] nvmem: add ONIE NVMEM cells provider
Date:   Sat, 30 May 2020 02:04:49 +0300
Message-Id: <20200529230451.21337-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::22) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 23:05:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da944db-8772-434a-796d-08d80424be3c
X-MS-TrafficTypeDiagnostic: VI1P190MB0622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0622744DA19F0A916806CC61958F0@VI1P190MB0622.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3XJfXxJGIdDwjdgJfGURnfWx4ZUo6XJ/7XlmCZ1Fy9JRE5jinepD7bpvuxOGSb1g4suvdY4SsmR8CTYRlIjbyJdOd6WCUPqG7W98IbRsDCAurxkv++n0PFxelcNpNcidcF2iGhaW33kupHFbgabkp/mckLtVoOJHM0ySOgGFRIonXWi6GYcTlTk12iOqVzAg0tXbQDp6QG7x4NYUWeNvA7rI3U7v+bg8GQUDPJvrXjVYpODzHHaPjafigkEg6H3juFlZexI+vsEyRR0N+e+R+DVBaJRFeoS4mGRkiJh3YlaiZvmTIWsUv0s/B5EYCgPyPWVLQYseoykRWlRGh2E2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39830400003)(346002)(376002)(66946007)(54906003)(8676002)(6666004)(6512007)(4326008)(8936002)(110136005)(316002)(6486002)(508600001)(5660300002)(52116002)(86362001)(107886003)(186003)(2616005)(16526019)(4744005)(44832011)(2906002)(83380400001)(66556008)(66476007)(6506007)(956004)(1076003)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /pnzbNNWgN4Zcqx7dh+jo/meU7TgPoHbMh+526WCf/kV5L7PDrLi4U8rfZzQUoc1jsCbKS3WYnHmjLtdMULFjWQOGG8QfVuHne099SElPwPfywXdslyLdXJbKx0xt2jUgWpz32NsRJMLK8aLWKzFUpOGJYQozwJP7kpmfSMrWcRIifsel+y9WL3C+GcFF/NzlElAEvmNa4ryjYTLrgylo7hnzU3LbPmQMSE3WN6HJGGVPaFvZ8O0tgCrFdzRGV0zsV/4RAtq0S5cv/9T+3IkoNj0YVf3pkQhiWvh+EG0KRHffy7xRZIm+ljoFbm/obNiQe1m3lrKuV74Akg4rX/bWg6v77Ye3Rq0quVM+5jtcaIef0mmmsuAjKwLgZDYw/m2stkkJ7F2cUWkqj1PTl+Z2BB2XTygPmFtJhZi9ExWwT6LHj7A6pvnVPjn4OcnBxXqr/ohpA8o9Vqk8N90NTWL7jXAL4SaWGYhyLhD+oPiWzY=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da944db-8772-434a-796d-08d80424be3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 23:05:13.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i7ElBb0ZkvxVoTAsaNL8kpz9chdHfQh9pE1l97pkfJSfZp3JAdHbaVsT3v6NXL8RuDR4NoA3dBYiM096gEN/WsZUOVbImRW5rl7V4aPLFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds cells provider for the ONIE TLV attributes which are
stored on NVMEM device. It adds possibility to read the mac address (and
other info) by other drivers.

Driver needs to register NVMEM cells table for already registered
NVMEM device, this requires additional change to the core logic because
current logic only allows to add additional cells only before nvmem
device registration.

v2:
    1) Fixed wrong memcmp comparison

Vadym Kochan (2):
  nvmem: core: allow to register cells for existing device
  nvmem: add ONIE NVMEM cells support

 drivers/nvmem/Kconfig      |   9 +
 drivers/nvmem/Makefile     |   3 +
 drivers/nvmem/core.c       |  59 ++++---
 drivers/nvmem/onie-cells.c | 332 +++++++++++++++++++++++++++++++++++++
 4 files changed, 381 insertions(+), 22 deletions(-)
 create mode 100644 drivers/nvmem/onie-cells.c

-- 
2.17.1

