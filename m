Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A803C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08F821D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WiF5mll6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OCTXu2F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDPQhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:37:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53752 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgDPQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:37:36 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 09905C0375;
        Thu, 16 Apr 2020 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587055055; bh=xGcffXxvNQ+Kr5i2XCFy/W8WIWTM7ih1uC91hrg4xfw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WiF5mll6WM8e59s4qvhHPB77+qL+bx70wwsxvwNxxuuuWPOmi5oeASeaKmDVYe2X2
         hNGtEzxsTRfEFei7U8OeaHLWTSl+g04xvsjUEoss/dsA6qhQd2TDJuWDBTQAX19wEn
         fL8qO42g9td/kyRMjlppLXRp8a79hnRTcvnfzBxUaxKsG+tz8O/GoQ38S23vP70zPW
         ++8kWJ0sxdG60v/xLmQwqlBsGsUyL+eosPYvMHeCuCWTk/P/VulkWjc8YFhNhZFM4l
         hxUHQY6ktwlcmQoQMQN3OLoCQXUe9/mJvbTm6fPZm4kHi1oiKrmhJIK7fO25pSBfJX
         a+Hy3vBO3aj9g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 08E8CA0083;
        Thu, 16 Apr 2020 16:37:33 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 Apr 2020 09:37:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 16 Apr 2020 09:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnh/y2pOhh4XEw8VNn/IA3DBIt7V1TA4K35wtyfXR0Dp859IUEfRlK0ha88CoZ5/qliAhUCNw23r4QhQxWcQ0Gyc187GOqblXjJBJ8UKjuubL1g6PFstsAOj1B5RqajHe5llHbk/whZwP669pOko1xpn7c7gkGU/ZBdstt30ShCpstzIYg/VOPWcxpujJFfq3owBTAzy/MQTZwlZVJWGxDdfJmj+pp8x5Hs/YAv3VfrFqGbGjPHxhWVd4tOBIcYn7HfBBxDWIQ6dADIcSaI8uYF8nP8VDJgr2F17yXQrjvm/HWvDqG2quowoAlWJLpyC1M8+DcH1lWir12HoIzbK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGcffXxvNQ+Kr5i2XCFy/W8WIWTM7ih1uC91hrg4xfw=;
 b=CAql4oIIkxDqwT+sHDcsP0iWXzb3TO2u2GejBtSC3rG7BuaQCjt6GV8y/v/e1cdmPOkJFMY7LehqUuq0skWiokZTF1Srm8rX1kwJZwH2N5Kq1QKYevZPZw26Cg6iQVkICAawQFsUhwH7DfuU5Bq1yiWv0F3SkSu6v4HgvCMCBNXXxCSplrN5BfAYpUpyxvGdwqyl6TR4qHJnvWxLQ23/Z99InHG2P/g6SSMpL6YIbi/6vxxYD5TjO+J6rRLI0Hg9c5c1snist5fvpdsfub6PjuqK0zm84tArtS8u/jRPAYweTQ1arlswoj/CB/BzSOsdf8ve2eiD7sHFemscXOmEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGcffXxvNQ+Kr5i2XCFy/W8WIWTM7ih1uC91hrg4xfw=;
 b=OCTXu2F2qGIA/GjO7icfV2DEWodY+Qt8bhjOgVO7NtzGq7mHYX72giSqRJwG7e6yPAeYkkYMMrrnUNNdUlB0Nr8yTAbK1NvcpgDMrLUqeM2bvhwPreoMG+iXpuK5u/U/A9qN6xKO2P4DdNxgLrgre6KVIsaGfOj71AxTCKbJhUQ=
Received: from DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 16:37:30 +0000
Received: from DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::7809:7719:df21:9539]) by DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::7809:7719:df21:9539%4]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 16:37:30 +0000
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Topic: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Index: AQHWCuwLvvH52um5KUelC2TK68yepqh4c8CAgAMGvYCAAIpOgA==
Date:   Thu, 16 Apr 2020 16:37:30 +0000
Message-ID: <aa1023c6-fe8c-8f5b-365f-403ac50ac94f@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
 <20200405014548.GA25539@bogus>
 <fe59318a-b3dd-c6af-702e-1ca4aed04a8b@synopsys.com>
 <874ktjsuuy.fsf@kernel.org>
