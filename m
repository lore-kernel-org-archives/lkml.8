Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC32C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BB220739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GWh420Up";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gPYQDKxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgGPMUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:20:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53076 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbgGPMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:20:01 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B110401B3;
        Thu, 16 Jul 2020 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594902000; bh=P0I6zX3npgrlS6lGhIc0dWVqCUewd/KhEmQhZ/rq/x0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GWh420UpGwQI53xa1ovzWJaQc6R2u13JH+X+NGbkKO5kZcEkrVFCC1ncqP4S4zW55
         59z+4qYwEsLNPiEyP6jUawY/uM5LZoYSGAVrp+fBjPKDSiWGxrqm/PogRKX2Xe/5vz
         wdVc9n7Z0+3v1Qd149aHCb9nf00w7wQPv3upqIAn1yzoOTg1yYR49evajGRSBM3MiE
         e+w0vS39vnwQnjAYCi30z3SNbSK2BAeoOKeHY8fhNc6lxGYpv9PlI5y8v3P+ey8axi
         GXbb5hJCcRT/LgY+XHevLFEsy6oo7TCQFIHOfJ2OPC/Kg2D15sNsHCYJ26AKAtMsO/
         LTf4jA48Qa0ew==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6C69EA005A;
        Thu, 16 Jul 2020 12:19:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3A89040032;
        Thu, 16 Jul 2020 12:19:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gPYQDKxn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpAbaibIsXGANHKEG4nvyx3cixFKYAyoOBsSgXedraYz5zc1eS+9XDUmrrkurqaNeKQiykwQXEi+FjtIhGxVvKO2zkxSMiMFNWfzUHiIFzhMi9PHzV6VNe6LDXKvhMlsh0j5wXHoc1y1OX5B441xtrsKf3216SzLJPXQoqaw2rI2IYqamKWaF82H1ebwjTxdESonvpgnRFmKWVOW0XmJ9njGA9Uft89k2n4kBl8kcwjxIIWMQKSSDB40HQKYMyQmkphhb+8UgB2++031H4/s8WbekBT9zrh5K9vPwfHWfNdTB2fIgTcpL1usnPWL+sMHMWWUTaQ0118FTgMMlW88XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0I6zX3npgrlS6lGhIc0dWVqCUewd/KhEmQhZ/rq/x0=;
 b=cR0HUL2OZKv2oWwxoOP7Cgq+74uVf6J8q+7r/KRnxWxIiSkfPHSoPsBSahc06wSTuhqpSe1doNyyg6H+Z1Wi3VpeLC+jgo1wDQhrOl0WSbXbAIJd70ge4DgeeA0tgnREOoZqkNAlMv2aVbsss3B70DEOaeegHlzARonTPfpCfkka+mUfd9ZllBFAh48jWmwn1XpmeE3C+VLTrfdIxBT/wK3nupfWUA9pOGnyHhCEr72lXxSHQ0JPXKliIIlmpFN8Yj1boKp38iWz10CUact3wT0MzishVXsfDSHRanZBwYRA8vky0vn3mc7wKjcjPHlAXjexCeyaiy4Z8gmHEY7Hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0I6zX3npgrlS6lGhIc0dWVqCUewd/KhEmQhZ/rq/x0=;
 b=gPYQDKxn4liDGXk/CpE53ICQnRgZIV66y4nHLc4Bobzhu+Um2yrMR+lraSnKMnTB5jpKoxUg62J1sApOgJttg4LjXynfbrkng3JNhaf7P+90ocNM6/Kr7P2GOhjfQMnr0T+wM+n9rPARnmK/61+NzLOnt7TakXMuPD6TbD8rsQ4=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 12:19:54 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3174.025; Thu, 16 Jul
 2020 12:19:54 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: dwc2: Fix error path in gadget registration
Thread-Topic: [PATCH v2] usb: dwc2: Fix error path in gadget registration
Thread-Index: AQHWW2oJamYfC8nRWEuRTA5WsVW2gKkKH/2A
Date:   Thu, 16 Jul 2020 12:19:54 +0000
Message-ID: <b7571d9c-95ac-26ec-538e-60e1aae0cddb@synopsys.com>
References: <CGME20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44@eucas1p1.samsung.com>
 <20200716120948.28180-1-m.szyprowski@samsung.com>
