Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA9720771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGEAs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:48:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:13464 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgGEAs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:48:27 -0400
IronPort-SDR: hq/POPEL9AE4RddX42K2JgdfBQ9fTUG2OP5jpO/XUrjJe3IKOolqdzUBOOcvqLUQ9BTOFlQ94u
 evjdugE7RsCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="232138481"
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="gz'50?scan'50,208,50";a="232138481"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 17:48:10 -0700
IronPort-SDR: KtBjiEkDe0JR/70fO5nFmmIA7ESYfBfC8h2Cd4i7T+5ebp4Ug99szA788YmeBtgdVoiPCn4j7Z
 SODftKGkp1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,314,1589266800"; 
   d="gz'50?scan'50,208,50";a="314778065"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2020 17:48:08 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrspD-0001Hc-F7; Sun, 05 Jul 2020 00:48:07 +0000
Date:   Sun, 5 Jul 2020 08:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: drivers/mtd/nand/raw/sh_flctl.c:510:24: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202007050830.tN7nClj4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35e884f89df4c48566d745dc5a97a0d058d04263
commit: 05933aac7b11911955de307a329dc2a7a14b7bd0 ia64: remove now unused machvec indirections
date:   11 months ago
config: ia64-randconfig-s031-20200705 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 05933aac7b11911955de307a329dc2a7a14b7bd0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/sh_flctl.c:510:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
>> drivers/mtd/nand/raw/sh_flctl.c:510:24: sparse:     expected unsigned int [usertype] value
   drivers/mtd/nand/raw/sh_flctl.c:510:24: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse:     expected unsigned long
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse:     got restricted __be32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

vim +510 drivers/mtd/nand/raw/sh_flctl.c

6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  458  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  459  static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  460  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  461  	int i, len_4align;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  462  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  463  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  464  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  465  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  466  	/* initiate DMA transfer */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  467  	if (flctl->chan_fifo0_rx && rlen >= 32 &&
e2bfa4ca23d9b5 drivers/mtd/nand/raw/sh_flctl.c Nathan Chancellor 2018-09-20  468  		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  469  			goto convert;	/* DMA success */
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  470  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  471  	/* do polling transfer */
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  472  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  473  		wait_rfifo_ready(flctl);
3166df0d0424ef drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  474  		buf[i] = readl(FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  475  	}
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  476  
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  477  convert:
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  478  	for (i = 0; i < len_4align; i++)
83738d87e3a0a4 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19 @479  		buf[i] = be32_to_cpu(buf[i]);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  480  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  481  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  482  static enum flctl_ecc_res_t read_ecfiforeg
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  483  		(struct sh_flctl *flctl, uint8_t *buff, int sector)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  484  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  485  	int i;
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  486  	enum flctl_ecc_res_t res;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  487  	unsigned long *ecc_buf = (unsigned long *)buff;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  488  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  489  	res = wait_recfifo_ready(flctl , sector);
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  490  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  491  	if (res != FL_ERROR) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  492  		for (i = 0; i < 4; i++) {
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  493  			ecc_buf[i] = readl(FLECFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  494  			ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  495  		}
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  496  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  497  
6667a6d58e25d3 drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-05-14  498  	return res;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  499  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  500  
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  501  static void write_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  502  						unsigned int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  503  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  504  	int i, len_4align;
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19  505  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  506  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  507  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  508  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  509  		wait_wfifo_ready(flctl);
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c     Bastian Hecht     2012-10-19 @510  		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  511  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  512  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c     Yoshihiro Shimoda 2008-10-14  513  

:::::: The code at line 510 was first introduced by commit
:::::: e8a9d8f31c592eea89f1b0d3fd425e7a96944e88 mtd: sh_flctl: Minor cleanups

:::::: TO: Bastian Hecht <hechtb@googlemail.com>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tgEA

--opJtzjQTFsWo+cga--
