Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F0C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D087D206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="VLYEdbw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBFLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:16:58 -0500
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:46685
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbgBFLQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:16:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOZ81nIeuQXoS4g/229kq08mrBvugAxbmGzxL6jaSujENKeuS1sKGroiau7DxnI6lY7OjGIpaW2Z0KMkJH8CViQC2V0Rgi5AjVtRdn+dWfNQBWrsPN3/jOrTZskLkVVgtRCZCQvtZqGJuJifmJLVxf+oakMU2XanIx+augasvDtsfU3b/vjwQfu8i5d9qHo9OwvCXMAXhgWZUIGmhjRLgp6mGMYNQFZ6roYsC0d3wYBd/IXuhX/l5TdjmlgWsaU0rZgPMR9kOMvk/qyYk0gWwCi9axmROpBQ5homb94WvKVk7/lPGKcPmKjKi8Hcx2D1Oq/cTE8Mo3+alBQ/++QZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSBcUZyaBhccD9h7z8pFu5FJTUAW+BUkX0tWOXuwUmA=;
 b=ehcip9Iqgr0nRdaHq+C++mjwoj85n2m/adnfUMZMauNkjajNXHO0Uk02P0RIQTiqHGwiWlm8wnHG5wjN6LMxZ18DS19vpcmbMWGzG44gSn3508NdDRFgiNo+5gNbj11niPhFe8zRHkorHoSIiS4dbbFRkbJp4BbUGTw98asl1/G1nF+9NPwfuZ1KazkWxvqN8sk3/tIJbozymVCqfrJWpTfbfufyXuCaPYWmcdv15AT6F9K+/msKvW3nPYQM0FNoRB/fVp0dC4yTX9nX88Llf3tJOhAn68tvaRzPbZo3IOQI6xhQoZqgpC2x6fmmBhHGFDV0nYteHxyim6Qz0eS+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSBcUZyaBhccD9h7z8pFu5FJTUAW+BUkX0tWOXuwUmA=;
 b=VLYEdbw89v/cXyH5Wzzp49MaQLxdmE0/Xb4IW436NpmDEYEYJele9Z3CI/f1PRwRTrhzspgw9hgfpDERONJRNhKmBx5MYY9mpbfP+NQS4LQqYbBvBNpmBl/1voImHptsB2BKwywogYQGPGjI+lGIflEa//qj5TybMQqYNJ6lh7g=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB5572.eurprd02.prod.outlook.com (10.255.31.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 11:16:54 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206%3]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 11:16:54 +0000
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 11:16:53 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: fix DDR bar address setting
Thread-Topic: [PATCH] habanalabs: fix DDR bar address setting
Thread-Index: AQHV3N7v2b8jcxix0ECPfPaWxfb1jQ==
Date:   Thu, 6 Feb 2020 11:16:53 +0000
Message-ID: <20200206111646.11755-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::32) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11ebf10b-1fa7-408b-7a5a-08d7aaf61205
x-ms-traffictypediagnostic: AM0PR02MB5572:
x-microsoft-antispam-prvs: <AM0PR02MB55726CC77FCB96D3027D7A46B81D0@AM0PR02MB5572.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(66446008)(64756008)(66476007)(66556008)(66946007)(6486002)(6916009)(5660300002)(1076003)(498600001)(6512007)(86362001)(4744005)(186003)(16526019)(71200400001)(36756003)(6506007)(8936002)(26005)(8676002)(52116002)(81166006)(81156014)(2616005)(956004)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5572;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQhuKianK7APBdKP3xIFmr2s4WznWjqxTQx7qmZJhA4ozEs2DTya+3paT8Y4YNhQPXCCZVke5B5LpusSZHXwmD76th1amHqlEs+zn+z1rm0J2gfw/7DeCtIXNU7gsVmEmkDKkeyYoBe4zCsQQMWS3vZI5aRpYoYC4DcXONmubH6H1VYTNTXegszNlkRFd9F+R1+M5bBj7ezCMIXGRxT/izN3lbwbqB3qkXR5EuLchUE/StMT5qBdFSaFDC2+ljomA0NXTY1Wube3B4r91182rIRrNZl4Az1X64GJp+vwFnuNa6GBleA386EnRRqqbMkqsj2/e7R6dCrL/Vk2Bhd6sVdZ92kitMlevxjP4aOkMuHoKo1S5IROo6bSBg7WQfnwd0H2oMXXfAfQPd3yv88VXQ0FWet5wakA9Wx7qQFsiH9o4p5o8yaspvNsbaSyBUxb
x-ms-exchange-antispam-messagedata: R//tMhGqqu8n2cASmC1PrfaFzwoGlXMVDBTh4aRRH2OZ7w5JatKwLurbfSPEJgco76omWy0NaXHW6EvAC70vuSMx7FXXA/apjR3Z2vOmqIfI7S29j90LOfr0K4vaFAO9U+uuAMm9e7mnK2WUJeRTVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ebf10b-1fa7-408b-7a5a-08d7aaf61205
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 11:16:53.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRhwJiu68dHwuHMl9CUg5xjKL1HiEQh8HwDmYIGirR8/bU2CvyRrAAV01wQC5mhmUsR2+dK5Mn5z7Ybpq3MMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5572
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRAM_PHYS_BASE is already taken into account in MMU_PAGE_TABLES_ADDR.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 74785ccd2cb1..f634e9c5cad9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2575,8 +2575,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	 * After CPU initialization is finished, change DDR bar mapping inside
 	 * iATU to point to the start address of the MMU page tables
 	 */
-	if (goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
-			(MMU_PAGE_TABLES_ADDR &
+	if (goya_set_ddr_bar_base(hdev, (MMU_PAGE_TABLES_ADDR &
 			~(prop->dram_pci_bar_size - 0x1ull))) =3D=3D U64_MAX) {
 		dev_err(hdev->dev,
 			"failed to map DDR bar to MMU page tables\n");
--=20
2.17.1

