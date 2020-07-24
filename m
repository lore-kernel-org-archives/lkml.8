Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B02220714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BGacacde";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NH07/tmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXDcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:32:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43670 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgGXDcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:32:42 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BFAEF406A7;
        Fri, 24 Jul 2020 03:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595561561; bh=Jtmxwa5Xd8+ABoYgll8PhawrkjMfjmuEiIG0tEo+F0g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BGacacdev1RiqCFruTduwRuTr3jHSKZ6cqPMk0Ud1+tVZN31TNCQi0kgdaAlUw9+8
         C+C2/4RIrF+hbD7UAAkbKvaKVdG0rmLsZGjQZntR9k42wrMs84i6xRavIe8Na41ei3
         Et+pkVUqyx+aiYlZwYtX2Hi6Rnf5x6iZMeCtDTSt4EtEZl5hd9FGA0rQKxLNIR5z4q
         YRkeJdS46VuRz2grLNoc0tWQHahSm+3be1oAyqWnrJ7M7HJCW3xocxdCplVaWmKN0V
         lF+s88izAbw8pVl/rhX6W5rwPXt9P9S3+H3sYCHaM+viUg8k9SGwPicKWy0dEfqZZ6
         xRyb7dNG5TiUQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 81055A005C;
        Fri, 24 Jul 2020 03:32:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 41084801BF;
        Fri, 24 Jul 2020 03:32:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NH07/tmK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaDks9OsQ+bf+5OetADzV/ovGhB/qOt/FurJ0FNDGnNV9UtWYKlWPPwp/DYcJlZSRixssd7OanI9msObOGc3+shRVCIYnX+NoNs6bowBogwrhJfpBAAbOpDmuBad2uPTX7uIUfV/deNmnwJDHJMlbKHqu1mQuDIebDvHjig3rzuOYDM4BYCKkZ3/xa8aziake9XbYMhU11xQXIHReY77TdJsNdfelu6ztk2EXNhgAXzCveAl1SJ673JlCplSkJfp657QQKSNX8wA8ZUWNQSiuXGhq7WU9+vADKHYrsneL8eB3Yd/e00KSefHFeMcQavchGq7gXe3+3DQeQRe33cNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtmxwa5Xd8+ABoYgll8PhawrkjMfjmuEiIG0tEo+F0g=;
 b=XUZ9nx3AugSRxycYxOmdHzRfGJFck+nshRI0yhSc6gNSK2PannI2BE+GDJFCg9xTjMPk4HlcGNi/bb5+shj98kseUiHsCzvNe+HtPcB9pXDSa1/7vfUz46m9VwthaOK9e2FDsRjIj2h7Hw6NGhPXYivW8pD8YFYrV4eb8cQjwtnlfXML1RtuBr4vcPvIt7+2KxhkuMnG0utC4Ms/yKaT1dlcoFYAjLTULFrUCFvMP46wBsQUQ4mH63PR5BOotqMWcALdy372CWN2GiIKTomhARVPdAkwEVwTKoAkVfLZHWXhQCK85vyh1l+1mlsfpvNcgtdsagnHPqFahm8/rVL9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtmxwa5Xd8+ABoYgll8PhawrkjMfjmuEiIG0tEo+F0g=;
 b=NH07/tmK9PqVvpTiGc4BPMu8mwC/OSuJOHO5KqCyHVnpjRhS0g9RSVh/XXaaDB9hFM7+FfUp6ztyeHjySjggFrF4DkNFJnmggHvALLbRFVJv+E5Km6wLhTMda6A1kZkrL8NCwKR+s2m5VeTlB2gaM9H+tIfA1o8cM2CrmGItlsw=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 03:32:32 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3844:ed8:654d:7456]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3844:ed8:654d:7456%5]) with mapi id 15.20.3216.025; Fri, 24 Jul 2020
 03:32:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only
 core
Thread-Topic: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only
 core
Thread-Index: AQHWVciZhhgPOtxvykmm/JX0MmuCQ6j/0eIAgBZYqwA=
Date:   Fri, 24 Jul 2020 03:32:31 +0000
Message-ID: <e94e9d0c-b0d5-b2e1-e3de-0a4e85bc95b4@synopsys.com>
References: <1594282250-25544-1-git-send-email-chunfeng.yun@mediatek.com>
 <6dff8574-e649-7a5c-4d80-c3fe6ddd6645@synopsys.com>
