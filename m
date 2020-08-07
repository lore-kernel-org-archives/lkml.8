Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE48C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D67221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHGJuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:50:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:21051 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHGJuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:50:06 -0400
IronPort-SDR: awPzk44k2YmWWeIHcXDzqd/+psQPcEiJK9s2+EscEmHukilO+1IQLZcmP3vi1++LQCIXcPiRI2
 OW+QeJ0AkspA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152275002"
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="gz'50?scan'50,208,50";a="152275002"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 02:32:02 -0700
IronPort-SDR: hp51rYYTXdBPr611x+Hy9JVGkRtaiPbU45Sgp65I82aReV0TPA+afltCyIgePmFdyEKmobtKIc
 xXHm41Tq9u4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="gz'50?scan'50,208,50";a="493986438"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2020 02:31:58 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3yjF-000091-G8; Fri, 07 Aug 2020 09:31:57 +0000
Date:   Fri, 7 Aug 2020 17:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: drivers/tty/ipwireless/hardware.c:431:30: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202008071747.ufhjwjYt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
commit: 05933aac7b11911955de307a329dc2a7a14b7bd0 ia64: remove now unused machvec indirections
date:   12 months ago
config: ia64-randconfig-s031-20200807 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 05933aac7b11911955de307a329dc2a7a14b7bd0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/ipwireless/hardware.c:431:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short val @@     got restricted __le16 [assigned] [usertype] raw_data @@
>> drivers/tty/ipwireless/hardware.c:431:30: sparse:     expected unsigned short val
   drivers/tty/ipwireless/hardware.c:431:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short val @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     expected unsigned short val
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned int @@
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     got unsigned int
   drivers/tty/ipwireless/hardware.c:889:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned int @@
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     got unsigned int
   drivers/tty/ipwireless/hardware.c: note: in included file (through arch/ia64/include/asm/io.h, arch/ia64/include/asm/smp.h, include/linux/smp.h, ...):
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]

vim +431 drivers/tty/ipwireless/hardware.c

