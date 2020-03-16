Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7782C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89620679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fM3aYuBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgCPXFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:05:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732846AbgCPXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:05:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id l184so10777281pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CNgSjJRkbHzGdJGl7ZXZ26pBb8B+njH3P9ZVB0Mk08=;
        b=fM3aYuBkCVzkdYwq9exlK1a2qxKW54XAPtOv0SM8M+/fc37eH+EXy5Q14nL7VEE6Cx
         7smeFQi2m4B8yqQshGp2hrCgVdMWu4mJEplpMSIHRjfPN/xDsr7aYOd2pwLL83F1sSYM
         zcGb1OW0IbmGbnORR+Un+MNGBvsdT7i7gs0sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CNgSjJRkbHzGdJGl7ZXZ26pBb8B+njH3P9ZVB0Mk08=;
        b=m1h1wHRNTda+CWWt474vXLgvuQpyYkRcD+v4uTQwOyWKtR68REonVb7eUSGQ0Wfwry
         N6v6/iWiXOstr0crW7V/ZpBy2iURyOjRubbOIlgrSbIkwYLvfSFMhUonYBsjt0mLRprs
         QolOAsbaNJOI9QKlnLarmjHFuGfOOx3rQCI3/hN+RM9B9mFECKQi/+1HOowNNE/d75fx
         pBZ91lUOCesDmvail6oSeLjL+lGn+c2ZCLKJKJUNCjV35fFaH27nUzDugeqecaZI4FxM
         5lA/IWUcHyHCpE6A4JMbwUS8pHl21LqP72/RpvYQUPPTXmM6vpD+rlv/A3U1fEx5y+O2
         YWBA==
X-Gm-Message-State: ANhLgQ04v3dsIe4ngbKthSlMX4YG6A1sIp7eaBGPxcL1ygsKy9+FXh3y
        54IbO7FTSNzLYSAMCTirbIvy/w==
X-Google-Smtp-Source: ADFU+vtk7piEtEksJIjGa/zwuB030QWcKnoiBrfHDSNP6UvQTl8R5TO+r1Blu1cxFgez0LBBGEqN3w==
X-Received: by 2002:aa7:9e82:: with SMTP id p2mr2055745pfq.46.1584399939246;
        Mon, 16 Mar 2020 16:05:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s25sm498877pgv.70.2020.03.16.16.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 16:05:38 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:05:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] WIP: Bluetooth: hci_qca: consolidate IBS fields in a
 struct
Message-ID: <20200316230537.GQ144492@google.com>
References: <20200316230233.138696-1-mka@chromium.org>
 <20200316160202.1.Ifcc5d58d16eabaa82553013f64714d93d1ff7836@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316160202.1.Ifcc5d58d16eabaa82553013f64714d93d1ff7836@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:02:32PM -0700, Matthias Kaehlcke wrote:

> Subject: WIP: Bluetooth: hci_qca: consolidate IBS fields in a struct

The WIP prefix wasn't intended, I'll remove it in the next version.

