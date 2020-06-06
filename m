Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9589AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7581C2077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CTKfbrCW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L2jAIXty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgFFPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:45:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52568 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbgFFPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:45:20 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 94C53406BF;
        Sat,  6 Jun 2020 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591458319; bh=O560krAgh4WhvRdlf819YQrn/zlaNtR0w0KD4HK1A+k=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=CTKfbrCWrHoLJlaHU5w6G90ZSue66i48meEAT9YpsF5cexuV7dP7VKzXJUL5haIO2
         CLX9L4VpymOap0HzM19gkJwRsu10UAbtbfDcx0Ur97ZR2AlPevugTNDVMQDFxOs3hr
         mLskmZQHR6SscZV70yGUIEPfUNX0g1ZHEh3lbB4q4UvlABE04mLVmA7PS37PkYRuWO
         L/a4FKDkqHfQD3TOqNZthfsJG0ihcbpX6sYwZXnI1phEVH9I/f5yAZc0kUBJ/0mIKm
         Inn51+7G2idLxd39pMjHs/dGPJ2LfPySmK2lXykgu/7oJavcR8N6dPMt0OYWpgW3N0
         qp+6mCzO9xRzA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 91072A0071;
        Sat,  6 Jun 2020 15:45:17 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 6 Jun 2020 08:45:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Sat, 6 Jun 2020 08:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtl3jID1WQ3b3Dj7RSNJVzP5/+jyakpl5m1DYorSA4YdELWgqTvTby5VOI7T1DDa5Ao3uTJMRjuD5YEQZpZkzJuRP+iD5sp1/ElO2eKYfcqQer2ZS6qeCDzVG8klUQJBMvvPg2D1CdjATlFNOxs50fTonOy5Hw4iW89xE9DoWK8BWz64xzlqL4Kb6doLMgF8Mvf59cKrv3RIb3upIg76Kf+Xg5cweBGelZJKQxwM0xHJ+DkwO3eNKVtVknRQkI26rSkbczsu7qVs/zqyomHBqSAE/XXh95sRmJzRPlmkz7AA0ij1hOvX8Rq6HdN1PIzOPGlrgGZPU61PZJPT922pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPd+oPLp7VONbjjKEVQKluPsvaA8+PyRtHhVPtZ3E4w=;
 b=HT0CBJAaUeWfOOx921waJVPfN3sUFHcl3kHuyEeYJbUkvCU8JAUi/mimvZ8RRfHeL91PxMzE2wWLMtfqAqj5fFabogWDtXZ5lbF2cv0mI5H6bfe3o9+Lc/R40o28LQGaI1Oxso9brBL/fIVKukfgobDjEEzeR6j0e80WUYs7YwBCgAjllZRiCXosH+BsPuQ0YFyEkQ61XaYCxQyhgqNoAFR7iKb/i0w38pmbzphVsqYZPlD9tapr0OSRWYDQCBM41marPPu2mRuLBHGQ9X5YxOO4PpIOHYd5tfCggNhO6M9r4OEjd97MxvGlwnN+3HdWS3fTs4PnZO/7HfRSTFFI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPd+oPLp7VONbjjKEVQKluPsvaA8+PyRtHhVPtZ3E4w=;
 b=L2jAIXtyYYny+D4lZEPKaivRglBCDuI/z8HbHL108Zo6rs9hblprG8eVQEshjVtLJ5PzKpVkFf6hk9oFi/XWWWG7S8H0YGdMIgXXcRNJLjxeHiNByxu4x6iNjPsBafLsX5KUWTZqKLLDQuPLW/FgvBayFPmLJJu/Z0W/nBoAJo4=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:45:14 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::78a8:d153:7e1c:57a5]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::78a8:d153:7e1c:57a5%7]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 15:45:14 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Pavel Machek <pavel@denx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] sr: dwc2/gadget: remove unneccessary if
