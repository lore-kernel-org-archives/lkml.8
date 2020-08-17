Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C904620738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHQK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:27:56 -0400
Received: from muru.com ([72.249.23.125]:40488 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgHQK1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:27:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1D2D280A3;
        Mon, 17 Aug 2020 10:27:53 +0000 (UTC)
Date:   Mon, 17 Aug 2020 13:28:21 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: drivers/net/wireless/ti/wlcore/main.c:700:9: sparse: sparse:
 context imbalance in 'wlcore_irq' - different lock contexts for basic block
Message-ID: <20200817102821.GE2994@atomide.com>
References: <202008111908.j7IQlv5Q%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008111908.j7IQlv5Q%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* kernel test robot <lkp@intel.com> [200811 11:55]:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   00e4db51259a5f936fec1424b884f029479d3981
> commit: 35fba0f0fd762a8b87d403ae3c723e0061c4aa25 wlcore: Use spin_trylock in wlcore_irq() to see if we need to queue tx
> date:   4 weeks ago
> config: mips-randconfig-s032-20200811 (attached as .config)
> compiler: mips64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-168-g9554805c-dirty
>         git checkout 35fba0f0fd762a8b87d403ae3c723e0061c4aa25
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/net/wireless/ti/wlcore/main.c:643:34: sparse: sparse: context imbalance in 'wlcore_irq_locked' - different lock contexts for basic block
> >> drivers/net/wireless/ti/wlcore/main.c:700:9: sparse: sparse: context imbalance in 'wlcore_irq' - different lock contexts for basic block

I tried to reproduce this with cross compiling for ARM using sparse-0.6.2,
but don't see any similar warnings.

Is this only happening on mips for some reason?

Regards,

Tony


> vim +/wlcore_irq +700 drivers/net/wireless/ti/wlcore/main.c
> 
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  649  
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  650  static irqreturn_t wlcore_irq(int irq, void *cookie)
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  651  {
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  652  	int ret;
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  653  	unsigned long flags;
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  654  	struct wl1271 *wl = cookie;
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  655  	bool queue_tx_work = true;
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  656  
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  657  	set_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  658  
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  659  	/* complete the ELP completion */
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  660  	if (test_bit(WL1271_FLAG_IN_ELP, &wl->flags)) {
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  661  		spin_lock_irqsave(&wl->wl_lock, flags);
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  662  		if (wl->elp_compl)
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  663  			complete(wl->elp_compl);
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  664  		spin_unlock_irqrestore(&wl->wl_lock, flags);
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  665  	}
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  666  
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  667  	if (test_bit(WL1271_FLAG_SUSPENDED, &wl->flags)) {
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  668  		/* don't enqueue a work right now. mark it as pending */
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  669  		set_bit(WL1271_FLAG_PENDING_WORK, &wl->flags);
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  670  		wl1271_debug(DEBUG_IRQ, "should not enqueue work");
> eb215c33f308ce drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  671  		spin_lock_irqsave(&wl->wl_lock, flags);
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  672  		disable_irq_nosync(wl->irq);
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  673  		pm_wakeup_event(wl->dev, 0);
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  674  		spin_unlock_irqrestore(&wl->wl_lock, flags);
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  675  		goto out_handled;
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  676  	}
> 97236a0656034e drivers/net/wireless/ti/wlcore/main.c     Luciano Coelho 2013-03-08  677  
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  678  	/* TX might be handled here, avoid redundant work */
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  679  	set_bit(WL1271_FLAG_TX_PENDING, &wl->flags);
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  680  	cancel_work_sync(&wl->tx_work);
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  681  
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  682  	mutex_lock(&wl->mutex);
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  683  
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  684  	ret = wlcore_irq_locked(wl);
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  685  	if (ret)
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  686  		wl12xx_queue_recovery_work(wl);
> b5b45b3cbd5616 drivers/net/wireless/ti/wlcore/main.c     Arik Nemtsov   2012-06-21  687  
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  688  	/* In case TX was not handled in wlcore_irq_locked(), queue TX work */
> b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv      2011-03-01  689  	clear_bit(WL1271_FLAG_TX_PENDING, &wl->flags);
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  690  	if (!test_bit(WL1271_FLAG_FW_TX_BUSY, &wl->flags)) {
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  691  		if (spin_trylock_irqsave(&wl->wl_lock, flags)) {
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  692  			if (!wl1271_tx_total_queue_count(wl))
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  693  				queue_tx_work = false;
> b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv      2011-03-01  694  			spin_unlock_irqrestore(&wl->wl_lock, flags);
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  695  		}
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  696  		if (queue_tx_work)
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  697  			ieee80211_queue_work(wl->hw, &wl->tx_work);
> 35fba0f0fd762a drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2020-07-02  698  	}
> b07d4037051318 drivers/net/wireless/wl12xx/main.c        Ido Yariv      2011-03-01  699  
> f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho 2009-08-06 @700  	mutex_unlock(&wl->mutex);
> a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv      2011-03-01  701  
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  702  out_handled:
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  703  	spin_lock_irqsave(&wl->wl_lock, flags);
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  704  	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  705  	spin_unlock_irqrestore(&wl->wl_lock, flags);
> 4633d30b61ac14 drivers/net/wireless/ti/wlcore/main.c     Tony Lindgren  2019-10-09  706  
> a620865edf62ea drivers/net/wireless/wl12xx/main.c        Ido Yariv      2011-03-01  707  	return IRQ_HANDLED;
> f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho 2009-08-06  708  }
> f5fc0f86b02afe drivers/net/wireless/wl12xx/wl1271_main.c Luciano Coelho 2009-08-06  709  
> 
> :::::: The code at line 700 was first introduced by commit
> :::::: f5fc0f86b02afef1119b523623b4cde41475bc8c wl1271: add wl1271 driver files
> 
> :::::: TO: Luciano Coelho <luciano.coelho@nokia.com>
> :::::: CC: John W. Linville <linville@tuxdriver.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


