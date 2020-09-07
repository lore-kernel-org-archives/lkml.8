Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A71AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F2E2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="oNpsNk5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgIGPXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:23:00 -0400
Received: from mail-am6eur05on2099.outbound.protection.outlook.com ([40.107.22.99]:27521
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730070AbgIGPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbSZYDucA5jA54Oq2d0BkzkyqPPsTW/0j6pF9QGidXCrvpyypFfzpxtnxhKLAiRZb8a3Rt9jQdsnjGG8LIRirUeVnLubSLeWVy5IfvO2/501z2YJ5T+O7mymWY72irM5QywT4+yn43K9eRArOj/OIaBS3r0xUU/oULE05cAY6l+jmPdtVE0d1mYreUaxnMHm2ImLY85BAEZRL0WkWrRP3or0OBKREsYd63GyExmHZiiCzAYxfYy/SqwcINuPsCCCYk1/sujnsX2IYqd7EbDeR3yMmXy1yhBeJjYO50rutpdVcyMApw+C8u6ypssaQGd8saHnTowXSBpnnHKFatU7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKbAOcf0S4+Jb9bYEtxTtEOgkSOjxwy+x/YQ6O8+/UM=;
 b=l/OUKODrcpNAqL+QTUzOkBK3EmbzOPSeIT5OGx535LYKcZuPPToSYaOVEUrTDILONuFv9GZ3HyEVzcWDgq6aKdNlNQEuT/tES3y2N3Q+lzU6y4LC0YxfB/T2qXPVlT78z+9lN35g8cmW2BTg21n3jnjh4jcWqKVq5kFzUq8Zs6M1OJFGjZYhXWdWqyaHXtEp0NmbLFv6LcRQw7nL5T68Zn7yuE2xYVNywmU+sp3Lq8qGIWY+dD/IKCw+AlOClRJZv/stfQ7y+l3pic3fgkW4eCrHpBfu27OhSwABwyJcsLGEylKv6yR1N6LxvKx5kb4JeNggkJRZ3RyNdapwX1C0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKbAOcf0S4+Jb9bYEtxTtEOgkSOjxwy+x/YQ6O8+/UM=;
 b=oNpsNk5/aHYo/HdFkWYab254QqyJHmzYNOeanPFHR30HEbeQDJPqpIxb9ir8Q1/hqifZYj/PZr1vaUrVBrF02zFL3t+6S4QZxKaxcS03aVU6b2uOB9G+FUvJU04sOyFkL/2zWGuebS1UNOg9za1oYhzhYpUS8220GRxr58XNLmM=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB6PR0201MB2389.eurprd02.prod.outlook.com (2603:10a6:4:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 15:20:55 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::95e1:b3c:ddde:4c32%4]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 15:20:55 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 6/6] habanalabs: check flag before reset because of f/w
 event
Thread-Topic: [PATCH 6/6] habanalabs: check flag before reset because of f/w
 event
Thread-Index: AQHWguu65u1yRXRl/061mkUfYix4q6ldTuSw
Date:   Mon, 7 Sep 2020 15:20:55 +0000
Message-ID: <DB8PR02MB5468E5717B7EA94B19A80383D2280@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
 <20200904184623.13478-6-oded.gabbay@gmail.com>
In-Reply-To: <20200904184623.13478-6-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6176fd0-c57b-48b3-c87b-08d853419d79
x-ms-traffictypediagnostic: DB6PR0201MB2389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0201MB238955248BB81CE55F738353D2280@DB6PR0201MB2389.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlKEXPiK+UOesKEIKFy3feBS48XLAflzv43/u4DNZqEXdbWUiduZ9H8iu0OTrqbMFXwBkhHXAHpM7XA2Uq+A5CVSInqY+95QQrLikdBn4quz7T6nORzW6cTTXz0kvUZSPX0YXUUY7E+QGPD3/4kecbxyWZx9ZOb9lUlnNExGeRbZKn/bHeivQFLLWuPcARhQlYVI90GrnenLIxvVnri8nYkv6vLOulWTvO4CjxFiIEaGPqjw3aImkECSl139TtRKLdv3PId5zjR9FGEN2Bc3K5QZX511uc3OGfvx6bICwyVUwS1KhY8XL2XCw8aGRKL7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39850400004)(346002)(396003)(186003)(86362001)(558084003)(5660300002)(26005)(66476007)(66556008)(53546011)(110136005)(6506007)(478600001)(33656002)(52536014)(2906002)(8676002)(66946007)(8936002)(7696005)(316002)(64756008)(9686003)(71200400001)(55016002)(76116006)(6636002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2XQkdVQZFFDGUIbA/+cbiPI2yYKkpXTzHBhzxqzhNcVxelu4N7/5bjWX2nWm8fxWinKvy+1weZtXeNWjwrQMdmxPgDwfcYFySWr5FcccqPdi/PMCxU+iRAN32S9MDXlm/CdZXdhpyMgxTFPjZe/rHOJcORsdGPTj/4mePBq8XlKmO03+qWD5pZOSSO8c+I33JJjg8lydTI9f2i2ocWl+HfC9zu0DWKe/lPxDKWpoQLMBbOKurNoxH6TC/COH4ooqHQqJvMiho2gfQPddx6naXQjJsxNejVaPgtb1Bvu6k3avrcrzPAynvFgR7r3ppvn8Nc+znQtoI1OkE0d6ZdUGjuQoCoxD1/7Q/jlsUbDJWTr1xTI95B7V3RAv/x27r7jfFsVFB9qhW6LJbyqX1CzdBJ54GyRr7MximBNpHJ4QlRv0ZUzvHKzlmeYx4sQ7WaZ/SSeuVpSXYSISUKikpWjxRzrd6N1EeBJKlF/h5uM4It1WXc5AazPl2iYCeOxNyrgug+tomcrNobtAkmG3IYGMcP9KkPaY7I2B2Z+brHvQ3TfMRWy7E/bHBwlwBzovfscdoDsjG33aQM4nQebEsad6sO2WdEkij54g5QP53aKhlFPDd2rIU+GSZ8ObcjSkX301NRgk3Tmui9g5GtwqjhR2pA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6176fd0-c57b-48b3-c87b-08d853419d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 15:20:55.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEtiURbglXCavOV0ZhaH9USlqzLVvV8rFfTnO/90aefjsnS24Y7qSz0r1Tq+kFnDKfCGYyVKJyq1v5NwI5v3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 21:46 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> For consistency with GAUDI code, add check of the relevant flag in the
> device structure before resetting the GOYA device in case of firmware
> event.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

This patch-set is:
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
