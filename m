Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8790C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B5220768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgF1BEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 21:04:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:27985 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgF1BEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 21:04:53 -0400
IronPort-SDR: tCyP/1law71D8PMfX6y0+aTh5iXlWmEjwtVrWIrGY2Y9lsM1F/3ytngX+/l85dNB+yW/dudzUQ
 bZdscDky2ICQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="147294836"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="gz'50?scan'50,208,50";a="147294836"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 18:00:47 -0700
IronPort-SDR: Np5DVoKLAgBpoy2cpp0PbWO2QC7GPVa99se4d7VYEbRZIEwi1BeASyGnWQAAJF5T+9VMc7/KgW
 OsT5netZTLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="gz'50?scan'50,208,50";a="480385824"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2020 18:00:45 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpLga-00032U-VR; Sun, 28 Jun 2020 01:00:44 +0000
Date:   Sun, 28 Jun 2020 08:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/serial/8250/8250_fintek.c:104:9: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202006280839.maZO7VGA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42afe7d1c6ef77212250af3459e549d1a944cc8a
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 days ago
config: riscv-randconfig-s031-20200628 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_fintek.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/8250/8250_fintek.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/serial/8250/8250_fintek.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:104:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/8250/8250_fintek.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/serial/8250/8250_fintek.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:105:16: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:110:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:110:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:110:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:111:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:129:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:131:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:132:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:132:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:132:9: sparse:     got void *
   drivers/tty/serial/8250/8250_fintek.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_fintek.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_fintek.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_fintek.c:139:9: sparse:     got void *
--
>> drivers/net/can/cc770/cc770_isa.c:125:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/can/cc770/cc770_isa.c:125:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/can/cc770/cc770_isa.c:125:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:125:16: sparse:     got void *
   drivers/net/can/cc770/cc770_isa.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/can/cc770/cc770_isa.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/can/cc770/cc770_isa.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:131:9: sparse:     got void *
   drivers/net/can/cc770/cc770_isa.c:142:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/cc770/cc770_isa.c:142:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/cc770/cc770_isa.c:142:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:142:9: sparse:     got void *
   drivers/net/can/cc770/cc770_isa.c:143:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/cc770/cc770_isa.c:143:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/cc770/cc770_isa.c:143:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:143:15: sparse:     got void *
   drivers/net/can/cc770/cc770_isa.c:156:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/cc770/cc770_isa.c:156:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/cc770/cc770_isa.c:156:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:156:9: sparse:     got void *
   drivers/net/can/cc770/cc770_isa.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/cc770/cc770_isa.c:157:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/cc770/cc770_isa.c:157:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/cc770/cc770_isa.c:157:9: sparse:     got void *

vim +/__iomem +104 drivers/tty/serial/8250/8250_fintek.c

92a5f11a1a3357 Ricardo Ribalda         2015-06-16  101  
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04  102) static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04  103) {
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04 @104) 	outb(reg, pdata->base_port + ADDR_PORT);
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04 @105) 	return inb(pdata->base_port + DATA_PORT);
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04  106) }
f1232ac229cc07 Ji-Ze Hong (Peter Hong  2016-10-04  107) 

:::::: The code at line 104 was first introduced by commit
:::::: f1232ac229cc078206a72ca365c3526e37ea1ae5 serial: 8250_fintek: Refactoring read/write method

