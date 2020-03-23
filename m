Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5601C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE4D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCWJWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:22:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:11948 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgCWJWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:22:36 -0400
IronPort-SDR: SkK1kczbAXyBKO9Qp0oyHCWPFnXMCpv/psr7Pdh+UARGCBpIIVcC9eRT6kk0jgdyUyHNGBby1I
 4OPiH5TMiASg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 02:22:35 -0700
IronPort-SDR: fP5vO9crsQBoTAt7BND19omSesrri7filQ9NCgkoFrhdTY6gpzP5UTg/ga/vmDa9Iipl3MqleW
 aSNIfzBmJuvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="gz'50?scan'50,208,50";a="246137107"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2020 02:22:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGJHz-000CwL-Uv; Mon, 23 Mar 2020 17:22:31 +0800
Date:   Mon, 23 Mar 2020 17:21:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:master 31/36] arch/x86/include/asm/vdso/processor.h:11:29:
 error: redefinition of 'rep_nop'
Message-ID: <202003231750.DPolvai3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   0747bb04956d8614b67a01df63d65d28879a955a
commit: 7c8cd4b433697f9d2b9b268a0ca181c534a49c7b [31/36] Merge branch 'timers/core'
config: um-i386_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        git checkout 7c8cd4b433697f9d2b9b268a0ca181c534a49c7b
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/vdso/processor.h:10:0,
                    from include/vdso/datapage.h:17,
                    from arch/x86/include/asm/vgtod.h:7,
                    from arch/x86/um/../kernel/sys_ia32.c:49:
>> arch/x86/include/asm/vdso/processor.h:11:29: error: redefinition of 'rep_nop'
    static __always_inline void rep_nop(void)
                                ^~~~~~~
   In file included from include/linux/rcupdate.h:30:0,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/../kernel/sys_ia32.c:25:
   arch/x86/um/asm/processor.h:24:20: note: previous definition of 'rep_nop' was here
    static inline void rep_nop(void)
                       ^~~~~~~
   In file included from include/vdso/processor.h:10:0,
                    from include/vdso/datapage.h:17,
                    from arch/x86/include/asm/vgtod.h:7,
                    from arch/x86/um/../kernel/sys_ia32.c:49:
>> arch/x86/include/asm/vdso/processor.h:16:43: error: macro "cpu_relax" passed 1 arguments, but takes just 0
    static __always_inline void cpu_relax(void)
                                              ^
>> arch/x86/include/asm/vdso/processor.h:17:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from arch/x86/include/asm/mshyperv.h:9:0,
                    from include/clocksource/hyperv_timer.h:18,
                    from arch/x86/include/asm/vdso/gettimeofday.h:21,
                    from include/vdso/datapage.h:126,
                    from arch/x86/include/asm/vgtod.h:7,
                    from arch/x86/um/../kernel/sys_ia32.c:49:
   arch/x86/include/asm/nospec-branch.h: In function 'mds_clear_cpu_buffers':
>> arch/x86/include/asm/nospec-branch.h:324:24: error: '__KERNEL_DS' undeclared (first use in this function); did you mean 'KERNEL_DS'?
     static const u16 ds = __KERNEL_DS;
                           ^~~~~~~~~~~
                           KERNEL_DS
   arch/x86/include/asm/nospec-branch.h:324:24: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/kernel.h:11:0,
                    from arch/x86/um/../kernel/sys_ia32.c:24:
   arch/x86/include/asm/vdso/gettimeofday.h: In function '__arch_get_hw_counter':
>> arch/x86/include/asm/vdso/gettimeofday.h:246:27: error: 'VDSO_CLOCKMODE_TSC' undeclared (first use in this function); did you mean 'VDSO_CLOCKMODE_MAX'?
     if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
                              ^
   include/linux/compiler.h:77:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^

vim +/rep_nop +11 arch/x86/include/asm/vdso/processor.h

