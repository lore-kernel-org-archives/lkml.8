Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931282074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="G5OGyJ3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgH1Q4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:56:32 -0400
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:31585
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgH1Q4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:56:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqqRVL+NBpMWiniNt5PjYjBpSQy31DTDZzQEJr15A3sPaMxIzfX4WzOqi+T9wCqJ1dgxsnFiFiP1oYVMD+201wDQSIIopy5AcwVCi6+mQ/KLTJyDvgGXrHEgXv9cyiHlmABijjDL/7Emx/q/JQOdcH/1by+BUM4u0BLvmwmeMYAGRDZnuPBPWevi7Q9glsQ2gFtvtrE5fODLjv+vN+QeG5RVRJW1NN1gfv9VWJwFaStEVTtUulSbQZ9DwsUMWfIp2uXTlKdiqTcmJitWbHrA2Cuf9NbeR4euas0XTuVFX2XzedpX9TbrCHtSLbEOsWoGu/d8mEzQH35MrhVLr3aqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DApqvdFI5R9r+6tVQJfysCbmXkS7DDf66wYt7A+rovc=;
 b=H0G47bqvQvR7vwiLX3VHPedY+J3ne9yOT0AwiuI6kt8NmgACFoq2zIvIo0klW8XAad8GvcHtX6fxsLfQece7qMHACHJAW9bX+niik71vNd8ND5jicVeb539hNJ1lRRdyAYlOu47HIVg9HvsfbGpuSU43rrRRpmwy5tZmuTC7Vb+uYnHsTMh3YeF9OfthFfa20kSsgzd55wJ0hglLo0AuzKnhRiL5K5I6z6WlxmVo5f+555A3RCVPQdc+Utfjbs3/i1DsOdbLwD/5ENdzabDrra+6no7kyTLNYW61Q+1lHdAyIHwng+7jNMM07IRBbVvziav1mC528kW2JHPubtI94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DApqvdFI5R9r+6tVQJfysCbmXkS7DDf66wYt7A+rovc=;
 b=G5OGyJ3B0gl9tKPeFQ+7uY09RAHlc6fnID5LouhMWahdTKrEAewrz+N3icYzKf8ufIAmjhwaE0pCXXOA35vr+Gd6EhL1eJF3gSPcVZEhXvSwHoiuyJEofjxUCpi9HSieVxyto+JzmqACYWJrvi+MlR+4N45eifUmVWK/DcEmkd0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1004.namprd13.prod.outlook.com (2603:10b6:3:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Fri, 28 Aug
 2020 16:56:27 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 16:56:27 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [RESEND PATCH v2 0/1] convert l2 cache dt bindings to YAML format
Date:   Fri, 28 Aug 2020 22:25:42 +0530
Message-Id: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG2PR02CA0032.apcprd02.prod.outlook.com (2603:1096:3:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:56:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786a9ca3-29f6-46eb-ae16-08d84b734dd0
X-MS-TrafficTypeDiagnostic: DM5PR13MB1004:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR13MB1004F6746FDE9D34AD25DF4F97520@DM5PR13MB1004.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kc0mAI2ofxC4amN8jvZ3Trai0KJbjl9r8I/hNAqFxcY39QvXjpZi9XDKHQlUlH51QSxXp8VLbSp214qbmMKoRNOfoQUPOONRovcdTedmYuRmCRP2Z4EsykkV+7wkeGG8mPaJtQB6+v6awQJyCdV89Bm+qAUW6Opcvtas7MwOgrZtS5uy87KS/j0RmzkZIsLRpGAeLRIBZNEoF+60pbLFAP9WrcMbGleOlzcXk/lUlz+FMZECUhTFCGSI4XqTUSqTnxfhf8eHEqKxi5jVrlNR/qgWH+JS3j/g+2qLb8dhXD/Z8gtLZCTc1o7qdJf0JAtkgOdkZzlAQm++Ts+obzFb0O7t01DAdmptsagrZElbrY9fJeCfPpagYfYKdOBEElNsumsCErH0sf7UkKqP/HXeDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39850400004)(346002)(366004)(376002)(4326008)(66946007)(2906002)(316002)(478600001)(6666004)(52116002)(66476007)(8676002)(107886003)(66556008)(8936002)(16576012)(83380400001)(6486002)(2616005)(5660300002)(956004)(83170400001)(26005)(186003)(6916009)(42882007)(966005)(36756003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /TcoI+WHlvRddfDy7UpoybGHApYdHjw9ZoB7gfw1k6S1okSdA7DYeBTAV79ZqadS8pexhOtr+aRpPKoBUweL8sxdM0MW+AfJZ+JKF9pHIs+F/nEZRRUj59+2gUqgfaMO/ItfMvn24+JuIxxUv1IH+h05qlRSmPuqXFXczP1P1+rfhhkkxHytqwOMMlhBY9GH77POOTyGYiF1icisTcwg5+6ezYops1e/eUXaSrgLsVeQlUH7KT7mHF1HnmwQOU0Zgq1Xiyj3d1WCStTEsTF+OfSOA1HvTEmOLOg7Ahs2mJvelU5PixF355sBT7Pb6DtcrsT+ALOj9XdmaQZCpxujTXg+WHxzoYLgxionNU032lnvzNln7Eef1vPpZy+Imsg6RaCn5Hb6Yc0a3s1L24UAMqTe2XWvBKGKsOqON60d7l/0C4+856M+lmLIdVs4QfQB1826hGStSE5fBLhVYQbRpyCa7C80uBD1dl/M6x3F2XNX/BxdSZB0d+RtrpapCUi+yh8zgnun4m4cGZ4L8t8dUMmpGeuE90QyDNUVimn/MZbokKnyVSgsZJljchGA0kZIXGXvM25KGNndBu2IJm13zneYFnzp+cxj1IAI7UU0XyR4VNCYccW9ubf01X5Z2zdixgBYURyETF3UdTTC3JTuFA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786a9ca3-29f6-46eb-ae16-08d84b734dd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:56:27.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1nZkCpyDuKx0jj0rvFK4Lux1hqacbdDdvV2Obj8osgr8uX2oYjlOFUwgPAIxoCAKMhp7HmwHiznQYmrk9bZZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending it, since subject lines of earlier v2 patches missed the file 
sequence like PATCH 0/1 and 1/1.

This patch is created and tested on top of mainline linux 
commit d012a7190fc1 ("Linux 5.9-rc2")

Reference log of "make dt_binding_check" is available here[1].

I was able to reproduce the error after excluding the DT_SCHEMA_FILES
option. Just in case required the failure log is here[2].

[1] https://paste.ubuntu.com/p/R5b52vCkKJ/
[2] https://paste.ubuntu.com/p/gwYY3hd9Rx/

Change History:
====================
V2:
-Fixed bot failure mentioned by Rob Herring
-Updated dt-schema and kernel as suggested

V1:
Base version

Sagar Kadam (1):
  dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92 ++++++++++++++++++++++
 2 files changed, 92 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

-- 
2.7.4

