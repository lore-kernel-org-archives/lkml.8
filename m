Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83E8206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0AOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 20:14:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:61742 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgG0AOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 20:14:40 -0400
IronPort-SDR: /fTjEeBodAUaLWfa23PXQWV6dkZXt9ApOHZ7wyCDOzqlaFtxvaIJNXE4os9G+oVOe0TcDK1ObE
 4fG+e5o3+9DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150916918"
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="gz'50?scan'50,208,50";a="150916918"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 17:14:38 -0700
IronPort-SDR: 7VBi+6b0U0yz+K8ZtC9BF69PhHw2IzSbu8FY6lkqnHZooxmXJL3gIzHwJqPWEmggezsYEmUSlY
 KWXwOxjhQJNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="gz'50?scan'50,208,50";a="303257373"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2020 17:14:36 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzqmp-0001ii-L3; Mon, 27 Jul 2020 00:14:35 +0000
Date:   Mon, 27 Jul 2020 08:13:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:WIP.core/entry 1/1] arch/arm64/kernel/ptrace.c:1863:6: error:
 too few arguments to function 'secure_computing'
Message-ID: <202007270837.7fzDKYXF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/entry
head:   85546baab915492f05f29b91c4003bf15891e89b
commit: 85546baab915492f05f29b91c4003bf15891e89b [1/1] entry: Fix !CONFIG_SECCOMP stub
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 85546baab915492f05f29b91c4003bf15891e89b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/ptrace.c:1852:5: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
    1852 | int syscall_trace_enter(struct pt_regs *regs)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/ptrace.c: In function 'syscall_trace_enter':
>> arch/arm64/kernel/ptrace.c:1863:6: error: too few arguments to function 'secure_computing'
    1863 |  if (secure_computing() == -1)
         |      ^~~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:21,
                    from include/linux/audit.h:12,
                    from arch/arm64/kernel/ptrace.c:11:
   include/linux/seccomp.h:64:19: note: declared here
      64 | static inline int secure_computing(const struct seccomp_data *sd) { return 0; }
         |                   ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/ptrace.c: At top level:
   arch/arm64/kernel/ptrace.c:1875:6: warning: no previous prototype for 'syscall_trace_exit' [-Wmissing-prototypes]
    1875 | void syscall_trace_exit(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~

vim +/secure_computing +1863 arch/arm64/kernel/ptrace.c

3157858feff891 AKASHI Takahiro   2014-04-30  1851  
11527b3e0b5775 Will Deacon       2018-07-12  1852  int syscall_trace_enter(struct pt_regs *regs)
3157858feff891 AKASHI Takahiro   2014-04-30  1853  {
1cf6022bd91610 Keno Fischer      2020-05-15  1854  	unsigned long flags = READ_ONCE(current_thread_info()->flags);
1cf6022bd91610 Keno Fischer      2020-05-15  1855  
1cf6022bd91610 Keno Fischer      2020-05-15  1856  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
3157858feff891 AKASHI Takahiro   2014-04-30  1857  		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
1cf6022bd91610 Keno Fischer      2020-05-15  1858  		if (!in_syscall(regs) || (flags & _TIF_SYSCALL_EMU))
d83ee6e3e75db6 Will Deacon       2020-07-10  1859  			return NO_SYSCALL;
f086f67485c5c1 Sudeep Holla      2019-05-23  1860  	}
478fcb2cdb2351 Will Deacon       2012-03-05  1861  
a5cd110cb8369d Kees Cook         2016-06-02  1862  	/* Do the secure computing after ptrace; failures should be fast. */
fefad9ef58ffc2 Christian Brauner 2019-09-24 @1863  	if (secure_computing() == -1)
d83ee6e3e75db6 Will Deacon       2020-07-10  1864  		return NO_SYSCALL;
a5cd110cb8369d Kees Cook         2016-06-02  1865  
055b1212d141f1 AKASHI Takahiro   2014-04-30  1866  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
055b1212d141f1 AKASHI Takahiro   2014-04-30  1867  		trace_sys_enter(regs, regs->syscallno);
055b1212d141f1 AKASHI Takahiro   2014-04-30  1868  
4913c59890b077 Eric Paris        2014-09-23  1869  	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
4913c59890b077 Eric Paris        2014-09-23  1870  			    regs->regs[2], regs->regs[3]);
5701ede884c222 AKASHI Takahiro   2014-07-04  1871  
478fcb2cdb2351 Will Deacon       2012-03-05  1872  	return regs->syscallno;
478fcb2cdb2351 Will Deacon       2012-03-05  1873  }
3157858feff891 AKASHI Takahiro   2014-04-30  1874  

