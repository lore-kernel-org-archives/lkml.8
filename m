Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDFF207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CqEJtGrN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e/lm9yrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgFPNxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:53:44 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37572 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgFPNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:53:43 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1A3294005F;
        Tue, 16 Jun 2020 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1592315622; bh=Afj37ZNuiqZR4L+HLifkOl2X3F6GKiMEzyVc4gdfv0M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CqEJtGrN6sD+sf8Scf8JAWqRIRpWhzuHCdVkq+SmUl7qL7yleXCKuGhO8djsSgkek
         Jpe7K5VUTt64qi+PvwakM1SzV4ZiEjy7PXWwx+1lcv+PYXTH7mM73P/p/k0RTQxki8
         kakFZxme3d03M+53Oh6M4RvzMvWBdByIOBtKpWRSAK02NrEgsQ5ND5xT6vzOO1rzLx
         VDTc66g53ytlcXrTwGWgCD9VmzZxBNLjXzrcBBkrm6xYv4R4b3HXwzkyfo85C3ju82
         wFqVL3G/Wjzpp2pAfxrkTHSbet7nsCT1uHuMgdgyvdtAnAvTJwUFKKL5ilHCZuOC83
         tepkmbl0C9rvw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9CD2DA0081;
        Tue, 16 Jun 2020 13:53:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3BE60400C5;
        Tue, 16 Jun 2020 13:53:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="e/lm9yrY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5+GE2Rhi1woRPS5tqjKQeV2gKCtoGH4i5bCcKtut3bg1SE9QBAk8I1gZoXNZIUbMB31taOVJuMzxg1z7uIx/Cy+BTj8PGA8luCet4NKbWkgURU+mIojzIcEonCQRGOEYAOGxJ86lLkCzBnXYlWfbcDHO7FHhLYl6JO7h72U5SgDABZZt2kl7ZjRSxLt0bKc1t5Q57rnngIkUVRjqCt8rM8DYEC/kscQi9m9Xulgo1lFcmJT+Evh+Q3B+JeNMV6CUgMrd25Djrma9mdoos9y+X+4xdMgqsK+cKUIEpfBHP6YcogMiI3VaPZlfYgp+U0drEBPdsTWFfe6yrw2fuyu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afj37ZNuiqZR4L+HLifkOl2X3F6GKiMEzyVc4gdfv0M=;
 b=fgeSAEbIcsAlkI6rkdzc8pFjZGS9efuN32FJNPYFvfOfjgE7GCePXHzniqDZtGi4ZUceXnGZyJzoL88wDb5r8nRSD0XXepcwVo2I2iy8fr/QtADITFn9D1/U/0YaxMO2AE2Q2QqU/SnbDHmzQAE47i9Stvn44qf3sZ2FzVEz0xV0Q0RglkcQgB1cqoQDz7ybdXtd0t1pr2l3uXIDBNg0ywIoeXkTEgjaUFJNgjC2QpyY2f4vK5MniD1gxYs1EaB0dAN6z9N8sVqag2HCdTUl+z6L8b+Q6JF5XscoLhLvJa6OoxUyh/kUAOi4Cj8mAxVEs6Zf5IyrcPLKKZODLRnfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afj37ZNuiqZR4L+HLifkOl2X3F6GKiMEzyVc4gdfv0M=;
 b=e/lm9yrYYDQmHN+8llRiDfJZPVeI2h0QFUZAjd6gsT37goFRKUMsB8WW/y97ynXjX4vbv8TtezKMlODyAJO93FChuocrj0h64oYvDwUQU/KOYXNmKnEFX6V0ynayatRL/Tm2YhubN5ZI+Bc/LU/GeKhvna28HpDnRrvnV076S9M=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1384.namprd12.prod.outlook.com (2603:10b6:903:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Tue, 16 Jun
 2020 13:53:37 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3088.029; Tue, 16 Jun
 2020 13:53:37 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Query]usb: dwc2: suspend/resume support for
 DWC2_POWER_DOWN_PARAM_NONE case
Thread-Topic: [Query]usb: dwc2: suspend/resume support for
 DWC2_POWER_DOWN_PARAM_NONE case
Thread-Index: AQHWQ7z/Xja2HTKcEkyRv/tIUExMH6jbQ5UA
Date:   Tue, 16 Jun 2020 13:53:37 +0000
Message-ID: <65502475-28b0-6a27-4494-d642192a599a@synopsys.com>
References: <20200616164712.67bf105c@xhacker.debian>
In-Reply-To: <20200616164712.67bf105c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
authentication-results: synaptics.com; dkim=none (message not signed)
 header.d=none;synaptics.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.92.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f583b59-b8ec-4d0f-716e-08d811fcab6d
