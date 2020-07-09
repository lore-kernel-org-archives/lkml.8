Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB1DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A2620708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGII4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:56:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:6485 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgGII4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:56:41 -0400
IronPort-SDR: 26ciCma1FlfgfQq7pAMjw5cApgB5uga/+qc+sTKuODQLnhNjpvaeN4TkB6Rv4z0J43ke3edvgL
 5rF65B5aYc/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="135415836"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="135415836"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 01:56:37 -0700
IronPort-SDR: InR/UtY+lFEncHHAmJxzqzoaXvXQE2GUpDlHWZAnQF9rajvThMS/gvuuOPbyDxq226gt9IKZX8
 FSxHt2bkYNlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="323187262"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2020 01:56:35 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtSM6-0000X7-JX; Thu, 09 Jul 2020 08:56:34 +0000
Date:   Thu, 9 Jul 2020 16:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: arch/mips/kvm/emulate.c:1734:28: warning: right shift count >= width
 of type
Message-ID: <202007091628.UzzEfrjS%lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: dc6d95b153e78ed70b1b2c04aadffb76bcd2b3ec KVM: MIPS: Add more MMIO load/store instructions emulation
date:   5 weeks ago
config: mips-randconfig-r031-20200709 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dc6d95b153e78ed70b1b2c04aadffb76bcd2b3ec
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/kvm/emulate.c:946:23: warning: no previous prototype for 'kvm_mips_emul_eret' [-Wmissing-prototypes]
     946 | enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c:1029:23: warning: no previous prototype for 'kvm_mips_emul_tlbr' [-Wmissing-prototypes]
    1029 | enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c:1102:23: warning: no previous prototype for 'kvm_mips_emul_tlbwi' [-Wmissing-prototypes]
    1102 | enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c:1138:23: warning: no previous prototype for 'kvm_mips_emul_tlbwr' [-Wmissing-prototypes]
    1138 | enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c:1163:23: warning: no previous prototype for 'kvm_mips_emul_tlbp' [-Wmissing-prototypes]
    1163 | enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c: In function 'kvm_mips_emulate_store':
>> arch/mips/kvm/emulate.c:1734:28: warning: right shift count >= width of type [-Wshift-count-overflow]
    1734 |      ((vcpu->arch.gprs[rt] >> 56) & 0xff);
         |                            ^~
   arch/mips/kvm/emulate.c:1738:28: warning: right shift count >= width of type [-Wshift-count-overflow]
    1738 |      ((vcpu->arch.gprs[rt] >> 48) & 0xffff);
         |                            ^~
   arch/mips/kvm/emulate.c:1742:28: warning: right shift count >= width of type [-Wshift-count-overflow]
    1742 |      ((vcpu->arch.gprs[rt] >> 40) & 0xffffff);
         |                            ^~
   arch/mips/kvm/emulate.c:1746:28: warning: right shift count >= width of type [-Wshift-count-overflow]
    1746 |      ((vcpu->arch.gprs[rt] >> 32) & 0xffffffff);
         |                            ^~
>> arch/mips/kvm/emulate.c:1796:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    1796 |      (vcpu->arch.gprs[rt] << 32);
         |                           ^~
   arch/mips/kvm/emulate.c:1800:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    1800 |      (vcpu->arch.gprs[rt] << 40);
         |                           ^~
   arch/mips/kvm/emulate.c:1804:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    1804 |      (vcpu->arch.gprs[rt] << 48);
         |                           ^~
   arch/mips/kvm/emulate.c:1808:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    1808 |      (vcpu->arch.gprs[rt] << 56);
         |                           ^~

