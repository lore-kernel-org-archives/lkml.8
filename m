Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAF520707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgFOHOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:14:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:14090 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgFOHOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:14:30 -0400
IronPort-SDR: eFh7dUupNnphsxwAydasiaUuba/cUg0l5PpENyB5QCuey63JYlkzR6aPTDDoxHicELkeSBMRg/
 3YcFq9w4sZkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 23:58:27 -0700
IronPort-SDR: VkoUmulWjGOjF6gLh0479hWQHXERik4GCAp5fGfSiUUgKjgyD97UU8cAHowg1o3ptRjYNB9CEw
 Q408TDEaQcog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="449189206"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2020 23:58:24 -0700
Date:   Mon, 15 Jun 2020 14:58:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Philip Li <philip.li@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec
 2158.6% improvement
Message-ID: <20200615065823.GB57549@shbuild999.sh.intel.com>
References: <20200611040453.GK12456@shao2-debian>
 <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
 <20200612000732.GA23169@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612000732.GA23169@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Jun 12, 2020 at 08:07:32AM +0800, Philip Li wrote:
> On Thu, Jun 11, 2020 at 01:24:09PM -0700, Linus Torvalds wrote:
> > 
> > IOW, rather than the above "just run all fo the lkp scripts",
> > something like how to run the actual individual test would be good.
> > 
> > IOW how do those yaml files translate into _actually_ running the
> > 'stress-ng' program?
> Thanks Linus for your feedback, we will improve this to provide
> more clear reproduce information.
> 
> In the attachment, there's a reproduce script with content like below,
> which is another way to directly run the stress-ng. This helps to show
> which parameters we are using when having this report. Would you mind to
> have a look?
> 
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
> 	online_file="$cpu_dir"/online
> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
> 
> 	file="$cpu_dir"/cpufreq/scaling_governor
> 	[ -f "$file" ] && echo "performance" > "$file"
> done
> 
>  "stress-ng" "--timeout" "30" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "pipe" "--exclude" "spawn,exec,swap"

If you only want to run "vm-splice" case only, you can use "exclude"
option like:

stress-ng --timeout 20 --times --verify --metrics-brief --sequential NR_CPUS --class pipe --exclude="fifo,pipe,sendfile,splice,tee"


Also we've used 0day framework to capture some perf info, pasted below,
hope it could provide some hint, the biggest change is "__get_user_pages"
is almost gone in perf samples:

* perf profile compare

     67.21           -67.2        0.00        pp.bt.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe.do_vmsplice
     65.22           -65.2        0.00        pp.bt.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe
     64.74           -64.7        0.00        pp.bt.follow_page_pte.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages
     67.58           -54.0       13.60        pp.bt.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe.do_vmsplice.__do_sys_vmsplice
     67.67           -51.8       15.83        pp.bt.iov_iter_get_pages.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64
     67.86           -46.3       21.56        pp.bt.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.00           -40.7       29.30        pp.bt.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
     37.33           -37.3        0.00        pp.bt.mark_page_accessed.follow_page_pte.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast

* decouple of __do_sys_vmsplice

  - old commit(f359287765):
	-   70.42%     0.06%  stress-ng-vm-sp  [kernel.kallsyms]         [k] __do_sys_vmsplice
	   - 70.36% __do_sys_vmsplice
	      - 69.95% do_vmsplice.part.0
		 - 67.80% iter_to_pipe
		    - 67.61% iov_iter_get_pages
		       - 67.52% internal_get_user_pages_fast
			  - 67.15% get_user_pages_unlocked
			     - 65.17% __get_user_pages
				- 64.68% follow_page_pte
				   - 37.36% mark_page_accessed
					1.31% workingset_activation
				     26.77% try_grab_page
			       1.37% up_read
			       0.54% down_read
		   1.03% mutex_unlock
		   0.72% wakeup_pipe_readers

  - new commit(17839856fd):
  
	-   41.93%     1.67%  stress-ng-vm-sp  [kernel.kallsyms]   [k] __do_sys_vmsplice
	   - 40.26% __do_sys_vmsplice
	      - 29.49% do_vmsplice.part.0
		 - 21.50% iter_to_pipe
		    - 15.71% iov_iter_get_pages
		       - 13.59% internal_get_user_pages_fast
			  - 11.52% gup_pgd_range
			       1.83% try_grab_compound_head
		      1.67% iov_iter_advance
		      1.22% add_to_pipe
		 - 3.46% mutex_lock
		      1.04% ___might_sleep
		      0.75% __might_sleep
		   1.42% wakeup_pipe_readers
		   1.14% mutex_unlock
	      - 9.01% import_iovec
		 - 7.83% rw_copy_check_uvector
		    - 5.24% _copy_from_user
		       - 2.14% __might_fault
			    1.07% ___might_sleep
			    0.56% __might_sleep
			 1.20% copy_user_generic_unrolled
			 0.84% copy_user_enhanced_fast_string
		    - 1.32% __check_object_size
			 0.53% check_stack_object
		1.31% __fget_light

