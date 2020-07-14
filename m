Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F82622224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="GvoS8QPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGNMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:07:45 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:27264
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgGNMHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuyEeTggXRo43v4dr+uQsL+JeIOB27y9AhvDKVryk/k9sZI98yt78Wlo24OaMZZxKJoEAO2tLd6rDM5SX2sc20tPfV5O8c9aIl4mxLRLvbxP1VeyWtSBjO0XHGZgukfNQf5SdM9ODp3/EF2xfL3rcd5jBVAaF7Gt+CTeGEecRCDloOZor/7CluEj+cmbQiqDsVsUgXrJ0nrtA7I+6OIlN8r9EU9foj/ZGg499k66WwMO/U377i+urSQ2LSNVI6Xt9tBARgQxhUj2Bu4pBsCAwIwvXlTwN/zANBR5kPPPoSt0TFScUaL4UqEyqSrDa5hnGd9MoUYeSWi3J61nzlEwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCUY1L3OUPcWulq+X9QlrGeN+jL16QQA5lyxfI0CIJg=;
 b=kdRNcXCtVfwRNy/UiDWygTnVWyDVSUiAn+bY7P+lzMeiEf7pZxv3oCSBXdsMjH9nuxM0D5AqLQk/9itcvJAyGICn/HnK/uN2mEguBso+ft6EZHpo0uNupSCL/MUJblwF4PCVIq6O5JhCvXLPFu/gIlyTpBpV9FQyDkyeu+8pIG8kMGapUORyqea5R8IOJfsCPR3f5q7/PIK8yQxMOA91ESZt1ZvDpW7w5M42QtFFbjzf0q+T7yuX6YAJJo8EiPDmGbN6uQW9f3VHY4DCl38Hmd5huyytJ5do2Az1LaVOknI438By7mAPflNbd/GF4bdCMNoRnes08teXqAztQ9HQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCUY1L3OUPcWulq+X9QlrGeN+jL16QQA5lyxfI0CIJg=;
 b=GvoS8QPijkd9gy/vOlIr+rccg+H3hSq+lm6NrFyYJTVwVtZQZojFZEH9lYQfE614RHJfZstPRQodrvbmm7/HjXd/hI/GB7c2LTfEytgn0n4OdY9xsoasw3X36E04QlzxfVYhVR4VBm2ZafYFibS/ycENht6d4Js64Dn1vL7d7A4=
