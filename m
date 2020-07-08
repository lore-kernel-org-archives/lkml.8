Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2996C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC59220775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="erblRfxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgGHHy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:54:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:63630 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGHHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:54:57 -0400
IronPort-SDR: fv/JKpcZkvoELF/6b0gH4PR4o9bFnKsGZg5/7Q4JhASSaQxM+TU5iVfgzjeMwchuKYwoW6zv8l
 8qJ4QfBrvbHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149267150"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149267150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:54:57 -0700
IronPort-SDR: G1EOCTgv6ivdainfMXJ36jZjJrd0igJpiHzS5fB6MFjLWm9DM/yQghxLuLQFaLO6rELLdqINov
 PvyMA6W+JMJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="483804832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2020 00:54:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jul 2020 00:54:56 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jul 2020 00:54:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jul 2020 00:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRkMrjeI552kJv8xrPNX15TaRodAgolvwMufVj5FzI7p0AXYgX6FZFnvsvnlU6ZM027jfGpe6wNh1IBmqJa+nHwW+i/1B9AnwUd19jMIGZUOcjAYaT04/4P5hu4+A9nQMSPIjPr3VS00JnKmBOT9ALW4YABCCuVt+n5PWwF1zCd2hrKZGO8MX++YGJnK+tdaNVlgj/miJOYyGRenX0EuBet/izEbmbDvzWVIEJHVlOVhnJ23IVuFW78EsiOO95hHkIotnVMoD/LSICBBsU9zh1YsIqjuNaqRAyKxx+Gayjc/tqSSbXmCiK/RTgw96dKt0+saMJUyhPIsrzd4X12HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgqXqw3kZr6eWO/G9sA0puEdZse+fVUIVXokdmWTbC4=;
 b=h5JUKLYsGSrnNVrp4YvJV4d0cqqRiK8TkHC1xhnJhUxzVNs4w0yWJHQu9ryoUlzzKQWnbK4GdU9Rvx4ZGKqvb7kDbnmHwzF8gl3q+8PQhEE3pI3Zm2J7NxhFJNCOoVARww4o0BlBdINNvOwOGdevvalHCitusOqeEl9tiTt76BdZ4FmaGmtZ3l5c5mHNuGeKGyBS5HjITBBRA/2qyaj9nOhAGUc/5WXbcaq22A8za9Jl3Ovx5F8U2fTqGqXF4tKNMEl/TYjPONAwvYLsV+0Bv7UxgBlbet79Nu65cDp44FY14nOhF8PcVRF5nTrywN8nb8Iy1RSEvhvf5NzDT6TI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgqXqw3kZr6eWO/G9sA0puEdZse+fVUIVXokdmWTbC4=;
 b=erblRfxH4iPzP5bdz9Por78eKzHW49+0rveA87hT/CxSVjW2WIGKobds4rSuXnYi0UjeaOTYLdPPmNzyl/JWhzaF3NUzv6o0s7lRuGQh24SE4cIoWp8mNP4IIplz8VhDDNXLusZvtpH5PSSGzw7Hc8WMgNUoIReaIehrbxVMIEY=
Received: from MN2PR11MB4064.namprd11.prod.outlook.com (2603:10b6:208:137::18)
 by MN2PR11MB3726.namprd11.prod.outlook.com (2603:10b6:208:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 07:54:51 +0000
Received: from MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::453b:72cf:dc13:cd6e]) by MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::453b:72cf:dc13:cd6e%7]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 07:54:51 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Peter Xu <peterx@redhat.com>, lkp <lkp@intel.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] Re:
 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse: struct kvm_vcpu
 Documentation Kbuild Makefile crypto include sound usr <asn:3>
 kvm_get_running_vcpus( ... )
Thread-Topic: [kbuild-all] Re:
 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse: struct kvm_vcpu
 Documentation Kbuild Makefile crypto include sound usr <asn:3>
 kvm_get_running_vcpus( ... )
Thread-Index: AQHWUNUwohyM0crwK0SxoUz9kQPpxqj9Vi+g
Date:   Wed, 8 Jul 2020 07:54:50 +0000
Message-ID: <MN2PR11MB406475936030EF8A40464EF3E5670@MN2PR11MB4064.namprd11.prod.outlook.com>
References: <202007021746.jJj16Pl8%lkp@intel.com>
 <20200703005840.GC6677@xz-x1>
