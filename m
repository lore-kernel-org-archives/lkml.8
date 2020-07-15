Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B105AC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826A6206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fz0tTPt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgGOLrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:47:23 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:30466 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730066AbgGOLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:47:21 -0400
X-Greylist: delayed 2839 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 07:47:18 EDT
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FAxFTU022601;
        Wed, 15 Jul 2020 10:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=03PCpgHDRSNJ1k3c1okWIm/R4t6h6xV+NhM98GdHKqc=;
 b=fz0tTPt58PYQDMumEb9txwsB6Pc7vVajz7foPpDXE4im4Gaq4vYqs8TWu2eo1cccJKXl
 bEae3Kz3QQKAObEDlKLX1XwWZocAiGu1LJkaGLGi2TECr1amy8Q30c05iO1xYL/bDXvq
 9yJkcy3Q/h1qxo3JAmwuSiokZI7O0zIIbMDMNUX50uLFeXHtT0BQBzusRU27JDV4fvl6
 E0VoX5EJeAFDS6X9FphObhn8T5R1AG2qSYqMB4bg62lk2vtkifRwZYwohvxAxO90KqD9
 WHKrs8qxFK+5IOFjfYtiA4LKucK7LCwIK3fiTtotThNLII00oZaA8MSoGyFnLo0A8OY8 yw== 
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
        by mx08-001d1705.pphosted.com with ESMTP id 3274759rxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 10:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWv1lLGI8ooWi6fO/phRs0XEY3tastZ7qT3/bmI19xBTNSKWs4bJbT4Yod7PPyOrtFJ9QAWMW14BKrF5WBF1iHwjkhEeDojoqMwUdmLmRYAKUI/uhxqLVqTMLzFIb2IhJ6M4KH6qstF3FIL/1KC5f8+tySg9V4xI3YMTkBI4MPZvKPXe6Lx30HEsWWN+55WTkFu24z3ka67yqxI8YR39hJ4iJBKXJaInzDs0VshbItogXc9NNFPGJELD4jLGxfzI0GkTlbJjUSlxEzoBRH5LeFlnqUiFZYVtMA9vZNrcB6kscP/bgYn+ifNXccH/tatbx8ekvUxAQxMrXDTUXhDBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03PCpgHDRSNJ1k3c1okWIm/R4t6h6xV+NhM98GdHKqc=;
 b=P8P2Bjbh1By1hwTn7tH4U1yJ6TS+UaWVW2LV0vbURRn1/nTooeRPRQeboT0AQpa1gJGz8dZHh+ew+rPmRhHD52zRjthIt4VGYMiPoEN49P3NsVn/E9XyMMPd6H0oxYhWT5iOh2pMwx9119M7RAUkIqHRGlh9WwSzxKhS/qOSwMih7XgvpyTGC+FwQGpFpQ5wWgiMiCWY+Zt0BqlBNS1E3Y+9pI8SWpt4wA8NOeAY01BiTJN/olOhPXMLjG987yIyK8oKp5iFGxOWoyQz0F8B44IFJlOdXKmXEk9sX364rjrFt2dCNX3TmvcSrx1i/di2HzfeiWAMd0X7mjctOSNdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14b::8)
 by AM0P193MB0579.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 10:59:12 +0000
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7]) by AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 10:59:12 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
Thread-Topic: [PATCH 2/2] debugfs: Add access restriction option
Thread-Index: AQHWWoPfDn+JEjIBf0W3BsLx2no9AqkIYomAgAAGt4CAAAkNAIAABpuA
Date:   Wed, 15 Jul 2020 10:59:12 +0000
Message-ID: <45741a2f-3763-a41d-62ad-29b5fbb16101@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
 <20200715084207.7639-3-peter.enderborg@sony.com>
 <20200715093907.GC2759174@kroah.com>
 <a07943bf-fb7f-872d-4bc6-307bbaf57a3f@sony.com>
 <20200715103532.GB2876510@kroah.com>
