Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C54BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1254B206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="BW0P9h9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFHUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:42:05 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:14084 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgFHUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:42:04 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KbFct010647;
        Mon, 8 Jun 2020 16:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=N9H+Y8buT+jotvXtzH9dwV1q2oPKTZnlCkgtVcsuoSU=;
 b=BW0P9h9Iz+1XreP3xccaro56svqohNY3k7km4nR/tnK5Q7jTLZ/2WsRWLYscmJKYDrcN
 dAiWrFckOLG+xyI4u2E5LAk0QDumqspb0f0mjQbXzt6UKfnmVcE9E4NQvb4YZmlfsYmK
 oR+Aer82BJJ3ohHQeyuo2yLh23IV+mnrSSds0CtkzL1/ypN6EVoOAAexf4ZsKKKxtz+M
 2GaTngcjMxZeS/I5P4wk+MQBpRFiKTR2vHgQ4ApISxjtTc4eDMRxYE2F1pPCIxl77w9g
 tLTY37m45Ru6XI675gIhPLK92SMm93BBpPtXQRtMjeVDzPRW9i4KwLWROl7PRzyQPbc5 ig== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31g47t6cua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 16:42:01 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KdHO4042593;
        Mon, 8 Jun 2020 16:42:01 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 31g7xfcyyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:42:01 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="497429425"
From:   <Mario.Limonciello@dell.com>
To:     <y.linux@paritcher.com>, <hdegoede@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>,
        <pali@kernel.org>