In-Reply-To: <20200716120948.28180-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.94.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99cbe134-7297-4c7c-9845-08d829828c1f
x-ms-traffictypediagnostic: CY4PR12MB1381:
x-microsoft-antispam-prvs: <CY4PR12MB1381C5B942893038E4EF5670A77F0@CY4PR12MB1381.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/exGn4btM3qDR669F5J6SGu7vmPdExigMLytniPGoSlCKQS9QJKNJoUCw1F9g9PbO9RFm/Lb63fCcTUUVVpCPBoQ7q9/M/0G189BaKBRM02NaYhpGJz05JlPa+yh+qxECwHfI60bRG3cUonUFSMdhHebje++pc49Gt1zeS6QiHBxEKZ0eExzvM97YB7PpCdkdsKRILcAW3gRslOFVdYfR8TDl8pGFj1DVMNFAKNrxeYowQwXsSM9+OT1HxEYRRzsWFZklFnns1tQbr4w/bXe3ky/zBMN1uDahVO3X+nwK1unTVeBrNX2VAXjwMtA242tby3fuSaZaUR4kTi9V3MO+XlGtY0M5mJ0mYBkkzUZs/T+L0F4AqdbW+/pCvPyPuf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(76116006)(66946007)(36756003)(31696002)(91956017)(8936002)(6486002)(8676002)(4326008)(2906002)(45080400002)(2616005)(71200400001)(478600001)(316002)(6506007)(53546011)(66476007)(110136005)(66446008)(66556008)(64756008)(6512007)(5660300002)(54906003)(86362001)(31686004)(83380400001)(186003)(26005)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xIJ2dp+Z1hl0INZxDM0xMRIj91ST46OBafqCwSB15WHVPxPy0YooeFab6G5td2VKRBGfh4T0ldGQPd9I1CCHqdjtSwHZIvNaUtLXxipVsNNcSteUskoyKup97B0hieTN0ZtX/1QI9ZHilC+xxh1H7U+aSdwMBJu7Q2mXVTcVJnOMgKHXtEbdIaE9sx9UwarW4Q8e+XHQ2IAJLeXCZ/91wqBXIJBStmPrj/wY8Vzwl8MmdBXPT1DX6rE5S4ixV9PqewqwbTy9bRUxBpfx9h3Kug7SVlFPhgH/6qKrqiopkkDYw832mTJV2QGXWpnA/zjiKoqxinlvzSrj5ZgV/tSf+bqee7RYw4/xtpVwHVqgyqX1xv/CsU/gWU5PITrj+L4XvUxCR7/+zIuMXtAZXOYblpzLGCWtCr+luozzudJ/IgyOm7eUfGm0oLR/kD7T4sfrZL23TWbpJ7hpzN6U/b18zLSQu9U6vL+am3tvRiDuapw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF8C4D2D70A17B47B2A09A83DAFA7847@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cbe134-7297-4c7c-9845-08d829828c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 12:19:54.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIW3pykt3yGHJT2H/okFCyET+86OyH3Qqsykiw9AetXIgYwf+OcPh23TaJu9gOR7N1TTRszBk5V7BJyhAHbeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyZWssDQoNCk9uIDcvMTYvMjAyMCA0OjA5IFBNLCBNYXJlayBTenlwcm93c2tpIHdyb3Rl
Og0KPiBXaGVuIGdhZGdldCByZWdpc3RyYXRpb24gZmFpbHMsIG9uZSBzaG91bGQgbm90IGNhbGwg
dXNiX2RlbF9nYWRnZXRfdWRjKCkuDQo+IEVuc3VyZSB0aGlzIGJ5IHNldHRpbmcgZ2FkZ2V0LT51
ZGMgdG8gTlVMTC4gQWxzbyBpbiBjYXNlIG9mIGEgZmFpbHVyZQ0KPiB0aGVyZSBpcyBubyBuZWVk
IHRvIGRpc2FibGUgbG93LWxldmVsIGhhcmR3YXJlLCBzbyByZXR1cm4gaW1taWVkZXRseQ0KPiBp
bnN0ZWFkIG9mIGp1bXBpbmcgdG8gZXJyb3JfaW5pdCBsYWJlbC4NCj4gDQo+IFRoaXMgZml4ZXMg
dGhlIGZvbGxvd2luZyBrZXJuZWwgTlVMTCBwdHIgZGVyZWZlcmVuY2Ugb24gZ2FkZ2V0IGZhaWx1
cmUNCj4gKGNhbiBiZSBlYXNpbHkgdHJpZ2dlcmVkIHdpdGggZ19tYXNzX3N0b3JhZ2Ugd2l0aG91
dCBhbnkgbW9kdWxlDQo+IHBhcmFtZXRlcnMpOg0KPiANCj4gZHdjMiAxMjQ4MDAwMC5oc290Zzog
ZHdjMl9jaGVja19wYXJhbXM6IEludmFsaWQgcGFyYW1ldGVyIGJlc2w9MQ0KPiBkd2MyIDEyNDgw
MDAwLmhzb3RnOiBkd2MyX2NoZWNrX3BhcmFtczogSW52YWxpZCBwYXJhbWV0ZXIgZ19ucF90eF9m
aWZvX3NpemU9MTAyNA0KPiBkd2MyIDEyNDgwMDAwLmhzb3RnOiBFUHM6IDE2LCBkZWRpY2F0ZWQg
Zmlmb3MsIDc4MDggZW50cmllcyBpbiBTUFJBTQ0KPiBNYXNzIFN0b3JhZ2UgRnVuY3Rpb24sIHZl
cnNpb246IDIwMDkvMDkvMTENCj4gTFVOOiByZW1vdmFibGUgZmlsZTogKG5vIG1lZGl1bSkNCj4g
bm8gZmlsZSBnaXZlbiBmb3IgTFVOMA0KPiBnX21hc3Nfc3RvcmFnZSAxMjQ4MDAwMC5oc290Zzog
ZmFpbGVkIHRvIHN0YXJ0IGdfbWFzc19zdG9yYWdlOiAtMjINCj4gODwtLS0gY3V0IGhlcmUgLS0t
DQo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2
aXJ0dWFsIGFkZHJlc3MgMDAwMDAxMDQNCj4gcGdkID0gKHB0cnZhbCkNCj4gWzAwMDAwMTA0XSAq
cGdkPTAwMDAwMDAwDQo+IEludGVybmFsIGVycm9yOiBPb3BzOiA4MDUgWyMxXSBQUkVFTVBUIFNN
UCBBUk0NCj4gTW9kdWxlcyBsaW5rZWQgaW46DQo+IENQVTogMCBQSUQ6IDEyIENvbW06IGt3b3Jr
ZXIvMDoxIE5vdCB0YWludGVkIDUuOC4wLXJjNSAjMzEzMw0KPiBIYXJkd2FyZSBuYW1lOiBTYW1z
dW5nIEV4eW5vcyAoRmxhdHRlbmVkIERldmljZSBUcmVlKQ0KPiBXb3JrcXVldWU6IGV2ZW50cyBk
ZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMNCj4gUEMgaXMgYXQgdXNiX2RlbF9nYWRnZXRfdWRjKzB4
MzgvMHhjNA0KPiBMUiBpcyBhdCBfX211dGV4X2xvY2srMHgzMWMvMHhiMTgNCj4gLi4uDQo+IFBy
b2Nlc3Mga3dvcmtlci8wOjEgKHBpZDogMTIsIHN0YWNrIGxpbWl0ID0gMHgocHRydmFsKSkNCj4g
U3RhY2s6ICgweGVmMTIxZGIwIHRvIDB4ZWYxMjIwMDApDQo+IC4uLg0KPiBbPGMwNzZiZjNjPl0g
KHVzYl9kZWxfZ2FkZ2V0X3VkYykgZnJvbSBbPGMwNzI2YmVjPl0gKGR3YzJfaHNvdGdfcmVtb3Zl
KzB4MTAvMHgyMCkNCj4gWzxjMDcyNmJlYz5dIChkd2MyX2hzb3RnX3JlbW92ZSkgZnJvbSBbPGMw
NzExMjA4Pl0gKGR3YzJfZHJpdmVyX3Byb2JlKzB4NTdjLzB4NjljKQ0KPiBbPGMwNzExMjA4Pl0g
KGR3YzJfZHJpdmVyX3Byb2JlKSBmcm9tIFs8YzA2MjQ3YzA+XSAocGxhdGZvcm1fZHJ2X3Byb2Jl
KzB4NmMvMHhhNCkNCj4gWzxjMDYyNDdjMD5dIChwbGF0Zm9ybV9kcnZfcHJvYmUpIGZyb20gWzxj
MDYyMWRmND5dIChyZWFsbHlfcHJvYmUrMHgyMDAvMHg0OGMpDQo+IFs8YzA2MjFkZjQ+XSAocmVh
bGx5X3Byb2JlKSBmcm9tIFs8YzA2MjIxZTg+XSAoZHJpdmVyX3Byb2JlX2RldmljZSsweDc4LzB4
MWZjKQ0KPiBbPGMwNjIyMWU4Pl0gKGRyaXZlcl9wcm9iZV9kZXZpY2UpIGZyb20gWzxjMDYxZmNk
ND5dIChidXNfZm9yX2VhY2hfZHJ2KzB4NzQvMHhiOCkNCj4gWzxjMDYxZmNkND5dIChidXNfZm9y
X2VhY2hfZHJ2KSBmcm9tIFs8YzA2MjFiNTQ+XSAoX19kZXZpY2VfYXR0YWNoKzB4ZDQvMHgxNmMp
DQo+IFs8YzA2MjFiNTQ+XSAoX19kZXZpY2VfYXR0YWNoKSBmcm9tIFs8YzA2MjBjOTg+XSAoYnVz
X3Byb2JlX2RldmljZSsweDg4LzB4OTApDQo+IFs8YzA2MjBjOTg+XSAoYnVzX3Byb2JlX2Rldmlj
ZSkgZnJvbSBbPGMwNjIxMWIwPl0gKGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweDNjLzB4ZDAp
DQo+IFs8YzA2MjExYjA+XSAoZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jKSBmcm9tIFs8YzAxNDky
ODA+XSAocHJvY2Vzc19vbmVfd29yaysweDIzNC8weDdkYykNCj4gWzxjMDE0OTI4MD5dIChwcm9j
ZXNzX29uZV93b3JrKSBmcm9tIFs8YzAxNDk4NmM+XSAod29ya2VyX3RocmVhZCsweDQ0LzB4NTFj
KQ0KPiBbPGMwMTQ5ODZjPl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxjMDE1MGIxYz5dIChrdGhy
ZWFkKzB4MTU4LzB4MWEwKQ0KPiBbPGMwMTUwYjFjPl0gKGt0aHJlYWQpIGZyb20gWzxjMDEwMDEx
ND5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyMCkNCj4gRXhjZXB0aW9uIHN0YWNrKDB4ZWYxMjFm
YjAgdG8gMHhlZjEyMWZmOCkNCj4gLi4uDQo+IC0tLVsgZW5kIHRyYWNlIDk3MjRjMmZjN2NjOWM5
ODIgXS0tLQ0KPiANCj4gV2hpbGUgZml4aW5nIHRoaXMgYWxzbyBmaXggdGhlIGRvdWJsZSBjYWxs
IHRvIGR3YzJfbG93bGV2ZWxfaHdfZGlzYWJsZSgpDQo+IGlmIGRyX21vZGUgaXMgc2V0IHRvIFVT
Ql9EUl9NT0RFX1BFUklQSEVSQUwuIEluIHN1Y2ggY2FzZSBsb3ctbGV2ZWwNCj4gaGFyZHdhcmUg
aXMgYWxyZWFkeSBkaXNhYmxlZCBiZWZvcmUgY2FsbGluZyB1c2JfYWRkX2dhZGdldF91ZGMoKS4g
VGhhdA0KPiBmdW5jdGlvbiBjb3JyZWN0bHkgcHJlc2VydmVzIGxvdy1sZXZlbCBoYXJkd2FyZSBz
dGF0ZSwgdGhlcmUgaXMgbm8gbmVlZA0KPiBmb3IgdGhlIHNlY29uZCB1bmNvbmRpdGlvbmFsIGR3
YzJfbG93bGV2ZWxfaHdfZGlzYWJsZSgpIGNhbGwuDQo+IA0KPiBGaXhlczogMjA3MzI0YTMyMWE4
ICgidXNiOiBkd2MyOiBQb3N0cG9uZWQgZ2FkZ2V0IHJlZ2lzdHJhdGlvbiB0byB0aGUgdWRjIGNs
YXNzIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJv
d3NraUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5j
IHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYyBiL2Ry
aXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiBpbmRleCBjYjhkZGJkNTM3MTguLmRiOWZkNGJk
MWEzOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiBAQCAtNTgyLDYgKzU4Miw3IEBAIHN0YXRp
YyBpbnQgZHdjMl9kcml2ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPiAg
IAlpZiAoaHNvdGctPmdhZGdldF9lbmFibGVkKSB7DQo+ICAgCQlyZXR2YWwgPSB1c2JfYWRkX2dh
ZGdldF91ZGMoaHNvdGctPmRldiwgJmhzb3RnLT5nYWRnZXQpOw0KPiAgIAkJaWYgKHJldHZhbCkg
ew0KPiArCQkJaHNvdGctPmdhZGdldC51ZGMgPSBOVUxMOw0KDQpDb25zaWRlciB5b3VyIHJlY2Vu
dGx5IHNlbnQgcGF0Y2ggIltQQVRDSF0gdXNiOiBnYWRnZXQ6IHVkYzogRmx1c2ggDQpwZW5kaW5n
IHdvcmsgYWxzbyBpbiBlcnJvciBwYXRoIiwgbW9yZSBwcm9iYWJseSBpdCdzIG5vdCByZXF1aXJl
ZCwgDQpiZWNhdXNlIHJvb3QgY2F1c2Ugb2Ygb2JzZXJ2ZWQgZHdjMiBpc3N1ZSBjb21lcyBmcm9t
IHVkYy4NCkFtIEkgd3Jvbmc/DQpPciB3ZSBjYW4ga2VlcCBpdCBhcyBzYW5pdHkgc29sdXRpb24g
dG8gYXZvaWQgYW55IG90aGVyIHBvc3NpYmxlIGNhc2VzPw0KDQo+ICAgCQkJZHdjMl9oc290Z19y
ZW1vdmUoaHNvdGcpOw0KPiAgIAkJCWdvdG8gZXJyb3JfaW5pdDsNCj4gICAJCX0NCj4gQEAgLTU5
Myw3ICs1OTQsOCBAQCBzdGF0aWMgaW50IGR3YzJfZHJpdmVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKmRldikNCj4gICAJaWYgKGhzb3RnLT5wYXJhbXMuYWN0aXZhdGVfc3RtX2lkX3Zi
X2RldGVjdGlvbikNCj4gICAJCXJlZ3VsYXRvcl9kaXNhYmxlKGhzb3RnLT51c2IzM2QpOw0KPiAg
IGVycm9yOg0KPiAtCWR3YzJfbG93bGV2ZWxfaHdfZGlzYWJsZShoc290Zyk7DQo+ICsJaWYgKGhz
b3RnLT5kcl9tb2RlICE9IFVTQl9EUl9NT0RFX1BFUklQSEVSQUwpDQo+ICsJCWR3YzJfbG93bGV2
ZWxfaHdfZGlzYWJsZShoc290Zyk7DQo+ICAgCXJldHVybiByZXR2YWw7DQo+ICAgfQ0KPiAgIA0K
PiANCg0KVGhhbmtzLA0KTWluYXMNCg0K
