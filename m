Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10487C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 10:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9AE20771
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 10:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF1Kdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 06:33:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:37857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgF1Kdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 06:33:41 -0400
IronPort-SDR: w1MAgKVm7uYPhLV0hXD/CZV2xFZWdYhQplwYmIOjnPzkSPwN7mZX6E2XemqXM4jdzLvbeFYmsQ
 Z4rgM9QEQYQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="145816003"
X-IronPort-AV: E=Sophos;i="5.75,291,1589266800"; 
   d="gz'50?scan'50,208,50";a="145816003"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 03:32:32 -0700
IronPort-SDR: FoklUxxEYARGVXIqjWrGmH3Qrkh+b4UgeU8moaG0nj+A78QwpkuXCDzRaUyi0pG6L7gI6oUe6E
 wmeGyEgONQlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,291,1589266800"; 
   d="gz'50?scan'50,208,50";a="453860784"
Received: from lkp-server01.sh.intel.com (HELO eb64fcae9b6e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2020 03:32:31 -0700
Received: from kbuild by eb64fcae9b6e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpUbu-000034-Cs; Sun, 28 Jun 2020 10:32:30 +0000
Date:   Sun, 28 Jun 2020 18:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: arch/nios2/include/asm/irqflags.h:12:9: sparse: sparse: context
 imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
Message-ID: <202006281820.uANdHABG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   916a3b0fc1206f7e7ae8d00a21a3114b1dc67794
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   8 months ago
config: nios2-randconfig-s032-20200628 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=nios2 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   sound/core/pcm_native.c:544:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:544:51: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:544:51: sparse:     got int state
   sound/core/pcm_native.c:709:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:709:38: sparse:     expected int state
   sound/core/pcm_native.c:709:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:721:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:721:38: sparse:     expected int state
   sound/core/pcm_native.c:721:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:770:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:770:38: sparse:     expected int state
   sound/core/pcm_native.c:770:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1229:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:1229:32: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1229:32: sparse:     got int state
   sound/core/pcm_native.c:1253:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1253:31: sparse:     expected int state
   sound/core/pcm_native.c:1253:31: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1260:40: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1260:40: sparse:     expected int state
   sound/core/pcm_native.c:1260:40: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1286:28: sparse: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1288:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:1288:40: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1288:40: sparse:     got int state
   sound/core/pcm_native.c:1312:64: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] state @@
   sound/core/pcm_native.c:1312:64: sparse:     expected int state
   sound/core/pcm_native.c:1312:64: sparse:     got restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1328:38: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1328:38: sparse:     expected int state
   sound/core/pcm_native.c:1328:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1697:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1697:38: sparse:     expected int state
   sound/core/pcm_native.c:1697:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1763:61: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1763:61: sparse:     expected int state
   sound/core/pcm_native.c:1763:61: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1764:63: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1764:63: sparse:     expected int state
   sound/core/pcm_native.c:1764:63: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1781:76: sparse: sparse: incorrect type in initializer (different base types) @@     expected int new_state @@     got restricted snd_pcm_state_t @@
   sound/core/pcm_native.c:1781:76: sparse:     expected int new_state
   sound/core/pcm_native.c:1781:76: sparse:     got restricted snd_pcm_state_t
   sound/core/pcm_native.c:2128:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2132:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got unsigned int [assigned] k @@
   sound/core/pcm_native.c:2132:54: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2132:54: sparse:     got unsigned int [assigned] k
   sound/core/pcm_native.c:2150:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2154:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got unsigned int [assigned] k @@
   sound/core/pcm_native.c:2154:54: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2154:54: sparse:     got unsigned int [assigned] k
   sound/core/pcm_native.c:2334:30: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2336:30: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2339:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2341:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2343:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2353:86: sparse: sparse: restricted snd_pcm_subformat_t degrades to integer
   sound/core/pcm_native.c:93:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
>> arch/nios2/include/asm/irqflags.h:12:9: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:159:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1138:9: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block

vim +/snd_pcm_group_unlock_irq +12 arch/nios2/include/asm/irqflags.h

f27ffc751ca5d2 Ley Foon Tan 2014-11-06   9  
f27ffc751ca5d2 Ley Foon Tan 2014-11-06  10  static inline unsigned long arch_local_save_flags(void)
f27ffc751ca5d2 Ley Foon Tan 2014-11-06  11  {
f27ffc751ca5d2 Ley Foon Tan 2014-11-06 @12  	return RDCTL(CTL_STATUS);
f27ffc751ca5d2 Ley Foon Tan 2014-11-06  13  }
f27ffc751ca5d2 Ley Foon Tan 2014-11-06  14  

:::::: The code at line 12 was first introduced by commit
:::::: f27ffc751ca5d216a347084996c70452a4e185a4 nios2: Interrupt handling

