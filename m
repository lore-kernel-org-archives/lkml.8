Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B0A2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="N5tXNvyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgHPPZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:25:02 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbgHPPYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXTIwkDHiqSqZTQznv4aQ0j02FtOHrBmiEDvGEUM8+UcztSpo6GxPUOW5CtypaFHQxWEqtqvWJ7/zECXUDf/LvDaAp0QNNT+cisPp3/m4Hbp4M84iBVpk7FOz+Ub7XbccDJVKXQv6+lRU9vvIaNIpjebustNwr48yVXDxn2eS8bMzaMI0ybrvNcE7oALBnu41XlJBIqJk+2GpYshnnyX8dwZod9be9RHmAKVWMVu7vYqR3YwwCXU+8CAP0KezfnU0so4aqtZbtB9xxhl3w6WfjkkoPVy6COOgE0g+vDsAN9FLBFaNIanErsvV0HKQYLc8HlsUqXaqGlRBSpy8YjwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk8a0K393GycXjqyoLYylVvfDlcUuOxdkOiQ5U3ov78=;
 b=Rw4g4dWqBV8fvguLKpYN96iQUG29WeHDxb3fa5cQngWUzxQjLWLXntlwd33+Lz9hA5fVkIWlJnbbRUPyUmSlWjZlTBiF8OAiVoRzQvaDCAOaCAUVvS8FGggePknjp63bm+QRTEVjGkWuqoHhRr4TXen1RoX1jijXrzo7gv85+ZkU7dD30hCJxPgqIOw8O3JIxOlY2dYf21KcS8EgAdElvlwUEUUysLABd5t0yXaWV9+zNDaD2l1kM4NhWTvJYwKvZjdqQdBHxUEC8/gznxqJOZt3zC5lT4JqepeXla/eVeVJM4vqgU5w1mee5yzDyz2BN5v1uLif+AI+FsIpGr++Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk8a0K393GycXjqyoLYylVvfDlcUuOxdkOiQ5U3ov78=;
 b=N5tXNvyyYDs/kFt/BOGoHcqdsfMrmGK7SC80jqqSnVqDJBIV/UjKIqm2chyTqBVLWYybIDKgjv99A7RT1JmOSG02KmDXOCOgdvkbCuCnmrjv1Zls4YA0drjCJXAr7kqKTHrX4UOVF8v5bru5XeNcpdvBqNbIpriyJ2f/8mB3vwU=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:30 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:30 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 7/9] habanalabs: check TPC vector pipe is empty
Thread-Topic: [PATCH 7/9] habanalabs: check TPC vector pipe is empty
Thread-Index: AQHWcy3gawgrgyCNy0e7mIIbhuBS96k6umRw
Date:   Sun, 16 Aug 2020 15:24:30 +0000
Message-ID: <DB8PR02MB54684077C775BA3F2A106BCED25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-7-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-7-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11374427-c0fe-4dac-9c6c-08d841f878ca
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB35474678E902CF0CE6239882D25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xe9hhMnw4G2O/eMStfXe1SdDZfABc03Fj0SofufADvMaV/DmJiDLDSuAhBcn8DrSGt0P1/BRu5t8OjQsTc+U/mPZKV0d3GR78QbvsUeYE+QMwLuerbTVH9zCr8naBSyG1Z3Jyc7yvYiscu/+/YiB7zk/VQEKfg0X0CBzOAIRAM5chSeyF/nTFFrTwHB0jgP2LJYfdwSSLUVqOwJK+mu+E9WwNp1v4q9tjH3cT337dCOT6caKfhNq02+pKZjbWLKldyY0GGrbk9P9WZLPc8AmmMxES/MVE/JNAtA0DTiormieX4sSwyBbNeLZ88Zcel4Wbx9WixFwy/1aTZkX48SnoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(7696005)(86362001)(4744005)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3AhOk1mkEyOtnO7m9uSx8LXwK1ZEWF/kyxq9XiBd3KAWfs1204FyWSqf1GiUrr4B2M9CF3VN1doxlDcofYsznsJ/7HUl45UxoLy3rLWMuwbNadiIax6vOfeV25jvojlqxtp3wwvwU8r7flysmZp9NEonKiMnJ+W/yQvQ9bfg6vOyv/84nbPhKC5VuPn934ezPyXhRmzkBOzvbdyLf4x9dSjvu3DoXCBx/4P5/zoXGJmqbyId89qDXf0nmRjQyzzGekNPIAVaH7jIhFTmNLJeYR5uH5LvjOiVrve4eLptwImN7T+ReTwIqerivIEw9MBaEle48+nQ6IsyszxClgGQauzpQjwlRcBPvejpHt+aydN5ITIH8WOtympTHwKKKnCgPTQ1XpHoOmYdgmajYzdCVDyM7rxiyV4HkMWxUjoBjtsfWnY9snrDVfOleg2amhu5sN82tQZzGTpMSawfMTQhEKPf/ksrP7iSmPYZYg3ubyBCpT9ktEkdoSFCoM9inQmEmxYcI2oko+XEbtRAytI9j4nV0mxQUvRFOWeb9+Kfz3nzSOym/FqGJB+yPAkkW4gRxPRDHTB1kHEQVw0IhUmSjynT//Yy1uxnCeMmSfSLaINDf/da2qjgXZxARKsuciXM6uGCE5nRMG1r78tOPX8LLQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11374427-c0fe-4dac-9c6c-08d841f878ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:30.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alt2354VSs+Ey1BtN2fxxkzJjk9Cmp0cyDXqcf3cXVs3e/BI7R1dV3av+jsp4SX2ic1gjZl646q60KCp2UaKGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The driver waits for the TPC vector pipe to be empty before checking if t=
he
> TPC kernel has finished executing, but the code doesn't validate that the
> pipe was indeed empty, it just wait for it without checking the return
> value.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
