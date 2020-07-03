Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89738C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD62207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="WkybO6Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCI56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:57:58 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:45553
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgGCI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UABVl9GBD95oL03GDxYME/Uuf9awABjhjp7OPiqGPyQjKKzKL6hgZqXpm4p6AS8KUVweOeCQNoQWWUnxCddi3gHq5ZcRXt2YN4SlF3A810QY5KPq40y8k0Uzte1Ny52v6orm/vPNiQJ6FkJPq5hqnQ4K0Qvki6MMpjnPx71PRwRqeErOf93lm6JHj8H1oL0AORFex0Y7gzTTZqmDsqhfCSZlk9i/EWYk/ww5iReupeAn+EMRKJ4nzuP79ZOh+v1ZaNvS7tZg+nsB1R6aEw3IYUraoskfoub5a+9hqA37domb0ZF8vKjhSJ1HeON03cngzRMQuX2DS4p7yB/pWJG10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD9dM/lBndTRjz54gPVBIEYWLFiE2W5vOPD4ByKWNSQ=;
 b=DJRsoFvfWGfMT9ISmzYztutP4Q1pLPG0aES5yHEAzC56uEZyXX3eE+9q9KKlxCB0QyBMVggRMwm4WT0k0lIgYOQOKPi1ESEf3BlUexSJxhjc1kVSHJgw+hO8aXqAqiPY/5GAc8RFW8h3uAHeZaSPlECuH5W854dQDxVm45jnNifsQjX+nW0qFHcwH8ZDCHlGFODPege8IlPq5NXk00oSndQyEfIHcqGIn7d4dad47lFZ6tPMEA2m0LtsuUF0sGmVpCa6tGQqNq7FT64MdPApGXRNs8rCIRZOhPEd1+Nu5eOBYfa3Zm4UX4XUu4fQzJM35/WOuwgMfYKqQZw30HGbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD9dM/lBndTRjz54gPVBIEYWLFiE2W5vOPD4ByKWNSQ=;
 b=WkybO6WkshTnaZEesZ/3KQs241MptkSG7YakTkU4VTWAloq5y4O80BPXmFQ6ivj5HXgmCFmsmbRPNwPEjYXhwk4o2UHl/9FRIdJo8T8I3Js3ei5dOwgNtfqU5E1Z3AyuW+gXLw1okAaFyf52OJknFOd60r3EgpehTcGq2M7Kx5Y=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:57:55 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 08:57:55 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "cl@rock-chips.com" <cl@rock-chips.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBrdGhyZWFkOiBEb24ndCBjYW5jZWwgYSB3b3JrIHRo?=
 =?gb2312?Q?at_is_being_cancelled?=
