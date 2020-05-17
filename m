Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA52420758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEQL2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 07:28:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:34273 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEQL2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 07:28:11 -0400
IronPort-SDR: ubtjLPiOv6ogR6p9meoAp3dyN9EEdVwntw99MKdVy+cTMoFtO8VBUGIicgdf/JzOHTdgJACMi0
 hmbnAdCVxASA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 04:27:09 -0700
IronPort-SDR: 5PY6lA/yWfZU3qbtHtRMN5yI5mnYmCQqAH3Da3z79I4Hq320I0sUOqGx75B34e3u5htOAl/nTQ
 0gsGvM/aq2Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="gz'50?scan'50,208,50";a="438894861"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2020 04:27:07 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaHRi-0009GX-Vo; Sun, 17 May 2020 19:27:06 +0800
Date:   Sun, 17 May 2020 19:26:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:tglx.2020.05.05a 105/140] arch/x86/kernel/traps.c:819:24:
 error: 'tsk' undeclared
Message-ID: <202005171929.ZVVDCTIJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx.2020.05.05a
head:   e6d36eed49b863bbe393e3c07cae737cd9c475e3
commit: ca303aa341bab5cdb3a3b41391ff262e252cd3f3 [105/140] x86/traps: Restructure #DB handling
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        git checkout ca303aa341bab5cdb3a3b41391ff262e252cd3f3
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

Note: the rcu/tglx.2020.05.05a HEAD e6d36eed49b863bbe393e3c07cae737cd9c475e3 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>, old ones prefixed by <<):

arch/x86/kernel/traps.c: In function 'exc_debug_kernel':
>> arch/x86/kernel/traps.c:819:24: error: 'tsk' undeclared (first use in this function)
clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
^~~
arch/x86/kernel/traps.c:819:24: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kernel/traps.c: In function 'exc_debug_user':
arch/x86/kernel/traps.c:842:24: error: 'tsk' undeclared (first use in this function)
clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
^~~

vim +/tsk +819 arch/x86/kernel/traps.c

   809	
   810	static __always_inline void exc_debug_kernel(struct pt_regs *regs,
   811						     unsigned long dr6)
   812	{
   813		nmi_enter();
   814		/*
   815		 * The SDM says "The processor clears the BTF flag when it
   816		 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
   817		 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
   818		 */
 > 819		clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
   820	
   821		/*
   822		 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
   823		 * watchpoint at the same time then that will still be handled.
   824		 */
   825		if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
   826			dr6 &= ~DR_STEP;
   827	
   828		/*
   829		 * If DR6 is zero, no point in trying to handle it. The kernel is
   830		 * not using INT1.
   831		 */
   832		if (dr6)
   833			handle_debug(regs, dr6, false);
   834	
   835		nmi_exit();
   836	}
   837	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHEdwV4AAy5jb25maWcAlFxZc+O2k3/Pp2D9U7WVPMzE9zi75QcIhETEvIYgdfiFpcj0
