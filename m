Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36712C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02037206F7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+3YaHXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHXCjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:39:54 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:17060
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727942AbgHXCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlsuQPOg2LZEiG9Kfo9EQM4WR2lcnGOGwoOtIY2KT7otgqBjIA/0zubOyjaLnL42TwTU4x1eBRl1ChC9daDipqKmOCQcF4LmmXm55uH9t8IG8WaKi0B9RP6gBL6p+qLwidzg/kOUbZrG34JeLYlIPgb5+vmOlF9mfMRmShSld8hMbhNH8yvvrZLeIFigXk8re05+8wc5O4yJK9AJjKrNRVo9+NIyrUm4LDt7v7ozHDFdFKIyaPVAqYKbjHqa9nX4Sdo41TRjevLjUxEQ1W1t0CnK+BfdJiLxoP95ftjclTMPS/1e7FuSQbI2r8a6uWP4ky2ThhnPJVAWvfi5eV/4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27RPWjYsMr2DDAb8Gcmy7rDFaxQVEe9tffAqw6VBIoU=;
 b=DE0+D8Pj3VWZFIyFknty67EAKoaJ1IiVXQ5SD7mIuLQbL9rvnDxITdZZdPrhkiQ1muiWLUWXpsTkqu4HUKwnPbJ0r+U+bfW2BE9+sdtAbSeTnPdpT5cdCy1ZQkMi7SVD9HKr6OWWSYBCdJwZs3MnVkt6OP40BMpavgkB1cgOqb32UbNn6MPOgNUMZmNJUQjf+UHvdODeHeKbPXl6rIgvD9ffpwOgS/epwQ/4duSeuKVVrwhenQ6RvXsp1JT5RH6JyiOKeZawyveXEFdUIxJeNDnOuOHmSmxZNU9CaBErTAiwXHMh43Agg1Eu7NsZ4/3GFnuIoUpwow6SYRLefBeQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27RPWjYsMr2DDAb8Gcmy7rDFaxQVEe9tffAqw6VBIoU=;
 b=i+3YaHXnjYoBYsZUZz3ZFFBD3LymsMb9DL83IxQEBpKWaSeVNxIgEUjWDFe6Dq2gpQxxEGEgDTsi9zllgDcCv34052GFXqkkdxgJk2ORJHhO1tZuGqvgkog4Yig7mwp5/jYhrsryNOj6h8ecacOZuivUm8tC3SfjCiOx6Y425IQ=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5735.eurprd04.prod.outlook.com (2603:10a6:20b:a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 02:39:50 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 02:39:50 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] usb: hcd: fix the error check
Thread-Topic: [PATCH] usb: hcd: fix the error check
Thread-Index: AQHWdu2wIt6TNfBTb0KQoyimK4tKialGkX2A
Date:   Mon, 24 Aug 2020 02:39:50 +0000
Message-ID: <20200824023839.GA4974@b29397-desktop>
References: <20200820122038.18704-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200820122038.18704-1-tangbin@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cmss.chinamobile.com; dkim=none (message not signed)
 header.d=none;cmss.chinamobile.com; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a745e707-e0b2-4448-3e29-08d847d6f94c
x-ms-traffictypediagnostic: AM6PR04MB5735:
x-microsoft-antispam-prvs: <AM6PR04MB5735277BF59126ADB96DF0268B560@AM6PR04MB5735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65TAyumAACToBmy7BsnAfWHvqBYX1hOdq7IxrcjBLGC6TRTC46l7wgSV4YNBwNCfP3RyguvOekfEd/4CttTahuNfVfqJTPIsbqiycuV9OJaGVjf3B7L16jtX56tC/IsAwD1LEDatC1rDhg5ny7skTdOAZdMa4pSLfrlPeouQ40bhkg+Hhm6LBTI9R1LP4s6OgD9DZFsPikrhTjhg+wVCUIlqSZvoVBym2olt/+1JJN6oatPYGCg7wkdcsL5AGS1mFKlOXX+xVwqf0uBH62C79gIg4l8xQIHAaShmRf50y8sLIlNeDGugjZeluIChCQvuqgKnhGfHAgFxoLWIQetgAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(1076003)(8936002)(8676002)(4744005)(5660300002)(6486002)(54906003)(316002)(53546011)(6506007)(2906002)(186003)(26005)(478600001)(9686003)(71200400001)(6916009)(6512007)(33656002)(64756008)(4326008)(33716001)(66446008)(76116006)(83380400001)(66556008)(66476007)(91956017)(44832011)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qHUjUW/Ca4j7GLRn6Y5fiYWpLl20Yb74+KBl5CrpoCWq/4OQ1SGzKghcNbxxUWQiP0nDDIhyOmt/ClaoOIL069lHHk8WnTjuaHdXm7HJSVV6l+QhjpcplyE10j/OgQKheRSXR4Xdwdu6/K/Rv5u727Uw/Iqe1Wnc51t6UMQPVdFpFSv3cHTZ6bISrhPVPauFms6SVle8UQ2jOPHdOByFdKqfgluBE3/Gx2LH3o2aC5c2x/bhXmiVWsFGn899K1zHWg2ehrYITJ2dIVNw0fjaD9jPqU2kzm2bmgZDyRMdx43uInUteLDOgdSA2WIXZcfZmpr1bbvNsAkM9p4FxE/bnp0dvsSdZCkotx/mFaFA8FNBJ2sZ/HYtlFUgubRXZxRohi0r4YtKfBCl6HP0B380EufEVdJjpWetL/IaNt1VwUOQ1HgHxSUKY4J/+NF0W01/0gvGtwsKZdTjD7+qBb/wOdqT6cjr6R36MBB/lslejFLpzov1dm78ElJ4RrrWrwfDR4UmfZP8i68BQFYivfQFI/V+YEzxoVSEMG9yO5E2FzBgLsRQUUSbL7wRrtYm3RQ/mExq1pIcvDoHOXnKJbddVeL8D7Q2DmPI8ncIP1oMuACRB7wKNsMpKIhO6vE/cUmL81kZ6Tx2MMZYRIiwx52QKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A021B90885F684F843EE60FD3E5EC8B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a745e707-e0b2-4448-3e29-08d847d6f94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 02:39:50.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APfYE/5QugbOXhKCB7XRxgrpjMc61LsaZjWX6Ej50fH4JckzmF6Uwf42HYGDtAU2fRCcoIVvzNncspw5vKMUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-20 20:20:38, Tang Bin wrote:
> In the function usb_add_hcd(), usb_phy_roothub_alloc()
> can return NULL in some cases, so IS_ERR() doesn't meet
> the requirements. Thus fix it.
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/core/hcd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index aa45840d8..b73a92ee1 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2633,8 +2633,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
> =20
>  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub =3D usb_phy_roothub_alloc(hcd->self.sysdev);
> -		if (IS_ERR(hcd->phy_roothub))
> -			return PTR_ERR(hcd->phy_roothub);
> +		if (IS_ERR_OR_NULL(hcd->phy_roothub))
> +			return hcd->phy_roothub ?
> +					PTR_ERR(hcd->phy_roothub) : -ENODEV;

Many (old) host controller drivers, their PHYs are not seen by software.
We may not consider NULL as error.

--=20

Thanks,
Peter Chen=
