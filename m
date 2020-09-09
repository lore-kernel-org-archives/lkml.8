Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26910C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10342166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZRuig3f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgIIRDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:03:50 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:61824
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730494AbgIIPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqLSzODX6NNP+cIXpI9B8iVOu+EnGejzY7PiNySckYsHdGGvh0e9wLDrWUBaVHNkrDs1+QHaUrQmEun8byW1n85JfdRE4GkNXPHbhovTHsinSsgT0/G3IgKWoWsnT8lI35SA4lR+b4uiK+EP5h2fu5QxlPFhVQvEKQdcU2dJhIgz5bLyDcHUO8ulhgttGbQ6Pin6fGW9nCBmozfPYGyWRO0G/GfHW47GWMef5avV3PTm12AubMyRVjRcnC1i9Xl/gis0h5UP1atYEa7+6g0T683DteIDkj8TYNlV7zwXlDQwkpGsNVr6W+auqVB+lbs9Rr4yBSwzjF948tcvUWJ5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxQgBUeTBuyN+JwqjIpIWS6i5OlF/4xaLh84B2rMaig=;
 b=iQHfeLcRv5hvwolOT3Xnq1W5O60vgpLz1Ucvgvs/XmFujJfihMrEssRuBgryvmzWrHP2G2GIRypa5BS8db0H3WSEISakOallMnOPNS7J37puic0Sbvr8hdVgxVp5vUuFdyc2xejsWIVr2EBKDjyf0druH5FHTuWYCOo28hrHxsECcZ+LaRz1m23TDjPtERzxAzJmNFSU5wjv4TB/74sV8M77D5AMP1VA3Y2e1n50HHEB/2H4ZiKlgAvE/81cfKXoy5kgymf1VeJ2lBx8N3oLixfknum+xknneiLgAlWDTTDOJqXqpItiYUA9X0VNrvrMNyNk92B4Z4hzBUzO7Ejk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxQgBUeTBuyN+JwqjIpIWS6i5OlF/4xaLh84B2rMaig=;
 b=ZRuig3f7eOi/CLHzEYS9hV3c7Z4vdrgQWkpTMMYStDgdpNxffn9czAEl4eD6M6ORfu3gm8go6po7xGJHtgTxzNyDi1Hx1F2ZmSmWzqO8dUuVZ0hMN1JWLxInUxmR+y5kQTIHBf89KkwY/vFyo6cPrhlhRxMDpX+WcRPCkj7POQs=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BY5PR02MB6850.namprd02.prod.outlook.com (2603:10b6:a03:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:46:13 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 15:46:13 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for
 Versal DWC3 Controller
Thread-Topic: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for
 Versal DWC3 Controller
Thread-Index: AQHWe9j+PlxSy8oZg0WQBIs3MmmIKKlfcVoAgAEWjJA=
Date:   Wed, 9 Sep 2020 15:46:13 +0000
Message-ID: <BYAPR02MB589674F9C2EFC763AFC63BD2C1260@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-2-git-send-email-manish.narani@xilinx.com>
 <20200908230520.GA1102401@bogus>
In-Reply-To: <20200908230520.GA1102401@bogus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e7f3652-0efe-4840-f709-08d854d77b5e
x-ms-traffictypediagnostic: BY5PR02MB6850:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB685061ACDB2EB11AEE2FAE91C1260@BY5PR02MB6850.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UKcmu5SXuAPnrEx/VYF7Dx75j7tCsSYlX7YFSNldwGq5VRGpCKwTXQxURmbhwU3G/3OkutAC6IosN1K6SoOnGrGSIwjVetQ8b0H18N+b0n40DBmFEpPJ5FU4f/22j9/eymso6Vy6vS8q28AxPAa88GAsy/NPUzXrbUbExxpj0GIEAwXvKYE6szjY+U8VV9zkbbZNogyxo6GLXEdCDuRiEomYUEfz5WJmGJ0fudMfhHV12HXGLNwHN19LQEn/ErSj4kZ5vwK+MK88QSFwpq+FP5yGXGo+t/tyi6sm6Zm4SKqxAX0UG56WpuQL5FaSGXLM3QYJT1Fdmm8leQCbftojQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(8936002)(83380400001)(2906002)(54906003)(33656002)(71200400001)(9686003)(66476007)(66946007)(4326008)(55016002)(66446008)(64756008)(66556008)(76116006)(107886003)(6506007)(53546011)(316002)(186003)(7696005)(5660300002)(7416002)(478600001)(44832011)(52536014)(8676002)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9CTfkpjQMdi85PmN01LU+zmO7s0aVqUSX0M7aZ/UawyFyB3CFQAkPn9cm3Oxb81iGMNItD/mmalAglNLTCye5GhCR5ru/jg5RCCGTF6/Oc5JikW0pwBxU9OHP0h3u8Xhar6OLAHl+9BNboWiDx8h3zjz93pim72dx7xAunM2iGbgbKLdz0KtdWj40hedKVyQD8ONeZvHf4ii0Ygh1GDiSLmkl/o+vQSkl5gJMM2QudxrE0Bi/yeTBei6Szo8oHK13azEthkhIT0RldwQcRKutv8J24Q18gxX4I97VqNvJL2nWA0Ld4XwoDb9cW+KEZS9hSp3dSBCBskNryCl+uuoiavBcBbuf0fqZBrXDlv4KFW0bFZiPAkVPNWhCuvIShMvnyULT0YALJ3UGd+WkY3BAZFkoOO0Y8pPHWZEDME3+MI6SJrTi36VIUqC5nMVbW3zUnefTN+P0W5I2JdzAg8GpE5sNx4u0jyHEuePuEeyxGluq+rvR1xVbuE2vtyxSY1Jscw49t9igaQtdTRk/skEGmSVPc7DTJHpldbKbPDuuWgn7F33S3ULQa2gBD/+yvGWOGgS/9pKVlrwhb0nUlUlmcUCtpI4xJ2Ozmevw3u9URXnuJbUoCspllXAQNPNF3evvEh6Gl2JJbB0i/tQf7aapw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7f3652-0efe-4840-f709-08d854d77b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 15:46:13.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFO/se0PZi+n6tM7ezMcLGj9MKtRZj3qprSfFF4dMPCjRpezLoD5yW5pBbsWWl18mxhmRFizo7ewym9l+oQQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, September 9, 2020 4:35 AM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
> balbi@kernel.org; p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>
> Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation=
 for
> Versal DWC3 Controller
>=20
> On Thu, Aug 27, 2020 at 12:14:00AM +0530, Manish Narani wrote:
> > Add documentation for Versal DWC3 controller. Add required property
> > 'reg' for the same. Also add optional properties for snps,dwc3.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/usb/dwc3-xilinx.txt          | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > index 4aae5b2cef56..dd41ed831411 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > @@ -1,7 +1,8 @@
> >  Xilinx SuperSpeed DWC3 USB SoC controller
> >
> >  Required properties:
> > -- compatible:	Should contain "xlnx,zynqmp-dwc3"
> > +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-
> dwc3"
> > +- reg:		Base address and length of the register control block
> >  - clocks:	A list of phandles for the clocks listed in clock-names
> >  - clock-names:	Should contain the following:
> >    "bus_clk"	 Master/Core clock, have to be >=3D 125 MHz for SS
> > @@ -13,12 +14,19 @@ Required child node:
> >  A child node must exist to represent the core DWC3 IP block. The name =
of
> >  the node is not important. The content of the node is defined in dwc3.=
txt.
> >
> > +Optional properties for snps,dwc3:
> > +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding t=
his
> > +		flag configures Global SoC bus Configuration Register and
> > +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> > +- interrupt-names: This property provides the names of the interrupt i=
ds
> used
>=20
> You have to define what the names are. 'dwc_usb3' seems pretty pointless
> if only 1 name.

OK. I am planning to add more interrupt ids going ahead. For now I will rem=
ove
this interrupt name in v2. The interrupt name will be added along with othe=
r interrupt
names.

Thanks,
Manish
