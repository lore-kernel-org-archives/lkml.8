Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235DAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4B020735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="BfgL46Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHPPYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:45 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbgHPPYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gsc/SWeemJH6kIJz8rhGT7VwsLFcyFjkJpCFUPWHVRc8KE4JPTD9CJWmtS4pccqJ1A7dsaxlcZOydTWgUvh2jQhRK2k+oH8ydgC9v4g+C+2l4kXaufDuRFntNMf/pDd9oFyY5q//mBVFAo/fILQ8xNfHkEXi83bieMmeh+3xW2ujRt08k5XGIaC3VvPZrq7jsVch9y7ZrQwVoQbnBtl5b2RJU0VDHSKfpED1vpfnibWvJ+N6gs0YtJy+ODxpPmLQ27LfNqhtWSOWLhK0vXBg46W7WEitwwgA/2SI04XNXOVB5YWxMp6Fix1KobJeH6KO24Cb37f4YVtOId0tPM2ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUKOiTwuxuFaHKwMz1EgoFymMwTu67WHj9z4P1TakaA=;
 b=QkQGzi4Ncp5TYe+fLp0WTvTipQDhX7wNyoaJN19D7TiF7XLsOaRNuilvLGRRkQ3CiHbcaeaoLBWKG2L8edhNSmqsgjCjrIY8f1rNFvMhp7TlweIFRbq/ZeGMTQHzu6r+3b4Dj/IwqL5MhrQjxBq9MvNMeCaykwk+3ymc//J6AuK1/1JM6uV1kGJHV6Y5+2v82dO0bKQ+U0W8bcuwmgyLmiIx5Hg4u0MZ3QgJtXk6/Z4Lfwt8j1tNgP9sQ425MMpwyeCbAJvrhMysIE5eReT7ToD5xeVagDEc2/wQXKI6Q+3bVd7oIoY/tlD4aTq64vTaJYpVYBv29jZTqm8l/MsGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUKOiTwuxuFaHKwMz1EgoFymMwTu67WHj9z4P1TakaA=;
 b=BfgL46Ml4KYr48FeL7GagmVEQlQocPscQdKe12Pab1psLP13SI20ogFZ7VYa5plIqFd4YjoJduwtce0sgtWHVeMaSKV+AaoMlaW7iVSy4QktDtQ/pnNh69t24eCSFuHm9dNLPXB0JCuY5qrFrikYw8W2ES7TeOqoDPiOpMJ8Yrg=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:21 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:21 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 3/9] habanalabs: eliminate redundant else condition
Thread-Topic: [PATCH 3/9] habanalabs: eliminate redundant else condition
Thread-Index: AQHWcy3c/MvwArBX0Eu8LRJnZVHGmak6twRQ
Date:   Sun, 16 Aug 2020 15:24:21 +0000
Message-ID: <DB8PR02MB546857DD4BAFBEB847C49EFAD25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-3-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-3-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92714ee0-5f47-46b4-a6ba-08d841f87389
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB354723F14A965514FD109B7ED25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJohcwddCaET/KQ/d6gS1mMvvqg64xGjNimfjIqP2LSKU1Q9giqwdFdBhXdin3cwM7wyVPkJBTy1hCZr2DWXyJecWZF0J44W3X87BWju9+bJBysrKYHYFoH50tOcwb34HYHyHooDds+2fvkQZb/Y9Qo8gbcktCeOIHj0/wAAyx87NsexIuAOcldlGADsAIyJvM/duz7lCsxLQ6nnFU5Zb2Q4wvGMVaSOysWBDa0nmVMd9fVoh91/OOASUeGnRVszZD+uztpk2AiZUls45/+DPCHM48AzXRWglSWZKmZEYwhv6Nv5gBzFiMnRWXu7VZPNbN0kHdmnyAV4+yBwzmZsaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2vi+medc7Yv2MJrK2DU/rOAbMvPWhT4gf3DTqKQlfOAvenQj5AmdpC4vc7E2TbegV7uXxFbVAhaLwS0DRRaNoVVtPPdaUho1dzd4ZOJvWfokE6TdzrSFJkUnTZiBpSMmomTUwqlcz2J63dnQuGnbR/jq01j1HjqbXhfysPpdU9/b7BklhQ3f2yC/N5XGjdGJF1gc7+ALaFL5p44EgIV0lAR4IC9kt6QNpUqRUL1GlTYTPliJaw7RMp2C0s9mNfiOoanAas3AJoctVeY6Y1mBbFru2egP3RcRJHg4LgqHMmeB2q8VaR4G7YJpXYS+C96BKPeOVbZDKe14nODO2mzj1fwPv822MS7lvgU51J3NOUy3mRJvjwtpa5eHmTQRhq2zJlQmQ8TWdgpIVB6n4HgIp4ursbJ0bvfcAXEsyF9jKkFsxHHoFIhB7oNoHCAtRqekrxjFiW0W4MvCaHAVy7s1T5JWjsZwO9EXNf7EGUkW6/roFLwjxIAPcw3c+asJw9Z8IYptMn9VrzvTxuPWuwI/rqzr0NllmKfvCELxUhFjukfSYM2Ol7FPMTJUhocrG6tZ2gdRDt7rpNVmWwuW+mxzOAgn3jny3EKfmTL1CAC/DsZ668bHxC0793QJDChlZLpVO2dLPw1+oQAtzqvwTgsAyg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92714ee0-5f47-46b4-a6ba-08d841f87389
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:21.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/qoh4KhpvI1+ro6LsTNvo8qxCprg4nJSOjcC6/dNG7z6UG4IqgOl3AbjkfbDHq1iG5gnM9s+OOU3bas+gBpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> If both parts of if-else are goto statements, we can remove the else and
> put the else goto statement after the if statement.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
