Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7CDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D8E20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbgDAMyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:54:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:4819 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732490AbgDAMyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:54:09 -0400
IronPort-SDR: 7vhqv+1SaGgHcn4S63azwHUKzVhfjiqTYD/nf/VrBjnxsn1TDkMb8wvLG4KNoaHRAR3vymCEXc
 G6pVObIsoKJg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 05:54:04 -0700
IronPort-SDR: 31yEY6lRdJgYDTw8/FqoOPvmIKCYo87ps6+Amwvk74iWzDx+e/ch7HQRB5w7dAvbbWxf0m4FFu
 NUfugzep3FTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="gz'50?scan'50,208,50";a="295324053"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2020 05:54:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJcsb-0007Wb-Q6; Wed, 01 Apr 2020 20:54:01 +0800
Date:   Wed, 1 Apr 2020 20:53:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [rcu:dev.2020.03.30a 99/116] kernel/rcu/tree.c:2948:4: error:
 implicit declaration of function 'vfree'; did you mean 'kvfree'?
Message-ID: <202004012051.CfqBKkux%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.30a
head:   3cc6f49bd92ebef95e8f98191e27b2fd2600eac0
commit: b76ca6e09d52b27c8157f63ff4131eb8ce7e823f [99/116] rcu/tree: Maintain separate array for vmalloc ptrs
config: sh-j2_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b76ca6e09d52b27c8157f63ff4131eb8ce7e823f
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'kfree_rcu_work':
>> kernel/rcu/tree.c:2948:4: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
    2948 |    vfree(bvhead->records[i]);
         |    ^~~~~
         |    kvfree
   {standard input}: Assembler messages:
   {standard input}:158: Error: unknown opcode
   {standard input}:195: Error: unknown opcode
   {standard input}:269: Error: unknown opcode
   {standard input}:294: Error: unknown opcode
   {standard input}:385: Error: unknown opcode
   {standard input}:454: Error: unknown opcode
   {standard input}:649: Error: unknown opcode
   {standard input}:1219: Error: unknown opcode
   {standard input}:1275: Error: unknown opcode
   {standard input}:1340: Error: unknown opcode
   {standard input}:1706: Error: unknown opcode
   {standard input}:1951: Error: unknown opcode
   {standard input}:2018: Error: unknown opcode
   {standard input}:2230: Error: unknown opcode
   {standard input}:2340: Error: unknown opcode
   {standard input}:2638: Error: unknown opcode
   {standard input}:2683: Error: unknown opcode
   {standard input}:2818: Error: unknown opcode
   {standard input}:3345: Error: unknown opcode
   {standard input}:3364: Error: unknown opcode
   {standard input}:3404: Error: unknown opcode
   {standard input}:3446: Error: unknown opcode
   {standard input}:3457: Error: unknown opcode
   {standard input}:4193: Error: unknown opcode
   {standard input}:4215: Error: unknown opcode
   {standard input}:4275: Error: unknown opcode
   {standard input}:4314: Error: unknown opcode
   {standard input}:4330: Error: unknown opcode
   {standard input}:4382: Error: unknown opcode
   {standard input}:5235: Error: unknown opcode
   {standard input}:5264: Error: unknown opcode
   {standard input}:5332: Error: unknown opcode
   {standard input}:5657: Error: unknown opcode
   {standard input}:6454: Error: unknown opcode
   {standard input}:6841: Error: unknown opcode
   {standard input}:6905: Error: unknown opcode
   {standard input}:7163: Error: unknown opcode
   {standard input}:7195: Error: unknown opcode
   {standard input}:7207: Error: unknown opcode
   {standard input}:7320: Error: unknown opcode
   {standard input}:7337: Error: unknown opcode
   {standard input}:7353: Error: unknown opcode
   {standard input}:7419: Error: unknown opcode
   {standard input}:7428: Error: unknown opcode
   {standard input}:7542: Error: unknown opcode
   {standard input}:7630: Error: unknown opcode
   {standard input}:7663: Error: unknown opcode
   {standard input}:7672: Error: unknown opcode
   {standard input}:7901: Error: unknown opcode
   {standard input}:7991: Error: unknown opcode
   {standard input}:8004: Error: unknown opcode
   {standard input}:8101: Error: unknown opcode
   {standard input}:8277: Error: unknown opcode
   {standard input}:8336: Error: unknown opcode
   {standard input}:8440: Error: unknown opcode
   {standard input}:8941: Error: unknown opcode
   {standard input}:8951: Error: unknown opcode
   {standard input}:9017: Error: unknown opcode
   {standard input}:9088: Error: unknown opcode
   {standard input}:9266: Error: unknown opcode
   {standard input}:9378: Error: unknown opcode
   {standard input}:9845: Error: unknown opcode
   {standard input}:9964: Error: unknown opcode
   {standard input}:10012: Error: unknown opcode
   {standard input}:10054: Error: unknown opcode
   {standard input}:10254: Error: unknown opcode
   {standard input}:10532: Error: unknown opcode
   {standard input}:10605: Error: unknown opcode
   {standard input}:10615: Error: unknown opcode
   {standard input}:10624: Error: unknown opcode
   {standard input}:10670: Error: unknown opcode
   {standard input}:11046: Error: unknown opcode
   {standard input}:11202: Error: unknown opcode
   {standard input}:11250: Error: unknown opcode
   {standard input}:11301: Error: unknown opcode
   {standard input}:11438: Error: unknown opcode
   {standard input}:11754: Error: unknown opcode
   {standard input}:11829: Error: unknown opcode
   {standard input}:12018: Error: unknown opcode
   {standard input}:12027: Error: unknown opcode
   {standard input}:12091: Error: unknown opcode
   {standard input}:12117: Error: unknown opcode
   {standard input}:12213: Error: unknown opcode
   {standard input}:12233: Error: unknown opcode
   {standard input}:12317: Error: unknown opcode
   {standard input}:12486: Error: unknown opcode
   {standard input}:12500: Error: unknown opcode
   {standard input}:12847: Error: unknown opcode
   {standard input}:12905: Error: unknown opcode
   {standard input}:13686: Error: unknown opcode
   {standard input}:14600: Error: unknown opcode
   {standard input}:14612: Error: unknown opcode
   {standard input}:14686: Error: unknown opcode
   {standard input}:14699: Error: unknown opcode
   {standard input}:14746: Error: unknown opcode
   {standard input}:14754: Error: unknown opcode

