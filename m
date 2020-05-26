Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29EB207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kgFR34KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgEZPea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgEZPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:34:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F83C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:34:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so10317219pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8W11mCFaZlqqgwjd6pr/5BoHKN+oaQPu3yE26VkZIxk=;
        b=kgFR34KBsx0oI1+MKKstfa5lW1H5kQ16Y3jO42RlsqGTyZe7QT5tmf1xmKgWNZI6ub
         XyrEvbKspvwFeI1YqvY+nWDW2SVEsc2mJiHS0OKG0sbHzL+pYMGEGFTVbP8Y9eVmH9Wc
         o65pnCp6nWc1vf1fxko35nOU3W0XLc3OwdzFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8W11mCFaZlqqgwjd6pr/5BoHKN+oaQPu3yE26VkZIxk=;
        b=A1HjMxxMupb9F3l4d3wfXjBrEn8oRl2G4lO1Ctt52MGv6/YtKtvSB0AM4j8Bx8Gu5/
         y7ERwa9JRdoXt2YkAsFl+AVizRtmefREKlZEkY1xOGklmBqETPDgDoC6aZdeTiQrEjaN
         sJqwNxwCyzRh06prKDKFsFqfeZYOdW9wfeVS9yzSM80E4N1lURk3DZWUFpM4qKuuoVL0
         /T5/SER5VqQIHBcZ+DGrOXazpww4Kb84i27ekPY3hEY0iyaMlr4w1Y/pExLvPRmE3376
         j1DTiz7PzxS13Rx8rqAxybmfTAK7cWcwZGhGT4px0ZxTE2JCWRmsFLdXoozRWaYFmduB
         Mctw==
X-Gm-Message-State: AOAM530wRnnA6sf/bXS49D7tfebnO4r30IaJZds9ieS3T097Q6a+71YN
        REfJkCdOhzZx9+6vie9Rr1GGCA==
X-Google-Smtp-Source: ABdhPJwvQUuJk+3JmCR8WIBdZSU/GvEbA9MR1r4bCTHrtiDU0sJOoFq1RbVUiRntAYHcL1SgZGUWCA==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr1608669pgd.412.1590507268516;
        Tue, 26 May 2020 08:34:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id r1sm83636pgb.37.2020.05.26.08.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 08:34:27 -0700 (PDT)
Date:   Tue, 26 May 2020 08:34:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v2] bluetooth: hci_qca: Fix qca6390 enable failure after
 warm reboot
Message-ID: <20200526153425.GD4525@google.com>
References: <1590461850-9908-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590461850-9908-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:57:30AM +0800, Zijun Hu wrote:
> Warm reboot can not restore qca6390 controller baudrate
> to default due to lack of controllable BT_EN pin or power
> supply, so fails to download firmware after warm reboot.
> 
> Fixed by sending EDL_SOC_RESET VSC to reset controller
> within added device shutdown implementation.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e4a6823..b479e51 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1975,6 +1975,32 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  	hci_uart_unregister_device(&qcadev->serdev_hu);
>  }
>  
> +static void qca_serdev_shutdown(struct device *dev)
> +{
> +	int res;

nit: 'ret' would be a more standard name

> +	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
> +	struct serdev_device *serdev = to_serdev_device(dev);
> +	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
> +	const u8 ibs_wake_cmd[] = { 0xFD };
> +	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
> +
> +	if (qcadev->btsoc_type == QCA_QCA6390) {
> +		serdev_device_write_flush(serdev);
> +		res = serdev_device_write_buf(serdev,
> +				ibs_wake_cmd, sizeof(ibs_wake_cmd));
> +		BT_DBG("%s: send ibs_wake_cmd res = %d", __func__, res);

Why use BT_DBG regardless of the result, instead of using BT_ERR/WARN only
in the failure case? And does it actually make sense to continue in case of
an error?

> +		serdev_device_wait_until_sent(serdev, timeout);
> +		usleep_range(8000, 10000);
> +
> +		serdev_device_write_flush(serdev);
> +		res = serdev_device_write_buf(serdev,
> +				edl_reset_soc_cmd, sizeof(edl_reset_soc_cmd));
> +		BT_DBG("%s: send edl_reset_soc_cmd res = %d", __func__, res);

ditto

> +		serdev_device_wait_until_sent(serdev, timeout);
> +		usleep_range(8000, 10000);
> +	}
> +}
> +
>  static int __maybe_unused qca_suspend(struct device *dev)
>  {
>  	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
> @@ -2100,6 +2126,7 @@ static struct serdev_device_driver qca_serdev_driver = {
>  		.name = "hci_uart_qca",
>  		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
>  		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
> +		.shutdown = qca_serdev_shutdown,
>  		.pm = &qca_pm_ops,
>  	},
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