In-Reply-To: <20200703005840.GC6677@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0514720f-1bea-47b0-77bb-08d82314318f
x-ms-traffictypediagnostic: MN2PR11MB3726:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3726E2EAFF02146056C36A23E5670@MN2PR11MB3726.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3t5nKgW84n2WqF5srf2+vU1k/HkdYq6rVBQNax+sFN8665ttrAQWwj0zqma9rKrC18I7/Dp1ZGmPSO8q6OmcnYah0LqGvd1QR1cUAMR1BEfitvAlYRBFMiKeWjTxylmCSN4XVgEvBuUV+5NSDcHXZdv3U4ClSAPsMMb1VIESfLyeU/mNkGQAf/Yzh9d/X8JCPBp7xlGGq1WYTLrwQZtF275QsZVqTLSWz0gwFCT/k3ZA0edtlChTC63oV93cL20w48dmnlIx5cuwJuUDHKBRDIe21GM5u8ZRebUO+eR/KjMefMmjmqNKA4dfIhyh9ix+Rc6oMbjszIv+MGH/7Gh24zQGlvg9Lrb/gSo/w/PD2Zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(52536014)(55016002)(76116006)(966005)(26005)(9686003)(83380400001)(66946007)(6506007)(7696005)(54906003)(66556008)(186003)(316002)(110136005)(66446008)(6636002)(66476007)(86362001)(64756008)(478600001)(33656002)(5660300002)(2906002)(8676002)(8936002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KJ/hnTYs4bd12mQQQq0EmrxpIXuj3nLkQcExwFfYOfo6dIsNCpmhvoYe3GK0d3s60U9QUP3HLw0EWeHLz/vJR9nj8CsNeBCWuIBUUWJJPMjWBHlJ42LcOzm7yMCQ12xyfH0fLUslN3blBdJIecVywB1QkLV0EzwQBgEejkm1xkll1GQbkPNEaxpyYoS/WqYGtLKPd0Gr6sD+OrqVglEMEy34B1H5fMVMZe1rb9euWCkiurYVUVgLUrLY7W/eGSJd8Wq9XjuD5J6IGUpXLGQCFIgKC8aIv6FdfwSgsZeGgvec5Pc0GjskKFwIEWDkytYk5ZqVsTQpkOnHrEPtoiTGHt8yqSZzf2JynQl+8dY90aeRSiIClw5UfyHod3EyJeRgSaKj2GkrhwFLtQrsCV+CTqOCdGnZLBXbAC0PrwUp6/hOsYEZCQqJrrpw5iCC+sBr6glVrWRfZ3KChXAQciIpNcdsqaHtGdXOHabSYssIYbQBXoFOAyfh2Aq0jadZcuJ7
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0514720f-1bea-47b0-77bb-08d82314318f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 07:54:50.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bId+3Lu2jCH2KzNznKgQw/kVMUokwB0qj15/9qBjbcWOM4MZaUlFowDhwYTU6VWNfcnYkXqnD+E5DioEKzm+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3726
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Peter Xu <peterx@redhat.com>
>Sent: 2020=1B$BG/=1B(B7=1B$B7n=1B(B3=1B$BF|=1B(B 8:59
>To: lkp <lkp@intel.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>; kbuild-all@lists.01.org; linux-
>kernel@vger.kernel.org
>Subject: [kbuild-all] Re: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:1=
7:
>sparse: struct kvm_vcpu Documentation Kbuild Makefile crypto include sound=
 usr
><asn:3> kvm_get_running_vcpus( ... )
>
>On Thu, Jul 02, 2020 at 05:18:48PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   cd77006e01b3198c75fb7819b3d0ff89709539bb
>> commit: 7495e22bb165e7030bae4d9c6e84addb5ea17b29 KVM: Move running
>VCPU from ARM to common code
>> date:   5 months ago
>> config: x86_64-randconfig-s031-20200701 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.2-3-gfa153962-dirty
>>         git checkout 7495e22bb165e7030bae4d9c6e84addb5ea17b29
>>         # save the attached .config to linux build tree
>>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>> ARCH=3Dx86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse: sparse: ca=
st
>removes address space '<asn:1>' of expression
>>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse: sparse: in=
correct
>type in argument 2 (different address spaces) @@     expected struct
>compat_sigset_t const [noderef] [usertype] <asn:1> *compat @@     got void=
 *
>@@
>>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse:     expect=
ed
>struct compat_sigset_t const [noderef] [usertype] <asn:1> *compat
>>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse:     got vo=
id *
>>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse: sparse: sy=
mbol
>'kvm_get_running_vcpus' redeclared with different type (different address
>spaces):
>> >> arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse:    struct
>kvm_vcpu *[noderef] <asn:3> *extern [addressable] [toplevel]
>kvm_get_running_vcpus( ... )
>>    include/linux/kvm_host.h:1339:26: sparse: note: previously declared a=
s:
>>    include/linux/kvm_host.h:1339:26: sparse:    struct kvm_vcpu [noderef=
] <asn:3>
>**extern [addressable] [toplevel] kvm_get_running_vcpus( ... )
>>
>> vim +4326 arch/x86/kvm/../../../virt/kvm/kvm_main.c
>>
>>   4322
>>   4323	/**
>>   4324	 * kvm_get_running_vcpus - get the per-CPU array of currently run=
ning
>vcpus.
>>   4325	 */
>> > 4326	struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
>>   4327	{
>>   4328	        return &kvm_running_vcpu;
>>   4329	}
>>   4330
>
>Not the first time got confused with this report - this seems to have been=
 fixed by
>fcd07f9adc7d ("KVM: let declaration of kvm_get_running_vcpus match
>implementation", 2020-02-28) already...
Hi Peter,
Sorry for inconvenient. Please ignore this report.=20
The wrong report is caused by incorrectly trigger bisection from old base c=
ommit if some branch still based on the old version kernel. We will fix it =
soon. Thanks for reporting this.

--Hui
>
>--
>Peter Xu
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
