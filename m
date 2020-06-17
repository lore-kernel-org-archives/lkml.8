Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D473C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9F21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:26:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:38317 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgFQR0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:26:14 -0400
IronPort-SDR: nNE1QpxoIqOISd/VHpCVRZuaORa5Zzh5OIeNeGtGUSC/tnL+/Q4JX3REWF7KNirr1rUc7AovEQ
 oRGd9J8X4xrA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 10:23:08 -0700
IronPort-SDR: UGKMRapRtQgTRR2vVftOGbjR7Z/Z1iEdo8E98ZVr3g3vLled0wcVat46h4YLSykYp9b/x4g+PI
 RgZxt7AZlnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="gz'50?scan'50,208,50";a="299371589"
Received: from lkp-server02.sh.intel.com (HELO cd649bb48ab3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2020 10:23:06 -0700
Received: from kbuild by cd649bb48ab3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlbmE-00003A-14; Wed, 17 Jun 2020 17:23:06 +0000
Date:   Thu, 18 Jun 2020 01:22:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/cgroup.c:1111:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202006180107.CPytzuNg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69119673bd50b176ded34032fadd41530fb5af21
commit: 0d01da6afc5402f60325c5da31b22f7d56689b49 bpf: implement getsockopt and setsockopt hooks
date:   12 months ago
config: openrisc-randconfig-s032-20200617 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc1-6-g78f577f8-dirty
        git checkout 0d01da6afc5402f60325c5da31b22f7d56689b49
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=openrisc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/bpf/cgroup.c:1073:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] <asn:1> *optlen @@
   kernel/bpf/cgroup.c:1073:21: sparse:     expected int const *__gu_addr
   kernel/bpf/cgroup.c:1073:21: sparse:     got int [noderef] <asn:1> *optlen
>> kernel/bpf/cgroup.c:1111:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] <asn:1> *optlen @@
>> kernel/bpf/cgroup.c:1111:13: sparse:     expected int *__pu_addr
   kernel/bpf/cgroup.c:1111:13: sparse:     got int [noderef] <asn:1> *optlen
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] <asn:1> *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] <asn:1> *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] <asn:1> *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] <asn:1> *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] <asn:1> *from

vim +1111 kernel/bpf/cgroup.c

  1038	
  1039	int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
  1040					       int optname, char __user *optval,
  1041					       int __user *optlen, int max_optlen,
  1042					       int retval)
  1043	{
  1044		struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
  1045		struct bpf_sockopt_kern ctx = {
  1046			.sk = sk,
  1047			.level = level,
  1048			.optname = optname,
  1049			.retval = retval,
  1050		};
  1051		int ret;
  1052	
  1053		/* Opportunistic check to see whether we have any BPF program
  1054		 * attached to the hook so we don't waste time allocating
  1055		 * memory and locking the socket.
  1056		 */
  1057		if (!cgroup_bpf_enabled ||
  1058		    __cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_GETSOCKOPT))
  1059			return retval;
  1060	
  1061		ret = sockopt_alloc_buf(&ctx, max_optlen);
  1062		if (ret)
  1063			return ret;
  1064	
  1065		if (!retval) {
  1066			/* If kernel getsockopt finished successfully,
  1067			 * copy whatever was returned to the user back
  1068			 * into our temporary buffer. Set optlen to the
  1069			 * one that kernel returned as well to let
  1070			 * BPF programs inspect the value.
  1071			 */
  1072	
> 1073			if (get_user(ctx.optlen, optlen)) {
  1074				ret = -EFAULT;
  1075				goto out;
  1076			}
  1077	
  1078			if (ctx.optlen > max_optlen)
  1079				ctx.optlen = max_optlen;
  1080	
  1081			if (copy_from_user(ctx.optval, optval, ctx.optlen) != 0) {
  1082				ret = -EFAULT;
  1083				goto out;
  1084			}
  1085		}
  1086	
  1087		lock_sock(sk);
  1088		ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
  1089					 &ctx, BPF_PROG_RUN);
  1090		release_sock(sk);
  1091	
  1092		if (!ret) {
  1093			ret = -EPERM;
  1094			goto out;
  1095		}
  1096	
  1097		if (ctx.optlen > max_optlen) {
  1098			ret = -EFAULT;
  1099			goto out;
  1100		}
  1101	
  1102		/* BPF programs only allowed to set retval to 0, not some
  1103		 * arbitrary value.
  1104		 */
  1105		if (ctx.retval != 0 && ctx.retval != retval) {
  1106			ret = -EFAULT;
  1107			goto out;
  1108		}
  1109	
  1110		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
> 1111		    put_user(ctx.optlen, optlen)) {
  1112			ret = -EFAULT;
  1113			goto out;
  1114		}
  1115	
  1116		ret = ctx.retval;
  1117	
  1118	out:
  1119		sockopt_free_buf(&ctx);
  1120		return ret;
  1121	}
  1122	EXPORT_SYMBOL(__cgroup_bpf_run_filter_getsockopt);
  1123	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WUpfJ3MiSWEzDvHkAmIcIf0PW37b9EF7AQA=

--7JfCtLOvnd9MIVvH--
