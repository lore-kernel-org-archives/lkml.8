Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CC320781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="grmfe+dx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="m6U0nKvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404378AbgFYLez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:34:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51430 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404239AbgFYLex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:34:53 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D47D340391;
        Thu, 25 Jun 2020 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1593084892; bh=CqEjaOX56SFTAAb+E4RdvnBhS0ifpAx1v7Zdk8b4ZOw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=grmfe+dxEUfewxuT24qgR9KmiQvIWxMgkpMRVPvhMFdaFuHx2Lcs3QINUc3d9skNQ
         YVjPjyOnrKBacTbxScqBfW1Cb24V56XhgmTmEAe+DtHel4fC51mqftR/9g+WthnCfX
         JUZyM0Sg3MpjngmPazdZjRY7LGhMsDKGR/cf8zkyykJRgVYEdfLztM9GcwBfPqZKKL
         5G23HMLRqdHozQ/qkn+N9Sbu7TTZRnQc907YbGa47ihVd9D/Dw82F9mSSeOpraL9F2
         UAJfF8I9Dkv2qK0DCtBZS+Av6WiRsF/BAnfkskjX7Y6XYEVzh2LHvbhlKytNd4JCxy
         xcSPcF/15qcBg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1F659A0057;
        Thu, 25 Jun 2020 11:34:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6DAD6400F0;
        Thu, 25 Jun 2020 11:34:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="m6U0nKvJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FykM8LMA8YwR3g85G5tFPSzj44u3/k2pXAU+kJXdLCNoDYKg5SiD4jrJpXikqRuBmeShL33CMtRdwmeiQjMKA7mu0NHqSeMiyowruXFns4wgnKbBckR4oEooFadg3he6amu1UNlTX79NbUvFdDnPaV3p07p/w7fLyg774rVO+bNtBNi8MthuSjX3uSxjTBfCRAllRkLQdQKzwlVqpPAMsU+7z2w0eJt/8D+H5YHT7fwFrGN7bGAV7EsID5cyflN3svcRX0kScJ2OTQatAbMOGZyATPtytpqBKAbESlCO5fCRJ0+v1Umm/UbXSAwZH6ZTjhiMjQLhBFVhG63uFEhMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqEjaOX56SFTAAb+E4RdvnBhS0ifpAx1v7Zdk8b4ZOw=;
 b=JWXzWSffzpdhVbuiXcO7YQUYhMwcegdbnkysRkDXvu8hbFsU/CGpkYSTX3QZDYjOppaPdkHShAbkzF/qATn+BkjycwCnKQm9+pK3eYeZhwJULWzxGWBAm+FD+jhDsdxce6hSHZ+x/Ad/OavKVdi6ckLn6IpC2NUHFI2x9HaezYvSA+c1ijQlZBPUyWnEvDidVDdN6XqMjrpGb7lPDWHI99QxICLFgGaEFM+dNpSYVH868g84Yth8+fI7B88W0ICYfJ8ajDV8vaxabZNf6+bdeS9Rlva2u+Rsjo5TLwPlrSZqrJtY2rNrEbb0FuQbp+IeXwbriK1KEu3YYQhjEjAkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqEjaOX56SFTAAb+E4RdvnBhS0ifpAx1v7Zdk8b4ZOw=;
 b=m6U0nKvJNBNcXpioXRlYOKWqlrXf4eFv7iU0lri1pd/bD4lDJJj2FoGkLJ2IjSdJ5DMPuNuIIAOWbdOqDYNmQHvA7nFqZGThlU4YD4IQlH5jZXhS89sz8CaCQyzpg7B1XOjW5U55+9fsGIMUFo8RZMpOCFgOfVal7+0hzhttLpE=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR1201MB0055.namprd12.prod.outlook.com (2603:10b6:910:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 11:34:45 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3131.020; Thu, 25 Jun
 2020 11:34:45 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 0/3] Add USB role switch support to DWC2