vim +1734 arch/mips/kvm/emulate.c

  1637	
  1638		case sw_op:
  1639			run->mmio.len = 4;
  1640			*(u32 *)data = vcpu->arch.gprs[rt];
  1641	
  1642			kvm_debug("[%#lx] OP_SW: eaddr: %#lx, gpr: %#lx, data: %#x\n",
  1643				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1644				  vcpu->arch.gprs[rt], *(u32 *)data);
  1645			break;
  1646	
  1647		case sh_op:
  1648			run->mmio.len = 2;
  1649			*(u16 *)data = vcpu->arch.gprs[rt];
  1650	
  1651			kvm_debug("[%#lx] OP_SH: eaddr: %#lx, gpr: %#lx, data: %#x\n",
  1652				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1653				  vcpu->arch.gprs[rt], *(u16 *)data);
  1654			break;
  1655	
  1656		case sb_op:
  1657			run->mmio.len = 1;
  1658			*(u8 *)data = vcpu->arch.gprs[rt];
  1659	
  1660			kvm_debug("[%#lx] OP_SB: eaddr: %#lx, gpr: %#lx, data: %#x\n",
  1661				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1662				  vcpu->arch.gprs[rt], *(u8 *)data);
  1663			break;
  1664	
  1665		case swl_op:
  1666			run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
  1667						vcpu->arch.host_cp0_badvaddr) & (~0x3);
  1668			run->mmio.len = 4;
  1669			imme = vcpu->arch.host_cp0_badvaddr & 0x3;
  1670			switch (imme) {
  1671			case 0:
  1672				*(u32 *)data = ((*(u32 *)data) & 0xffffff00) |
  1673						(vcpu->arch.gprs[rt] >> 24);
  1674				break;
  1675			case 1:
  1676				*(u32 *)data = ((*(u32 *)data) & 0xffff0000) |
  1677						(vcpu->arch.gprs[rt] >> 16);
  1678				break;
  1679			case 2:
  1680				*(u32 *)data = ((*(u32 *)data) & 0xff000000) |
  1681						(vcpu->arch.gprs[rt] >> 8);
  1682				break;
  1683			case 3:
  1684				*(u32 *)data = vcpu->arch.gprs[rt];
  1685				break;
  1686			default:
  1687				break;
  1688			}
  1689	
  1690			kvm_debug("[%#lx] OP_SWL: eaddr: %#lx, gpr: %#lx, data: %#x\n",
  1691				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1692				  vcpu->arch.gprs[rt], *(u32 *)data);
  1693			break;
  1694	
  1695		case swr_op:
  1696			run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
  1697						vcpu->arch.host_cp0_badvaddr) & (~0x3);
  1698			run->mmio.len = 4;
  1699			imme = vcpu->arch.host_cp0_badvaddr & 0x3;
  1700			switch (imme) {
  1701			case 0:
  1702				*(u32 *)data = vcpu->arch.gprs[rt];
  1703				break;
  1704			case 1:
  1705				*(u32 *)data = ((*(u32 *)data) & 0xff) |
  1706						(vcpu->arch.gprs[rt] << 8);
  1707				break;
  1708			case 2:
  1709				*(u32 *)data = ((*(u32 *)data) & 0xffff) |
  1710						(vcpu->arch.gprs[rt] << 16);
  1711				break;
  1712			case 3:
  1713				*(u32 *)data = ((*(u32 *)data) & 0xffffff) |
  1714						(vcpu->arch.gprs[rt] << 24);
  1715				break;
  1716			default:
  1717				break;
  1718			}
  1719	
  1720			kvm_debug("[%#lx] OP_SWR: eaddr: %#lx, gpr: %#lx, data: %#x\n",
  1721				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1722				  vcpu->arch.gprs[rt], *(u32 *)data);
  1723			break;
  1724	
  1725		case sdl_op:
  1726			run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
  1727						vcpu->arch.host_cp0_badvaddr) & (~0x7);
  1728	
  1729			run->mmio.len = 8;
  1730			imme = vcpu->arch.host_cp0_badvaddr & 0x7;
  1731			switch (imme) {
  1732			case 0:
  1733				*(u64 *)data = ((*(u64 *)data) & 0xffffffffffffff00) |
> 1734						((vcpu->arch.gprs[rt] >> 56) & 0xff);
  1735				break;
  1736			case 1:
  1737				*(u64 *)data = ((*(u64 *)data) & 0xffffffffffff0000) |
> 1738						((vcpu->arch.gprs[rt] >> 48) & 0xffff);
  1739				break;
  1740			case 2:
  1741				*(u64 *)data = ((*(u64 *)data) & 0xffffffffff000000) |
  1742						((vcpu->arch.gprs[rt] >> 40) & 0xffffff);
  1743				break;
  1744			case 3:
  1745				*(u64 *)data = ((*(u64 *)data) & 0xffffffff00000000) |
  1746						((vcpu->arch.gprs[rt] >> 32) & 0xffffffff);
  1747				break;
  1748			case 4:
  1749				*(u64 *)data = ((*(u64 *)data) & 0xffffff0000000000) |
  1750						((vcpu->arch.gprs[rt] >> 24) & 0xffffffffff);
  1751				break;
  1752			case 5:
  1753				*(u64 *)data = ((*(u64 *)data) & 0xffff000000000000) |
  1754						((vcpu->arch.gprs[rt] >> 16) & 0xffffffffffff);
  1755				break;
  1756			case 6:
  1757				*(u64 *)data = ((*(u64 *)data) & 0xff00000000000000) |
  1758						((vcpu->arch.gprs[rt] >> 8) & 0xffffffffffffff);
  1759				break;
  1760			case 7:
  1761				*(u64 *)data = vcpu->arch.gprs[rt];
  1762				break;
  1763			default:
  1764				break;
  1765			}
  1766	
  1767			kvm_debug("[%#lx] OP_SDL: eaddr: %#lx, gpr: %#lx, data: %llx\n",
  1768				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1769				  vcpu->arch.gprs[rt], *(u64 *)data);
  1770			break;
  1771	
  1772		case sdr_op:
  1773			run->mmio.phys_addr = kvm_mips_callbacks->gva_to_gpa(
  1774						vcpu->arch.host_cp0_badvaddr) & (~0x7);
  1775	
  1776			run->mmio.len = 8;
  1777			imme = vcpu->arch.host_cp0_badvaddr & 0x7;
  1778			switch (imme) {
  1779			case 0:
  1780				*(u64 *)data = vcpu->arch.gprs[rt];
  1781				break;
  1782			case 1:
  1783				*(u64 *)data = ((*(u64 *)data) & 0xff) |
  1784						(vcpu->arch.gprs[rt] << 8);
  1785				break;
  1786			case 2:
  1787				*(u64 *)data = ((*(u64 *)data) & 0xffff) |
  1788						(vcpu->arch.gprs[rt] << 16);
  1789				break;
  1790			case 3:
  1791				*(u64 *)data = ((*(u64 *)data) & 0xffffff) |
  1792						(vcpu->arch.gprs[rt] << 24);
  1793				break;
  1794			case 4:
  1795				*(u64 *)data = ((*(u64 *)data) & 0xffffffff) |
> 1796						(vcpu->arch.gprs[rt] << 32);
  1797				break;
  1798			case 5:
  1799				*(u64 *)data = ((*(u64 *)data) & 0xffffffffff) |
  1800						(vcpu->arch.gprs[rt] << 40);
  1801				break;
  1802			case 6:
  1803				*(u64 *)data = ((*(u64 *)data) & 0xffffffffffff) |
  1804						(vcpu->arch.gprs[rt] << 48);
  1805				break;
  1806			case 7:
  1807				*(u64 *)data = ((*(u64 *)data) & 0xffffffffffffff) |
  1808						(vcpu->arch.gprs[rt] << 56);
  1809				break;
  1810			default:
  1811				break;
  1812			}
  1813	
  1814			kvm_debug("[%#lx] OP_SDR: eaddr: %#lx, gpr: %#lx, data: %llx\n",
  1815				  vcpu->arch.pc, vcpu->arch.host_cp0_badvaddr,
  1816				  vcpu->arch.gprs[rt], *(u64 *)data);
  1817			break;
  1818	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
peuDH9SJQpGG/f8Cqz403i97AQA=

--XsQoSWH+UP9D9v3l--
