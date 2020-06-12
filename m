Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E523C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DB62065C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cn026Ehg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLMUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:20:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48529 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLMUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:20:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200612122009euoutp013742d4e8e3448d8c3fd7d2b9af4ef837~XyzIlokQM1489114891euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200612122009euoutp013742d4e8e3448d8c3fd7d2b9af4ef837~XyzIlokQM1489114891euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591964409;
        bh=yML2HjAqUrRoPVVkme5efN7lLsQCcJAVzK4lojagUAA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cn026EhgO1mrfbkU70PVdAXQhl/9eTpNV9whN/FzfkQDS/w59Ve8et0lrsqGcbvnX
         4cU1B6LnfJCVyHbjKk1JkT1l+q+dVQD8bzYCmf8idWxyKqy44uV8bJuKt2h8PWq3zS
         G6h5Wagh8BUyOgWDeW0o+/TWjyaEgJ4M/3VHe6hk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200612122009eucas1p1d53c0de18be00fb8d52f9a0c978585da~XyzIfh8Rt0759607596eucas1p1w;
        Fri, 12 Jun 2020 12:20:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.D3.61286.9F273EE5; Fri, 12
        Jun 2020 13:20:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200612122009eucas1p11e484ab0757e6a499cddc3c44bbad4be~XyzIIcS7Q2002420024eucas1p1Y;
        Fri, 12 Jun 2020 12:20:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200612122009eusmtrp19675e49cc6f74e1f69cb15c878bbb944~XyzIH40x72903729037eusmtrp1d;
        Fri, 12 Jun 2020 12:20:09 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-f4-5ee372f998b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.CA.07950.8F273EE5; Fri, 12
        Jun 2020 13:20:09 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200612122008eusmtip2663f6529b942ff4467eb77d2950bf39c~XyzH034Ne0030400304eusmtip29;
        Fri, 12 Jun 2020 12:20:08 +0000 (GMT)
Subject: Re: include/linux/libata.h:1366:2: note: in expansion of macro
 '__ATA_BASE_SHT'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <70e6cefd-20f7-7e5f-918f-3bcb721b9a66@samsung.com>
