Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656FE2073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="XUnXnqDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgGEN3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:29:45 -0400
Received: from mail-eopbgr20122.outbound.protection.outlook.com ([40.107.2.122]:55870
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbgGEN3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D01iENKbbEZ2j1JJizZM56VEKEM1dWbKId134ywovhuiONEHzc15Hsw4bV1Bsr8NJCI+EGC8BGQMeI6POfr6Iw4pSFXeo/8q8lr/I8Pxg4YStuKKfXaKAYBwML+QeT8Gm/WfMT8DGF6BJz5iwZ3XfC28LSA1cbtCRpoKihScG8r84FAjJb8hAJ5JvyHLWMNO66EHaCZnMQFeGzfRW5BZDNpQ8zYzqJU63I9fnk31Zav5UJZVKXRyxFZCbn5/abbmmjO8DcxCtHAr+Hf03509xKO/6AxMxKH0pGmnj9ok551QarPODOygQYXpA6/gtbheOTpan7vZcBv19k2/fXIP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmcZWVA4vKI3RgOGRMcmBS+u6QnmdRGdWmo2zJJm8Io=;
 b=as4Io0rDTXe9TMrIuNC12GpmM/O/RgTyPqA3TQymwPpQI11eicsIVfUH90kGDHeyDw/1bgaN5Q/jf/cm6tySWWw/UqzUWO8LB5QIGBVRvv/ZIyXuYj4wVFPyeSoYu2YrO3a05qQ5/+t/RvelCfN7X492mPeq9gWkOltbdLWr4eHaNv2NpzJJnajvo/1PI3fb7d6tpU5TcfLtzm7oSoAoy1PcpNAaBHiBl149ZT6qqdrSx0tPgswEjGH+mXfp4ODIdwySKAMp7c45d0q2/oIBwxA61uip40hav3XCwimc95/VqLExHtEU8us+vEsxIB0W/olL5oc5vVko6LE+IcSFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmcZWVA4vKI3RgOGRMcmBS+u6QnmdRGdWmo2zJJm8Io=;
 b=XUnXnqDJ7ljjdhfqvMPVcwy24YApjk4tzcLRPnQGtcKMprlTGb6PZbdEZPwBQYUosXQd+4CUpEjTUoLpg7KTv0+OT7/4uxChh5llTZON+83ODo/9bVKt4b3wIi5Wryx9mx4Ny6jj2GAjCV8ikEhktfUZ4n4+w9PHChs/tzU1kPQ=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5578.eurprd02.prod.outlook.com (2603:10a6:10:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Sun, 5 Jul
 2020 13:29:40 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 13:29:40 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 2/9] habanalabs: rephrase error messages
Thread-Topic: [PATCH 2/9] habanalabs: rephrase error messages
Thread-Index: AQHWUs36dSSEUvVBu0WpqqdzdX6hdKj4+mWQ
Date:   Sun, 5 Jul 2020 13:29:40 +0000
Message-ID: <DB8PR02MB54685B3C381C9740DA7AB593D2680@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
 <20200705131245.9368-2-oded.gabbay@gmail.com>
In-Reply-To: <20200705131245.9368-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [93.172.67.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a8edbb-573b-4196-e174-08d820e7789f
x-ms-traffictypediagnostic: DB8PR02MB5578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5578A7BF43133AAEEDCCF38ED2680@DB8PR02MB5578.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFr2S0gcXL+qIiVLWVQCxkFI38hVnpw/9c1UvE4rozaQgSlVu24f3RJfmbhzpVw8arQfjnKSnEAoGGxSb/DjSTUPYq3WEiyYXkSs3yHKBQXCrq+GC4V/kPUawwdD5CNvp4HzHawQlmOHJADhXeWUn3Y3Sy5mbxf450g7Y/ESibYjoP5XjOYsmXYrMlmyIQYNlmxwAJpYiQusY3WaoXU1giu83vBxLZciJohMdlvYEqjhrfMcFaCx7b6vZfQBSHK6HSocLsymFH6PtHmo7wkswBsvoZ56NBX3NX35BFWnEzmxlBUxyX564oM1u+2G6D4p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(136003)(346002)(39850400004)(71200400001)(83380400001)(6636002)(316002)(76116006)(64756008)(66446008)(66556008)(66476007)(110136005)(66946007)(9686003)(478600001)(55016002)(8676002)(7696005)(33656002)(5660300002)(4744005)(2906002)(15650500001)(52536014)(186003)(8936002)(53546011)(6506007)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kX1/DKnJdIKnF8iaH98hYlRMcBsIUmZ0+u+VTqj/1x5rOBurCHKKSuhzppRSQiat88C+HyhyDtlLizutBhHaHGv4/IjjCtzv18354XDPku1dck5XnG9h2kFi0NRK7FWXGIOtULWfH4+5Z1ILxTobHvu848d5iKLE5CZF7q63x/IVsx5zdAQkGTCHJ8gIr2SBvJLUAV9HDzNyDVfEK1fA4RBn2TjonTL9EV5dY6UdLI6RnVxwQO/TGnCw7ClxxIxG02eKmYTMN/kg/Hej5y/Bc9M+DKRmI1gjQsyQGQDvCqYvGOKlqt1JiSciCDK5G2sHmFVyKvjhpYecC5JbDexos+vHeDUsa6gg8O9whAm4WMFsNTXvTjLxy7kihgn03dAzeiT3FEwezKCrks2ib4vszpgV3LYUfMhVK8NwOLZSW2NqZdITnVhktwgwlf4wi3rjMghld6s3RFTpP6SfVp7JssV7+jpqJshNNshqLY899u4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a8edbb-573b-4196-e174-08d820e7789f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 13:29:40.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/w+PdeE1DcBu2OwVwKqQqBIuqLkfpkSNqPcisLY7LS5H91jMb7JrtrzimmVK05kpvUV5VVnZtHMoKaLgpiYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 5, 2020 at 16:13 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> rephrase some error/warning/notice messages to make them more
> accessible to
> ordinary users.
>=20
> There is no need to print context ASID as the driver currently doesn't
> support multiple contexts.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