> About two thirds of the fields in 'struct qca_data' are related with
> in band sleep (IBS). Move these fields to a dedicated IBS struct which
> is part of 'struct qca_data'. Also congregate the IBS stats fields for
> debugfs in a separate sub-struct.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/bluetooth/hci_qca.c | 362 +++++++++++++++++++-----------------
>  1 file changed, 191 insertions(+), 171 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3abf4e68de7a8c..c578c7c92680a6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -125,51 +125,60 @@ struct qca_dump_size {
>  	u32 dump_size;
>  } __packed;
>  
> -struct qca_data {
> -	struct hci_uart *hu;
> -	struct sk_buff *rx_skb;
> -	struct sk_buff_head txq;
> +struct qca_ibs_stats {
> +	/* For debugging purpose */
> +	u64 sent_wacks;
> +	u64 sent_slps;
> +	u64 sent_wakes;
> +	u64 recv_wacks;
> +	u64 recv_slps;
> +	u64 recv_wakes;
> +	u64 vote_last_jif;
> +	u32 vote_on_ms;
> +	u32 vote_off_ms;
> +	u64 tx_votes_on;
> +	u64 rx_votes_on;
> +	u64 tx_votes_off;
> +	u64 rx_votes_off;
> +	u64 votes_on;
> +	u64 votes_off;
> +};
> +
> +struct qca_ibs {
>  	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
> -	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
> -	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
> -	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
> -	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
> +	spinlock_t lock;	/* HCI_IBS state lock	*/
> +	u8 tx_state;		/* HCI_IBS transmit side power state*/
> +	u8 rx_state;		/* HCI_IBS receive side power state */
>  	bool tx_vote;		/* Clock must be on for TX */
>  	bool rx_vote;		/* Clock must be on for RX */
>  	struct timer_list tx_idle_timer;
>  	u32 tx_idle_delay;
>  	struct timer_list wake_retrans_timer;
>  	u32 wake_retrans;
> -	struct workqueue_struct *workqueue;
> +
>  	struct work_struct ws_awake_rx;
>  	struct work_struct ws_awake_device;
>  	struct work_struct ws_rx_vote_off;
>  	struct work_struct ws_tx_vote_off;
> +
> +	struct qca_ibs_stats stats;
> +};
> +
> +struct qca_data {
> +	struct hci_uart *hu;
> +	struct sk_buff *rx_skb;
> +	struct sk_buff_head txq;
> +	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
> +	struct workqueue_struct *workqueue;
>  	struct work_struct ctrl_memdump_evt;
>  	struct delayed_work ctrl_memdump_timeout;
>  	struct qca_memdump_data *qca_memdump;
> +	struct qca_ibs ibs;
>  	unsigned long flags;
>  	struct completion drop_ev_comp;
>  	wait_queue_head_t suspend_wait_q;
>  	enum qca_memdump_states memdump_state;
>  	struct mutex hci_memdump_lock;
> -
> -	/* For debugging purpose */
> -	u64 ibs_sent_wacks;
> -	u64 ibs_sent_slps;
> -	u64 ibs_sent_wakes;
> -	u64 ibs_recv_wacks;
> -	u64 ibs_recv_slps;
> -	u64 ibs_recv_wakes;
> -	u64 vote_last_jif;
> -	u32 vote_on_ms;
> -	u32 vote_off_ms;
> -	u64 tx_votes_on;
> -	u64 rx_votes_on;
> -	u64 tx_votes_off;
> -	u64 rx_votes_off;
> -	u64 votes_on;
> -	u64 votes_off;
>  };
>  
>  enum qca_speed_type {
> @@ -267,41 +276,41 @@ static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
>  	struct qca_data *qca = hu->priv;
>  	unsigned int diff;
>  
> -	bool old_vote = (qca->tx_vote | qca->rx_vote);
> +	bool old_vote = (qca->ibs.tx_vote | qca->ibs.rx_vote);
>  	bool new_vote;
>  
>  	switch (vote) {
>  	case HCI_IBS_VOTE_STATS_UPDATE:
> -		diff = jiffies_to_msecs(jiffies - qca->vote_last_jif);
> +		diff = jiffies_to_msecs(jiffies - qca->ibs.stats.vote_last_jif);
>  
>  		if (old_vote)
> -			qca->vote_off_ms += diff;
> +			qca->ibs.stats.vote_off_ms += diff;
>  		else
> -			qca->vote_on_ms += diff;
> +			qca->ibs.stats.vote_on_ms += diff;
>  		return;
>  
>  	case HCI_IBS_TX_VOTE_CLOCK_ON:
> -		qca->tx_vote = true;
> -		qca->tx_votes_on++;
> +		qca->ibs.tx_vote = true;
> +		qca->ibs.stats.tx_votes_on++;
>  		new_vote = true;
>  		break;
>  
>  	case HCI_IBS_RX_VOTE_CLOCK_ON:
> -		qca->rx_vote = true;
> -		qca->rx_votes_on++;
> +		qca->ibs.rx_vote = true;
> +		qca->ibs.stats.rx_votes_on++;
>  		new_vote = true;
>  		break;
>  
>  	case HCI_IBS_TX_VOTE_CLOCK_OFF:
> -		qca->tx_vote = false;
> -		qca->tx_votes_off++;
> -		new_vote = qca->rx_vote | qca->tx_vote;
> +		qca->ibs.tx_vote = false;
> +		qca->ibs.stats.tx_votes_off++;
> +		new_vote = qca->ibs.rx_vote | qca->ibs.tx_vote;
>  		break;
>  
>  	case HCI_IBS_RX_VOTE_CLOCK_OFF:
> -		qca->rx_vote = false;
> -		qca->rx_votes_off++;
> -		new_vote = qca->rx_vote | qca->tx_vote;
> +		qca->ibs.rx_vote = false;
> +		qca->ibs.stats.rx_votes_off++;
> +		new_vote = qca->ibs.rx_vote | qca->ibs.tx_vote;
>  		break;
>  
>  	default:
> @@ -318,16 +327,16 @@ static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
>  		BT_DBG("Vote serial clock %s(%s)", new_vote ? "true" : "false",
>  		       vote ? "true" : "false");
>  
> -		diff = jiffies_to_msecs(jiffies - qca->vote_last_jif);
> +		diff = jiffies_to_msecs(jiffies - qca->ibs.stats.vote_last_jif);
>  
>  		if (new_vote) {
> -			qca->votes_on++;
> -			qca->vote_off_ms += diff;
> +			qca->ibs.stats.votes_on++;
> +			qca->ibs.stats.vote_off_ms += diff;
>  		} else {
> -			qca->votes_off++;
> -			qca->vote_on_ms += diff;
> +			qca->ibs.stats.votes_off++;
> +			qca->ibs.stats.vote_on_ms += diff;
>  		}
> -		qca->vote_last_jif = jiffies;
> +		qca->ibs.stats.vote_last_jif = jiffies;
>  	}
>  }
>  
> @@ -359,7 +368,7 @@ static int send_hci_ibs_cmd(u8 cmd, struct hci_uart *hu)
>  static void qca_wq_awake_device(struct work_struct *work)
>  {
>  	struct qca_data *qca = container_of(work, struct qca_data,
> -					    ws_awake_device);
> +					    ibs.ws_awake_device);
>  	struct hci_uart *hu = qca->hu;
>  	unsigned long retrans_delay;
>  	unsigned long flags;
> @@ -369,19 +378,19 @@ static void qca_wq_awake_device(struct work_struct *work)
>  	/* Vote for serial clock */
>  	serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_ON, hu);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  
>  	/* Send wake indication to device */
>  	if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0)
>  		BT_ERR("Failed to send WAKE to device");
>  
> -	qca->ibs_sent_wakes++;
> +	qca->ibs.stats.sent_wakes++;
>  
>  	/* Start retransmit timer */
> -	retrans_delay = msecs_to_jiffies(qca->wake_retrans);
> -	mod_timer(&qca->wake_retrans_timer, jiffies + retrans_delay);
> +	retrans_delay = msecs_to_jiffies(qca->ibs.wake_retrans);
> +	mod_timer(&qca->ibs.wake_retrans_timer, jiffies + retrans_delay);
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	/* Actually send the packets */
>  	hci_uart_tx_wakeup(hu);
> @@ -390,7 +399,7 @@ static void qca_wq_awake_device(struct work_struct *work)
>  static void qca_wq_awake_rx(struct work_struct *work)
>  {
>  	struct qca_data *qca = container_of(work, struct qca_data,
> -					    ws_awake_rx);
> +					    ibs.ws_awake_rx);
>  	struct hci_uart *hu = qca->hu;
>  	unsigned long flags;
>  
> @@ -398,8 +407,8 @@ static void qca_wq_awake_rx(struct work_struct *work)
>  
>  	serial_clock_vote(HCI_IBS_RX_VOTE_CLOCK_ON, hu);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -	qca->rx_ibs_state = HCI_IBS_RX_AWAKE;
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
> +	qca->ibs.rx_state = HCI_IBS_RX_AWAKE;
>  
>  	/* Always acknowledge device wake up,
>  	 * sending IBS message doesn't count as TX ON.
> @@ -407,9 +416,9 @@ static void qca_wq_awake_rx(struct work_struct *work)
>  	if (send_hci_ibs_cmd(HCI_IBS_WAKE_ACK, hu) < 0)
>  		BT_ERR("Failed to acknowledge device wake up");
>  
> -	qca->ibs_sent_wacks++;
> +	qca->ibs.stats.sent_wacks++;
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	/* Actually send the packets */
>  	hci_uart_tx_wakeup(hu);
> @@ -418,7 +427,7 @@ static void qca_wq_awake_rx(struct work_struct *work)
>  static void qca_wq_serial_rx_clock_vote_off(struct work_struct *work)
>  {
>  	struct qca_data *qca = container_of(work, struct qca_data,
> -					    ws_rx_vote_off);
> +					    ibs.ws_rx_vote_off);
>  	struct hci_uart *hu = qca->hu;
>  
>  	BT_DBG("hu %p rx clock vote off", hu);
> @@ -429,7 +438,7 @@ static void qca_wq_serial_rx_clock_vote_off(struct work_struct *work)
>  static void qca_wq_serial_tx_clock_vote_off(struct work_struct *work)
>  {
>  	struct qca_data *qca = container_of(work, struct qca_data,
> -					    ws_tx_vote_off);
> +					    ibs.ws_tx_vote_off);
>  	struct hci_uart *hu = qca->hu;
>  
>  	BT_DBG("hu %p tx clock vote off", hu);
> @@ -445,25 +454,25 @@ static void qca_wq_serial_tx_clock_vote_off(struct work_struct *work)
>  
>  static void hci_ibs_tx_idle_timeout(struct timer_list *t)
>  {
> -	struct qca_data *qca = from_timer(qca, t, tx_idle_timer);
> +	struct qca_data *qca = from_timer(qca, t, ibs.tx_idle_timer);
>  	struct hci_uart *hu = qca->hu;
>  	unsigned long flags;
>  
> -	BT_DBG("hu %p idle timeout in %d state", hu, qca->tx_ibs_state);
> +	BT_DBG("hu %p idle timeout in %d state", hu, qca->ibs.tx_state);
>  
> -	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
> +	spin_lock_irqsave_nested(&qca->ibs.lock,
>  				 flags, SINGLE_DEPTH_NESTING);
>  
> -	switch (qca->tx_ibs_state) {
> +	switch (qca->ibs.tx_state) {
>  	case HCI_IBS_TX_AWAKE:
>  		/* TX_IDLE, go to SLEEP */
>  		if (send_hci_ibs_cmd(HCI_IBS_SLEEP_IND, hu) < 0) {
>  			BT_ERR("Failed to send SLEEP to device");
>  			break;
>  		}
> -		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> -		qca->ibs_sent_slps++;
> -		queue_work(qca->workqueue, &qca->ws_tx_vote_off);
> +		qca->ibs.tx_state = HCI_IBS_TX_ASLEEP;
> +		qca->ibs.stats.sent_slps++;
> +		queue_work(qca->workqueue, &qca->ibs.ws_tx_vote_off);
>  		break;
>  
>  	case HCI_IBS_TX_ASLEEP:
> @@ -471,33 +480,33 @@ static void hci_ibs_tx_idle_timeout(struct timer_list *t)
>  		/* Fall through */
>  
>  	default:
> -		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
> +		BT_ERR("Spurious timeout tx state %d", qca->ibs.tx_state);
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  }
>  
>  static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
>  {
> -	struct qca_data *qca = from_timer(qca, t, wake_retrans_timer);
> +	struct qca_data *qca = from_timer(qca, t, ibs.wake_retrans_timer);
>  	struct hci_uart *hu = qca->hu;
>  	unsigned long flags, retrans_delay;
>  	bool retransmit = false;
>  
>  	BT_DBG("hu %p wake retransmit timeout in %d state",
> -		hu, qca->tx_ibs_state);
> +		hu, qca->ibs.tx_state);
>  
> -	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
> +	spin_lock_irqsave_nested(&qca->ibs.lock,
>  				 flags, SINGLE_DEPTH_NESTING);
>  
>  	/* Don't retransmit the HCI_IBS_WAKE_IND when suspending. */
>  	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> -		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  		return;
>  	}
>  
> -	switch (qca->tx_ibs_state) {
> +	switch (qca->ibs.tx_state) {
>  	case HCI_IBS_TX_WAKING:
>  		/* No WAKE_ACK, retransmit WAKE */
>  		retransmit = true;
> @@ -505,9 +514,10 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
>  			BT_ERR("Failed to acknowledge device wake up");
>  			break;
>  		}
> -		qca->ibs_sent_wakes++;
> -		retrans_delay = msecs_to_jiffies(qca->wake_retrans);
> -		mod_timer(&qca->wake_retrans_timer, jiffies + retrans_delay);
> +		qca->ibs.stats.sent_wakes++;
> +		retrans_delay = msecs_to_jiffies(qca->ibs.wake_retrans);
> +		mod_timer(&qca->ibs.wake_retrans_timer,
> +			  jiffies + retrans_delay);
>  		break;
>  
>  	case HCI_IBS_TX_ASLEEP:
> @@ -515,11 +525,11 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
>  		/* Fall through */
>  
>  	default:
> -		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
> +		BT_ERR("Spurious timeout tx state %d", qca->ibs.tx_state);
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	if (retransmit)
>  		hci_uart_tx_wakeup(hu);
> @@ -563,9 +573,9 @@ static int qca_open(struct hci_uart *hu)
>  		return -ENOMEM;
>  
>  	skb_queue_head_init(&qca->txq);
> -	skb_queue_head_init(&qca->tx_wait_q);
> +	skb_queue_head_init(&qca->ibs.tx_wait_q);
>  	skb_queue_head_init(&qca->rx_memdump_q);
> -	spin_lock_init(&qca->hci_ibs_lock);
> +	spin_lock_init(&qca->ibs.lock);
>  	mutex_init(&qca->hci_memdump_lock);
>  	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
>  	if (!qca->workqueue) {
> @@ -574,10 +584,10 @@ static int qca_open(struct hci_uart *hu)
>  		return -ENOMEM;
>  	}
>  
> -	INIT_WORK(&qca->ws_awake_rx, qca_wq_awake_rx);
> -	INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
> -	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
> -	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
> +	INIT_WORK(&qca->ibs.ws_awake_rx, qca_wq_awake_rx);
> +	INIT_WORK(&qca->ibs.ws_awake_device, qca_wq_awake_device);
> +	INIT_WORK(&qca->ibs.ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
> +	INIT_WORK(&qca->ibs.ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
>  	INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
>  	INIT_DELAYED_WORK(&qca->ctrl_memdump_timeout,
>  			  qca_controller_memdump_timeout);
> @@ -587,10 +597,10 @@ static int qca_open(struct hci_uart *hu)
>  	init_completion(&qca->drop_ev_comp);
>  
>  	/* Assume we start with both sides asleep -- extra wakes OK */
> -	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> -	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
> +	qca->ibs.tx_state = HCI_IBS_TX_ASLEEP;
> +	qca->ibs.rx_state = HCI_IBS_RX_ASLEEP;
>  
> -	qca->vote_last_jif = jiffies;
> +	qca->ibs.stats.vote_last_jif = jiffies;
>  
>  	hu->priv = qca;
>  
> @@ -602,14 +612,15 @@ static int qca_open(struct hci_uart *hu)
>  		}
>  	}
>  
> -	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 0);
> -	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
> +	timer_setup(&qca->ibs.wake_retrans_timer, hci_ibs_wake_retrans_timeout,
> +		    0);
> +	qca->ibs.wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
>  
> -	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
> -	qca->tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
> +	timer_setup(&qca->ibs.tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
> +	qca->ibs.tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
>  
>  	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
> -	       qca->tx_idle_delay, qca->wake_retrans);
> +	       qca->ibs.tx_idle_delay, qca->ibs.wake_retrans);
>  
>  	return 0;
>  }
> @@ -628,36 +639,45 @@ static void qca_debugfs_init(struct hci_dev *hdev)
>  
>  	/* read only */
>  	mode = S_IRUGO;
> -	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
> -	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
> +	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->ibs.tx_state);
> +	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->ibs.rx_state);
>  	debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
> -			   &qca->ibs_sent_slps);
> +			   &qca->ibs.stats.sent_slps);
>  	debugfs_create_u64("ibs_sent_wakes", mode, ibs_dir,
> -			   &qca->ibs_sent_wakes);
> +			   &qca->ibs.stats.sent_wakes);
>  	debugfs_create_u64("ibs_sent_wake_acks", mode, ibs_dir,
> -			   &qca->ibs_sent_wacks);
> +			   &qca->ibs.stats.sent_wacks);
>  	debugfs_create_u64("ibs_recv_sleeps", mode, ibs_dir,
> -			   &qca->ibs_recv_slps);
> +			   &qca->ibs.stats.recv_slps);
>  	debugfs_create_u64("ibs_recv_wakes", mode, ibs_dir,
> -			   &qca->ibs_recv_wakes);
> +			   &qca->ibs.stats.recv_wakes);
>  	debugfs_create_u64("ibs_recv_wake_acks", mode, ibs_dir,
> -			   &qca->ibs_recv_wacks);
> -	debugfs_create_bool("tx_vote", mode, ibs_dir, &qca->tx_vote);
> -	debugfs_create_u64("tx_votes_on", mode, ibs_dir, &qca->tx_votes_on);
> -	debugfs_create_u64("tx_votes_off", mode, ibs_dir, &qca->tx_votes_off);
> -	debugfs_create_bool("rx_vote", mode, ibs_dir, &qca->rx_vote);
> -	debugfs_create_u64("rx_votes_on", mode, ibs_dir, &qca->rx_votes_on);
> -	debugfs_create_u64("rx_votes_off", mode, ibs_dir, &qca->rx_votes_off);
> -	debugfs_create_u64("votes_on", mode, ibs_dir, &qca->votes_on);
> -	debugfs_create_u64("votes_off", mode, ibs_dir, &qca->votes_off);
> -	debugfs_create_u32("vote_on_ms", mode, ibs_dir, &qca->vote_on_ms);
> -	debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
> +			   &qca->ibs.stats.recv_wacks);
> +	debugfs_create_bool("tx_vote", mode, ibs_dir, &qca->ibs.tx_vote);
> +	debugfs_create_u64("tx_votes_on", mode, ibs_dir,
> +			   &qca->ibs.stats.tx_votes_on);
> +	debugfs_create_u64("tx_votes_off", mode, ibs_dir,
> +			   &qca->ibs.stats.tx_votes_off);
> +	debugfs_create_bool("rx_vote", mode, ibs_dir, &qca->ibs.rx_vote);
> +	debugfs_create_u64("rx_votes_on", mode, ibs_dir,
> +			   &qca->ibs.stats.rx_votes_on);
> +	debugfs_create_u64("rx_votes_off", mode, ibs_dir,
> +			   &qca->ibs.stats.rx_votes_off);
> +	debugfs_create_u64("votes_on", mode, ibs_dir,
> +			   &qca->ibs.stats.votes_on);
> +	debugfs_create_u64("votes_off", mode, ibs_dir,
> +			   &qca->ibs.stats.votes_off);
> +	debugfs_create_u32("vote_on_ms", mode, ibs_dir,
> +			   &qca->ibs.stats.vote_on_ms);
> +	debugfs_create_u32("vote_off_ms", mode, ibs_dir,
> +			   &qca->ibs.stats.vote_off_ms);
>  
>  	/* read/write */
>  	mode = S_IRUGO | S_IWUSR;
> -	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
> +	debugfs_create_u32("wake_retrans", mode, ibs_dir,
> +			   &qca->ibs.wake_retrans);
>  	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
> -			   &qca->tx_idle_delay);
> +			   &qca->ibs.tx_idle_delay);
>  }
>  
>  /* Flush protocol data */
> @@ -667,7 +687,7 @@ static int qca_flush(struct hci_uart *hu)
>  
>  	BT_DBG("hu %p qca flush", hu);
>  
> -	skb_queue_purge(&qca->tx_wait_q);
> +	skb_queue_purge(&qca->ibs.tx_wait_q);
>  	skb_queue_purge(&qca->txq);
>  
>  	return 0;
> @@ -682,11 +702,11 @@ static int qca_close(struct hci_uart *hu)
>  
>  	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
>  
> -	skb_queue_purge(&qca->tx_wait_q);
> +	skb_queue_purge(&qca->ibs.tx_wait_q);
>  	skb_queue_purge(&qca->txq);
>  	skb_queue_purge(&qca->rx_memdump_q);
> -	del_timer(&qca->tx_idle_timer);
> -	del_timer(&qca->wake_retrans_timer);
> +	del_timer(&qca->ibs.tx_idle_timer);
> +	del_timer(&qca->ibs.wake_retrans_timer);
>  	destroy_workqueue(qca->workqueue);
>  	qca->hu = NULL;
>  
> @@ -710,23 +730,23 @@ static void device_want_to_wakeup(struct hci_uart *hu)
>  
>  	BT_DBG("hu %p want to wake up", hu);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  
> -	qca->ibs_recv_wakes++;
> +	qca->ibs.stats.recv_wakes++;
>  
>  	/* Don't wake the rx up when suspending. */
>  	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> -		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  		return;
>  	}
>  
> -	switch (qca->rx_ibs_state) {
> +	switch (qca->ibs.rx_state) {
>  	case HCI_IBS_RX_ASLEEP:
>  		/* Make sure clock is on - we may have turned clock off since
>  		 * receiving the wake up indicator awake rx clock.
>  		 */
> -		queue_work(qca->workqueue, &qca->ws_awake_rx);
> -		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		queue_work(qca->workqueue, &qca->ibs.ws_awake_rx);
> +		spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  		return;
>  
>  	case HCI_IBS_RX_AWAKE:
> @@ -737,17 +757,17 @@ static void device_want_to_wakeup(struct hci_uart *hu)
>  			BT_ERR("Failed to acknowledge device wake up");
>  			break;
>  		}
> -		qca->ibs_sent_wacks++;
> +		qca->ibs.stats.sent_wacks++;
>  		break;
>  
>  	default:
>  		/* Any other state is illegal */
>  		BT_ERR("Received HCI_IBS_WAKE_IND in rx state %d",
> -		       qca->rx_ibs_state);
> +		       qca->ibs.rx_state);
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	/* Actually send the packets */
>  	hci_uart_tx_wakeup(hu);
> @@ -760,18 +780,18 @@ static void device_want_to_sleep(struct hci_uart *hu)
>  	unsigned long flags;
>  	struct qca_data *qca = hu->priv;
>  
> -	BT_DBG("hu %p want to sleep in %d state", hu, qca->rx_ibs_state);
> +	BT_DBG("hu %p want to sleep in %d state", hu, qca->ibs.rx_state);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  
> -	qca->ibs_recv_slps++;
> +	qca->ibs.stats.recv_slps++;
>  
> -	switch (qca->rx_ibs_state) {
> +	switch (qca->ibs.rx_state) {
>  	case HCI_IBS_RX_AWAKE:
>  		/* Update state */
> -		qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
> +		qca->ibs.rx_state = HCI_IBS_RX_ASLEEP;
>  		/* Vote off rx clock under workqueue */
> -		queue_work(qca->workqueue, &qca->ws_rx_vote_off);
> +		queue_work(qca->workqueue, &qca->ibs.ws_rx_vote_off);
>  		break;
>  
>  	case HCI_IBS_RX_ASLEEP:
> @@ -780,13 +800,13 @@ static void device_want_to_sleep(struct hci_uart *hu)
>  	default:
>  		/* Any other state is illegal */
>  		BT_ERR("Received HCI_IBS_SLEEP_IND in rx state %d",
> -		       qca->rx_ibs_state);
> +		       qca->ibs.rx_state);
>  		break;
>  	}
>  
>  	wake_up_interruptible(&qca->suspend_wait_q);
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  }
>  
>  /* Called upon wake-up-acknowledgement from the device
> @@ -799,33 +819,33 @@ static void device_woke_up(struct hci_uart *hu)
>  
>  	BT_DBG("hu %p woke up", hu);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  
> -	qca->ibs_recv_wacks++;
> +	qca->ibs.stats.recv_wacks++;
>  
>  	/* Don't react to the wake-up-acknowledgment when suspending. */
>  	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
> -		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  		return;
>  	}
>  
> -	switch (qca->tx_ibs_state) {
> +	switch (qca->ibs.tx_state) {
>  	case HCI_IBS_TX_AWAKE:
>  		/* Expect one if we send 2 WAKEs */
>  		BT_DBG("Received HCI_IBS_WAKE_ACK in tx state %d",
> -		       qca->tx_ibs_state);
> +		       qca->ibs.tx_state);
>  		break;
>  
>  	case HCI_IBS_TX_WAKING:
>  		/* Send pending packets */
> -		while ((skb = skb_dequeue(&qca->tx_wait_q)))
> +		while ((skb = skb_dequeue(&qca->ibs.tx_wait_q)))
>  			skb_queue_tail(&qca->txq, skb);
>  
>  		/* Switch timers and change state to HCI_IBS_TX_AWAKE */
> -		del_timer(&qca->wake_retrans_timer);
> -		idle_delay = msecs_to_jiffies(qca->tx_idle_delay);
> -		mod_timer(&qca->tx_idle_timer, jiffies + idle_delay);
> -		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		del_timer(&qca->ibs.wake_retrans_timer);
> +		idle_delay = msecs_to_jiffies(qca->ibs.tx_idle_delay);
> +		mod_timer(&qca->ibs.tx_idle_timer, jiffies + idle_delay);
> +		qca->ibs.tx_state = HCI_IBS_TX_AWAKE;
>  		break;
>  
>  	case HCI_IBS_TX_ASLEEP:
> @@ -833,11 +853,11 @@ static void device_woke_up(struct hci_uart *hu)
>  
>  	default:
>  		BT_ERR("Received HCI_IBS_WAKE_ACK in tx state %d",
> -		       qca->tx_ibs_state);
> +		       qca->ibs.tx_state);
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	/* Actually send the packets */
>  	hci_uart_tx_wakeup(hu);
> @@ -852,12 +872,12 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	struct qca_data *qca = hu->priv;
>  
>  	BT_DBG("hu %p qca enq skb %p tx_ibs_state %d", hu, skb,
> -	       qca->tx_ibs_state);
> +	       qca->ibs.tx_state);
>  
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
> @@ -866,43 +886,43 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	if (!test_bit(QCA_IBS_ENABLED, &qca->flags) ||
>  	    test_bit(QCA_SUSPENDING, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
> -		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +		spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  		return 0;
>  	}
>  
>  	/* Act according to current state */
> -	switch (qca->tx_ibs_state) {
> +	switch (qca->ibs.tx_state) {
>  	case HCI_IBS_TX_AWAKE:
>  		BT_DBG("Device awake, sending normally");
>  		skb_queue_tail(&qca->txq, skb);
> -		idle_delay = msecs_to_jiffies(qca->tx_idle_delay);
> -		mod_timer(&qca->tx_idle_timer, jiffies + idle_delay);
> +		idle_delay = msecs_to_jiffies(qca->ibs.tx_idle_delay);
> +		mod_timer(&qca->ibs.tx_idle_timer, jiffies + idle_delay);
>  		break;
>  
>  	case HCI_IBS_TX_ASLEEP:
>  		BT_DBG("Device asleep, waking up and queueing packet");
>  		/* Save packet for later */
> -		skb_queue_tail(&qca->tx_wait_q, skb);
> +		skb_queue_tail(&qca->ibs.tx_wait_q, skb);
>  
> -		qca->tx_ibs_state = HCI_IBS_TX_WAKING;
> +		qca->ibs.tx_state = HCI_IBS_TX_WAKING;
>  		/* Schedule a work queue to wake up device */
> -		queue_work(qca->workqueue, &qca->ws_awake_device);
> +		queue_work(qca->workqueue, &qca->ibs.ws_awake_device);
>  		break;
>  
>  	case HCI_IBS_TX_WAKING:
>  		BT_DBG("Device waking up, queueing packet");
>  		/* Transient state; just keep packet for later */
> -		skb_queue_tail(&qca->tx_wait_q, skb);
> +		skb_queue_tail(&qca->ibs.tx_wait_q, skb);
>  		break;
>  
>  	default:
>  		BT_ERR("Illegal tx state: %d (losing packet)",
> -		       qca->tx_ibs_state);
> +		       qca->ibs.tx_state);
>  		kfree_skb(skb);
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	return 0;
>  }
> @@ -1732,10 +1752,10 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	 * still open, stop queueing the IBS data and flush all the buffered
>  	 * data in skb's.
>  	 */
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	spin_lock_irqsave(&qca->ibs.lock, flags);
>  	clear_bit(QCA_IBS_ENABLED, &qca->flags);
>  	qca_flush(hu);
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	hu->hdev->hw_error = NULL;
>  	hu->hdev->cmd_timeout = NULL;
> @@ -1959,18 +1979,18 @@ static int __maybe_unused qca_suspend(struct device *dev)
>  	if (!test_bit(QCA_IBS_ENABLED, &qca->flags))
>  		return 0;
>  
> -	cancel_work_sync(&qca->ws_awake_device);
> -	cancel_work_sync(&qca->ws_awake_rx);
> +	cancel_work_sync(&qca->ibs.ws_awake_device);
> +	cancel_work_sync(&qca->ibs.ws_awake_rx);
>  
> -	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
> +	spin_lock_irqsave_nested(&qca->ibs.lock,
>  				 flags, SINGLE_DEPTH_NESTING);
>  
> -	switch (qca->tx_ibs_state) {
> +	switch (qca->ibs.tx_state) {
>  	case HCI_IBS_TX_WAKING:
> -		del_timer(&qca->wake_retrans_timer);
> +		del_timer(&qca->ibs.wake_retrans_timer);
>  		/* Fall through */
>  	case HCI_IBS_TX_AWAKE:
> -		del_timer(&qca->tx_idle_timer);
> +		del_timer(&qca->ibs.tx_idle_timer);
>  
>  		serdev_device_write_flush(hu->serdev);
>  		cmd = HCI_IBS_SLEEP_IND;
> @@ -1981,22 +2001,22 @@ static int __maybe_unused qca_suspend(struct device *dev)
>  			break;
>  		}
>  
> -		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> -		qca->ibs_sent_slps++;
> +		qca->ibs.tx_state = HCI_IBS_TX_ASLEEP;
> +		qca->ibs.stats.sent_slps++;
>  
> -		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> +		qca_wq_serial_tx_clock_vote_off(&qca->ibs.ws_tx_vote_off);
>  		break;
>  
>  	case HCI_IBS_TX_ASLEEP:
>  		break;
>  
>  	default:
> -		BT_ERR("Spurious tx state %d", qca->tx_ibs_state);
> +		BT_ERR("Spurious tx state %d", qca->ibs.tx_state);
>  		ret = -EINVAL;
>  		break;
>  	}
>  
> -	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +	spin_unlock_irqrestore(&qca->ibs.lock, flags);
>  
>  	if (ret < 0)
>  		goto error;
> @@ -2009,7 +2029,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
>  	 */
>  
>  	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
> -			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
> +			qca->ibs.rx_state == HCI_IBS_RX_ASLEEP,
>  			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
>  
>  	if (ret > 0)
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 
