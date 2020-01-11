Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB7C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3563F2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgAKF3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 00:29:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:27631 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgAKF3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 00:29:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 21:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="gz'50?scan'50,208,50";a="423808023"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2020 21:28:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iq9Jy-000CPl-Fi; Sat, 11 Jan 2020 13:28:26 +0800
Date:   Sat, 11 Jan 2020 13:28:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: remove unused guest_enter/exit
Message-ID: <202001111356.vQDhRgyu%lkp@intel.com>
References: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x65czyblvjwzfqf2"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x65czyblvjwzfqf2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Alex,

I love your patch! Yet something to improve:

[auto build test ERROR on kvm/linux-next]
[also build test ERROR on linux/master linus/master v5.5-rc5 next-20200109]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alex-Shi/KVM-remove-unused-guest_enter-exit/20200111-004903
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
config: arm64-randconfig-a001-20200110 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
>> arch/arm64/kvm/../../../virt/kvm/arm/arm.c:861:3: error: implicit declaration of function 'guest_exit'; did you mean 'user_exit'? [-Werror=implicit-function-declaration]
      guest_exit();
      ^~~~~~~~~~
      user_exit
   cc1: some warnings being treated as errors

vim +861 arch/arm64/kvm/../../../virt/kvm/arm/arm.c

0592c005622582 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  687  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  688  /**
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  689   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  690   * @vcpu:	The VCPU pointer
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  691   * @run:	The kvm_run structure pointer used for userspace state exchange
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  692   *
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  693   * This function is called through the VCPU_RUN ioctl called from user space. It
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  694   * will execute VM code in a loop until the time slice for the process is used
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  695   * or some emulation is needed from user space in which case the function will
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  696   * return with return value 0 and with the kvm_run structure filled in with the
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  697   * required data for the requested emulation.
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  698   */
749cf76c5a363e arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  699  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
749cf76c5a363e arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  700  {
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  701  	int ret;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  702  
e8180dcaa8470c arch/arm/kvm/arm.c Andre Przywara    2013-05-09  703  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  704  		return -ENOEXEC;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  705  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  706  	ret = kvm_vcpu_first_run_init(vcpu);
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  707  	if (ret)
829a58635497d7 virt/kvm/arm/arm.c Christoffer Dall  2017-11-29  708  		return ret;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  709  
45e96ea6b36953 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  710  	if (run->exit_reason == KVM_EXIT_MMIO) {
45e96ea6b36953 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  711  		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
45e96ea6b36953 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  712  		if (ret)
829a58635497d7 virt/kvm/arm/arm.c Christoffer Dall  2017-11-29  713  			return ret;
accb757d798c9b virt/kvm/arm/arm.c Christoffer Dall  2017-12-04  714  	}
1eb591288b956b virt/kvm/arm/arm.c Alex Bennée       2017-11-16  715  
829a58635497d7 virt/kvm/arm/arm.c Christoffer Dall  2017-11-29  716  	if (run->immediate_exit)
829a58635497d7 virt/kvm/arm/arm.c Christoffer Dall  2017-11-29  717  		return -EINTR;
45e96ea6b36953 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  718  
829a58635497d7 virt/kvm/arm/arm.c Christoffer Dall  2017-11-29  719  	vcpu_load(vcpu);
460df4c1fc7c00 arch/arm/kvm/arm.c Paolo Bonzini     2017-02-08  720  
20b7035c66bacc virt/kvm/arm/arm.c Jan H. Schönherr  2017-11-24  721  	kvm_sigset_activate(vcpu);
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  722  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  723  	ret = 1;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  724  	run->exit_reason = KVM_EXIT_UNKNOWN;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  725  	while (ret > 0) {
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  726  		/*
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  727  		 * Check conditions before entering the guest
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  728  		 */
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  729  		cond_resched();
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  730  
e329fb75d519e3 virt/kvm/arm/arm.c Christoffer Dall  2018-12-11  731  		update_vmid(&vcpu->kvm->arch.vmid);
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  732  
0592c005622582 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  733  		check_vcpu_requests(vcpu);
0592c005622582 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  734  
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  735  		/*
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  736  		 * Preparing the interrupts to be injected also
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  737  		 * involves poking the GIC, which must be done in a
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  738  		 * non-preemptible context.
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  739  		 */
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  740  		preempt_disable();
328e5664794491 arch/arm/kvm/arm.c Christoffer Dall  2016-03-24  741  
b02386eb7dac75 arch/arm/kvm/arm.c Shannon Zhao      2016-02-26  742  		kvm_pmu_flush_hwstate(vcpu);
328e5664794491 arch/arm/kvm/arm.c Christoffer Dall  2016-03-24  743  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  744  		local_irq_disable();
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  745  
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  746  		kvm_vgic_flush_hwstate(vcpu);
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  747  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  748  		/*
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  749  		 * Exit if we have a signal pending so that we can deliver the
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  750  		 * signal to user space.
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  751  		 */
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  752  		if (signal_pending(current)) {
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  753  			ret = -EINTR;
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  754  			run->exit_reason = KVM_EXIT_INTR;
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  755  		}
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  756  
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  757  		/*
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  758  		 * If we're using a userspace irqchip, then check if we need
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  759  		 * to tell a userspace irqchip about timer or PMU level
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  760  		 * changes and if so, exit to userspace (the actual level
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  761  		 * state gets updated in kvm_timer_update_run and
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  762  		 * kvm_pmu_update_run below).
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  763  		 */
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  764  		if (static_branch_unlikely(&userspace_irqchip_in_use)) {
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  765  			if (kvm_timer_should_notify_user(vcpu) ||
3dbbdf78636e66 arch/arm/kvm/arm.c Christoffer Dall  2017-02-01  766  			    kvm_pmu_should_notify_user(vcpu)) {
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  767  				ret = -EINTR;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  768  				run->exit_reason = KVM_EXIT_INTR;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  769  			}
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  770  		}
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  771  
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  772  		/*
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  773  		 * Ensure we set mode to IN_GUEST_MODE after we disable
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  774  		 * interrupts and before the final VCPU requests check.
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  775  		 * See the comment in kvm_vcpu_exiting_guest_mode() and
2f5947dfcaecb9 virt/kvm/arm/arm.c Christoph Hellwig 2019-07-24  776  		 * Documentation/virt/kvm/vcpu-requests.rst
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  777  		 */
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  778  		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  779  
e329fb75d519e3 virt/kvm/arm/arm.c Christoffer Dall  2018-12-11  780  		if (ret <= 0 || need_new_vmid_gen(&vcpu->kvm->arch.vmid) ||
424c989b1a664a virt/kvm/arm/arm.c Andrew Jones      2017-06-04  781  		    kvm_request_pending(vcpu)) {
6a6d73be12fbe4 virt/kvm/arm/arm.c Andrew Jones      2017-06-04  782  			vcpu->mode = OUTSIDE_GUEST_MODE;
771621b0e2f806 virt/kvm/arm/arm.c Christoffer Dall  2017-10-04  783  			isb(); /* Ensure work in x_flush_hwstate is committed */
b02386eb7dac75 arch/arm/kvm/arm.c Shannon Zhao      2016-02-26  784  			kvm_pmu_sync_hwstate(vcpu);
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  785  			if (static_branch_unlikely(&userspace_irqchip_in_use))
4b4b4512da2a84 arch/arm/kvm/arm.c Christoffer Dall  2015-08-30  786  				kvm_timer_sync_hwstate(vcpu);
1a89dd9113badd arch/arm/kvm/arm.c Marc Zyngier      2013-01-21  787  			kvm_vgic_sync_hwstate(vcpu);
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  788  			local_irq_enable();
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  789  			preempt_enable();
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  790  			continue;
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  791  		}
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  792  
56c7f5e77f797f arch/arm/kvm/arm.c Alex Bennée       2015-07-07  793  		kvm_arm_setup_debug(vcpu);
56c7f5e77f797f arch/arm/kvm/arm.c Alex Bennée       2015-07-07  794  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  795  		/**************************************************************
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  796  		 * Enter the guest
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  797  		 */
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  798  		trace_kvm_entry(*vcpu_pc(vcpu));
6edaa5307f3f51 arch/arm/kvm/arm.c Paolo Bonzini     2016-06-15  799  		guest_enter_irqoff();
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  800  
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  801  		if (has_vhe()) {
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  802  			kvm_arm_vhe_guest_enter();
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  803  			ret = kvm_vcpu_run_vhe(vcpu);
4f5abad9e826bd virt/kvm/arm/arm.c James Morse       2018-01-15  804  			kvm_arm_vhe_guest_exit();
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  805  		} else {
7aa8d14641651a virt/kvm/arm/arm.c Marc Zyngier      2019-01-05  806  			ret = kvm_call_hyp_ret(__kvm_vcpu_run_nvhe, vcpu);
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  807  		}
3f5c90b890acfa virt/kvm/arm/arm.c Christoffer Dall  2017-10-03  808  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  809  		vcpu->mode = OUTSIDE_GUEST_MODE;
b19e6892a90e7c arch/arm/kvm/arm.c Amit Tomar        2015-11-26  810  		vcpu->stat.exits++;
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  811  		/*
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  812  		 * Back from guest
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  813  		 *************************************************************/
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  814  
56c7f5e77f797f arch/arm/kvm/arm.c Alex Bennée       2015-07-07  815  		kvm_arm_clear_debug(vcpu);
56c7f5e77f797f arch/arm/kvm/arm.c Alex Bennée       2015-07-07  816  
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  817  		/*
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  818  		 * We must sync the PMU state before the vgic state so
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  819  		 * that the vgic can properly sample the updated state of the
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  820  		 * interrupt line.
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  821  		 */
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  822  		kvm_pmu_sync_hwstate(vcpu);
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  823  
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  824  		/*
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  825  		 * Sync the vgic state before syncing the timer state because
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  826  		 * the timer code needs to know if the virtual timer
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  827  		 * interrupts are active.
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  828  		 */
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  829  		kvm_vgic_sync_hwstate(vcpu);
ee9bb9a1e3c6e4 virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  830  
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  831  		/*
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  832  		 * Sync the timer hardware state before enabling interrupts as
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  833  		 * we don't want vtimer interrupts to race with syncing the
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  834  		 * timer virtual interrupt state.
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  835  		 */
61bbe380273347 virt/kvm/arm/arm.c Christoffer Dall  2017-10-27  836  		if (static_branch_unlikely(&userspace_irqchip_in_use))
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  837  			kvm_timer_sync_hwstate(vcpu);
b103cc3f10c06f virt/kvm/arm/arm.c Christoffer Dall  2016-10-16  838  
e6b673b741ea0d virt/kvm/arm/arm.c Dave Martin       2018-04-06  839  		kvm_arch_vcpu_ctxsync_fp(vcpu);
e6b673b741ea0d virt/kvm/arm/arm.c Dave Martin       2018-04-06  840  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  841  		/*
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  842  		 * We may have taken a host interrupt in HYP mode (ie
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  843  		 * while executing the guest). This interrupt is still
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  844  		 * pending, as we haven't serviced it yet!
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  845  		 *
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  846  		 * We're now back in SVC mode, with interrupts
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  847  		 * disabled.  Enabling the interrupts now will have
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  848  		 * the effect of taking the interrupt again, in SVC
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  849  		 * mode this time.
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  850  		 */
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  851  		local_irq_enable();
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  852  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  853  		/*
6edaa5307f3f51 arch/arm/kvm/arm.c Paolo Bonzini     2016-06-15  854  		 * We do local_irq_enable() before calling guest_exit() so
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  855  		 * that if a timer interrupt hits while running the guest we
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  856  		 * account that tick as being spent in the guest.  We enable
6edaa5307f3f51 arch/arm/kvm/arm.c Paolo Bonzini     2016-06-15  857  		 * preemption after calling guest_exit() so that if we get
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  858  		 * preempted we make sure ticks after that is not counted as
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  859  		 * guest time.
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  860  		 */
6edaa5307f3f51 arch/arm/kvm/arm.c Paolo Bonzini     2016-06-15 @861  		guest_exit();
b5905dc12ed425 arch/arm/kvm/arm.c Christoffer Dall  2015-08-30  862  		trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
1b3d546daf85ed arch/arm/kvm/arm.c Christoffer Dall  2015-05-28  863  
3368bd809764d3 virt/kvm/arm/arm.c James Morse       2018-01-15  864  		/* Exit types that need handling before we can be preempted */
3368bd809764d3 virt/kvm/arm/arm.c James Morse       2018-01-15  865  		handle_exit_early(vcpu, run, ret);
3368bd809764d3 virt/kvm/arm/arm.c James Morse       2018-01-15  866  
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  867  		preempt_enable();
abdf58438356c7 arch/arm/kvm/arm.c Marc Zyngier      2015-06-08  868  
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  869  		ret = handle_exit(vcpu, run, ret);
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  870  	}
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  871  
d9e1397783765a arch/arm/kvm/arm.c Alexander Graf    2016-09-27  872  	/* Tell userspace about in-kernel device output levels */
3dbbdf78636e66 arch/arm/kvm/arm.c Christoffer Dall  2017-02-01  873  	if (unlikely(!irqchip_in_kernel(vcpu->kvm))) {
d9e1397783765a arch/arm/kvm/arm.c Alexander Graf    2016-09-27  874  		kvm_timer_update_run(vcpu);
3dbbdf78636e66 arch/arm/kvm/arm.c Christoffer Dall  2017-02-01  875  		kvm_pmu_update_run(vcpu);
3dbbdf78636e66 arch/arm/kvm/arm.c Christoffer Dall  2017-02-01  876  	}
d9e1397783765a arch/arm/kvm/arm.c Alexander Graf    2016-09-27  877  
20b7035c66bacc virt/kvm/arm/arm.c Jan H. Schönherr  2017-11-24  878  	kvm_sigset_deactivate(vcpu);
20b7035c66bacc virt/kvm/arm/arm.c Jan H. Schönherr  2017-11-24  879  
accb757d798c9b virt/kvm/arm/arm.c Christoffer Dall  2017-12-04  880  	vcpu_put(vcpu);
f7ed45be3ba524 arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  881  	return ret;
749cf76c5a363e arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  882  }
749cf76c5a363e arch/arm/kvm/arm.c Christoffer Dall  2013-01-20  883  

:::::: The code at line 861 was first introduced by commit
:::::: 6edaa5307f3f51e4e56dc4c63f68a69d88c6ddf5 KVM: remove kvm_guest_enter/exit wrappers

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--x65czyblvjwzfqf2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HN37nr44LRd9+cj7/wAN1iGpvgMCAA==

--x65czyblvjwzfqf2--
