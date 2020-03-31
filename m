Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234620748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgCaAlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:41:19 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:37348 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:41:18 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V0W1YX020678;
        Tue, 31 Mar 2020 00:41:00 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 303mqw2h1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 00:41:00 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 6D3EB91;
        Tue, 31 Mar 2020 00:40:59 +0000 (UTC)
Received: from G4W9326.americas.hpqcorp.net (16.208.32.96) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 31 Mar 2020 00:40:59 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9326.americas.hpqcorp.net (2002:10d0:2060::10d0:2060) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 00:40:48 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 31 Mar 2020 00:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz+sbJJXsrSBe2unM6xcY5BtaB2T7N2SMvKyGIKCPXwBVJUHgifUWaI2w+lCUmerOXchUdJY9QShtoKy2HCPrYbqHqWJie/V5Gg8P6vMxZLOT2MEBVSjRHR/AW+mI+VATO8G+FGmNsEYvtPhBxwzHs5rnRjc8dO2lmXwAVPSAV5Yc+dkgpfVLPwQlGSKUAGARsNdrF/K9XZySl6Ug7ufKTkQ5LgO5OCECTrW+PWmjiVC87AcvcIAxFEPUWzGqed2E5y9B/K8gscneGfmn67ALnZ3Ed3eGXs19WKlVXbQzgOlb2+o80NN4jmBkDLglrTmVCOdlNcYppW7gc6ANw/DrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ftq7oR4ZJTzjerN6nl27wRqGjHiAIRfkXIJXfiZO0I=;
 b=nbJ5WtnptOFnckdsX4RK8+FmgiO6hfOlNIjciuUwYM2yMmhMMFhJSTPhta/d0HS6+dKwENz10nra7CyXavR6D6SnZdWsSNiATjQ53+0cQafqLmfbvzy9nXZ7AcYDz78uQySFDN83x+ylJsngh2kvkm45l48eBNXbqcQOgw85FpMDI7Y1op5qywUJpA+EZnIRS3o8RIGusm8fY3kBHUpYvMvv222W17jsnrRPOyrw/WzlX9CQAu/C1sjSQz2C1nKhk43JHot/RJiF1G4tlOxYyVS9QAp0+SaCGBJXD2XAmsli8UKpGLLOm9/W50LMg+MWF2BVmI0y3B13YHtcLHhw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::15) by CS1PR8401MB1189.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7513::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Tue, 31 Mar
 2020 00:40:46 +0000
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6023:914f:6cca:4c98]) by CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6023:914f:6cca:4c98%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 00:40:46 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Greg Thelen" <gthelen@google.com>, Salman Qazi <sqazi@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] mm: clear 1G pages with streaming stores on x86
Thread-Topic: [PATCH] mm: clear 1G pages with streaming stores on x86
Thread-Index: AQHV9BxTUcdpkrKhkkWxKukJhgDyEqg/ZXUAgACWXQCAAG2HgIAAMeMAgAHykQCAAAlMgIAALQQAgABOS4CAAKxEgIAeQSIg
Date:   Tue, 31 Mar 2020 00:40:46 +0000
Message-ID: <CS1PR8401MB12375ECD03418C2CC8BBDF92ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box> <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200311033552.GA3657254@rani.riverdale.lan>
 <20200311081607.3ahlk4msosj4qjsj@box>
 <20200311183240.GA3880414@rani.riverdale.lan>
