Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E2FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0781E2067B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgFFVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 17:06:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:42882 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgFFVGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 17:06:41 -0400
IronPort-SDR: FyZ6Uq/C54QXOlS4ed+TnvOdrew3SuOZBcmIoII65u0QzmPcmB1i7R5ailEC21sXmi9Xpph+Uf
 otHVAN1jpguQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 14:06:36 -0700
IronPort-SDR: +I7+yvsP5JYgfWsDRLyRJ9T7GwaeZEcdtDDO4ha2Abc/kSE5IxxwA+UtkkxxlSgn4+Ks9sM34e
 uCRt8V+UPHmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,481,1583222400"; 
   d="gz'50?scan'50,208,50";a="313529350"
Received: from lkp-server01.sh.intel.com (HELO 3b764b36c89c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2020 14:06:34 -0700
Received: from kbuild by 3b764b36c89c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhg1R-00003h-Gx; Sat, 06 Jun 2020 21:06:33 +0000
Date:   Sun, 7 Jun 2020 05:06:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: include/linux/compiler.h:350:38: error: call to
 '__compiletime_assert_7252' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct ctio_crc2_to_fw) != 64
Message-ID: <202006070558.Cy93XggE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bart,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b170290c2836c40ab565736ba37681eb3dfd79b8
commit: df95f39ae76474d922d9be9c0260dc263c451b09 scsi: qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst IDs
date:   10 months ago
config: arm-randconfig-s032-20200607 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-247-gcadbd124-dirty
        git checkout df95f39ae76474d922d9be9c0260dc263c451b09
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
In file included from include/linux/kernel.h:11,
from drivers/scsi/qla2xxx/qla_def.h:10,
from drivers/scsi/qla2xxx/qla_os.c:7:
drivers/scsi/qla2xxx/qla_os.c: In function 'qla2x00_module_init':
include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7238' declared with attribute error: BUILD_BUG_ON failed: sizeof(cmd_entry_t) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_os.c:7238:2: note: in expansion of macro 'BUILD_BUG_ON'
7238 |  BUILD_BUG_ON(sizeof(cmd_entry_t) != 64);
|  ^~~~~~~~~~~~
include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7242' declared with attribute error: BUILD_BUG_ON failed: sizeof(ms_iocb_entry_t) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_os.c:7242:2: note: in expansion of macro 'BUILD_BUG_ON'
7242 |  BUILD_BUG_ON(sizeof(ms_iocb_entry_t) != 64);
|  ^~~~~~~~~~~~
include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7243' declared with attribute error: BUILD_BUG_ON failed: sizeof(request_t) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_os.c:7243:2: note: in expansion of macro 'BUILD_BUG_ON'
7243 |  BUILD_BUG_ON(sizeof(request_t) != 64);
|  ^~~~~~~~~~~~
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7252' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio_crc2_to_fw) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_os.c:7252:2: note: in expansion of macro 'BUILD_BUG_ON'
7252 |  BUILD_BUG_ON(sizeof(struct ctio_crc2_to_fw) != 64);
|  ^~~~~~~~~~~~
--
cc1: warning: arch/arm/plat-iop/include: No such file or directory [-Wmissing-include-dirs]
In file included from include/linux/kernel.h:11,
from include/linux/list.h:9,
from include/linux/module.h:9,
from drivers/scsi/qla2xxx/qla_target.c:17:
drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_init':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7296' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio7_to_24xx) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_target.c:7296:2: note: in expansion of macro 'BUILD_BUG_ON'
7296 |  BUILD_BUG_ON(sizeof(struct ctio7_to_24xx) != 64);
|  ^~~~~~~~~~~~
include/linux/compiler.h:350:38: error: call to '__compiletime_assert_7297' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio_to_2xxx) != 64
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
331 |    prefix ## suffix();             |    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
|  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
|                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
|  ^~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_target.c:7297:2: note: in expansion of macro 'BUILD_BUG_ON'
7297 |  BUILD_BUG_ON(sizeof(struct ctio_to_2xxx) != 64);
|  ^~~~~~~~~~~~

vim +/__compiletime_assert_7252 +350 include/linux/compiler.h

9a8ab1c39970a4 Daniel Santos 2013-02-21  336  
9a8ab1c39970a4 Daniel Santos 2013-02-21  337  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c39970a4 Daniel Santos 2013-02-21  338  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c39970a4 Daniel Santos 2013-02-21  339  
9a8ab1c39970a4 Daniel Santos 2013-02-21  340  /**
9a8ab1c39970a4 Daniel Santos 2013-02-21  341   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  342   * @condition: a compile-time constant condition to check
9a8ab1c39970a4 Daniel Santos 2013-02-21  343   * @msg:       a message to emit if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  344   *
9a8ab1c39970a4 Daniel Santos 2013-02-21  345   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  346   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  347   * compiler has support to do so.
9a8ab1c39970a4 Daniel Santos 2013-02-21  348   */
9a8ab1c39970a4 Daniel Santos 2013-02-21  349  #define compiletime_assert(condition, msg) \
9a8ab1c39970a4 Daniel Santos 2013-02-21 @350  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c39970a4 Daniel Santos 2013-02-21  351  