Date:   Fri, 12 Jun 2020 14:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202006121548.ZOvLuAVk%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7o/ix7HGTy8Kmax+m4/m8XK1UeZ
        LM52X2O0uLxrDpvFq+ZHbA6sHov3vGTyuHy21KN79j8Wj903G9g8Pm+SC2CN4rJJSc3JLEst
        0rdL4Mp49bms4HxAxek9q1kaGG87dDFyckgImEjcejKdsYuRi0NIYAWjxNNZ95khnC+MEo1L
        +lkgnM+MEgu3PGfrYuQAa5nT4wzSLSSwnFHieXcBRM1bRolza7uYQBLCAlES37+/YgexRQRU
        JXY8XAYWZxaolNi+spMNxGYTsJKY2L6KEcTmFbCTaJtznwXEZgGqf3FpKjOILSoQIfHpwWFW
        iBpBiZMzn4DVcAoYSXxe94oNYqaBxJFFc1ghbHGgd+ZD7ZKXaN46G+wbCYF57BIrl39jg/jZ
        ReJLxwEoW1ji1fEt7BC2jMTpyT0sEA3rGCX+dryA6t7OKLF88j+oDmuJO+d+QdmOEs96drNA
        goVP4sZbQYjNfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZX186VzBMYlWYh+W0Wkn9mIflnFpJ/
        FjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMN6f/Hf+0g/HrpaRDjAIcjEo8vAYJ
        j+OEWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS
        1OzU1ILUIpgsEwenVAPjguutb28XxyV5eOxcpGN/2nDOvC/xRne+bOi6ZyZ7Km/t5ItL5UP7
        bn5Psvz1QrSefZdI0/aI19EVYUkyClJLPI+f5Q/XCBL7KM+kZyrTvuO19E9vuWNzrvkLy94+
        +UDIQSdq5a7d805/6Bf6uZGJ1fvC92rfV15zzRYw+K7UqNxXevT3koVPlFiKMxINtZiLihMB
        0uhkWjMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7o/ix7HGbSVWay+289msXL1USaL
        s93XGC0u75rDZvGq+RGbA6vH4j0vmTwuny316J79j8Vj980GNo/Pm+QCWKP0bIryS0tSFTLy
        i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Ml59Lis4H1Bxes9qlgbG
        2w5djBwcEgImEnN6nLsYuTiEBJYySrxe/Y0ZIi4jcXx9WRcjJ5ApLPHnWhcbRM1rRokfzxcx
        giSEBaIkvn9/xQ5iiwioSux4uIwJxGYWqJTY1drPCNHQyijx/sUhsASbgJXExPZVYM28AnYS
        bXPus4DYLEDNLy5NZQaxRQUiJA7vmAVVIyhxcuYTsBpOASOJz+tesUEs0JPYcf0XK4QtLnHr
        yXyoxfISzVtnM09gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cT
        IzCyth37uWUHY9e74EOMAhyMSjy8HUmP44RYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQf
        X1Sak1p8iNEU6LmJzFKiyfnAqM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBa
        BNPHxMEp1cCo+bKJSX112ulKp0ty998FP0uX3vJGbr1qm2bwhyV6mk//+kdFPb0Uryz5Mpdp
        rpqAjhynuEvX1aAszqtzD3tcbHWqnb8y23df2Rovzt2efr7mM+4frD9mXKSw02eu5cJ5WdeE
        TmlnZ2YxsSpXzuiS9hPjkeXb4f62rWt/yZWfWq83iPt9+KXEUpyRaKjFXFScCADcswMmwgIA
        AA==
X-CMS-MailID: 20200612122009eucas1p11e484ab0757e6a499cddc3c44bbad4be
X-Msg-Generator: CA
X-RootMTR: 20200612080537eucas1p241be7d826607e41fcc122003c8e63ad4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200612080537eucas1p241be7d826607e41fcc122003c8e63ad4
References: <CGME20200612080537eucas1p241be7d826607e41fcc122003c8e63ad4@eucas1p2.samsung.com>
        <202006121548.ZOvLuAVk%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/20 9:58 AM, kernel test robot wrote:
> Hi Bartlomiej,

Hi,

> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
> commit: 6f09eae3b5d974ef845e56690d6bc2b8f2a70acd ata: expose ncq_enable_prio sysfs attribute only on NCQ capable hosts
> date:   3 months ago
> config: i386-randconfig-r011-20200612 (attached as .config)
> compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> reproduce (this is a W=1 build):
>         git checkout 6f09eae3b5d974ef845e56690d6bc2b8f2a70acd
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> In file included from include/linux/linkage.h:7:0,
> from include/linux/kernel.h:8,
> from drivers/ata/ahci_platform.c:11:
> include/linux/export.h:19:30: warning: initialized field overwritten [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_platform.c:40:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: (near initialization for 'ahci_platform_sht.can_queue') [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_platform.c:40:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: initialized field overwritten [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_platform.c:40:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: (near initialization for 'ahci_platform_sht.sdev_attrs') [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_platform.c:40:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> --
> In file included from include/linux/linkage.h:7:0,
> from include/linux/kernel.h:8,
> from drivers/ata/ahci_ceva.c:10:
> include/linux/export.h:19:30: warning: initialized field overwritten [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: (near initialization for 'ahci_platform_sht.can_queue') [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: initialized field overwritten [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> include/linux/export.h:19:30: warning: (near initialization for 'ahci_platform_sht.sdev_attrs') [-Woverride-init]
> #define THIS_MODULE ((struct module *)0)
> ^
> include/linux/libata.h:1346:14: note: in expansion of macro 'THIS_MODULE'
> .module   = THIS_MODULE,                    ^
>>> include/linux/libata.h:1366:2: note: in expansion of macro '__ATA_BASE_SHT'
> __ATA_BASE_SHT(drv_name),         ^
> drivers/ata/ahci.h:383:2: note: in expansion of macro 'ATA_NCQ_SHT'
> ATA_NCQ_SHT(drv_name),           ^
> drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro 'AHCI_SHT'
> AHCI_SHT(DRV_NAME),
> ^
> 
> vim +/__ATA_BASE_SHT +1366 include/linux/libata.h
> 
>   1338	
>   1339	/*
>   1340	 * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
>   1341	 * by the edge drivers.  Because the 'module' field of sht must be the
>   1342	 * edge driver's module reference, otherwise the driver can be unloaded
>   1343	 * even if the scsi_device is being accessed.
>   1344	 */
>   1345	#define __ATA_BASE_SHT(drv_name)				\
>> 1346		.module			= THIS_MODULE,			\
>   1347		.name			= drv_name,			\
>   1348		.ioctl			= ata_scsi_ioctl,		\
>   1349		ATA_SCSI_COMPAT_IOCTL					\
>   1350		.queuecommand		= ata_scsi_queuecmd,		\
>   1351		.can_queue		= ATA_DEF_QUEUE,		\
>   1352		.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
>   1353		.this_id		= ATA_SHT_THIS_ID,		\
>   1354		.emulated		= ATA_SHT_EMULATED,		\
>   1355		.proc_name		= drv_name,			\
>   1356		.slave_configure	= ata_scsi_slave_config,	\
>   1357		.slave_destroy		= ata_scsi_slave_destroy,	\
>   1358		.bios_param		= ata_std_bios_param,		\
>   1359		.unlock_native_capacity	= ata_scsi_unlock_native_capacity
>   1360	
>   1361	#define ATA_BASE_SHT(drv_name)					\
>   1362		__ATA_BASE_SHT(drv_name),				\
>   1363		.sdev_attrs		= ata_common_sdev_attrs
>   1364	
>   1365	#define ATA_NCQ_SHT(drv_name)					\
>> 1366		__ATA_BASE_SHT(drv_name),				\
>   1367		.sdev_attrs		= ata_ncq_sdev_attrs,		\
>   1368		.change_queue_depth	= ata_scsi_change_queue_depth
>   1369	
> 
The above warnings produced by gcc-4.9 are very misleading, gcc-5.4
(Ubuntu 5.4.0-6ubuntu1~16.04.11) produces much more descriptive ones:

  CC      drivers/ata/ahci_platform.o
In file included from drivers/ata/ahci_platform.c:21:0:
drivers/ata/ahci.h:384:16: warning: initialized field overwritten [-Woverride-init]
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:384:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: warning: initialized field overwritten [-Woverride-init]
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
  CC      drivers/ata/libahci.o
  CC      drivers/ata/libahci_platform.o
  CC      drivers/ata/sata_dwc_460ex.o
  CC      drivers/ata/ahci_ceva.o
In file included from drivers/ata/ahci_ceva.c:15:0:
drivers/ata/ahci.h:384:16: warning: initialized field overwritten [-Woverride-init]
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:384:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  .can_queue  = AHCI_MAX_CMDS,   \
                ^
drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: warning: initialized field overwritten [-Woverride-init]
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^
drivers/ata/ahci.h:388:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  .sdev_attrs  = ahci_sdev_attrs
                 ^
drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
  AHCI_SHT(DRV_NAME),
  ^

Also it turns out that this is an old issue and not a regression
introduced by commit 6f09eae3b5d974ef845e56690d6bc2b8f2a70acd
("ata: expose ncq_enable_prio sysfs attribute only on NCQ capable
hosts").

Anyway, it should be fixed by:

https://lore.kernel.org/linux-ide/0d803e72-b15e-4673-4858-4741f2772fc4@samsung.com/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
