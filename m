Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6598C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BF92073E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Z8/PWot/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgFFM6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:58:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26816 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728796AbgFFM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 08:58:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591448287; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=L0dPa4WboKgSG/BnSettdX0rSi6ZEV66DQzLoB4TqbA=;
 b=Z8/PWot/mZJpZ6offqOlc5SSFc4YZOvHO41zPKsZo9Glg0S1hFBnYnYMSe6f5Ovn4ygV7g6u
 qGZYVfCLFv9idF5EwKYG/IRKroCaxQwI21G9YjQY2H/yt7GO+X+v6ZCo41LHNMsw3G3wBqwK
 mBMiW/O9okwMb12HsbEWuP41Lic=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5edb92d8b2f512dd9d5705bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Jun 2020 12:58:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4F1BC43391; Sat,  6 Jun 2020 12:57:59 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42C22C433CA;
        Sat,  6 Jun 2020 12:57:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Jun 2020 18:27:59 +0530
From:   bgodavar@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>, hemantg@codeaurora.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Skip serdev wait when no transfer
 is pending
In-Reply-To: <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
Message-ID: <ca3bb368e9959770720c8a3fbe149652@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi matthias,

On 2020-06-06 00:16, Matthias Kaehlcke wrote:
> qca_suspend() calls serdev_device_wait_until_sent() regardless of
> whether a transfer is pending. While it does no active harm since
> the function should return immediately it makes the code more
> confusing. Add a flag to track whether a transfer is pending and
> only call serdev_device_wait_until_sent() is needed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/bluetooth/hci_qca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b1d82d32892e9..90ffd8ca1fb0d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2050,6 +2050,7 @@ static int __maybe_unused qca_suspend(struct 
> device *dev)
>  	struct hci_uart *hu = &qcadev->serdev_hu;
>  	struct qca_data *qca = hu->priv;
>  	unsigned long flags;
> +	bool tx_pending = false;
>  	int ret = 0;
>  	u8 cmd;
> 
> @@ -2083,6 +2084,7 @@ static int __maybe_unused qca_suspend(struct 
> device *dev)
> 
>  		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
>  		qca->ibs_sent_slps++;
> +		tx_pending = true;
>  		break;
> 
>  	case HCI_IBS_TX_ASLEEP:
> @@ -2099,8 +2101,10 @@ static int __maybe_unused qca_suspend(struct 
> device *dev)
>  	if (ret < 0)
>  		goto error;
> 
> -	serdev_device_wait_until_sent(hu->serdev,
> -				      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> +	if (tx_pending) {
[Bala]: Good idea why don't we move this call to switch case under 
HCI_IBS_TX_AWAKE
https://elixir.bootlin.com/linux/latest/source/drivers/bluetooth/hci_qca.c#L1994

i.e. i would recommend below sequence

1. Send SLEEP BYTE
2. wait for some time to write SLEEP Byte on Tx line
3. call for Tx clock off qca_wq_serial_tx_clock_vote_off

> +		serdev_device_wait_until_sent(hu->serdev,
> +					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> +	}
> 
>  	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is 
> going
>  	 * to sleep, so that the packet does not wake the system later.
