Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6417F20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="g92R/ij1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEUHlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:41:36 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com ([40.107.8.117]:47750
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728245AbgEUHlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik10gQXZlK2Kl/+iGhdaNXLpVmp5o7u64hu/Wtvd9Q9/z2h1qj2PM2cD9jW0grp5pKen6/2v4x2BFfxaeOgaBcXQT7LCXVWURR+UL0rheufQFaHggsHcrSspAGO8aoERNGKNv0CKPO50qC0iAr6Nie5G+y2On0sklmh9FVWe+lrVHHbl4A0R7ltUkrfSbDkw+l2t6BV2QMHJCUlXCbOt8FZvx7rCFt9LJTsd4TxqArDPGHXJd2B+7QgeAkmrbOoXlPNpE/RLAfpPjVmg3wXyne/gPfv3wuO5I8R5m0lCbQcP8mqFFJX0ExlgnSA/3bhepFm4jX0JQ7J36drlixm09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XFeDihof+XS7K0DbiBSUhOqJtF0gkCgfKKBkDH2QZM=;
 b=BAfwoHGxGM1EQ3/3cCTIvLnUjzxXRNFi2OAKp2qmduKBIZfrlk5NzicLXv/qNvztNELGGCC4urh+6LEJJLDFJC0fohZNABFdceMcqa8Jk5iCFqZkZIxJqESyN9diVN+5dyUDZCihQyVSbLmUTPpqC6ZKUnRZ+p8fsJwI42+scUV1O1V3nh2eYFMjDKAs3qDeffm3nNwc0tw+c/i/sCqCADLU+J1QMBBA/F0I9zF0KsMy54acSMZUQEKuzUObe5rJokOP8dh8OIzkoQEXfXKs+20AeSnDHchH3JHyT/tn/sH+FmALmQeTToDYjfYraDl9eRX0NST1UwlQdDbuZaNKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XFeDihof+XS7K0DbiBSUhOqJtF0gkCgfKKBkDH2QZM=;
 b=g92R/ij1Q8t9+QqkN2NG4/DZImnEsg+wS0znoy8cROSV9rUmGd+K5Pwsa54VPrhSxzZIqkfdTttKt/Q0PjkEZhdMQhVooCeOkUULaVkUzHBKb+4dxn6oX/x3RY1Ov9Gnt49cOjoI1p2puzsy5TWvZghsAHuwGuDHX7XVHgVEz8o=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5899.eurprd02.prod.outlook.com (2603:10a6:10:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 07:41:32 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 07:41:32 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 3/4] habanalabs: GAUDI does not support soft-reset
Thread-Topic: [PATCH 3/4] habanalabs: GAUDI does not support soft-reset
Thread-Index: AQHWLz3E0Z1FW3JAIkCMzYhIUxHdzKiyJ4bA
Date:   Thu, 21 May 2020 07:41:32 +0000
Message-ID: <DB8PR02MB5468B508D08C3DFCCF60A969D2B70@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200521070205.26673-1-oded.gabbay@gmail.com>
 <20200521070205.26673-3-oded.gabbay@gmail.com>
In-Reply-To: <20200521070205.26673-3-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [85.250.181.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1dcbf1c-778d-4271-2844-08d7fd5a61a8
x-ms-traffictypediagnostic: DB8PR02MB5899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB589911E1097A983C77CA4297D2B70@DB8PR02MB5899.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/Ql06IO7P3q6Jdgr8yM5kfvaFtgFS/NTchaTqjgaw7UtwbrUK7Z2yLnQv6I3htIBG6m6RuGBgBt91/Ik1z5gwpeWFP+zMDAuFC2qFSN7ER8pvQ9EbhHL/58fV/dB5zf/TuAcc6/E77QyIPQEtFJoqimIjqaCk3DtLPTPQHr/PinSQti7sbT5bOcFADkipp96ZPdpne5TiFLm/8j0KoLreaBgJNMY4LA26j3cF1ctJcCCd+ij7ccXt63Y8K7sPbLOX5Ii/3OfscJ0imxVBxpxPyhde+R3AtgK/ffQyWCfCZW0H9W9ZC7xYwHgzOuDzb99EsZpgOtuh2LTBL9CYSpmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(396003)(376002)(346002)(366004)(5660300002)(86362001)(52536014)(2906002)(71200400001)(33656002)(478600001)(8936002)(6506007)(26005)(66946007)(8676002)(53546011)(186003)(4744005)(76116006)(66556008)(4326008)(7696005)(110136005)(66476007)(9686003)(55016002)(316002)(64756008)(66446008)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ToR8h6PkS1U3OFU5fn7EdGwDj77GRvRG8l1ybMK/sFK4aAMIxvfa6Zh1mYIsl3yDQjraDNiIr5QCdF52IEB3VRfUDYvCnbdsNnq3f43+NOWcFnG6hOv/Q661RHMx1bHu3tg4bQB7nbCB7emXiAqai6NOCHaZweZAtjyBeaT2e5OiPvV9MqqCuC8c6YZ+1kxuXouvGRBBnszCH5UtpXZ/u1Zgy3fFALijZyKNyxjSlNrtsiWKTJb7T5d6tpbeOYkG9MbBkmceouan2WxcpDr75EAF1L/lpVdjhx+234iWATQzssWPhRqbiKSjq/nLuXQu97B3k4RZsxrFTKEweNutvojZGhEt5VT4bCoZRaagUmq+sf4YfaRarT/jCW7Xxt3eWHEmuYfC6wqsOtOJKhTYRy76lkTVrniBcAOv2zs4vgevNfv0VhrQVn6GiEjUkmztBCsMPB8ea1dOh8E5ncQ3YuqlVUTK1DmR5J/5h59gLLg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dcbf1c-778d-4271-2844-08d7fd5a61a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 07:41:32.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLjvXQA/LubdywXslyotEo1554ICsNU0Pkq+KhmSyYc5v/NFNC+o/uSjyiY0WjUgsn/Di7WIa7GnTj/5/c9ScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:02, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> GAUDI does not support soft-reset as it leaves the NIC ports in an awkwar=
d
> state, where their QMANs were reset but the NIC itself is still working.
>=20
> In addition, there is not much sense in doing soft-reset when training is
> done on multiple GAUDIs.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

