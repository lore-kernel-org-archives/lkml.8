Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B850BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DE120700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NT12wP7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgDXP1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:27:40 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13546 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587742058; x=1619278058;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zrR+KCbhcERLGcAyFjOWLjy9cTa3gPlVudTF1SAPosk=;
  b=NT12wP7Br6Tv5jaKayQPEPFiRPlvUI1LOFAKSOpV09S+Pbhn4B6ThsOp
   BmSvzqkxB6uU7HagZWKf3pAcFEce6qIqCqWPPUyOBBzCt/bdgKUUDVifs
   KoAJyWpi/NbhNI/FfDcX9MpWGg1NskFDu5TQ5oQhneEB/0e4g7vXdFG+4
   0=;
IronPort-SDR: d5YU5XmWm7K3rszI5VmhjEGREmeuIwcxc339x1V9gX2qEiNjR1Zq8WWaJbI+iIE64imCEzgunC
 0g2dnEWtziWg==
X-IronPort-AV: E=Sophos;i="5.73,311,1583193600"; 
   d="scan'208";a="27489379"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Apr 2020 15:27:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D6102A1E29;
        Fri, 24 Apr 2020 15:27:20 +0000 (UTC)
Received: from EX13D16EUB003.ant.amazon.com (10.43.166.99) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 15:27:20 +0000
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.161.52) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 15:27:13 +0000
Subject: Re: [PATCH v1 14/15] nitro_enclaves: Add Makefile for the Nitro
 Enclaves driver
To:     kbuild test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, Anthony Liguori <aliguori@amazon.com>,
        "Benjamin Herrenschmidt" <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Frank van der Linden" <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        "Martin Pohlack" <mpohlack@amazon.de>, Matt Wilson <msw@amazon.com>
References: <20200421184150.68011-15-andraprs@amazon.com>
 <202004231644.xTmN4Z1z%lkp@intel.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <c7469263-fd17-1fd5-46b2-27d212de61e8@amazon.com>
Date:   Fri, 24 Apr 2020 18:27:07 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202004231644.xTmN4Z1z%lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.52]
X-ClientProxiedBy: EX13D03UWA004.ant.amazon.com (10.43.160.250) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2020 11:43, kbuild test robot wrote:
>
> Hi Andra,
>
> Thank you for the patch! Perhaps something to improve:

Fixed in v2.

Andra

