Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC7AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47CF2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHSULO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:11:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:9777 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSULK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:11:10 -0400
IronPort-SDR: XakqnMYyrvG3/F97Cl6geiAYSBRP/DOm5l0zxh2N+4PwGd6llxwJjfEsTrUzknnxRp9D9jMMvl
 HZsa6auvnEIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142821471"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="gz'50?scan'50,208,50";a="142821471"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 13:10:36 -0700
IronPort-SDR: Y4znJU03GHUS/7RyboZPzkn6Ljq1RqFpiGS3HPtt54OCioLgRH+uldTQYp/F6fy1uR0xUMrZus
 rk+yT6tWq81g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="gz'50?scan'50,208,50";a="472366185"
Received: from lkp-server01.sh.intel.com (HELO 4cedd236b688) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2020 13:10:34 -0700
Received: from kbuild by 4cedd236b688 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8UPq-0000XV-1q; Wed, 19 Aug 2020 20:10:34 +0000
Date:   Thu, 20 Aug 2020 04:10:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/android/binder.c:3861: Error: unrecognized keyword/register
 name `l.lwz
Message-ID: <202008200453.ohnhqkjQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18445bf405cb331117bc98427b1ba6f12418ad17
commit: af84b16e3423bd9c1c8d81c44bc0a217f763f6b7 openrisc: uaccess: Use static inline function in access_ok
date:   11 days ago
config: openrisc-randconfig-r022-20200818 (attached as .config)
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
>> drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
>> drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
vim +3861 drivers/android/binder.c

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
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3689  				return -EFAULT;
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
355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30 @3861  				return -EFAULT;
da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3862  			ptr += sizeof(binder_uintptr_t);
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3863  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3864  				/*
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3865  				 * Allocate memory for death notification
2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29 @3866  				 * before taking lock
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

:::::: The code at line 3861 was first introduced by commit
:::::: 355b0502f6efea0ff9492753888772c96972d2a3 Revert "Staging: android: delete android drivers"

:::::: TO: Greg Kroah-Hartman <gregkh@suse.de>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
