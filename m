Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FCC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DEC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UXoMZ5qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgAMEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:31:12 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29588 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387474AbgAMEbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:31:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578889871; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kLWHsDu+lXLZgOyBoFDbIPxxLyvvZ/yYAxYjOJEO5nQ=;
 b=UXoMZ5qgmqz7NZ/aIQZpYLJttXD90xcpLAzAVjRfj19mF4Ixx31KlLQ5WXfmSrOZssN+mjo0
 PmKWvKC/+isxZqVaekm8VUG+r5VohvD/jKsRlwCeXV3Cez7w9LIXkAKL68lpfPd46BOVeOpq
 H2BFHIzUZ9nTuf1hzvyr1zM2L5U=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1bf28e.7fe114443848-smtp-out-n03;
 Mon, 13 Jan 2020 04:31:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E144C43383; Mon, 13 Jan 2020 04:31:10 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD4FC433CB;
        Mon, 13 Jan 2020 04:31:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 13 Jan 2020 12:31:08 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Add qca_power_on() API to support
 both wcn399x and Rome power up
In-Reply-To: <20200113042942.9526-1-rjliao@codeaurora.org>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
 <20200113042942.9526-1-rjliao@codeaurora.org>
Message-ID: <5bd30d7a3fabcc73d50e428d4a874755@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this one. I was wanting to send v5...

在 2020-01-13 12:29，Rocky Liao 写道：
> This patch adds a unified API qca_power_on() to support both wcn399x 
> and
> Rome power on. For wcn399x it calls the qca_wcn3990_init() to init the
> regulators, and for Rome it pulls up the bt_en GPIO to power up the 
> btsoc.
> It also moves all the power up operation from hdev->open() to
> hdev->setup().
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2: None
> Changes in v3:
>   -moved all the power up operation from open() to setup()
>   -updated the commit message
> Changes in v4:
>   -made a single call to qca_power_on() in setup()
> 
> 
>  drivers/bluetooth/hci_qca.c | 48 +++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 82e4cd4b6663..6a67e5489b16 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -541,7 +541,6 @@ static int qca_open(struct hci_uart *hu)
>  {
>  	struct qca_serdev *qcadev;
>  	struct qca_data *qca;
> -	int ret;
> 
>  	BT_DBG("hu %p qca_open", hu);
> 
> @@ -582,23 +581,10 @@ static int qca_open(struct hci_uart *hu)
>  	hu->priv = qca;
> 
>  	if (hu->serdev) {
> -
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (!qca_is_wcn399x(qcadev->btsoc_type)) {
> -			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> -			/* Controller needs time to bootup. */
> -			msleep(150);
> -		} else {
> +		if (qca_is_wcn399x(qcadev->btsoc_type)) {
>  			hu->init_speed = qcadev->init_speed;
>  			hu->oper_speed = qcadev->oper_speed;
> -			ret = qca_regulator_enable(qcadev);
> -			if (ret) {
> -				destroy_workqueue(qca->workqueue);
> -				kfree_skb(qca->rx_skb);
> -				hu->priv = NULL;
> -				kfree(qca);
> -				return ret;
> -			}
>  		}
>  	}
> 
> @@ -1531,6 +1517,31 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  	return 0;
>  }
> 
> +static int qca_power_on(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> +	struct qca_serdev *qcadev;
> +	int ret = 0;
> +
> +	/* Non-serdev device usually is powered by external power
> +	 * and don't need additional action in driver for power on
> +	 */
> +	if (!hu->serdev)
> +		return 0;
> +
> +	if (qca_is_wcn399x(soc_type)) {
> +		ret = qca_wcn3990_init(hu);
> +	} else {
> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +		/* Controller needs time to bootup. */
> +		msleep(150);
> +	}
> +
> +	return ret;
> +}
> +
>  static int qca_setup(struct hci_uart *hu)
>  {
>  	struct hci_dev *hdev = hu->hdev;
> @@ -1553,6 +1564,10 @@ static int qca_setup(struct hci_uart *hu)
>  	 */
>  	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 
> +	ret = qca_power_on(hdev);
> +	if (ret)
> +		return ret;
> +
>  	if (qca_is_wcn399x(soc_type)) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> 
> @@ -1562,9 +1577,6 @@ static int qca_setup(struct hci_uart *hu)
>  		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>  		hu->hdev->shutdown = qca_power_off;
> -		ret = qca_wcn3990_init(hu);
> -		if (ret)
> -			return ret;
> 
>  		ret = qca_read_soc_version(hdev, &soc_ver, soc_type);
>  		if (ret)
