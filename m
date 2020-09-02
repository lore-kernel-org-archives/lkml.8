Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFA32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FGJ4cngg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBIIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:08:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:61970 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBIIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:08:09 -0400
IronPort-SDR: 6MmkG1eYLvY4xIcGhxEzzlZ+n/KrIgQEESM1HCpjO67qY03MISTr+8zkHofF+i/7K3t3V4kgi+
 w7cCoirfx95g==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="242168118"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="242168118"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 01:08:06 -0700
IronPort-SDR: l587vt9oR3DkJX5XcAWCiL+vK5dHiIkq56gRFCVVK8HgFd1pQdRe/IIclgivKIVyOLM9A7AJJa
 uLAckmraF4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="331347559"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2020 01:08:06 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Sep 2020 01:08:05 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Sep 2020 01:08:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 2 Sep 2020 01:08:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Sep 2020 01:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWI8YJvLhnyy7lbYVM4KKas6lAXzsGnfc/MrOfbh1Y25WswqDixfJU3JGzZICl9XwKVL+GO2HGAQvNZLTvVIGVLQG2iJDZh5KN/GG5v3F+f10PLtFbEICaW86fBOY83Bvb3FDp4XLhfWpCG/b6z2JvWSvEegeacFNNhKnekNqOZpeTPK90pMlJdqHWNrs/D5fir3vHuBB3U9fJaFA/Ubsvm36ZYp+tvILhVPCZ+koB8Oeq0s38ZMr5XVwhhoxwvDgT++REHrFMne/w3RA+GT3RrIfx2QZGeViqJNcvbF4kAgro6uJhgNxi+irQ3XL4InHsowWOfKANr/dYvR/tI1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl2g68nSnn5liJaijSMRaFDVMX7I2U+/Fgu8HUu1Acw=;
 b=DfE0lquccF4v9Awfqkb/8LWzC3ouvW5TUxYglUKBQRS6tmelSkzW0mu/hpO+9anGYiNhZwVfumhAaPPPdg0H3xg/3p1y0SKdoKwnl6NX6XtbydrTGNfy0BkZaKdwQbLwj7CQWzpElnY7RSX23L5rnFHWXZg1SArk+mkYicejoMOktaSPIW/U7W/0m9Ux5KbvNCrKVE+48vaZJzheMNfiv2b8AM5NBiwww+hJRPH3v+5+s4PEtUEOXG4qkBVL8RHdLkkk3ZR/IP7GPu8dMhprcr1qu1ruA20Ts8CCR1sAwWgGVLDwe/Q3BAbj+JQPLjReCKNGidKwYJ5nJ/Sujdmy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl2g68nSnn5liJaijSMRaFDVMX7I2U+/Fgu8HUu1Acw=;
 b=FGJ4cnggwny/g0dygcV25O00kXQ+HhJxBxFb3yjU6XgGMRlek6+6iPXF+er8OSJDDJ8Sv4O7awvIy2ooFEePcJ0WVoqhMtgZ3Tr8K6iDprccLaNSYv0+v5WaOWf//wpWIJoDUh58QB0gf0GAP8AFm2BVstxHSZs61oy4ksIbGCc=
