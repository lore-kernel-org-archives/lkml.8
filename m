Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA18C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A244206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1BJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:09:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:15357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgC1BJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:09:22 -0400
IronPort-SDR: /9B2ediMAnL71u1Er9c0xxqxspFTQzPgNWoS27Lnno09CcSfZAYlgNPWGiQ7PZgWlNldLIA1F7
 HdWxniOxg8vQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 18:08:47 -0700
IronPort-SDR: 2KzhK0C1I1+YxJ43gLcnRpcUFfxoejqJELYQE4uAJ6+J2+9fgu3XqsUMagy1jj5eDMdOhDHMBT
 l4x1oZzDAsuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="gz'50?scan'50,208,50";a="239249201"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2020 18:08:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHzxs-0007Dv-3B; Sat, 28 Mar 2020 09:08:44 +0800
Date:   Sat, 28 Mar 2020 09:08:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        sfr@canb.auug.org.au, marc.zyngier@arm.com
Subject: Re: [PATCH 2/2] powerpc: Remove Xilinx PPC405/PPC440 support
Message-ID: <202003280933.CumdkPAe%lkp@intel.com>
References: <0eb7f65742d1d9982ae271aa484cf2fa897be5fd.1585311091.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <0eb7f65742d1d9982ae271aa484cf2fa897be5fd.1585311091.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michal,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on sound/for-next robh/for-next linus/master v5.6-rc7 next-20200327]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Michal-Simek/powerpc-Remove-support-for-ppc405-440-Xilinx-platforms/20200328-034921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/powerpc/xmon/ppc-opc.c:3270:55: error: 'FSL' undeclared here (not in a function)
    3270 | {"get",  APU(4, 268,0), APU_RA_MASK, PPC405, 0,  {RT, FSL}},
         |                                                       ^~~
>> arch/powerpc/xmon/ppc-opc.c:861:17: error: 'URC' undeclared here (not in a function); did you mean 'XRC'?
     861 | #define VLESIMM URC + 1
         |                 ^~~
>> arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
>> arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
>> arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
>> arch/powerpc/xmon/ppc-opc.c:879:13: note: in expansion of macro 'VLEUIMML'
     879 | #define XS6 VLEUIMML + 1
         |             ^~~~~~~~
>> arch/powerpc/xmon/ppc-opc.c:880:13: note: in expansion of macro 'XS6'
     880 | #define XT6 XS6
         |             ^~~
>> arch/powerpc/xmon/ppc-opc.c:884:14: note: in expansion of macro 'XT6'
     884 | #define XSQ6 XT6 + 1
         |              ^~~
>> arch/powerpc/xmon/ppc-opc.c:885:14: note: in expansion of macro 'XSQ6'
     885 | #define XTQ6 XSQ6
         |              ^~~~
>> arch/powerpc/xmon/ppc-opc.c:889:13: note: in expansion of macro 'XTQ6'
     889 | #define XA6 XTQ6 + 1
         |             ^~~~
>> arch/powerpc/xmon/ppc-opc.c:893:13: note: in expansion of macro 'XA6'
     893 | #define XB6 XA6 + 1
         |             ^~~
>> arch/powerpc/xmon/ppc-opc.c:899:14: note: in expansion of macro 'XB6'
     899 | #define XB6S XB6 + 1
         |              ^~~
>> arch/powerpc/xmon/ppc-opc.c:903:13: note: in expansion of macro 'XB6S'
     903 | #define XC6 XB6S + 1
         |             ^~~~
>> arch/powerpc/xmon/ppc-opc.c:907:12: note: in expansion of macro 'XC6'
     907 | #define DM XC6 + 1
         |            ^~~
>> arch/powerpc/xmon/ppc-opc.c:912:14: note: in expansion of macro 'DM'
     912 | #define DMEX DM + 1
         |              ^~
>> arch/powerpc/xmon/ppc-opc.c:916:13: note: in expansion of macro 'DMEX'
     916 | #define UIM DMEX + 1
         |             ^~~~
>> arch/powerpc/xmon/ppc-opc.c:918:15: note: in expansion of macro 'UIM'
     918 | #define UIMM2 UIM
         |               ^~~
>> arch/powerpc/xmon/ppc-opc.c:3321:62: note: in expansion of macro 'UIMM2'
    3321 | {"vspltw", VX (4, 652),   VXUIMM2_MASK, PPCVEC, 0,  {VD, VB, UIMM2}},
         |                                                              ^~~~~
>> arch/powerpc/xmon/ppc-opc.c:3500:63: error: 'URT' undeclared here (not in a function); did you mean 'XRT'?
    3500 | {"udi0fcm.", APU(4, 515,0), APU_MASK, PPC405|PPC440, PPC476, {URT, URA, URB}},
         |                                                               ^~~
         |                                                               XRT
>> arch/powerpc/xmon/ppc-opc.c:3500:68: error: 'URA' undeclared here (not in a function); did you mean 'FRA'?
    3500 | {"udi0fcm.", APU(4, 515,0), APU_MASK, PPC405|PPC440, PPC476, {URT, URA, URB}},
         |                                                                    ^~~
         |                                                                    FRA
   arch/powerpc/xmon/ppc-opc.c:3500:73: error: 'URB' undeclared here (not in a function); did you mean 'FRB'?
    3500 | {"udi0fcm.", APU(4, 515,0), APU_MASK, PPC405|PPC440, PPC476, {URT, URA, URB}},
         |                                                                         ^~~
         |                                                                         FRB
   arch/powerpc/xmon/ppc-opc.c:4674:51: error: 'FCRT' undeclared here (not in a function); did you mean 'FRT'?
    4674 | {"lbfcmx", APU(31,7,0), APU_MASK,    PPC405, 0,  {FCRT, RA, RB}},
         |                                                   ^~~~
         |                                                   FRT
   arch/powerpc/xmon/ppc-opc.c:861:17: error: initialization of 'unsigned char' from 'const struct powerpc_opcode *' makes integer from pointer without a cast [-Werror=int-conversion]
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7068:52: note: in expansion of macro 'VLEUIMML'
    7068 | {"e_lis", I16L(28,28), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},
         |                                                    ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:861:17: note: (near initialization for 'vle_opcodes[105].operands[1]')
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7068:52: note: in expansion of macro 'VLEUIMML'
    7068 | {"e_lis", I16L(28,28), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},
         |                                                    ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:861:17: error: initializer element is not constant
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7068:52: note: in expansion of macro 'VLEUIMML'
    7068 | {"e_lis", I16L(28,28), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},
         |                                                    ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:861:17: note: (near initialization for 'vle_opcodes[105].operands[1]')
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7068:52: note: in expansion of macro 'VLEUIMML'
    7068 | {"e_lis", I16L(28,28), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},
         |                                                    ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:861:17: error: initialization of 'unsigned char' from 'const struct powerpc_opcode *' makes integer from pointer without a cast [-Werror=int-conversion]
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7069:56: note: in expansion of macro 'VLEUIMML'
    7069 | {"e_and2is.", I16L(28,29), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},
         |                                                        ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:861:17: note: (near initialization for 'vle_opcodes[106].operands[1]')
     861 | #define VLESIMM URC + 1
         |                 ^~~
   arch/powerpc/xmon/ppc-opc.c:866:18: note: in expansion of macro 'VLESIMM'
     866 | #define VLENSIMM VLESIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:871:17: note: in expansion of macro 'VLENSIMM'
     871 | #define VLEUIMM VLENSIMM + 1
         |                 ^~~~~~~~
   arch/powerpc/xmon/ppc-opc.c:875:18: note: in expansion of macro 'VLEUIMM'
     875 | #define VLEUIMML VLEUIMM + 1
         |                  ^~~~~~~
   arch/powerpc/xmon/ppc-opc.c:7069:56: note: in expansion of macro 'VLEUIMML'
    7069 | {"e_and2is.", I16L(28,29), I16L_MASK, PPCVLE, 0,  {RD, VLEUIMML}},

