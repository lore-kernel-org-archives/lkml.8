Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366E4206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HFOCghxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHXUmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:42:07 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:1120
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgHXUmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:42:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJawFdEkL8wueJ4CmU5zl1visYEbPLMZ4O/3+tRj17r9xFGChwVJNeCWxEMC4zR+UtIqTBTtAGBEv3XNoRsq/Ul/DVam8JeBvTBHNHDf7YmFKniEtk/IyGUG4FMuEHEnG4H8dM8+sbV5nEnLPboEH9XKgdzKLtyygpT4PgBMpUASx0jYDMFj7Y9mza4tV4Dl7BKGYEdGEWpEA3MT59Y+KmnO4ahojC4LVqn0udaV5Fo4O4xj5CrfDQG6ouLH6ZoFCXMgMsBkTVlsijcTFvVmu0miw5XteJOfpsxdtTXSHHFsOTI2CyuiQJZaXgziUNPUut7w8YWPWUe8Tk2e4IXzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3h9RuDdaynY52zFaPIz8eGJvthApV7ZGF9ySU7JR+Y=;
 b=Q2QAhPnw3yo5penziFsf2YTjTwH+hQGGbs+ioTkgyfifkkGbl7SXqb/ZfiMsbLPFXWL7z8a/4VvrXXVqlh2dHXfrL356hEjdqRzs12nx544L+YQDzV1Jd/hM5HJdmZnrzSpp4T8BSwt1y4CHY9iWhlWSStuOxN0sdlmM6JXzgjWfvGq7A0praKvqurQc+0dRVxf17zZsxRNQgy5w13fg+jj3OJ+9D9x/gbsivqTFoyBavsFK2B3/61wsz4rNz7QWPVrxWnHzyfLdu6ww8Ae0uOFx0MQwBU9uEy2LhZCb1zrCeyIeCO3Wja4wqUlNnHBubpnlphKIFlmjTqIr7rtvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3h9RuDdaynY52zFaPIz8eGJvthApV7ZGF9ySU7JR+Y=;
 b=HFOCghxaumEVw2pWyT1YgImbomsvZP0E74sYbGAsDJvi5ZhTMWOAMkIJIh8ibr3IikwL+l9SCdTOuRAk0XbpMrCsyGc9TExhWVqzVhFzGWwGUKkq1r1bxsoofuovvpCkrm1LIgheqOuW178fXIPAkyhnfuBo2J6XF++zmuc90HU=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BY5PR02MB6420.namprd02.prod.outlook.com (2603:10b6:a03:1b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 20:42:02 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 20:42:02 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Suman Anna <s-anna@ti.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomas Evensen <tomase@xilinx.com>
Subject: RE: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
Thread-Topic: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
Thread-Index: AQHWToklQms2JpjNc0ijdq2TU5NNUakHZ8mAgAMljICAACg9AIARetmAgBWf4ICAEAtpAIAGNF2A
Date:   Mon, 24 Aug 2020 20:42:02 +0000
Message-ID: <BYAPR02MB4407622C9232A249A14D3E31B5560@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200630024922.32491-1-s-anna@ti.com>
 <20200630024922.32491-2-s-anna@ti.com> <20200714171553.GA2522956@bogus>
 <20200716171903.GA3286345@xps15>
 <alpine.DEB.2.21.2007161232400.3886@sstabellini-ThinkPad-T480s>
 <b7415d48-a354-5610-a657-08cdefc482a6@ti.com>
 <8ba1f240-df9a-d63e-5c05-1a4a13e03213@ti.com>
 <d818fe7b-26d6-2b3f-3155-87fc58f5b273@ti.com>
In-Reply-To: <d818fe7b-26d6-2b3f-3155-87fc58f5b273@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b467a1ef-0ca3-47c7-d5fc-08d8486e280f
x-ms-traffictypediagnostic: BY5PR02MB6420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB64208507A4AD497601C056E0B5560@BY5PR02MB6420.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBKEdzZvwCmglsehJF7uEKEJkgo/czlkPhNQ3+pjbfj4te6Y7gyQgaoiZjw3qcMCnwqe84hn00kS5MKl0ry/PpnuRU/b8E/snv6OeqSOfups/Mb3YIFoX3zcY5uFK02wCSFmF1Vzu4nNFIzCie5SvLiPvS3HcTn0++f1XhUQ+E3Q2suygQr53PNVE1iHbFB96S2xTsq0to5v2ZOG/DwkK7G9oyhTVc9lSV7WKy/eCffIWUoSuShVIVLw+fF2J+jccSHAi0tG1dxH29q4ptBZ4Q5YgjddE8HEh/AuAivdgWLK5JgE4AIVCM3zpkne7T02KPznUqBz87Fr9haxxAcis5tS2v9XTrBpeYsqizZYTjfbPlIiKxc2w8flkvzGLobbbRfcnRAJNRRDx9yG0Ix10g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(136003)(376002)(396003)(346002)(366004)(39860400002)(107886003)(76116006)(64756008)(9686003)(33656002)(478600001)(966005)(2906002)(186003)(66946007)(66556008)(66476007)(66446008)(55016002)(26005)(110136005)(316002)(71200400001)(6506007)(8936002)(5660300002)(4326008)(53546011)(8676002)(54906003)(52536014)(83380400001)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DgmRVXJsp3ReDdUbRPVsatcMWLwYGG72AH0BsDMMqrPP6f5gZqSBaiQElb8MlmPR4ACW0/TbznpYxT6dSsRyxmtAtz8xv1gknc+G6Ph25p/DwF10Qj9r+fCLzvGFNJ9BjIc+tDfwGA1YJy2LQRX/2CcCZr9W1erzQzlkwEKCf2z1nDVFBFG9RCAYFlhXPMgtJSmH12tczgm4EbAacyUNh2lX48sdwvMxAAWBnctSVvUS3yDiqqPS3ddEoQCkEdmGfHF3v14qU+uWvEXtx5FjqypRv/nkbsw/VLV2VSTR44Sv2SY8u5S7+f65bvBtnmPbcxTdYC0ucwIfrllem1ktqdcZTgbgeiMpSUN4wHFo/GvPfMfh2iTnfewC4GdfeIi6bP/3+tiWsEDSkVXVzHRpaNCSSVIkW4vE/iP2iEa8B42rza1IGnI75md3UMG4rQg5exU2GJm+KzIhERgWGf29lokzppdgJQ01Xe3yg511gYYkYi0HiPLd+JeNgmWVcDJFqPdx2jUWOtENCUCumFKsE8IHwZIgwqhAaTu2vokQ7I9WBYdz5PD9hvDQn1xBAcomLdOBk1iJr4TAebVspZouexo2T1BVJzCahWnKXj9CJYqeZAn3I2TDrTo981yJacpbw+0GVtiAnWWZjO2IN9BNYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b467a1ef-0ca3-47c7-d5fc-08d8486e280f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 20:42:02.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fQ69e+92bdLZLQZsxbOVQK0MsCRirNsJJARPsAh2FZg8cruNJ5fYqoONfnQVLWjYJsEO4kJf9dwmr3FxWewaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6420
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4gQW5uYSA8cy1h
bm5hQHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMCwgMjAyMCAyOjU0IFBNDQo+
IFRvOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHN0ZWZhbm9zQHhpbGlueC5jb20+OyBNYXRoaWV1IFBv
aXJpZXINCj4gPG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz47IFN0ZWZhbm8NCj4gU3RhYmVsbGluaSA8c3RlZmFub3NAeGlsaW54LmNvbT47
IEJlbiBMZXZpbnNreSA8QkxFVklOU0tAeGlsaW54LmNvbT4NCj4gQ2M6IEJqb3JuIEFuZGVyc3Nv
biA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBMb2tlc2ggVnV0bGENCj4gPGxva2VzaHZ1
dGxhQHRpLmNvbT47IGxpbnV4LXJlbW90ZXByb2NAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgVG9tYXMgRXZlbnNlbiA8dG9tYXNl
QHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczog
cmVtb3RlcHJvYzogQWRkIGJpbmRpbmdzIGZvciBSNUYNCj4gc3Vic3lzdGVtIG9uIFRJIEszIFNv
Q3MNCj4gDQo+IEhpIFJvYiwNCj4gDQo+IE9uIDgvMTAvMjAgMTE6NTIgQU0sIFN1bWFuIEFubmEg
d3JvdGU6DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gT24gNy8yNy8yMCA1OjM5IFBNLCBTdW1hbiBB
bm5hIHdyb3RlOg0KPiA+PiBIaSBSb2IsDQo+ID4+DQo+ID4+IE9uIDcvMTYvMjAgMjo0MyBQTSwg
U3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPiA+Pj4gT24gVGh1LCAxNiBKdWwgMjAyMCwgTWF0
aGlldSBQb2lyaWVyIHdyb3RlOg0KPiA+Pj4+IEhpIFJvYiwNCj4gPj4+Pg0KPiA+Pj4+IE9uIFR1
ZSwgSnVsIDE0LCAyMDIwIGF0IDExOjE1OjUzQU0gLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiA+Pj4+PiBPbiBNb24sIEp1biAyOSwgMjAyMCBhdCAwOTo0OToxOVBNIC0wNTAwLCBTdW1hbiBB
bm5hIHdyb3RlOg0KPiA+Pj4+Pj4gVGhlIFRleGFzIEluc3RydW1lbnRzIEszIGZhbWlseSBvZiBT
b0NzIGhhdmUgb25lIG9yIG1vcmUgZHVhbC1jb3JlDQo+ID4+Pj4+PiBBcm0gQ29ydGV4IFI1RiBw
cm9jZXNzb3Igc3Vic3lzdGVtcy9jbHVzdGVycyAoUjVGU1MpLiBUaGUgY2x1c3RlcnMNCj4gPj4+
Pj4+IGNhbiBiZSBzcGxpdCBiZXR3ZWVuIG11bHRpcGxlIHZvbHRhZ2UgZG9tYWlucyBhcyB3ZWxs
LiBBZGQgdGhlIGRldmljZQ0KPiA+Pj4+Pj4gdHJlZSBiaW5kaW5ncyBkb2N1bWVudCBmb3IgdGhl
c2UgUjVGIHN1YnN5c3RlbSBkZXZpY2VzLiBUaGVzZSBSNUYNCj4gPj4+Pj4+IHByb2Nlc3NvcnMg
ZG8gbm90IGhhdmUgYW4gTU1VLCBhbmQgc28gcmVxdWlyZSBmaXhlZCBtZW1vcnkNCj4gY2FydmVv
dXQNCj4gPj4+Pj4+IHJlZ2lvbnMgbWF0Y2hpbmcgdGhlIGZpcm13YXJlIGltYWdlIGFkZHJlc3Nl
cy4gVGhlIG5vZGVzIHJlcXVpcmUNCj4gbW9yZQ0KPiA+Pj4+Pj4gdGhhbiBvbmUgbWVtb3J5IHJl
Z2lvbiwgd2l0aCB0aGUgZmlyc3QgbWVtb3J5IHJlZ2lvbiB1c2VkIGZvciBETUENCj4gPj4+Pj4+
IGFsbG9jYXRpb25zIGF0IHJ1bnRpbWUuIFRoZSByZW1haW5pbmcgbWVtb3J5IHJlZ2lvbnMgYXJl
IHJlc2VydmVkDQo+ID4+Pj4+PiBhbmQgYXJlIHVzZWQgZm9yIHRoZSBsb2FkaW5nIGFuZCBydW5u
aW5nIG9mIHRoZSBSNUYgcmVtb3RlDQo+IHByb2Nlc3NvcnMuDQo+ID4+Pj4+PiBUaGUgUjVGIHBy
b2Nlc3NvcnMgY2FuIGFsc28gb3B0aW9uYWxseSB1c2UgYW55IGludGVybmFsIG9uLWNoaXAgU1JB
TQ0KPiA+Pj4+Pj4gbWVtb3JpZXMgZWl0aGVyIGZvciBleGVjdXRpbmcgY29kZSBvciB1c2luZyBp
dCBhcyBmYXN0LWFjY2VzcyBkYXRhLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBhZGRlZCBleGFt
cGxlIGlsbHVzdHJhdGVzIHRoZSBEVCBub2RlcyBmb3IgdGhlIHNpbmdsZSBSNUZTUw0KPiBkZXZp
Y2UNCj4gPj4+Pj4+IHByZXNlbnQgb24gSzMgQU02NXggZmFtaWx5IG9mIFNvQ3MuDQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU3VtYW4gQW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4g
Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gdjI6DQo+ID4+Pj4+PiDCoCAtIFJlbmFtZWQgImxvY2tzdGVw
LW1vZGUiIHByb3BlcnR5IHRvICJ0aSxjbHVzdGVyLW1vZGUiDQo+ID4+Pj4+DQo+ID4+Pj4+IEkg
ZG9uJ3QgdGhpbmsgdGhhdCdzIGEgbW92ZSBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uIGdpdmVuIHRo
aXMgaXMgYXQNCj4gPj4+Pj4gbGVhc3QgcGFydGlhbGx5IGEgc3RhbmRhcmQgZmVhdHVyZS4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gQXMgSSBzYWlkIGJlZm9yZSwgSSdtIHZlcnkgaGVzaXN0YW50IHRvIGFj
Y2VwdCBhbnl0aGluZyBoZXJlIGdpdmVuIEkNCj4gPj4+Pj4ga25vdyB0aGUgZGVzaXJlcyBhbmQg
YWN0aXZpdHkgdG8gZGVmaW5lICdzeXN0ZW0gRGV2aWNldHJlZXMnIG9mIHdoaWNoDQo+ID4+Pj4+
IFRJIGlzIHBhcnRpY2lwYXRpbmcuIFdoaWxlIG1heWJlIGFuIHJwcm9jIG5vZGUgaXMgc3VmZmlj
aWVudCBmb3IgYQ0KPiA+Pj4+PiBEU1AsIGl0IHNlZW1zIG11bHRpcGxlIHZlbmRvcnMgaGF2ZSBS
IGNvcmVzIGFuZCB3YW50IHRvIGRlZmluZSB0aGVtDQo+IGluDQo+ID4+Pj4+IHN5c3RlbSBEVC4N
Cj4gPj4NCj4gPj4gUGluZyBvbiB0aGlzIGRpc2N1c3Npb24uIFRJIGlzIHBhcnRpY2lwYXRpbmcg
b24gdGhlIFN5c3RlbSBEVCBldm9sdXRpb24gaW4NCj4gZ2VuZXJhbCwgYnV0IHdlIGRvbid0IGhh
dmUgYW55IHBsYW5zIHRvIHVzZSBEVFMgb24gb3VyIHJlbW90ZSBjb3Jlcy4gV2UNCj4gaGF2ZSBv
dXIgb3duIGF1dG8tZ2VuZXJhdGVkIENoaXAtU3VwcG9ydC1MaWJyYXJ5IChDU0wpIGNvZGUgdGhh
dCBnZXRzIHVzZWQNCj4gb24gb3VyIGZpcm13YXJlcy4NCj4gPj4NCj4gPj4gQWxzbywgbW9zdCBv
ZiB0aGUgcHJvcGVydGllcyBJIGRlZmluZWQgYXJlIHJhdGhlciBzdGFuZGFyZCBwcm9wZXJ0aWVz
LiBJDQo+IGhhdmUgcG9zdGVkIGEgcmV2aXNlZCB2MyBbMV0gYWZ0ZXIgdGhlIGNvbW1vbiB0aSxz
Y2kgcHJvcGVydGllcyByZWZhY3RvcmluZy4NCj4gVGhpcyBzZXJpZXMgaXMgb25seSB3YWl0aW5n
IG9uIHRoZSBiaW5kaW5ncy4gSSBhbSBoYXBweSB0byBjaGFuZ2UgYW55IHRpLA0KPiBwcmVmaXhl
ZCBwcm9wZXJ0aWVzLiBJIGhhZCBvbmUgb3BlbiBxdWVzdGlvbiBbMl0gdGhhdCBJIGFtIHdhaXRp
bmcgZm9yIGENCj4gcmVzcG9uc2UgZnJvbSB5b3UgZm9yIGlkZW50aWZ5aW5nIHRoZSBSNUYgQ29y
ZS4NCj4gPg0KPiA+IFBpbmcgb24gdGhpcy4NCj4gDQo+IEFueSBjb21tZW50cyBvbiB0aGlzPyBU
aGlzIGRpc2N1c3Npb24gaXMgd2hhdCdzIGhvbGRpbmcgdXAgdGhpcyBzZXJpZXMgZnJvbQ0KPiBn
ZXR0aW5nIG1lcmdlZC4NCj4gDQo+IEFsc28sIEZXSVcsIEkgc3BlbnQgYSBiaXQgb2YgdGltZSBs
b29raW5nIGF0IHRoZSBSNXMgKGNhbGxlZCBSUFUpIGluIHRoZSBYaWxpbngNCj4gWnlucU1QLCBh
bmQgdGhlIGludGVncmF0aW9uIGFzcGVjdHMgYXJlIHZlcnkgZGlmZmVyZW50IGJldHdlZW4gdGhl
IFRJIGFuZA0KPiBYaWxpbngNCj4gU29Dcywgc28gSSBkbyBub3QgdGhpbmsgZXZlbiBhIHNpbmds
ZSBiaW5kaW5nIGlzIHBvc3NpYmxlIGJldHdlZW4gdGhlIHR3bw0KPiBTb0NzLg0KPiBBIGZldyBv
ZiB0aGVtIHRvIGNpdGU6DQo+IA0KPiAxLiBUSSBTb0NzIHJlcXVpcmUgdGhlIHBvd2VyL3Jlc2V0
cyB0byBiZSByZWxlYXNlZCBmb3IgYm90aCB0aGUgQ29yZXMgaW4NCj4gTG9ja1N0ZXAtbW9kZSwg
d2hpbGUgaXQgd2FzIGVub3VnaCB0byBqdXN0IHJlbGVhc2UgdGhlIENvcmUwIHJlc2V0cyBvbg0K
PiBaeW5xTVAuDQo+IFNvLCBvdXIgYmluZGluZyByZXF1aXJlcyB0aGF0IGJvdGggQ1BVcyBiZSBk
ZWZpbmVkIGZvciBzdXJlIGFzIHRoZSByZXNldA0KPiBjb250cm9scyBhcmUgZGVmaW5lZCBwZXIg
Y29yZSwgd2hpbGUgeW91IGRvbid0IHNlZSB0aGVtIG9uIHRoZSBSUFUuDQo+IA0KPiAyLiBUaGVy
ZSBhcmUgc3BlY2lmaWMgY29yZSByZXNldCBzZXF1ZW5jZXMgb24gVEkgU29DcyBpbiBMb2NrU3Rl
cCBhbmQNCj4gU3BsaXQtbW9kZXMgb24gVEkgU29DcywgSSBhbSBub3Qgc3VyZSBpZiB0aGVyZSBh
cmUgYW55IHdpdGggWGlsaW54IFNvQ3MuDQo+IA0KPiAzLiBUaGUgVENNcyBhcmUgZW1iZWRkZWQg
d2l0aGluIHRoZSBSNUYgc3ViLXN5c3RlbSBvbiBUSSBTb0NzLCBhbmQgYXJlDQo+IGNvbnRyb2xs
ZWQgYnkgdGhlIHNhbWUgcG93ZXIgYW5kIGNsb2NrIGFzIHRoZSBSNUZzLiBUaGVyZSBpcyBhbiBh
ZGRpdGlvbmFsDQo+IENQVQ0KPiBoYWx0IGxpbmUgdGhhdCBjb250cm9scyB0aGUgY29yZSBleGVj
dXRpb24sIGFuZCBhbGxvd3MgdXMgdG8gZW5hYmxlIHRoZSBhY2Nlc3MNCj4gdG8gdGhlc2UuIFRo
ZSBaeW5xTVAgbG9va3MgdG8gaGF2ZSBjb21wbGV0ZWx5IGluZGVwZW5kZW50IGNvbnRyb2wgdG8g
dGhlDQo+IFRDTXMuDQo+IFRoaXMgaXMgdGhlIHJlYXNvbiB3aHkgdGhleSBhcmUgcmVwcmVzZW50
ZWQgYXMgaW5kaXZpZHVhbCBtbWlvLXNyYW0gbm9kZXMgaW4NCj4gdGhlDQo+IFhpbGlueCBiaW5k
aW5nLg0KPiANCj4gNC4gVGhlIFRDTXMgYW5kIHdoaWNoIG9uZSBhcHBlYXJzIGF0IHRoZSBSNSBh
ZGRyZXNzIDAgYXJlIHByb2dyYW1tYWJsZSBvbg0KPiBUSQ0KPiBTb0NzLCBJIGNvdWxkbid0IHRl
bGwgaWYgdGhpcyBpcyB0aGUgY2FzZSB3aXRoIFhpbGlueCBTb0NzLg0KPiANCj4gQmVuIGFuZCBT
dGVmYW5vLA0KPiBQbGVhc2UgZG8gY2xhcmlmeSwgaWYgSSBhbSBvZmYgb24gYW55IG9mIHRoZSBh
Ym92ZSBkaWZmZXJlbmNlcy4NCj4gDQpbQmVuIExldmluc2t5XSBIaSBTdW1hbiwgDQoNCndoYXQg
eW91IHNhaWQgaXMgY29ycmVjdC4gDQoNClRoYW5rcw0KPiByZWdhcmRzDQo+IFN1bWFuDQo+IA0K
PiANCj4gPg0KPiA+IHJlZ2FyZHMNCj4gPiBTdW1hbg0KPiA+DQo+ID4+DQo+ID4+IHJlZ2FyZHMN
Cj4gPj4gU3VtYW4NCj4gPj4NCj4gPj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cGF0Y2gvMTE2NzkzMzEvDQo+ID4+IFsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2Nv
bW1lbnQvMjMyNzM0NDEvDQo+ID4+DQo+ID4+Pj4+DQo+ID4+Pj4+IFRob3VnaCB0aGUgc3lzdGVt
IERUIGVmZm9ydCBoYXMgbm90IHlldCBnaXZlbiBhbnkgdGhvdWdodCB0byB3aGF0IGlzDQo+IHRo
ZQ0KPiA+Pj4+PiB2aWV3IG9mIG9uZSBwcm9jZXNzb3Igb3IgaW5zdGFuY2UgdG8gYW5vdGhlciBp
bnN0YW5jZSAod2hpY2ggaXMgd2hhdA0KPiA+Pj4+PiB0aGlzIGJpbmRpbmcgaXMpLiBXZSdsbCBz
dGlsbCBuZWVkIHNvbWV0aGluZyBkZWZpbmVkIGZvciB0aGF0LCBidXQgSSdkDQo+ID4+Pj4+IGV4
cGVjdCB0aGF0IHRvIGJlIGRlcGVuZGVudCBvbiB3aGF0IGlzIGRlZmluZWQgZm9yIHN5c3RlbSBE
VC4NCj4gPj4+Pg0KPiA+Pj4+IEVmZm9ydHMgcmVsYXRlZCB0byB0aGUgZGVmaW5pdGlvbiBvZiB0
aGUgc3lzdGVtIERUIGFyZSB1bmRlciB3YXksDQo+IHNvbWV0aGluZyBJDQo+ID4+Pj4gZXhwZWN0
IHRvIGtlZXAgZ29pbmcgb24gZm9yIHNvbWUgdGltZSB0byBjb21lLsKgIEkgYWdyZWUgd2l0aCB0
aGUgbmVlZCB0bw0KPiB1c2UgdGhlDQo+ID4+Pj4gc3lzdGVtIERUIHRvIGRlZmluZSByZW1vdGUg
cHJvY2Vzc29ycyBhbmQgSSBsb29rIGZvcndhcmQgdG8gdGhlIHRpbWUNCj4gd2UgY2FuIGRvDQo+
ID4+Pj4gc28uDQo+ID4+Pg0KPiA+Pj4gSSdsbCB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gYWRk
IHRoYXQgSSBzaG91bGQgYmUgYWJsZSB0byBwdWJsaWNseQ0KPiA+Pj4gcHJlc2VudCBhIFN5c3Rl
bSBEZXZpY2UgVHJlZSBwcm9wb3NhbCBmb3IgdGhpcyBkdXJpbmcgdGhlIG5leHQgY2FsbCAodGhl
DQo+ID4+PiBuZXh0IG9uZSBhZnRlciB0aGUgY2FsbCBlYXJseSBuZXh0IHdlZWsgdGhhdCBoYXMg
YWxyZWFkeSBhIGZ1bGwgYWdlbmRhLikNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IFRoYXQgYmVpbmcg
c2FpZCB3ZSBuZWVkIHRvIGZpbmQgYSBjb25jZW5zdXMgb24gaG93IHRvIG1vdmUgZm9yd2FyZA0K
PiB3aXRoIHBhdGNoZXMNCj4gPj4+PiB0aGF0IGFyZSByZWFkeSB0byBiZSBtZXJnZWQuwqAgV2hh
dCBpcyB5b3VyIG9waW5pb24gb24gdGhhdD8NCj4gPj4+DQo+ID4+PiBJbiBteSBvcGluaW9uIHdl
IGRvbid0IGhhdmUgdG8gbmVjZXNzYXJpbHkgd2FpdCBmb3IgU3lzdGVtIERldmljZSBUcmVlDQo+
ID4+PiB0byBtYWtlIHByb2dyZXNzIHdpdGggdGhvc2UgaWYgdGhleSBsb29rIE9LLg0KPiA+Pj4N
Cj4gPj4NCj4gPg0KDQo=
