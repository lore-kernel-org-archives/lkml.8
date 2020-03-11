Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D41BC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49E020736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Yp/LTLFv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Bre8N7Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgCKTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:13:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37796 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730705AbgCKTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:13:34 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B870A43B76;
        Wed, 11 Mar 2020 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583954013; bh=GCnc8Pe16ifGGkBm9Qf1Pg9gDdgo5xyrsNj7YaH1v98=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Yp/LTLFve61m3uCDVcZeEFomxUPuPRi/24K41uKhCJ/PBQxvEoKgiW3eMt3ORWWkf
         SZonKrU10ZqoonSAuoVQfX9EbMp04lT1R/Vf6lkQaqLgkP6XWWs9ReKY/SnVlgeigq
         waQAehba+IM5iENmUSlfChrlM/kPLIcnCIBS32AQIn9d7qsC28FqaYEZWmgoBw/zAb
         LY/WBvruoh9kU1SK0UsQxjVUpTOXdp0pGBwGMkPYm/IngDNwW7rSM7fU0aPwFeMEz/
         R+BCAijM0KnpVdruNULbbhLx3sfRmkRrbtsJKrO8dyyVCmkVU4Ih0hUITrtvyln/jz
         z/FcbnMaqKOQw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 881CBA0083;
        Wed, 11 Mar 2020 19:13:33 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 12:13:29 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 12:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfg0ZgCqIj3/JP9RDlYmNf8as7FuDI0TAC/yuJt/EO34/2flIWzHYghYPUHXyBhb/R/hJQQl0Hg7khf3OjFnJSOEC9sSwU2TUcEhn7SMIBHQL2Khod6qpTcWvEdHJw1aF/6AD53QxISANxnVoOcnio/GFE/b9dc8Bk7xyESZ/FBW+X57Uy3TbG///y7RGmJvapZdv+ANv1T1/G31HL+Y8Hd5UVGKtjkAVibL9C4bvHPaz45vmBPsxJyQaaraBHYtt8jD0UvYVSavF5flPEUnpMPLq3zeOn3RbZ92XGzKwBHJLVNI0fGMNdmDOmaL6fMC/STKsm7CcbfcOZDhTrlQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCnc8Pe16ifGGkBm9Qf1Pg9gDdgo5xyrsNj7YaH1v98=;
 b=DhXydrpnckpPgfxLALZcq0zipnXZp0Lr9d/RtHOYCneGRVjQ2yDqpT1Oez8hxGbTzzIgMAB8uM46MTu35awl8Vq9QxR94eb8XhTRVj5jALUCo3DcTpkl9HvJVG+UNcugQ6LjgtZd/ZEkKNVS3NLxRaaLxoj0liOw4FsVATgD+D8PMfvUhavrkO33eGl3sTCXWxN2RlnbmpAroFUVsw/X2TKhekvilqZfwNkJcT3wiKwCbq3Y4xn4lcqhAfX6eexvZUgHiMVXjqSQL/Gy9UDu5/I4PljYagrnGyJqVRT/KbvHzEf1q+cRN18tabnqJgkIY7FiYLB2/0avH7wB0BOKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCnc8Pe16ifGGkBm9Qf1Pg9gDdgo5xyrsNj7YaH1v98=;
 b=Bre8N7Xb4G0vzoJtlFsOAZmWWAiFlnNw3X6EdkcKIPiPM8s1oJf6MO+RkgEsmnj9FooA6XGVNBzNYd9PUzr9CJ7ywvMH5ha9criDlMqSfOvhcSBncJqLJwRT7yJkGdeyyLkwX4mptR7x8vOb+OCrc7cdu2yj6XixyDSVFcuLvMU=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3112.namprd12.prod.outlook.com (2603:10b6:a03:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 19:13:28 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 19:13:28 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 3/4] ARC: add support for DSP-enabled userspace
 applications
Thread-Topic: [PATCH v2 3/4] ARC: add support for DSP-enabled userspace
 applications
