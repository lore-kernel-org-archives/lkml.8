Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C726C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1653B20826
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WkO4OW04";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fB4V0s4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGCIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:35:47 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54956 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbgGCIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:35:46 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1A6AC050E;
        Fri,  3 Jul 2020 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1593765346; bh=L25/lPH2PNcWeQ2DLv/0J+znJZT/VzUW1Y8HcT+JIpM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WkO4OW04Dx8OtAbdVn6uoKamh5kC/KGq6hbUGQwiaOWS7WNySQlmevrFh3giykfqr
         lsOQSLEyFmtT7rjhL7RTDJ+pAnBiSgkvA4nw58kEyCk3WYml85XyKrfGCcx/kcRtRz
         KEnwN+lv5wgsLRldljpn4XOyXlLRHNQf0YaM6y8hanB/cn9Fmq+YJ66qjNp8cWLrrC
         K2nlaj0Dm5OLOxS/whNOiAxJK+oqFtTf0d+AJIEzSdXcoS6BIobG2gtBAYUdgI028o
         LoqziXOAzQhbwu6TgAvbfNoQ6AJyBMgDMQeq044yThxEa7JxWQOfNKA3a9xqPvL6SF
         6mhwUQwBAqf1A==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 26EE3A0255;
        Fri,  3 Jul 2020 08:35:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1AB4C40140;
        Fri,  3 Jul 2020 08:35:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fB4V0s4o";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNKNyM3XKGTCoo5ezx0KwFyr9COKgC9+vw0XgPs1z9glirgbxHC6CvZp9kf9b07f0sV/vam6iVMUKu2G7N8/yjQy6OMuoxNoAML8r/DGhztrYETKFLHQZfEGAH1JxtyCYPmF4B9KEX6tQ2ReTK6AUBFOFO6qGgcoUYv7BFIx8OSJ2qOXBsrmzk5M+AeJl+w4a0DbCOovtAn0clQYLtu+2efzGtSN+V6ivdLzPVPahsxbJyQzvAEdmeRJ9HYoTB8Xjm/Q/4UDW67mDWinwvk35zUYnycbr28T9jb554fl6bYliSKH9khbxrdZ4SnlpXKT1VhOmwGErK9Uo3RZFDdw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L25/lPH2PNcWeQ2DLv/0J+znJZT/VzUW1Y8HcT+JIpM=;
 b=cyfp2O0NMWfe8lgIqNuSYIuvGKiRlUN74cN/uzT092isSVB3CG4TdE6Ty0FRBgzQPOpRNV8tYrlLTGo0UwjlQsOu+h6L0jIE/Xm9OZjfpTi4oD2vdY0hFqsfvdg9UGq1rlY1iAzP581z2dWUZFyApqa0e3FvXBiMWgVOodHNvsNs4acQVLFf2/aeTgYqfF7qvvPWRpgw6PT6yvPdR8/ihBkVVe4Rw34oU4trNZC2tvIC4HVk7xuOizwjnVCZVOlveo2fCAn8z6aiGNbYs7tAW0gh43TBpRLC2FXe5cVmS7JJ50PdKEHTwP1QL7tfe5zBiehacHJrL6xTpLac3kJvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L25/lPH2PNcWeQ2DLv/0J+znJZT/VzUW1Y8HcT+JIpM=;
 b=fB4V0s4ohpAF8T7ST6M5c9WlB98YH2uWQykUlrrDuqwcN0Tdx1CxTTi0EmM+t/Rdd5Tr0Nk1TKlSZEIJuoKI1xeKzhxZqrV/4qtyV3EbQCL+8hOv7IaYyqhDLoaBQcKAc+HnSwTJXIDf0kP6L1vjA2JYtyNyksSx4hEtlTGUVcw=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1383.namprd12.prod.outlook.com (2603:10b6:903:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 08:35:39 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:35:39 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Thread-Topic: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Thread-Index: AQHWUH+fyhb4/oSmxUieC1VUnpCQeqj1dlwAgAACd4CAAAGTgIAADnUA
Date:   Fri, 3 Jul 2020 08:35:39 +0000
Message-ID: <5e7abda6-9488-a810-48ae-b23022187325@synopsys.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-12-lee.jones@linaro.org>
 <20200703072926.GA2322133@kroah.com>
 <e88abd64-4acf-31f6-f76a-5a333df3d46a@synopsys.com>
 <20200703074353.GA2391671@kroah.com>
In-Reply-To: <20200703074353.GA2391671@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [37.252.92.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc695b47-bab8-4dbf-d710-08d81f2c10ee
x-ms-traffictypediagnostic: CY4PR12MB1383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1383C1D8D83123EAC2692D05A76A0@CY4PR12MB1383.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQDlMeJlfHnsebskRjEkzz/a8HA6+2DkyP1txqZ9J7s8rLfPZjUvg3gtWxcVddAgYlZMLPvPAUUORm5TbnoArVeBluSNjRmrysTKbSFcDnwuRNniGq/UWKassIW6gZ77j+zOe42k53w2/Gv+yjC+Q+8C4Emtmnp0wLnngQt2IGTtLC5yLvMwtOh84sDfgzC7U27tQNzFClrYnGbVnw69ScXpJZKTr1qC50ImjUbdA6JREM5nD1hrTcYfsk/MIUK8Jv9DM+L7pcLh3AAo+K944rELTvzz0awH2nLhLMxWg20Ibdq2ZVWTEfruxzE0Pxn7NRbr27bsZdg6MW4x5Xja4HZ7/itEnK7ZPTpw2RpxDF1n/7/n4dVYXhS80fGTsB2z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(4326008)(186003)(26005)(6512007)(316002)(110136005)(54906003)(478600001)(83380400001)(53546011)(6506007)(8676002)(8936002)(2616005)(2906002)(31686004)(6486002)(76116006)(36756003)(71200400001)(91956017)(66946007)(66556008)(66446008)(64756008)(66476007)(31696002)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M3+AJ8Vs/nDjDyTwydtAsBWRDfRDNw16zHiEB3mQIr4ZtQ2cW78MSbFbNeijitHLODT9vVWCPYyINregnj5lnrWyhkB5XgWZry+5eS/q1bY0mcTe9SAahsihjqZX3Zu2xJsj4fyKg0NMANdWB751T6ecoPv81gMOsLFGXgev/e9YKuwlx4/x6oiZbRldupiuETJ+YC4hs3Lqbkuy2n1LGAjj86x+p8JiIQMJ5XR9vB/uE8ErmOV/P29HBeDhpD3AykKTA6CIQcqHCaszRnZyUOqqK4uaXYIyLTsA08DzFX3d7B1m5HHXnK3NW+FlhJvM3wvJqYeqsweOndV7pCrgiHKQHRjbFNYJcvjcF1nFVs3Rdy/pNdzKgqbsIY4xd5lEyzjtpsrfJoK+lgtONUhWsmWsKlqfxBD+w7lTi/6OTBhA1rerwislT3koB+yeJxKC7qF5/mkgWbfJPH3YuWe3d9cl69VKiryGWUhKo0lSLOA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53012EB3E58DB40892981B70D062AD1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc695b47-bab8-4dbf-d710-08d81f2c10ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:35:39.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghhvPz8vudR42J49l0W7x+6DXWSrZ/fcCJTUnb5IbkeiBMtGsC46R2br8qCGW36o4iY+UzFkDn3LP1zxK6OZ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDcvMy8yMDIwIDExOjQzIEFNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBGcmksIEp1
bCAwMywgMjAyMCBhdCAwNzozODoxNkFNICswMDAwLCBNaW5hcyBIYXJ1dHl1bnlhbiB3cm90ZToN
Cj4+IEhpLA0KPj4NCj4+IE9uIDcvMy8yMDIwIDExOjI5IEFNLCBHcmVnIEtIIHdyb3RlOg0KPj4+
IE9uIFRodSwgSnVsIDAyLCAyMDIwIGF0IDAzOjQ2OjA2UE0gKzAxMDAsIExlZSBKb25lcyB3cm90
ZToNCj4+Pj4gQ29tbWl0IGVjMWY5ZDlmMDEzODQgKCJ1c2I6IGR3YzI6IGdhZGdldDogcGFyaXR5
IGZpeCBpbiBpc29jaHJvbm91cyBtb2RlIikgbW92ZWQNCj4+Pj4gdGhlc2UgY2hlY2tzIHRvIGR3
YzJfaHNvdGdfY2hhbmdlX2VwX2lzb19wYXJpdHkoKSBiYWNrIGluIDIwMTUuICBUaGUgYXNzaWdu
ZWQNCj4+Pj4gdmFsdWUgaGFzbid0IGJlZW4gcmVhZCBiYWNrIHNpbmNlLiAgTGV0J3MgcmVtb3Zl
IHRoZSB1bm5lY2Vzc2FyeSBIL1cgcmVhZC4NCj4+Pj4NCj4+Pj4gRml4ZXMgdGhlIGZvbGxvd2lu
ZyBXPTEgd2FybmluZzoNCj4+Pj4NCj4+Pj4gICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYzog
SW4gZnVuY3Rpb24g4oCYZHdjMl9oc290Z19lcGludOKAmToNCj4+Pj4gICAgZHJpdmVycy91c2Iv
ZHdjMi9nYWRnZXQuYzoyOTgxOjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGN0cmzigJkgc2V0IGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4+Pj4gICAgMjk4MSB8IHUz
MiBjdHJsOw0KPj4+PiAgICB8IF5+fn4NCj4+Pj4NCj4+Pj4gQ2M6IE1pbmFzIEhhcnV0eXVueWFu
IDxobWluYXNAc3lub3BzeXMuY29tPg0KPj4+PiBDYzogQmVuIERvb2tzIDxiZW5Ac2ltdGVjLmNv
LnVrPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDIgLS0NCj4+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQu
Yw0KPj4+PiBpbmRleCAxMTZlNjE3NWM3YTQ4Li5mYTA3ZTNmY2I4ODQxIDEwMDY0NA0KPj4+PiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzIvZ2FkZ2V0LmMNCj4+Pj4gQEAgLTI5NzUsMTAgKzI5NzUsOCBAQCBzdGF0aWMgdm9pZCBkd2My
X2hzb3RnX2VwaW50KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdW5zaWduZWQgaW50IGlkeCwN
Cj4+Pj4gICAgCXUzMiBlcGN0bF9yZWcgPSBkaXJfaW4gPyBESUVQQ1RMKGlkeCkgOiBET0VQQ1RM
KGlkeCk7DQo+Pj4+ICAgIAl1MzIgZXBzaXpfcmVnID0gZGlyX2luID8gRElFUFRTSVooaWR4KSA6
IERPRVBUU0laKGlkeCk7DQo+Pj4+ICAgIAl1MzIgaW50czsNCj4+Pj4gLQl1MzIgY3RybDsNCj4+
Pj4gICAgDQo+Pj4+ICAgIAlpbnRzID0gZHdjMl9nYWRnZXRfcmVhZF9lcF9pbnRlcnJ1cHRzKGhz
b3RnLCBpZHgsIGRpcl9pbik7DQo+Pj4+IC0JY3RybCA9IGR3YzJfcmVhZGwoaHNvdGcsIGVwY3Rs
X3JlZyk7DQo+Pj4NCj4+PiBBcyB5b3Uga25vdywgbG90cyBvZiBoYXJkd2FyZSByZXF1aXJlcyBy
ZWFkcyB0byBoYXBwZW4gdG8gZG8gdGhpbmdzLCBzbw0KPj4+IGFyZSB5b3Ugc3VyZSBpdCBpcyBz
YWZlIHRvIHJlbW92ZSB0aGlzIHJlYWQgY2FsbD8NCj4+Pg0KPj4NCj4+IEdyZWcsIHllcywgaXQn
cyBPayB0byByZW1vdmUgdGhpcyB1bm5lY2Vzc2FyeSByZWFkIHdoaWNoIHJlbWFpbmVkIGZyb20N
Cj4+IHByZXZpb3VzIGltcGxlbWVudGF0aW9ucy4NCj4gDQo+IEdyZWF0LCB0aGFua3MgZm9yIGNv
bmZpcm1pbmchDQo+IA0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5v
cHN5cy5jb20+DQoNCj4gZ3JlZyBrLWgNCj4gDQo=
