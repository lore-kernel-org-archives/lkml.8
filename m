Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB3207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xkyui+VX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ja9HBSDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgE2Ur5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:47:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38816 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbgE2Ur4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:47:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 448804094C;
        Fri, 29 May 2020 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590785276; bh=jJ2i7qdxRmtVvYj+X5kWTxRQgZJ9Kh3c2U5J3YrNGik=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Xkyui+VX1/avhVv3pr1wulVc0GXvOq2Nb6gPUKfRcsYXHL/FNsiHDElc1c25UjXOX
         wkSb9hKDJsA1I+P3ul8flfE3Ci3y+5CwKoP+JLsxYkLaxgW7yH3VWdFSNQnGCoVZYM
         NYS1DSDrjPiZ7w1RzRPms/IofEPhx+PI5ffZFcR66pIMiCcMeZ4M+85CcPSdwFHjPX
         VzmwzCaG/UjpdV/X+D5kb5rmbQA5NgczkSnREdb0qOQ4+gPSnO/szIfQCKgYRl+Mkk
         1vG1fmqWKIOGK2WcMTXsOBvZW/24PoVJegxkHKgymRjjkEdkXsCcSGLzij6aMnuOBS
         fg7b/LEYC3ETQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F3542A0069;
        Fri, 29 May 2020 20:47:55 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 29 May 2020 13:47:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 29 May 2020 13:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhMhFJqqk89Ilo3fIyL8Y9rAA2pzGmSgmBwOX7OGvlUhRvshO3fGYbE7Bv4ltqWT47bZdEoASX1mJK6m8xbRiIVnscLWfGFMDl4LqA9pXJRroigN5jynXwW0kvNqos/fu+BgENTguIxurdd8EgZKpLPzZWZK9bugar99Vz378W2ieXYBcXAPtYCF9/UAN+g5L+GcfqNcHQqnqbCQWyULMG6eKeHfOv/knj86o08oNIfqjZvAGoUZvs/K6uMFOy5hc2+cxPO2hC7FJcPyT6TaKw/nFVgzgRwXfZmjVHPmPhzp78/jwgI0WyshyLQ1jTI9B1mzeOp7Omz95agM8wgfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ2i7qdxRmtVvYj+X5kWTxRQgZJ9Kh3c2U5J3YrNGik=;
 b=ZvT4UIcPTVapC2mYYS27H8vGL8FE6WwYkxp7syxf6X4TU+rHNR7k8CstBY36elTLW9zo+06M3Wru/yEZBIQt3HvbcAEgaJhClx7I70efDAluHXkKq+b5jUVZhu16OgfKKpFRwRZsH79jDk7SAVc/STppglaQ2IV3+g5Mls+i5Xz5Yqq5Nv35LxSF/4Qakf1LU3iOVJhT9VvV+hc2htagJoIT6Ii3/Jh3jyDtFLRB8du0LPgfytpNU5N339wbVLohS9kesT1DSMZoS5XFf+gy+/PYtuLS1phRvvVHKyGFi9HcoVk0D3juCuuSGrwdnN5K8GhQGxNiZKWsQm+d4RFulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ2i7qdxRmtVvYj+X5kWTxRQgZJ9Kh3c2U5J3YrNGik=;
 b=Ja9HBSDQsgi1B3edJVmRG6FTS89506lG/qkk+76Pc6Sw01/CbjzFviBh9vMBXbFIWarzpeQ4YuQVmeSkZOImgGQ9S8cQWp6CWbpqe9/mIrx+QARzEm23CALaeDPoZn2rlO0PwCRfMKXnbGeVxzLx7TPNPl0W6joGpiAIT4Hdcgs=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 29 May
 2020 20:47:17 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 20:47:17 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 1/3] ARC: allow to overide default mcpu compiler flag
Thread-Topic: [PATCH 1/3] ARC: allow to overide default mcpu compiler flag
Thread-Index: AQHWNbAt4qzSjtc+Cku0PN3e5ay0Bqi/iUwA
Date:   Fri, 29 May 2020 20:47:17 +0000
Message-ID: <c1dee77e-f8e3-1213-61a9-390412bfb5ee@synopsys.com>
References: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
 <20200529115534.22883-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200529115534.22883-2-Eugeniy.Paltsev@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 93f3ddf8-17dc-4204-c6a5-08d8041179b8
