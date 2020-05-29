Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A6C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k3+YCYyf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c5mA3U1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgE2UtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:49:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54038 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbgE2UtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:49:11 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66266C042B;
        Fri, 29 May 2020 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590785350; bh=66VPI7YCM0l8yIlLElT/qbmzlaCozjxsVwfNR/VJArw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k3+YCYyfjfKNzQ5+GGiBk+Q08Msk1+a1m2MYBGGNRTGeywsFREmX4/zVHVJVelog+
         AOm5nW6010ecBi8oY/aNdS7HURM/wBiGBtCLmAJw8J2neTz5EPcliLAW5ADl9bLdoc
         uDJPNyMLK5SXSMXlGGv83HlftiXOIYdOKHI6tq25m6CffQdQlviH2AGqulid6FNp2R
         qG2980LRdYY/94JTpveAkcv03xlq39zHy3rfIAj2WuV2mRQCODFY6PhOPsmxBHm6+3
         iSVWbyO0yXwC/HpsnvNvB65rLFszH6l4KJmQFHaXGHFZ07TPbspSRONr4+J1PXktD4
         cfbF4hszJr2bg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 044ACA008A;
        Fri, 29 May 2020 20:49:09 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 May 2020 13:47:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 29 May 2020 13:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu9aTA+/eFT7Z9Fdi5sYMcCUtorc2LARBRXPnoWMBCPvPsWjDQEXifYniUUCOPYh/+slBxbLnJkMe6TPvbeUNQ/vwMvcws9c7ONzECzrMmiDb981txVUYs+rN7ukWyqCU6s68VlFlN5CoMBH9y+LJrYggB4lryauzOrjm9VclJ4bNBfjs35/g8HuCM+7NghkMQY7yLPWldmJLBbb2rVjcY1kngUT+aZP7rzRjJUHKUmoN/kDc25lss7D/6xJdbdw10C45GFD7KNXS5n5XDGWPoMASq3BDBjx3CnZNZ4nfCNXBB6uSowLcTtMA+zWbpgHVkXXocBvPp9XBZBXXrkTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66VPI7YCM0l8yIlLElT/qbmzlaCozjxsVwfNR/VJArw=;
 b=cxUxZimMtXdIM+j51o9RxtWf+ZcnzkkLHJica8ADUNYkSw7RIjFG4FyN1F7/CBxEK03KBq/++cDMaszNPd/E4y+CJBkmvUlxSc1oVlNyIDWMGOksUDGAK46KHhGD2oQTajzCXSM2JDcp/TBWicdWtxnF7Za1IZtp1a/x4xlvDZGw/YmX8iFBki86TFJ+MZpdBkRdNYwS/9CAdWxKMzduzb/2FbrsV1LSSC+c9tXQuoV4hgmZRv6DJGVFQ0OB2hWrhvpWpDqT9cq2Md6B3LvtkD2snEP5ile0+pC4v6lwk6iKAc4B6zuJZZS4XQB5omzUAkkd70BP48J3ajjPpITGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66VPI7YCM0l8yIlLElT/qbmzlaCozjxsVwfNR/VJArw=;
 b=c5mA3U1iiPjcGFdOUKk69qwg8nU7NKBwsQ4swCbj2ItRo6znEp0MsvF0BAhQOnuX0rqf9pxWveWtuluc6RJWvEPNySm0Hwg20/JMYyT6+zV3mEsHsS/LQqo2aGMW8j1+mOAQ1UGppHCFAQWaH0HeSJ/0e0YH1pDcvEaPHKRYoJ0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3432.namprd12.prod.outlook.com (2603:10b6:a03:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Fri, 29 May
 2020 20:47:56 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 20:47:56 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ARC: ARCv2: support loop buffer (LPB) disabling
Thread-Topic: [PATCH 2/3] ARC: ARCv2: support loop buffer (LPB) disabling
Thread-Index: AQHWNbAu45kCK8zTtUiyo6D8NILYiai/iXkA
Date:   Fri, 29 May 2020 20:47:56 +0000
Message-ID: <99b62f47-7535-c8f0-7fe8-63c0fdedf7b4@synopsys.com>
References: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
 <20200529115534.22883-4-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200529115534.22883-4-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b205dbca-7868-45c8-fb5d-08d8041190c0
x-ms-traffictypediagnostic: BYAPR12MB3432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB343284B8FAF67697AE1D2424B68F0@BYAPR12MB3432.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42TkPHV6Qxb95MXxiZwjwaty/6Xj4yGadd+VXRd/FjN9XnYmLoItiucCrH5J10nqF8pfEFRN2VQcVRvk+VI0NubR7T9leRbU5z5vp5mePymiHtN7sILsLVXnhYPf3kUIws4iR0OwzEDK578O3fwhO2RCa3Whsr2gFraogGIUPt4hVju/1AWLaGNxUSMVi7fe31S9fPvN6UN1iDfXorO8F6RzOwolYaqGKjroZ5hi+l26cVacIXvJIQLmZdTn+pnGif+wWYhPaQpvoz03soXTlhjCzBt38vuTffheZZL3yxtdbmhKhtLU0bL5gonn4/RxcFnzBUBZ/EueA8tl+nUCxHF4tuEqwVJxVApVYEt8ttpi3NvA2jWVz6qdrrbdYHV4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(2906002)(31696002)(64756008)(66556008)(2616005)(86362001)(71200400001)(478600001)(6486002)(110136005)(31686004)(54906003)(53546011)(316002)(186003)(26005)(83380400001)(36756003)(558084003)(6506007)(8936002)(66446008)(8676002)(66946007)(5660300002)(66476007)(6512007)(76116006)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B1SjQai0fBlFq+jH3XQnFIo0Qcrv1EBkdJn7RtX8wOIIBLS+btUOorZwErrMg/mrvttrwBC1MwhhNkChdoZvZd3Bga0Jd/2pVloYecLBU9BA8UXwOs3ZE/yQP6ZxFXnAUoiKwuhqhmsgeK28T4nj1vOR4ycjdHoQG8VOVrobtWho+hqW43TEptxXWbGPU8M8BqAGtMzM+k4WK1iFFes1ZXIIVUA2DCFu4jFcDkdXDxIk1HHo4XzP39Jwq0bIJRJUSO6kp353IZ3gDFa34veNnadNsT7SrKXQ3kpbTmmC3q4u78PpwWdnjzt8a5+YMJbL6bisNiOsSYYfiFZRnzWTKnyKq+KzQ7JS8HFamfxIqlWyXMxWza5V2Ynalc8FgdJ7t6yiU0SiUANRVxbtqb8a93y2ayjSPhc+WUX6aYD6EBmMA4HtAHYxVyXl2pAJhc6jgFBGGSh7cme7QHwYJH6Nw6xUYa2AI1b5+w5n7o/3nY0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <160D418B3E72FA4DAF24C84B6084CEFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b205dbca-7868-45c8-fb5d-08d8041190c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 20:47:56.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFssrew2Bk+Zsywq82N3/cCedt8HLs97vO036/J+EuAaTXMqQykhqQ+d/UXs5MUi8m0km7YtuNPyi4B0kzCN1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3432
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOS8yMCA0OjU1IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IE9uIEhTIGNvcmVz
LCBsb29wIGJ1ZmZlciAoTFBCKSBpcyBwcm9ncmFtbWFibGUgaW4gcnVudGltZSBhbmQgY2FuDQo+
IGJlIG9wdGlvbmFsbHkgZGlzYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBh
bHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQoNCkxHVE0uDQoNCi1WaW5lZXQN
Cg==
