Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41787C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147FA20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHKLbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:31:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:16879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgHKLbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:31:21 -0400
IronPort-SDR: VSyDwmJJhdq/Kh05WXtJwGg1yX46l2v65nSrOBc8conWzddKFgucFs/4LiJDGYIJMLGlLLBson
 Oq7k+LwiCevg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151380970"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="151380970"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 03:58:18 -0700
IronPort-SDR: 2MtJnitDPvomCNSMZwN3TLPhzsgUKqfEazZ6OOujCORQXBKBO7A55ek5CAcmft495bo21WXgdy
 IxVfoPqKk64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="324728834"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 03:58:16 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5Ryx-0000XA-Od; Tue, 11 Aug 2020 10:58:15 +0000
Date:   Tue, 11 Aug 2020 18:57:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ti/wlcore/main.c:643:34: sparse: sparse:
 context imbalance in 'wlcore_irq_locked' - different lock contexts for basic
 block
Message-ID: <202008111809.NQDh2CXi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00e4db51259a5f936fec1424b884f029479d3981
commit: f0325e38ab39c2e270770b72c79795772ac3b49e wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
date:   4 weeks ago
config: mips-randconfig-s032-20200811 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout f0325e38ab39c2e270770b72c79795772ac3b49e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/ti/wlcore/main.c:643:34: sparse: sparse: context imbalance in 'wlcore_irq_locked' - different lock contexts for basic block

vim +/wlcore_irq_locked +643 drivers/net/wireless/ti/wlcore/main.c

