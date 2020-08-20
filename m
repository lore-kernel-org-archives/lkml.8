Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05863207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="x8sJzjCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHTSnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:43:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:37920 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgHTSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:43:21 -0400
IronPort-SDR: xdvgu4FJr+QQ5ziH+viTcoY8/KzY15+T4YNbCWTz9DnWulA4BHl1HU9rCEyUEQdkWSUCL+kJDn
 YTT2PFbg2KVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="240208720"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="240208720"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 11:43:20 -0700
IronPort-SDR: BVz6pYtoPT0JDFge2U3cbJR7Ku4s3ZPEuVXVEn0rIE+3UWLjlLvsbcHxSHGKW9wIPGUhoIwOHn
 TEo07lQ2eKcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="293579572"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2020 11:43:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 11:43:17 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 11:43:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 20 Aug 2020 11:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOQCFwrS+XatWD8NCKpeoU27YWA8WE4Wvnb6l9tP4Do/odQfR1904MuZOAHushXMi279cl8oLH83GxUuLagMJdrRc29hWxsg2Ihl7e96RahnJGgEQnj6lCkKrrwPQWudyRnsIMW6uW59SGtGpoylUPskDufmCtz36ZrKMNchr1HzRbOx87rWmwsNqgloVsbGsaDiYBaV7pscD9xl/g6c3H82Jg6Cxru7EtfhKTEXkgGy8PqS1QRZavaTAYToNqK7Tt8SSQDxyeXfm5QSIPPRo9mo7K/3h9c0dOoW6H/bSZFDzN9Af6K+4pVDFqLDfFMJ52qoaWsENFHVuLB+ld9gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg4Idkj7Du7d7AJUiJGQBo5enbJHrkYh+IzJN+s7LvI=;
 b=dKUxQxCtS4aIWRJ5Ab4je3EvcdTuRoWtAVi/O5lyHlHVYmzwZuyQBTREjG8AMcHT2vMlO1t1vjjcxNL19lazhdNw9zqKr+DIej9Vyl9R+qdzyKJExj4cVsyDI+4aw40mmOxeWXO+L/aMmau7usUTOI3cmzYrzhkWIt6lKEpcey1IQfGuHZH9XP+KtbND5Bvs5nrm8/0A7J3+KU+jIqsSxuYjhnU9odP7PmfK1l5yOl3KvoXUY8rOPIuQrntcpQhud2Lw5aMEQ0AtU3viPPoHfE3ymaKPB420XLO4irCcJnckyNUylUCbnuZZqKxis7CEL4NT3Yq9aedtoeYoviWdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg4Idkj7Du7d7AJUiJGQBo5enbJHrkYh+IzJN+s7LvI=;
 b=x8sJzjCSsc0xiBDVXgcrz+sJBmoSG8qFlTd55VlCLA6C2zVjuTjY5zhl7/9suNoMDh+7YhvynmyYxyCtnvt0WTZK3bqlgoVkdiCA6rbBJOs60043OrQtRIYWmg1UVRarwvicTAQZcvVblhi0P7WVmh1hL6xuoupjoIo8PmSLHG4=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB2774.namprd11.prod.outlook.com (2603:10b6:a02:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 18:43:10 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7%6]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:43:10 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: FSGSBASE causing panic on 5.9-rc1
Thread-Topic: FSGSBASE causing panic on 5.9-rc1
Thread-Index: AQHWdlOaEZ0YyP9OxUGfkNFdu56IAKk/vf6AgAAzyICAADFJgIAA+HaAgAAC/YCAADhWgA==
Date:   Thu, 20 Aug 2020 18:43:10 +0000
Message-ID: <5D0385FC-D535-457A-A0D9-E5F013F301BE@intel.com>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
 <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice>
 <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
In-Reply-To: <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ba1fdd-8c0d-4c49-e6bd-08d84538e33c
x-ms-traffictypediagnostic: BYAPR11MB2774:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB277484ECADB7EB660B84BF9AD85A0@BYAPR11MB2774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOWGX2wo7/h2x8AXoHZGmeRVNibFAwNpbR65EDPHZJnW/1AHIF1EcuCwI9jeDTJNCE7SPFbIyAKbr3MYaBVEnYZH9qhxs6FWhcB2lQp7FWik1JZxhYxW/UcRGIZEvIkS7DCG9/Aso0vaoomlfW0++5Q2vSyJyzZSZu6vHUAhnP+W8wyzOwFDJeHSSsQbuTz/KawNmITeLCTe2ffS8Lc74WLG9aVLEIR9IPfr6uNU3mGzFr1M6EkAUcbaEX2XF09wW6PzK1W7j1U1KjDymJFDlzbk7lIocxF5MZWr2kWPIl0tnXZGd9Y4xJqUlPrt4CKY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(2906002)(66446008)(316002)(64756008)(66946007)(66556008)(71200400001)(86362001)(66476007)(5660300002)(6486002)(76116006)(6512007)(4744005)(26005)(6916009)(36756003)(186003)(478600001)(53546011)(8936002)(54906003)(33656002)(7416002)(107886003)(4326008)(8676002)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VP/KD8r46PGijifRsp/+Oah/rcE8/SaRTvygPNllcYYxUDYpZu9EpVjuLuMmEvxvuHmytzrvo6LtpAYlAxQ+g8dU/z4qPFem/wMmoDEMjP3GH0lYQuPEHd0H/fJIzTLr9qliag7ipJuovhOFtI/5U9DalXUovgJvmDoLUn07NPyuTJ1oH2fBm0OMqycQpBsOKB6sNjxO4g4tIbvUNnO86ZZNLwQKfFsonBe5omoE9UrRxPNvlOJ+Le20H6vPsAQGay4nmoVatn8bT+/M+dLNgUFYY67URMlYRKe2rUtYQ98bpkEjyo3NQmlQ8AtJjZpdWzBURE6vkDKmP9KJZi/WSiKqe+8Da1zbsQMhWtr36yh3+nlW/vRzmH+LuU18/Rb+F/oUmHjVLWqZeI6ioQd4kg3fjWI+nNojlELHjd9/nQ5xMHbJckFQaQof3Xs7Cd2g88JmExoFqiQKJQiN7g0Uk6jfj9Q1gWIvbfCPF56G84pvRMegOTiVJesRO7sL/WPt5W8sSsA15QPjNuDLcBFsz5Xy1x+MWdtNGEbufQ2tEL2GI5WBAKiHz//NSohdvFhHJKVANeRIGcB5/rRuWswCf0qsYWRFipeu3cFwzEBKLQK4st7IleiQ1SEwjqwOccBXSjW5AhRzuBs3X4y9jJ/gGA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72FC2BC180CFE74998EA790EAA6D1DF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ba1fdd-8c0d-4c49-e6bd-08d84538e33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:43:10.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyO7ViY+cOiQdhpar4k2YLHbrSpjAMAw4QBC7Q3k+1siq4q8aD+rEMu1cJutdBzPutce7T/0WG6Z/Kw8xQpXYBw1ZIingsWcKhaIcjgn8wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2774
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 20, 2020, at 08:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> On 8/20/20 10:10 AM, Sean Christopherson wrote:
>>=20
>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
>> 	current_save_fsgs();
>=20
> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the curre=
nt->thread.gsbase value to a new variable in the svm struct. I then used th=
at variable in the wrmsrl below, but it still crashed.

Then, current->thread.gsbase is from __rdgsbase_inactive() which is
user GSBASE.

If you do the wrmsrl below, it overwrites the current GSBASE with the=20
user value.

>> 	wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);

Thanks,
Chang=
