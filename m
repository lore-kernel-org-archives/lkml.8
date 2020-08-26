Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE8EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ABE206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kr78kDPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHZWsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgHZWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:48:19 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:48:19 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p185so1084997vsp.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1qY92/PwTT0Gk/j2QImlQ1lTtyrii53vnwrnB6jcwg=;
        b=Kr78kDPV8rShI6VR1rKATyA8p91nltiq2JBgff3egxahVAx6vOdWahUWS7PaMDogy/
         U11DctEM0UVzdLpxGP31NOt+20skpFztsz7sBCX9vRNcPO+pIcgjNKmGR5S6Y4xHdRnI
         jpW1+OvpxWraR3wlY+RVYtZkR4YJCAeaW/7Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1qY92/PwTT0Gk/j2QImlQ1lTtyrii53vnwrnB6jcwg=;
        b=UCHEQM0BCFaXEUBBM1LvZa5sMqBHAPFxLuuDGtEx9zvABaE4ZuTXyJPV568UY68+l3
         qzAZSKBMHvprK9S6/d6Qy1dpQImpQQxOpKBeeNxpvYsvTxtVCjbO9ndHEOExLO0BKlr7
         H4O7U3yNfOEtNrloEjLBtIESY1Ftla7c8cPFP5PEtir6PqOnorVJ87LnKBOvYjze0C3B
         j3IzMkPA4uN4TF5+MDQMCC0V4JOcgtQBg0QVx3o1MLmCsO+LBEyw/eplkt4mhW0+AfB9
         92fQtFsRJui5LD+4rafal5VkXyUOefTv54cRhex4OeafNZCmmgshBUoJy8ILNR4wvfYC
         PLjw==
X-Gm-Message-State: AOAM531XZO882ZBIgHkF150K1UubiTfR3j3kbBBk0MR7EiVSWESHDl8z
        oLDy7fUMprLH7gr8LT+yFM4fxWLYwkht/aZrHluHOA==
X-Google-Smtp-Source: ABdhPJxdEd1ugfMHWrcNXgWBRatmklOZ31zN9s8sOVMobrAoeawvvRQ8HIDcXT6WLyulfcLzFc+J1AjPuMxMw3XLbS0=
X-Received: by 2002:a05:6102:2042:: with SMTP id q2mr7894641vsr.209.1598482099029;
 Wed, 26 Aug 2020 15:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200826152623.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
In-Reply-To: <20200826152623.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 26 Aug 2020 15:48:05 -0700
Message-ID: <CANFp7mVR5mWpTNOCzVqma5dL26nWLFCYRL9xBpE72ywpj8yo1Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Clear suspend tasks on unregister
To:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this earlier email without the Fixes tag.

On Wed, Aug 26, 2020 at 3:26 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> While unregistering, make sure to clear the suspend tasks before
> cancelling the work. If the unregister is called during resume from
> suspend, this will unnecessarily add 2s to the resume time otherwise.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> This was discovered with RT8822CE using the btusb driver. This chipset
> will reset on resume during system suspend and was unnecessarily adding
> 2s to every resume. Since we're unregistering anyway, there's no harm in
> just clearing the pending events.
>
>  net/bluetooth/hci_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 68bfe57b66250f..ed4cb3479433c0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3442,6 +3442,16 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>         }
>  }
>
> +static void hci_suspend_clear_tasks(struct hci_dev *hdev)
> +{
> +       int i;
> +
> +       for (i = 0; i < __SUSPEND_NUM_TASKS; ++i)
> +               clear_bit(i, hdev->suspend_tasks);
> +
> +       wake_up(&hdev->suspend_wait_q);
> +}
> +
>  static int hci_suspend_wait_event(struct hci_dev *hdev)
>  {
>  #define WAKE_COND                                                              \
> @@ -3785,6 +3795,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         cancel_work_sync(&hdev->power_on);
>
>         unregister_pm_notifier(&hdev->suspend_notifier);
> +       hci_suspend_clear_tasks(hdev);
>         cancel_work_sync(&hdev->suspend_prepare);
>
>         hci_dev_do_close(hdev);
> --
> 2.28.0.297.g1956fa8f8d-goog
>