Received: from MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 08:07:28 +0000
Received: from MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00]) by MWHPR11MB1613.namprd11.prod.outlook.com
 ([fe80::c075:135f:66a3:cf00%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:07:28 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Leo Yan <leo.yan@linaro.org>, lkp <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: RE: [kbuild-all] Re: include/asm-generic/qspinlock.h:94:9: sparse:
 sparse: context imbalance in '__msm_console_write' - unexpected unlock
Thread-Topic: [kbuild-all] Re: include/asm-generic/qspinlock.h:94:9: sparse:
 sparse: context imbalance in '__msm_console_write' - unexpected unlock
Thread-Index: AQHWfzBc6NdaYy5SM02hSOvychdzNalVAIIw
Date:   Wed, 2 Sep 2020 08:07:28 +0000
Message-ID: <MWHPR11MB16130694AD99D997B7120128E52F0@MWHPR11MB1613.namprd11.prod.outlook.com>
References: <202008290845.9m3df1TL%lkp@intel.com>
 <20200831004636.GB4715@leoy-ThinkPad-X240s>
In-Reply-To: <20200831004636.GB4715@leoy-ThinkPad-X240s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d3d3b0a-2dba-4196-dc12-08d84f173c26
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45887687F4B7CDF88539BB14E52F0@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vt0PUcHwdHrjL/3uYNwP3rpBTH1ec3Kppwv/7ZKq+v+1uxfUgd0bpNR+F0dU53bMdjaaHhTvW7jtPIYo95MtMpV8wH+og4mEeogbhg8FNIKLbqPJW76f1RblaPkp7FYN6uOu/Qudf19jJ1w8l/E46Iv8dOYeZ64tHZjj/e4c6hUZcQNTfjozs8Yh/ZfU0JJecALM3P8Dry0wHyxM/E/1dUIyzLVqnJROUH7CK52rBQ/OWr3WsH04L22q8aQU4Ly7YjTN7FDUarZpMRyRhioN9k+EO27jtHg03RdvrD5H42zgs+oJeUdvJYkoGsV1XLb6qNRT5ISK+hTpUUNLIq+OUKzLx1Dyb/7JFaS8V3vIZaWoEnUJ8HB+ahVIvJQRD3pBy1OV7KDktjDAPPJNY8A1woKRwzJhGTqDAmJb7frhLeDtAKovjW8TwwkcxnTVLlA0XXidYzzf8X3jX3kC2TQKMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(9686003)(7696005)(966005)(8936002)(5660300002)(316002)(86362001)(33656002)(54906003)(478600001)(110136005)(55016002)(6506007)(2906002)(8676002)(4326008)(66556008)(66946007)(64756008)(6636002)(26005)(83380400001)(76116006)(71200400001)(66476007)(83080400001)(186003)(52536014)(66446008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ArZeg/eTLqzQ9ih2jJl+ia9/hZDfjV37Rf/NMiWyoqqBthQe+OcqfY9CjO9T7qhL2AnUG6S8ZlajbMdpGR+mdLAVugP5AN1NASNI2y34J4rrcXc9ul5BOPs0beNLvPGNwsWc4br5V3bMFdWJbbKroz2FswzLt9BbVhXIl5fJSdfTzssSdgh4xlmbx30mYRy/sbkgUFYR3ChQvLr4SoQdMPs8iwmIIYJoorhi74Ts6gkcpIqz4tYg4/xT1fy0vejFD8oI8Q5GbRONIRQ5/1iCP7eMcIS9je+ctccOAgnlt96QUURd68Dc7xlOyMWJy5CEiQsBev33ZLwRAiSwRb8TvGHJqz8azXi65UwrJaKWoqrr/0HNNIVvHOalQKh6dRMKfHR+tnZJq0hd6sM2kxjgIZAFoq9tSujnrlBjquDkh6PyL1TbHX5f3/IaM7dMuctb2jYt8cQm2pbGKgAN7xdq3uAQ8PhhACW3+vHIfhj8dTZEsPQbufikGMr2KVzJi9wOfENVOXDQr3EKkUSFD/4uwp3N4Ekm1VIW4oV2Es0jKPTuQs0VFgR1GN+Dp414pZGFKI8n+SNex4LUq+sOhTHMZw4NTvVZVl9AkjgglalcBoNrC5DeAIzkPBJx1CdFxIX8X0++Cs2edle0/+mJ/mgojA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3d3b0a-2dba-4196-dc12-08d84f173c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 08:07:28.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRZjbnEVXTlYAtX+yS0YvPBNC1Jd5z6ZLx/xcl7y0zrT49YZK5EMrHkABxwyc35tV8xnI7TnrXjisRbo1HAsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Leo Yan <leo.yan@linaro.org>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B31=1B$BF|=1B(B 8:47
>To: lkp <lkp@intel.com>
>Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-Hart=
man
><gregkh@linuxfoundation.org>; Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
>Subject: [kbuild-all] Re: include/asm-generic/qspinlock.h:94:9: sparse: sp=
arse:
>context imbalance in '__msm_console_write' - unexpected unlock
>
>Hi,
>
>On Sat, Aug 29, 2020 at 08:27:03AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   005c53447a63cbce10de37406975a34d7bdc8704
>> commit: 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e tty: serial: msm_serial=
:
>Fix lockup for sysrq and oops
>> date:   9 months ago
>> config: arm64-randconfig-s031-20200829 (attached as .config)
>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-
>tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # apt-get install sparse
>>         # sparse version: v0.6.2-191-g10164920-dirty
>>         git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cro=
ss
>> C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Darm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>    drivers/tty/serial/msm_serial.c:736:25: sparse: sparse: context imbal=
ance in
>'msm_handle_rx_dm' - unexpected unlock
>>    drivers/tty/serial/msm_serial.c:802:28: sparse: sparse: context imbal=
ance in
>'msm_handle_rx' - unexpected unlock
>>    drivers/tty/serial/msm_serial.c:1100:12: sparse: sparse: context imba=
lance in
>'msm_set_baud_rate' - unexpected unlock
>>    drivers/tty/serial/msm_serial.c: note: in included file (through
>arch/arm64/include/generated/asm/qspinlock.h,
>arch/arm64/include/asm/spinlock.h, include/linux/spinlock.h, ...):
>> >> include/asm-generic/qspinlock.h:94:9: sparse: sparse: context
>> >> imbalance in '__msm_console_write' - unexpected unlock
>
>I think this is a false positive report.  Let's see the locking relevant c=
ode in
>__msm_console_write():
Hi Yan,

Thanks for the clarification. Please ignore this report.
It was sent out unexpected. We will fix the robot bug soon.

Best Regards,
Hui
>
>  __msm_console_write() {
>
>      int locked =3D 1;
>
>      [...]
>
>      if (port->sysrq)
>          locked =3D 0;
>      else if (oops_in_progress)
>          locked =3D spin_trylock(&port->lock);
>      else
>          spin_lock(&port->lock);
>
>      [...]
>
>      if (locked)
>          spin_unlock(&port->lock);
>  }
>
>Since we need to handle oops and sysrq as special cases, it uses 'locked' =
to
>indicate the spinlock has been acquired and later will release spinlock if=
 'locked' is
>true.  So locking and unlocking are paired and I don't see what's the reas=
on the
>robot reports the context imbalance.
>
>BTW, this report is not only for msm_serial driver, it also might be appli=
ed to
>many other serial drivers, e.g.
>
>  drivers/tty/serial/amba-pl011.c
>  drivers/tty/serial/xilinx_uartps.c
>  drivers/tty/serial/stm32-usart.c
>
>Maybe I miss something at here, if so please let me know.
>
>Thanks,
>Leo
>
>> #
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
>> mit/?id=3D0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>> git remote add linus
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> git fetch --no-tags linus master
>> git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>> vim +/__msm_console_write +94 include/asm-generic/qspinlock.h
>>
>> a33fda35e3a765 Waiman Long 2015-04-24  83
>> a33fda35e3a765 Waiman Long 2015-04-24  84  #ifndef queued_spin_unlock
>> a33fda35e3a765 Waiman Long 2015-04-24  85  /**
>> a33fda35e3a765 Waiman Long 2015-04-24  86   * queued_spin_unlock - relea=
se
>a queued spinlock
>> a33fda35e3a765 Waiman Long 2015-04-24  87   * @lock : Pointer to queued
>spinlock structure
>> a33fda35e3a765 Waiman Long 2015-04-24  88   */
>> a33fda35e3a765 Waiman Long 2015-04-24  89  static __always_inline void
>> queued_spin_unlock(struct qspinlock *lock)
>> a33fda35e3a765 Waiman Long 2015-04-24  90  {
>> a33fda35e3a765 Waiman Long 2015-04-24  91  	/*
>> ca50e426f96c90 Pan Xinhui  2016-06-03  92  	 * unlock() needs release
>semantics:
>> a33fda35e3a765 Waiman Long 2015-04-24  93  	 */
>> 626e5fbc143589 Will Deacon 2018-04-26 @94
>	smp_store_release(&lock->locked, 0);
>> a33fda35e3a765 Waiman Long 2015-04-24  95  }
>> a33fda35e3a765 Waiman Long 2015-04-24  96  #endif
>> a33fda35e3a765 Waiman Long 2015-04-24  97
>>
>> :::::: The code at line 94 was first introduced by commit
>> :::::: 626e5fbc14358901ddaa90ce510e0fbeab310432 locking/qspinlock: Use
>> smp_store_release() in queued_spin_unlock()
>>
>> :::::: TO: Will Deacon <will.deacon@arm.com>
>> :::::: CC: Ingo Molnar <mingo@kernel.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