In-Reply-To: <20200311183240.GA3880414@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.206.28.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81e2eedd-2f74-487e-15b8-08d7d50c271c
x-ms-traffictypediagnostic: CS1PR8401MB1189:
x-microsoft-antispam-prvs: <CS1PR8401MB118970DD05956F53C5CFAD74ABC80@CS1PR8401MB1189.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(53546011)(6506007)(2906002)(55016002)(478600001)(81156014)(86362001)(33656002)(7696005)(5660300002)(81166006)(8676002)(7416002)(66446008)(54906003)(76116006)(64756008)(66556008)(110136005)(66476007)(52536014)(316002)(4326008)(66946007)(186003)(71200400001)(26005)(9686003)(8936002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kc76ktQxy98BjqagdbCBKioIQqmEgU0lfFcM75aB0oksOIzCWkzdr6X+RV/yGtI5TaJoqjakKBLwPR71r5xZ0hq7XEUtPGUMMN/gzMIwaqCkXCAYEi1siN0HpkqkblSi4M5psqMeDk+N1BPyqABw06NX7nAjaO1frLSTT4aaTcP0UIiFTBhZ4CFIw1CxVx3jyJ4Dk3bFg2COgwhQ1f06OITTEMeoe0UR+4b4K46Hsh7cAzFRe7758PHsYBMOJjkcF99LlBrTUUgsQ0T6MI8RGaJrech6FZ7YDDBS4+o16ZU/q6/hUgSPNERmWyLoWXRCDtyMyfMS8+VhC9XWWRZR18d/R+BzUJ2aNOOQF42my6kejMou1lSMz92x/HA2QPBQaDqZ4s5WL+DRudn9vlMwE/OtCwHftJklfAee/D4Md6qqpcdNaZlGQUYx62XjcuMQ
x-ms-exchange-antispam-messagedata: 6QZ0WupoOAXY1vKq761GV0nQMI+45nyb7IVMIbYAT65SqYDrYEwAgkf3im4LX3CnLIOGCtHbgcs7p3stzanKa1CHJm/DkDoSgb/chK8LiZ67fAATVboCqFEstRWAmD7LJDHEl+z2EnehjL0kyhfoQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2eedd-2f74-487e-15b8-08d7d50c271c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 00:40:46.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPWq09CbF4dyqR/g3SJvqZsYobr3AsdqGD5i6WotOJJ2TUnecXVdjsSDkdRrw6Qn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1189
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=798
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBBcnZpbmQgU2Fua2FyDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MTEsIDIwMjAgMTozMyBQTQ0KPiBUbzogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGxAc2h1dGVt
b3YubmFtZT4NCj4gQ2M6IEFydmluZCBTYW5rYXIgPG5pdmVkaXRhQGFsdW0ubWl0LmVkdT47IENh
bm5vbiBNYXR0aGV3cw0KPiA8Y2Fubm9ubWF0dGhld3NAZ29vZ2xlLmNvbT47IE1hdHRoZXcgV2ls
Y294IDx3aWxseUBpbmZyYWRlYWQub3JnPjsNCj4gQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwu
Y29tPjsgTWljaGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz47DQo+IE1pa2UgS3JhdmV0eiA8
bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20+OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LQ0KPiBm
b3VuZGF0aW9uLm9yZz47IERhdmlkIFJpZW50amVzIDxyaWVudGplc0Bnb29nbGUuY29tPjsgR3Jl
ZyBUaGVsZW4NCj4gPGd0aGVsZW5AZ29vZ2xlLmNvbT47IFNhbG1hbiBRYXppIDxzcWF6aUBnb29n
bGUuY29tPjsgbGludXgtDQo+IG1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW06IGNsZWFyIDFH
IHBhZ2VzIHdpdGggc3RyZWFtaW5nIHN0b3JlcyBvbiB4ODYNCj4gDQo+IE9uIFdlZCwgTWFyIDEx
LCAyMDIwIGF0IDExOjE2OjA3QU0gKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4g
PiBPbiBUdWUsIE1hciAxMCwgMjAyMCBhdCAxMTozNTo1NFBNIC0wNDAwLCBBcnZpbmQgU2Fua2Fy
IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRoZSByYXRpb25hbGUgZm9yIE1PVk5USSBpbnN0cnVjdGlv
biBpcyBzdXBwb3NlZCB0byBiZSB0aGF0IGl0DQo+IGF2b2lkcw0KPiA+ID4gY2FjaGUgcG9sbHV0
aW9uLiBBc2lkZSBmcm9tIHRoZSBiZW5jaCB0aGF0IHNob3dzIE1PVk5USSB0byBiZQ0KPiBmYXN0
ZXIgZm9yDQo+ID4gPiB0aGUgbW92ZSBpdHNlbGYsIHNob3VsZG4ndCBpdCBoYXZlIGFuIGFkZGl0
aW9uYWwgYmVuZWZpdCBpbiBub3QNCj4gdHJhc2hpbmcNCj4gPiA+IHRoZSBDUFUgY2FjaGVzPw0K
PiA+ID4NCj4gPiA+IEFzIHN0cmluZyBpbnN0cnVjdGlvbnMgaW1wcm92ZSwgd2h5IHdvdWxkbid0
IHRoZSBzYW1lDQo+IGltcHJvdmVtZW50cyBiZQ0KPiA+ID4gYXBwbGllZCB0byBNT1ZOVEk/DQo+
ID4NCj4gPiBTdHJpbmcgaW5zdHJ1Y3Rpb25zIGluaGVyZW50bHkgbW9yZSBmbGV4aWJsZS4gSW1w
bGVtZW50YXRpb24gY2FuDQo+IGNob29zZQ0KPiA+IGNhY2hpbmcgc3RyYXRlZ3kgZGVwZW5kaW5n
IG9uIHRoZSBvcGVyYXRpb24gc2l6ZSAoY3gpIGFuZCBvdGhlcg0KPiBmYWN0b3JzLg0KPiA+IExp
a2UgaWYgb3BlcmF0aW9uIGlzIGxhcmdlIGVub3VnaCBhbmQgY2FjaGUgaXMgZnVsbCBvZiBkaXJ0
eSBjYWNoZQ0KPiBsaW5lcw0KPiA+IHRoYXQgZXhwZW5zaXZlIHRvIGZyZWUgdXAsIGl0IGNhbiBj
aG9vc2UgdG8gYnlwYXNzIGNhY2hlLiBNT1ZOVEkgaXMNCj4gbW9yZQ0KPiA+IHN0cmljdCBvbiBz
ZW1hbnRpY3MgYW5kIG1vcmUgb3BhcXVlIHRvIENQVS4NCj4gDQo+IEJ1dCB3aXRoIHRvZGF5J3Mg
cHJvY2Vzc29ycywgd291bGRuJ3Qgd3JpdGluZyAxRyB2aWEgdGhlIHN0cmluZw0KPiBvcGVyYXRp
b25zIGVtcHR5IG91dCBhbG1vc3QgdGhlIHdob2xlIGNhY2hlPyBPciBhcmUgdGhlcmUgYWxyZWFk
eQ0KPiBvcHRpbWl6YXRpb25zIHRvIHByZXZlbnQgb25lIHRocmVhZCBmcm9tIGhvZ2dpbmcgdGhl
IEwzPw0KPiANCj4gSWYgd2UgZG8gd2FudCB0byBqdXN0IHVzZSB0aGUgc3RyaW5nIG9wZXJhdGlv
bnMsIGl0IHNlZW1zIGxpa2UgdGhlDQo+IGNsZWFyX3BhZ2Ugcm91dGluZXMgc2hvdWxkIGp1c3Qg
Y2FsbCBtZW1zZXQgaW5zdGVhZCBvZiBkdXBsaWNhdGluZw0KPiBpdC4NCj4gDQoNClRoZSBsYXN0
IHRpbWUgSSBjaGVja2VkLCBnbGliYyBtZW1jcHkoKSBjaG9zZSBub24tdGVtcG9yYWwgc3RvcmVz
IGJhc2VkDQpvbiB0cmFuc2ZlciBzaXplLCBMMyBjYWNoZSBzaXplLCBhbmQgdGhlIG51bWJlciBv
ZiBjb3Jlcy4NCkZvciBleGFtcGxlLCB3aXRoIGdsaWJjLTIuMjE2LTE2LmZjMjcgKEF1Z3VzdCAy
MDE3KSwgb24gYSBCcm9hZHdlbGwNCnN5c3RlbSB3aXRoIEU1LTI2OTkgMzYgY29yZXMgNDUgTWlC
IEwzIGNhY2hlLCBub24tdGVtcG9yYWwgc3RvcmVzIG9ubHkNCnN0YXJ0IHRvIGJlIHVzZWQgYWJv
dmUgMzYgTWlCLg0KDQoNCg==