:::::: The code at line 1863 was first introduced by commit
:::::: fefad9ef58ffc228f7b78b667c2aea8267503350 seccomp: simplify secure_computing()

:::::: TO: Christian Brauner <christian.brauner@ubuntu.com>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICMgXHl8AAy5jb25maWcAnDxdc+M2ku/7K1hJ1dXuQ2ZlyfZ46soPEAmKWPFrAFCW54Wl
2JoZV2xpTpKTzL+/bpAUQbJB+y6p7Froxlejv9Hgr//41WOvp/3L5vT0sHl+/ul92+62h81p
++h9fXre/rcXZF6aaY8HQn8A5Php9/r3vzeHl+tL7+rDzYfJb4eHa2+5Pey2z56/3319+vYK
3Z/2u3/8+g8/S0OxKH2/XHGpRJaWmq/17S+bzeHh+/Xlb8842G/fHh68fy58/1/epw+zD5Nf
rG5ClQC4/dk0Ldqhbj9NZpNJA4iDc/t0djkx/5zHiVm6OIMn1vARUyVTSbnIdNZOYgFEGouU
t6B5IeJAi4SXms1jXqpM6haqI8lZAJ3CDP4HUNQSgECHX72Foeqzd9yeXn+0lBGp0CVPVyWT
sAeRCH07mwJ6s5IsyQVMo7nS3tPR2+1POMJ505nP4mZfv/zS9rMBJSt0RnQ2WykVizV2rRsD
HrIi1mZdRHOUKZ2yhN/+8s/dfrf9lzWlulcrkfv2RGfYHdN+VH4ueMFJuC8zpcqEJ5m8L5nW
zI9IvELxWMyJvURsxYGEMAkrgE9hLbD/uKG9kJ+94+vvx5/H0/alpf2Cp1wK4DH5ucxlNreO
2QapKLtzQ8qYr3hMw3kYcl8LXFoYlknFDecVywBwVKnuSskVT4MWhn2DLGEipdrKSHCJe70f
zpoogZhOwGDYiKUB8Fc9cqcrooeZ9HlQ87VIFy1U5UwqXvf41dvuHr391x6lKZokwEainlYO
12lEa9WeXw/sA2MvgeCpVi3QnDsKrBb+spzLjAU+U3q0dwfNMIl+etkejhSfRF/KHPpngfDN
XuvmNEOIgH2QvFqBwyKO3WASEolFhCxhaCFVF6em82CxzVpzyXmSaxjeaK3zoE37KouLVDN5
T05dY9kwQxs/L/6tN8c/vBPM621gDcfT5nT0Ng8P+9fd6Wn3raWWOQToUDLfz2CuimvOU6yE
1D0wng+5HOQXwxAtLomn/MgwKZcJi3ETShWSPpVcCZKg79ihpa5g+UJlMdOgXgfEkn7hqSEX
aaBtCTCbGPCz5GtgLkq5qwrZ7t5twt5Kg5ygmUiytAtJOdBE8YU/j4Xh8vNeuwu0yL2s/iDW
0khQRWkjR43cqIfv28fX5+3B+7rdnF4P26NprucioB2xVUWegwlVZVokrJwzsNR+R8/Utlik
+mJ605P5c+cztD2ihcyKXNHWJuL+Ms+gE4qZzhysUu0VjacZi8SRPGa0KM3jJVjNlTGkMqBR
sgxEwUVy2HiWA/eLLxzVMKog+L8E6NMR7D6agj8oZgKNqmNgNp/n2vhhkvmWwau40B7YKGow
uJImzoJrNGhlrapppHsVqlGMsDIEtKhmSqxJJXjWVnCES5q0Ba0p5gxsllMnhwV4pySE55lr
j2KRsjikT9gs3gEzdsgBUxH4QiSEiYxWlVlZSJd+ZMFKwL7rg6CJCRPOmZTCcd5L7Hif0H3n
eUidsi2qdwykrfEiEf8/osNtyGgG2KVI38K3q4QJU7DoILwdhar4Z6I/9OJBwAPb7wGvDEWq
PHsTLV/5F5PLgVqvI5x8e/i6P7xsdg9bj/+53YGNYKDqfLQSYJIrc1mP0w5P2px3jmjZzqQa
rjTW0CUWGDMwILKkRUPFjPKgVVzMbSKoOJs7+8M5yAVvztONFoLRQutTShDzjOboLiK6xWBr
XGJRhCF4qzmDyYHZIMgB7e0YtZgbOw1uqhaMll1w+kMRD6SmPp5uxNayYnJ92fLR9eVcWJ5m
khS2jQLUarEqEqG+vZh2QfBD16DLDqsnCctLmQYlDA5MDw77xc0YAlvfTh0jNNxwHujiHXgw
3sV1gweeqsjQzkJ7bgUAEKUtjRVp7LAVOsQxX6ArhkYWZHXF4oLfTv5+3G4eJ9Y/Vhy7DHg+
HKgaH/zAMGYLNYQ3fkl0x8Frplx+VSREK4MwUjKNLAwG3Ob7L+A4l0HCSIZpgLOpS0nx1KQF
6lA2ynQeF4ue2zLAkfDXyjLGKrHovOQy5XGZZAEHn8728kIwj5zJ+B5+42gtJF9U2QkTm6rb
Ge01FSbo7QdS0OiXS1SsVa6mdvPy580J1RTs+Hn7UKd3WgtjQm8fPQtaKVUICxE7DGy9snQt
RrrHuUhpX8HA534yvZldjSKUAvc3gsIlKIQRuNAYKY8gSD9Rmlad1emv79NshEjLmRsGvApa
32f5CBXixQWt+CsjKvoBUEcb8ECAVIz0T7jKRnafrPi8GAGvR0j/2XdYCAOVnMWjK5Mg24qN
EBbOfelHgnbkK/7rynUPyJnWDle1QgBlpcX6YjKCcp9+LkCj0TbLoGi+kLTyqUbIHcFE1Tkq
0mB09AphZJtFKvLI5QUajBXEChhiuzHWqGfd4C8jKuALUCjpHVFtjwkNZDtmYRt9mmYwsd72
cNicNt5f+8MfmwP4U49H78+njXf6DiH+MzhXu83p6c/t0ft62LxsEaur09BGcwmnWiTlzfR6
dvHJsfAu4sf3Il5Ort+FePHp8qPryDqIs+nko0v/dRAvZ5fvWuPFZHr58eLmPZgX11dX0/es
8gLIM7v++B7Mq9nk09SlDzuY05vrm8m7xry8nk2n7yHSxdXl1EUln60EoDSo0+nMQfc+4gxG
fRfix8ur6/cgziYXF6NT6/W0HdWxnbCAcEwVZ7zJBThnF47spAKXGT2OM52uL64nk5sJffao
1cuQxctMWlw1oQ/VgUwv2iB/DkIQo0m78sk1TQ1qaA5xHr1LlfngyoD706pszCsKRyT3/9M1
3WDgcmlChU4kWkEurmvQCNNeXxI4HYwVq5z72afhDA3s8uat7rezT/3wpuk6DHyqHpc33czp
HAPyFByNlJgMEWKBhrbG6cSkJiOX0D5EBVQJlUpNJQ6sbqdX1xYnV845QugMfdGNAs7dYo4Z
RxMM2KuLviCvUj2+lNOrSQ91NqH9hGoUehhY/4R25QNwuxaGAUxY3M+TmrsaiBDq0MMJrgP6
PpzH3NdNvIKBSNzDgOhMU8O313J5mGIUKKwUjLpX7QaiYsF1PA/70YjJGyGwzBM43YjJ/uox
LeQzOPwSb2pN/pOOt1QOjGWGyXWdwG6Zh/sYANNZAiYZ3lqMAt91T7Hka+5D2ObwIn3JVFQG
hWMda04JjLmhw4jd8GMmwbvDGL9NrKUY4ddBJAT4PHbwnUm8QPjCUhMEQiTgu5IrNS6Pp+AM
ItaYZlJqTnusMguYZiYbe84MVkfl8nDNcHel1nM5Acq74hBE02yxwOx9EMiSzemQp0p5DBJ9
MMCfNx8uPCxReDqBp/mKWaDO5UZnquiuZGEwd8UulSocW+sq4i6rMrYQa7HTdy+2YHT+uF6n
M+1swMCfEL7qsb34Ke28v7FOay+zd+8l1xKvZyLKjFS3RmduzkDwmQ8xoqXbahxM4COgkKlh
F4hsLP2hDA70HbT5oShTvsAkkmSYDdPcvmR7YzPWhi/fvWGWFAT9OxM6B7MmvHr3hHMt/k/E
xQ5D74JP8pGYlUoNd7bkXO5ANaxcQafhFsWLICvThFYGkpt0MqofGm6WibdseIfkogqYO5MX
RaIYzYhWTvKFzRn9eNWQfb6H0fY/MKo9WnVTSWDKj+zSHh7SN9idEaqU3f6v7cF72ew237Yv
2509fmv4CpWDo0XbtoTYZu13mF54RadEZfHbMN01a1NJUGMkZ4wmYkeYeHze2uszV+2DG8L2
0r7qcO4eHrb/87rdPfz0jg+b56ouoTNWKLsXRJ2xiN42eLBuM3j4dHj5a3PYesEB/PtDX4pK
FfDSZMFDiCLo6EvI5A4cG/SwwFiTOIssW4AP06DSbjrwuC/K8G7ggMEqEt8uo+u2l4FQfrbi
8v5cDLP9dth4X5utPZqt2ff6DoQGPCBKuxP0lgrwBL/Q1RPNrYsl89vfHrc/YGAHC/8HHKYy
ZnNOXT6ajfIwFL7Ai7MihZkXKXoGvt/R9AZx2c+IV62g2UhAWKQm5Y0BJYi6SP/Dze8eGqgc
yiU2dxtRli17wCBh5mZILIqssKY812DAdlEk6qosovQMgXhhDW6tLnLCXwanUYvwHsLcQvqU
Q73kPK8qFwggjFoHAw5gIKQJGOzrImvfVZGk0rIApLtIaF5XqHRQVYKhRl3D2Kc8qFRVgkau
tG19mCXL+4TG+2DXoWHFpbOjubvFWah2vKyuZ0Zvndpky5TjUFNBgiWCnTvEEtyKCOaobnHw
cpQEY5kPhVIfRsV6pWIhB0uSr/1o0V9MLQz1WWD82MOo+1UFpQ5YkBWOqK8OqzDk0Xa1n4WB
VIw56wtB14oOnbauke1Xu3XBLrWAQoYpHhTEZafoyIAdlWo9LKJGzSHsKcbZvA5nCVJXp4ah
7qojOSAFBaYcgOsg5AoNxxCCZ0CNk0IN3bkz7g3QhfUumzu1GzrLg+wurXrE7D4r+pLrZ/l9
I+Q6tmbyY7w+nQOxwYQFnURXffs8m8L8hpyuM6tuIHBuc8adysJzq8ttqTgHVKRuAmJ5t7Zv
tJ2gfvfqTLo47frqqm1ZRmQqBA5wNm0czlq5VbYPjPBvv2+O20fvj8pJ/HHYf3167tRXnpeC
2HUJg6mGsJ2wsZE6K8J6esyCibRzHlbzaG3EG1a6mcqUXakEF2mlJmrGJv2dOWZoXOdYFeWX
Kscae3lfJ3PewCjn0QjSG2O8b4Bu/bQTRbFVX1nbaEX6xmIqhPHl1DjjC2qR6jpIGtdIsntN
Z7BzRS2Gcz0dFDeBDNoYgSyE8eW8RaAe0iiB7iT4MCMUauHONVkoziV1cdxEqvDGqGRjvLGk
t+jUxxoQalRY35JTt4iOSue4YL4tk29I21uC9k4Zc4vXqGSNC9Xb8jQmSm9I0VsC9E7ZGRGb
cYl5Q1jeISejIvKWdLwpGO+Vie7lDdPgs/klRPaW04elyBUHQagCDpftPss7xRMX0EzqgFUV
HmCLzVOswKAhvuWkuSH9zvKO7jpoP3ssKa4IIrqY5Tl603W6FS+gyCi0rikGekIHsw/jJvG/
tw+vp83vz1vzQtEz1bOnTk5gLtIwwcuO0OVDtBjn3O0gekIgRhEEDRZpgSAsmu+UD9bDKl+K
nL4xqjESoeh7TKy8G94B1X6Xa+tm78n2ZX/4aSWohglF+iqvzUTV93gJSwtGpVPaq8IKxXKe
G0jP5a2nys0bN03gY0Zbwh8UaFVlxNp7xTbC6+O4AoaQKV0uBlkQTHCYavL+TWC3cpMkgblG
NFeI1a3yZS+O8fuJLeu2cIHaEcXedUeYiIUcZMaa7tG9qq609LnwuL1cVFS6tgnbDBkTUV1x
3F5OPl3TuqjefshEXHRL67sQcu1UkEvzOET8qbm0pcGu8ts8y+hK7i/zgs5hfzFRR7fis4lx
6nSZKaEtBYhdFXaf+wLtuJTd9Ih5zzMWX+amqHjVGwr0BGYSUNPQ8Q5waDnnqR8lTI7Grzi+
yrkvWCfgc8u+VdDAqZVXmq59kmFUSbD98+nBTmmfl5GULJmznpDnfufaB37S7O/7rFu+2KZ8
nx7q2bxsmOItqmcPEY9zR2UikFwneUgTF8ieBgyzD/SyZDX8OQ9vXkYPlnnOaT/vN491NrzR
m3dgdtmg8rKfDK87WvcDwJp35pkYrfXPm8PqjkCKlXP3BoGvpCOcrhDwFXk9TFnVnI+Ihcl8
FTpzvIxG8KqI4QebC9CIghOp6ir1leVZnC3uO/kJ+sirq7DXo/do+K9r0qvC6nIh1BwGpius
m9pU4lldq8giASdM5zXsuS3hTB3VrommXisF2rppyUJbMrIQC2y14zk/QNEC604yFxorDUWC
BjfW0NZxSbPQPC+XK6ycMtbZXkzljTkeAzOJNmEgBylYXE+9/vixP5zsK6FOe+WQPB0fqKME
Rk/ucZnkvKAF4wwf8Ja4bOE7WFpJRtcqrPFJD/jOQchpDytf5SwVDu9rSu4ZvAWZJd7R2nWz
WgMpP8389TXJUr2u9fXa35ujJ3bH0+H1xbz4On4HBfHonQ6b3RHxvOen3dZ7BAI+/cA/u3dv
/+fe1e0/liFuvDBfMOvmbv/XDvWS97LHd7reP/EO9OmwhQmm/r+aq1mxO22fPYhSvP/yDttn
83UQghirLHeK1tgQFjn9KCO7d3ipenjsK1G3WGtpuAOA6N/aSofq0DVjWI+Ug5jhQ9vGFIrd
j9fTcJ7zikWaF0OGiTaHR0Nf8e/Mwy7dW3f8nADtB7CE9znwvAFq0Ja8xDKrOYE5Ng9w9JQo
ak0LP66QxcY0DQ602XienD/kQJeJ3Y29+0MnyVFtpH34L3dKd3zv4rHhVtuO1VLARy3ACOLT
66HFrs576pPHPPVptrbQLeyZo0g1pz0jlTvKUiLHc528+7a9qvfQuffwvH/4w1p/pb12JmKE
8AG/noIfNwBX8C6TS4wozHULeEgJhuTeaQ/jbauq5cfHJzTLm+dq1OMHWwkNJ7MWJ1JfS9pT
X+Qi633D5Qy7o4ux8+wOHBa2omqbKxhauE4wZDWbN/7MVb5p4blfrdhYmJNwRXcDtKopC0MS
Hw1mAvjmOwAYizv3h+FZfD/cYNVeeXf0kgJWodJyhv6gGzwHf4NDyBeo6ccbumq0g0KfXoMy
/zz9uF7TT3/8iMkF7Cdh65tPjrcB0V3ioHv94Q+apfDLQ0FGBvLgR3YKmNp2AnsOQSmJPu9F
q5Xn8/p8evr6ujPPlBqt/DgsEErCoMSUSwzeHV+7HsC1WFHsB7RmQZwEFRodOiM4EteX04sy
Txy+T6R9MIFK+PQB4BBLnuQxHWmbBejr2Sf6FQ6CVXLleFXC5uurycREQe7ebslDsBYQmc5m
V+tSK5+NUEl/TtY3tK82emyWKeGLInY+PTePKEuf+01WZQSLwKhC4sPmx/enhyNliQKZDPDx
AYpt3a13KWdL2HYvJcThVZZ6ztovuYT4MsX7/fXrVzCgwdBXCOck0chuVSS3efjj+enb9xO4
fMC4I04UQPErbQpfMqDL79Ak/jLGZ94jqE0c98bM5zi0T2dLDWRFSkV3BaiNLPLF4JmKBW/f
qbcpDGgu4nwQelrgc44n8oNe18GBY5vx9Fulcm7Pv/884rf8vHjzE12hodpJwU/HGdc+FyuS
1s1ySeqOTNIdYcGCBaf5X9/njvAMO8oMH2zcCe34EFzieAQEBlXhB6hoe8vxa22B47GCqQQT
JpdxTxwQD5hPnavUfsWOtJOLKnkQw1YptoTNi5CsycUvmzhfiVT9SszewDliGd8YWsRZ/ytI
9SH25rcoUawDoXJXWqBwRC6mXKpKLtG0QASRwRGl9HurVZDTtmuFXx0c9KszDA+H/XH/9eRF
P39sD7+tvG+v2+Opo2LOAeQ4qkV/zRau9Pwii4NQKAdXgnXBTxmWDs72I5kl/Bxhuj7EE8cs
zdZnNFfO1o+tq0v4gbFanGXLol+QCDDMcWJi3upgPhlWD2Il5pfl50wKOjPT9hlxli2kUKwx
65Q4OCa6a24ZB+fqm8hC7V8PHb+p0R34WaUqs9Zp6aUqTbLaZCARett9l2BBSr7SSkvuyCeF
Kj6/GGWTyc3VDf3ClHwZOzH/0hqn+yT76ubTlEYEf01m+OUCCKz09SVthUmKWWMwEc8z2vsW
GdaUulwRuX3Zn7Y/DvsHypJgGlnz4Tc1mk/NDTtXg/54OX4jx8sT1agKesROz565/t/KrqW5
bRsI/xVPTs2Mm8ZOps0lB5qkJI4pkuZDsnvRKBLjaBJLGtnuJP313V2AJB67tHtommiXIAAC
+8Luh2Vi248qTgR9+60isLuzfH8Wftsd3549HtvN7msfgR5QAx5+HO7h5+oQWt3rDCqGrJ6D
Btut+JhPVQbS6bDebg4P3nP9oEIeUKQzc7jnVZD2tvhjcmpbLGRoz24OJ9jSwktumiQMwYyZ
euAqXWD3hbaosd27+a00fI9GxJvn9Q/ouz94/RRLt+fGLk+ih28xyfGnNFYdG16EDTtS7uE+
eviqZWS43lhOu/DrTTp74rYWvRk6aeW3qiBKi6XvE2B8fQO99IOjQEFxYkvKaRJ6P1BdaVZ+
vnB/X3zweRcfVokNpBaAW5twR68EykVJ+Opg1IzSet02Rl9gyr0Uj1SBF/hHDdZjykT2itmd
Bcw5KHV9XIUM7OzO7kYUHqIKXedZgIbr5Wgb4JbGWRivwHPEM/IX+aLXNFYF6UJYFMCFyisB
f3d+47oRFtscNHUKf4J/MvrS4jZYXX7K5hiXFA5XTC6cEXaj2Z/CeBqDUaFQAzUP+QGUgW9d
B/vt6bDbWsVYWVTmScT2p2M37OeAV5aZG7VW4f4lHr5sdvt7zrutat6ywLKwdFXP2C4xTRo2
CZ7h8MYKHy+uYwHkNBGMgipN5mLkH8vZ4O9ZHPKLWOMT8n6HnVqgj9ZBsajFYJh5kSrrX+al
Ua41eAWIJoDVtxOszy0loNL4Fq0a4KFMn1UuYMJSEj1ySIY/tADbrbwrxOQe4ADfJxEOVKIR
Xy1RtJWItjoJRp6+afJaQIxq6nxSfVwJaRGKLFEnmOYm0PSxsUNWS369+eaEjSom06ezWhW3
Es+P7fP2QHltw1IYJAPC0gndIRpotDQqBSRpQqLlrfYOeIJRU0OpRTINsho1hCrbMRY6/o+Z
xE7O+WMy7fpK+fnQuzoW3MFMwGttMnA1In5Wre2kbOB283zaPf3iwg3X8Z1wwh6HDa7nVTSP
K9KvVPwyysvOI3mhHbInrXKqEeoRPM0Z9dj4xWkVMPI9qgP8YtgMnq34uUPdxtQZcsNozWL/
tJp/foOuFZ6Tn/9aP6zP8bT8uNufP66/ttDObnu+2z+19zi951+OX99YqGTf1qdtu0chPsy8
may52++edusfu3+dGzPoXghVYugWtxEJ6xdx+vruC0KpY8YCQZHXziFzu+TUrTMj6k1kd5UZ
GwUlZ+5Ji3T35bSGd54Oz0+7vS03isCTxp3FldSYsgUyn6uv4qh97WxdZiEsvQnmbODS4FnS
OOuoxlYvI8nmKbEAMGvmV07sqzdQUGkEzH0GRZig+x246akoe43Sy+synnz286Mpt5Vwuos0
YfO8q7s52D2gPPpCM2Nl6DLdQvApwhKEapjUgoovwwsBoAyeqy/eRwl/6onkpG5WXAIU0D5c
WpOOP2DW8kRImdIMaRLGV3efmEcVRcBcUyxBuQQ7YoTjKhHn4E+xZZHAn4+lyRW9TIgcliEL
zYWXnQw1h0HdLSwrQk2JD8I0Dp7x3yAextJkTWnd77kKV6+d811h6Hn4QV1DQPHoFWyraT1z
aEjQlZteFj7SnHznTmoDBfqbBiUWnM7i0kouN6vRm4KYwfBjKwyykMgIna8i9S9xKXfVZUEq
xliZzlTLJAcLw+47CPWOk3KzbWpPwoRnm9RlKZvzoPaxn7+Ms4cenZgeQDff5CxqO6zHSeSW
9nZrYRFVuS/MwJDCeGo+iWxIZTQbsqmw/LTq8BSBrUQ331UNLP16PIHC/U55LNuH9vGewU0B
WZeTQT8lCOQe2OwvkeOmSWIDhhssngrTvb0WPppG5fwqTzGDvCzxUiR2YGJnlao7PBzBWPud
bh0BU3jz/ZFYN+r3E2evqVxevGOKd3g0ujSmOdFNF8zHnZTQ3dUyKLPPl+9NfD78VAVhL4hg
/1jcRW8IKt6rncWYhoAQeXQ5CWty4QgqBZaBZvAcszSMHeNQqKdgtaQu4ARVpqvBaKhxY5Nb
v9t5/fh6BZy2jINrDEL5KICdh/LaL2SlsuuFG7Vfnu/v0VYysjWt/I8AI2eIEcRHCXVXRaNa
1bJMIwu6H/895s00V1WQgdoD0xDxjLrS8c6xQCo7Fa8anP2NVS29P/lu9ZNpEvft2sYgbMb4
to6zSvK/HQxE3lLDZqgoTibDiqnyTIoDqLdo7DrBKBm0AjETSIDTwPJ2RNUWtYYVcR7KrxBg
RlwMespBH2tADefxjjIyLuVxNJVUuKNBNokLAaAkAePMwGLeQdL7vVpI6aH2g694iQIWYt6g
CCOv0bVNbm2Pu7SUmEBr5YUNGVSBixMyEAjCMDCRZTSoiaIOFpxNxXxNVKNZPuxcN/lft0/I
GBeeYzdsLO+zz5xkfF0EBPxn+eH4eH6Wggv8fFSib7be3zueWgarFos7c3ZmLHp3GYRNJMOh
qeFn44BnQkV2aMDFPpKLMQQkrmYNTA7euMgyLW/YVEAjPgrqUr1NiFqOzYWKsfRXXdkSzLsJ
S/4OOAsKemnqfQ18qyFzf3s87vaUlnt+9vD81P5s4S/t0+bdu3dvB0OIYp7U9pRMMD9/pSgx
kWQs8qkKiutgbGtwB/nuHsOK5tHypOWyK3tO8yU4M3yShRbAWAI91hj1WlYEiklXXlcpzPkL
bVG9MhjTnRXLv5veCgu1bkr/0s5hMfYDHTWJ/8cHt8Je+loW/tVoSWFNdZNV4H1hufZYij6p
DaV2xrUO/LeIy6ucgi6G9NDoM1uExkYjYeMhTeopToS50qL3BXo1pqwpdp5IaUmkWLMV6fMw
L8uGifBbQkAYkvvWsITpzfDuIT9IjjfwsWYOInoRxJi4dgjzS1hgBouuNoUP3UnWywunEXGN
0K2ENxXnNxo3CMpSbKnvDV2VnlltLpweiI164qKD9dRpGRQznie6A7cL9u/EucyOIa6WST3j
AN00eU5HVsCAYT6HpYMhIE7yJ9xGQv2gasVIS4InBLk7kee/CuZFKiC59xYP1Q4klSohpZvN
aB2pe5l5EzrBm4k71LMk4rUppmBXmGTLfni3edNLr9tHvCeT1GJ4+Kc9re8tKM/rRjKvug3q
4igKZ2HqfmKGx52l6zBfeHYUWEgInKU+e2FFypCf3xEI7DZXGw6/p5jDCB9FlOej0+QF2VXE
4z9m/wuDnnsAAA==

--2fHTh5uZTiUOsy+g--
