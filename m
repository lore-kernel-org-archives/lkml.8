Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F372206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PfwFuT5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGQST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:19:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:10390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:19:57 -0400
IronPort-SDR: naywMxTPi8LWc/+snl5ivvIs7qoiZa6j2bVjTdAqWnkBSEYW8LgW3QUVXKJ0mneSljhs9eUmBb
 jNFi1DGzGcBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="137122414"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="137122414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:19:56 -0700
IronPort-SDR: N0g5+tchUIX0P5AcTk6dPeGGMuTvusuX1sYW+P2bH65q4TRvkGj7wIIzwK+GAryek6iZgCVPIz
 ne+XcPv4DL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="430924643"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2020 11:19:55 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:55 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 11:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I70MT8rZdrdWdKRQmIdbvHViqJ+X84Mx3ytsQotbjMeLqGGSWW8cpACfVjbQ/BF1mNaLIw9GnABNVILYjjICUltG0G1VO22fVibod2tpqSmsDPXduOSajXerQ2RJQ35/n+3bNnyg7GIN8oNIp68bg7NDqJ8mVvhDTpta3YuUem0F6Dritfj/u402449xdhuO1TEfEGzXI3LkBYzHHzLKftJPw3ka33SKA9X/uUsHwob8bnybTOBi5E6Fo2m+F9Lie0WI1Ly/otRZgoXUVKPeM00KEaqqDWO4XuZW1r+JmMHT6Bxx/4+o6If3wZHp0W4dO+HmHysqn0goeK+uF5idlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVG/aBM8HBUtfuFf8WiuA8GyMd290FoWoGE681YQUlo=;
 b=Tf2Ip7PL61Xai29yMoceHZ+lsh0SqIKeLaC9XKQGtpD2eA5idFAXmQqUPKEb/EHFqAaSEVcBwOITuX97RcBFQh6JHmXh42/By9FqvPOxrZRFRy3EZmC7k/yubxEU3pyN8tqUrAPcgqffreJf11H0mY1+emH9I/bNsGCEtpSqwJ4VvrOgfVvcooo1Uf+R23ATbplBSVU8iQ+br4mTi+//+BjWj90TxZOeuz0DmeFH6yDFDcVrSF/QnwzDosgvUttWh6x5RAJCBfM/Pq+pq6s18+k3ffuZd6E76AtSuLQofPLmkL2Hq1yZE+8Qf94EF9CxbSqg9Il2Fbf4TKFjtCswNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVG/aBM8HBUtfuFf8WiuA8GyMd290FoWoGE681YQUlo=;
 b=PfwFuT5UBdsdru9wfv6XhGjkvHq9k/fn0U3vc+Ekm0BjCRtZcO1VSS0yoeUkZ6Cq/ErfH8gADOxMIZVVV3FjyEkIcaRstjz+ODPAQ2EaUm5ImCdaDp1twiAaS92lFrP/+7EsyVLu5g3Iq1tHaV61sEpuWqTPPDsrTw9AKEULeCE=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 18:19:53 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:19:53 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWGERiGLMQx7oL0apZ2u4U144JKkL/3pA
