Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28117C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87CD20709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JdSBRO2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHJJ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:28:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:2599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgHJJ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:28:31 -0400
IronPort-SDR: ccq1VdklxOsyfwLdHtMJy17BZsUAYEBUTDfV2sbPYEigm5B5oW1yQitWfrNqQ2GsUV8Odyhnw7
 C93hlaX9IkWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="215019522"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="215019522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 02:28:30 -0700
IronPort-SDR: /2Jp4bEPh+V7KeT1K5ze5iC8VDHbLjj1GWEoHp0YU2+2xvgRlxykNgi5D7tUjn5F3/Nr7TaBUf
 /rd3mzFaoPOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="334172449"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2020 02:28:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 02:28:29 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 02:28:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 02:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhtgAL2Wcz+j+QCy7FCC57cwTnAZbYoVGF9W4GlbQI+P4uMVjsaVIVF3a0E4lBozYK6A/hHSR+DSvaZL0hD3VmTJaXPS1wSeqs0s36eETKPmvzM3HNovUTuqBAudvrHJodUNd4KfbqVzoVnZSZOMY28rj3wLdBqQrmDxAmnbUtJugEEeqafgAt0V96HARBWIPOP/bL3/dulyyqucgkFTVVfVscZjkOYOZ15UcIwCgFS4U3r0TsQGR4koWD15/4D4PZnP2ZnYcISbu6sV4aGtkq3d8IIt4Tx5q8TTLl8uCOSi8HPI5sXwvWSLwHePiXuLl7ww2wHbn6apmdBVS0f3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBAiI2mrUMph0r6/mel2MZKK7T5zT4PWxqXav44D/CM=;
 b=cPFbAW73ZMTqG+B99DlAEpch8rTtsA3LDzM4qh6GtCg4uI7LJ+mGYera1GDBnsWO/tDsNoGrwcjqokQAaSgBqK2eWWXB2Zbi16eKyzJabhySbAr7ATxFRSuiwZeJr67n5ASxh722bTYdQdEHUez1FGFk+pjg3kdua9tfD2k6B0cqthJ6ZV0aGQltP9BnjwerDESxQX6Tyir/tKLROqh4lt/ilXeyYPRJ7NztsEWqKzZ9ZFDQIDRisciup8HmApmcsvmNDEK1B97yh8O6KrEZl2EiVkCeh//x2BsuRtWqDO+FPQ30efJOsCruTR+05hcczzQBOxXHAv4y/7JgXuGmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBAiI2mrUMph0r6/mel2MZKK7T5zT4PWxqXav44D/CM=;
 b=JdSBRO2HOrFHMSRb0LFNNnKt+nZ790Ea/nrMmTWErz0QZjqglmom7H+4Lg/QZreBycLDlZLtEpckDj+KgeNo0ipb2zlgrXJHZ6T2SJg1p5HC5M40mjo3D0jW8WM1IC+delLPLq2XItgKGgy+++6KYSy0UJka9gsq9DbLVahjpDw=
Received: from MN2PR11MB4064.namprd11.prod.outlook.com (2603:10b6:208:137::18)
 by MN2PR11MB4061.namprd11.prod.outlook.com (2603:10b6:208:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 09:28:27 +0000
Received: from MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935]) by MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 09:28:27 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Christoph Hellwig <hch@lst.de>, lkp <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [kbuild-all] Re: fs/init.c:72:8: warning: Variable 'error' is
 reassigned a value before the old one has been used.
Thread-Topic: [kbuild-all] Re: fs/init.c:72:8: warning: Variable 'error' is
 reassigned a value before the old one has been used.
Thread-Index: AQHWbUZqh9dN3DXNf0+0JSI5NuZG1akxFqVQ
Date:   Mon, 10 Aug 2020 09:28:27 +0000
Message-ID: <MN2PR11MB40642475AE2B0194F7BEE9C8E5440@MN2PR11MB4064.namprd11.prod.outlook.com>
References: <202008081143.D8Y8xO2X%lkp@intel.com>
 <20200808054006.GA16706@lst.de>
