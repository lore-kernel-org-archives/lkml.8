Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B53DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E772087C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JbI7aHlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBIDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:03:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:31584 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBID2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:03:28 -0400
IronPort-SDR: kXNguvYwP5gNIlbPPKa+Cfol0aigRkvtRdQYus6+eQt8LtYmj7DkdTxZqwjNwb+/lruE0JQfYs
 K8ljxy7+d1uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="175394977"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="175394977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 01:03:16 -0700
IronPort-SDR: RlBqUYJZFqjFoNIQnzAwyOraIitSpTMjxaecIGmHkxciRpuTiA5h8aHXLJhDFmUmPOrazm/lZU
 5X0JJqbhhPFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="341326136"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2020 01:03:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Sep 2020 01:03:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Sep 2020 01:03:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Sep 2020 01:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO5yAD57AqQKIg1aT8DW3ZJLgrPsdGZTvkgtAy4c8zNFnAceZC+jr3XgEKOumuVU/LCQWHiskcU++mv+b5v0HpOUl8CmdLllRbSrK/JYwqB/n/9G1af5mSBViqLB+GBZ+EyhgEOh5HhPeZ4v5WtEmF8sxJsHJrOGc+WrQr6VCkQck5rq0tudlsccps0arRK+sydFIia5IVNqo/kBwq40u4VMstnC1mWLkpD236aVorPZguKI5fW9zsxAe8v41JraoVcnzb0U6+tlmTDNthwz9LDslaYVYF1UQSu5pXjvDFpE+OMqMTgBKCZ2XzRAvC3m5ZDc7itQhQQ1yhTAgZBDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwZdJOq2UMn881iEJ+sbU++X7aQiaUAdPo1VI3LaZ8E=;
 b=JPo02/qGA1hCJyobNaOX8WVvopq5dtO6hFCHJFYzXcMmvOdkS62Wjgus9jXZkDHBatqC0m8a9Js/pH0RWCvsNVKOP9kdWItx+MVCcmsgkz/+//1BTgkFv72Ox/anXoxSHGRUcH+1jGsnMna3euSrpRhxK5HYV358Y9mQg5rYDrGK0gMqvRrkY+4AMRc6C2VhPtq31d7xW4jIfLowRMEQCRVG+oxuHgN612YNzJznpGpkYaspG0veGTtgv7zGGhivjo8FwO+jA8Z0z22c3BA9OAcdfwLZSMMTG9NKBuecWfZd5v4fgF998dlxJc8guQIhPGW5YAsOckque6zsJv48Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwZdJOq2UMn881iEJ+sbU++X7aQiaUAdPo1VI3LaZ8E=;
 b=JbI7aHlDjFS//7fEuPt1voijdBdDe4EPdOpDphOqSD1abTarClIa7sJvgQ3f5nsEZ0TMjNrboCYLqxBmIqpA3MrFn78n39dTJ3q07FOPrIAQXdepQ3CMP98apvHIfGl1PckX0Z/itXzJMuESPJSGhvOdbmuUwti2Usu/+RHxukw=
Received: from MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 08:02:45 +0000
Received: from MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00]) by MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:02:45 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     lkp <lkp@intel.com>, Leo Yan <leo.yan@linaro.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: RE: [kbuild-all] include/asm-generic/qspinlock.h:94:9: sparse:
 sparse: context imbalance in '__msm_console_write' - unexpected unlock
Thread-Topic: [kbuild-all] include/asm-generic/qspinlock.h:94:9: sparse:
 sparse: context imbalance in '__msm_console_write' - unexpected unlock
Thread-Index: AQHWgPxXATgBMtE3wEKmaNzqApG5ZalU+9aQ
Date:   Wed, 2 Sep 2020 08:02:45 +0000
Message-ID: <MWHPR11MB161334AE3CC0D7801CE544DFE52F0@MWHPR11MB1613.namprd11.prod.outlook.com>
References: <202009021509.cZc8g2w8%lkp@intel.com>
In-Reply-To: <202009021509.cZc8g2w8%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73f456d-c0a4-4954-71ca-08d84f169359
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4588131E787D37E645D01BFEE52F0@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6r+l0P57e+jVU7wAlfZG5VldoX8AtFE3a04JeGd3hxP7o206H9Iaf8nB3JGufKj7V9zGlDhc3TwkKIs67dU468jWK0sBhp+I/TkxXV1G8EzTHgLqadGbObrvTecn8FmCOSTKiMKH66QsHFzgDzd5he3tvX80UoBqGVlIsPcZ5vzLh/MI5i1vnjYLCr2v1hQOAxUhBHzEx+DxCILDo12aiaWk5dUb3filX2ro47EpbH4zty9CzMLBIW1xr9mv/l+4Lt5DHdSnQtNU6x55QKO0RT7pAXvKXAya9AzJXQ11YhISv8QC6GO/AwRtNPzS+lVP8XagbSD5d6j49+BIqHVHxhT9Cok96hpF/ATEK1O+zgO2kBLbfhrAQ9gLbxKPr4c+D5H9TuIrXUgF52UXYg4IX0mDEY8/PX009ZgeorXJtv26cIqzq1NScrtcCQhiLRh6nQwMLDDfKh2lrTENyQHog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(64756008)(66946007)(26005)(8676002)(4326008)(66556008)(83080400001)(66446008)(186003)(52536014)(76116006)(71200400001)(83380400001)(66476007)(966005)(9686003)(7696005)(8936002)(478600001)(110136005)(55016002)(33656002)(54906003)(2906002)(6506007)(5660300002)(86362001)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: l3/HNSb+lo6O0LqfvWemI8+H3YZesKsle0UxeNUUyAvczVY3l6gogJgCz8cI0u3QNBnInCZNSW6LgBfv2qbVL3eyuZUDxdkzsZ2bTVJYYMIA0YPQiLsoTeccrX4/UAjd2m3JYmJ5gjt1U3uldavBU2eCorO6AK+3zSzJoE1vBAUZmjPolWj/LQiUyk/wsKig7syMWofUvYNweXMN5X94Q5OGTYi1re6reYziS42547nhURafuCiCls/ctIA3kwtqzzVCDtjb3nsBDuj4i6vehD/Yb9pcl6P8mX+337BtcRbnRSye2hJZoqbkotZNd4mjSe6npkJIW3XojWuK9xjzIGxPg9Ju3utAshoyNMd0EFRn06yarpjuTfiEHwqWom6Bjz66kuqcSLscPoRG5W8MjpyrVSs+TMiyJdMtlV7zdnfaLBdDiG7YEbWj0TiNMZqP8B98vx2rw4Jm5eykUPbkss+Hs7Zt3C0EZ6dYLyJCh9hBBHhVIlDn724GE+ZziwTfoXFrpGD7g0ErtSQwsPJNltc0W94WT+j2BIIiccP+vLkNPuyA3B0LUXMj3OOLHUWQ5PArUrSWV6v5UFGDVITpDUzI5LQMI4glJPiquPJWp9pBr5s+5f/ei7kULUzX9AQkySyiv2wjzGc5d6LKE2wJJw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f456d-c0a4-4954-71ca-08d84f169359
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 08:02:45.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxtdLrnt4/zo5PRhqs/FOjgTqzboOd3L9BLjuHGmIElgYA0dJla8liQbl+2uzqa9YGsuhQxLhTJLaHS6dsL0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please kindly ignore this mail. It is duplicated.
Sorry for noise.

