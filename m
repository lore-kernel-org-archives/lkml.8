Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42924C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075072071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PAuI6v0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgDXRBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:01:12 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:27032 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587747671; x=1619283671;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t9+J8wGTi+E0+XxVAYWwswFoFQa4Q8ZnG7aAkmSiPow=;
  b=PAuI6v0d4rCalSjgVf+bZ9W7ZThSfjBBFyeTaelMdED83T5OgBLxBG2D
   iOGl8frDQW5+ggAiM7M71wNnS6CRdoT0CUG2Kt9B4O6vjDD6+Sk7Cq+eu
   jcwFGn+ut283lD/zd20TTQmAOpByeAHuJV0XDJsZUjycFxWpT9ju/49P+
   c=;
IronPort-SDR: oorvYMgBGmedh6UJ7zhX+8aco2ksGnu0F3NsvaLsYtt58cj7MIMT192uvXNRsPnNwuqBMtWXn8
 KhTDxT4aAj/w==
X-IronPort-AV: E=Sophos;i="5.73,311,1583193600"; 
   d="scan'208";a="27169388"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 24 Apr 2020 17:00:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 14427A2258;
        Fri, 24 Apr 2020 17:00:53 +0000 (UTC)
Received: from EX13D16EUB003.ant.amazon.com (10.43.166.99) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 17:00:53 +0000
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.161.203) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 17:00:47 +0000
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
 <202004231636.SiZkUyP0%lkp@intel.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <4100fd51-8b71-cae0-2037-633eb77f8b6a@amazon.com>
Date:   Fri, 24 Apr 2020 20:00:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202004231636.SiZkUyP0%lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D16UWB003.ant.amazon.com (10.43.161.194) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2020 11:12, kbuild test robot wrote:
>
> Hi Andra,
>
> Thank you for the patch! Yet something to improve:

 From what I see, this was triggered by using the uapi KVM header, which =

includesasm/kvm.hand this is not present for parisc arch.

Andra

>
> [auto build test ERROR on linus/master]
> [also build test ERROR on linux/master v5.7-rc2 next-20200422]
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
> config: parisc-allmodconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day GCC_VERSION=3D9.3.0 make.cros=
s ARCH=3Dparisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/uapi/linux/nitro_enclaves.h:21,
>                      from include/linux/nitro_enclaves.h:21,
>                      from drivers/virt/amazon/nitro_enclaves/ne_pci_dev.c=
:26:
>>> include/uapi/linux/kvm.h:14:10: fatal error: asm/kvm.h: No such file or=
 directory
>        14 | #include <asm/kvm.h>
>           |          ^~~~~~~~~~~
>     compilation terminated.
>
> vim +14 include/uapi/linux/kvm.h
>
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10   4
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10   5 =
 /*
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10   6 =
  * Userspace interface for /dev/kvm - kernel based virtual machine
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10   7 =
  *
> dea8caee7b6971 include/linux/kvm.h Rusty Russell          2007-07-17   8 =
  * Note: you must update KVM_API_VERSION if you change this interface.
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10   9 =
  */
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10  10
> 00bfddaf7f68a6 include/linux/kvm.h Jaswinder Singh Rajput 2009-01-15  11 =
 #include <linux/types.h>
> 97646202bc3f19 include/linux/kvm.h Christian Borntraeger  2008-03-12  12 =
 #include <linux/compiler.h>
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10  13 =
 #include <linux/ioctl.h>
> f6a40e3bdf5fe0 include/linux/kvm.h Jerone Young           2007-11-19 @14 =
 #include <asm/kvm.h>
> 6aa8b732ca01c3 include/linux/kvm.h Avi Kivity             2006-12-10  15
>
> :::::: The code at line 14 was first introduced by commit
> :::::: f6a40e3bdf5fe0a7d7d7f2dbc5b10158fbdad968 KVM: Portability: Move kv=
m_memory_alias to asm/kvm.h
>
> :::::: TO: Jerone Young <jyoung5@us.ibm.com>
> :::::: CC: Avi Kivity <avi@qumranet.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org




Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar=
 Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in R=
omania. Registration number J22/2621/2005.