Date:   Fri, 17 Jul 2020 18:19:52 +0000
Message-ID: <SN6PR11MB2574F33CF9C422517B3C13CFF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0c387db-de6b-4381-b5b4-08d82a7e0040
x-ms-traffictypediagnostic: SA0PR11MB4751:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB475153A8029AFDC6DC414F14F67C0@SA0PR11MB4751.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHVRbh6EaV2oolU+QGULoKC2HRs8z0an50006g71uD/l1IDlJNzXNX4iP0keHsdCKNRcurSEW7Kq4vim2YYUQzKfgAL3KoiA0UQPviDXh/Ir9jiF3YEE2fHwOgTo3uIcM2qVhTlQqthVFvOM4M2cdMgFtNr+wkSIwJmACn5ymWhpQsf+d/iZ9BVIWNsFgxdyGNlugi8fq1zFoQyabvRpMzzUqBD+QObbLtQbhsCAaEthYop9gcKlQKmI49vCbj4NLOhPU7+qeS67k8FW+qwFRyM1FweUPU/dueT6X9HegZzXrEFSdwe8vf9oIv+3YfaWdsEokbmHK28c8P4lTo91tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(26005)(33656002)(9686003)(55016002)(7696005)(6506007)(8676002)(478600001)(71200400001)(64756008)(66446008)(76116006)(66476007)(8936002)(186003)(86362001)(66556008)(66946007)(107886003)(6916009)(52536014)(2906002)(83380400001)(316002)(4326008)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eI4SMMCwrKzOb/VNUiLuRzCqkMiXwp1f2o8b2EhmbeZ1KlMhs7HPWy7l4OR7S4mOHtnxl7IHXpqEGgKvbjU4QrY/qmpn/fS8Mrz7lviczbiulli/91Fs5dx0GYAiMiSD4Yv81gqGNQG+dIGblKUlZoq1nrru9xXcT2lb3etRZ8lIuRNTAqh7a2Fc1mSSEF9si6wxSY+0ZmlZE/gkQV7GDCAPNBQXLcTpMn0dfWfkrvTllOuRKC5IK17MPTQ1X5tiR3NOFcZlxXCiEturRrQ44e46+VfgFM6NZ8ebSZNOs8aBwmkkD+I7gSyeJoD9eSt1q3BFwrninWK3QhlDXpyvU5aAQDpW9Pedbhqkv+RzThYzejEbzP1dDMkRIqteGyecerWV22MQbgvnOfHBt6lk6myOgfHFJLWhwJOMTJ6ZMt5biTlKubD/PTDcDMoDVFoZoR2ri6kyS0kxchLcKgTAc2l6WvO78tNyBtQ7FKyfuf8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c387db-de6b-4381-b5b4-08d82a7e0040
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:19:53.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCfcvHZy2FFEDy4tDdFW/xXsg+4n6xx0XGuD3s2//8xsXUg5k88CSZZvLZ3IRj5Zpm8WYPzia7DemxNgaWzJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+ICsvKiBWZXJpZnkgdGhlIGlvY3RsIGFyZ3VtZW50IHNpemUgYW5kIGNvcHkgdGhlIGFy
Z3VtZW50IGludG8ga2VybmVsDQo+ID4gK21lbW9yeSAqLyBzdGF0aWMgaW50IGRsYjJfY29weV9m
cm9tX3VzZXIoc3RydWN0IGRsYjJfZGV2ICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdXNlcl9hcmcsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUxNiB1c2VyX3NpemUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZvaWQgKmFyZywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6
ZV90IHNpemUpIHsNCj4gPiArICAgICAgIGlmICh1c2VyX3NpemUgIT0gc2l6ZSkgew0KPiA+ICsg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldi0+ZGxiMl9kZXZpY2UsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgIlslcygpXSBJbnZhbGlkIGlvY3RsIHNpemVcbiIsIF9fZnVuY19fKTsNCj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKGFyZywgKHZvaWQgX191c2VyICopdXNlcl9h
cmcsIHNpemUpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LT5kbGIyX2Rldmlj
ZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAiWyVzKCldIEludmFsaWQgaW9jdGwgYXJn
dW1lbnQgcG9pbnRlclxuIiwgX19mdW5jX18pOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVGQVVMVDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4g
PiArfQ0KPiANCj4gWW91IHNob3VsZCBhdm9pZCBlcnJvciBtZXNzYWdlcyB0aGF0IGFyZSB0cmln
Z2VyZWQgYmFzZWQgb24gdXNlciBpbnB1dC4NCj4gYW5kIGNhbiBjYXVzZSBhIGRlbmlhbC1vZi1z
ZXJ2aWNlIHdoZW4gdGhlIGNvbnNvbGUgaXMgc3BhbW1lZCB0aGF0IHdheS4NCj4gDQoNCk1ha2Vz
IHNlbnNlLCB3aWxsIGZpeC4NCg0KPiBBIHBsYWluIGNvcHlfZnJvbV91c2VyKCkgaW4gcGxhY2Ug
b2YgdGhpcyBmdW5jdGlvbiBzaG91bGQgYmUgZmluZS4NCg0KVGhpcyBmdW5jdGlvbiBhbHNvIHZh
bGlkYXRlcyB0aGUgdXNlciBzaXplIGFyZyB0byBwcmV2ZW50IGJ1ZmZlciBvdmVyZmxvdzsgY2Vu
dHJhbGl6aW5nIGl0IGhlcmUgYXZvaWRzIHRoZSBjYXNlIHdoZXJlIGEgcHJvZ3JhbW1lciBhY2Np
ZGVudGFsbHkgZm9yZ2V0cyB0aGUgY2hlY2sgaW4gYW4gaW9jdGwgaGFuZGxlciAoYW5kIHJlZHVj
ZXMgY29kZSBkdXBsaWNhdGlvbikuIElmIGl0J3MgYWxyaWdodCB3aXRoIHlvdSwgSSdsbCBrZWVw
IHRoZSBmdW5jdGlvbiBidXQgZHJvcCB0aGUgZGV2X2VycigpIHByaW50cy4NCg0KPiANCj4gPiAr
LyogWzc6MF06IGRldmljZSByZXZpc2lvbiwgWzE1OjhdOiBkZXZpY2UgdmVyc2lvbiAqLyAjZGVm
aW5lDQo+ID4gK0RMQjJfU0VUX0RFVklDRV9WRVJTSU9OKHZlciwgcmV2KSAoKCh2ZXIpIDw8IDgp
IHwgKHJldikpDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGRsYjJfaW9jdGxfZ2V0X2RldmljZV92
ZXJzaW9uKHN0cnVjdCBkbGIyX2RldiAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB1c2VyX2FyZywNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUxNiBzaXplKSB7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgZGxiMl9nZXRfZGV2aWNlX3ZlcnNpb25fYXJncyBhcmc7DQo+ID4gKyAgICAgICBzdHJ1
Y3QgZGxiMl9jbWRfcmVzcG9uc2UgcmVzcG9uc2U7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArICAgICAgIGRldl9kYmcoZGV2LT5kbGIyX2RldmljZSwgIkVudGVyaW5nICVzKClc
biIsIF9fZnVuY19fKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXNwb25zZS5zdGF0dXMgPSAwOw0K
PiA+ICsgICAgICAgcmVzcG9uc2UuaWQgPSBETEIyX1NFVF9ERVZJQ0VfVkVSU0lPTigyLCBETEIy
X1JFVl9BMCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gZGxiMl9jb3B5X2Zyb21fdXNlcihk
ZXYsIHVzZXJfYXJnLCBzaXplLCAmYXJnLCBzaXplb2YoYXJnKSk7DQo+ID4gKyAgICAgICBpZiAo
cmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAgICAg
IHJldCA9IGRsYjJfY29weV9yZXNwX3RvX3VzZXIoZGV2LCBhcmcucmVzcG9uc2UsICZyZXNwb25z
ZSk7DQo+IA0KPiBCZXR0ZXIgYXZvaWQgYW55IGluZGlyZWN0IHBvaW50ZXJzLiBBcyB5b3UgYWx3
YXlzIHJldHVybiBhIGNvbnN0YW50IGhlcmUsIEkNCj4gdGhpbmsgdGhlIGVudGlyZSBpb2N0bCBj
b21tYW5kIGNhbiBiZSByZW1vdmVkIHVudGlsIHlvdSBhY3R1YWxseSBuZWVkIGl0LiBJZg0KPiB5
b3UgaGF2ZSBhbiBpb2N0bCBjb21tYW5kIHRoYXQgbmVlZHMgYm90aCBpbnB1dCBhbmQgb3V0cHV0
LCB1c2UgX0lPV1IoKQ0KPiB0byBkZWZpbmUgaXQgYW5kIHB1dCBhbGwgYXJndW1lbnRzIGludG8g
dGhlIHNhbWUgc3RydWN0dXJlLg0KDQpPaywgSSdsbCBtZXJnZSB0aGUgcmVzcG9uc2Ugc3RydWN0
dXJlIGludG8gdGhlIGlvY3RsIHN0cnVjdHVyZSAoaGVyZSBhbmQgZWxzZXdoZXJlKS4NCg0KU2F5
IEkgYWRkIHRoaXMgY29tbWFuZCBsYXRlcjogd2l0aG91dCBkcml2ZXIgdmVyc2lvbmluZywgaG93
IHdvdWxkIHVzZXItc3BhY2Uga25vdyBpbiBhZHZhbmNlIHdoZXRoZXIgdGhlIGNvbW1hbmQgaXMg
c3VwcG9ydGVkPyBJdCBjb3VsZCBhdHRlbXB0IHRoZSBjb21tYW5kIGFuZCBpbnRlcnByZXQgLUVO
T1RUWSBhcyAidW5zdXBwb3J0ZWQiLCBidXQgdGhhdCBzdHJpa2VzIG1lIGFzIGFuIGluZWxlZ2Fu
dCB3YXkgdG8gcmV2ZXJzZS1lbmdpbmVlciB0aGUgdmVyc2lvbi4NCg0KPiANCj4gPiArc3RhdGlj
IGludCBkbGIyX2lvY3RsX2NyZWF0ZV9zY2hlZF9kb21haW4oc3RydWN0IGRsYjJfZGV2ICpkZXYs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
bG9uZyB1c2VyX2FyZywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1MTYgc2l6ZSkgew0KPiA+ICsgICAgICAgc3RydWN0IGRsYjJfY3JlYXRlX3NjaGVkX2Rv
bWFpbl9hcmdzIGFyZzsNCj4gPiArICAgICAgIHN0cnVjdCBkbGIyX2NtZF9yZXNwb25zZSByZXNw
b25zZSA9IHswfTsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgZGV2
X2RiZyhkZXYtPmRsYjJfZGV2aWNlLCAiRW50ZXJpbmcgJXMoKVxuIiwgX19mdW5jX18pOw0KPiAN
Cj4gSSBhc3N1bWUgeW91IGhhdmUgZmluaXNoZWQgZGVidWdnaW5nIHRoaXMgdmVyc2lvbiBhbmQg
Y2FuIHJlbW92ZSB0aGVzZQ0KPiBkZWJ1ZyBjb21tZW50cyBhZ2Fpbi4gSWYgeW91IGZpbmQgbmV3
IGJ1Z3MsIHlvdSBjYW4gYWRkIHRoZW0gdGVtcG9yYXJpbHksDQo+IGJ1dCBub3RoaW5nIGlzIGdh
aW5lZCBieSB0aGVzZSBoZXJlLiBZb3UgY2FuIHVzZSBmdHJhY2UgdG8gc2VlIHdoZW4gZnVuY3Rp
b25zDQo+IGFyZSBjYWxsZWQuDQoNCllvdSdyZSByaWdodCwgYW5kIHRoaXMgd2FzIG1lbnRpb25l
ZCBpbiBhbm90aGVyIGNvbW1lbnQgYXMgd2VsbC4gSSdsbCByZW1vdmUgdGhlc2UgdW5uZWNlc3Nh
cnkgZGV2X2RiZygpIGNhbGxzLg0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGRsYjJf
Y29weV9mcm9tX3VzZXIoZGV2LCB1c2VyX2FyZywgc2l6ZSwgJmFyZywgc2l6ZW9mKGFyZykpOw0K
PiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiArDQo+ID4gKyAgICAgICAvKiBDb3B5IHplcm9lcyB0byB2ZXJpZnkgdGhlIHVzZXItcHJvdmlk
ZWQgcmVzcG9uc2UgcG9pbnRlciAqLw0KPiA+ICsgICAgICAgcmV0ID0gZGxiMl9jb3B5X3Jlc3Bf
dG9fdXNlcihkZXYsIGFyZy5yZXNwb25zZSwgJnJlc3BvbnNlKTsNCj4gPiArICAgICAgIGlmIChy
ZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBUaGVyZSBpcyBubyBu
ZWVkIHRvIHZlcmlmeSB0aGUgcmVzcG9uc2UgcG9pbnRlci4gSWYgaXQgZmFpbHMgbGF0ZXIsIGl0
J3MgdGhlIHVzZXIncw0KPiBmYXVsdCwgYW5kIHRoZXkgZ2V0IHRvIGRlYWwgd2l0aCBpdC4NCj4g
DQo+ID4gK3N0YXRpYyBpbnQgZGxiMl9pb2N0bF9nZXRfZHJpdmVyX3ZlcnNpb24oc3RydWN0IGRs
YjJfZGV2ICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBsb25nIHVzZXJfYXJnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdTE2IHNpemUpIHsNCj4gPiArICAgICAgIHN0cnVjdCBkbGIyX2dldF9k
cml2ZXJfdmVyc2lvbl9hcmdzIGFyZzsNCj4gPiArICAgICAgIHN0cnVjdCBkbGIyX2NtZF9yZXNw
b25zZSByZXNwb25zZTsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAg
ZGV2X2RiZyhkZXYtPmRsYjJfZGV2aWNlLCAiRW50ZXJpbmcgJXMoKVxuIiwgX19mdW5jX18pOw0K
PiA+ICsNCj4gPiArICAgICAgIHJlc3BvbnNlLnN0YXR1cyA9IDA7DQo+ID4gKyAgICAgICByZXNw
b25zZS5pZCA9IERMQjJfVkVSU0lPTjsNCj4gDQo+IEp1c3QgcmVtb3ZlIHRoZSBkcml2ZXIgdmVy
c2lvbiBjb21tYW5kLCB0cnlpbmcgdG8gaGF2ZSBleHBsaWNpdCBpbnRlcmZhY2UNCj4gdmVyc2lv
bnMgY3JlYXRlcyBtb3JlIHByb2JsZW1zIHRoYW4gaXQgc29sdmVzLg0KDQooU2VlIHF1ZXN0aW9u
IGFib3ZlKQ0KDQo+IA0KPiA+ICtpbnQgZGxiMl9pb2N0bF9kaXNwYXRjaGVyKHN0cnVjdCBkbGIy
X2RldiAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNt
ZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYXJnKSB7DQo+
ID4gKyAgICAgICB1MTYgc3ogPSBfSU9DX1NJWkUoY21kKTsNCj4gPiArDQo+ID4gKyAgICAgICBp
ZiAoX0lPQ19OUihjbWQpID49IE5VTV9ETEIyX0NNRCkgew0KPiA+ICsgICAgICAgICAgICAgICBk
ZXZfZXJyKGRldi0+ZGxiMl9kZXZpY2UsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIlsl
cygpXSBVbmV4cGVjdGVkIERMQiBjb21tYW5kICVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIF9fZnVuY19fLCBfSU9DX05SKGNtZCkpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gLTE7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIGRsYjJfaW9j
dGxfY2FsbGJhY2tfZm5zW19JT0NfTlIoY21kKV0oZGV2LCBhcmcsIHN6KTsgfQ0KPiANCj4gVGhp
cyBpcyB1c3VhbGx5IHdyaXR0ZW4gd2l0aCBhIHN3aXRjaC9jYXNlIHN0YXRlbWVudCwgc28gZG9p
bmcgdGhlIHNhbWUgaGVyZQ0KPiB0ZW5kcyB0byBtYWtlIGl0IGVhc2llciB0byB1bmRlcnN0YW5k
Lg0KPiANCg0KV2lsbCBkby4gQW5kIGFzIFJhbmR5IG5vdGljZWQsIHRoaXMgbmVlZGVkIGFycmF5
X2luZGV4X25vc3BlYygpIC0tIGVhc2llciB0byBhdm9pZCB0aGF0IGVudGlyZWx5IHdpdGggYSBz
d2l0Y2ggc3RhdGVtZW50Lg0KDQo+ID4gK3N0YXRpYyBsb25nDQo+ID4gK2RsYjJfaW9jdGwoc3Ry
dWN0IGZpbGUgKmYsIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKSB7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgZGxiMl9kZXYgKmRldjsNCj4gPiArDQo+ID4gKyAgICAgICBkZXYgPSBj
b250YWluZXJfb2YoZi0+Zl9pbm9kZS0+aV9jZGV2LCBzdHJ1Y3QgZGxiMl9kZXYsIGNkZXYpOw0K
PiA+ICsNCj4gPiArICAgICAgIGlmIChfSU9DX1RZUEUoY21kKSAhPSBETEIyX0lPQ19NQUdJQykg
ew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldi0+ZGxiMl9kZXZpY2UsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgIlslcygpXSBCYWQgbWFnaWMgbnVtYmVyIVxuIiwgX19mdW5j
X18pOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gZGxiMl9pb2N0bF9kaXNwYXRjaGVyKGRldiwgY21k
LCBhcmcpOyB9DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGNhbiBhbHNvIGJlIHJlbW92ZWQgdGhlbiwg
anVzdCBjYWxsIHRoZSBkaXNwYXRjaGVyIGRpcmVjdGx5Lg0KPiA+ICAgICAgICAgaW50IGVycjsN
Cj4gPg0KPiA+IC0gICAgICAgcHJfaW5mbygiJXNcbiIsIGRsYjJfZHJpdmVyX25hbWUpOw0KPiA+
ICsgICAgICAgcHJfaW5mbygiJXMgLSB2ZXJzaW9uICVkLiVkLiVkXG4iLCBkbGIyX2RyaXZlcl9u
YW1lLA0KPiA+ICsgICAgICAgICAgICAgICBETEIyX1ZFUlNJT05fTUFKT1JfTlVNQkVSLA0KPiA+
ICsgICAgICAgICAgICAgICBETEIyX1ZFUlNJT05fTUlOT1JfTlVNQkVSLA0KPiA+ICsgICAgICAg
ICAgICAgICBETEIyX1ZFUlNJT05fUkVWSVNJT05fTlVNQkVSKTsNCj4gPiAgICAgICAgIHByX2lu
Zm8oIiVzXG4iLCBkbGIyX2RyaXZlcl9jb3B5cmlnaHQpOw0KPiANCj4gSnVzdCByZW1vdmUgdGhl
IHByX2luZm8gY29tcGxldGVseS4NCg0KQ2FuIHlvdSBlbGFib3JhdGU/IFByaW50aW5nIHRoZSBk
cml2ZXIgbmFtZS9jb3B5cmlnaHQvZXRjLiBzZWVtcyB0byBiZSBhIGNvbW1vbiBwYXR0ZXJuIGlu
IHVwc3RyZWFtIGRyaXZlcnMuDQoNClRoYW5rcywNCkdhZ2UNCg0KPiANCj4gICAgICAgQXJuZA0K