Thread-Topic: [PATCH] kthread: Don't cancel a work that is being cancelled
Thread-Index: AQHWUQOAJajxNwV5lUikAJdXb6GaDaj1dQMAgAAXGwk=
Date:   Fri, 3 Jul 2020 08:57:55 +0000
Message-ID: <BYAPR11MB2632739E5D4E396955CE29CBFF6A0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200702044324.32927-1-qiang.zhang@windriver.com>,<20200703072818.GC11587@alley>
In-Reply-To: <20200703072818.GC11587@alley>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443d7497-5eea-48cd-2928-08d81f2f2d16
x-ms-traffictypediagnostic: BY5PR11MB4260:
x-microsoft-antispam-prvs: <BY5PR11MB4260A65374FE768E53701A1CFF6A0@BY5PR11MB4260.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XpmLX47Pq55SaPwqaJ9oFdSafulWZ/DXmQhSoxuikaZjYRU7EdPjf1cj1GvJTYudz2rPs/pm/jmKhqfOyjXB1ni9PL9JuZDswQIb0A2kt6cLY7UwCHZ6TTWA6ix5i8DpkY/5NIxeN6LGG0UbthB6AEI3W8uZpOuGc2E8TsARz/xjefZ4cYLoVvKrRN2zsGDR7PRzToVfpQzWwjccUa270dvrTOSlsuBodpTDXXAu2Jr1T4mdOgL1g2d/mgqbLDd/dWDreSpd4pqrjnjltupSlyHE01m7tjsKHpgTPLVfJH/sfVMwmt8+MANZ766qXq0KNRSmT19CQZg4DoA0FBPRLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(366004)(396003)(39850400004)(86362001)(54906003)(55016002)(316002)(4326008)(33656002)(71200400001)(9686003)(186003)(7696005)(76116006)(91956017)(26005)(8936002)(66556008)(66476007)(64756008)(52536014)(66446008)(6506007)(478600001)(5660300002)(6916009)(66946007)(2906002)(224303003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lm+3kFHEtzxALImFFJZwXyj/JxpROysObGFdTiRCpJsO9tcnF5wvRlUy8AtUrACbi9a+Z/aHenD66bbyFnPLDMviQnT6xLL5sJ8YbqFpkukEBulXfAx6wHBJsm+iWoKMzytzP5ELTqbMH1qQdiUXjC2twNFHUdlCwgKm7VvYXZ1/EF2c71KPdBsUvz6jnv6r/eYeqvWBLzXtQbFrXhR8t5bLl5M48N0wXJ3dgouDIorSES+UbVp9NuoH4NqMyEwnncex51lVjzltTG7JMBibAFSDXUIjK6cbkr+f3lBA6vYN1txxTJwCHksKbFX9kBjDh+4lt85XQ2gPUXIS+rmK1VhsPrvTjzEG1faUfyav0RYo/pSVzjPReNE6lePqAwVTENVny209hH/UMxgieVRBJPlT8jMeCVe4dtlWz/mq553Bjpt7BVY0OonUOz84i7ngVmDy/JCAGXqYQPpzAskVIEbMTgIR9n6pyszKRJSUxEQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d7497-5eea-48cd-2928-08d81f2f2d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:57:55.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUi7Xrsc2XFMR7cxmMLPIIs4mdUnJ5ra9DhzdjpYz5roimRpVJ2qM0bObRzymcj1CYy00nZjUOHgyzlhCx9kt9foU9Y0F6USCC+h8iAOarg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIGFkdmljZSwgICBpZiBhZGQga3RocmVhZF9jYW5jZWxfd29yaygp
IHdpdGhvdXQgdGhlICJfc3luYyIKaXQgaXMgYmUgZGFuZ2Vyb3VzLCBCdXQgSSB0aGluayBpdCBp
cyB1bm5lY2Vzc2FyeSB0byBjYW5jZWwgIHdvcmsgd2hpY2ggaXMgYmUgY2FuY2VsaW5nLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogbGludXgta2VybmVs
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9y
Zz4gtPqx7SBQZXRyIE1sYWRlayA8cG1sYWRla0BzdXNlLmNvbT4Kt6LLzcqxvOQ6IDIwMjDE6jfU
wjPI1SAxNToyOArK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBiZW4uZG9va3NAY29kZXRoaW5r
LmNvLnVrOyBiZmllbGRzQHJlZGhhdC5jb207IGNsQHJvY2stY2hpcHMuY29tOyBwZXRlcnpAaW5m
cmFkZWFkLm9yZzsgdGpAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW
98ziOiBSZTogW1BBVENIXSBrdGhyZWFkOiBEb24ndCBjYW5jZWwgYSB3b3JrIHRoYXQgaXMgYmVp
bmcgY2FuY2VsbGVkCgpPbiBUaHUgMjAyMC0wNy0wMiAxMjo0MzoyNCwgcWlhbmcuemhhbmdAd2lu
ZHJpdmVyLmNvbSB3cm90ZToKPiBGcm9tOiBaaGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJp
dmVyLmNvbT4KPgo+IFdoZW4gY2FuY2VsaW5nIGEgd29yaywgaWYgaXQgaXMgZm91bmQgdGhhdCB0
aGUgd29yayBpcyBpbgo+IHRoZSBjYW5jZWxsaW5nIHN0YXRlLCB3ZSBzaG91bGQgZGlyZWN0bHkg
ZXhpdCB0aGUgY2FuY2VsbGVkCj4gb3BlcmF0aW9uLgoKTm8sIHRoZSBmdW5jdGlvbiBndWFyYW50
ZWVzIHRoYXQgdGhlIHdvcmsgaXMgbm90IGxvbmdlciBydW5uaW5nCndoZW4gaXQgcmV0dXJucy4g
VGhpcyBpcyB3aHkgaXQgaGFzIHRoZSBzdWZmaXggIl9zeW5jIiBpbiB0aGUgbmFtZS4KCldlIHdv
dWxkIG5lZWQgdG8gYWRkIGt0aHJlYWRfY2FuY2VsX3dvcmsoKSB3aXRob3V0IHRoZSAiX3N5bmMi
CndyYXBwZXJzIHRoYXQgd291bGQgbm90IHdhaXQgZm9yIHRoZSB3b3JrIGluIHByb2dyZXNzLiBC
dXQgaXQKbWlnaHQgYmUgZGFuZ2Vyb3VzLiBUaGUgQVBJIHVzZXJzIHVzdWFsbHkgd2FudCB0byBt
YWtlIHN1cmUKdGhhdCB0aGUgd29yayBpbiBub3QgbG9uZ2VyIHJ1bm5pbmcgdG8gYXZvaWQgcmFj
ZXMuCgpXaGF0IGlzIHRoZSB1c2UgY2FzZSBmb3IgdGhlIG5vbi1zeW5jIGJlaGF2aW9yLCBwbGVh
c2U/CgpCZXN0IFJlZ2FyZHMsClBldHIK
