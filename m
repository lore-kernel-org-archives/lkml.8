Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B298C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C33206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ghu+AnCy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pI+2yLoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgGOMXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:23:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60516 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728781AbgGOMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:23:13 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 999584047D;
        Wed, 15 Jul 2020 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594815792; bh=aHiJUoMPG5iYxbrk2IPeWgoyzgBmuxIcHBfIUA/psjc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ghu+AnCyvrsdH5BOK9HneXxf0qNlWJZ0dOvBAz83mDpmods8M5BLz6qt8Q/0LthGc
         1538y6wQO5yy03fxUHlPpme7ZwReobnI4GvF3VECJ5DqsgEFl/keZThqNDfCkRxLUe
         5QOPeLx4dTKuZUuEQdq3gK+A6nO9EquHgRxQ5GhfOjPUeXn3I1dkpxlHBMk37HveE3
         U+DWcBECEHphqegmqKq5oRNe79HEfb3QEyBLm5UDmryXPy68hss213N6n/iyUaIf8F
         rM3Obfy8MLTzKLnvEHGicx4zRMUvE85McrkQyefI9rXnY5fSfvNIe3nOEdYcMzfVPE
         VB0mGCXPlC7oA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E5D51A009C;
        Wed, 15 Jul 2020 12:23:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 225A6400BA;
        Wed, 15 Jul 2020 12:23:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pI+2yLoP";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXhcsDMRuASDkpVaIhjbLAoYD02HP1or2Tb1CKvhL/5XvOgUyeaZ7pgy9clnJaEPjUDRHT3hz6/a8tf/9046YcB3NrA2wqa9ao4tGvlOgMko6JNIQ24b4FcAqlPrsBWvNlqUBPDfgJ3sDrviE7P97lQaW2cStYHyep/1hyXJgr9K3/uLwgm3kuFjW9x8+8oHwY1PoEo7ibUUbZ3oCAtUwkafWHAbksO8MZzu5I3s4Z0iawUtR1Z+61RsgDRZlU/Ib19V5rElgIuUofqAwec2X69M/PDPTgwG1VE9U4fAedI6H2z032TYTE5m2Boar2Tn1aDc6SRCJCFJor+cNO34cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHiJUoMPG5iYxbrk2IPeWgoyzgBmuxIcHBfIUA/psjc=;
 b=AKYOwVOuNypcr4yV9wRt69R/H7ApVsU05TxDfOHOqXGGyO8kRqHl9TZJUt5dV/mQzNbVYHe+n27KPUEZSqTIDa7O6JU46yQ8o2wrqnOkD4Pw0UMIR+wocCY9YbrxxElKLfEV8YUEhTlGHhyqUelDZ9eEA2e42ahqsv6DVpn6GjmGblE27Co9tFTQi+MO0f2lNBeuqqqxmjMOss/77Zed2X+KYO8xlo6fjhRcMircTDqE0WPogSdwEINEpZudzz3G4kXywrR+gCQK366jg9r6hfgg0MSeVfQS1iY6+CKp3moK8p/wIMgThDn0D9/Q4eZIb4EtxIvOK1OvylfeJ+bzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHiJUoMPG5iYxbrk2IPeWgoyzgBmuxIcHBfIUA/psjc=;
 b=pI+2yLoP588gbnccUvF5bWeTWH5NJsBgMG8hpKaqS0oyHZdowYIFTJipdU9fJgfBbyCSx6e2575KFscLJlw087H8FeaOV6libY4hTibiIz3gzjhP4GIlrgp4gqkE0FOC7E0FByiEaWx/HoJp4smtxO4dLQkC5Wb74cE0JjkGHlw=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1832.namprd12.prod.outlook.com (2603:10b6:903:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 12:23:02 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3174.025; Wed, 15 Jul
 2020 12:23:02 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Thread-Topic: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Thread-Index: AQHWWorVyBqGE0pBtk+bf+VA53x5lqkIkEaA
Date:   Wed, 15 Jul 2020 12:23:02 +0000
Message-ID: <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
 <20200715093209.3165641-2-lee.jones@linaro.org>
In-Reply-To: <20200715093209.3165641-2-lee.jones@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50481411-dccb-4750-c2e2-08d828b9d1da
x-ms-traffictypediagnostic: CY4PR12MB1832:
x-microsoft-antispam-prvs: <CY4PR12MB1832B67CDF7FBB449491494FA77E0@CY4PR12MB1832.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MC8n1NrdL7YVf/foctRwS5oltDIGczrPg7KsxQjK+XML86Dzj0t6GzOxmL/TAy/MOr7b5NPa0zIqmAbbnopgGTk8J2/bwj0pM6+zLTl6Ri+tZP/jKsY0dNNSnJtOwDUQHcH0RGBYTzqIXFFivnADqmYszI0H/XseLglvwJjD8RwHMzg9CCu5VqU7z30H2/vIFD43eMx+WGGxJUqSqeUaJ8Pq1+wAqmb6Fv5xFNRoguKlfKkEhovNVaJ+TIk5yHxGtH9Z+GqMFDGAhazEk+lMq0/qfbvzqtwlGvTSFwzBRA6ktRyXRjy2trnehqJrOzs/xgCaez0KzAQS93vxkQ2Y22mI2QyTbkCGSjPVmfKu8E0YFL9O/izeEbtxbDjC8yWZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(366004)(376002)(39860400002)(316002)(110136005)(83380400001)(2906002)(5660300002)(54906003)(31696002)(2616005)(66476007)(76116006)(186003)(91956017)(66946007)(6506007)(53546011)(64756008)(71200400001)(66556008)(4326008)(8936002)(8676002)(66446008)(86362001)(478600001)(6486002)(31686004)(36756003)(6512007)(26005)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wrbQGoHX9bBj8e87UzFg62KcL/OLaWb+2qvIo5ji+za86A9NyQtPScfQg8IkOO8QXNiVQGQmKb8Uc0yYhquAw1yRtUbJzWDhdS7ys7dAdFeIqcoXy+fVf8zLKn94R8bNVXP4sLPTRMFMq2Df8/Nw5wWhdnPLnVhdfMrAbjT7Pit3t19lZpJUs21j9RIJ+hulo2aLmik5SxjcQPoZ0s+/yVx4EnZCw+loe1KXgtS/fPzmYpZ1dcfA5Vil3dn7HUQK0uipRbxh40uMnU5RQSSo2KD+oYhV4H0obcKXgOuxyWctYcb9FoPzjKlMfKGY2xuSVv295YTjDDMz0nQZf+xxilKPzrkSGKeAkMxPr4VkT0LDYKRITnwyHXbZx4UaZQ2lvs7ITdhUiuppxxF8MHeBtS8ZreJUBXZH2skLmDo6LmgmJ+KCx23ajk15OOnOe2JfHYsVgSa7/DbHqdKPlMqL6U30FLxAc6ZAx8hfyql9XwuY2AfV+1xDzg2K+C985DZ2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01AEB015FA78424384F0C307E9F04ACE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50481411-dccb-4750-c2e2-08d828b9d1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 12:23:02.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv2FrJVNSjjsIbXYjWLA/nwU5eKqxXZ/FOu60YicIAj8THOudEoclRFr7g3Vx8DViG6FvOpMmZ9276vp9k9bNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTUvMjAyMCAxOjMyIFBNLCBMZWUgSm9uZXMgd3JvdGU6DQo+IFRoZSB2YWx1ZSBv
YnRhaW5lZCBmcm9tIEdJTlRTVFMyIHNob3VsZCBiZSBtYXNrZWQgd2l0aCB0aGUgR0lOVE1TSzIN
Cj4gdmFsdWUuICBMb29rcyBsaWtlIHRoaXMgaGFzIGJlZW4gYnJva2VuIHNpbmNlDQo+IGR3YzJf
Z2FkZ2V0X3drdXBfYWxlcnRfaGFuZGxlcigpIHdhcyBhZGRlZCBiYWNrIGluIDIwMTguDQo+IA0K
PiBBbHNvIGZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIHdhcm5pbmc6DQo+IA0KPiAgIGRyaXZlcnMv
dXNiL2R3YzIvZ2FkZ2V0LmM6IEluIGZ1bmN0aW9uIOKAmGR3YzJfZ2FkZ2V0X3drdXBfYWxlcnRf
aGFuZGxlcuKAmToNCj4gICBkcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jOjI1OTo2OiB3YXJuaW5n
OiB2YXJpYWJsZSDigJhnaW50bXNrMuKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlXQ0KPiAgIDI1OSB8IHUzMiBnaW50bXNrMjsNCj4gICB8IF5+fn5+fn5+DQo+
IA0KPiBDYzogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQo+IENjOiBC
ZW4gRG9va3MgPGJlbkBzaW10ZWMuY28udWs+DQo+IEZpeGVzOiAxODdjNTI5OGExMjI5ICgidXNi
OiBkd2MyOiBnYWRnZXQ6IEFkZCBoYW5kbGVyIGZvciBXa3VwQWxlcnQgaW50ZXJydXB0IikNCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NCg0KQWNrZWQt
Ynk6IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiBD
aGFuZ2Vsb2c6DQo+IA0KPiB2MjogUmUtd3JpdHRlbiB0byAqdXNlKiBpbnN0YWQgb2YgKnJlbW92
ZSogZ2ludG1zazINCj4gDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDEgKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzIvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IGluZGV4
IGRmNWZlZGFjYTYwYTAuLjAzY2YxZmE4NTYyMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzIvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBAQCAt
MjYwLDYgKzI2MCw3IEBAIHN0YXRpYyB2b2lkIGR3YzJfZ2FkZ2V0X3drdXBfYWxlcnRfaGFuZGxl
cihzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgDQo+ICAgCWdpbnRzdHMyID0gZHdjMl9y
ZWFkbChoc290ZywgR0lOVFNUUzIpOw0KPiAgIAlnaW50bXNrMiA9IGR3YzJfcmVhZGwoaHNvdGcs
IEdJTlRNU0syKTsNCj4gKwlnaW50c3RzMiAmPSBnaW50bXNrMjsNCj4gICANCj4gICAJaWYgKGdp
bnRzdHMyICYgR0lOVFNUUzJfV0tVUF9BTEVSVF9JTlQpIHsNCj4gICAJCWRldl9kYmcoaHNvdGct
PmRldiwgIiVzOiBXa3VwX0FsZXJ0X0ludFxuIiwgX19mdW5jX18pOw0KPiANCg==
