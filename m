Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9196206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="K00SxNyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGMHY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:24:59 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:40512
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgGMHY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ1Zf90ua3t3sqBT0NYAbvTaaTbrMMa/lu/d8cpGNqZw7t2npkFNSWy+rKljzU2zqkLgYbuDi65kFQgI1W1f25vbXWdA1qvypEiYQm+6tUkVStKpHDg2i89eRF1536dTNoYAadXBmstODJjMq3stcx1pC9ya934baev1JfsAHXmERyVk7tv1rHBmrKCA16fat6kgHGQnCm057F5mnPgSLCi5YhYIrJOws339CzuJVyEz+L5ZTwrFCQnypP+9DWtgIvqpVZ2UUGpL35m8LJPrjF9D7M4jOXLbfN+YGY7L3VB47ZyIYUjSSKa63uCsUE8RX7WizylSS6G8wWzPhWUr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhFRwQ/4dvszuYlnKEA8tLmZMosdshBAKeKfdk0i5Pk=;
 b=DAAXu4mnO0PRrxwKEhDzM5Q9SQHLldgb+bPVZtW1pcrd3yluKejxNh7Nelr67ZqCQSoFq1MJ1+UFShy1JGM0hrls0+cyU3XKvHOQEAp5fzR392OwwtjScZBwaRxi1yrU8BtH3/lLVTwk5zGoGu0pCDrX05YsxbGhgBz5Gd64SRO+yUQTu4T7/4WZtQLKIqRVD3BEO6BvRgzTK5ar68H6FMJPK9VJm6/myDU6E63MVEtmayEWE1E6LcWvPiqNI1/7UXgjtPaxLoZBxhcGfDUR1NG4j4IqD7/ZyGbB2rw5kqOad07hFq18pHxG4Xja0VvMLRCvbYOZGdNQPt3uFyLpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhFRwQ/4dvszuYlnKEA8tLmZMosdshBAKeKfdk0i5Pk=;
 b=K00SxNyMJH3peOKZ7P5EjkcUTFHOOZMISh4gY8KtlCCF2ZkMI0nRqEGlwQJXnrPL216csyiT49+ZrhKBg8x9WivGcwPf22q7EWPkxiulGfPoOn1Iv56iOlGxgEPCmRK5nJr94O/DUuKBg+QgQYVZpzvJDMLHmGS8/89K8+xmWUU=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB7PR02MB4505.eurprd02.prod.outlook.com (2603:10a6:10:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 07:24:54 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 07:24:54 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 1/4] habanalabs: halt device CPU only upon certain reset
Thread-Topic: [PATCH 1/4] habanalabs: halt device CPU only upon certain reset
Thread-Index: AQHWVuCx1c9bP1ERmUmNs+bwrU0OHakFHydQ
Date:   Mon, 13 Jul 2020 07:24:54 +0000
Message-ID: <DB8PR02MB5468F9E41DA0EFA9FC1FB7C7D2600@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200710173652.31039-1-oded.gabbay@gmail.com>
In-Reply-To: <20200710173652.31039-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d799a77-7074-4fe4-cc6f-08d826fdd6b0
x-ms-traffictypediagnostic: DB7PR02MB4505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR02MB45059C59ACADED20C0D249BCD2600@DB7PR02MB4505.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnZchrHkugE9CvekuJeS4EcfP+Bz9EUAvATWzAPLyANhfcLokd8SQJSq8UFLqGhJhgw+T5CquOV2plSloM0bRFbuVc3SX+dNUiXVr/oIlpPN8FQOu+DjQIwQGI8stn0Y49n6Wi45uRxjU6Ai6V1W+CWQbwL+9LLdHJiBn4XT5wJrEDrcy/5xAlgatqrv5qwPAzBzveimab57CzX82R4/c6zyB8ftYjYAY+7em0UDq3uaTU6b5KrHvoCOGr+3NZshWxggQmWmcEyYk8PG4GXhaPC+rKQvKkPpZXTX+argPzN5UKHTvMjQJMtJAMKrzw9T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(366004)(39850400004)(83380400001)(6636002)(478600001)(4744005)(110136005)(26005)(52536014)(186003)(71200400001)(5660300002)(316002)(55016002)(9686003)(6506007)(53546011)(2906002)(86362001)(7696005)(8676002)(33656002)(66476007)(76116006)(66556008)(64756008)(66446008)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MgzUBUyL9iby7evXqrej7dDwC4sZatmISbQrDreN+KALIvJLMPzQS/6WBoZefsMeO/Gpz/pLUvaAxfOMNJpnlUugZA7RS/ECJ5jiAH9UuHw5NUrg/xfCI4iirzIxcRlIAPBWKzqQylXC8SelGHwcUWil4kCKsvIiFmUfOoHB3rFG6M6hBSeIkHRx44engxJyg/gEJaBfUioU1F6Uy0AEEWTPKp17/5Cu0zY3XmT6+yH4e4zrgYcs2CUy0Ol8Dz3ArZbPHGRaPRxmWNLHChQDu7PVZI1+PK7iyRNmoBsm5J1LuDdxG3JWclCuhRXXGdXeiemFDjDlc7xBlk5U/ebHRSKLh5VT/TyrnE/q4294LY0mkMQc9Tv8sCTWuj63huH1+R9sRGwKI/QyuEyaLqhDq20hRo9ecpeoNTwD/YqnbcGpphlK9CJvdwGVQhGodaxMQrzuBJZgxMXlk0nEgN5BB7SiTe/Qo65jLCXhd+RXZP7dtClMbnvs+2pcHjSs7IKd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d799a77-7074-4fe4-cc6f-08d826fdd6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 07:24:54.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMjJ9SmSEKZQ642tyL1FSlX+zomh+RdKzXVfQ/9E9HR8cNurN3jfjwaujfH9OP5o5dKc7/ii7ttn2tCh19UqIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 20:37 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Currently the driver halts the device CPU in the halt engines function,
> which halts all the engines of the ASIC. The problem is that if later on =
we
> stop the reset process (due to inability to clean memory mappings in time=
),
> the CPU will remain in halt mode. This creates many issues, such as
> thermal/power control and FLR handling.
>=20
> Therefore, move the halting of the device CPU to the very end of the rese=
t
> process, just before writing to the registers to initiate the reset. In
> addition, the driver now needs to send a message to the device F/W to
> disable it from sending interrupts to the host machine because during hal=
t
> engines function the driver disables the MSI/MSI-X interrupts.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
