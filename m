Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6776124655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="ATwtGgQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAVJHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:07:54 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:25114 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgAVJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1579684071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYhvcLodsYCv1zZZcC0OL7bCXNNu+SPnBUOlhR+GRuc=;
        b=ATwtGgQUslyalM1AfzqBrnYUtAZVpppUouayIrpVVo8Dx89gFWFMxdKKCU5WsLMa6EFDiV
        4PhUCUym2eZ/FvDMqGMTubMMb3FjRTHZ4xBuJHSsji3YAWqylMILSufm66K0KcXxH+RPo8
        oQLe45JOGJa9MN/C90NodaY3REb3pTI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-r5VKoD5sNCe5jt47ZGIw9A-1; Wed, 22 Jan 2020 09:07:49 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB1870.EURPRD10.PROD.OUTLOOK.COM (52.134.21.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 09:07:48 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7cc2:599e:25ce:49b2%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 09:07:48 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR07CA0291.eurprd07.prod.outlook.com (2603:10a6:800:130::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Wed, 22 Jan 2020 09:07:48 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>
Subject: Re: [External] Re: staging: Add MA USB Host driver
Thread-Topic: [External] Re: staging: Add MA USB Host driver
Thread-Index: AQHVz3K8AIv1fzzvAkakA28tJGe9z6fzRtUggAL+SgCAABtLgP//8WiAgAAHrgCAAAlHgIAABSYA
Date:   Wed, 22 Jan 2020 09:07:48 +0000
Message-ID: <2873029f-1259-60a0-4590-24f6a97ba29a@displaylink.com>
References: <VI1PR10MB19659B32E563620B4D63AF1A91320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB1965A077526FE296608D5B1191320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <20200122070312.GB2068857@kroah.com>
 <aba22f24-1124-2203-b9f6-4a5e9274a8a8@displaylink.com>
 <20200122074839.GA2099857@kroah.com>
 <98df2373-6f19-df36-c78c-e0384ddb8730@displaylink.com>
 <20200122084921.GA2420736@kroah.com>
In-Reply-To: <20200122084921.GA2420736@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0291.eurprd07.prod.outlook.com
 (2603:10a6:800:130::19) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78850b7a-c867-479a-a3d3-08d79f1a8d17
x-ms-traffictypediagnostic: VI1PR10MB1870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR10MB187023C95A395CBDFCA3499C910C0@VI1PR10MB1870.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(189003)(199004)(36756003)(6916009)(52116002)(4326008)(26005)(107886003)(186003)(8676002)(5660300002)(44832011)(66556008)(66446008)(66476007)(16526019)(64756008)(81156014)(8936002)(956004)(71200400001)(31686004)(2616005)(81166006)(66946007)(19625735003)(6486002)(478600001)(966005)(31696002)(16576012)(316002)(54906003)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1870;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWuu6yw+4ShyXvF6Z5JLZ/Hhk1m7w6EQkmllGRI+kyWPFcU8kj1vt2z5gAD3nE/NFlP3svWUS8KvMnRiLYppiTzGKTH2Ht3E+cL8ZfkY/YU7Qp6RZOfDakJdJVp2cJ7Do8KYJEhUXyQ5y0+IXREdJmuC9mFqC428a+HajcEm3z2MrHdHFWgr/+yYAc1XkQ7OsQ/ugNGBpA6AW6mE5KKJjU7eK2o0wWwyrpPnIhtNnOaJA+0h0WELE3yNPArgHhvzvtEt/jE2VBvARArnaNwQLb2W2OJlqmTxavAiF4udBm5XAzeaYJd2BsHPPrcAAXbXt84u0HbOmMw9AXm3fKUruHYWXvzausUVEdOIIs8XGWI0OXdddPmmkWPvvXzOmsOd1izkqDXt5PVk+QFlER8DbT0Khuau2iix5OoMk1sg+v8x9LBetE6qB9WTru4MQwBJOMzjEHiEoW8k7rxafpvAkd3qoCN/jMQXy0f8p6qssns=
Content-ID: <091E55DA90AE2348BA806342518A99A2@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78850b7a-c867-479a-a3d3-08d79f1a8d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 09:07:48.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgbOJua5us+kmz8e01/tTBctfyf3eOp3D0fY4ECVhDeOkviZoPhrMqM1vgTJFZaBRU5F1/GvNGdr/q47nMb5tTY3aI43/P8/culcQf9mH7W6ryT3HBfDckouAK8uy5Xv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1870
X-MC-Unique: r5VKoD5sNCe5jt47ZGIw9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.1.20. 09:49, gregkh@linuxfoundation.org wrote:
> A: http://en.wikipedia.org/wiki/Top_post=20
> <http://en.wikipedia.org/wiki/Top_post>
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top=20
> <http://daringfireball.net/2007/07/on_top>
>=20
> On Wed, Jan 22, 2020 at 08:16:09AM +0000, Vladimir Stankovic wrote:
>  > Hi Greg,
>  >
>  > It was section 2.5 of the kernel development process, "staging trees".
>  > In particular, statement "where many sub-directories for drivers or
>  > filesystems that are on their way to being added to the kernel tree
>  > live" caught our attention.
>  >
>  > Now, by reading it once again, I see that the rest of the section is i=
n
>  > line with your comment.
>  >
>  > We'll address all comments received so far, and resubmit patch onto
>  > appropriate repository. With that being said, is USB subsystem tree
>  > (drivers/usb within usb.git repo) correct one? Please, advise.
>=20
> If this is a USB host driver, then yes, drivers/usb/host/ would be the
> correct location for this.
>=20
> Note, at first glance, there is a bunch of work to do on this to get it
> into "real" mergable shape. Be sure to at the very least get it
> 'checkpatch.pl clean' before submitting it, that will help out a lot, if
> it is not already done.
>=20
> thanks,
>=20
> greg k-h

Failed to set my Thunderbird properly, sorry.

Thanks for your feedback. We'll proceed as advised.

Regards,
Vladimir.

