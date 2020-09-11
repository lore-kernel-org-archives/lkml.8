Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D751221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKGTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:19:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:46186 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:19:16 -0400
IronPort-SDR: /SdxfdReRaucdYZULFrBKiyjchoxHLO9Ot+LFjJQePAntRxzuo5RqWUXtaBCIx36wGvN44VVBa
 HmSn39tdT8qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159646269"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="gz'50?scan'50,208,50";a="159646269"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 23:19:12 -0700
IronPort-SDR: o7+HsCQY4PQKowTAUn8/g2nvgL5L1r5/4unQcX2NP0WBlI5BSH6/ewyb4+I1BGH6SwmYN2a6da
 7zR4kEsI0/HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="gz'50?scan'50,208,50";a="285486522"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2020 23:19:10 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGcOr-000053-Ga; Fri, 11 Sep 2020 06:19:09 +0000
Date:   Fri, 11 Sep 2020 14:18:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202009111416.cjcclMUT%lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   581cb3a26baf846ee9636214afaa5333919875b1
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   4 months ago
config: powerpc-mpc8272_ads_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
>> arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
    1172 |  unsigned int word, suffix;
         |                     ^~~~~~
   arch/powerpc/lib/sstep.c:1168:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
    1168 |  unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                               ^~
   cc1: all warnings being treated as errors

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650b55b707fdfa764e9f2b81314d3eb4216fb962
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
vim +/suffix +1172 arch/powerpc/lib/sstep.c

  1153	
  1154	/*
  1155	 * Decode an instruction, and return information about it in *op
  1156	 * without changing *regs.
  1157	 * Integer arithmetic and logical instructions, branches, and barrier
  1158	 * instructions can be emulated just using the information in *op.
  1159	 *
  1160	 * Return value is 1 if the instruction can be emulated just by
  1161	 * updating *regs with the information in *op, -1 if we need the
  1162	 * GPRs but *regs doesn't contain the full register set, or 0
  1163	 * otherwise.
  1164	 */
  1165	int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
  1166			  struct ppc_inst instr)
  1167	{
  1168		unsigned int opcode, ra, rb, rc, rd, spr, u;
  1169		unsigned long int imm;
  1170		unsigned long int val, val2;
  1171		unsigned int mb, me, sh;
> 1172		unsigned int word, suffix;
  1173		long ival;
  1174	
  1175		word = ppc_inst_val(instr);
  1176		suffix = ppc_inst_suffix(instr);
  1177	
  1178		op->type = COMPUTE;
  1179	
  1180		opcode = ppc_inst_primary_opcode(instr);
  1181		switch (opcode) {
  1182		case 16:	/* bc */
  1183			op->type = BRANCH;
  1184			imm = (signed short)(word & 0xfffc);
  1185			if ((word & 2) == 0)
  1186				imm += regs->nip;
  1187			op->val = truncate_if_32bit(regs->msr, imm);
  1188			if (word & 1)
  1189				op->type |= SETLK;
  1190			if (branch_taken(word, regs, op))
  1191				op->type |= BRTAKEN;
  1192			return 1;
  1193	#ifdef CONFIG_PPC64
  1194		case 17:	/* sc */
  1195			if ((word & 0xfe2) == 2)
  1196				op->type = SYSCALL;
  1197			else
  1198				op->type = UNKNOWN;
  1199			return 0;
  1200	#endif
  1201		case 18:	/* b */
  1202			op->type = BRANCH | BRTAKEN;
  1203			imm = word & 0x03fffffc;
  1204			if (imm & 0x02000000)
  1205				imm -= 0x04000000;
  1206			if ((word & 2) == 0)
  1207				imm += regs->nip;
  1208			op->val = truncate_if_32bit(regs->msr, imm);
  1209			if (word & 1)
  1210				op->type |= SETLK;
  1211			return 1;
  1212		case 19:
  1213			switch ((word >> 1) & 0x3ff) {
  1214			case 0:		/* mcrf */
  1215				op->type = COMPUTE + SETCC;
  1216				rd = 7 - ((word >> 23) & 0x7);
  1217				ra = 7 - ((word >> 18) & 0x7);
  1218				rd *= 4;
  1219				ra *= 4;
  1220				val = (regs->ccr >> ra) & 0xf;
  1221				op->ccval = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
  1222				return 1;
  1223	
  1224			case 16:	/* bclr */
  1225			case 528:	/* bcctr */
  1226				op->type = BRANCH;
  1227				imm = (word & 0x400)? regs->ctr: regs->link;
  1228				op->val = truncate_if_32bit(regs->msr, imm);
  1229				if (word & 1)
  1230					op->type |= SETLK;
  1231				if (branch_taken(word, regs, op))
  1232					op->type |= BRTAKEN;
  1233				return 1;
  1234	
  1235			case 18:	/* rfid, scary */
  1236				if (regs->msr & MSR_PR)
  1237					goto priv;
  1238				op->type = RFI;
  1239				return 0;
  1240	
  1241			case 150:	/* isync */
  1242				op->type = BARRIER | BARRIER_ISYNC;
  1243				return 1;
  1244	
  1245			case 33:	/* crnor */
  1246			case 129:	/* crandc */
  1247			case 193:	/* crxor */
  1248			case 225:	/* crnand */
  1249			case 257:	/* crand */
  1250			case 289:	/* creqv */
  1251			case 417:	/* crorc */
  1252			case 449:	/* cror */
  1253				op->type = COMPUTE + SETCC;
  1254				ra = (word >> 16) & 0x1f;
  1255				rb = (word >> 11) & 0x1f;
  1256				rd = (word >> 21) & 0x1f;
  1257				ra = (regs->ccr >> (31 - ra)) & 1;
  1258				rb = (regs->ccr >> (31 - rb)) & 1;
  1259				val = (word >> (6 + ra * 2 + rb)) & 1;
  1260				op->ccval = (regs->ccr & ~(1UL << (31 - rd))) |
  1261					(val << (31 - rd));
  1262				return 1;
  1263			}
  1264			break;
  1265		case 31:
  1266			switch ((word >> 1) & 0x3ff) {
  1267			case 598:	/* sync */
  1268				op->type = BARRIER + BARRIER_SYNC;
  1269	#ifdef __powerpc64__
  1270				switch ((word >> 21) & 3) {
  1271				case 1:		/* lwsync */
  1272					op->type = BARRIER + BARRIER_LWSYNC;
  1273					break;
  1274				case 2:		/* ptesync */
  1275					op->type = BARRIER + BARRIER_PTESYNC;
  1276					break;
  1277				}
  1278	#endif
  1279				return 1;
  1280	
  1281			case 854:	/* eieio */
  1282				op->type = BARRIER + BARRIER_EIEIO;
  1283				return 1;
  1284			}
  1285			break;
  1286		}
  1287	
  1288		/* Following cases refer to regs->gpr[], so we need all regs */
  1289		if (!FULL_REGS(regs))
  1290			return -1;
  1291	
  1292		rd = (word >> 21) & 0x1f;
  1293		ra = (word >> 16) & 0x1f;
  1294		rb = (word >> 11) & 0x1f;
  1295		rc = (word >> 6) & 0x1f;
  1296	
  1297		switch (opcode) {
  1298	#ifdef __powerpc64__
  1299		case 2:		/* tdi */
  1300			if (rd & trap_compare(regs->gpr[ra], (short) word))
  1301				goto trap;
  1302			return 1;
  1303	#endif
  1304		case 3:		/* twi */
  1305			if (rd & trap_compare((int)regs->gpr[ra], (short) word))
  1306				goto trap;
  1307			return 1;
  1308	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2fHTh5uZTiUOsy+g--