1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  518  
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  519  static int wlcore_irq_locked(struct wl1271 *wl)
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  520  {
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  521  	int ret = 0;
c15f63bffabb99 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-12  522  	u32 intr;
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  523  	int loopcount = WL1271_IRQ_MAX_LOOPS;
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  524  	bool run_tx_queue = true;
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  525  	bool done = false;
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  526  	unsigned int defer_count;
b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  527  	unsigned long flags;
b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  528  
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  529  	/*
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  530  	 * In case edge triggered interrupt must be used, we cannot iterate
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  531  	 * more than once without introducing race conditions with the hardirq.
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  532  	 */
6f921fab584494 drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho  2015-03-18  533  	if (wl->irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  534  		loopcount = 1;
341b7cde6ccc60 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-31  535  
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  536  	wl1271_debug(DEBUG_IRQ, "IRQ work");
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  537  
4cc533830b7e6b drivers/net/wireless/ti/wlcore/main.c     Ido Yariv       2012-07-24  538  	if (unlikely(wl->state != WLCORE_STATE_ON))
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  539  		goto out;
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  540  
fa2648a34e73fb drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19  541  	ret = pm_runtime_get_sync(wl->dev);
fa2648a34e73fb drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19  542  	if (ret < 0) {
fa2648a34e73fb drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19  543  		pm_runtime_put_noidle(wl->dev);
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  544  		goto out;
fa2648a34e73fb drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19  545  	}
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  546  
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  547  	while (!done && loopcount--) {
4e857c58efeb99 drivers/net/wireless/ti/wlcore/main.c     Peter Zijlstra  2014-03-17  548  		smp_mb__after_atomic();
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  549  
75fb4df7f80422 drivers/net/wireless/ti/wlcore/main.c     Eliad Peller    2014-02-10  550  		ret = wlcore_fw_status(wl, wl->fw_status);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  551  		if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  552  			goto err_ret;
53d67a50cd17ac drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2011-12-12  553  
53d67a50cd17ac drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2011-12-12  554  		wlcore_hw_tx_immediate_compl(wl);
53d67a50cd17ac drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2011-12-12  555  
75fb4df7f80422 drivers/net/wireless/ti/wlcore/main.c     Eliad Peller    2014-02-10  556  		intr = wl->fw_status->intr;
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  557  		intr &= WLCORE_ALL_INTR_MASK;
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  558  		if (!intr) {
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  559  			done = true;
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  560  			continue;
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  561  		}
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  562  
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  563  		if (unlikely(intr & WL1271_ACX_INTR_WATCHDOG)) {
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  564  			wl1271_error("HW watchdog interrupt received! starting recovery.");
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  565  			wl->watchdog_recovery = true;
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  566  			ret = -EIO;
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  567  
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  568  			/* restarting the chip. ignore any other interrupt. */
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  569  			goto err_ret;
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  570  		}
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  571  
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  572  		if (unlikely(intr & WL1271_ACX_SW_INTR_WATCHDOG)) {
f5755fe96cb010 drivers/net/wireless/ti/wlcore/main.c     Ido Reis        2012-04-23  573  			wl1271_error("SW watchdog interrupt received! "
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  574  				     "starting recovery.");
afbe37185c0eca drivers/net/wireless/ti/wlcore/main.c     Yoni Divinsky   2012-05-16  575  			wl->watchdog_recovery = true;
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  576  			ret = -EIO;
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  577  
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  578  			/* restarting the chip. ignore any other interrupt. */
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  579  			goto err_ret;
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  580  		}
ccc83b046c0337 drivers/net/wireless/wl12xx/wl1271_main.c Eliad Peller    2010-10-27  581  
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  582  		if (likely(intr & WL1271_ACX_INTR_DATA)) {
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  583  			wl1271_debug(DEBUG_IRQ, "WL1271_ACX_INTR_DATA");
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  584  
75fb4df7f80422 drivers/net/wireless/ti/wlcore/main.c     Eliad Peller    2014-02-10  585  			ret = wlcore_rx(wl, wl->fw_status);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  586  			if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  587  				goto err_ret;
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  588  
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  589  			/* Check if any tx blocks were freed */
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  590  			if (!test_bit(WL1271_FLAG_FW_TX_BUSY, &wl->flags)) {
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  591  				if (spin_trylock_irqsave(&wl->wl_lock, flags)) {
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  592  					if (!wl1271_tx_total_queue_count(wl))
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  593  						run_tx_queue = false;
b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  594  					spin_unlock_irqrestore(&wl->wl_lock, flags);
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  595  				}
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  596  
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  597  				/*
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  598  				 * In order to avoid starvation of the TX path,
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  599  				 * call the work function directly.
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  600  				 */
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  601  				if (run_tx_queue) {
eb96f841b9563b drivers/net/wireless/ti/wlcore/main.c     Ido Yariv       2012-06-18  602  					ret = wlcore_tx_work_locked(wl);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  603  					if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  604  						goto err_ret;
f0325e38ab39c2 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2020-07-02  605  				}
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  606  			}
a522550a283de3 drivers/net/wireless/wl12xx/wl1271_main.c Ido Yariv       2010-10-12  607  
8aad24642a7c06 drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  608  			/* check for tx results */
045b9b5f4172b2 drivers/net/wireless/ti/wlcore/main.c     Ido Yariv       2012-06-18  609  			ret = wlcore_hw_tx_delayed_compl(wl);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  610  			if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  611  				goto err_ret;
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  612  
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  613  			/* Make sure the deferred queues don't get too long */
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  614  			defer_count = skb_queue_len(&wl->deferred_tx_queue) +
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  615  				      skb_queue_len(&wl->deferred_rx_queue);
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  616  			if (defer_count > WL1271_DEFERRED_QUEUE_LIMIT)
a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv       2011-03-01  617  				wl1271_flush_deferred_work(wl);
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  618  		}
1e73eb62cec7cf drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2010-02-22  619  
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  620  		if (intr & WL1271_ACX_INTR_EVENT_A) {
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  621  			wl1271_debug(DEBUG_IRQ, "WL1271_ACX_INTR_EVENT_A");
045b9b5f4172b2 drivers/net/wireless/ti/wlcore/main.c     Ido Yariv       2012-06-18  622  			ret = wl1271_event_handle(wl, 0);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  623  			if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  624  				goto err_ret;
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  625  		}
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  626  
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  627  		if (intr & WL1271_ACX_INTR_EVENT_B) {
1fd2794f369139 drivers/net/wireless/wl12xx/wl1271_main.c Juuso Oikarinen 2009-10-13  628  			wl1271_debug(DEBUG_IRQ, "WL1271_ACX_INTR_EVENT_B");
045b9b5f4172b2 drivers/net/wireless/ti/wlcore/main.c     Ido Yariv       2012-06-18  629  			ret = wl1271_event_handle(wl, 1);
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  630  			if (ret < 0)
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  631  				goto err_ret;
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  632  		}
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  633  
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  634  		if (intr & WL1271_ACX_INTR_INIT_COMPLETE)
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  635  			wl1271_debug(DEBUG_IRQ,
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  636  				     "WL1271_ACX_INTR_INIT_COMPLETE");
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  637  
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  638  		if (intr & WL1271_ACX_INTR_HW_AVAILABLE)
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  639  			wl1271_debug(DEBUG_IRQ, "WL1271_ACX_INTR_HW_AVAILABLE");
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  640  	}
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  641  
da74b6933b3ba2 drivers/net/wireless/ti/wlcore/main.c     Dinghao Liu     2020-05-22  642  err_ret:
9b71578de08748 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19 @643  	pm_runtime_mark_last_busy(wl->dev);
9b71578de08748 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren   2018-06-19  644  	pm_runtime_put_autosuspend(wl->dev);
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  645  
f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho  2009-08-06  646  out:
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  647  	return ret;
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  648  }
b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov    2012-06-21  649  

:::::: The code at line 643 was first introduced by commit
:::::: 9b71578de08748defb3bcae3ce8ed1a75cb6a8d7 wlcore: Enable runtime PM autosuspend support

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2mX/B6fzxcMNugEA

--fUYQa+Pmc3FrFX/N--
