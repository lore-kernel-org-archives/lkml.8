Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A40C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C269121835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VSYG47P3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="khOaihOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgD1TqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:46:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39482 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728620AbgD1TqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:46:04 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EEA504017D;
        Tue, 28 Apr 2020 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588103164; bh=lty+6iUJ6jk3PWGcbv8AlVkjx5NoUFHko6LkB3O5adM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VSYG47P3RP8yReynDm29kA/+oBTH0+FBHQpBIjl3pOy1cxnkk2PGbm+6LdeWZqHnq
         nuvm540ZDxbDJ2LzGW/7OAmShIIEcQ2kmgO1wpJhAS7Y4Ql2v5BFpH1QgA1GcRvbaM
         kDM95ue2blqUL9w3CNVPa45uUetJnB0eOafQHAGvfgnjCI9C7pRhAEE5EEcoNQ3JR7
         Y1XmtXQnkewfC5VBZ0sWxQlh8uX0IAtpE3sN97UGV5TpPZdy33gqdxCgNhhJ62EAYw
         ZyT82BAuLd4tYXuOVbenOxwCt8CEpxe4FIiyOc7ODOwyVTMJzSudBZLyJdOQwJKRl4
         htSKNx2JywZ0Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A9480A0069;
        Tue, 28 Apr 2020 19:46:03 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Apr 2020 12:46:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 28 Apr 2020 12:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deHM20ep3iUtVKk0nnrDOP5XCiub4HklFY14+SyVFZ0aWj9HmzeRZcNOmIrKDCcmB6HmlY8mq6AuRmrTkTKpPDStMYLnMex+qkA1xtvyuO2eJAGZkXSU/lzsuQ/iKHJe8DQYCxzZlSx3rEmJkR//qtNKB9fNaInsh2hTi94qPXEpkRTF9OqQCUorE93SR9dM9pR1h7NcWGweiIjduVnyeOFg+bYycsliA0WdEARxY1qHPb4jfnEoJSXrGFNzIV+GHo0dXfuFnbSOQ5Z78LEu6TFkmsoA4YSsl28TRFZHJgl1ND6VRsvEoMbqYJWZvZxt83YdMQYrYfjlTfCyjvC4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lty+6iUJ6jk3PWGcbv8AlVkjx5NoUFHko6LkB3O5adM=;
 b=i0F1RA6Vioq844FU7oKR7xGFty+h0fdHGuMDam53Xve8H/+VQAi4vpLSmrb43CrUkR4RHgsRfVPyb3ZSsAjOsfgMY3axHe4rPLlfAOnZ8kSSR863ZrMEubj/uAw5i1/SIOprQIKCSe6ZGGrkRGiT9L0vTFLNYHXefGB8NERVV2+XODfdCIb1beCfmNn9mFfQU+J4kQomdoKQHstDJkUPPe5B+sNufrmhTIAw8TxupeTk6JDcW6Lnv+pyWrNj99AGJzpIVSl1yLEoEj+Hcf/hsK9F3t1yzbB/xgSy3hLK6UwgeSKHNXVcPf6v/oWS+gI+raAx7yZBoYsB8nk4wQjA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lty+6iUJ6jk3PWGcbv8AlVkjx5NoUFHko6LkB3O5adM=;
 b=khOaihOp9WWA/5RM5TKEpGIrDF0cjKKfd0KCW5af3jLwO9EykLdr7RsG2234DQr+YCAgVxfWmy1fsobh+bez4cmG7EhGwtW9TXLf7mqrsMCFu6Fc3G2za02ciO2VMFlf6bGwLcYPWggAdLNLQJ4MZ50xd/SAjavNeRzDzBdbzDc=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3591.namprd12.prod.outlook.com (2603:10b6:a03:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 19:46:01 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 19:46:01 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Topic: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Index: AQHWHY4Y/rFoWc1Ys0qE7xdv+GRYS6iO8C2A
Date:   Tue, 28 Apr 2020 19:46:01 +0000
Message-ID: <08a295ba-e6f0-65d2-cb64-3ea463797f6d@synopsys.com>
References: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:83a0:8d37:2a26:865c:124e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f714437-1ed1-466c-0935-08d7ebacc801
x-ms-traffictypediagnostic: BYAPR12MB3591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35916A2287AC1DD4D2A4D955B6AC0@BYAPR12MB3591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(136003)(396003)(376002)(31696002)(5660300002)(31686004)(2906002)(54906003)(36756003)(110136005)(316002)(86362001)(66446008)(2616005)(6486002)(8936002)(64756008)(53546011)(66556008)(66476007)(76116006)(6512007)(186003)(4326008)(478600001)(8676002)(71200400001)(66946007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTxgXCZAmHnTVLC8UFmeVbG83NC7Li8x5Gm9dCnVLauqcWuWsJRNtZ8Sp+dX4IvYzr5skikUwTAjR0vcHhiE+DflFMQnoEFOGEjd9W/pe596pY1Z9+rtuPm19kuPdTfKathkBnuAHNDBtWluRBRRORfe2+Hv7erYzKPLP5gr+vj15BMHXd8qiU6DwO1si9as8pUvMqCYDLxy1cg3cnT/wSEluEX8UrL/424RpImrE36y7/rew0X19Q4hZWWax9ddy9x+hOkr6TjXvrzUQ9Jm1sFEs8bmWNgmEZ0MQwNx9+QtyKxhobFjiRl9KxIBKH7rCXGeH7d+/hoFfBuQxvQl7def3euOtBC6sLihxOsaZdEpcqy5PXeSKp1SYNnxg3IDcNoOYDjUimIgREFqHE8i1ndcCbvpWJAFVXbreGjbYpegw9baD23W0EG41RXKp8bR
x-ms-exchange-antispam-messagedata: so+jWBZsDVJX/S7yz9qeDGsyZeiXmrK54U8t1clumPTeeinDovWSnKYPMWWTONaP2sG9K9dES1fpeuI+zpsYl2atjq4dZkBTm3BeE133A2zssmsJTySV5SzBgLrn93Ccvi1OwHOQ0YBRsT35xYjN5LVrlpAEL4sgHJwqcdHOdFkwSCrkRsP6odAM7zT04dbYAUK3xujH7t87ePON/pde4EZSw31J8An+b0guVyFCo5bhHxHcON81RI76xO37YPp8XoZ+/oj2QkKrDx85LnofYcbCnHRyB7gHM1UXk9oU7bPl7PrOAMiIy2z3X9N2HwJfKhS2LWsF1YLuKNAYhKiGjTwyxe8X0va7eTPZWT/SqBBKitoyv9D2xnPoW/zQvG80RA7RShScwiOUR5B4TXfrdNIrwHEDI0AjPqcXOlGpLP+MT3Jf9gV5lxkTP2b3pkUEEZ9+wHzgvRGJpCDvbYzw3P/Cs5Ji5mnTzTKwbF8aO9FQ0732yzKiTKS56NFlTo4MqoFL5KD2AKpHTZ7pWQTLJUwT66wwpB+bOL/pNPGgmLaXUnCd8oKEd6R/Jmprarmc7MwDsLmc0UwTLg5ywI8TQVq1GthZdTTbRU/cmc/r9Wc8YMnidFigsX4ZiLfNT0jdPSrb5635YFrS72QyBGxtfO6mYHwucQfKv3qWuFJyvo0O6hMG3FQ8XzB7x0OBgYD0e+siUAH5bZXiEeVR42SWIMyas5x8Hcdj+cy3Ly9XW+oxIxTcjuk6dxCOgn67MPewe9frcUybndxzK24AAh/uSfko0qjSAX0doQWrvXvpSpwnOSj47jXptnCaMTXxIIShcuHsCkbJmQ68iWZvBRp+YW3U3IXn9RnhKKmKzPf2Fmc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABE2FEB008F13B429933BF4A2C21986A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f714437-1ed1-466c-0935-08d7ebacc801
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 19:46:01.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWSl0449Qe8yXShSVqJwsqyLtrTLXXrIT3Frqr7+aenp3hQqv1Dpz9OeBfEmqO1DB1IS4ShUEgRDnPx9CdU9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOC8yMCAxMTo1MCBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiBBcyBvZiB0b2Rh
eSB3ZSBndWFyZCBlYXJseSBEU1AgaW5pdCBjb2RlIHdpdGgNCj4gQVJDX0FVWF9EU1BfQlVJTEQg
KDB4N0EpIEJDUiBjaGVjayB0byB2ZXJpZnkgdGhhdCB3ZSBoYXZlDQo+IENQVSB3aXRoIERTUCBj
b25maWd1cmVkLiBIb3dldmVyIHRoYXQncyBub3QgZW5vdWdoIGFzIGluDQo+IEFSQ3YxIENQVSB0
aGUgc2FtZSBCQ1IgKDB4N0EpIGlzIHVzZWQgZm9yIGNoZWNraW5nIE1VTC9NQUMNCj4gaW5zdHJ1
Y3Rpb25zIHByZXNlbmNlLg0KPg0KPiBTbywgbGV0J3MgZ3VhcmQgRFNQIGVhcmx5IGluaXQgYWdh
aW5zdCBub24gQVJDdjIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVn
ZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9pbmNsdWRlL2Fz
bS9kc3AtaW1wbC5oIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLWltcGwuaCBiL2FyY2gv
YXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCj4gaW5kZXggZTFhYTIxMmNhNmViLi5lNjRkOTQ1
YWU3ZGYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCj4g
KysrIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLWltcGwuaA0KPiBAQCAtMTUsMTIgKzE1LDE0
IEBADQo+ICANCj4gIC8qIGNsb2JiZXJzIHI1IHJlZ2lzdGVyICovDQo+ICAubWFjcm8gRFNQX0VB
UkxZX0lOSVQNCj4gKyNpZiBkZWZpbmVkKENPTkZJR19JU0FfQVJDVjIpDQoNCmlmZGVmIGlzIHRo
ZSBjYW5vbmljYWwgd2F5IGZvciBhIHNpbmdsZSBtYWNybyB0byBjaGVjay4NCg0KQWxzbywgdGhp
cyBuZWVkcyB0byBiZSBmaW5lciBncmFpbmVkLCBpLmUuIENPTkZJR19BUkNfRFNQX0tFUk5FTCB3
aGljaCBpcyBhbHJlYWR5DQp0aWVkIHRvIEFSQ1YyIG9ubHkgY29uZmlncy4NCg0KPiAgCWxyCXI1
LCBbQVJDX0FVWF9EU1BfQlVJTERdDQo+ICAJYm1zawlyNSwgcjUsIDcNCj4gIAlicmVxICAgIHI1
LCAwLCAxZg0KPiAgCW1vdglyNSwgRFNQX0NUUkxfRElTQUJMRURfQUxMDQo+ICAJc3IJcjUsIFtB
UkNfQVVYX0RTUF9DVFJMXQ0KPiAgMToNCj4gKyNlbmRpZg0KPiAgLmVuZG0NCj4gIA0KPiAgLyog
Y2xvYmJlcnMgcjEwLCByMTEgcmVnaXN0ZXJzIHBhaXIgKi8NCg0K
