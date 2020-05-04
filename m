Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CADBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51192078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgEDSLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:11:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:18300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbgEDSLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:11:39 -0400
IronPort-SDR: Vut0BDhCwxVvwXy/DGEvMBg+rfAZwqzcA1b57QCsREPkutino7/wrnalL0o/pKkCWT12syla9S
 exHSFEZFiAAw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:11:37 -0700
IronPort-SDR: YV52woUnityNRYTlBILnJ9A3eLXx8gVrhPntVCNV/7GerigDtMGPAQUjlBpopGWEdVd3OE6XDY
 PRIGeTCN124A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="gz'50?scan'50,208,50";a="249235766"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 11:11:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVfYz-000CEN-Vv; Tue, 05 May 2020 02:11:33 +0800
Date:   Tue, 5 May 2020 02:11:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, tglx@linutronix.de,
        john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, psodagud@codeaurora.org,
        pkondeti@codeaurora.org, Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really
 not bound to a cpu
Message-ID: <202005050240.43QyO4uy%lkp@intel.com>
References: <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prasad,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on tip/auto-latest tip/timers/nohz v5.7-rc4 next-20200501]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Prasad-Sodagudi/timer-make-deferrable-cpu-unbound-timers-really-not-bound-to-a-cpu/20200503-025049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 4479730e9263befbb9ce9563a09563db2acb8f7c
config: riscv-nommu_virt_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/timer.c: In function 'get_timer_cpu_base':
>> kernel/time/timer.c:847:11: error: 'timer_base_deferrable' undeclared (first use in this function)
     847 |   base = &timer_base_deferrable;
         |           ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/timer.c:847:11: note: each undeclared identifier is reported only once for each function it appears in
   kernel/time/timer.c: In function 'get_timer_this_cpu_base':
   kernel/time/timer.c:866:11: error: 'timer_base_deferrable' undeclared (first use in this function)
     866 |   base = &timer_base_deferrable;
         |           ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/timer.c: In function 'run_timer_softirq':
   kernel/time/timer.c:1805:18: error: 'timer_base_deferrable' undeclared (first use in this function)
    1805 |    __run_timers(&timer_base_deferrable);
         |                  ^~~~~~~~~~~~~~~~~~~~~

vim +/timer_base_deferrable +847 kernel/time/timer.c

   836	
   837	static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
   838	{
   839		struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
   840	
   841		/*
   842		 * If the timer is deferrable and NO_HZ_COMMON is set then we need
   843		 * to use the deferrable base.
   844		 */
   845		if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) {
   846	#ifdef CONFIG_SMP
 > 847			base = &timer_base_deferrable;
   848	#endif
   849			if (tflags & TIMER_PINNED)
   850				base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
   851		}
   852	
   853		return base;
   854	}
   855	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIpVsF4AAy5jb25maWcAnFxtc9s4kv6+v4KVqdqaqZ0ktpz4nLvyBwgEJYxIgiFAveTq
