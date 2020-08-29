Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D0BC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473ED207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH2Trl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:47:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:24025 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgH2Trk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:47:40 -0400
IronPort-SDR: 5vBrQQkBcSAQA4RVmzSFC7eFo0h8yi07oxaiVuvdHGoeTA7gwDpdU8VwgBeZIVQ4c5IuO3q46n
 L7tXLLmLqePA==
X-IronPort-AV: E=McAfee;i="6000,8403,9728"; a="144493542"
X-IronPort-AV: E=Sophos;i="5.76,368,1592895600"; 
   d="gz'50?scan'50,208,50";a="144493542"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 12:44:32 -0700
IronPort-SDR: QLDq9s8EHfrca7rNNBg8U9D/FrN9vMKVw+hjqY1NprH+6Ok2EVZAppgPfzDJF4QEhwhGiGIx2J
 pXs/4VFbA8dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,368,1592895600"; 
   d="gz'50?scan'50,208,50";a="332907903"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2020 12:44:29 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kC6m4-0000cj-Tj; Sat, 29 Aug 2020 19:44:28 +0000
Date:   Sun, 30 Aug 2020 03:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>
Subject: drivers/android/binder.c:3779: Error: unrecognized keyword/register
 name `l.addi
Message-ID: <202008300324.QORqBq4y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d41ead6ead97c3730bbd186a601a64828668f01
commit: 4b836a1426cb0f1ef2a6e211d7e553221594f8fc binder: Prevent context manager from incrementing ref 0
date:   4 weeks ago
config: openrisc-randconfig-r016-20200830 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4b836a1426cb0f1ef2a6e211d7e553221594f8fc
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/android/binder.c: Assembler messages:
   drivers/android/binder.c:3774: Error: unrecognized keyword/register name `l.lwz ?ap,4(r25)'
>> drivers/android/binder.c:3779: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b836a1426cb0f1ef2a6e211d7e553221594f8fc
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 4b836a1426cb0f1ef2a6e211d7e553221594f8fc
vim +3779 drivers/android/binder.c

