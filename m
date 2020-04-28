Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA6F206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="SiZ3DJZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD1FoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:44:21 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com ([40.107.22.121]:15424
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgD1FoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNaay1RoOpu5uuXH8ps+6aYHuI3gdTric0FXCz3W3tZFMSkTd4JPIYp61vBZ3bfJbgPc77HNP8dvv3D/XoWjutG7J6KFcYqluvdnN/IwKGsCevtLti12gys/WeNwrOyj6dp7wL4NvhrUh25Cxx+h9zTsibjvF+yi73VQlOCLNt79iOh3EL4ZyLIkejhOisuZELQ12xTtqcl37ni5ylJdb7CTipRI8vRbziu4xoZ+p1BwIajQBdCRmHEaUZ5B1OYQZ5fvSElUcUn7lac2XOxHnRL2CD/65IhHuXnmFIeNc+50+o2qZ06eFpA9b9CsSvlh9cXlC5oofyVaBjLQxwM1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haPVHYtfLIZd+aIo1Vg6t05v+eFKCNDkqYRAP7HpXAg=;
 b=d3HFnbjykCssesWMhZp06Ed0dntm3tCPDIBLuELIP1Nwcv71m0yY81X0UYjNL3bzHiLRpRMbpqP1WFo6Ta2LMJ26G7w1DCzkoEWGDruPGmGePreREqku2QQfeGPeTBQEcQ9acuwKcpovKgwnfwtlZ4/uFQtg3W+42IwrLZ7FbfHSJsjocimkfQXDwei5G/9oUqcIxwP71hSnjUvPIwdgTs6+gNv5wxE/9tnYdRF3qmj2pa/gYGqkRm2eMc6i4Rci+rV09F6GqJbrYH1IeiW2TSVF+C5PhSx2U/RqG5Rovj1ohqEHt0tTD7m5RZJVXLn4EM/E8PVx8nl/SC6vXTGTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haPVHYtfLIZd+aIo1Vg6t05v+eFKCNDkqYRAP7HpXAg=;
 b=SiZ3DJZCHcqK1v6dUdtjCxtcyEpNAq0f3VktO2YxJZk0+sXGygErRbvUN/0yjKv8HHjrW8SjUvBPx6CM1LwjNgLBqpk0SiMc/IARfblZCu09s2LOWQIcJCK1qR+JXtsFyt5Q5hOSvgGrSAMHCVA3ih9ur3yV6hImjby7J1cf9aI=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5530.eurprd02.prod.outlook.com (2603:10a6:10:ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 05:44:17 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 05:44:17 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/2] habanalabs: update F/W register map
Thread-Topic: [PATCH 2/2] habanalabs: update F/W register map
Thread-Index: AQHWHOQcl/w7TgFFKkuzUI6WrFjad6iOBdXg
Date:   Tue, 28 Apr 2020 05:44:16 +0000
Message-ID: <DB8PR02MB54686EF2DB22033260E5F6E2D2AC0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200427234047.13249-1-oded.gabbay@gmail.com>
 <20200427234047.13249-2-oded.gabbay@gmail.com>
In-Reply-To: <20200427234047.13249-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [93.172.117.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a43d0c-090d-4855-5e7c-08d7eb3730ea
x-ms-traffictypediagnostic: DB8PR02MB5530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5530933D52FF6BA26F0A52B6D2AC0@DB8PR02MB5530.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39850400004)(346002)(366004)(396003)(52536014)(7696005)(66946007)(76116006)(6506007)(53546011)(71200400001)(558084003)(5660300002)(6636002)(316002)(66446008)(64756008)(66556008)(66476007)(110136005)(26005)(186003)(15650500001)(33656002)(4326008)(2906002)(86362001)(478600001)(9686003)(8676002)(8936002)(81156014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSINxHNf9TYDjtFdBS3OawcZJVPbUCQgIBK9gQ/XsDFg1XtiNF8yI64rxsOvI7FKclxpmK0SRcwK2a+lCd44JA3gxWcffX6herJ+F3zslevAS3CAG8EhmRbZ/8Qvg4GzgeCgGOpPbqJINDVZgzggtMpBGhK89r7eeYjPQdPIS9XtRGd+Xudzd927A67TsrqvDuGwxcPOcSOfE8sLs34X32NP1tuoUPe4DnfrqwURaQWHjpeWrI0vCh4p/yvkCXN5BYKSeg2cgWxj1vb8sBRSqsk874Kr3aSU9oaN+qulZHPxRt427cL8WDeZOjq7lff5WqNINaQoFFdJXlsWim/xhN7mBNfTbHYV1WUo/Xa1w+OeIHeUDO6sGs8UJ97voRGDTI8dKtwvxgJqDFvmRRMzFdd8KdpyC6I0m00UQLZk8lv+vgZ3LGm5sYYbow0aqqO5
x-ms-exchange-antispam-messagedata: /gzeJdt5Burb/oVXHoXBwZWRxXHNlkVSe6ph5ALb7BQX8eOXwFeAE/QZG7MFSvqiJWdxqUbLFTt+ysxYGjc6oBy84XYeX/kdA30V3Ptyilvhhv6Y7+JsZ/eQYQBXN3yHHddEGuFCDj4iAdeR7cW96BGMBNwMvOcAXWIqqaG48ez80Wwm6DaRk5rMo+rfQtNRpqs1p/XvPBN91SLpkcotVV9KvSOSk3MuignShRaUqpVDmbksNcZGQWLMXw7OfRMLMUnlzS1GM5fwjLfZPSWlutTlaZ+6kxOQc5kNaTlMM4+GZtf/2vvvm0QIeLvXqSIBfVhhz0VaAUOAdBIwVdS6+Ylq4O6d+MYPdCJs3AtbTXJFwoH1TRPKXLS+t2GeUeKUZgJscq56bB0CQHEpKkPMjQXHDMss6ehify07x8spvD49JBwLR4Kg/nGV9KY2OFUUnS4crFzzkeHPRWMWdzB/xJvQnjMsJEJr/xWPqIaAaVF5Kcbfej8Ny2NeowVe6iwnNUVfoR/C9TkVJQGBcfdbRtiAx9TqpS2W6shzT4PEXBGNIiFPTaFjDOJNPMAsjTe2ot76HDTRLmJbGkkqp9Hd7YiGcPpBYHCNU3M+M0nuqBw7Ar6FzLEtgO9+573kgaLBIHiUxcPHKSAiMuYn4Dje6dhr9zvOqVxwDvQTOtPYL1WVGDj5NNo6gtxkrTmnnchCLEJ9Oe8H+UsOQOwRkkXgFUlXxAprxyNIG59lqiUBBpucGPima3dGhMDlHcpYP5vWblMdiZGQqJlo+ic5OUYGQofo4DoNVHp9q+XXAE/Zom8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a43d0c-090d-4855-5e7c-08d7eb3730ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 05:44:17.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ox9LINCphHo/Aow99qz8UUI+pzzNs8zWNk8dYJNQn+D++ONnPtpyLIj3nuOVaRMyfvfuNop0lH0i5ayHpfiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 2:41 AM, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Update the mapping to the latest one used by the Firmware. No impact on
> the driver in this update.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