jCq25NWRzHz77QZIESQbymwqyYzRjbvR/euD/vmnnz12PGzflof1avn6+t37Um2q3fJQPXsv
69fqfzw/8eIk94Qv84/AHK43x2+/ra/v77zbj58+XnzYra69x2q3qV49vt28rL8cofd6u/np
55/g35+h8e0dBtr9t/dltfrwyful+PO4ORy9Tx9voffdUf909av5GXrwJB7LScl5KVU54fzh
e9MEP5RTkSmZxA+fLm4vLhpC6J/ar65vLvQ/p3FCFk9O5AtreM7iMpTxYzsBNAZMlUxF5STJ
E5IgY+gjBqQZy+IyYouRKItYxjKXLJRPwu8w+lKxUSh+gFlmn8tZkllrGxUy9HMZiTLXY6gk
y1tqHmSC+bC4cQL/AxaFXfX5T/R9vnr76nB8b893lCWPIi6TuFRRak0MqylFPC1ZBucqI5k/
XF/hLdabSKJUwuy5ULm33nub7QEHPl1EwlnYnPV//tP2swklK/KE6Kx3WCoW5ti1bgzYVJSP
IotFWE6epLVSmzICyhVNCp8iRlPmT64eiYtwA4TTnqxV2bvp0/XazjHgConjsFc57JKcH/GG
GNAXY1aEeRkkKo9ZJB7+88tmu6l+ta5JLdRUppwcm2eJUmUkoiRblCzPGQ9IvkKJUI6I+fVR
sowHIACgTGAukImwEVOQeG9//HP/fX+o3loxnYhYZJLrB5Fmych6eTZJBcnMvrTMh1ZVqlmZ
CSVin+6FtGzKchTKKPFF9/2Nk4wLv35aMp60VJWyTAlk0ndTbZ697UtvB63+SfijSgoYC959
zgM/sUbSx2Gz4PuzdIZFmYKO8FkuypCpvOQLHhJnoRXEtD3aHlmPJ6YiztVZYhmBEmH+H4XK
Cb4oUWWR4lqay8vXb9VuT91f8FSm0CvxJbflOE6QIv1QkDKkySQlkJMA703vNFNdnvoiBqtp
FpNmQkRpDsNrDX4atGmfJmER5yxbkFPXXDbNGLi0+C1f7v/yDjCvt4Q17A/Lw95brlZbsG3r
zZf2OHLJH0voUDLOE5jLiNVpChQ7fYUtmV6KkuTOf2ApeskZLzw1vCyYb1ECzV4S/FiKOdwh
pe+VYba7q6Z/vaTuVNZWH81fXIqiiFVt6HgAr1ALZyNuavW1ej4CpvBequXhuKv2urmekaB2
ntuMxXk5wqcI4xZxxNIyD0flOCxUYO+cT7KkSBWtDAPBH9NEwkggjHmS0XJs1o72To9F8mQi
ZLTAjcJHUNpTrRMyn2ZJEtAFg4Ns18nLJAWJAnSB+gzfIvwRsZgL4uD73Ar+0jOFhfQv7yxN
CJomD0FAuEi1Gs0zxvt9Uq7SR5g7ZDlO3lKNXNlnHoGBkmBBMvo4JyKPANqUtYKjmRZqrM5y
jAMWuzRPmig5J5XLSQvApT/Sl1E4Xmt3/3RfBgZlXLhWXORiTlJEmrjOQU5iFo5pudEbdNC0
CXDQVAAAgKQwSUMSmZRF5tJjzJ9K2Hd9WfSBw4QjlmXSIROP2HER0X1H6fisJKCkaVDU3a6t
LRDct0uA0WKwgPDeOzpSic9Ef+glfN+G9eY5wJzlyQhbUnJ50YFtWqfVnlVa7V62u7flZlV5
4u9qAzqdgbbjqNXB1rUq3DG4L0A4DRH2XE4jOJGkh/Nq9fmDM7ZjTyMzYalNluvdoOfAQO9m
9NtRIRs5CAUFJlWYjOwNYn+4p2wiGpzrkN9iPAajkjJg1GfAQHk7HnoyluFAcutT6npVzarm
93flteWIwM+2a6XyrOBaTfqCA97MWmJS5GmRl1o5g/9Tvb5cX31AL/vkCaEB9EVaqiJNO74f
2En+qPXukBZFRQ9sRmjvstgvR9LgvIf7c3Q2f7i8oxmaG/2XcTpsneFOUFyx0re9NDMAWzTm
oxz7nMChAIhHGSJiH01orzu+WwRaaF7nFA38F4H+v+iZuRMH3D5Ic5lOQBLy3htWIi9SfE8G
zIGH0DLEAmx+Q9I6AIbKELMHhR1t6PBpgSTZzHrkCFw746mAiVJyFPaXrAqVgqfjImvUo4+O
hWVQgCUNR4MRtPSoRlvAkvQT6cgzyDd4IE+LcqJc3QvtqFnkMZhUwbJwwdHREhYCSCcG5IWg
QUL1cNWLqiiG14PyjXcgOLzVBgOmu+2q2u+3O+/w/d1g3Q4YrAd6AqiPwkVrg4iGZLjNsWB5
kYkSPWVao02S0B9LRXvBmcjBMoN0OScwwgnwKaNtE/KIeQ5XimJyDjvUtyIzSS/UoNAkkqBf
MthOqYGrw54GCxBJsMoA/yZFL8rT2uSb+ztFAxIk0YTbM4Rc0UEHpEXRnDAA0Z3WrS0nCD9A
x0hKeqAT+TydPuGGekNTHx0be/zkaL+n23lWqISWmEiMx5KLJKapMxnzQKbcsZCafE2DughU
pGPciQAzNZlfnqGWoUMQ+CKTc+d5TyXj1yUdGNNEx9kh9nL0AlPufiC11SAkCan6PcS4G2MX
VCDH+cOtzRJeummIqVJQUcYvVEXUVZkg3d0GHqVzHkzubvrNybTbAnZVRkWklcWYRTJcPNzZ
dK2pwQOLlIUlJANtgPqrBEo3zpFwofBpKxGCNqVcQJgIFLk+ECuA1DTrO+1AnIbCIn/YGCwm
SUyMAq+JFdmQACgmVpHIGTlFEXGy/SlgyVzG9k6DVOTGySEFwo8ksfdYm2JVwiLAGI/EBMa8
pIkYUhyQauA5IEBDRxTxtFJJKzx96V3n3Jg7C46/bTfrw3ZnAkvt5bbIHy8DlPysv/sauzrG
6i4iFBPGFwDuHVpbv5okDfF/wmGY8gTeyoi2vfKedgRw3ExgXANQgyv8EkkOogzP1X2Gir75
2vJKyt+LE4wuGnzSCThC0w3twNbUuxsqjjWNVBqC0b3uxPjaVgy2kKM2LFf0pC35X0e4pNal
sWYyHgOIfbj4xi/qhFnnjFJGBYg0zhsDFoE9wxtgBArVoXE3WeudJouAMXdLycgQhS5s4AlG
vAvx0FuY1rDgTSQK3fCs0GEnh1Y38X2wUMns4e7GEp88o6VDrxFeuH/GkChwbJxEABjpGRMT
gimY623j+dtSQXHQNpng7CfUWuQnOLpftOg+lZcXF1T49am8ur3ovIGn8rrL2huFHuYBhrEC
NWIuKPObBgslwZdDnJ+hQF725RFcOPTTUZzO9Qd3cBJD/6te99oBnfqKPiQe+doNBJ1DI3E4
YzlelKGf08GkRq2e8UiMDt/+U+080LvLL9VbtTloFsZT6W3fMWPecVxqd44OTUSut3nywXBY
+wr1NKSIjDvtTUbDG++q/z1Wm9V3b79avvZsjYYjWTfoZSchiN6ngeXza9Ufa5gIssYyHU6n
/K+HqAcfHfdNg/dLyqVXHVYff7XnxajDqFDESdbxCDTSneSMcniRHEWOJCWhI5kKskqj5ljk
t7cXNN7W2mehxiPyqBw7Nqex3ix33z3xdnxdNpLWfR0aV7VjDfi7SVwA2hi3SUAVNv74eL17
+2e5qzx/t/7bhCTbiLJPy/FYZtGMgZMN9sClVSdJMgnFiXUgq3n1Zbf0XprZn/XsdjrIwdCQ
B+vuZv6nHTAwlVleYK0Gc1gdLBKZzm8vLZSKYYyAXZax7Ldd3d6Z1k6dxnK3+ro+VCtUHB+e
q3dYJ4p5qyLs9SUmSmmZ2aaljCNpELC9gT+KKC1DNhIhpbFxRO1nSgznFrHWqJjA4ug29Ew5
+jxYspHLuBypGeuXZkhw1DAGSETPHvsBItOKMROKACCH7mBasYZlTOWdxkVsoq0iy8DnkfEf
Qv/cY4OD6rXo/ekRgyR57BFRM8DPuZwUSUGk0RWcMOqzunCACiyChkaDYhL7BAMAsxoiOYi+
zDSMGhy6WbkpBjLR5nIWSAAL0s7knwKC4LMsYoZvOddpNd2jx3d9NQIgCXCl7F8jlkOBbazL
evq3k4kJPIbYN/G7WoZqndrhU+Kz6+KwCMnZMZiVI9ioScP2aJGcg9y2ZKWX089lAjrEQF2R
xYD94UqkHZHv52oIOcE6EwzLg0PnCxOe1D2oQYj5m3RMVh+RX0TkfbaP9jxVx7pzOR2KlJHy
UrGxaGIPvaHqVlOo5aD5SeGIK8uUl6Ympin+IhZag9E6rk5y4DGEcGf9aHs/AtzYrjpK3CEP
qju6ZJfeM5uReQDqzFyHjpX274yo0OiLXoJXG/Wzfo1OidFDQvWKMXj0xKjzRBqOgVYi66s1
eHKNryU4CK0VWwJSEYJGRN0sQhS6kNAgmqKdnGF+f5gD6jGIOWgDUrV1e913RShJF41eykNr
TB5igH4E5w3W3bcICdYCykkNg68HBNao8j7ON/oK7+hcShdUnQTlWBfMZTMrRXSG1O9uzrvL
0x5jCsd/fdW4L10VaeeWwVXm2SLNT0iAJ9MPfy731bP3l0nGvu+2L+vXTiXRaQDkLhujb6q+
2izlmZE668XS2jQsJjJWnf4/hkmaoXQRg8Lcsh3yqoWSiuHX4ppnAp30BBSpfaEj1K0UPo9N
2i6Fp1rEyFSX4nXpWtgM/RyN7DvLwGi6OtvEbu+eD2ZgMgBXAjp9LkQBJgo3oYv83CzZjGLQ
UtgUI5QjMcY/0Jh0CxktXu25wuJZmopTGk18q1bHw/LP10qXe3s6MHjooPeRjMdRjlqDrrEw
ZMUz6QhG1RyRdCR5cAdo+0i3xrVAvcKoetuCnxK13uAAJp+NODWhrIjFBeuEyts4lqERYlh3
7o5W6iSC6WcZ83Y4sC25rbKNSheRFva69wDWjbHkc1J0BsTwXprrXjrIfNPThLzvorThA4z/
ZQKFtFfeYLk5ZZ6ge2yfyaOi4g5NWbFW/6Zu1M8ebi5+v7MCwYTdowKwdkb8seN5cYAFsc6/
OGI4tG/+lLqCOk+jgnZKn9SwOKYH8XUuu3FwOgkWkemkBNyxI2cMUHEE6j6IWEapttNzTXNh
7DvrKHS3wHdCCE7nDgui/pAnS+NXf69XtsveYZaK2ZsTvQBIB8ryTqgEww+k5HHOupWMreu7
XtXr8JJhNKwwFUaBCFNXSkdM8ygdOzLgOcAdhlDDUepjhj/FI/SnCINlnkIFr9vlcx1kaJ7+
DOwX8x0Jl35HOw4UJjNd5EkrwdPmsCDDzwDbu3avGcQ0cxQrGAb8bKMeBhQAItUzUq4rW4o8
cZTdI3lahFhQMpKgjKQYQofhnZ6Cc89a9DqXHAWyH5HrRLeaLtZzipUjQZTTjzsZux5dJCdB
fio4Al1VF1JZWlM3DaQingLSVMf39+3uYMedOu3GWq33K2rfcO3RAoEEuWTQFmGisBQFkxmS
Oy5YgbdCRw2xiG1eKn8sHOb3ityXEHDxkbe3dtasSFPK36/5/I68rF7XOk73bbn35GZ/2B3f
dDnh/is8iWfvsFtu9sjnASytvGc4pPU7/rUbxPt/99bd2esBAKw3TifMCgFu/9ngS/Tetlgn
7v2Cwer1roIJrvivzXdrcnMAvAwAzvsvb1e96i/iiMOYJqlTaM8NYR0nDxKye0deul6of/r0
QnElayZreY1QABExj/0wqQ7Ww2Fcxpi3rdWEGsiF3LwfD8MZ2zB5nBZDaQqWu2d9+PK3xMMu
3WQHfiLyYy9Ts9rvcgJeel+AT5ulpm1vh9iIWRXI1nIFkkO91jynq/VxYSzUunwgD83RpJEs
TfG5o/hqdi77mPL7T9d338pJ6qi1jhV3E2FhrtptID26aPHUpVhgIxOTjXUXWuQc/ksd1QEi
5H0Pr038DK6g7WiOCEBlAdYMKwWGptdI6hUnBfSKLny22S3ua1prKlc+LY1oQtD/Zqe51XT4
xtI89Vav29Vf1vqNUt5oTygNFviNHaa+AO3hh6KYBtX3AFAnShHWH7YwXuUdvlbe8vl5jeYX
PHk96v6jrVuHk1mLk7GzQBElrfel34k2ozNYuialZFPHpxWaikl72o80dHSvQ/oJBrPI4fLk
ATjGjN5H81UeoX+UGtn1tO0lK6omfQReCMk+6rknBg0cXw/rl+NmhTfTqKHnYfIsGvuglUG+
aQ8nyBGtKMmvaSAEvR9FlIaO0j8cPL+7/t1RbQdkFbnykWw0v7240MjV3XuhuKtoEci5LFl0
fX07xxo55juKQJHxczTvVyI1ZvLcQVpaQ0yK0FntHwlfsiZ0M3RQdsv3r+vVnlInfrf4ycAO
aLNNR71Su9l4FLvlW+X9eXx5AUXnD22NI9VLdjPIern663X95esBEEfI/TNmGqj4bbzCsjVE
lXTkBuPx2vy6WRuA/i8zn/yC/lFaryopYqouq4BXmARcluBl5KEuvpPMSjEgvf3yofUZobkI
04FPYZFP7nbA/V7XwZ1imwaa7Rs9tadfv+/x1yd44fI7mqzhK44BJuKMcy7klDzAM+N09zRh
/sShIfNF6gD52DFL8HPKmcwdX25HkeP9iUjhh6uOggVwfYVPa3STu5PaP1wQdyB8xpswqeJZ
YX2RoEmD71ky0HZgc7oNEb+8ubu/vK8p7YvPuZFbGvSgUh34UyYsErFRMSarcjDiipF215DQ
z2SAdEKRNlM1WyBYv7yxFoXe/NZ5FnNfqtT1wWjhgH46nkfg+Q6DTOCi44Km+ykV+pnirxIo
/bSThjGN/aFqB3i12+63Lwcv+P5e7T5MvS/Han/oqKeT73Oe1bqSnE1c3xfqSsb604mSuO2O
icFfcFC6fOQAHFpxGsv1pWIYsjiZn/9aI5g1Mf/B+XCNwtT2uOtAgWYN4aPKeCnvr26tdBi0
imlOtI5C/9TawmpqBtv7k+EooSuTZBJFhdNCZtXb9lC977YrSvthrCnHoACNvInOZtD3t/0X
crw0Uo3U0iN2ehpHGSb/RenP0L1kAw7G+v1Xb/9erdYvpzDVSamzt9ftF2hWW96ZvzHkBNn0
gwHByXd1G1KN1d5tl8+r7ZurH0k3wad5+tt4V1VYZVd5n7c7+dk1yL+xat71x2juGmBA08TP
x+UrLM25dpJu23z8pRUDcZpjjvLbYMxuSGvKC/Lyqc6n6McPSYHlc2i9Max1bKzUPHfCW51x
op+SQ0+nsyGUxLDgClZJKckBzZoixRIGVyBC+1i6igkwQUi4zuBNdn5BROv01dFfZCARI4/K
xyRmCDiunFzorKZzVl7dxxE6xrTS7XDheE4uUw8tBgCm8XA7u+k5lNxReBjxIQYkvpyg7uUc
m3UJbIg82OZ5t10/2yfOYj9LpE9urGG3sAVz1JX2gz8mKjfDAOpqvflCuQgqpy1YXX0ekEsi
hrT8GYzD0rEgxy/QkA5rpEIZOcNs+PUA/D3ufeLUWnPzoTqNvbopsTrxAxrTSI9lj33zOdgs
yawKyRYGNb+uZ6xMaRTtd4o5mlPgMfnfxPHBiy7uQA4X0oER6ioSV9YXOAD/SUf00j+DV6Wh
lc7fyzFmZ3p/LpKcvnRMLo3VTelI2hmyizrGCgkHDfB3Bhi5RzaivVx97fnYikgrN3DJcJu3
v6+Oz1tdhNCKQqtKANu4lqNpPJChnwn6bvTvLKHRovlS20E1fxCH1Cii4ZotBSeV8WVg9lw4
MG3s+K0cRSyH31+d0p3WczHYq1odd+vDd8qlehT/V9nVNLdtA9F7foUnpx7Ujp140lx8oChK
5ogiaYIK61w0sq2oGteyRrI7SX998RbgB8BdOjk1FZYgiI/dBfDe861woxWFS8xXvV+KFMUs
Al0N2kqTxUHc8jUQLqNB0PRvmuuFYuEObeuCDpojUYur98ixccc0+rF+Wo9w03TY7Uen9beN
rmf3MNrtXzZbdMfo7vDtvaPz8ff6+LDZw3m2PdVFuux0MNmt/9n9V0ssNks0Li1s0Yc/UhGw
tAA1NM0XnERtPAUiS7J1sQh+kzwdEeaLmlzMnxWdiQ1PlvVWb7K7O4KYcHx+fdnt3XWMhIeH
szTI7LJIw1y7BdxeYqAZ8LY2SaJUKJ3Gaa3lMI6ds6ZQB4F4CDKSh3HDl/CKvJ9bmDhAPySI
lCexC+MP9T4wDONSCG9FeMGTNvFceXE+iXkoF4rjcrkSq/3Ip2C65BNPjdclYgF/5JzEY3qR
JEIY8tx5cyf08QPwXlNfnbLdOHyF8gozTOhvPQ5dNJf5CdHZB2QpV62EUEuKjnVWeu7MSkdF
zBKJDACDX3OQNvRUnJp3AZtp5wkIbP3Zo8MDrn2y6aQrgdJ9xuFMOwUEZO6hUsmNVEEyd0HU
EHESeteu597qdD3b/aMBsNKvh6P2go90g/XwtDlt+8A9/R+VUdYzI3WQhl79p2hxs4yj8uqy
gZfqlAxQt14Nl93IuxhnCTBdRQGpD/bDxMa+6wjc/k6aezpfuH88kem9Fb7lgp6B40Culc8K
iTurFz/JwUQsCtZIeUBK9uri/MOlO1Q5kTNEXSzAX+kNgRIOqSLcOCnSLArYqWm+QBlGDXKJ
Ba7ROgBFr8SI3mZpcuusDqqFlDZXVRTMa/Qfn439bEc7oDI7/yabu9ftFnGogyJx7tmCGQLA
rRJwOLap3FVCC/mezybOETT+n3mg8fHLsQpSyNzEJUT3avh2nWShlO2Kn/o4d6gMnr3f+T4s
t5tuNPW6gRYCCFCmUdJewxMQ4rNiYqFXqbCnoOI8i1WWSnse85Yi09usQFIkbuJvadk13tPZ
GKQwcVBt1+nAYGkp3uN1yUD7TFa2VB7ktV2upM5jrKDf1FvvXn1fRPIvRSZjY3iK/fbagoHq
LVAaieBwp1CLsdOaJqS9y312XczUZLk78wALwI5S6z3Mz1QHUQnclLOdlr23XnswOgtz1fZn
2fPhNDpLdHL+ejCO43q933o5pN7WIP/NvI04V97oEziFFIyXZVe2QGXT0qOJ8U63TycTBgqF
emuoAzJ4e6xRdcMCGzonLjq2mLcJ5yBDffbOlWF1/URPh1UeL/TWPIpyb4mbZB9XFa1n++2k
d1GEXhmdPb2+bL5v9D/Acf6DeN11+ohTFKp7RvlK/1pY78a/DJ+lUB3YDw6tauYOx19JEO0c
hONWlTGCmmGVB/6JmuvmKiXt0Y0BtVp2t8aovmtNdJ+/URe6D4lrnfLx76a36olKWmli3t1+
6GD++AsD7mzcrfwh/2qkHSC+LFOlE3XwaWSEnXXqJigIbsQSqR7WL+szxNr7nuac7cNY6Awb
HN8oV0Mxr2arCqqniGvpisIir5HirXLhk/y3hoXuvxR/rKB/rgaZZzZbgH40EV3FyQGLN2cQ
GYmDTCLVN4rbZHVkqGU3VFm191XRyz7rVKyh6QpKmy5xmYx8jmtTOiuC/Jq3qfnYLKHdLSS2
Kscr5swsY5xkdv1mGbMFnYrr+nCW4RNwLXmMLA2h2ucI2wdNLW0hnhAc8VQeTxUscp4y2El0
cKOBvxFCHApS2aV59/3zJ2cmdhpC9N1pEswU1x6ABXS+Ms4UacGUgl63If8MyEDbKcXfWxgO
tSxQa8NiMiY5cikDWyzizJ+HzndYfVnW39bHDpnRTV2d//XZUfvpFEQ8arCxWE5E8fLGJpVY
N2EeDJyKmI7Q7ka4Q23U71ZTf7tYL9m0ilN0gih66RtC8NIhsbhzqXucUW5OkNOnlCh8/ndz
XG8dVZv50kug2xN167t9VQrhZgUHsKyNm0frdBk8YDMpcudvLRSgqS+Mb8VSFFE+ej2JsXnw
s3tHvuao538w4ex2XGgAAA==

--SUOF0GtieIMvvwua--
