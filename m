Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA88EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB32072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="JIuR50Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHVSk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 14:40:26 -0400
Received: from mail-db8eur05on2102.outbound.protection.outlook.com ([40.107.20.102]:64640
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbgHVSkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 14:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAK2BTRLMVjLhGZAJB/m8uzMPL8qz504mZAbeRpvQAhKnS1rezICiLa3MVELnWffGPqqIy4U8bovcWmPyO78W85xAYbo+/DRzXqoC6eHrVjuuEEaf9uZtp0Wo+xHa2UViRydVF0SolkNCAyKEark1Qyv8DxkKK1i8KCxCdh9YeV2T1k9s5pUTk7htM7hX88+oQjwgX/b3NaC9TVXv464AUmnt8T0N4s0LoUW3b9GtAzQpomtdcSDr21SI4qY6L3nz2BmIVg2YlRX4vgmwhE1tKJUxQxib+kfWm7Uu5d+1O1Yx26xcHUb3jt5SyxW5N8+rSohjqWpHgR6Trw7yu/TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7e9DXab0C7FV73IGFp8IKIvFmfRDtIio7OZvp9Gto8=;
 b=ONBA4SMUfhGMLzmC+gpP8tqy1AaoWDot8DMIeEiDXi3HuJmCpYKn8LOFJerljRysv0TN209hcv32hyrOhAHSPCr0vEWUndp4qiZPTx6bF5m9JPzTXlp6sBD95lTlF8xqgn7tIWeCh7hjFGIXPWTm8Dhsnw7+LVNUHVxvA67MfUFTQSgD16sl8fgRr1oYQ5j5eFRNHcuDgJifQsXXcoeHARIdfa6wFL81R3gUAEBVebZYBT7us6SFYl28x3lk0AIPXyI8jUnmVv1yy54etabiEWXqkmI/1RAoVCONSzps4ScnG9/qZD8QI4B/7/4exjQSpwQJiD1NLPMAgDbIE+tFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7e9DXab0C7FV73IGFp8IKIvFmfRDtIio7OZvp9Gto8=;
 b=JIuR50IesvjXFPaenhtqw+Ue8UUE7wbD7xNunKGDesEdRFAq3UBQdKyurJFyBDNsHQ8DyF5RdS9H7JFZztj8Ga9LxeB4MBa5Jby4Hlsh7V1d5mH0K3mTFxsQLnx0r2Uto2K3M/JW4NFXpZfKugX7vxwyhn6vETMX5FN34oa0aqM=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5739.eurprd02.prod.outlook.com (2603:10a6:10:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sat, 22 Aug
 2020 18:40:22 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32%4]) with mapi id 15.20.3305.025; Sat, 22 Aug 2020
 18:40:22 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 2/2] habanalabs: update GAUDI hardware specs
Thread-Topic: [PATCH 2/2] habanalabs: update GAUDI hardware specs
Thread-Index: AQHWeKCad7SNepDj50+vLr4FvlVIT6lEddWA
Date:   Sat, 22 Aug 2020 18:40:22 +0000
Message-ID: <DB8PR02MB5468E756C9F873ADFFE94256D2580@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200822162335.21295-1-oded.gabbay@gmail.com>
 <20200822162335.21295-2-oded.gabbay@gmail.com>
In-Reply-To: <20200822162335.21295-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [89.139.189.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f64731-cb32-4df0-0320-08d846cad3b3
x-ms-traffictypediagnostic: DB8PR02MB5739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5739141837A15D560FD91452D2580@DB8PR02MB5739.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mD7e3kdbD+g62qb052F8qibaZxiQR2IKDvXHeHVBNda3+y2Wafw98273g0NayIqXaUgVOjw753oudad9uIDjlFwYc/+S0nnIvp4/ADmnj+j8I2xtN7pLtE5QrHxi3bNaQy6Q9uzmFg16Oj5Rf3pM4shSyopZzx1g+7qEe2vDf7gVuOdvUSy+ATMux0k7jLidSMQKEJbFR8cWrYtHFJDOTs+ecbninRPnpNGPdecmpcCj5dAYS3ih9JINBhdabkOrtJbn3dLwnI5rcBR/uWwroGvkepKOmQB+tGoS+8PMpyXkYuu6VAvksHO9T52n2cRCi6yo5/+02OiS+qjPh6gP8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39840400004)(366004)(136003)(86362001)(6636002)(55016002)(9686003)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(110136005)(316002)(2906002)(478600001)(53546011)(186003)(6506007)(26005)(33656002)(7696005)(71200400001)(8936002)(558084003)(8676002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7xRS0OzNn/eIj+Uu8hJsw57yX8t/clsp3DAQFpXgq4m/AWc27tWwvC5NXpRXfAV0JaJ6pJDtVHVMb51Vl+32Unq5BcjKzLBMtOAhLO5EojZLnjRWMX2+twRhQXwTG2Nzs7Hobq04JI+wqtPWP3RocGWtvSLR2pIg0FkQdIBIHeFqwWwLuNJZcztbl5nvsMadxCPEztk2yuGvXchrVDTcQJlPDnK+G5hDciWn9buhxM0CMhOSafwP/nlMzE82xivrL4qOJoiGEIhZTnTf9hH/g6kFzKY4YwBbAfK1RNW2uikrN5KOvjLNTv0bl+MjF7erdK1YLSlACCQnwcLFcCxWGc7sZNz+h2uNc8aV4xbOQ/PZ/eC+G13GpsgZqfLeR1vNkg7nF4a0PxJTuDGuAxoGy/0yQhTgk/N88hLtdZunhlRxWh3bw1q+qrxnvVvmdDnxIn6I/DwoUpqrgL/Gqw40T3s7z4CVk2cutWJsbL529LDL0OGwqIx4t8+pIgZCSI4JxRSjnoC+RoiF6nCVt/GVu4Ci6FcoEsd27AJEF1F9Q9W6D3Xt75xE/ozylHfYpcJtughaDNrw59AWxddbReN7LXpnd6aVGHAnsClUFa41vas55O8lgnvY+0EwxYE8kAirZLGp8qyQTfDsyGtT57QShw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f64731-cb32-4df0-0320-08d846cad3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2020 18:40:22.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZFP+SBSwLa0L2FJstq4iZWCMTecH7XJWOWU8N6pChQYKWyH0+vxGUKhq3TcQASTERwqA+NZn88BJ7b5uDt0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 19:24 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Add define for the 2 MME slave engines.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
