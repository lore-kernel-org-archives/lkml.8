Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFCE2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k6EyRRzo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="r1VmxjuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEUB4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:56:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:47074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgEUB4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:56:45 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A504B4013B;
        Thu, 21 May 2020 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590026204; bh=bOA1Pdh8Hy5ARzAFI7GnAWsdJ32GSR8FX+8eOischRw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k6EyRRzoiYHtj/cgU8hz7wjiTKlZYd4ACWVmgVu509W1JAWKE8yscPp2lHKxSlDtw
         QlPiyUqkzawrdTc+Jq4mFNnyEjWzxwGNOByEk75RLYXHo/V3U0vaFHJr0bpTJLtQl7
         swr5zR/RF6fWllz0tRSfunFY9J/beJHTjCZ5WwTHebD/vxre0tKd6WRaMBzZ+qdWBy
         rb2tGh9G/+1jpu5PTqr98Kk6ov6gQ0ZpQsWuZQpY53vGcDVwBSU0cvudQV9TtEsLFb
         JHF3frrfdebqR8FSzTiCOSHD76YxQPZrw03iFXv8XzxJCqse2bnY5ms2T2z1KxV9HS
         +kOrPcKa0owmg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB381A0085;
        Thu, 21 May 2020 01:56:41 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 May 2020 18:55:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 20 May 2020 18:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXs23VVASZpReOdSYJKFn760QuML9nmBuDAyAWnJvAAG2LsIMh3FB4HeqQDekF2OKgEdyOBDvC9/wMZTMQm0I97PfvUQgzgYmySK7cDpD9106eCNAHvxgMFTo6hX2bKsmzMbs52FUG5EPjYWFhhkNKp4yadPn7on1Zagzmnd3Bqp2rBFuSWH9TAA+AgNhkkIaWuxbtT//lKFYCSFGPj+xOSgz3Bx7Ss8r7BIGPYJ35tmODLCEtSqEftku4WBzf5pInSYfKg1YZdmrzTHpV0MSAMUonaBmXnCTy6QXYTv4GAW1w7ARAALZbUKs2nTQ5g8SdZBFVQMb50FOZDSi4jiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOA1Pdh8Hy5ARzAFI7GnAWsdJ32GSR8FX+8eOischRw=;
 b=WTBdrj0ZHJo9qN3hC3GhjIkzRXvfUGwsAI5cZ01BrV0nttc0KhEkgN2/TsVdQqe5Z4EjQSIYUB270gpCYPERHlKccs2675A4NR/ARhWrteo7KLpeFm+REgACD+6UduFiPqscg8mrR1HRqptzyO/MC5qpjrANMVjHM9gv4dLyLCrXODes91H0g4WdZ9wZp0p3081w0BIQ9Bk/ppiZy0FrHi43wm5AvHPGTlL70nmS8KhDj/v4p7pXrhF0UD9Uhy+ogkBGddFMpth6u29y9jx40S28fIxTh778X4GYyM24dmu+USBNxjesQ6PJGokb8T4FH0OCJGndfOMsLg4IsAUbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOA1Pdh8Hy5ARzAFI7GnAWsdJ32GSR8FX+8eOischRw=;
 b=r1VmxjuDJ2Pn+0WXULF0c5Y8oG0Nzj3xV1gmvEYi5MubpDXQ4amm6GOtFNT0FnXkh0rhTrs5tj58sOWBT+kwcvSIEbD+s7nDEwDNQGqZvZprVBNKdEFrUjSRoPxfDt5jGvqFZROPQgstn9IpaUQCmCgvhWuvEUEZRVzPVff4Hf8=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 01:55:55 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 01:55:55 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jun Li <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Jun Li <lijun.kernel@gmail.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Topic: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
Thread-Index: AQHVjdstgzFrMkrXvkaRRkMvFUhS+Kio62yAgAAEAECAAiXGgIAAcduAgAAjyICAACvNgIAEFssAgABEXACAAATjAIAADt+AgAK3EgCAAA2YAA==
Date:   Thu, 21 May 2020 01:55:55 +0000
Message-ID: <1c16bdb6-8d8d-1e1b-f08b-b3963f905eb0@synopsys.com>
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
 <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
 <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com>
 <87h7wqmwrv.fsf@kernel.org>
 <CAKgpwJXfWv5=MDqBCADhe2iXf6eiP0GQ13Bwo9fkuU5kGO7dsw@mail.gmail.com>
 <87imgx35pg.fsf@kernel.org>
 <VE1PR04MB65283F16826D2254128073C589BD0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <3d757998-56f2-6fff-a724-f713867ae785@synopsys.com>
 <87ftc0xsig.fsf@kernel.org>
 <VE1PR04MB6528AB046FD441A5DDD83CD289BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <87d074xfbq.fsf@kernel.org>
 <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
 <e3b0ff51-70ab-7d16-2c7e-cacac7d97043@synopsys.com>
 <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
