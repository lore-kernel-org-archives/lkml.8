Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EF820899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bEANDDLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgE0T1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:27:34 -0400
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com ([40.107.243.104]:31201
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgE0T1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUcjGd7Eryj83VOB8vG9GB95fFquy8xxNJpwC8+mxBGioG1JVqu+LjJNhemxw6pkypzeQKWRV9aDH++oOQO2TyZYGVZAw0fm68wBWBdX4LIJOlJ5S8ft7DkvpQNKhe/0j/+dzWT09hEiCps+4H3O703mSczs+wGPY2rWYa/0/weDjqZIRqtFxfGKKO/lb/FvW0VJPbpE4JFUVT0pXtmP10BOmraPcj9ZUUpt1Hr0SQv0YQjxquWWP+hsgw1Uh3TfUt8Y02EbSdIzaMlL9AjGBb0ANP5O9idFS0WembWztbj2u71IDtm2rQlkSwDMWROfi50BNKKR9kEIZkexcOM6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhmvU8b4qPayqGXyyD/SyXPmAmzquH/ZvSmvPvkE+Lo=;
 b=W8TGDg5+cA2d+wXojM2g2ajOynm1ZBBhYoOD1aknZ3jjJQ86r7Mk3K49lGhQahI5X8G4dowwYJe3L7P4hB+8El5+gWosYytFBUV41gM/ibnjuWjyRf//OsRGs9TC1PqGlS0NX0Da+7HDOQTWD6TgO0aYXNVzUsxOo9F7JvYh1pGSiwCWdi8VPT2/EbGSl+9HGmQAZg0vb+BGm8g4URNdrUVxD78puWcnHXFJNNW0giQMQVdyBA+Ljaix9ek8Rk0+wmCr3cREngChhERIBPO9hyfy1IkiYAJqSyhd/1bZI7ZDulm8XlklN2Uhys5/VMikKImt18CwpUOKkmOGqXX+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhmvU8b4qPayqGXyyD/SyXPmAmzquH/ZvSmvPvkE+Lo=;
 b=bEANDDLKYOLKkdnhRjHEVX1llIwsxvld6Vj6+fWCQk+6nu0wx4TDGDTKFW1Jv27MuPiUKOoeqb6F4AhJOEm4DFxOZi0hkbyvq4SyDbzWvDSKpsuYHvHxKXD5aTnavyObDNmMO4KM3vexVEyYyrMrk0UmBm0JefVw+voeua71KQE=
Received: from MN2PR21MB1518.namprd21.prod.outlook.com (2603:10b6:208:20e::24)
 by MN2PR21MB1502.namprd21.prod.outlook.com (2603:10b6:208:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.5; Wed, 27 May
 2020 19:27:28 +0000
Received: from MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88]) by MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88%8]) with mapi id 15.20.3066.007; Wed, 27 May 2020
 19:27:28 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Ian Rogers <irogers@google.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Topic: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Index: AQHWM8mKGkvgLkOO8Em0Algb20rYzKi8SrMAgAACEUA=
