Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51606C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7452221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgIKGix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:38:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:64409 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:38:51 -0400
IronPort-SDR: +TgXCAVxMtDW/kRtqAb/t49DCDJopOGiKH6cBLqkSggjtrZomuyKCin9uE6USCNsRrjDXxdwfe
 ir5YuD3Ar5Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220256932"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="gz'50?scan'50,208,50";a="220256932"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 23:37:22 -0700
IronPort-SDR: KV9G4URy0ofIKPaComL8CwDOcbmiryrowHf0GFFb+3UnkGVP0Xx8agMZG1j8HBu62kdzhrF4Mi
 TjNJGCou672g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="gz'50?scan'50,208,50";a="506107148"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2020 23:37:20 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGcgR-00005U-Cf; Fri, 11 Sep 2020 06:37:19 +0000
Date:   Fri, 11 Sep 2020 14:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/android/binder.c:3689: Error: unrecognized keyword/register
 name `l.lwz
Message-ID: <202009111401.bEXTltMk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Stafford,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   581cb3a26baf846ee9636214afaa5333919875b1
commit: af84b16e3423bd9c1c8d81c44bc0a217f763f6b7 openrisc: uaccess: Use static inline function in access_ok
date:   5 weeks ago
config: openrisc-allmodconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/android/binder.c: Assembler messages:
>> drivers/android/binder.c:3689: Error: unrecognized keyword/register name `l.lwz ?ap,4(r17)'
   drivers/android/binder.c:3694: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
vim +3689 drivers/android/binder.c