In-Reply-To: <874ktjsuuy.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joglekar@synopsys.com; 
x-originating-ip: [49.207.49.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbfc3f78-4fd3-4d80-a90b-08d7e22474e1
x-ms-traffictypediagnostic: DM6PR12MB4466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4466BE3A36EAD6561D864B74A4D80@DM6PR12MB4466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4251.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(31696002)(71200400001)(86362001)(81156014)(36756003)(31686004)(186003)(8676002)(5660300002)(26005)(8936002)(4326008)(478600001)(2906002)(55236004)(316002)(2616005)(6512007)(6486002)(66446008)(66556008)(66946007)(76116006)(66476007)(91956017)(107886003)(53546011)(6506007)(54906003)(110136005)(64756008)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnDsrMWsXWZhI4eGwZCVOom0sslW50umkjjn8knsdjGKFJKIn8WBN29+JRkLUFKgcXmQcVgy7566YYp7zUd3YRu1LDhOJaaaPzyZyedUpbE4pVDJi9tAr60w/BwF2lQuCa1lWyz2gGXeQkLeRz73bRA98eLf2jbyPf1U7ffom5mKnkU3jkHJG6SN1F5DHbJkxVPez4WRQ57uCfe9rfrPPvE4hgHc1btkhNVcJPIx+sV3GyGmjyH+DNdPBj1+HoZbG67sFTBBn9MFlV+wC7XEbGKqHcx2eNZq6dweah3Ke3w7kBwYWm+ZVkMghuVWtr+rTo2w1X6TnXM6CUaPFZLv0OFnHhkTmd57zgO1LSEBOmXZNrZW+DqURNgnOQldecbDWtBGSshmRYKOg2ntMl3oiC7wmvG/DQ/sYZY8aB/2KKaXYAJaB4+LefC9iR11iQTbGYPyX54sTzwwVW07om6tfvzcMdjzPTnmZZkzcScixlTi82ezW7vL6GOMAvckzxLx
x-ms-exchange-antispam-messagedata: m0lxcQQFu68Qu6mijewRXEXMLgMlvsPdLuBecp9SPwJmtIGV/Xqjh3TxU35DW0Wp5l3h+UripuZGfii8Y+v6V48vtWuiW9b9u7ljGrT2urCPrknrX3d5FLevwE95P/ONeMydb7SAey3aAm+MZ/QjNA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AF089F0E324F941B9916A578FC97E7F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfc3f78-4fd3-4d80-a90b-08d7e22474e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 16:37:30.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNhBdSqJShQn62YT6FqCGmA100bkcP/TmdgLeM+IxuAWePfW7BCS0EjXXziNKXeUF2szNGGSAsqJ5AIMdQuJmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiA0LzE2LzIwMjAgMTo1MiBQTSwgRmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGks
DQo+IA0KPiBUZWphcyBKb2dsZWthciA8VGVqYXMuSm9nbGVrYXJAc3lub3BzeXMuY29tPiB3cml0
ZXM6DQo+PiBIaSwNCj4+IE9uIDQvNS8yMDIwIDc6MTUgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0K
Pj4+IE9uIEZyaSwgTWFyIDI3LCAyMDIwIGF0IDAzOjExOjU2UE0gKzA1MzAsIFRlamFzIEpvZ2xl
a2FyIHdyb3RlOg0KPj4+PiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciBj
b25zb2xpZGF0ZS1zZ2wsIGFuZA0KPj4+PiBzbnBzLGNvbnNvbGlkYXRlLXNnbCBwcm9wZXJ0eS4g
VGhlc2Ugd2hlbiBzZXQgZW5hYmxlcyB0aGUgcXVpcmsgZm9yDQo+Pj4+IFhIQ0kgZHJpdmVyIGZv
ciBjb25zb2xpZGF0aW9uIG9mIHNnIGxpc3QgaW50byBhIHRlbXBvcmFyeSBidWZmZXIgd2hlbiBz
bWFsbA0KPj4+PiBidWZmZXIgc2l6ZXMgYXJlIHNjYXR0ZXJlZCBvdmVyIHRoZSBzZyBsaXN0IG5v
dCBtYWtpbmcgdXAgdG8gTVBTIG9yIHRvdGFsDQo+Pj4+IHRyYW5zZmVyIHNpemUgd2l0aGluIFRS
QiBjYWNoZSBzaXplIHdpdGggU3lub3BzeXMgeEhDLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBUZWphcyBKb2dsZWthciA8am9nbGVrYXJAc3lub3BzeXMuY29tPg0KPj4+PiAtLS0NCj4+Pj4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQgICAgIHwgMyAr
KysNCj4+Pj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLXhoY2ku
dHh0IHwgMyArKysNCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2R3YzMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4
dA0KPj4+PiBpbmRleCA5OTQ2ZmY5YmE3MzUuLjI5MmQxZjc5NjllNCAxMDA2NDQNCj4+Pj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPj4+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMudHh0DQo+Pj4+
IEBAIC0xMDQsNiArMTA0LDkgQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4+Pj4gIAkJCXRoaXMg
YW5kIHR4LXRoci1udW0tcGt0LXByZCB0byBhIHZhbGlkLCBub24temVybyB2YWx1ZQ0KPj4+PiAg
CQkJMS0xNiAoRFdDX3VzYjMxIHByb2dyYW1taW5nIGd1aWRlIHNlY3Rpb24gMS4yLjMpIHRvDQo+
Pj4+ICAJCQllbmFibGUgcGVyaW9kaWMgRVNTIFRYIHRocmVzaG9sZC4NCj4+Pj4gKyAtIHNucHMs
Y29uc29saWRhdGUtc2dsOiBlbmFibGUgc2cgbGlzdCBjb25zb2xpZGF0aW9uIC0gaG9zdCBtb2Rl
IG9ubHkuIFNldCB0byB1c2UNCj4+Pj4gKwkJCVNHIGJ1ZmZlcnMgb2YgYXQgbGVhc3QgTVBTIHNp
emUgYnkgY29uc29saWRhdGluZyBzbWFsbGVyIFNHDQo+Pj4+ICsJCQlidWZmZXJzIGxpc3QgaW50
byBhIHNpbmdsZSBidWZmZXIuDQo+Pj4NCj4+PiBUaGUgcHJlZmVyZW5jZSBpcyBub3QgdG8ga2Vl
cCBhZGRpbmcgcHJvcGVydGllcyBmb3IgZXZlcnkgc2luZ2xlIHF1aXJrIA0KPj4+IG9yIGZlYXR1
cmUuIFRoZXNlIHNob3VsZCBiZSBpbXBsaWVkIGJ5IHNwZWNpZmljIGNvbXBhdGlibGVzLiBBcyBT
eW5vcHN5cyANCj4+PiBrbm93cyB3aGF0IHF1aXJrcy9lcnJhdGEvZmVhdHVyZXMgYXJlIGluIGVh
Y2ggdmVyc2lvbiBvZiBJUCwgdGhlIA0KPj4+IGNvbXBhdGlibGUgc3RyaW5ncyBzaG91bGQgcmVm
bGVjdCB0aG9zZSB2ZXJzaW9ucy4gKEFuZCB5ZXMsIEknbSBzdXJlIA0KPj4+IHRoZXJlJ3MgY3Vz
dG9tZXIgRUNPIGZpeGVzIHRoYXQgYXJlbid0IHJlZmxlY3RlZCBpbiB0aGUgdmVyc2lvbiwgYnV0
IA0KPj4+IHRoYXQncyB3aHkgd2UgaGF2ZSBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZXMgdG9vLikg
VGhpcyBpcyB0aGUgb25seSB3YXkgDQo+Pj4gd2UgY2FuIGZpeCBxdWlya3MgaW4gdGhlIE9TIHdp
dGhvdXQgZG9pbmcgRFQgdXBkYXRlcy4gRm9yIGNvbXBhcmlzb24sIGRvIA0KPj4+IHlvdSB3YW50
IHRvIGhhdmUgdG8gdXBkYXRlIHlvdXIgUEMgQklPUyBzbyBhbiBPUyBjYW4gd29yay1hcm91bmQg
aXNzdWVzPw0KPj4+DQo+PiBZZXMsIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSB3YW50IHRvIHNheSBo
ZXJlLiBCdXQgSSB0aGluayB0aGlzIGNvbXBhdGlibGUgc3RyaW5nDQo+PiBkb2VzIG5vdCB3b3Jr
IHdpdGggdGhlIHBsYXRmb3JtIGRyaXZlcnMgd2l0aCBQQ0kgYmFzZWQgc3lzdGVtcy4gU28gYmFz
ZWQgb24gdGhlIHZlbmRvciANCj4+IGlkIGFuZCBkZXZpY2UgaWQgdGhlbiBJIG5lZWQgdG8gc2V0
IHRoZSBxdWlyayByZXF1aXJlZC4gDQo+Pg0KPj4gQEZlbGlwZTogV2hhdCBkbyB5b3Ugc3VnZ2Vz
dCBmb3Igc2V0dGluZyB1cCBxdWlyayB3aXRob3V0IHRoZSBEVCB1cGRhdGUgZm9yIGR3YzM/DQo+
IA0KPiBXZSBoYXZlIGJlZW4gdXNpbmcgU3lub3BzeXMgY29udHJvbGxlcidzIHJldmlzaW9uIHJl
Z2lzdGVyLCBidXQgdGhhdCdzDQo+IG5vdCB2aXNpYmxlIHRvIHhoY2kgZHJpdmVyIGFuZCB3ZSBk
b24ndCBoYXZlIGEgc2VwYXJhdGUgY29tcGF0aWJsZSBmb3INCj4gZWFjaCBzeW5vcHN5cyB2ZXJz
aW9uIG9uIHRoZSB4aGNpIGRyaXZlciBzaWRlLiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRvDQo+IGFk
ZCAic25wcyx4aGNpLWZvby1iYXIiIHRvIHhoY2ktcGxhdCBhbmQgdXNlIHRoYXQuDQo+IA0KQEZl
bGlwZTogVGhhbmtzIGZvciBzdWdnZXN0aW9uDQoNCkBNYXRoaWFzOiBEbyB5b3UgcHJlZmVyIHBh
cmFtZXRlciBwYXNzZWQgdGhpcyB3YXk/IEkgY2FuIHNlbmQgdGhlIHYyIHBhdGNoIHNldCwNCmFm
dGVyIHlvdXIgaW5wdXQuDQoNCg0KVGhhbmtzICYgUmVnYXJkcywNCiBUZWphcyBKb2dsZWthciAN
Cg==