vim +2948 kernel/rcu/tree.c

  2886	
  2887	/*
  2888	 * This function is invoked in workqueue context after a grace period.
  2889	 * It frees all the objects queued on ->bhead_free or ->head_free.
  2890	 */
  2891	static void kfree_rcu_work(struct work_struct *work)
  2892	{
  2893		unsigned long flags;
  2894		struct kvfree_rcu_bulk_data *bkhead, *bknext;
  2895		struct kvfree_rcu_bulk_data *bvhead, *bvnext;
  2896		struct rcu_head *head, *next;
  2897		struct kfree_rcu_cpu *krcp;
  2898		struct kfree_rcu_cpu_work *krwp;
  2899		int i;
  2900	
  2901		krwp = container_of(to_rcu_work(work),
  2902					struct kfree_rcu_cpu_work, rcu_work);
  2903	
  2904		krcp = krwp->krcp;
  2905		spin_lock_irqsave(&krcp->lock, flags);
  2906		/* Channel 1. */
  2907		bkhead = krwp->bkvhead_free[0];
  2908		krwp->bkvhead_free[0] = NULL;
  2909	
  2910		/* Channel 2. */
  2911		bvhead = krwp->bkvhead_free[1];
  2912		krwp->bkvhead_free[1] = NULL;
  2913	
  2914		/* Channel 3. */
  2915		head = krwp->head_free;
  2916		krwp->head_free = NULL;
  2917		spin_unlock_irqrestore(&krcp->lock, flags);
  2918	
  2919		/* kmalloc()/kfree() channel. */
  2920		for (; bkhead; bkhead = bknext) {
  2921			bknext = bkhead->next;
  2922	
  2923			debug_rcu_bhead_unqueue(bkhead);
  2924	
  2925			rcu_lock_acquire(&rcu_callback_map);
  2926			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
  2927				bkhead->nr_records, bkhead->records);
  2928	
  2929			kfree_bulk(bkhead->nr_records, bkhead->records);
  2930			rcu_lock_release(&rcu_callback_map);
  2931	
  2932			if (cmpxchg(&krcp->bkvcache[0], NULL, bkhead))
  2933				free_page((unsigned long) bkhead);
  2934	
  2935			cond_resched_tasks_rcu_qs();
  2936		}
  2937	
  2938		/* vmalloc()/vfree() channel. */
  2939		for (; bvhead; bvhead = bvnext) {
  2940			bvnext = bvhead->next;
  2941	
  2942			debug_rcu_bhead_unqueue(bvhead);
  2943	
  2944			rcu_lock_acquire(&rcu_callback_map);
  2945			for (i = 0; i < bvhead->nr_records; i++) {
  2946				trace_rcu_invoke_kvfree_callback(rcu_state.name,
  2947					(struct rcu_head *) bvhead->records[i], 0);
> 2948				vfree(bvhead->records[i]);
  2949			}
  2950			rcu_lock_release(&rcu_callback_map);
  2951	
  2952			if (cmpxchg(&krcp->bkvcache[1], NULL, bvhead))
  2953				free_page((unsigned long) bvhead);
  2954	
  2955			cond_resched_tasks_rcu_qs();
  2956		}
  2957	
  2958		/*
  2959		 * This path covers emergency case only due to high
  2960		 * memory pressure also means low memory condition,
  2961		 * when we could not allocate a bulk array.
  2962		 *
  2963		 * Under that condition an object is queued to the
  2964		 * list instead.
  2965		 */
  2966		for (; head; head = next) {
  2967			unsigned long offset = (unsigned long)head->func;
  2968			void *ptr = (void *)head - offset;
  2969	
  2970			next = head->next;
  2971			debug_rcu_head_unqueue((struct rcu_head *)ptr);
  2972			rcu_lock_acquire(&rcu_callback_map);
  2973			trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
  2974	
  2975			if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
  2976				kvfree(ptr);
  2977	
  2978			rcu_lock_release(&rcu_callback_map);
  2979			cond_resched_tasks_rcu_qs();
  2980		}
  2981	}
  2982	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BOKacYhQ+x31HxR3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHeJhF4AAy5jb25maWcAnDxrb+O2st/PrxC2wEWLg22d5yb3Ih8oibZYS6JWpGwnXwRv