In-Reply-To: <20200808054006.GA16706@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06da4a88-de85-4c6e-80e6-08d83d0fbcea
x-ms-traffictypediagnostic: MN2PR11MB4061:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB40616AA67906918F9B92E119E5440@MN2PR11MB4061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTrzHQZ3NQGzrZhLE7wOHWeCNIXvwqb8ceTUd2u92lSximhWjX/a0d/eSjpKQVFqXzXkG+/hQDjcXiBG2QnsbSuT3pGFdNiytMxyN/5kKApKzFAyGOuFfrrjPYy4ySzK4bQhCvXbzQdVRmGsXBFuZw3s5/Z8i4rfWPrG0LdZtPSVq58ctgb14fkR5Qoq2kdoS7TkIEwRQ5YkUBZViTM/TnlxpzumbGEUra2lTDlJrN79FocUCcea4sg6LyPIHi6KnPmqo2KkLDZNrTdk9lHxESgXO4+tZ61gQz5t2loqssWznrlNXaJjh1ruJskexqJ0Oequ5Zlz/EbeEbdfWAeI+P3tGRlKF862o0guicQleXBV7bofU20XEf3skqtDjEN0TFW8La/RmUzjouPDXKkcyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(55016002)(110136005)(54906003)(83380400001)(6506007)(7696005)(4326008)(8676002)(33656002)(26005)(9686003)(86362001)(316002)(66446008)(71200400001)(186003)(966005)(6636002)(52536014)(478600001)(66476007)(66946007)(8936002)(76116006)(64756008)(66556008)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rHLPmJsXhkoMUGthPf3F9QSvTaLuTvK9aGwSfsceANHVz3rr3J+37sRyGJtnryo5tkua/CUlGMao3bSL1PDGHd3jts02sUxpLRX+jViifECHudeFcHW7thzmazF572erxDrAkY1r4MEwW6CgIXrpZH5PhRGuLBY4In47rcb1fYUmWv/JIzxuyVKXqS53LBmOZYnnccqmMbNxvBiuWl+2KxCyH0pH2bDhOLiiD5DUy39ibVDhn4Ci5LQrrXLN6NDzCd/utb9xhCwMLis2+pkgNm16MKW25OvOuL9X/QPd6fNJKHN+GuDlSOHJVtt06tSGf+C7b77MtSasLhzfRvNYRgVXuuHFGHyHikmISbREpAsbNmJeApc4aJ9/ICyn3bN9D9zvtGvidNMQ8ptCmce6yCKJCDiSPwdEtUUwl8tzUNvrvy64SVkCNI4vz/KHcBCY3rXT7ZHzCa1KtWZxTsMZiJZ9Z1IoGIAzT6zqCayjT6RpoxL49n09A/kEpgRkiCK1YNcejUKjieII+dDjtgOjOrvZ5i8+Puh5c8gnA/PV+VLycUeQ5thVZM5natjbvfS8c8krjFTOLz6p8TW9ZynjjXuKvVpFf98PhIXF3fZK6RTaMIm3wZtgqzyyDAjnxjaIV4iDGbOL5M5yA59EDHW/mA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da4a88-de85-4c6e-80e6-08d83d0fbcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 09:28:27.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoLxRgNU/qWVpL+SO9RqvXwgTqDGWYm0PbEvGl2K4i+T0Uo9XDwOuMKFWFt7VqECMjsay++0I1BT0CHjpyQRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4061
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Christoph Hellwig <hch@lst.de>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B8=1B$BF|=1B(B 13:40
>To: kernel test robot <lkp@intel.com>
>Cc: Christoph Hellwig <hch@lst.de>; kbuild-all@lists.01.org; linux-
>kernel@vger.kernel.org; viro@zeniv.linux.org.uk
>Subject: [kbuild-all] Re: fs/init.c:72:8: warning: Variable 'error' is rea=
ssigned a
>value before the old one has been used.
>
>On Sat, Aug 08, 2020 at 11:35:45AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
>> commit: 4b7ca5014cbef51cdb99fd644eae4f3773747a05 init: add an init_chroo=
t
>helper
>> date:   8 days ago
>> compiler: hppa-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>> >> fs/init.c:72:8: warning: Variable 'error' is reassigned a value
>> >> before the old one has been used. [redundantAssignment]
>>     error =3D security_path_chroot(&path);
>>           ^
>>    fs/init.c:69:8: note: Variable 'error' is reassigned a value before t=
he old one
>has been used.
>>     error =3D -EPERM;
>>           ^
>>    fs/init.c:72:8: note: Variable 'error' is reassigned a value before t=
he old one
>has been used.
>>     error =3D security_path_chroot(&path);
>
>I really don't understand the warning.  We assign a value to error, if the=
re is an
>error we jump the out labe and return it, or else continue.
>
>That is a pretty common pattern in the kernel.  What do I miss?

Please ignore this report. It is false positive.
We will double check this type of warning in future. Sorry for inconvenient=
.

Thanks,
Hui
>
>>
>> vim +/error +72 fs/init.c
>>
>>     57
>>     58	int __init init_chroot(const char *filename)
>>     59	{
>>     60		struct path path;
>>     61		int error;
>>     62
>>     63		error =3D kern_path(filename, LOOKUP_FOLLOW |
>LOOKUP_DIRECTORY, &path);
>>     64		if (error)
>>     65			return error;
>>     66		error =3D inode_permission(path.dentry->d_inode, MAY_EXEC |
>MAY_CHDIR);
>>     67		if (error)
>>     68			goto dput_and_out;
>>     69		error =3D -EPERM;
>>     70		if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>     71			goto dput_and_out;
>>   > 72		error =3D security_path_chroot(&path);
>>     73		if (error)
>>     74			goto dput_and_out;
>>     75		set_fs_root(current->fs, &path);
>>     76	dput_and_out:
>>     77		path_put(&path);
>>     78		return error;
>>     79	}
>>     80
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>---end quoted text---
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
