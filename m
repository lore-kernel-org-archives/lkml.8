Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB553C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A232071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Sr6vvByR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgGPRnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:43:31 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:36772
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728182AbgGPRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiizH2q3HrgErNVF1Fu77KrEbgXCRqLFG9ZYd0uw/PWkWmNj4PhZZFIBmexum8+4Zr1Qpj89KyTUZ4Gs5u2u9pdISBn8tbH2ge9NW+5dC3YNHc4p3NqQLSi30hQL5cU0CnYlWS7Xx6HJaAny39L0RYSQqH9+0J3LQmo98YhUTqr0CFBHpeOkPCAYJWT3HwOOovKVS2TG0MkPE8MZ2vmpCvRiWqUlmesdIrQnOTMz8v/wdSgYeOS/HaHOwaIdyeJnFs/wnKkUBXMNVaEYZOBgXM6sKakZGJ83v6C/H+Q0aXInizIl6KctXSVtuUxo1eR8Ijkqn1PfnYVFwrY3EuC+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YMIo6+m6DDQqkpXXnOM6b4zYzc79MrauWp09V97N1c=;
 b=hseFiIvcNPyGSFcT/HfK/JqxgX8wamVBJqbG2Hmp4W4lpaD6sQx2pnKjTQ9nCem7E+K4op0KItz/fw655QHCh6qvXS2LM1iTiV/VqB4b5nRyu4UmB43PWU6hyQGTbmHSGy9nbvhZ8V/2TI70czdSBUcQtRG7/3NUmjoqzqHvgSCTmgjlweT6FdMxSIaK62Ved6n8VbNx2PvSr9FnVZKmquXIYKkJlIgZkij7wTnT8Cfyju2B3WdAbTdNSU2B5FaiMP0M0Ze60VtB+1Se2d3j5z5WpF3WG1wKw90xaRSjSp2LhMY0x6olvCXc3so7psbNTEMME7E87fIPibZvX5Gopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YMIo6+m6DDQqkpXXnOM6b4zYzc79MrauWp09V97N1c=;
 b=Sr6vvByROR1+bA6c4b793DfQ4k+qYUEY5ccKiHO2NlzKzkmSbeOozlEcVbt8eMxn8TVo0yWfazLVgyJjy0u2MZRzrUp0/Y2WCqmhjH3E9AuKLJPziVgBuGVip0+2/wCiiGxYRdhDQiU2HvjmUXMniRpvTZal7y2bf5JFtG5/s0o=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 17:43:24 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3174.027; Thu, 16 Jul 2020
 17:43:24 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 2/2] habanalabs: enable device before hw_init()
Thread-Topic: [PATCH 2/2] habanalabs: enable device before hw_init()
Thread-Index: AQHWW0Mj1I59sY5wuke/e06Krcc2Y6kKeeew
Date:   Thu, 16 Jul 2020 17:43:24 +0000
Message-ID: <DB8PR02MB5468F3E741314B6129244B6CD27F0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200716073129.5924-1-oded.gabbay@gmail.com>
 <20200716073129.5924-2-oded.gabbay@gmail.com>
In-Reply-To: <20200716073129.5924-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c40cd98-b44d-40ac-813a-08d829afbd8e
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB35474CE700627EA0F2C6A633D27F0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugkQTcKphEJrVNtM0yXl+h+JEQhVajaKaQOCrRh8XqBJAzOF7haU7fE472WfsOkZUJj3mB8786iCfucb75B8esDmZMu5Vlhfd2c3NRdivq5xs6sti/ZU7FDlA/56iUFdDq4CPF0ZYippiJJ3yLcORTRmHZe5w16qLCYqC8wfZHxbOZ09AYVVyol8NNKrNjowaJx9lxnEtymUC7NilknjNBNCfiE0erI1QHkOUtFNFK6kKmYzcrA6T6s8P+/PT4++a9I440X099hEL6LpVyezL/77FX54dQhZCy6mYhisavPjy/5m/R4XvjEOF4Msj90qwNdxr+gGQsU3bYd1CW5VKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(366004)(376002)(346002)(396003)(5660300002)(2906002)(8676002)(186003)(55016002)(6506007)(8936002)(86362001)(52536014)(9686003)(71200400001)(110136005)(7696005)(53546011)(478600001)(66476007)(66946007)(66556008)(76116006)(33656002)(64756008)(66446008)(316002)(26005)(4744005)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YIRgQ4EXPzvDJdIsjfpA0gHSlQxHA2uyyGV5nU6/kycySZ0POVT3eXH7lbT/K2i89Aktse2NyPI52YphK0XT266P/IqbHix8JnBvtO5mBhgmdYyLmoYs9jwZs4VcLtOPwMK6WY3x2dCYegpXoGm54EfhjQVsHaKmrqqaVkweJt1XxxyusNBR3IXFCH8Nrksm6knwHUsfkzrBEbmnkuEa8cuLyUfdENmi/ENqViGTegEyHaekPjynGO12pqdWTYB7RGeCCZyQVdJ53QsUIIkO6cJprVWe1kkjWGtV3zvwNd+IatB2mzDB/oVDX8+I2jrTL+qtj0qNQNFVaKTe4kG16l1h/6S1ENtlcGcFxwdtRs5CUm1NabjATWUljFcb66OHzcJyQ4DBUL+rBTq4U9TOFiRiznnPp8e/TXd6eAin/HEczjXRf+S55YLeWRC3TwbfBGgBzbsugMTLMKJc1+aPEIJ3CIJZ9RGx+OPD1qu9tVxPFJ/kFGlt02G4jIQC+aNw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c40cd98-b44d-40ac-813a-08d829afbd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 17:43:24.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6hsf3cq0Eyy4UfIhmCVwj+Snzyb+mv7MOdexkXVy1bCYL3FG1Z/xUy4GerAxymwz2WtLvkIKwBMj8svaK+WHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:31 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Device is now enabled before the hw_init() because part of the
> initialization requires communication with the device firmware to get
> information that is required for the initialization itself
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