:::::: TO: Ji-Ze Hong (Peter Hong) <hpeter@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGrm914AAy5jb25maWcAlDxLd9u20vv+Cp1007tor/yIm5zveAGCoISKJBgAlGxveFxb
SXxqWzm23Me/vzMAHwA1VPN1kZozA2AwGMwLgH784ccZe9vvnm73D3e3j4//zL5sn7cvt/vt
/ezzw+P2/2apmpXKzkQq7S9AnD88v/3935eH17s/Z+9/+fDL/OeXu5PZavvyvH2c8d3z54cv
b9D8Yff8w48/cFVmctFw3qyFNlKVjRVX9vKda352+vMjdvbzl7u72U8Lzv8z+/jL2S/zd0Ez
aRpAXP7TgRZDV5cf52fzeYfI0x5+enY+d//1/eSsXPToedD9kpmGmaJZKKuGQQKELHNZigEl
9admo/RqgNilFiwFwkzBP41lBpEw9x9nCyfJx9nrdv/2bZBGotVKlA0IwxRV0HUpbSPKdcM0
TEcW0l6enUIvHVOqqGQuQIDGzh5eZ8+7PXbcz19xlndTfPeOAjesDmeZ1BKEZlhuA/pUZKzO
rWOGAC+VsSUrxOW7n553z9v/9ARmw3AqPbfm2qxlxQlGK2XkVVN8qkUdyDWEYmNu8wG5YZYv
m1ELrpUxTSEKpa8bZi3jy5CB2ohcJsT4rAZFHrpZsrUAiUP/DoFDszwYewR16wpKMHt9+/31
n9f99mlY14UohZbc6YhZqk2gtQFGlr8JbnGVSDRfyipWt1QVTJYUrFlKoZH368O+CiORchJx
0O2SlSmoV9tz1NRUTBtBd+e6Ekm9yIwT//b5frb7PBIR1agAfZLtqDqQNy4FB7VdGVVrLrwm
HgzrKMRalNZ0q2IfnrYvr9TCWMlXsN0ELEq48jdNBX2pVPJQcUqFGAlchcoTowm1WsrFstHC
wGAFbLdQFgeM9UqvhSgqC306E9OP0cHXKq9Ly/Q1yUlLRW2xtj1X0LwTD6/q/9rb1z9me2Bn
dgusve5v96+z27u73dvz/uH5y0hg0KBh3PUhy0XIX2JSGENxARsQKCzJHhpCY5k1NPNGxvBW
Vt/BpZuN5vXMUCtdXjeAC7mFz0ZcwVJTojKeOGw+AuE0XB+t6hGoA1CdCgpuNeOiZ6+dcTyT
fpOv/B/Btl/1q6t4CF6C+/Ea19t8NO4Z2CCZ2cvT+aAWsrQrsPiZGNGcnI33l+FLkfpd1imQ
ufu6vX973L7MPm9v928v21cHbqdBYHtLvdCqrky4JmC2+YJUjCRftQ1ItEd59o4RVDKlFa/F
67RghDq02Aw20E1olVp4KtaSR1u1RYDaTm6EliSpsukBnQUNDK7iqx7FLIvsE7hfMMiw+aju
loKvKgXrjLbIKh0x6xcVo4BpAYOrywzwAzaEMxsLudtQImeBx8EVA8E4Q63TOJ7RrIDevCUP
wgmdNoub0M8BIAHAaQTJbwoWAa5uRng1+j6PrJRSaALxb0pSvFEV2Gp5I5pMaXQF8L+ClaP1
HZEZ+IMyI6OIxX+D2eGisi7sxa0fyKzKhg9vnIZv5xkhftHR2i2ELcCKNG0scmTxCIoWn3l3
Ow67epcVGYowUozMv8gzkKum5JAwiBOyOgygshpC/tEnbM9RBObBvKiu+DLYCKJSYV9GLkqW
Z4GSOdZDgIsJQoBZgrEJ2WdSkcKTqqlh4pSysHQtjegEG0gKuk6Y1jK0FSskuS4ie9fBGnpd
erSTH+4vK9exujRDDDpoOIB/g6SB5Rt2bSDCIeeFmuSi94y2mDAFkabkTndLgzuj6UOtwYPz
k/l52MZ5gzYPrLYvn3cvT7fPd9uZ+HP7DB6cgZ/g6MMhFvIBSdvP0D0ZEXxnjx3L68J35oOf
LhILcihmIQFbUXs4Z0m04/I6oXdZrqjEAtuDQuiF6NKlQAkRh14llwZMM+xCFemkWdZZBtF3
xaA1rDJkbWC8aUNjReGcAia0MpNAGSUTEB5kMu8itlaIcSbakZ6dJmFsraXh61EkXhQMnGUJ
5hmyoKaAhOHDMTy7ujz5NeqvMUmw14siCIrWzLXCLLfjvYOcDxAQiMoyI+zl/G8+jxN7x0IG
uwX2IaTOLAltm0P61GUaLXJIxrosslCpyEcUGwa65KIiljfLGqxwnow7qatKaWu8F3csuyWM
3MFA1XaSBWYE4mS+8tFhSxZYOAeGjAnmuTCH+C5iiwKIPk1ikARr8OPAW+S0ewJTF4fQ5UZA
OhMMkoGXEEzn1/DdeHvaLdDColybHHYdWMbTNlbccdC1x+1dXAeCuAZseOZt26D8AF1Lbcnt
H/fkOq8eb/doC2b7f75th87dWuj12amMrL2HXpxLOjhzaw5TSnO1ocKEHs/KQHwArWHSxmfy
oUNgV9Xy2qDCnS5ic1JURP+2LsVhZuF3jjSsiVLTrKpJGcUCCe1wFKl3Rv2mOZnPSWkA6vT9
nHIEN83ZfB7y4nuhaS+DupyPOZcaU8pIHIKjNabCy85sNOv5SWjExnNyk0p20Hr3DbXjNSg4
Fqmr20HI2TePKL0i7f6CfAV8yu2X7RO4lKCfwT0VtMinmkaFv9uXu68Pe9Bd4Pfn++03aBwP
E/pZp6luty+VCqIvh4R0BWNZKxe1qs3hjgXtcjWLthw5slBYzQQL2tq5CWQqtbOFrBqNjXVQ
UPi2imhGWOe/tViQcIw9vHVr0ro46NibYKcIYGJyG6VcvgjrGoNPs8AbxN9tqSTsBVjrbL3g
6BDH29QgGy5qxciKmL1DOZ8M0T3FY+TljnnIkXd0zqOrnVpVpWpT+gZgjFU9LkNyVV139WQb
hpmQh4OZSEASG6bTEOEDGufIXSxMra0FBbHNSugSLJneBME4heo1H3P/MJYyB8Hegqv1z7/f
vm7vZ3/4vfntZff54dHXkvqOkKwdg4qtOz4dmY9eXAwUxS/HRhoHOf+y63o7A7qOWYcI5Oni
b1Pg6PNYiTD3aFyGaA/0K6pseGqg5FhlYXTM3VLV5TGKbsMd68Fo3lf3ydRi4P7Qe/kZhXlp
gBnlGgHGLNnJ0ZGQ4vT0fLr56fuLo5PyVGcfzr+D6v3J6XFmQLeWl+9ev94CS+8OesEdpIU5
KmSM5jYQ/BoDYfVQgGlk4SI6Yvi6BJOTQtxXJCrcyElbUOs/IZ/nRoJh+lQLY2MMFlUSsyCB
ENZFmWBfg7FioaWlK8Yd1Q1YE1rrXPXN+87GRc5UDoJEm2TELACa4tMhTxgRZ7R03exBSqpi
lOYi2h+/QezO9XXV5jlR+wOCJoPVQkt5YK2q25f9A5qAmYUwKXbyDOIT1xoyfSwBUclwYVJl
BtKg5JDJCDwECaMRw5kVnyCDlrEMAYZxsFQHYCxXdnVYqYZiaxBDAJVUPtpKwYG48OeJQK6u
E3CzT2HdwyOS7BMZ6sTj9WbblCdhrc8tg6lk6YwaeI7otKjFO8/m8cdwZNsNqLWYahwi49a9
eykKqTZB6jbUeJ1Uxd/bu7f97e+PW3fsPXPFhn0g30SWWWExVghWPs+4r7HGRIZrWVmCiRaP
KetBoxY4qPcAblROaWRLcTPREoyjhnVFLL3/PBnYNeqcFifWxmy9KkwJyUmw2D7tXv6ZFVQ4
3Qf9R9LtLo8vWFmzyPcMSbzHUZVN3zjuDaLFVDS+XRB7Dt3h+VQYLw6YNfyDcdq4atCyLo3K
R3UXU+UQg1XWqSCvIEg/H0QJURofmy9X2tACXQhddSzkQo8G8SlAMyovFEUNU7UQ+0Z1SBOI
owtC3aQKiYYu1Zfn848XHUUpQFcgaHfnfquoOsVzAUaRgZUg9SjTwBVeACDz5+jwAj69T5hI
xll3lkx3BRtJMHPZV5huKqXywcrdJHWQ+dycZbBtAqyL61SUUXewvowB4qlGq3FIjGpDMOjy
L7eqmMWtfAmuW2yhUa7uQDRkYIEnQ+C9lgUji5K95ais8AkOiwLj6U03rGtYh1wljbiyouwy
Obdzy+3+r93LHxBMkxkwzEVQ861LGeQS+AWGL1IcB0slo+UJKQ7R61WmA73FL6z/YZw8grJ8
oUYgd2gSuDYHxJhIZxCvTQzWmDppKpVLfj3qzm/AqFblG6DZMGA5pvhvZIV7fugOFgEyoOtB
GVtAMETYXKAjtTy0WQUPJwafB3LtOkgrd34owkw1ALp2AyPS68cQDVT+/IkzQ3sNIOiCpEZD
DkuGiEBUleE9FvfdpEt+CMRzumrEAsI105RFQcnJSlahODxsobHMWdRXk62w3FaK6JyuBJuq
VjJMAj3t2soYVKeH7RGeqei6QQsaRqOUBKXesGUYxwAAlj1eGIT02n+A6VRkEJznfKKu5rDj
CTig04gYBD1TYJRBC45H1WwzpZD9ELA4xmoV7DIcBf5c9BpFoBLJh6n3UF4n0VWMDr6BITZK
UR0tR9IaEAb+pGqzPcF1kjOCibVYMEOMVK4JYjy9i2OJHpVXBHAtShXqeI+4FmxJ29OOQuYQ
FCtJKV5Pk3IUByHYdEGOmiSaHLQLLNyCEAP2NwdH0u/gToZHe+6W9CiRBmkdGb2bxuW7r/u7
b+/CWRfp+6g4Ajv/Iv5qzRxeq8piO9Xh3O3PCWsJNP4GATqMJp0o9+AmuWgmFtYjYcdP7K6L
A3/jhi1kdRFbjQvvXigjcDFAY+bBDpIGHlBG2qD/FtJcRJdAEFqmkGK4YNxeV2KEPGAGgd6m
RpNBp1RhgRs3kTlgE5y4hYyOViXfg1uqybmIxUWTb0huHA4iNE7Bo6scXiWqnOipqCKH7j47
ZRsKTg6KQx3c8w0dDN5AxsL5RNCIBreyFd57NkZmgcHt2lbLa1cuhkimqEa3+4DG1+LppLE6
ggSfl3LSlkq8s2Ujp43fTZosGpX8xkt6rp6mMzHOUXvpwK79/zWYKFpO0scHDY5sNH6UoY7x
E8M5X+jH9FHYcEsxJc01bOzASMMXHkVKho448BkIdwUwNQLGsR6kyNEHKEgcR3UwvOUqORlF
IEnOwtoSQopKsRiS6NOLD+cUDHShP+sZDhtOLTWasYGPWkBAGJS0wo9Ey3Qhxt+NXBSgd6VS
Yx1v8WuYSXvwNJX0tZQFGYu6UxsX3hgWbTIHeBoBwHRhQvfx7OyExiWaF1gsKCDlnyQ40hQc
VCXKlKZYmI2saNQks2ISU9gVjViZGxqhuMiVpXGf+MQwsD4fz+Zn41i/Q5vf2MnJ/P2ECeyo
IBuXuUsMW6Rb9g/z05NPFKxZrHWwuQJEESFSwTF3eoq/22BhIMtzHn0EdxyZZfkqDorWDavA
yyGCyu1O3wd9sSooZ1ZLFWX6F7naVKwMJdeCqBLLAU25pII5KYRAUbyPznYGaFPm7R/uTiM4
mNKS5bqgiU9Lo4L0gGzZoYpjjLecjHRj+mpwyun7XGlp8Laswncy5J1GWzB3MhCeE3awJgmP
lAN4OqrJDpiS05YmaDtZBBsTkUO7a6ADRoFRWMPut/ELmXVbEKB3D2QQq1EGWFT5KEtGCBgW
FYcwAMNNQBc1sVlpgsx3aXTcqecUtkIMzs9gzQ3G4RHqk7Y6/mpMkYYMORhEYwQzDlUs5ViH
Sm6ooLe9ke3CKx2e0gQIH3OlMe/6qklqc93Et1mTT+GHv8s5KsnN9tvX/eg43Q2/sgtBX/d0
lk8rSGxUKUeXCPuy4UH3I0RYChycXaFZ6qbdnqfd/bHdz/Tt/cMOj+P3u7vdY1Q5ZGCvKDGy
qA4On1g+oAmbJK4oImgxRfvbycezjx17AJil2z8f7raz9OXhz+isDInXPLaODnbFGS1VxJqc
k6aIO5sa5PwIgGyf45UQzPzCQjDislxc+dHDWWmCodWa4Q2aikuRUSdAbqSGaOiATZUzi3cW
JqfUknFS2xHPf/11PpoYgvBuGgXuBhyzIzOJ/5+cQ9EcyKOIZjDusBJsdVwsGBvM5/NxQ1GY
8XwjfPbh5GJ+MokeFmSSpGNtmiC/OopvOUcZ/ysNtcIhmcrc462REPyxvH/NQt+6JnZPb6mC
mCfBy9QiDSwwQHSGMWw4Zg9sbHw1IeimFNWoCYKagjfHstGWCi+IqX8hXMqUiuERYyL+wxod
fA6RVEiSRiUIvPxgMnzbPDX6saAL0Ebk2cTLXsBmgtnaVbe9y/c3Hx/ftvvdbv91du8X6r43
c9G0uUysSSVVHvPomul4SVtYszwfzbFDJJysRQUUzC7PVhOt8UCGfr8SdrC4uLo6QrReTuwg
XAq9nuwfEpexMIYbolMS7QP2DFy5rqIjxA7majlUwtzj3cPfJlcmvELYYbulHQoCV6uJWiG0
WXFqxxurBSvaizvBUbhMGt3eU2tBG6kFAAgIHg8GUPhq4isODhS/QXQgU10fEMkgUOPZAgP2
MPV1ycKJq3ThXYBDWjRRkDXiqfSG6RIsmSGIuNC2fwjRqLKmiPCGFUzRPSHCkyuxSBOCDG+K
dtchkQQP6ajuYH6aDSSp1MHztmBQ+BB5XudMg/0ZvaCJyPBq6pWru9AGLBCJL1ZVE+8bB7pp
gzOITqese1JAuZCObhNpRS6T0VJ2EF+FAvJqEsd5MY20K0khR6lOm/sF43cQd1Su+SEpAPHa
A+6QnMb2NyS+h+ry3dPD8+v+ZfvYfN2Hlwo70kKYJSHQHt86kDE4fElPdGm6ywUTF0aibqBB
WZM9lcpfmzrWBeTCiTLi0C4N/OSFOHKZo6cz9tidj2Hl7PdQKZ58D5lMjDmkG1NVZkqzGpvm
00gv3uCBGTVlvHaKz0Hck9HL+cDkRgKUYEtnKxmmh/57pCktUJZVeHu8hS4qqeI62sfRHYSP
1cENwxbc3jCMgSMBcCajAzD8npSyQ0I/PluP29SGekDHRbXEPR/kAS0EK5sQOR7oYo9Hs/0v
ZZwyC8wCfDSpXEjLgutDCCzDO5ktoIkDJIQux2Rmmbo6X5u8377MsoftI75PfHp6e364cz+I
M/sJSP/TBhdRnOa6kJRPR0wWFvtbQCNP45+tAHBVvj8/RwRdGPAUZ2djigBfSK6Ve0DyRILd
qE9xnxhtORFN9Gns6Qn8n40E1kLbeUQYtwpPh7B29HB1rqpD4hZ4SG3Oso0u35PAfmZ9IeS7
1jC4JmVYUeWUTXW3MrLgdCI4HBwOQFrYxO8EpCABdwNvkNVCKxdcjGpy7rcDivDauKsIiTVW
9IKgkMlcrcMw0R1miFEdaqqC4p/4hLtg/NH+kowhgcGTt0GAkM1jHJLUVEkSscxURdSdgwSv
baO+HK5SGzDRwCy5JWIyDIS+i3j4qYBJwqay1G5GERRmJKipX+RBHAatq9G7a3nEAyLW2ImH
y4iUaj2Jg4B9GseMpNORpbJVXi/GJQ1fIwTY3e55/7J7xJ8GITJU7Duz8O/Um0QkwJ+d6lRm
WuRX+Oz56oCHdPv68OV5c/uydezwHfxh3r59273sR4yAD9m4ioobcJIbCMTGT+1bo3FsKH9H
evc7SODhEdHbQ1a6S53TVJ7j2/stvoN36EG8+BND9LQ4SwVo69TcuprPv3bbP2ygl7VfcvF8
/2338DxmpBFl6n6chBw+ath39frXw/7u63cokdm0JwdW8Mn+p3sbNh1nOo03XMEl+WMxQJjU
/S3aiv98d/tyP/v95eH+S+zer/EcjNQnzSo5KkcML0gf7lrDO1Pjm/S1f5i3FHkV2vAIDHvW
LqMfcVvbooqziw7WFBjNkjUFVqYsj25DQDTmhsmkLiAvF/6n5Do5ZP/j7Fp6HMeR9H1/RZ4W
3cA01pL8kA99oCXaZqVeKcq2nBehZioXndiq6kZVNWb6328EKVkkFZRmt4FqpCM+PkRRZEQw
Ivj+7cs/8RP4/DtMqG9jn483FRBnmSYGkvKbTjEl0cjUOvbQiPEgYykVX+oOAsl+xAVRuCEI
7FfDs9p9jIdpQ8d0Xu0AiZ6pI8VMrsdrTdlfa0GLqg/zbM2dl4V0NJf0ZUHezcsrJXMoEJP3
IhmgVV0eDBmk5icrKEL/tqWxnoaRM1OgGWSD0cl9tAm8waPt2oHMo1p+VHAz+W16pru2c/75
3RCZB1XrLPBIzZTYTJyhIpQgVSV0Mo1TIW1Vu6EOE9LGGJLSUoDKI7q4Nx7DLXAxCgXd0swK
dCIFmvVcHj5YhPResFxYHVChG5btDmjW6yiPttc//M5TUzUsMRQavo0rvDArakYzUIWyaCgo
WukjKlb3WSjGZVKTOtbG8W5PWUIHRBDGa8PCroMSLVtxH6dYXECpPZCeEEla2xlUhjK430kJ
j9WIKgo9JuTXmtFnYkMtFxgVysDds7OyNJ2PDKqKrdF59+JptdpHC3Gzraf1gQz3GoblkFon
JT1ZtvFMIXjiaY+B2Hc22FI8Zbowg4TUsOPpc5JeDR3RIvdLgBELb7Nvgx5juJ0xNcU63tAO
sNpm4ZkKjw7Tw1JL3znCAIDxRK83bu9/WpO/5tyQ0AaFCqiDVXw6abEIoQRiGe3EirvyXxb9
yA4g2UqH6phkFNDW+ZHUsPrEaYnK6r2WP9+//4OyP7B0E27aDqQzaiGDfSy/90vM+L2fYSMs
6c+oEcfclyIMnnMfhXK9MsJHYXfISoknXLgo4aGk+SbPsNtk1PEVq1K5j1chy6ThhyyzcL9a
RWPtmhIa59iSF7KsZdcAZ7NZjdCBcTgHePA9oasW9ysj7OmcJ9toE5r9TWWwjamgdIkfoaPK
DSKxL6+vVmo6mR65ZXmprhUrBBm4GfZLs45r5bDx54ZmMAy5osOnFxprcU/M+ImZwVA9OWft
Nt5Zfq89Zx8lLbXi92yRNl28P1dctpNKOQfFb20KXk6Pja38sAtWk2mlc7++/evj9yeBJvk/
v6jkYN9/A9nt09OPbx+/fsd6nj6/f317+gTz//0P/NPMGQpCrilI/D8qGzs5zJRMSJ+hjeEp
NUPJukLrow7q/vrj7fMT7PRP//n07e2zSr9NaHNX2GEc+8gYpz1TxWPQk7MVVIKxv9CfpPS7
NChI3Ui/z8KZHVjBOkZndLWWHJ0cCr2r+hPWybxU6RByM4CnZiLFBM+mpR1R9q/OWiwVBQ8p
u+NDP1PN9u2pTElPP8Eb/J+/Pf34+Mfb356S9BeYdj8bAd/Dvmppg8m51lTyqH4oYuaxGQqc
CFpyNhYl7PNjJbQ95YEDf6Mu5smnqyBZeTrRJ0OKLdH1Q+kE1pA0w6y2dgRdohJ65P1tHpMp
wuQL9X/i9XUSU6z3dKdZht/PQTJvrbKu+rLGd+s+zX/YY3NTKcrMbQHpVlCGJqnEodqHcvIS
2tMh0jD/kCBovQQ6FG04gznwcIbZT7Po1rXwn/pC/C2dK48fkeJCHfvWIyENAOmJ0NKvFs0g
M2yWzHePiWQ32wEE7BcA+/UcIL/OPkF+veQzb0rFJsJ0mEHUSS7pY3v9UUPzIc3PYatVC1zB
bz6PzgdG78vzmPknrZpoCRDOAmTO6qZ6mRmuy1Gek9npCKK8J/ew6sK99qTd7LlzvXMkIpub
5m0U7IOZvh377Pe+nU6BTqlHS9HrnccvQzMLzBEzy2c+O7h+wIbPzHN5zzdREsOKEPpBL7BL
iASV8Jl2XjK2tIClSbTf/Gvmo8C+7Hd0CieFKCRo6H72Ld0Fe+qgXDfvngXrLT9fWG2qPF6t
6EAw4Lpn47ql86SZ9AzKGaNku4ENOou8TSrquBPG35NZdnGWaHNLc0QlS2+mFwN6ALSmOBGg
H/zjBbNCTGRrDMd4CqL9+umn4/u3txv8+5mSTY+i5uhFRtfdM7uilHfyUWebMY4ye69VSw+e
eypYnAtXP36MX95bRz1uUsq/YQrQx0rvoB+8//1PFLOlPlZgRuI545hi2LU3VhwT/FRWOcIM
bGPQ2rqAAcXysIjhdeoJjx2CpQ5J3skjpbkOCNvw9aCCWCpeHhFmk3rzZreJqFShD8A1jvl2
tV1N61auB3gpCkaWeYPjLNR+vduR3XBBflcJqkS8289FmulnAEmG6N3A6k5ZeWCZEQI2hVR2
MowBoOMGZ9p/SVhMxOTVHNXNZ9i4xZQpc9Dtxhi7Ga7jTEEhbBPzALmKhkvJu6tMdhE1OA7A
9vgfzlX/zW/toeY2Z/ThbOxxvvIiBUU3SmzL8bWsfbtqc6/OZUnFfBj1sZRVDbd9gjUJVfz6
KEgzmFnBidumRN4EUeDLYjIUykCwhqGzY7pkJpJSekK6xqINt1NRsYT7JKfeWNHIpYfI2atd
KS/Y40UslbVUbPgZB+hj65GzKlzQI98yNdT5csFViZFTgJkuoiYdu1taewtrMlpGAQYdJoIM
z1YEHN8oL73uS13WViotTemKQxyTaZiNwoe6ZKkz6w9rWjKDPQAdLTxxDKC00julb/o04lQW
kbcyjzCrkty7PslmwYUJBQ+MLg/W8xbUEb5RpveRcFxdKT9Fq9BVmAnUTdaZZ1KUtu1IkbrG
E180sOnxerDpFzeyr5QDmdkzkOxL+0sVpEOgUUQlqbPm34nnoK6QX/hoCV/89FN74dQpijLh
S/w0lOp92caGsvCZnkqXInUdtab18fyScSv58YGHi33nr/1lbeNAKkpXVHgVQgHrOgZAd+7n
NK3pVJanzJp6J/JU3yhyvrAbF+TME3G4aVuahaE3Vo8DcvHgKnTOwa3oVU2caH0d6PZMHDmt
rwgwPI0gx1fd2tczYPjKeHz3jnmwomeSONEr3Af6uG8c85zVV+4kU77mkxikYcI+n+ieyef7
wpaXQyusKK15nGftuvPZlbJ249ebgCtvs+wjFYdr9gekZ3u2Pcs43mDkAB2ehUJ2vJ4cNNA1
l+7HB8++W0cL+6gqKWHpsgZJ4jVPKj9F70O2UMm9tsvD72DleW9HEMCLhV4VrHH71JNo9UTG
URwubPrwJ95uaIlkMvTMumt7WpjF8GddFmVurVLFcWGhLuxnEl2LuVT+L0tjHO1X9g4RTqJr
iXavIhXWdqUSnaeOSDktWD5bPQZ8ubA16vSY8CQnUdhmiTPIxDBJyQG/c/QUO4oF3aLihcSL
CcjFXFvyzBZfMhb5bOkvmVdIgzpbXnQ+9guZDtvsyAWPEHNLvnxJ8HA3Z3SVdb744uvUerR6
u1ovzPhe1TVLxUG0T2hjM7Kakv4c6jjY7pcaK9CsT76YGhNrWD5wmjJfo2Q5SCu2TRN3PVcP
Ikpy/kJ2BLMU10f4Z9+3c/QYyTGyBN/kwqSUIrMzOMhkH668xolHKfugT8i9z9ItZLBfeNdo
ebA+1EokXss5YPdB4NE1kLleWkxlmcBSagVBmtxGbSvW4zU5pgFbfnWXwl4yquqec+a53g+m
B/clc8DLCTzbhbgsdOJelJW8276mt6Rrs1NOWrmNsg0/XxprzdSUhVJ2CdElFQgbmJVOekLD
m4zMvWHUebUXfPjZ1WcnytHiYmhxIsiEBEa1N/Fa2ClyNaW7bXwT7gGIljRz7d1jVt77+7BW
+FfPHpNlMNY+zDFNPd4aoqqot6Nt0cMFpyZx8LO1aEmOrq/09NAI0RxYYWSfG+rq8ktLU50A
RouFTsg1P007MvD7/JCtxwSuwFi/r79ngQeAOJ5ODyzLp6ZUL+tVsJ9S49V2Pemhki5zIegP
V0HaikwlDd+DUnS/WAQjPlLeKvPu74ynXVOL0wndvRVDO/0J8QQ/p2kiHuu+YdNnKZ5/no1U
1SxPHUJvWnOo2u/3YFNhnuyUVdshxjuCqFMbOc84GK8m6M06WK96qmm+itdxHCCdGNFEJCx1
Ot7bNtyaUgafgm6Wtm1UKISHnoaQ2yRxEEyqxWLreL7a7W6Bv/c0exQtd96WSKoMvhGbhmaA
rr2xu9u9DN0VmmAVBImniaxt7Mp6/ZYmglrkMJRS6DY7HrTQjY78JpjWpxQ6m1yoZBBs0hBr
4lXUekf3ZaiJ6MNwkmK104uBDhGkveFhrONePC6hK5cND1atdXqGdnf4IEQiPWWGkxOr7X5v
OMFHH9b4f2P1yGyFuarIlJuZeTGzzM7m/RiYG3QIljGzdSuG8g1xaJjXQ/21HVaj8+/ff/zy
/f3T2xNGgQ/+eNiPt7dPb5/wThHFGVKUsU8f//jx9m3qKXhzpNBHBpMbmUoV4eORTe4oCkCJ
w4ASYVlznhw7WnU11gkMwv3hmcjFbB99WIcOUEKCSg7iK7KhLVKK4/VVAe7eW277TEtZN5Ft
w4ASWqBQsDK2Iv27SxxHfkWk1fOeKa1jwp448eYw6WQixAFwlEP+F3M+3pIi2pqnjT2BSrBh
v8ycvKTOxBinKcOmszZOT+FHJ6V9OxeQQE7hErcn1oFCjwj6bMOCEj0ZAboRg4zu5Hi5u75l
Z8JDU57Nt1r1pYjCwtaNVEgAQf3kVoBESkQfeGaWe6TZiS2Qcr7VxaRaX34J4PV+6l8mpLmh
GBHTAZmgJn3s6UNPJww3KefIMN2TjW44Qzui1TSpUH4snZMsC4Vc30wa25iBoe+iT4lA5pGW
8c0vYnKgZDIn2b48mFoKwzkXg5SZtR1qyiMclNZtNKbKaF1/YPv82Hmdezxkqs263wRodi0k
yKMLTzkeBAyilDjA0sUs7WqgTb7HKcL3ZTwAmIRo2lrXwGaDw0g2OzD92XNuuNa2lvSmSf4u
DwAMzvMAspjerKwBxNTnsHEvAmuGetMyTEt0yziPH6SJIeMBTIB5ncwtC8JNYA6hpvhHEPkt
dYoAjNja6DIVmOb8dnbdm1DpfQdXG3WdvO/7fb2npB++iVEKIS/sA+KXpsC1Y/LSHxrCkPjp
JoURm4g+mB3OlyE0hn9VF87d3jFt0k/TBLU/P/34HSp+e/rx24CaqLg3W1TEZD2U0paZqWTw
l7rR/hHHiBm31Xm3IW6HGwypMF+lkb56zrnwmrfoxkLbh1J+tQYFFWMjY8vYlkxJq9jVssXD
z65ygif7qKM//vzhDcUZkkyNrSFB7YlEm5p5PGJAccbtwGrNw+zH8GDkaGiEvn/vOSevktOQ
nDW1aJ917Lp6iMv3t2+fP3799PT+FfSE//5oxYn3hUq8jtUOMrY5mL6HvDjKgUnQXnnRtb8G
q3A9j7n/utvGbnsfyvv8EPCrw3e4RgJQ/fZ8GXp0gWd+P5ROQouBBkpPtdnEMdkbB0SdhoyQ
5vlAt/DSBKsNbSS1MLtFTBhsFzBpn7K83sb03SAPZPb8fKBdpB8Q11JII9SU9mSbfwCbhG3X
AX3hsQmK18HCq9Bzf+HZ8jgKaQciCxMtYGDh20Wb/QIoode2EVDVQUh7Oz0wBb81HrnqgcEU
9riPLTTXH6EtgJryxm6MNgCNqEuxOElkk1e0PDN2HBYq2l/LePURfF8Lr7XJw64pL8kZKPPI
tlnsd8KqIPAcEz9Ah4Q2WI/vtgEJAsNNZxdNy08CCbDS0hd2I0/yWrBsWkZfioHPT4uPCoQ2
YV/AiUYkd1ZRSrXmcpRorAQoNt1NuedwZU5nLtOwq2zblrFpee9K04/IvWCVMgL6nNVd3MVj
WnhsQHgRGZVIQQPU/VrWtq8pWC86CieerMQmSlQ+sdpAnVkBYpnnatAR9nyAH0ugCm+RI0e/
B+mJBXIgaHFGwHv/yDix9K49sgwiRhJXaGSy/TtMRBxXebxdedzIDSBLd/GOXlYtWA0CRuAJ
ILeAaLHqcvNk2mJfYJMSbSIMmdXkHy5hsAoiurBihnu6JBq4y4J3IiniKIjpGpJ7nDQ5C9Yr
38BpxCkgjY42sGlk5SSjJgDORzpFrP1ObSYYTbTw3hd6dWZ5Jc/C1LhMNufOSbfJO7GMLU8Y
Desn8EJveJtE2nGTYB4vH0QjL3RHT2WZitbX1bNIOSevyDRAoFPCdLEMAyZbbuV9t6Us7FY/
LsWr5/3y5+YYBuHOM9KZmaLf5pR0hWox6G4YEEiX1ADr/Ndkg4gUBLHKY0I+MUhHmxXpAWCh
chkEa08LPDuiHUdUPoD6QfNE3m4vWddIT/dFwVvhGZr8eReEdDGQxFSuON975ilogc2mXdES
rwlVf9fidKZsJxPgTRS+kdYr3EIlt7RRp87WDm8BQCwOvPMXtxk8+iqlIG+RtN98EO3iiB5A
9bcAhcbHl4n62ktfTwAQrlaUtXGK8nwteAmopEdBiszK/2vzpH/4ZBOEkWfSgKR89DaIUrSH
1cbbzZrmNZXcbla7lm7wlTfbMPSM8KtyBvWMTHnO+43PsyuKF7kxLW69sCtk4soVg1DQlQVe
/j0xPoAsEKzpHaAHqM0dxPWJ6GvBDrDDbqybbnprQdSu4FmahvToG+wp7W4HA9n30X0qxd1H
6JjW2L6mPUDP9K661UsN5aDhblZuC0qNPsDuYt/cbjBTnpSp78LREXYVh5oOhx7GUqh0iQ2n
Q5ge9hJZ4YVUCjkHbJsPtBg3GLtuvAaFfa6OO/fbqTUiyYMVZXrR3JqfLhlrMBpEv57JANa8
ufwb70Z9S2EQj1D3NbG2CmEiV/zZ5VycXPT947MsR7eIR30uPznGm9162uPqlvfTwdtbhKi3
7Vaq5kFdNqy+YyIdnDVub1O2X202j8nuNI7cbaS5M29FbxSdx2gxfNttFq39FkVYRcLtnk37
kOQsoqWGvo/1NcQ1Rb9ywsyqANvNAJjpo0buKKSFkw3q+YG7RNS5WE/S4CkirbYoFmjJ42tT
lKOZq22g9DugTQ/TPr2Wiw+CCSV0KdFqQlm7lM3m4aXy8dsnlf1V/Ff5NCRH6rFO19RP/L+b
EVMzKlb7DDI9IBG0SUSzM3EAtttczW4uqY/U1WC3DRmig6S3EVYnquAXtyCrDnOd00ZQaez6
l2F0HhWdWM6nsZx9ZDc1zmNCM+J0Qmec+O3jt4//QK+gSWLYprE22iv1zJdCtHtY7Brzap/h
sNxD7PNkhptHLsxM3WqO/gOYRXiYOPLt2/vHz4STpTZAqNyvibke9ow43Kzc99aTYQesap7A
XpKqq+TLgsyLZRQItpvNinVXBqTClLtM0BFP3Z9pHpBkad6DZjKtTP8mg7espjm5EopNz1WD
WdTq+gj565ri1jDsIudzEN42vEh56hu/nBV492ZN3nVqApmsOAzy1b7ww0SoLMd2tl37TTV4
x5eXX0vmfck37xrxKN2EcUxmxNGg8mhmT9AJTH//+guWBbSal8rZjkje4kzProa5fe3kgXLk
6rE4SBnoQpOBGhjjiw0chG3EMYjGxHO79kGSV55pphRHcZ1Wqcne2SyTpGgrD3mmVLAVEjVJ
8jEe7JmClg7Vc/vl+0PDTuT06/kX28dywkORXU31yadigg7sktawoPwaBBvQEieDbWL7cfAP
fu9yWkm6czbbO6yYk2HyzLAtwSTSzxNMellXvp0JmEeZdVlF9mhkzcw3BRIF3tXqXm7jQhMM
DVJp4cVJJLAdULJrj8WV8DWINu5Wi/OjchPpDVmg7D3FrTFp6v7up+lTFDprZOrk6OtBRXeS
tqdA+VrmZOwOpuLGvdW0SWA6d/jGCuow4XwdMs8bTl1AeywsRGfx8HyS3XTc19HNqmhodUmx
PEpiVdFH6n1W6WEKjJoCSLt4OpFmZucVVV2g4XrLaA5m4+3UvQi0xI0gHV6j3d2OjMxKoHBS
TOqXsJb54DeGF2aXJ7ezqIKWx6P1ZIdJJ4z3cwO5skjtRCEPYofbMMh2dGr0EeYmURs5CcxU
+zJaPNfDKAvKGYdfdWr6Bxgoz3TjIA0Pk82IQGg1nV+lKbbB715QH2ZWAv8qw9nGeGLzviGF
E7Kz/at66oSgjgSV/YZmoZddwUvr4maTX1yupe9YHHETT2WLe23wnqK6bGk1dmhINlH0WoX+
O8Ng7c7uvoTDUyl8fB96+OqLbFQ61ce9H9pxBVqbehuZeyKOgDplhmGyljVkoBWWUXK9YoKA
5nr6ADmnnXuA018PgnK83T7LTuVBNFNilbBBvMIneagweAHF+Fj9nTBPoPAC/bffv/9YuMRG
Vy+CTUS7rzz4W9p148FvZ/h5utvQhvmejZmXvHwRe67GVkzpOZ1HZiVES5/Mq8muDLIeuxzy
VTg/7HEXL0QKudns/SMH/G1EexD17P3WY4oF9lV4TIua55wTjpP8r+8/3r48/R1vJtEv/Omn
LzATPv/19Pblfym7sua2cWX9V/x0a6ZOTYX78jAPFElJHHMzQUl0XlgaRzNxXcdOOc45k/vr
LxrggqUh5zw4sftr7Au7gUb3n5dP8N7lw8T1G5XUHz4/fv1VnRMpPHE0vFwEPMshpi2LwzNt
TVJyASZlgrqVUdiwmOsqC/rCA5jyKj866uq7UvvbvGpL4boBaA0z9ZFpdNGJFROQ7tYd5EVK
ioo7ZBNo00vb2ab0H7ptPVOZikIf+Ao9T++MDCtzCl5iaEWfNIR+/Kt5h2vePtOs1syFGSDt
eFTKLERHd8b9RGpef9jIXcAGVumDkoXzY7709YHk8UsNt+ArC+x277AYvdELe/xSL1e6QUgh
Yiel0U81Mclu2ek9DtIanNS2qCC7Fx3H75m37/Uzw4/+iBjc7Nu8lTPy0yPEAxDnBmQB3xyk
qLaVA/e1iMn+Knn3LXBo2wjQpmL1byZkySOXjLdMOhMe+60QO6hCkTmMD4ZNCsVSib8hRNP5
7eVV/8j1La3iy8P/IhWkrbL9KKKZNqlwdQCvWIPl9S7KPDJ3KmLECwXO+shpXcyAWudMJXeS
eoWXlEUN2tQ6Q6aggzMAQTcPrRjTsqjhOTvGD6/StweaDA7spBTwG14EBwSJF5bYVDbW0KlW
CXFDRziEXehwaxPrdHbPgfBXaeu4xIpkYUxFdYTqgIr/sgUZbN9gFbWw9NUWE85mnF8l6ZXl
DpuQaoKomej8KfHC0vb1BAxwTUBkAmLLBAin9bCK4Dm7Shi3dEeDSEBjWVRUyPRtZ+ZotvPa
U5IU3Z3q84pPEMPnlR3O8zgGUl5C8FWRyix+reUTWV2+vLz+uPly/vqVSimsCO0LxtKF3jAo
MeIYnZ8hrePAiKuXRZGanZJWejHJqHCcjM4chm57+M+ycZlObOciN1zh7IxmmAzflyfs/IRh
zAvTUevNTRQQ0TqBU/P6IzdhkvMnSZX4mQNP9TaYsxbONB9yKmmLBl9g8/in6M0vQxepSBq4
Khu3k1/ZOYiLeTIswi6jXv75en7+pE+S6amBOkU4VT4vn5C61XppB9FZjePA56+l9jhQnUHr
tYkORZsypCJn7LuDVo2Jfj0pXG+rHdu3RepEtiX2LNJzfPlts3d6tCs+NnWi9NsmCy3fibTm
8ntv8zThYrgZL9soRH3rTZ2Z6Ut9tizR+49t6Ka8utTv/cjVp7nR2J73rW5FL3c9t3DQKsOA
2MZ1T8bBb/uv4+obl3nZ6IO4BLbVBlfOddNHBgv9aYIVIwSOHQ0PS2amnHM5uO7NOzxLXUdt
oBAzV22ANAl3uy7fgQmKvsCo6HXAbEZP9vyJsX/7z+Ok51RnqgPL3XCyJ7GfvXtp0MePC0tG
HC+S7q9FzD7he//KY9z+VxaywwNcIa0QW0eezv8WL6hphlw3g4eElVJjjpDK4OVr4YDmWpg3
epkjEp58ygC8fc2mcLh49jZ+iiTngwV9kzhEEzwRiCwfbTqkMRzTyDyYIbHM4ZoLcMe0ww88
ZT78PZbIowi3CEcYWXgXhJFtqmGUW/iClZns8NqEnCaeIHCzIPfJEXU1xTAICisHdV3Jk5KB
i/ICm3ElqUzwa5+gRyoia9mnTuwLIrUIVn3ginaaIjZlj4NcLDI1laPLBQp245CzKGGTb4aJ
OCVDMYjFWUnQF7le5NC25b1eI043PsdvwZ0VMEpziRuowfo+4N4vJw6WEpvA7Js2ZSz59iO9
MdEm6ek+eb+Yva4thAMScEoG8p4VCNb2c5Ik7aPY8xMdSU+OZfs6HRaQGC9EpEcmOlIyo0sf
jhkhG0NUmKkxJnxOv7lz1MBmatlJbIvRR2c6PCwILfnNjILh61BictAQEnPtzYNEE0exaJM3
AyADis8vZrp69bxmBH5+sZmy5Ni7gewHYUa4IQ1zmjHYXuBjHxqhwpqgKWMxdko0s9Bx8mwf
6QgGxGi2ADl++E6uoeujuVJB1cI6jFQb17uWKbd5Fw8eJMSxQ30y7ZLDLue7qId2ddfTlYfJ
EjPDISW2ZTl6oauyoQFxHPuSde/+VKFqKJOCEuHEbSJA7JS+IL0UFnnG8iqn5dRgmTdt0XTC
lAmd+OR3S2WWQ7bP1FNXsKeB4DDRELJtZs3ybXIo6UergbCfeTueCmJ4P4ak2CZFx83GzK2X
EjCfYKSVbuZnPjlDHF+qiMPglJP9g8NY6Wl70MeJn61q5Cw/brv8zjyuEGuBOefTIXaItJ4R
s0PKJaNVhtKsHWaKZoy8AHVzSu6bA26asXBxmw8e/zOvYXZghw0LOzxKZ0YRNOPfLSQ/dvam
neifzm8Pnz+9/H3Tvl7eHr9cXr6/3exe/n15fX5RFKA5n7bLp2JgiMwZmlxBkGbbI902Ld8V
kbre98Uk64kjH5UZMunbep5VXm8de1OlIrZkCwdjVhBfy3cSWZDh58IKlu1ke3Yl149F0YFA
rVd4OqrEuueE1KKr/T6wIwSBuNkQ2QqrIHuggVVvvceajO+vMiVlUYW2ZcMjN/zCLnAtKycb
IwM/AFLhdXTGxGG5L1dCafHbn+dvl0/r9EvPr5+kCQyW7enVetMM8atkAo+6G0KKjWQqSEQT
YspC2PWmiI8b2Jck+3zIKi3A+Ree5Ywq+Uwe9TZdke2UBOBNSc1vHTCBwdAybqu0+KDDayUz
qSVMqOHon/kZ1LMFsiACAxNvRloYuBccI5MmVchrnRWAbMuESI4yRX5wMz6mFW7tJDFeae7s
eo8fn35/env86/vzA7iIMno+rraZYsQLFEEZWfcnoFMFGHUROoOOpEfAsuUn3A5+oMGSJb0T
hXpUe5GFPQIEO9S0EUwfVmhfplkqN4G5wrCGQW0CFcz80K5OmDkky5A981IK4U+/ZDfY20w7
9F1pOq9297YQXYwYYURR7F2Jkq0J63L4Qrn40SkkY982x/BEaWFQKjBdmP7Qswow1WICJeUO
aLukz09Nd0vGHVF7M7VdKXikQET6vnUCJ5Yz3xeBR/do6APBwqEH0xVSpK5MozmC2Y0YPqel
VIMFF2Am6y4ourgjgSGWG8B/JPVHurwb3MMocExWQEr/Mh0VfQq3or7cMYtaq2TF1Eg/DI11
5IoiGgdihcXnqys1CjBq7CJ1CMPIM00YrneH6pJlZAe/ulnw+GrDKB6ZCu0DN1BbRWlxqNBm
6U0mg/iiVrhNtz5dFvjxMUuEXTiIeO9bqF0HA/XrIUa+jSxTGyfJTF4tJE81dYHRCy8Mhmv7
Mal82efDQjTGFwCG2/uIzkBH7S3wCY6LdJvBt65+GOaH8/zdWV89Pry+XJ4uD2+vL8+PD99u
+I1ZMXvFE/QCQbikLLr17/zu4OfzlOqlna0CtYeQ4K7rD+CZIMkMvowoY9m6sWeePXAKFZmG
mhZSVgd5jk72I+IZQEsC2/INvlfYGQvujmZ2OaA2jdEj7IxqhdXPl35iMzeAXbWq82QC/AA7
qRHyi7SEQI8Mtq0LQ4w2WIAdpPaUqvjL4gjds13ZK8qp9CxXn8wiA8R3uhJujuYMPlBD99qK
KCvXd12lPvxiWBuzu2qI8LtTgI9DZLguZ+U06b5OdqjVHxOZ1Lt5gWgQjhxP5j5Vvm05Os22
VBrs/mrrGNW0SCjoWXo24PsEoekjzPVtjKZ5SJurgjkrYVsz87aRhbIPWxFRrRnkVI6pjZPW
rOz5YGmmro9TmsWu6oVjvr+/pkUsiv/shUE4C1gcMyj+wFeAR+o4NmWf7OQH9AsLPKQ58Odl
5FAZzF9Xdji5Ywd3P5uAyko708YgcYFEhQsYKxsoTVGALxmZC1Qr9EZtYcp8N47kU5IFM19C
CkxMY3mHaVaR3mPjU/B9LjtC73qEqcD1ii84IppjSohjW3hXMAxTR4VJltS+64vKzIqptzaC
MxGmSFzNmLMcfcmpwoIWpIxdCy2VQoET2gmG0d07cAesG0AkCG28GxiGvQMVWaJQNgGTMYO2
KDMZPgcCE//SXK8J5QnCAGsjaCh+ZIIU5UPCosCLsf5kUGBMFYvOoRRIvG9XoNDFx2HWha62
f1GNTK2MLOdK9pHzTvaTviw/0ZNxyS+XDFE9y1B42tq0/6/Psqr1PTtA+62NIj9GS6VIMOBp
7sLYQZcX6GeSxxMJcfDmKTrdiujisYBtDx8NEaIFpmMUWQFaUwZFZihGJ2d7qjDyqvnp0KLh
IY0gTtUmhndrMhd5ZzslfhWFAdqLgnqnY+XOZ/G0MUyVUwSI5mgFCZrqPoocD503VPz27cA1
TGQQ2x03uD6gXF/B55GgAhkwfEwZZrvotrJoQsYqg17zfpVjG+3+RSFBsCN77YEAiy9AFPEN
n2QuWeMzLTUpLul6EiFQ6obFNBKEShb9gmFgEqT4GmJOcA8lySPgQGsALF1S1GSfZM1JZZMK
mQuQLugEgEqvpek91sy4ybqjEF1Hu7WsLp8ez7NM/fbjq2gjOTU1qeAweW2thCZ1UjZUczya
GMAZQ0/FZzNHl4BtrAEkWWeClrgZBpxZSYmDtFjRa00WuuLh5fWCuWY5FlnOInNe6W76R9+B
L3pMI82Om/VlqFQVqUhWZvb49+Pb+emmP87hNdZRgXx4KFSBAM/skyxpIYDP73YgXBRTcA5z
VhV102Fmh4wph5dSJGcPpahqTQg8qZBLOZS5ECNsagNSV3Fm6add0+ilxTw4xgXAY/3M3pbm
M7aHly9fQA9kOev9QyoykiKpm7HK+qO4eI5eKQRbuRIUBNr6U4wwO68x8o6o0g8sogzNdn7f
qtaXRX3tjvrckN53cNL5+eHx6en8+gO5SeNrsu+TdK8th0PNzBP5UHz/9vby5fH/LjBsb9+f
kVwYPzzibctc34I42meJzfwamdfEwhg5aDRpjUt8r6GXFdpGNI6i0FjRPPFxt8c6V4iXUPWO
epWnoIbQGBobeqguMzlBYKyF7Rr6AEJ4yGqqiA6pY+EHNRKTL4lIMuYZsWooaUKfXEPD3oCm
nkdlA9eAJoNDpf7rMxCVS0S2bWpZtm3KhKFoOASVyVDJqRaOoQlR1JGA9h3yKZ/SH5LYst6b
nqRwbN8wO4s+tl3j7OwixzJvs8sguZbdbQ1zq7Izm/aAZ2gjwze0jZ64h2HbjLj/fLuwTXH7
+vL8RpMsr7zZid+3t/Pzp/Prp5tfvp3fLk9Pj2+XX2/+EliF3Zr0GyuKBeVuIga2OGM58UiF
438Qorx0JnJg29Y/hk8mh201Fcx2+RAKa9MDC6f1rxv6MXi9fHsD11LG1mXdcKuWMm+HqZNh
5nGsfsW0csTK1VHkhY5WZ0Z2tUpT7DfyMwOQDo5n6z3IyA624bFSe9fWqvKxpGPm4ncCK447
/WWt9ve2h94gzyPtRJE+0pvAMugMS7L4SqF8plxNH1/JH758VoRft82jbeF3W3NyR7ToB+Ix
J/YgHvIwzmm3yCZVWC6FgXwoTWPGixrUXBN9pfF8AnRK2Jh99Tph1DVLJ/KgFkno50xrQUZU
r73yNN9EQWJ4q7d2c2ij66C/+eVnFitpqRyiNgBog9Y9Toj0GSU6SmqY0a62UOiuYFr5ZeBJ
zyzWtnlKLeqhDyy1FnRd+kodYNW5vjKZsmID3V1tcHKqkUMga+3gdPyFzMQQ476YhXZpSzpP
8SOzeTm6QahPzcyhX0qDD5SZwbON+t3HzKbfUNClmmwWtWHqpNN+L08aKWtYrZFx2+KNdNAh
dVx9N4PdKtRmcdITWpOaqpmfb5Ivl9fHh/Pzh1uqfZ6fb/p1an9I2beJak/GSU6njWPJUUaA
3HS+jd+GzKjtKhNrk1aubysTsNxlvetaA0r11VLLnRqWTl08liIZJIfIdxyMNnKdUc3AXl7L
FiT7+a0gVkeMTuVIX26wKzkWkYqQv7r/81+V26dgXKe0j33iPXfxLDHr7UKGNy/PTz8mOe1D
W5ZyrpSAfzBooyxT7ECFS1YBuclMns6OfmYPdiz6PBM91FVC9zw3Hu7/MO179Wbv6PMDqOZv
N4Vb9KJtAZWehNszz/IRojrcnKitT9CFTd/XckeiXemrM58S1S9g0m+oZuFa2p4QBP4/apHF
QNV0HzM4ZXMDNBQHkQiSbWwZbMgA3jfdgbjYPTJLTNKmd3K5fvu8zOt8OYfgZzmrJdMvee1b
jmP/irvpU/Zii4n88t7XKvfSsiqiaRysGv3Ly9M3CGBLJ+Dl6eXrzfPlP+atOjtU1f24zdFy
TGc0LJPd6/nrZzDg0lw0HXfJmHSCh5qJwE72du2BnerNdegEY3v6B0QmKqjoI7krBXrW0l1t
mJ0xYqM0R5geKyVLTiV5uYVjVGEIKXZbkclfo5wG6NvNCsl1YRnSGlUEQr21Tdns7scu36IH
kjTBdgOOaJF3SisIcXiTsmzS3+lnUIfLPLkF31aEPeVXKwTOMEeqwWZoMHO5F1PRjx3Qdnk1
MgN8QzeYMEhH9vAGGUNJus8XF/ZgDnh5fnj5BIecrzefL09f6W/gm1BcCF01+dukIlQgDxP3
wVfagSeXwlw5Di07Mouj4Qroaz5STBXi4kVXCZEApM6+bao8S9AFI6aSE3VJlht8rwKcVJnJ
FSXAdXM45gnmxgfQ406fEUc6cubSCP5ih62/XbJzTGoHNCRNOniutM9QZ3gLS3nMJF9rANwN
uH9ZwDZNujctn8mtMu0heVa0SZ2X8xzLHr99fTr/uGnPz5cnZVoxRroF0azyjtA1KDpnFhjI
gYwfLYsu6spv/bGmuoMfB/Ks4qybJh/3BZgvOGGcqb2/8vRH27JPBzqEpUFVW9ihx95h4SfY
hl7iLHlZZMl4m7l+b7su1sptXgxFPd7C466icjaJaBQosd3Dw87tPZWHHC8rnCBxrQxjLcA3
/y38F0eRnWKFFnXdlHT/bq0w/pgmWC5/ZMVY9rSwKrd8KebgynNb1LusIC28zL3NrDjMLE+d
ZVNv5kkGlSr7W5rb3rW94HS144QEtPR9RjWYGKtC3RwT4GOTQxL2F5amLKp8GMs0g1/rA+3u
BuXrCgKv0vdj08OzBDl4j8BHMvihA9Y7fhSOvovGnVgT0H8T0oD78ONxsK2t5Xo13qFdQtpN
3nX39KuLBi0VWe+zgs7krgpCO7bxqgpM0bVtZOJu0lvW/j/2lh/WlvlcSUhSb5qx29B5krmo
orSuFh67eSRBZgcZ2vyVJXf3iYMNksASuH9Yg+XiLRf4oiix6JZOPN/JtwY7ETxhkrzTpLy4
bUbPPR239s5QDyohtWN5R2dLZ5MBPYnXuInlhscwO4lxKxEmz+3tMpffKoi7U09Hpxiozh6G
75Xb1OCjY/AcL7ltsUL77lDeT1twOJ7uhl2CsR0LQiWqZoAZFztxjFeNrsA2p308tK3l+6kT
4oK18g0RS1MfbQrb/IxIn6FVDdi8Pn76+6J8kZin2kz0HMuoe9qBPQToozKQaHbOZLdp36Ok
mnmykLsDPh8jRChTxLsKAg7tixZ8s2ftAMZsu3zcRL51dMftSWauT+UqgSvTC0Sptq9dDz+f
YP0BYs7YkihwtG/KAnnKnknlOvpT0DSWOniUHFuGZ2Az7riYKThH4Ws5j4/Smn5f1OAxKw1c
2nO25Zhy6RuyLzYJt/oPmQAqZyTjuFUzwogbADNGuhVvWw99PzHhpA58OkSRIiZDyjazHWKJ
LyOZyMdsW+jaTOohcD1fTieioWQ4L6FZq0vlSXYMfds2ApO+oS0xfX2IGeR9nRyLo9rXE3n2
4GDon6RL291BWQUD0QjbjTop0qLrqAh4RzU14+jwAF6GovOBGzOBkRjVNQm2X9Cvfl73TBEc
7w5Fd6twgWPWJWgG21O2r+cvl5s/v//1F1VSMjU+GVVT0yqjcoawO1EaM/e6F0nC75OWyHRG
KVVKf7ZFWXZ0h9GAtGnvaapEA6ggvMs3ZSEnIVRbRfMCAM0LADGvpeOhVk2XF7t6zOusSDC/
L3OJjehNeQvWQFsq4OTZKD7hp3TwZVVCqGCJCo60JoVWzgaUBqhWX9Q7dGA+z17WETsh6Cc2
t9BpRdG2wp8gQMJ7KqA5pqugLZxNUck7qXGdjo0O6bEbcwqBwxHuGl8aBjubnw6L+fCYCaZS
uuJoxIrQM9Zed8Uo5WrWm6Hl/8/YszU1jjP7V1LzcGq/qtmz5Ao87IMiO4kmvmHZSeDFxUCG
SQ0QCsLZ5fz6o5YsW5cWc6q2dkh3W5bkltTd6kt1PQxEUihsCMVxOyBgyEbwXxDLgl8wi3PB
uQz3lBT49XWJZ7ETuHG0CM7AJs+jPMeFSEBX4uAMjqYSZ1+ofhDMUInXPpIMGWxUqPep2G2C
cwSBqzi7sXnaLHfVZGpeG8AgVFySvRBjkCbzNHb2AbhhGAWCbOQXCqjIgONwp3XuNMjTczdZ
a3tWofuuXNbz27tfj4eHn6fBfw2EmueWlOz2ZlABaUI4b2skmSsKcFge6RbdbU92Ax8+Xiff
fvJRXfhi99YeV2w/f+2VrGWfxBHWsBvd12NIBBEIZ9hDEnWOoozkcUhXZRzPGWabd2gu8aEm
xcU0EJzbE2mH+0/fYniW+9+hMJNNGW/fTEdn50mBzdY8mg3tCH1jukq6oxl21Blty8/Tcexv
+LIzyIMDMH7SgV3PnEQh+eXo4vDs/7oFntdZZI6IZ9bdvqp9wSJ/tayYZUkTP/vUiVUp9LcK
TxghCEuCWXdqaPHJbrFdLf7d3cv+Du4NoWfeJQ08SCZgqjBmCmC0rHdunyWwsZN82gSFs0XZ
2FqIRbihVM5InKwZfiICmq7AmoPMhUIy8evaHgPN66VZZRVgKaEksXOHSlLpJhd+93UhRAn8
hAS8+ErLPCtDue6AJIZ7l/DMgeM/WttNIm+sYtLqY6dzVkYOcGEW/JGQRAjlec3tSRCtSZOY
Tbu+jl2W2pKkyrHE1IDcsHgrbXHOK69LfRdktcUgSVigKSiNavXwG1E1y60Wqi3LVqiErAaV
QW0Nq4A6wBOqc76awNhbkEmc5RtckJFooSjCMgkSSBkpFXMdGqTQ6+DgtzuSkmuV7smCCqFe
cpTDu4yWOSSoc8BgWSldBoEa1gz5ylnFbIBQ68zSxgAS6hwoooJ3DB3KAApGdmeviCuSXGdY
WK9EQ61P6s15CxbCyufPYSqNiRaf02FxIX9k0mhnl32XqBKuN4LfkROw+Qf605o07RmUlZCF
murMIq9i4ixHAYoTqOAZe70SzRZJjVm/JUOkzG58CcZsoR9Zi6QDNmgiZvmalJTVt/wa3mUd
ZQb8s32qYhssbYtECf00jr1jCexRy9DOVq2g7qHKGt8P0IQqXjMegWq826bgY3cGt4yleRVa
fTuWpbnd0k1c5u48aFh4Bm+uI3EOumuTi90Hgr3rOQqnYjxC6FS/bJ4gScFNSQc7rvsCiph0
IUszthKGWRzNpO2KyBvATpjgQl9eUdaAESCJW0NEPw7AB+LoxMIDVQzPWAgEdVKwYKFaIBB/
ZqFkQIAXsuKqWRHerOztQ+ACT6iMenLKgEiW8e7lng5e/Px4O9yJiU5uP/BadlleyAZ3NGZ4
RBlgZQ7PTbAWL1ltcrez3df4pB/OS0i0jHFtt7ouPotizMUH5VtW2SdXS5GmZu2qbcnjKyGo
IEAeXZxfGLqBBvuBRylVaSWRt8kAKrtgN5BL35UPMwxLRWKtoA4o7R2MvFyt8LCTNARAPFpR
S9LvgG4tRowiqRZ4QQnZVbYQixiv/QJ4Oj8P+JcDdiNDJcVf+JcQ3ytasZn4Ymf2gOgVMqAV
vwp3szXI4/lCgSKtjMMqFbJpxcyacxriJIqUlY346XD3Cw8ZbB+qM04WMdQHqNNAiiJIRurz
iYH3kV4Xwvzhd0l+uIDjSEf0TQpYWTO+CGSA0oTl9BJTprN460gi8EtZOTBY40h+EjMvQczJ
hLYBxZWpkHeXvbsRZFn2VDj5mJ+jXoIJqYYjM8xcQbPx2Wh6SZxOET6eObk8FRzqCmCukKrD
NJ2NRxfeUxI+xW2YkkCacLCroB47cnrYWn2eXOBsglDOLkc7r1cAPwsk1JMEKi9EqFeqntXI
6UEL9fLESGSwyIfqD2Rww27oOuzUG1oxncrEHRB36w8QkqjiRtUeHxwfYGfu8MDIZN6fa+DF
7MwbrZyKKaYGdOiZWYNWQtvsWZDG3pbGOuw0yCcqA4b9RJdlIMiz0ejibOR1PqnGU9TnV3GG
mxFFQitKIMuDC03o9BLCYeyB+tlpDPDlGOPW6RSLbFOPGYkm7efWVTSaXeIXL5KA8fFwkYyH
aBUwk2Ikx+BsPtL1+/vj4fnXH8P/SCGmXM4HbQr4d6h9hUmxgz96deA/zvY1B/XJ/5DBinxq
/MlOfGnvIUjuFXpEJT3s1463ZZyjO8boHK8xpDq5TMfDie8zD/NRvR4eHvzdGkTmpWWdNMGN
qk+L43JxNKzMWp4WdhUL8Woek8rjbU3RadLhAWlSGnDctIgIFSohC1xIWZQBId+i0cUd5MeR
s3h4OUGgy9vgpKayZ7Fsf/pxeIQ61HfH5x+Hh8EfMOOn29eH/cnlr25mS5JxuKUOzo/KpPG7
fhYkYzTYRhZXuCu30wZYgF0u7Oa1jkyjO6E0hqTj4JFomDmZ+H8mRL3M0o16qKpRkRIsBs2l
Uq8ItBPvitZBADxN51wKOzUp0Nrm7uvjFOux+MgQhAV/FWTJzCobBhGJovaz/QbdKOQiNIK0
WlHcwiv2kYlBidKY3aZllOItAaIpd7jQK5GcbX/XPityhum2BgkvDYcV81FuGjoNRFmVPIho
y1ibO59LIdrdoLtqHBE0yU5ZUSXkoqONIPk53Pr5iTgEal4vkIwh1xkFpwsz8/9WQi2rQPu4
31GFaNJ8E/ceJGaHAKtDKVAnVEUidljTDcOEwnFVmbxuIaGegOkuZI+zW+f1rnWHM2+uJhNV
qKv/PukSIncYg8tWzFBVDWdr08+uLV/eeZZ3YOVVq2qbnzngMpcTPu3fqxBKKxHrmvOQSwGE
s0jDLRQVwr6HSWDdFRgIqR8hz6pBPDlNGQYruXP2TAHFlBlu0wRcAemXlnHmFKm1aCIIB/kN
DQnZYSBzUlzSPOCcUbdFSpELPItGHCuYuCYfL2vO3TGni1mgmCm4JWCpcAy0rcm0gQpC4sRi
NTZRYeiS8AssQxa/LugG44KNLI7B8ioxo6oksGSmnX1jVx1RJNAdF5bZVRkVELqET4REw7UK
b82eiBucsjxAeu+344/TYPXxsn/9czN4eN+/nawsVDq67DekusPLMr6e18a+LBQg+xykEJFj
+asqSLDEYYdWYpTc09hN3Kznf4/OJhefkAkdxKQ8c0hTxqnmGLd/zTzPjJvIFtiGpLk9b/ca
fNNQJIwTjDm9lsSSCfNwS3QxMvPIGsCGEw++Vv9CEfo+m12VIL8Fy1wXldhWaFqEcNWaWXW5
bew2xmPpBdXF8HIUECEE8nw0DlRTLCs+HZ3hFpdNNZsF0rIqT6EpEvT7sr/99f4C4vXb8XE/
eHvZ7+9+mpweoDCulRRHN971uopFe75/PR7u+0OeyLA7S4BzfeR0QFr7qLN0BCsS89JyyZtF
sSRQpqz/THXGxEnNC2LFP7Z5zGiybnZJtoM/tjclWtWMJdROUqkh0sSNgFfbJs/nQqqqzCSF
cuvJ00KodFll7d4KhesQqd7lXPqIBVwtJRYv4rLm52dmqE+7JbnahwbDPJZmZR2NUO4oDlBd
2JpVxDUCL4bWYfNCllv2GvSKt2oE7iSjsRs2L4kKK/CeVD70EUSgeuy5vH37tT9Z0ZLaRcjG
6BfuWNKQHQPn4IXpksviJIKXiQ9q3P2lYIiFTvBmbpu9wD+qxX2erhDakFKaww/rggb9aq+S
gMi2DbhqLvMkWjBUEFtBOTixUIwTIVnLqN48X9eGX5gmhPp8Yt3F1hHSLjsM5rnjAWzFI5zY
qDGDLWuBvpxc4JugQcbZdDzB/DwdmunQOkAM1HASwkwmgb4JXCA5g0FEIxqfn+Hhlg6ZUwYH
IZKpBBpahDoUTPJrELUJkbHBOnZZA7Ohv+maLnKAfWJVC0BWv7R4QoVyzFnFm21ZJEJHSbLR
xaqgNhlnCyEwYLBmUU8nZ4I/zXpsqy0vWAY3UdoISh+Pd78G/Pj+ihVJk4Y7VUXVgog1Orff
ykvqjKIUEtbGNf3JGykIcmoKVs0mc1ODRLti7PqEJfMcUxiYmM7aUNrVZrd/hlwzA4kcFLcP
e2l3G3Bfvv0dqf0eKaouusSg5f7peNq/vB7v/OkrY3DgEJNlBdYgT6iWXp7eHpBGipRbZTgl
QCqJyFwopKHw6JdajXdSBniAblnZpcYQs/98v4US8n30ikLkdPAH/3g77Z8G+fOA/jy8/AfE
o7vDDzFzke2OQJ4ejw8CzI/UuljVsg6CVs+BvHUffMzHKhfv1+Pt/d3xKfQcipcE2a74a/G6
37/d3YrPfXV8ZVehRn5Hqmy7/53uQg14OIm8er99hNSyoadQfPf11EJPrIsf8aHEovPO/t3h
8fD8r/Oa/piHSqkbWpscgz3Rycn/L27ozBupLg2sF03706p92xLrIsKynLGKCxTamDSrWgYu
g6yIS3DNJxnFBQGLFkQuLk5vzCJm0HUVVQzrl9kM4Rw23id7PMiVfT/4Jt44ER4tSbyrqLQZ
yefif09C/QgW9FXEzYITcfYbjhUtvHVt717fgoWoMB6jlb57Aq9wXYtSh2L40aLKpla5wxZe
VlAxgnhwnk6nZra5Fqx9jyzHELGBlvhVDAvcQmfVHIVv0tj129JfaGuYOMUPVbvZBjluOQAy
CnC2TfTfXKAXPGkWFeYnCFh5b2yWupTv1Ye51ZAqu+auZ7DbQRYUxHuuvIID1myGiK4w1Eun
rdlZXhlKvzy3hWpniBrtTlMkzDrJvE50fRArZy21ADPKA1TZBor+jtAceeBHKnrKipxWxMr6
VcY8rgKag5wN0Hb4+/c3uSP1U9EaIEEZMlToHthGUCt0308KqWMyAhw5chUp/WHEw7pItNDE
SnXdgCBl4yiGk2RjMTsggWtYurtIrwIOgarXuzix+m4gix1pRhdZKrQKsxiohYKBmfMrGyVF
sRKae5NG6WwW0LWAMKdxklfwtaLYsdu0bGF/DeNp2HspwfzvU2qF+IqfYd82gUsK3KpckqBj
5sRjGt9ak0VlbobZtoBmzsQJVArOpCGcuV84T7UXQ39/+X6Aa96vP/9p//if53v115fw+/pk
WMayc21FETF0i2xjXU/Kn92OpiJ6toPT6+3d4fkBKznA0T2LyWQH1cq+U1OwgFteh15Whk9Y
B015jUCLiqGv8OzDvQOwPxrDFFgssavvhZ21TPyU17+g6Gd5FIiXFEStB3fg4t+gUG7T2LNE
OtcHnuZWlWcJmcfS9vJkN5ZTdDeHEAkhMO36lPsy//PL4/5fLKEd1F4g0fL8cmTXu653wWqm
AiW1PLNkAPIKQ/LLi8I8R/Kd/QsOCX3sa3DC0rkZ4gMAFeTYlmyx+KOkKs0GqoPXWWVnhRNH
cnNVkyjCS6DkrY1fX2raQpgKJT+AYVjubcZcbgikc6qE2s3hSoCbSq8ACdWRFJYkNBJgSwYC
QLMjVWX1VyOKnEPWB4qHm2kqHtO6DDmvCKJxs8A3SIGbfIpb1xmrmtBd8rd5ZCkh8Dt4pyP6
mc4poSurThdc9QuM7e7QgQVxwLW2IwE1G+75Mb41mu+mGEF1k4z2ITC/esiq8wZzfvvtZ/v2
+yYdwVM+ASkpwHHXWCI7PXXG76s6r4gNMgdogM0yNvA7zyBJhdiOSjP8w8CA0ZNZfArILSnx
cMedHghm1F7wkdX1nIYgTT6ixs1VBzaqXya1jLwxvkJHBdOGM7giaVNSEr7Gzfkmlc2l80qx
B/JQxhJ3NIuRx+YSBP3DG2mfcDlXg5GPqlGaubyXyfUUWvDqaXmTyrJvqjjPJ92CKx+IJnVi
JDU6uQlkU+jw+J2+xt/wCj8vbbkHnwiV5sWebQ1TLvnigELnnCUx1PpdW/fXYIWAm5drF2+c
zo2Q7uFKNDBpHPzNLJ+3DuQu9h4xr5k42oXqzJYZqWo7DQhH3H8UCJXKJEauGavfJPiIs4/I
n3BhBy6u6gReKDtJL+iXAtwSwqYg5ijUrjtmBazK2GrwapFWzQYz3iuMYU2QDdDK4AEoRLbg
E2sRKpi9LsWUODs4xYNfW+cRmxbSwkLSr4XvAkZv737a2UkXXJ5/qEDbUivy6M8yT/+KNpEU
Ozypg/H8Uihr7sGTJyzG5KEbQW8OuY4W+lH9cvyFysiV878WpPor3sH/swrv0kLuYsaS4eI5
C7JpSZ7MR7TrBuRFK6As8mR8juFZDoZvHld/fzm8HaG25p/DLyYb96R1tcAq9MjuWx1SEOQN
76cfF51yllXevi1BoYNNIsut5SP32QwqQ8bb/v3+OPiBzawUcOwOSNA6UFxQIsHj3FwMEggT
DGHWzKpcLVF0xZKoNPNKruMyM2fLsY5VaeH9xHZihfDk21W9FDvJHD33hOYKJdLLmJjh9F0A
5ZItSVYxNRzzcg3+6b+VNkr4M2uoPOANBFu68njEj0Wx5W3zch2i01SJMRvih+Yri18NtGb4
RjC8/WCHOQ9jzq288xbuIlAhzSFCA79skmng7RfTUL9UWpnAK9GKaA7JKNiwEa/iYCZBzDSI
mVnL2cZh5ZwtksvxLNDNS9Mc7jwzCnTmcnIZ6ub5xG5NbOPASc1FcJKHofp4LhUeWQVU0h03
MAW6A0O3AxoR4iqNH7vzrhFY6JiJn+IzMcPB5/aMavAlDh6OQ8MZ4iKqRYL7YQDJOmcXDXZZ
2yFru/spoY04hknmzhIgaCxEQdz82ZMIqawuMU24IylzoUUG3nBdsiRBLww0yZLEiR0w0mGE
6IYFS2s8E/1Xd3kuIqvNtITWPFjh+xoj5OA14yu3E4FjP0rsGkBJGjy564zBEjHkJAVoMrhl
TNiNSgmJmWYt45C6ON/fvb8eTh9+BMA6vrYOc/gtNOurGkrIevKhPqSFqiuUf/GBgR58iq02
Kkg0EcuMOAFjjlJOEJK+F020gnyDKu2N28W2OjFVSPQaR+mc4GLO5d1NVTJqOTF/aqbSSFQk
kH5XsrJEFqtoHEhP2ch6DMSSZjyiT1BCbEwS6aJnSiYeFeyZvCC4jUNaZagkhnxdKl0Xesms
xMx+mohxq5Dw9O8v4Adzf/zn+evH7dPt18fj7f3L4fnr2+2PvWjncP/18HzaPwBPff3+8uOL
YrP1/vV5/yhTW+6fwRjes5sRaD44PB9Oh9vHw//eAtZQJMC6J4Yg9OEszyzdS6IEu8s5NgLa
UOVSkS7EHmCGvll1kNF+aHR4GJ3rgbueOrlP+iHrSw76+vFyOqoqx13diH68rdMySZakMPyj
LPDIh8ckQoE+KV9TVqxMK7CD8B9ZEb5CgT5paTnVdzCUsBNAvY4He0JCnV8XhU+9Ni38ugUw
CvmkYisXa8hvt4VbNuQWFYh+tR+ElNtknsRuLt+WarkYji7SOvEQWZ3gQKwn8h/MFKXHXFer
OKNee3YtmxYYZ0vWVyQq3r8/Hu7+/LX/GNxJxn2AnH0fHr+WnHjNRz7TxJT6L6SRdXvXgcuI
47Eketh1uYlH0+nQkofVDer76ef++XS4uz3t7wfxs+y7WJSDfw5Q7O3t7Xh3kKjo9nTrDYbS
1OvlEoEJdVz8Nzor8uR6CJXY/BW4ZHwoUzY4ay2+kqmp3SGviNipNnry59Lv8Ol4b+Zq1u+e
U4wT0PxeGln5/E0Rpozp3IMl5daD5Xb26xZaiJ6F+7CrONJtcXpvS4KHaeiphJChqsYzxuiO
g+uTxwur27efoUlMib8qVhhwB/PtD3YjaL0XRoeH/dvJf1lJxyO/ZQn237dDN915QtbxyP88
Cs59Di1pNTyL2MLfedD2DU52h5pGmAbUIX3mT5lgZ+kOgs1cmUZDtP62gZ+deY0K8Gg6w9sb
o/Ui9YpbkaF/5InVO51h4OkQOTlXZOwDUwQGVuJ5vkS6WS3LYSBdhA5XKqZ2LmElNRxeflpX
5N0O469fAWvM3IManNVz5rMIKenEA86TfAuRCEEEkhRFsxxJY6GjYd4NHYUKx7ESQxi4KQqd
edAo9kezkP/6ksCK3JDI34ZJwolZXtfZ2JFlwB0nCR9fFrgzZccwE+Qg9k/PapsvGLJEW7ie
QC1VHp9eXvdvb5bs3M3TIrEMlXpPv8k92IVZ0byj83ssYCt/L4MbMX14lbfP98enQfb+9H3/
qjzZHdG+40vOGlpgkmNUzpdO7KmJQXdqhcE2N4nBDkFAeMBvDJJGxODZZ6pohvDXKAkdkwsB
JTsR5oOOrBPI3XnvKEr7Js9Fg5wffg/0QnofOArI4+H7K1RkfD2+nw7PyOEIIZTY9iLh2KYB
iPYg6hKKYw/rwwrDqZX36eOKBEd1EuHnLXRkKDoKDFofjkLYZTfx38PPSD57fXfIYhPoyZQY
UeDcWm0RNgHfsRVbZM35JZotyiBTjsNshJ3XPT5GXbw8Mujj2YQgu/ZGR4FgKEhot6Oxr/wA
klJ1/Yq8M4W0wbRZ7pJQ53uKoH2N/F9lR7bbuA38lWCfWqBNN226mxbIgw46Vi2JCiXFjl+E
1Ku6RjbZILaLbb++M0MdQ5F004cAMWdEidfMcM7yPsOiAYCGCiVM+MjMOyOwqMO0wynr0ERb
/fz+lyYSqtNFCcvpqlhE5RVaorEIHPXhwvjYJ33wQPHu1uhk1aOmJ7lBtVAhtBMAmuh7fZgt
ULSvB4yJgFuQLjC8322fHw7H1/Zs82e7edw9b5k/noxrzG6ZkKLt+t0GHt7/gE8AWgOXw/OX
9mkwHmkTFNf4KcNXwYaX1++YqbSDi1WlAj6TPqWczONA3U/f58bWXQMFwtxMZeVG7k3Ob5gi
nX/KS0rRJylQWIvnhhMVdEI3piRMQGTE+Hq2kXp3cJAm8whVgUpmvXeEAyUVuQeaCzQ5J9z8
F0kV83TimKlZNHmdhYKnr9GKVl5VY/BRj5Kp6yDcNeCAAtc0mi4+mBj2dSRqkqpuzKfMGxH8
5Dptsx0Oogjvr0zKxyBuA0mHEqilb2NpDFgYJ7GLPhgyUWT+4knqktC++EVXjF5MbnoYEF7Z
/EOXc3JOBMhsg6vT+GJsjYXdvkYGAvKAKRKuNeObtIKEOPZstLKeWfulExskRXe7sxeUIR3D
oWbXeFbrxihYp383qyvDgtq1kqO/x0W/Q0mCD66LbgcNVOboFlqrORyeU/1iFgQX4+zAYfSb
NYZJrelh8M3NOmEHjwFCAPzohKTrLHACVmsPvvS0X9rUwGHlIPeruyDtPaYGJlrKKAGycidg
1pSRfCkgb2QeI6CbKJ2SQWqwPTbGk6G/VpQGSsDemZPcbkJ1Uiitn2n/eDh+PlBJ9d32+OW4
P3vSyv+H1/YBqPw/7a9MGqZcYmuBBi40X6JLx8V7Rid6eIm6jvC+Es4kKRyL9fS3ryNPfQ4T
KXAKdIASpCAKZDgJV8yyiIDCn9KmvEn1SrKZu2W0P09NN89h9SuZJSZBTNdNFTA1VaJuUexl
nWUFZX8Z35Rkxm/4MYvZGkoq1nADPFuxPVNi7I5k3ZKlKBYFz9tYAhE3tg/a/XKjnPvA8y1W
Ph1sIpUwOusBdC0q52mc/OQFKi8wPQWso6yIyepjWtR6KY1aX153z4fHM7h1n316avdb26xL
zo8LCny/Nly1qBmrtbgNGjIvJfmU3qQgo6SD2eajF+O2TkR1fTmsdSfJWj1cMldlKav+U2KR
Bm4TbHyfB7DXXFE3LozG44AGknwoUYIXSgG6EUqLj8Ef5l6UpZ6obm94Z3jQwOw+t98fdk+d
fLgn1I1uf7XXQ7+ru5pbbViapI5E7IT15FhMQo8HhLJIE0+F9hEpXgZq5mJ2N3GIPvZJYWrr
RU6mrKxG/d007qHDmSmYT/KtvcaKqNwMDf3BIcCYL6d/mhJBTP0DDn/rXGAsKDCCHA536qzY
SUMqtT84usxlQcXLLE0h9HkYMcAoCTnvLYO86kZQSOJg3A2Xt09XZSaBpDdLESyQumNCV75z
3rw3jAQR3TmP29+P2y2anJPn/eH1+NQ+H3isFFbDwYuNumXUdWwczN169a7ff71g7oUMT0e5
eqeX+1KSswPN2AK2Cl8s/O0OdAzLqX/CJMnFyeGa34Ken1xF0EVIJGV0bWTQHztjVBApEdwt
sYiRGRege0E4cUGXjws+K5e5cR2nO7pMsECTqaczIU2O+ubcHVAzQcXaKPaXKRkH6IIOLMul
u+i9TzXycjWdHt4yXOOquM4YM9O/iWxajWN6EaNbGWIgRml/bgcY2OwJatSjonvGG9AodYsn
36mBiF6xb0BTUU1Uxrv3e0QU3IqaRe85sToy2TO5i+lryzRwn5EOTM4u9TThZ0/LgPDGHY7I
Y02H7cm/c8XKTraIVTJz2jzpU+c8IF8al5gQUdeLADa5fX3VzfTZNCGm0814TCckfZ6oMTUH
Ip3JLy/7787SL5vH44smovOH5y2XcjBhNPr6SKOKr9GMQZE10+BqIG4rWWNy1pFpyVmFsTQ1
bv+KSqZ7Vg6BzbzOsRBN6d50y1tgMMB+YmcUFyn09Ls46zg9au3IBxzl05EKc9jkTu+XPpZl
HBg2OwLPel8mR5fm0uBkLYQoWClj/DxGvr/Zv+ye0YMBvvzpeGi/tvBPe9icn59/OxWC8IJX
V2IlHHSkTwx14sh0z3rPr1qWIrMol763wHGEYUxhXQCVNtD0uYr5t1GEFmwHjHnykeTlUn+Z
+6bxP2bLuN1Uykj+QrIMMCwsBiNEDIs9VP6ezNJCEyjbX4G22KNmv58eDnAFBr67QUWnJa2i
0nQ6V4Wr0cwMpdu0g6Y7iygR0LwhDgfsR9XFUNrQOAmez5y+KgLpGa6/INDYUU9A7l0nhS8m
/3bkDpjIx7fKCD/1LK2X5zlxW7Kz2WfEMr5vOjKgIlrYVP66Ad0thvYoiDpo//BUIQhADoru
PaUnUcrDMB3cXTQKEn55TA000k3aTks+s4Y90p4Akye5+bd2ycUPBm5jrdzrbr/5y1g7fiGu
2v0BjxKSxwjzNz1sW+bUjHHiRupGChzvpBqXv/EQWD7q4HSbWNEIrMS7Gkqz5QlH708AXjyl
GoNY+czJGVyFTuH7YoB0loj/eKBfHjOI1li5IEm9IgoCtbRqycgmThYsRO8z7nw/4CRy4LmT
9zczpJue3o0vH24nfpEEJI9I3ukd3PBMKQrEOLR74Grp3Ll5bdD4RVy5Hc40s0YDUulLsUwo
WZJTUno/hvf5sCf1xD0s4jOSmBA1rCfgAuVFmUpM7OjFMtS1frROAPbCe1XgaaGfBj4XK7xW
nJgZraXrykv7JCbAKqPCiDHWplEAVM6kjAQmTdPMekprCv3fBHDKMevHqOvkBHRFOm8/HGN1
Z6l0V64gDIXWogovGCemduJ4YkKT2OWbpXe0WRmoH/IkEN2E32V+SqBnBP1UMEzB99awmNlv
RQvtXNI1yl0RcpbkmI8IUIGDzbNAubRR1NcsURlIScJ6iQ5BdeoHEeDkANpqzAEjueDGXv8Z
0ZPi13F225qCNrzRMoRk3NdOECGRRQFsef8RInN0UlnHAZ6c3vZG1ZHI7CGawRJuhmxFVGg1
9r9yK0wS9JsBAA==

--bp/iNruPH9dso1Pn--