x-ms-traffictypediagnostic: CY4PR12MB1384:
x-microsoft-antispam-prvs: <CY4PR12MB138496BCFFDBBB0B7F24677FA79D0@CY4PR12MB1384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBez7K5GAhSuLUc3/8CmAuFwLNqJkvAR7MokeZucQSQ0qP1xslJqrXHSBwt+bTGphkqYNV0yMXgw5YfxxrlGnlcTnF+EN/Ex2pwKGfJnreaa3+YAQmo1KZBMCA/d9QjvRUUkp2OizDvOYm+jfJ5gguwiNtio8OcJ/MJvWr9+41Fo7FAG9VgA5NKnmA4HGJqvmtRKrzcmRV3TJNI//xqBaFog4S/VdRMMuRyRkg4r+tA+6ut9xaUt7TwSCGE+P4+QA7LosCeEPVPHHPEnGUFJuPV0uNFIJc1lXfYz0jkkq1Qw5e6MtT9mXGqu1Ow0ETyLf9INH6TZuUCyPWEk4KaBrc9QIQZWocdzmHr+5MGYWrjtDfFUuh/YVEzAibPamjfx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(316002)(31686004)(8936002)(8676002)(4326008)(54906003)(71200400001)(4744005)(2616005)(110136005)(5660300002)(26005)(53546011)(6506007)(186003)(83380400001)(36756003)(91956017)(76116006)(66946007)(31696002)(64756008)(66476007)(66556008)(6512007)(6486002)(86362001)(15650500001)(478600001)(2906002)(66446008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vctXaha0he26OwUgb0ChdFjw85JGFcWNJT4G6xIP+B+lQ/ZqhNje2CDKrPXGS/0oQdmSo6+e8mnYNHyc5rrhQ1UdQuwXaJigJrvHN3W3wBZRMqD42ADQTc+GwxyyLAM/vtMWvd6eTZfbor9+tBus3A/tnGF1lN5MYwF+Chj1fF3noVXgf7wWSRUJ2ioPFn2xc+yRJOgutR+TFdC7pY30Nc8UBNoE/8MXDJpmGM9sSxdd2HBPmdXxgwBHuesjUO6V4sjLe/qby0EF+Mzeg6P6Bb5cuGqw+lmYK+oRJlusIZw6ZdPxYR3wgnsI7vUDFN3RJb9qglHyCF6shiGFTBWxWdqdqv36R1BRWhNLjnNqMtYrXmqBic8RS5ATp4ABtll0dQNWVI2lF4X70payKW8LIrwRaaxWftopIVHtKS+3ZCmxfNfN9Zbmm/opzuLJ51uYb70+pPiNZhqu1GPALPtoz1tk/06mydDWFBVRSjjM/iQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <47E3780A2CBD7B4CA68AB6441E497E77@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f583b59-b8ec-4d0f-716e-08d811fcab6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:53:37.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhdQOc9lcexnIlQqSNIOYv10TzoPCcEOO8ABewvIJN4IW5e9UjUx3tfqmhYPmsQSysJRsEEVnNHH+GVq60xKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlzaGVuZywNCg0KT24gNi8xNi8yMDIwIDE6MDMgUE0sIEppc2hlbmcgWmhhbmcgd3JvdGU6
DQo+IEhpLA0KPiANCj4gQWZ0ZXIgcmVhZGluZyBjdXJyZW50IGR3YzIgY29kZSwgSSBnb3QgYW4g
aW1wcmVzc2lvbiB0aGF0IHJlc3VtZSBmcm9tIHN1c3BlbmQNCj4gdG8gcmFtIGlzbid0IHN1cHBv
cnRlZCBmb3IgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05PTkUgY2FzZSwgcmlnaHQ/IEluIGZhY3QN
CidyYW0nIERvIHlvdSBtZWFuIG9uIHN1c3BlbmQgc2F2ZSByZWdpc3RlcnMgaW4gUkFNPw0KSWYg
eWVzLCB0aGVuIGluIGNhc2Ugd2hlbiBwb3dlcl9kb3duIGlzIF9OT05FIHRoZW4gbm8gYW55IHJl
Z2lzdGVyIA0Kc2F2aW5nL3Jlc3RvcmluZyB0by9mcm9tIFJBTSBzaG91bGQgYmUgcGVyZm9ybWlu
Zy4NCj4gd2UgZG8gc2VlIHVzYiBkZXZpY2UgY2FuJ3QgcmVzdW1lIHByb3Blcmx5IHdpdGggRFdD
Ml9QT1dFUl9ET1dOX1BBUkFNX05PTkUgY2FzZS4NCj4gDQpJZiB5b3Ugc2VlIGFueSBpc3N1ZSBv
biByZXN1bWUgaW4gbWVudGlvbmVkIGNhc2UgdGhlbiBtb3JlIHByb2JhYmx5IGlzIA0Kc29tZSBh
bm90aGVyIGlzc3VlIHdoaWNoIGNhbiBkZWJ1Z2dlZC4NCg0KPiBJZiB0aGUgaW1wcmVzc2lvbiBp
cyB0cnVlLCB3aGF0J3MgdGhlIHByb3BlciB0ZWNobmljYWwgZGlyZWN0aW9uPyBBZGQNCj4gZHdj
Ml9ob3N0X2VudGVyX3N1c3BlbmQoKSBhcyBkd2MyX2hvc3RfZW50ZXJfaGliZXJuYXRpb24oKQ0K
PiBhbmQNCj4gZHdjMl9ob3N0X2V4aXRfc3VzcGVuZCgpIGFzIGR3YzJfaG9zdF9leGl0X2hpYmVy
bmF0aW9uKCk/DQo+IA0KPiBUaGFua3MgaW4gYWR2YW5jZSwNCj4gSmlzaGVuZw0KPiANClRoYW5r
cywNCk1pbmFzDQo=
