Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F291620CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="hKeSGJSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCaSaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:30:00 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:54754
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgCaSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:30:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP9hgQ0n6q/Piug+Hc6rYPnJm1L/YKoomFhv67H4WkretS6Tt/z60UpO4HM+4OgkU6+dU1qs+/UIFglv+45M75zR4Qq1MblkaD825p20sUuAlu7CLYUYHiSX3j176F94DMoK5Ve2mmTEfr4VSqaPKqOCi2ZPyLtQNf5qsbHNGOBIzTeeEAd/FBoNZI6oAeBbSTGbULrzf+Jf4VtFRRBSmM5f+q3dEEn0DSCsdmwQvJSmf/DltoVIWtp15N+3e2GvtisZ+RBQh+Gnji+erVebb1gyJjBQbuOpwu58guOsvsAWnhVMdjBaXKwE0Zv8us99hexqnuTFYPBTcAXXBhq90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zypOxOoTMui5lrFS3iRqNtKntWf53Eti2gC0ZZtEyOI=;
 b=hAs0lICWyanBxnyUkS4Wa+3FMj9qH2j9dwHsx0BAXfIk26kI3gymiVhlpM7/9QjLhh/eUDJgD9akowacs3BlzEcnSb44abs2KjXh6bB0m7CxGako5VtdA+FuVBzIR7Ty7Gg5PBOoczlyGlWcq6DqUJr2P9Gt0AXnwXCSWmzgBuxNmYv4SlvmWJ+pfqhLayuST7An+k/zDpZnPP5PoJyQrGEESACFY3eDdCUB2EsAweGjaO2ilHfezHWsjAlNcj/44oYMKZ42wI3S7mw+GkihmCnKdD4pkaKWo0Jdc2IM/9CoIiT8lqAY+IfIMVep1cBDIdUeBcBxBk1Ou3F2wEaOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zypOxOoTMui5lrFS3iRqNtKntWf53Eti2gC0ZZtEyOI=;
 b=hKeSGJSCovXKn8RPcpvAA/J1lsplHKog8NEXPL16VTa22BgRH+og9B6nbjazWR9heRLJzRg4xcXPMvaYUKb7DpLSz+ZmyQuLldf3q+Ps3B5huv3HzSZ5YlbuIcEE+S/Vl44ASXu+xGdVdz6qGNE+rxdhFC88F9PiVtlIEyeDKVQ=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (10.255.19.214) by
 DB8PR02MB5931.eurprd02.prod.outlook.com (52.133.242.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Tue, 31 Mar 2020 18:29:57 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::2989:ba7f:c6b3:c93d%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 18:29:57 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/2] habanalabs: handle barriers in DMA QMAN streams
Thread-Topic: [PATCH 2/2] habanalabs: handle barriers in DMA QMAN streams
Thread-Index: AQHWB2yChtAdFxLVi0ux2FuE15RN/ahjBXjw
Date:   Tue, 31 Mar 2020 18:29:57 +0000
Message-ID: <DB8PR02MB5468F96C4CDD58D2A3676E3ED2C80@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200331145600.768-1-oded.gabbay@gmail.com>
 <20200331145600.768-2-oded.gabbay@gmail.com>
In-Reply-To: <20200331145600.768-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [89.138.173.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 412b9c03-aa32-449f-f511-08d7d5a183f5
x-ms-traffictypediagnostic: DB8PR02MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB5931BE46D2EC18A75A68F1CAD2C80@DB8PR02MB5931.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(76116006)(66476007)(9686003)(186003)(4744005)(55016002)(110136005)(498600001)(4326008)(66946007)(8936002)(7696005)(81166006)(66446008)(8676002)(52536014)(26005)(6506007)(53546011)(86362001)(6636002)(5660300002)(33656002)(2906002)(71200400001)(66556008)(64756008)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GymZqKc1B51aDi7ZbISJ3M4ny6SwQF0k+tqB7jLUVdIYNIQniyiQhxDggK/4wlCS6r6/qgOYKxVug3+z+3F5tmawqbBPFTo8LiOrMj9tPZwi3qLMhfrUwFYpnHcKQOPc0qrNLdEL+pOJU4qGH2xTfATZdEt4gI96ptmgP90ZlYq1gAK2Gfk00y8pCqWqaRM2THQ3PbXe9J5C/XM4R1L8wVO+G0eClHcTJMZoCMf6fQI335xx4OAH5GZlLCDxLsoRhejOIJFdESYdORiQsv8qzhoj8VpJzOKpg9LUpJ8/dysRrHON2MWpZARdrI9rZzoQPfnoEsOTg1taW3n+7akkYfMNEMG9+DDxUcZ+Acg0z39Q9V20Cku8Ft6GD9ac1Na+qsaY/3HNiL1BwzSwGlaGhFJQHk2bR/+MW/VV8QHqKtDJ6Ecc9sXan2OlV3GbEwZZ
x-ms-exchange-antispam-messagedata: gLdIbyJXQMAqKXZH24ittLRwgX2C9SkW4aGw85kWEpxN/d2pJ1578b3kHMmZvY2TfwVmMBA+S/dzlLThVfwe2E4t4MEDCBipGL/bJWqteJJXz5Ciwb55hSFHmuMQDhxBjbUVJhkGEL/ac4cYTCCN2g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 412b9c03-aa32-449f-f511-08d7d5a183f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 18:29:57.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2ZnK/bG6/gUBQXj3J8sx8DVzPlluhP/iyg4akyDQ94XGV/1I64+9jslk3O+4vcKztQABRaZEZPjUP65XxMXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2020 at 17:56, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> When we have DMA QMAN with multiple streams, we need to know
> whether the
> command buffer contains at least one DMA packet in order to configure the
> barriers correctly when adding the 2xMSG_PROT at the end of the JOB. If
> there is no DMA packet, then there is no need to put engine barrier. This
> is relevant only for GAUDI as GOYA doesn't have streams so the engine can=
't
> be busy by another stream.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