ou0azcY5ttN2//2doSyJlEeO7z04QNec4Ws47xnlp3/95LG33fr7crd6XD4///D+qF6qzXJX
PXlfV8/V/3ih9FKpPR4K/Ssgx6uXt39+237zrn69/nX0cfN47U2rzUv17AXrl6+rP95g7mr9
8q+f/gX//wkGv7/CMpv/9rbfLj8+4+SPfzw+ej9PguAX7/bXi19HgBfIdCwmZRCUQpUAufvR
DMGPcsZzJWR6dzu6GI1a3JilkxY0spaImCqZSsqJ1LJbyAKINBYpPwDNWZ6WCbv3eVmkIhVa
sFg88LBDFPnnci7zKYyYy00MqZ69bbV7e+2ugXNLns5Klk/KWCRC312cIy3228kkEzEvNVfa
W229l/UOV2hmxzJgcXOvDx+o4ZIV9tX8QsRhqVisLfyIzXg55XnK43LyILIO3Yb4ADmnQfFD
wmjI4mFohnUod+v28va+9uX7CLj7Mfji4fhsSVA25GNWxLqMpNIpS/jdh59f1i/VLy3N1L2a
iczivv0A/jfQcTeeSSUWZfK54AWnR7sp7dkKxWPhk8dmBUgXcWJDXZYHUY2Ba7I4btgP2NHb
vn3Z/tjuqu8d+wEL1xNVxnLFkWsteeIpz0VgWFlFcu4ydygTJlJ3bCzzgIeljnLOQpFOLOrY
6//kVS9P3vpr71T9fQPg4ymf8VSrbiFzQxRBLYJp6eeShQFT+vDU1mwHzZBDr75Xmy1FEbOs
TDlc2Fo0lWX0gNKYyNR+JxjMYDcZioB4knqWCGPeW8mSCTGJypzjdRIQWJs4B2dseSfnPMk0
LGU0U3uYZnwm4yLVLL8n+WePZcNq7ZsVv+nl9k9vB/t6SzjDdrfcbb3l4+P67WW3evmjRySY
ULIgkLBX/dTtFr4KYRsZcKUQQ5Pn0ExNlWZa0adUwh3fE+WEU7aqGs4nlIyZFubRzC3zoPAU
8epAlBJg9i3gZ8kX8LyUtKka2Z7uDuFsuF4cd1xjQVIOYqL4JPBjYbiyvaB7wO40Ylr/g6SW
mEYgcMA/pI1ArT8GCRZjfXf2yR5HEiVsYcPPOy4TqZ6CqRjz/hoXfVlTQQT3MRLXEFo9fque
3sCae1+r5e5tU23N8P6WBNQyepNcFhl1F9TEoEmAsTpyFiDfqfUbdXCqeso0hyFivUyEztyU
695cuFgwzSSQAqVUy5yTD1ATAE2tOTuNc6/GCgwLCGDANA9JpJzHjJZbP57C5JnxGHJ6si+l
Lg/ZpHNdZAZqBvwUVNSouOA/CUsDR4v00RT8gxKAnpkzVqQQ4dm15WxkY3vlQWHqTUvA8Ap8
NMt8TLhOQGGUnVlzqHowPI5Y6ujd2uC2WtZh8v7vMk2E7TJZdozHY6Bwbi3sM7Br48LZvNB8
0fsJvNYjVj0cJNkiiOwdMuncT0xSFo8tz9LcwR4wRs4eYMJyroQsi9yxxSycCcUbmlnUSHji
szwXNuWniHKfqMOR+ubIsFrMHBaCd29WJ/kUtuFh6EqATRnkzLJv+M0gcEU5S2BdGTSKZh9R
ZNXm63rzffnyWHn8r+oFbAIDXROgVQAz2ql6d/FWI524TLPKLKnXKI39c3hKxYUPkuqwDfrx
TIMfMrXppGLmU6IFC9jLMR9eJp/wxintL1GOwfygHSlzYHqZ0NrHQYxYHoLuptWIiorxGIKO
jMGehtYMFN/AQY0NAecOIyDXGZFjAbHThDTjbjTUrlfA40TW1c3vCyvoMN4fkKH+efdhuXn8
BgHmb48mntzCP/+5KJ+qr/Xv1llv7JTzJs1gNOfghFEeJMR0fg6qGnYErezoHDxbJnOwPSqx
4iWw+MFU52ChGoQOhtYRtP8hAFxCIXEIbLG1VpgwdPECGfEcOM2ShIlmPrxPDBwI4nu+N7jG
Y/B2P14rK0qGx1GRRUAc+P3c0feIUvj6PoMzR5+uz24p22EhHZ1+PjojeeoA7eI0tOuT0K5P
W+368jS023fRkgXtiPWW+jS6Og3tpGt+Gn06De3mNLT3r4loZ6PT0OgQvY92ftpq5ydx0aer
k1Yb3Z66Wn4iHh2zHOCduO3Zadten3LZy/J8dOJLnCQzn85PkplPF6ehXZ3GwafJM7DwSWg3
J6KdJqs3p8jq4qQLXFye+AYnvejFtXMyYxSS6vt688MDf2b5R/Ud3Blv/YopV9sfQisvx2PF
9d3on9H+f63vihkdEyM+yJRL8Bryu7NLy2GU+T1avRwnn/UmN2CIIHDpSxd6ce4L3TPtY3Am
YVbJU7RwPWCdQzoB3PlJDpzHPNDNoRIJRt2yqUgFPGh5OfUdP6YF3EzphFyHcXb9Lsr15ZR0
+Uz8mAS2Rzr8dnW+ZgkxtPfYS6R3zMFgyXKeC8198Ekom95h6Aii1knk2HUDBb6g0zDE5mb3
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

--BOKacYhQ+x31HxR3--