d54c2752f6bb6c drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  403  
93110f698fe92f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  404  static void do_send_fragment(struct ipw_hardware *hw, unsigned char *data,
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  405  			    unsigned length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  406  {
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  407  	unsigned i;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  408  	unsigned long flags;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  409  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  410  	start_timing();
93110f698fe92f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  411  	BUG_ON(length > hw->ll_mtu);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  412  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  413  	if (ipwireless_debug)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  414  		dump_data_bytes("send", data, length);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  415  
63c4dbd1023b9a drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  416  	spin_lock_irqsave(&hw->lock, flags);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  417  
eb4e545d4ac82d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  418  	hw->tx_ready = 0;
d54c2752f6bb6c drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  419  	swap_packet_bitfield_to_le(data);
eb4e545d4ac82d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  420  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  421  	if (hw->hw_version == HW_VERSION_1) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  422  		outw((unsigned short) length, hw->base_port + IODWR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  423  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  424  		for (i = 0; i < length; i += 2) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  425  			unsigned short d = data[i];
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  426  			__le16 raw_data;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  427  
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  428  			if (i + 1 < length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  429  				d |= data[i + 1] << 8;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  430  			raw_data = cpu_to_le16(d);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07 @431  			outw(raw_data, hw->base_port + IODWR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  432  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  433  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  434  		outw(DCR_TXDONE, hw->base_port + IODCR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  435  	} else if (hw->hw_version == HW_VERSION_2) {
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  436  		outw((unsigned short) length, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  437  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  438  		for (i = 0; i < length; i += 2) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  439  			unsigned short d = data[i];
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  440  			__le16 raw_data;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  441  
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  442  			if (i + 1 < length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  443  				d |= data[i + 1] << 8;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  444  			raw_data = cpu_to_le16(d);
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  445  			outw(raw_data, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  446  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  447  		while ((i & 3) != 2) {
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  448  			outw((unsigned short) 0xDEAD, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  449  			i += 2;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  450  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  451  		writew(MEMRX_RX, &hw->memory_info_regs->memreg_rx);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  452  	}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  453  
63c4dbd1023b9a drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  454  	spin_unlock_irqrestore(&hw->lock, flags);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  455  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  456  	end_write_timing(length);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  457  }
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  458  

:::::: The code at line 431 was first introduced by commit
:::::: 099dc4fb62653f6019d78db55fba7a18ef02d65b ipwireless: driver for PC Card 3G/UMTS modem

:::::: TO: David Sterba <dsterba@suse.cz>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNsbLV8AAy5jb25maWcAlFzbc9s2s3/vX8FJX9qHtL7FSc4ZP4AgKOETSdAAKMt+4ai2
nGrqWPkkuZf//uyCNwAElZ6ZdiLuLhb33d8uAP/4w48ReTvuvq6P28f1y8s/0ZfN62a/Pm6e
oufty+Z/o0REhdARS7j+BYSz7evb379u19dX0YdfLn85e79/vIwWm/3r5iWiu9fn7Zc3KL3d
vf7w4w/w349A/PoNFO3/J8JC71+w/Psvj4/RTzNKf44+oxIQpKJI+aymtOaqBs7NPx0JPuol
k4qL4ubz2eXZWS+bkWLWs84sFXOiaqLyeia0GBS1jDsiizon9zGrq4IXXHOS8QeWDIJc3tZ3
Qi6AYrowM0PyEh02x7dvQ1uxbM2KZU3krM54zvXN5QX2uK1O5CXPWK2Z0tH2EL3ujqhhEJgz
kjA54rfcTFCSdZ179y5Erkll9y+ueJbUimTakk9YSqpM13OhdEFydvPup9fd6+bnXkDdkRJ0
9K1S92rJSxpoUSkUX9X5bcUqNtRqU7Ew1Zk15FIoVecsF/K+JloTOrfrqhTLeBwcHFLBggs0
Yk6WDAaczhsJrJBkWTdTMHPR4e23wz+H4+brMFMzVjDJqZnYjM0IvbeWl8UrpYhZmKXm4m7M
KVmR8MKsmHAxOuelu7ASkRNejKVzxVs1/RjYihIWV7NUuWO1eX2Kds9erzvFZpAorJeFEpWk
rE6IJuN6Nc9ZvRzGsa+9lIzlpa4LUbDQamjZS5FVhSbyPlD2RDEqoFQ3bbSsftXrwx/Rcft1
E62hV4fj+niI1o+Pu7fX4/b1yzCXmtNFDQVqQo0OGH675iWX2mPXBdF8GepDrBKcc8pgkYK8
tvaSx6mXlwNTE7VQmmhlV4xEmKWM3JsCgdqMxMqtx9C4mOhMqXhwwv/FePU7EIaCK5HBEIii
G29Jq0iNt4mGuamBZzcBPmu2KpkM9Ug1wnZxj4QjVTskVAiDl2VoIHNRuJyCMTBhbEbjjCtt
GtL22W1zv6MWzQ9rjy36lSaoTW7MrRpImUCbmcLW5qm+uTiz6ThsOVlZ/POLYQnzQi/A0KbM
03F+6ZipqoCOxuACFJ1Dt8xe7KZAPf6+eXoDvxg9b9bHt/3mYMhtZwPcfkJnUlSls/TAvtJZ
0IrG2aItEGQ3rKZ5pwRKnqhTfJnk5BQ/hZXxwOQpkXk1YzqLA4sMpkIxbc0bTiw2qeXYI9Eq
S9iSU3aqOig6sUt7FWBvhzqVoIue1djRXiW6VVUSsBUhdXNGF6WAFVNLcPRCMsfZmoWBbnx6
ksA0pwraA5aTEj0xURINT8jCZWiUlgarSBvi4DfJQXHjHCzEIJN69mB7LSDEQLhwKNlD7gwC
kFYP4aahsJhmXYVGjdaiBM8EuKxOhQQ/K+GfnBTUGT5fTMGPkJnyUEnz3TjIqgD0NyvAyxlg
aHmAMh0+Ggs4fOcAqTgsPulMJqzgHO1560xPzOZ3JLB1AZFWIJ2TIslGEAwduXS2CZopGx46
viUmCgatCtdQabYaSppP2HHWeJQiswcURpBkqbW+TGNsAluyQtsENQezNXwSbiFZcIiVbHxh
x06WXLFuUHzrFxMpuWtfWuYCpe9za1g6Su3BHZjvk9OCs22gdBregdAKliQT27Ok52fOOjfG
vg2bys3+ebf/un593ETsz80rOHICboCiK9/sHb/wL0tYcChvRr7BW7A+QpsNAhWi69gEPMMy
zEgYmausCplplYnYml0oDTMjZ6yLQBzd8ypNwS+WBPgw4BDTgGUM71zNcmNxMdDjKacdkBmc
QcqzDje1w+QGbL3orPHGGYwILKHLZhLK/e5xczjs9tHxn28NmLI8crcgyfXVUOf1VcwtY/AA
ALkGD3hpWcjbCmBqC2G6dZpbKAiAAV2ABQZYrqqyFLZxaV1hMzpo0uolkRybPkbvsFx5LMEt
NNDTUoIABLwjem8IMg0ilszC/0lu7+fU+mickoB4Fhw3+LbauC9j6+zgzNhPa8/CEHXNsufa
0BMexicds17q8MYxAvOyflidf48PkSwXHoRw5dSM19XypB7F8zBfk4JXeWCJ5nTBi4zdj/o8
TN/V4kSjBrFPi9C+8oTOrxfxiaqur4JK5g83mDgZUg8P9fnZWTgr8VBffDgL6qhBh113oyUk
a1qVncPyhLXUguOPXqPpPQDiYGjJhSIlt8A7+HbYKIjHca8JCTj+5vxjv15zC6wUZq2rm6uz
z9d9y4Uus8ogSWsNo/dnhbEIbYKilfuejIRfywCMU3kw4GUSd1KsACZ3BZ1u0ZJxYEEIPWPa
q1uxjEHw2dadC9jknkTCFXxqPgOZtqmeRAqx3yQTcKtUbJLtaB8MeTfWVW4ZlAJap7pAqA+m
MB6vSIZdgAm0JmouMhDnhZlSz26ZulGfMfxspVmhHKsPzhgHFq0aNsLI1jzx1DTDlmEMbxrn
dc7EERAtSszRrbRnynJKYFYoTJgM7W1wOamYWvk5rZmU0Ln/MKpHhZkf1Xs2iORZXaR3QZkF
W7FQbo5KomC6KrMVjF9Lt/uvf633myjZb/9sYES37LjMAeua8cnd5B/4AcAqSRmoAfyFPcDw
2WBZj0QJJlfpnINPLERhNKbg4mNCHXgxE2IGu6prywgbQbnoJ/b3cfN62P72shm6wxHiPK8f
Nz9H6u3bt93+OPQMKwNfqfwuIa0uTfQVxm4gEwtwHsJkZHHJSxECxihISakqhBFG2PGhJpdr
A5H/Ty9Mt/Xmy34dPXdiT2bubAQ4IdCxx7PecU7hnAYI7f7a7CMAlesvm6+AKY0IoSWPdt8w
od8A0c6qhVxhY1EaOINpMzti8L5QMuezuW43PHDrMqGufAf/SnEHs4IZNzQwPVwacsUoawL2
WTAIaHSVVNbas3HIYLRLro50EhpcLoYXEw2YKBRzN+xKa2Ox3FIpKaZKJE12yCa1GUiIbKnp
/UhdLzCllJe5Nwme1TYkWsHeAAOvEoB8PLOzAcPYjiunHFF/yOk1WmEbEbAD0qttbp+12PXn
TM9FMqpHsqSi4F/nRCbGbokiu5+emHlOJpt0RzSdJ8Jy8TA+mESQbOY4mK4D8LtdF902+u4u
MdtkXkZq+/XtZX2EDffUW+ABOhmoCf0NYzDDhYCTk3Aw2grQifxwsHYrYlal60ScU671/vH3
7XHziKbh/dPmG+jEfg5GwHE51MtoiSYgC8E6s9M7vl1mYc5dQqGpKdKyPee+AMgUZBjbYkKr
uRDWjupCJoCLABXwYG4OAVHiGSWTkFdaVgC7wH2ZOO2ESB+8+jJGd1N8Usg0t0Cvialkmpcr
OreWZnteaXRATzVgCbAExRguBc48vi+B4+HjJZF0qJBRjLWt4FUkFeI1BF4sS02+0SvNVgBz
/TE1obLJBjnJQpaaZkzlnzBRbuctVAdqZoDH3v+2Pmyeoj+aVMi3/e55+9KcEA3gAsQAKsmC
ZcH9cUpNbxggEgB0iuemlKJBHGUXvrNR+mQp4HdMoNkL1STfVI4pqHNviJ3UliG1cQLijaAx
aKWq4pREe2QcTuO3GpSk/cnyRBask5yI51s2ZpQk+KWgjJY8h8bCSkrqBWbigmlrxxliFhuN
HSyc24rZSZUuvx2rWZCY8XhMx2zGTHLt4PqOieFIeBTNYUqeZAhtTdgU8roodBd7LQRCnd/6
DQGfWrugw/QTcy+la/cbfLbeH7e4tCINAM5FY0Rqrs28JUtMkichBwh4iwyi1t5WiVAhhokG
LPLgBL2m2P3KbxEYuH0FGlogO8XbkvHkqNvcXAznXpafASkumgg7AduCw2+1fWAu7mMbanTk
OL21m+5W0m924h6OE1WcW9FmwQsz66oEi4D7bDjHY39vHt+OawT3eF8mMnnZo9X8GALFXKPR
tAY2S1u/6QopKnnpQNuWkUMcHj7OEoiO8jJo5qbaZhqeb77u9v9E+YBkRh4+nH3o6+4SCzkp
KhIy4072oJFysiZ97uFfabDyJlBxE/KPsgrm/NiczpQZ86P+ocJlE/qOkh5d2sDYn7YKW70q
M3BnpTbsJs/Ur8RmlGJ09i7wN/l1insolD7kM+mntOf3ED0lCYQrfqq5kE1mefAaxrNrAfGG
1dE8r6DxGly4e0K1UKGwrbsiZEYk54Wpu0mgDX3IGNgVzOYFl2EqYZbwJlF4kbqnwy31oRTC
ymY9xJWFGx4uU5E5ocCDcZcilPwwaM7kQBH2LRz402SwlwY72era7JG5xhFs9Kwq65gVFMIJ
uQhur+kdNKxGa+7UIh5SWT2iKTbHv3b7PwB5BMNs6A4LRTNgklaOgVqB8cjtDhpawknYUess
5HZXqbS2GX7VIk0RVnhUks2ER2pPQ22SqmKI3TNOHUdrWM2yD0UJTUmYFq40p8pTyUvcTbY6
GGOAeuF4UOXB5VK4lwZ42VgMSiYu6oFA51drKQDLhRw/CBkeXktUyk6VAacsSv+7Tua09JqB
ZMxDhbdRKyCJDPNxJHjJQ8m7hjWTeEyUVyvbXiKj1lVRuMa9LxE8lSvAqIkFd9FqU2Sp+UQD
qsSqyKKnwkrL4+TUZO4RmCrHlPHa5E0T2iViE83i8Ss3nCAR940vR8uOPMxI163JfWYkJLn7
jgRyYWogqBThlYy1w8/ZKYDXy9AqtmO3zr53/Jt3j2+/bR/f2eXy5IPibt/K5fXUMsPLsYAO
6Ng0ejLgykzwB/s5B+wUHgEQTnkW3lVx2bCc3ZNQ6s8vkrrpMQYUCRGlPDmMriW7imoUuvDv
+9jMS2+XDoymVNgYGCmdSlo3MUjvNiZbNrS7Peafrx//cO4+dmqHfJyt0yvltFnRCaMiJ252
6fAdYEB8Tn5O52DveFg1MjMSPOFDViwvrj9d+doaKjR5cklkF9qaffwK5W8NfXkZsl528RkY
UwuGS57MnExFQ6kBgMIYFkL4i9gVW0J366bh4xyMWaaKuLYvRKg1GINPZxfnt2FWLGk+ujzp
C5woCqE53lsOS8zUHS/DrMm2sklObl9AshkL9XCyC8CfZHy++vgxzLylE+2Aefl8eXYZZqr/
kPPzsw9hJiBKntn2x8yxNzsDrZ4tpePVLVa+nHDcCaNFEOVlmWXG4cO6YALhamaNLWYuSAkx
T0u29n4SPM5bXVgdzkhppUnKuXCAK2eMYQ8+OJt1oNZF1v4w1+TA3Bd6Im9tFcIblcFO54T2
tVkTYqL5zrrfvm3eNmDkfm1jecdKttI1jW9HKuq5dq5P9OR0IsDuBMA2TcAaZY6S7dxGRzWo
MtAGyZIxUaXBhqn09mS7NLsND3UvEKcn+TQORQIdF1xzqFWaYI9PlJsF+5goRAwhhfAvC9+8
6cvKkDPoh/q2nYLxAC5iv63jMZiLRchNdfzb9DakmmJG5KTi9HYs5CshCzYeqTS0dOfBuSh5
OCbv+VkQovTjOr6e1wFGd+l5THDQqahTYmdjO16r++bdt+ft865+Xh+O79qXHi/rw2H7vH30
wBiWoJlyOw0EzJS798k6hqa8SNhqomcoYcKxq7HK9C6kr7q8OKVLLUdRZ0e/PlEOApRgbeNL
+X6/7evHtjbbF3X0HI81SebFVcyQQ7T2WOvyIsCi4/C65RTxvZ5eaq3Q9DC2AjnTJNim9g7O
aKhI8Jp+v1FgFTprl4buvyWFwuv3Al/OWXAPjDoxOXMH8vXU7ucyhPgsqYxMlE9IOKFgiRQh
lG3xc0qUnlIfehM2IfY9IXOXJygkACwuARXCHAWaumz8uLVzO8ooWm6OAHr+1ErKeLEYhcsd
NiizUcoBaQBbQ97IsNAMOGjcUHkZznkUauJIXk26HzM0AMB8VdklbEwFsQCis8l9U3iH+C1L
ltaQytS8QrPTFCub3z5MQXUuErEYo7SUyUzgCyd1X7vX+eNbP0MDdqd94eqmLaPj5nAcga9y
oZvD5T4+HYl7DDv9OQRNuSSJ6U17/vX4x+YYyfXTdofntcfd4+7FOq0gDqTFL9h/OcGr6EvX
w0phhUdSKNZVQVa/XHyIXtvGPm3+3D5urNsb3fpZcOWswmtM0waTF7dMz90UfEzuIe6pFayK
NAl5L0tgnqxsY2XoJbEM2D3J7VE+2XwrHR+8g+ScWeJrAJa4DYfVkmLIFrYkUKJg4fAGeDSf
SD8Ab86DAQpylNMk99KIISTBw2ONJ1epdg+KB2LNaDIPc5yrxMAYEgtmfcQvb5vjbnf8fXJt
YKspj7VKXDTa0CsSfEbZMBOdnTuVG0WXdKwmzipGiZw4pTYiS/g/XFMul5mnEkk1tniihF70
3WlX2uRA9NsvBdsiS/tCX0tpb8XWmVAqwPXycHK1IO6NsLRe0FAodsclw6u+Q9mOUjuXe+/g
q3ZPXw3JfS5qSKq8HwnxpWVd0xlGqtasNZHwubkHiueldss7afQGLBP4KgNfnIFrmnhb2clT
JnX/8qUWRRV8xNNJ4xUJ6Lh5k4XnFWyWxOMmm4s8zQ2ZRgTPUNREc1vA/51mnkIjQ19kQror
nKd6cefMmUPGLIPzXibjsTcNHQWquy81lConeZTm00y94A4Y7tlTed82d3FuF+potaR4uqq0
DMaDtlgXk71roya1+7qJ/truNy+bw6Hba9F+8983oEXrCP9eR/S4ez3udy/R+uXLbr89/m49
7O5150xZlq8noyENNjkwpwGVqjt69Z6vu2pAsqhOaYKgBC+8zc1DD3zNMvxNjzsONHtno0ij
1bzmuvk0QKUFt7FM8z3qYUvmRVmFIXorMCsn0xyfvTTp53K45OIgvM8nHki3/Kn1RAl3Yn78
PimMCj0oasiVCj6tZuW8P57waJgm1vp+OnjoBdGU2AFWaLxSN4ZPKb764lNpQuQXQQeGnLl9
vQgJap6YRGmLTNf7KN1uXvA95Nevb69triH6CUR/bv2Vc8iOKsriw9VVzS9C0VjLv7x0azUk
LOKSc06lcC9BOuRxCaUvzuFfEqa28hZi/lf965O5ikC842WYeGoRsjv/CLSjuEmIBPCRuQEy
kCC6gGWQ+XkbWIAYxA3ElPBMNKF3c8jVgIbRyxRzTuLcHmuuPjok/6P9iyrKJYb+oAnlDD1H
HHSgWChXnmp0pQvlKTkRUCMXJhnvqXTvxvBx/0R1SlexWx++QR4Rifb6xsXSKya9dpfECfWQ
lJHYjXa7V3Glu9GaWAtorT/BP0IxwNxm36yfNvj0GKQ2ltghOvQPcoY/VfI92XZBHLZfXu/w
4QpWTXfwQ42VnRTrLyeG2973i70+fdttX4/OPRsYIFYk5qFr8K6PU7BXdfhre3z8PTxS9jzf
tUkCzZytfFrFoAGxvj2ZOeXE/zbXg2vKXQwHBb3V3rb9/eN6/xT9tt8+fbHfOd/j0Y0VX+Jn
LS58iuRUzH2i5iOKUHMe201Nrj9efLZbyD9dnH0OZQybXuNtd3MXyDKZkpQ8sZMcLcFcFjS3
DUSlby7PfHa7H+Wq1qvaPFFyAEGnJCcgOePBY+teyAtS+hqqvE9Yezy8R1aEKsyxKTX1UkTN
n+lZf9s+4YXVZo2M1lanQiv+4eMqUGep6lWAjvLXn8LyM1ZcjDlyZTj/x9m1NTduI+u/4qdT
SdVORaQkW3rYB4ikJIx5MwFJVF5YTsbZuHZ2Zsqeqc359wcNgCQabIip8+ALuxsXAiDQaHR/
WLqjN1C7MZbk9Xc7w99VU8+2k3HvP2Z5TWoMqj1kUaPwQkvpCgsdNbp5SVamzA8mHj/uxpQ1
xD1qoLRJaw+hc5+/qjnrzYmXvExi/QaSdjtMAQJoZKo9SsOG0kzowCTdSRt4Qm8/yvWu9G7L
+zUd1GJW6sV38ApGG+ccjHguN3AWDUp1qva5AbweK5Cdm4ze6xkBbU4x2di4Z9rNBMSYuJZJ
L6xjeqhvLzsgV1zzjLUpSysKND1YQReizdJEkjhrLXz64qi6TPfnHtvtgLnPysRsdDJykQiM
emM6+vGOdM/ekOKQB628UspXgsKFdKiyHsVo0jqUgtybSWQyUY+6nQOibkyDq2kAizUPA9kL
Qvj2/PaOzaISrA0p+C9SWfWslDf65a42yONDhGuKstDwPDp4ivR4m8qDhg3hgWiZndRZv8pJ
/XtXfIVIAAOfIt+ev7x/Nsp0/vy/k5fb5Y9q2Au/afVrBCpn/MgbZzTuXSCi0jw5OxGZd82F
yIyXKGGzT3FOQuxTtMUSBQgEqlVVtdc7FgXSoQyBH+BQr48x+jHQsOKXpip+2X9+fleay5+v
3wgbOYwrF1QECB+zNEs8jEWgq5VlgF5ETaty0IdTAPLkxS45UvAl71j52F14Ko9dhDP3uPFN
7gpzoXweEbSYoJUyy5HVaniDQm2d0ildLVtsSj1JnntfDiv8hlHNT06n+pvdiSygxd7oORMT
8vztGxzF9BamP76+Gann3yF23OveCjaWLTQheMV5AwqCGDxwAYdsMYeC79CLgflFhyMEut7s
BXFSrQ4Hc9bd1J0hjjKYac5kg09W5hrGWOlePv/xART559cvL5/uVFbhIyQopkjW62hSfU0F
sK49p46HHBlPC9WfcW4qjppyQlI/Pk09K3VdstwY3lz0FMvNGh2zCNwo3rjZ6UkuNouO2c29
vv/7Q/XlQwItFNrrQ8q0Sg6OVWWnfWqUwt8V/4xWU6r852rskvnWdksqlYboWf31RFhmwCGJ
BnDq2l0aLulkDtwRwazkZPT3rLiF+e6gmjXQw1oqSxLYOh6Z0mdKr6MJAYh28CeOS2dfD1XD
TbzDp/p23/HfX9RS+ay2o5/vQPjuDzNhjNt33I86wzQDKD2imoaB7TZjn7D9ZNo3bUtbXgc+
fKWACdgPuuL1/XdcKzH1kh1Swy/BC4Lj7W3Ht+DisSoxni/BNAvZ4Kb/92RTreEv5kWP/HAk
W8uR3O2kHrKTbs1rmEj/x/yN79REefcfE8JEABRAziYBtZDMZ4VzEoA7UdEbCuCfdpSxFzjH
q9ohmeC20SNlTwj7kCJ1AioMPikKETr3oLKnGfgFZPsbpLXbEb3ZHGXECbxhSePfKDRYcyY5
sHazedjSMRi9jJqJKfhME240Spf1cASjD2sIi9DUn0KlwqAtNkLazbkPmi5PeQ4PocrylIRf
tqnBMCsErEu8XsauxaKXOKH4z56aKz2WpuowRgMxvfH5+mivotOmzQ7NlvDcmeNPc2ztBXFO
G2IXjh0Hvnik9jEDt91M64SWaodo3y+6p3jjKj4aA9MG/EceZZKeyfhwMPXBDjyTzvxnnbZ2
2Kt8pHZTEBK/OjNN0oi2nYzH8lxkU3wnoHqr+NDwZwwxoUVNIDCTlOOaFtizXYOCDDXVBqXj
vPYB/3DgyYR05dQsD9bNIXrj1+XYGhCcfULTpQ0m7E+J3PYb1kfq9Iul63jddmlNAvmkp6K4
YttJfWSldD2oJN8XExwYTXxoQ7CNidguY7FaRESZWZnklTiBD0PWAJAzmvyPdcdzalJldSq2
m0XMsIsgF3m8XSyWdD00M6YgDNUmSlSN6KQSWa8R7mHP2h2jh4dbaXWVtosW1b9I7pdryuSd
iuh+4+wsBfry3SOKEWfMMluAQG07ke5JdDiAD+gaKZyZtT7XrHRV1yS2S6OBNchq2GO+TxDW
NF3NFTEKBrFkc7cC1aWGX7D2fvPgeOlZ+naZtPcTqtqRd5vtsc7celtelkWLxcod8V6Nh9fa
PUSLyeg01OBB+sjtmBCnwpgf+raRL389v9/xL+/f3378R4Pvvv/5/Kb2IN/BgASl331We5K7
T+qLe/0G/7rfm4SNP6lU/T/ynY7JnItl4BybQVwaA7NDPV6Y8eW70vELnihl7u3ls773Zex0
TwSMlWmPSGe2vAnfE+RzVWPquHCotZk6kRoLOX59/+5lNzITOLUiqhCU//ptgL0T38FLxonW
/ympRPGzszMd6u7Uu4cNudFOjj02Ky9PlKaTJUfHBqg/R5YnAGyONkX9Z4rJR7ZjJesYRxYJ
dzofJc8Ag4mGuqd62TZTa7bdLU8+cQ20U2ActobxFO5vIfGjIYEza0FytHxpinXs9qjarj36
V+p62QoZmMKf1GD/9z/uvj9/e/nHXZJ+UJ/4z463Za83Ofus5NgYGvaa7yUpo8+QBHkvDdSE
9gjXLzCsVYF2MZYL5tntNSevDodQSLQW0Fia+myE7kDZTwtoPTdJAbzwRncpNcLwvf7g+jfF
EXClUoCe8536QzAAPAv71BpWUw95jfYc75UmrXXRnl7h5kqP5KxKjXVH+5EBUyEZYG9ULayA
ykStVB5eFdAA5M49hgJabT+V0aFQaYCAjGqzpgz/+t0GLXJ85V1NJBoPGk/C26qYmTHLsrto
uV3d/bR/fXu5qJ+fpzPAnjcZOM86pxaW0lVHbHEdGKo+MV2TXqIMVXUQqMSV7MKbtR6UYe34
ZrXFkTZZ+neVvrIppOsirebppK8GC0V+IF0cdPCMFVOKBk7qdk3F0gRFy2GBRu3m1A5tx5GX
gCfDyjRg+ceCADd0zmBkBS4VweJw1rxjOVisaAdNiGJGdidFkoza9PDayo7P0j1aOrdeVmBD
DRwOHwJBA6p0Qeq56q1gvq08fzdL69JryQqOOw1HvujolUrfTaQhgFHkdyl3o3tlvzByHCtt
nsHDxLeUW07jcEad8ERFZKB2UyLdWY9nfaWa+4ZnasOOalXmyArKmqTEs4mhdFFMbsh67mId
+ZmAjXlCS9yK97Sq2C7++itEd2fKPmeuJlaikipFvPD2bM58XlhHgqmOCY6wji5NGD21q6yU
NASLZsLCqgOKwiLHgD1EM03vTKqWviql//W3H6BWWn8a5qBLEnEma4RKoh7VkgWeSWHHDS0D
h2ozMmrbuZuVyZqUBGztoRN2arUT+xh/WcCwNg80EWm60pH4k4GfCM5YIFjIh/WS2nQPAufN
Jrtf3C+mhWsnXG0kv4U/gaRosAlTRtu2N1jdIa/UpBpTbzsK1YE5rpd8StiG8i7o+eBtKrNH
pWXxaV1EoTYUI/bFJHOXH3J+pkQLLxzo7w7fYTsEUXF4hlLFnDO1ujXdMqnQebf1b1wm64cV
2VSjwGZLCpyrRuJI8XHmvdbHigTmc2rEUlb3rpv9PGNIsJluQIGZyeCQYSUkk9EyCsWu94ly
lsA5Dr4yU+RcbVtDn96QVGY++HhW8gCauTELSDH3EgX7FWeaqV1p35VzaXEQV5FuoijqQvjX
NUz0S1qftL1dFnD960ypSn9Tswojh5laTWg6vFCFseBlTtdFMWj7JjDoJQI4oX6YGxCnpmqQ
YdpQunK32ZDXsDiJjf6Jv6zdiv6g1OQNWlkgdr1s6cZIQgNM8kNV0vZXyIz+MA30vx8m5iac
GXLqhROGTSG7ksKhdNJAAnPFHMU78xNqPnlUGnvWdCVcBEuDrLgi53mR3SEwSzkyTUDG1C+4
nuT86cTTAA5Kz/TqSDTCMcsFjnCypE7SX8LApgfAwKZH4sierRkgxeLJiYfWsz6JGly8RB9U
OjuTpdkEjUSe8iDoYp/K2r7GgvKYPiwVqqcD+zAnv6w45Rk6Vthl8Wzds1+x+4LD2p8+cilO
xLq7L84fo83M1GRuc0HbOvLCXSfJEamBxzqam8GOJ3bJOFl7vonXvi7Ws8DfC40LuiAgL3y5
BT2H80PgPq/DLvCR8zaURDEChQAnlN0qVDPFCKUJXIi6L6IFPRT5gZ7PPxYzXVuw5pzh2Kvi
XIQmH/F4oGsmHq8hLJm+IFUKKyv0IRR5u1IfP204yNu1NgiFuOJyk72nXHPd+qidAx5tj2Kz
WdHrJbDWkcqWtmmqvYdK2vrhWXShlf2wxxmdlQ+r5cxXq1OKrMA+lAJuVU2yvOqhTWYyuTY4
vXqOFoEu3avdSjlTq5JJv06WRG+UxGa5IU9w3TwzgGTE2quIAwPy3B5mBrjGECkrz+NgP7MI
lPideKfKAehztTsAyLzOV7mmOWyW2wUxRbM2pKyVWfzojyA/dR0AH3RrflbaAVoodVxmmtGe
FWPC6hG9M9zvM7MoG8RrG4KFD/6ZvleMfJVrBtEtez6zIXjKqwNGE3vK2bJtaY3qKQ+qtE95
YICrwtqs7ILpyDAGt4YnOBcskJ75BLgvWRG4jKopZruvwaEBzf1iNfO9WKuCm2oTLbcJrVsC
S1aBK5430f12rjDV00yQy3cDWFEoEMdQbucoWKH0KHSaJ2A59TecRMoseyIrIqpc7fTVD774
MeAVpOhw610yZ1kQ3LOGi2QbL5aUERalwqeJXGwDl3kqVrSd6Wuw7BCTiiiSbZRs6bUrq3kS
ukAU8ttGUWBbB8zV3HQtqgSs5S1tIBJSL1yoCWShvo+/0b2nEk8pdX0tsgAKAQyhAChlAlha
ZWBB4hTKhVuJa1nVAqOtpJeka/OD95FP08rseJJoTjWUmVQ4BYdIz4sG5xaBE1U5a1w54wVB
PXbNkQdCMIELoDcJl5R7kJPthf/qnU0YSndZhwbcILCc20K0vKGNi8CIAwA3+zSlO1qpXHWo
4cXO7id6rciEDcP5pEfEF3doSgL3I3E1FnwGlzuGIgGACo7ySAHTUcWgxRU8cJuxFrFGBeIF
1MDAvhqa4N7ufVGU8THPUrjVCW5f7AzDeBxyfqcep0EwzjRJqUysSG02o6HLWvKAThvPjLP0
LiwgN4tl67MtU7X4gzbGu2+liJsHgmgOCb0W6c1rWDrhCUuZ/zLW7hCoS8rUIBkyGieIGtTc
OJRIcWWyiSIy2WoTbBbNv38IZLvnbZbiV+JJnZ+ER9MxVe2FXTE9BwcZGS2iKPHrlbcyUKbd
PPoJerLaWgRfxmy/brLNuc68hIxC1ev3TPhVSw3OxSbVLluVF+CLt5OxN+p3fXZEcf3xDirM
Kkx+WaAZUa/nLL1+EiGzaNFSHyGcCaiBzhOvr89cZgJuX8YZWQfUg/rm4wZ+U9NK7hqf6ho/
dDuR4os7gJhmcNkT0rmAHLwcAJhFXU8SaE9wmNToNJW518AhZO4jjuQCNlwvQG+qVGETny2H
p0PdpXRaVKBmEfkRx/Eq7gACQO4etAQAa0ucp3HtgP/u+xkZfCs/vL9+erkDPKje0Q6yfHn5
9PJJhzUCp4frZJ+ev31/eZt6CF2Qj8cAtHfBIFsgNZ6hFWocU7O9PE5OYlFCic6/QDzkt6t4
a/eyTnj0oyQNEflXKtL2sTtefMpQK7dwRd/JpMraGyh2WmyaLrQPN1x2pC2EhhsGYrP8a+ld
sG3oBsYsmCw5Mg30pIj4CvS+xlXm3fdxvH+kNcYLz+/jKOSVcQwZGS9JubwPbMDxMCgCqqor
1S/Ds4L6uIBoFldmYjrm9SWmrcfAibH92JLUV1hyScYa9xJP+LSxJ4dGudI7lAhaTDXlBiwV
v+Sr7f06xFtuV2uqfpf8wt0YfkvowfRGanpGo0RRijPqAwvy9NuPf/0Lwqgr/6bBPufpxTaT
NKGeagT34K0E7aF2zJoCXRqsnwFDS6C3sHQNeQaALFWpyuG0na3OWytPLaVKn/ULLcElIZ+Q
IchjStNblAAZruqVzcldvdYrYuoCKm1KBo4Pj6gbY02FFrrNPtr5x4GYNdI15fSULqGIAuE4
DWRvyh7oGL1yIEu17QS0He+TwMwwZCcMvMw5PLKEzofw7ekQrUhrj5d8E5jk3EbLUs68pZAU
bFhAX0FCg6GuVwJlvok2C0TQOGDCk9nG7lbUksSUhI/QgfgQLxmJ0GN4u0mCaLPJQglUCZlX
6CaOGCbhacgSfPCHnhzq6P6tJ9qGrTdFN0s9x7EEjbxsNvPdR8K6uxKuL3Byibz1w1BMggA2
s5uZi752yaPYddU0z5MBDeSWOoxRjI17nHrJPbxk/TzNTyvYQ2A+3H5A+Vu4tf71mrKgyqj3
/FlZ0h76dv5r2DWh4Rw1Wy1u64WL4NKDzR4vJvzfMVE1soMBNFm3Lq8Fa+8uPfzu7u3r86ff
ntX6NEZTmpi5L/qqXVe1/v5VZfNicwCGawSxS9xs9k7rkEY551Il6/rqLM4jb88es3xHsqaN
UcCREu2yYV0FupD/J2Akcc8P3gEA7UsXaYmfwG3YGcTwZLC2kGrRC+pfASfgAqSoymE1RT12
tRe0buPHvv34HoyP0pjBrvFDPU4WUEPd7+Fa4Dx0E7oRAn/z0AURRsLcW/xYBK7XNUIFkw1v
faEB6eozjKjXL2o398ezFwFs01dwI/vNenysrrcFsvMc35uaneYO4cSYlI/ZdVcZGMwhz56m
9pb1eh2Ykj0h6ihqFJGPO7qEJxkt1vRgQzIPszJxdD8jk9oLUJr7Da2xD5L542Mgtn4Q8VFU
aAk9BgO33g+CMmH3q4jGo3CFNqtopivMUJ15t2KzjOkJCMksZ2TU3PqwXNN+waNQQn+go0Dd
RDHt4DbIlNlFBtAhBhm4SwfWzpnihKwu7MJoc+EodSpn+18WcSerU3IMXZE8SLbSy2w6OzjL
KDx2tYgJUsdyhC430HfXlCLDmbz665oDR6a4lqzG90ATzE4U+BhlEEmuPXrmhKXvCtfh9EjL
H/gZhCRkgeBPpxIZmAk4fQ7slKY7gZMXHg5C+yoBdd69tMspqPBgcAzLwNTcKN1cCwnF3xDa
JcV6G/CvNxLJldWBWEnNh+byYwg8kbNo25bdyiQ4Xdl3HTr8dkGjnId7P13Q4JLxgPubFpEA
Ghy4FtwIQMuKpMkCPmf2++GB+yWbgq8mPmfGWPv89kmjvPJfqrs+zNemgk7HEVM+9pEnoR87
vlmsYp+oflvkh9HorBlK6wjNL1YggQ+XMklrttqDmxnCS9awy41MbTiCl7FfsojBon8rmyaZ
ycMsfAGRkwhANx1YkWEMqZ7SlUIpGO7rDpycsqQM3Kw4RYvHiMhxX2wWkWsOo8bECFFAaK1G
z/vz+e35dzDkjzsWW5Q5iRj1fmp+OpW83W66WmKXBQP2ocmBIcByi99dpp7qpp14ZNC7P7km
OaMDzIqqZcYym7vjW5P1IQga9dcyAW0KIyH31O5A+k1Vv1bY+5AHAvrKDu6dCLAOgjZC6x1N
J2jLjobR8rok17DmcIsAROkSiZTKjdCx1POjIVhUyrfX58/TCELbQRlr8mvimj0sYxP7oDcD
WRWhVlUNynsDmtVNYADJCMYeuvKR5iV+KC+qAkKYcItyj3ZcRtayJvRCpAnBFSib7qQxjVcU
tzmVgDt/SyRrZVamWRqqgQaeBqCl4Iw1Nr6E+7M8UapWItBE6SVUi0bGm03Ac8sRg69tsl6V
X798AK6i6BGnDSDujRA4I2ir3IMpxBLY6OQQnZHh5/pRUJCalimSpGxrIpVh9NneyiC65+Kh
bck8LC8QSGnF7PL2UbLDiU1X3anEfK1sghM+AZ7wYCtkrj3wB6grtGOntIET9yhax4vFDcnQ
54kC60baLXn4vEzVoklzNAFcCcvei7zLa/9iPQclFs1+XtFFIpt84kBlmYD94kEVjbO4vMIZ
SSlJf4JGn0c5JxX19OXr2oNStHH74d7mdcGVelemCJRAU1P4yRJz4ZzLAFustsP6dMD+MoDy
+Ohx4Am1RSdRMkyB2pPNnLvtWeIX6+IBGYLge490gUt/0+owLR/uOK72VLyX4u+ossczu8st
jIxsz9UMR0JjqT0SN66B9oIUDSL9e1hxGpQId2sK5yxwoe4K+f6N1JVDVVuGeNW6jeLcYOhc
EROoyHBIwS7W6usauVtDB7T6eO1gQB7rwF5GjatDcswAiUYtZNRptUzUT+3C/gGB662YOZ2n
WXD8VmauguFyy9O5kj6zz2383JLDkE+gakmz81OcVXUBYaqlLR99NYRcLn+t49DtX6oRsb7f
8jy/InNDT9FHg27vTRVvY/BUBU3NyjEOME9qrluoUqrWgZPvDWxtvFFt42i93Jxx1Ux6NKVi
IPASIBanth/0xY/P31+/fX75S9UXqqjhu6l6QqLJrNnTc5mslgvqTvReok7Ydr2KJvWwjL+m
DNUCU2KRt0mdp25733wDN725eEVr1Thjz5Ckx3Z+qHZcTom1vrJt6NFhbwbIdx6GXp3cqZwV
/U9At7t1X5TJnEfr5dpvXU2+XwZaVnPbpVfNIn1Y308y+j/OrqQ5cltJ/xWdJp4j3htzJ+vw
DiySVcUWNxOsRX2pkNWyW+FuqaOlnrHn108mwAVLgvLMwW5VfomVQCIBJDLF83v6uELg17qj
NvZ8QieO9u1gg3JQKV1ZXgKV1PAnQ55eF/G0CEYTZTTPv0gJ2+pNqH2mkkW+o+eFDyEi6kIT
Qc1efSSBeDAUWZx69IdhGd8ZLpP4r9e3x683v/5YgnL+4yt84S9/3Tx+/fXxE9rU/Txy/QvU
YwwZ8JNy9YLTEiWHxds54rAPLvcND1ykasQaqF2HI7qS621RT5NHorbG4bT8UbNU9rqudHyt
+cdAqrAJNbq3+BME4jMoZcDzs5gV96OdIWEizgsW3q6t43Xyhl3hCZiVa0hbBiqPaZfUvn0W
8mKsjfQ5FReQtjmuDcLhSIXa5NAYiVzlR+Lo1tRad+GL1Po0dWFBufQOi6HTSu0jmuRbXjiR
Tx9YJ7uhOTD1h7JYiTNOVmpRBRbylyf0gSoFh0Rvigd1D991hCvzoYPELw9/UJtPAK9umCTX
TI/aI1/hC+v+G7wybYrh3PbcAJurRmxIawx3Ml3tw9iB4fuJxxeCMc0Lfv1PedyY9Zn3AGWD
GxBpU1A2Yj2WGOAv6WRQBJwwAfFpqQz5Fkf4X9GIddZ5PnMSE2EXN3SkeqAcUZ47jITrLmUD
+teGqVfDEhm6nsxxVf3HT4nK/hf9ubKovvX0n2fG7hhpAMtBIxIHp/LLP2dRcESIgq/3376B
YOalGWJe1LvOu0HLKz+nndYD05ESURFZUKrNqLdJxGJqleKwEJpaprgg70Y/QJOqY2/LvDxx
6uOf32AcE20Ul+Z6SYKqevyW+tKhqN7FbKWgW06pxNE7anu+mXSkryfdJUrEQ04dujLzEteR
u4noBjEUdrnZPWo90r782JIeYzi8zTdh7Nbnk9GAPN04IX1owfEPafPxOpDBuThuLs2cXHX+
JqC0P472WTiEiW90CYtCJ4mMzDiQkMrSgm9cT8/vl/qSRDrxXEXK1pZTz3XiuxdlyJp9PkdS
XR2q20ExRxuHAGyP8Bmbq1cHN2EC8gIN6vPM99RKEYXrQ7m1etE80zo0P8G4pifSLo1joGTJ
3s8kIv5/UE7yBIivDSrlYkCmr4UkltkO59piotDhOzVkJeosPuVVuBNdKjaSeSpl740xHW15
4QqO7wRR0DiREv5qmw5D0UNbmBcntJGMwkJ3vsJC7WEmBrZVY+WOFQMyde3E3TT0YyItp+0v
Xqz4AtQANUilDubD9Qi9D72mG6jNTQGB4r/TIYbMMRnc0DFrAYLajcXsNTIdMYu7r7G/gCnZ
OJRcmjiqLok9yYniRB9PEHTuwY9k41WpHDcIYyIfXGviaOObCHRxAJtiC7BxaMALiUIQiNU9
uQSFCfnKfh5T9dYPYrPz9+lxX+CJibcJiCb3wyYIpZ0vn73aT9jEKkuFII77hUNpGgM292+g
JlD3gWPMijwOXCW4g4IklNY/M9Su47l0WoSoVyYqR2RPTNtwKTw+LRIkno0XWLwWzDwDtHI1
qAfnkD6XAkSeBYgdGxCSbWZZHHmUI4iFoyvkAGMzfbh0RO1yFnlkFBMMO7JakJAtUNnMzLUM
b0E73ZrALnYTJ9xRBSKUeDuL5/uZKfTjkL59mXjqzPXjxMearVR/N7ChOA4oYM1q7qvQTVhN
Ap5DAnHkpFSzALDdVAmGQ3mIXNJ17dyb2zotiDKB3slPVGb6kMQm9UMWEIMQFuTe9TxiFGLw
X1jcCIALJnJ4cmizPpXwJNgN10YWcnhuSJYceB7RCg4EthQR1ToOEBMCF5TIiYi8OOJuLECU
UB2C0CZeaSvGvolo4cghnzJNVjior8oBOjoRh9QqUTy+G5Nr1zLJOl8IdQ0Ysigk14m6aHae
u62zFXVz/jp1RBvwLgzxuwy0mbTEsN4JwEAbLC8MyVoPoRkyOUfqZG3BA5iYvFW9oQYxLFwk
1SepoecHFiAgR6CA1vuxy5LYtxivyzyBt97dzZBd0cduXTL6XezMmA0w2ciuRSh+57sDD2wj
1kUy8mwcyjpv5ui4bxCqEvwUYkPJt0431Z2T1NrpK6HFeLRCAGvANdvturXkZe+HHi1jAEqc
aK2lZd+xMHCImV6yKkpgqaVHjgf7OOq6T1kqYlJoAuQn7tokGYU0MZoB8Zw4pAU7CLWE7EXE
guAdHRC3NFGypul2lwJWCFLsDh0LYM+0Pu6AKfSjeF2lPWb5xrE52ZJ4PPJJ+sTxsYKKEiKF
HQZq5QUyJeyB7P9JNReAbG2JN67vZq2yLtzYJyRgAWpd4BCCDQDPtQDR2aNGLvo8CeJ6BaHk
qsC2/oaoHcsOYQS7dv2xqIJ7toR+RADDwMhxzOo6iujNQZ65XpInloc2CxtzndXpBRxx4iVm
2Sl0aUINhLJJPYdQjZB+oVTUJvU9Wn2IiVk9HOqMVmeGunPfkeacZV1b4CzrvQYsWlxKksXy
HGhiOZVplET0W4eZZ3A9d23ynIbE80lxfk78OPYp+yyZI3FzW+KNS/qSkTk8YnPJAWIKcjo5
VgVy3aX8amm9zAqk9kDs0gQUya7PJAim22FnQwoSms6mV+7755mAhjjTGeeIcfUlrQwChoMY
Sqa+V5qwoi76fdGgyfxo4XbNiyq9u9ZS6O+JWTvqmcgY2BsfpKC7tY4oIy9EsOJ9iwHwiu56
LpkalpVg3KVlL+yPaTspIgk+j8BnqRaf0lSS8VC8qtosHSyhwKd09loRjKvtRAb0mcf/905G
S6NsOf1f2oAu2lM9XvTII9k+ahTNxGMmN+05vWvld8czJExCr9u2Rbe5ODpyggtfHvILbMzE
ka4wJgbjelW8fb9/e/j86eX3m+7749vT18eXH283+xeYKc8v6pXZnE/XF2Mx2GX2DI33vovk
aHfDnB/Zx+OJFMUjcUQeaWS6bE9X0p/zFOqQy/0tbjvMTze6PjOBj2XZo22HiYxxJggkP9N1
hr28f7ms90palXUMCz7Wm7JAiXzHKdhWbVY5ZO1IWWw+kDZ7TLV5uRLXlGpu0LfX1HNH4nS7
969f718fPy2fHqO4yoHms7LLqFZDLrTLGgat6FrGyq1iT862yg+Yy70cp5qnykoelJJMPaE6
EU1w9VTLaFVYLJVFVxkr5U6wShVmvVgp/ujBVrjKRiscC5vFJGyb1SlROSSrv0RMT7x9pbln
XK7mAjDS/zfHl3ZoOU41Rw+/Wd1YUOUySSCjG6HFuPW3H88PaKhjuiSdxu8uNwJGIi1lfmwx
mOzqMhNmE6RXY546HbwkdjTZjgh/duvIejOnSqYFcjaXznMuFE03HkakBhnTU9YLvML8SlG2
NJqIoacWMIpaogCOUJuLCYw8KglpwDqCyg0lb0Tm+he9e0aieqsK29Brl7IyU86LkApsIKeI
QqsOQNlyFQmKKSuWxq01srpVXFUhYJppIDVJupoOxrSgIZkocihrDPEp9avPkapde87UJDCp
ycaJzTECZPJWbkY3dKINvYfi+BD55Ek4B6fFV88VtIajNcsu24UwcGwjRzbrkMlD6NjTzPYy
ShpWZIaZpQyXQRxdSBHB6tCya+To7V0C35C6oReJmTSW0+0ldHRxkW5910Zsh0793qDMZar/
N6QOJezrfT+8XAeW0ZdmyCYMjdQM8Q4/SYgMq3rls6VVnVoeUHUscp3QEu6KWy2Rl7ACijWJ
QJk5LXTLNdXUAGgZGShlziCJjKE1mkfZprlpPSVTVcE1IiAz1J3+cK4Cx3dso3E0uiLWFHTr
FfvkGK1qP7TOCN22C2mnSyIbIPAVR5jFkURqmchYEFcedfDMK1uHrmOsE0i1di4o4oRU4lTq
yHYEA0dbWuYzAINGtQKR0LG7nZhqoHnQkN+l2JSPJZe+2OOekbwUyUbBJFest8sqdDI46e6K
CvT18dPT/c3Dy3fCs5VIlaU1vvFcEks7J8TTJq1gnzecqL2BxpuX+3KAzfDfYu5TNNqzbzjG
RuW9VDe15hiQ0wK1ZjznU5kX3Cm/TjoFlQcZbfEFqOKTbIHlbhHUND9ZXQ8KDuFNvS4b7tyx
2cv2CLzIuqg9+E+rEiK7cyMed452zPgNiccSoq2onK/1NuQoOekzgyUrjHOdTD6Ji5v8Gc7n
xu4q68ykCbMlk4gfkQbwVSN/0RgFet9DER717ntC8WWsMqVxpPytLsDRtsYoXCyIiQRb3LrO
fubOGscXLdLWgtdle9x5mshe6OO4MujQ/W2ndytH8lqM7HJP5lfzkypydA/dXh1N988PT1++
3H//a3nJ9PbjGf79J7Tz+fUF/3jyHuDXt6d/3vz2/eX5DYTb60+69MBp05/4yzpWVEU2Sx8U
ncXzw8snnuenx+mvMXf+2OKFv8T5/PjlG/yDj6XmFyHpj09PL1Kqb99fHh5f54Rfn/7UpoJo
63BKj7TvzBHP0zjw9V5H8iZRbSJHoEAfaCG9CEgs5FZQ4DXr/MAh8s6Y71uuJiaG0CcdNS9w
5Xup0Zjq5HtOWmaev9WxY566fmC0H5ayOA4pqr8xK37qvJjVHaVDCQbWNnfX7bC7AtM0HPqc
zZ/T/G4sTSPNox9nOj19enyR0+kiOFZ838pknxTZceTQTq8WDi1+n4Jvh0S2E5qJYUQQI4N4
yxxXviscR0iVRFCxyACgV2LXNdonyBfju2d+mMQB0e4JQTG4NpJPXegG9s/K8dCoDpBjxyFW
yOHsJaStxQRvNvLtrkQ1Og6pZkecuosvLNykwYLi4V6RHvqw4f0XG/2XXbxQCAEpt8fnlTzM
T8nJiTGT+IiM6YFqzjsk+9R35MCGvvBcOELLwdXEsfGTDe0kbeS4TRIyVvn4KQ4sEa6LxTS+
//r4/X6U6qbbhDHLTgTAUWOECqysL567NieRIVyTk8hgcWU3M/iuJVT8zBDS1kWCoT15ERlD
b4FDQlIinTQlk2Dj87enMAqMkdWeRrs/g9ccV0jdEPnGipfomRp7xlwAakSth0iP1xoUxwFR
nYQQkO1pYyliE4VrRbh+EiaGKGBRJD//GSXrsKkdx2gzJ5taAJJd1zWrBEBHB+mb8YEuZnBd
qpiT41LcJ7pSJ9fkZr3jO13mEx3YtG3juBxcGdF1WLcVqd5zuP8QBg3RFSy8jSweHSWGNREF
DEGR7Ve0h/A23KY7vcXFkBS3ySR2KpA35nH+JOLCxCM6Jr2N/diuT+XnTaw+hJjpiRNfT5n5
knz35f71s1Xo5Z0bhcYCh2cykTFHgBoFc9wesfY8fQWt978evz4+v83KsarNdTlMId81VEAB
cBVo0aZ/Frk+vEC2oErjyQSZK+picegd2JQa9kQ3fG8w8yvbJTTMc9V+FfuMp9eHR9hiPD++
oCMMVcnXVYUDi33yUdE0Wr14Y3Sadm4zVh+db3ZlrtsOSQ9E/x/bEtERXWm2Y3I8pWPqNmk4
NvwoQjT9x+vby9en/3m8GU6iZ1/1bRXnRz8LnXzhJmOwZ3FHn300mnibNVA5UzXyjV0ruklk
O2YFLNIwVt/4mTB5UyBx1YOnXpBpWGRpFMd8W9mAeqTVqsbk+paGo7dv11L0JfMc2ahOxUI1
MKSCBVasvlSQMGRraGwce41oFgQsceydgTPWEh7IHArkEzCZbZc5ynpmYJ6tIhwlz6fNWnh0
AYW9C3cZ6I2OtROSpGcRJLYfPY7lH9ONsrqrM9Rzw9hWRjlsXPquQWLqYbEijl3nD+07br97
91v9Uru5C91Jbl4Nxi20Wyx1k+cqQiTJsur18SY/bW920znQdE4zvLx8eUXfGLAIPn55+Xbz
/Pjfy2mRLCBtGXGe/ff7b5+fHl7NM+p0rziOgJ/XMogo/RChQ3f9eJGVpX16TfutQeCHi/vu
yP7tSt7S8p72yJLjWWCn757FygpJlvV/bqxMnmwOb/4hDrWyl246zPoJfjz/9vT7j+/3eFOg
5PC3Eggt5DvswW5+/fHbb7D45LoysttesxpjDEjrCNCadih3dzJJ+rvsa+5iCIZNrqTK5TeB
8JsboZ0Klprn8Fgu/Lcrq6oXx4IqkLXdHZSRGkBZp/tiW5VqEnbH6LwQIPNCgM5r1/ZFuW+u
RQPTotEaNBwW+jwCEIF/BECOEeCAYoaqIJi0ViiHu9ipxa7o+yK/yhYHyAyDVfHCgrVIs1vu
9kih8siPwseZmvVQVrz5sP2ez3+V4fJ5cnBE3C7g9yj7nnzAAlhXe0pZ8Bu+0A4UZoy11zTi
Qym53W2L3rM9cQCGlJUV9B19jcGHBhsocQ3QEUehUp859oLaqSD9VBMTnAzcKRlBUq9uF7IW
sWwB6O/Tl6dU6wskWTwQTugSHE8D5kLoxGWs7qtxgKRD31ILEWaZ5kWrj3ZBXKmgwOXmEslt
92P4qYc710u0ZIJIt0/js8wvX/3YviGxWHoSb1/l/ATRetu7cKRZVlA27chRagOtZFfFf85E
c0Ot9KZoQUyV1rJv73raTRJgfr6zfNZT2+Zt6yrln4Yk8tQuGnrYNTXqcE37W21m+/pMhgVO
i/0ujb9tfd1fhiDUWo8eb4+yFT0OzAIGZtPW+hdBr0meJUwo70jcGFnROnbp3R+5VHKZt71/
+OPL0++f327+46bKcjMa1FwAoNesShkbPdNS9o3TAFYYl4YvuOHHaoG6c02RZ0u+xdpSwSye
iKR862QTuNdzRUYXXvgkhz4GluZdkpBamMYjH05KkDCQpCA8CPGd1AptSKRLwtBSVWHJ9E6f
2Kxkl1xOoefEVUeVvs0jV7W1k1raZ5esacjB+M6Qk1RWfGYiDZ9DLnvdq9p9q/7CF/7oMBUm
llwrCYI8LZGdJKasOsKumbZwMRT2qXzWHhv1EVKTG1rzocxNTf+gOTYp88V1z9AXzX6gA9oA
oy3CyBELMj8rZr1MPHG08+3xAR2HYwJCFcIUaWCNDsThrD/S8oqjnU1ecZRZ/I5z8IhBP63w
tqhuS1onRTg7gG5JO0QWcAm/VvD2uE/phy8HbqORpVW1kpzvPO2wiNZkxeHD7tumL5m964oa
NGp6e8zhqrCFh+bwR1ucLDFG6m3Z0xFxOL6zbBgRhIztQZg4w529Vee0GlraBxnCp7I4s7ax
qAy8ane98RhJYSjxTYodHezYh3Tb2z/pcC6bg2WPJLqlYbAZsUVOQ5YqM5yJqbglcp3AmvZE
a0scbvfl6izmihgPKrXCUqHOsoLf7WDVt5cBWz0+ru05lFnf4qsoO0eL3vBXhi5GSyrXx18z
0GFuEMNo1XSULEQ72KKBWKnalbnRFUNa3TV2idiB4MFVz4pjOLYeB7ldPnR9ibFUbTBLy7Vm
sLRmx4Z+W8Vx9Lekx2RWOYYitUsAQIsKg0tYwv9xnmPTVSvCH9Rs+xzHGGSwZbZPRh4g6UN7
t1rEUK5MGJBCrFiZbxhue2/vguHQH9lQgwKzMp8xAMn52jH61pCLw7Ks2xWRdCmb2t6Gj0Xf
rvYARiXO1qa0eBt8PRxpuwm+SledVsB0MURoFosPeUURmjPkLuvLnMzPSDbHCpOIk6ZzZNtr
e8hK9Wxq0RYRN07ukMgjzB1Sdj1kilamxdeTUoh3XCL+LDDxaECLJjXTu89/vT49QH9U93/R
HsCbtuMZXrKipIPLIspddZ5svq1XStKySfO9JUTGcNdZzKUwYd9Cd7JzOVgkLPLAQoX7a1rC
IMOx6kprzJnjmerqWjauhR/XLTq2JkjC8Jj9O5k1c7S21mMQITsa85q3t9yyVRi3HjCIQbYE
MTBi9mIu2pEYklh+UN8FzsSr9s6T4OCv9Mn2T1lUw64mCrzu8F/fUaEUY5irpKHc1cBqVhD2
Be2BjhGGDNk2Vl3BIPHETdXhL0uiI9SpjGDUaPVC3R4WKf0FJS/nlwP5GpbXvWWHcptSyWoy
SNHSPRdQkSQRUIMGjTEx1RsoQTMP8CS/2uzt6eEP4knllPbYsHRXoH/bYy3fYeMrXWPUspli
lPD+6JtK5B+0Zmbbrh+4StVc/eRCoH248Siy8mkm6VScp+Df044ZfolzHmWzPVOvdm2QM217
PCloYB+E4YwyjMxTmFtmVHqNvubp+SMfxyibk+mzoAmPLK5eOS7ccq8wWL23i+zxURll/Pm/
lT1JUxvJ0n9F4dNMhGcGCSHg4ENvksr0RnW3JLh0YNBghQ0iQLxnv1//ZVZVd9eSJfs7zGBl
Zte+ZFZuPfZs4rYZvWpp68UBT7MJPd4TlFHhLyynPQt7rgdIH4ZBDymrQy0v5B41Mx/oBFz5
GuFTjufAF2Tyec/XRNtjV9aoPxTKJRVPLk5sMhU904Jilu8z8/VKwtPo7HK88baEcBbtl93Z
D+9XmjuotaxH/+5fR1++756//TH+U1zgfBGOlKz3jpG6KVZq9MfAhf5pbYxQpAJ1WpilG57Q
d7LAY1gQX/ulA+QQDKrvQ/26e3x09ybe/gtDKaeDZe4tD66AE2FZ1B5sVsfulCncMoFLPkwC
Sj1kEJLaG4MiItP0GCRBBAIEs3KY6gSet1WDpgscMwzq7uWAqTneRgc5ssMqyLeHf3ffMX3M
vdCFj/7ACTjcvT5uD/YS6AeaB3nFrOx3Zk+FF5x/VXR0ZeB7djHI8qSOE5p7tYrDF05KW2wO
chOb2bdQEYXhGBgw9pQuTGRPAwbBfIsdoDL4TUYmmLWpZF2ecpJN2WUGXiU8rMQF2QQk7+ZU
r8e+1ZBCc5jhv8pgwfQoUBpREMdqXn+BbiVyTtNl9TIK/BibrdV7Pjd0unCsTDU0OfV6HyNM
EvgrqqbyrTb8uuUbSvskUBVbe2aMlQXzJUnviSpeHp9AIKjJYWGVka7SRBj7j9eR5JCImmIM
Z4FKM2PdDVAPZ4pD6ljA4HAk+cKwgEGY0kcKlitP0srEqlw2w46TqVCzamHNW9/TOklbBkg9
euU1XBUoykOB2SIzuj+gqP6vsRGuC7CCH/nC4FYBmBiZkxWgy1zYD1rUZ18aOowpL9t603pa
mGGE7docNDnMLQ+ELqcrPWzmo/0LGixZCTXRokcPjbMWUOO9QX1OCflWyV0pQbOJWVWmgWbd
tIyn03PdUww9sfRMSPK3SEr76eQH8EkWQkRu+9RnO2IZjk/EGGqDh1K6xGRwSejpMcXPDjnE
flNgXohRODPBUg6AI7KqjFjdEivsrjrchw/DeGEqAVRQh2lbeNQiOgl18Wh4IblYdQ8/FaEx
XR6RYDX3OGVy0o3YzOquMuUC79g4QGO1DzB1Jbko48pRwBDdZk0LGIVhedlQXFTXooxqZoZZ
faXFXTucYcok/v51/7b/9zBa/nzZvv61Gj2+b0G61Z8AuxACvyDt90xtXZFwqiQxs3/b91gP
lXwX7CO4MW6T9ir8NDmZXhwhA8ZfpzyxSDPMXj9M6bDqJDosPFejwttvUSa220JuuawKjris
d5/DwnBWm8JdTM7OzNWkEMBIMCqkm4YNsOCxdN6xG6YRnHkM3whKj3KeoCRDPLt0M93izUFP
DMcjFz0x0hvb6NOx6W3jEtBCt0u3IVuZ4rzMJicXZCUCe74hZWaT6GI8m/qLuPRlSHXIKHv4
nmiFROPzMTVgCucZrQ5Lv284ZEfnXRHNvK1oLXmiw2ZlGiEOZtz7RmvQltHkdPbbpLNTm5Qm
ZJMJOVU92uPbpugiVI9GXT/91cVBhZc+sevj+vSEWPTxTS54p/EJsVIXcPIty5gRDc/ms82R
CWNRKTW2xKdxcC3SaNp2sybVZ35qvwUrzBWmkW3yms7OpcZLqG9gNMgN0mN/WUAceD/PfuP7
TBZgDV3n4eGMaYJjc2wZ5KydnU0ohyOdgJhJhM9OaPg5DU+DsIw8U5CLq+foSpQkGbkpeR3T
sQYVvppNZu6wMd1ibKgFWJRITw7aX40Y0dJ7O8L8wPyNZ21EXepyG3n09EPVMFvtOYY0O7IQ
FBmeQNM2chvSjzSNE7yXi7luArT6wKJLCg+X/5QCnhGdFYxCRUlE3YaTfw3LfX2gvH3yTBcF
5kWjTPo1aTpNPXI9oC7gXiET3fG6OrOu1lU9m5GBHqVp7Vnv+1+9bO++vb/gO9zb/vt29Pay
3d5/NbwiaYqhLsW+to6dmPSaeX543e8eTKl0CTw82c0gj3mB1lF00FGma73gBzpj1EmGz6XS
xajzvFGV9r1mPFnDfy2achjmy+u6Fknz2rrAoFfImopoRQ4+gvNboU+HjLlVOy8XAYpyhgiV
M2hYVXqs7tYsjcZwIAp1LqXnk2Flh2cpjMIa+d4iBTb3KMAFUjjV+tG0g8BVdW44Sy54cmNl
SFGg1hevp8Pj8Miovs6ntHFnh3UetnsEGQB6wBYlvos7jbdjwndgHqypWlYs5J7Qbn3XOIsX
SYyppqkSPO/mHdpyfu5buaY3R4e3l41DgBYCzkZc3L192x4oTzcL07US493D+taO2g7iurX0
mE1Q1/Sq70maKmlXGWyqEgae7qmiFQIryz8nkScoe1+mTF+MEUnRVOvTGVHtLaONMecsSWMc
NWuDSQOfKs5HUWAkGxhuE4C3wcqTAh6+bDGs1oItgsqzPZc3WD5pIuRUrH21rkqW28nQh00d
sDQkPYVYkWUN/H+lv5YLmBEyT4KsSISL7fP2dXc/EshRefe4FcqdLpCasZ5+QWrWI9bS3NRN
KIRcAGVQVfUSrsvFkuhTnAW8FQkW9Bdr8Y6LpZgP6D24q9Xzhq7TdVotZ23w7dP+sMWoZq5W
nydo7FbyItKvJeILWdLL09sjUUiZVdpzhfgpXuxsWP/aNtRklNg/NKFhP96D/e2/f39+WO9e
t9qLu0TA9ftH9fPtsH0aFc+j6Ovu5U+8+e93/8LExqZNWPD0ff8I4GofGduku4wJtPwOWYkH
72cuVnr5vO7vHu73T77vSLxMo7op/5m/brdv93ewGq/3r+zaV8ivSKV+8+9s4yvAwcnjZFNO
f/xwvunWHWA3m/Y6W9AnqMLnZUIfGW7hovTr97vvMB7eASPxw5JBI6tuvWx233fPdvsVpcqp
sIoafSFSX/Sc5W8tsqH/pQizOecJlWQ+2dTRoHpOfhyAXz2SsEKSw70QXE7J8E6KwLQOUUAt
uLddICYr88WhGkhEEHB/pVpAcOJjtNnwf1vWuRnhTcF5fXF5fhoQRVbZ2ZknS5Oi6Iw1KV4V
Djpu8D6MpMvrUCeCn21WUa9IiGF6fgoESCPN2gwIigi4Bxdl4TEAR4K6KChnT/FtwudmNULX
bL9Or7LEtu/s1qNutAM/ZD4WE2QH5kaYMC8SQcPkocCvRbwZSoXg4PorrgQGt7UYcvHI1GIC
jok3Bx3KP6g/jmqPQ5JMaQ8/VPBd594DXheu8i9vYuMO+195YylWuGtRlLVXGGUaltDE5pLh
Z1tugnZykYMIVzFKDDFosBD9cDFbohWMbD4wTzR7FHkkbPNxyxJeTfl06GAnsIYsjzFaiP4E
YOL0lWF91amYPnzZoXnMx6//Vf/4z/OD/NcHf30wp+lcqXG9AnDKwnwVs8zMVZ+idehKaNSo
PYL6Q8OmNCQ992XB6Cylq98D7YktXxk6O/Gz3yzSm3A9Orze3e+eH12nwqrWE8LUGapba1T5
VbrT7YDAAA3GDkZU3GQZZWSDOGCLeIRPrHlVGLrsAdfbY7n8pO3S2Jnyuz3SZI5y4Ukzx0jG
vUqZk54UQNL+wJOjDVvHoz6IQyezyHdkfa1Yl6QMMLHDlx6xr/TgYkHK4qBOUJwqA25YiQgh
LAuMSC9wfUzaOXV0AubUFC0lADPUsE0bRKmLqpKo4dJKbcBM7VKmQr6cF1zU7tB6KphaFehd
mHpjIHwOY60G/OVElajaLIyCaKktK56gGY0lWvdAINVfLno4yhJoimO8LmtFuZJ31yyrps/0
IHz2DMDnOWGoo39DpM/bdFX2pSDkuilqetVv9CYR9SDevJQRUuRCP19F3OPTg0TrgNM+QRuq
X8NLyrzyrNwikqihtx2kLSZRSIBxhIzBkBhROfBz1RX9mqVTmYMZ1nLKaaaHpd62zyfWWhAA
bJ8L7VaUXnGHODZXHY27WwVGLG+iNvOpx6gUTabJABmezYwMnHkoSIjyqTFD97A0aRFs2F+g
3SI+/N148FBWkkf8pqyNB+l5ZUdkim0AkwBhO6l9GNh0Yq9YP/GRF82h5ck+D/RoFCUHoCLD
JW80V4Ktk0kCa54YtmnX86xuV5SmX2ImVgFRrQ09BpCfV+aJLGHWAp6LI5rcXauEY35NY3/1
MHS7ZRg9qoU/xwmCdB2IQE1pWhiPuxoxslC056lGtIEpE734FWGWwHAU5Y3DREZ391+NaF5V
dyFoa1yA5FFBLnWJX2L+9QUPMupjb6QehS9C3F3ACuoWfwKFq7yiYO5Dr4brG0PyP6rXcgTi
v3iR/ROvYsFYOHwFq4rL2ezEWiWfi5QlFMN5C/QmaRPPnfOwawddt7RrLKp/5kH9T15b7RqE
hQpofEftai4OTlK8tA5aAXAGU0D5mmy3p21SAnvbvj/sR/9SYyn4BEMKRcCVbYQqoKvMk4tG
YDEhVZ06H5UYRCkrckZrRgRNtGRpzBPtbLxKeK63yhKV66x0flKnu0R0F5MCLpsFnIyhXoAC
icZq53oishvxJDAV6/jHVnXM2Srg3Yrs5E133Pui0WZO7AuhkdSPL5E3xjkDg9i5wzvM3G6L
uGpokLIgNc77pfU9/EbfaZuLSPxMROhHuV/1zKDNGHUQtfC1DLY9BpMjA3I+9/iWS8IKhLeA
U+JbX5DDq/SYY8xKT+RyKxIF8pUIb4K65kJc907/bg0rAQlLbwu3LRxdhY70EthYTxAY1RYR
IjAv8mOFSCJgBwpOe5XoZGgE6rZT4ubBCkRf6AhtEQLHPrkKqusmqJbGTlcQyUs5V5+Jlrf3
kXJhLeGctBiAJKULUhTCGIsWsilKfA60XKXcD3wyVk+gFoP7ZXpL2Y5p6IIYsc0tAbytTL+x
HjEVrzn4qIPzerwjSRYmcUxGDxsmhAeLLAG2UvEmuFhO+6eAjXXIZCyHbWbwbZl9DpUW4Drf
TF3QzDkrFdDH4PChpkEyFjC0AkjiNryRvD/97mdRZjU1Kk55Ra1Z1UssBlM0faJ7uPT1665I
4Jus21hAUNmY4vNKd+pQ16ukhPXSU9kF41o7ilxGfvTFdOJH4tLzYzWE3TG9uZ1K9Vjnpg41
WajeE6pY+wu9c79Db/T31+122vzh+/+mH5xSI/nO6C/HVPsqoMX0A5uxou/hxtpR8re8aQ2e
+ciOAklzXfArmqHJbd4WfuuCofht6K4kxHMHC+T005NJXq09z/eSvKXtvDn61OS+lxHRbnGY
efEomCpXyDgnOXtFhPxskiKR1VHangmEdbxgWKEdA3hU2D9xJIyB7N2Uu3lvcq7rGOTvdqHv
RwBgTlyAtVc8NAwgFXnMKrSYAAlYMD4YVCbCWCmehHrqI89iUehNyWvht6hx1km5tM5lBXJm
wURTrH/E9EWHv6S4bHpsIBh9gdZD3+R80mwMkjclBsDz432XvkDaPjk9bEIBUQ1RdpoSs5b4
N1pSZaGfQxIUw9tCL9zEgfkgY+3egBJMg19slf6jFka4IuXAy9KaeQHwzbtAGrNuftcz6NSW
1N0+4cdw/O7e9hcXZ5d/jT/oaMwsKYTY6em5+WGPOfdj9FxfBuZCV7pbGGONWjjaVsAiohT+
JsnsxF/HjHrQs0iONJFM/26RTH19n50dKZjK5mGRXHoKvjydeQu+JJNPWZ9PfAVPfVVenFu9
ZFWB66u98HwwnnjXxFjm8TLaL7xRvauhq4y++XQKKn2Ejj+le+Hp3BkNntHgcxp8SYPHp/YY
9BhKXDIIrHZdFeyi5XZxAkrFv0AkuloDh26mCegQUQJCIe23P5DkddJw0tylI+FFUBvh2nrM
DWdpqmuwO8wiSCTcqRCjBVKBoTo8g0bLcBE2Im/0/AlG58nW1Q2/YrrfMCKaem44GcQpbfra
5CJ7L/msaSiWpanh9v79dXf46bqX2/ck/m55ct1g5mL/5YQZFBjwrCC5whec5QuKkQuHChSk
xjiHSWxBlaJngOvNaeMl5iiQcVrJ5xB1bbVxllTCtqbmzEyqQN1sDtLD0grlayS0SfhoI9NH
EM3orFiH5gTawkurDESV/f23h/1/nz/+vHu6+/h9f/fwsnv++Hb37xbK2T183D0fto84Tx+/
vPz7QU7d1fb1eftdJKDYPqOlwzCFWgiw0e55d9jdfd/9r8uQouplOauxC9GVeNXSB0WgQG4W
2ZA9RrgW6Rw2hxmEZnDEptvRof3d6C0V7TXas1e4NvDpRioNXn++HPYyU/u+yz429FcSQ58W
hrm1AZ648CSISaBLGqZXESuXumrRxrgfLY34ABrQJeWGk3oPIwk1wd1qurclga/1V2XpUgPQ
LQFFcJcUTjm4c91yFdyUICTKE0HK/LCXo9D8qnKKX8zHk4usSR1E3qQ00G16Kf4SDRR/KGGz
G4qmXiZmIA6FIWNFlu9fvu/u//q2/Tm6F6v4EaPD/3QWL9cztChY7K6fJIoImCC0m5NEPK4I
v7H3w9ft82F3f4dJ2pNn0SpMePjf3eHrKHh729/vBCq+O9w5zYyizJ0OAhYt4RoJJidlkd6M
T0/OiPYFyYJVMJGed3CDxiO7aUSTM09YALWwCriErDS1JA1URrqTSpIquWYrYgKWAZyWq+64
CvHMHz3tH3TtdDcwoTuBkZ5gqoPV7raKiL2QRCExtqmt/DTRxZwKn9rvDKKJG6JquKfXPHAP
i3ypzbo1VRhit26ybqSWmCPUM1BZ4DZjSQE3VINXklKqo3eP27eDWwOPTifEbCDYrWRDnudA
XI9PYjZ3dwVJ7x2ZLJ4SMIKOwWJLUvzr3g5ZPNZzLWpgI9pBD57oqYcH8OnEpa6WwZgCUkUA
+GzsDiGAT12gmT+ng6L9TEiab3WH7YKPL9061qWsWbINu5evhitFf2BURJ0AbWsy/oLC503I
3F2QMhER2p09EhimxXrOiIXRIYaHSediCrIEBBvSu7qjQP7detjUcO5qQqg7f3HidnPe3ZfW
GbAMbgk2qgrSKiBWUXctuB8kSUytg4SXIG8cOZCzKfFZndD2kB16XeBQuwZFQ/pfZ80oFZI7
/bqCUcEupu7CTG/dxSAULQ5U6SGlA9vd88P+aZS/P33Zvkr/P4vX7xdnxdqopBjJmIcLK0CU
jlFHqj1GEucLzqsTRfQj7kDh1PuZYWDHBB0hyhsHK+MqEox8h6A56x5bDdwuxXwKGu7xbLHp
UBzwdw7b4ZgOd7g18V1Q3WSY1QtESxRyUTMw9ENDlk2YKpqqCb1kdZnRNJuzk8s2SnjN5ixC
xWdvVD4I81dRdYH2DCvEYymShmh1V41tmY5FnHeR1jxY5InxY0MwZ4scXbsTaZqwSrhsJiN8
QaPt6wG91oAjfRNRcN92j893h3cQBO+/bu+/gVSph80TQQu09wZu2O+4+AoDxJnYZFPzQB88
53uHQqrwpyeXM+15osjjgN8QjdFVjVhcmIpQs1X/qkKb2/3GQMiIu7svr3cglL/u3w+7Z52x
Qs8mYzxCBtcsxjTR+th5G+VJ3TY101UAUcFjneuQrzN61IfeVSlivdOChbLAIpcC6v2irNxE
S6mt44nBTkUgdcCJYYDGM5PCZcKgqrppza9Mvg5+mj4+JgZ2YBLe+MQTjWR6jCTg66AmNXIC
HzK7ajpomcVLRNpzMDAgLicbaWxgz7oO6twgj4tM6z5RJW2wgFBp3WPC0T4Hj0LzjhRQ5+ak
bSwQSpVMG134rC2QmmwfbWEhwBT95hbB9u92c2EoRxRUuMWV9Ju2ImHBjF4mCh9wylNsQNbL
JguJqjEWCuXep9Bh9NnpgxWZtO98u7hlJYkIATEhMemtrpbu9rh4XEQ7f+2sAP6urYq0MHhT
HYoPwhceFNR4BKWfBWG0NH4IoxAMdcAD3dSihjO8SvDwoWDtVVaS8DAjwfNKgwdVVUQMjsZV
AhPHjUirgfDl0l32JEgERjXORYQbKv9cdFpGkk1Fwj8LJ8LoBmVr5UMUDRQxe0XQ53Y2DXWN
RZ/LRoScRTr08IrKhiBBbFQsBefWoiw716ayCxpsuoFUa1bUqbFwRVtK5rd6WKRyAWnHWdmA
WKoPT3yt3Tp5apotp7xpbW19eouxLAYA49coi2ulZKUZlipmmfG7ENnJFnBPc21KmwjNaGuT
z5gXMEBu0m+EXvzQV6sAoQ9Ehbn4NNoKfW0LrXXiNT9OSj3ofQUzaYyKbAfpt+pwBaaeoWOk
BPTldfd8+DYC0WP08LR9e3QVSMIr5kqE6Dd4SglGWwtPRD1hoIVRhlLgO9L+KfvcS3HdsKT+
1IeN6phNp4Tp0AoR/1c1RYQmpvQ2N3mQsUgz0FDj5O17LyDuvm//OuyeFNv1JkjvJfzVHSlp
zKFkBAeGbjVNZEq+GrYqU0ZdzRpJvA74fOr5PqzpKMeLOETvPlbWHlP0XDy+Zw0+J6BfGeX8
AgdqIlyiPl2MLyf6EizhDEQ3ZP3A5SBIiUKDyjC3a3Jg/mIkDouUDHZO+OktoTDgWtESqfbZ
9aBReYaxeBl6M1pctVF2JV3j0NMgw1C22n6yMKK76B554w44HJsRjEcSXKGe1E4OMbDxv7uC
+hWPSRdRVODX2lk1AHvNnJy0Tyc/xhSVHZ9NNloa29lQdLn4ZCQbGsXbL++Pj4awJawt4A7E
nJX6nS7LQKx1iluIbpU56ixRcLHODWFSSJgFw8Se+klrwtscX55yw93AosB8d3aTpP9W5c6p
QpBcsocUlaXeldYRidQmlacZLRqI+nA8asTq97dVWtsfCWtqkluTMDapVplb0SoTb+teK4Ge
ilM6hh5bLkAqWDiDIMOeCN2zW7XaWMjmUEfFVQCTL29K6IitpB6WcH/ZRJLzCfKoWGGMErQl
dRZstWRi60lNAhYySvf3395f5MZd3j0/6pltQHxtSvi0huHVGWBMWeoijUtLMKk6YWnnU/kl
MUYSaBLdI0hW1i4bWPx1UNGm+uvrPoo3eWr5uq1d/aJ2dOYpyLkx8H0rDSTuiqLRcgBUsMRi
2xBUAs0LVcAcb3BJKc0gkjx2bzJrdWH9V0lSWneFfFRBhV6/gkZ/vL3snlHJ9/Zx9PR+2P7Y
wj+2h/u///77T/vuR86+AWEhcdZ6F2zOXejqA+/+4evKsByXUJC4kKepUuiEW6ZytpZPpOpA
8+TaQm9uWJ81Gvl6z731WjbTczp2fOf/Y+AMXldsR70X4u6FmwNz54G8A1MrXzGOzOiVPOV+
TQHsSZoElf/kVr699nmEYD9fsbAnSDijMyv4vzL3BU4QxCq4o91gOXDoUxewPkMaowU3BAZg
au1XLUT4JlUjwfNVcFX9fpyMdXw3LxooudYtnbtAeUajzXGA40ayS7wTNa3RkAEFgLlAxyt6
/rCdSzgG00ZaayVdZCXKjE+Ne5twDtKtHg2hl6AxJRVNqDfvSOTMYftAY/LoxspR3sv1q6Sd
N7lkLMVg6g63iO1kk7k11PJTeU1l4n6HZYtvstqbhEBGlq8UUMJUikmX4YRzY8jTq7imd5F4
vBcv01XB6WkQJF5s2G1kcUj4zxIeor73CF5/8fFSifANcLW0xwtTHJJnD8hDdDYlX4ZFb5fJ
Br0NjgyHFMOl0SB9xHZ0VVTS9olSbwIUNRm3SKCFjDt32idfBfylAl6EZvVTNI2dX1nHbsSr
lh+PoRvmaUEboAgKju/RIrSon8arehRYFtMKXrlir44sZ+BdUfo40nnU/dnxJqwRLGm5WiJR
nbMsBFNNB5aeM4wAxoAUzollFnBKvhZlzRnP4N7TDgG5cJwAArLlzmuHvd6EUSuqvY6suaw4
MvfAnkcBrDxfg8XVbTPv3ZcIJ4sGnHe3CmElb+OgxsdHzpvSe/BWmAKD5JqasDKN0QUAxcUg
ZYs8o00MJFFP4Y434inD2QCOjwVwJw0sgvHMfLcXSBlVBk0neExyecr8cbU0TRTFx4phkPoy
+iAcyDDOIcWXWS9//wdTkL3y+5ABAA==

--FCuugMFkClbJLl1L--
