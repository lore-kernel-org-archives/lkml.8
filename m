Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE55C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BCB20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFLFPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:15:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54454 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgFLFPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:15:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49jpnp5nvYz9v0mr;
        Fri, 12 Jun 2020 07:15:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4R3ERbEzavAN; Fri, 12 Jun 2020 07:15:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49jpnp4Y9Rz9v0mq;
        Fri, 12 Jun 2020 07:15:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCA4F8B77C;
        Fri, 12 Jun 2020 07:15:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RBYjxCbtSQ-e; Fri, 12 Jun 2020 07:15:11 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E81138B75B;
        Fri, 12 Jun 2020 07:15:10 +0200 (CEST)
Subject: Re: arch/powerpc/kexec/core.c:246:29: sparse: sparse: incorrect type
 in assignment (different base types)
To:     kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202006120012.MZ8EDP2d%lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <add1bf7c-c06b-6c85-6154-e520262f4116@csgroup.eu>
Date:   Fri, 12 Jun 2020 07:15:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006120012.MZ8EDP2d%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/06/2020 à 18:01, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b29482fde649c72441d5478a4ea2c52c56d97a5e
> commit: 793b08e2efff3ec020c5c5861d00ed394fcdd488 powerpc/kexec: Move kexec files into a dedicated subdir.
> date:   7 months ago
> config: powerpc-randconfig-s032-20200611 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.1-250-g42323db3-dirty
>          git checkout 793b08e2efff3ec020c5c5861d00ed394fcdd488
>          # save the attached .config to linux build tree
>          make W=1 C=1 ARCH=powerpc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>


That's the second time the robot reports sparse errors on that commit, 
but the only thing I did is move code, that commit didn't add any code, 
so I don't know what I should do about it.

Christophe


> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> arch/powerpc/kexec/core.c:246:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_base @@     got restricted __be32 [usertype] @@
>     arch/powerpc/kexec/core.c:246:29: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_base
>     arch/powerpc/kexec/core.c:246:29: sparse:     got restricted __be32 [usertype]
>>> arch/powerpc/kexec/core.c:248:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_size @@     got restricted __be32 [usertype] @@
>     arch/powerpc/kexec/core.c:248:29: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_size
>     arch/powerpc/kexec/core.c:248:29: sparse:     got restricted __be32 [usertype]
>     arch/powerpc/kexec/core.c:256:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] mem_limit @@     got restricted __be32 [usertype] @@
>     arch/powerpc/kexec/core.c:256:19: sparse:     expected unsigned long long static [addressable] [toplevel] mem_limit
>     arch/powerpc/kexec/core.c:256:19: sparse:     got restricted __be32 [usertype]
>>> arch/powerpc/kexec/core.c:272:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] kernel_end @@     got restricted __be32 [usertype] @@
>     arch/powerpc/kexec/core.c:272:20: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] kernel_end
>     arch/powerpc/kexec/core.c:272:20: sparse:     got restricted __be32 [usertype]
> 
> vim +246 arch/powerpc/kexec/core.c
> 
> ea961a828fe725 arch/powerpc/kernel/machine_kexec.c Anton Blanchard      2014-01-22  235
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  236  static void __init export_crashk_values(struct device_node *node)
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  237  {
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  238  	/* There might be existing crash kernel properties, but we can't
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  239  	 * be sure what's in them, so remove them. */
> 925e2d1ded80fc arch/powerpc/kernel/machine_kexec.c Suraj Jitindar Singh 2016-04-28  240  	of_remove_property(node, of_find_property(node,
> 925e2d1ded80fc arch/powerpc/kernel/machine_kexec.c Suraj Jitindar Singh 2016-04-28  241  				"linux,crashkernel-base", NULL));
> 925e2d1ded80fc arch/powerpc/kernel/machine_kexec.c Suraj Jitindar Singh 2016-04-28  242  	of_remove_property(node, of_find_property(node,
> 925e2d1ded80fc arch/powerpc/kernel/machine_kexec.c Suraj Jitindar Singh 2016-04-28  243  				"linux,crashkernel-size", NULL));
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  244
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  245  	if (crashk_res.start != 0) {
> ea961a828fe725 arch/powerpc/kernel/machine_kexec.c Anton Blanchard      2014-01-22 @246  		crashk_base = cpu_to_be_ulong(crashk_res.start),
> 79d1c712958f94 arch/powerpc/kernel/machine_kexec.c Nathan Fontenot      2012-10-02  247  		of_add_property(node, &crashk_base_prop);
> ea961a828fe725 arch/powerpc/kernel/machine_kexec.c Anton Blanchard      2014-01-22 @248  		crashk_size = cpu_to_be_ulong(resource_size(&crashk_res));
> 79d1c712958f94 arch/powerpc/kernel/machine_kexec.c Nathan Fontenot      2012-10-02  249  		of_add_property(node, &crashk_size_prop);
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  250  	}
> 4bc77a5ed215b4 arch/powerpc/kernel/machine_kexec.c Suzuki Poulose       2012-08-21  251
> 4bc77a5ed215b4 arch/powerpc/kernel/machine_kexec.c Suzuki Poulose       2012-08-21  252  	/*
> 4bc77a5ed215b4 arch/powerpc/kernel/machine_kexec.c Suzuki Poulose       2012-08-21  253  	 * memory_limit is required by the kexec-tools to limit the
> 4bc77a5ed215b4 arch/powerpc/kernel/machine_kexec.c Suzuki Poulose       2012-08-21  254  	 * crash regions to the actual memory used.
> 4bc77a5ed215b4 arch/powerpc/kernel/machine_kexec.c Suzuki Poulose       2012-08-21  255  	 */
> ea961a828fe725 arch/powerpc/kernel/machine_kexec.c Anton Blanchard      2014-01-22  256  	mem_limit = cpu_to_be_ulong(memory_limit);
> 79d1c712958f94 arch/powerpc/kernel/machine_kexec.c Nathan Fontenot      2012-10-02  257  	of_update_property(node, &memory_limit_prop);
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  258  }
> 6f29c3298b1821 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-17  259
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  260  static int __init kexec_setup(void)
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  261  {
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  262  	struct device_node *node;
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  263
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  264  	node = of_find_node_by_path("/chosen");
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  265  	if (!node)
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  266  		return -ENOENT;
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  267
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  268  	/* remove any stale properties so ours can be found */
> 925e2d1ded80fc arch/powerpc/kernel/machine_kexec.c Suraj Jitindar Singh 2016-04-28  269  	of_remove_property(node, of_find_property(node, kernel_end_prop.name, NULL));
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  270
> 2e8e4f5b80e101 arch/powerpc/kernel/machine_kexec.c Dale Farnsworth      2008-12-16  271  	/* information needed by userspace when using default_machine_kexec */
> ea961a828fe725 arch/powerpc/kernel/machine_kexec.c Anton Blanchard      2014-01-22 @272  	kernel_end = cpu_to_be_ulong(__pa(_end));
> 
> :::::: The code at line 246 was first introduced by commit
> :::::: ea961a828fe7250e954f086d74d9323c3d44c3e4 powerpc: Fix endian issues in kexec and crash dump code
> 
> :::::: TO: Anton Blanchard <anton@samba.org>
> :::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
