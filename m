Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2FA2073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KqsGfimH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgFFMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:53:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55164 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbgFFMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 08:53:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591447995; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8lSmFwwn8suFfajmfcWy9VDml1caclfVTUHAXUEzFe0=;
 b=KqsGfimHInMR8x18+xlA2gevOwzwf8TpYFuH1SVRDU50kIZj473ywI/KfeBB6nq4z/xsOkBa
 JdwXofJugX/tJcKpW4M02HwuuwnqH5QxouTNIgR4v2IrSuHyue0Yn6ox/nNiNV3WuZd9uOWs
 qAIuEBl3TAZJ9QXKsfmE766ArjU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5edb91bbd26ace6bd5d2af1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Jun 2020 12:53:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B42D7C433CB; Sat,  6 Jun 2020 12:53:14 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06F4AC433CA;
        Sat,  6 Jun 2020 12:53:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Jun 2020 18:23:13 +0530
From:   bgodavar@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH 1/3] Bluetooth: hci_qca: Only remove TX clock vote after
 TX is completed
In-Reply-To: <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
Message-ID: <534a51662c623a512780e20162138469@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2020-06-06 00:16, Matthias Kaehlcke wrote:
> qca_suspend() removes the vote for the UART TX clock after
> writing an IBS sleep request to the serial buffer. This is
> not a good idea since there is no guarantee that the request
> has been sent at this point. Instead remove the vote after
> successfully entering IBS sleep. This also fixes the issue
> of the vote being removed in case of an aborted suspend due
> to a failure of entering IBS sleep.
> 
> Fixes: 41d5b25fed0a0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ece9f91cc3deb..b1d82d32892e9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2083,8 +2083,6 @@ static int __maybe_unused qca_suspend(struct 
> device *dev)
> 
>  		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
>  		qca->ibs_sent_slps++;
> -
> -		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
>  		break;
> 
>  	case HCI_IBS_TX_ASLEEP:
> @@ -2112,8 +2110,10 @@ static int __maybe_unused qca_suspend(struct 
> device *dev)
>  			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
>  			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
> 
> -	if (ret > 0)
> +	if (ret > 0) {
> +		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
[Bala]: qca_wq_serial_tx_clock_vote_off votes for Tx clock off, when 
both Tx clock and Rx clock voted to off.
then only actual call to clock off is called.
https://elixir.bootlin.com/linux/latest/source/drivers/bluetooth/hci_qca.c#L312
I would recommend to vote Tx clock off after sending SLEEP BYTE from 
HOST TO BT SOC.

>  		return 0;
> +	}
> 
>  	if (ret == 0)
>  		ret = -ETIMEDOUT;
