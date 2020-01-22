Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B0EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032A2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="raXbh4Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVIQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:16:17 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:35705 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgAVIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1579680973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnKqdxQBxDT6/dtCZv+26advpwqjmsW2p5Ym4G/2PtE=;
        b=raXbh4Ju4IRhVyULpCAdR59g0e0UuSxvpetnaN/lXZkPxk+AQJe4+1FxUDP/Acfb1nwOnd
        3QDRytsoQkh+i+/OEJrpPFgLMUI9EWaKrrxAkaFlUrUtZ1jb2ZVwVFOQ9XWW9MuJvzM39r
        D2dVnPbF9pc5Cv4O9dbkS6Y5b2DHrBY=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-24--ctU88VxNfyf29GHwVMtMA-1; Wed, 22 Jan 2020 08:16:11 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB3262.EURPRD10.PROD.OUTLOOK.COM (52.133.245.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 08:16:10 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 08:16:10 +0000
Received: from [172.17.183.132] (80.93.235.40) by VE1PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:803:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 08:16:09 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [External] Re: staging: Add MA USB Host driver
Thread-Topic: [External] Re: staging: Add MA USB Host driver
Thread-Index: AQHVz3K8AIv1fzzvAkakA28tJGe9z6fzRtUggAL+SgCAABtLgP//8WiAgAAHrgA=
Date:   Wed, 22 Jan 2020 08:16:09 +0000
Message-ID: <98df2373-6f19-df36-c78c-e0384ddb8730@displaylink.com>
References: <VI1PR10MB19659B32E563620B4D63AF1A91320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB1965A077526FE296608D5B1191320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <20200122070312.GB2068857@kroah.com>
 <aba22f24-1124-2203-b9f6-4a5e9274a8a8@displaylink.com>
 <20200122074839.GA2099857@kroah.com>
In-Reply-To: <20200122074839.GA2099857@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:803:104::23) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab12ae43-ff2d-427a-0c77-08d79f13564c
x-ms-traffictypediagnostic: VI1PR10MB3262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB3262254FCB9DC291D1AE82BB910C0@VI1PR10MB3262.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39840400004)(376002)(136003)(189003)(199004)(107886003)(36756003)(31696002)(66446008)(66476007)(8676002)(66556008)(81156014)(2906002)(64756008)(4326008)(8936002)(81166006)(2616005)(5660300002)(956004)(86362001)(44832011)(31686004)(66946007)(6916009)(16576012)(54906003)(71200400001)(186003)(6486002)(316002)(16526019)(52116002)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3262;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIFa2T33p2i01NNhjvPScPpj2q+jfCeil1DIy3GH7zuH7S0+sgUn0lRZF1u22RtS6X+xueeIDQJuiiOtWDnU2XTUTvzepehJINR5tLXsancExXujOEU0FJDjgpPIVoRQIGLXFcuP10Y4mGwnugC/GEnDSGfMH32U7dutLJK/+NNjwXLSpRinW8zIUurNXWpP0+Cu4WLkZVXx2Uc9Q1sFK/tcl+krm9/wjL6cA6R/jnO0IXnt9QwQ/AHj0uYXg68HYxp5xm5Sx5qBsQM2Cx5WkjpGZUMHPU/sezEiIBqF6zZVDw+LEZVKEg4haKUUj6rerU1VlS5CAL0B2R7G5hhDiJDzNtbNx7L9w5IQW2FbVSIrhH6GunFLonHe+t8tVtliUGKyBUsCuZOgQ/F3wwTTLRUlnW2btULaI5RLA6Gp9E1c6cKGJdhw0ufS8iLAyayh
Content-ID: <1EC75E063B29B14DA1D8B5FE330D3F21@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab12ae43-ff2d-427a-0c77-08d79f13564c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 08:16:09.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbvIYQJ7te8wXYLo7Nz0LJ6d9LgSSHMJv9BMIE11fNDAJpGybvWhzrc3NPOrIunrM30cTepPDxc6eQVqGNKRJGF1X9CuECNnGmwOPaAH9t6wuQfIq08iQGfnNeKu/X/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3262
X-MC-Unique: -ctU88VxNfyf29GHwVMtMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

It was section 2.5 of the kernel development process, "staging trees".
In particular, statement "where many sub-directories for drivers or=20
filesystems that are on their way to being added to the kernel tree=20
live" caught our attention.

Now, by reading it once again, I see that the rest of the section is in=20
line with your comment.

We'll address all comments received so far, and resubmit patch onto=20
appropriate repository. With that being said, is USB subsystem tree=20
(drivers/usb within usb.git repo) correct one? Please, advise.

Thanks.

Regards,
Vladimir.

On 22.1.20. 08:48, gregkh@linuxfoundation.org wrote:
> On Wed, Jan 22, 2020 at 07:40:59AM +0000, Vladimir Stankovic wrote:
>> Hi Greg,
>>
>> Our intention was to follow Linux kernel development process and add our
>> driver to staging first.
>=20
> That's not the "normal" development process at all, where did you read
> that?
>=20
> staging is only for code that needs lots of work, and almost always
> merging a driver through staging takes _more_ work from the submitter
> than it does to submit it through the "normal" subsystem.
>=20
> So if you want to do more work, hey, by all means, send it here :)
>=20
> thanks,
>=20
> greg k-h
>=20