Date:   Wed, 27 May 2020 19:27:28 +0000
Message-ID: <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
In-Reply-To: <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-27T19:27:27Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ee7bcf6-f175-4484-a184-cf957bd28845;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [75.182.186.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00a24e30-df63-47c1-73e3-08d80273fe74
x-ms-traffictypediagnostic: MN2PR21MB1502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB150214A041D42747CA912CAEF7B10@MN2PR21MB1502.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOiI9luSdYqcqhj3Dzi4XnrHgYe025m8+GH586nQ6CqIi+1j4d7CaR5acf4gK2Xd8/iZ29XlHH5xfpYTd8Nrb8jfZ/etfKEqT4vPMqojkIEQleUrVYb4zIFKNtH/svUWkMoFxqbjYYAkctyF1GR/4Wpwb9f0x3IDC5Ey7xYpjqzvqL2+kN72o6wsltkhs8dqnK8+qV11vp8odfYyIkRMUKj3GWrSHEYO4L+FOkUZ4p+RIrCA+5MeGx29j8Jrbgw1G1z9xcMK83QfkCwjTG54I2P+dEJpKet/oF/2AP8oMthot5R8v6I4caHwifjgSlUy5g1iMeEJbxPZsVXB2wperQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1518.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(26005)(86362001)(10290500003)(478600001)(71200400001)(9686003)(55016002)(82960400001)(82950400001)(8990500004)(7416002)(110136005)(5660300002)(66446008)(76116006)(4326008)(186003)(2906002)(52536014)(33656002)(66556008)(54906003)(66476007)(8676002)(66946007)(64756008)(316002)(6506007)(7696005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y1kHB3q4axv6UmnFrYeaM8+v97pbPzDrjAhc5gViGdUN5ZSdSVqePQsPWrWjo4W6kJ5WGJxhA9tRX4V2e1HlyCoOTt49tcsk51P9j2xSvxUk/mIUNa1NhLHeeh/Yp7BD56nrriLOgYn8k92t7E6w1triiUjZ5QAurF8y8HT6hNInBFv9k6zxK+seCU3mRYV79SRa1d9nDySMDhYLZuiYGJ3A8bTscCAxjeE6iazzHQrbRWGjkCrpCkaU7qrYDk7E9gAO2W378XAFiC9nKIXBEe4lALfYfmE7Qx113aOjPOgzN8T68J3Z7Uxh1r6aEcHWNYeIQ9otjUy9l0/SXs9mnUsBPMQzknCDXvlaqmCaCS28YpqMiumTN3XJdo8fwof4+TLUQ6gG5YrwlniBuDnsuvBfErGx2NFhR6VCnzFEXIiyAl9oPmqhzuUqLYBYAZCcjcY1VckGTy43mH+v7c4mgpay6Kc52GLRXtDjFF3eSUvC8HC99MoZvTroafozp98V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a24e30-df63-47c1-73e3-08d80273fe74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 19:27:28.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFXUVWrRkJLbOoTsAfeu+iL3fRyWUDDZFEAGx2MgA7GhOwmkYVboibfq992K+lDbm1TaRtXvZ7RZwS9IjxbnCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKiogSW1wbGVtZW50ZWQgc29sdXRpb24NCj4+DQo+PiBUaGlzIHBhdGNoIHNvbHZlcyB0aGUg
aXNzdWUgYnkgcmVtb3ZpbmcgLy8gYW5vbiBtbWFwIGV2ZW50cyBmb3IgYW55IA0KPj4gcHJvY2Vz
cyB3aGljaCBoYXMgYSB2YWxpZCBqaXQtPHBpZD4uZHVtcCBmaWxlLg0KPj4NCj4+IEl0IHRyYWNr
cyBvbiBhIHBlciBwcm9jZXNzIGJhc2lzIHRvIGhhbmRsZSB0aGUgY2FzZSB3aGVyZSBzb21lIHJ1
bm5pbmcgDQo+PiBhcHBzIHN1cHBvcnQgaml0LTxwaWQ+LmR1bXAsIGJ1dCBzb21lIG9ubHkgc3Vw
cG9ydCBwZXJmLTxwaWQ+Lm1hcC4NCj4+DQo+PiBJdCBhZGRzIG5ldyBhc3N1bXB0aW9uczoNCj4+
ICogLy8gYW5vbiBtbWFwIGV2ZW50cyBhcmUgb25seSByZXF1aXJlZCBmb3IgcGVyZi08cGlkPi5t
YXAgc3VwcG9ydC4NCj4+ICogQW4gYXBwIHRoYXQgdXNlcyBqaXQtPHBpZD4uZHVtcCwgbm8gbG9u
Z2VyIG5lZWRzIHBlcmYtPHBpZD4ubWFwIA0KPj4gc3VwcG9ydC4gSXQgYXNzdW1lcyB0aGF0IGFu
eSBwZXJmLTxwaWQ+Lm1hcCBpbmZvIGlzIGluZmVyaW9yLg0KPj4NCj4+ICoqKiBEZXRhaWxzDQo+
Pg0KPj4gVXNlIHRocmVhZC0+cHJpdiB0byBzdG9yZSB3aGV0aGVyIGEgaml0ZHVtcCBmaWxlIGhh
cyBiZWVuIHByb2Nlc3NlZA0KPj4NCj4+IER1cmluZyAicGVyZiBpbmplY3QgLS1qaXQiLCBkaXNj
YXJkICIvL2Fub24qIiBtbWFwIGV2ZW50cyBmb3IgYW55IHBpZCANCj4+IHdoaWNoIGhhcyBzdWNl
c3NmdWxseSBwcm9jZXNzZWQgYSBqaXRkdW1wIGZpbGUuDQo+DQo+DQo+IFRoYW5rcyBTdGV2ZSB0
aGlzIGlzIGFuIGltcG9ydGFudCBmaXghIEFzIC8vYW5vbiBjb3VsZCBiZSBmb3IgbWFsbG9jIG9y
IG90aGVyIHVzZXMsIHNob3VsZCB0aGUgc3RyaXBwaW5nIGJlaGF2aW9yIGJlIGJlaGluZCBhIGZs
YWc/IA0KPg0KPiBJYW4NCg0KSSBoYWRuJ3QgYW50aWNpcGF0ZWQgYSBuZWVkIHRvIHByZXNlcnZl
IHRoZSAvL2Fub24gbW1hcCBldmVudHMgd2hlbiBwcm9maWxpbmcgSklUIGdlbmVyYXRlZCBjb2Rl
Lg0KDQpBcyBmYXIgYXMgSSBrbm93IG1tYXAgZXZlbnRzIGFyZSBjYXB0dXJlZCBieSBwZXJmIG9u
bHkgZm9yIG1hcHBpbmcgY29kZSB0byBzeW1ib2xzLiAgRmlsZSBtYXBwaW5ncyBhcmUga2VwdA0K
YnkgdGhlIGNoYW5nZS4gIE9ubHkgLy8gYW5vbiBtYXBwaW5ncyBhcmUgc3RyaXBwZWQuICAoT25s
eSBmb3IgcHJvY2Vzc2VzIHdoaWNoIGVtaXR0ZWQgaml0ZHVtcCBmaWxlcy4pDQpBbmQgdGhlc2Ug
YXJlIHN0cmlwcGVkIG9ubHkgZHVyaW5nIHRoZSBgcGVyZiBpbmplY3QgLS1qaXRgIHN0ZXAuIEkg
YmVsaWV2ZSB0aGUgLy8gQW5vbiBtYXBwaW5nIGFyZSBvbmx5IA0KZ2VuZXJhbGx5IHVzZWZ1bCBm
b3IgbWFwcGluZyBKSVQgY29kZS4NCg0KSSBzdXBwb3NlIGlmIHNvbWVvbmUgd2FzIHRyeWluZyB0
byBjb3VudCBtbWFwIGV2ZW50cyBpdCBtaWdodCBiZSBjb25mdXNpbmcsIGJ1dCBgcGVyZiBpbmpl
Y3QgLS1qaXRgIGNyZWF0ZXMgDQpzeW50aGV0aWMgbW1hcCBmaWxlIGV2ZW50cyB3aGljaCB3b3Vs
ZCBhbHNvIG1ha2UgdGhpcyBzY2VuYXJpbyBjb25mdXNpbmcuDQoNCkkgcGVyc29uYWxseSBkb24n
dCBzZWUgYSBnb29kIHJlYXNvbiB0byBhZGQgYSBmbGFnLiAgSSBhbHNvIGRvbid0IHNlZSBhIHNp
bXBsZSB3YXkgZWl0aGVyLiAgTm90IHJ1bm5pbmcgYHBlcmYgaW5qZWN0IC0taml0YA0Kd291bGQg
cHJlc2VydmUgZXhpc3RpbmcgYmVoYXZpb3Igdy9vIGppdGR1bXAgc3VwcG9ydC4gIFdpdGhvdXQg
c3RyaXBwaW5nIHRoZSBhbm9uIGV2ZW50cyBqaXRkdW1wIHN1cHBvcnQgaXMgcGFpbmZ1bGx5DQpi
cm9rZW4uLi4uDQo=