Thread-Index: AQHV8ykv0O4Z+b6gX0KY0D/KHFb2oKhDy/cA
Date:   Wed, 11 Mar 2020 19:13:28 +0000
Message-ID: <6f7916f4-9ff9-e947-c62e-30000a4bcc84@synopsys.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
 <20200305200252.14278-4-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200305200252.14278-4-Eugeniy.Paltsev@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 1ba3b106-10ea-44e0-2866-08d7c5f047b2
x-ms-traffictypediagnostic: BYAPR12MB3112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31123F2A562B0202711D4A4BB6FC0@BYAPR12MB3112.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(76116006)(71200400001)(66556008)(478600001)(66946007)(66476007)(64756008)(66446008)(31696002)(4744005)(8676002)(2906002)(86362001)(5660300002)(53546011)(81166006)(8936002)(81156014)(36756003)(6506007)(6512007)(2616005)(26005)(107886003)(4326008)(186003)(54906003)(316002)(31686004)(6486002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3112;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1I4sgSNL/i7LXmknuLSFEveCg89TOJQVgTgU0/7bjJLwt/kOGq3p32Lfiz0LGQUFu8/ojOne1AP5GqKVHqjq4U9hC5O8tAoSM+Jo5s/TThr9UJwCRcuueGwlc705eqXxC8AR1eg79f5WZlLfxYxjRYfIvZha3qz0eU2VbztSrD7Y8Q5Pv7my4MwcGdrEDcZ5z2l0RlITrtygf4xJy3Y7vk3NI2wth7lT8c9GgGEEHZPOMr+IFYXOU137fA4LefstmjlmWXZKMZ4akBWfu+UZr0TpZ9lw7Ao5g/q63nCkfC25vZZB4k+AsZuS9ndqFmuLhLkNSmvfDVAYUvy/MWlQS38Po9UFhjS/rIJhlL7PLnS0aSduVlh/EJvOiD4qPN7ThrLllVEFSVbPq54FKeAA7Yd3kBA0NBXJw6Hchrd/oqcQRAIVC7uWlv3eu165qMHQ
x-ms-exchange-antispam-messagedata: ZbOgs+uwtNVvhxlLBRw+O2RswABN8aV4NL7MprX/crzHyxOn7gsGqUF2Liul8Qv/ZI+tZyCdbReSI3blXDOBthhJP4x957tKK/2WfyQNLo0etYtfm29PxwfPgAY1PS+Y9IXHyJExVtEzR1g3SOwG8g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6401D9DBA752F04C8C88B8138468C5BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba3b106-10ea-44e0-2866-08d7c5f047b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 19:13:28.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4lbC1C/K8hKjdwAjkF2OwnqdJnSlaTUZQG45OoY+sZB+h9VrGTUy7uQgufiM+j0HZHFJKWiJyNcoEoGmCGYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy81LzIwIDEyOjAyIFBNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IFRvIGJlIGFibGUg
dG8gcnVuIERTUC1lbmFibGVkIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgd2UgbmVlZCB0bw0KPiBz
YXZlIGFuZCByZXN0b3JlIGZvbGxvd2luZyBEU1AtcmVsYXRlZCByZWdpc3RlcnM6DQo+IEF0IElS
US9leGNlcHRpb24gZW50cnkvZXhpdDoNCj4gICogRFNQX0NUUkwgKHNhdmUgaXQgYW5kIHJlc2V0
IHRvIHZhbHVlIHN1aXRhYmxlIGZvciBrZXJuZWwpDQo+ICAqIEFDQzBfTE8sIEFDQzBfSEkgKHdl
IGFscmVhZHkgc2F2ZSB0aGVtIGFzIHI1OCwgcjU5IHBhaXIpDQo+IEF0IGNvbnRleHQgc3dpdGNo
Og0KPiAgKiBBQ0MwX0dMTywgQUNDMF9HSEkNCj4gICogRFNQX0JGTFkwLCBEU1BfRkZUX0NUUkwN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5
bm9wc3lzLmNvbT4NCg0KQWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNv
bT4NCg==