44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3594  
fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3595  static int binder_thread_write(struct binder_proc *proc,
fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3596  			struct binder_thread *thread,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3597  			binder_uintptr_t binder_buffer, size_t size,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3598  			binder_size_t *consumed)
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3599  {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3600  	uint32_t cmd;
342e5c90b60134 drivers/android/binder.c         Martijn Coenen         2017-02-03  3601  	struct binder_context *context = proc->context;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3602  	void __user *buffer = (void __user *)(uintptr_t)binder_buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3603  	void __user *ptr = buffer + *consumed;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3604  	void __user *end = buffer + size;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3605  
26549d17741035 drivers/android/binder.c         Todd Kjos              2017-06-29  3606  	while (ptr < end && thread->return_error.cmd == BR_OK) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3607  		int ret;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3608  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3609  		if (get_user(cmd, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3610  			return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3611  		ptr += sizeof(uint32_t);
975a1ac9a9fe65 drivers/staging/android/binder.c Arve Hjønnevåg         2012-10-16  3612  		trace_binder_command(cmd);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3613  		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3614  			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3615  			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3616  			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3617  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3618  		switch (cmd) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3619  		case BC_INCREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3620  		case BC_ACQUIRE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3621  		case BC_RELEASE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3622  		case BC_DECREFS: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3623  			uint32_t target;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3624  			const char *debug_string;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3625  			bool strong = cmd == BC_ACQUIRE || cmd == BC_RELEASE;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3626  			bool increment = cmd == BC_INCREFS || cmd == BC_ACQUIRE;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3627  			struct binder_ref_data rdata;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3628  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3629  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3630  				return -EFAULT;
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3631  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3632  			ptr += sizeof(uint32_t);
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3633  			ret = -1;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3634  			if (increment && !target) {
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3635  				struct binder_node *ctx_mgr_node;
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3636  				mutex_lock(&context->context_mgr_node_lock);
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3637  				ctx_mgr_node = context->binder_context_mgr_node;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3638  				if (ctx_mgr_node)
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3639  					ret = binder_inc_ref_for_node(
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3640  							proc, ctx_mgr_node,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3641  							strong, NULL, &rdata);
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3642  				mutex_unlock(&context->context_mgr_node_lock);
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3643  			}
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3644  			if (ret)
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3645  				ret = binder_update_ref_for_handle(
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3646  						proc, target, increment, strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3647  						&rdata);
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3648  			if (!ret && rdata.desc != target) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3649  				binder_user_error("%d:%d tried to acquire reference to desc %d, got %d instead\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3650  					proc->pid, thread->pid,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3651  					target, rdata.desc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3652  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3653  			switch (cmd) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3654  			case BC_INCREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3655  				debug_string = "IncRefs";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3656  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3657  			case BC_ACQUIRE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3658  				debug_string = "Acquire";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3659  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3660  			case BC_RELEASE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3661  				debug_string = "Release";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3662  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3663  			case BC_DECREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3664  			default:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3665  				debug_string = "DecRefs";
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3666  				break;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3667  			}
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3668  			if (ret) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3669  				binder_user_error("%d:%d %s %d refcount change on invalid ref %d ret %d\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3670  					proc->pid, thread->pid, debug_string,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3671  					strong, target, ret);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3672  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3673  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3674  			binder_debug(BINDER_DEBUG_USER_REFS,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3675  				     "%d:%d %s ref %d desc %d s %d w %d\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3676  				     proc->pid, thread->pid, debug_string,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3677  				     rdata.debug_id, rdata.desc, rdata.strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3678  				     rdata.weak);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3679  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3680  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3681  		case BC_INCREFS_DONE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3682  		case BC_ACQUIRE_DONE: {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3683  			binder_uintptr_t node_ptr;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3684  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3685  			struct binder_node *node;
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3686  			bool free_node;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3687  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3688  			if (get_user(node_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30 @3689  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3690  			ptr += sizeof(binder_uintptr_t);
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3691  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3692  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3693  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3694  			node = binder_get_node(proc, node_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3695  			if (node == NULL) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3696  				binder_user_error("%d:%d %s u%016llx no match\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3697  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3698  					cmd == BC_INCREFS_DONE ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3699  					"BC_INCREFS_DONE" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3700  					"BC_ACQUIRE_DONE",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3701  					(u64)node_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3702  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3703  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3704  			if (cookie != node->cookie) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3705  				binder_user_error("%d:%d %s u%016llx node %d cookie mismatch %016llx != %016llx\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3706  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3707  					cmd == BC_INCREFS_DONE ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3708  					"BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3709  					(u64)node_ptr, node->debug_id,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3710  					(u64)cookie, (u64)node->cookie);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3711  				binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3712  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3713  			}
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3714  			binder_node_inner_lock(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3715  			if (cmd == BC_ACQUIRE_DONE) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3716  				if (node->pending_strong_ref == 0) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3717  					binder_user_error("%d:%d BC_ACQUIRE_DONE node %d has no pending acquire request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3718  						proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3719  						node->debug_id);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3720  					binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3721  					binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3722  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3723  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3724  				node->pending_strong_ref = 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3725  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3726  				if (node->pending_weak_ref == 0) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3727  					binder_user_error("%d:%d BC_INCREFS_DONE node %d has no pending increfs request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3728  						proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3729  						node->debug_id);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3730  					binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3731  					binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3732  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3733  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3734  				node->pending_weak_ref = 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3735  			}
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3736  			free_node = binder_dec_node_nilocked(node,
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3737  					cmd == BC_ACQUIRE_DONE, 0);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3738  			WARN_ON(free_node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3739  			binder_debug(BINDER_DEBUG_USER_REFS,
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3740  				     "%d:%d %s node %d ls %d lw %d tr %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3741  				     proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3742  				     cmd == BC_INCREFS_DONE ? "BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3743  				     node->debug_id, node->local_strong_refs,
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3744  				     node->local_weak_refs, node->tmp_refs);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3745  			binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3746  			binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3747  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3748  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3749  		case BC_ATTEMPT_ACQUIRE:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3750  			pr_err("BC_ATTEMPT_ACQUIRE not supported\n");
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3751  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3752  		case BC_ACQUIRE_RESULT:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3753  			pr_err("BC_ACQUIRE_RESULT not supported\n");
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3754  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3755  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3756  		case BC_FREE_BUFFER: {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3757  			binder_uintptr_t data_ptr;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3758  			struct binder_buffer *buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3759  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3760  			if (get_user(data_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3761  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3762  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3763  
53d311cfa19ad3 drivers/android/binder.c         Todd Kjos              2017-06-29  3764  			buffer = binder_alloc_prepare_to_free(&proc->alloc,
19c987241ca121 drivers/android/binder.c         Todd Kjos              2017-06-29  3765  							      data_ptr);
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3766  			if (IS_ERR_OR_NULL(buffer)) {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3767  				if (PTR_ERR(buffer) == -EPERM) {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3768  					binder_user_error(
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3769  						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3770  						proc->pid, thread->pid,
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3771  						(u64)data_ptr);
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3772  				} else {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3773  					binder_user_error(
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3774  						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3775  						proc->pid, thread->pid,
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3776  						(u64)data_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3777  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3778  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3779  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3780  			binder_debug(BINDER_DEBUG_FREE_BUFFER,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3781  				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3782  				     proc->pid, thread->pid, (u64)data_ptr,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3783  				     buffer->debug_id,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3784  				     buffer->transaction ? "active" : "finished");
44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3785  			binder_free_buf(proc, buffer);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3786  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3787  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3788  
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3789  		case BC_TRANSACTION_SG:
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3790  		case BC_REPLY_SG: {
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3791  			struct binder_transaction_data_sg tr;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3792  
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3793  			if (copy_from_user(&tr, ptr, sizeof(tr)))
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3794  				return -EFAULT;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3795  			ptr += sizeof(tr);
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3796  			binder_transaction(proc, thread, &tr.transaction_data,
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3797  					   cmd == BC_REPLY_SG, tr.buffers_size);
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3798  			break;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3799  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3800  		case BC_TRANSACTION:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3801  		case BC_REPLY: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3802  			struct binder_transaction_data tr;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3803  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3804  			if (copy_from_user(&tr, ptr, sizeof(tr)))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3805  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3806  			ptr += sizeof(tr);
4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3807  			binder_transaction(proc, thread, &tr,
4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3808  					   cmd == BC_REPLY, 0);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3809  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3810  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3811  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3812  		case BC_REGISTER_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3813  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3814  				     "%d:%d BC_REGISTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3815  				     proc->pid, thread->pid);
b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3816  			binder_inner_proc_lock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3817  			if (thread->looper & BINDER_LOOPER_STATE_ENTERED) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3818  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3819  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3820  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3821  			} else if (proc->requested_threads == 0) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3822  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3823  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called without request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3824  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3825  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3826  				proc->requested_threads--;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3827  				proc->requested_threads_started++;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3828  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3829  			thread->looper |= BINDER_LOOPER_STATE_REGISTERED;
b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3830  			binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3831  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3832  		case BC_ENTER_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3833  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3834  				     "%d:%d BC_ENTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3835  				     proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3836  			if (thread->looper & BINDER_LOOPER_STATE_REGISTERED) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3837  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3838  				binder_user_error("%d:%d ERROR: BC_ENTER_LOOPER called after BC_REGISTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3839  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3840  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3841  			thread->looper |= BINDER_LOOPER_STATE_ENTERED;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3842  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3843  		case BC_EXIT_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3844  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3845  				     "%d:%d BC_EXIT_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3846  				     proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3847  			thread->looper |= BINDER_LOOPER_STATE_EXITED;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3848  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3849  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3850  		case BC_REQUEST_DEATH_NOTIFICATION:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3851  		case BC_CLEAR_DEATH_NOTIFICATION: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3852  			uint32_t target;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3853  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3854  			struct binder_ref *ref;
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3855  			struct binder_ref_death *death = NULL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3856  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3857  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3858  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3859  			ptr += sizeof(uint32_t);
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3860  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3861  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3862  			ptr += sizeof(binder_uintptr_t);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3863  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3864  				/*
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3865  				 * Allocate memory for death notification
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3866  				 * before taking lock
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3867  				 */
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3868  				death = kzalloc(sizeof(*death), GFP_KERNEL);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3869  				if (death == NULL) {
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3870  					WARN_ON(thread->return_error.cmd !=
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3871  						BR_OK);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3872  					thread->return_error.cmd = BR_ERROR;
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3873  					binder_enqueue_thread_work(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3874  						thread,
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3875  						&thread->return_error.work);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3876  					binder_debug(
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3877  						BINDER_DEBUG_FAILED_TRANSACTION,
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3878  						"%d:%d BC_REQUEST_DEATH_NOTIFICATION failed\n",
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3879  						proc->pid, thread->pid);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3880  					break;
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3881  				}
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3882  			}
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3883  			binder_proc_lock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3884  			ref = binder_get_ref_olocked(proc, target, false);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3885  			if (ref == NULL) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3886  				binder_user_error("%d:%d %s invalid ref %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3887  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3888  					cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3889  					"BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3890  					"BC_CLEAR_DEATH_NOTIFICATION",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3891  					target);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3892  				binder_proc_unlock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3893  				kfree(death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3894  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3895  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3896  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3897  			binder_debug(BINDER_DEBUG_DEATH_NOTIFICATION,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3898  				     "%d:%d %s %016llx ref %d desc %d s %d w %d for node %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3899  				     proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3900  				     cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3901  				     "BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3902  				     "BC_CLEAR_DEATH_NOTIFICATION",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3903  				     (u64)cookie, ref->data.debug_id,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3904  				     ref->data.desc, ref->data.strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3905  				     ref->data.weak, ref->node->debug_id);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3906  
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3907  			binder_node_lock(ref->node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3908  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3909  				if (ref->death) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3910  					binder_user_error("%d:%d BC_REQUEST_DEATH_NOTIFICATION death notification already set\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3911  						proc->pid, thread->pid);
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3912  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3913  					binder_proc_unlock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3914  					kfree(death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3915  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3916  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3917  				binder_stats_created(BINDER_STAT_DEATH);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3918  				INIT_LIST_HEAD(&death->work.entry);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3919  				death->cookie = cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3920  				ref->death = death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3921  				if (ref->node->proc == NULL) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3922  					ref->death->work.type = BINDER_WORK_DEAD_BINDER;
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3923  
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3924  					binder_inner_proc_lock(proc);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3925  					binder_enqueue_work_ilocked(
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3926  						&ref->death->work, &proc->todo);
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3927  					binder_wakeup_proc_ilocked(proc);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3928  					binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3929  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3930  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3931  				if (ref->death == NULL) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3932  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification not active\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3933  						proc->pid, thread->pid);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3934  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3935  					binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3936  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3937  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3938  				death = ref->death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3939  				if (death->cookie != cookie) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3940  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification cookie mismatch %016llx != %016llx\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3941  						proc->pid, thread->pid,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3942  						(u64)death->cookie,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3943  						(u64)cookie);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3944  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3945  					binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3946  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3947  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3948  				ref->death = NULL;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3949  				binder_inner_proc_lock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3950  				if (list_empty(&death->work.entry)) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3951  					death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3952  					if (thread->looper &
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3953  					    (BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3954  					     BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3955  						binder_enqueue_thread_work_ilocked(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3956  								thread,
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3957  								&death->work);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3958  					else {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3959  						binder_enqueue_work_ilocked(
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3960  								&death->work,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3961  								&proc->todo);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3962  						binder_wakeup_proc_ilocked(
408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  3963  								proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3964  					}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3965  				} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3966  					BUG_ON(death->work.type != BINDER_WORK_DEAD_BINDER);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3967  					death->work.type = BINDER_WORK_DEAD_BINDER_AND_CLEAR;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3968  				}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3969  				binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3970  			}
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3971  			binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3972  			binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3973  		} break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3974  		case BC_DEAD_BINDER_DONE: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3975  			struct binder_work *w;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3976  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3977  			struct binder_ref_death *death = NULL;
10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3978  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3979  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3980  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3981  
7a64cd887fdb97 drivers/android/binder.c         Lisa Du                2016-02-17  3982  			ptr += sizeof(cookie);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3983  			binder_inner_proc_lock(proc);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3984  			list_for_each_entry(w, &proc->delivered_death,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3985  					    entry) {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3986  				struct binder_ref_death *tmp_death =
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3987  					container_of(w,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3988  						     struct binder_ref_death,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3989  						     work);
10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3990  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3991  				if (tmp_death->cookie == cookie) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3992  					death = tmp_death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3993  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3994  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3995  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3996  			binder_debug(BINDER_DEBUG_DEAD_BINDER,
8ca86f1639ec58 drivers/android/binder.c         Todd Kjos              2018-02-07  3997  				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3998  				     proc->pid, thread->pid, (u64)cookie,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3999  				     death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4000  			if (death == NULL) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4001  				binder_user_error("%d:%d BC_DEAD_BINDER_DONE %016llx not found\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4002  					proc->pid, thread->pid, (u64)cookie);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4003  				binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4004  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4005  			}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4006  			binder_dequeue_work_ilocked(&death->work);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4007  			if (death->work.type == BINDER_WORK_DEAD_BINDER_AND_CLEAR) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4008  				death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4009  				if (thread->looper &
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4010  					(BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4011  					 BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4012  					binder_enqueue_thread_work_ilocked(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4013  						thread, &death->work);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4014  				else {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4015  					binder_enqueue_work_ilocked(
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4016  							&death->work,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4017  							&proc->todo);
408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  4018  					binder_wakeup_proc_ilocked(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4019  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4020  			}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4021  			binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4022  		} break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4023  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4024  		default:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  4025  			pr_err("%d:%d unknown command %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4026  			       proc->pid, thread->pid, cmd);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4027  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4028  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4029  		*consumed = ptr - buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4030  	}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4031  	return 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4032  }
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4033  

:::::: The code at line 3689 was first introduced by commit
:::::: 355b0502f6efea0ff9492753888772c96972d2a3 Revert "Staging: android: delete android drivers"

:::::: TO: Greg Kroah-Hartman <gregkh@suse.de>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JiuUAwA=

--3V7upXqbjpZ4EhLz--
