Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE752C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CE72072A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 01:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="esWvfnK1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wavDflmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgCaBoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:44:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46984 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729089AbgCaBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:44:00 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AE369C0FDE;
        Tue, 31 Mar 2020 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585619039; bh=+JYwxjmNrGYe+FIxr1oRwnWUOSmki7yaI2j2Ch6XPXU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=esWvfnK15aiaoYccxOYShAFDBFkXq0g92CgGjZAptlUnDhda0SqeUnof0RPvA2r1r
         rKG3vZZEV+j7tQ+C9rEfi9fKGY8+InuVKcNDhGGwdQlBhdkO64apGIVPgGh6Y2F4th
         FXsCHwg/xg8kglIQNGO3Scj0ZumqzHeXAGR93YZMVN1O3mSbVLbYyEykePJzRGrZwc
         uAUN4o34AwergCVT9cwOzfDZh8E/KdeZvc5ATlpEc8OnX+GrYKPNXwlXj0c/KhZ5bH
         r4VHE5isgHOnIMpz2b5Bx2YWjaIX8rGV0kOeMg5UDeKHHhBNI0bgkoQpnV6t83KNFZ
         xdpqTM1q+qmAQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 05FABA00AE;
        Tue, 31 Mar 2020 01:43:57 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 30 Mar 2020 18:43:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 30 Mar 2020 18:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZuDVHVepN3yu0tCOo55Xi9Nw9hzJ3NvKeDOZlrKNGAWADwtgm2H9kIfFw+JgR+lS00t5sn5R0GW2K2pPnd1uIFe10s4/8VteYKrHk9XJeFeVtWXYtWncPWmynkGzY8jkBiyFJ0nwl3boWbMxFmJxR34gPJnpd+5ZCIbMFls4bHseE6KdNGMMzjruG2miqLRGQVHzl7ihFP+WbZ8oSqG6rJJwJtx+LuDU1MVMmewN2MEJn7TuNYQb7rEaWbzkLayCjKMTX9cktHQ5THLQRdmZ8WIbgBsFYRmdN3o1z0VHDDRIesUFdA0qpwJBxoeQFG5PL5fehfuD6G5zCFuoZncfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JYwxjmNrGYe+FIxr1oRwnWUOSmki7yaI2j2Ch6XPXU=;
 b=BVOsIh1Nhb4DlX9aHDFGOVqko7aXLXjKrA8sKDE3y4aJpxDtunCR3g6wxCD3glYAAvpt8np334d5cRwJnOE6AmNPd/IVjvSPLs5EWnsrEkCv81V049IJT7BSz0/hC0P81i5pgeW03JWgfrQMf6fepqTq/+018VWRokxASGMfYKymV/85XryC75ipM62dwQ8dOLW3ULf2vcWlviczS46syQ7x4SAGw0lIDY+ibGbbWqJRKo+Fi3GvcsPVrx6iKZSqialvG3ThmVDwTXCqYTc3qs+QctCIyhZ5JF5ezh9Kf9IZOrQlmmV4wudlPxevVlxFh0bSxz17z/v3fF970Qg67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JYwxjmNrGYe+FIxr1oRwnWUOSmki7yaI2j2Ch6XPXU=;
 b=wavDflmJ/XlH+YuVruOS8hCqtvuz+Lc9iVTHI+csco9G5qOGJtb69exnPC14533PuO6BYuGujSnruio0pfbLWHY4pncWGOPzHVJjoFtyaHk/TSV+6AQk2EkVVxgr0f/nA16SN8Rtbn4/6ecvw4ux4v+G5YyhLlFk7OaJVSQLDkI=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3447.namprd12.prod.outlook.com (2603:10b6:a03:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 01:43:50 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 01:43:50 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: Build regressions/improvements in v5.6
Thread-Topic: Build regressions/improvements in v5.6
Thread-Index: AQHWBpcvcUuu+ZudzU+b+A9JmGkSJahhl0cwgAAMygCAAEU6AIAABSyA
Date:   Tue, 31 Mar 2020 01:43:49 +0000
Message-ID: <8abe0bd7-d665-8625-ac4b-517f341fe0d3@synopsys.com>
References: <20200330085854.19774-1-geert@linux-m68k.org>
 <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
 <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
 <CAHp75VfsfBD7djyB=S8QtQPdKTkpU5gFzyRYr8FshavoWgT0CA@mail.gmail.com>
 <CY4PR1201MB01204FB968A6661FB8B295ACA1CB0@CY4PR1201MB0120.namprd12.prod.outlook.com>
 <c8447243-98c6-d545-9766-e6b3f33f4d13@synopsys.com>
 <a5e8ec79-2eff-7517-4b90-38d5cb366f45@roeck-us.net>
In-Reply-To: <a5e8ec79-2eff-7517-4b90-38d5cb366f45@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [24.7.46.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 978016bd-f6d0-463c-b7f5-08d7d514f608
x-ms-traffictypediagnostic: BYAPR12MB3447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3447855CD2C14545F43D0E4FB6C80@BYAPR12MB3447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39860400002)(36756003)(6506007)(71200400001)(8676002)(81166006)(81156014)(31696002)(4744005)(6512007)(107886003)(4326008)(53546011)(86362001)(2616005)(110136005)(316002)(66556008)(76116006)(66946007)(64756008)(66476007)(66446008)(5660300002)(478600001)(6486002)(54906003)(2906002)(26005)(8936002)(31686004)(186003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjdsIno10Va6s7E+9sTZzS0Y6BGMzfLcMUOvxQF/9BR0Q+Cpt07ODWm0HRJ2J32SnqaIOkYAk+9FtONQva1j7g5kSuGL5voraXkPuxp16znWqhBT9BMBaTe0BR4c+omhixuXbvfFisGl6dcX0F4xtVAJumZCEVLLIbgRU9nqfo2dIYrRF1+JMXeYYnXHToCNcHsgHEstO+jAfV/7b1Xb0P15kA3nArZ5v1u7J716wQftRHOQMe8T8AR5I7SBmFWlfr6YWyY9khA4mHx3eQlCcC0kGUVOa9boVP5A/CvvbIVVcIxydA1HNG+r+HGvTxnKpf7Q19nubxeqq8zGDQAHhbf0aCGFhL77Ht06cELKOeNxy5FhyM1rmcjDv/111wUFCdL9YWM8uQLK5gbiMGW9Mr2WjE0922F0wpOQH0dgu3xQjx7DLz3CDwzhtotRXL3G
x-ms-exchange-antispam-messagedata: x0c+IKJAM4Qnngtagkc7u9zFLuxIpIIl/FiyIwe0AKlFloDLjy/uZPwU79ezBv0QOZjnwE6ibBYxgz5cvS4+bchVL1/WcCkK4wg+aHhoHDbqLg3sHqV5/eC/1DPOhsk/dBztMUj6Iakr/5Sd+G8EbA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F90019EAF54A04CA15F67A870A62860@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 978016bd-f6d0-463c-b7f5-08d7d514f608
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 01:43:49.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3in3FpbYwNyphsV5CaGRhQmC9deHKboDPm2Wg3slAaJyMB5SxY4VdMk8v/vJQ8sT91/QIb4s9gEJ0gtEr+Mug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3447
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMC8yMCA2OjI1IFBNLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiANCj4gSSBhbSBjdXJy
ZW50bHkgdXNpbmcgdmFuaWxsYSBnY2MgOS4yLjAgdG8gYnVpbGQgYXJjIGFuZCBhcmN2MiBpbWFn
ZXMuIEFyZSB5b3Ugc2F5aW5nDQo+IHRoYXQgSSBuZWVkIHRvIHVwZGF0ZSB0byBnY2MgOS4zLjAg
PyBnY2MgOS4zLjAgd2FzIHJlbGVhc2VkIG9ubHkgYSBjb3VwbGUgb2Ygd2Vla3MNCj4gYWdvLiBJ
IGRvbid0IHVzdWFsbHkganVtcCBvbnRvIG5ldyBjb21waWxlciByZWxlYXNlcyB0aGF0IHF1aWNr
bHkgYmVjYXVzZSBlYWNoDQo+IHJlbGVhc2UgdGVuZHMgdG8gaGF2ZSByZWdyZXNzaW9ucy4NCj4g
DQo+IFsgTmV2ZXIgbWluZCwgSSBqdXN0IG5vdGljZWQgR2VlcnQncyByZXBseS4gU3RpbGwuLi4u
IF0NCg0KTm8geW91IGFyZSBnb29kLiBUaGUgaXNzdWUgd2FzIE1pY2hlYWwncyB0b29sY2hhaW4g
ZnJvbSAyMDE2IHNvdXJjZXMuDQoNCi1WaW5lZXQNCg==