Received: from VI1PR0202MB3277.eurprd02.prod.outlook.com
 (2603:10a6:803:1d::17) by VI1PR02MB4926.eurprd02.prod.outlook.com
 (2603:10a6:803:9a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 12:07:30 +0000
Received: from VI1PR0202MB3277.eurprd02.prod.outlook.com
 ([fe80::1863:35ec:4293:eab7]) by VI1PR0202MB3277.eurprd02.prod.outlook.com
 ([fe80::1863:35ec:4293:eab7%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 12:07:29 +0000
From:   Ofir Bitton <obitton@habana.ai>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Thread-Topic: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Thread-Index: AQHWWSShqFCRK4JZYk2Bp6Q6RakrCqkFqnEAgAArrQCAAAhQgIAAAWOAgADAMgCAAFu6MA==
Date:   Tue, 14 Jul 2020 12:07:29 +0000
Message-ID: <VI1PR0202MB32774769723B6CE154865086BC610@VI1PR0202MB3277.eurprd02.prod.outlook.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
 <20200713155752.GC267581@kroah.com>
 <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com>
 <20200713190357.GC25301@ziepe.ca>
 <CAKMK7uEvehX2CV3Q5FJrF49-_Xe9gXJ11wDo7xyVsipyuZm23Q@mail.gmail.com>
 <20200714063648.GC662760@kroah.com>
In-Reply-To: <20200714063648.GC662760@kroah.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=habana.ai;
x-originating-ip: [141.226.183.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35a2d9a4-ce65-4ada-c2bc-08d827ee7b66
x-ms-traffictypediagnostic: VI1PR02MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB492645C714E83C8A704F6E0BBC610@VI1PR02MB4926.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuG4in5GRHjdwdzDCk+7P8uu1DUdXSmNIu3q87FT8/BlVP34MZclqZRDf0YGssHbALjKzNCZlEEy2wJkuQ57hEx0sqC9RgNMmN/v2p88wYhKTUB0Qj3BG00X11hMuXuTddfOUWoKLoZmcGKchdaIGUUERz7ZVrhH9BluaScWqp3+K0kIAsi3YuV9COqkpTUzNKnuQQFFGft/H1KDOdHBDYv+S51l6UXSz19AfXlA27m0RordbaBJBzxJilIVSzvPUDqdVgw/xBz96PKX2ONIfcDidpXRuuzp7bwdJWCgHmP2fo4e2QFBARmid/Zf9j/6H1Zd+NX/ILJdXYz0eBiwGEHZzX9ZlB4wjJxroPo6s+QOydvhoZgSXvCh75l0+eIRMsZBLWdUbBL/SqCMSoBx1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0202MB3277.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(54906003)(186003)(76116006)(8936002)(66446008)(64756008)(53546011)(66946007)(7696005)(66476007)(66556008)(86362001)(4326008)(5660300002)(478600001)(107886003)(71200400001)(33656002)(8676002)(2906002)(83380400001)(26005)(110136005)(55016002)(6506007)(9686003)(316002)(52536014)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y0wQGG/yQ/iViEwiBnjG9eyOGjEjNZRd2aKOXNqJaKjIUnV67RYId330vPApELxwVOj3kKyiwdjnEHdLyho+DqI32H8QVa7d+Kq4fY3yNM8aowcOo+2fYUjt8cyfN5mm4CkPMfUlnk9yDLhurK1jA1uZ8xzkLsiczMcnSI68PLIJ9dhLmKlcEOEjRf8T/yOR0mLPoauSvqOsgvoe5gTQyrcWF7/aSuI29czyRgr41+JB7+58ScqG5Gdqne2nVqxLsqC5gsynlhKqemSYre9yNwa/i3eoZUfBoTbDIUHfkjYMvV788WEQq3wpYr6aGaueQ1eoucImEWYSIK6sQYw/Lns3Wb8d+KWT1SMEHytjogtfxDdiSYXofz4tU64P62E9BoL6LVZSOueaAkNbqsuNHuGDJjbiQGvEZ4wtQJo9s5S4CQV3Tfy4+9bzKAGkyeTPj1mKp7kUgmUldMq+rE66Ky9CWpI15GpGXSoUJW+4hLT47SOgxI3O1F7frg9vXYYD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0202MB3277.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a2d9a4-ce65-4ada-c2bc-08d827ee7b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 12:07:29.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWwxtJ+WjpxGEx1b03apWCLDy9fTG4XTTI9HKXGXDPiWmFFEhic2tYUo9HXs2yX4RmR1nqaRCLGB0/89zYvU4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure,
I will send a new patch using completion instead of dma-fence

Thanks,
Ofir

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
Sent: Tuesday, July 14, 2020 09:37
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>; Oded Gabbay <oded.gabbay@gmail.com>; Li=
nux Kernel Mailing List <linux-kernel@vger.kernel.org>; SW_Drivers <SW_Driv=
ers@habana.ai>; Ofir Bitton <obitton@habana.ai>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism

On Mon, Jul 13, 2020 at 09:08:55PM +0200, Daniel Vetter wrote:
> On Mon, Jul 13, 2020 at 9:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jul 13, 2020 at 08:34:12PM +0200, Daniel Vetter wrote:
> > > On Mon, Jul 13, 2020 at 5:57 PM Greg Kroah-Hartman=20
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> > > > > From: Ofir Bitton <obitton@habana.ai>
> > > > >
> > > > > Instead of using standard dma-fence mechanism designed for=20
> > > > > GPU's, we introduce our own implementation based on the former=20
> > > > > one. This implementation is much more sparse than the=20
> > > > > original, contains only mandatory functionality required by the d=
river.
> > > >
> > > > Sad you can't use the in-kernel code for this, I really don't=20
> > > > understand what's wrong with using it as-is.
> > > >
> > > > Daniel, why do we need/want duplicate code floating around in=20
> > > > the tree like this?
> > >
> > > The rules around dma-fence are ridiculously strict, and it only=20
> > > makes sense to inflict that upon you if you actually want to=20
> > > participate in the cross driver uapi built up around dma-buf and dma-=
fence.
> > >
> > > I've recently started some lockdep annotations to better enforce=20
> > > these rules (and document them), and it's finding tons of subtle=20
> > > bugs even in drivers/gpu (and I only just started with annotating dri=
vers:
> > >
> > > https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.v
> > > etter@ffwll.ch/
> > >
> > > You really don't want to deal with this if you don't have to. If=20
> > > drivers/gpu folks (who created this) aren't good enough to=20
> > > understand it, maybe it's not a good idea to sprinkle this all=20
> > > over the tree. And fundamentally all this is is a slightly fancier=20
> > > struct completion. Use that one instead, or a wait_queue.
> > >
> > > I discussed this a bit with Oded, and he thinks it's easier to=20
> > > copypaste and simplify, but given that all other drivers seem to=20
> > > get by perfectly well with completion or wait_queue, I'm not sure=20
> > > that's a solid case.
> > >
> > > Also adding Jason Gunthorpe, who very much suggested this should=20
> > > be limited to dma-buf/gpu related usage only.
> >
> > Without all the cross-driver stuff dma_fence is just a completion.=20
> > Using dma_fence to get a completion is big abuse of what it is=20
> > intended for.
> >
> > I think the only problem with this patch is that it keeps too much=20
> > of the dma_fence stuff around. From what I could tell it really just=20
> > wants to add a kref and completion to struct hl_cs_compl and delete=20
> > everything to do with dma_fence.
>=20
> Yeah, that's what I recommended doing too. error flag might be needed=20
> too I think, but that's it.

Ok, so this should be made much simpler and not use this copy/paste code at=
 all.  I can accept that :)

Ofir, care to redo this?

thanks,

greg k-h