vim +/FSL +3270 arch/powerpc/xmon/ppc-opc.c

08d96e0b127e07 Balbir Singh 2017-02-02  3064  
08d96e0b127e07 Balbir Singh 2017-02-02  3065  {"ps_cmpu0",	X  (4,	 0),	XBF_MASK,    PPCPS,	0,		{BF, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3066  {"vaddubm",	VX (4,	 0),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3067  {"vmul10cuq",	VX (4,	 1),	VXVB_MASK,   PPCVEC3,	0,		{VD, VA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3068  {"vmaxub",	VX (4,	 2),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3069  {"vrlb",	VX (4,	 4),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3070  {"vcmpequb",	VXR(4,	 6,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3071  {"vcmpneb",	VXR(4,	 7,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3072  {"vmuloub",	VX (4,	 8),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3073  {"vaddfp",	VX (4,	10),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3074  {"psq_lx",	XW (4,	 6,0),	XW_MASK,     PPCPS,	0,		{FRT,RA,RB,PSWM,PSQM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3075  {"vmrghb",	VX (4,	12),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3076  {"psq_stx",	XW (4,	 7,0),	XW_MASK,     PPCPS,	0,		{FRS,RA,RB,PSWM,PSQM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3077  {"vpkuhum",	VX (4,	14),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3078  {"mulhhwu",	XRC(4,	 8,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3079  {"mulhhwu.",	XRC(4,	 8,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3080  {"ps_sum0",	A  (4,	10,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3081  {"ps_sum0.",	A  (4,	10,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3082  {"ps_sum1",	A  (4,	11,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3083  {"ps_sum1.",	A  (4,	11,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3084  {"ps_muls0",	A  (4,	12,0),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3085  {"machhwu",	XO (4,	12,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3086  {"ps_muls0.",	A  (4,	12,1),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3087  {"machhwu.",	XO (4,	12,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3088  {"ps_muls1",	A  (4,	13,0),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3089  {"ps_muls1.",	A  (4,	13,1),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3090  {"ps_madds0",	A  (4,	14,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3091  {"ps_madds0.",	A  (4,	14,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3092  {"ps_madds1",	A  (4,	15,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3093  {"ps_madds1.",	A  (4,	15,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3094  {"vmhaddshs",	VXA(4,	32),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3095  {"vmhraddshs",	VXA(4,	33),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3096  {"vmladduhm",	VXA(4,	34),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3097  {"vmsumudm",	VXA(4,	35),	VXA_MASK,    PPCVEC3,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3098  {"ps_div",	A  (4,	18,0),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3099  {"vmsumubm",	VXA(4,	36),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3100  {"ps_div.",	A  (4,	18,1),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3101  {"vmsummbm",	VXA(4,	37),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3102  {"vmsumuhm",	VXA(4,	38),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3103  {"vmsumuhs",	VXA(4,	39),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3104  {"ps_sub",	A  (4,	20,0),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3105  {"vmsumshm",	VXA(4,	40),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3106  {"ps_sub.",	A  (4,	20,1),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3107  {"vmsumshs",	VXA(4,	41),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3108  {"ps_add",	A  (4,	21,0),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3109  {"vsel",	VXA(4,	42),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3110  {"ps_add.",	A  (4,	21,1),	AFRC_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3111  {"vperm",	VXA(4,	43),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3112  {"vsldoi",	VXA(4,	44),	VXASHB_MASK, PPCVEC,	0,		{VD, VA, VB, SHB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3113  {"vpermxor",	VXA(4,	45),	VXA_MASK,    PPCVEC2,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3114  {"ps_sel",	A  (4,	23,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3115  {"vmaddfp",	VXA(4,	46),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VC, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3116  {"ps_sel.",	A  (4,	23,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3117  {"vnmsubfp",	VXA(4,	47),	VXA_MASK,    PPCVEC,	0,		{VD, VA, VC, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3118  {"ps_res",	A  (4,	24,0), AFRAFRC_MASK, PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3119  {"maddhd",	VXA(4,	48),	VXA_MASK,    POWER9,	0,		{RT, RA, RB, RC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3120  {"ps_res.",	A  (4,	24,1), AFRAFRC_MASK, PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3121  {"maddhdu",	VXA(4,	49),	VXA_MASK,    POWER9,	0,		{RT, RA, RB, RC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3122  {"ps_mul",	A  (4,	25,0),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3123  {"ps_mul.",	A  (4,	25,1),	AFRB_MASK,   PPCPS,	0,		{FRT, FRA, FRC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3124  {"maddld",	VXA(4,	51),	VXA_MASK,    POWER9,	0,		{RT, RA, RB, RC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3125  {"ps_rsqrte",	A  (4,	26,0), AFRAFRC_MASK, PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3126  {"ps_rsqrte.",	A  (4,	26,1), AFRAFRC_MASK, PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3127  {"ps_msub",	A  (4,	28,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3128  {"ps_msub.",	A  (4,	28,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3129  {"ps_madd",	A  (4,	29,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3130  {"ps_madd.",	A  (4,	29,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3131  {"vpermr",	VXA(4,	59),	VXA_MASK,    PPCVEC3,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3132  {"ps_nmsub",	A  (4,	30,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3133  {"vaddeuqm",	VXA(4,	60),	VXA_MASK,    PPCVEC2,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3134  {"ps_nmsub.",	A  (4,	30,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3135  {"vaddecuq",	VXA(4,	61),	VXA_MASK,    PPCVEC2,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3136  {"ps_nmadd",	A  (4,	31,0),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3137  {"vsubeuqm",	VXA(4,	62),	VXA_MASK,    PPCVEC2,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3138  {"ps_nmadd.",	A  (4,	31,1),	A_MASK,	     PPCPS,	0,		{FRT, FRA, FRC, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3139  {"vsubecuq",	VXA(4,	63),	VXA_MASK,    PPCVEC2,	0,		{VD, VA, VB, VC}},
08d96e0b127e07 Balbir Singh 2017-02-02  3140  {"ps_cmpo0",	X  (4,	32),	XBF_MASK,    PPCPS,	0,		{BF, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3141  {"vadduhm",	VX (4,	64),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3142  {"vmul10ecuq",	VX (4,	65),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3143  {"vmaxuh",	VX (4,	66),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3144  {"vrlh",	VX (4,	68),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3145  {"vcmpequh",	VXR(4,	70,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3146  {"vcmpneh",	VXR(4,	71,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3147  {"vmulouh",	VX (4,	72),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3148  {"vsubfp",	VX (4,	74),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3149  {"psq_lux",	XW (4,	38,0),	XW_MASK,     PPCPS,	0,		{FRT,RA,RB,PSWM,PSQM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3150  {"vmrghh",	VX (4,	76),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3151  {"psq_stux",	XW (4,	39,0),	XW_MASK,     PPCPS,	0,		{FRS,RA,RB,PSWM,PSQM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3152  {"vpkuwum",	VX (4,	78),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3153  {"ps_neg",	XRC(4,	40,0),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3154  {"mulhhw",	XRC(4,	40,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3155  {"ps_neg.",	XRC(4,	40,1),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3156  {"mulhhw.",	XRC(4,	40,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3157  {"machhw",	XO (4,	44,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3158  {"machhw.",	XO (4,	44,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3159  {"nmachhw",	XO (4,	46,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3160  {"nmachhw.",	XO (4,	46,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3161  {"ps_cmpu1",	X  (4,	64),	XBF_MASK,    PPCPS,	0,		{BF, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3162  {"vadduwm",	VX (4,	128),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3163  {"vmaxuw",	VX (4,	130),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3164  {"vrlw",	VX (4,	132),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3165  {"vrlwmi",	VX (4,	133),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3166  {"vcmpequw",	VXR(4,	134,0), VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3167  {"vcmpnew",	VXR(4,	135,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3168  {"vmulouw",	VX (4,	136),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3169  {"vmuluwm",	VX (4,	137),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3170  {"vmrghw",	VX (4,	140),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3171  {"vpkuhus",	VX (4,	142),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3172  {"ps_mr",	XRC(4,	72,0),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3173  {"ps_mr.",	XRC(4,	72,1),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3174  {"machhwsu",	XO (4,	76,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3175  {"machhwsu.",	XO (4,	76,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3176  {"ps_cmpo1",	X  (4,	96),	XBF_MASK,    PPCPS,	0,		{BF, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3177  {"vaddudm",	VX (4, 192),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3178  {"vmaxud",	VX (4, 194),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3179  {"vrld",	VX (4, 196),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3180  {"vrldmi",	VX (4, 197),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3181  {"vcmpeqfp",	VXR(4, 198,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3182  {"vcmpequd",	VXR(4, 199,0),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3183  {"vpkuwus",	VX (4, 206),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3184  {"machhws",	XO (4, 108,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3185  {"machhws.",	XO (4, 108,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3186  {"nmachhws",	XO (4, 110,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3187  {"nmachhws.",	XO (4, 110,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3188  {"vadduqm",	VX (4, 256),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3189  {"vmaxsb",	VX (4, 258),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3190  {"vslb",	VX (4, 260),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3191  {"vcmpnezb",	VXR(4, 263,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3192  {"vmulosb",	VX (4, 264),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3193  {"vrefp",	VX (4, 266),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3194  {"vmrglb",	VX (4, 268),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3195  {"vpkshus",	VX (4, 270),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3196  {"ps_nabs",	XRC(4, 136,0),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3197  {"mulchwu",	XRC(4, 136,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3198  {"ps_nabs.",	XRC(4, 136,1),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3199  {"mulchwu.",	XRC(4, 136,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3200  {"macchwu",	XO (4, 140,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3201  {"macchwu.",	XO (4, 140,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3202  {"vaddcuq",	VX (4, 320),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3203  {"vmaxsh",	VX (4, 322),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3204  {"vslh",	VX (4, 324),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3205  {"vcmpnezh",	VXR(4, 327,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3206  {"vmulosh",	VX (4, 328),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3207  {"vrsqrtefp",	VX (4, 330),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3208  {"vmrglh",	VX (4, 332),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3209  {"vpkswus",	VX (4, 334),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3210  {"mulchw",	XRC(4, 168,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3211  {"mulchw.",	XRC(4, 168,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3212  {"macchw",	XO (4, 172,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3213  {"macchw.",	XO (4, 172,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3214  {"nmacchw",	XO (4, 174,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3215  {"nmacchw.",	XO (4, 174,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3216  {"vaddcuw",	VX (4, 384),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3217  {"vmaxsw",	VX (4, 386),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3218  {"vslw",	VX (4, 388),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3219  {"vrlwnm",	VX (4, 389),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3220  {"vcmpnezw",	VXR(4, 391,0),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3221  {"vmulosw",	VX (4, 392),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3222  {"vexptefp",	VX (4, 394),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3223  {"vmrglw",	VX (4, 396),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3224  {"vpkshss",	VX (4, 398),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3225  {"macchwsu",	XO (4, 204,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3226  {"macchwsu.",	XO (4, 204,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3227  {"vmaxsd",	VX (4, 450),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3228  {"vsl",		VX (4, 452),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3229  {"vrldnm",	VX (4, 453),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3230  {"vcmpgefp",	VXR(4, 454,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3231  {"vlogefp",	VX (4, 458),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3232  {"vpkswss",	VX (4, 462),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3233  {"macchws",	XO (4, 236,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3234  {"macchws.",	XO (4, 236,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3235  {"nmacchws",	XO (4, 238,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3236  {"nmacchws.",	XO (4, 238,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3237  {"evaddw",	VX (4, 512),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3238  {"vaddubs",	VX (4, 512),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3239  {"vmul10uq",	VX (4, 513),	VXVB_MASK,   PPCVEC3,	0,		{VD, VA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3240  {"evaddiw",	VX (4, 514),	VX_MASK,     PPCSPE,	0,		{RS, RB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3241  {"vminub",	VX (4, 514),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3242  {"evsubfw",	VX (4, 516),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3243  {"evsubw",	VX (4, 516),	VX_MASK,     PPCSPE,	0,		{RS, RB, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3244  {"vsrb",	VX (4, 516),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3245  {"evsubifw",	VX (4, 518),	VX_MASK,     PPCSPE,	0,		{RS, UIMM, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3246  {"evsubiw",	VX (4, 518),	VX_MASK,     PPCSPE,	0,		{RS, RB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3247  {"vcmpgtub",	VXR(4, 518,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3248  {"evabs",	VX (4, 520),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3249  {"vmuleub",	VX (4, 520),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3250  {"evneg",	VX (4, 521),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3251  {"evextsb",	VX (4, 522),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3252  {"vrfin",	VX (4, 522),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3253  {"evextsh",	VX (4, 523),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3254  {"evrndw",	VX (4, 524),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3255  {"vspltb",	VX (4, 524),   VXUIMM4_MASK, PPCVEC,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3256  {"vextractub",	VX (4, 525),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3257  {"evcntlzw",	VX (4, 525),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3258  {"evcntlsw",	VX (4, 526),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3259  {"vupkhsb",	VX (4, 526),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3260  {"brinc",	VX (4, 527),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3261  {"ps_abs",	XRC(4, 264,0),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3262  {"ps_abs.",	XRC(4, 264,1),	XRA_MASK,    PPCPS,	0,		{FRT, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3263  {"evand",	VX (4, 529),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3264  {"evandc",	VX (4, 530),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3265  {"evxor",	VX (4, 534),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3266  {"evmr",	VX (4, 535),	VX_MASK,     PPCSPE,	0,		{RS, RA, BBA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3267  {"evor",	VX (4, 535),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3268  {"evnor",	VX (4, 536),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3269  {"evnot",	VX (4, 536),	VX_MASK,     PPCSPE,	0,		{RS, RA, BBA}},
08d96e0b127e07 Balbir Singh 2017-02-02 @3270  {"get",		APU(4, 268,0),	APU_RA_MASK, PPC405,	0,		{RT, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3271  {"eveqv",	VX (4, 537),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3272  {"evorc",	VX (4, 539),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3273  {"evnand",	VX (4, 542),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3274  {"evsrwu",	VX (4, 544),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3275  {"evsrws",	VX (4, 545),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3276  {"evsrwiu",	VX (4, 546),	VX_MASK,     PPCSPE,	0,		{RS, RA, EVUIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3277  {"evsrwis",	VX (4, 547),	VX_MASK,     PPCSPE,	0,		{RS, RA, EVUIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3278  {"evslw",	VX (4, 548),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3279  {"evslwi",	VX (4, 550),	VX_MASK,     PPCSPE,	0,		{RS, RA, EVUIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3280  {"evrlw",	VX (4, 552),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3281  {"evsplati",	VX (4, 553),	VX_MASK,     PPCSPE,	0,		{RS, SIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3282  {"evrlwi",	VX (4, 554),	VX_MASK,     PPCSPE,	0,		{RS, RA, EVUIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3283  {"evsplatfi",	VX (4, 555),	VX_MASK,     PPCSPE,	0,		{RS, SIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3284  {"evmergehi",	VX (4, 556),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3285  {"evmergelo",	VX (4, 557),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3286  {"evmergehilo",	VX (4, 558),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3287  {"evmergelohi",	VX (4, 559),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3288  {"evcmpgtu",	VX (4, 560),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3289  {"evcmpgts",	VX (4, 561),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3290  {"evcmpltu",	VX (4, 562),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3291  {"evcmplts",	VX (4, 563),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3292  {"evcmpeq",	VX (4, 564),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3293  {"cget",	APU(4, 284,0),	APU_RA_MASK, PPC405,	0,		{RT, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3294  {"vadduhs",	VX (4, 576),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3295  {"vmul10euq",	VX (4, 577),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3296  {"vminuh",	VX (4, 578),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3297  {"vsrh",	VX (4, 580),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3298  {"vcmpgtuh",	VXR(4, 582,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3299  {"vmuleuh",	VX (4, 584),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3300  {"vrfiz",	VX (4, 586),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3301  {"vsplth",	VX (4, 588),   VXUIMM3_MASK, PPCVEC,	0,		{VD, VB, UIMM3}},
08d96e0b127e07 Balbir Singh 2017-02-02  3302  {"vextractuh",	VX (4, 589),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3303  {"vupkhsh",	VX (4, 590),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3304  {"nget",	APU(4, 300,0),	APU_RA_MASK, PPC405,	0,		{RT, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3305  {"evsel",	EVSEL(4,79),	EVSEL_MASK,  PPCSPE,	0,		{RS, RA, RB, CRFS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3306  {"ncget",	APU(4, 316,0),	APU_RA_MASK, PPC405,	0,		{RT, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3307  {"evfsadd",	VX (4, 640),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3308  {"vadduws",	VX (4, 640),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3309  {"evfssub",	VX (4, 641),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3310  {"vminuw",	VX (4, 642),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3311  {"evfsabs",	VX (4, 644),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3312  {"vsrw",	VX (4, 644),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3313  {"evfsnabs",	VX (4, 645),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3314  {"evfsneg",	VX (4, 646),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3315  {"vcmpgtuw",	VXR(4, 646,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3316  {"vmuleuw",	VX (4, 648),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3317  {"evfsmul",	VX (4, 648),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3318  {"evfsdiv",	VX (4, 649),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3319  {"vrfip",	VX (4, 650),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3320  {"evfscmpgt",	VX (4, 652),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02 @3321  {"vspltw",	VX (4, 652),   VXUIMM2_MASK, PPCVEC,	0,		{VD, VB, UIMM2}},
08d96e0b127e07 Balbir Singh 2017-02-02  3322  {"vextractuw",	VX (4, 653),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3323  {"evfscmplt",	VX (4, 653),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3324  {"evfscmpeq",	VX (4, 654),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3325  {"vupklsb",	VX (4, 654),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3326  {"evfscfui",	VX (4, 656),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3327  {"evfscfsi",	VX (4, 657),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3328  {"evfscfuf",	VX (4, 658),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3329  {"evfscfsf",	VX (4, 659),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3330  {"evfsctui",	VX (4, 660),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3331  {"evfsctsi",	VX (4, 661),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3332  {"evfsctuf",	VX (4, 662),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3333  {"evfsctsf",	VX (4, 663),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3334  {"evfsctuiz",	VX (4, 664),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3335  {"put",		APU(4, 332,0),	APU_RT_MASK, PPC405,	0,		{RA, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3336  {"evfsctsiz",	VX (4, 666),	VX_MASK,     PPCSPE,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3337  {"evfststgt",	VX (4, 668),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3338  {"evfststlt",	VX (4, 669),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3339  {"evfststeq",	VX (4, 670),	VX_MASK,     PPCSPE,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3340  {"cput",	APU(4, 348,0),	APU_RT_MASK, PPC405,	0,		{RA, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3341  {"efsadd",	VX (4, 704),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3342  {"efssub",	VX (4, 705),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3343  {"vminud",	VX (4, 706),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3344  {"efsabs",	VX (4, 708),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3345  {"vsr",		VX (4, 708),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3346  {"efsnabs",	VX (4, 709),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3347  {"efsneg",	VX (4, 710),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3348  {"vcmpgtfp",	VXR(4, 710,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3349  {"vcmpgtud",	VXR(4, 711,0),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3350  {"efsmul",	VX (4, 712),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3351  {"efsdiv",	VX (4, 713),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3352  {"vrfim",	VX (4, 714),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3353  {"efscmpgt",	VX (4, 716),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3354  {"vextractd",	VX (4, 717),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3355  {"efscmplt",	VX (4, 717),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3356  {"efscmpeq",	VX (4, 718),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3357  {"vupklsh",	VX (4, 718),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3358  {"efscfd",	VX (4, 719),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3359  {"efscfui",	VX (4, 720),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3360  {"efscfsi",	VX (4, 721),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3361  {"efscfuf",	VX (4, 722),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3362  {"efscfsf",	VX (4, 723),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3363  {"efsctui",	VX (4, 724),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3364  {"efsctsi",	VX (4, 725),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3365  {"efsctuf",	VX (4, 726),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3366  {"efsctsf",	VX (4, 727),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3367  {"efsctuiz",	VX (4, 728),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3368  {"nput",	APU(4, 364,0),	APU_RT_MASK, PPC405,	0,		{RA, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3369  {"efsctsiz",	VX (4, 730),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3370  {"efststgt",	VX (4, 732),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3371  {"efststlt",	VX (4, 733),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3372  {"efststeq",	VX (4, 734),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3373  {"efdadd",	VX (4, 736),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3374  {"efdsub",	VX (4, 737),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3375  {"efdcfuid",	VX (4, 738),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3376  {"efdcfsid",	VX (4, 739),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3377  {"efdabs",	VX (4, 740),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3378  {"efdnabs",	VX (4, 741),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3379  {"efdneg",	VX (4, 742),	VX_MASK,     PPCEFS,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3380  {"efdmul",	VX (4, 744),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3381  {"efddiv",	VX (4, 745),	VX_MASK,     PPCEFS,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3382  {"efdctuidz",	VX (4, 746),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3383  {"efdctsidz",	VX (4, 747),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3384  {"efdcmpgt",	VX (4, 748),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3385  {"efdcmplt",	VX (4, 749),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3386  {"efdcmpeq",	VX (4, 750),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3387  {"efdcfs",	VX (4, 751),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3388  {"efdcfui",	VX (4, 752),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3389  {"efdcfsi",	VX (4, 753),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3390  {"efdcfuf",	VX (4, 754),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3391  {"efdcfsf",	VX (4, 755),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3392  {"efdctui",	VX (4, 756),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3393  {"efdctsi",	VX (4, 757),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3394  {"efdctuf",	VX (4, 758),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3395  {"efdctsf",	VX (4, 759),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3396  {"efdctuiz",	VX (4, 760),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3397  {"ncput",	APU(4, 380,0),	APU_RT_MASK, PPC405,	0,		{RA, FSL}},
08d96e0b127e07 Balbir Singh 2017-02-02  3398  {"efdctsiz",	VX (4, 762),	VX_MASK,     PPCEFS,	0,		{RS, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3399  {"efdtstgt",	VX (4, 764),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3400  {"efdtstlt",	VX (4, 765),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3401  {"efdtsteq",	VX (4, 766),	VX_MASK,     PPCEFS,	0,		{CRFD, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3402  {"evlddx",	VX (4, 768),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3403  {"vaddsbs",	VX (4, 768),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3404  {"evldd",	VX (4, 769),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3405  {"evldwx",	VX (4, 770),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3406  {"vminsb",	VX (4, 770),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3407  {"evldw",	VX (4, 771),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3408  {"evldhx",	VX (4, 772),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3409  {"vsrab",	VX (4, 772),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3410  {"evldh",	VX (4, 773),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3411  {"vcmpgtsb",	VXR(4, 774,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3412  {"evlhhesplatx",VX (4, 776),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3413  {"vmulesb",	VX (4, 776),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3414  {"evlhhesplat",	VX (4, 777),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_2, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3415  {"vcfux",	VX (4, 778),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3416  {"vcuxwfp",	VX (4, 778),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3417  {"evlhhousplatx",VX(4, 780),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3418  {"vspltisb",	VX (4, 780),	VXVB_MASK,   PPCVEC,	0,		{VD, SIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3419  {"vinsertb",	VX (4, 781),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3420  {"evlhhousplat",VX (4, 781),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_2, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3421  {"evlhhossplatx",VX(4, 782),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3422  {"vpkpx",	VX (4, 782),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3423  {"evlhhossplat",VX (4, 783),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_2, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3424  {"mullhwu",	XRC(4, 392,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3425  {"evlwhex",	VX (4, 784),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3426  {"mullhwu.",	XRC(4, 392,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3427  {"evlwhe",	VX (4, 785),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3428  {"evlwhoux",	VX (4, 788),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3429  {"evlwhou",	VX (4, 789),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3430  {"evlwhosx",	VX (4, 790),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3431  {"evlwhos",	VX (4, 791),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3432  {"maclhwu",	XO (4, 396,0,0),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3433  {"evlwwsplatx",	VX (4, 792),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3434  {"maclhwu.",	XO (4, 396,0,1),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3435  {"evlwwsplat",	VX (4, 793),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3436  {"evlwhsplatx",	VX (4, 796),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3437  {"evlwhsplat",	VX (4, 797),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3438  {"evstddx",	VX (4, 800),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3439  {"evstdd",	VX (4, 801),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3440  {"evstdwx",	VX (4, 802),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3441  {"evstdw",	VX (4, 803),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3442  {"evstdhx",	VX (4, 804),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3443  {"evstdh",	VX (4, 805),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_8, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3444  {"evstwhex",	VX (4, 816),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3445  {"evstwhe",	VX (4, 817),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3446  {"evstwhox",	VX (4, 820),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3447  {"evstwho",	VX (4, 821),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3448  {"evstwwex",	VX (4, 824),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3449  {"evstwwe",	VX (4, 825),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3450  {"evstwwox",	VX (4, 828),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3451  {"evstwwo",	VX (4, 829),	VX_MASK,     PPCSPE,	0,		{RS, EVUIMM_4, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3452  {"vaddshs",	VX (4, 832),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3453  {"bcdcpsgn.",	VX (4, 833),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3454  {"vminsh",	VX (4, 834),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3455  {"vsrah",	VX (4, 836),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3456  {"vcmpgtsh",	VXR(4, 838,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3457  {"vmulesh",	VX (4, 840),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3458  {"vcfsx",	VX (4, 842),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3459  {"vcsxwfp",	VX (4, 842),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3460  {"vspltish",	VX (4, 844),	VXVB_MASK,   PPCVEC,	0,		{VD, SIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3461  {"vinserth",	VX (4, 845),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3462  {"vupkhpx",	VX (4, 846),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3463  {"mullhw",	XRC(4, 424,0),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3464  {"mullhw.",	XRC(4, 424,1),	X_MASK,	     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3465  {"maclhw",	XO (4, 428,0,0),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3466  {"maclhw.",	XO (4, 428,0,1),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3467  {"nmaclhw",	XO (4, 430,0,0),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3468  {"nmaclhw.",	XO (4, 430,0,1),XO_MASK,     MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3469  {"vaddsws",	VX (4, 896),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3470  {"vminsw",	VX (4, 898),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3471  {"vsraw",	VX (4, 900),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3472  {"vcmpgtsw",	VXR(4, 902,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3473  {"vmulesw",	VX (4, 904),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3474  {"vctuxs",	VX (4, 906),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3475  {"vcfpuxws",	VX (4, 906),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3476  {"vspltisw",	VX (4, 908),	VXVB_MASK,   PPCVEC,	0,		{VD, SIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3477  {"vinsertw",	VX (4, 909),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3478  {"maclhwsu",	XO (4, 460,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3479  {"maclhwsu.",	XO (4, 460,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3480  {"vminsd",	VX (4, 962),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3481  {"vsrad",	VX (4, 964),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3482  {"vcmpbfp",	VXR(4, 966,0),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3483  {"vcmpgtsd",	VXR(4, 967,0),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3484  {"vctsxs",	VX (4, 970),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3485  {"vcfpsxws",	VX (4, 970),	VX_MASK,     PPCVEC,	0,		{VD, VB, UIMM}},
08d96e0b127e07 Balbir Singh 2017-02-02  3486  {"vinsertd",	VX (4, 973),   VXUIMM4_MASK, PPCVEC3,	0,		{VD, VB, UIMM4}},
08d96e0b127e07 Balbir Singh 2017-02-02  3487  {"vupklpx",	VX (4, 974),	VXVA_MASK,   PPCVEC,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3488  {"maclhws",	XO (4, 492,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3489  {"maclhws.",	XO (4, 492,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3490  {"nmaclhws",	XO (4, 494,0,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3491  {"nmaclhws.",	XO (4, 494,0,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3492  {"vsububm",	VX (4,1024),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3493  {"bcdadd.",	VX (4,1025),	VXPS_MASK,   PPCVEC2,	0,		{VD, VA, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3494  {"vavgub",	VX (4,1026),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3495  {"vabsdub",	VX (4,1027),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3496  {"evmhessf",	VX (4,1027),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3497  {"vand",	VX (4,1028),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3498  {"vcmpequb.",	VXR(4,	 6,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3499  {"vcmpneb.",	VXR(4,	 7,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3500  {"udi0fcm.",	APU(4, 515,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3501  {"udi0fcm",	APU(4, 515,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3502  {"evmhossf",	VX (4,1031),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3503  {"vpmsumb",	VX (4,1032),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3504  {"evmheumi",	VX (4,1032),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3505  {"evmhesmi",	VX (4,1033),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3506  {"vmaxfp",	VX (4,1034),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3507  {"evmhesmf",	VX (4,1035),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3508  {"evmhoumi",	VX (4,1036),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3509  {"vslo",	VX (4,1036),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3510  {"evmhosmi",	VX (4,1037),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3511  {"evmhosmf",	VX (4,1039),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3512  {"machhwuo",	XO (4,	12,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3513  {"machhwuo.",	XO (4,	12,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3514  {"ps_merge00",	XOPS(4,528,0),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3515  {"ps_merge00.",	XOPS(4,528,1),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3516  {"evmhessfa",	VX (4,1059),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3517  {"evmhossfa",	VX (4,1063),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3518  {"evmheumia",	VX (4,1064),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3519  {"evmhesmia",	VX (4,1065),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3520  {"evmhesmfa",	VX (4,1067),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3521  {"evmhoumia",	VX (4,1068),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3522  {"evmhosmia",	VX (4,1069),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3523  {"evmhosmfa",	VX (4,1071),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3524  {"vsubuhm",	VX (4,1088),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3525  {"bcdsub.",	VX (4,1089),	VXPS_MASK,   PPCVEC2,	0,		{VD, VA, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3526  {"vavguh",	VX (4,1090),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3527  {"vabsduh",	VX (4,1091),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3528  {"vandc",	VX (4,1092),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3529  {"vcmpequh.",	VXR(4,	70,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3530  {"udi1fcm.",	APU(4, 547,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3531  {"udi1fcm",	APU(4, 547,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3532  {"vcmpneh.",	VXR(4,	71,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3533  {"evmwhssf",	VX (4,1095),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3534  {"vpmsumh",	VX (4,1096),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3535  {"evmwlumi",	VX (4,1096),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3536  {"vminfp",	VX (4,1098),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3537  {"evmwhumi",	VX (4,1100),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3538  {"vsro",	VX (4,1100),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3539  {"evmwhsmi",	VX (4,1101),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3540  {"vpkudum",	VX (4,1102),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3541  {"evmwhsmf",	VX (4,1103),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3542  {"evmwssf",	VX (4,1107),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3543  {"machhwo",	XO (4,	44,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3544  {"evmwumi",	VX (4,1112),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3545  {"machhwo.",	XO (4,	44,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3546  {"evmwsmi",	VX (4,1113),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3547  {"evmwsmf",	VX (4,1115),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3548  {"nmachhwo",	XO (4,	46,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3549  {"nmachhwo.",	XO (4,	46,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3550  {"ps_merge01",	XOPS(4,560,0),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3551  {"ps_merge01.",	XOPS(4,560,1),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3552  {"evmwhssfa",	VX (4,1127),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3553  {"evmwlumia",	VX (4,1128),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3554  {"evmwhumia",	VX (4,1132),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3555  {"evmwhsmia",	VX (4,1133),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3556  {"evmwhsmfa",	VX (4,1135),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3557  {"evmwssfa",	VX (4,1139),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3558  {"evmwumia",	VX (4,1144),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3559  {"evmwsmia",	VX (4,1145),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3560  {"evmwsmfa",	VX (4,1147),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3561  {"vsubuwm",	VX (4,1152),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3562  {"bcdus.",	VX (4,1153),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3563  {"vavguw",	VX (4,1154),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3564  {"vabsduw",	VX (4,1155),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3565  {"vmr",		VX (4,1156),	VX_MASK,     PPCVEC,	0,		{VD, VA, VBA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3566  {"vor",		VX (4,1156),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3567  {"vcmpnew.",	VXR(4, 135,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3568  {"vpmsumw",	VX (4,1160),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3569  {"vcmpequw.",	VXR(4, 134,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3570  {"udi2fcm.",	APU(4, 579,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3571  {"udi2fcm",	APU(4, 579,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3572  {"machhwsuo",	XO (4,	76,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3573  {"machhwsuo.",	XO (4,	76,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3574  {"ps_merge10",	XOPS(4,592,0),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3575  {"ps_merge10.",	XOPS(4,592,1),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3576  {"vsubudm",	VX (4,1216),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3577  {"evaddusiaaw",	VX (4,1216),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3578  {"bcds.",	VX (4,1217),	VXPS_MASK,   PPCVEC3,	0,		{VD, VA, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3579  {"evaddssiaaw",	VX (4,1217),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3580  {"evsubfusiaaw",VX (4,1218),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3581  {"evsubfssiaaw",VX (4,1219),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3582  {"evmra",	VX (4,1220),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3583  {"vxor",	VX (4,1220),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3584  {"evdivws",	VX (4,1222),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3585  {"vcmpeqfp.",	VXR(4, 198,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3586  {"udi3fcm.",	APU(4, 611,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3587  {"vcmpequd.",	VXR(4, 199,1),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3588  {"udi3fcm",	APU(4, 611,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3589  {"evdivwu",	VX (4,1223),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3590  {"vpmsumd",	VX (4,1224),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3591  {"evaddumiaaw",	VX (4,1224),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3592  {"evaddsmiaaw",	VX (4,1225),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3593  {"evsubfumiaaw",VX (4,1226),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3594  {"evsubfsmiaaw",VX (4,1227),	VX_MASK,     PPCSPE,	0,		{RS, RA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3595  {"vpkudus",	VX (4,1230),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3596  {"machhwso",	XO (4, 108,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3597  {"machhwso.",	XO (4, 108,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3598  {"nmachhwso",	XO (4, 110,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3599  {"nmachhwso.",	XO (4, 110,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3600  {"ps_merge11",	XOPS(4,624,0),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3601  {"ps_merge11.",	XOPS(4,624,1),	XOPS_MASK,   PPCPS,	0,		{FRT, FRA, FRB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3602  {"vsubuqm",	VX (4,1280),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3603  {"evmheusiaaw",	VX (4,1280),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3604  {"bcdtrunc.",	VX (4,1281),	VXPS_MASK,   PPCVEC3,	0,		{VD, VA, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3605  {"evmhessiaaw",	VX (4,1281),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3606  {"vavgsb",	VX (4,1282),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3607  {"evmhessfaaw",	VX (4,1283),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3608  {"evmhousiaaw",	VX (4,1284),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3609  {"vnot",	VX (4,1284),	VX_MASK,     PPCVEC,	0,		{VD, VA, VBA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3610  {"vnor",	VX (4,1284),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3611  {"evmhossiaaw",	VX (4,1285),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3612  {"udi4fcm.",	APU(4, 643,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3613  {"udi4fcm",	APU(4, 643,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3614  {"vcmpnezb.",	VXR(4, 263,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3615  {"evmhossfaaw",	VX (4,1287),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3616  {"evmheumiaaw",	VX (4,1288),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3617  {"vcipher",	VX (4,1288),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3618  {"vcipherlast",	VX (4,1289),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3619  {"evmhesmiaaw",	VX (4,1289),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3620  {"evmhesmfaaw",	VX (4,1291),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3621  {"vgbbd",	VX (4,1292),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3622  {"evmhoumiaaw",	VX (4,1292),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3623  {"evmhosmiaaw",	VX (4,1293),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3624  {"evmhosmfaaw",	VX (4,1295),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3625  {"macchwuo",	XO (4, 140,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3626  {"macchwuo.",	XO (4, 140,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3627  {"evmhegumiaa",	VX (4,1320),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3628  {"evmhegsmiaa",	VX (4,1321),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3629  {"evmhegsmfaa",	VX (4,1323),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3630  {"evmhogumiaa",	VX (4,1324),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3631  {"evmhogsmiaa",	VX (4,1325),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3632  {"evmhogsmfaa",	VX (4,1327),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3633  {"vsubcuq",	VX (4,1344),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3634  {"evmwlusiaaw",	VX (4,1344),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3635  {"bcdutrunc.",	VX (4,1345),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3636  {"evmwlssiaaw",	VX (4,1345),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3637  {"vavgsh",	VX (4,1346),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3638  {"vorc",	VX (4,1348),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3639  {"udi5fcm.",	APU(4, 675,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3640  {"udi5fcm",	APU(4, 675,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3641  {"vcmpnezh.",	VXR(4, 327,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3642  {"vncipher",	VX (4,1352),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3643  {"evmwlumiaaw",	VX (4,1352),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3644  {"vncipherlast",VX (4,1353),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3645  {"evmwlsmiaaw",	VX (4,1353),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3646  {"vbpermq",	VX (4,1356),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3647  {"vpksdus",	VX (4,1358),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3648  {"evmwssfaa",	VX (4,1363),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3649  {"macchwo",	XO (4, 172,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3650  {"evmwumiaa",	VX (4,1368),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3651  {"macchwo.",	XO (4, 172,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3652  {"evmwsmiaa",	VX (4,1369),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3653  {"evmwsmfaa",	VX (4,1371),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3654  {"nmacchwo",	XO (4, 174,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3655  {"nmacchwo.",	XO (4, 174,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3656  {"evmheusianw",	VX (4,1408),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3657  {"vsubcuw",	VX (4,1408),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3658  {"evmhessianw",	VX (4,1409),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3659  {"bcdctsq.",	VXVA(4,1409,0),	VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3660  {"bcdcfsq.",	VXVA(4,1409,2),	VXVAPS_MASK, PPCVEC3,	0,		{VD, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3661  {"bcdctz.",	VXVA(4,1409,4),	VXVAPS_MASK, PPCVEC3,	0,		{VD, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3662  {"bcdctn.",	VXVA(4,1409,5),	VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3663  {"bcdcfz.",	VXVA(4,1409,6),	VXVAPS_MASK, PPCVEC3,	0,		{VD, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3664  {"bcdcfn.",	VXVA(4,1409,7),	VXVAPS_MASK, PPCVEC3,	0,		{VD, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3665  {"bcdsetsgn.",	VXVA(4,1409,31), VXVAPS_MASK, PPCVEC3,	0,		{VD, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3666  {"vavgsw",	VX (4,1410),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3667  {"evmhessfanw",	VX (4,1411),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3668  {"vnand",	VX (4,1412),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3669  {"evmhousianw",	VX (4,1412),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3670  {"evmhossianw",	VX (4,1413),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3671  {"udi6fcm.",	APU(4, 707,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3672  {"udi6fcm",	APU(4, 707,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3673  {"vcmpnezw.",	VXR(4, 391,1),	VXR_MASK,    PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3674  {"evmhossfanw",	VX (4,1415),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3675  {"evmheumianw",	VX (4,1416),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3676  {"evmhesmianw",	VX (4,1417),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3677  {"evmhesmfanw",	VX (4,1419),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3678  {"evmhoumianw",	VX (4,1420),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3679  {"evmhosmianw",	VX (4,1421),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3680  {"evmhosmfanw",	VX (4,1423),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3681  {"macchwsuo",	XO (4, 204,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3682  {"macchwsuo.",	XO (4, 204,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3683  {"evmhegumian",	VX (4,1448),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3684  {"evmhegsmian",	VX (4,1449),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3685  {"evmhegsmfan",	VX (4,1451),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3686  {"evmhogumian",	VX (4,1452),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3687  {"evmhogsmian",	VX (4,1453),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3688  {"evmhogsmfan",	VX (4,1455),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3689  {"evmwlusianw",	VX (4,1472),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3690  {"bcdsr.",	VX (4,1473),	VXPS_MASK,   PPCVEC3,	0,		{VD, VA, VB, PS}},
08d96e0b127e07 Balbir Singh 2017-02-02  3691  {"evmwlssianw",	VX (4,1473),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3692  {"vsld",	VX (4,1476),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3693  {"vcmpgefp.",	VXR(4, 454,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3694  {"udi7fcm.",	APU(4, 739,0),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3695  {"udi7fcm",	APU(4, 739,1),	APU_MASK, PPC405|PPC440, PPC476,	{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3696  {"vsbox",	VX (4,1480),	VXVB_MASK,   PPCVEC2,	0,		{VD, VA}},
08d96e0b127e07 Balbir Singh 2017-02-02  3697  {"evmwlumianw",	VX (4,1480),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3698  {"evmwlsmianw",	VX (4,1481),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3699  {"vbpermd",	VX (4,1484),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3700  {"vpksdss",	VX (4,1486),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3701  {"evmwssfan",	VX (4,1491),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3702  {"macchwso",	XO (4, 236,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3703  {"evmwumian",	VX (4,1496),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3704  {"macchwso.",	XO (4, 236,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3705  {"evmwsmian",	VX (4,1497),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3706  {"evmwsmfan",	VX (4,1499),	VX_MASK,     PPCSPE,	0,		{RS, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3707  {"nmacchwso",	XO (4, 238,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3708  {"nmacchwso.",	XO (4, 238,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3709  {"vsububs",	VX (4,1536),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3710  {"vclzlsbb",	VXVA(4,1538,0), VXVA_MASK,   PPCVEC3,	0,		{RT, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3711  {"vctzlsbb",	VXVA(4,1538,1), VXVA_MASK,   PPCVEC3,	0,		{RT, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3712  {"vnegw",	VXVA(4,1538,6), VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3713  {"vnegd",	VXVA(4,1538,7), VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3714  {"vprtybw",	VXVA(4,1538,8), VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3715  {"vprtybd",	VXVA(4,1538,9), VXVA_MASK,   PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3716  {"vprtybq",	VXVA(4,1538,10), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3717  {"vextsb2w",	VXVA(4,1538,16), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3718  {"vextsh2w",	VXVA(4,1538,17), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3719  {"vextsb2d",	VXVA(4,1538,24), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3720  {"vextsh2d",	VXVA(4,1538,25), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3721  {"vextsw2d",	VXVA(4,1538,26), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3722  {"vctzb",	VXVA(4,1538,28), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3723  {"vctzh",	VXVA(4,1538,29), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3724  {"vctzw",	VXVA(4,1538,30), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3725  {"vctzd",	VXVA(4,1538,31), VXVA_MASK,  PPCVEC3,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3726  {"mfvscr",	VX (4,1540),	VXVAVB_MASK, PPCVEC,	0,		{VD}},
08d96e0b127e07 Balbir Singh 2017-02-02  3727  {"vcmpgtub.",	VXR(4, 518,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3728  {"udi8fcm.",	APU(4, 771,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3729  {"udi8fcm",	APU(4, 771,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3730  {"vsum4ubs",	VX (4,1544),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3731  {"vextublx",	VX (4,1549),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3732  {"vsubuhs",	VX (4,1600),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3733  {"mtvscr",	VX (4,1604),	VXVDVA_MASK, PPCVEC,	0,		{VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3734  {"vcmpgtuh.",	VXR(4, 582,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3735  {"vsum4shs",	VX (4,1608),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3736  {"udi9fcm.",	APU(4, 804,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3737  {"udi9fcm",	APU(4, 804,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3738  {"vextuhlx",	VX (4,1613),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3739  {"vupkhsw",	VX (4,1614),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3740  {"vsubuws",	VX (4,1664),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3741  {"vshasigmaw",	VX (4,1666),	VX_MASK,     PPCVEC2,	0,		{VD, VA, ST, SIX}},
08d96e0b127e07 Balbir Singh 2017-02-02  3742  {"veqv",	VX (4,1668),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3743  {"vcmpgtuw.",	VXR(4, 646,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3744  {"udi10fcm.",	APU(4, 835,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3745  {"udi10fcm",	APU(4, 835,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3746  {"vsum2sws",	VX (4,1672),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3747  {"vmrgow",	VX (4,1676),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3748  {"vextuwlx",	VX (4,1677),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3749  {"vshasigmad",	VX (4,1730),	VX_MASK,     PPCVEC2,	0,		{VD, VA, ST, SIX}},
08d96e0b127e07 Balbir Singh 2017-02-02  3750  {"vsrd",	VX (4,1732),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3751  {"vcmpgtfp.",	VXR(4, 710,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3752  {"udi11fcm.",	APU(4, 867,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3753  {"vcmpgtud.",	VXR(4, 711,1),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3754  {"udi11fcm",	APU(4, 867,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3755  {"vupklsw",	VX (4,1742),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3756  {"vsubsbs",	VX (4,1792),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3757  {"vclzb",	VX (4,1794),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3758  {"vpopcntb",	VX (4,1795),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3759  {"vsrv",	VX (4,1796),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3760  {"vcmpgtsb.",	VXR(4, 774,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3761  {"udi12fcm.",	APU(4, 899,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3762  {"udi12fcm",	APU(4, 899,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3763  {"vsum4sbs",	VX (4,1800),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3764  {"vextubrx",	VX (4,1805),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3765  {"maclhwuo",	XO (4, 396,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3766  {"maclhwuo.",	XO (4, 396,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3767  {"vsubshs",	VX (4,1856),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3768  {"vclzh",	VX (4,1858),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3769  {"vpopcnth",	VX (4,1859),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3770  {"vslv",	VX (4,1860),	VX_MASK,     PPCVEC3,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3771  {"vcmpgtsh.",	VXR(4, 838,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3772  {"vextuhrx",	VX (4,1869),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3773  {"udi13fcm.",	APU(4, 931,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3774  {"udi13fcm",	APU(4, 931,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3775  {"maclhwo",	XO (4, 428,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3776  {"maclhwo.",	XO (4, 428,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3777  {"nmaclhwo",	XO (4, 430,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3778  {"nmaclhwo.",	XO (4, 430,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3779  {"vsubsws",	VX (4,1920),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3780  {"vclzw",	VX (4,1922),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3781  {"vpopcntw",	VX (4,1923),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3782  {"vcmpgtsw.",	VXR(4, 902,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3783  {"udi14fcm.",	APU(4, 963,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3784  {"udi14fcm",	APU(4, 963,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3785  {"vsumsws",	VX (4,1928),	VX_MASK,     PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3786  {"vmrgew",	VX (4,1932),	VX_MASK,     PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3787  {"vextuwrx",	VX (4,1933),	VX_MASK,     PPCVEC3,	0,		{RT, RA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3788  {"maclhwsuo",	XO (4, 460,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3789  {"maclhwsuo.",	XO (4, 460,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3790  {"vclzd",	VX (4,1986),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3791  {"vpopcntd",	VX (4,1987),	VXVA_MASK,   PPCVEC2,	0,		{VD, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3792  {"vcmpbfp.",	VXR(4, 966,1),	VXR_MASK,    PPCVEC,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3793  {"udi15fcm.",	APU(4, 995,0),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3794  {"vcmpgtsd.",	VXR(4, 967,1),	VXR_MASK,    PPCVEC2,	0,		{VD, VA, VB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3795  {"udi15fcm",	APU(4, 995,1),	APU_MASK,    PPC440,	PPC476,		{URT, URA, URB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3796  {"maclhwso",	XO (4, 492,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3797  {"maclhwso.",	XO (4, 492,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3798  {"nmaclhwso",	XO (4, 494,1,0), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3799  {"nmaclhwso.",	XO (4, 494,1,1), XO_MASK,    MULHW,	0,		{RT, RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3800  {"dcbz_l",	X  (4,1014),	XRT_MASK,    PPCPS,	0,		{RA, RB}},
08d96e0b127e07 Balbir Singh 2017-02-02  3801  

:::::: The code at line 3270 was first introduced by commit
:::::: 08d96e0b127e07c3b90e10f1939caf70b456793e powerpc/xmon: Apply binutils changes to upgrade disassembly

:::::: TO: Balbir Singh <bsingharora@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
8zS6hzgmnvJF+v8AB1m8lWqlAQA=

--BXVAT5kNtrzKuDFl--