* detailed compare report
  
      4.43           -99.2%       0.03        perf-stat.i.MPKI
 3.163e+09         +1497.9%  5.055e+10        perf-stat.i.branch-instructions
      1.16            -0.2        0.94        perf-stat.i.branch-miss-rate%
  36601352         +1179.3%  4.682e+08        perf-stat.i.branch-misses
     32.17           -21.8       10.33        perf-stat.i.cache-miss-rate%
  23170333           -97.2%     653650        perf-stat.i.cache-misses
  71808397           -92.2%    5636462        perf-stat.i.cache-references
      1537            +0.5%       1546        perf-stat.i.context-switches
     16.19           -94.0%       0.96        perf-stat.i.cpi
     96108            -0.1%      95989        perf-stat.i.cpu-clock
 2.636e+11            -4.8%   2.51e+11        perf-stat.i.cpu-cycles
    126.06           +19.5%     150.69        perf-stat.i.cpu-migrations
     11310         +5322.6%     613322        perf-stat.i.cycles-between-cache-misses
      0.00            -0.0        0.00        perf-stat.i.dTLB-load-miss-rate%
     47789          +162.6%     125478        perf-stat.i.dTLB-load-misses
 4.223e+09         +1614.0%  7.237e+10        perf-stat.i.dTLB-loads
      0.00            -0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
     17758           -38.2%      10983        perf-stat.i.dTLB-store-misses
 2.541e+09         +1636.8%  4.414e+10        perf-stat.i.dTLB-stores
     99.33            +0.6       99.89        perf-stat.i.iTLB-load-miss-rate%
  23983228         +1653.0%  4.204e+08        perf-stat.i.iTLB-load-misses
     83340          +192.8%     244057        perf-stat.i.iTLB-loads
 1.622e+10         +1506.1%  2.605e+11        perf-stat.i.instructions
    689.90           -10.0%     620.97        perf-stat.i.instructions-per-iTLB-miss
      0.06         +1524.4%       1.04        perf-stat.i.ipc
      2.76            -5.5%       2.61        perf-stat.i.metric.GHz
      0.87           +67.8%       1.47        perf-stat.i.metric.K/sec
    104.92         +1557.3%       1738        perf-stat.i.metric.M/sec
      2973            +0.2%       2979        perf-stat.i.minor-faults
     97.83           -12.3       85.57        perf-stat.i.node-load-miss-rate%
   1777209           -94.8%      91899        perf-stat.i.node-load-misses
     40064           -28.5%      28636        perf-stat.i.node-loads
     98.94           -11.7       87.22        perf-stat.i.node-store-miss-rate%
   1950431           -97.9%      40800        perf-stat.i.node-store-misses
     14881           -17.0%      12357        perf-stat.i.node-stores
      2973            +0.2%       2979        perf-stat.i.page-faults
     96108            -0.1%      95989        perf-stat.i.task-clock
      4.44           -99.5%       0.02        perf-stat.overall.MPKI
      1.13            -0.2        0.93        perf-stat.overall.branch-miss-rate%
     32.29           -20.7       11.60        perf-stat.overall.cache-miss-rate%
     16.30           -94.1%       0.96        perf-stat.overall.cpi
     11380         +3265.0%     382951        perf-stat.overall.cycles-between-cache-misses
      0.00            -0.0        0.00        perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     99.68            +0.3       99.94        perf-stat.overall.iTLB-load-miss-rate%
    673.00            -7.9%     619.63        perf-stat.overall.instructions-per-iTLB-miss
      0.06         +1591.6%       1.04        perf-stat.overall.ipc
     97.65           -21.6       76.08        perf-stat.overall.node-load-miss-rate%
     99.29           -22.6       76.65        perf-stat.overall.node-store-miss-rate%
 3.114e+09         +1502.8%  4.991e+10        perf-stat.ps.branch-instructions
  35311356         +1209.5%  4.624e+08        perf-stat.ps.branch-misses
  22873359           -97.2%     647182        perf-stat.ps.cache-misses
  70844364           -92.1%    5580624        perf-stat.ps.cache-references
      1488            +2.6%       1527        perf-stat.ps.context-switches
     94719            +0.1%      94804        perf-stat.ps.cpu-clock
 2.603e+11            -4.8%  2.478e+11        perf-stat.ps.cpu-cycles
    116.79           +27.4%     148.85        perf-stat.ps.cpu-migrations
     46047          +169.3%     124021        perf-stat.ps.dTLB-load-misses
 4.163e+09         +1616.8%  7.147e+10        perf-stat.ps.dTLB-loads
     17216           -36.8%      10874        perf-stat.ps.dTLB-store-misses
 2.508e+09         +1637.9%  4.359e+10        perf-stat.ps.dTLB-stores
  23732007         +1649.3%  4.152e+08        perf-stat.ps.iTLB-load-misses
     76010          +217.5%     241345        perf-stat.ps.iTLB-loads
 1.597e+10         +1510.6%  2.572e+11        perf-stat.ps.instructions
      2873            +2.7%       2951        perf-stat.ps.minor-faults
   1752026           -94.8%      90903        perf-stat.ps.node-load-misses
     42165           -32.2%      28583        perf-stat.ps.node-loads
   1926258           -97.9%      40352        perf-stat.ps.node-store-misses
     13783           -10.8%      12289        perf-stat.ps.node-stores
      2873            +2.7%       2951        perf-stat.ps.page-faults
     94719            +0.1%      94804        perf-stat.ps.task-clock
 1.283e+12         +1529.3%  2.091e+13        perf-stat.total.instructions
     67.21           -67.2        0.00        pp.bt.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe.do_vmsplice
     65.22           -65.2        0.00        pp.bt.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe
     64.74           -64.7        0.00        pp.bt.follow_page_pte.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages
     67.58           -54.0       13.60        pp.bt.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe.do_vmsplice.__do_sys_vmsplice
     67.67           -51.8       15.83        pp.bt.iov_iter_get_pages.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64
     67.86           -46.3       21.56        pp.bt.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.00           -40.7       29.30        pp.bt.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
     37.33           -37.3        0.00        pp.bt.mark_page_accessed.follow_page_pte.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast
     70.48           -28.4       42.10        pp.bt.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
     26.74           -26.7        0.00        pp.bt.try_grab_page.follow_page_pte.__get_user_pages.get_user_pages_unlocked.internal_get_user_pages_fast
     70.62           -25.9       44.71        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
     70.67           -24.6       46.08        pp.bt.entry_SYSCALL_64_after_hwframe.vmsplice
     24.98           -22.9        2.11        pp.bt.page_cache_pipe_buf_release.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice
     26.15           -16.0       10.15        pp.bt.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice.do_syscall_64
     71.03           -13.1       57.88        pp.bt.vmsplice
     27.50            -8.9       18.57        pp.bt.splice_from_pipe.do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.37            -1.4        0.00        pp.bt.up_read.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe
      1.31            -1.3        0.00        pp.bt.workingset_activation.mark_page_accessed.follow_page_pte.__get_user_pages.get_user_pages_unlocked
      0.54            -0.5        0.00        pp.bt.down_read.get_user_pages_unlocked.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe
     27.81            -0.3       27.46        pp.bt.do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      1.03            +0.1        1.16        pp.bt.mutex_unlock.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52        pp.bt.generic_pipe_buf_confirm.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice
      0.00            +0.5        0.54        pp.bt.fpregs_assert_state_consistent.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +0.5        0.54        pp.bt.check_stack_object.__check_object_size.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice
      0.00            +0.6        0.55        pp.bt.aa_file_perm.common_file_perm.security_file_permission.do_splice.__x64_sys_splice
      0.00            +0.6        0.56        pp.bt.__might_sleep.__might_fault._copy_from_user.rw_copy_check_uvector.import_iovec
      0.00            +0.6        0.61        pp.bt.__x64_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
      0.00            +0.6        0.64        pp.bt.splice_write_null.do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.67        pp.bt.apparmor_file_permission.security_file_permission.do_splice.__x64_sys_splice.do_syscall_64
      0.81            +0.7        1.50        pp.bt.wakeup_pipe_writers.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice
      0.72            +0.7        1.44        pp.bt.wakeup_pipe_readers.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.73        pp.bt.__might_sleep.mutex_lock.splice_from_pipe.do_splice.__x64_sys_splice
      0.00            +0.8        0.75        pp.bt.__might_sleep.mutex_lock.do_vmsplice.__do_sys_vmsplice.do_syscall_64
      0.00            +0.8        0.80        pp.bt.pipe_to_null.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice
      0.00            +0.8        0.85        pp.bt.copy_user_enhanced_fast_string._copy_from_user.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice
      0.00            +0.9        0.95        pp.bt.rw_verify_area.do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        0.97        pp.bt.___might_sleep.__splice_from_pipe.splice_from_pipe.do_splice.__x64_sys_splice
      0.00            +1.1        1.05        pp.bt.___might_sleep.mutex_lock.do_vmsplice.__do_sys_vmsplice.do_syscall_64
      0.00            +1.1        1.08        pp.bt.___might_sleep.__might_fault._copy_from_user.rw_copy_check_uvector.import_iovec
      0.00            +1.1        1.08        pp.bt.___might_sleep.mutex_lock.splice_from_pipe.do_splice.__x64_sys_splice
      0.00            +1.1        1.11        pp.bt.mutex_unlock.splice_from_pipe.do_splice.__x64_sys_splice.do_syscall_64
      0.00            +1.2        1.21        pp.bt.copy_user_generic_unrolled._copy_from_user.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice
      0.00            +1.2        1.23        pp.bt.__check_object_size.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice.do_syscall_64
      0.00            +1.2        1.23        pp.bt.add_to_pipe.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64
      0.00            +1.3        1.33        pp.bt.__fget_light.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
      0.00            +1.4        1.38        pp.bt.syscall_return_via_sysret.splice
      0.00            +1.4        1.40        pp.bt.syscall_return_via_sysret.vmsplice
      0.00            +1.7        1.69        pp.bt.iov_iter_advance.iter_to_pipe.do_vmsplice.__do_sys_vmsplice.do_syscall_64
      0.00            +1.9        1.85        pp.bt.try_grab_compound_head.gup_pgd_range.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe
      0.00            +2.1        2.11        pp.bt.__might_fault._copy_from_user.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice
      0.00            +2.3        2.33        pp.bt.__fget_light.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.77            +2.6        3.37        pp.bt.mutex_lock.splice_from_pipe.do_splice.__x64_sys_splice.do_syscall_64
      0.00            +3.1        3.07        pp.bt.common_file_perm.security_file_permission.do_splice.__x64_sys_splice.do_syscall_64
      0.00            +3.3        3.33        pp.bt.mutex_lock.do_vmsplice.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.95            +3.8       31.74        pp.bt.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +4.5        4.50        pp.bt.security_file_permission.do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.2        5.17        pp.bt._copy_from_user.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice.do_syscall_64
     28.02            +5.6       33.60        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     28.07            +6.9       34.94        pp.bt.entry_SYSCALL_64_after_hwframe.splice
      0.00            +6.9        6.93        pp.bt.entry_SYSCALL_64.vmsplice
      0.00            +7.0        7.05        pp.bt.entry_SYSCALL_64.splice
      0.00            +7.7        7.68        pp.bt.rw_copy_check_uvector.import_iovec.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +9.1        9.13        pp.bt.import_iovec.__do_sys_vmsplice.do_syscall_64.entry_SYSCALL_64_after_hwframe.vmsplice
      0.00           +11.5       11.48        pp.bt.gup_pgd_range.internal_get_user_pages_fast.iov_iter_get_pages.iter_to_pipe.do_vmsplice
     28.44           +18.2       46.63        pp.bt.splice
     67.21           -67.2        0.00        pp.child.get_user_pages_unlocked
     65.24           -65.2        0.00        pp.child.__get_user_pages
     64.75           -64.8        0.00        pp.child.follow_page_pte
     67.59           -53.8       13.78        pp.child.internal_get_user_pages_fast
     67.67           -51.7       15.94        pp.child.iov_iter_get_pages
     67.87           -46.1       21.79        pp.child.iter_to_pipe
     70.02           -40.2       29.85        pp.child.do_vmsplice
     37.40           -37.4        0.00        pp.child.mark_page_accessed
     70.49           -28.1       42.37        pp.child.__do_sys_vmsplice
     26.80           -26.8        0.00        pp.child.try_grab_page
     25.03           -22.9        2.11        pp.child.page_cache_pipe_buf_release
     98.98           -20.5       78.53        pp.child.do_syscall_64
     99.07           -17.8       81.22        pp.child.entry_SYSCALL_64_after_hwframe
     26.17           -15.5       10.65        pp.child.__splice_from_pipe
     71.12           -13.2       57.90        pp.child.vmsplice
     27.51            -8.8       18.73        pp.child.splice_from_pipe
      1.37            -1.4        0.00        pp.child.up_read
      1.31            -1.3        0.00        pp.child.workingset_activation
      0.54            -0.5        0.00        pp.child.down_read
      0.40            -0.4        0.00        pp.child._raw_spin_lock
      0.18            -0.2        0.00        pp.child.__libc_start_main
      0.18            -0.2        0.00        pp.child.main
      0.17            -0.2        0.00        pp.child.ksys_write
      0.17            -0.2        0.00        pp.child.vfs_write
      0.17            -0.2        0.00        pp.child.new_sync_write
      0.16            -0.2        0.00        pp.child.cmd_record
      0.16            -0.2        0.00        pp.child.perf_mmap__push
      0.16            -0.2        0.00        pp.child.__GI___libc_write
      0.16            -0.2        0.00        pp.child.generic_file_write_iter
      0.16            -0.2        0.00        pp.child.__generic_file_write_iter
      0.16            -0.2        0.00        pp.child.generic_perform_write
      0.12            -0.1        0.00        pp.child.iov_iter_copy_from_user_atomic
      0.12            -0.1        0.00        pp.child.copyin
      0.11            -0.1        0.00        pp.child.find_extend_vma
      0.11            -0.1        0.00        pp.child.ret_from_fork
      0.10            -0.1        0.00        pp.child.kthread
      0.10            -0.1        0.00        pp.child.follow_page_mask
      0.09            -0.1        0.00        pp.child.follow_pmd_mask
      0.06            -0.1        0.00        pp.child.page_fault
      0.06            -0.1        0.00        pp.child.do_user_addr_fault
      0.06            -0.1        0.00        pp.child.handle_mm_fault
      0.06            -0.1        0.00        pp.child.__handle_mm_fault
      0.05            -0.1        0.00        pp.child.worker_thread
      0.05            -0.1        0.00        pp.child.process_one_work
      0.05            -0.1        0.00        pp.child.execve
      0.05            -0.1        0.00        pp.child.__x64_sys_execve
      0.05            -0.1        0.00        pp.child.__do_execve_file
      0.05            -0.1        0.00        pp.child.find_vma
      0.05            -0.1        0.00        pp.child.memcpy_erms
      0.08            +0.0        0.10        pp.child.task_tick_fair
      0.10            +0.0        0.13        pp.child.scheduler_tick
     27.82            +0.0       27.85        pp.child.do_splice
      0.13            +0.0        0.18        pp.child.tick_sched_handle
      0.13            +0.0        0.18        pp.child.update_process_times
      0.00            +0.1        0.05        pp.child.perf_mux_hrtimer_handler
      0.00            +0.1        0.09        pp.child.ktime_get_update_offsets_now
      0.00            +0.1        0.10        pp.child.get_user_pages_fast
      0.00            +0.1        0.10        pp.child.vmsplice@plt
      0.00            +0.1        0.11        pp.child.vmsplice_type
      0.15            +0.1        0.26        pp.child.tick_sched_timer
      0.00            +0.1        0.12        pp.child.splice@plt
      0.00            +0.1        0.13        pp.child.pud_huge
      0.06            +0.1        0.21        pp.child.clockevents_program_event
      0.19            +0.2        0.34        pp.child.__hrtimer_run_queues
      0.56            +0.2        0.73        pp.child.__irqentry_text_start
      0.00            +0.2        0.18        pp.child.kill_fasync
      0.05            +0.2        0.25        pp.child.ktime_get
      0.00            +0.3        0.26        pp.child.pmd_huge
      0.00            +0.3        0.26        pp.child.__fdget
      0.37            +0.3        0.69        pp.child.smp_apic_timer_interrupt
      0.32            +0.3        0.65        pp.child.hrtimer_interrupt
      0.00            +0.3        0.34        pp.child.kfree
      0.00            +0.4        0.39        pp.child.splice_from_pipe_next
      0.00            +0.4        0.41        pp.child.wait_for_space
      0.00            +0.5        0.45        pp.child.pipe_lock
      0.00            +0.5        0.46        pp.child.pipe_unlock
      0.00            +0.6        0.56        pp.child.aa_file_perm
      0.00            +0.6        0.57        pp.child.check_stack_object
      0.00            +0.6        0.57        pp.child.get_pipe_info
      0.00            +0.6        0.62        pp.child.__x64_sys_vmsplice
      0.00            +0.7        0.68        pp.child.rcu_all_qs
      0.81            +0.7        1.50        pp.child.wakeup_pipe_writers
      0.00            +0.7        0.71        pp.child.apparmor_file_permission
      0.72            +0.7        1.44        pp.child.wakeup_pipe_readers
      0.00            +0.7        0.73        pp.child.splice_write_null
      0.15            +0.8        0.93        pp.child.copy_user_enhanced_fast_string
      0.00            +0.8        0.84        pp.child.generic_pipe_buf_confirm
      0.00            +0.9        0.87        pp.child.pipe_to_null
      0.00            +0.9        0.88        pp.child.__x86_indirect_thunk_rax
      1.47            +0.9        2.36        pp.child.mutex_unlock
      0.00            +1.0        0.99        pp.child.rw_verify_area
      0.08            +1.0        1.13        pp.child.fpregs_assert_state_consistent
      0.08            +1.2        1.27        pp.child._cond_resched
      0.05            +1.2        1.24        pp.child.add_to_pipe
      0.00            +1.4        1.38        pp.child.__check_object_size
      0.06            +1.4        1.50        pp.child.copy_user_generic_unrolled
      0.05            +1.7        1.71        pp.child.iov_iter_advance
      0.00            +1.9        1.85        pp.child.try_grab_compound_head
      0.09            +2.0        2.08        pp.child.__might_sleep
      0.11            +2.1        2.21        pp.child.__might_fault
      0.12            +3.0        3.17        pp.child.common_file_perm
      0.13            +3.5        3.66        pp.child.__fget_light
      0.32            +3.9        4.20        pp.child.___might_sleep
     27.95            +3.9       31.85        pp.child.__x64_sys_splice
      0.16            +4.4        4.59        pp.child.security_file_permission
      0.23            +5.1        5.36        pp.child._copy_from_user
      1.11            +5.9        7.04        pp.child.mutex_lock
      0.30            +7.2        7.52        pp.child.syscall_return_via_sysret
      0.30            +7.7        7.96        pp.child.rw_copy_check_uvector
      0.35            +8.9        9.21        pp.child.import_iovec
      0.36            +9.0        9.40        pp.child.entry_SYSCALL_64
      0.29           +11.4       11.67        pp.child.gup_pgd_range
     28.53           +18.2       46.70        pp.child.splice
     35.94           -35.9        0.00        pp.self.mark_page_accessed
     26.67           -26.7        0.00        pp.self.try_grab_page
     24.93           -22.9        2.04        pp.self.page_cache_pipe_buf_release
      1.37            -1.4        0.00        pp.self.up_read
      1.31            -1.3        0.00        pp.self.workingset_activation
      0.45            -0.5        0.00        pp.self.down_read
      0.39            -0.4        0.00        pp.self._raw_spin_lock
      0.17            -0.2        0.00        pp.self.follow_page_pte
      0.14            -0.1        0.00        pp.self.__get_user_pages
      0.09            -0.1        0.00        pp.self.follow_page_mask
      0.08            -0.1        0.00        pp.self.follow_pmd_mask
      0.06            -0.1        0.00        pp.self.get_user_pages_unlocked
      0.06            -0.1        0.00        pp.self.find_extend_vma
      0.05            -0.1        0.00        pp.self.memcpy_erms
      0.00            +0.1        0.06        pp.self.get_user_pages_fast
      0.00            +0.1        0.08        pp.self.pud_huge
      0.00            +0.1        0.09        pp.self.ktime_get_update_offsets_now
      0.00            +0.1        0.10        pp.self.vmsplice@plt
      0.00            +0.1        0.11        pp.self.vmsplice_type
      0.00            +0.1        0.12        pp.self.splice@plt
      0.00            +0.2        0.17        pp.self.__fdget
      0.00            +0.2        0.18        pp.self.kill_fasync
      0.00            +0.2        0.20        pp.self.pmd_huge
      0.00            +0.2        0.23        pp.self.ktime_get
      0.00            +0.3        0.28        pp.self.pipe_lock
      0.00            +0.3        0.28        pp.self.kfree
      0.00            +0.3        0.29        pp.self.pipe_unlock
      0.00            +0.3        0.33        pp.self.splice_from_pipe_next
      0.00            +0.3        0.35        pp.self.wait_for_space
      0.00            +0.4        0.38        pp.self.__x86_indirect_thunk_rax
      0.00            +0.4        0.39        pp.self.get_pipe_info
      0.00            +0.5        0.47        pp.self.check_stack_object
      0.00            +0.5        0.50        pp.self.aa_file_perm
      0.00            +0.5        0.51        pp.self.rcu_all_qs
      0.00            +0.5        0.53        pp.self.__might_fault
      0.00            +0.6        0.56        pp.self.__x64_sys_vmsplice
      0.00            +0.6        0.59        pp.self._cond_resched
      0.81            +0.7        1.47        pp.self.wakeup_pipe_writers
      0.00            +0.7        0.66        pp.self.splice_write_null
      0.00            +0.7        0.66        pp.self.apparmor_file_permission
      0.71            +0.7        1.38        pp.self.wakeup_pipe_readers
      0.00            +0.7        0.71        pp.self.security_file_permission
      0.15            +0.7        0.87        pp.self.copy_user_enhanced_fast_string
      1.47            +0.8        2.24        pp.self.mutex_unlock
      0.00            +0.8        0.78        pp.self.__check_object_size
      0.00            +0.8        0.78        pp.self.generic_pipe_buf_confirm
      0.00            +0.8        0.79        pp.self._copy_from_user
      0.00            +0.8        0.81        pp.self.pipe_to_null
      0.00            +0.9        0.88        pp.self.rw_verify_area
      0.08            +1.0        1.09        pp.self.fpregs_assert_state_consistent
      0.05            +1.1        1.19        pp.self.add_to_pipe
      0.00            +1.2        1.20        pp.self.import_iovec
      0.00            +1.3        1.27        pp.self.do_vmsplice
      0.06            +1.3        1.41        pp.self.copy_user_generic_unrolled
      0.05            +1.3        1.40        pp.self.rw_copy_check_uvector
      0.05            +1.5        1.54        pp.self.__x64_sys_splice
      0.05            +1.6        1.63        pp.self.iov_iter_advance
      0.06            +1.6        1.69        pp.self.__do_sys_vmsplice
      0.08            +1.7        1.80        pp.self.__might_sleep
      0.00            +1.8        1.80        pp.self.try_grab_compound_head
      0.95            +1.8        2.79        pp.self.mutex_lock
      0.08            +2.0        2.05        pp.self.iov_iter_get_pages
      0.09            +2.0        2.11        pp.self.internal_get_user_pages_fast
      0.09            +2.3        2.39        pp.self.do_syscall_64
      0.10            +2.5        2.61        pp.self.common_file_perm
      0.10            +2.6        2.73        pp.self.entry_SYSCALL_64_after_hwframe
      0.09            +2.7        2.75        pp.self.do_splice
      0.09            +2.8        2.88        pp.self.iter_to_pipe
      0.12            +3.0        3.13        pp.self.splice
      0.12            +3.0        3.15        pp.self.splice_from_pipe
      0.12            +3.1        3.18        pp.self.vmsplice
      0.13            +3.4        3.56        pp.self.__fget_light
      0.14            +3.5        3.60        pp.self.__splice_from_pipe
      0.31            +3.8        4.07        pp.self.___might_sleep
      0.19            +4.6        4.76        pp.self.entry_SYSCALL_64
      0.30            +7.1        7.44        pp.self.syscall_return_via_sysret
      0.28            +9.2        9.47        pp.self.gup_pgd_range

Thanks,
Feng
