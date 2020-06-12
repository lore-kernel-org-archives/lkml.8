Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E703DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C28207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="umMyvuUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:33:02 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com ([40.107.4.130]:15114
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbgFLIdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:33:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9jZXJnVGlyjQ1eJaflt+aHxbAF56JqDoI7j0VNBWYEu+4WyHJ/f+EddKv07a+yBpozQKuYpzeShhtE0mplefYH1xAgkxYPq5vRELgI4bqSrbCSg3QfjojpvlIQPFa1W92udN4vum/xze0FbzWDDwTuMlRwuxomxO1mVGfPWrX5VKdmdMG5vNNA42DEMOxBd3QPlL5Z596Cb6QQo4uee9rlQ2rmaNcBPZQxljWJFqG/C5sBo3BGuaVvarWQ1VmQidbtPWNXJe0O3ZfplyVgtURCefCHpvz2cHEj1QetnyZFGSVDNuBD9dsUSK5y8zd+SMv3a85fYiCt64eTFXBJ3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5jj+vXUzlcQkJqOxckoGrvDNGMTGeCtpH/i0mUjoNQ=;
 b=aaVWk3yfK4AXpmFiAdtTJKYLBbrxdTQaVozykioqw1oh5nCxRi0Ki174ndZaw2ZQe6NR5/+pI5JS8JJZhBi3/cxRxvhYZU4kukd5+1LzutvLBBxeBMW8VPLGUhiANKQYFx14WAjk0BGnYlzlCRXb1yRtpZH6AfkRxOhCjY2P6l3t6m76v5PxwniQ83AC3BEPJGNp9oidinDHY7e1qjeoo6DzmC4yENWJ1e+PUXo9d9HoDpP+3oZ6cw6SPChx2C7OBRq1ktw8RHhJvGr5+rTjlW8v7mdwe624XlLlHkWu/p93wKYO1mOx3ha0GeCNlOZfmJ9tJcJ9Pw5eW6rvsLVLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5jj+vXUzlcQkJqOxckoGrvDNGMTGeCtpH/i0mUjoNQ=;
 b=umMyvuUCnfLlg99s7TmR8Z3eZ1auEB5UGYgTDUCKyXZ9jZisemeRc+77cAUBOiawvvkfVzVtHmEDJUzdK9Z5wyTXq0cfs06f6JxSSs5kwkrf4l0wh0Uj7eYeF0K0bqwqxp3ceZktnCyyP7qsHf1iUCNEmse2CXNvB5UKIpOuyPA=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5386.eurprd02.prod.outlook.com (2603:10a6:10:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 08:32:56 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.3088.025; Fri, 12 Jun 2020
 08:32:56 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: increase GAUDI QMAN ARB WDT timeout
Thread-Topic: [PATCH] habanalabs: increase GAUDI QMAN ARB WDT timeout
Thread-Index: AQHWQIKZBIpvatRonk2sYQ2qmaGDzKjUpsWg
Date:   Fri, 12 Jun 2020 08:32:56 +0000
Message-ID: <DB8PR02MB546893BB8105D9B4F9B96F64D2810@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200612062744.29316-1-oded.gabbay@gmail.com>
In-Reply-To: <20200612062744.29316-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.101.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc5995b2-6ede-46e4-39bc-08d80eab351f
x-ms-traffictypediagnostic: DB8PR02MB5386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB53868B6C9BB67E9523746FD1D2810@DB8PR02MB5386.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uy/NKEthNVfJykGfMEkECST9jq4bNZdJu9mVYS/jNTGYvOJ87xBZpLFCBl+oELEt0H9ENmJh3Dbtbs0cjm1huiikDBAFibmI5Uo0GfcRSV4ldyh68TFxjW5zTtfa69HhRYPSQX1tsp3lmFdoCC+9SVLG56zn67xt1c7E5hUU/fvKBGwrx9++EJgZc97ATaKj4XUvS9vSnxt8A8tBli9vjZqN5zlmSNmdW2W/ptZao4m1eo/dq+QSe4ohHZBMrYvmAwAn78kAllZqIxzSWBunIAICbUthNyoKaS2isCmBSF+bTVblZAURCqaTAZS0ZAAmB/L/qhUDV4gG2HYMLyL9Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(346002)(376002)(396003)(366004)(71200400001)(478600001)(76116006)(66476007)(66446008)(33656002)(86362001)(64756008)(52536014)(66946007)(66556008)(7696005)(186003)(6506007)(53546011)(26005)(4326008)(5660300002)(8676002)(316002)(8936002)(558084003)(9686003)(2906002)(55016002)(6636002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g4eErcxp5WOb90xjR6o8xVaMgbR6vEgs26zWWVFofKUEDJEKnssy/o0Pq0OGV2yFtgBqM5KbRL/CapbSGyZr9z0h2CuZ/7fRrBpwkIsXNeNr9uomz6ILmJy3g/Lp2+tHN06RjRS13Z5V552H5kikrF44RLy11OhOVnYc+GLtwxB3Y4iSw2fzHAH5GSNoCb6ab57+b1DSk0IFRUdzlJNCy1C6IKMXzvYbnN9thNOf/u46ED0VmncnMD/Yo66HGsK+2JsnAOb8nXonotKkejF6PmMJ9R3PwCXOib+FrKVRW565l/lIhTaN/c6mCwNiIGZZ/A7On+mx/UewJlW2IzzvK+uhClsSv8ZdSt6Yyzv+pG2M+Lz5p6dVHqeHvvEEhyu9O9uw6M+j8hrj9FwzWLpHVQC7VHRalWvEvDHkKueMD80rjPZGx5dwFZ7r1ly0AYqGrxizFA2kNRnAnL4rFkq9HhIbLoJI5O6Pr9o/2MJLeiw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5995b2-6ede-46e4-39bc-08d80eab351f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 08:32:56.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4QaIY474/NQVj2j/w1/8hx1prqCL0Yf/72UwjNkRP4sEx8jQHDFDDZ/KUNfy3AQIYyhVeV3rlWpBuBeQzywXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 9:28 AM, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The current timeout is too low for some of the workloads and we see false
> errors as a result.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
