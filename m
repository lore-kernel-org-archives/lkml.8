Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90255C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E5A20709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="kDCKrZMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHJJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:24:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:20194 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJJY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:24:58 -0400
IronPort-SDR: 9NvdSAyRvGeauWti40HggACv/zFmkpBi5kTEV5taSLUy2P0xLBHBmY9ZLFlNHLFc9rXaanSiB8
 8lJ0kekzsaBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="133040769"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="133040769"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 02:24:54 -0700
IronPort-SDR: C1ZZow6AexzpwgwyV3hbMWOQkl88Lx5CpOuYkJIG/vB/pa9MRitxY7PRDHkHG8jgCzJHEp5XAz
 CaMEOtsTjakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="438625047"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com) ([10.22.229.85])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2020 02:24:54 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 02:24:53 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 02:24:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Aug 2020 02:24:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Aug 2020 02:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi7qwe7BNtKnl2G03+P88QuWWaDGIltL7HLIjaSW3Mss/Xy3VMYg/sZsnSAcXYYURmtnn0IPzTKG/lrEZMTLap7ZcAGI9fISif2k8aftVxC+j4jjgcrz7nYJ5+iBWagiRSMqzdFoxQ2hoGEop2rK8l+jE0p0mEjH2HHheHYd3Ejt+zaTYFTEE67lloyUtIpphASTpNYNQ7Ns110TQP30JgMccAn3KaW2r7keK5rUyTJWj/ZL2rU2MSd6Ow1r4PfhdCA3STD431KrajO9duGFI20luFPetp5oJIN4wEb9dY0BtyyBkfeyjFHJzEOiYuN8dyG5VTdnvRZf1Af3asHE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrA6L5KS5jVBD7A8q7gdi6FCewleu7c+yRfGUnZyLPs=;
 b=IfLco+zCODML4vs4sqVBBY28j3t3Mzvfqn5mbvjzq4piDcX6uW+n0u+ZJO7IR5gu5eM2/eS3KrIzabo0FbNEEbfOba0JAXjEPSZdplv/Cjsf2rq5nxKHohegONZQYEeSEiYkMI5QhAkuzc+DKTVHuCq147dlOwNundGKk1KP/FoOk36KsoWn5LTMcGPZmCxvlkZCI4suVQ1V82CgAIKt/aWAxaqyJAxu33SlO3ujFm/XjWPPe1USRUtj+70PrONVdoBSXlcT62j1aNPHG8g9uM0vpqendTFdMKPGvCWA53USZ5O4lJ78ZBaSemAXWd/YP5dNtQBk2q2p9JR6aM8ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrA6L5KS5jVBD7A8q7gdi6FCewleu7c+yRfGUnZyLPs=;
 b=kDCKrZMwKpSWP+nswKHF5TafLrLdjkwZkpGvORGnz/3xuwrXAmvO+0PnJYv9uWLj149n5x0/oK7LD3+Qmcr7DpZHbdbNikTEcdwhTi9u6M0RVLapGPfwQUk31hGPNup9yi2VvHIwzPVHYL+TSpihJwyH4NtTa3Ydi12tYOEsmjU=
