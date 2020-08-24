Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92427C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E8C206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="NEHn14Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHXHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:50:50 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:39553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbgHXHum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNQQ51Fqd723fE3Uo1tKHO1CLgpflp6ASo3x8KjGPvW23iBN5vo/lgpZIgSJ2oTeP+64B74sfl6z2bfqGy6oGa295qbSzD1PGi7X0EVFlt1zvUJau/YeClK4nF1Hnl1WLTx0VS2sXDhvV0GQD6z7wBrucIfJOodGchKR+goKj4WCnjE1g0wwUM8RvxdwC0SrTwHJa9c25ypU981H4g+UPwCnfzlx93sMEcPHJS0LA9RTdkXZ6KOT0HBhLXyi86PSp8Mw76oYUXvQflF+X0Z+YjLstAMhE+yx49UnLsMMTOKtC50Jaq3KXxeuuLaHaHwmSrcLep6x+CurUNRREP8FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3CpX6qoX/+BpG6cw+O83u5KPHHW/uSvhBwG1JdDFZY=;
 b=Yeth/5gKialhfOIpxVUAH+Z03aPjH2TA6gLtF+r+lDSmKmw7fFZfJbpsGXCQkumvv75FEMG7UAq3/h4y1ZKURSc5KmJJJEnLhxGVKLreRHn8sacLhqHguKi2sfWns0IoqARvRWuljxLilQJCRfV2bUPqgfx9K5wF+5FFXrwMm+QGAlFX3SsfehJofZVMfjUeVjY62RD2ddVSNiNb5vyBb5MvyqIRKF6tlxcCL6z2FL0hjDF5ayiZEtvwU2hha57tZNk6UJPHyS6DAFkSmgBW+a8YXO+jYwx6JK9aBhX8uOZHifCIxHhpS0jpjXPg3v895fTk+kRst6RghEYBvDeMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3CpX6qoX/+BpG6cw+O83u5KPHHW/uSvhBwG1JdDFZY=;
 b=NEHn14Ws/V/nmvLG33RLxILTESl8xzKLcAxjtP58mb2uRYPuz8R4e/I4CS0EKvIULQ8Lpjv1Q/hyTowbZIkBnjdhtYTPDmiZbELTJmftJY/AAhQopdPbk4KODWb5lTxOeaq+GfCaQac3aBwp/D2raxKyV8qVLRYyXI3TYwzwPlU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4148.namprd13.prod.outlook.com (2603:10b6:5:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10; Mon, 24 Aug
 2020 07:50:39 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.017; Mon, 24 Aug 2020
 07:50:39 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH 0/1] convert l2 cache dt bindings to YAML format
Date:   Mon, 24 Aug 2020 13:20:20 +0530
Message-Id: <1598255421-8274-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::28) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BMXPR01CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 07:50:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc04d29b-0b54-43f1-5da9-08d848026500
X-MS-TrafficTypeDiagnostic: DM6PR13MB4148:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB4148A493F1B7C4F281BDBEA197560@DM6PR13MB4148.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lohN05zKWa6fC2+sgIxOKVvdM4xpN30uVZ9tL9U7VYeETiOutcoBz/J65MKqQcxnK9j3lHN/Ze0h9AcoK4KKjtnIOikU0Ii/gXgf3vy/VxFj/4ZiZkZv0dEHVlOIKqw11O6ZZi/PGNEtqL9grUK/0w27LCgRrC31V0mpN/isafb6oif7xlszBLPLVmTKhZXG272wM8DI4nnjNOJ6DSiu1eTYY41Isyl0niOmI2qBKPP5HOBQf0PDpj4RKBw8XkBLUhzFxny1NSt+w2NtVeGd7ONQkeDrpoEhwUFCE7gF5gt0shCMOk8TjZmg12Zgme8x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39840400004)(83170400001)(26005)(36756003)(8936002)(2616005)(16576012)(52116002)(6916009)(5660300002)(316002)(4326008)(42882007)(107886003)(83380400001)(186003)(6666004)(478600001)(6486002)(66476007)(66556008)(66946007)(8676002)(2906002)(44832011)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1jdAqAQDzhroLu+ZwixcIUFi0FCGBbcTQgXKsIkZdZ3cRfSvg6AZxq1yhP9kYSAhq5k3O7Cr1Y/3/zpZjFoLS+84z4LZwXuuOimccg4+ZPSdvcKwwLrUWdamR9/TQIaTgkE9N7FDRLW6O31cp4BIt0O7M6n1I03nRqUt6N8XnQv1R1xJCUOy1mTJnUFPZak+RjGn8pKhas8wUNT6ljHzZHk4UC7FJyK4RCg9Mx53bkJCckHE4meHDFDDpkiiUa3iaD61YdKU/vhHH5HuOzQG5tOH/V9Q/XeciHhsyXTTsWSz4H3mzPhZdVwTL22pupU8yCTJ4zZJAGQebKmYKm2uBcGyI+xOz0zjLCP20zYo02qbe6kdJ6O5Jm/USTPuPjqjtpI76VkNV1Q1gHLS3IaihKQGgPVBqdyLrhQOnpJASMU98ZvqCoJDKOto9viAN58Y/IG7PzEZl1enHq4Oa44zRjJFEmDar14DdOtWkkvkExlO/KDY82ueeYIyYkF/kAbOSVgMCtrtDNIAEba4xs2bX8WdlDdESrQGUGjv7TSskZ4/u3Huji2t3T1KcwsNi+VQy78mYCwvXU5r86k4hVFMARLd46Rc766f4T8Q9HZgNI3dGjQF1AHsPUC/g7BuhMGzLEqKqTYRMzyPEftF18CxDA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc04d29b-0b54-43f1-5da9-08d848026500
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 07:50:39.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0eKjyCB6bEvubPT2N5PD0czVrwio0PxNjvLtBuu2jFRl5AiFSfZsl2ps1h69mimYGnpccS6ASaMPaIp5uWLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is created on mainline linux v5.8.rc-7
commit 92ed30191993 ("Linux 5.8-rc7")

Following is the log for dt_binding_check and dtbs_check

linux> make DT_SCHEMA_FLAGS="-u" DT_SCHEMA_FILES="Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml" dt_binding_check
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/yamltree.o
  HOSTLD  scripts/dtc/dtc
  CHKDT   Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.yaml
  DTC     Documentation/devicetree/bindings/riscv/sifive-l2-cache.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/riscv/sifive-l2-cache.example.dt.yaml
linux> make DT_SCHEMA_FLAGS="-u" DT_SCHEMA_FILES="Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml" dtbs_check
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  UPD     include/config/kernel.release
  DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
  DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
  CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
linux>

Sagar Kadam (1):
  dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 93 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

-- 
2.7.4