iqWR6EQ1tuTVSya+X3/dICmCJCCnbmo3idGNJl4a3U83Gv7lH7945HTcPS2Pm9Xy8fHF+1ps
i/3yWKy9h81j8V+eL7xYKI/5XL0D5nCzPf14v98cVt+9j+9u31293a8G3qTYb4tHj+62D5uv
J+i+2W3/8cs/4H+/QOPTM0ja/6ene91+ePuIMt5+Xa28X0eU/uZ9enfz7gp4qYgDPsopzbnM
gXL/UjfBD/mUpZKL+P7T1c3V1Zk3JPHoTLoyRIyJzImM8pFQohFkEHgc8pj1SDOSxnlEFkOW
ZzGPueIk5F+Y32L0uSTDkP0EM08/5zORTpoWNU4Z8eHzgYA/ckUkEvVSjfTaP3qH4nh6bhYE
BecsnuYkHeUhj7i6vxngylbjEVHCYTCKSeVtDt52d0QJde9QUBLWK/Tmja05J5m5SMOMh34u
SagMfp8FJAtVPhZSxSRi929+3e62xW9vmoHIhZzyhJpjONMyyUI+tAxvTKYMJkbHMAjQMZAB
4wrrFYHl8w6nPw8vh2Px1KzIiMUs5VSvrhyLWXu9fRERHtva8jFnKX5s0VBlQlLJkAnafvGK
7drbPXQ+bPtuBKvBYfixH7LUUNWKhcICT9iUxUrWk1Gbp2J/sM1n/CVPoJfwOdWDqJpjgRQO
H7CuqSZbKWM+Gucpk7niEWxxm6eaYW809WCSlLEoUSBeH4+z0Lp9KsIsViRdWD9dcZm00gwk
2Xu1PPzlHeG73hLGcDgujwdvuVrtTtvjZvu1WQ7F6SSHDjmhVMC3eDwyBzKUPnxGUCYlcij7
OCS3TvsnxmEcLRgDlyIkCk5Jb0opzTzZ30wFK5ADzRwy/JizOeyx7YTKktns3m7C3lLBscCz
Hom4TYkZg9PKRnQYcqlMJW4PsBkNn5T/sC4cn4zBPnW05mw00DoEcOZ4oO6vb812XKuIzE36
oFEpHqsJmJSAdWUMugdH0jHMRx+f+uDI1bdifQIf4j0Uy+NpXxx0czVLC7Vj0+Hj14O7ZtW0
uZFZkohUGdRm20epyBJpP3Rg+8BkgPJZyTB4OkkEyMTzp0RqP7rlJNHs6k/ZeRYykGB34URR
ophvZUpZSBaWnRqGE+g61b4jNf0R/kwiECxFllKGFr7Z+jMxEECziE39fPSFJy3V9vMhNA3s
w/Pz8EtEXLS53XzpXsJN+mAlDYVQ+QXFBmUQCRhEcNA4P7S48FdEYutMu9wS/mE4DXBTKuz+
DEecsgRtBZxiUJGGXp795mftPMAnpuZKyhFTEcCBvHKCF7TiEkdQ+iTLnBIh+bzyCc1YysNp
uv+2tSXgHYOs/bH6U5li86an/jFPeNOivXvZTKNkTsct0SwRrlnyUUzCwK7zegIOmva4Dhrh
dp3iIs9gDexaQ/wphwWoFtx+6CMWDUmaArawkifYcRHZ+w6T4OJugmjm++3Tby4uanF+xhmN
+6PXV61joi1mhdOTYv+w2z8tt6vCY9+LLbg/AraUogMETFD660pOI97qTn9SYiNwGpXicu3Z
e+DEwLRE5cN0YlePkAwdhMwGMmUohq2TBv1h19IRq3GtXdo4CwJA1gkBRtgggMxg0e0qEJFE
s8zakYADI4mAhz2Nq5a0HQXUU7j9MOSGAUm5pNOOR9NjSGOwx4Cj8wgg8PXdJQYyvx98aAnM
ozwSfgv1RVFmWdAvgA1zPyI3g2YMU6Ll3t98OluWquXjbdMCKymCQDJ1f/Xj7qr8rzXIANAW
HCgIeDDE6jptDdbdZBYyqvA8inShpxJ2OGYEVE9DDRLm4wwsbjhsmfEGF1TUwDCVAMLoRJv2
ms3EbdgMkQFMYCT79BrflOa136hdueJ4pBE+tEz0OagApRqmAAZAbcHvWxhkFvVbxzMGAYEx
lmSkdPwawlEMYccqmLWjsMePxaoK35tzIACW8QDGZlXYdj/dMXlcHtEgeMeX58IUpTchnd4M
uEWrKuLtB95CY3ofYVN9OF02T32mk9hYElDvZLyQqCuDUev0GxQAfiOrwYiSRlKcIriV9+fD
pDLQ/mpxO0cSwgWSG41BkpmIvL0upk1uIdsmLLy+urJZ/i/54OOVOSdouWmzdqTYxdyDGGOf
GUXDe8nQNxAbxzncAdvuGff9YCRwIl+nVt7sgXz/fl18f/99vfT2f3vFcv/4stpt70/L/fEO
vv3709Nm9/vVj+vKEvx+ff1xcHW1vfOA67B7LO6Pxxd59cbUBi08D8DYDuE02t1HxcTmisU2
13mWgjjX3KDWjEpV3v0NoQW4tuXX4gk8mzHfxqBH1jVzdm1le5b71bfNEU4PrOvbdfEMnduf
Md29PiLa1IyFmPSPOiiuThhUaaYOEsO8F5yWKu0jO1QaTjot2vunbNTl1O0IX0uLmPuZeV6a
gVYKlYO3U2aSpIrLdGdwhgqMNkDsKuFgSpnyVHUyAThVm1FHcw0bAaHwmKRdOVQkizrzpkJj
OhBnghqgIs1I6rcgVIVBbgbgwzTm7MGpERXTt38uD8Xa+6s8Hs/73cPmsZXM0CPE2SJ35fo1
mjDV7pKks9EOsxGmsIRUlN6/+fqvf73pg4ZXlOlsq8BJIipnxlJooC8jHNm1YSyFn4XMlgwY
ViF6A2WrmHMo7VDaoHdygT0WdICjlCt7jqnmQhRiR1jIUZ9xDRnsqA3ZZkM7+EOahCBdJCTs
7XwC9muDS+opMOTGIYWPKa4jQAgcMLT0zRUiVKRxw+OIUuavcAgZvCYj4iPyGo8iKX+FJyL0
NQ7pC/kKT+hHr3DI0WsjAYievrowMnttcScEAv5XeFjw2mAw0X179wqToX42rtpFdBTJzN9E
n7X94+KcDRdNsqvlf4CTizKn5IOJw+/ad6vhmyyGjkNRcwyDz9Yht0fRJJb0bGUCJiqL0TRU
KfU2XVvgkn6JZu07A4PAXJ1NYrv32QBHERczA+2ff9ZLyX4Uq9Nx+edjoW++PB3PHo2jPeRx
EKlc0pQnyiK+omP8YhjVVmNjXJrmXIQOG1byfEGmSwza3/n5a2wRwFNHrA3dMwfsc62KXrKo
eNrtX7zIho3OkPJCRFaHehGJMxK2AvRznFfSbLmnsnNbGmAIn+VlPwORNOKm8AdGwd3wUaME
zONo/SmltCWEgAISpck6Gvik/zvbfQgowOT7aa66oXosIIbOq5wAYDce6TyhlKabpSEDb0Hg
4Fn36EsihD0/9GWYOZIMLEXgBBirm7qpIWOW5EMW03FE2mmWrmInCs81o5y0MIt7941sObNd
eOjFZpj5+kMvlFYmv/i+WRWev998L61bC3DSVkgIP9rnTCmguD5OQ3C0WVWyPdEH8FmZkxqz
MGlbxYoOaENFiZkKqFtApwGXtlIEsU/CFpRN0lJ8wNMIYCYrb1jriQeb/dPfy33hPe6W62Jv
DiuY5aHAyxjr2ex2NHy7TkQhRLIf7vMcMO/gpxDY211BxcCmqeO6o2TAm+dKDBjxSExtyedz
igKUEiRyyiwJjjK8EYkIxWjRAsj2LSyj0NPBW2vtad0Lmc2G1sfSkcRVtkDRV0YwLwJTCUWA
qT7luHYHKhokvM0zBeSMpOHCTpqI4R+tBrQnaCfMtpZrExidAbidgv0vbaE5OtiHtHM71JwU
kmJ6yn1zZAP2cRaG+MNFUB4KkfROoJ8OfW+9OaAjWXt/Fqvl6VB4eImbB9Lb7T2OlqLsgomk
Ym0eg1p0SiK7B/NTARBzoqg/tW1iiaJQTH3mYvADnjw9P+/2R/NL2J4H1HrcWn1K/7c5rFqa
VytNFkUL3Ck7vowh6JQZmAHcOe66SZSu2c4xdTzPpR8wu0NPpgmJucPZD7rbXoIfBnsReYf+
ipSU/NMNnd/aEUK7a1npUPxYHjy+PRz3pyd9G3D4BoZq7R33y+0B+TwIbQvUiNXmGf9pHtz/
R2/dnTweIQb2gmREAKxUtnG9+3uL9tF72iFi9X7dF/8+bfYFfGBAf6uLlPj2CDF3BIv2T29f
POr6J8tiTAW4zMx+E3JJhLGcdCys3Vu6VKZjqeRVizGWWjuAiHCqdRNLuJ+jXXEoFHWURNg+
1IoT7fbScTlH0hFT2u9YTiKcoVaByxSObcegVPvxfDo6J8/jJGvBad2QBwEawZA5DHzJhFeO
YEsucJRgcQLw7wJTRDAe7TLpsWeHYv+IhSUbvPt6WHaMQ9VfZJJdHscfYnGZgU1fo4Nzdixt
D211+k7YYig6WMo2hcvjl1jJc4FF30LYo5aKQWR0DBEXY/YguxqJK7RJI/6hp4p6suPlfq3t
A38vPNSu1hpILMayg2YSsa4FPR8km9DGPFg0uvwmGLcluLy94Urqw6SMC42pgTLhLykwy5uS
WJblSdLkrBmMAGdmtDUGTRkEjBT9zq1kjY9jPv90B5HAopUiDdmI0IVutpscWEeIeWKQr2Gx
Q5+qGzUe23VFww7lyAWGPmy+rqRBpOwAqRj1uUiTDq20vQA2l4/euhuMVBPSII6ahVgV4a5z
LWM0G5U8urIE1uTSmuku17cfP16RfEqgqXcDb+EPMG9qi+VMpp5qmMQ4zTOSKoxNLdQUU/CA
kGoW6yDKSxdHYra1ILNXWVI1uLubuycEKDcB9cc6njO0223fYl/g1nuo8YLFl1cScCoQ2tuc
VcWB9qO3WNhoO1AV2XZb2uGgNJ47Cr9KDoJ3JiT/Q5ERDvInWF9jq5BjIl/lhDjsEjmQYR4m
rwnRXDwOQjZ/jRV+YnO8xfH5iFM4yvaIt3Mse2L07UIXnzW2tCp1spKrGKHaUruzSaJzwa/9
pnUGGCz2hd3WpGR2KdZWFP7fvUhsIH+4cAHPvv8wv4nDAQObQYSOBXL9dEIJCgbUdkaw2Yp1
DXaD+8ahNIk9WyNhPe3r2AWqdWDTrsksb2JU4q0ed6u/jPGXIc1WZy2T8QIvmxCPQYiJpfiY
q9P3eeCTogT93XEH8grv+K3wluu1TseDlmmph3dmZNL/mDE4HlOV2pN0o4QL15XX7No+VzFj
aU6mdmUuqRj7O6qfNR1rUEK72xzPIse9hRqzNCL2ecyIomNf2BCClEOsL5R82DGI0lZfMaR4
DWNhR0Jvj6PT43HzcNrqApMaQ6370DUKMP6JGJgesDnUcQ4brnFIfbvKIk+EJ8UR+wB5zG8/
DK7zJHJE2mOFd2eS0xuniAmLEkfyXw9A3d58+g8nWUYfr+y6Q4bzj1dXPeDb7r2Q1HWnB2TF
cxLd3Hyc50pScmGV1OdofmfPDFzcNsNGsVEWOgvrUnphHsznpK606md998vnb5vVwWbY/LSP
+Qi0WdKIZnPJRxPvV3Jab3Ye3SX7HRAOu/1vvddPjYSf6lDmgvfLp8L78/TwAObc72eWgqF1
pa3dytzocvXX4+brt6P3Tw+0vR9SN0CaYtU9kbLKztqTfIROQqwlu8Bap18vf7l6G6aLfDCT
8/y4fKmUw5p5GRGbb663UyfcesC21Qx/h1kEYdLdlZ2eipm8H3w0HOsrozvnpruKZlg/kcX9
+4gx921zxGZrWGmwnwMyMLdiTDkALKVg8IC4IURopo70pgSxueeA5ixMeBclGeTztc+Y+p2u
/VQHtGl83Rjjc3vy7eWAbwq9cPmC2KRvrmOR6C/OKeNT68wvyGnPaUT8kcMVqkXiyJNixxR3
Xs44+DW7iYkcpo9F7uRGzGYQGvt2100o3v3xIWBxZXu5wXxCbVuXKloeOnsgi96ql0wuc+8R
GWaBrWxNLmKKtVn2s172y8eMdJ/CVLvTEWxMMZtDVJ647h50UVeJhG1KeK55aCPziMWtJ1V1
Uh/vuhyOrGLRSSL3tQCWAfS/FmEwUJVwNNdVVdp/td8ddg9Hb/zyXOzfTr2vp+LQDjLPWd3L
rAZETFkf4df7BCGg633CSIR+wOXYMj8aTqoLmUnWLc8DGl5LJsSMbcvXZVUdYP149wl8N9WY
V3uZv3f7v0wdQkFj6TvqMM8CQc3meEkVOfJqyHKhxNgxDhPPYuUJ3s739L/sJHenfQs11uYB
H5OUN3utliQVQ2NpyuJeTWqVEnOaCjrmCcB/dfvB7p2tAzBkEB4Oxbw37rR42h2LZ8ALNuOJ
96wKr17sEZqlcyn0+enw1SoviWSt/XaJrZ4dFzfjlhyrhLH9KvXjQ0/A5n3bPP/mHZ6L1ebh
fJN7dhnk6XH3FZqxmNwcXo2hLOSyHwgs1s5ufWoJi/a75Xq1e3L1s9LL9NI8eR/si+IALqnw
Pu/2/LNLyGusmnfzLpq7BPRomvj5tHyEoTnHbqWb+0VBj3ubNcdi0x89mU0CAjNHU5pZdcPW
+Zyz+SktMELXCO1tkDLH7elcOeMWXWRkT904zE4y68cBeG+7glFa7p3Sz3jWWxWdEGu2A8B6
mbUxy5OwetJtvCtvCTfGmGAptcsH6FgfsaoCyBJaUjjJeNF6jdx4iKq2AhmsmJ5G+UTEBPHQ
wMmFSRMIBFlMwR/a85ZtlgtyMDHIIWyMPndRZYstApcRwp8AVy+KS+YkH9zFEeaNHDfiJhdO
08mFCfQwZz3YVyeAWotsdMV8C3XcGEbUPseU9MEa2a73u02r+oHEfiocoUHNboRxfBhPfR45
7jvI3Noed29Iyjhlhlfuq832qzWBruzfKJdQja0Dtog0olu8ubeJDBwJQcmFfT4y5JHrJOnH
VfDvmDl+dUD1MtGOedv3plUBF5j3UiVaRnNKQu7jY61AWorQG3s2yIPWrVrVlM/xLt9lBG+w
cMZB++CipYzDKPB9t53+h5s0d5NGgRy4aEN14XMxDy90DQbunmyO4RHQy3pNkdgCCf3QAunl
7484w63Yx2zToks3tA1rdNJF4qztBg4IXlzPE/xYKB44HFFJ049n7KLJhd6fM+GoxsAL0EA6
N74kO1c6wyfedlpVRNYhl2q+XH3rpKekpYS1RsEld8nuv01F9B6rtfDwWM4Ol+LT7e2Va1SZ
H/RI9XfssstQWMj3AVHvY+X6bvmewfHVKfR16rKyrG9tNOyfLd32oTitd7q4uhlO7VXK+jiz
kBRfYta/e6DxPtgMyCT003adREWfsDRuPWPF3yHQej1YP3W1dG7eL/ERiRUCCTJq5ezLv9zT
t0zRjKBkmYOAQSnmeCQfOx7eZzGnwrfrW8sqV5f6q9N+c3yxpUImzFnCQDM86bkfMalhmAIw
5brMLHkvEh36g3XasLZoF7BK/kIlcvl7mJpxEaNCNZTR/Zv//p83rael35b7dbFFl9tM3Kzf
32w3x83ycfO/deb6bKu4qh74dX8XkCbhIyd8FH8ek8Na1swB/mYbF2+7qLw7pM4rVMuMmivi
ziYbeoomXfTMWLj5c7+Eb+53p+Nm2zZoCMntFTFDrrCqG7x6+yikvjUcSHWNDjEeP5xhOeU5
F+VjA2OocKApVw6AktLrWxclV9dXPg+cZK6y3JYNA5p+zW8y3wzwAUfgKHGuGCDCYcPFnaVr
SbH/tpaKhaQzouz5x5ID1tlFvXVKdhLst2mAmfXH/q+Sq+tNG4aif4XHTeqqraq0vvAQIIQU
EgcnKWtfEKMIVagtKnTa/v3uh/NhxzfdHipVtnEcx/fec22fI1yZ1eMbAb/j4Xr/HD1A36j1
toC3bM/QjwewBN9CgVKVZHjtu1LaqXw0Chkpi/HCRYiEbLIKlk+SwOEoQYnAUMEaeO4ioDst
sxCiiLX1TL/ELCx0LhQ2Jq6Xa1fMpZnc6aT1sJI3wDFbH2dtHTYYkmMF6GrTyDu9tb13rNe1
r1jpkPu1feL2wDRdKj2+Pb2cD3RL4PF5d9p3iUxGwgp3AO3QS8Uo3+J112NzuLRQEYktVP5v
+F1ssSzjsBjWwhwQdnJUzej0cN1C2Sh9ZIYyERSh8vtkpMAi16HWJODXorIgiQP+wJ2NVG7x
4cWJqbaHUdvxC2mpAbzbHk7UdGs0H32Rlp+G8oe+bIhoWesEr6uQlFaL3qVh0KS4OLz6en1j
r5KMqO2iyA4yC6ljaOVtYCTPYFiks+YZWS0GRXxDJ2Pgd4KQTMxfgDRJ4BwoNSDAasIKkipd
3DvGSpR2fuWuHIhV3h0HiRqsV2EwRxIYEm6kPfV/+3gWh8rYz2T3832/xwjcuqdvAekgigmr
CiwIM1QB143ywAdkqRxARxylSeWjHIJQ7/jsFY+wuE1H5FIEpPVJD6ORujMbGkRGYCKX0kTu
EBsSTvJvOpEizioV0kGqhi+dq1Q6AeKnqNEtrK0+lhYjuRKdiR+BEuuXW4XphO2vp7+7xPOF
6mzBtIl14VA7rYqe7pk2qcNIvClrvhdTSxFk9n0ENgSMk74kxwhSzANcXx1lFy6mmaFLrzZW
bVZHZ8ZnDgfIEB2h/UC9Hk8Xg8Xr9vB+ZLubbV72DviE9AaBs/Lvb1j1uNtUho0ELldiuFJl
MWyLvKgpsVjLDEbJyhvCvGElpIZpRCK13karpfdOWGu7rO9dOSur5Ru9Zlax2iXkQfUekmtH
HFL+TDhJ8zDMHAPj5ACP7hpn8ul0fHqhe4EXg+f38+73Dv7ZnbeXl5efu0GuUdnoM0vPuaW7
xD/sRK9yKXfmBkGhEvTHC3jPnmZmN4zQXgW7/N3SvhusnQKJbF10Vq2PFQ/+Awz3H5NsZcxG
jMv/aIysqJlapnkYTmAR9dzNNQGBnahgsUaY5XFz3gwwpGw7ek1mDmNhMown+qBeEE+pnGIR
T2NJNY/iQLqeBAVeltK69OxgWoYpvJL71LGG+UuRvt7dBESNWa/hojQt6QSJiwNbSCuo1cSw
2JEDYrzZ1TenE3ERkO7uMvf5j5ZGruwawL8xmtIeHGXDZzIIwAPEDPebDOSA6fi+sPmxdc5G
SpnpuJEP1cM//tpIB9lMaMNcmoTOMCB64oaE08SoTfLvCUS2oCUWUs7VvYA0lac5D5Js4bl6
xDrx7eXRzsGK3Qn1likgjF9/7d42e0srbl5KMb0yA8xllIbYf8u4WthRx/0mbxs7+kOQR4km
nsHMUuKuiC+4THF68DKS92GARkQ31/vanR0uzk//AmyTOIuhXwAA

--h31gzZEtNLTqOjlF--