Received: from MN2PR11MB4064.namprd11.prod.outlook.com (2603:10b6:208:137::18)
 by MN2PR11MB4061.namprd11.prod.outlook.com (2603:10b6:208:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 09:24:48 +0000
Received: from MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935]) by MN2PR11MB4064.namprd11.prod.outlook.com
 ([fe80::3d54:a596:62dc:d935%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 09:24:48 +0000
From:   "Xia, Hui" <hui.xia@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>, lkp <lkp@intel.com>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: RE: [kbuild-all] Re: fs/fuse/virtio_fs.c:1009:6: warning: Variable
 'err' is reassigned a value before the old one has been used.
Thread-Topic: [kbuild-all] Re: fs/fuse/virtio_fs.c:1009:6: warning: Variable
 'err' is reassigned a value before the old one has been used.
Thread-Index: AQHWbBjPnCClO90EHEWM7VrreCpx8KkxF/nw
Date:   Mon, 10 Aug 2020 09:24:48 +0000
Message-ID: <MN2PR11MB40643691440A2271CC46EA7FE5440@MN2PR11MB4064.namprd11.prod.outlook.com>
References: <202008061415.sHRFePnn%lkp@intel.com>
 <20200806174049.GE367847@redhat.com>
In-Reply-To: <20200806174049.GE367847@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b2ef674-5e32-419c-b8c2-08d83d0f3a73
x-ms-traffictypediagnostic: MN2PR11MB4061:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4061C6FB1DCF7307B2B86529E5440@MN2PR11MB4061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMnE4WnMQy0g4Pj1nJH7iRWH4u2VGsSdJHVMfsG1cuMDH1vnzoCmCzRn5pIoS32CQzewyh34BgSah4ScGTCN8Kb2uoR9n3tDilkk0I5WDmkjI03hN3jawUt/oUMpkeBaRA/gPkKp3XllSou5soc8wf7gQYh1QKzKxL+eqUcUZXp9HkZAuKRk5Dv0WNxsF9D6H5ibFIJzrWF5wMtKygVwSMwaMfZ3I0vseXkyIqXiFLeE/I36jU91uzuFQj+xmhShTuzL26umuk6+Y1eIcKgZGPFhc3LFjUKj0WhDxoT6WiJAYpfif2Ma/5EhuXbUAokJ0gztq2iGZbtuIBTYxr82THBC40f2dobm2/gJjMqsoxpF9mKbGishlmEwGpEOQV5SsIJx8XIQOhbsLdMX/UCLaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(55016002)(110136005)(54906003)(83380400001)(6506007)(7696005)(4326008)(8676002)(33656002)(26005)(9686003)(86362001)(316002)(66446008)(71200400001)(186003)(966005)(6636002)(52536014)(478600001)(66476007)(66946007)(8936002)(76116006)(64756008)(66556008)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5PbODgaCFPWJNiQkzY/ZFwYlFeJVT6yFTN7YbNweZA9/BSzGtju+suttqnbwBXB4UFu11jZZA34oLizchV62Z/z2VKY+452WUNLD/YGjs23O4rse6QuRyx7c0MklVlTBZZXx4o6DH32jygpycVIC73Lwml1Qf2rcvxd1iZS0CmtkFBWAN7RZTBYIrCT5AJX2KMYGT3q+vnEJJkk/XkdUovltO4jo2Sidhcw4V4OIeqMhni19vOS+sI56mb2LHUzDySG0NL7otZltyAE3wxb9st39fj4AE93HUhJREPKmWb29HWmlpjSM3z2HaexJJo+LV9ta451yBklQZxdegkrxubyVvkrBXAEeVl54sQ2Y+oNliqwPcZacAJdKTPFtOy/vqQZu+CHeb+snsvGw63jqXW6ngI9WC8ZtbPIBMSuzsU0FqCFnFRNMV1Si0UJzH8SjAYbfvs8T75ny2CzHVgPZrNY0hsYAK+kxQL7rm6MUgSqrqyuFI37hvdO2VsEppUTsUfQTdjYAGB9vvNDyC81Wz6GM59GhgNQbCaZBPfgxqLR+icmtk5zJ7D39wlvqSxGsnEU3auevXh7yitMaIn1vWMjKPjjmqj+q79vn/lvsRedk/iwLAqaI3J7TTs9oFDpj8g6BzaF6j65q8m4hhiJPTg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2ef674-5e32-419c-b8c2-08d83d0f3a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 09:24:48.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXP9HuUmVLVg9VGGL+Qv7B7BgoosEyQeQmgDQYkNpv5nndYd03tB6qA+d7I34uBlsSUzOLySNvtjGh0SETaJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4061
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Vivek Goyal <vgoyal@redhat.com>
>Sent: 2020=1B$BG/=1B(B8=1B$B7n=1B(B7=1B$BF|=1B(B 1:41
>To: kernel test robot <lkp@intel.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>; kbuild-all@lists.01.org; linux-
>kernel@vger.kernel.org; Miklos Szeredi <mszeredi@redhat.com>
>Subject: [kbuild-all] Re: fs/fuse/virtio_fs.c:1009:6: warning: Variable 'e=
rr' is
>reassigned a value before the old one has been used.
>
>On Thu, Aug 06, 2020 at 02:04:18PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>> head:   fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
>> commit: a62a8ef9d97da23762a588592c8b8eb50a8deb6a virtio-fs: add virtiofs
>filesystem
>> date:   11 months ago
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>> >> fs/fuse/virtio_fs.c:1009:6: warning: Variable 'err' is reassigned a
>> >> value before the old one has been used. [redundantAssignment]
>>     err =3D -ENOMEM;
>>         ^
>>    fs/fuse/virtio_fs.c:1003:6: note: Variable 'err' is reassigned a valu=
e before the
>old one has been used.
>>     err =3D -EINVAL;
>>         ^
>>    fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a valu=
e before the
>old one has been used.
>>     err =3D -ENOMEM;
>>         ^
>>    fs/fuse/virtio_fs.c:1020:6: warning: Variable 'err' is reassigned a v=
alue before
>the old one has been used. [redundantAssignment]
>>     err =3D fuse_fill_super_common(sb, &ctx);
>>         ^
>>    fs/fuse/virtio_fs.c:1009:6: note: Variable 'err' is reassigned a valu=
e before the
>old one has been used.
>>     err =3D -ENOMEM;
>
>Not sure why this is a warning. Previous value is not going to be used any=
more. If
>it were to be used, we would have taken "goto err" path, and return err. V=
ery fact
>that we did not take that path means we are not going to use previous valu=
e of
>err, hence it is ok to override it.
>
>IOW, this seems like a false warning from compiler. This pattern has been =
used in
>fuse and overlayfs code all over the place.

Thanks, Vivek. Please ignore this report.
We will double check this type of warning before send report in future. Sor=
ry for inconvenient.

Thanks,
Hui

>
>Thanks
>Vivek
>
>>         ^
>>    fs/fuse/virtio_fs.c:1020:6: note: Variable 'err' is reassigned a valu=
e before the
>old one has been used.
>>     err =3D fuse_fill_super_common(sb, &ctx);
>>         ^
>>
>> vim +/err +1009 fs/fuse/virtio_fs.c
>>
>>    979
>>    980	static int virtio_fs_fill_super(struct super_block *sb)
>>    981	{
>>    982		struct fuse_conn *fc =3D get_fuse_conn_super(sb);
>>    983		struct virtio_fs *fs =3D fc->iq.priv;
>>    984		unsigned int i;
>>    985		int err;
>>    986		struct fuse_fs_context ctx =3D {
>>    987			.rootmode =3D S_IFDIR,
>>    988			.default_permissions =3D 1,
>>    989			.allow_other =3D 1,
>>    990			.max_read =3D UINT_MAX,
>>    991			.blksize =3D 512,
>>    992			.destroy =3D true,
>>    993			.no_control =3D true,
>>    994			.no_force_umount =3D true,
>>    995		};
>>    996
>>    997		mutex_lock(&virtio_fs_mutex);
>>    998
>>    999		/* After holding mutex, make sure virtiofs device is still there=
.
>>   1000		 * Though we are holding a reference to it, drive ->remove might
>>   1001		 * still have cleaned up virtual queues. In that case bail out.
>>   1002		 */
>>   1003		err =3D -EINVAL;
>>   1004		if (list_empty(&fs->list)) {
>>   1005			pr_info("virtio-fs: tag <%s> not found\n", fs->tag);
>>   1006			goto err;
>>   1007		}
>>   1008
>> > 1009		err =3D -ENOMEM;
>>   1010		/* Allocate fuse_dev for hiprio and notification queues */
>>   1011		for (i =3D 0; i < VQ_REQUEST; i++) {
>>   1012			struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
>>   1013
>>   1014			fsvq->fud =3D fuse_dev_alloc();
>>   1015			if (!fsvq->fud)
>>   1016				goto err_free_fuse_devs;
>>   1017		}
>>   1018
>>   1019		ctx.fudptr =3D (void **)&fs->vqs[VQ_REQUEST].fud;
>>   1020		err =3D fuse_fill_super_common(sb, &ctx);
>>   1021		if (err < 0)
>>   1022			goto err_free_fuse_devs;
>>   1023
>>   1024		fc =3D fs->vqs[VQ_REQUEST].fud->fc;
>>   1025
>>   1026		for (i =3D 0; i < fs->nvqs; i++) {
>>   1027			struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
>>   1028
>>   1029			if (i =3D=3D VQ_REQUEST)
>>   1030				continue; /* already initialized */
>>   1031			fuse_dev_install(fsvq->fud, fc);
>>   1032		}
>>   1033
>>   1034		/* Previous unmount will stop all queues. Start these again */
>>   1035		virtio_fs_start_all_queues(fs);
>>   1036		fuse_send_init(fc);
>>   1037		mutex_unlock(&virtio_fs_mutex);
>>   1038		return 0;
>>   1039
>>   1040	err_free_fuse_devs:
>>   1041		virtio_fs_free_devs(fs);
>>   1042	err:
>>   1043		mutex_unlock(&virtio_fs_mutex);
>>   1044		return err;
>>   1045	}
>>   1046
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>_______________________________________________
>kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an =
email to
>kbuild-all-leave@lists.01.org