Best Regards,
Hui

>-----Original Message-----
>From: kernel test robot <lkp@intel.com>
>Sent: 2020=1B$BG/=1B(B9=1B$B7n=1B(B2=1B$BF|=1B(B 15:39
>To: Leo Yan <leo.yan@linaro.org>
>Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-Hart=
man
><gregkh@linuxfoundation.org>; Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
>Subject: [kbuild-all] include/asm-generic/qspinlock.h:94:9: sparse: sparse=
: context
>imbalance in '__msm_console_write' - unexpected unlock
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master
>head:   9c7d619be5a002ea29c172df5e3c1227c22cbb41
>commit: 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e tty: serial: msm_serial:
>Fix lockup for sysrq and oops
>date:   9 months ago
>config: arm64-randconfig-s031-20200829 (attached as .config)
>compiler: aarch64-linux-gcc (GCC) 9.3.0
>reproduce:
>        wget https://raw.githubusercontent.com/intel/lkp-
>tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # apt-get install sparse
>        # sparse version: v0.6.2-191-g10164920-dirty
>        git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cross
>C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Darm64
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>
>sparse warnings: (new ones prefixed by >>)
>
>   drivers/tty/serial/msm_serial.c:736:25: sparse: sparse: context imbalan=
ce in
>'msm_handle_rx_dm' - unexpected unlock
>   drivers/tty/serial/msm_serial.c:802:28: sparse: sparse: context imbalan=
ce in
>'msm_handle_rx' - unexpected unlock
>   drivers/tty/serial/msm_serial.c:1100:12: sparse: sparse: context imbala=
nce in
>'msm_set_baud_rate' - unexpected unlock
>   drivers/tty/serial/msm_serial.c: note: in included file (through
>arch/arm64/include/generated/asm/qspinlock.h,
>arch/arm64/include/asm/spinlock.h, include/linux/spinlock.h, ...):
>>> include/asm-generic/qspinlock.h:94:9: sparse: sparse: context
>>> imbalance in '__msm_console_write' - unexpected unlock
>
>#
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D0e
>4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>git remote add linus
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>git fetch --no-tags linus master
>git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>vim +/__msm_console_write +94 include/asm-generic/qspinlock.h
>
>a33fda35e3a765 Waiman Long 2015-04-24  83
>a33fda35e3a765 Waiman Long 2015-04-24  84  #ifndef queued_spin_unlock
>a33fda35e3a765 Waiman Long 2015-04-24  85  /**
>a33fda35e3a765 Waiman Long 2015-04-24  86   * queued_spin_unlock - release=
 a
>queued spinlock
>a33fda35e3a765 Waiman Long 2015-04-24  87   * @lock : Pointer to queued
>spinlock structure
>a33fda35e3a765 Waiman Long 2015-04-24  88   */
>a33fda35e3a765 Waiman Long 2015-04-24  89  static __always_inline void
>queued_spin_unlock(struct qspinlock *lock)
>a33fda35e3a765 Waiman Long 2015-04-24  90  {
>a33fda35e3a765 Waiman Long 2015-04-24  91  	/*
>ca50e426f96c90 Pan Xinhui  2016-06-03  92  	 * unlock() needs release
>semantics:
>a33fda35e3a765 Waiman Long 2015-04-24  93  	 */
>626e5fbc143589 Will Deacon 2018-04-26 @94  	smp_store_release(&lock-
>>locked, 0);
>a33fda35e3a765 Waiman Long 2015-04-24  95  }
>a33fda35e3a765 Waiman Long 2015-04-24  96  #endif
>a33fda35e3a765 Waiman Long 2015-04-24  97
>
>:::::: The code at line 94 was first introduced by commit
>:::::: 626e5fbc14358901ddaa90ce510e0fbeab310432 locking/qspinlock: Use
>smp_store_release() in queued_spin_unlock()
>
>:::::: TO: Will Deacon <will.deacon@arm.com>
>:::::: CC: Ingo Molnar <mingo@kernel.org>
>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
