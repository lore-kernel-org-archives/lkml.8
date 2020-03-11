Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE24820749
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e13vImE8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="lvF3t6FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgCKTPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37876 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731297AbgCKTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:28 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9054743B79;
        Wed, 11 Mar 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583954127; bh=x8RgU43QSxIAcj5Ch5WMn2cbatAXbOgzRXCu0nbuUL8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=e13vImE8HwLndW9e4bgtlHRelEs9QPnlSCbB1n+tTUvH3Cb1te2pSPVl6U7Nv/Vzz
         QDqWM3JDM2vpX/syensl+A16w8LfmmBvUXDPGP1OiTRkGg/ondyMJjMBvIo6wVM4bm
         OMHILuQGUsJU22mEjTRu7GFHuT9JRUy7hopxmW34IB6AAPJnQsjzhhXrG0rtz+WLwI
         LCyz7jD8ygzoGgGNbHzfka0kxz7xXo4kMHFL1ThOjKwsHTxeAhKLfotnbuq6VSk6eb
         uD4KnQzCfgrkkkJ5O+Zucpo3cQBoVInWamwkPC9yrXFhrFs1sVoa7fvREmOZRUi6sk
         MwWhmPzghO/EQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6FF8EA0083;
        Wed, 11 Mar 2020 19:15:27 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 12:15:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 12:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpQ9TWjWJwjIMs7UjgIEwejJWQnNNBrhVzu4paHR4qN0r+Qx30/tqzz9QtgsHd6jtvHtXY+qCBLtWbeSys2aBphC8LbTM/frFrbFkeMITwKXQIVPW4KrGneMJ0BoXM2l92vOG7UVFpOaUHZqk0BxZ9krN4s/YtlgCxf8lmQsCBv44tum4CYCcvjQePAUqBjyja5njQAyLEZB+HUmC5YSeWKhVa7i/OO3hKi0QNR6b78v+bO3l0YG+alaUOXxDpMgGGlhJ1nAc4AAsjlVMrq6oHXxYrRc82dDJsLRZzL0pToGSIopgP+uiie1SLJHhpFfj4GKRVr9b59dN+YVbMGyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8RgU43QSxIAcj5Ch5WMn2cbatAXbOgzRXCu0nbuUL8=;
 b=ewxc3TCQiYitn/uYkOSt6gsULi7u4GUk4FPWdSJcOLZZScC5KurwdP1YqC+WVee+B4csS8OfbFjme8MbQTJrdCK2A/UiZDXUjruFollWEjl3/r7fgTGDAAMr51Qfwp9duTgIixlwnIrlZDES7THDxdEJa2ZXMBpHMzl1/p366gh1PrZ4jvluhkuWmDWfBBhe8uf/Q1AMAaHrP9W/sydG43rGtVITQaNhuKcHe7MrW7psZpQ2BP2wer58T0Ea3MGo9llbH0CxbZ4vgMFYvoJCrlL//AnAmLu+yac/bPSBCmb5Ea3wmGl5i7rQcBeZqZMgoxP5TfJNF7MMx+j1oSVhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8RgU43QSxIAcj5Ch5WMn2cbatAXbOgzRXCu0nbuUL8=;
 b=lvF3t6FT/hltH8lE2XV7QpQLyTyoPaF+h7BtafQUs9a/lUamJH0AoLiGEzdQT6+U3caMFW1b0bH8MzbVumvM3rRd+e1W73UW4GxkQ3BynXxNHdRI1Oz7bCYr/ZvafmGlf/iE/ZbxhEFgemJvu67nEoH+NHYdLpMEfzEVecvehrk=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3112.namprd12.prod.outlook.com (2603:10b6:a03:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 19:15:11 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 19:15:11 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ARC: allow userspace DSP applications to use AGU
 extensions
Thread-Topic: [PATCH v2 4/4] ARC: allow userspace DSP applications to use AGU
 extensions
Thread-Index: AQHV8ykwg6aMtwkE2UKz1i5bXfrX06hDzHKA
Date:   Wed, 11 Mar 2020 19:15:11 +0000
Message-ID: <35b18191-24bb-c098-57bc-2521cdbf26cb@synopsys.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
 <20200305200252.14278-5-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200305200252.14278-5-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b05cf53a-33d5-448e-fd67-08d7c5f0852f
x-ms-traffictypediagnostic: BYAPR12MB3112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31127F519E9D8233EB1F86FFB6FC0@BYAPR12MB3112.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(76116006)(71200400001)(66556008)(478600001)(66946007)(66476007)(64756008)(66446008)(31696002)(4744005)(8676002)(2906002)(86362001)(5660300002)(53546011)(81166006)(8936002)(81156014)(36756003)(6506007)(6512007)(2616005)(26005)(4326008)(186003)(54906003)(316002)(31686004)(6486002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3112;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Hyq9hJSBzYpCPyzK6HZ6lZYYNkeQgLWOAJJ3stBrbnyCGBZcgH7T5cHkJDu70asOl6RISbZDrAGX90IjZPFxTHpoU4DfnM1wA6NA/iFqLjymaDttbv5Yaf9j8XPZjK4/1TTH7sYsjblejQ7nQEXHqY3RCuu6cYPvopthp7ZcjtuursHk0DD8lnYsYCX226OJuzlQ/wiHRhkFGNjSaPniCg2PLRqerLcgqWo3HLynbSfXU5iCZSxRG8Wm2+WXUl9aDj0/Mee5lqDwNfwSYFEvOHBrcgKNsX3FHj5KdZdPf2vI3ExhYIY+XJhtUNGNTR2HYXQ+uJyMszooO9ZztixW26Hi0i5tjcHh2Murd9GAq1cJY9S6RlpsA5Dk+wJncWUqfls3cZmGm2nTX4Rfnou0cKkH5T2OLNwdB5C5Qjy8UVUNS4Y7oUP5FOKzZKyaLys
x-ms-exchange-antispam-messagedata: UbQfDH3Vx0nc+8VVmbmlTi/ArTYiLqlgl1AhkLuP0WZU8T3aY8Zujb//yHKeMyEdzntjxB6T5Orm0TwM2yvBlOdW/jdEu1V5/hDOhfw1sgVDxt34sbR50gp7b2peZ9+K3IThc1nwkl3ul6GryWCjfg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AED8E6CA8C63940ADCB7A9D6032FE91@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b05cf53a-33d5-448e-fd67-08d7c5f0852f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 19:15:11.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gb8mdrfL/ko/6LVtgorf2szgb95F2K5Yx+ezS4+lShUlGy2O7vY/r1DRG42RbyoO7W3SU7ZFJ/DJahkaNZC2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy81LzIwIDEyOjAyIFBNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IFRvIGJlIGFibGUg
dG8gcnVuIERTUC1lbmFibGVkIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgd2l0aCBBR1UNCj4gKGFk
ZHJlc3MgZ2VuZXJhdGlvbiB1bml0KSBleHRlbnNpb25zIHdlIGFkZGl0aW9uYWxseSBuZWVkIHRv
DQo+IHNhdmUgYW5kIHJlc3RvcmUgZm9sbG93aW5nIHJlZ2lzdGVycyBhdCBjb250ZXh0IHN3aXRj
aDoNCj4gICogQUdVX0FQKg0KPiAgKiBBR1VfT1MqDQo+ICAqIEFHVV9NT0QqDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+
DQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+DQoNCg0K
