Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 05:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9868020723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 05:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="L1q8bK4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFGFka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 01:40:30 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com ([40.107.7.120]:28551
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbgFGFka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 01:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs4VU4V4Oge+OQlZD5ucBgIvixvzIm6ykyDfvcvenx7YhRS8kod/qHBjT+NYMmQI0fBxAo8tTCN15IbyaD3L3QhX2yKHx5/jgyLIQckFRRCKD5xmgn/V913pMaW/cov34v7264066yHrvU1s2kw28cerkeIBqcjusDuC5O11tyOBlZBAOxfZi8m1aLt3tBntYbMKZ0G2Ivoo274VH8/UJR+NFqNo5UBC7jbzfpAJf/QQDSNN6N6+R4g0m1DCphTQEMwkUhlIzg0EXWQlCBKVJnsBmKxPeSCWHSXtx0vk4Vx2jRSTnRmtb9GP+HVZMcg6T5lsC4Bb2i/ogp0e5dsopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhq5e4onxDjmABxJWEP8D8wWXLcHHNK75z3U6q8anWQ=;
 b=JMZr3mKpBfkJVaCfWx9139JEoMQ4HtKej8aOPDdji5CzP2hS+CLJph8phxt126eI++Fwr11b3qte3HuaAW/6vdg6YqebmNCawy76Ae6I1AFXfVpUrSJfYcIc5OI3Qfx+NywCAylwnJfU5hpp8pCAxTdrAxxXTI89zQCthSD+UGDV877EYAQobJhu+/+wDYHL+Kkzar18nRdH8FXRCFK05KgDsh6oocj3o6AI2ABYGasW/UjNYOYqtaYgz8+nw74isMwAc+o5NWj+6sM84xx9QHBb2SAtUpdP9fDSWpI7dONMHwtrIVjgpUtlXkW9VcGo6MImxYKyAMoUhHLGfcXZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhq5e4onxDjmABxJWEP8D8wWXLcHHNK75z3U6q8anWQ=;
 b=L1q8bK4PGe/72LUPmS4ccBo6s0K77ShM4Dnw6cKhC2bEDPCJXDv8vswxBJUwRy2ekUpOunQLzXLBVFK0HX0AgvS3AKTPoaBF0gi/Mbk7R+xt5snZx69vK+o1l8uao+Pw+nNs3RIe7CF3hTPoFbSbLdkjVB8sy+/OGwjF5mBGDHc=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB8PR02MB5897.eurprd02.prod.outlook.com (2603:10a6:10:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sun, 7 Jun
 2020 05:40:25 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::207a:b49c:79e1:d713%6]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 05:40:24 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] habanalabs: block scalar load_and_exe on external
 queue
Thread-Topic: [PATCH 1/2] habanalabs: block scalar load_and_exe on external
 queue
Thread-Index: AQHWO3cRyT3wksYDhE6zR82ey5VLcqjMpOWw
Date:   Sun, 7 Jun 2020 05:40:24 +0000
Message-ID: <DB8PR02MB546827507A4779E0535659FCD2840@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200605212842.18424-1-oded.gabbay@gmail.com>
In-Reply-To: <20200605212842.18424-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [217.132.152.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b88c3611-c1b5-429c-3d68-08d80aa546f5
x-ms-traffictypediagnostic: DB8PR02MB5897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR02MB589750743864723641565A31D2840@DB8PR02MB5897.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 04270EF89C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxH6aP8VHpx2dMWTAjb8cOBhhw4hpQqWSa56KT+GCU6FtS18859F0GfCn5V55bAhs5zJmgxlV4vhpTEEYiqk7jKiwZSyDVBei13W8LTpttGbVuq8XJw3CsPUTlus+u4Oy475iUC0DrtOn2BkY8NVeyWvKHrRHeS5l29SMaEWpMhbDl2GMejC7I5LD5NSv1WgKWiolv+q2pzDIRagRk1cQR/uez8uwugPbr+Dl7QPzluCmFcwEgNUYhsMJPb3Rx56G99fUgUWhNk0iKiK78vtrn9ZNgBAPSY4rB9LJQZoAlEs9z22Y8p7KqWaNaYSTKQG6gTU1W1ySK45ZrCLIP6vPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39840400004)(478600001)(4326008)(8676002)(8936002)(7696005)(33656002)(86362001)(4744005)(83380400001)(53546011)(66946007)(66556008)(64756008)(6636002)(6506007)(186003)(26005)(5660300002)(2906002)(316002)(71200400001)(110136005)(52536014)(9686003)(55016002)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: q4ZCpRzQU8wLBU0WOoOXEQlMvLDfMO6WxSliLhdmeceeEM3JMEZyWiUCqbHaOrOLJKZstDDv1DD/WNdJm85lfxlgMJ9nbRd17sQnclOZPjhmSTgbM54BXajvPPhA91cpBwtISuCqAwqkM5sHyLbL3biMtWGq86oM1RN0iefPs9vvtCK6AVBg1AN3M6zXS5sSYtOz3Cm0c8lCojd0tz+KDyVSJw5T6lxEUnLRFgf6k4A/Karh5kemnpofSRzwUb7evlezYf78QugdMKLA1xM6law/4D1nVZBp1PaOG9yfdkRTXZ5PzRjEQcna1XQI2TAxuZWmTOjTTVWc1P7JI9PA+nwjymPbVBEsXRFNmeeg7v9qvxdaZYVpDHc3ZPpMTZ/FXtZNocL/PWNJZk5iy3vkXvhSs34k2vLALGZcJx283sDmC4xG8aR656DdIm7hn5L7BLzm3Ali/TteRQQj1WCKaSD3cvH22Ya4Zkka2moRJ9oebB/u+zG+bnu1i1OBly7L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b88c3611-c1b5-429c-3d68-08d80aa546f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2020 05:40:24.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSolZL/ET3yjVTShcDQMx58N4tvA9Jr5MubpOGVdsC0R8a8JBy+InsxtpSaHjskJZmaGd1dxQxqOdrOGOgb0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 0:29, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> In Gaudi, the user can't execute scalar load_and_exe on external queue
> because it can be a security hole. The driver doesn't parse the commands
> being loaded and it can be msg_prot, which the user isn't allowed to use.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
