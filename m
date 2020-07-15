Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A23E2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RE8cMeIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGOOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:16:59 -0400
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:37764
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbgGOOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSbo1dgo/FjNn6bVhivyhgzXqwrKubAi78rh6mW2A4ukRuFWOx61rt2kG5GiHApGs83NPQD5H+BqRGtgxvb1xD4aVbkqycSSGCHQpW/NPVt0CdLYCnf02J7rSLEU0BzIiW65IRbKO5XCwaReBvjEcJTOC5dB15TuvlZmwQ3M/3buk75k9DdrZEZjsmUN/ENm1cMAI6WD0la3K2lAHhzRMdrrtCGdAHjO5qDYx3miewmanIbL5d/apGUKvhM6E2+mSmxGZ0NuURzOjagh/lUWteVgTEFWhaYUc6AowIHRnBlHyMW42++BdG9ocRkYLHa+W/wlUxljKLmWesAwSccZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9NJqL+dSwU0FeaLOpUzOcfMFSD+IIm1iRD7egSKROg=;
 b=PSzl1ZhM+of7093UuaLO7hOI3CzJ2gbMakdcDFuy3N5klBc+hbBYYGlWt0XS+Ew2YiIDm7lIUBsxvAm/mVD72Q2QM9MMxky1VsYnaFEHhKCuw+l3COJ92SRX/1215cD1dHtlS/vgm4QQ3zkD0DORFuwpe5/CDwt6FmUe7dM5fmTsIYkcBmu1Za4u5I+Zy+NfrGBLM8KDlM7755ridjSdp2k6t0ltQ33pGhsAW+xRohU6MoTGbCp28Bga+ipQlmhibVUIK6YiWDRJ1XY1zAQmBdY9I9vxaaeHZD7GJVx8dKxqczM/0OPqlOn2mqH4xdURA2c3RyTYQQ9nwHFcvfJAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9NJqL+dSwU0FeaLOpUzOcfMFSD+IIm1iRD7egSKROg=;
 b=RE8cMeIKwCqKwUR2iCTPrQouzJUB161u7wpxDxNXhHByPfXwX+Kb6ZdoXeMD/iwV6/Lf7mtf31L5m7E2tOo2ZvQ2NWgGm7b1YsF6s3gUZ9RkCTGH/UTHylba3yzQfCeTWLzWjn9dOAcxnpwTl8dXCyxQGzWU8T1NaMXZmPH6B8s=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB4125.eurprd04.prod.outlook.com
 (2603:10a6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 14:16:55 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::e5d7:ec32:1cfe:71f0]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::e5d7:ec32:1cfe:71f0%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 14:16:55 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH 0/6] staging: dpaa2-ethsw: cleanup of link state and MAC
 addresses
Thread-Topic: [PATCH 0/6] staging: dpaa2-ethsw: cleanup of link state and MAC
 addresses
Thread-Index: AQHWWeOcTNWCNrl18kmFkABE4UkG5akIr44AgAAAO2A=
Date:   Wed, 15 Jul 2020 14:16:54 +0000
Message-ID: <VI1PR0402MB3871A51187B93BD27415A46AE07E0@VI1PR0402MB3871.eurprd04.prod.outlook.com>
References: <20200714133431.17532-1-ioana.ciornei@nxp.com>
 <20200715141018.GA3377845@kroah.com>
In-Reply-To: <20200715141018.GA3377845@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [188.25.219.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27208d90-8381-49a6-693f-08d828c9ba34
x-ms-traffictypediagnostic: VI1PR04MB4125:
x-microsoft-antispam-prvs: <VI1PR04MB4125D17F504A65A9D44F11A1E07E0@VI1PR04MB4125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOcooLTNVG+TcQN8nC1vW+0JVntK6oHsW/mSMLfb/YrF5kkq7n3I84q0vWiE3rd3YTXqYPbXCPwT/Zr9KwYDl00f4AjHfxsnAhUQTWpb7gzR2j4YozNyDRhhMZOR7mNlkOyyZYGK97D/TDZUA6osxvxDNIAwOFQ6udwFpnXv/nuGzAH7XmTaXm2+RePVknxy4vCg2MU6e/+LzxcL2gQZ7+tF3xcaG5NmiuhbfBu0DKwiOBIBYu2lhKHmKaSWSuKRlb/yhoA2bBhZNzg1xR8a3H7wMzUb2UDrv/vF5bJrixZeYe+Fd8p4T6JtvSdjXdzlboYdT9rZk5Y6VK7U8Z/wj0bq+YNHw6xZ2wEqmnx2kSaERVVoBrdgHwf8LsD/ST/g7N57OQadogPdpAGaSAtYRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(66476007)(64756008)(66946007)(66556008)(6506007)(76116006)(71200400001)(6916009)(7696005)(54906003)(9686003)(186003)(52536014)(2906002)(8676002)(4326008)(66446008)(55016002)(478600001)(316002)(33656002)(26005)(5660300002)(86362001)(44832011)(8936002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9mRr7pmXBGIZt0l7EBTXKdRkKQz3KbXxiAcjL7CtJ2+sf+Vh1qChkNZC3GRGqPFpTSTjbxyCPxsf9mc2/wmysq+M6VCI+q+B9bDp8Afd6XFVwaj6/6xP0CBH17HuJWBJLVXQhKIgErQzB/jPyzXpDdpcfQsi1srMJN90OvMhnPEW/5sk9d9b31sG6ZoJbgd5pCgXV7US1ftPYqACTh01ODGzC5sUBnYiAWQFqgGBTDpnMerkSdBgpat+7jfz15ySidIriytwLLbXVaNnzTfX+i6XWCEQzYbR+X65n8ZsCwXcfQwEb+m20eql6qAvm8xy7N69wpMhBH8F39sacPHscj6aFSqOWWmRsT5E0jx+/GcEhS9+A7OC9kfjNmMJSapdadEooVjeJTZxNVagzf8yTsU53nC8aZ67e5KKgpfxFxt0RwGsG5Hy7GWeG9EUZPUL9IgqgGxxxxryKjD2wh/ZWMfB8L2RkRE/8C4HC576sFAtkEePKVFdb1vdY8n4yfoG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27208d90-8381-49a6-693f-08d828c9ba34
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 14:16:55.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pad2xuFC4JmaN4y3zHcVZNK6Jn1q/u9EDFEWtNY5zzdRtVj2U1rPihTIf34KxeEUVyKS3FJ/dQ89Wh3ut17O8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/6] staging: dpaa2-ethsw: cleanup of link state and =
MAC
> addresses
>=20
> On Tue, Jul 14, 2020 at 04:34:25PM +0300, Ioana Ciornei wrote:
> > This patch set is cleaning up the link state handling of the switch
> > ports in patches 1-4. The last two patches are setting up the MAC
> > addresses of the switch ports automatically so that the user is not
> > forced to manually add them before adding them to a bridge.
>=20
> This feels like adding new functionality to this code.  What is keeping i=
t from
> getting out of staging at this point in time?  I would prefer for it to b=
e moved out
> before adding new stuff to it.
>=20
> thanks,
>=20
> greg k-h

We still have some work do to on this driver before moving it out of stagin=
g unfortunately, mainly integrating the Rx/Tx functionality for switch port=
s[1] and general cleanup on the driver. Sorry I did not mention this in the=
 cover letter.

This patch set just does some cleanup of the link state handling since the =
state showed to the user in the ifconfig output was not consistent all the =
time with what actually was happening in the hardware.

Thanks,
Ioana

[1] https://lkml.org/lkml/2019/11/5/548

