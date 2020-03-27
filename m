Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB6C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23320705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OiHCkO3N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nm6qxOJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0K2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:28:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37760 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgC0K2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:28:45 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 04795425BD;
        Fri, 27 Mar 2020 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585304924; bh=Dr43viJs/Cyd6J2wzr4se58hi3UXf6AQDCgErx1lLzc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OiHCkO3Nd6Br7/pu6rkG8S1yqo1ylvSC2hJC0YyVfvcYBx6mobkTQLOjms8SKA0mq
         73YZ9wYKdQdqOehxpY9SrOHFZYZXrCS5uwca0gyWq4lY6nw17cYwyUI6E7ZAqik0G4
         UsdCkff6VO1x3P8mO+L9EMWqnVvzkIR5vrDlxM0LsyQEctZctmT3OiYaftK9VXUUIJ
         uEEodQCWZK6lqNAjH0dF7ybmDTU85bdBH+a4xqF3ueF9fLI2Gk15UHxNbhpIIorZmO
         EXY+NkIuR/mhNT0cYwQ/UEaM2uQ91u8Swd8MTd7SymV6mkM6aPu2L76aZ+hwmrX8pQ
         m5/Mmbjt6VZ2g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7249DA0079;
        Fri, 27 Mar 2020 10:28:43 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 27 Mar 2020 03:28:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 27 Mar 2020 03:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1IFGphLl2LMD34rcd2wyHpdsdcFJG4gBvNesP8491VSVB8X2q2HRJHe5ojHLWaV4a85LaEWPDfINBU5/USB+S4/aP3UvoRXo7LmsJzDJvzQb4VpGrPOm8DY/7w4Z5nXQeOl7bhdIJQYnnYskm7QNlLT+Swyb8Xl/ymiTC26R0lSdv+djdjV7ypCtGupih8JirF+YpsVe6sOClaAAU9KwsoiTWXlZyoDAiSR4yM8YdMOXr9/Zb2pjvFJ+pun/hckA5GvVv0bHQk5pFQxjGJ28KK0SnAeYQqfIxRD914PLRHTQ2UWFWKWHq8tl+zgK/YU4ydqkG3/f7cYoUeRukLHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr43viJs/Cyd6J2wzr4se58hi3UXf6AQDCgErx1lLzc=;
 b=Ymn+cTPk9cw0R2CCQWR9MhMeGB5WeTcxZm4rOqerXA20EeD3RID1PMiPAgwvqaMo74donuX/G/1uPrBMWu+Fmj/lc07gY6Ut9IXDY1jE8agQqLeYdAzMsGs97ciDQ3Pi53Kjr6Kl/q+xq1Osm8iylwLDDowY0zsN+wgcLOejUP0t8qrkBAVM4a14F2BDLHdvWVI0ZWTBLxQxu6GEes0J5TGZKN5eBBOe/RuEF1sfn/kUo4f+E8t1JouTyTCtfrXvLoYSWcPSOaVpisHXMZfMzo2sSH2/lG0GLT2u0uIZ5vtdcs2w5XDjnLLJte/4HBhO3lk1n2Agf+LWh2b6Zm9WKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr43viJs/Cyd6J2wzr4se58hi3UXf6AQDCgErx1lLzc=;
 b=nm6qxOJ6xIt74J+ZNXdEyCv5cEoR0XHSIa4q+hcarewZK9cY+QEJY9yWCXjxv49e/x85HaDK5FL0KKBX2gk2LRdgMT/kHJs/KnAzX8p+qFthNMowmA0p7jh74wDvyQka48X78wigyeqF0apTVPBoD+PqCubhrt737NujbbT/JFY=
Received: from DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 10:28:09 +0000
Received: from DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::65a9:e78c:7f63:81ab]) by DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::65a9:e78c:7f63:81ab%6]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 10:28:09 +0000
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Topic: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Index: AQHWBB3U2hXO07jC8U6J6+lTktLsnqhcOBAAgAADaICAAAEdAA==
Date:   Fri, 27 Mar 2020 10:28:09 +0000
Message-ID: <53f27031-50bb-8fde-3c53-30307aec6982@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
 <20200327095447.GA1698181@kroah.com>
 <11a058bc-a947-a763-680f-a11fd454925a@synopsys.com>
 <20200327102409.GB1700570@kroah.com>
