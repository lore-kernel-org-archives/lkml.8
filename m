Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7909A206F7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="UkN0oSOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgHXCct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:32:49 -0400
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:4287
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbgHXCcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWpOnndSW2GA32nw3pzi9kCf402jPUlKhUzXc8K1eMuUemi3i8Ck0ObMrHt1qaDRtQ1FZUEwnBLEZpmvo9HlAJdAJJ3YHUhUjIXKbPlOZVPVGCHjD0N8p5+7vF7UStPc261MMc1odyqQ/HuVEnsUWYJnf6CvlXo0JJ1o0082wMoKXrwJfUpMt2zSiOvf62QWFXnYoWtN/hta+eCWBSjzodixxcafcIGOhYOtzRy9Q1Xj4H+40iDsXY0WVtjgdSRXBpULOUyrNIhhkRvcl7gP8hpwzu/0p9a4GFk4jzpg5okYGYvUrL/ncJvq8FoVjv5+ZP8HyibEbZaU6rLAFs6z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLqXLmepUxH8lJ/T1aYWR5QEo481OuYSaLRGxZY5cQw=;
 b=GAwgsTWMvkfDb42nJWbO1yvY/kJkrPZeeZU7T+50ei1/87Rb0M3d/MgTz6lBUCaqxJ/3dHvVDeuKvrlRTtYA192nEKWSNYpH0+g+XRHl4QeXASzueAj3mx6XxBxlHntMEwBGgo8xPT9qefkZYuWcAOhWX0a1Fej2KRXbxt1tGtUgv2l+OQkIlNtIcactqBh2o574sCoZSUcI9u6eoow1GOuZ455nSW8ID0LkyE7yhUP26VIrBR4RsJNv3byMcS2hsC7UAMq2HjIG6ZWmzoG0xSrH15NI4253O9t2Bm13WXNmUZXrc5sLca+Yphnp0FnojG5OigpeJOJNdTy/Fv9Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLqXLmepUxH8lJ/T1aYWR5QEo481OuYSaLRGxZY5cQw=;
 b=UkN0oSOSTJ9V9VLZPWrPno3nRkgEjxw2aCEYrS1ZLUhzhsBhSVNWi5OGxwnxRWOFvYsxPSGqzxa9OqBY70bu08UPrtxq37jbEvKaLHBf2LafSfX5lO5IfHRC9Fh2UR8pwwjrF5+EG8YUj0mAOp46QegvVOK/3Uh4sRwTQlHxM8w=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (20.178.24.145) by
 DS7PR03MB5544.namprd03.prod.outlook.com (10.141.123.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Mon, 24 Aug 2020 02:32:46 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 02:32:46 +0000
Date:   Mon, 24 Aug 2020 10:32:14 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: mp886x: use "mps,switch-frequency-hz"
Message-ID: <20200824102402.4047fa5f@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:403:a::17) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYXPR01CA0047.jpnprd01.prod.outlook.com (2603:1096:403:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 02:32:43 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20622826-c3c7-43aa-5b35-08d847d5fc08
X-MS-TrafficTypeDiagnostic: DS7PR03MB5544:
X-Microsoft-Antispam-PRVS: <DS7PR03MB55443502AD77EE443645D24BED560@DS7PR03MB5544.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zykgtRs2pRlJYMqIGu0bXwQ8ci1C5pssyIe9wR4o5i11LHKtbjPWPXbLV3LetAv01jmEA2iKeGU/zFseZx2BIZbarTlvCSTCV9+0CQiwVhbW9N3svDQXJ/YkVUm/aPeiy0nVD3BvHefdSxSu9xsKIJc9AaJTkzDu1RPP2IQmwuW7q4oUFdU+hLpRZoliB7WJRL4qYNweFXmSaqOliHDg6EaGzy0gYfphZ0X3mh6XavPXFFOQXQRO/OZI0ntT0ovb3NPxRw+7fXBj7SvTsK40em0X13kLhFNUY0EilAsXyzVD/aQKO0lglmgUeu5ftw6ERH0wiJ9vG+ycrtoMOseH+RaDxv7j2AVaCPvSnTjvK1+ZvdqQjMfv4330c2vHHkze
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(956004)(6666004)(16576012)(478600001)(316002)(186003)(83380400001)(6486002)(26005)(9686003)(86362001)(1076003)(66946007)(4326008)(5660300002)(8936002)(2906002)(8676002)(52116002)(66556008)(110136005)(66476007)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hHkcponacak1XrPbEK6meIkIH5v2bV8zNaGlRrcBvJQ5YRFB10DGqzImcXbCVaTYnk6RI10KnGnoZELkMM8z69hjV20VwQJGRMOvGhv0AGrdkQSnQMfYE7KMkVqI14POCo157nCc9gf6XFs/ds5UjJXJFhziUOZexgcR0DzwJ7Z+N3DrznbwvNulcVTO12NMiJX4lnDmJ8rX2FH87CyyIbwEW5eeFKFpChrb/g1HGtAUuE+Ud8tH9wKHpHXk4iJsh8ZvKgm9XNAZdIyRo9dZi2Uy5QIveTX8Aek1etF+XD2Uh5RlzKYn49Zer6Ev9CXlEUzwiAAQdGMAuek1e6mSumYBxXXBfRyObjQOKHbQdMeKFIUiaeUzya8BiOp8R7Yi7rI3OeBvLI3ljQWdQEU2TF3Sl0frPLDwPGk21LtwzgOEoWJ0qNb+jpxDd3N95DUtuMTvjtwSu526QbIdguckMRxZX3LJgwGKDqpYzdmF3KfF2OvOc1gR6SX2e5DKQhoUiENMtJQTSWODrni6atw9xgt54IxAsOAwYhXnG5N8ssEptqR8pFqfmaEC8LvDnFUEFI5Fu6aEQ56H3LJsAGlnZVeVXyVDHxtUYWD5dPDEcvM5sSxOuaX8FBflQ5YTVKZ5E4PMKHqHkZvrTQe9bHnblw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20622826-c3c7-43aa-5b35-08d847d5fc08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 02:32:45.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LIYrKQoKAQP5IEB0J3PnXZ1r72KH2MXcUGTs6yR2h8bTSXs+Bl4cBPLUTkWVx2PKsKea7mfyec8Kfnp/wvjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Rob suggested, use the "mps,switch-frequency-hz" instead of the
"mps,switch-frequency" for switch frequency. Fortunately, the switch
frequency support isn't released, so we can modify it now without
any concern.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/mp886x.txt | 2 +-
 drivers/regulator/mp886x.c                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
index e747000cebba..b05307bbb0d9 100644
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
@@ -10,7 +10,7 @@ Required properties:
   values R1 and R2 of the feedback voltage divider in kilo ohms.
 
 Optional properties:
-- mps,switch-frequency: The valid switch frequency in Hertz. Available values
+- mps,switch-frequency-hz: The valid switch frequency in Hertz. Available values
   are: 500000, 750000, 1000000, 1250000, 1500000
 
 Any property defined as part of the core regulator binding, defined in
diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 97dc44c0d663..a84fd74081de 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -349,7 +349,7 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 	config.driver_data = di;
 	config.of_node = np;
 
-	if (!of_property_read_u32(np, "mps,switch-frequency", &freq))
+	if (!of_property_read_u32(np, "mps,switch-frequency-hz", &freq))
 		mp886x_set_switch_freq(di, regmap, freq);
 
 	ret = mp886x_regulator_register(di, &config);
-- 
2.28.0