In-Reply-To: <20200715103532.GB2876510@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a1d08e0-0402-4090-8e1f-08d828ae1b83
x-ms-traffictypediagnostic: AM0P193MB0579:
x-microsoft-antispam-prvs: <AM0P193MB057985CF621624B739613D4B867E0@AM0P193MB0579.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8lUAX+lecZTM2ju9mK1UxR3cQ6Bu+Fd25c3wGczGOFq6KksBElCdRv+ociov4e6M7v0dsmumjm6Ixf3ROzXm4vbvhYGMFz+sbjfufl8ec/BzkVFcOFPRWhFzBGC/AihZ9ob1ZwEpVLkrLenvB9IaVvnrXJ5PpaHgjJIWsJoX7/zM5ySFm4tP/Kc242Fl9G9/cW+4kArQO6P4Rpx1mteiESDOAcqMaD/w3nrWuWmsezOMcdrltvOuf+2m0UD8LPWe3j3TLr6pY4PIP6PYWdtauscqOfiqXxaOco+Spy2SaJ3mHa/JayrbCx1dZ+kYg8wASTi/fQXJPmZSUCL38z83XqZ8AorVx1EMTxlLwyycNypJjy71297Ck84y1EEXKmN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0626.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(2906002)(6916009)(316002)(83380400001)(186003)(2616005)(91956017)(31686004)(26005)(6512007)(478600001)(66476007)(5660300002)(64756008)(76116006)(86362001)(66556008)(66946007)(66446008)(6486002)(8676002)(36756003)(8936002)(71200400001)(53546011)(4326008)(31696002)(6506007)(54906003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fq7GymK8AwT64TU1s/Mlr7WkVXKQObnC1NiB5Z6P34OIBlzmNR68XJlwjg7Ml0ov1bI16lLMfydjPS+vg5y3NJ3lWW8nLbT8so+XNtEoqeAMymG+d/j5hzqoKPOp630wWTLVxu+bofU/RW4TKR+EM6ya4M3aTYr9HKygBm8ZRygXpiWHbgUESPD/3cTpN8U6vVua0YmjiU1+W30dxm0vI2lCQ+exlNbGoAcZkz+Ub+CFnq/OFDAKuVgQ2iS1MJ5EcgBZ0d6wEJOsszI7quqxQeVv6Phy6TabAB4VP2WspC46O+Div5id0kdiLJDpOLJB550x9YzDHVPY9Xkq5Cd80LnLzvm+gHdo1K4eGeJKnmt0PRloQZHM3U3RnNeCqUxkmcDAQNHvgcQ9Dxc0aKP8YwmEfUrE0U/Br02nnA5vAqxuk2wWXSMfHNVz6h0gwXwPdY8cYb45bjEif12fZb03h7/zqrhatRMZtIVGLvZsRf8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2401DA0167AB1B4F8C46A91C2361BED6@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1d08e0-0402-4090-8e1f-08d828ae1b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 10:59:12.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uerg3msa3vRGaL5isHJ8J5VLPHzc46AfskrwVM+QuB4xagzuRFAwVLuQazk4V/auE6vGJzVnRYUUmwtcU88MBs3aWZvOZapE7T3Jfy/e3Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0579
X-Sony-Outbound-GUID: KDLMBaSqxfd2h7q1em7IQNjyzRAzMNRM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_07:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNS8yMCAxMjozNSBQTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBXZWQs
IEp1bCAxNSwgMjAyMCBhdCAxMDowMzoxOUFNICswMDAwLCBFbmRlcmJvcmcsIFBldGVyIHdyb3Rl
Og0KPj4gT24gNy8xNS8yMCAxMTozOSBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPj4+
IE9uIFdlZCwgSnVsIDE1LCAyMDIwIGF0IDEwOjQyOjA3QU0gKzAyMDAsIFBldGVyIEVuZGVyYm9y
ZyB3cm90ZToNCj4+Pj4gU2luY2UgZGVidWdmcyBpbmNsdWRlIHNlbnNpdGl2ZSBpbmZvcm1hdGlv
biBpdCBuZWVkIHRvIGJlIHRyZWF0ZWQNCj4+Pj4gY2FyZWZ1bGx5LiBCdXQgaXQgYWxzbyBoYXMg
bWFueSB2ZXJ5IHVzZWZ1bCBkZWJ1ZyBmdW5jdGlvbnMgZm9yIHVzZXJzcGFjZS4NCj4+Pj4gV2l0
aCB0aGlzIG9wdGlvbiB3ZSBjYW4gaGF2ZSBzYW1lIGNvbmZpZ3VyYXRpb24gZm9yIHN5c3RlbSB3
aXRoDQo+Pj4+IG5lZWQgb2YgZGVidWdmcyBhbmQgYSB3YXkgdG8gdHVybiBpdCBvZmYuIFRoaXMg
Z2l2ZXMgYSBleHRyYSBwcm90ZWN0aW9uDQo+Pj4+IGZvciBleHBvc3VyZSBvbiBzeXN0ZW1zIHdo
ZXJlIHVzZXItc3BhY2Ugc2VydmljZXMgd2l0aCBzeXN0ZW0NCj4+Pj4gYWNjZXNzIGFyZSBhdHRh
Y2tlZC4NCj4+Pj4NCj4+Pj4gSXQgaXMgY29udHJvbGxlZCBieSBhIGNvbmZpZ3VyYWJsZSBkZWZh
dWx0IHZhbHVlIHRoYXQgY2FuIGJlIG92ZXJyaWRlDQo+Pj4+IHdpdGggYSBrZXJuZWwgY29tbWFu
ZCBsaW5lIHBhcmFtZXRlci4gKGRlYnVnZnM9KQ0KPj4+Pg0KPj4+PiBJdCBjYW4gYmUgb24gb3Ig
b2ZmLCBidXQgYWxzbyBpbnRlcm5hbGx5IG9uIGJ1dCBub3Qgc2VlbiBmcm9tIHVzZXItc3BhY2Uu
DQo+Pj4+IFRoaXMgbm8tZnMgbW9kZSBkbyBub3QgcmVnaXN0ZXIgYSBkZWJ1Z2ZzIGFzIGZpbGVz
eXN0ZW0sIGJ1dCBjbGllbnQgY2FuDQo+Pj4+IHJlZ2lzdGVyIHRoZWlyIHBhcnRzIGluIHRoZSBp
bnRlcm5hbCBzdHJ1Y3R1cmVzLiBUaGlzIGRhdGEgY2FuIGJlIHJlYWRlZA0KPj4+PiB3aXRoIGEg
ZGVidWdnZXIgb3Igc2F2ZWQgd2l0aCBhIGNyYXNoa2VybmVsLiBXaGVuIGl0IGlzIG9mZiBjbGll
bnRzDQo+Pj4+IGdldCBFUEVSTSBlcnJvciB3aGVuIGFjY2Vzc2luZyB0aGUgZnVuY3Rpb25zIGZv
ciByZWdpc3RlcmluZyB0aGVpcg0KPj4+PiBjb21wb25lbnRzLg0KPj4+Pg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVuZGVyYm9yZ0Bzb255LmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAg
fCAxNCArKysrKysrDQo+Pj4+ICBmcy9kZWJ1Z2ZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAzNyArKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBmcy9kZWJ1Z2ZzL2ludGVy
bmFsLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrDQo+Pj4+ICBsaWIvS2Nv
bmZpZy5kZWJ1ZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzMiArKysrKysrKysrKysr
KysrDQo+Pj4+ICA0IGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMu
dHh0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+
Pj4gaW5kZXggZmI5NWZhZDgxYzc5Li44MDVhYTJlNTg0OTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+Pj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+Pj4+IEBA
IC04MjcsNiArODI3LDIwIEBADQo+Pj4+ICAJCQl1c2VmdWwgdG8gYWxzbyBlbmFibGUgdGhlIHBh
Z2Vfb3duZXIgZnVuY3Rpb25hbGl0eS4NCj4+Pj4gIAkJCW9uOiBlbmFibGUgdGhlIGZlYXR1cmUN
Cj4+Pj4gIA0KPj4+PiArCWRlYnVnZnM9ICAgIAlbS05MXSBUaGlzIHBhcmFtZXRlciBlbmFibGVz
IHdoYXQgaXMgZXhwb3NlZCB0byB1c2Vyc3BhY2UNCj4+Pj4gKwkJCWFuZCBkZWJ1Z2ZzIGludGVy
bmFsIGNsaWVudHMuDQo+Pj4+ICsJCQlGb3JtYXQ6IHsgb24sIG5vLWZzLCBvZmYgfQ0KPj4+PiAr
CQkJb246IAlBbGwgZnVuY3Rpb25zIGFyZSBlbmFibGVkLg0KPj4+PiArCQkJbm8tZnM6IAlGaWxl
c3lzdGVtIGlzIG5vdCByZWdpc3RlcmVkIGJ1dCBrZXJuZWwgY2xpZW50cyBjYW4NCj4+Pj4gKwkJ
CSAgICAgICAgYWNjZXNzIEFQSXMgYW5kIGEgY3Jhc2hrZXJuZWwgY2FuIGJlIHVzZWQgdG8gcmVh
ZA0KPj4+PiArCQkJCWl0cyBjb250ZW50LiBUaGVyZSBpcyBub3RoaW5nIHRvIG1vdW50Lg0KPj4+
PiArCQkJb2ZmOiAJRmlsZXN5c3RlbSBpcyBub3QgcmVnaXN0ZXJlZCBhbmQgY2xpZW50cw0KPj4+
PiArCQkJICAgICAgICBnZXQgYSAtRVBFUk0gYXMgcmVzdWx0IHdoZW4gdHJ5aW5nIHRvIHJlZ2lz
dGVyIGZpbGVzDQo+Pj4+ICsJCQkJb3IgZGlyZWN0b3JpZXMgd2l0aGluIGRlYnVnZnMuDQo+Pj4+
ICsJCQkJVGhpcyBpcyBlcXVpbGl2YW50IG9mIHRoZSBydW50aW1lIGZ1bmN0aW9uYWxpdHkgaWYN
Cj4+Pj4gKwkJCQlkZWJ1Z2ZzIHdhcyBub3QgZW5hYmxlZCBpbiB0aGUga2VybmVsIGF0IGFsbC4N
Cj4+Pj4gKwkJCURlZmF1bHQgdmFsdWUgaXMgc2V0IGluIGJ1aWxkLXRpbWUgd2l0aCBhIGtlcm5l
bCBjb25maWd1cmF0aW9uLg0KPj4+IE5hbWluZyBpcyBoYXJkLiAgSW4gbG9va2luZyBhdCB0aGlz
LCBzaG91bGQgIm5vLWZzIiBiZSBjYWxsZWQNCj4+PiAibm8tbW91bnQiPyAgVGhhdCdzIGEgYmV0
dGVyIGRlc2NyaXB0aW9uIG9mIHdoYXQgaXQgZG9lcywgcmlnaHQ/DQo+PiBJIHRoaW5rIG5vLWZz
IGNvdmVyIGl0IGJldHRlciBzaW5jZSBpdCBkb2VzIG5vdCByZWdpc3RlciBhIGZpbGVzeXN0ZW0N
Cj4+IGJ1dCBwcm92aWRlcyB0aGUgaW50ZXJmYWNlcy4gTW91bnRpbmcgaXMgdGhlbiBpbmRpcmVj
dGx5IHN0b3BwZWQuDQo+IEJ1dCAibW91bnRpbmciIGlzIHRoZSBjb21tb24gdGVybSB3ZSBhbGwg
a25vdy4gICJuby1mcyIgZG9lc24ndCByZWFsbHkNCj4gZGVzY3JpYmUgd2hhdCBpcyBoYXBwZW5p
bmcgaGVyZSwgcmlnaHQ/ICBFdmVyeXRoaW5nIHdvcmtzIGludGVybmFsbHkNCj4ganVzdCBmaW5l
LCBidXQgd2UganVzdCBhcmUgZm9yYmlkZGluZyB0aGUgZmlsZXN5c3RlbSB0byBiZSBtb3VudGVk
Lg0KPg0KSSBoYXZlIG5vIG9iamVjdGlvbiBidXQgbm93IHlvdSBrbm93IHRoZSBiYWNrZ3JvdW5k
LiBTbyBuby1tb3VudCB0aGVuLg0KDQpJIHdpbGwgZG8gYSBuZXcgcGF0Y2gtc2V0Lg0KDQo+PiBU
aGUgaWRlYSBzdGFydCB3aXRoIGEgY2hlY2sgZm9yIG1vdW50aW5nIGJ1dCBpdCBpcyBtdWNoIG1v
cmUNCj4+IGRlZmluaXRlbHkgc3RvcHBlZCBieSBwcmV2ZW50aW9uIG9mIHJlZ2lzdGVyIG9mIHRo
ZSBmaWxlc3lzdGVtLg0KPj4gSSBjYW4gaW1hZ2luZSB0byBoYXZlIGEgZm9ydGggIm1vZGUiIHdo
ZXJlIGl0IHJlZ2lzdGVyIGEgZnMgYnV0DQo+PiBub3QgYWxsb3dpbmcgbW91bnRpbmcuIFN1Y2gg
bW9kZSBtYXliZSB1c2VmdWwgZm9yIHNvbWUgcnVudGltZQ0KPj4gY29uZmlndXJhdGlvbi4gQnV0
IHRoaXMgcGF0Y2ggaXMgYWJvdXQgYm9vdCB0aW1lIGNvbmZpZ3VyYXRpb24uDQo+IFByZXZlbnRp
bmcgdGhlIHJlZ2lzdGVyaW5nIG9mIHRoZSBmaWxlc3lzdGVtIGRvZXMgY3V0IG91dCB0aGUgYWJp
bGl0eSB0bw0KPiBtb3VudCB0aGUgdGhpbmcgcXVpdGUgd2VsbCA6KQ0KPg0KPiBXZSBjb3VsZCBj
aGFuZ2UgaXQgdG8ganVzdCBwcmV2ZW50IHRoZSBzdXBlcmJsb2NrIGZyb20gbW91bnRpbmcgaWYg
eW91DQo+IHdhbnQsIGFzIG1heWJlIHdlIGRvIG5lZWQgdGhlIGZzIHRvIHJlbWFpbiBpbiB0aGUg
bGlzdCBvZiBmaWxlc3lzdGVtcyBpbg0KPiB0aGUga2VybmVsIGF0IHRoYXQgcG9pbnQgaW4gdGlt
ZT8gIE90aGVyd2lzZSB3ZSBhcmUgbHlpbmcgdG8gdXNlcnNwYWNlLg0KDQpJdCBpcyBhbGwgYWJv
dXQgaGlkZSBpdCBhd2F5IGZvciB1c2Vyc3BhY2UuDQoNCg0KPiB0aGFua3MsDQo+DQo+IGdyZWcg
ay1oDQoNCg==
