Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DE1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D521D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ywc5bfCW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F26zBPK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGNMcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51854 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728047AbgGNMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:34 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7CC6C00E9;
        Tue, 14 Jul 2020 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594729953; bh=eeixpN2+EI6mUAAQ4cGP3s1R99EwwqmFBhljeDPOmFw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ywc5bfCWGlLtKs8r7MbvaHpGFUI5pNkRzK6ju/aU3EnTmmUIzHNAIPx2m+4yrF2Vc
         BtskSoftnzuoZWDV7APKpaLmnNshGDhNiSapf3UmtKjlZFK2BFrlCAiu0wx5fBSeQc
         zUhdvilDhyu+ue/dxrllcOkpZWjcyR3TYn3wH0btYcu6k5smf5ZEqGk1KjHGCrXXOo
         RJ+lCl9cGeE0pjCbPiXSka17FaJrQfmXroYL37CTPyl5urAECYN3P2TAOaUacRXe00
         J00pCfcKJfFJUhqP6pZSzwyM2ZdYzktHor2ZZr8Qx/7qKQ08rnFlt1Si5I7RDF9+IG
         CNnsJph8zgXTg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 96FBAA0071;
        Tue, 14 Jul 2020 12:32:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 17C3440081;
        Tue, 14 Jul 2020 12:32:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="F26zBPK2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH0vPVUeqf7eubLWYg2RPc45/GdxGk6cjq1IXZytYOcdrfunqUEmz9YI9EchK1+J1F6vcf/6Foid1An7bWVniVNlbZnlr48gXD/l7j9U3zR6KtFQtRQsC35PDqtCR8zMoKSdvKW3EuoQs+CySop0aVCKAdywQlUNC/a8k/bdSXaEVQ82IUN2IFia0SMKmFmTSlSqo8M1YZSw3GVMkz6O8XHcNeQC5taXIzziaQWI7iIW5uppAnmwAGCzAAjRWCJrPVq5L2OqxeaXceZReedctnN5eoqxDRvbejZdnGkU4Yg/0psL3IreUGvG/qJZZ8iQziMYrLYLn+BavVJ9/o/02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeixpN2+EI6mUAAQ4cGP3s1R99EwwqmFBhljeDPOmFw=;
 b=NT4c0np0uhPhjzUgBTVdLwyhDGKEMFCWn4dW+KWHX4RYVg/N06lGf1QyI1SzOQPrg/RMoABwlI2X8zt8IntAen6VYiM2MM1YlZl5yvnQmKjllJRFADnhWkCjl/5mviP1PtwbbhPCCPFOZ/tKl37EhpBzBHTruGyRXIVR2YBgn0qBP8S/xThiMQ1yTkvylb6rebtLttDe0zewHLiiHTzGlzdPgAS+Hxacn31azJyYzva93ONJHAM0b4FesUGrQUeHpQ37LvvVsQ7Y66R9RCyEN7ypmciLKSIKsZeAAoZrh13ysD6aVG09qTsmE+U5D1OEwlLEb4DH1SNcYTMl6EYTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeixpN2+EI6mUAAQ4cGP3s1R99EwwqmFBhljeDPOmFw=;
 b=F26zBPK2Eks97yIIGjB2zm/93SQGNPqbjyLbqeu1JjyE4X+JXHaQ3Wmp0qhQfJjJj9IlXW9fMQWIy6rxtEGAvRDWg8C5AblsDhdNy/zBLKSYjh5aijFwyexArgkepdrrzmP23Karo01gdpfIwBIu8FuPXzw6a5FRWzXjtdAwRhE=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1416.namprd12.prod.outlook.com (2603:10b6:903:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 12:32:28 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3174.025; Tue, 14 Jul
 2020 12:32:27 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: dwc2: Fix error path in gadget registration
Thread-Topic: [PATCH] usb: dwc2: Fix error path in gadget registration
Thread-Index: AQHWWbuDBUQ8jHqiX0W5003po+jOE6kHAjIA
Date:   Tue, 14 Jul 2020 12:32:27 +0000
Message-ID: <40bfbfd6-6516-5995-8250-c8e3df16e11e@synopsys.com>
References: <CGME20200714084807eucas1p1f6e680d162573c6a0660037172a65805@eucas1p1.samsung.com>
 <20200714084800.11340-1-m.szyprowski@samsung.com>
In-Reply-To: <20200714084800.11340-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4921cfc0-20e3-4c29-fed0-08d827f1f841
x-ms-traffictypediagnostic: CY4PR12MB1416:
x-microsoft-antispam-prvs: <CY4PR12MB14165A9A0B7F1009D258477FA7610@CY4PR12MB1416.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bI8SLaqlXjqnK5b8wEVCoT2Bznrg46c6K5K7tdh41jczT+vmcPazhzLeYCROlnnIdjEOXIzTkKnWV5j1PoG1tQkl1dhLPkCp9kenPenkgYyyySQw3B2fT9PG/8WLJNP9VLEPET78WaF1nXIzFjEv3cnK2jq07DJjYS5LAdCnKLsLMJ7tcUgDGTggAU+GdE0PK3S35rhy2747v2wfesVa/GHz9y+xQEg8MKl57UFJ9QBRhNZhvOt3fDflMLUEmMBHKu23B/DTY5scKtiNhlJEjGYZje42/Hg/0cakuXLLsGmiYrFsaQyCakA4HDWIJTPIeca966QxxIVBmSPcswPsv4b0RPj19x0gZxaxWqqfNJi0KFY3rfTFfE5FNLKMWyKc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(39860400002)(366004)(396003)(346002)(31686004)(5660300002)(86362001)(8936002)(71200400001)(4744005)(2616005)(76116006)(83380400001)(66446008)(53546011)(8676002)(186003)(31696002)(26005)(91956017)(478600001)(6506007)(64756008)(316002)(4326008)(66556008)(66946007)(66476007)(2906002)(6512007)(110136005)(54906003)(6486002)(36756003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +qUn7xyZoK9SjWq0HkcP12fp5j0nHSAgglgi6Y4jor141vtcQwD5AWPnb5IO6fzvGdNR6rfaFXUhEhT22wO5V/Rfl3jM6ZFw/UHWCdZPjV2v9HpMW4xDFh+7LL5GvWee3F8Wkfl6t0J+odwLe7QfTjpRJbhi4JQRlDMOn8wL9haLg8yHCXLOo99bAj8ra/USJYTYlFJByuC51VaePes2U8wCkhWq3ndT0wFsVdF3/OgDB3qqlTN1TduP/Hy6O6O7JS1tl2pEo4iTIfugjYE/FiQ7RYCl0u+HlrBezNQdh7Y8jvf0Cz+mxukMD3wBGM8eHsCSjzVd5tbskNRVZCHg49Zk8r28DZ9BqC6x7fK0Huk8sdFD3CqsEgh3Tp0MKrrYFDVH/JIHWK/P75SBJDBBE1OEpL1ew4UR/LD7e0EZ9vEEdKuABfy39uAaZ8QBGd8GYw1PWqe3ysQJamocoekBMDv3qlX4tx8l5mYuhmebOZgjGPceJJ46NGnRYnt0eFl1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D5B43223C7A7143A0C61A9504EAF726@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4921cfc0-20e3-4c29-fed0-08d827f1f841
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 12:32:27.6482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpo5oH9Exot7M+nZFZRaZCyD2AMz1+C1QyWJtINtEpf8V3DWNQhs2Po4rntbK6kSgtv1asCnHsHfzqG6lHUf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyZWssDQoNCk9uIDcvMTQvMjAyMCAxMjo0OCBQTSwgTWFyZWsgU3p5cHJvd3NraSB3cm90
ZToNCj4gV2hlbiBnYWRnZXQgcmVnaXN0cmF0aW9uIGZhaWxzLCBvbmUgc2hvdWxkIG5vdCBjYWxs
IHVzYl9kZWxfZ2FkZ2V0X3VkYygpLg0KPiBFbnN1cmUgdGhpcyBieSBzZXR0aW5nIGdhZGdldC0+
dWRjIHRvIE5VTEwuIEFsc28gaW4gY2FzZSBvZiBhIGZhaWx1cmUNCkkgd2FzIGFibGUgdG8gcmVw
cm9kdWNlIGlzc3VlLiBJJ20gT2sgd2l0aCB0aGlzIGZpeC4NCg0KPiB0aGVyZSBpcyBubyBuZWVk
IHRvIGRpc2FibGUgbG93LWxldmVsIGhhcmR3YXJlLCBzbyByZXR1cm4gaW1taWVkZXRseQ0KPiBp
bnN0ZWFkIG9mIGp1bXBpbmcgdG8gZXJyb3JfaW5pdCBsYWJlbC4NCj4gDQpXaHkgZG8geW91IHRo
aW5rIHRoYXQgZGlzYWJsZSBsb3ctbGV2ZWwgaGFyZHdhcmUgbm90IHJlcXVpcmVkIHdoaWNoIHdh
cyANCmVuYWJsZWQgYmVmb3JlPyBBbHNvIGZvciBzb21lIHBsYXRmb3JtcyByZXF1aXJlZCB0byBj
YWxsIA0KcmVndWxhdG9yX2Rpc2FibGUoKSB3aGljaCB3YXMgZW5hYmxlZCBlYXJsaWVyIGluIHBy
b2JlIGZ1bmN0aW9uLg0KU28sIEkgc3VnZ2VzdCB0byBrZWVwIGp1bXAgdG8gZXJyb3JfaW5pdCBs
YWJlbC4NCg0KPiBUaGlzIGZpeGVzIHRoZSBmb2xsb3dpbmcga2VybmVsIE5VTEwgcHRyIGRlcmVm
ZXJlbmNlIG9uIGdhZGdldCBmYWlsdXJlDQo+IChjYW4gYmUgZWFzaWx5IHRyaWdnZXJlZCB3aXRo
IGdfbWFzc19zdG9yYWdlIHdpdGhvdXQgYW55IG1vZHVsZQ0KPiBwYXJhbWV0ZXJzKToNCj4gDQoN
ClRoYW5rcywNCk1pbmFzDQo=