In-Reply-To: <6dff8574-e649-7a5c-4d80-c3fe6ddd6645@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.7.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bd2be35-7e90-47d2-a785-08d82f823321
x-ms-traffictypediagnostic: BY5PR12MB4049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB404948F3463EEBC39CDFFAB0AA770@BY5PR12MB4049.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dL17mQUEM+HG+NcA2rNkhs6fEJuK79RCeENt3lrRTv2A01A8pkmmZX7Iy3t2XeeEApXzWQ+6390p0bOh+Wjox4bV8t+3Wb2gxIbfYtvzPZHTNfB3azJJ8lwxRKqCkd/stPCWuZvrBEj7YCS5xw7A/p2w+Q1TNFz7sZQ9czSOCRKFMYC36KizSIq8rqnEw0AXpIgVuGCXZigjHJAsJ0u2KVYYJnooEdlzn5wDiLh/WiFTbE17A/g36xQYtHYkEqwlDpryaS02BzQLfaZU1eTgakKteS6476BI3NqbYMBueUsccw+hhX5v0/F+LqWRdRQdPm9HYiFZbJfpzmaW7mS5M+XSXAjfRjjX12qIHptiHlQLMCgX4TCFptXtd7bP5sl3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(186003)(478600001)(26005)(4326008)(31696002)(66476007)(64756008)(36756003)(6506007)(83380400001)(66556008)(66946007)(76116006)(5660300002)(66446008)(2906002)(6486002)(71200400001)(316002)(86362001)(2616005)(6512007)(8676002)(31686004)(110136005)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5mP5FVM/7bllaQ4lsi7Hcf7knY1WoCXliRXvMe8dcfEJMAanzPhMZkS2x1GNSuK/9yTAbKHAaWuJOQFQiCtNQVoB4e73ojExF5udVkCUjxXECJ7hjzAIap/mbvZqEFeODqZ+mJuCtTKsxeCuYnywoF9IbubgjS9zwuZlX8z9M0uYBqYuXy/OtxAb1M+2/aak0RdZ+lgHV+P1M+YJZLky57nh7BdJj7oTWeHlEiAh+aP9/ICFwhPIHcvNPsi4m1k4cwHZp3RxrpxF2/8ZEpYHvsYV0T+uCDfCvimLGRQlqI3M77HkD4sLt7LvmtUY7Jwz1Neq20UE/XADwXZ+VdBMON0TujNA0EMT0xNbKSIjhEqtRt11Ob7Uzxw9zX29rzS2IOrjii8QIfpscsLvbZ4zFlexjI55KrvQS6AhPBYfN0n2X0S8ODHZOVsIcwv72Cr4chVxDHwTHpxWSIZwlAL7e48gzRWNKwn9br9aqwTwyMo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F3C220DDF65CD4F83434F569E6FB423@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2be35-7e90-47d2-a785-08d82f823321
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 03:32:31.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9Kr6kDeu+lFae/muM41kBJlljSuNNFMqfcW1R0uL7Ar9JTQyoocGIw9KyKPogEW/ZMaES/XztT7TW8jL47M9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGksDQo+DQo+IENodW5mZW5nIFl1biB3cm90
ZToNCj4+IFRoZSBtYXhpbXVtX3NwZWVkIHdpbGwgYmUgVVNCX1NQRUVEX1NVUEVSX1BMVVMsIGJ1
dCB0aGUNCj4+IG1heGltdW1fc3BlZWQgY2hlY2sgZm9yIHVzYjIuMC1vbmx5IGNvcmUgZG9lc24n
dCBjb25zaWRlciBpdCwNCj4+IHNvIGZpeCBpdCwgYW5kIG1vdmUgdGhlIGNrZWNrIGludG8gZHdj
M19jaGVja19wYXJhbXMoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+PiAtLS0NCj4+IE5vdGU6DQo+Pg0KPj4gV2hlbiBJ
IGxvb2sgYXQgdGhlIGNvZGUsIGZpbmQgdGhhdCB0aGlzIG1heSBiZSBhIHByb2JsZW0sIGJ1dCBu
bw0KPj4gcGxhdGZvcm0gdG8gdGVzdCBpdC4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgfCAxNCArKysrKysrLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4gaW5kZXggMjVjNjg2
YTcuLmZmZDVhYjMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4+IEBAIC05MzAsMTMgKzkzMCw2IEBAIHN0
YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4+ICAgIAkgKi8NCj4+
ICAgIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VJRCwgTElOVVhfVkVSU0lPTl9DT0RF
KTsNCj4+ICAgIA0KPj4gLQkvKiBIYW5kbGUgVVNCMi4wLW9ubHkgY29yZSBjb25maWd1cmF0aW9u
ICovDQo+PiAtCWlmIChEV0MzX0dIV1BBUkFNUzNfU1NQSFlfSUZDKGR3Yy0+aHdwYXJhbXMuaHdw
YXJhbXMzKSA9PQ0KPj4gLQkJCURXQzNfR0hXUEFSQU1TM19TU1BIWV9JRkNfRElTKSB7DQo+PiAt
CQlpZiAoZHdjLT5tYXhpbXVtX3NwZWVkID09IFVTQl9TUEVFRF9TVVBFUikNCj4+IC0JCQlkd2Mt
Pm1heGltdW1fc3BlZWQgPSBVU0JfU1BFRURfSElHSDsNCj4+IC0JfQ0KPj4gLQ0KPj4gICAgCXJl
dCA9IGR3YzNfcGh5X3NldHVwKGR3Yyk7DQo+PiAgICAJaWYgKHJldCkNCj4+ICAgIAkJZ290byBl
cnIwOw0KPj4gQEAgLTE0MjYsNiArMTQxOSwxMyBAQCBzdGF0aWMgdm9pZCBkd2MzX2NoZWNrX3Bh
cmFtcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4gICAgDQo+PiAgICAJCWJyZWFrOw0KPj4gICAgCX0N
Cj4+ICsNCj4+ICsJLyogSGFuZGxlIFVTQjIuMC1vbmx5IGNvcmUgY29uZmlndXJhdGlvbiAqLw0K
Pj4gKwlpZiAoRFdDM19HSFdQQVJBTVMzX1NTUEhZX0lGQyhkd2MtPmh3cGFyYW1zLmh3cGFyYW1z
MykgPT0NCj4+ICsJCQlEV0MzX0dIV1BBUkFNUzNfU1NQSFlfSUZDX0RJUykgew0KPj4gKwkJaWYg
KGR3Yy0+bWF4aW11bV9zcGVlZCA+IFVTQl9TUEVFRF9ISUdIKQ0KPj4gKwkJCWR3Yy0+bWF4aW11
bV9zcGVlZCA9IFVTQl9TUEVFRF9ISUdIOw0KPj4gKwl9DQo+PiAgICB9DQo+PiAgICANCj4+ICAg
IHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiBB
Y3R1YWxseSwgdGhlIGR3Yy0+bWF4aW11bV9zcGVlZCBjYXB0dXJlcyB0aGUgbWF4aW11bSBzcGVl
ZCBkZXZpY2UNCj4gcHJvcGVydHkgdmFsdWUuIEl0IG1heWJlIGJlIHNldCBiYXNlZCBvbiB0aGUg
cGh5J3MgY2FwYWJpbGl0eSBpZiB0aGVyZSdzDQo+IG5vIHByb3BlcnR5IHNwZWNpZnlpbmcgaXQg
KGkuZS4gbWF4aW11bV9zcGVlZCBpcyBVU0JfU1BFRURfVU5LTk9XTikuDQo+DQo+IFNvLCB0aGlz
IGNvZGUgc2hvdWxkIGJlIHJlbW92ZWQuIFRoZSBmaXggc2hvdWxkIGJlIGluIHRoZSBjaGVjayBv
Zg0KPiBkd2MzX2NoZWNrX3BhcmFtcygpLiBJZiBtYXhpbXVtX3NwZWVkID0gVVNCX1NQRUVEX1VO
S05PV04gYW5kIHRoZSBwaHkncw0KPiBjYXBhYmlsaXR5IGlzIG9ubHkgdXAgdG8gaGlnaHNwZWVk
LCB0aGVuIHNldCB0aGUgbWF4aW11bV9zcGVlZCB0bw0KPiBoaWdoc3BlZWQgb25seS4NCj4NCg0K
QXJlIHlvdSBnb2luZyBpbnRvIHVwZGF0ZSBhbmQgcmVzZW5kIHRoaXMgcGF0Y2g/IElmIG5vdCBJ
IGNhbiBjcmVhdGUgb25lIA0KYW5kIGFkZCB5b3VyICJSZXBvcnRlZC1ieSINCg0KQlIsDQpUaGlu
aA0K