:::::: TO: Ley Foon Tan <lftan@altera.com>
:::::: CC: Ley Foon Tan <lftan@altera.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICCxq+F4AAy5jb25maWcAlDxdb+O2su/9Fcb25RwcdJuP3bR7LvJASZTNWhIVkXLsvAhu
4t0GzcaB7fS2//4OSX2Q1FDJLQpsPDMkh8PhfJHUjz/8OCOvp/337enxfvv09M/s2+55d9ie
dg+zr49Pu/+ZJXxWcDmjCZMfgTh7fH79++fnx/3xYvb546ePZz8d7n+ZLXeH593TLN4/f338
9grNH/fPP/z4A/z/IwC/v0BPh//OdKufnlQPP327v5/9ax7H/559+Xj58QwoY16kbN7EccNE
A5jrfzoQ/GhWtBKMF9dfzi7PznrajBTzHnVmdbEgoiEib+Zc8qEjC8GKjBV0hLolVdHkZBPR
pi5YwSQjGbujyUDIqpvmlldLgOjpzbW8nmbH3en1ZZhGVPElLRpeNCIvrdbQZUOLVUOqeZOx
nMnrywslpJYLnpcso42kQs4ej7Pn/Ul1PBAsKEloNcK32IzHJOvE8eEDBm5IbUskqlmWNIJk
0qJPaErqTDYLLmRBcnr94V/P++fdv3sCUsWLpuCNuCVqbj13YiNWrIwRzkou2LrJb2paW0K3
oapxLDNrRSouRJPTnFebhkhJ4sWArAXNWDT8JjXoZ7cksESz4+vvx3+Op933YUnmtKAVi/UK
lhWPLEZslFjwWxwTL1jpKkLCc8KKASZKUgmqULZY7D4SGtXzVLiLu3t+mO2/enz7HMSwjEu6
ooUU3UTl4/fd4YjNdXHXlNCKJyy2OYE1AwxLMopql0bjesfmi6aiopEsB0VC2R9x0y9zRWle
Suhe77i+0w6+4lldSFJt0KFbKkyp2vYxh+adTOKy/lluj3/OTsDObAusHU/b03G2vb/fvz6f
Hp+/DVKSLF420KAhse6DFXObv0gkSlFiCnoIFPiOlEQshSRS4MwLhsrqHVzq2VRxPRPj5QVO
Nw3gBs2DHw1dw5pLSxsdCt2mBfV8uP33qr00f1jKvuxlzmMbbAySGEAZV1YlhW3EUnl9cTYs
FivkEkxNSj2a80szV3H/x+7hFTzF7Otue3o97I4a3HKKYHtLMa94XQp76cBsxHN0RaJs2TZA
NMogGhEvbJOfElY1Lmaw2KloIlIktyyRC6THSgZbGnjJEhHmpEpyYplEA0xB7+9ohXSW0BWL
8b3dUoDiBVW5JYnKdAqtLRjCseDxsqch0mJb+RCwjLCPbJZrKZoCmzp4EEA4pAJ8XhHYYSwJ
oQoq8RFgKeJlyUEhlU2TvLJcgV4n7SX1VDz3BqudULA7MZE0wZabZmRjuVdQNlgT7fYrO4hQ
v0kOvQleVzG1nG+VNPM75owLoAhAF+gkAZnd5QTjJWnWd5aFUITc+/3JiYB4CeYdwp0m5ZXy
H/BPTorYMdo+mYA/MG3wvDkold2LMVVIuxwCD6bW21oRLXbVIcmsHtMFbLtsFE0YB2VBtd2x
Ix7LrNEsBe9hL39EwH+ntTNQLena+wlqZ/VScptesHlBstRabs2TDdBu3AaIBVgsK5xh1kIx
3tSVcU0dOlkxQTuRWJOFTiJSVcwW31KRbHJnQ3WwBv5FFqFHa2konZZsRZ3FHK+HWjQdN6aO
mQOOaJK4m0Xb9TZnKHeHr/vD9+3z/W5G/9o9gxMkYPFj5QYhnLBdwDtbdAytciNnEx8YpXAi
bSIhTF9iypuRyNn4WR0FyEDk1Zx2IbO1oAqnDHXGBFgZUFWe28tdpynE+SWBtiBFCNDBCjkq
L2muzahKb1jKgEAF9U70xFMGScwcDTDctKS3xIyLi3FwG4s6H0MXtxSiPomQQ04UVWABYdqO
uYP4kfGSg8/LdWJgr7Pj04co9fzsDA8475qLz0HUpdvK6e5s4Gdxd60A/c7lYGqBtXVzB5Eo
ryBwuT4/H+nXEF8oVsun7Ump22z/orLaY5fW5rvv+8M/angVrR2H2EzLWO1EvXuuz/4+a/8z
7ZLdX4+guKfDbmeLwrRKZASpTlMuNrA1k6RCJjkQGtfRRJxbu9BHK8+ixykg+Z4xiEafj6fD
6303F6eZzusqiCF0Annuc7e4Vea5EXWp1jjImyFbd3Q+b4BO2MrCeqOkEI8jQ3hUMVPZZ/Qm
Mx1dwa/bBYi3EEki6xbXEAnkoNwQADSCSpUNiJFgWzQ4PVjZXwfdctCqtNDRXHgkzOlBq2ev
gCNdMxp42N/vjsf9YXb658UkC9Zm6ix/boX6RaXiPAEr6C5vBp4pVxYRgo9+f0Z7kNug3IOF
zBM9D6VfEwtREsiOWtrgKkAfUkll2fA0BdnqXfHZ7Iph9hPz1IyRh7+U0X/oay09K+AQVZyS
6NCEuzFfu+u+bl+fTv2yz0DMs23X371dt+pkMdsedrPX4+7B3yVLWhU0UxKHvTJXNZV2o//a
bXSM3CW9R0nB07tku46sF5InA6cEtT3c//F42t0rkf30sHuBJuAdrbXtzCJZUbPXQQ9iuuDc
io80XJXC6kJragJ7Ya6UxiO5vIiYVMvZWJi2igb5MMTXFZc0BrfW5f2dpvKkzqhQ8YKOv1R4
YYVrc0ki8IwZuG6IbC46+NUnNZwKpKzRjA83nHgoMCLgjWgKnpMpjQe1c0JqmuqoQId6eCVt
aUcPfcllHvPVT79vQS1mfxp38XLYf318MnWFoeQDZO3K4+55opteFFk9Z4WuwsXx9Ydv//nP
h7F/f2PNrTQ0V3ErtSyaDu5EroK4M29xnFRag1rnmXGSoMagpaqLKYq2Bolna20Poor7UmWG
G56OkuEZfotW2gHZ3eRgKvQCb8WEAGM/5KkNy5VTwZvWBWgu7IpNHvEMJ5EVyzu6pQqkEQ2L
lIq5maKIBQPNvKkhJx3nkJGYo0BTB3XqGybllHReMYkX1ToqFQjhy6XrJK0L0FXNKkh2G2H+
1wwB6Vbjbj09U22qSTay0+X2cHrUVliCD3D8ETAhmdR60Vp7LH0UCRcDqZVxpcwBD17HG9Fm
P79pVgzacFfwAG7rMqbczIfilO2Rb8Cem2pCQkniHjdYyOUmstO1DhylNzab7iC9JRbFuV1V
MIFHCVZDbUQwYaYS7eIr4KbFT+HQtregUTTU2Ea6rYeKlZYY/Xt3/3ra/v6004dMM53OnSzZ
RaxIc6ncg5Ort6m6lcRVkIPUedkfWSiH0pYkMZU03Yq4YqW9wwwYzEBsO5eKqq7tRQjxbScE
+fZ5+233HXW8KSTSTp6vAOCnEqrzBZM0dSlgmYFXK6UWpo7mPjl+L3b1O2fzinigXPlACcmj
WytcihyRTSfBHLiA3gqdf1x/Ovty1ccoFNSypDq2bJbWLOKMEhMsOIuDFqXuSidduYtqqwpy
d5nyzKke3Gn/xGPU9qhzDJNCqzhmOUqFO8NBK8XxqEjfuWpV8qRFvMiJPtXrVzu8oINE7OyG
StgIc+VyrFVcRg1dS1pov9fpf7E7/e/+8Cc4+7GOwMou7W7Nb0iZiGX+64Kt3V+g1LkHcZtI
u04EP9pa8QBbp1Xu/lLRnXLnHpRkc26vkQbWnoOwccoVVSlx64gaI+qoKXnGYtxLaRqj2XhR
23QCC8uEZDG2uoaBUm0Zd6mWdOPkngaEjdYtZe4cpcFPLWGcr6TU9XCKahxz9IaVpugZE+Fk
wwDv05qKQ/CGyReINE4dhUMQkzjdlkXp/26SRVx6oyiwStBKfJMZgopUOF6rfcmw0xSDmisb
TfN67W2VspF1AfGxD567Nn7oJKpAF5WUcDnkrSB4nttWsMe4omC5yJvVOQa0CmRiU0CHfMnc
kNjwtJIsMOk6wSeX8noEGAThDKF0pCHYiZLGQJxqu18Dsfar24/R/1Bfrp3QIBmXGFjNCwFX
5LYDu+MqIKy9kBXfIKOrUeDPIX23O+iREcOtf08Q1x6JT3ALHNxybhfkO9RCxiUGFtLdJgNm
E2WYX+sJVnROBNq0WE21U9V0lfmiTTNs8awhC45MYkPJAu2NZRCucRbIXTqqJIY/35B8gpu/
Ye0izGj190s8IXdwLUK044Gi4JME3ZJPElVeLx66m8X1hz9O9y8f3OnlyWcv/+ztyOrKNbCr
q9Z+qwsL+NGqJjLHasqRNUkgh1a76sozCx4S7EBgo18NftAdOGflVZgthuq76VB7V9/SGdQI
qvoCkzkaXTDcoK+sPtwW4AxCLRwL20FC/Wi3W6rrVmrj4UfRimzkPnqg34VHZDkUb850ftVk
t4avsOg1GcSlmHUDIYO98DyMupgGreI2lLU8TSnLNkZIN+Mm5WKjC2gQSuWlc9QIFCnLpJ2h
9iDbbrdX/Q47FdxCcnTaHUbXAUftR+HygFLTY8USQ6UkZ9mmgYDE88lu09GVnSBhdyttoq+M
Y3t9TMeFlbEW6nC5KHRy4kDV/Rc/TmnB0BEE5ngfTZ+hYMh22fEgzSZUNR9M2R0idc8nFQE+
+lto+ABKk2B3vDVEr3CBUbR6eyxIxZjk4JziEsfM7dN8GyFiGWgCYQ3k2jQ4H5KTIiFvCzaV
aBRskywuLy4D02VVHMD0gW8ADzoTMS68SzOuchRo/OcueSnLcAekCNwZdKhYIElw1j0sJ2nt
e6dxj2gWNCvRVGi8GedZDfmAK7WCjH6PJK9gFU1YRceNYQ8KsBcVSShmmyBhAJ1ab5xmvW+w
p2SA6qAxJLGWQrlTXFwtwdhkgLTqfE4Ld0jZBO59KVSqCuFt/oCO1l+jGHUKC6tvMgf79oyn
i/NbWjglandaelW8mboLKseJF8B49BuEXj7n2u4Hxr6pub7C5jSo6G90QobmPCrQ4YKIhctU
al9gVgC3AqMgpobgzcV1MTDhkcZJXA+TukSVJQRPb5MBbmumVhZzThfWzoEI2yjrflPoyGGt
q6rH2f3++++Pz7uH2fe9KnUfsahhLZtRfDOglDq2aKfn0/bwbXcKdShJNVcJd3uNfIJE3x00
92WQeMGia4OtUNFk3KBlfNK0WeRv8JmIuJymWGRv4EfhBkKkarD6etu755mhBzcoJZ+/Nfx7
BGYsxGQ3AMtJsL41Jk/figdtWu/RA0rE/SARIVJ1SSrenEvnud7Jn+PPJjuG0d/ZZ2+RpvtT
lw/e2SOW04w7jMsczyYcGsizhaxY6VuI79vT/R/umaNndGS80MciclO+ybihNtdew/h4dMkY
I8pqId+zw1pyyCwgPn8fg8rqRBtJQ2IbqLpsc3poJBaYJp9Y1oGo2x2TY5f1+0b1cgeEgK66
ZZkgCttXQ0Dj4g2OvVLNFKmKHv4fgjVB8iR7i7fWclw0nqauSDEPpAgY+QpNQceU2YWclnNG
i7lcTJPoh3ZTFDmJ38BPuMKWRJeCgrcWxw2KNPgSA6GGsO/dpLfFGxlST2oO3yanXi6lsndv
zF7Hy+8bc/BjEzSUZPkbFLFzKQ0h8TJ+hMAPrxESSWTIeQ8Uumr7BlWF19UGkkn31ZI4l9wQ
gvrSFBu7Z2ZTBTnnjE+gYTwgVu6xlALo4mSI2tz5sQuhCgjRfhMxKa7PL9pLM8oAnA7b5+PL
/nBSt99O+/v90+xpv32Y/b592j7fq+Px4+uLwts+2XRoKjehEwqbpk7QgrhFQRbeeZqFMwi0
Y/x0ziJo9W+Y77G7wTOeTxU43QXUbVX5vGWxD7kdg1LuQ/gqHfUUjRsq2GjIZOFDxGIsmTxw
NGEaoJG/wRU3jqTEwhGWN+6gTr9abfKJNrlpw4qErl0d3L68PD3em5u/f+yeXrDFKVLXTret
//uOWneqjpMqogv61mMrgBvjM4ab4LmDYwUhwEwWhPzKuJuwe61tMlUICPeuytOmaxeGcGoK
JRN9qUpaW290gW6BFMQPcFaOK2gG04bkgY3YE5hQDEFUpX+4YWOlzHxET+4x0udewQKRQ9eV
ZyYoC7SS1LFXzN2TYqf3Nl9A72Q4hF6I6uBg8sHmFbkdt4MUrQ7eNzUkoD3jo7bhiuPEhmp3
3F9X79tzw966CuwtD97vLAcuux3hQVMWjc55R7sM85DDHnPHH/bLFba9rmw1vPK2hIvodoS7
PhaK1uwK25QOkbJYga5V9hxALbIAQk3B3MoMEORhfrst+hbLlQx2ISrcQFxZ6o7wju31q/du
9qs3drvP53hDX7U7Ldyq23Ejzp2auMsLdnzhUhSltEPI6U2H+jl/X8TWSRZL5ljpJMIMsZuo
mxtF8XAzyTzsAcAsjllyDJmDtqNGEV300altmXr0JWqXgkMMDLQvBxfb+z+9hyBd96NX8273
XgcW724So341STRXJxqxnf4YRHtzxVxZ0zcH1EUVe7pBOrEg56guB1uoZz3YPUlFP+YghFXj
eotsRvQulFXoZxIg47bCV/WrySk0VVG/B3cvrhGZOz/Aadofd+kg+klrnHuYjNh3+RUkLzlx
IVF1cfXrJwwGq+oru1vkUL+6D8XYItDw1SUmc7v53AnScjcYDO5A/ShMbzFhf7qhBziXHwEE
5mLe/Hp2cX4TuATZ0URVnI9vO3gEYYy6NFXSIsEp5uKWlTgKm4dG0IkJ5TJwnNBTLMUd3u1N
HBgPtOXL5dllaEjxGzk/P/v8xrBgP1lmq8wKujXyx2DNfGUrgYXIV5V36S7Gj/CyzLnvDD/x
D1AQSTJMaOsLx/BkpIzQ9uWCF4FD8CsIqEpSYB6QUqrm89nJPAZoU2TtH/pLE0wVxEngptXQ
yISNyHBgqPrRrMXpvumiDf7N6+51B8b75/adjvOloZa6iaMbXw8UeCFx2fT4VATugGm0Y8w6
YFnZ75Y6qK5SojxUgYdgHV6k0zyKNGQJFFbSm2zMjYxSjJU4ChSHNZbKFOmJ4POdVzQZQxOB
FHQ1Bv6l+eQ8kyp4EmMkfKM4mRbVMvJpfAks+JKO+b5Jb8bAmCf+RXMFTm9CmJgsR1fsTYtp
JVykExyXDOFXPWFFpO9/LGOILhL3iKlDdHOZvM4LXjXlTYo/EOiIWh6uP7x8ffy6b75uj6f2
Awnx0/Z4fPza1oLcrRtnbl1WAdT7We/rai1CxrrOFBCWotCXRz+Nu0xvxzBT0m2BLUB/nGcM
xZRaDydWofcZHfoKYSbjCDvoiaWRR+C7UXZ/oXMJTaCzNeebMgpDNRiDmXfmzgcULWQcPrzq
SPTJZ4AhahfUx/CcylEQ0aIkXQdPdXrmSMEC1yA6Elb6R/1aSCR0sm+2MLOrvkls3TBKCqG+
dsXVlyCdiBC8B9GPalGmOQRfK4iygCVk3FX7ysnusIONnkd1eP2k1m6KI7CgUd/rcyP5vPQ3
p4JAZMhdGr3pvC/8KepCYBNbiMozXFoE/l0odUvlUiXV6hQGkIGlKWLhXHxXvxtOc/XCujFp
Oebf26+pqR5c72YhRg+/FLBaN1EtNo37YapIu2D7BeLstDueRoFKuZTd5cE2Rx2Rewj7JeOQ
UOQVSTTX7dPu+z93p1m1fXjc9+c91n0s4gWM6neTkJyobymtgifLFcdes1Zc0G5gsv548Xn2
3E7hwXx/5+Hw+Jf7XHvJ7MO3q9K7cRCVN1QuUPsVkQ2oaqM+Upcma3dv9ZhFskansCFeuNF9
6GOK614PiLU94EdbmbUAkZ1bKcDcI/jt/Mvll05UAOg+UJT0AupZVeSrGI3HNWo9YkdkI5Bz
y1ABYpLF6jBHPX6xT0gVLs3ouNN5NQLFY0loEAQgRKqv2NmLorHxL79gn5BSOJYy9a/9eTYF
zsdj5P4Y9tQhrTMfo3IGprloyjiPGXZYbrVrmJ2+2ojQlARPZegJtBG8+haDefWLF+CR1bdU
GXM7JAVTU5VOFNTBRjVwhKLQZe+MCyze78lGNbtqvURvKUOLpa3vQlaU5O3nKwawKt9XtVM9
v2UVzZynKB1EPd/+P86ebcltXMdf6dqHrZmqkxpLvskPeaAutpnWLaJsy3lR9SQ9m67Tk6Q6
mZo5f78ESUkEBbqz+zCZNgDeKRAAAdCCZsrF1I4xUCCcFlWBRH2dEXF77+8PoFMG6FxQWmug
8jsXUuCl9ogpBiuZ5RXE40PSapysaiSCbCJyIConIcQRZ4c0JsggF8+UpyiNIRSaqm4UtWnk
YLFyMUmTsnk6sBF9QVOMwKC+o0I5j4dZcyCylWsNkX+1F5cgS56DbO85hXTcGYwlIJhDVOYj
O5JgRDQJJFSAzZjT2DH3ws9Qvf2vP1UOt8fn/vMPKypxJC0yQd/CjxR5RhpTR/xsJe26xZBw
AXFrXFbSlScCWVZj3vV5r6RcGstjmzKVz7qRFwSdSyXVgznvmJar/ZmWqiR+vSEeC3GjpVq8
XkWb5jPXGWdOrTSW1EjBRVAlN9Sp5SY+JmE2WwMSXaHKsfU2GmWm/T23xUX9W22WGZCX9amd
QQ+1a4LZ1e7vKaMOkqJ3/sTCCePISgS/byydQpcqbMFTmWR3NhPMavAQREmUBhgYn9v26u3Z
QAb809GvhrHtsYlgDxcRB+4zRgK+TMi8AhJzTDiquRfHVFlpjUz/8HK3f3p8hlyof/7515fB
reUXSfqrESGxe7Osoi7Xq1XPQzrI3lAsly6FhS940lSQOAj3bQRDUafbbRjI/zMaaugtHeOn
xmVZlAWTCp9Psed7xH6oKFyDSkXbD2ltDEjqXXLVUc5dlff6zHKeQkbUzvU01fhCOHYwuTtx
fOue8bw6TzmSZmL4MLgkYXYqaS1M2iPSEJWqrU/4PBdinbz5+PDy6e73l6dP//M4JjRVGeWe
PpoW76p5RsiTTojnjcCTY2qLGt9ZDbC+AO5FXzC2EF6Z07eJ8gNUje55U0g5J9MvVgyTtH96
+fNvyNMIboO219f+osaPpL4BpFIGpZCAfkJKUaNhYyNWOu6plEpC7jpWk2i5lnkeo3iOiW5I
S2fvcHcYI7NmpdopdjKqQdRVmetonAO11kJpAFIK9QQTjCpC42oIiACkU1ON5HhF5VHOFRkT
1zIZiNWrG8Qij4mF69OgoKDvC4wZ1mGTHVCmLP0bcxkDuwQzUFHYZ9RQ1k5WloLJ4Si3gdoj
e2wtA+Q+K5NsHr6CczPOvySdbfWv74gTmyI2eDxdKsmXEp0Xevq4paJh4q+piSxtFQZ+ge2B
s9wBFvASA4UQvNnTmFPczRBFi1K2yJ9q0QmWMybZ+/bw8h3bXWQh1mxVcj6BqrbTD7qoak9B
5ZKpTLM3UDo2Cp6U0QkY3wS4/6iK/lSa5Nx0ssEZPRx3VZlf7Y97PnY1JSf5512hoxxV/vIW
nKGf9cmWP/xnNklxfi+/DeFOuBqGp3MK1zfWft+3ODLW+dU3lnWIY3yzT3FxIfapkxILCGh5
Gtasqj3JOCVyzM0ovzptTp1tooYVvzVV8dv++eH757uPn5++EVY82DZ7jtf+XZZmifPiD8Al
23EfAjLlwRo+5BKeI8vKffhowMTyfLpKKQDw3qECYe4hdMgOWVVkbXN12wKeFbPyvlfPjvSB
pwqHLMRDcbCrVxqJfq6RYHOzlWVIzRv3jUAhw/kS8BUBixweYTvFjERShcqRvWFc8kLKe+kc
LsUTNoeeWp47HIYV7tBo27TieLHQ0SvTSzz+3a3TSz58+wZmdgNUCawV1cNHyJrtfAIVCMAd
TH6NLUPqWzteBTpBLaAJYqdxciqadkp0TZHkmfUQm42APaC2wJTT2UZXe3fyBgxkA2ZytinB
waY7ZAUvua8WUE19KfUV3UyMnqA9K6vyKgVY0mgCZDlrh+Ufkke+slz6xaPH5z/efPz65ceD
inmXVc2vJ1B/RN4w35aqj7oL9rfXpi5M/u7bSqqf2kxg5/c02KxReaEBG4SRXZ06TkJ96Gsd
5en7v99UX94kMDCfwgIl0yo5WG79sQ7rlOJh8TZYzaHt29U0k69Pkt1SKXWJ3s0Tq7hBmQHO
M3mqWJZIJfQCF1f4JsJDYDJCIhZwUYRu23bhGN+j6pPt4e/fpHDw8Pz8+HynevmH5gJy1C9f
n5+JnaCqLDpOq+0jBWz72xTDdcKsU8XT9494FRU9/CN4QcxOysV9VeJH8gikPnLt3FE/QZsq
lWnxOik8VEdOv0UZx61KVTwbcl4Dg/hv/f9QKsrF3Z86CSwpaCgy3P/3UmiqRqFi3MOvV2xX
coodAUYC+kvet0c5C0fIkOt8toogzmIT6BouXBw4xRRzkQVQkCQn5t49omq+IWIer1LhRepZ
2lpfBWbrUmo/lbz1vF5Z7VU+5LbJMruCPmNNfqVR91X8DgHSa8kKjjow7h4bhhS+StkL0e8i
tbXECiI0pPJzBuHUzt+sEWDyQzCw4+iHcSa9jTWed0pMKnabeMjOXp7yHH6QqzMQ5VKuvkmQ
NrE/xbtq5hV8415RDwpqKgUW8BZI0jNdA7xfBJPRZy19JWFcPl4bozMCbe48F9mdmMeHArzf
e8yZgNNxDqTmjuocuaClsA+aTlaKqhHyexPL/LwILS7G0nW47vq0rpD7jgX2mFLTU1FcnaTr
idgtQ7FaWGaMrEzySpzgTk9uSGwqYXUqdtEiZE4uWZGHu8ViSU6JRobUZfgwylaSrNfWu0oD
Ij4G2y0BV/3YLaxrh2ORbJZrS5BPRbCJ7Ey7jvjcwdNWXS/SfUYvZX2uWclJr5nQXBnqXPNZ
DWI4EUisMXKPhnRApMHn2YElVOyOwRes20Rb5LpiMLtl0lFRYAYtheE+2h3rTFgTZXBZFiwW
K/sIccah3399/Ofh+x1XLzr9qR5C+/754UUKSVNg9bMUmu4+yU389A3+tJ8Q7QVSQP4flVGf
A7bDMYhzYKA41KPvEf/yQ4o5kkvLA/Hl8Vm9NT0tj0MChjEtUg44kfA9AT5LLoigE4+pajAg
zhjI1Mjx6/cfTnUTMgFbOdEFL/3Xb+NDRuKHHJ2dQf6XpBLFr5aQPPbd6vcQeXVjnsbtkhwr
pHbY7Mr0VfBBYJ5meVg48EMr7MzIDeMpvLZsXzMK7b1ml9HPX0yWH4Ap0+R+Ps+qB6Zp/bTT
L3IP/ftfdz8evj3+6y5J38iN/av1+INh+gI/l3psNJS+RBgLUQreWNZ2Lxpgtm+pGsfIYWcj
VNoJKz0PwyiSvDocfF44ikCAL46yitMT1Q5f23dnmUTNx4XBVe4TjaBYOOC5+pdY1F7Aa+ge
eM5jweaNAQqeJIJ3zX0Niqa2ujrocc7oZhN3UffR/plLj+SZTW1wJIHQsi0tsIy52MgUw/pW
mSfzbPCeAqxJtGQ59UdB+iBcUCavAbtYB0QhOhjUIBPboDPAqmK3+OcfoiqDIWMQhta4PKLo
ouGCFhggxk1f9dhCCQBBtsEgnfvbeB1KdjqdMoTtQ93aty11CisUfBvKSxRxjBHjfGw2/ogd
cxVMC6WzzzN9kkfj0+9/AR8Wfz/9+Pj5jlmvb811xHht2zzWS6VVmAlyEGCiohBSLIppRNak
TtIuFSsWJ0Uv9uEcAWoCAZXcjL8fw+jQngZ80W7XS/oZzpHkHEXZZrGhNsRIA74ASve+Fx+8
wYCIarfabn+CxHEuoMii7W5NkKhud11HDntASvW4ilke3hjb+4RF9/P6IYNRm91LNsnnSFGI
xIoLvIGlx4cojK46G8SZS0VbZP1ZJNulHApl6ZmikH9yc4+CB/hCl+77N+esTKumXyYVEuaN
GXWZrLe0qD0RRDvPVJuqWc4SsN0kyMpjxMxW+Jw+htIF++DuvBGVEl0uiyQnHZ7tku9P8BUx
utomoeGnpmqQDKUhUhmPIvJ1W6uwTgiN5zhe0VMrGQJcr3tcL9Q7w74HVKcGE5ZmZZKRI0nY
mZ8KGiUr5iUapbbSj9uH9jKQZ5PnWeCUjlW12sw+GAvkpI0pSF/WEGFUMtkDcChx52Re0/70
jrfiROyKfXF+F0S+AC9T/FBVh5yesuOJXTJOongUrruORsHVFYkpWCMlJxQ5V5yBLdzuYSHL
sLJCHLDIO3GZiTM2ek8JIXatkvfiKL57EUVrcNqknKyckhW2H7tYkRX4ikfAe/RJlldDhM7t
JkrWmioIHASTlFVBrxm+WpJbuDtk/7f9FC13C2Izsc73HRiC2g3QnnZ2e6x8ccGm0Vqq5vD4
ODkmybhyOIztXsnjbAthBifmyWT4HiJaMidgaXLNL16dh0ZOldYsCByEfjUkSrBCnHD4lugO
cebaFomSWfaerrLKWbPPWUMvOZyyqLki2QV0FI9ZKkWR7OhAeahuFwSvsA1RJeAF0dEnq2jV
Z4B61RaQR+P1WbiWVS2u2DvvkvRdfvC+MDKUPeOrUfmzh+CDhJMiuVXwwj84CpCG9Je17+X3
kYB+5N2qvOMNLWgAIqzJ21olgTsv3ykgusPQkAQeceUoNahG8DZm6ILQVNCjV85sqOMajVDg
kdZknurGF2Y67IemaPy3e4A9crANuF+qTYFkSwVR/LTg9v1efbxiT1UFsByoxUVC7L7lWQpP
4B4O4PJ3RDtE29Q5vwO4LxRP7G1VNuVl7zQgZTW34glnpDGXYEB3kdQHNrGpclRIo8WywzC5
/FvQAFxgtCWAOm5ymJhJ+DKCmqczCZeCFcOVGZnJHXIqpSx/RWkdLaMwnBWS4DaJIATBX2wV
4Q4o4GaLgXveZSkG8aTO5R51mlRCSt9d2NXTZg4WtjZYBEHils271lPICDi4AwMwWBwchJJA
5jCtETqNTojWN02j5OGWLdWLqyz3bsb3Qymi1kFBdOo0p6O3Sjghh3FQ9jfQDNHIpYQfLDo7
G5JUleR25cls8QaNka7aXMkc5OcbNvCvxRLqGv3oY5HiJzcBmGZwiZth4DzLGkCLmsywrlDA
EB2OVNcVyoECgAzXSb45A3Q49xK0oKyzGKS8mFs71ZpA+aJEfkwwbnT0tl0cFAJyj7QODIL9
1F+bwSgGdxJvvj99erw7iXg0n8MQHh8/SSUdHIoAM4Rms08P3yA/28zGf8ntsFX4NeqgaSE3
IDqcbaznyhbTFB6LrU01cMFXCRMuEkpnsWkcLchFNcL2ywNDNXZ70JDR059ozFAkljggddUC
23w1BCI6BT0sQ6DCR8D7vypl9zxv5NTrlbGJvTL2Sc8bOCaPs6bFVvoB1ovUIx2MFP4gqpHE
G0w4UrRHXsJ0UozzAo9PY/1Sg2ado0YLidxubNCGARd4dVMZPvtKY419xSV/9FLSR2wZLiB0
WCTNluHawzfhdkOk64tN0HJ7dwfhOnB/q4bwrARhRysmEhV5UV41/6IY7GgxlNIHmdzd7vaH
a4r3oY1UMllWllQlRmZv2NX+5Az0ki/XC3QXMsVvXgSnNh1Y73vYZQMnvTwVrJP/vjw+P37/
fhe/fH349PvDl0+WW4f2FPiiXna32e2Pr7LmR1MDIOy7CWM5fbX6cbYYyrYLoXu0jSsnAwCt
PGWzOxYLt2f3WR6TKDVjjqUYQgq4P+HVEJXmcR1JSdPo2bYGnqXMGuf3c8gY7Wruz7/99cN7
T+2Em6qfTmCqhu334KCFI/k1BlKhoNwTGixUcoB75A6tMQWTOkxnMGPIxjOs7NMXedL+8YBc
gkyh6iQP/HkzAxxiE20d0cEKKbhmZd+9DRbh6jbN9e12E2GSd9XVcSTT8OxMx8IO2Nky+Fx5
dYH77BpXOgZxMvEZmJQp6vWavBzEJJHlrO9gdhSmvY/pBt9LXWJNWxIQzfZVmjAg77BGitQk
H2o20ZroYn6vu+jCseaPwGpTZlShNmGbVbAhRyxx0SqIbg9H797bNHkRLUPaKwzRLKmUo1ZL
3Xa53pFdLRL6tJwI6iYIqZvwkaLMLq19ZTMiIDEVHGCCbFm01YVJLfRW1eJU0ktWyY9+Ra7K
Um7PjsIUYd9Wp+QoIQS6827fhNVB0FE2wWmOWnkSI6dWiyOgoxEAksNQt5UaNwbwOWVYXeeZ
6j9tTlJEcVKsd1sqd7jGJ1dWs3ndGcgBtMujJjiLrutQjI0Cm+/GqU0qYqxWuqsvZN2lg2Ob
PL0Gnglvt1DioSZQedaRBVNDoN6eJVniearbpuK1I4BSVEdWSgnB86D6RHYfyx+vEdXwgjoZ
rmKI9EaQIonUO1buxlIbQR8zltVgAoKnVy2Ff46/PZuCpdtoS13lIqJGHnMBtkIiPGiXfdG1
3lZOkoXyLuGU05dNGJ/CYBEs6WYUMtz5GgFjS1VmPU/KaBlQUXCI+holbXEIggXdWHJtW1E7
KYQIgiEHgpdi5fM5sklTtlssV3RDgLM9chEOvh47btRGHllRiyPH/nE2QZa1lACLSA4st9OS
zHGzYGNE0iVLnVyLQBL3tjb6UFUppxguGiNPMzuRkI2TupHcMJ7Oi424bjcBjTycyg/+Wbtv
92EQbulv2yakPRIwiWft1AffX6LFwtNFTeD9JOVhHwSRr7A87tfeZSkKEQSevSi/8z0YG3i9
8k1PMTueqKUpus0p71vh/Xh4mXUeLR21dr8NqGMUccGsVEktvAuaSn2kXXcLOguaTar+bvjh
SBkHZoQX7uPLihd6FjZt1c3FDcZykbKe537TJoMDBoybleBk9lS8I4LlNlr6WlR/cyl5UxIm
IhSJYgiebS3R4WLR3WCrmsKz/TRySyOboreTCaCPneco7Q3GCf9nJNogXHp4r2iLvbfBLtqs
fYOoxWa92Ha+uf6QtZswfG2iP+yrJvHMYVMdC3Naeo5S/l4g7xUjqHL8PWpoFNVFJNesKqWk
6xW/pCARrGY1aqi7lw1OSQ1SrvYxDE0WFyywY1qMMrzsFnKIrVY5nJoLUfRnHjesrcjnaIzZ
oNtu5ULocc2NCoDdLeUhWrec6L0kiHbh+pVZMZ9VX1+asbOYoJA64noxr/9Qh5QRbkDCxbM8
+NBDLBMqzSALN41TE0OtBlc5YtqMdooYTQqihvSlivIWYde+293A15BiWuq+t+q4Zn7DsaZI
imBxq5UmO5xy2AVmGW+StqdpmfxaBny8YRChFXWnsqtD+b3UpC1bk5xIQ1nN8gJuFP1V18k+
WpOqncFfCs++AMyw9Hjg99FiDW3qr2C2DeWWaaqWNVeIt4Bd5W1cC6r09wS4zZLG6eOsn38c
LO3yJcVUFBhz7WFDMCxvIjDNh9LmHG7keuktQuliFt1mPdDNRqjQWwvttCNaMA4EXo7RFHzl
HIwKhPMlAUQUsQPZ2+7JA8Q9iBU8TE0UmEtvp8o0kNCFLBGjMjDanVUj1+i5FH1f+vDySeXQ
4r9Vd278DO6w+gn/4tSiGpzzuBahC3VevNNA43VMG1w0icQV+qkDt2yTuAVdijq+TaAtiGTj
J2fEB1ZkeLADpC/Feh3Z/RsxubMC5r6DmugpZI2w4utAjs8PLw8f4YJ6FkyLrtXPdibYSm6o
XGXaKkXOnGw853YgmGDHyxwm6SZwH/MyRckdTiXvdpLvttgzTkd9KrBncVkOL2Dp5HXYGF76
73akDui5MFbpxKTUWJIPEEEgOJqnPJVCVc9ObQV55SZ4mp11hPp0nZSd74tsnt9BPL48PTwT
3ld6bCrqPrGZp0FEIQ4FHoGypbrJVLIsK3cS2rQD5R6u6qmB2kTTSpJ1eEzLNkmhNJD4lXbK
Rjm7ircrCttIDY8X2UhCNpR1bVamngd0bEIm6kxOz9nrXYvm8/IqSdOGUUSrbIYMMqX5UnyU
X7+8gWokRO0FdedJREqbqqDTOa3zGQp8zFjAG4sp+J57MggOFElSdmSw4YAPNlyAcku2P6L9
GHwYGqxh7+9adjixZsbD5xTDIP09NQVOzD13MA60AGDB8y1pE8XslMJb6m+DYC3VV1/vfD1z
yY17Vy38rt9DxQ1lzDfIvcj7vCZHOKHmXNom4SXk/ffMuUPxMyNLwJ9apdLkB55IhknJmoYW
WMaHYKnD+ccMRIhTuiWStnFTHxsUXNciv2ILrkpJlm6OZcsHT2XE8G8lLsU9uCxIc/xcJjga
yg9d+WogKVFhIFeCzhvpq1J7RWsnqj2zbQAKbfvHaIDAaZkV8AJP16QVfYuhewIaWrWnnpKS
+PhGN+Qp3kAoAzrdRmAPXFoKPc5RNyMb00+bXLjqKYaPhHQy7aJrmairX8+JA/l44QWd1YJ0
WJ/QK/vcTJoQqSC19QTBlDvS171RfmaXWXgoJPhWcMgWGa43loyRyP9qWv6Qn39+ddIkTC9D
3OiAnvzmJCRHqqp2TLur/QnChPDmQApWmPTqnhMyJ2Gwm4pOwY6SFPlXSKB2u9e+5X89/3j6
9vz4j+wrNK5SkxFHGhRjTayFaPXqVFb+L2NP0uS2rfRf0emr5JAKF3HRIQeIpCR4uJmLFl9Y
k7FsT2XscY3H78X//kMDXLA0NO+QeNTdaIBYu4Fe0LyYI39tgS9QxeR/AuddsvYd5fl+QtUJ
2QRr7MlbpfgXLUxL2DduFFYcCQCYZlJBs6VFfk7qPJUn3c0uVNs0xjsGMRRf8YyGaZVY8A3G
mDx9fn55fP3y9YcyN9jBta+2VBt4ANbJDgMSufUa47myWW2BICF6uBGYpb9+vF6/rv6GQLxj
zL7fvj7/eH36tbp+/fv6EWxu/xyp/mByEwTz+11vNxy4+rgl4Mmhe2ooAwTJOXhsa1V80ZBY
3heNxEiUJJGZ85dPfZF4QiRikZV3ILjLCjE1JFg1mVxIMDYCSBIcPva06DJtsQs5Y1qv2b9s
V/nGTleG+pNNFdb996MlMxIHgNcmImkxIQB/LgGajlQtO+2KqZbq9YuYzGMV0iirQ7gbwwFI
kwmdONoU73pMyeCoMSqBDhoD/ZiDKTI9WOwyFxKY+W+Q2DZzeU+e2+VLo5RAKgMGGQPxKsrk
SULgMleNvf22tex0eWjVH8oBIG5zWqpFP1zAT48QnWgZN2AAx8LCsq4VzbO+kYCj7OqRXMgD
dTtVYJ5bwIdJAuDtecelDb2SEcl1c8zSdSEZV+Nc52cIGX7/+vxi7E3guPDw9PzwD3aKMeTg
BnHM2Goh+hYRwig/N0c/E6Yw7CNi4EnmZJtcWiqnnUQPR8muZ8XUOxrgxP7CqxAI6Z4CJq39
hJtaRVo/8jy1Dg6H63HFimPGFFjYzwlbJLXnt06MlWxpuUeF8Jng7AayKcAM74rdGeMo7uLR
lTOR8JvzG3UKd2ezTjYFDiXZKwth+kaQyYgJT9p1lLuBBbFxbAip+2EmK+6AI4DHnGTi22EM
Shm4c9zfaqedRlMR2rzXnffFrLAcn/wEay+tnKqIw8ZpNguFItbm1/vv39kpzpkZuz8vF63P
Zy1DgAgcbJzsQm4UYRFsLUtPpNY6Zth18I8jmwfJLUbOUYFudHM4Dj7kJ2xqc1yxjcM2OmuM
mH77wfUig1NLChKkHhvnatvf6OpEfT7iYHGi2wqBs+ZuDNcxSZj28ZjlMQ69/vv9/ttHc5wM
E2IZqsZQHDFlrffoaZjkXqV/wJoV1eMWtHfGi3lnqNpWlIv1vj4eIxRps3iT0+m7miZe7Dq6
lKJ1l5j2u/R/6EZPn4qkoR+q0pzt4h3O9nm6sMiBeR1HQRgg3QX7EboLzt0Jj+jWvuS7qMF2
tM+18xU2EjEWlHHBx6E5vhyxQU2COF68NWpfD8BA710G3GyUyI7IMOndwQ73HrsAlfObnNxB
LE4+9u4f/30cZdbinuks8tgzyiljbeutYyUiv4xzT9hVykKhbuILvN0rQjTSFLmJ7dP9f65q
64SEDCFiCoW/gLdKCN4ZDN/iBDZEbEXwpB1qth6FwvW1/pEK45ZdCg1qcSNTxNZG+64NYW+S
7w9Jg789qXSYIatMoYg1MiKKHRvCtTUrzhzMuEAlcSNk1oyzYxZD4PZwIEdZxuQgiM+s3KNK
4FFkxIUuicwaTkEngj872yW5TJx3ibcJ3q4Z4YdQzcevFTffri5ETcbz04CDsdw9I72ExZQj
eEvUOCh1Q07P/IJD9WyGNUQ6ALxyU8mNnTTwaLgBa7KvDfBEvEw0vs0KOP60ComoDPSIBM0R
AlXAWeiEygzeko5tZxdIuR5v1gF+Xk1EsABQ/yGZQF46Cty1wD2sPe0We5OePoRh5UIiRFFj
KTSx3L73orP8QqYhdBMXHX1I39/snYku7Ya+hkR5LUyuW70FlutYb2lW6xLcVe3dJgyYLEfO
+tbQjCQIW47x5JN96mY+d2XzmAkBMo8XmXD1tFzY8OFB2HR+KLv+SvW66yBCKkizjl/iCZIw
CNHCXK6S+0nFbbDjaiJho7h2A6QzOEJWF2WEFyCNBUTkB1hDGIpJcehTyjTFi62/RpgK8Q5r
x2hfF5kjvCf9PhMb9RpZhU0XOD4yyk3HdoTAhPdJ6zqOsmwPJ9yzn8s3qjfWCIJ42R1tLWZj
E1FWZKzKEqxUxl2fTYGcsEkLmTIMntUO3xxHNGTEAN8giNxjydM1kU7pivcVhGPO6uFEW0sK
QKTEjtBG5Ne78W1yAZ5Zsa3FW+BN1qN0IFK2oa+8Uym1Icswyvj507BqgQCCQPH/vVHR7Q94
o+GyHc+uyd5P5W72d1b0wl7qRsvUaw5uSOlJc3I6XMcHXRNiZNmZEWV1IpeqRwMdTDTiAZu/
GA5ZCRMvRaoAH0/+sMu4yXN6JuCXP8bj0un+9eHLx+fPq/rl+vr49fr883W1f/7P9eXbs/qe
MPOBPL+iGhgPO0ObZ3Rb7Tqkr0bTVRwRYgihIy5gVRGc20ua5MADiiQkt2Tcy8qd526LBH2T
X4g+OOEGG2UhbOEIJm2ZiNF+BGv7B0obEPNvtGS8SsO66oQAmzLoQjdGMJCOAaLdYu3gxtg3
GjGZ0ppcxe0GONFINYEHoueqwBa8L6u2pVvN2KnFXoi2SUFkcgms/hpDrleJBm53OWkPGnDM
tgph/YakKC1YRRwRGDkgA38F/vTz2wNPSGkL1VbsUu3VEiCTwKxBmRYmWwNPMOUyn/W/dC21
zGagJZ0XR47N75GTcN8PsA0SgQEN1CFP0kRFcLdmR40DzeHpJojc4oRFTuAMuTm+Vokw0Vfj
6u3S5f5dqUFAbb7R0LPz9bxSjoP9AF/2Ez7GnhBmrCwjLUB9ILgQfkaAsgQOxcd9TlMSZoyt
KWIXxIqEmBg6IhW3Hd6PiesryosENMfiQMM1W7WqR/2hg4fllibKzQpAWXm28i2t0S89ASb8
mhwMaIwkB4cOdncuJsgs62sTB0R1NMrGgg6MBSTg6O3ngt74+tRl0HjtI8yYkB7ZeYFmjxba
4C6uCx7NNArYLvQ3kda86ZhTwbDT65XXyY5p+GgwC15kkvSVQk0SdEFsLXMXyzeLHCROJhXY
ZgmyTbZ0HYVnQ47iqCJQE0So2LtLzCYGfq8kiqMP0GR7DhzHqJBsfdcx91WVY1egEfk4zngW
AmgHKVV9PziDeyVJLcEadpBGz9+sbT0M2nSs9SbjnBe9CptfBCYplyl8rhOo3pBcPXSxZSM5
T8oVjc8FGFTfQSUNU+8G+AbftsZHvPZKInG0rQbsrWKGb9CvlNAe0noGxbZwhmP7mY9Px+6U
rx3/xuRhBKGzvnlqQ/iyyEfXQV74gXXFLuFY1Pa+L87WTQ55JOcH9/zmZQLNI4Sflt5aBZ6K
wHU8E+Ya+zB/ArJvghyNh/cZ0Wv0gXJEKu9QC8z8Cv15aoGhtNOrlbzXcYfgNLKGmJOJmIBg
m8qj3K3tjroJBVchxtgZqKnLTZF11hwm301JmZjdObUr6wUh4t8eq7wj+wwjALPiXtiat71m
GrRQwU0AvwiY6ZAeWciZeLDXVriCLPBMEQsNCOJxGGANNmV0CZcG/ibGqyUl+wd7i5RINEFf
xcjivoTRpOkFI8nn5nhpAqqKCdCaZqETw3jqatVwmNWuNEdIGfhBEOAMLCYskisxl0uxdgnM
MZDvwxcsbfON76BjzFChF7noGLOdNfQtU2veJG82GM7tyLVwABz2Wi6TxJGHjh0/D9EPWk5K
FBVb5mwuTorbzWE0YRTiDCZB/CYHIApiOwebRYNCFIfrjZVDHIZ4FDuVigneb1azwReHqQNI
uFGj0nyJFbyI9YGi4o1n+bCkdlnP4NKsRMak/zdWIJB4eAMm1QFhbJrkmSS7/gNk5LQwOMax
8+bIcKr49gTgNBtbNag5xoLniTlUQ9sFqWkqEkLXVySUoREtuNYraoLmsFNpWteyQ7RBEUfh
7RXV5ntIE4Fue4bMIKGYduSExFLvJY69NSaNLzRM4g3c0LfM10m1eItF6PmhZSiFCmGJvaiT
RW/XNCopVhboa5pG5ProjmC+nGk4IaDgOKFnIM06Wox8FwpdklUxATonZil1xCSG2g2Qsuog
BrUsACaG8tGAkTueVzunqP9jk0zxUWT3CEgrlCCBUxq4WbDAQxT+7ijzmVsDb1hVeZlQSMOA
gpSXylb6QJr6dvGCCax32xRt1rmoUTgtqtLyfUVhInjvHfXUmk0iBZDB23ag5+CQetpHUe3J
VcfpuTRlPPtaa8xIMLcBp1tLLm3YlpqMFB8sUwdq31dNnff7G1XQfU9K3NqEYbuOFUUjHrLe
giyPoy2bXEZYK1NLGOdm9Eu1Yi0FWX3nbXUebNnfeQB3bg2kJZjjDwz7l/vvXx4fED+LVDb7
Yz8gLhwdUtlpBKBpPZD+LHkELk+lgOWG422W78D8B+ktILor2tGHTS++24KT7q13VKACZ8eB
fWU6JxQwmpjI/k8A22fFwF90pnq19thwR61T2uTA30xni+nrt4fnj9eX1fPL6sv16Tv7C3zU
fij9OvpQRo4TqtyEt1buhmsTXp7roWMK0CY+30AGhk2yrUG8xaQpFGfbsZwMFnRJvfqN/Pz4
+LxKnusps/bv7Me3T4+ff77cg7KvcPifCig9u8+0vj2ygdBnRJ/iCwRwTUIaeKg8pAXm/TST
5MfU4Ds6fO9rzOweCGpSZnPy9PTxx/en+1+r+v7b9Ul5y55JBwJc2THEZi7qvLJQYu0RmJYW
tcWrfiHaZfQCNhC7ixM53jqlXkh8B3ssWcpQiCBxB/9s4tjV1sZIUpZVDk6rTrT5kBCM5F1K
mcbGai0yRw05udDc0XKf0rYGk5i71NlEqbPGP7bKaZGdhzxJ4c+yP9MS09WlAg1twdrqMFQd
XMJsiIVxm8J/ruN2XhBHQ+B3mKKxFGD/J+w4p8lwPJ5dZ+f46xL/uoa09TZrmgvbGtWAvUg7
GnJJac8mYRFG7ga/yUWpYw+9YZJoq+SOd8S7gxNErK0bVUuSKcttNTRbNmipf5vpmOpvaMPU
DVMLv4Uo8w8Eu2tAaUP/nXN2/Dd5xoRYUpAu1Bm9q4a1fzruXMycQKLkMlb+nk2Exm3PcvxU
g6h1/OgYpac3iNZ+5+aZhYhCJkt6ZtJIFOEkXdPnl6Hs/CDYRMPp/XmveFFr24xcftvQdJ9h
PGeMslPRKVnCavvy+PHzVTuQ2ITPqz1rKynPUXzWThjuipqqObr5wdoXW7ZvkyG15KHkpzPb
3bDocgpRAYGeDrRuWWel9ZnnfM6GbRw4R3/Y4UIilINzr+5Kf40a/YpOaUgK8djjUL7z5Gc3
hUGiDOHoCLpxvLMJ9Hxj74LEO+AlkYQ++1LIGGFtbFe1B7ol4sUkCjFbfIQsMmpkW82uXqNv
SyO+LcOAjVeMiBckPUaB61oQspGlVmKUoYzJac4smUHWleRIDblwBGNmdPKsbJJ636stEiHB
sInPjoOs7LigOLzvaXM3+xPvXu6/Xld///z0iUk/qR75bLdl0h6klVBUz52mGIxfjbLilWzv
H/55evz85XX1fyt2hlmzqMD5luSkbY0MmIAxPQ9BkeBe9nqpuakLxei/iNk4zTT1CWU+X+Ij
bK0+ZwsJYmogVVnEm7U7nPIMk0oWuvm2AeFhT2mi0MRx6FgZxLEl/8hCxS/kHSw4q0azwTox
r+NAtsxWMMoL+oLBjKLnNmtvONJIa46oUk1H1k1Rjj0OLUTbNHSdyNJRTXJOyhKd/m9M8qmi
I02zimfTEzqUnMUtLeacUEwZ+PH8dF19HLcS8UpoLhk4YhIzdBkDs7+E1SeTu6o8h4/A9pK+
KC5mtCsFzP7N+6Js/4odHN9UJwjks/TFW62f6AwVe+LfVn0ppyXUfgxTdAMJVCeFCjicUjlC
PoAacipoqhzWAK7aFhRpzOBSMMbqgxQEYG5WMFlcHkXAQYQjCKvU/uV7Mny8amBCfDqQmmof
wETVYdfqjWOK0raCtCkMbcntppLRskMjF0Kb1efjGTSV1utus/c9WL2i8cig0vOgZtoFhnPu
L4UVnzHW1hO4F7JUUnQ1Oap1TPH+3DBQrcg4fd2v1Yt/EZoj/YMr3bIqPsOUeQN+YJCUL6/g
yuFD9le41uZDQonaoOO5hsTgnd6WOiV9StnAWb+8VROki6bS1FzpDChtFTRdvK26Jiv33UGu
m+FtF4g9cMcQwBM5JUUszu/XBwgxB2UNG1soSNagZKkNJEkjR+OYQYPs/sehkN1Ha/6g54dR
kT0MEDJheMdk+Z2cgQBgyQFUUR1G2a+LXnFS9fjLMiALAgbtGiO2NFMKIcI1/vx+0WB/4VlX
LfzZsO2rstGcOhbogAamg5JZ0Rodm+WZloCcQz/ggZjFBCi2tNFm2n4nS10AYQy4Tq+zvrug
GUsZ5kTyrqp1+iPNTvw6wdacS8OlVr0c5KXGL3841hJeHXDvyLbBZBjAdSdaHkipf2oJUVaU
GPYAzxPNK5QDs1Rvap6V1RG7reFIplmOC0ctNMLhR2155ZlI0BkB2IbpoHlWk9QTE0Mput+s
HXvR0yHL8lYrJub/niY8g5V1geSg25vlLtwTwFKKP1rs9S4Wea2ZDKOBK4i9mBkLlydetiVV
AIJSTl0KAHYWq+lb+WomJeheedVgIjmnyDqSX0ptb6shdGeSosBFhsTR1nJqDkkZIxKpqC3P
WdPhYsUSCFLsVRTSgdrQLaF44GOB5LdPant4wOAx3bXKqssIGupS4Nj8YkdNpn0d4w9Z21Vg
U2jjtoebRNKqm+sMtO+RPLP1u+oyVrEcxBLcXrqjx0ptB9vR2izThg6uPfbGptsdIAKlGZdM
IoFouaehbn2V34lSeF1UgWdaFlpjPmRNpfbdBEHWMWTDZYsLf4PkXcWD5Q+HHn8F5Idwrvth
TvFoEWlhiXOoCDfLMx5Ea9QlEznKnVxslt8k4PTRkP2nOiSUSaZdx5STrGSHsLSxAH6Uw+VO
ATBbbOBdigeHBYI+r6kZtk4iYH+WNks6nmkP3OIOpB0OSarVbshcAOMBrxeBa4bXX379eHxg
XZzf/8IjEZZVzWs8Jxk9WtsrMqPYvqgjh2Nl5iccO/9GO7RKSLrP8FgU3aXO8PtRKNiActme
aIfu6IXsU1GfGqasMCEIAbZpHMWKRj8hjDekhfWwhYh1C68ZNCl8c25bSHatRcwGYnjVnbR5
9vvPNv2T598+PP94BQV5DB1oumpC4UlRW56qGbBND2jiZcD1DElD1mGO2orkPSujgopO/iwm
NkJ6SaWuEWbGJJSClbWvjw//YBNvLt2XLdllEP6jLyx+Gy2TnEWvWvAm0mjCm/1ZZiftGIVf
4soQgw2Ty+IiLwFuy9OflUx05+kamJy4V+/seMvgHg/pFM6BkM71UEsngS59xwvUlzqBaP3Q
Ft1DNC0pQh81Xl/QQax9K/dccIzKOBg3dZzw4Rq78JyxG/l5YIY66u0lhwtzSBsvEXnMM0qN
cHs0HE5l2YRFe8ChZ21+OgOjd7kjNgi4cWlRqOLtjPXwd8sFb/1UwIbml8KdKWrCOGE1g+IJ
HFtsPZfuC3AJcCYIUXcgjh69NSACRK+vH93yjQN1G/gZGCBji5qQcpTsF6FN/9SLLda5okc6
P0DDhojVZTrziskprIXtbCEFdoA6GAp0ngQb96x/uOT7aIJlu+Z5NQb/6rSmSyGH33WpF8o+
shxKW9/d5b670VsyIrzzHOt42bxWn55fVn8/PX775zf3d37SN/vtanyk+Akx4DAhb/XbIv9K
oafFIIGKUBi9LFzzbH1Y5GcRL1wtBF4q1m7nvnfLMjV2pwgBetFa7oPu5fHzZ+UMEazZCbBX
buxl8GBE3FWwFTs5DhUuBSmERYepnQrJIWPSxjaTQ88reETZVPBJ3VswJGFKDu0u1s+4ta1O
NFPEkyXY3+P31/u/n64/Vq+iZ5dZVF5fPz0+QTTtB27+tPoNBuD1/uXz9fV34wSduxoSLlE8
V4T6paRQ4soqyBpyTli/tMy6NMN86zUecAmrT7S5O+HyV66BJEkGwRTAyAjPnrijJd2SUtEO
FqgI1VIQbIroVKKupWUSPjvXUwIpuPlvuYzUKy8SRp2yCZqE5Ea0BfxVk71IXIW1m6TpOGy4
pWYKsSKoxeR1YUPriuIKadMlQnzDbQwglAG33jUkNoba9rvV83cwu5MjplzKZNhRJQfMiUMl
XVIUVq5qOWS268QVZK3OiR3pz6M9mKTZp+u1EpaNFoywTSgdL40WpYY/9QvBlA1X25I9LnaD
QSq/k4KYS/jLhEyC7c4SXgvwMWKkPpLDePQQGzVtjvDQICLKLgofRHCFcH4ChSnQULjpW+Xq
BqwTpzcnpMycTUX5DUdor3OB1KLw6GO5FBlJeE5Da0Va0CIJOBlSSFbkQpV5fHh5/vH86XV1
+PX9+vLHcfX555VpNPIVyeQ++gapchVmpkqZJnHH1yl2B3Vqa1qOaq/Ye3lc9vb55wsWW+X/
K3uy5rZ1Xv9KJk/fnck5bZamyUMfqMU2a22hpNjJi8ZN3NRzmmVi5zvt/fUXIEWJC+j0PiUG
IO4LAGKRFx4sobG/CgJCXaSeL/RzMFXMIIEynkWlGcSjt/Po8plxTfXJonKLtP9Wy9p6h8Dd
3xo6HmXNjQHsN3cHEnlQreB+wSvpoPbH+T1Sux4pJE+G+RQgmu7WL6/Pd5QcqBwF8CmXPBeI
j1WhL4/bB38CRJXXpjcw/nQyDSiY9LyayhxBBYMbPt1DAABzZyi8Wsh0m622DUclPuBjxiA9
LjD7T/cLjJg6WhkpBIzFf2qV3KR8kslc/udgi8zld5iDxNZ9scefzw8Arp9ja3i1aTWBVt9B
gev74Gc+VtktvT6v7u+eH0PfkXiVuG5ZfZi8rtfbuxUsnKvnV34VKuQ9UsVA/Z0vQwV4OIm8
elv9hKYF207ijVOijGE3e5flcgMywS+nzP6TPr7Wddyae5/6YtAT/9HUD+dCrkPM6TXV/7RC
p+lruA9GJ+PkSTUfXGSKURnXvklUpQIPHVaYZmcWAb721VayFBM9eM4HvgbORO07q+WJf0SM
3QymQ0uXTTwy1+mvHfDOfuS3oURF3k1qdnl2QWsGepKgSqXH73EzHilOT03f6BHuyLcmwgnf
06P2pKLQFE3x6Zj0We4JRHNx+fmUebXW+adPZiyMHqxV4pZ+tBR2fmhSALJMBzHntJP1AUGY
GXDSOHRS23LxSU8mcj53dkowXa+fewKzDXIyNlcfuKvnsPQzilu20SlYuXP3ZWO4szB+M/xo
0I7MjRyBODSr9eR4lRxmdgPX5jeVlcoI7q+TScwMTtcA9g5VFjqK826O0U5gkk76L8dNA9/o
CH0J/V5uk8wo6cskAfFS2BHREItTyPPlRX7lPosYRDlfAiNudsEqo1qy7uSiyDEvEJmFx6TB
zroF5KyqZiWwknmSn5+T/g9IptKwoK1UktpJ+6xJMcrGEy5mlB1WHkfWC0EcdVlFOpmygRNi
T/evz5v7cdbh7BWlacXUA2TOY+AbeWVJ4zZ2Qi1NpwDNWh9+26By4ejHv/0//326V/8dhorH
yklnvJFJ6LsznO7MUmjLUOS+JdfiYPe6uts8Pfgbum4sRgt+IufcoBTiLAyCBvZbR10NSCFN
7QypFUDAjomYTnI7Yge1UkAKb9AtY0YODtFPXf2kmjL70FJJyXHIQ0GX8BvPj6P/EG7G9DYd
sUPBOj+skM67LVz5lJJQFi3SKTe1g+XEgQ+FSnAyoUzNJrbXB/yUahR0yyzKgHUSEhnJKd6j
Cb2+Iwmct3SiTImM0gmfUBeVNJKBsVmOOTDNfIp+AM122bFk+vnyxA4P2WecJGsYUhSRKRtd
UQEYnrKy7rWal4GU0Rl3kzVa61PA/0Ua0wsY1kThJYXTChmbeVKuERvgx9UhabFT1yzjGCEe
BhpdaGhdNOBAPGRWt4DJOOnIcwwwp53JLvQADL2Knkdx5qPqNG4FN1OuA+bMLeUMGdMOOFtZ
u0cbqODMqcDswlkwVd3XyHZzx99BYqggj2IWz6xQLbzGk97qxAAEUvudesBIy2nMzkdyL0OZ
3ZI1jSBLMEfinUKoYfkqUcSHS6cz+PuqLe0EyMt3ake8aV2Av8tCKpPqWLSRW1aPE2nFAo7x
SLVgglZ0ITI0a9NJfeLYqKNVurusB2TUiNDQFDwbCtNr4kQP13iYIQjfGulC+i+GmXXAxOrW
KH/7SIxcZFQbzDyktL89DhszlFOh3YVaKbsCDesNTMqK7CoHGRbxjpIdRVp8Fr2xKAI3A3ob
ipsq3IPr1F3bA9BfFARN1HK4X0DA4tOCNa1Iya7UMsSJVU2iQOS7hsRICdsYXTaU4UD6hw+U
6HMOUrdK+DhUJLcf2QuJwXcfqQcbEnwTTZKUcWNMK2YYntT28atg7mKS5zE1KiUMIbqCm0WM
MDSR5QIWX5fYhp8UCcsWDBjECchr5WJvVR1yv8tAeehm7uVO9snyFAajrG4GrfHq7oflRVjr
c95YMBIkdza9QhR+xuumnAqWm9tKoRxfFg0uI9yhXcZNjbBE4fawpmKE7lnaBtHQGJKF6Hut
RiD5S5T5B4w7glzEyEToJV2XlyC5WVP9tcx4arT5FojspdMmE++c1ZXTFSpdU1l/mLDmQ9HQ
jZnIw9VQedTwhQW5dknwt37lRe/lCoNOnp1+pvC8RI00Jr863GyfLy4+Xf51bIhhJmnbTCgj
pqLxdpEEhVPm4l5YmPxnYAyUjmK7frt/PvhOjQ3hkyVB84DgIpGoCzHPBgnEIULLdW5F9pSo
eMazRKSGPDJPRWGOt6NMavLK+0ndNQrh3I0gpmKEWAFynhl3Sv4Zx1mrCvyxGcrhtXofhcY1
aW4eWgKfIL05Y4nHCoy4SYhNSOV9ZbO1GtS/cnLLJN3huOC3MoE2YJHfOAkKLajIKTN1fn+d
uJyMhvSnlJEZZMBgPhtATiYB339FWIMszwTtODcUJWeYYsglAciJ0uMInb/LqnHvQ0V0mwXe
1RU6u6VlVYUV+O4XrB84VNMbq2+UdIEtStuz3MRVgpfCsZIgCdFF712iCbsuW+F0Q5+rEXcm
VEPQwR9fBBI1iNZhrElCQzMQuEPr4esm8UtmOKZUbCr3c0+oGTCaxd33Ndzus7RoeKzdrPR5
ANecOSLqt2JQVTArG5E3pofuVcvqmXWA9RDFo3rsgI1WTAytANCEqOLJKyL/dZBUKj4ojRlF
h8yjZSU1UHnDPWCCW2igyG6pwBYGuiQLXt7uLxYX0H6KM7Tlvo6yeXizDLRpHqVJQoYjGKdJ
sGmOaeJ7Lg6dZE8HbsEVenOOoV4stjb3DuBZFboBrorlmVMigM69Enpg6BAXY6UWBI3lYINH
N4PF/6gecAjywDh7BZUN5bCgyOAUdlwLKmArzcBs6jdyRRmqmfT5bTEhigRWzICmHz003RlJ
51HNYrM6G31xdrKvLbgK/6CSYPFudzVXSHbbbKgm3DcAZtsperqNQxMO79fff65260OP0NOn
9xi0mghXYAk0wD9d27ePexupo1oyDNZBv2e1Y7o9h2npIa7gNMC9k23A7FNODUSEPlKjbnlF
QGNgyxppQon5DXnOmy/HAwufNotSzGn+snB6hr+vT5zfp+5vmzWWMMsFACH1IhAXU5F3tIG/
wBxxBa3kkk317jsEox6gt8FMitC3SITCQJohkd18z0cIgNSpDRJrnOKFxkvjjpYXufNTjYhR
BQyZYUdlIFzz6rotRBW7v7upuc8BgGlmANbNRWTFw+nJE17LDI+8kIsJffdi9BCjRkd/Yi/m
OK1mzrXQg+QcUJaMCk2JTxqlV3aXsSg18dypife6yppyIpFYtC9cjP1zIzZJmkXK5l21QDfB
mVd8WwUT6km8JwrY6NBxoZBD+U6LiBUs4bjwqcLKhNmKMGfDMmr1srGigIjYf9TB0NWBHJSX
VUDZnJmbJzNOdkMnYaC1UqM7O/1sfzhgPocxnz8FMBem34eDOQliwqVZTo02joz65pAc7/mc
WsIOyemezylG1yEJduv8PIi5DGAuT0PfXAaH/PI0NOSXdooDuw2fQ13jdYkrqbsIlHp8EmwK
oLy5kDbe71TlfaQRodnT+FO7IRp8RoM/0eDzUO2UfZiJv6TLO/YW1IB5b8yPnSbOS37RCQLW
ulVgDkpgzBn1HqLxcQoiYUx9GYMQlLaC1gAMRKIE6Xp/DTeCZ5mZ8E9jpiyl4SJN5z6YQ1sd
75EBVbScZpKtcdjf0KYVc27a+yMC9bZmjUlGefG1BccFb3GwCtQVaHmZ8VsVoXCvGY71Kq8M
iNd3b6+b3W/fhcMOyYO/OoERreqmc16eMRAbBzYTRFogE7yYmupCr6j+FS1N/Cq6ZIZZgVXY
GlMDopmIJE9raTjXCB43PoEPmVDF9BwygbF8iAKfdUsrpM+ArlhjBnHChFYyenmRKjcgfOYZ
00Bb8rtLRhonwajEkgKVcm4QcRKtmnT4Yftt8/Thbbt+fXy+X/+lwnUbzwhDD2DxYIBkqvaB
JHcC0NsYNC0qpi0tCDikMJwgotAhPRxSVlUpxvvCh9GsJqtvyry8oTSUAwUUwmBwBPm5RkrO
8U9K8ZmwAAlcRjAprjPTO9/0Lkgk8z5w1CVLKl6QTehxsNkmpYgDWitNfMNyKqrTOAdsgqaq
PAlUBdJPuSi6rKZOLnwKntp7cwCNL90UktU3eZ7iTndOipGkwbgw6iQR1kvGSDJ4xIw0ltlT
X1ebBM53ntMP3uk1bUGm3+PsFUwMjEdIrU+PyAmJrCXQOv9yiI5C98//Ph39Xj2ujn4+r+5f
Nk9H29X3NVBu7o82T7v1Ax72R6uXlxWcBa9H2/XPzdPbr6Pt4+run6Pd8+Pz7+ejby/fD9Xt
MF+/Pq1/HvxYvd6vn9A+cbwljFASB5unzW6z+rn5Xx2ufxhe3uDBhHtdPVaYCLisVJhAy+XV
mBtFgyaLBgl5rwXaodHhbgzOFO41OIhjeFWhZlk9Tb/+ftk9H9w9v67HvAdjfxUx9GpqeYNa
4BMfnrKEBPqkUTaPeTUzz30X4380s10MR6BPKswtNMJIQkPF6DQ92BIWav28qnzqeVX5JaB2
0ScFzgsOS7/cHu5/YJvD2NSDJkW6oHpU08nxyUXeZh6iaDMaaNn19XD5h1I46Y7Kp6WY+NJl
7tQz/Nu3n5u7v/5Z/z64k2v0AYPD/vaWpqiZ18TEXx1pHBMwklAkskhltP62+7F+2m3uVrv1
/UH6JJuC2Tr/3ex+HLDt9vluI1HJarfy2habMWj1YBOweAbsJzv5WJXZzbGVG3HYO1NewyR5
iDq94tdEH2YMDptr3YtIOlwip7T12xj5AxNPIh/W+MsrJhZTarsG9NBMUHZHPbIkqquodi2J
+uAOXAjm76tiFh5NjADWtP484Kv4MGiz1fZHaMzg/vPPHwq4VN1wh+M6Z35Q1WTzsN7u/MpE
fHpCzBGCiaKXywC7N37XHH9M+MRfmeSxGhzFPDkjYAQdh9UoHWCokRB5ckyGKjLw5x+9QgF8
8umcAp+e+NT1jB17wIxHiKCKCYM/HfsnL4BPfWBOwBq4+KPSv5CaqTi+9AteVKo6dVFvXn5Y
lvhGN1jq74sArGs4MQusaCNOceZmJSL2J5wERlm5mHBiLWmE916g1ybL0yzj/oEeM5TRvVBL
BpbKIGqg/cnELiXEGCWOUaCCTuRfWpHen0MzdkvG4dCTD1IeI9amPvuJoz31mSi45EFsbIgW
1jmdTmO4Yyl5SCMXJTlfPXwc+T4W/ePL63q7tRjjYfTkq60/2relB7s485d8dusvJ/m860F7
MxnlD796un9+PCjeHr+tX5W/vsO3D+u85l1cUUxhIqKpjgNBYMjTXWGoU1NiqCsTER7wK8eo
MSl6VFY3HlZFbyHYb42gmzBg6xCPOlAIW4Z00ci571tbIatdgzGX7hhEHTOKLbClZBkUcmy7
gazaKOtp6jayyZafPl52cSowdWaMdgTKNWckqOZxfYFWZdeIxTIois9abRHAIuuKHxtaK5D/
U4wJrIyX0A5+MppTqQ20ft2hSzswjlsZWWu7eXha7d5ABLv7sb77B+Q5M+4MPneH1QI+vv5y
eOhg02UjmDkc3vcehbLiOft4eW4pSMoiYcLTUlCqFlVulMngU3UTbPlIIReKtNQ+PDRsmf9g
tFSors231xXIzK/Pb7vNk8m2oTezVXXE4SrGEDHGQGh/Y7ili7i6ASm9zB2pyiTJ0iKALVI0
XebmE2NcioRb50cMwgHsegt0fG5T+Hxa3PGm7eyvTk+cn4PC3N5vEgP7JY1uaH7LIDgjPmVi
wQKB1BVFxMnXXxGfW2e6zTDEZvw1HvnMbmwIPYq3Nc4CVHHpcR/BghVJmdsD0aMcoyUDqsz9
bDia8OHJZV9pt4p1cKCm7ZUNpUo2LbAsKGlxhdRk+0wbKwdM0S9vEez+7pZm9qseJp2/K5+W
M3M2eyAzHw9GWDNr88hD1HCS+uVG8VcPZk/d2KFualkQGYjlLQm2uA8LbvRFb1/zOUMvKGDF
urrMSotpNaH4BHQRQEGFe1Dmpo/MlBnwQxqUNTIxm2nw1MBhXacYO5qCdfO8IuFRToIntRXJ
DRiRa4b59lLr0q3LmMtQQTCxwgpIxqRrqxkODkFJbnDxBfYZQ7rlrJLcghkVBcAwDBmT9nMz
yQYZFesA2TL8GtJOSu3Y/x6VZbA7kCAWZr8yKxt104BEjidkF1NPM7U+jPZfGSqyaVZG9i/i
DCoy2wNjWHhNCTKydVhmt13DjBK5uEKB3Kgxr7idcsd/fkh4bpHAj0litKeUCRemcO+aGVFq
DABRGjXVcL7npqIFXyyLqX3b9He2dxXbunfN4kjoy+vmaffPAbDwB/eP6+2D/26rchjJaGLm
ZPVgNFAiH9ziPh1VVk4zuOyzQb37OUhx1aLP1dkwuD3v55VwZniKoLVf35QkzRjtoKCzQxGO
Zf2QBYdhkLk2P9d/7TaPPduzlaR3Cv7qD5p6dOvZbg+GvoFtbGcnMbB1lQXejgyiZMHEJJDD
caSKGjqk4DSJ0F2ZV6TokBZSX523KPf3jt49agKHYSrdlb9gDklzNVZwUGGoHTsZsgDxRZbG
yNc81VbLRyjFeDnoCwlnlbnZNMJpEXrR5MAtwwcZLyxGU2f1lk7C6COVs8Y8tl2M7Bd6bN/4
MyOfPXtzQBW1lfb9+9OlMqxyzOGC3LgMD+QDh6cqNSlfPv46Hptm0vlZ2a32K8NVd2zQb0wL
Rv2jV7L+9vbwYElB0iwK7ixMvmPrgFQpiJcHM2VkLcW3kmNiIXNubHhXoI6msF51HQrMn+FX
rTxMA3FG1fRnjPYE6dHyObENxufsU7KF164KSiWfF427I5bX3ZxBp3wWWYFlzV+OvVfHcQKc
0uCjuLzGwK1oQhz7g1HPnFidSrON5R1kz3f/vL2oxThbPT1YUTQwrQ8+u7cVlNTAgAYsOhWy
m2HW44bVdKKAxRXsI9hNSUmftaH2jPOOGa3RP66sTM8EE4xxP9p0NFFXSLyjyrb5MmRGlFnv
CcMKBHt6ExvdLwy0EpEHTnD+sdJ5mlZqdStZGB98hmk8+M/2ZfOEj0Dbo4PHt9361xr+We/u
/v77byuqsipPNHDwAoeY7l3UfWzQPSTvFyIWdZqTGcaVmYnkiGD/pGnlr7U+tIHScdHxdTXH
g2EUYEUhX+S9Nuo1s1DtpfmZ/8dwGssQz3I4lTD1BXDAadJLpnsGZK5Ok+CI9H7s7umH4H1z
RfuyK6SMksCdcLkOTQzsAroFsswPmCzi1jqxx3s3bmUYRW/ELYrQtNhEggUsfhCbXpEe+zog
qdU+t2dwVKh7VRA3qkWpgnHAHYTiR8Bwsh/KLhUCBBAyOshA/H4EEdEW0usThwYXuhulOJsn
Db2YpFpS6tRqx13UJgli0XlNnfK4HfZMToSC4h68Ke0GqSypM0ymnDDDeC1ABSxGzY7P0mXS
5rRNnxoZJdz0SXmJydFUdVxZvJrSCAOiKSmrQ4mW4oIZJxmBg3hlFwVgWFIZrYCXFG0byOAp
sUspr4fxGLhj4oQFsSkEKt0aZP32jKfz5mxjeUIbnKllOt+zhq9zj6tzOo+PFK59qTOCFS2B
KCRqn2coBDrR/cd9yguMCgikaRHPciboK0+WNuEih1N/z0CpYBB7+hOWIfsVJ41iUc0fJgKG
MGawzMLLVirEeeOtNvgS4WTRgAvcnZINLrqENZh9Woi2cpN01gxj7pJZTpnUKaHeCkRC8xv8
TdmNRzWzypYAZN9ZxqdFTsfIVUQDhddxiaetIpnIbog8yr4tnlJr/B+SOVOHo34BAA==

--9amGYk9869ThD9tj--
