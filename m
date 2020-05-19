Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A92C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A69620758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OzHO9LAF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ppOSHT7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgESG25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:28:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54176 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbgESG24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:28:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D81B0C008F;
        Tue, 19 May 2020 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589869736; bh=OJYK2o7rFSAJ5Jy+qXq4k9RAcbccmfR52OSkmJtVaok=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OzHO9LAFHZNz4nqtpGhhYGABlhvauN2pS4+psVlduD9EVM6eUndp6KcdjUs9xUQ78
         LE586d+5D+d1ruz5jhvjoJ+MckKoLelRASXVRipEnHfWZ2BtLT6YoUZXj26W6F+Nuu
         CqioptcqAAkJAfN3zTV2Gjb95FENaz5e3Ki/KNWQiijDTw1Is4syWQElL/UlHSkH7F
         KqGw3OXBRQ6KHRthBpt7OlsX/L6Dbgi++62bkEnyqB4xeVWjBjlEIjypml4M8Pb1S+
         +XuBnDlmTukRI8OasxsS8M4SyOFBwWRB/WOc9l+CtOvNGxPO46fykG5JLSEMMoA+zN
         Ld8rx8itKGbwA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 40F90A0071;
        Tue, 19 May 2020 06:28:50 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 May 2020 23:28:50 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 18 May 2020 23:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0aDKdk5AdRrVMmgvOefZYnSgDtHOWL0/maWWjkRF02AqOMKbjMGLrTJjNlhcsaVY9h4+epr6gxUcqti5O693+3ZGiyeGtgBMjmQAkzWKybqzwy7EnkjeT2mxo3Rnv9fJMxeUxQXoGC9LI5K8L0sY/M78Govpc9ZtM6nyzvE4HQB7sH991sobNi2pHx1ZsumuXpsu0Ak3+dQJLyiOmhCquOiyM8ab+n86/6r2i/llAiIiWnHHr+M2AIzigxL4ju9ARUbT93t0oSn6c9hXl4mW49ZZjtJc/Jbmnio+nx0x5zibzuY/labRN0g/kqlbTP4Ipy7/YaIKvOOsq7QmbJQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJYK2o7rFSAJ5Jy+qXq4k9RAcbccmfR52OSkmJtVaok=;
 b=lDn54YZ69KTy6GWuhVlsy0U+IBoi8qr/qDvRScPy5YCOd3p2RnC/ANj5zq1iunr7fMPTH3D95B8PvVk9MvuXsmd0eBHezk2Q8FBObKvqFNPckRlx3kZRm1cfjNXZvgPloB+CmaPedNX3SMTaXsXU221DZ5Y5bMtriTRYQ2692rle4MIyOkgtEVbVDdTfV2MVQ4Cs0aPTZ/dKRrWzG09sZ01qWKBS+1ZgStG2bLPe7M4/GvxjPBdtbB6QXdoamjv+YrcRfufRS3slenssCqhi4Kc4IPVfQj0tvZubfabJSbAyFZVsoqvyZycuGqIRag9+XeU4ZgUtE9yIn7GwLf3ujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJYK2o7rFSAJ5Jy+qXq4k9RAcbccmfR52OSkmJtVaok=;
 b=ppOSHT7EutJqBZwYP6OmakVPytl+rU+On9nhbtTpdv25nZW4aL9St7f2JPPgxmVr/HfNiccYMb7M+hcvTpEOX0i5ECqOO5md2MHkin1ZRXB/H8Ir3cWw4r8KJEJ26BL1wYjKuCYnjhMx1WnqhwdV1j1N8+hqBBTjm60647NHA00=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB2758.namprd12.prod.outlook.com (2603:10b6:a03:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 06:28:48 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 06:28:47 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jun Li <jun.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Thread-Index: AQHVjdstgzFrMkrXvkaRRkMvFUhS+Kio62yAgAAEAECAAiXGgIAAcduAgAAjyICAACvNgIAEFssAgABEXAA=
Date:   Tue, 19 May 2020 06:28:47 +0000
Message-ID: <db7447c2-a39d-361f-8b35-a1d5c2705c89@synopsys.com>
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
In-Reply-To: <VE1PR04MB6528A50EA40BF40E4B09793789B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e86987-b0ec-4bf3-d64a-08d7fbbde369
x-ms-traffictypediagnostic: BYAPR12MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2758E3832182116AB57B2713AAB90@BYAPR12MB2758.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKLQ8YsCymh5ta5+pwQt3cFE3XGyV0b9vz1ko8kjNjmyE/f+mweJaPkjcQF3bwVuis7KbHw0VZJ6grrAjKQ1kWXeVBN62TkrQuXma8Z4vHQBRbrkMbhYJNEO53t8DyOlEUvfshtEI4KnU772rMHP16CaLqkaAaGAUR+vDJ3lW+NPojss+4EW6jdRJPIKMEwGO0we4qjFQsk1OxNdVYYsJ6qDUehHIWDsGnIuv2PCj6TqIiOiMnXWXHA0yWveFxQsnU9uaqNiZsgjo0zzYm+YGEhVnkdXbW3vvvM3MgxksIi2+CePSrPZoquwBMPtqjFKjztFSyGJR6lYdNcSYZBV1BPgZxdhPhfeQDZQwHmk44GNSRqHYukw7D4jAwvoSefw1gyYpdu9OHAdpKgW/q3t4p0yko+aCZgEF2khLPVKrc3W0fP9zz/ZNjarURIOgioDTdu59PwFOrrIvDi3wtAraOXFXPMqco2xRlsTP+iBCtpZ61zxkDyoojKVE8Fj3kOm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(71200400001)(31696002)(186003)(316002)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(7416002)(66446008)(5660300002)(26005)(6506007)(53546011)(66476007)(6512007)(66556008)(31686004)(478600001)(8676002)(64756008)(4326008)(2906002)(76116006)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DUp5k5v6d4e4knqn1UFnusTwz9pqzT03hxWJh8NJy4DwR8ELdAo+LfA7GNc+nvtYcIVJXRCjAyGS9eNJjHDQtVXQrh5b5gt/Hn8s4o++KKQh0wT7Iee4p4+yLKU7F+0fCcDT4dGMP74oSiFOGX/VOkc7hKQkQu6okzW12Cf+gP7mJTdYLNxsOY2/1npOTIm/38bW+R9XZz3i05niX96paxm8AlR26lVOA/Reh8HvSscmCBam5pTRXLHPMsIlhnp7IvLh2yp11CD5AH9IlQN8F2LGJsiT58pfSPTfS3LcO1Cx4oQX82u7J5RiOd2GMet3fuClqq8GgJo33evBhEUTdJa1zAqyrahzrmb+b6MG15cQG8JR/KTkdKvb8wLm3yoMEh6dwYE+C1D7v+yo6vXHJug+q9ylLARGKLo0RgT7qQ/Ob2km4VrUj0K0bIfddgHv20R061mrtnSa1nvAcEDfMU2Bvmcnz+6BOzXB+ZpGN7rCBoKOC06/vtzTRDMCgIcA
Content-Type: text/plain; charset="gb2312"
Content-ID: <313A1E8C1438C74D8BE1B0C93BE5A535@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e86987-b0ec-4bf3-d64a-08d7fbbde369
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 06:28:47.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AO29zeHbToDaJ9+/ckBijwCd3kC7yz60wedwxeIpRDs6gL1wAawcOzK66Cuzxej8yOBJqcHdmPuvF3MpjtekaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2758
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVuIExpIHdyb3RlOg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEZl
bGlwZSBCYWxiaSA8YmFsYmlmQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEZlbGlwZSBCYWxiaQ0K
Pj4gU2VudDogMjAyMMTqNdTCMTbI1SAxOTo1Nw0KPj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5j
b20+OyBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBKdW4gTGkNCj4+
IDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPj4gQ2M6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0
ekBsaW5hcm8ub3JnPjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFl1DQo+
PiBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz47IFJvYg0KPj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNodUZhbiBMZWUNCj4+IDxz
aHVmYW5fbGVlQHJpY2h0ZWsuY29tPjsgSGVpa2tpIEtyb2dlcnVzIDxoZWlra2kua3JvZ2VydXNA
bGludXguaW50ZWwuY29tPjsNCj4+IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFy
bS5jb20+OyBDaHVuZmVuZyBZdW4NCj4+IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPjsgSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPj4gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBWYWxlbnRpbiBTY2huZWlkZXIgPHZhbGVudGluLnNj
aG5laWRlckBhcm0uY29tPjsNCj4+IEphY2sgUGhhbSA8amFja3BAY29kZWF1cm9yYS5vcmc+OyBM
aW51eCBVU0IgTGlzdCA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IG9wZW4NCj4+IGxpc3Q6
T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZz47DQo+PiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+
OyBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+PiBTdWJqZWN0OiBS
RTogW1BBVENIIHY0IDMvOV0gdXNiOiBkd2MzOiBJbmNyZWFzZSB0aW1lb3V0IGZvciBDbWRBY3Qg
Y2xlYXJlZCBieSBkZXZpY2UNCj4+IGNvbnRyb2xsZXINCj4+DQo+Pg0KPj4gSGksDQo+Pg0KPj4g
SnVuIExpIDxqdW4ubGlAbnhwLmNvbT4gd3JpdGVzOg0KPj4+Pj4+IEhpIFRoaW5oLCBjb3VsZCB5
b3UgY29tbWVudCB0aGlzPw0KPj4+Pj4gWW91IG9ubHkgbmVlZCB0byB3YWtlIHVwIHRoZSB1c2Iy
IHBoeSB3aGVuIGlzc3VpbmcgdGhlIGNvbW1hbmQNCj4+Pj4+IHdoaWxlIHJ1bm5pbmcgaW4gaGln
aHNwZWVkIG9yIGJlbG93LiBJZiB5b3UncmUgcnVubmluZyBpbiBTUyBvcg0KPj4+Pj4gaGlnaGVy
LCBpbnRlcm5hbGx5IHRoZSBjb250cm9sbGVyIGRvZXMgaXQgZm9yIHlvdSBmb3IgdXNiMyBwaHku
IEluDQo+Pj4+PiBKdW4ncyBjYXNlLCBpdCBzZWVtcyBsaWtlIGl0IHRha2VzIGxvbmdlciBmb3Ig
aGlzIHBoeSB0byB3YWtlIHVwLg0KPj4+Pj4NCj4+Pj4+IElNTywgaW4gdGhpcyBjYXNlLCBJIHRo
aW5rIGl0J3MgZmluZSB0byBpbmNyZWFzZSB0aGUgY29tbWFuZCB0aW1lb3V0Lg0KPj4+PiBJcyB0
aGVyZSBhbiB1cHBlciBsaW1pdCB0byB0aGlzPyBJcyAzMmsgY2xvY2sgdGhlIHNsb3dlc3QgdGhh
dCBjYW4gYmUNCj4+Pj4gZmVkIHRvIHRoZSBQSFkgYXMgYSBzdXNwZW5kIGNsb2NrPw0KPj4+IFll
cywgMzJLIGNsb2NrIGlzIHRoZSBzbG93ZXN0LCBQZXIgRFdDMyBkb2N1bWVudCBvbiBQb3dlciBE
b3duIFNjYWxlDQo+Pj4gKGJpdHMgMzE6MTkgb2YgR0NUTCk6DQo+Pj4NCj4+PiAiUG93ZXIgRG93
biBTY2FsZSAoUHdyRG5TY2FsZSkNCj4+PiBUaGUgVVNCMyBzdXNwZW5kX2NsayBpbnB1dCByZXBs
YWNlcyBwaXBlM19yeF9wY2xrIGFzIGEgY2xvY2sgc291cmNlIHRvDQo+Pj4gYSBzbWFsbCBwYXJ0
IG9mIHRoZSBVU0IzIGNvbnRyb2xsZXIgdGhhdCBvcGVyYXRlcyB3aGVuIHRoZSBTUyBQSFkgaXMN
Cj4+PiBpbiBpdHMgbG93ZXN0IHBvd2VyIChQMykgc3RhdGUsIGFuZCB0aGVyZWZvcmUgZG9lcyBu
b3QgcHJvdmlkZSBhIGNsb2NrLg0KPj4+IFRoZSBQb3dlciBEb3duIFNjYWxlIGZpZWxkIHNwZWNp
ZmllcyBob3cgbWFueSBzdXNwZW5kX2NsayBwZXJpb2RzIGZpdA0KPj4+IGludG8gYSAxNiBrSHog
Y2xvY2sgcGVyaW9kLiBXaGVuIHBlcmZvcm1pbmcgdGhlIGRpdmlzaW9uLCByb3VuZCB1cCB0aGUN
Cj4+PiByZW1haW5kZXIuDQo+Pj4gRm9yIGV4YW1wbGUsIHdoZW4gdXNpbmcgYW4gOC1iaXQvMTYt
Yml0LzMyLWJpdCBQSFkgYW5kIDI1LU1IeiBTdXNwZW5kDQo+Pj4gY2xvY2ssIFBvd2VyIERvd24g
U2NhbGUgPSAyNTAwMCBrSHovMTYga0h6ID0gMTMnZDE1NjMgKHJvdW5kZXIgdXApDQo+Pj4gTm90
ZToNCj4+PiAtIE1pbmltdW0gU3VzcGVuZCBjbG9jayBmcmVxdWVuY3kgaXMgMzIga0h6DQo+Pj4g
LSBNYXhpbXVtIFN1c3BlbmQgY2xvY2sgZnJlcXVlbmN5IGlzIDEyNSBNSHoiDQo+PiBDb29sLCBu
b3cgZG8gd2UgaGF2ZSBhbiB1cHBlciBib3VuZCBmb3IgaG93IG1hbnkgY2xvY2sgY3ljbGVzIGl0
IHRha2VzIHRvIHdha2UgdXANCj4+IHRoZSBQSFk/DQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhp
cyBlcCBjb21tYW5kIGRvZXMgbm90IHdha2UgdXAgdGhlIFNTIFBIWSwNCj4gdGhlIFNTIFBIWSBz
dGlsbCBzdGF5cyBhdCBQMyB3aGVuIGV4ZWN1dGUgdGhpcyBlcCBjb21tYW5kLiBUaGUgdGltZQ0K
PiByZXF1aXJlZCBoZXJlIGlzIHRvIHdhaXQgY29udHJvbGxlciBjb21wbGV0ZSBzb21ldGhpbmcg
Zm9yIHRoaXMgZXANCj4gY29tbWFuZCB3aXRoIDMySyBjbG9jay4NCg0KU29ycnkgSSBtYWRlIGEg
bWlzdGFrZS4gWW91J3JlIHJpZ2h0LiBKdXN0IGNoZWNrZWQgd2l0aCBvbmUgb2YgdGhlIFJUTCAN
CmVuZ2luZWVycywgYW5kIGl0IGRvZXNuJ3QgbmVlZCB0byB3YWtlIHVwIHRoZSBwaHkuIEhvd2V2
ZXIsIGlmIGl0IGlzIGVTUyANCnNwZWVkLCBpdCBtYXkgdGFrZSBsb25nZXIgdGltZSBhcyB0aGUg
Y29tbWFuZCBtYXkgYmUgY29tcGxldGluZyB3aXRoIHRoZSANCnN1c3BlbmQgY2xvY2suDQoNCkJS
LA0KVGhpbmgNCg0KDQo+DQo+PiBUaGVuIHdlIGNhbiBqdXN0IHNldCB0aGUgdGltZSB0byB0aGF0
IHVwcGVyIGJvdW5kLg0KPiBQZXIgbXkgdGVzdCB3aXRoIHRyYWNlLCB0aGUgdGltZSBpcyBhYm91
dCA0MDB1cyh+MTMgY3ljbGVzKS4NCj4NCj4gVGhhbmtzDQo+IExpIEp1bg0KPj4gLS0NCj4+IGJh
bGJpDQoNCg==
