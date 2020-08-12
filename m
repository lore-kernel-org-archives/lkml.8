Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDB4206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLOdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:33:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:43111 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:33:36 -0400
IronPort-SDR: vVO9nvDbNqaG5Og0SVuCD1h64J70TC35RATX6NyKYMW/7Exj/TRsYgipZR9gXRpH72Qw+M+XmN
 2/jTyvxM/26w==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141804695"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="gz'50?scan'50,208,50";a="141804695"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 07:33:11 -0700
IronPort-SDR: WOIgTNjDy9hzH7KbN5jKUp+FpQv1HKhqfh5u3/t8NJ6md9eOWmsWS0F0bK2Su9QZR7IglJSmbP
 JjuRAOVvH50g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="gz'50?scan'50,208,50";a="308736944"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2020 07:33:09 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5roS-00007B-J0; Wed, 12 Aug 2020 14:33:08 +0000
Date:   Wed, 12 Aug 2020 22:32:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx()
 error: uninitialized symbol 'tid'.
Message-ID: <202008122246.sQFMp1Nj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb893de323e2d39f7a1f6df425703a2edbdf56ea
commit: 3f649ab728cda8038259d8f14492fe400fbab911 treewide: Remove uninitialized_var() usage
date:   4 weeks ago
config: parisc-randconfig-m031-20200811 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx() error: uninitialized symbol 'tid'.
drivers/net/wireless/broadcom/b43/xmit.c:457 b43_generate_txhdr() error: uninitialized symbol 'cts'.
drivers/net/wireless/broadcom/b43/xmit.c:479 b43_generate_txhdr() error: uninitialized symbol 'rts'.
drivers/net/wireless/broadcom/b43/xmit.c:497 b43_generate_txhdr() error: uninitialized symbol 'plcp'.
drivers/net/wireless/broadcom/b43/xmit.c:517 b43_generate_txhdr() error: potentially dereferencing uninitialized 'hdr'.
drivers/net/wireless/broadcom/b43/xmit.c:664 b43_rx() error: uninitialized symbol 'macstat'.
drivers/net/wireless/broadcom/b43/xmit.c:719 b43_rx() error: uninitialized symbol 'chanstat'.
drivers/net/wireless/broadcom/b43/xmit.c:771 b43_rx() error: uninitialized symbol 'mactime'.
drivers/net/wireless/broadcom/b43/dma.c:67 b43_dma_address() error: uninitialized symbol 'addr'.

Old smatch warnings:
drivers/net/wireless/intel/iwlegacy/4965-mac.c:1736 il4965_tx_skb() warn: potential spectre issue 'il->stations[sta_id]->tid' [r] (local cap)
drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx() warn: potential spectre issue 'il->stations[sta_id]->tid' [r]

vim +/tid +2822 drivers/net/wireless/intel/iwlegacy/4965-mac.c

