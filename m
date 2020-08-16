Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64074C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39ABB20735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="YoGAxXCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgHPPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:30 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728310AbgHPPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCWuOPGZ6Ckg7So3C7oYr6sdx0wMYk65AB/LLqLpKCfeNzgIPDQ0cpGpu+LM+l1Iue9mUQLBkKhXKuN8azkPqw/wYy+OdRb7Cc/EU8IqUiW0aaWdosWqvsV1nNtG8UJ0n4ZKaNd5/xjQUhd4P8WEEGpr7l4PzucES91QCr1V1Pvfi59EIEnVi/3eqDgocyaTIB0WSjU5/zCVkMAfmzlIvM0CMiF9O9SeuBCsn4oV32RPEHq8HnWRfAM8x/cYJ4K33hLMe9a+Xy7lcp+PeRGCAQN/5sjBb998uSXKg43KMqyW/I4ZzjMyqbDWaFIF4xXkJyx4daFps06yLEQqEXkmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HlQ2bBtE94vd73MP2JhlvwBsXxpZx2mkkdIp2VSfKs=;
 b=TH5p6qDH6Ck9f0QUhPJv5pBDmqiRhsXs0pVA8g7vAJu1IoWqDQ8y5tcPDSDZFgNQQTI+y34p1YcZgiP0tfhIVi4iKscvoKmb3HMV0jI3Lthxy7JfTzYph2MsO5fHFeSxCZGFwAxvVkSfCipzO03D/Z7c6NuwcLlHuHDGT+Oxf1TXstWgl1NCoDuq5dErXgclB7h8siT79Fx+3NAr7S+gG2YW1VSYbcjpga9YcEGPe9KnAWrcb4/8llDBa8jpcDakmPHban/6rEKT/1O7PvaUMw41IuHsOubPzL9qH6uEo2JfqbBdSYiM4D8dHMwemAI6VkvVIcj+s5CJHsjNsiYKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HlQ2bBtE94vd73MP2JhlvwBsXxpZx2mkkdIp2VSfKs=;
 b=YoGAxXCLypc0UiUuwo/xp6ooeU6QdIsLPTrDaxeXruK+Yf8s1rM1zkazGe3af3BPyG7sOyiVEOBtCwBARDIdVLtzvy3pTg1dq641Ql/E1PVXKv0A7rpQwrg2t+lcSHKNgM/TTofxNe32076J8myqZrllKF4Vuaj/55djrLXgltc=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:20 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:20 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 2/9] habanalabs: cast int to u32 before printing it with
 %u
Thread-Topic: [PATCH 2/9] habanalabs: cast int to u32 before printing it with
 %u
Thread-Index: AQHWcy3bKRxNGHFb4E2xMipGlF522qk6thOg
Date:   Sun, 16 Aug 2020 15:24:20 +0000
Message-ID: <DB8PR02MB5468E4A6F68AA5A255D9934CD25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-2-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 355b446b-e1d0-4445-712c-08d841f872c6
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB35473CAB9775146B1EDD3D0AD25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPpLX0NsDory/68fiP6LE9o9IWcUGtpi87cgEq73+Ab/R2LUVW3/l80rS68cU2RxpK6Q0Ayejx6pDbGdGNwgKjDIMGEQqmWL8EIIcb0Evm5X3LIMsbvez+0qYfEzdKpNSL79mhQ3rzf1Wd4s1A/MGQp+Cq1mm09upG63tq5+ogQHFPKyHp8m2aqbA6R7O8Jg9OiYpDsnW/Y8ZZ2rKzyBHkAFPdskiekniu1+apukVVQ8+YeL/iJGrCd/b3RoHI53dPqZNx3Yh0Tu4Jh3P+YmHnNRbvTMAJHnpYlYGkXTHtfunkP5psQB6Iw2xjBKyDnE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Z96/igG80X0vE3WuSL202sUaHfG4hy0W+rGk70CWN8qlqr2nRx9fRLxMjvqHEG1nZbmVgJb1T/VVsvKPiRIANq5CG4yKFAcQ5tcWiZlsdLJIedkFzGWUD4ehI39c3SK2BLCuHxEFYTbJATqSZeG3xKmT3og5x5cisv5EoIpk2uk4c/NYHRTLtsy8QNWozTcVM5Goe/A8NzVgyYSpgDAQ5H0YHSLr5il9fQ+Quv2HKy2DnL8wuy+zPJ3qAh2j48J8L8avZa78otUpIiePDTi6uaMzctDoFCuxHR1hrOiLpGMvcDolbqnKrRupJWbVSHGykn8DLRXIz6JaPK6W3DOGXxnjKxNyMl5C39jwbBljGt5BtTeuu9ysUERjb3fSL8ix6wAVRTSnQAr9TQHedgy7dsIlloTIJjDSdJ8bMSP4jl2scgPvPwH+Knda9jCsiBIwSLjn+xzKyzJ+5rv1ACP3OvmpRTQ3QZ2NxpDjAIcPgC1G5QQpJ5cL1zC7lSJx99lthMdq9vLU5Y7Icuz0f3n8OC/xWMve45PlMwTyr7eubePfYyfMldvqUZ78E7ZfmsiVbpGJl8dE05WuwPebdI22tTc+td66X+M6LyhDOCpYCm1CK5DRHRmstenJWkZaiGUgl1VN72sJ+td2NzO88H3mXg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b446b-e1d0-4445-712c-08d841f872c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:20.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DFyuR3kSqcpfUTTnXHbfU4bIkkA6NIbvIFAIcINGxE08rIpYeHfsjD6scH0324QqFSPmIV3xQxWL9IFv89iGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> %u is used for unsigned so we need to cast the int variable to u32 to avo=
id
> compiler warning.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
