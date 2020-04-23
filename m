Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09472C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D595920728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lZXzQ4Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgDWTCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:02:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:29120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDWTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:02:53 -0400
IronPort-SDR: mkyphmrfGl+oqGzp/Da1pVAYA2H6j6zjbokkMewQTHooFpieXzXHkg/3HLMKFFElpK+3+1bdQB
 RgpwsX0fa0cQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 12:02:30 -0700
IronPort-SDR: 6qjWUcLDuRNWk07ZY5wLL3O4kwm2EdR/iuwXs9NtWIuRR9bRY3xe+4SPAREdsPQpaOTsJ5ABLW
 N9DZnvG7YCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="244968730"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2020 12:02:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 12:02:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 12:02:29 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Apr 2020 12:02:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 12:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YumLd8kS6fle3Qb0yIIfWn6B2WSmmzC462GbYewnFPp7VmSaKAkYGIaLsYG4jql1Y8MlHR/BePMRjpj+YfPzRR1BhnDjAW0TVN2IPKrOl3MYEF3whYreM/pw1NZb1CLuscV7X13W/OH0v8nivkvU4XrN2JutU47f5jZ6aF/2Gw2Rl/5+to9lKsrjEciwpbQs6GFoPa6sCI0x8SU3ShC6GCVWhCKCodNanWACVgBwFYumaF13Z0bO+130/IKa/VztokgMCOEKGRbVcDVU+QL5Y8DVfdnM/0ZxCX6D7xy1qh+oI4Pclmo3LBMIaNajhun/AauFJXzjgMLvKabyzzaZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IyNvJzZZTPYu4+kj5OO1me8658RSPg34P0wehq6ZBg=;
 b=U33lV0jBKMfM5yC3eiL0R4evJF5Dmz4HjWcvNGuejeMFHwb58Jg6cBAsynqOAINdzOMrjO4JQIS1MDgtya9rT9YEpODbzKAL9UqWS0y/qNey06r/N4//YIdfXUBAOCpXP/qELTXliXPiAJPtHaC5ChnbDr/ZVkvzyz87jMexo0YaVQ8iK1yELt1lWHsadq4M6Uvy3sEqDpTnMFU/TRf3cIFY3AG3egq9ViizI5xgvuNiNkHb4OR4jNkh5Ufvbr5rJVYMX+jxkNcscS3vMz+P3C8LNgkUurwts2xopoIpPfwWxdI9QrBH89OsfbMRNBkKIEUsrbuCC3Lm4w7pGE/gHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IyNvJzZZTPYu4+kj5OO1me8658RSPg34P0wehq6ZBg=;
 b=lZXzQ4JrWgSzZbbhZAvjIyjepp5oq0NUObm452HnTblVI5Oy0TFqMnvuHy1a1B394M/qe+tsdYLCLYw2UJBRvg4ouvBL+TyPNapbFBiKBRTVOSo5gKVx11X9BTJJ8S/3V9yPuFhLHcbUmGkxSjbvhbWGPZ5PFPpAns/15V6vVlU=
Received: from DM5PR11MB0074.namprd11.prod.outlook.com (2603:10b6:4:69::24) by
 DM5PR11MB1321.namprd11.prod.outlook.com (2603:10b6:3:9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Thu, 23 Apr 2020 19:02:26 +0000
Received: from DM5PR11MB0074.namprd11.prod.outlook.com
 ([fe80::18be:129d:8094:c863]) by DM5PR11MB0074.namprd11.prod.outlook.com
 ([fe80::18be:129d:8094:c863%5]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 19:02:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] x86/mm/cpa: Flush direct map alias during cpa
Thread-Topic: [PATCH] x86/mm/cpa: Flush direct map alias during cpa
Thread-Index: AQHWGR2JdXhQ7JnV8U++PcWYNeR/4aiGY6kAgACtj4A=
Date:   Thu, 23 Apr 2020 19:02:26 +0000
Message-ID: <f1c60f169231ecf65facb9b6c1af96ef75a0eb78.camel@intel.com>
References: <20200423031355.23955-1-rick.p.edgecombe@intel.com>
         <20200423084114.GS20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200423084114.GS20713@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rick.p.edgecombe@intel.com; 
x-originating-ip: [134.134.139.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2c9d658-7deb-44f5-670d-08d7e7b8dd48
x-ms-traffictypediagnostic: DM5PR11MB1321:
x-microsoft-antispam-prvs: <DM5PR11MB1321DD5CB6B0042F3E6D5EFAC9D30@DM5PR11MB1321.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(71200400001)(478600001)(316002)(5660300002)(6506007)(4326008)(86362001)(81156014)(6512007)(36756003)(8936002)(8676002)(186003)(26005)(54906003)(6486002)(2616005)(91956017)(2906002)(6916009)(558084003)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFIJfsAV51caFrbCc7J40SOBZ8gw0a7QdwsPVnczKhNV0h17EViOyDXsFkcdj2cRqopZAFpb6rcbuT5cSelhut/J9K3kfZmQM1/Bq5lcgv6zDS2kI6vlJ+/Y7SVI7EsN8iIP6JstmnCYiaa/agZnSxoe/rBtlWef+J4SM09Uo47q2tlMFZjR1VGhzrRVajUNJD4mnKXF9ubF/m+ylf3I4SR9uEUymSc0tEqbsaxx2BUburpsfmambXSfjSzmmy6IUzNDa7HH/QkKk7vve4iY1baspwHZ/sQqXOGr9ROStqcbkFbRMUpAzruOAEKWBe2GpONjb/X6NXNr/PDZrbAlCP+eAFWPvQ3vGjJ6SK0GAIp8Wl4P2UCqiffjt2BIgDbUwRYw9EGUkYEPctSJPXEc2wGwa0XfaF2O4qYJLuLBqz40L8vWKjPMC/mWVWBHBLL9
x-ms-exchange-antispam-messagedata: 66Qz0LY18t69NCiF/hR3yiqtUwFadNFpmzw9aZfC7Tc9PzczHpqK3LAISGxly58UGKLbJQiXvqWnlp/Gdt0rv9KxC1k1WNYGhjxFeCIqz29UzuJKnIbjIg0cHjN5s+QnjvlVsKLGVGgyLlmTXc2DfQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB6ACEE20B12234581E85A7DC9BDEB4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9d658-7deb-44f5-670d-08d7e7b8dd48
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 19:02:26.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aTefP/8Nxz6J7EtWhVWGTw2/9GkSOTyZQ8JZS78TQZdaIAGoq+x35djDEffHhH37OvDusNWZ4y7WJDkhncvgrh4QrYIWtixA3ZzBFjxd2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1321
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTIzIGF0IDEwOjQxICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gV291bGRuJ3Qgc29tZXRoaW5nIGxpa2Ugc28gbWFrZSBtb3JlIHNlbnNlPw0KDQpZZXMuIERh
dmUgaGFkIGNvbW1lbnRlZCBvbiB3aGV0aGVyIGEgc21hbGxlciBmaXggd291bGQgYmUgYmV0dGVy
IGZvcg0KYmFja3BvcnRzIGlmIG5lZWRlZC4gU2luY2UgdGhhdCBkaWZmIGlzIHRoZSB3aG9sZSBm
aXgsIGRvIHlvdSB3YW50IHRvDQp0YWtlIGl0IGZyb20gaGVyZSBvciBzaG91bGQgSSBwdXQgaXQg
aW4gYSBwYXRjaD8NCg==