:::::: The code at line 350 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEb7214AAy5jb25maWcAlDxdc9u2su/9FZz2pZ0z6bGtOK3vHT+AJEihIgkaACXZLxzF
UXI8texcWW6bf393AX4AIOj2ZNrE3F0svhb7hYV/+O6HiLyeng+708P97vHxW/Rl/7Q/7k77
T9Hnh8f9/0YpjyquIpoy9TMQFw9Pr3/9e3c8RJc/L34+e3e8P49W++PT/jFKnp8+P3x5hcYP
z0/f/fAd/PcDAA9fgc/xfyJo8+4RW7/78vS63318ePfl/j76MU+Sn6Ir5AX0Ca8ylrdJ0jLZ
Aub6Ww+Cj3ZNhWS8ur46W5ydDbQFqfIBdWaxWBLZElm2OVd8ZNQhNkRUbUluY9o2FauYYqRg
dzQdCZm4aTdcrEZI3LAiVaykLd0qEhe0lVwowOuZ5nrhHqOX/en16ziXWPAVrVpetbKsLe7Q
ZUurdUtE3hasZOp6cYHr1Y2SlzWDDhSVKnp4iZ6eT8h4JFhSklIxwXfYgiek6Nfk++9D4JY0
9rLoubWSFMqiX5I1bVdUVLRo8ztmDd/GFHclCWO2d3Mt+BziPSCGSVpdBxfBGsBb+O1dYImc
oUw5vg80SWlGmkK1Sy5VRUp6/f2PT89P+5+G9ZIbUtvc5K1cszoJsKq5ZNu2vGloQ8elsKHY
OFGFJbiCS9mWtOTitiVKkWQ5IhtJCxbbfZMGTqzdsxZSEOro5fXjy7eX0/4wCmlOKypYomW+
Fjy2xmSj5JJv5jFtQde0sDdWpICTsCytoJJWabhtsrQlCyEpLwmrXJhkZYioXTIqiEiWt1Pm
pWRIOYuY9LMkVQqHruPsNEXyjIuEpq1aCjh8rMrD00lp3OSZ1Huxf/oUPX/2Vr1vhKMG9cWT
leQNcG5TosiUp6aAla2U7FWNejjsjy+hjVQsWYGuobAfamRV8XZ5hzql5JUtIwCsoQ+espCM
mlYMVsQSQl4pUH6tEiRZmSWwdJaLM+s1x9gZB8uXKCItKlch3bPcreFkzmPzWlBa1gr4VqHu
evSaF02liLi1u+6RRfFGy4RDw37xk7r5t9q9/B6dYETRDkb3ctqdXqLd/f3z69Pp4enLuB1r
JqB13bQk0Ty8FdO75aIDowgwQeGwGaHcacMUZjTQxTLF851Q0CRAGjYtisiVVETJ0IpIZqkr
OEa9TkyZRIuY2mL/D1ZKr6hImkiGZLm6bQE3dggfYHpBZC3Zlg6FbuOBcDodn2FobpfDIV+Z
H6xjvxpEgSc22NhfeX0YbSsa0Qw0IcvU9cXZKEOsUiuwrBn1aM4X/lGXyRL0iz7wvbTJ+//s
P72CAxV93u9Or8f9iwZ30whgh5OaC97U0pYSsB3JjFwUq65BYM8NwgxuXIKMMNEGMUkm2xg0
6Yalamn3D2JsNQgOpOurZmlI+jqsSLXD4TfK4LTeUTHfLqVrltBASxBU/zR446EisyZogHGd
BXhp9R/gJHmyGmgcRY+uhKwJHErLnivZVs7mgR8BkOCigfEXHq4XPpZ6bCqqwqSwJcmq5iCs
qIkVF5bWN3KJDqMev+fiwHanFFRlQtTMrgpakNtAnyh2sCnaGRa2643fpATGxjJaLqlIPU8U
ADEALhxI55KOA0g9J9DGgAs4jwr5gRBC8BrULcQLaOO0dHBRksoTLo9Mwg8hwfD8PO0PNyw9
/2B557UlfoMGHAUAqQOsS9DMDKXD2sqcqhI0ou6WFFa/ZidHsL3FMMAeE+gmM36T78caY25B
tSb0v9uqtEwKnB1rokUGplc4ixoTCavZhMfRgP9haSj8hCNgMay5M2OWV6TILMHTQ85Su0Pt
eWVpaOOWoFAdl5uFBYnxthFh207SNZO0X1trsYB1TIRg9t6tkOS2lFNI6+zkANWLhYdPsTV1
pGm6/Sgm2pTb66FdVAyXx+FAyyrpt6U/KZLe2AuhdaCGBqYMnGia2gZDSzweonZwc3sRQSCM
rF2XMFjbAtfJ+dn73kh2CYh6f/z8fDzsnu73Ef1j/wSuBgE7maCzAb7j6FkE+zKDDvQ4WNt/
2M24DuvS9GIcyIln28tR0cRTs+GkAohqY7GaaU3ikHACU+cQFzxMRmLYXJHT3pOzjgfi0KgW
TIJRgDPOS5eljcdoD9yY8EFpsgziqppAN3pVCdgXWxHwjBVOQIUxBNXWyAmk3BzLKKVWaAiC
3cqmrrkAE0pq2AHQgnAAeOULHHh0aPmtphBTr3TPPYcRhz4ZWLkpwtCDA54VJJdTfAaakBJR
3MJ3axSG5/UtNxTiHzVFwAFlsQCrCnsDBtQ7lsMkGx2xW5JcUbDWAgy94q2r/WGlYBcUtK6X
sE4YWUy7dXRwnZtMl47t5fVF55VqvzlS377ux1NVlo03xLIk4K1VYKEZjLOEUPvXt/Bke33+
wVKnmgRNWA0biBY2eAA0GY0lOT8/e4Ogvlpst/P4jHMVC5bmdJ6G8frcY+KhFxdbxyD04MUb
PbNt/f6tkaV8/caYVvLXD1eX8/jN1dn26uyNhSnqBEb9Rv/1Npxc00jhZrdcpN6SN7qWi+Ti
7amTNasSNk/AQYDOp0ku3Ii/Inb4+rg/gH7WCemIf8V/XvrEdEdUP+5OqM21LFsmoiRaaH49
uzi/sqwyQvOCVIpUK0/Y2c2vZ4uL8wl0cX7x3slqaibVhbc0Tr/lL4B2MkhvTmk4rHBOUN56
u1gfn+/3Ly/PR++kYjJhi/bfzuwATC2bMga1U+ORd1GLiz8uXQiJIZ6j60vlgmsNL2hOklsX
k8DUwK6ytddCFXG7fr+JmUden19OIa6WQSgaa5Oxk9N5Z2PQbKlAPU/HVQc+qRlfl8gIpa1Q
ra50sLWkRe34tjNg7Kw472Zuov5L300CJZ9XreAYFAZ6ZZuy3CpbFmzlq6cbv2Je7OvX5+PJ
Tg7YYNtNmq7JupR1wVS7cLJTIxTjmOAh7Ekuwq5Ljz4Pub7aG+BZJqm6PvsrOTN/nMNTiTav
GR9vdZZ3aE/BdzxzkphzWgZQF8FThojLMy8VupjncjmPgr7DPVxDD5a6oiRmITp0RYyezap2
DcLgRB+YGQWnIewYgtDKTZ+trkkVYr8JO7vGNoAeM1afFO2ygciwiF3ZLXnaoONW2G11Whet
dXvHK8rB7RPX5+dDMxTnEp1e8IycVAHmWDDxuGFqqXNRdSgnIGmCHq/lgRBBOkdlzNp2sLeT
nq7bPoi9OTPPQPY8mAQ7lwJCGTLxCtw7N8jpcx56OCW4j6IJJpHuYnAu4ISD4qFwlM+m8FjK
6zN74Uld0wqCpDZV7q0O4mAkCO8ig1CCokzBndZpk6HlltXd7dbMVdmWhk15IogEU9yUodwg
5oTaOwwx09TyM2nGYDma2IFYoZYO+UdFZe9Fn2OP6uc/98eo3D3tvmiTN9woAy477v/vdf90
/y16ud89Oil3PBUQlNy4RgIhbc7XeHEGISxVM+jpHcmAxpT47DnUFH0uHBlZOaH/ohHfgPkg
65D1CTZAq6NTh8ER25QcpAlGM5N1DbUAHHBf69zBW+PxZjtmxF2KfmozC2/PJITvxz/D3h6s
dVETffYFJfp0fPjDSQbgkZJJyZBhJzj2DUZA1gbu7NPj3lYeOCS8LwuqobGBDZlIueaXPT7v
8H4k+vr88HSK9ofXR6eqgpyix/3uBU7N037ERodXAH3cQ7+P+/vT/pM9tqymbbWBv4MSgNiM
SDXBd0OdHZDxt/QkDsMkQopVNhJVWshGsRj0Eoa5mJGKIQa3jE2PdOL3GpWtVruKKbfEAVEF
pY7hARjqKQ0POSIlWMIV1RexTh8DtCvQAFPvMB3xefCOv/QGMXc1MJOl2NyYUwO6M2MJQ5M6
ydF0mQC9tJh2lczx3FG2tZtgKPzE3ri2dtth02e31cjow/Hw5+64j9LZE1ULrnjCC9+CGaSe
m/FegiE10tVvMannmYyCzUS5IYKiwwHBYqiqo2QsdWyTSYXb/WWbNsm6FHmwm5zzHBylvrdJ
SArmL/qR/nXaP708fHzcj4vHMGf4eXe//ymSlgtv2dE1EaH7GkRRaedvEKI9EQl6EZyKLPWQ
Ap0k8Jc2At0LO05BLKxpZ7Kd7juwdjgKjpeeM4OBsFGis2iIXN5YpgSa27oQAhNsilhWLRwt
lmspDKqe/2bpTHXE/stxF33uyYzCtwOjGYJB1/mC7ZwmcVs75WT6G2I7cq7zkNYkR9TF5QdE
hqzoQHN5ftElMn0GhEq/9RhhgRPcYOXaZP2cmrTd8f4/DyewCeAAv/u0/wozddV0x46bVKyl
QXR8MgWvhpzjMJTfwENsCxLT0NUMBJB+lnKSttQ6Cf1vrEUDbx68YlNP1fcp6ISJKR4LQ+fI
A2PRcOciaozLdIJ3yfnKQ6Yl0SUvLG94Y/EaLvNhOdAZ6OqFpgQaiTdS6I82ta+cicRIS7Hs
tr8FnRKswKL5l6cDEo+YKRcLTkuPqgta2s2SKZ3H9/gsLmKI3yFKb5XHRNAcxLJKTda87WI7
Uvtr2N0N2SAdkWL7EFwnUgxPjDlCQx8lLRTQ4kU5qEG8wukKIF0WmjcaFZo4txBdYaiL1jVF
3g1BoK3XCBaV27cZut9kWjplo+erfGyqQKGPRwEhe+cV1DRh4DhY2UsdzUt9xvBuVUwWEBdA
Y/RlD7vzFcE0a+8R0C2Iiy/wgVbDPUBSwAK36PSB3UwtdhzLUVneeS6LCYIkrrf04T1KKq6N
taXm6swIsYsy6eMaeZCiL/sUm23oHCk4rSpI8wbKb96lUgzN6BX7yLnLBeSk72zAIKR2va2g
mZYEfSnu3lfZl49DbjRP+Prdx93L/lP0u0mMfD0+f37ogujRoQGyQL7AH5Im66xD29cN9Jd1
b/Q0ZqybHIs4uVRJcv39l3/9yy0+xrJvQ2NrWAfYzSqJvj6+fnlwg46Rsk1uEy0PBYpoKPFk
0YInjgsH/wteO+WCFhGekWnKx5q9NSL//vJv7PGwtyAZWMRgmyp9py/xcvr63DvYziWDkSiT
q0OXLHTXYGiaCvG+muiaDkibc6dYw65w11yKZKg0L8I5p56ShbPHHRo3DfzFkA/cKzQlKE6S
r2wrGndldMPnCkIGCV4wvWmobej6KqRY5kGgKaz24AyUeS5Akuyl6ZGYFw1nWnShncnOGSMV
8qaRaBMrnzOA2jJUUWG6xbsEN2rRU6YpqDlSTFzDenc8PeisQX/zZWdXTVyN5SmY0wkKj0y5
tEJwPwwZwGM46fVoD7+EWDdh7jIDTDiqDoE6qO4u8MbyR/vi7qZl3BSspWCFdB70EECubiH4
td31HhFnN8ED7fY3aEJZnY/88SmJ3lsJbpk+O4l/TTjWJiiwsEkLAaOVWjcljP0U6V/7+9fT
DqMefIwT6bKTkzXZmFVZqdBkO/s+QCEGrFkoNwE4v7IKv7XLNWQBkUFX5xqSOtOLTASrfbcR
TUOHz0CZBgaH4HmmiMWXMesa38jU+vUMuliWLBjCksnESgnCFDqncQwfZ9ZQL3C5Pzwfv1np
t2lIhENxyjb02Cqe6pRCWxLfcUefXNdLuZvfPdxgkvt5HnNHVittssEDlNdX+o/jxXjeTsly
4bExsUjr1UmtpDX0fmO1L1YyPN+puH5/dvWhp9B3nOCHa0905UajBQVdgDeZodI7cHiVG64l
9tGFD6OiAqBMukAC3qO8/mXs+Q4ZB9XpXc15yD+5i5vUPtt30lRzhcx+F43pGh1QAoI6W2qC
NLyqDD15gJXS6bWZavkcq4RplSxLot+RDUI5L3fjRtiVWKsYn5zRSlvdXjtU+9Ofz8ffMSsb
yLeCyKxo6IiBjrLcVPzCfJwHSRnJx3OlCul8jJXUHWyb2SVY+AVymHMPpGuRDg5INjGGwMyu
FdAII+COgjINYKkhTGVJaL01BcR/vHTyv1jzvKLBy8bSOirw4c17m9a6bpvacY4F9MiZ2TSr
ZNuULyUk+EgP0L19bQUHP88KKAGXsRhkjlEjXQ6qK4oCmcRSBa9M3PDqaIhahktSezLw0WIu
Q0caSOqqdvqF7zZdJlMgXmTW3jAQLogIH1zcElbPPOszyBzNES2bUEhkKFrVVBX1apXB0wdH
kNGQfJhma2U5GghqUouVBc94425uS5z3DBpEZSipzExX7k22BmoZ9XvTmOlsNBhlLPxOJ6lR
6edveWkDTdLEdiqgtwQ9/vr7+9ePD/ff2+3K9FKy3N3VdajMHEaJD2Xx6r5TdNYi1qrGN7pS
suzWO5S6EQS1OjQHKS/ruXdLQAwRpgp7y7VBeeKXJklwY/D1iSur+N2mcd7y+LekCp1UQ9Et
mRGvFnR6gks05RSgw/RwuHp3rsXMWzZN/3cj+Ec9izQcvik2V9KnQgns4kJZEo5fg1E/OND1
wiNjfjuqlmMbabM1hZn+d8tycFZlxXntpME67LogVWtEY5ol0wdLEldUQ4AWiy2wCvBmHJuN
ikVSjlUDMwTzGHxi6N7M2RS53NirZKNwrMEB0VlMqVZhxErevTkFwM8irt7/8ksYeZPMrCbs
y9XibBEei/wNi0Yvw0hwwVhhm0m9x2Z37MK1Adrm6xkDZNGUHs2gIhPHCTPfE0tdFIndN3xe
hKuHCmv1MUlAarDgHdhSXGkaHvD2IlzlW5A6VNhfLzmOfjRflFKc7uV7y+oMsLYquh/04yKG
9VvENUUjrXF+wrWrXRcH15hP3vv1y5BYmZW0kngvyPEXFDgBIygeolMRwXsliA/hlKhkaXdq
gdv1tiDhu2GbCsOAmTrrdefthS0fhPsr4weOwVltv+TBBUAInGZuj1HDUJrCL4PMQz1LIy6l
cJmakYMo+b5usYCtkAovxul61sOqEhmurO4eKWrjLWaeNFk0xriHtlcfl20bN/K2dV9exTeO
cOGDpN9YMB+AT5UUBIRlly7zgp/otH85ealrPfCVgh2dGVMqOHg3vGJ4h3MYo7IJTw9hR1pj
d0tSCpLOrdOM6MWhyZIMlkvUiS0lPQx8wd9oAnvLZdhuD4TzL4nEdhXMA0PTVVLattdd8A6M
AYnw88wbJmgRzs5uGL7oODifXZ7S/KaI4RJIZCsG4mEXCGgITLpuwkV3HQGWB8/s8pVnOa+m
D4c78FxdTkKY+8IXvt96qIVoYDl36DS+kSFtndB62WKe+eBD0EFQ6rbPnYzMerwuf7dUZ2g1
Mkek4BMUVs4UCaVOEFslzDLABoApTZ8LghsiQrKM6GUyaSGXaeG4l91h3h2j7GH/iK/oDofX
p4d7U9D2I7T5Kfq0/+Ph3k1RI68sDZltxNTV5WLhzkCDWnaRuGCpusm6o9RQpJ7poCMwS2Iv
yLYO8evAbzFcZBtRXXqDM8Bu1JY2+kerNXgCkuCtl+tRscxJrRQbE3yGbDTMVWf9rPs3wUH+
nOeq+nW7rl7HOr4tVsu5tgrxpX3BohUxXaP5HIE60YY5PXtwGTh9PCzZ5s65Mx+9aUj1AoTL
0kgZ+7+ryLl3MJdeDsj/mD6dBSDFnH7cOKpxyRVeFeo2SBLy0gBMXHenA3X6PqhIkKSliQjH
aZqBrEPBmm5Yl9Tvr01nYj7TQIVrjzQy3oT7wd+x4y7b3C/dQdxNw8RKesN6Q9XqbVBN0PEF
FFETXoyH3Ee9NYL5xDUJOzSI8+pOrE0OAtvEYIJSIZf1VBkCIrp/fjodnx/xF3uM9cpG/+0+
7fHhMVDtLTL7AZC9PQlJaWVnam2ovnafQVHnEuVve3XXL1Pw99yjHCTAjvvM+5ycbvFJ8Nbf
mvWilbQMvaTRjQiG+8Sb0/9z9iRLjttK3ucrdJqwI57HErUf+gCBpIQubk1QEssXRrurbFdM
b1HVjuf5+0ECIJkAE9LEHGphZhIbseQOA9Qz8ku/Rby9/Pn1Ck5+MNz8m/pHkgMYX73C4ms/
bN4SuprwO0CGl0tPRTsi6+n1mNRqf6kSb/Wo492xpt7swmBypefSMM+Sr0/aodvpdJcUsQ69
9se+h3cGlpIZR4BO7ceDxydqyVDbUP/bv19+fPqLnu7uYr9acafxo1RQ+eHSxtZxVqMYgorn
XDB8XBuI9pjouCATpagSzE5vu/HLp4+vT7PfX1+e/nSZlEeQoqkxijfbaI9k810030e4VVAH
qAC1tQOpbWtWCSVqTABdI8UWx5728FhIrtWrSs58t0Tu6z1BUujwbiWmNW2nDdM0u92XlzP1
ylEUtKg8kAU46rHWcw6eLAKxYz0OrGWFIwtYRA7N67jHXpsMUh+/vzyBgd7MAGISoYFab+mQ
46EBlezIKG9cxmY3HWx4UW1q0bRPdasxS7yAA20e/XZfPlkeBoUuD409G98uE3FKaq8uTV65
/iA9TMm+54LepNSEK2KWBROp6UoHn3qdNLJfCIPb9Odv6rR4RRb068QnfABpji+GpFgjMmkb
tVv3laDYjvEtFG1LFYrQins0MSUUXe9ahD+L342Be8yy8qoVd46XwTC0INbGtfD4VJ8gudQJ
vcIMAWybthgl0eWh0H9NxnQmFkusPZpvmLe1Z+m5Kb3sjnVydMzd5tmVkyxMYtdeC7suJmR5
7uxPtrzaCasKTO8hmJkQ+EBZLptDdxTyoDh5MpeJADkHAm1gex7adUla/ZHtqYXbgetConWp
RCHw4yWH/lgEFDB5Q6o4G7R9l446oUzB1t4EUrgqLHiagGsbLsD6KZCoh/Lw3gHEjwXLhdMA
7fJhpvwIczJdlqnrfKCec+fMKVMdv1Ff1ML1MiApFEhqdLYv4wYMqU56wQtUTG62lBGAvdH0
xh8SUSyatbvddr+5SbOIdlQ+L+u252gkrSdfcc4yeAg68wERcHZSqsFoRBXMpdETn0Ph3D1B
Vpa0BaAniOtD2LlQN/oOXra7m/iaBQLOYwgrqh4aHl/oGljD9AQAW97tKu40sZbuMBo10SVP
pmw6QKdpwvqhgFcIlQu8M3hIIKUEwFN2UDummzUP4KA9DJWV8gl5w+pjQvsGOx0xjmgvb5/Q
ttfvaEkhyxrCD+Uyu8wjxLmyeB2tWyW4l05gFQIHtE2YwlPpqUMtf4TNgF5EJ1Y0JT0z5BEk
bE4trkak+eTzaOC2bWnTtBr8/TKSq/mCKE9Jp1kpz4r7gC1IOFkTT+qkyUo0SFUs97t5xLD/
kpBZtJ9j+6OBRHOkAbcD3yjMek0gDqfFdkvAdY37OVJ7n3K+Wa4jZ5zlYrOLyK7Dti5A/ObV
0h5Y9ICH1uhw2oGWKg1rTwZZLnD8GOm7k3GaIFagulSsEM5c5xFsrZO1miSK08inWgkDVxtF
5FgJR/Ca+uYGa5PKfPHAOWs3u+16At8vebvBTR3gbbui/FgsXsRNt9ufqkS2kzKTZDGfr7Bg
63V0kBIP28XczHscEqihQXvDiFXMnVQsZoP9/Zrnfz6+zcTXtx+vf3/Raefe/lKM6tPsx+vH
r29Q++zzy9fn2ZPaS16+w7+YgWpAY0buRv+PctFERFsU7CcUX4ZJHM7SKmaU0FFlvWoGojo/
zxTXMvvP2evzZ30TwTiLPBJg4OI+vtNkJuMiJcAXdaY60H65lJXlFr2ST9/efnhljEgOAj9R
b5D+2/chI5H8obqEPT9/4qXMf0bq6qHB8Ri5OjaX/IS3Bg3Nf36ijGXgQ60+BYdMpq6uUmPq
RraAILeSEzuwgnVMkM1yTjVH6S5ixLrCg/0AFaQ1gAQGz7P426e/h1RXv748PcPPf72qz/KH
Gsa/nj9///Xl6x/fZt++zlQBRn5GZ6eCdW2qWJG89OoCfYgocPQhABXrUgmKhQCkDORmUqgj
OpTNc+dk9x1hlRffYAvn6GwaWLwkexCOEgS/cJt1UhSqLlpu1L2H7K/qsG4oaw8Q6MSI6bDt
wOB++uvlu6Lq59Svv//95x8v/3gSWs8NE8n6pk0ERZJM01GLJnBFhDobvevN0h5TpumhZDUl
hfUkVhqmBhZiATcRxXF4rQ7UzhK+iUi10UCRicW6XU6/Ns/jzaqdwptapFlCIE5Vs9xsqF68
V3tA7QfS+x9IiFvNFM1usY3IudfsosXy9qvRoqVeLeRuu1pQZ/vQqphHczWAEN857fGALZIr
Vb68XB/IIJUeL0TOjsm0YJntIu44nI0Yvp8n9DA3da44xhv1XQRT5bYt9VX5bsPn88UUYyZY
vyQgWM1untPVoCPZ1M6GVY0i1tmN0HYCVO6TGzuqIdaHyYN6m4BujG3F7Mf/fH+e/aTYgf/+
1+zHx+/P/5rx+BfFBP1MbQeSWo/8VBtkQ35MWvMyvETyTj2Sn7weDwIDrkpjuFawFwGVtybJ
yuOR9s/SaMnBMw30cM5ANT3j9OZ9McUgUd9IiY8kWOjfFEbC3UYBeCYO6s+kt4DSdjdJZvIy
NHU1FDvmG/S69B/uAF37a1/GU0ZjGtr/WuN04jOTZWXyUdrjYWnIQq0EkpUh8bp/KNpoQLjl
AqpVA11S+oBDEnnF9XNxee3UKm718pqUeaoknRtVY9Wr+5Y8EXo09ZkY944wD804NOUGgeDb
G7UCeo+3JQuAQ0jqyC8b27OMfAqTtEWnIu5y+W49x+mQeiIjvRirEqV9cMggEf07opA6OVq/
J5Mk/kZn9qvWOXAsKHwNg944L9TIa+gNpwNEBDxURvrAWqJz7k9NHaShprwPBr127W9Zqo7I
CU7Nleird3h1/nmOjVMaIydTnH5PYbrvNFmxFCQ0gv6C555Ux+ci2lFv3cJH5F6Us7qpPgRX
+DmVJx57jTFAzX9NEF185WrHsUi3sv69MF86lOKEgNsl3kBCXW9YHuvDFIQjHsQh5d5jibgP
98kMSeHypQNwCO0ONTzO2+Viv/CHK7WONn6ZaZ8wNCDSaaJjHFDgmnOpCjZGX6VXek1RQLaY
z6fda5LgRiUf8/WS79RSjvyRGjDAjlt7BqRL0ZLeIkTbRzxBGs/FJkAFE1lTbFZ+W0eaPODs
q+k+KJZBfTS1Eij+0JKwDk+PhucAixx2EQH9yNmhEPqky6qUUvyaucKX+/U//h4EPdtvVx64
kNUympR+jbeLffCrmZb671T55NBy0TvDD3sndgrDFB5pfkoyKcrQme6wJ72nh+PRoj092Ikt
1hHVIUswriMXXojiPfNYbIsyc2ACNlNoPZ97Ax2fvG8bn7o6ZnxCBgpueZ2Ck5ygZdmZTdg4
T55wLDfUgRFPVRY52mhyddiIImG1A4JvPZ9AnA/cw8gU6Aa3Wm+cMkZzDYbqRf3oFc2zs2wC
hvjDJIR9amCjzghjzuk1umiRChPo78AgHY5woj0AWgWYWsCBywLa6MAICF4LtlqvdPS1La/d
U/k8uG00MMxkl9OzpPLGQbTPbLHcr2Y/pS+vz1f187OTYrx/XdQJRADQZVtkV5Ty0aXo1Za3
qul7aDzqXUNPLrwQXvc+mkNZ6PsZx3grsGw59oYPOmse7S4Pob/cLb9JWD6F6BMHbnhlMcR4
+6EFI0ldnou4Lg9kpkuPdHLPiouHTBCXBOYGeVmbSwx+LgeWMccFNGccot9cQOMkPagswTid
KqAg6tPRVcg1XIdRoWccxqnqkdiapNqq/pNl5ojmI7T3X6C76UYU6aAfyKWnnpta/YM9g2rh
BsOZZ/B4gzu5MNdqMfUU05xRN53RUpjuoiehvqEVp0m8ODGtReaEWCrWv3AXrYEo3mFOG0Z7
/HxN6SkttmZXokxOfr0eWeb7+T+ILXDhmJ/rKxFq46Poo7ljSPUQLvPuI/lgh4FQGWR+Ivz5
dDBN0zyS46SRoGuRGQt4UGmSUygCDpCQkM9l9Izr8Mvbj9eX3/8GE4t13WMom9c0v/RhvXT0
xWttJyN8xRBBrp0oNQVSSQACvKkswi+0ZodbHmiaJqnjYGYEiLI9qONFppG7rgABBxIBZUUj
PoTilPNmu17OnfVu4JfdLtnMN3PiFVBfw4XAN4OSHSo6AnlC4vqvuU1xGO8JqjtmpdpEI39P
domqJrQdA10wrNki4PVp6z5wtnuYgusEDKcPSooWRIG55OEQa4wd4opu0eRxMMAOaC+iUcJX
0l0k3y5dTUyAJGAkDlH3UjvmZP+vS7AvW23CkMgQuZlZhzanrZdEHbx1t+Qlxf4hChazqkkc
JwgLAkt2nYb4IVzEManpK2ZGkozxWg0GvuVbZoKrI8Yf5eGNJinJVNrGzN5ILwisfy9nv7l3
HiQFGwbtbldyWhmJSRSzpfYJWlWK6QIRTZgEWlWGdrCe6FyXOAjEPHfFYbebz8khMCycy3Yd
VqSvIM+Bx8HpA4sW7Ze8wIJfI45lsXTkAA3pTtc8ZKUDPTUlzj4qkSZ3vSUVrWtAUc9dmumc
6GWa+mkfXbqYH8LIcPvcUYNwoXtkNqToPtlFnO8sPSvyo+G2OoBm4fgkDVDv6qEpBWXOHJAr
oqKVm7UAwbVSj2rF6kJdKNOjTdgvOSKirs+0ccqhkjy0RfckkEe6cLQfxyQXhSBXeS8zKd5v
7tyRZCA2RrL3tj6Z2H6qAI+7RQ2KkwBTPxBYk+RYdxY9UKtCyVWudNNDPEd0VDZctYDviT0k
UeEm7jKQ6SJw0eqPX4j6s5zAtPhVT8Dy4fHErg90E38D1gWFROjnrqhA1V6o0yM3+WmTicxp
C0hZrc4kmjvGZOf3opHn29/C3G3gTJ4AU41eOgkp4LQKCbw9mRNFcaroS/HwC2d2TQQ5aGIX
rduWRhWNa6JM6IoAPPfp5gFfmiO9fyq4u95HTBt6RSEClQAmVNwq1DKFCL0T2IfTfDGnndzF
kT6U39OO1eOY56y+JFhEzy8+2yUfAtdtqrVBZdHBpauiWVGiz51n7apLHD7GgvyjDmNdxZEG
edr2gczEdrnFrzWGNsdlrbzeRKfXe6sIpBgyKt+jKb3touDR7v0G8To9pLsCT6lERC8bm8K3
0UoRUKtCDfR2tZww97h+PyaXJHysaZpUyTMFHTWBXi9YE4j8xUQJpPtysqtGWH1xabETEDz1
gVf6Gl/mq5TGYuuyKHEC+SJFVkH1APmcLO/l7MkWww55V9CqrLTqJuk9cN33unwRsUDcrj6e
Y6N4osorH6gCFX3JSd7YJBK1UZ9Ovn+4qxRtxY8JhMilrskRFWSsIrc7A2pZkPrHUpUMvJ1j
tt0C3OQbPRCykeDqP3Bw2lYNJWdXndOsD2pQHTuCXr2Zr+6cUFY6H3uwWyz3OGcmPDclmpQW
0FXu7tiDm3ORdM1VBE0aPeFuEe2JtgFa35pQWx8Op0O7xWZ/b+nVitOQ7I7UVUOWLKx0Nc/0
XJAsV4xaMNnjQJaQV8hjijJTIrf6wSwg1t6rhy7nMXjLFQTUOng5pxLkloFpeId3UQyOqySX
fB/Nl5Rq1nkLp00Rcu/ZxYVc7OnECbiQXN5ZSLLkoMpuQwyibPS+fbei871BeCzKCtxaxjxu
V9612TFnjnJphAYdD1CpTXI6N/ep7uyMF7wtqoeuPpls8ENhA3Bi1EcEF7jkTTSP5O54Fb85
2gDz3F3XC7xnDdCl+7Ut/HCGVMJ1KN8LohLFlG5KxQrncMdtuqF+sz2a5t2wsUCsFZOtlHq9
NooUi7K2bwBHlaO6SuM4EFQgKrKRRivupZ7WwAO+gMlAwKZaCJiFmGPTKNEcGOnT2ZfV5ed2
WgNAzX3EX/wSLRImUZ3cK3lI39y6rIKmAblJMUT0MGsKtfQ5GEBRwjYlhHt5lACAtBTyqiC9
i6p6d6Yee18AwrgiU9JYlMdQsGNcspo9gFNvmJjcQ2dq76HNbr5sbVEWpj7XVmvRMaEC7rYE
0Bj7vC72Kjy3XC64koPdEqw2xAXCVfPj2+O2Ve2WuygK9A+wDd8tFm6l+qXVzqsAgJutS6kv
s7Z0SEarsrMMVKkl2a69ske3pAzcBpvFfLHgHqJt/E5ZySxQQ49dzI+TF7U4EnpvsLh4/RkR
zeLWu8Ddu203d1OyzB1JyKbWgNnEnxofpiX0phKHzrIzHlCxK0PrR2casIV4/VF82GLe0jHa
oGhXs1Pw0Pfr7RtemXaLPaq1GdXwOzBIavQf5G6/X2M3/irDwl9VuQ/dQcZ+RnwAxwkkEaCF
U8BPE2476LwKxBhpJOxwsCUR3VD4MnFaWNok0k4R2qs+WIFOfREy/8pMkB7u2Wlw04fwvl/e
Xp6eZ5CQsQ9sgHeen5+en3SIGWD6lKDs6eP3H8+vlA/M1Usvq3HXl5y1M3Bo+fz89jY7vH77
+PT7x69PKMbbhMl+1TeT4Eb8+DaD8DdTAiDwBm0tYHeLR80LZCBFCX2N0ZhWNF/yVs1nSkte
aL8cKXKfxb+Rr0/I2HUrUc/gmkBPdyD+4jx2sax8ULYoRdU7DnwB0Oyvj69P6GpPfDuQfuWU
cscRYYDqeevD2SVPa9H85sNllSRxilOcGrhQ/xdJOWn7dbPZR+52CmA1ZO/pdMqmtAo7AlqY
xB53xQW7Jl3UGXbAuaZ7yKBksMGp3//+EQwv0nlXnQ8FgC5LYkoINMg0hWwgmZNbxGDAPuDl
1zAIqVPMPtD38hqSnDW1aIGk/8Tnt+fXzzDXX/r7X9+8hkN+I5mQNfYYyIpJ3izhkUm15SZF
175bzKPVbZrHd9vNziV5Xz6SrUguXhIrD+v50Bowq3J92/FkrzGfMpT10rz8kDzq2Ejclh7W
sbhar3d0ThCPiNIvjCTNw4Gu4YPiTNa0VOvQbO/SRIvNHZrYZuSuNzs6Y/pAmT08BNKQDCR+
fmGaQs/wwI1vA2HD2Wa1oBPUYKLdanHnU5g1cadv+W4ZLe/TLO/QqHNmu1zTGqKRiNOHx0hQ
1YuI9mkbaIrk2gRszgMNZGwHjfqd6mRTXtk1YP4aqc7F3e8vmzzA5oxtUnsT7Vw7ftU86pry
zE/eLURTyra52yTglDs/C+KEiFXAH9/e4BwmHQBqV6TTkhisTGrBQlc5AoG50gA6eoNICXDr
/ZbyrTB4/sgqJyWjASdwYYOX0sYjuUglQjLazcRQBNKF2+49FqzSrLvnGOWj6Rzew5YPt1Mh
WbyHdExJMuWRQiydXXOExxRfNKB5ecBeLgP8mEZU9cdaIN7JAXf4lqIRcxZqV8vLhngLxNCa
8YZ4TYo4uYrCyfc3IJs85lRx2mgRRHTRMiKQV1bXonRUzAMOor2z0MUPY1sVc5WUZDY5l+bg
WIZGHFzeQHf0KmL1QLT6t1NSnM6M/OLxgTpgxy/C8oRjxnKs7lwfymPN0paeSXI9X1CK6YEC
WBUvp+GAayvy2oABX0mgcB0sCWSXpmTxVVtTyi6znvQNZw4raiCwCDv1YXjAxQlTiapJaOM2
ojqx4soCFglE9nBQD/eIquTIZMBzx5KZvVRNYSWa06eH7T/spobDvEEFiVoCFi6xmtigjQTc
y0ji13Lmx6qDDRVpD+ERfrveZwasWHjg+r64UMiz/uDEwBpiLtQR40MzcQCoVzD4sXsg68hI
FKFAILtNmlHzjiiaVVSFhpOTjoh21ihidsJS9DMV9rCukIpVJr/HQJLRH33AJ/l5MX+gluxA
kuY7GzVntQLUJx0zBBHynlFjKGn54ydQbkzyzzXu9caX0HWS+11XNdgGZCKQg0BzJfm7aL1B
ShuzIEzS4yIOBcEX5W9lyNWgO0o6KZox7ktPHzW+CEkeG/JS8EwnUIbEqf412EqC8zI5jogH
kxbTJIR4fn35+HmqibD91ek8uWOaNIhdtJ6TQFVBVat9r9E3O/cZwvxx1JQpHNOk2xwi4jYE
h6zLSWuPEUnL6lC15N2cmKCotaFevltR2FrNDZEnAwlZh74ONQ7IXJiQaTVNdwncU+IMl8xC
XYppVx2n2U2029FSGSbLyzaQM8IQlSkZqW4SYH77+gsUoiB6Uml9IaGStEXBJqwKmy9oidmn
CtxQ6M5TfYsG6NmDee7tC0pwXIauAHBIbg4ZfLVMNGR8r6FwHbgQEE1sv9T3gX3CoqVIRcDD
safgvAhYAAaKxUbIbSAZrCVSotBmeZvEHnnvG3b0Z3CA9B6ZSNtNG1CiWBJrjajk3cJCLvsW
XVe0PGnRasF1WXWvDg5+DKxo9KVFXG3EtFGiH3hIjE3fEeBtxd6cyXlTmwulJtMJtHwmS+B4
pPS5SUgTR63lI3T0VdNttqo83eDpwuHWUooVrnIBDGqcuXcE55D8AYLuuZvjDhD6monYpKIb
uUWNgRSenU7lTrOUulxtZjdyXso4tQA1Hb7lxQDU6kHhyf/L2ZU1N44j6b+ip43piJlt3gQf
KZKSOCZFFgnJcr0o3C51l2Nsq8J2zVTtr18kwANHgq7dB4ft/BJAEmcCSGQC6TaFOHXy1lfI
AaeZzUblXhslz/Dudn4dq5N4kAOmqimh2uE8ohTWCIOXObBFWD0gGs/cje72GT9BtJxpgXse
iEcYOKit5AwHyjP/zgsUA8qyxSKnSeEsLJJO15XprfFAEJxXcHpx7FXlimbsp8UnPcate3CV
ryWru7W+kxmDwpjC8eNoL0MuFDzJJIv9c+bHVOV+06hkHutevXkA6o4x4yfmDAVjjeFuoP7+
9P747enygwkFcmRfH79hCyQkS7u1UPlZ7lVV7LdoHxf5G2YfMx0PUD3iFc0C35EcGYxAm6VJ
GLg24AcClHuYoUygK7YqkUfNlvgNqevqlLVVjrbqYhXKpQzxFUA3VtuwrxX/+7yuq22zniN0
Qb7TZgXcsmoOXttsxTJh9K/ghXU5OozIvnRDH/MuOKGRr0s0OmNUc6rzOMR8Aw8gcV1XT1MS
1FE1hxR3dEAB54uBStrzMy5PI3KrXta/Dnpxfcl2lwl+tTHgkY9NTQOYRCe1qKMaAWcgtZ35
9pkP7Z9v75fn1R8QOkG0xupvz6yZnn6uLs9/XL7A7fnvA9c/mL4KHj1/0xssA1Moy2Gs6MF9
ud3zGCOqww0NVF6H4iz2J+B6Xhl22gpMw+DXKML1yBCnrenUMVA2rX/S6vmmqFvZtyVv5qZO
8/JGJTb8ikP/JjYxLPmwEq1bU9nBAtAGc75hgix+sPn6hSlBDPpdjLH7wbTB2KHyQod4DLos
Q0CFCqI5WCuXpnBTcTT3Mc37VzG7DCJIncnoKeK242zGJ1TYNvpL/vHYwzbTKNVGD2u10nin
0VchThwcgS90KHhNYH31MbPAlPgBi23hlVfYSWpfavcMAoIyyhAGWLJMu0XJysktd06gOZxi
pCGNvJkCamG2LliY1vdv0Keyeeo2Lqa5L0wtXBunnYSfTPHgQBFyNN3UpVgfKCiLFXaCA7gR
BU984zj01TIgRJviYk7Q+HNChQh2aOCfV4uiAJBlagOoqmPnXFWtngT2Qhb/6QxtIIqXatUL
ZLZt97CHUhw7gfMwPcVo5oZvocBlRuYStoI4lo0bcCxsj6FLnErLnpCBJ3jcYRF4mqkk2ue7
/ae6PW8/iUqe+lf7en2/Plyfho6mdSv2A3srrYZnn0p4yAPgoVUReSdHFcKYDSYi33XYK4qz
iIfbo18atFz5oHzXq/8omrI4ue/loH6TKRknPz2CA/+5NnbcT5psLdS2amzMFnF5KZSwth/z
Q4JLsmRsmwSvUG/4zkvPcwD5+SlaQRLTsJpgG+mZaViEJ9H+ghhS9+/XV1N7pC0T/PrwL0Rs
2p7dkBCWacPvaGUjPGFRvALTon1Bb5uOm43yJu5pWrfgB3gwzmPrF1s3vzyCa3q2mPLS3v5b
ttAzhZhkGPRyxWcShOgagDMPrS6dmzO6Yo8u8YMyvzmwZMMpsFQE+wsvQgDS9g+WmqFsvKUG
udJT6zm4JcjEUqNhUwe0zlrP7x0idcYBAfeN6kndhJzc0HJEOLHQeoP67xvwJiuqhqq1w8WB
GHCpSc/6IK4S6fCdB67iYQuyQ0+bWqh/kl8O+F8xRh8ITEXsKbisY4oShEQO3cmpbrPRjprG
JGX3aXjMqTWRZU3hsghXykpek697lcrteZx5w3x5vr7+XD3ff/vG9HZehKEH8nRxMHi+lGdV
jog1HL/N4tvrBfcPnCG/TVv8SpXDcNNg++4NhV+Oq7zZlr8e1Zg1zm6pZnfVraSyc1LZtEZx
9ZpEfYz1QgG34Dn0pLUFW70jV6P1aZ2GuQdvAdcHHSubkyYLRPmRL484cVpIVRk/F0f7d8Lj
jk22k68TF/rGtBvk1MuPb2zS1JR3katpWajC+1b7oC0EyM0N2UW3xQ+tZwYPnyhEZcO5im9t
oTbbkDDWq5e2ZeYR15GrBflsMZQ2+UJ17Gh2LpY62j/T/eczpZXx6WLbaP+wqvWTALfiG2om
18an0oHAwM3ozrTto9AhuLHizOG51qbleOJ6eoV+qk8kMr7xtia+qzXe2AvNap0ihnzQ+9aU
WC5XhiYvzzw6q4sd+IwsheDxAu1Lujzzx2AXUgxiTFRQWA1RtcnVjfQC+O1Y4uqThhgJrs6c
+T4hjkZty76RnYuL2aFL3cBRQtEiAqq5N+BtUnrO6I7rh/uP/zwOO+tZE5+q+dYdto3cZLXB
Bt/MkvdeQDy5kBlxb2sMmE5lh+9ApJGl7J/u/33RBRz0+F2BnqpMDD1cLDwjKUFsBzt6VDmI
Ir8MwBulXI1Qq3C4vr1crOMqHJ41MXHwI0QlOfqYWeWwS+f758xyPajy4aYyMk+MOtNWOVy8
hknhBNY6KNwYnXTUDiOpnNy1VnpEI59zzHhgL5F5ENubZo/GBNfYerq25WJZRXQW+JOmSnBV
iaOimZeEHg7OKVEB4LFQSks0wIPKd5rDKyO4UF4+yEQwzZeF0is+HkVkCO8l3d9xfglFCoAA
nLWWg1J2f2jb6g6nmt46FNTuOq2Fl6j6E44JTdt6ARUr5Nnq93fAeQbKPTVEirZnC2cDW+jS
TFFjyiiS8TqFs7U78DtMkiBM51E2IjD6IuVZu4ygI1dhcPEs5bVgpPdr6WJplF0Qp8KFgyxO
Xih5/cmL1fBMKqDbgOvwLsejpOp8OT0fWLuzZoBOt1QVaeLKkUZHOlvv3VhcJhuFDBh2Aqiw
aEG5xopjOi9rdMsLkJGJZUASB3eTJziqlsRejBVgmanmrHlLzaNsypH6Uah59BNIXlB+28K/
K4jQqzpJ8jiOEh+TjDVP4IaYQqJwJI7Z3QDwwhgHYj9EgZBgWfX12g9is8236WFbiCk6QEZH
R0PH983sOsoGaIh9Lr9FOfTrFt9HjGyHrHcdB+tOfFKTzS7Yv+djqVhECuJwAaIdMQvztft3
tn3ETCGH4Ll57LuSz0WJHrhydAqZTpRj3gmpXcfy4EjlwZUglQfrZCpHggnHAN9FgcQLsNjB
OY1ProN/D2VVgwYUkTgCe+IAtf5XOCLPmjj+sOQ4RBP3WYzHVJw4wJowUw3FZUS5mJpyBYtO
1axvQOipXSot7yMsyjPEY/aQlirDG7CONIFN7DL1eYOJABDxLIGXZ6bQj0PcSlZw1Jnrx8Rn
lZuZxW+r0CV9jQKegwJsgU6xFmIAen80wuKee282wq7cRa6P9rdyXaeoZbTE0MphLSc6JbFZ
0j+zwDN5mUrTuZ6HCsBDkqDmPBMHn1pDM1sOJHiuNGNLxlL3Ag7PRUcCh/CrOpkjsCe2WmzK
PMszHqyZrtXMd+aJnGh5WuRMLn4VoPBE2PmQzJHEZhvwg4/YQxodIn2jI5UDPjILcyBAZzYO
hUszG+ewS4h3kzpr/Y+Wnro6QYi7TYptfqbY81kUootepvpZn3pAHeGa3MxgeV4tMWB6ngRj
I6aOkRpiVIJRCTL9wjNklIoPhprEi0ImaBEJ2gcYffmL2RbZRxqBAwHSEQWAVFObkdiPENEA
CFT1eYT2NBMHU2VPrUbPA2tG2WBb+hbgiPFlmkFsm7Y0OQFH4iAVsW+54yYTaLLs3BI13LuC
JWyDVqAYJiI/nk+wybdVrQ2nBDgZtDIPrwW2Kp2zzaa1RIMduTo/9BZVGsZBnAipq7Jr+zDQ
Ap2NWF9FhC35H4xPj+3X8EN5ZQGLl6ZdxuETF+miw9SPSM4Qz4lDVHIxF1pcLchMQYB6zpRY
SESQSaM9FWyxQUYObfuAbX6RdYIhoR/FyHpwyPJE8SYqAx4GfK4iF6O3tzXXjJAq6XfUXa4P
xvHBEsE4/B8L1cXwDG2PJfPQSeGtCzf2l6bRgimggYNMywzwXMfHSmZQdGsLXTSJV/dZENe/
xpQszUmCae1jC3RPaW/pr31dRx+oN2yJdT2SE4sfjpmN7ZY/aGjGExNvaThyjhgVNWUVSpbn
mn3qOQk6oexTPBq9xOB7mC5FsxiZAuiuzkJsENYt2/9a6Ej/4XRklDO6ZWoEZLESpGNmHSnT
iEQpAlDXc9HSjpR4/nLvvCV+HPtocGGJgygBWSUgsQKeDUDqkdORSVzQYWYajIww8Ss2X9Ol
7afgieQQehIUefFuY0MKDpmlGje8AwNXcFLJHGogQCwdWoKHgN7EirrotsUeXhMP9wJzXGpH
Z9bOrkZyszFp4B0d3uefaVeqdnIjxxhGdttA9PqiPd+WPbbTxPg3admxiTvtio9yhmfnwvEE
2hOxJMPVVFU1Wappi1oqQxQEnz4Nh8EI9zxY4iLwLD72ob8mbdYezL6RF8dNV3yydxqI7cGd
RpqQGg/kU9OVcz7y/eDwWA0bHeDaoen7cq08l+7Xyj/swzv5iRpPlfH3snjqEVWJ4nEXYPwx
K55SZUIx1cpsndUpkheQpXNmYBLyZqWFe8Ixct9kGnkWVAP6TZX2O5ybe4vOasVjoILj1wuC
RXZ2x980/fn95QHsNU2/t0O6epPr4SAYRbr3mq+YgN77seUsZYQ93Ia6rctMWEZ5+H6cp0+p
R2JnIX4EMNG6qLgNOh60bObZVVmeqR/G/TA56lkCp+dJGLv1LfbcjmcIZqCy08OJpu72eHWK
1xtyA0rkhXd9wKXbZ840s6CBrpni87LAmtOipU24/wFOMAOPCZVtRWeip/WjvsyUQJC8G+Rp
4vi4jRIkAjj09HcBGIvVM9bIYv9CgCOL368Rxk4WBlC5teRtkbm+crUqEbEWGqGlT9iVEVMC
eZ1ht1MUniTxCpbyBirL02Y8V7UMVj2VSYjycA8k4PZ5Wd3k8jMQAPRnXUAjhMc0179UkO0t
wfHIYu4suvnJDcIYPyYYGOI4WphXBAN67DnDJNJHl3mTOtGJxfhwYCCJsyguSSx3cBOefJA+
wbdpHKeRv5S82G88d13j/a74zF/jYtYWfJQDps9sXUGxaFoAjbftc9WOlOGWZ54ZRrrV+yTP
rwaTYkths3WiTBzvjVWRs5CGxN6G3Q1xsA0sx/YhjdQrWCD3MLc3aIRLDpdBHJ3Gl51qyjpE
H9Ny7OaOsN7vmWksT0zS9Sl0zCVUTjpYvwozTVo/PrxeL0+Xh/fX68vjw9tKuH8sR0ezyCM2
YFBftwuSeFI3W1j+et6KfKN5t/LBtDynte+HpzPtM9Z3LB8nDIP12gJrDYuv1yHvqj7YO11a
1WggGLD3dZ1Q0SaEFbHF+4wAUZN5LsdggayLL+iWCCkTg6fb9WlfyOpgYdUdOMLItuqPxs+o
cCRayFlYRdtm38lo+idGNbWeCRl7m4qxFchylEFvq8DxF7RLxgCRjpbGzm3lerGPjuKq9kOL
WREXLfNDklhbfjQRl2jHEwlD/QvZ3nG3T7cpfjPCda6u/Nzs00XNYuRZ0rFuaxKg3j4G0HdP
unCDPZ5WssmAtBwgobMoNGNJEtyDHJ+Wm13N9PjYtdm/y0xMe7RPBz0Flcs6I8PLK73xx+M4
mLzwYCgdN6hu564ju56wbdOmxMUWtviN8uJwIppvGQ0OEXPj2FQ03Up7vZkBAr8fhN+h/lDL
76RnHjjh4AccMxeSE9PntiRSakgBQUdEq37mgu0nQScilUffokpoHvoWFUli2rNf+KNgiYnv
8j5gGreVH7BlumaFtWWaeJbVQ2PCOqjU4uk+9MMwxBpSPR6Z6WVfJb6DJoG7Oi92LdUNq268
LA9n8WzJSYzGf1ZZVDM/CRNz63J6xhPFEZ4B7DBCglm8KTwkChKsbjgkX3OrUBJ6Vij2rRLx
LckH/WDco3wkeQxX3agQwzZUdTii4jGxCclAgl5XyTyty3QXvHC2UXFdDDG3DRK2OXwuXHWf
KaFHQpwIW7Y0HoK2F4cSHLqtsTHDgy2qr9lnENkqSCDfmXzQwqP+v/hBfbUNXeWGV8JYeiey
jFu4M3Yjfzl3SctFMc+PLI0h9FZvuXuOOrEte10h1lD3F6TX1VYdDT6auEedc7Gko/rCXQLG
uzrkCwdFShbOvo0swDsSvLgQ3mnmY97ny5fH+9XD9fWCOf4S6bK05qeFIjmu/HBG4bL9TI+/
wAveCSlTG3BmhbVL4UnhKP1PPac+736hvIxtsu0FHcu84MHy5poWpGNQeTotzY/moxYBCW2p
LvcwStP9tsA2f5DneXO7h4c008NyaAbEqY8QHi4WEOHFPlw02+XLqq6z33tWVaOPImnjLaow
zdOWMk1M6mqcTos0jNXN6FDnZRA76PI6wep7u/H9+AAhKYXjpSGdkhtbbUr+lw5w8WRDm6H0
NI1jJ9qZ7Bu2/nnm14gtmFGB9PLj/m1Vvry9v35/5v47gJH8WG3qoUVWf+vp6o/7t8uX32Sn
Ff+3hFI73788PD493b/+nH2CvX9/Yb//zqR6ebvCH4/eA/vv2+PfV3++Xl/eWZFvv0mXL2K8
UZpmO9lNXPHycP3CM/pyGf8asuSeOq7cldTXy9M39gt8jU3+UNLvXx6vUqpvr9eHy9uU8Pnx
h9KhRHenx/SgNNhAztM48I1xw8gJkU35B3IBkV5C5UxPQjxsSRZ43bd+4BgZZr3vO8TMLutD
P8D2BjNc+V5qyFcdfc9Jy8zz1zp2yFPXD4wvZXOzZjw4031M3Rwmm9aL+7o96dn1zf7uvKab
s8B4e3V5P7WW3ixsZEQhNw7jrMfHL5erlZnNZmzn65vCrilx7bIyNIx0QRkxMog3veN6sU6t
KxId4yiKzYJhYLuWnYzMgU1MY79sQzcw6pGTQwfpaMc2diw+nAaOW484WBSWEU4SB6lDTsd1
8Zlh8VOP7cn31DEgNSoMzXtl5CJ9IXZjoyqykxeKsSjldnlZyMOztRR62yf1rdgYoIIcYmQ/
8FFyglRuekPIUifY9UTYKIoF9f758no/zIaYK1uRqjkmUbDUIDVNau1ZAM+lYhlLKzinbZ7u
377qQQxFXT8+sxn23xdYN6aJWCvp0OZMFN/FHkDLHHzwzpP476KAhysrgc3gcDg0FmDMEnHo
7foxNVOkVnwdUleG+vHt4cKWq5fLFXyMqmuHXuOxjw2DOvRiyyG0YDBO7yTvIf+PNW3yI6FJ
q7hwMFOI1RmwdNagJAcvBqouxxB5vpu62/e39+vz4/9cVvQoahXR63gK8EPZoq/DZSa2eLo8
yMGzBSVesgTKU4CZr2pRqeEJIZb7AZmPK2no0afBFeOi1H3pOFZBaurZzsl0NnQXbzD5CyV5
EXamozG5vlVYiM6H31tITKfMczyC18UpCx3tRlxBLf60FQlPFcsj7K2fyfHYvu8a2LIg6Ilj
r6305Ln43Y/RzbQ7IAnfZI4tpILBhm2mDSZ/qbvLjnZktAiUsxA1U7ZgWrCakK6PWFJqKfSQ
Jgs9uy89N8TMy2WmkiaubxnDHVvn6EIz+47bbT7I/1Pt5i6ruMBSNRxfs28M5DsIbJaTp7+3
yyo/rlebcQszrin0en16A/eAbG28PF2/rV4u/5k3OvKsa8uI82xf7799hdth5OziuE3BaTna
pXKLhzNGP+ctnBUYy3vKkshKwyCeTBZ8Wbv6m9hMZdd23ET9Br5d/3z86/vrPdzWKDn8UgKh
TrwyHWb1x/c//wQPsXr4oc36nNUQzlO6pmG0fUPLzZ1MknvKpuxq7s+ZNTXmjJBlkMuPaqEQ
9rMpq6orMmoAWdPesexSAyghxNy6KtUk/V2P5wUAmhcAcl7zlzCpmq4ot/tzsWf9FnssOJbY
tL2SaV5siq4r8rN8uwHMrBOBp0KZF3yKcEfOChW8ogw+3nslC3D8AqJC6Ltxp660oz36MtRc
2XUHVda29rTPZhRWiZvmDN5Dm/2e1SX+7ayzZlWWa8mzu3XRefh6wuApiKjaDGw2UM3WoKtx
L+wISTX5mMnGKdoMTdWMS9WVx1T7DiBZbpBHFCuPAx+UVsaqRxFocJuLLsgyzZWA1hPJqIeB
PPcpBNS8S0M70jvXI5pAgvjRlzAuRa4UwotRPffJHyT0FgM7GSRc/t5Xu4zPpxK19vv0iL89
B6zstW9klLNv66gcdEO1nxUNmyvKTMvn5q7DLcUY5ueoe1SGHJsmbxpX+agjJZGnfift2JZm
r04PaXdjDFr8AgcGJBunbBa3wfDycnuiQWi5DQepxJ08/hl1wXruvqkLdQJbsw/RxvNA48fP
W6PpRtQ65PqezRFOrLdhHbvaScuwEqLLG58w1/cP/3p6/Ovr++q/VqxLWgOxM+ycVWnfD2Fx
5q8BpAo2juMFHpVfWv0vZU+23MaO6/t8hStPM1UnN9Zix75VeaC6W2oe9+ZeJDkvXY6jOKoT
WynZrjmZr78A2QtIgsrcF7sEoLkTBAEQUIi0ml7NVstzQ2WnMPV6dnF+u2YHGglkIq+nrAW6
x85oDA0E1mE+nacmbL1aTeezqZibYC5hA8JFWs0ur5crNqJd16OL88nN0u5pvL2a0WA8CMvr
dDadmqGquu3sGcwR30fNZVDFxmg2QaRX1/NJu7FSgDt0g4HLwYiwuLqyY2gZSDYEC2mCYyUe
cUk6u5yds6OhUNd8tUlxdcFGSBpJOI9MMpSe5xljDeuL6fnHpOBatggvJ+ZOIwNSBtsg48Sh
kabzMaKi/W/23KD5WQl8ekZWh9LoWPLQuHpzO49DV50jyvfFVXmTmeFrstCRzmMQXpk7QCxd
UpXjgidXeXokn+jH+WxII0qAfZsxq20eA9dEwS+JOoF0PJkQP9ozCbCLnV21cWD0mc+h3ejX
UL1YiUQqx6GlhUR48f3Xy/7h/sdZcv+LzwyU5YUqcBtEkud3iFUhbtZOqg1C0SS2a2A3UCea
YdUhwlXE23Lru8KTyx0/LHMY62oja09G9b55bqqQnmDDDXOaEgZXbMoqum0jDqgVecZFPA3a
BQbPZ6tDY60/ZyB+a+de0GpKZefVpt4YUz6dyhuCpThiLwJByIB/XAYNxFZhTLN6DCAz2QeC
gf3nsRojq4KOPqmX7GMrbEISmPnIVZflMoVvfe2yHsSoenQT2DyqqsQU46obfko92IQEi49m
TDAErpWLQZqynqk4uBuzEEyIgn22ywH4ImmipYwSX+eAJNreZXnllBjL2cfrq2BtxFzocDcz
twH2JDUwGfIS9of1eXCrp9mcgbyK5UJ4UjwhRVob4mwapSo3OUOdRZsWDnojr3FYabmCiCED
rNUPHE3MosRDKkMv2XiDz+CylYpopu0uIEYw7Ex9KEQ9mXoMD5ogm51PL645C4vGg5xluYrq
FmEqUo8j8EjgyWqte+v16NTo8vx8Mp9MOJOjIlBO4+fWQCng1Gktyi1s2MsBez3dukVdnk9s
qA4L79bQwX1CjKIx84LpSvDNxdxtL4AveGtsh7+48AQEGfH89WrAe57wdfgr/l1Nj7WEz3EI
LngDxUBw6XlHoQh6H3cQpzznkyILRTCZzqtzTxAZXdeGV3Aq5OBD5uvhIpwaXp+62/XsgoZW
UEDGy1PB60Cga56/DXUSXFxPPPYcXbTfQ3VY6xd/OzXf1OH0knUtVWhZzSbLZDa53jpfdigr
DojFY86+HY5nX37sn//65+RfSqQpV4uz7irzhsHgz6qfuwdMnIuC4eDfAz/aOpbZKiVePHqw
MX1qao+rCnlmAdGL3mm1Suh1x6Z81gOtXihhptCUqqTGnf+xt1hiJ+rj/vGR46Q1sOAVyPLs
fIkgiPDVO1x32bTwEv5mcKKYcvwI1REQUsG/PLXpdG0nq4FLYFhiHnua5odFtxq55OnSOg6E
H2Or5gg+2K4WBmODGZ0TgtPNzwNMi0vc9OBXW25pZseRWBa5NHT6Nq4NPAn4bDrfaxBCWJUF
2wiA1742VBHHaSwKoi+LgMO1wJ/wxXcVlA0JGKFQzs0JodbnSbQSwZ2d6UehrEkra6CWRvh4
BClphDcS4et5VIhUDp8A1KJZnh1+os3GyZOMlg5Lq9ddjazv+qaJZhvKqkiEkckuDudzK074
OOzpCsPISomaHWbQ43pyeWM8qu1SUxYiixIKhp9DOstzC1zm2JNPF2O9GqElMxAHq4pX6mIE
A1Q5LTCejBEQlmL4cPCEQsmITPFWJ7ovRkBDzTsNXgqkEX0HQUVYrlGtJctbpgakCDEYvqYw
im5FFJjFw7IO8soIY9B0mVQ6xZmniiyqt2ZRRdlUld3WdHk55X3SYEZ11A9D+YJw/CzKGmfp
qge3L4dvr2fxr5+74/v12ePbDu6WVE3SO8L8hpSs+lqsMA8cN5+rPAmXkp3HIC7zdExXSzZw
HwrDCjffg/mMkD0W1i1NvpxGSSKyfDtqWUeUjjga53WRNOQY7uBUjo03UGlG8+MFKo9ddXg7
GmFTRos2hx9qEDJZ5Mb7SAztnMb8I+PB39oiGNCz6Xmb2gWqFGQKzN3vdAuU6oGwepAfGsJ5
tfkdkwruH84U8qy4f9y9qtSAlZPPXH2Ny3ilAkaRI9PCgHQtzFSyHAHsrGTpyUvpfADjt/5Y
nSxTk7CljgrK33TWrF8dMsvKnscqTd2tV+6eDq87dLjmLrJllOY1ZtHlPeSYj3WhP59eHtny
irRa6cdHKxQ9EcCuLU2oeQZftVEF2fWosd1I8yWKdsmDTvyz0imx82eVLP1fZy8oL3+DkQ1N
taV4+nF4BHB1CLhtxKH1d1Dg7qv3MxerTUzHw/3Xh8OT893QqaDPNMMOBvu9juO/LT4sj7vd
y8M9LJfbw1He+hr3O1JFu/+fdOsrwMFplfe2mP/9t69niN1u29t0xT8N7/BZwcsuTOGq9Nu3
+x8wHu6Adt+xeHO8a+msoO0e7l52V7pPdCK/dh00NJYE98XgBvpfrceBm6Z9RLWeAXY/z1YH
IHw+0Mb0sddUeDilFwbBJoxSfQliiIqoRE4uMmppMwgwCFylc+sy6OGNtad4EGflOrJb7uiL
x0620RrN2KPwvK0DFV3jH11q9IfDc2emdYvRxO2yEtdz6jbXwbt3xMNsd2AMfDvzxF4aSXxq
gY6iqLMLI8pSBy9rfDUrHHiVXhjPTDtwb+3gEEOideorl+blnc3vi2TycdqmBas9htP5YgbV
G6KM9MSwyWy+08t0IChZ5oy+ePrsFOPv9pehUXoAYNcR/nuVZntZE+0EAodIKQSmlFtXFybQ
iBeDAjX6WrtW+zGH6yCgwFWJxl/rwpiVt3RjOwUO5RWYthoDWo9x8jArdFuD5I0adCPMZymh
Orj/BjXrMKHTasEPTEedmIELEFPLPuxMn205vgOZ4MuL4iokc2GfYTUmvngE2KYSM6dr9GjF
DdIWU6DhopsiGS8Fwudd3lgogZtKgyAmLkAUU8moNDL8Ag4XgEy3V+ktNoEuVN3mLVz7hpZ7
ai62op1eZSmm1zasRAYSe+jtXSqKIs4zuFuG6eWlx/EFCXX2YpzWMKrY88qcH/I1slefTj4N
Fs5RVOyO3w7Hp/tn4H9Ph+f96+Horm1kAkFATL+KK6TGCXWqoGGxiarfSOL56/Gw/0qPcDhU
ytxjuO7Jh0NBEKW+yuw2Nk4nenP4RB+BJEIxNHUGIt6cvR7vH/bPj27/gQUY261O9TWsXWAA
OmbBjBToqUmjfAIibNKULF4EgbBZdnFFciPe54iLI1HWi0jQ60xWw8KtYxfS2c6IIquDr2re
qDwQVDV3lx3QadVwtdWSgY4G297JwB3i/qNlsRKUdaq7XVECS+vDc9oXvxGp7o+c8xaU2YI8
OHxRdYZXDz5YF4aXV4/uJDJfsKCBTgbR/Nxzex+IUhHE23zKtGRRypAGp+laBUJM9DlysF2j
Cox+E+RNYTB1VR7c8Y2YuPnSgJuVh8vE+hwg7TKNnBHp4K1P0DaIdKt949FTDS1yCxFLTiMw
oI3YssvKWPPwUxluQRBsMyslpEFEEsv+jiZuONcKJIDDkwgYCrKI0J/ZBOpUFz0/bpJawsxt
1dyN4Qx+/tj9bbi3DPTbVoSrj9f0eW8HrCZGvlmEmnIfQrpwyGbwJas2IkLnBRFnukTkIxOE
3yie+KylVSKtdBwA0Dd2FSjC4BdloD2+idoTrt81jcMEAlx724gwjALq4GWJ7tozfQ/3Tn00
mg8SRSIxLSPMBGqFeY0+4GSeCtJzkJinrXmWdKB2K+qa3wZAMQMKXsCfY3FPBvFcNSqvJMxm
kPiKVFRVFDSlZaMyiXwmkD8XIbki4C/HL7tq00UAPMrY+GWExg3ALXljwp8OqudSCkFHDiG3
TV4LtqCtbxAIntpM8Hee4WsR28ZCMGVUCFnajdiIklfRI9I3gKtl1S2FnqkGHYSMVg9r82nA
sYsBTwKKJU1Vm3bRgQot6fywaxKdfBEY1E2S80pqSsdO06LWk0ucMjvIOBuGQN9jYZ3AJQV3
8Mq7IgfisoFrqsiATqll/Q2x1qQGws0/olM/FhstMTux8Twok4k7L8upb5la/Ry2EqqJDctb
B9HecG1e0FcyEtW6AJY0Qj5qStBJ4c6Dh7Lg1lLeFWb8+mVlP3gKbYDUAG1PHz8UNp3abHTy
FACNM0pvqrjv0pd0oCgB332BG8YygxglWrOmgTVIL0bly7Ru15xXisZMrQKCmkyIaOp8Wc2N
haphxp5cwpAYNAEAxl85LBZMG0EpRhgsp1DiQ642lGRcOQKRbIR6h5Uk+YZ2khDLLIx49xBC
tIW5VB3hmMVIlkYwHnlxN5ho7h++G0/nKodxd6ATPKSniDHf2KoUvBa9p3L4okORL/7EsUkk
a9ZQNLgTjI05Qk9UQIg8be0tU3pY9BCF7+Gu9yFch0ooYGQCWeXXcBf3nWxNuHRQfT182Vox
mVcflqL+kNVWvcM2ra1zMa3gG547rQdq8nWfBiQAybbAoJbz2UcOL3M0IGN++nf7l8PV1cX1
+8k7Mm2EtKmXXMznrO7PBqLGO3FGKmS5oXKmZzi0AuJl9/b1cPaNGya0Fxk9VwDUVFG2oIA4
Bm2aw+mSlxYqiGUSlhFhrzdRmdFiLQeLOi3MyVGA30hnmsYRCPvpjXQOhAgfGYyGYPXPkZFg
ma9F6Vt3zICRZSQr7aEBXaqjlF/UwPs3eXnjo+upEjIk8KNfJ8ZCIuh+JbawEo3FQnF8BjKT
hMZUMTBXF+dmiwhm6sX4S/M384oNvmCRTE58zrnuWSQzX4tpkDAL4+3L5aW3tGtvM69n3Msr
k8QMNGR9/tteXs+vfe36OLcLBlaMy6plmRD9djI90SpAcuIF0iifIrrRaK2+j3r81Ndc3kWX
UvBBmykFbyyiFHz4JUrh21g93pqJod8zD3zugV+Y8JtcXrWlPTgKynt7IBqT/MDhKfgbWE8R
REnNqldHApBemzK3a1e4Mhc1/4B+ILkrZZKY72p73EpEycm6VyDZ3tiLCRESms37Rg4UWSNr
cxSHAZFmeskeVzfljeVmZNB4zu4wMV5wwE/vsd1kEveQ4ealQW2GFt1EflZJtk77lxiqF+0t
sXt4O+5ffxF/wuEUvjOOPfwN0vVtA4VrcY8zxcCVGcQ/mHikh+vJyihj0ZXD6V30PSsKuYrb
MMYYAaXqIp8lTytd0HGuUmazupSBEcjzpF6mR7ISXoymCZUXKYu0fzDK+WOqtHGtOESGT6VT
whKKwPeRbJNccmSgVcEHnYCLL143tTWCWihgyAJVBL6W1I8lf4OGeur407sPL1/2zx/eXnbH
p8PX3XsdyWoQKXqpdBx4QYypSZV+eocuaF8P/37+49f90/0fPw73X3/un/94uf+2g4bvv/6x
f37dPeLa++PLz2/v9HK82R2fdz9UvIrdM1oixmXZRc96Ohx/ne2f96/7+x/7//SRToZbt6yx
U3D7z/LM2C0rzHCcNCsJW6QuGxBRI3Gjes57DrLki7syWv5/6XGhsEYbaCtsWLWMhvGkaoae
Am0MJgGJF8aOR4/2D+fgnWLv/0FDh4HjUSFCb/PKw9h85aZhIEAHxZ0N3ealDSpubUgpZHgJ
OzbISWBcxQvy4Sp9/PXz9aAjCB/6MGzjrGtiGMiVKIjBwQBPXXgkQhboki6Sm0AWMd05Nsb9
KDaS6BGgS1pSndMIYwkHOd9purclPcYe3vamKFxqADqEIshThhQORGBJ7qh0cPeD7nUJS42R
ZXSiT9Q+Op+ulpPpVdokDiJrEh44pdu/g6t/3OHfd7SpYziJnPI6R1V9JX778mP/8P6v3a+z
B7UwH/FZ+S+qtuinq+L16B06ZP2SNS6ilqgBFsYMsAwr8WkIzvj6fff8un+4x2DN0bNqIEZn
/Pf+9fuZeHk5POwVKrx/vXd2UBCk7rgHqVNnEMPxL6bnRZ7cTTAlg7uNVrLC8DHuDPQo/ppO
iaYXvFTdL5u8bCpfGE1KA5Vx18WOpIpu5drpQAT9A/a77jnQQvlT40H44o7awl0vwXLhwmp3
pwTMSo8C99uk3DBjmS85A0aHLLBd9sxt64opBySsTclmVeu3U+yfaow6UDdpP1IxRiP1DFQq
3JGKNdBu0hZa72/POlWPcbQyb/+4e3l1KyuD2ZSZGAS7w7KNjRfBI3E9OQ/l0t0VLD0ZJGcl
htwjigHpjmsqYQkqxyd3Fss05DcXIi5P7gigsPaVg8dgMnZrqlhMOCCUxYEvJsZ9fETwt/Ee
n3Ielz0SbRWL3D0o61U5uXandFNcqKxdmi3vf343bPUDn3G3H8DamhEjsmZhxorqEWXAaxAG
ESHf+N6gdMtM4DMRKZjCA1HVvPaBEJyYzpCGVOtgS/WfqewmFp897yP7SRBJJdhg6dbJwKzN
KopOlx2VBdwbT6yAdM6cy8KFbXIcbx+8f6baL40xhLGzPEDUSkyNcMeNP+fOqF7N3TWYfJ4z
AwHQ+ARv+1zVYc/byvvnr4ens+zt6cvuqF+HWDeeYXVWsg0KTpAMy8VKPcfiMR7+q3HCo9Og
RAGrUScUTr1/yrqOygi9XYs7B6vf31L/KwvRdrzXbs2Arzp519+sgRQH7ERJeB04xZIEe5zG
G3bQ4LqTYlw0uHCjSgPDzDhujsHu+IrvAkBGe1HPwF/2j8/3r29w8Xn4vnv4C+5wxO9RGQeA
wagQS9WgcjEsJyYFDp2y/n16947Yyv6LWvsiFzIT5Z02PS/7TZTsvxwx1cTx8Pa6f6ZHv77d
0VtfD2kXIGjD6itviEFIWAb4hQS2j08MySbsHZrhRMgC1KKUeWrZ2SlJEmUebBahVU1SQwrc
bUN64GqNE01rP7hTB9L2RFKBldC6HaTFNohXyp+gjAzpAa7PASx/AzS5pGs9aF2ZI2hl3bS1
QTYzrlfwc1D9OfBEBtHizhIYCMZ3fikSUW5EzfsfaAqYI3aPBNRSAj/NXzRAnFy40lpwNf7q
xDPDWzgL85T0mWkBcGTk9VZyI4SiT6YN/wytwPfiJsNXUOcYAP4/lmxASckEPmep5yw1sn+m
2QrMtXv7GcF0bDSk3Xrys3Vo5Ype8HGuOhIpLvmV0eGFJ8LxiK7jJuWflHQ0VQGbhvMk02hz
NY/db1ef6VsOglgAYspiks802kG/jRkl7qLzihnYdpUHEvjAGt9wloKcWBhEDXgA9W7XIPXc
3eANCDfCLWQgDiEEyVod3W5sdYr+OkEiSnQ6j9VZabEZLK+K6qZQxIar04AH4agM803mkiBA
PeB2oGVkNBtBgWq2vmvtvt2//Xg9ezg8v+4f3zBXw5PWQN4fd/dwbPxn979ENoGPK/k5alMM
HlJ9mlw6mApvOBpLmRNFF1GJhiTrsT9Pm0rPu36DSHBPkpFEJHKVpTjYV8Qqgwh8fOKxzFSr
RK8iMmq39MBI8oX5i2HUWYKeCczyVBEqLongK8tbvGeSCkKZ6tgSIztdhqTsXIbKhxsOQ6Kh
bYJqiuejKS/gE5U8sdZSliNCaUQIKbD91My2rks7bYFyJAVT7d9LOAr687h/fv1L5d/4+rR7
eXRtVEoKuYHrWmro+jtwIPAxFTfX+iEHBopMQLpIBp3qRy/FbSOj+tO8x3fhJ9wS5sTYled1
35QwSgRveQrvMoFBSBjXqm7IvMMw3F/2P3bvMc2eltZ0xpIHDT+6g6Y9TeGoyymf7GHoQNcE
kRFFh2CrIpF8KEFCFG5EueSPDkK1qD2mlHCB7sKyYH1Qo0wpidMGrZDo3zp2YlnCRVo5Qn66
mlxP/0GWZQFsHB8d0TgPJQj3+mV+RRh4k4EEh2ne00VOJcPeP5eOSxzho0F0IwQGnvAazbyA
1YmsR6K7M++hqcuuokBZcFNZpaIOyAXWxqg+ov/0nbVTNyKru2EocuU7WtnD08GdjuX4immD
Ris0AQaF8Xrsv15kw/7AgNgq3fTtWBMBDuYsPZ2fzv+ecFT65aTdVvQPixwo+lb151RnFgt3
X94eH407k3JCibZ1BBfmzpRGMXBashxDIWHoqjwzGKYJV5xSuVB7KT5HZe5uLUVkmRYNgjIP
Bfrr6kPD+lo7dfLOZFXSLFz/0kEoWUf9mIIUgyZLt/Qec2I7a4tr4wnIo2nWqVv0OlWaXI8v
wUBTLuy5BmCxAqF8xYk9HYkOT85U6sYttyj0M2tlfuUOj0DVciNgpofY1EMrNFgNyKeJY6cd
F6TT6hu0f/6yKoGyAIxRxGBzFoaUj/SnpiS2ggt18hvUf5YcHv56+6l3cHz//EjOBryxokwZ
/V9lV/cTNwzD/xXE0yZNB9Je9sJDr01pd9drSVoKTxViNzFpICRA4s+f7fTDSZzCkCZY/Ws+
nNix09hpYUZxo9jUeRsSnbUOTPmk4sAGREEy7uNgjAHqQBvw3mBlQ9GB7LSJkWdhfwWaD/Ri
5kdYzFFIcre58GPtoGJrsIhF+Wf0uZUOEY2QumOJrAxM6yzMi0uP4ye+7VtWohQmecM1Liod
WOlOqYZd/IHdXCbayZeX5z9P+PXq5dvJ49vr8f0Ifxxf7zebzVd33G2Rl2TChffgNrq+niMk
hPZQCdgtX1bRE+padaOCxZQlNXLlT4b3vaWATqt7OqPi19QbVQWvUcM8Ax2fZaoJlcNIiPJ7
yhi3V7G3kX20CTlawdJsoiaBBLWdVp6Pu3Ry8hFYNN3/DO1UoNUdoAw8dUkzjIi8H2RYALPA
DML9epiJdqdlRdPs7PITZRn8u1Z6WxslMKz03QR3WfyAbuLGFMXZlF5uMktKwcIFHw8MizC5
nk47yWqQxwrAlFFlmMeJEfgrQisJ4nMfH6orMcxiSofktM/vGehBa8dpsuBWOGcjpMAOwvhb
mcUTBwelda1hNfxprVARPEYzrGJwD+2Q3ra1JF6YGZ744ZymA42Tdwdr/K5TL3XSFDJm8rDy
id9x4tCXbYHOsvHrseSK4l7psJLOPAjGPaDkEJKsbL+QdHzRlrIQbatxX2LwmmhrTV0lSU72
tstz3lPKo0N4xz6FXy2Osk1YH/CHFUUqsgcg3/5ptFIVODBgiovdCuqb9i38ikZgmFYzD4TA
G3BpMV5aRd12867pK7AqcuFtb4ldARQ9zNU1wDgdxiGXVPw4puaQNKaonZXUI03+FrE+VtKw
BT0MA2jTYlqWL8YXpyk6+ShyzZKTA0h2ggdt7Xvu1ttY1hr3yDRZAWz3O4rqx2vSdSx0cQfN
2apx/KTzzpzO9mabPHg2ibD/3CshGLw20bh/GlHQy3x3PlQtupqJzgwQu8qRH1TKZjbtGHkJ
Em3DFZiftGtMCVJ5k0CrgD1IL2Gdfg7OGQgOTrhBN3EYHcrDQO4mKCvdNVGFbhJMORZ1LMm1
2V1mTtpb/L9YWLc14slmes52ZiV/jzLKlMaqMJVxDDiKbdZVQp6ShTTmUYzaEj3Pk3roMWhU
B7sp3gLrHyx2zZ5g86JMVZamYTFg0JZFTcO5spqjvQbzasC7ez8Ba/bn4pXWM6o8pPsuUxen
v9DUOHu++/uISbA25tSFzpX63bHVFLfm4vz99/HHOf4ICHTF1xFYOPqyOfOrfHKT7Ksxt5c/
CDMmx7UNF0NdS2exYcmZPhPNfX+8u384e3uarrjePLC4TJXo/fgNXJZ5nF1WxZmYrNN9h+59
dvOjAYO/8eYI8ATxrxhkRgytezfKAkuTVlYCC8QW0JSfwql2ey3eOsxwNiWSaqvvN1LLbb6m
sKXNmNKUuzzel4F/JcoQmR2HAQA=

--XsQoSWH+UP9D9v3l--
