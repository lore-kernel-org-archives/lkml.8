Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148822078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgH0GUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:20:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:54123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgH0GUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:20:54 -0400
IronPort-SDR: yXyvbcqo+x01bsp3N9/ikElVNv/4O6WxU7xXqJCn1ygkAZyG12ffMs5bUwkFZR9FnQGOXn+H/G
 UfVCKOqf3nPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136495182"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="136495182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:20:48 -0700
IronPort-SDR: owvnyDkMBZvFBkVZj3mFNML9xhcTeYnqHm9ns78xa/qgHPeAWXfT3DpRwLCddzjkT4UC6D2o0S
 Dy2t0XNKPF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="444329033"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2020 23:20:46 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBBHB-0001uh-KO; Thu, 27 Aug 2020 06:20:45 +0000
Date:   Thu, 27 Aug 2020 14:20:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Torsten Duwe <duwe@suse.de>
Subject: arch/parisc/kernel/module.c:965:8: warning: Uninitialized variable:
 err
Message-ID: <202008271452.TWk1LUAn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15bc20c6af4ceee97a1f90b43c0e386643c071b4
commit: a1326b17ac03a9012cb3d01e434aacb4d67a416c module/ftrace: handle patchable-function-entry
date:   10 months ago
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> arch/parisc/kernel/module.c:965:8: warning: Uninitialized variable: err [uninitvar]
      if (err)
          ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1326b17ac03a9012cb3d01e434aacb4d67a416c
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout a1326b17ac03a9012cb3d01e434aacb4d67a416c
vim +965 arch/parisc/kernel/module.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  884  
^1da177e4c3f41 Linus Torvalds 2005-04-16  885  	register_unwind_table(me, sechdrs);
^1da177e4c3f41 Linus Torvalds 2005-04-16  886  
^1da177e4c3f41 Linus Torvalds 2005-04-16  887  	/* haven't filled in me->symtab yet, so have to find it
^1da177e4c3f41 Linus Torvalds 2005-04-16  888  	 * ourselves */
^1da177e4c3f41 Linus Torvalds 2005-04-16  889  	for (i = 1; i < hdr->e_shnum; i++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  890  		if(sechdrs[i].sh_type == SHT_SYMTAB
fe579c69c6d437 Julia Lawall   2009-08-04  891  		   && (sechdrs[i].sh_flags & SHF_ALLOC)) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  892  			int strindex = sechdrs[i].sh_link;
6ca6366220ed28 Sven Schnelle  2019-06-05  893  			symindex = i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  894  			/* FIXME: AWFUL HACK
^1da177e4c3f41 Linus Torvalds 2005-04-16  895  			 * The cast is to drop the const from
^1da177e4c3f41 Linus Torvalds 2005-04-16  896  			 * the sechdrs pointer */
^1da177e4c3f41 Linus Torvalds 2005-04-16  897  			symhdr = (Elf_Shdr *)&sechdrs[i];
^1da177e4c3f41 Linus Torvalds 2005-04-16  898  			strtab = (char *)sechdrs[strindex].sh_addr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  899  			break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  900  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  901  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  902  
6183d68b8b01e3 Sven Schnelle  2019-06-05  903  	pr_debug("module %s: strtab %p, symhdr %p\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  904  	       me->name, strtab, symhdr);
^1da177e4c3f41 Linus Torvalds 2005-04-16  905  
^1da177e4c3f41 Linus Torvalds 2005-04-16  906  	if(me->arch.got_count > MAX_GOTS) {
f8fc18a1323c3f Helge Deller   2006-10-18  907  		printk(KERN_ERR "%s: Global Offset Table overflow (used %ld, allowed %d)\n",
f8fc18a1323c3f Helge Deller   2006-10-18  908  				me->name, me->arch.got_count, MAX_GOTS);
^1da177e4c3f41 Linus Torvalds 2005-04-16  909  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  910  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  911  
c298be74492bec Helge Deller   2009-01-01  912  	kfree(me->arch.section);
c298be74492bec Helge Deller   2009-01-01  913  	me->arch.section = NULL;
c298be74492bec Helge Deller   2009-01-01  914  
^1da177e4c3f41 Linus Torvalds 2005-04-16  915  	/* no symbol table */
^1da177e4c3f41 Linus Torvalds 2005-04-16  916  	if(symhdr == NULL)
^1da177e4c3f41 Linus Torvalds 2005-04-16  917  		return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  918  
^1da177e4c3f41 Linus Torvalds 2005-04-16  919  	oldptr = (void *)symhdr->sh_addr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  920  	newptr = oldptr + 1;	/* we start counting at 1 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  921  	nsyms = symhdr->sh_size / sizeof(Elf_Sym);
6183d68b8b01e3 Sven Schnelle  2019-06-05  922  	pr_debug("OLD num_symtab %lu\n", nsyms);
^1da177e4c3f41 Linus Torvalds 2005-04-16  923  
^1da177e4c3f41 Linus Torvalds 2005-04-16  924  	for (i = 1; i < nsyms; i++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  925  		oldptr++;	/* note, count starts at 1 so preincrement */
^1da177e4c3f41 Linus Torvalds 2005-04-16  926  		if(strncmp(strtab + oldptr->st_name,
^1da177e4c3f41 Linus Torvalds 2005-04-16  927  			      ".L", 2) == 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  928  			continue;
^1da177e4c3f41 Linus Torvalds 2005-04-16  929  
^1da177e4c3f41 Linus Torvalds 2005-04-16  930  		if(newptr != oldptr)
^1da177e4c3f41 Linus Torvalds 2005-04-16  931  			*newptr++ = *oldptr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  932  		else
^1da177e4c3f41 Linus Torvalds 2005-04-16  933  			newptr++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  934  
^1da177e4c3f41 Linus Torvalds 2005-04-16  935  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  936  	nsyms = newptr - (Elf_Sym *)symhdr->sh_addr;
6183d68b8b01e3 Sven Schnelle  2019-06-05  937  	pr_debug("NEW num_symtab %lu\n", nsyms);
^1da177e4c3f41 Linus Torvalds 2005-04-16  938  	symhdr->sh_size = nsyms * sizeof(Elf_Sym);
8cc28269b95741 Helge Deller   2018-11-10  939  
8cc28269b95741 Helge Deller   2018-11-10  940  	/* find .altinstructions section */
8cc28269b95741 Helge Deller   2018-11-10  941  	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
8cc28269b95741 Helge Deller   2018-11-10  942  	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
8cc28269b95741 Helge Deller   2018-11-10  943  		void *aseg = (void *) s->sh_addr;
8cc28269b95741 Helge Deller   2018-11-10  944  		char *secname = secstrings + s->sh_name;
8cc28269b95741 Helge Deller   2018-11-10  945  
8cc28269b95741 Helge Deller   2018-11-10  946  		if (!strcmp(".altinstructions", secname))
8cc28269b95741 Helge Deller   2018-11-10  947  			/* patch .altinstructions */
8cc28269b95741 Helge Deller   2018-11-10  948  			apply_alternatives(aseg, aseg + s->sh_size, me->name);
8cc28269b95741 Helge Deller   2018-11-10  949  
a1326b17ac03a9 Mark Rutland   2019-10-16  950  #ifdef CONFIG_DYNAMIC_FTRACE
6ca6366220ed28 Sven Schnelle  2019-06-05  951  		/* For 32 bit kernels we're compiling modules with
6ca6366220ed28 Sven Schnelle  2019-06-05  952  		 * -ffunction-sections so we must relocate the addresses in the
a1326b17ac03a9 Mark Rutland   2019-10-16  953  		 *  ftrace callsite section.
6ca6366220ed28 Sven Schnelle  2019-06-05  954  		 */
a1326b17ac03a9 Mark Rutland   2019-10-16  955  		if (symindex != -1 && !strcmp(secname, FTRACE_CALLSITE_SECTION)) {
a1326b17ac03a9 Mark Rutland   2019-10-16  956  			int err;
6ca6366220ed28 Sven Schnelle  2019-06-05  957  			if (s->sh_type == SHT_REL)
6ca6366220ed28 Sven Schnelle  2019-06-05  958  				err = apply_relocate((Elf_Shdr *)sechdrs,
6ca6366220ed28 Sven Schnelle  2019-06-05  959  							strtab, symindex,
6ca6366220ed28 Sven Schnelle  2019-06-05  960  							s - sechdrs, me);
6ca6366220ed28 Sven Schnelle  2019-06-05  961  			else if (s->sh_type == SHT_RELA)
6ca6366220ed28 Sven Schnelle  2019-06-05  962  				err = apply_relocate_add((Elf_Shdr *)sechdrs,
6ca6366220ed28 Sven Schnelle  2019-06-05  963  							strtab, symindex,
6ca6366220ed28 Sven Schnelle  2019-06-05  964  							s - sechdrs, me);
6ca6366220ed28 Sven Schnelle  2019-06-05 @965  			if (err)
6ca6366220ed28 Sven Schnelle  2019-06-05  966  				return err;
6ca6366220ed28 Sven Schnelle  2019-06-05  967  		}
a1326b17ac03a9 Mark Rutland   2019-10-16  968  #endif
6ca6366220ed28 Sven Schnelle  2019-06-05  969  	}
5336377d622595 Linus Torvalds 2010-10-05  970  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  971  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  972  

:::::: The code at line 965 was first introduced by commit
:::::: 6ca6366220ed285e29ee22f4cf5c68a0397cb005 parisc: add dynamic ftrace

:::::: TO: Sven Schnelle <svens@stackframe.org>
:::::: CC: Helge Deller <deller@gmx.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
