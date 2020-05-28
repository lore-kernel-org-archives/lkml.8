Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2589421532
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JiWpVhyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404965AbgE1QQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404906AbgE1QQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:16:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A5C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:16:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a45so815102pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S76ddrdGq/cBbQZ5tUQB2unFDdKjzHHbrT8hpYe9YzM=;
        b=JiWpVhyw1smRR696kDsmG/PvNo7sZu5e24qbl+VPXErlBMim+HjZG2Z2tGTg+EQ3c6
         5K/pnLuPLxYJWoQDn9cFgvvzrAYr2oaWTol8ilzpzHKI9n+DCLhZPLSDfA/RFV9JAUDD
         dNZ7x5M2uU8VqhhdK5Om372FdLpWT3N2o341M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S76ddrdGq/cBbQZ5tUQB2unFDdKjzHHbrT8hpYe9YzM=;
        b=idIdvqNo1WNSIcmfnsjY5NM8dYHkJVA4QGwGRrkB62ME9j424aGpSU9Jju8B6+wvu1
         NUyJclPuH3Bu3F4DC0C9kZeuNQSqfUnUwuJsgAK07FT+fM+0sDlZd73jMoyQRjEDdQWr
         +Lbfh0Mb9IIDEAlStqw//1rq9p80/htyDh9wr/WGA3QHbld9b+IMnDXX+OQjubNYgLeq
         P5LcMvJs7MOkWOCY9FiAGPRAm3Qw4LRaxLZjwqOtU7I18M+Wnsa9bOXJq9JKI4VdPFZF
         DRpBTqSFW+uIoWJb+q+OTx04V49Ej6xYUvSe7KeVwOa6FCWgBfvxIRqHUcrHIIhqUM10
         z1Lw==
X-Gm-Message-State: AOAM532nuDU2L0jJNgl/LlS0YSxKPN6zsquHCjJtkwrEEhqaPVRhy7vM
        n8cyRUcwcnQYs1RbaQc1MvIlcvk+L6g=
X-Google-Smtp-Source: ABdhPJx8NV9kadMCeflkmPi1yiAesNMW3uLpAf3Uo3Djp1f3fesJ94fSB9RULJ/7tXTLkUaRNCdO2A==
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr4327057plr.138.1590682589611;
        Thu, 28 May 2020 09:16:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id lj12sm5932279pjb.21.2020.05.28.09.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 09:16:28 -0700 (PDT)
Date:   Thu, 28 May 2020 09:16:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] bluetooth: hci_qca: Fix suspend/resume functionality
 failure
Message-ID: <20200528161627.GK4525@google.com>
References: <1590662302-10102-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590662302-10102-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

On Thu, May 28, 2020 at 06:38:22PM +0800, Zijun Hu wrote:
> @dev parameter of qca_suspend()/qca_resume() represents
> serdev_device, but it is mistook for hci_dev and causes
> succedent unexpected memory access.
> 
> Fix by taking @dev as serdev_device.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

Please add:

Fixes: 41d5b25fed0 ("Bluetooth: hci_qca: add PM support")

and add stable@kernel.org to cc:

> ---
>  drivers/bluetooth/hci_qca.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e4a6823..c159161 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1977,8 +1977,10 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  
>  static int __maybe_unused qca_suspend(struct device *dev)
>  {
> -	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct serdev_device *serdev = to_serdev_device(dev);
> +	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
> +	struct hci_uart *hu = &qcadev->serdev_hu;
> +	struct hci_dev *hdev __maybe_unused = hu->hdev;

hdev is not used, please remove

>  	struct qca_data *qca = hu->priv;
>  	unsigned long flags;
>  	int ret = 0;
> @@ -2057,8 +2059,10 @@ static int __maybe_unused qca_suspend(struct device *dev)
>  
>  static int __maybe_unused qca_resume(struct device *dev)
>  {
> -	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct serdev_device *serdev = to_serdev_device(dev);
> +	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
> +	struct hci_uart *hu = &qcadev->serdev_hu;
> +	struct hci_dev *hdev __maybe_unused = hu->hdev;

hdev is not used, please remove

>  	struct qca_data *qca = hu->priv;
>  
>  	clear_bit(QCA_SUSPENDING, &qca->flags);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