In-Reply-To: <20200327102409.GB1700570@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joglekar@synopsys.com; 
x-originating-ip: [198.182.52.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04684ee1-f649-424c-6dec-08d7d2398b93
x-ms-traffictypediagnostic: DM6PR12MB4434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4434C6B61C85406F1DF37C82A4CC0@DM6PR12MB4434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(316002)(36756003)(81156014)(186003)(8676002)(31696002)(86362001)(107886003)(6512007)(81166006)(6486002)(54906003)(76116006)(91956017)(2906002)(31686004)(478600001)(4326008)(2616005)(66946007)(64756008)(8936002)(53546011)(6506007)(5660300002)(26005)(66476007)(66556008)(66446008)(110136005)(71200400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB4434;H:DM6PR12MB4251.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ed0j9+Vtc5LDQEkn70zZqa5oCrg4/J665QsWoUOu3N4Y5wKdk7eh2EvPG6IrX6pumoHILfTvBR9tLvkH0y+wWWvAsNm4kF8tbkK1t1KHx5CGI+FHT365U8KJUCMIn4lFfWEVQXNj2hAiqozLiwFaaEwauMUXTlsXvf0G5fHT2qnsrkVOwhXGmjUebhgKZLebNbcSMSyLfyjNYHgYQIg642uIwbnwSoj0H5Ke9k8JRhCiACpUSZficjbAAPWDLsYOugIJkpx0W2fpPEDdFa2aziYo1wZnpqPbmxSs6n5D7Fk+9cvLmnWX/VsZ1HlwZWM++TWUoYy7vheEaR3mtZzBYygOlWtrPZ49xds/+fhJ+slDvXvCSG9f1JXfMeabtzQ6Cw6aJDPvbWa7Sn7gIYqzfomMk+23S9FGhJljrbieEKVlmD63yq3ejx6mLBn1SGyp5vO8Fx88/VgbEa/IsuGzJftqch/8409hy71TSqFiqmj72TFFB5ijjf4rlVB8Hpxr
x-ms-exchange-antispam-messagedata: fUkdcS4dRFAubVA/MnvHqXhk9h5Q8l0nz1xdD+iQZfy83C4xlLQGm954pblEdIG4+nqM8FT9S18ArbKRpDyyoafYASyHGq91dfZzYg9dp0mu012s2WrulJVHkEchqkVy2kcfwc582JVzLkYja72fWA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6CCB0FB71AFED4A9C78D87417695328@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04684ee1-f649-424c-6dec-08d7d2398b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 10:28:09.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sHPidsnbXtv4Wq8AFBwtFsqEf5XrED8FDO3eVww3Uv4s5N8qpIhIPx/vB2QN9fFEclYuQug+JEhEX0uPJBBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNy8yMDIwIDM6NTQgUE0sIEdyZWcgS0ggd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDI3LCAy
MDIwIGF0IDEwOjExOjU5QU0gKzAwMDAsIFRlamFzIEpvZ2xla2FyIHdyb3RlOg0KPj4gSGksDQo+
PiBPbiAzLzI3LzIwMjAgMzoyNCBQTSwgR3JlZyBLSCB3cm90ZToNCj4+PiBPbiBGcmksIE1hciAy
NywgMjAyMCBhdCAwMzoxMTo1NlBNICswNTMwLCBUZWphcyBKb2dsZWthciB3cm90ZToNCj4+Pj4g
VGhpcyBjb21taXQgYWRkcyB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgY29uc29saWRhdGUtc2dsLCBh
bmQNCj4+Pj4gc25wcyxjb25zb2xpZGF0ZS1zZ2wgcHJvcGVydHkuIFRoZXNlIHdoZW4gc2V0IGVu
YWJsZXMgdGhlIHF1aXJrIGZvcg0KPj4+PiBYSENJIGRyaXZlciBmb3IgY29uc29saWRhdGlvbiBv
ZiBzZyBsaXN0IGludG8gYSB0ZW1wb3JhcnkgYnVmZmVyIHdoZW4gc21hbGwNCj4+Pj4gYnVmZmVy
IHNpemVzIGFyZSBzY2F0dGVyZWQgb3ZlciB0aGUgc2cgbGlzdCBub3QgbWFraW5nIHVwIHRvIE1Q
UyBvciB0b3RhbA0KPj4+PiB0cmFuc2ZlciBzaXplIHdpdGhpbiBUUkIgY2FjaGUgc2l6ZSB3aXRo
IFN5bm9wc3lzIHhIQy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVGVqYXMgSm9nbGVrYXIg
PGpvZ2xla2FyQHN5bm9wc3lzLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMudHh0ICAgICB8IDMgKysrDQo+Pj4+ICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi14aGNpLnR4dCB8IDMgKysrDQo+Pj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQNCj4+Pj4gaW5kZXggOTk0
NmZmOWJhNzM1Li4yOTJkMWY3OTY5ZTQgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPj4+PiBAQCAtMTA0LDYgKzEwNCw5
IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+Pj4+ICAJCQl0aGlzIGFuZCB0eC10aHItbnVtLXBr
dC1wcmQgdG8gYSB2YWxpZCwgbm9uLXplcm8gdmFsdWUNCj4+Pj4gIAkJCTEtMTYgKERXQ191c2Iz
MSBwcm9ncmFtbWluZyBndWlkZSBzZWN0aW9uIDEuMi4zKSB0bw0KPj4+PiAgCQkJZW5hYmxlIHBl
cmlvZGljIEVTUyBUWCB0aHJlc2hvbGQuDQo+Pj4+ICsgLSBzbnBzLGNvbnNvbGlkYXRlLXNnbDog
ZW5hYmxlIHNnIGxpc3QgY29uc29saWRhdGlvbiAtIGhvc3QgbW9kZSBvbmx5LiBTZXQgdG8gdXNl
DQo+Pj4+ICsJCQlTRyBidWZmZXJzIG9mIGF0IGxlYXN0IE1QUyBzaXplIGJ5IGNvbnNvbGlkYXRp
bmcgc21hbGxlciBTRw0KPj4+PiArCQkJYnVmZmVycyBsaXN0IGludG8gYSBzaW5nbGUgYnVmZmVy
Lg0KPj4+PiAgDQo+Pj4+ICAgLSA8REVQUkVDQVRFRD4gdHgtZmlmby1yZXNpemU6IGRldGVybWlu
ZXMgaWYgdGhlIEZJRk8gKmhhcyogdG8gYmUgcmVhbGxvY2F0ZWQuDQo+Pj4+ICAgLSBzbnBzLGlu
Y3ItYnVyc3QtdHlwZS1hZGp1c3RtZW50OiBWYWx1ZSBmb3IgSU5DUiBidXJzdCB0eXBlIG9mIEdT
QlVTQ0ZHMA0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi91c2IteGhjaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3VzYi14aGNpLnR4dA0KPj4+PiBpbmRleCAzZjM3ODk1MWQ2MjQuLmE5MGQ4NTM1NTdlZSAx
MDA2NDQNCj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91
c2IteGhjaS50eHQNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi91c2IteGhjaS50eHQNCj4+Pj4gQEAgLTQzLDYgKzQzLDkgQEAgT3B0aW9uYWwgcHJvcGVy
dGllczoNCj4+Pj4gICAgLSBxdWlyay1icm9rZW4tcG9ydC1wZWQ6IHNldCBpZiB0aGUgY29udHJv
bGxlciBoYXMgYnJva2VuIHBvcnQgZGlzYWJsZSBtZWNoYW5pc20NCj4+Pj4gICAgLSBpbW9kLWlu
dGVydmFsLW5zOiBkZWZhdWx0IGludGVycnVwdCBtb2RlcmF0aW9uIGludGVydmFsIGlzIDUwMDBu
cw0KPj4+PiAgICAtIHBoeXMgOiBzZWUgdXNiLWhjZC55YW1sIGluIHRoZSBjdXJyZW50IGRpcmVj
dG9yeQ0KPj4+PiArICAtIGNvbnNvbGlkYXRlLXNnbDogaW5kaWNhdGUgaWYgeW91IG5lZWQgdG8g
Y29uc29saWRhdGUgc2cgbGlzdCBpbnRvIGENCj4+Pj4gKyAgICB0ZW1wb3JhcnkgYnVmZmVyIHdo
ZW4gc21hbGwgU0cgYnVmZmVyIHNpemVzIGRvZXMgbm90IG1ha2UgdXB0byBNUFMNCj4+Pj4gKyAg
ICBzaXplIG9yIHRvdGFsIHRyYW5zZmVyIHNpemUgYWNyb3NzIHRoZSBUUkIgY2FjaGUgc2l6ZS4N
Cj4+Pg0KPj4+IFNob3VsZG4ndCB0aGlzIHJlZmVyIHRvIHRoZSBmYWN0IHRoYXQgdGhlIGhhcmR3
YXJlIGlzIGJyb2tlbj8gIE90aGVyd2lzZQ0KPj4+IHdoeSB3b3VsZCBhbnlvbmUga25vdyBpZiB0
aGV5IHNob3VsZCwgb3Igc2hvdWxkIG5vdCwgZW5hYmxlIHRoaXMgb3B0aW9uPw0KPj4+DQo+PiBX
ZSBoYXZlIG5vdCBzZWVuIGlzc3VlIHdpdGggTGludXggZW52aXJvbm1lbnQgZm9yIG5vdy4gQnV0
IHdpdGggb3RoZXIgT1Mgd2l0aA0KPj4gU0cgbGlzdCB3aXRoIHZlcnkgc21hbGwgYnVmZmVyIHNp
emVzIHRoZSB4SEMgY29udHJvbGxlciBoYW5nIHdhcyBzZWVuLiBTbyANCj4+IGN1cnJlbnRseSBp
bnRyb2R1Y2luZyB0aGUgYmluZGluZyBhcyBvcHRpb25hbCBvbmUuIE9uZSBjb3VsZCBlbmFibGUg
dGhpcyANCj4+IG9wdGlvbiB3aGVuIHhIQyBoYWx0IGhhcHBlbnMgZHVlIHRvIHNtYWxsIFNHIGxp
c3Qgc2l6ZXMuICANCj4gDQo+IFdoYXQgSSBtZWFuIGlzIHRoaXMgc2hvdWxkIGJlIHNvbWV0aGlu
ZyBsaWtlLA0KPiAicXVpcmstYnJva2VuLXNnLWxpc3QtaGFuZGxlciIgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4gIE90aGVyd2lzZSBob3cNCj4gZG9lcyBhbnlvbmUga25vdyBpZiB0aGlzIHJlYWxs
eSBpcyBuZWVkZWQgb3Igbm90LiAgUmVhZGluZyB0aGlzIHdvdWxkDQo+IHNlZW0gbGlrZSBldmVy
eW9uZSB3b3VsZCBsaWtlIHRvIGRvIHRoaXMsIGFzIGNvbnNvbGlkYXRpbmcgbGlua3MNCj4gc291
bmRzIGxpa2UgYSBnb29kIG9wdGltaXphdGlvbiwgd2hlbiBpbnN0ZWFkIHRoaXMgcmVhbGx5IGNh
dXNlIG1vcmUNCj4gbWVtb3J5IGFsbG9jYXRpb25zLCBtYWtpbmcgdGhpcyBwb3NzaWJseSB3b3Jz
ZSBwZXJmb3JtYW5jZS4NCj4gDQpTdXJlLCB1bmRlcnN0b29kLiBJIHdpbGwgcmVuYW1lIHRoaXMg
ZW50cnkuDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo+IA0KDQpUaGFua3MgJiBSZWdhcmRz
LA0KIFRlamFzIEpvZ2xla2FyDQo=
