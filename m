Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607532083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEHOjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:39:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2573 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgEHOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:39:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49JXz34r4XzB09bD;
        Fri,  8 May 2020 16:39:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id K-HNgrLJ7kOc; Fri,  8 May 2020 16:39:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49JXz33yrlzB09bJ;
        Fri,  8 May 2020 16:39:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A0B8D8B7D0;
        Fri,  8 May 2020 16:39:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ycy5w0eULPyS; Fri,  8 May 2020 16:39:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B01E58B767;
        Fri,  8 May 2020 16:39:28 +0200 (CEST)
Subject: Re: arch/powerpc/kernel/entry_32.S:450: Error: bad expression
To:     kbuild test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202005081830.QR5IP9B2%lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f808d366-70bd-23e1-ee57-735a876e73b2@csgroup.eu>
Date:   Fri, 8 May 2020 16:39:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005081830.QR5IP9B2%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/05/2020 à 12:07, kbuild test robot a écrit :
> Hi Christophe,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   79dede78c0573618e3137d3d8cbf78c84e25fabd
> commit: feb8e960d780e170e992a70491eec9dd68f4dbf2 powerpc/mm: Fix CONFIG_PPC_KUAP_DEBUG on PPC32
> date:   2 weeks ago
> config: powerpc-randconfig-r035-20200508 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout feb8e960d780e170e992a70491eec9dd68f4dbf2
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>

Following patch fixes it:
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/ea599546f2a7771bde551393889e44e6b2632332.1587368807.git.christophe.leroy@c-s.fr/

Christophe