x-ms-traffictypediagnostic: BYAPR12MB3575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3575FDFC4E7F203E5A36192FB68F0@BYAPR12MB3575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNz7hEdj5su46jJ0PQeS8XnIxe5CCw62tx7vTha2jzXDz/w9AhcRVztSd+g7Ce9TXFsgsauPu5w5lA6suHxa60JCXxP3tEGwfCXsh5C/imvTRdm60bHKaSHGjB3ZcPG5sWanezmtesHyuc2hx/ckFCbDN1v4bRdN2lLFw3dmtYR1LcF481R874oenyOJvgsD3qCENlJ8TjLFk7KOW7MquGzeLizfZNrffgUHC/M9XCcU9UWCYTRZn+Fy3IsLzS0EYj0yXYZ98+QL8gEBURoMDBJB+W7JVkldxFbyeo/BUDz+ZhG7XKC2V4aWIWeWbUeGw1WQDEoXDHDqy/h4V43kmffPGu5+Lfhcgx7W7aVAoJfuayV5F23/gjgWDbgWp082ZV0HQfMzJzu00NCKkCunOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(66476007)(31696002)(66946007)(8676002)(36756003)(186003)(2616005)(107886003)(8936002)(6486002)(53546011)(4326008)(6506007)(26005)(66556008)(478600001)(31686004)(66446008)(64756008)(2906002)(54906003)(86362001)(71200400001)(316002)(110136005)(76116006)(5660300002)(21314003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sf/IgQBbXF8lXxPfNQulMoDo1xE6HJXVMF3kiXcw5iNQkPjrxGYczu2rzSttKBQKtSWLFCAEv9J5w/cJ5BsYpP0dC11EyzgOWxj5pieu9IlLbALrLBIsUwffGj5dwH47xeQhFwMHL6HyJCKVOoIK/OSPobVY+3SjbMTH0XKtaYfZ2L1j/J2l36jsRPgac4biFnkdiUCgkuqFA7jfCp5JCFeIqbnzcI7CN0cCmna1GEONjikUZyQ/k28I5YtSf1SxoCK/Z6MCMXwEnMQKB3PNddUyZp9JgZguukF8UUsETK8TYo3MCdS81wbs4LxtqLHAsNO8B+vIy3L2MfEcqV9ysqkmWabaVeZxwzH6/Cyk1KCEvtzBeqd1Hu9//eHmuQH4xQZsFNvVBZCJh3zZomoGErjufYA8z9Cb4o+XWdcIdKwFELX+vqbG7/qelRKHWBS8W4ToMew5I6NNi6jwUB1e7/dB1lQChePT8tFKg8BfC5c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0F40BD766F98D4981E79ADEB8FBF3BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3ddf8-17dc-4204-c6a5-08d8041179b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 20:47:17.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkuycj6w2DVSSodexkGvrEHVokFhKjm5jne8y+3ijQxxEdMWIpJKn//a70aZ52yEa35quAgV+f6gpFELP9fUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOS8yMCA0OjU1IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IEJ5IGRlZmF1bHQg
d2Ugc2V0IC1tY3B1PXh4eCBjb21waWxlciBmbGFnIGRlcGVuZGluZyBvbiB0aGUgQ1BVIElTQQ0K
PiB2ZXJzaW9uLiBJdCdzIGdvb2Qgc3RhcnRpbmcgcG9pbnQsIGhvd2V2ZXIgdGhhdCBtYXkgYmUg
bm90IGVub3VnaA0KPiBhcyBmb3Igc29tZSBwbGF0Zm9ybXMgd2UgbWF5IHdhbnQgdG8gdXNlIHNv
bWUgc3BlY2lmaWMgJ21jcHUnDQo+IG9wdGlvbnMgZm9yIGJldHRlciBvcHRpbWl6YXRpb24gb3Ig
dG8gd29ya2Fyb3VuZCBIVyBpc3N1ZXMuDQo+IA0KPiBXZSBhcmUgZ29pbmcgdG8gdXNlIHRoaXMg
b3B0aW9uIGZvciBIU0RLLTR4RCBib2FyZCBzdXBwb3J0Lg0KPiBJbiBhZGRpdGlvbiBpdCBhbHNv
IGFsbG93cyB0byBhd29pZCBwYXRjaGluZyAnbWNwdScgaW4gQVJDIE1ha2VmaWxlDQo+IHdoZW4g
d2UgYnVpbGRpbmcgTGludXggZm9yIHNvbWUgbm9uLXN0YW5kYXJkIHNpbXVsYXRpb24gb3IgRlBH
QS1iYXNlZA0KPiBwbGF0Zm9ybXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRz
ZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQoNClF1ZXN0aW9uOiBTbyBub3cgaWYg
SSBidWlsZCBpbiBidWlsZHJvb3Qgd2l0aCAtbWhzMzhfbGludXgsIGl0IHdpbGwgdXNlIGhhcmQg
ZmxvYXQNCihrZXJuZWwgc2hvdWxkIG5vdCB1c2UgZmxvYXRpbmcgcG9pbnQpIGJ1dCB0aGUgbGli
Z2NjIGxpbmtlZCB3aWxsIGJlIGRpZmZlcmVudCB0b28NCmFuZCB0aGF0IHNob3VsZCBiZSBPSyA/
DQoNCkkndmUgcmV3cml0dGVuIHRoZSBjaGFuZ2Vsb2cuDQoNCiAga2VybmVsIGJ1aWxkcyBzZXQg
dGhlaXIgb3duIGRlZmF1bHQgLW1jcHUgZm9yIGEgZ2l2ZW4gSVNBIGJ1aWxkLg0KICBCdXQgdGhh
dCBnZXRzIGluIHRoZSB3YXkgb2YgImN1c3RvbSIgLW1jcHUgZmxhZ3MgZnJvbSBwcm9wYWdhdGlu
Zw0KICBpbnRvIGtlcm5lbCBidWlsZC4NCg0KICBUaGlzIHdpbGwgYWxzbyBiZSB1c2VkIGluIG5l
eHQgcGF0Y2hlcyBmb3IgSFNESy00eEQgYm9hcmQgc3VwcG9ydCB3aGljaA0KICB1c2VzIGEgZGlm
ZmVyZW50IC1tY3B1IHRvIGVmZmVjdCBkdWFsIGlzc3VlIHNjaGVkdWxpbmcuDQoNCg0KDQo=