>
> [auto build test WARNING on linus/master]
> [also build test WARNING on linux/master v5.7-rc2 next-20200422]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Andra-Paraschiv/Add-supp=
ort-for-Nitro-Enclaves/20200423-130814
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 18bf34080c4c3beb6699181986cc97dd712498fe
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=3Di386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     In file included from include/linux/device.h:15:0,
>                      from drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c=
:22:
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c: In function 'ne_subm=
it_request':
>>> drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:80:9: warning: format '=
%ld' expects argument of type 'long int', but argument 3 has type 'size_t {=
aka unsigned int}' [-Wformat=3D]
>              "Invalid req size=3D%ld for cmd type=3D%d\n",
>              ^
>     include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_f=
mt'
>      #define dev_fmt(fmt) fmt
>                           ^~~
>>> include/linux/dev_printk.h:167:3: note: in expansion of macro 'dev_err'
>        dev_level(dev, fmt, ##__VA_ARGS__);   \
>        ^~~~~~~~~
>     include/linux/dev_printk.h:177:2: note: in expansion of macro 'dev_le=
vel_ratelimited'
>       dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
>       ^~~~~~~~~~~~~~~~~~~~~
>>> drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:79:3: note: in expansio=
n of macro 'dev_err_ratelimited'
>        dev_err_ratelimited(&pdev->dev,
>        ^~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c: In function 'ne_retr=
ieve_reply':
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:121:35: warning: form=
at '%ld' expects argument of type 'long int', but argument 3 has type 'size=
_t {aka unsigned int}' [-Wformat=3D]
>        dev_err_ratelimited(&pdev->dev, "Invalid reply size=3D%ld\n",
>                                        ^
>     include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_f=
mt'
>      #define dev_fmt(fmt) fmt
>                           ^~~
>>> include/linux/dev_printk.h:167:3: note: in expansion of macro 'dev_err'
>        dev_level(dev, fmt, ##__VA_ARGS__);   \
>        ^~~~~~~~~
>     include/linux/dev_printk.h:177:2: note: in expansion of macro 'dev_le=
vel_ratelimited'
>       dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
>       ^~~~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:121:3: note: in expan=
sion of macro 'dev_err_ratelimited'
>        dev_err_ratelimited(&pdev->dev, "Invalid reply size=3D%ld\n",
>        ^~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c: In function 'ne_do_r=
equest':
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:193:9: warning: forma=
t '%ld' expects argument of type 'long int', but argument 3 has type 'size_=
t {aka unsigned int}' [-Wformat=3D]
>              "Invalid req size=3D%ld for cmd type=3D%d\n",
>              ^
>     include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_f=
mt'
>      #define dev_fmt(fmt) fmt
>                           ^~~
>>> include/linux/dev_printk.h:167:3: note: in expansion of macro 'dev_err'
>        dev_level(dev, fmt, ##__VA_ARGS__);   \
>        ^~~~~~~~~
>     include/linux/dev_printk.h:177:2: note: in expansion of macro 'dev_le=
vel_ratelimited'
>       dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
>       ^~~~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:192:3: note: in expan=
sion of macro 'dev_err_ratelimited'
>        dev_err_ratelimited(&pdev->dev,
>        ^~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:203:35: warning: form=
at '%ld' expects argument of type 'long int', but argument 3 has type 'size=
_t {aka unsigned int}' [-Wformat=3D]
>        dev_err_ratelimited(&pdev->dev, "Invalid reply size=3D%ld\n",
>                                        ^
>     include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_f=
mt'
>      #define dev_fmt(fmt) fmt
>                           ^~~
>>> include/linux/dev_printk.h:167:3: note: in expansion of macro 'dev_err'
>        dev_level(dev, fmt, ##__VA_ARGS__);   \
>        ^~~~~~~~~
>     include/linux/dev_printk.h:177:2: note: in expansion of macro 'dev_le=
vel_ratelimited'
>       dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
>       ^~~~~~~~~~~~~~~~~~~~~
>     drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c:203:3: note: in expan=
sion of macro 'dev_err_ratelimited'
>        dev_err_ratelimited(&pdev->dev, "Invalid reply size=3D%ld\n",
>        ^~~~~~~~~~~~~~~~~~~
>
> vim +80 drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c
>
> 0ed609272739ee Andra Paraschiv 2020-04-21  42
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  43  /**
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  44   * ne_submit_request - Sub=
mit command request to the PCI device based on the
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  45   * command type.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  46   *
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  47   * This function gets call=
ed with the ne_pci_dev mutex held.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  48   *
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  49   * @pdev: PCI device to se=
nd the command to.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  50   * @cmd_type: command type=
 of the request sent to the PCI device.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  51   * @cmd_request: command r=
equest payload.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  52   * @cmd_request_size: size=
 of the command request payload.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  53   *
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  54   * @returns: 0 on success,=
 negative return value on failure.
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  55   */
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  56  static int ne_submit_reque=
st(struct pci_dev *pdev,
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  57                        enum=
 ne_pci_dev_cmd_type cmd_type,
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  58                        void=
 *cmd_request, size_t cmd_request_size)
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  59  {
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  60   struct ne_pci_dev *ne_pci=
_dev =3D NULL;
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  61
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  62   BUG_ON(!pdev);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  63
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  64   ne_pci_dev =3D pci_get_dr=
vdata(pdev);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  65   BUG_ON(!ne_pci_dev);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  66   BUG_ON(!ne_pci_dev->iomem=
_base);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  67
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  68   if (WARN_ON(cmd_type <=3D=
 INVALID_CMD || cmd_type >=3D MAX_CMD)) {
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  69           dev_err_ratelimit=
ed(&pdev->dev, "Invalid cmd type=3D%d\n",
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  70                            =
   cmd_type);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  71
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  72           return -EINVAL;
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  73   }
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  74
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  75   if (WARN_ON(!cmd_request))
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  76           return -EINVAL;
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  77
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  78   if (WARN_ON(cmd_request_s=
ize > NE_SEND_DATA_SIZE)) {
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21 @79           dev_err_ratelimit=
ed(&pdev->dev,
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21 @80                            =
   "Invalid req size=3D%ld for cmd type=3D%d\n",
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  81                            =
   cmd_request_size, cmd_type);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  82
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  83           return -EINVAL;
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  84   }
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  85
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  86   memcpy_toio(ne_pci_dev->i=
omem_base + NE_SEND_DATA, cmd_request,
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  87               cmd_request_s=
ize);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  88
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  89   iowrite32(cmd_type, ne_pc=
i_dev->iomem_base + NE_COMMAND);
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  90
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  91   return 0;
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  92  }
> 08a5a524ab0b6c Andra Paraschiv 2020-04-21  93
>
> :::::: The code at line 80 was first introduced by commit
> :::::: 08a5a524ab0b6c939997c8d44b4d07e5ee97e91d nitro_enclaves: Handle PC=
I device command requests
>
> :::::: TO: Andra Paraschiv <andraprs@amazon.com>
> :::::: CC: 0day robot <lkp@intel.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org




Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar=
 Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in R=
omania. Registration number J22/2621/2005.