abc22418db02b9 Vincenzo Frascino 2020-03-20   9  
abc22418db02b9 Vincenzo Frascino 2020-03-20  10  /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
abc22418db02b9 Vincenzo Frascino 2020-03-20 @11  static __always_inline void rep_nop(void)
abc22418db02b9 Vincenzo Frascino 2020-03-20  12  {
abc22418db02b9 Vincenzo Frascino 2020-03-20  13  	asm volatile("rep; nop" ::: "memory");
abc22418db02b9 Vincenzo Frascino 2020-03-20  14  }
abc22418db02b9 Vincenzo Frascino 2020-03-20  15  
abc22418db02b9 Vincenzo Frascino 2020-03-20 @16  static __always_inline void cpu_relax(void)
abc22418db02b9 Vincenzo Frascino 2020-03-20 @17  {
abc22418db02b9 Vincenzo Frascino 2020-03-20  18  	rep_nop();
abc22418db02b9 Vincenzo Frascino 2020-03-20  19  }
abc22418db02b9 Vincenzo Frascino 2020-03-20  20  

:::::: The code at line 11 was first introduced by commit
:::::: abc22418db02b986fc5623c035507b6357e191ed x86/vdso: Enable x86 to use common headers

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--TB36FDmn/VVEgNH/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEB2eF4AAy5jb25maWcAnDxrc9u2st/7KzjpzJ12zk2T2Enqnjv+AIGghCOSoAFQD3/h
KBKTaGpLvpLcNv/+LsCHAGrhZO7MOY25u3gtFvvCQj//9HNEnk/7x9Vpu149PHyLvtS7+rA6
1Zvo8/ah/p8oFlEudMRirn8D4nS7e/7nzfNj9OG3j7+9fX1Y/x5N68Oufojofvd5++UZ2m73
u59+/gn+9zMAH5+gm8O/oy/r9evfo1/i+tN2tYt+/+0DtP7wa/MHkFKRJ3xcUVpxVY0pvf3W
geCjmjGpuMhvf3/74e3bnjYl+bhHvXW6oCSvUp5Pz50AcEJURVRWjYUWKILn0IZdoOZE5lVG
liNWlTnPueYk5fcs9ghjrsgoZT9AzOVdNRfSzM1yaGz5/RAd69Pz05kRIymmLK9EXqmscFpD
lxXLZxWRY1hixvXtu6ubDpsKStKOIa9eYeCKlO7yRyVP40qRVDv0MUtImepqIpTOScZuX/2y
2+/qX3sCNSfOnNRSzXhBLwDmX6rTM7wQii+q7K5kJcOhF02oFEpVGcuEXFZEa0InZ2SpWMpH
8A1y1kBICWIabY/Rbn8yHO0oJ2TGgGV00lCYUUiadlsAWxIdnz8dvx1P9eN5C8YsZ5JTu2Nq
IuZ2oHq3ifafB02GLShwfMpmLNeqG0NvH+vDERtGczqFfWYwhD6vLRfV5L6iIstgK50VArCA
MUTMKbLOphWPUzbo6fw54eNJJZmCcTMQCXdRF3Pst0gylhUaurLnoznZRflGr45/RidoFa2g
h+NpdTpGq/V6/7w7bXdfBkuEBhWhVJS55vnYEUEVwwCCMthowGt3tUNcNbt2V93TaaKmShOt
UGyhuA9v1/sDS7BLlbSMFLZx+bICnDth+KzYAnYIk0LVELvNVde+nZI/VH/qp80fjh6Y9lsj
qDsBPp0wEsPGIuOnwhz4BISZJ6A33p+3l+d6ClogYUOa64YDav213jyDHo8+16vT86E+WnA7
aQTbn9+xFGWh3BnCYaZjZHajdNqSO8fffleKTlwVmhAuKx/T904TVY1IHs95rCeoNEjttkVJ
2mELHuMC1eJlnBFkIS02gUNzz+TFYmI245RdgEEYh9LfNxiVGMOMalYFgcPhqEStqtz5Nmo4
99gPSlMCCD8oPB6guqGYHnQDvKPTQoDgGGWihWRoj5bH1ubYtWCHYqlgy2IGOoYS7W/mEFfN
rvAtZSlZohgjVMBwazclvtkjIXTV/I1vNq1EAcoSzHiVCGnUL/yTkZwybPMH1Ar+8CyjZ96s
XSp5/O6jow+LxOVBUJsMmmVgsbnZXG80YN/Z2HXHZwLnI72wwL098LSC6yo4+oelCfBMOp2M
iIIVl95ApWaLwSfI2GD5DZhmxYJO3BEK4fal+DgnaeJoATtfF2ANrgtQE9A150/CHceHi6qU
nh0i8Ywr1rHLYQR0MiJScpe1U0OyzLwj0cEq+BfZrx5tOWVEVvMZ86xdkXTDo5Jodtd6Zgku
yTBPFse+TrN6uvXQi/rweX94XO3WdcT+qndg6ghocGqMHRh+V6X/YItubbOs4X5lzbsnRuDC
FESDP+uIkkqJ57aptBxhqgHIgPtyzDqX1G8EWKNkU65ACYFMiwzXQZMyScA3Lwh0BLwFbxj0
Fa4ApUg4RAFj1F/wXXXLrjJLXx+f6vX283Yd7Z9M6HM8ewiAdcQoc4w/OGVceNKpJWhy42sm
KRnDqS2LQkjHITQuJWjCSwT4PXTatL7A9Q4pRCEjCSoUGAmq0jmB97fvzhFVLo0ZUrfvmsVN
9sdT9HTYr+vjcX+ITt+eGi/J8wG61b2/+agWKFMNCkd8eAGhFQ3ismyBiEv28eaj52gUIJG8
zDjHO+rRL+Nxoeqw73HsNLCw6e8B+A0Op7JUAjetGUsScCREjmPnPKcTMP+BibToa1yTZCAl
gX7HTMRsvHj3ArZKA4JAl5IvgvyecUKvK9zCW2SAd8YOBVrBQce3b3HzsTsciCQZLDd6LDer
oRB0stYh/uCSpO/CONDVVQHqpHGUVOmcdIMG6fYBrf37+H4IFjMfkoErk5WZDacSkvF0efux
N2rk+qpKGKhbP4gGUlANdkkImGTxJXCyHNvAcwCmIPWklJcIUEC5ypgm1fXVJfZ+QsSC526k
813l4ihRs3CfC+4gNq4HA9HGSK9Wh/XXN8+Pb9Y2IXV8s72GBpv6c/PdJzGuqxRsVloVY21S
N2rQoUn9KNr6HUOkZGZ/TX6kmrUWGxCMXGreyZxBwO0bLghUAWMSVFiQFsOwkkO0HS+dDTBj
Ja5TAv8q4XpxGRlzm3ORd46fAjIMa7Q2ohISAkNQ7ufzkZECvEs8kQDBjeMMNkxqWKZur3vj
w6gx8F6AAftlfDMjEoa/rVFCLSpqPjvDGtGvq8NqDY5GFNd/bde1Y1mVhqXI6oIJSjkCnoM3
CuePOGw0MxmC9HIA0ReQBeiCbACDfyqI70QDfvV58++3/w3/effKJWhwT6fjK2eGCNQwTYHv
FN8+9oTIZ2WyYb7fbQTDJLUEkLp8RbjXMzavT3/vD39estVMA2I9J55sABXTE4hC3Kxfh9Hg
8GFwlXIEGhM2SGh1mBmjIa+sJ4mxiKvDZpQojfVcUIIFns5EZeFqJoxD515nXGoTPGSej+6l
co0C2p7qtdFjrzf1E/QLrvOle0glUZPBdlr1cn014roSSVI5W9HkMFVWZSJuk7lDtTQn4IKb
kL8gEvRTlwkedGEo23NbgbervZAxAG9z4VaPgFXTdrO6fGCnTURcgh61ps/Eh5INI10qimWl
J6Ao40q7SpWm0BMERnQ6JzJ2EMKoQz5WpQJ/K76+QBCqvRW20UbDQKOFBhwCvdYmM/v8OxWz
159Wx3oT/dkEPWCUPm8fmgTm2fd/gazXJGk55rk9kZTevvryr3+98pZvbjIaGmeFPrAXszO4
gkDRhFbwfwn8Q0+IQ20CIaVlSXGN+4My2s0OtGVm4nPXPNr4VWUmp/B2sPee+21BJglCTVqR
xJjL3tCUucEHGzdo3MM7n4UQ3vSjJO3vPwLBdUcZyAK1aCNfkqkXBzMh5hz8NKUgkDxn6Sqe
GeuDNy1zODUg0ctsJFKcREuedXRTk0hAc6gQJXophTb/NVL4shw8RIjfSaFpNpZcv5xou4eD
HMiztRRw/oXWl0G2Q0az2FzFNWoMtwmGbD7S4S6a3CkX9vTQ8KR7QgrHNkhlmC4Kcqnzi9Xh
tDVnJtLgwXohMcxec21lLp6ZdCF6AlQs1JnUyWYl3AP3J3g4YnOFJc5ZeMfCZHewsCYHG4PS
9e83HeR0ObLa/nyN0CJGyR2qRvzx+vjD3qBWqgA9ZA4t+Jzc9UZbvNX/Df4lHNp2DhLIQo1d
pN/6nIy37GL/1Ovn0+rTQ21vuSOb5Do5jBvxPMm0MWNeztO31earisus6G9Mjdlr718cfdn0
1Xj1F2DQE/Ts5ZkuTY/uhocma1eS1Y/7w7coW+1WX+pH1M1I4Ah4qSYDqGxoC2CIG9y73CIF
w1loy0GbC3rvZMKNcbUGFz0nU5UhAt6xxsQaJniFwxDL2/dv/+ij1pyBoEEYYqPFaebdMqQM
Do6JsdEREylybS6j8cS9fzvTw+8LIXAbcD8qcd11b82dwDNS5rq1SS6aLNw0pNhghTYcDl5T
jkENjUBXTTIip+ipC2/2mZe9Y9O6sOCgXIoEbOOUec5yA6liTrCrpjLnTiLffIE4eztlYcPW
Z9sVsGmLBMKqMqTjjXc+ZUtkPjz3Z8+L5v7DhAD4HhW9Eq5A3+vAiEBW5Lg0mcnwgr+EHBt1
wLISz36pJYSDQkw5w3nR9DHTeHbMYBNR4rM2SILfdlocOCBhJMQLcK4DTLZb6upZE/HRogP7
PZVxERYBSyHJ/DsUBgtMBA9W4DbbjA5/jl8yqj0NLUfcSbR1uqjD375aP3/arl/5vWfxh5AX
CPsTyKcW0DK0cabcx0RWl+d6QFNMljZoAR2RFSE9AsRNdIY7K8ULSBDvmAbmyc2FuMZxMnAP
rkF2UAQYHBSeXgVGGEkej7Ho3gZOVjAUcQWuBaGdzVKSVzdvr97doeiYUWiNzy+leCaZaJLi
e7e4+oB3RQrcny4mIjQ8Z4yZeX/AbxVstiJYtBDTgP8Om0GsD4qiBQTWMzXnmuIKZKZMLVPA
ZMGMTBozfKazIqD5m4oCfMiJCtuDZqYQRwQp0mtwaRQcgeolqpwOi4I6r6GJB2ziSIKb+x0a
mhKI8zAlZPXdohqValn5d9mju3RgpKNTfTx1GQenfTHVYzbwtlpf4KLlAOHafYe1JJMkDi0r
cOcTCLNIAuuTIQ2QVFOK+YNzLlkKEbTn5iVjI/benVLDig6xq+vNMTrto081rNP4whvjB0cZ
oZbACXlaiHG0TM5qApBFU4bx9jzinAMU13XJlAdSBGZH/gj4moQnOIIVkyoUWucJzrxCgf5P
cZ/XmuwEx6VzXeY5w2efEJ6KGZrtZ3qiwSfujnMnnE3yM4oP27+aqPKc5dyuW3Aket/y7As2
tQATluKXC3AudVa4txkdpMpM/YB3t53HJPXSjIVsuk+4zOYEXC5bw9rNOdkeHv9eHeroYb/a
1AcnCprbJJSb1GQLcNj7fkwB7JlZHXVTL3W5FIQSzw21p3I4rz4raZNFJi/ihX49X0Yl/Ffy
WWD0loDNZMCrbAg0uBRtNxBhZyAGuD03ZAQcVdoRF1KMMLPcFxZARNMUtHmVpAEZsTs0ej5G
m/7ioW/igt2QE+Q5eDEwzkOZOI3bSJEga2kTU1jazN4gjVLsnq4jKUcx1hLAxuPHbpc7Egob
3xf4DnCpEMU5K+BCbQxty2xuby6HpXJZaGHoXszBxXKEmax+2aPY3iYNwJLgXh04R5XRLEaP
vDjsYNTGAs4yFqnnp6f94eTKgwdvUh3b49qTnE7EyyxbmnQPOjYE1KlQJegJOMhWUHE9fTW8
pGwSRQxOQBYdnfl1/VpM9cc1XXxET/ygaVMFXv+zOkZ8dzwdnh9tOdXxKyiFTXQ6rHZHQxc9
bHd1tIGlbp/Mny5L/h+tbXPycKoPqygpxiT63Omhzf7vndFF0ePeZPGiXw71/z5vDzUMcEV/
7ZQ9353qhyjjNPqv6FA/2HchCDNmIJfg6OCpwhe6cNhJJwJt7u16U4xsXLcG4sylsxiANIl4
90xKwmPzeEDiW68uXMGurhkZyNExuIrRRI6NXzioiD1b77O6dCx6m1g8nxiRx4MA0JV293Qa
h2pckkB1K7sr7QuUsEetWeBYgyc1C5UBQSAcQs0WIYwxGgHLMw7EhTAHCJxDc6fN9T+WAShz
l0fwWc0sn+17koBrNQvprzzN/Jxn4x5t4SBuPz0bgVZ/b0/rrxFxbtWiTe839RL1o00cx8wU
cGhfWMD9iYUE14FQk/B2n8S46Izcu6bFRYFQ5JoTHCkpDi+lkHgTSmbcrXByUaBVeY43Y/em
BA1FjYUYe49YzqhJSeaMoyh+c/VhscBRfu2Tg8mInLE0gOMgMMFJWqxiGT6ZnOgwjmkpcpHh
K8zxRjfXf7xFERDBK1P+iiLN+TdehqcQs0EG4rKZhLOqiEK7lCYjIFEUBC6qdKuqXZxIiUxS
IvFVK0E5OPoLXNjBlxKFWuITmgVEeWFqeRfuyhtIRRa8YqBbcJ0D8XHr1AYSOMtBQNchisJV
OvBpHjANs6sePmbmMiYwTtHVYQTRWVGE29qM+LDKzKUIFJaatmTou3pYGyFojWXmbdnPuWgp
nVCXJQbbx0mBPJalUXAq8ayDRWfm8sr89fFCK5u6wtfH7aaOSjXqzLalqutNmzUwmC5/Qjar
J1MkdeFJzFO32st89ZowzjSbBnB64sobfAbf7/jNMlc9uaiRhPASeIZjKVdU4KiByhuipOKp
O1VbSIbdA7gNL5Slh2QxJ0HOSOI/yfVwjKThhorjCKVxuA7Q3y9jV6O5KGsQWW4NVeP42yRT
NN+aPNEvlzm1X00y6ljX0elrR+Xa+26IgCdkb3PC+RiIfbxc9yyrikEU2ozSl/hthpV8cDr9
C7s/bkylo7P8lI0JXQaBbYx5feXMoxor3FVsnx+EdI0No3F9kcYgwPaBWFsC1Lm5bNbcWTuZ
jNkUQLhSYJKTtKlkGYYhnXjPkTciHX+ytEV6bIeJjYtArtTeZCF5me5p6cXOuE3NSMCzUmn7
+qzJH13sLsRhWKxlwGic5ZA71Ne4GldFhue/J4G8eFGoixkW4LWvH/brP7F5ArJ69+HmpnkN
fRlZNwesNaam8jt4C+actNVmY2tfVg/NwMffXPf6cj7OdHhOtcRTo2aXQznaQswZ6OdZ4MWk
xYI1C9zoNHhTAp0GrjPBwc8IPq05MVcdAr9ZMUFfOnzI1CRoD6unr9v10duULjE3xPWW2isv
NklWmhLuGB2wmZWYUF6lXOuUVaA3OfEqeeFwKvPSO6Dx5qBcAveIhJoX3nwE3oqvJJo4KyOj
MnGKGM5CbPwQcJFwP6ZpZ+pxCjwzMejYmU+5ALVUhB6VlgGdYEqDW6WAFee1lcMZy8vOymTb
9WF/3H8+RZNvT/Xh9Sz68lwfT9jOfY/UkWbJliEtCGdqHLpYnsxN4RZ6WKk9VGr/fFijcS2K
d6N4no4E9maLQ2RSOu/WvBsGi4yK1Ze6qX5CsoTfI23e79eP+1Nt3ppgc0ewTaunx+MXtIGH
aFJSgka/KPtoPxI70P7bp1+j/mHD4AKFPD7svwBY7SnWPYZu2kGHJm8QaHaJbdLth/1qs94/
htqh+CYzuyjeJIe6Pq5XwNG7/YHfhTr5Hqml3f6WLUIdXOAs8u559QBTC84dxTvCLiBK4RfC
vDBV2/+E+sSwfULwh7bZ0f6ZcUkSyQKp6YXJYOExqP3FEzz1FtA+xTy7dCHkXbSGWWIK5QLn
2hZlc5Km4jxNEdcETLT3ixheis/cCxmCQOzcxCUQfme4H+P3PTClNFDrJ8mld0J2m8N+u3Gn
B56XFDxGx+3IHQMSuCI2VxOXvJ7MTR5+bWIExBtSw4qY7hncZatzI5uxxy/qAj+3wEWg+Czl
Wcgm2GCQNhdt+N1I86gbt6H+HXF7BwtKoNk/z1zPIAKMzSPkRCGl3d2alTEKxLsGhYNyBYjQ
Iboe4M6Y95V7y2wB5nWK+WEG0+dgjPd2YvbHEAjFXbKOSjFaBmvhLVEo6v/PKPbGNd9BYnMj
PrL1r+dVSMbN7wCoZmnOmW3B9sFpwGVsScyPxsC2J4HQ5jxAtTDXJijVfywBilqEUeNEBXdy
pGW4Yc7TF5omV+GW5hdECOZ7sIVxOnwudrDmJUUlCkywjMdp3+N7vx+RmVIFbX6naoB3Z8Jy
e0MbKqEGCnAeORopJyoXmidOWB8PAbwBVO3PgJy7JQ0C6fWuFNorrLOAvrDL6oaEoD91Yn8g
pKU3v3s2WG2DuJDsM95Uv8/wd+QN7io0X+91s8kdJMqe9Ecf1oDOXLBHHxcSk4gBd3+AbpTX
av3Vv3BOFFKS3nnCDXVDHr+WInsTz2KrEs8asdsuJf6vsqt7ThxH4u/3V1DzdFeVnQ35muRh
HoQRwYOxiWyHJC8UQ3wJNRNIAdnb3F9/6pZkW7Za5qp2K7v0z7LU+m53//rm6urUqvkPeRG1
fZufJIyodT4ctRpk6uF+t7pQJemfI5b9GWeNelXHD4xKId56L58lp2nmmIhmq3C/Vh0o9sXH
8xbjG1pqwtVqZDHTyB8mdiwG/tYinIMf0TN/msShnJuWxzsIg3EYDYXtYqflEDpdfyuy6VT/
azyYqj0ZHZj824fCtBbV6tA3Gi4CweUeabnH4R9asQ7llUWCdQ3WI1n7jNt8NYlg8S2nF042
9MhGtGzsFc2inBQPPLUZ0CLPU4FgU0KU3uUsHVNj3LOHAQPDA7mQTD2tn9Gyu/jhwiu9oqXC
99KZh5zrMb2nHss96hZJS1haeZQJjxhxsWd/H6UEFxs4UFK9G1KCZMjooUtVvh6RLP+nJB36
st5vr68vb/7o1zwEASBfw3F5uTh3c5NYoG9Hgb653ckt0PXl6TEgtyt7A3TU646o+PXVMXW6
cu/3DdAxFb9yM0E2QIQjvQ06RgVX7riPBuimG3RzfkRJN8d08M35EXq6uTiiTtffaD3J0weM
/YWboMgqpn92TLUlih4ELA0IeqB6XejnDYLWjEHQw8cgunVCDxyDoPvaIOipZRB0B5b66G5M
v7s1fbo5kyS8XhAuZEbsjk0D8ZQFsEdR30I1IuAQwNcBkdeRXLivrSVIJCwLu172KMIo6njd
LeOdEME58cFDI8IAuLTce1uJifPQbXqx1NfVqCwXk5CIqQFMno3csziPQ5iejj0xTBbzu7pn
t2XbUbbvYvWxWx8+XR9oJvyROHxp+8liOOUpGhwzERLmJ6+txQidOzoGj42ZGPKYD/FWjAwk
JQeg5f7QhLlfp7ibAAM+KJ4QBxVpWLWT1bzqonT6/Qt8MgEn3JPP5dvyBFxx39ebk/3y34Us
Z/18st4cihdQ7BeLxPF1uXsuNnZUbz0SfL1ZH9bL3+v/Gh720jYQZpoHStO2VEaZij1EMYdE
nE3osFw3fPAouDsExoMn2TiwtoqtQ97SjDYJq4kBQ5A/ibVDqJtaavBeOpRcfgNoDnejYOV6
b75hBbvP98O2t9ruit5213stfr/Xo1EUWDbvltUJUa2fz1q/QziT80fLoqh/lwuG3G7dXagh
zS52FlBy20N0SOp4EXh3+N6Cf4jDvW5vno054W+mIfDylmlm9vHz93r1x6/is7dCfb/A5+3P
+gqkHxdEqKgWD92LppbyoEsuqFBUo4Jc3POzy8v+TasN7OPwWmwg+wI4BfMNNgTYPf6zPrz2
2H6/Xa1RNFwelo6WBYHbJUaLb/3iYMzkP2ensyR67J+fuk8Appf4bZj2z9xbiMak/C50B12W
uhozOV/vW3oY4Cfkt+2zbWsz9Rx4R0cwcjtvGDFhwy7FlPFAV9lbeCTmPnHir9qso2UP/rrJ
DXYuKP4L3W3gp5Hl3mEA3hftLhkv9690j1Dus2ZZ6pA/dDT8vvG8drl/KfaH1jIaiOD8LHAs
TSjw1uIBlk8fYhCxCT/z9qGCePtJViTrnw6pIFE9V7vqcswsnQ7dJ/1S7H86lPOTR/DXBxPT
YcdCAAjCIlAhzi7d96MKcX7mLSMdM/ddsJJ3vEMiLvveISIR7uuVkU/94kyeSgaEE5fZ3G5F
/8ZbifmsUUs1I9fvrw2P03Kt9g5Hhvk/vIg4H4T+MkTgHWmDKJmPqOuImRZsyuU1zL93sjTz
jlkAePt46FfGCP96V9kxeyII6Ewvsyhl/rFqtlr/9kllpDByAbzT/uHo7ZWMe5WdzZOuPtOQ
RYO8+x8m3dOu2O/VzaPdD3Swg9lMnwhqAiW+vvDOkujJ23YpHnuXtac0aweoiuXmefvWiz/e
fhY7zZ94cDeQxWm4CGaCcLAzahCDW/QC9IF+hFnGhY/zsXaGX8jbwqJr8yiB6SQIZ+PumwGC
O9pS4hhnbdXpS9Dv9c/dUl66dtuPw3rjPE1E4eCYbRRgah51opwn7jbObKkQZfDE6+TIDtBx
VXOfphuno3l5USx2B3Afk2f8PQan7NcvG6TA7q1ei9WvBg/pMXDERx6lz9o0ZVoyCDOgVxBp
7dOq8elCiqcsrH8lMaJRGA+BSAEc2kM7h00iGqmqaooL5O1FjnOnmoL+lX2gCxbeE1SwCLN8
QZR13rggyx/kWhqNmrdKGxCFAR88XjseVRJqsUEIE3N6rQPEgDD5SSnx2SKgd1yCG18OSnU2
ph5zn+FUhAKhoxL18ARUSk7RcMpwVaD8moZ39XjLCL6HW2xi4g4pcxxPplJtDe8wMB3Gt0Rd
9bRpzQbbpGamGf76vltvDr8wJOH5rdi/uAybOmUWhCk4FaDlQAzvNrGoyGVIt6VY6M23xm8k
4i4Hx5CLylkgTeFzSquEi6oWmNpIV2XYzJFktIeUs3IOcyEw2V8tBAeoQ+S/cj0YJCmvm4FJ
HZXHgPXv4g/Mq4bL0h6hK50N0qVR9bamU5oW8hgtUFOImEH/tqqWIyErjf5H3/unZxf2sJgh
YXaTLLca53LTwoKZk7qyTOSE9KIN9yZV35QjHyb4WUxZg0LL1KMBUTkikzh6bDYC02nZnlvq
LYoGeQ5mU82T6RzkR6vd8rLXk2BY/Px4eQGTZ41gok6rVGYXqNhOsVe+n/7dd6FUTJajMYTD
wSBlLjcc/H3BovA2lmemzMUy422BPZpVPoTmGEcO1k/LjF4WZu+bcsLxh4zHKeXBpwoEIE0Y
isUk85gK7AWxHAtpElOhGuotyeAHp2xXenhGzBWojN9FtEKmfAr2+HY/GYmvePyckMM65EQp
DmGF4vKEQLumqvLu3QSy2EUqBSiY+msWcMVKP2EwRPRZpJKqn/HteK6zvwBUHdxq1bjBJaPJ
sCS+l2zf9ye9aLv69fGuJtd4uXlpHK5iOQfkhE/c3qOWHHyic17xqCshbCtJntUJy9JkhKS8
mA8woymRlHAxzmOVFdMJmt8RsWWlU7evreqrX5nzsT5TrH5HbVobNfzs4L9tpZGk+wY0M+G8
SY6pTrxgQK4WgX/u39cbjBE86b19HIq/C/kfxWH19evXf1VVRTdfLPsWDxFlJFJtK0/uS3de
9ykLyoB2eYZ2RaTvm0+O+KsGpLuQ+VyB5ORP5jNGUJroWs1TTuyNCoBNo1eyCgTKw8ulPoW5
C8Xi5NDNgI+JPFhWLfAe6f6P7i4HZpkrrd7DuCFDCp88BgMMUATT2eT04qjWXv/aah2daouI
TiDxvDwse7BRrVrZ1LReQ0JBepPpkBOU/0qIDuEhJyiRcHeJF0Ng9pI3OJE7XNattYJoUvOt
gZDqBeYZmxVU2VmC3L3rQk5dSLpJDxhAdI4qBAlGkHpg4t671OWvXkvNSy9McklVpzThOJ/Z
B2qcBPIUgayH7mmichZkiYuOAdpgL1XmENka2DrVCVynVDZq59ukOMVcM/C4e1dRC7oHMJ4D
p7wHoE/wJQMzIqlEFyBbpDGbQU5sl5VCzk95kFbZGnnLn8H8zmI5yjFvrHqAWDZLOHD9+YBl
JozEM5BQohLjEmTu7c7Buxk9chUbaHvGfLy5Nl/ORPRYZW8tx6+Frl9/M8Ugizt8sP2r2C1f
CsuJJ48p7yS9iMDdEVlFfnA6PYDqeCdGI8q8a5OgnvXO5B6SPZPca6qJmfW1D/CO8gSkGp+q
JQFmjI68rroK6C4xe2jaSlBWhwDjIkSR0wjy+UGVmxNyQ9CL0wA+E3nkkCMhTaJkKpdlEoXX
R3miXPgL05kISDlkTQyDqwu/+QcbPuYPwFnq0YwyzihHKWK+a1waEJZuBEwkIiOiGxGAI95t
HUS5Mhx55XIsRwSrHyDyvBk6Wpc+MCEIwgCUQ4jRSB7JaIQAEz7m2fMonLLyozQcUvGiMNIn
BHkLCO89CS5U41OkuPV10WDmU38kp8I4wT3A7SGCRmTI2+VfN7E0Q9rrGVAYC+RpT8sg1hyQ
6OlHejCqQTlNPCMCMt3LXdE7O9ASTyyvphASIGXk8di7uLfc3ZQB9H8a9Wg5DoYAAA==

--TB36FDmn/VVEgNH/--
