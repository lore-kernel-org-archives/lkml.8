Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB61C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A06B20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h3vvCsta";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="NMen1L7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgBCSlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:41:09 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:50786 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729092AbgBCSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:41:09 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D75DBC00B0;
        Mon,  3 Feb 2020 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580755267; bh=xyazO1v1Rst24xDF8S1Nz/nJoqT+ynATv8zxkqgngiU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h3vvCstaRcK3tr4EOsdb7n2W/L+MRUDO5bUK/GPFTpuQMGAE1Z8S4qT0wkcEd+7RT
         H43IoxKjUE1UTWfhU0+6oYcFvOh0gwU8nP0uOt6H8yb15naGydjqt6ZAEjn4AZ0JbY
         7TQ5VEAVb8DYIp5IhBzUhf2X7kKkOhSbmubKVMIqTgMWYRWahoGj6+/oomWL5C1pZ1
         Z0EdMOABaNRlK6R8qpar44ps83lAlF5gxCpO8vix2nJ3mVjYvjqbOiM95+NXYbZ1YA
         OZkJQq0a0AUmri3TnaXQJf3NtSGLqh2sAH6b/S9at6ODjE9F8cK3A+BKEvl/BIJFyy
         nusGvJhwIzijQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 467D6A0085;
        Mon,  3 Feb 2020 18:41:06 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 10:41:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 3 Feb 2020 10:41:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oavfz64ApBtLNTMH1voAvfGdZYZaDKs7jiGviyL7jQ6kM5DRBjA4NyzapWiiUimD2X7DmyaWohan5LGDjVF7xNl2g1jdIHGJIJuUW/TEXFesxawP+ISS4r7M/s/HcMiOvgTQVtlyH9jK0NwGuVUFdoV93OFo/ZdsIYKCo7CASk1K/uDnT3gsvWrNOEAE2siB9WuT1v211WtChv81f0ZB5HZ9QC1GBsta3+Hhlra02GWLiYCHq3smvMySFqgys+wn54Q5HRXCekhlZb9HAHPbk49mcNwCXOQ2gzAu+XO5WjzOMvOB06ncSGSmmE0NCfIooL5ApvqrMxHovdf9fH/mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyazO1v1Rst24xDF8S1Nz/nJoqT+ynATv8zxkqgngiU=;
 b=fWzJRADYpB4ShwEDSrN2WUJHGt/cM+gEq0md100RX+8wkU/pf56Jn9OQ7Z1lm5DLDyhZnp2sPSycsWwxj54AKatD54ade6svLZWKoU7+Yc/LW+PI833VUWe/yipTgakSU6ojQeNOjbLptwDTgrNcNj52GAtrDWSH51e331bJs5/KCI1q/3QuZvinlMZJZMtWDJeQAhqFZgk8smevwMfALNX1c6gpXNF2mM5OjIy4dhH/f0YAoFJnepHMUndhJcgetcyHq2Ma/2lTRk3A3m8YKAbj/pTT3vJHpIC3/d6bE2CPSvYLN1VOJyrgNqX/a5bL2CNxnhOHNfu+j5Co95so3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyazO1v1Rst24xDF8S1Nz/nJoqT+ynATv8zxkqgngiU=;
 b=NMen1L7p7UBiCrh0y7vauIDbIDarkQ36mwolOdUxGH4hxSqmkMvQozoEap2Tmba2y3FgcSEC4/20DA8Bcfhb08FxOKqlSq0Rc+JL4hUmVoI9JoC1RbOOhQIXPqFNZNqB4tOoh5ZSjRDyKmYDs9GgejFzNOOhXvmu0O3x0lYIn+Y=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2872.namprd12.prod.outlook.com (20.179.91.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 18:41:04 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:41:04 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arch/arc: fix some Kconfig typos
Thread-Topic: [PATCH] arch/arc: fix some Kconfig typos
Thread-Index: AQHV2KHypw3dLUwSbUm57lsiGJ4io6gJ0bWA
Date:   Mon, 3 Feb 2020 18:41:03 +0000
Message-ID: <0cb45863-91b2-66ab-506d-9d8cd6b5c717@synopsys.com>
References: <cbd02a9e-5529-1054-957f-766072496009@infradead.org>
In-Reply-To: <cbd02a9e-5529-1054-957f-766072496009@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cc9d12b-1c28-4e51-6123-08d7a8d89fab
x-ms-traffictypediagnostic: BYAPR12MB2872:
x-microsoft-antispam-prvs: <BYAPR12MB2872E69D08CAFA5DDD462FCAB6000@BYAPR12MB2872.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(6512007)(6506007)(316002)(53546011)(186003)(110136005)(558084003)(4326008)(478600001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(26005)(36756003)(8936002)(31686004)(31696002)(6486002)(2906002)(54906003)(71200400001)(2616005)(81156014)(5660300002)(86362001)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2872;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zpa1HgZKvX151GVD/4KnKOzsf0WLLPUp7xjbMfxGRK0mTF2SBNI9251hctfcActsAvaNjIc9KQUvdjuRvNhhVahPQpK6vdWrjPy6h4xLarhRXS/Ibnmq0lOmk8D5HMo3aNq8ZPa3Drlkivw5tyJySE5OntFAdiKHcCsnNt5xzRB+rB4fdW4GRcV1pXCc2mcLIL1ejZn0hPADvA/MTJQpuOnck+y+hjwbMApvhCimy2D0Lxh1Dgy+kfKTGyQVruwyv/JeQyz4KPxng/wqDjgwj7IHPAa47L4VLFeTNSqyXxH9D2cUWU7gm2oV0NwYCeDK7ZxVPMTvVKQpX4ff0UxDQi8ESsCVfNN7fAvL6YQwvG7NKfh0zemYpHnVk/S8fha/dR0AVMwDsSAHSp9uUZAk0QwdH71hrUu5X5E67i/9KrN8e1A2XRGW1VsO1KVaeEG
x-ms-exchange-antispam-messagedata: EEJRC+oK9P7rnv1z3g2vgI3mbnmWbmmNQazdRH2bJunxgxHTTdW034DJ9fFAjvDLdHrs/mUelC8IXt+V/0C0Ozz1SOrNQuBgWzinLuReemp35d/uCFZbvZE03ktz4ucSXXRw3G88ySc+Y4zeQl12cA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96AD5A90FE50C6419856E197FA7DEA27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc9d12b-1c28-4e51-6123-08d7a8d89fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 18:41:03.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/d3yGqevKJvuhr6YBoytCnMA2VPyrCc0vPv86crSMyLhW0AjNhVFUT9xWbPZoo/NEE2ztRhkzJzXI39kNYIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2872
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMS8yMCA1OjQ5IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IEZyb206IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPg0KPiBGaXggbGFuZ3VhZ2UgdHlwb3MgaW4g
YXJjaC9hcmMvS2NvbmZpZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVu
bGFwQGluZnJhZGVhZC5vcmc+DQo+DQoNClRoeCBSYW5keS4NCg0KQWRkZWQgdG8gZm9yLWN1cnIu
DQoNCi1WaW5lZXQNCg==
