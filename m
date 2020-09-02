Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB69C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55B920767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nyxMsTzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIBWs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:48:56 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:29666
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbgIBWsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkYmVDJ9QMXtyvhx5IQ+2reWitzsA2hELGiV1jOzppuX0PfAPBbOaIXM7M7b9sfRGdRUSj1mRiofHxydTTFfGVOVAPKoJCa4XIkNBbYt8v2+oBfckvbpDgLvUS32k7lUoQRWqfR6ZHK+oMdLs+/YuuyCOGWtKjBlSq5ifyzdSrZ/TRrdC+RjVh6rZJXaVqHZVb6ERqhKWoqE8ue7l8dpc+tRrPNI/eWYcxRSsNK8lDh8Sf7Z9kiKhyAR6Wtf84kPS/jq28GOjIA/m+Rh3fkEu5HVu84lyZvlT9kf6PJn94fUgsAb0E2M80G1MrGAopZo9c16CTvsgZARtngOenp54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djP9nZSO0mPS+u1xb0QVGMh7kJhv+owi8Wkg5ZKlWrs=;
 b=lss2GfTQKrz7N4oxiDaCFQ095z7pq3xhFmLGAEPGRv2mvS5CAHKdzTg6uJebrJOcEO//r9cMdb3AJnb6+BKN5HFeB5BCuB9YUM4Ql6LUhbPrB+KYAEZK3wkJFlxhHvEwt5nDSlCrRgzo7SK9bzRzDmqpWwIgk3l7jkp9NGNWmMGoJKjgQtspzW0ucIbF5CnEKlu1V211OS/Rlu2XRTE4anV7JiZ0EUvX0dN16JTg4t8HtFMXWDI3nMr7zup80CX/1zvyyIHHxMEoRCw1yAy2yYpdtuch0Aj3I2ZICLWE8DKzi1bWkE8OWvJCRF2QuwsZRNP9W1Bd0mPMDTmN+Cplag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djP9nZSO0mPS+u1xb0QVGMh7kJhv+owi8Wkg5ZKlWrs=;
 b=nyxMsTzMwCi5ExeV0HEzy5nVCKfv/DchoIAA0x36FFEL6OIZTPiV6fzPdTewRoUfLOakCR5vJvlqN6JlcEUja3owZ1qtmGJqWz7qe0PF424ZLtkVLF/vGbwDuyMCT8pD/TezlW0LnVBl1EdpX1xr6yQsgK8wiEV1BGvuo8/2EgQ=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6278.eurprd04.prod.outlook.com (2603:10a6:20b:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 22:48:49 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 22:48:49 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable
 property
Thread-Topic: [PATCH 2/3] dt-bindings: usb: cdns,usb3: Add
 cdns,phyrst-a-enable property
Thread-Index: AQHWetjF2mYsQKwgvU+3PPFGyTZfuKlL0I2AgAmTp4CAAJx0gA==
Date:   Wed, 2 Sep 2020 22:48:49 +0000
Message-ID: <20200902224829.GA11250@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-3-rogerq@ti.com> <20200827111343.GB5983@b29397-desktop>
 <08a7533f-b09e-f044-64e5-d709ae220599@ti.com>
In-Reply-To: <08a7533f-b09e-f044-64e5-d709ae220599@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7decf3bd-7cba-4ce5-8bb0-08d84f925b88
x-ms-traffictypediagnostic: AM6PR04MB6278:
x-microsoft-antispam-prvs: <AM6PR04MB6278904E2860F70064FDCACB8B2F0@AM6PR04MB6278.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVgzuSplbL9c3O+AXRzRDO0vqU9kWx9cp4VWzDpSidlTeyTkg+C+bKsYZ2Aa9cEvHNCZFJDZ2Gkntv1+QYmQ+z4+grTVa8rQgv0TmzeLJjnsHupsmSXuKn5hJNLHsduFJpW0quTJpIJS7otEcouuUCdN8zYIENVcU4EohAQEgNRtlVyuDYOTD13/z7cqlKExXe+ZLpSj5y/nm4xTs2tEeBsbEPCD1O0Ta6Txaw6xV+ce4CLJN4t77N1pUieFnEmbBQ8+9OBW3LDkAd5c2fO+1KQrE3zAnkwLPKfIoy/e30Fsdmx1N11c1iWX8Q7RzBGOwNd+vWhz3G6o+gn11PaFJT/lrPNxLlPPEIZUm+lGAzS/B8EgCs90jn7ZqqG3NyTm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(33656002)(316002)(44832011)(71200400001)(7416002)(8936002)(54906003)(5660300002)(8676002)(66446008)(66946007)(2906002)(9686003)(6512007)(91956017)(86362001)(186003)(6486002)(66476007)(6916009)(66556008)(53546011)(4326008)(478600001)(33716001)(1076003)(26005)(6506007)(64756008)(76116006)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ul5kDXXv2ZuuKF3anQf2mdiuS/jypO2aBtUE2FgRADFc4HssZ0+ocV1Px2imfGATFCtZ2bsc/W1Wou7sA0HB4RyGCkZBztQPguV8CffIzGi1BU9mPcgoGf8k5vgVQf2quir245E/AdX5colQhdC8TRkHAyhgF3d2xUL7HDNupg97glT6ycc97ntx5BfZ+eLR9CNE/A92Yem1jb/ystDDeJg2OffjdnirkfDCo/rX5F0JbjhAE90gt1lvSgl4s10HLVxT/YvGZOI3dLi3Ci7uCSNg160PhuCYCfKDYK8qhaGQSIiv0921J0CQLMYzmbywyZytdy4qvgWuMoeRnzTEqewgVmBboK9LZ4Jd8rkLkG7yWkaLYijm1+vwlFYjb+q02XIsp/4KjV1LE8dEYbWxb0cHKPZ9aT4Jkx+A7F0rph1MnStKLhq8VP93cV54AL6xOPMsqDumKZEzjOR5t1eHqXdDHGwQmanNyO3erKq6oomXqijQEWucKmKQES73Glqx2TnPi2g0144NAqMYXGFLxo/RlcMvMeFtMbtxlm/XfAfBJOHT3QXARCqbdRzyYp0ttQf064cUxf73UDJqNN1WBFnNCRmv3ljIKpg/xIlxej1ibie3dl/1dfLR/VNIUGShOx7UQcdzBy4WzCNlslZOEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B379C6FED2430458D6C5B48169BE3BF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7decf3bd-7cba-4ce5-8bb0-08d84f925b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 22:48:49.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQlc2tD8jSUoN4UEZS87vWdhc/RIGx5f5gZZ9WDHbX8YS5ju7vk0uHggamSlOiANWjonNbWNw6Q9Jp3TXBY93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-02 16:28:31, Roger Quadros wrote:
> Peter,
>=20
> On 27/08/2020 14:14, Peter Chen wrote:
> > On 20-08-25 15:00:58, Roger Quadros wrote:
> > > Controller version 0x0002450D has USB2 PHY RX sensitivity issues
> > > that needs to be worked around by enabling phyrst-a-enable bit
> > > in PHYRST_CFG register.
> > >=20
> > > There is no way to distinguish between the controller version
> > > before the device controller is started so we need to add this
> > > DT property.
> >=20
> > Maybe you should say "There is no way to know controller version
> > at host mode, but this workaround needs for both host and device
> > mode, so we have to add this DT property", the same for the comments
> > of your driver code patch.
>=20
> I will reword it to
>=20
> "There is no way to know controller version before device controller
> is started and the workaround needs to be applied for both host and
> device modes, so we add this DT property"
>=20

After apply it, feel free add:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Please apply above for device party commit log as well.

--=20

Thanks,
Peter Chen=