Thread-Topic: [PATCH] sr: dwc2/gadget: remove unneccessary if
Thread-Index: AQHWPBhw3SL7LTHMVUK+qAoLyD/PXKjLur6A
Date:   Sat, 6 Jun 2020 15:45:14 +0000
Message-ID: <4057a9d1-2cf4-78a1-9f29-587a87b523b4@synopsys.com>
References: <20200606153703.GA18931@amd>
In-Reply-To: <20200606153703.GA18931@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f110b41-301d-4fa9-afa9-08d80a309ada
x-ms-traffictypediagnostic: SN1PR12MB2367:
x-microsoft-antispam-prvs: <SN1PR12MB2367059F7E92F2FA0FB65D5BA7870@SN1PR12MB2367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 04267075BD
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HtKv+YNeT9Nq5S6gpAfyfjFQjEiMuPEWEVetqD2l9yBjPQmGXOMiN5pwet3l4WDqwTt4WQ8Qn0J0nPBvs+k6+rhsz5lX0DTVCpEGwgILlMR2NYt17GYLYaFYpB3FIkp19ePs/amXnSF5Z6ESJg519nDO5BjJv8WBLraxzbxZTti6E0J+3x+vnC5myJHytKxXPbJELKOKQVaZf/cE5Z5vefVh7LsqR7DmgPRXBdO0e6FYPsnsgK3IDWEatCP36q22F/Jrs47WpfrHx5gELL+XX37aXy1x4qpI8utRNBG9Oe/ta7JK9uWU+a+wK1JWtGMaRINrTycgdsMItkQF4Ni8ei5jv0nKMkStmANBSXXxRpxpoFVC8AgZjVMBcuB6KdcH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(26005)(76116006)(186003)(36756003)(66946007)(66476007)(71200400001)(66556008)(86362001)(66446008)(91956017)(8676002)(2616005)(64756008)(6486002)(316002)(2906002)(53546011)(110136005)(8936002)(6506007)(478600001)(83380400001)(4744005)(31686004)(5660300002)(6512007)(31696002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bqPoI4zqFEqQAOp1Ygi5zsXWZ7pAizvvyslx2UOt+yXOqoCb/Pooi3kZqTmcNg083qdMTbKDkFg9f9aPd4Ucs3FZdo63pzj/+2Q5rk0Y8mDJR+Ec/TA+jKo0CIzZiK9rCnoctsgjMqkT4QjNa9xMrCebI2D2tF7oc2Wu+dGIaXUXxYdhUYdgVhzZH4VzpdAJiLIskOJ8ZbXuLhZjXxvgxNhUtQWLguBN7d0Pzxhnidsvw5cIenXprEau3phMqjk6V0KE02sLXrd3u+/9SJyXUiq2TcJcpwIgHjG2fuau/8V3ozvsxMc0jrCK5D6SaE52E/Qq+rqNxwYcsJ+2AZNht+Q9hdLFM+U4Vz3VfJV7XdQeDjZf5J648Gp/BcMnmsWYb9CEei4czUW2Q/YDVRGmomApTUnFKV1z3gLITPnyh7ZZJ0LBUhKtYfx2Q96PTAdKQZkLHilxb19dWwlE3fAg+Bd7UXb/+sqH60wOnI27LQyYhzV6Bb4fEUQuM6QXQ7AT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4FBD9350E4DDCC46881ECFE74041C926@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f110b41-301d-4fa9-afa9-08d80a309ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2020 15:45:14.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Q6JGeZW9teQntQIomGdRXOMULjpJb+EKPpev0xc96BG0Lq5/wFrGzUkxoXBbwMoUtN0ahGgrjzCaR38xLY/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 6/6/2020 7:37 PM, Pavel Machek wrote:
> We don't really need if/else to set variable to 1/0.
>=20
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>=20
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index 12b98b466287..f9f6fd470c81 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -1761,10 +1761,7 @@ static int dwc2_hsotg_process_req_feature(struct d=
wc2_hsotg *hsotg,
>   	case USB_RECIP_DEVICE:
>   		switch (wValue) {
>   		case USB_DEVICE_REMOTE_WAKEUP:
> -			if (set)
> -				hsotg->remote_wakeup_allowed =3D 1;
> -			else
> -				hsotg->remote_wakeup_allowed =3D 0;
> +			hsotg->remote_wakeup_allowed =3D set;
>   			break;
>  =20
>   		case USB_DEVICE_TEST_MODE:
>=20

It's good catch, but 'set' declared as 'bool' while=20
'remote_wakeup_allowed' is 'unsigned int'. Maybe update 'set' type to same.

Thanks,
Minas