3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2755  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2756  /**
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2757   * il4965_hdl_tx - Handle standard (non-aggregation) Tx response
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2758   */
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2759  static void
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2760  il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2761  {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2762  	struct il_rx_pkt *pkt = rxb_addr(rxb);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2763  	u16 sequence = le16_to_cpu(pkt->hdr.sequence);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2764  	int txq_id = SEQ_TO_QUEUE(sequence);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2765  	int idx = SEQ_TO_IDX(sequence);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2766  	struct il_tx_queue *txq = &il->txq[txq_id];
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2767  	struct sk_buff *skb;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2768  	struct ieee80211_hdr *hdr;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2769  	struct ieee80211_tx_info *info;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2770  	struct il4965_tx_resp *tx_resp = (void *)&pkt->u.raw[0];
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2771  	u32 status = le32_to_cpu(tx_resp->u.status);
3f649ab728cda8 drivers/net/wireless/intel/iwlegacy/4965-mac.c Kees Cook         2020-06-03  2772  	int tid;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2773  	int sta_id;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2774  	int freed;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2775  	u8 *qc = NULL;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2776  	unsigned long flags;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2777  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2778  	if (idx >= txq->q.n_bd || il_queue_used(&txq->q, idx) == 0) {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2779  		IL_ERR("Read idx for DMA queue txq_id (%d) idx %d "
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2780  		       "is out of range [0-%d] %d %d\n", txq_id, idx,
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2781  		       txq->q.n_bd, txq->q.write_ptr, txq->q.read_ptr);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2782  		return;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2783  	}
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2784  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2785  	txq->time_stamp = jiffies;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2786  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2787  	skb = txq->skbs[txq->q.read_ptr];
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2788  	info = IEEE80211_SKB_CB(skb);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2789  	memset(&info->status, 0, sizeof(info->status));
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2790  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2791  	hdr = (struct ieee80211_hdr *) skb->data;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2792  	if (ieee80211_is_data_qos(hdr->frame_control)) {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2793  		qc = ieee80211_get_qos_ctl(hdr);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2794  		tid = qc[0] & 0xf;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2795  	}
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2796  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2797  	sta_id = il4965_get_ra_sta_id(il, hdr);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2798  	if (txq->sched_retry && unlikely(sta_id == IL_INVALID_STATION)) {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2799  		IL_ERR("Station not known\n");
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2800  		return;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2801  	}
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2802  
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2803  	/*
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2804  	 * Firmware will not transmit frame on passive channel, if it not yet
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2805  	 * received some valid frame on that channel. When this error happen
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2806  	 * we have to wait until firmware will unblock itself i.e. when we
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2807  	 * note received beacon or other frame. We unblock queues in
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2808  	 * il4965_pass_packet_to_mac80211 or in il_mac_bss_info_changed.
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2809  	 */
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2810  	if (unlikely((status & TX_STATUS_MSK) == TX_STATUS_FAIL_PASSIVE_NO_RX) &&
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2811  	    il->iw_mode == NL80211_IFTYPE_STATION) {
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2812  		il_stop_queues_by_reason(il, IL_STOP_REASON_PASSIVE);
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2813  		D_INFO("Stopped queues - RX waiting on passive channel\n");
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2814  	}
8cdbab7f07e82f drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2013-06-12  2815  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2816  	spin_lock_irqsave(&il->sta_lock, flags);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2817  	if (txq->sched_retry) {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2818  		const u32 scd_ssn = il4965_get_scd_ssn(tx_resp);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2819  		struct il_ht_agg *agg = NULL;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2820  		WARN_ON(!qc);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2821  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13 @2822  		agg = &il->stations[sta_id].tid[tid].agg;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2823  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2824  		il4965_tx_status_reply_tx(il, agg, tx_resp, txq_id, idx);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2825  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2826  		/* check if BAR is needed */
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2827  		if (tx_resp->frame_count == 1 &&
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2828  		    !il4965_is_tx_success(status))
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2829  			info->flags |= IEEE80211_TX_STAT_AMPDU_NO_BACK;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2830  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2831  		if (txq->q.read_ptr != (scd_ssn & 0xff)) {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2832  			idx = il_queue_dec_wrap(scd_ssn & 0xff, txq->q.n_bd);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2833  			D_TX_REPLY("Retry scheduler reclaim scd_ssn "
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2834  				   "%d idx %d\n", scd_ssn, idx);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2835  			freed = il4965_tx_queue_reclaim(il, txq_id, idx);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2836  			if (qc)
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2837  				il4965_free_tfds_in_queue(il, sta_id, tid,
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2838  							  freed);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2839  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2840  			if (il->mac80211_registered &&
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2841  			    il_queue_space(&txq->q) > txq->q.low_mark &&
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2842  			    agg->state != IL_EMPTYING_HW_QUEUE_DELBA)
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2843  				il_wake_queue(il, txq);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2844  		}
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2845  	} else {
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2846  		info->status.rates[0].count = tx_resp->failure_frame + 1;
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2847  		info->flags |= il4965_tx_status_to_mac80211(status);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2848  		il4965_hwrate_to_tx_control(il,
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2849  					    le32_to_cpu(tx_resp->rate_n_flags),
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2850  					    info);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2851  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2852  		D_TX_REPLY("TXQ %d status %s (0x%08x) "
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2853  			   "rate_n_flags 0x%x retries %d\n", txq_id,
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2854  			   il4965_get_tx_fail_reason(status), status,
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2855  			   le32_to_cpu(tx_resp->rate_n_flags),
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2856  			   tx_resp->failure_frame);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2857  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2858  		freed = il4965_tx_queue_reclaim(il, txq_id, idx);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2859  		if (qc && likely(sta_id != IL_INVALID_STATION))
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2860  			il4965_free_tfds_in_queue(il, sta_id, tid, freed);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2861  		else if (sta_id == IL_INVALID_STATION)
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2862  			D_TX_REPLY("Station not known\n");
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2863  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2864  		if (il->mac80211_registered &&
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2865  		    il_queue_space(&txq->q) > txq->q.low_mark)
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2866  			il_wake_queue(il, txq);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2867  	}
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2868  	if (qc && likely(sta_id != IL_INVALID_STATION))
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2869  		il4965_txq_check_empty(il, sta_id, tid, txq_id);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2870  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2871  	il4965_check_abort_status(il, tx_resp->frame_count, status);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2872  
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2873  	spin_unlock_irqrestore(&il->sta_lock, flags);
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2874  }
3dfea27d103e99 drivers/net/wireless/iwlegacy/4965-mac.c       Stanislaw Gruszka 2012-02-13  2875  

:::::: The code at line 2822 was first introduced by commit
:::::: 3dfea27d103e9913698cf1a2c86745a74c7c556b iwlegacy: gather all 4965 handlers in one place

:::::: TO: Stanislaw Gruszka <sgruszka@redhat.com>
:::::: CC: John W. Linville <linville@tuxdriver.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx--