Thread-Topic: [PATCH 0/3] Add USB role switch support to DWC2
Thread-Index: AQHWQ+eB+/PdVadB/EW+WlrQXFio16jpQW6A
Date:   Thu, 25 Jun 2020 11:34:44 +0000
Message-ID: <fc3b71e6-90a8-7aae-0131-adb0083dc93d@synopsys.com>
References: <20200616140717.28465-1-amelie.delaunay@st.com>
In-Reply-To: <20200616140717.28465-1-amelie.delaunay@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
authentication-results: st.com; dkim=none (message not signed)
 header.d=none;st.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f2362d-3276-4d47-36de-08d818fbc26b
x-ms-traffictypediagnostic: CY4PR1201MB0055:
x-microsoft-antispam-prvs: <CY4PR1201MB0055E306B8FCD93F7B3E3722A7920@CY4PR1201MB0055.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+d/fnnPKyjeWO3IMu5/8+avVw+yvnHwTp5kBHg4wRKwJgk/1p6wl9NvLvm5U3JwcUrRf3Z+k1n8qwxZErDpmb+M+O/y4+OV7AXM9Uv1dy3QFfCBSWYBs6Cn+FJYR8KY2P+t3NCmOFrDypY7ysBTbHbTPK4/xCTnUp2NBgCnkMhU2afVkkEajf7aEtSLS6YPPSdB28oW4IE5s2sVUsiKq3190OZaN7OgtT2FZoVFZsQTbQ95AyWtF1ULwNJWis8KfrNNjm1mU/7hRc82KRlqNvSIIcJXd1eISPtKYneJh+/CpQSPyv/ffxuXq5SntpSe3GzzYRANeukMZYTR0u/fynoXDIy33FW/FEmGWbgcMaEhvBTeQFWPfZQMAagX51VmiDJNPw0qWKuKU6VnHshOr0NsJ6O1lFh1CThDUr4MDbjQY/3rJmYjdDFJxR6+I7aVp0BY2zLALrq7I14G45lQGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(6512007)(6506007)(7416002)(66946007)(66476007)(316002)(83380400001)(8936002)(53546011)(4326008)(31686004)(71200400001)(76116006)(186003)(2616005)(2906002)(26005)(54906003)(66556008)(110136005)(86362001)(66446008)(64756008)(5660300002)(91956017)(36756003)(31696002)(478600001)(6486002)(966005)(8676002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1De2RN2U2s6mYmbkvLmxkBFvp1p4geixGCmSx8mo+MbwJkJpRlZW/Nolk9Qb57WY+ecUkFewegEt6PmnMieGQu5ez8DB5U31mwwCx9ngRiSS0hb99uJj8WPssplAKBpZIqdqZR9MGthQtRU2AjKOiu/J138QWPX9BtC/Ktxj8aMFMQ1MqA+H+gNpuudFANnqU7jiWpN/TkAcO3vsCEiRcn8HH9T31l5ihITJiD19s9RDhFCD7vsN1ybnx8YTQDHx8doK8hh1G1lqu7U6jnrpG3vaNe2de1heiA74P3OzZzYQYyaDJLl2WmOS2sN9xC55r9FmD7Vli4CY0fc2UvpG/a+Cq2whUDtRTADucItyVinL/qc/AmUiqqOMlPyZTn5IXtQtAxGmoWSmJHGtptQ6rhKjeC5l0FJmeZ3bFd/zQWJooyDKiAFKVHB36UdCPSfJKfFNHkHFRmXFOnVES4plBs/0k7MjbphZisAyl5RVDqpKf+QKrQtTOopTDGo6mxj3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <62BA19D6A1F5B14B87B3F522A29D4891@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f2362d-3276-4d47-36de-08d818fbc26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 11:34:44.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3RC7SIB3S8n5CLqyZ3tGUXNPI0k24TXR9+MU/EnSzywNV/hgElhBYGU1xcE8XyFmaPOuVWiRoOC8gsmnKwPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDYvMTYvMjAyMCA2OjA3IFBNLCBBbWVsaWUgRGVsYXVuYXkgd3JvdGU6DQo+IFdo
ZW4gdXNpbmcgdXNiLWMgY29ubmVjdG9yIChidXQgaXQgY2FuIGFsc28gYmUgdGhlIGNhc2Ugd2l0
aCBhIG1pY3JvLWINCj4gY29ubmVjdG9yKSwgaWRkaWcsIGF2YWxpZCwgYnZhbGlkLCB2YnVzdmFs
aWQgaW5wdXQgc2lnbmFscyBtYXkgbm90IGJlDQo+IGNvbm5lY3RlZCB0byB0aGUgRFdDMiBPVEcg
Y29udHJvbGxlci4NCj4gRFdDMiBPVEcgY29udHJvbGxlciBmZWF0dXJlcyBhbiBvdmVycmlkaW5n
IGNvbnRyb2wgb2YgdGhlIFBIWSB2b2x0YWdlIHZhbGlkDQo+IGFuZCBJRCBpbnB1dCBzaWduYWxz
Lg0KPiBTbywgbWlzc2luZyBzaWduYWxzIGNhbiBiZSBmb3JjZWQgdXNpbmcgdXNiIHJvbGUgZnJv
bSB1c2Igcm9sZSBzd2l0Y2ggYW5kDQo+IHRoaXMgb3ZlcnJpZGUgZmVhdHVyZS4NCj4gDQo+IFRo
aXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdXNiIHJvbGUgc3dpdGNoIHRvIGR3YzIsIGJ5IHVz
aW5nIG92ZXJyaWRpbmcNCj4gY29udHJvbCBvZiB0aGUgUEhZIHZvbHRhZ2UgdmFsaWQgYW5kIElE
IGlucHV0IHNpZ25hbHMuDQo+IA0KPiBJdCBoYXMgYmVlbiB0ZXN0ZWQgb24gc3RtMzJtcDE1N2Mt
ZGsyIFsxXSwgd2hpY2ggaGFzIGEgVHlwZS1DIGNvbm5lY3Rvcg0KPiBtYW5hZ2VkIGJ5IGEgVHlw
ZS1DIHBvcnQgY29udHJvbGxlciwgYW5kIGNvbm5lY3RlZCB0byBVU0IgT1RHIGNvbnRyb2xsZXIu
DQo+IA0KPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd3d3LnN0LmNv
bS9lbi9ldmFsdWF0aW9uLXRvb2xzL3N0bTMybXAxNTdjLWRrMi5odG1sX187ISFBNEYyUjlHX3Bn
IUtQVTZwTGNBTWFWckZ4elNwM3BlTGtqWnpXSnpqc2NfX0tsODc4VVlTTFkyQ252NU5NbXdBQ3NZ
NGtUQ293MCQNCj4gDQo+IEFtZWxpZSBEZWxhdW5heSAoMyk6DQo+ICAgIHVzYjogZHdjMjogb3Zl
cnJpZGUgUEhZIGlucHV0IHNpZ25hbHMgd2l0aCB1c2Igcm9sZSBzd2l0Y2ggc3VwcG9ydA0KPiAg
ICB1c2I6IGR3YzI6IGRvbid0IHVzZSBJRC9WYnVzIGRldGVjdGlvbiBpZiB1c2Itcm9sZS1zd2l0
Y2ggb24gU1RNMzJNUDE1DQo+ICAgICAgU29Dcw0KPiAgICBBUk06IGR0czogc3RtMzI6IGVuYWJs
ZSB1c2Itcm9sZS1zd2l0Y2ggb24gVVNCIE9URyBvbiBzdG0zMm1wMTV4eC1ka3gNCj4gDQo+ICAg
YXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1eHgtZGt4LmR0c2kgfCAgIDIgKy0NCj4gICBkcml2
ZXJzL3VzYi9kd2MyL0tjb25maWcgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVycy91
c2IvZHdjMi9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBkcml2ZXJzL3VzYi9k
d2MyL2NvcmUuaCAgICAgICAgICAgICAgICB8ICAgOCArKw0KPiAgIGRyaXZlcnMvdXNiL2R3YzIv
ZHJkLmMgICAgICAgICAgICAgICAgIHwgMTkwICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIGRy
aXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgICAgICAgICAgICAgIHwgICA0ICstDQo+ICAgZHJpdmVy
cy91c2IvZHdjMi9wbGF0Zm9ybS5jICAgICAgICAgICAgfCAgMTMgKysNCj4gICA4IGZpbGVzIGNo
YW5nZWQsIDIxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3VzYi9kd2MyL2RyZC5jDQo+IA0KRm9yIGR3YzI6DQoNCkFja2VkLWJ5
IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpNaW5h
cw0K
