Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD72C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF2221927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="RVOmYHbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgBYLYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:24:12 -0500
Received: from mail-eopbgr60139.outbound.protection.outlook.com ([40.107.6.139]:32165
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbgBYLYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:24:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7PPdaJhFRXj2zZKtQmyue2Wfwdp7/K+SqK0D4fd8EhV9g7rDU9i8b0R96Yq1Y7AdnqU1NntbagxiBcPEY9eGOuKiM5J4GDR2n08G8Hh/qDrP8cuU5kJ1f5JI+JWT9Lwjg4IJgjK/nMxsXqIAXuXAq5EGKhaFVg7rc3p7lmzNtZ8LGFpV50aK0w78qUbNsjDa/w8mODYrYaOIftv7TeslxKt4E1rpVjeG47crX/evmXvHXACW+2ZSTG2yuqpT0mEZ3/r7gvY02agf9QgJPmk5x7f1qJTuKqgx2E499Dz9AR7DdW6L1BaU4BE/LV5gHeLp50mxx5JjHGynE3HQpF3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UX7xCLy8ZIvnXc7sXddBMHruhG+sfjr2KKeOkGov94=;
 b=mi4bSyb3GQYEa+O5X8CbY3biZ56yorTR0z//fo6448sCqFMYvdiC4GB9JXBgfQTIE4kmDI6LUuNeTfDy0x02DS8eHUKaUk3b8KuI2ieULjj4aXEmlnccXijw+ai7kbnCwCHzesKVp9UhYr1LKJBvE4gLRypVK+wZMKvJymUOvXLaDWMM/eHp4uoT9RUryK3jcjSD1dP1KM5wdM/0ZzZWYmMsUmCkdq1Drl50fjdPD/ka43Z9RtgsrkjyEGtasV9FpkMng6/rWgqEZM9VK4CTUgZ8eH1gEGrB6eYHXhnGPHHmoqpN9RwY4ntemH0aVZWw4dx8JNKRhpQgWyz6quJ+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UX7xCLy8ZIvnXc7sXddBMHruhG+sfjr2KKeOkGov94=;
 b=RVOmYHbfMQm0Xiqs8j7w9osdRQq4M60TWlz5NkOB8YUAucnn/mShc4yQesyPQOD6bvQdM3oktV30Us11LLC0HnoOzFVjAzMRX1xlr5DeQ9Was9S3gFMFAZlvS9rE9hNNCRtDAf6dJV0glWpNcskbULNfpRQx8eGbrs8TiXZLOxA=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (10.255.19.214) by
 DB8PR02MB5692.eurprd02.prod.outlook.com (10.255.17.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 11:24:08 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 11:24:08 +0000
Received: from ttayar-VM.habana-labs.com (31.154.190.6) by AM0PR06CA0104.eurprd06.prod.outlook.com (2603:10a6:208:fa::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 11:24:07 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Remove unused parse_cnt variable
Thread-Topic: [PATCH] habanalabs: Remove unused parse_cnt variable
Thread-Index: AQHV684YAjkxXbcV4kao3EYTxNeXYw==
Date:   Tue, 25 Feb 2020 11:24:08 +0000
Message-ID: <20200225112401.5151-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::45) To DB8PR02MB5468.eurprd02.prod.outlook.com
 (2603:10a6:10:ef::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04b38161-86d3-4c99-c5c5-08d7b9e53a9e
x-ms-traffictypediagnostic: DB8PR02MB5692:
x-microsoft-antispam-prvs: <DB8PR02MB56927A8D7BE9B5053139E100D2ED0@DB8PR02MB5692.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39850400004)(189003)(199004)(86362001)(6916009)(1076003)(16526019)(26005)(186003)(36756003)(52116002)(5660300002)(6512007)(64756008)(66946007)(6486002)(81156014)(8676002)(956004)(2906002)(81166006)(478600001)(66556008)(6506007)(71200400001)(66476007)(66446008)(8936002)(4326008)(2616005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR02MB5692;H:DB8PR02MB5468.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdHbFURjOZVfadIbFB3CbXOsbiZ3qxmJNMqaAxXRgvZJZIXOAWYDwicqDH34uFZJFZ//3s7460NTDJTwZSWHNuA8DCvlFwlsdQs+UOzjLmwlERhyZgyGL04y9Tr5QZ+qCWXIAPduciCE9Cj29KU1lBb03wJq8kwOWcv22z1tRObERz1Z/le7t9qiEmIRo8ST9XROEJLWrA4aUgBzuivYJk6p7C6hEB0XWCivgur1/AoDXVKW0BuPm52kejnpW6Rjk8w3MCZPoE4KhhCZ0y2bvYGYjA66C1nBeKttZGs2p9W8i+i8kke6cMr5wgp/CpkP693nD29TGrtJ4AePOfuh1fcH8QkZx4GvFZpVuOae6jVjAGXQ6Ovp93r+cD55htiVm/iRR8YKYwEbkUVBJx9SGp9YRtojMHWtZARTQLeOCSp9g6b1vZVP9XBWXVKzpuuW
x-ms-exchange-antispam-messagedata: LRhraGJK0bHu/g5LrcadwUwe4K8wCJBMfEgy86V/dVEf9+kfEInUMHJ/paAwIpgbi/Op7bM33+8H4V4k3gF9ekLli9tba4yBS83vkT575Sav5ry/HmtSL5pYh5uBRES23pQJM8b/93wuz4VOMntkNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b38161-86d3-4c99-c5c5-08d7b9e53a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 11:24:08.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY0/lL4iYi98Te2mbX8hJXFxGnESgixL48yNH8Ir4EkhTec9kBQY63GEQfcM7ZcGIwOBNY+/6WfIN9CZxpW2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "parse_cnt" variable is incremented while validating the CS chunks,
but it is actually not being used.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index 73ef0f9d758a..409276b6374d 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -509,7 +509,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 	struct hl_cb *cb;
 	bool int_queues_only =3D true;
 	u32 size_to_copy;
-	int rc, i, parse_cnt;
+	int rc, i;
=20
 	*cs_seq =3D ULLONG_MAX;
=20
@@ -549,7 +549,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __=
user *chunks,
 	hl_debugfs_add_cs(cs);
=20
 	/* Validate ALL the CS chunks before submitting the CS */
-	for (i =3D 0, parse_cnt =3D 0 ; i < num_chunks ; i++, parse_cnt++) {
+	for (i =3D 0 ; i < num_chunks ; i++) {
 		struct hl_cs_chunk *chunk =3D &cs_chunk_array[i];
 		enum hl_queue_type queue_type;
 		bool is_kernel_allocated_cb;
--=20
2.17.1