In-Reply-To: <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.7.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4fa23f5-73a1-4ddf-9f40-08d7fd2a197a
x-ms-traffictypediagnostic: BYAPR12MB3367:
x-microsoft-antispam-prvs: <BYAPR12MB33674EBB6AF9294601FD9BA7AAB70@BYAPR12MB3367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xvEV0TEaYqIDFj/S9IZwB/Vyt9xRzUHaoGVZDNw3QrSeFcYENBkXy8nBvSUY0OwZSSuubA614/5kuNosUeTLo/qDQRVceOwRMWnPvvgVe+N+bjMvU4/X+xqo4TpmtBMSh1FcKxFjE86dUL7h7xyLedYpq9cuBIjUGCxNXlwDrL/lKxpA3RYFT//SEfye45n+vRRjJzxnavmMPJ5h9P2vEgnRdrlf6lFXvbNv7P+tGzrUQL3mfyv7T3y17HLi9TrnDfExsu3TTWYcBAnkO4CMpGlstdMepCIHN+PlYBCadQZI/WSD1ec3zV266Hrc2Hz6aqRhKrkJa4TdouTjIcu8w0BDptHwYRfCKJ873nvff9173nuBbgog70wK+QOuBsx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(53546011)(66446008)(6506007)(186003)(71200400001)(478600001)(110136005)(54906003)(26005)(316002)(5660300002)(36756003)(31696002)(86362001)(6512007)(31686004)(6486002)(8676002)(8936002)(7416002)(2906002)(66476007)(64756008)(66556008)(76116006)(66946007)(2616005)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6+vJ/9vNA9AgkWc9zJSHAEqleqUw6fDRRyo8UZPPlmY73vkW5HpfzM6WKFBxwe6+NHvoLhiyKPxmeFireXMVEhYPFV52WFOHgCvXaXBKuwsIZMrY27c4WqwXX7l0fCOJRsv2G7mt2ax6m0c5XBl7/QWkSueIc8gBOKqxWdVvo0ltl2xI+2iKwFnoNtPGsXzM1XUSP9n0DmS362iIIZqFpdGGEv3bArODxm5UAV4uIZ23hb3K4QiznheazMH45IoqEe/+2xYRxCSG4s6zXscX7CV88hl9PT7eOgUuPJKIOA32y3nddHjtprehXv+rUSCgOI+LwQue5O7z3R0IWST7uAiaWAFkkqezbtLCeUwLvCTHlJhrWB/DTrxHFVRdEbghOEtQevm/gthxlkHHP3VOikjoIcYW8Eb7ZPBhZWsyZzz++X2P+Y3UhYiW1DhL4H9YasieYr909gvCr6xY2A1t0hMZm0mKPlsuMmZGGU8/pDk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC704407B2099F48952C8B201EE4D218@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fa23f5-73a1-4ddf-9f40-08d7fd2a197a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 01:55:55.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayparvnI9m1rg5o+l8JubWx+NSB/WGA5Wq1EHYxZC8yzqb3uCc3Q+WT9kY0LINX8YdzgS0w68/FGguUf2DJFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBKdW4gTGkgd3JvdGU6DQo+PiBIaQ0KPj4NCj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4NCj4+PiBTZW50OiAyMDIw5bm0NeaciDE55pelIDE0OjQ2DQo+Pj4g
VG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5v
cmc+OyBKdW4gTGkNCj4+PiA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4NCj4+PiBDYzogSm9obiBT
dHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgWXUNCj4+PiBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPjsgR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJvYg0KPj4+IEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+
OyBTaHVGYW4gTGVlDQo+Pj4gPHNodWZhbl9sZWVAcmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2Vy
dXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+Ow0KPj4+IFN1enVraSBLIFBvdWxv
c2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+OyBDaHVuZmVuZyBZdW4NCj4+PiA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBB
bmR5IFNoZXZjaGVua28NCj4+PiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGlu
IFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+Ow0KPj4+IEphY2sgUGhhbSA8
amFja3BAY29kZWF1cm9yYS5vcmc+OyBMaW51eCBVU0IgTGlzdCA8bGludXgtdXNiQHZnZXIua2Vy
bmVsLm9yZz47IG9wZW4NCj4+PiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJ
Q0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPj4+IFBldGVy
IENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMv
OV0gdXNiOiBkd2MzOiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3QgY2xlYXJlZCBieSBkZXZp
Y2UNCj4+PiBjb250cm9sbGVyDQo+Pj4NCj4+PiBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+IEp1
biBMaSB3cm90ZToNCj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+IEZy
b206IEZlbGlwZSBCYWxiaSA8YmFsYmlmQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEZlbGlwZSBC
YWxiaQ0KPj4+Pj4+IFNlbnQ6IDIwMjDlubQ15pyIMTbml6UgMTk6NTcNCj4+Pj4+PiBUbzogSnVu
IExpIDxqdW4ubGlAbnhwLmNvbT47IFRoaW5oIE5ndXllbg0KPj4+Pj4+IDxUaGluaC5OZ3V5ZW5A
c3lub3BzeXMuY29tPjsgSnVuIExpIDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPj4+Pj4+IENj
OiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz47IGxrbWwNCj4+Pj4+PiA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+
OyBHcmVnDQo+Pj4+Pj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
OyBSb2IgSGVycmluZw0KPj4+Pj4+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQg
PG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2h1RmFuDQo+Pj4+Pj4gTGVlIDxzaHVmYW5fbGVlQHJp
Y2h0ZWsuY29tPjsgSGVpa2tpIEtyb2dlcnVzDQo+Pj4+Pj4gPGhlaWtraS5rcm9nZXJ1c0BsaW51
eC5pbnRlbC5jb20+Ow0KPj4+Pj4+IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFy
bS5jb20+OyBDaHVuZmVuZyBZdW4NCj4+Pj4+PiA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT47
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ow0KPj4+Pj4+IEFuZHkgU2hldmNo
ZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IFZhbGVudGluIFNjaG5laWRlcg0KPj4+
Pj4+IDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT47IEphY2sgUGhhbSA8amFja3BAY29kZWF1
cm9yYS5vcmc+Ow0KPj4+Pj4+IExpbnV4IFVTQiBMaXN0IDxsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUNCj4+Pj4+PiBBTkQgRkxBVFRFTkVEIERFVklD
RSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47DQo+Pj4+Pj4gUGV0
ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPjsgVGhpbmggTmd1eWVuDQo+Pj4+Pj4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+Pj4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NCAzLzld
IHVzYjogZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0DQo+Pj4+Pj4gY2xlYXJlZCBi
eSBkZXZpY2UgY29udHJvbGxlcg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0K
Pj4+Pj4+IEp1biBMaSA8anVuLmxpQG54cC5jb20+IHdyaXRlczoNCj4+Pj4+Pj4+Pj4gSGkgVGhp
bmgsIGNvdWxkIHlvdSBjb21tZW50IHRoaXM/DQo+Pj4+Pj4+Pj4gWW91IG9ubHkgbmVlZCB0byB3
YWtlIHVwIHRoZSB1c2IyIHBoeSB3aGVuIGlzc3VpbmcgdGhlIGNvbW1hbmQNCj4+Pj4+Pj4+PiB3
aGlsZSBydW5uaW5nIGluIGhpZ2hzcGVlZCBvciBiZWxvdy4gSWYgeW91J3JlIHJ1bm5pbmcgaW4g
U1Mgb3INCj4+Pj4+Pj4+PiBoaWdoZXIsIGludGVybmFsbHkgdGhlIGNvbnRyb2xsZXIgZG9lcyBp
dCBmb3IgeW91IGZvciB1c2IzIHBoeS4NCj4+Pj4+Pj4+PiBJbiBKdW4ncyBjYXNlLCBpdCBzZWVt
cyBsaWtlIGl0IHRha2VzIGxvbmdlciBmb3IgaGlzIHBoeSB0byB3YWtlIHVwLg0KPj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4gSU1PLCBpbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQncyBmaW5lIHRvIGluY3Jl
YXNlIHRoZSBjb21tYW5kIHRpbWVvdXQuDQo+Pj4+Pj4+PiBJcyB0aGVyZSBhbiB1cHBlciBsaW1p
dCB0byB0aGlzPyBJcyAzMmsgY2xvY2sgdGhlIHNsb3dlc3QgdGhhdCBjYW4NCj4+Pj4+Pj4+IGJl
IGZlZCB0byB0aGUgUEhZIGFzIGEgc3VzcGVuZCBjbG9jaz8NCj4+Pj4+Pj4gWWVzLCAzMksgY2xv
Y2sgaXMgdGhlIHNsb3dlc3QsIFBlciBEV0MzIGRvY3VtZW50IG9uIFBvd2VyIERvd24NCj4+Pj4+
Pj4gU2NhbGUgKGJpdHMgMzE6MTkgb2YgR0NUTCk6DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICJQb3dlciBE
b3duIFNjYWxlIChQd3JEblNjYWxlKQ0KPj4+Pj4+PiBUaGUgVVNCMyBzdXNwZW5kX2NsayBpbnB1
dCByZXBsYWNlcyBwaXBlM19yeF9wY2xrIGFzIGEgY2xvY2sgc291cmNlDQo+Pj4+Pj4+IHRvIGEg
c21hbGwgcGFydCBvZiB0aGUgVVNCMyBjb250cm9sbGVyIHRoYXQgb3BlcmF0ZXMgd2hlbiB0aGUg
U1MNCj4+Pj4+Pj4gUEhZIGlzIGluIGl0cyBsb3dlc3QgcG93ZXIgKFAzKSBzdGF0ZSwgYW5kIHRo
ZXJlZm9yZSBkb2VzIG5vdCBwcm92aWRlIGEgY2xvY2suDQo+Pj4+Pj4+IFRoZSBQb3dlciBEb3du
IFNjYWxlIGZpZWxkIHNwZWNpZmllcyBob3cgbWFueSBzdXNwZW5kX2NsayBwZXJpb2RzDQo+Pj4+
Pj4+IGZpdCBpbnRvIGEgMTYga0h6IGNsb2NrIHBlcmlvZC4gV2hlbiBwZXJmb3JtaW5nIHRoZSBk
aXZpc2lvbiwgcm91bmQNCj4+Pj4+Pj4gdXAgdGhlIHJlbWFpbmRlci4NCj4+Pj4+Pj4gRm9yIGV4
YW1wbGUsIHdoZW4gdXNpbmcgYW4gOC1iaXQvMTYtYml0LzMyLWJpdCBQSFkgYW5kIDI1LU1Ieg0K
Pj4+Pj4+PiBTdXNwZW5kIGNsb2NrLCBQb3dlciBEb3duIFNjYWxlID0gMjUwMDAga0h6LzE2IGtI
eiA9IDEzJ2QxNTYzDQo+Pj4+Pj4+IChyb3VuZGVyIHVwKQ0KPj4+Pj4+PiBOb3RlOg0KPj4+Pj4+
PiAtIE1pbmltdW0gU3VzcGVuZCBjbG9jayBmcmVxdWVuY3kgaXMgMzIga0h6DQo+Pj4+Pj4+IC0g
TWF4aW11bSBTdXNwZW5kIGNsb2NrIGZyZXF1ZW5jeSBpcyAxMjUgTUh6Ig0KPj4+Pj4+IENvb2ws
IG5vdyBkbyB3ZSBoYXZlIGFuIHVwcGVyIGJvdW5kIGZvciBob3cgbWFueSBjbG9jayBjeWNsZXMg
aXQNCj4+Pj4+PiB0YWtlcyB0byB3YWtlIHVwIHRoZSBQSFk/DQo+Pj4+PiBNeSB1bmRlcnN0YW5k
aW5nIGlzIHRoaXMgZXAgY29tbWFuZCBkb2VzIG5vdCB3YWtlIHVwIHRoZSBTUyBQSFksIHRoZQ0K
Pj4+Pj4gU1MgUEhZIHN0aWxsIHN0YXlzIGF0IFAzIHdoZW4gZXhlY3V0ZSB0aGlzIGVwIGNvbW1h
bmQuIFRoZSB0aW1lDQo+Pj4+PiByZXF1aXJlZCBoZXJlIGlzIHRvIHdhaXQgY29udHJvbGxlciBj
b21wbGV0ZSBzb21ldGhpbmcgZm9yIHRoaXMgZXANCj4+Pj4+IGNvbW1hbmQgd2l0aCAzMksgY2xv
Y2suDQo+Pj4+IFNvcnJ5IEkgbWFkZSBhIG1pc3Rha2UuIFlvdSdyZSByaWdodC4gSnVzdCBjaGVj
a2VkIHdpdGggb25lIG9mIHRoZSBSVEwNCj4+Pj4gZW5naW5lZXJzLCBhbmQgaXQgZG9lc24ndCBu
ZWVkIHRvIHdha2UgdXAgdGhlIHBoeS4gSG93ZXZlciwgaWYgaXQgaXMNCj4+Pj4gZVNTIHNwZWVk
LCBpdCBtYXkgdGFrZSBsb25nZXIgdGltZSBhcyB0aGUgY29tbWFuZCBtYXkgYmUgY29tcGxldGlu
Zw0KPj4+PiB3aXRoIHRoZSBzdXNwZW5kIGNsb2NrLg0KPj4+Pg0KPj4+IFdoYXQncyB0aGUgdmFs
dWUgZm9yIEdDVExbNzo2XT8NCj4+IDInYjAwDQo+Pg0KPj4gVGhhbmtzDQo+PiBMaSBKdW4NCj4g
KFNvcnJ5IGZvciB0aGUgZGVsYXkgcmVwbHkpDQo+DQo+IElmIGl0J3MgMCwgdGhlbiB0aGUgcmFt
IGNsb2NrIHNob3VsZCBiZSB0aGUgc2FtZSBhcyB0aGUgYnVzX2Nsaywgd2hpY2gNCj4gaXMgb2Rk
IHNpbmNlIHlvdSBtZW50aW9uZWQgdGhhdCB0aGUgc3VzcGVuZF9jbGsgaXMgdXNlZCBpbnN0ZWFk
IHdoaWxlIGluIFAzLg0KDQpKdXN0IGNoZWNrZWQgd2l0aCB0aGUgUlRMIGVuZ2luZWVyLCBldmVu
IGlmIEdDVExbNzo2XSBpcyBzZXQgdG8gMCwgDQppbnRlcm5hbGx5IGl0IGNhbiBzdGlsbCBydW4g
d2l0aCBzdXNwZW5kIGNsb2NrIGR1cmluZyBQMy4NCg0KPiBBbnl3YXksIEkgd2FzIGxvb2tpbmcg
Zm9yIGEgd2F5IG1heWJlIHRvIGltcHJvdmUgdGhlIHNwZWVkIGR1cmluZw0KPiBpc3N1aW5nIGEg
Y29tbWFuZC4gT25lIHdheSBpcyB0byBzZXQgR1VTQjNQSVBFQ1RMWzE3XT0wLCBhbmQgaXQgc2hv
dWxkDQo+IHdha2V1cCB0aGUgcGh5IGFueXRpbWUuIEkgdGhpbmsgRmVsaXBlIHN1Z2dlc3RlZCBp
dC4gSXQncyBvZGQgdGhhdCBpdA0KPiBkb2Vzbid0IHdvcmsgZm9yIHlvdS4gSSBkb24ndCBoYXZl
IG90aGVyIGlkZWFzIGJlc2lkZSBpbmNyZWFzaW5nIHRoZQ0KPiBjb21tYW5kIHRpbWVvdXQuDQo+
DQoNCkluIGFueSBjYXNlLCBpbmNyZWFzaW5nIHRoZSB0aW1lb3V0IHNob3VsZCBiZSBmaW5lIHdp
dGggbWUuIEl0IG1heWJlIA0KZGlmZmljdWx0IHRvIGRldGVybWluZSB0aGUgbWF4IHRpbWVvdXQg
YmFzZSBvbiB0aGUgc2xvd2VzdCBjbG9jayByYXRlIA0KYW5kIG51bWJlciBvZiBjeWNsZXMuIERp
ZmZlcmVudCBjb250cm9sbGVyIGFuZCBjb250cm9sbGVyIHZlcnNpb25zIA0KYmVoYXZlIGRpZmZl
cmVudGx5IGFuZCBtYXkgaGF2ZSBkaWZmZXJlbnQgbnVtYmVyIG9mIGNsb2NrIGN5Y2xlcyB0byAN
CmNvbXBsZXRlIGEgY29tbWFuZC4NCg0KVGhlIFJUTCBlbmdpbmVlciByZWNvbW1lbmRlZCB0aW1l
b3V0IHRvIGJlIGF0IGxlYXN0IDFtcyAod2hpY2ggbWF5YmUgDQptb3JlIHRoYW4gdGhlIHBvbGxp
bmcgcmF0ZSBvZiB0aGlzIHBhdGNoKS4gSSdtIGZpbmUgd2l0aCBlaXRoZXIgdGhlIHJhdGUgDQpw
cm92aWRlZCBieSB0aGlzIHRlc3RlZCBwYXRjaCBvciBoaWdoZXIuDQoNCkJSLA0KVGhpbmgNCg==
