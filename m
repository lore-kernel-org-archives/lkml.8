Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AECCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1BE20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="baAYUZwA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="w9PEzd5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEUBHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:07:48 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45850 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgEUBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:07:48 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5CB5340526;
        Thu, 21 May 2020 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590023267; bh=mYF/CFCy4ykfjt9GQuWpcjcMorrQ37Xnrt9OrxFt2BM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=baAYUZwADLBdwI7zKQHWJHtg8FHUecpkdGQe9I6BSWzJ+8enm8pDTM8Oqq7C+KT9e
         57VvnJTLr4lKQVDgO61Wuy6MjV4PZtyirVwsVAO9EkwIICAAHdQzSH7y0d0hYXLxbr
         zMYntdalVEspZ+nVGz1WK0krQ+Qb2ase0Sji4nQOtyytnUGZMcJlCFxBtUjOR52iPR
         KS9zYuMC8lp6iH/vcGybcqArOkbxEXAG2Xq4hlug33X2qG1+6SFRYQyIEUK3VOqxmu
         yAfiGlKPpL7USeVk4IE40ped+rp6RgjlfqrRKUyNoRkRp1WcAy7syimF7AiLmZK8Tb
         2l/pU4NpiJVVg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 51691A0069;
        Thu, 21 May 2020 01:07:43 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 May 2020 18:07:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 20 May 2020 18:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVcbr1CbszZUQGJ321GfcROydzy6vx6aeBHn48EXywhdFpNMq5cc/MbOtl/fQT8uBgLvMzZDh/8Drwg3dXrK/aeakIeg1G9PKtHu7IUpBddo/fULYayJtDQL3eJhyFAE+tk9Uxqm4oxtTsrSNvQ4VoDrS9clcuxq/DQ0dERzLC0Kv3vUIFEFXzG3XibgFqc1xsL0P9w1APK0tlBXF4E/6vU0IzfSiJWiczchxYVQBHF3V8ONwDbgurIjS6soYjeEjhqnGUZiBcEdV3isGtT7jKk/YoSexez+YDF6yCXaekYlw22yVTvEdUBLPXiwJ/EB0Lv8+ab/q0QXZ5OooOxcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYF/CFCy4ykfjt9GQuWpcjcMorrQ37Xnrt9OrxFt2BM=;
 b=N/h6IAobBN2wP6dIh7eyz0Y6CYh2W7F55ZtfWt8Xo/ASnnAMJyJeqYT+bW3PV8HZw2dnnakMhlSCm+Nt4znCf6Jp7vCsMKHZZae9IzwKLji9xrhwUAkzPEcpwsvnZPCg2+QbhORX9yAqoUZW1UBT/wr76SLcIW1dEWnZtUcY5JvobY0sQTQHWJnqPxYUSeI7kJNCtvFQ+q3RasZ/ghPwX1A/261UiedC3udZFwlQAtOe8ocaEV0XePp8rtOKyW0C03JYhmxgkuMIcme2y4tisbZ310+la/Oly0gLVA6AZZ2SPIMIKd2IF2hvOI93uwTqb8OJEsZsbPlMdjwyLuLg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYF/CFCy4ykfjt9GQuWpcjcMorrQ37Xnrt9OrxFt2BM=;
 b=w9PEzd5UoF8Fa2HC2hZBNY+FSIQGbshak3l79Rb/nLqw+IsaopyjXhn+Pa0uQfB/c3HNrQa5UcQopGOKIsp0IUVPX1xWx2etnzxplxYILDxDvgSWU6sizoOlBdOy6ditf2Z7aoe0SbIGr1MuwfNTxYrQzxeW3MAU9JqtW1kMBKE=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 01:07:15 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 01:07:15 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jun Li <jun.li@nxp.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
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
Thread-Index: AQHVjdstgzFrMkrXvkaRRkMvFUhS+Kio62yAgAAEAECAAiXGgIAAcduAgAAjyICAACvNgIAEFssAgABEXACAAATjAIAADt+AgAK3EgA=
Date:   Thu, 21 May 2020 01:07:14 +0000
Message-ID: <bbfbd3f7-4908-5529-1a4e-29469e794b27@synopsys.com>
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
In-Reply-To: <VE1PR04MB65286728B9546B5FAA818A0A89B90@VE1PR04MB6528.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 7987def9-52ad-4727-17d2-08d7fd234cc9
x-ms-traffictypediagnostic: BYAPR12MB2823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28234CA0EEB2C6CE41B7D92BAAB70@BYAPR12MB2823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glwWXtm7FIXlPOv1anbBxAGzpJMe6Wu9jwkHe7la3A2JrEj+G77UNHvh4JCqUuei4baTrQItvmm59dCFTCaBm60whKJPBZ+1Cm1ILwAf1PUyY+5k+zp0u0LU9XYqwABfHYxNjbruXT3VbE9I6PVzKDdEFvIa5BWgS8swKsYSLhyFGd7aMNSy6KMVeGVVG27QrVHJ0VNXslf4MeeB6HXaGzs0O65RR4Di0UnGZzu54YHFQ2YNfkvTGx0o9prI16xxcwwHiM5Lt/YC6haIbm/lmXBDBjldR0EE2h1GGTAqzaFEPnA2/esz7hbFZTutifLMXyf38U3K5oLzPwcAQz7fBBlCaftsk590e34fx7NePU5TaVKh+wVJw1hdOD8Wa8d9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(6486002)(186003)(110136005)(6506007)(53546011)(66556008)(66946007)(54906003)(316002)(2616005)(2906002)(76116006)(66476007)(36756003)(26005)(64756008)(66446008)(8936002)(8676002)(5660300002)(86362001)(478600001)(4326008)(7416002)(31696002)(6512007)(71200400001)(31686004)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FIhmN7gKdNhZzxZxfo+0izAN390D7Wi88EiLPzphoxMVKEH+3WfWVL26GGtnKYANm/eitruBMEUhmLppDcEYfUH28kLV2E7ZbvOjNzd9CCqpvOUrwMMkcu17VD65PtP4Snm1KzDVVL9EMFl3FDy+jjaHyH2Zg9Qz2iBzCQec+iWG3ojPcXEBeP4P17wMeLaqysINL+3F6heiR2KOtNAvw5HbSIQYx5x1XvKzW3cgRREbfGDcMaIiIr+UuFDd/umI/W49Em3Sj/3YYloOQQw2ZPryTpTY7hWbZkKx05AnbWdlB3jqVRWSS0XX9g5dJ6FbPU12FpflQoz+Mkq2cIzOh0vr1r6thgno6oYdLZeD2QO+7hp5qlvT0p205QRkFwceYY41MA+udLZIFycpHwBxLkYBeuFcxF1FGRRrPAFjnIzNv+UGUL8PXVPGBU/S3YsBO4IEawMUEpPgMko7a79y1oDxrJ2Iu+gM6czWYH7LWoQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80BFB3EC43AE82428CD8C6C849ABC083@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987def9-52ad-4727-17d2-08d7fd234cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 01:07:14.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQWUlueC0S7mJ6c8tFM3iNwpJixfoxjDAPsyHbkCpjRhSE924fqBDm6JRp3rPaTWpyV2G9iQjk/52DKjbSM5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVuIExpIHdyb3RlOg0KPiBIaQ0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
IEZyb206IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4+IFNlbnQ6
IDIwMjDlubQ15pyIMTnml6UgMTQ6NDYNCj4+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsg
RmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPjsgSnVuIExpDQo+PiA8bGlqdW4ua2VybmVs
QGdtYWlsLmNvbT4NCj4+IENjOiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz47
IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBZdQ0KPj4gQ2hlbiA8Y2hlbnl1
NTZAaHVhd2VpLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBSb2INCj4+IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFu
ZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBTaHVGYW4gTGVlDQo+PiA8c2h1ZmFuX2xlZUByaWNo
dGVrLmNvbT47IEhlaWtraSBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNv
bT47DQo+PiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPjsgQ2h1bmZl
bmcgWXVuDQo+PiA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT47IEhhbnMgZGUgR29lZGUgPGhk
ZWdvZWRlQHJlZGhhdC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4+IDxhbmR5LnNoZXZjaGVua29A
Z21haWwuY29tPjsgVmFsZW50aW4gU2NobmVpZGVyIDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNv
bT47DQo+PiBKYWNrIFBoYW0gPGphY2twQGNvZGVhdXJvcmEub3JnPjsgTGludXggVVNCIExpc3Qg
PGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuDQo+PiBsaXN0Ok9QRU4gRklSTVdBUkUg
QU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc+Ow0KPj4gUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPg0KPj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAzLzldIHVzYjogZHdjMzogSW5jcmVhc2UgdGltZW91dCBmb3IgQ21kQWN0
IGNsZWFyZWQgYnkgZGV2aWNlDQo+PiBjb250cm9sbGVyDQo+Pg0KPj4gVGhpbmggTmd1eWVuIHdy
b3RlOg0KPj4+IEp1biBMaSB3cm90ZToNCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4+PiBGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpZkBnbWFpbC5jb20+IE9uIEJlaGFsZiBP
ZiBGZWxpcGUgQmFsYmkNCj4+Pj4+IFNlbnQ6IDIwMjDlubQ15pyIMTbml6UgMTk6NTcNCj4+Pj4+
IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgVGhpbmggTmd1eWVuDQo+Pj4+PiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT47IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4NCj4+
Pj4+IENjOiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz47IGxrbWwNCj4+Pj4+
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWXUgQ2hlbiA8Y2hlbnl1NTZAaHVhd2Vp
LmNvbT47IEdyZWcNCj4+Pj4+IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgUm9iIEhlcnJpbmcNCj4+Pj4+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxh
bmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2h1RmFuDQo+Pj4+PiBMZWUgPHNodWZhbl9sZWVA
cmljaHRlay5jb20+OyBIZWlra2kgS3JvZ2VydXMNCj4+Pj4+IDxoZWlra2kua3JvZ2VydXNAbGlu
dXguaW50ZWwuY29tPjsNCj4+Pj4+IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFy
bS5jb20+OyBDaHVuZmVuZyBZdW4NCj4+Pj4+IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPjsg
SGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47DQo+Pj4+PiBBbmR5IFNoZXZjaGVu
a28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBWYWxlbnRpbiBTY2huZWlkZXINCj4+Pj4+
IDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT47IEphY2sgUGhhbSA8amFja3BAY29kZWF1cm9y
YS5vcmc+Ow0KPj4+Pj4gTGludXggVVNCIExpc3QgPGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc+
OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRQ0KPj4+Pj4gQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJF
RSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPj4+Pj4gUGV0ZXIgQ2hl
biA8cGV0ZXIuY2hlbkBueHAuY29tPjsgVGhpbmggTmd1eWVuDQo+Pj4+PiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjQgMy85XSB1c2I6IGR3
YzM6IEluY3JlYXNlIHRpbWVvdXQgZm9yIENtZEFjdA0KPj4+Pj4gY2xlYXJlZCBieSBkZXZpY2Ug
Y29udHJvbGxlcg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBIaSwNCj4+Pj4+DQo+Pj4+PiBKdW4gTGkg
PGp1bi5saUBueHAuY29tPiB3cml0ZXM6DQo+Pj4+Pj4+Pj4gSGkgVGhpbmgsIGNvdWxkIHlvdSBj
b21tZW50IHRoaXM/DQo+Pj4+Pj4+PiBZb3Ugb25seSBuZWVkIHRvIHdha2UgdXAgdGhlIHVzYjIg
cGh5IHdoZW4gaXNzdWluZyB0aGUgY29tbWFuZA0KPj4+Pj4+Pj4gd2hpbGUgcnVubmluZyBpbiBo
aWdoc3BlZWQgb3IgYmVsb3cuIElmIHlvdSdyZSBydW5uaW5nIGluIFNTIG9yDQo+Pj4+Pj4+PiBo
aWdoZXIsIGludGVybmFsbHkgdGhlIGNvbnRyb2xsZXIgZG9lcyBpdCBmb3IgeW91IGZvciB1c2Iz
IHBoeS4NCj4+Pj4+Pj4+IEluIEp1bidzIGNhc2UsIGl0IHNlZW1zIGxpa2UgaXQgdGFrZXMgbG9u
Z2VyIGZvciBoaXMgcGh5IHRvIHdha2UgdXAuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSU1PLCBpbiB0
aGlzIGNhc2UsIEkgdGhpbmsgaXQncyBmaW5lIHRvIGluY3JlYXNlIHRoZSBjb21tYW5kIHRpbWVv
dXQuDQo+Pj4+Pj4+IElzIHRoZXJlIGFuIHVwcGVyIGxpbWl0IHRvIHRoaXM/IElzIDMyayBjbG9j
ayB0aGUgc2xvd2VzdCB0aGF0IGNhbg0KPj4+Pj4+PiBiZSBmZWQgdG8gdGhlIFBIWSBhcyBhIHN1
c3BlbmQgY2xvY2s/DQo+Pj4+Pj4gWWVzLCAzMksgY2xvY2sgaXMgdGhlIHNsb3dlc3QsIFBlciBE
V0MzIGRvY3VtZW50IG9uIFBvd2VyIERvd24NCj4+Pj4+PiBTY2FsZSAoYml0cyAzMToxOSBvZiBH
Q1RMKToNCj4+Pj4+Pg0KPj4+Pj4+ICJQb3dlciBEb3duIFNjYWxlIChQd3JEblNjYWxlKQ0KPj4+
Pj4+IFRoZSBVU0IzIHN1c3BlbmRfY2xrIGlucHV0IHJlcGxhY2VzIHBpcGUzX3J4X3BjbGsgYXMg
YSBjbG9jayBzb3VyY2UNCj4+Pj4+PiB0byBhIHNtYWxsIHBhcnQgb2YgdGhlIFVTQjMgY29udHJv
bGxlciB0aGF0IG9wZXJhdGVzIHdoZW4gdGhlIFNTDQo+Pj4+Pj4gUEhZIGlzIGluIGl0cyBsb3dl
c3QgcG93ZXIgKFAzKSBzdGF0ZSwgYW5kIHRoZXJlZm9yZSBkb2VzIG5vdCBwcm92aWRlIGEgY2xv
Y2suDQo+Pj4+Pj4gVGhlIFBvd2VyIERvd24gU2NhbGUgZmllbGQgc3BlY2lmaWVzIGhvdyBtYW55
IHN1c3BlbmRfY2xrIHBlcmlvZHMNCj4+Pj4+PiBmaXQgaW50byBhIDE2IGtIeiBjbG9jayBwZXJp
b2QuIFdoZW4gcGVyZm9ybWluZyB0aGUgZGl2aXNpb24sIHJvdW5kDQo+Pj4+Pj4gdXAgdGhlIHJl
bWFpbmRlci4NCj4+Pj4+PiBGb3IgZXhhbXBsZSwgd2hlbiB1c2luZyBhbiA4LWJpdC8xNi1iaXQv
MzItYml0IFBIWSBhbmQgMjUtTUh6DQo+Pj4+Pj4gU3VzcGVuZCBjbG9jaywgUG93ZXIgRG93biBT
Y2FsZSA9IDI1MDAwIGtIei8xNiBrSHogPSAxMydkMTU2Mw0KPj4+Pj4+IChyb3VuZGVyIHVwKQ0K
Pj4+Pj4+IE5vdGU6DQo+Pj4+Pj4gLSBNaW5pbXVtIFN1c3BlbmQgY2xvY2sgZnJlcXVlbmN5IGlz
IDMyIGtIeg0KPj4+Pj4+IC0gTWF4aW11bSBTdXNwZW5kIGNsb2NrIGZyZXF1ZW5jeSBpcyAxMjUg
TUh6Ig0KPj4+Pj4gQ29vbCwgbm93IGRvIHdlIGhhdmUgYW4gdXBwZXIgYm91bmQgZm9yIGhvdyBt
YW55IGNsb2NrIGN5Y2xlcyBpdA0KPj4+Pj4gdGFrZXMgdG8gd2FrZSB1cCB0aGUgUEhZPw0KPj4+
PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoaXMgZXAgY29tbWFuZCBkb2VzIG5vdCB3YWtlIHVwIHRo
ZSBTUyBQSFksIHRoZQ0KPj4+PiBTUyBQSFkgc3RpbGwgc3RheXMgYXQgUDMgd2hlbiBleGVjdXRl
IHRoaXMgZXAgY29tbWFuZC4gVGhlIHRpbWUNCj4+Pj4gcmVxdWlyZWQgaGVyZSBpcyB0byB3YWl0
IGNvbnRyb2xsZXIgY29tcGxldGUgc29tZXRoaW5nIGZvciB0aGlzIGVwDQo+Pj4+IGNvbW1hbmQg
d2l0aCAzMksgY2xvY2suDQo+Pj4gU29ycnkgSSBtYWRlIGEgbWlzdGFrZS4gWW91J3JlIHJpZ2h0
LiBKdXN0IGNoZWNrZWQgd2l0aCBvbmUgb2YgdGhlIFJUTA0KPj4+IGVuZ2luZWVycywgYW5kIGl0
IGRvZXNuJ3QgbmVlZCB0byB3YWtlIHVwIHRoZSBwaHkuIEhvd2V2ZXIsIGlmIGl0IGlzDQo+Pj4g
ZVNTIHNwZWVkLCBpdCBtYXkgdGFrZSBsb25nZXIgdGltZSBhcyB0aGUgY29tbWFuZCBtYXkgYmUg
Y29tcGxldGluZw0KPj4+IHdpdGggdGhlIHN1c3BlbmQgY2xvY2suDQo+Pj4NCj4+IFdoYXQncyB0
aGUgdmFsdWUgZm9yIEdDVExbNzo2XT8NCj4gMidiMDANCj4NCj4gVGhhbmtzDQo+IExpIEp1bg0K
DQooU29ycnkgZm9yIHRoZSBkZWxheSByZXBseSkNCg0KSWYgaXQncyAwLCB0aGVuIHRoZSByYW0g
Y2xvY2sgc2hvdWxkIGJlIHRoZSBzYW1lIGFzIHRoZSBidXNfY2xrLCB3aGljaCANCmlzIG9kZCBz
aW5jZSB5b3UgbWVudGlvbmVkIHRoYXQgdGhlIHN1c3BlbmRfY2xrIGlzIHVzZWQgaW5zdGVhZCB3
aGlsZSBpbiBQMy4NCg0KQW55d2F5LCBJIHdhcyBsb29raW5nIGZvciBhIHdheSBtYXliZSB0byBp
bXByb3ZlIHRoZSBzcGVlZCBkdXJpbmcgDQppc3N1aW5nIGEgY29tbWFuZC4gT25lIHdheSBpcyB0
byBzZXQgR1VTQjNQSVBFQ1RMWzE3XT0wLCBhbmQgaXQgc2hvdWxkIA0Kd2FrZXVwIHRoZSBwaHkg
YW55dGltZS4gSSB0aGluayBGZWxpcGUgc3VnZ2VzdGVkIGl0LiBJdCdzIG9kZCB0aGF0IGl0IA0K
ZG9lc24ndCB3b3JrIGZvciB5b3UuIEkgZG9uJ3QgaGF2ZSBvdGhlciBpZGVhcyBiZXNpZGUgaW5j
cmVhc2luZyB0aGUgDQpjb21tYW5kIHRpbWVvdXQuDQoNClRoYW5rcywNClRoaW5oDQoNCg==