44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3600  
fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3601  static int binder_thread_write(struct binder_proc *proc,
fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3602  			struct binder_thread *thread,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3603  			binder_uintptr_t binder_buffer, size_t size,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3604  			binder_size_t *consumed)
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3605  {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3606  	uint32_t cmd;
342e5c90b60134 drivers/android/binder.c         Martijn Coenen         2017-02-03  3607  	struct binder_context *context = proc->context;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3608  	void __user *buffer = (void __user *)(uintptr_t)binder_buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3609  	void __user *ptr = buffer + *consumed;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3610  	void __user *end = buffer + size;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3611  
26549d17741035 drivers/android/binder.c         Todd Kjos              2017-06-29  3612  	while (ptr < end && thread->return_error.cmd == BR_OK) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3613  		int ret;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3614  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3615  		if (get_user(cmd, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3616  			return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3617  		ptr += sizeof(uint32_t);
975a1ac9a9fe65 drivers/staging/android/binder.c Arve Hjønnevåg         2012-10-16  3618  		trace_binder_command(cmd);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3619  		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3620  			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3621  			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3622  			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3623  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3624  		switch (cmd) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3625  		case BC_INCREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3626  		case BC_ACQUIRE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3627  		case BC_RELEASE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3628  		case BC_DECREFS: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3629  			uint32_t target;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3630  			const char *debug_string;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3631  			bool strong = cmd == BC_ACQUIRE || cmd == BC_RELEASE;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3632  			bool increment = cmd == BC_INCREFS || cmd == BC_ACQUIRE;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3633  			struct binder_ref_data rdata;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3634  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3635  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3636  				return -EFAULT;
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3637  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3638  			ptr += sizeof(uint32_t);
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3639  			ret = -1;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3640  			if (increment && !target) {
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3641  				struct binder_node *ctx_mgr_node;
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3642  				mutex_lock(&context->context_mgr_node_lock);
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3643  				ctx_mgr_node = context->binder_context_mgr_node;
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3644  				if (ctx_mgr_node) {
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3645  					if (ctx_mgr_node->proc == proc) {
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3646  						binder_user_error("%d:%d context manager tried to acquire desc 0\n",
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3647  								  proc->pid, thread->pid);
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3648  						mutex_unlock(&context->context_mgr_node_lock);
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3649  						return -EINVAL;
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3650  					}
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3651  					ret = binder_inc_ref_for_node(
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3652  							proc, ctx_mgr_node,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3653  							strong, NULL, &rdata);
4b836a1426cb0f drivers/android/binder.c         Jann Horn              2020-07-27  3654  				}
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3655  				mutex_unlock(&context->context_mgr_node_lock);
c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3656  			}
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3657  			if (ret)
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3658  				ret = binder_update_ref_for_handle(
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3659  						proc, target, increment, strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3660  						&rdata);
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3661  			if (!ret && rdata.desc != target) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3662  				binder_user_error("%d:%d tried to acquire reference to desc %d, got %d instead\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3663  					proc->pid, thread->pid,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3664  					target, rdata.desc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3665  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3666  			switch (cmd) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3667  			case BC_INCREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3668  				debug_string = "IncRefs";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3669  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3670  			case BC_ACQUIRE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3671  				debug_string = "Acquire";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3672  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3673  			case BC_RELEASE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3674  				debug_string = "Release";
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3675  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3676  			case BC_DECREFS:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3677  			default:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3678  				debug_string = "DecRefs";
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3679  				break;
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3680  			}
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3681  			if (ret) {
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3682  				binder_user_error("%d:%d %s %d refcount change on invalid ref %d ret %d\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3683  					proc->pid, thread->pid, debug_string,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3684  					strong, target, ret);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3685  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3686  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3687  			binder_debug(BINDER_DEBUG_USER_REFS,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3688  				     "%d:%d %s ref %d desc %d s %d w %d\n",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3689  				     proc->pid, thread->pid, debug_string,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3690  				     rdata.debug_id, rdata.desc, rdata.strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3691  				     rdata.weak);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3692  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3693  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3694  		case BC_INCREFS_DONE:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3695  		case BC_ACQUIRE_DONE: {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3696  			binder_uintptr_t node_ptr;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3697  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3698  			struct binder_node *node;
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3699  			bool free_node;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3700  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3701  			if (get_user(node_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3702  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3703  			ptr += sizeof(binder_uintptr_t);
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3704  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3705  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3706  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3707  			node = binder_get_node(proc, node_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3708  			if (node == NULL) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3709  				binder_user_error("%d:%d %s u%016llx no match\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3710  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3711  					cmd == BC_INCREFS_DONE ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3712  					"BC_INCREFS_DONE" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3713  					"BC_ACQUIRE_DONE",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3714  					(u64)node_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3715  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3716  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3717  			if (cookie != node->cookie) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3718  				binder_user_error("%d:%d %s u%016llx node %d cookie mismatch %016llx != %016llx\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3719  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3720  					cmd == BC_INCREFS_DONE ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3721  					"BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3722  					(u64)node_ptr, node->debug_id,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3723  					(u64)cookie, (u64)node->cookie);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3724  				binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3725  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3726  			}
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3727  			binder_node_inner_lock(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3728  			if (cmd == BC_ACQUIRE_DONE) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3729  				if (node->pending_strong_ref == 0) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3730  					binder_user_error("%d:%d BC_ACQUIRE_DONE node %d has no pending acquire request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3731  						proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3732  						node->debug_id);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3733  					binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3734  					binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3735  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3736  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3737  				node->pending_strong_ref = 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3738  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3739  				if (node->pending_weak_ref == 0) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3740  					binder_user_error("%d:%d BC_INCREFS_DONE node %d has no pending increfs request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3741  						proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3742  						node->debug_id);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3743  					binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3744  					binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3745  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3746  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3747  				node->pending_weak_ref = 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3748  			}
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3749  			free_node = binder_dec_node_nilocked(node,
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3750  					cmd == BC_ACQUIRE_DONE, 0);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3751  			WARN_ON(free_node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3752  			binder_debug(BINDER_DEBUG_USER_REFS,
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3753  				     "%d:%d %s node %d ls %d lw %d tr %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3754  				     proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3755  				     cmd == BC_INCREFS_DONE ? "BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3756  				     node->debug_id, node->local_strong_refs,
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3757  				     node->local_weak_refs, node->tmp_refs);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3758  			binder_node_inner_unlock(node);
adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3759  			binder_put_node(node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3760  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3761  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3762  		case BC_ATTEMPT_ACQUIRE:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3763  			pr_err("BC_ATTEMPT_ACQUIRE not supported\n");
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3764  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3765  		case BC_ACQUIRE_RESULT:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3766  			pr_err("BC_ACQUIRE_RESULT not supported\n");
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3767  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3768  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3769  		case BC_FREE_BUFFER: {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3770  			binder_uintptr_t data_ptr;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3771  			struct binder_buffer *buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3772  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3773  			if (get_user(data_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30 @3774  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3775  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3776  
53d311cfa19ad3 drivers/android/binder.c         Todd Kjos              2017-06-29  3777  			buffer = binder_alloc_prepare_to_free(&proc->alloc,
19c987241ca121 drivers/android/binder.c         Todd Kjos              2017-06-29  3778  							      data_ptr);
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06 @3779  			if (IS_ERR_OR_NULL(buffer)) {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3780  				if (PTR_ERR(buffer) == -EPERM) {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3781  					binder_user_error(
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3782  						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3783  						proc->pid, thread->pid,
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3784  						(u64)data_ptr);
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3785  				} else {
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3786  					binder_user_error(
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3787  						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3788  						proc->pid, thread->pid,
7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3789  						(u64)data_ptr);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3790  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3791  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3792  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3793  			binder_debug(BINDER_DEBUG_FREE_BUFFER,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3794  				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3795  				     proc->pid, thread->pid, (u64)data_ptr,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3796  				     buffer->debug_id,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3797  				     buffer->transaction ? "active" : "finished");
44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3798  			binder_free_buf(proc, buffer);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3799  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3800  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3801  
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3802  		case BC_TRANSACTION_SG:
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3803  		case BC_REPLY_SG: {
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3804  			struct binder_transaction_data_sg tr;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3805  
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3806  			if (copy_from_user(&tr, ptr, sizeof(tr)))
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3807  				return -EFAULT;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3808  			ptr += sizeof(tr);
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3809  			binder_transaction(proc, thread, &tr.transaction_data,
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3810  					   cmd == BC_REPLY_SG, tr.buffers_size);
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3811  			break;
7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3812  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3813  		case BC_TRANSACTION:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3814  		case BC_REPLY: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3815  			struct binder_transaction_data tr;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3816  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3817  			if (copy_from_user(&tr, ptr, sizeof(tr)))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3818  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3819  			ptr += sizeof(tr);
4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3820  			binder_transaction(proc, thread, &tr,
4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3821  					   cmd == BC_REPLY, 0);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3822  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3823  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3824  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3825  		case BC_REGISTER_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3826  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3827  				     "%d:%d BC_REGISTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3828  				     proc->pid, thread->pid);
b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3829  			binder_inner_proc_lock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3830  			if (thread->looper & BINDER_LOOPER_STATE_ENTERED) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3831  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3832  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3833  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3834  			} else if (proc->requested_threads == 0) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3835  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3836  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called without request\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3837  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3838  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3839  				proc->requested_threads--;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3840  				proc->requested_threads_started++;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3841  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3842  			thread->looper |= BINDER_LOOPER_STATE_REGISTERED;
b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3843  			binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3844  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3845  		case BC_ENTER_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3846  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3847  				     "%d:%d BC_ENTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3848  				     proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3849  			if (thread->looper & BINDER_LOOPER_STATE_REGISTERED) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3850  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3851  				binder_user_error("%d:%d ERROR: BC_ENTER_LOOPER called after BC_REGISTER_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3852  					proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3853  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3854  			thread->looper |= BINDER_LOOPER_STATE_ENTERED;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3855  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3856  		case BC_EXIT_LOOPER:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3857  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3858  				     "%d:%d BC_EXIT_LOOPER\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3859  				     proc->pid, thread->pid);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3860  			thread->looper |= BINDER_LOOPER_STATE_EXITED;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3861  			break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3862  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3863  		case BC_REQUEST_DEATH_NOTIFICATION:
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3864  		case BC_CLEAR_DEATH_NOTIFICATION: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3865  			uint32_t target;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3866  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3867  			struct binder_ref *ref;
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3868  			struct binder_ref_death *death = NULL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3869  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3870  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3871  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3872  			ptr += sizeof(uint32_t);
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3873  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3874  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3875  			ptr += sizeof(binder_uintptr_t);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3876  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3877  				/*
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3878  				 * Allocate memory for death notification
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3879  				 * before taking lock
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3880  				 */
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3881  				death = kzalloc(sizeof(*death), GFP_KERNEL);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3882  				if (death == NULL) {
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3883  					WARN_ON(thread->return_error.cmd !=
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3884  						BR_OK);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3885  					thread->return_error.cmd = BR_ERROR;
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3886  					binder_enqueue_thread_work(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3887  						thread,
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3888  						&thread->return_error.work);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3889  					binder_debug(
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3890  						BINDER_DEBUG_FAILED_TRANSACTION,
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3891  						"%d:%d BC_REQUEST_DEATH_NOTIFICATION failed\n",
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3892  						proc->pid, thread->pid);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3893  					break;
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3894  				}
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3895  			}
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3896  			binder_proc_lock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3897  			ref = binder_get_ref_olocked(proc, target, false);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3898  			if (ref == NULL) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3899  				binder_user_error("%d:%d %s invalid ref %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3900  					proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3901  					cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3902  					"BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3903  					"BC_CLEAR_DEATH_NOTIFICATION",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3904  					target);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3905  				binder_proc_unlock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3906  				kfree(death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3907  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3908  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3909  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3910  			binder_debug(BINDER_DEBUG_DEATH_NOTIFICATION,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3911  				     "%d:%d %s %016llx ref %d desc %d s %d w %d for node %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3912  				     proc->pid, thread->pid,
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3913  				     cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3914  				     "BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3915  				     "BC_CLEAR_DEATH_NOTIFICATION",
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3916  				     (u64)cookie, ref->data.debug_id,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3917  				     ref->data.desc, ref->data.strong,
372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3918  				     ref->data.weak, ref->node->debug_id);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3919  
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3920  			binder_node_lock(ref->node);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3921  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3922  				if (ref->death) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3923  					binder_user_error("%d:%d BC_REQUEST_DEATH_NOTIFICATION death notification already set\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3924  						proc->pid, thread->pid);
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3925  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3926  					binder_proc_unlock(proc);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3927  					kfree(death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3928  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3929  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3930  				binder_stats_created(BINDER_STAT_DEATH);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3931  				INIT_LIST_HEAD(&death->work.entry);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3932  				death->cookie = cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3933  				ref->death = death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3934  				if (ref->node->proc == NULL) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3935  					ref->death->work.type = BINDER_WORK_DEAD_BINDER;
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3936  
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3937  					binder_inner_proc_lock(proc);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3938  					binder_enqueue_work_ilocked(
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3939  						&ref->death->work, &proc->todo);
bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3940  					binder_wakeup_proc_ilocked(proc);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3941  					binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3942  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3943  			} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3944  				if (ref->death == NULL) {
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3945  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification not active\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3946  						proc->pid, thread->pid);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3947  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3948  					binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3949  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3950  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3951  				death = ref->death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3952  				if (death->cookie != cookie) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3953  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification cookie mismatch %016llx != %016llx\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3954  						proc->pid, thread->pid,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3955  						(u64)death->cookie,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3956  						(u64)cookie);
673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3957  					binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3958  					binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3959  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3960  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3961  				ref->death = NULL;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3962  				binder_inner_proc_lock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3963  				if (list_empty(&death->work.entry)) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3964  					death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3965  					if (thread->looper &
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3966  					    (BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3967  					     BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3968  						binder_enqueue_thread_work_ilocked(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3969  								thread,
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3970  								&death->work);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3971  					else {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3972  						binder_enqueue_work_ilocked(
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3973  								&death->work,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3974  								&proc->todo);
1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3975  						binder_wakeup_proc_ilocked(
408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  3976  								proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3977  					}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3978  				} else {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3979  					BUG_ON(death->work.type != BINDER_WORK_DEAD_BINDER);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3980  					death->work.type = BINDER_WORK_DEAD_BINDER_AND_CLEAR;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3981  				}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3982  				binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3983  			}
ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3984  			binder_node_unlock(ref->node);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3985  			binder_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3986  		} break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3987  		case BC_DEAD_BINDER_DONE: {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3988  			struct binder_work *w;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3989  			binder_uintptr_t cookie;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3990  			struct binder_ref_death *death = NULL;
10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3991  
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3992  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3993  				return -EFAULT;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3994  
7a64cd887fdb97 drivers/android/binder.c         Lisa Du                2016-02-17  3995  			ptr += sizeof(cookie);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3996  			binder_inner_proc_lock(proc);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3997  			list_for_each_entry(w, &proc->delivered_death,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3998  					    entry) {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3999  				struct binder_ref_death *tmp_death =
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4000  					container_of(w,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4001  						     struct binder_ref_death,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4002  						     work);
10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  4003  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4004  				if (tmp_death->cookie == cookie) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4005  					death = tmp_death;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4006  					break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4007  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4008  			}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4009  			binder_debug(BINDER_DEBUG_DEAD_BINDER,
8ca86f1639ec58 drivers/android/binder.c         Todd Kjos              2018-02-07  4010  				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4011  				     proc->pid, thread->pid, (u64)cookie,
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4012  				     death);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4013  			if (death == NULL) {
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4014  				binder_user_error("%d:%d BC_DEAD_BINDER_DONE %016llx not found\n",
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4015  					proc->pid, thread->pid, (u64)cookie);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4016  				binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4017  				break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4018  			}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4019  			binder_dequeue_work_ilocked(&death->work);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4020  			if (death->work.type == BINDER_WORK_DEAD_BINDER_AND_CLEAR) {
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4021  				death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4022  				if (thread->looper &
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4023  					(BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4024  					 BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4025  					binder_enqueue_thread_work_ilocked(
148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4026  						thread, &death->work);
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4027  				else {
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4028  					binder_enqueue_work_ilocked(
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4029  							&death->work,
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4030  							&proc->todo);
408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  4031  					binder_wakeup_proc_ilocked(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4032  				}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4033  			}
72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4034  			binder_inner_proc_unlock(proc);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4035  		} break;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4036  
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4037  		default:
56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  4038  			pr_err("%d:%d unknown command %d\n",
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4039  			       proc->pid, thread->pid, cmd);
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4040  			return -EINVAL;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4041  		}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4042  		*consumed = ptr - buffer;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4043  	}
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4044  	return 0;
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4045  }
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4046  

:::::: The code at line 3779 was first introduced by commit
:::::: 7bada55ab50697861eee6bb7d60b41e68a961a9c binder: fix race that allows malicious free of live buffer

:::::: TO: Todd Kjos <tkjos@android.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
YrOXrNT4iaPVXmhGJIoqLahxX/2uV/q2bqDu7+uH+Zr/vH6kLyT8LTVuwV3OSCzmTduB+iHV
5naCtcMDqXaht6nzHZZl5LNGS6oqx6LfbrzrCJdIy+zSQ3l3xB6PZUJyrGnNLx5F+IP+ZYFX
OxafZ+2mDjXPHfuM5o2EHz2bI4oGQbeaSg2aiv5gh7lyY6gjnIaZ6dEWBo5bEwaJu2EtVEfH
sf7dBsnQMZbZdOTEjJ2YiaubU+cAaEi/gZk752w+5mIxdRKaRtp4eOToDMbMO7p5NTE7A/o4
LqCa8+jVnh2OqNeziRrqKJnpUu94+6Kh+aVbBL8tKQXvZksp+FgNSsE7p1IKPv6PUnC5Cyje
+uLd2H88giGXREIjuNTndZNFs7ow3yihlaMpTOcKIiutytuC/TAuI99sTWHSMqwKTkXoSIrM
K7HY75OFuSmiOKZ35y1m5YUx9QLp4EUYbmxw5GMRvIDrYJRWESciaiOOuEGXVbHRMlQiAk00
ukudozxMGvnGNWyDibJ6d03tA9oNnArlPdx/vKEjlFVQGI8fulPwNwh/1xXWxmOMca20qGoP
w7fCJwpQ9vmTZtE0ybnRYR1xUHNkD3o9Xpl6ezjtWR2sQU0OC09qytyFaGNFx3yuQrrQlEXk
a/LSWUN7i+Q1QswHuvaKIEyhe2giRqumFEV8z7AwWWT86/B6yZc0qB+vwzhnb0Vbc14/PBrF
GosE9JCX+78eXv5+/vzv3dPd58eXu4fX4/Pn97s/D9DO8eHz8fl0+IZL4PPX1z8/qVWxObw9
Hx4vvt+9PRykw2C/On7py35cHJ+PGGhz/O9dE4/Zrju8qIQh+BvLhCBRmBQN54YkJnfcRyvi
JWxFJ217bc53qUW7R9QFnJs7oR3NPiuUWk2dVWTGZ704nYIlYeLnNyZ0r6UlkKD82oRgrukp
LE0/I4UR5aLPWl8F/+3f19PLxT1W+n15u/h+eHylRf0UMUzuytOyFlDwyIaHXsACbVKx8aN8
Tc1gBsJ+BEVsFmiTFvT+p4exhER1Nzru7EmLMSe33uS5Tb3Jc7sFVPNtUmDr3oqZlAZuP9DU
VGCpO7VOXnJaj66Ww9EsqWILkVYxD7Rfn8t/LbD8J7D65VXlGpivboCTGLPOk47tcvEpu/7H
18fj/a9/Hf69uJeL+Nvb3ev3f621WwjP6kFgL6DQ9xkYS1gETJPALrfh6PJyOG876H2cvqOv
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
GIgQXR2XWV3xJn1XwjQ/oe+o0Rl3AQA=

--lrZ03NoBR/3+SXJZ--