Subject: RE: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Topic: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Index: AQHWPUx5kZ6BCWcrZkepA13uOwTuTKjO2RsQgACifgD//7DjgA==
Date:   Mon, 8 Jun 2020 20:36:58 +0000
Message-ID: <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
In-Reply-To: <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T20:36:56.1946643Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6e911269-6054-4d45-93f5-26cb4d27a263;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 cotscore=-2147483648 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZIFBhcml0Y2hlciA8eS5saW51
eEBwYXJpdGNoZXIuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyMCAzOjEzIFBNDQo+
IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOw0KPiBtamc1OUBzcmNmLnVj
YW0ub3JnOyBwYWxpQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIHBsYXRm
b3JtL3g4NjogZGVsbC13bWk6IGFkZCBuZXcga2V5bWFwIHR5cGUgMHgwMDEyDQo+IA0KPiANCj4g
W0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gNi84LzIwIDExOjQwIEFNLCBNYXJpby5MaW1vbmNp
ZWxsb0BkZWxsLmNvbSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogcGxhdGZvcm0tZHJpdmVyLXg4Ni1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPHBsYXRm
b3JtLWRyaXZlci14ODYtDQo+ID4+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9m
IFkgUGFyaXRjaGVyDQo+ID4+IFNlbnQ6IFN1bmRheSwgSnVuZSA3LCAyMDIwIDExOjIyIFBNDQo+
ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2
QHZnZXIua2VybmVsLm9yZzsNCj4gPj4gTWF0dGhldyBHYXJyZXR0OyBQYWxpIFJvaMOhcg0KPiA+
PiBTdWJqZWN0OiBbUEFUQ0ggMi8zXSBwbGF0Zm9ybS94ODY6IGRlbGwtd21pOiBhZGQgbmV3IGtl
eW1hcCB0eXBlIDB4MDAxMg0KPiA+Pg0KPiA+Pg0KPiA+PiBbRVhURVJOQUwgRU1BSUxdDQo+ID4+
DQo+ID4+IElnbm9yZSBldmVudHMgd2l0aCBhIHR5cGUgb2YgMHgwMDEyIGFuZCBhIGNvZGUgb2Yg
MHhlMDM1LA0KPiA+PiB0aGlzIHNpbGVuY2VzIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgYmVpbmcg
bG9nZ2VkIHdoZW4NCj4gPj4gcHJlc3NpbmcgdGhlIEZuLWxvY2sga2V5IG9uIGEgRGVsbCBJbnNw
aXJvbiA1NTkzOg0KPiA+Pg0KPiA+PiBkZWxsX3dtaTogVW5rbm93biBXTUkgZXZlbnQgdHlwZSAw
eDEyDQo+ID4+IGRlbGxfd21pOiBVbmtub3duIGtleSB3aXRoIHR5cGUgMHgwMDEyIGFuZCBjb2Rl
IDB4ZTAzNSBwcmVzc2VkDQo+ID4NCj4gPiBFdmVudCB0eXBlIDB4MTIgaXMgZm9yICJTeXN0ZW0g
RXZlbnRzIi4gIFRoaXMgaXMgdGhlIHR5cGUgb2YgZXZlbnRzIHRoYXQNCj4gPiB5b3UgdHlwaWNh
bGx5IHdvdWxkIHNlZSBjb21lIGluIGZvciB0aGluZ3MgImxpa2UiIHRoZSB3cm9uZyBwb3dlciBh
ZGFwdGVyDQo+ID4gYmVpbmcgcGx1Z2dlZCBpbiBvbiBXaW5kb3dzIG9yIHN0dWZmIGFib3V0IHBs
dWdnaW5nIGEgVGh1bmRlcmJvbHQgZG9jaw0KPiBpbnRvDQo+ID4gYSBwb3J0IHRoYXQgZG9lc24n
dCBzdXBwb3J0IFRodW5kZXJib2x0Lg0KPiA+DQo+ID4gQSBtZXNzYWdlIG1pZ2h0IGxvb2sgc29t
ZXRoaW5nIGxpa2UgKHBhcmFwaHJhc2VkKQ0KPiA+ICJZb3VyIHN5c3RlbSByZXF1aXJlcyBhIDE4
MFcgcG93ZXIgYWRhcHRlciB0byBjaGFyZ2UgZWZmZWN0aXZlbHksIGJ1dCB5b3UNCj4gPiBwbHVn
Z2VkIGluIGEgNjBXIGFkYXB0ZXIuIg0KPiA+DQo+ID4gVGhlcmUgb2Z0ZW4gaXMgZXh0ZW5kZWQg
ZGF0YSB3aXRoIHRoZXNlIGV2ZW50cy4gIEFzIHN1Y2ggSSBkb24ndCBiZWxpZXZlDQo+IGFsbA0K
PiA+IGluZm9ybWF0aW9uIGluIGV2ZW50IHR5cGUgMHgwMDEyIHNob3VsZCBiZSB0cmVhdGVkIGxp
a2Ugc2NhbiBjb2RlcyBsaWtlDQo+IHRob3NlIGluDQo+ID4gMHgxMCBvciAweDExLg0KPiA+DQo+
ID4gSSB3b3VsZCBndWVzcyB0aGF0IEZuLWxvY2sgb24gdGhpcyBtYWNoaW5lIHByb2JhYmx5IGhh
cyBleHRlbmRlZCBkYXRhIGluDQo+IHRoZSBuZXh0DQo+ID4gc2hvd2luZyB3aGV0aGVyIGl0IHdh
cyB0dXJuZWQgb24gYW5kIG9mZi4gIElmIGl0IGRvZXMsIHBlcmhhcHMgaXQgbWFrZXMNCj4gc2Vu
c2UgdG8NCj4gPiBzZW5kIHRoaXMgaW5mb3JtYXRpb24gdG8gdXNlcnNwYWNlIGFzIGFuIGV2ZGV2
IHN3aXRjaCBpbnN0ZWFkLg0KPiA+DQo+IA0KPiBZb3UgYXJlIHJpZ2h0Lg0KPiBJIGhhZCBhc3N1
bWVkIChpbmNvcnJlY3RseSkgdGhlIHdlcmUgdGhlIHNhbWUuDQo+IEkgdHVybmVkIG9uIGR5bmRi
ZyBhbmQgZ290IHRoZSBldmVudHMgd2l0aCB0aGUgZXh0ZW5kZWQgZGF0YS4NCj4gDQo+IEZuIGxv
Y2sga2V5IHN3aXRjaGVkIHRvIG11bHRpbWVkaWEga2V5cw0KPiBkZWxsX3dtaTogUmVjZWl2ZWQg
V01JIGV2ZW50ICgwMiAwMCAxMiAwMCAzNSBlMCAwMSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0K
PiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMA0KPiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCkNCj4gdGhlIGV4dGVuZGVkIGRh
dGEgaXMgZTAgMDENCj4gDQo+IEZuLWxvY2sgc3dpdGNoZWQgdG8gZnVuY3Rpb24ga2V5cw0KPiBk
ZWxsX3dtaTogUmVjZWl2ZWQgV01JIGV2ZW50ICgwMiAwMCAxMiAwMCAzNSBlMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMA0KPiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCkN
Cj4gdGhlIGV4dGVuZGVkIGRhdGEgaXMgZTAgMDANCg0KVG8gYmUgY2xlYXIgLSBkbyB0aGUgZnVu
Y3Rpb24ga2V5cyBub3Qgc2VuZCBkaWZmZXJlbnQgc2NhbiBjb2RlcyBvbiB0aGlzIGxhcHRvcA0K
aW4gdGhlIHR3byBkaWZmZXJlbnQgbW9kZXM/ICBJIGV4cGVjdGVkIHRoYXQgdGhleSBzaG91bGQg
YmUgc2VuZGluZyBzZXBhcmF0ZSBzY2FuDQpjb2Rlcy4gIElmIHRoZXkgYXJlIG5vdCBzZW5kaW5n
IGRpZmZlcmVudCBzY2FuIGNvZGVzLCB0aGVuIHRoaXMgYWN0dWFsbHkgbmVlZHMNCnRvIGJlIGNh
cHR1cmVkIGluIHRoZSBrZXJuZWwgYW5kIGEgdHJhbnNsYXRpb24gbWFwIGlzIG5lZWRlZCB3aGlj
aCBpcyBwbGF0Zm9ybQ0Kc3BlY2lmaWMuDQoNCj4gDQo+IFRoZXJlZm9yZSBpIGFncmVlIHRoaXMg
c2hvdWxkIGhhdmUgaXQncyBvd24gY2FzZSBpbiBgZGVsbF93bWlfcHJvY2Vzc19rZXlgDQo+IGJ1
dCBpIGFtDQo+IG5vdCBzdXJlIHlldCBob3cgdG8gZGVhbCB3aXRoIGl0LiBhbnkgc3VnZ2VzdGlv
biBhcmUgaGVscGZ1bC4NCj4gDQo+IEFib3V0IHNlbmRpbmcgaXQgdG8gdXNlcnNwYWNlLCBJIGp1
c3QgZm9sbG93ZWQgd2hhdCB3YXMgYWxyZWFkeSBkb25lLCBpZg0KPiB0aGF0IGlzIG5vdA0KPiBk
ZXNpcmVkIHdlIHNob3VsZCBjaGFuZ2UgaXQgZm9yIGFsbCB0aGUgbW9kZWxzLg0KDQpSaWdodCwg
SSBkb24ndCB0aGluayB0aGlzIHdhcyBhIGJhZCBmaXJzdCBhdHRlbXB0LiAgSSBqdXN0IHRoaW5r
IGl0J3MgZGlmZmVyZW50DQp0aGFuIHRoZSAweDEwLzB4MTEgZXZlbnRzLg0KDQpJJ20gbm90IHNh
eWluZyBpdCBzaG91bGRuJ3QgYXBwbHkgdG8gbW9yZSBtb2RlbHMsIGJ1dCBqdXN0IHRoYXQgZXZl
bnRzIGZyb20NCnRoaXMgMHgxMiB0YWJsZSBzaG91bGQgYmUgdHJlYXRlZCBkaWZmZXJlbnRseS4N
Cg0KSSBmZWVsIHdlIG5lZWQgYSBkaWZmZXJlbnQgd2F5IHRvIHNlbmQgdGhlc2UgdHlwZXMgb2Yg
ZXZlbnRzIHRvIHVzZXJzcGFjZQ0KdGhhbiBhIGtleWNvZGUuDQoNCkkgZm9yIGV4YW1wbGUgdGhp
bmsgdGhhdCB0aGUgcG93ZXIgYWRhcHRlciBhbmQgZG9jayBldmVudHMgYXJlIGFsc28gcG90ZW50
aWFsbHkNCnVzZWZ1bCBidXQgcmVhbGlzdGljYWxseSB1c2Vyc3BhY2UgbmVlZHMgdG8gYmUgYWJs
ZSB0byBzaG93IHRyYW5zbGF0ZWQgbWVzc2FnZXMgdG8NCmEgdXNlci4NCg0KSGFucywNCg0KQ2Fu
IHlvdSBwbGVhc2UgY29tbWVudCBoZXJlIGhvdyB5b3Ugd291bGQgbGlrZSB0byBzZWUgZXZlbnRz
IGxpa2UgdGhpcyBzaG91bGQgY29tZQ0KdGhyb3VnaCB0byB1c2Vyc3BhY2U/DQoNCiogV3Jvbmcg
cG93ZXIgYWRhcHRlciAoeW91IGhhdmUgWCBhbmQgc2hvdWxkIGhhdmUgWSkNCiogWW91IGhhdmUg
cGx1Z2dlZCBhIGRvY2sgaW50byB0aGUgd3JvbmcgcG9ydA0KKiBGbi1sb2NrIG1vZGUNCg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBZIFBhcml0Y2hlciA8eS5saW51eEBwYXJpdGNoZXIuY29t
Pg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMgfCAxNyAr
KysrKysrKysrKysrKysrKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMN
Cj4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLQ0KPiA+PiB3bWkuYw0KPiA+PiBpbmRleCAw
YjRmNzJmOTIzY2QuLmYzN2U3ZTkwOTNjMiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9wbGF0
Zm9ybS94ODYvZGVsbC13bWkuYw0KPiA+PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxs
LXdtaS5jDQo+ID4+IEBAIC0zMzQsNiArMzM0LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2V5
X2VudHJ5DQo+ID4+IGRlbGxfd21pX2tleW1hcF90eXBlXzAwMTFbXSA9IHsNCj4gPj4gIAl7IEtF
X0lHTk9SRSwgS0JEX0xFRF9BVVRPXzEwMF9UT0tFTiwgeyBLRVlfUkVTRVJWRUQgfSB9LA0KPiA+
PiAgfTsNCj4gPj4NCj4gPj4gKy8qDQo+ID4+ICsgKiBLZXltYXAgZm9yIFdNSSBldmVudHMgb2Yg
dHlwZSAweDAwMTINCj4gPj4gKyAqLw0KPiA+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBrZXlfZW50
cnkgZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAxMltdID0gew0KPiA+PiArCS8qIEZuLWxvY2sgYnV0
dG9uIHByZXNzZWQgKi8NCj4gPj4gKwl7IEtFX0lHTk9SRSwgMHhlMDM1LCB7IEtFWV9SRVNFUlZF
RCB9IH0sDQo+ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICBzdGF0aWMgdm9pZCBkZWxsX3dtaV9wcm9j
ZXNzX2tleShzdHJ1Y3Qgd21pX2RldmljZSAqd2RldiwgaW50IHR5cGUsIGludA0KPiA+PiBjb2Rl
KQ0KPiA+PiAgew0KPiA+PiAgCXN0cnVjdCBkZWxsX3dtaV9wcml2ICpwcml2ID0gZGV2X2dldF9k
cnZkYXRhKCZ3ZGV2LT5kZXYpOw0KPiA+PiBAQCAtNDI1LDYgKzQzMyw3IEBAIHN0YXRpYyB2b2lk
IGRlbGxfd21pX25vdGlmeShzdHJ1Y3Qgd21pX2RldmljZSAqd2RldiwNCj4gPj4gIAkJCWJyZWFr
Ow0KPiA+PiAgCQljYXNlIDB4MDAxMDogLyogU2VxdWVuY2Ugb2Yga2V5cyBwcmVzc2VkICovDQo+
ID4+ICAJCWNhc2UgMHgwMDExOiAvKiBTZXF1ZW5jZSBvZiBldmVudHMgb2NjdXJyZWQgKi8NCj4g
Pj4gKwkJY2FzZSAweDAwMTI6IC8qIFNlcXVlbmNlIG9mIGV2ZW50cyBvY2N1cnJlZCAqLw0KPiA+
PiAgCQkJZm9yIChpID0gMjsgaSA8IGxlbjsgKytpKQ0KPiA+PiAgCQkJCWRlbGxfd21pX3Byb2Nl
c3Nfa2V5KHdkZXYsIGJ1ZmZlcl9lbnRyeVsxXSwNCj4gPj4gIAkJCQkJCSAgICAgYnVmZmVyX2Vu
dHJ5W2ldKTsNCj4gPj4gQEAgLTU1Niw2ICs1NjUsNyBAQCBzdGF0aWMgaW50IGRlbGxfd21pX2lu
cHV0X3NldHVwKHN0cnVjdCB3bWlfZGV2aWNlDQo+ID4+ICp3ZGV2KQ0KPiA+PiAgCQkJIEFSUkFZ
X1NJWkUoZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAwMCkgKw0KPiA+PiAgCQkJIEFSUkFZX1NJWkUo
ZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAxMCkgKw0KPiA+PiAgCQkJIEFSUkFZX1NJWkUoZGVsbF93
bWlfa2V5bWFwX3R5cGVfMDAxMSkgKw0KPiA+PiArCQkJIEFSUkFZX1NJWkUoZGVsbF93bWlfa2V5
bWFwX3R5cGVfMDAxMikgKw0KPiA+PiAgCQkJIDEsDQo+ID4+ICAJCQkgc2l6ZW9mKHN0cnVjdCBr
ZXlfZW50cnkpLCBHRlBfS0VSTkVMKTsNCj4gPj4gIAlpZiAoIWtleW1hcCkgew0KPiA+PiBAQCAt
NjAwLDYgKzYxMCwxMyBAQCBzdGF0aWMgaW50IGRlbGxfd21pX2lucHV0X3NldHVwKHN0cnVjdCB3
bWlfZGV2aWNlDQo+ID4+ICp3ZGV2KQ0KPiA+PiAgCQlwb3MrKzsNCj4gPj4gIAl9DQo+ID4+DQo+
ID4+ICsJLyogQXBwZW5kIHRhYmxlIHdpdGggZXZlbnRzIG9mIHR5cGUgMHgwMDEyICovDQo+ID4+
ICsJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAxMik7
IGkrKykgew0KPiA+PiArCQlrZXltYXBbcG9zXSA9IGRlbGxfd21pX2tleW1hcF90eXBlXzAwMTJb
aV07DQo+ID4+ICsJCWtleW1hcFtwb3NdLmNvZGUgfD0gKDB4MDAxMiA8PCAxNik7DQo+ID4+ICsJ
CXBvcysrOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiAgCS8qDQo+ID4+ICAJICogTm93IGFwcGVu
ZCBhbHNvIHRhYmxlIHdpdGggImxlZ2FjeSIgZXZlbnRzIG9mIHR5cGUgMHgwMDAwLiBTb21lIG9m
DQo+ID4+ICAJICogdGhlbSBhcmUgcmVwb3J0ZWQgYWxzbyBvbiBsYXB0b3BzIHdoaWNoIGhhdmUg
c2NhbmNvZGVzIGluIERNSS4NCj4gPj4gLS0NCj4gPj4gMi4yNy4wDQo+ID4NCg==
