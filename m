Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91401C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6D2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLKa3Eru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFEEx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgFEEx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:53:58 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB53C08C5C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 21:53:58 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j13so4887933vsn.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSK3iGrwNXhNPMJarS5DBwkVfOTARnkNBQgwEVg9fzQ=;
        b=OLKa3Eru19miQbfdsFwziHODftiQNhKc4EdQde9u1NnrdN7pNq03T9y6y7pRRxwOH/
         3O+4MIcvxf/abLwwAyZDvo3EVUiawKW9fPciyLPXrNe3mzA4cb0fsaqJEtKQPGjet+0x
         yUiD4YjaWXlzJaW3tX5tQX009Vhxc4SCODiWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSK3iGrwNXhNPMJarS5DBwkVfOTARnkNBQgwEVg9fzQ=;
        b=tx3bHPZFINMLq9gXMeEn/xduSTp8jQkOa8xP9cyKcHybkXztaYkp9dEPNutlWlZ0dZ
         meWlscHfgFqBN7ryyQEQ/BcxYpv1ZgBKRqiwP2EdsjYG8lecscrT2EzdGyGpLuUwoUPC
         E8mH+z2KfNM4jdx+K3Uf2INcG/Z+soa8ht5mtm+xR75gGfbI5XckCgrvL5p4g42siZLg
         wyVIFrCqT7KMEj83u8xDmArg6RgkjLUMK0H6KHcg4ti6TrC0k3So86jxe/bF+ORSdfab
         CQBYEA/OXtnL/cxTaddPbfQvFnTmofiQOZMboji7GETpJvCZsuj3dgnKo3jCfunkkFhg
         YozA==
X-Gm-Message-State: AOAM530tebg8ItdDXleE40aWNk5YGgxZWAIxE5S/zzptQbgY+m0Z1miF
        6a+6XTY6OzW7jxSSh97ilm633DF4fKJ/BGw0B+xQbw==
X-Google-Smtp-Source: ABdhPJwdWFvJCxmedX/E9k5TaI0rTCAck27IIEFlzSk+XHOBcn46sl1Tb3UUpBvYtbnaohow5PXV2JknybmaQG/rT6Y=
X-Received: by 2002:a67:3c6:: with SMTP id 189mr6264601vsd.71.1591332836701;
 Thu, 04 Jun 2020 21:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <1591279032-7527-1-git-send-email-gubbaven@codeaurora.org>
In-Reply-To: <1591279032-7527-1-git-send-email-gubbaven@codeaurora.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 4 Jun 2020 21:53:42 -0700
Message-ID: <CANFp7mX1iKNETqzjdp5z4OrRJBdaGV+f4rOQBtGomYEhsazVfw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Fix double free during SSR timeout
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        robh@kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        Claire Chang <tientzu@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, rjliao@codeaurora.org,
        Yoni Shavit <yshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 4, 2020 at 6:59 AM Venkata Lakshmi Narayana Gubba
<gubbaven@codeaurora.org> wrote:
>
> Due to race conditions between qca_hw_error and qca_controller_memdump
> during SSR timeout,the same pointer is freed twice. Which results to
> double free error. Now a lock is acquired while SSR state moved to timeout.
suggestion: Change "which results to double free error" to "This
results in a double free."
suggestion: Change "while SSR state moved to timeout" to "when SSR
state is changed to timeout"

>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 836949d..9110775 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -983,8 +983,11 @@ static void qca_controller_memdump(struct work_struct *work)
>         while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
>
>                 mutex_lock(&qca->hci_memdump_lock);
> -               /* Skip processing the received packets if timeout detected. */
> -               if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT) {
> +               /* Skip processing the received packets if timeout detected
> +                * or memdump collection completed.
> +                */
> +               if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
> +                   qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
>                         mutex_unlock(&qca->hci_memdump_lock);
>                         return;
>                 }
> @@ -1485,7 +1488,7 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  {
>         struct hci_uart *hu = hci_get_drvdata(hdev);
>         struct qca_data *qca = hu->priv;
> -       struct qca_memdump_data *qca_memdump = qca->qca_memdump;
> +       struct qca_memdump_data *qca_memdump = NULL;
>         char *memdump_buf = NULL;
>
>         set_bit(QCA_HW_ERROR_EVENT, &qca->flags);
> @@ -1509,9 +1512,10 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>                 qca_wait_for_dump_collection(hdev);
>         }
>
> +       mutex_lock(&qca->hci_memdump_lock);
>         if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
>                 bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
> -               mutex_lock(&qca->hci_memdump_lock);
> +               qca_memdump = qca->qca_memdump;
>                 if (qca_memdump)
>                         memdump_buf = qca_memdump->memdump_buf_head;
>                 vfree(memdump_buf);

This section of code looks a bit unclear because it's only partially
in an if statement. Suggestion:
  if (qca->qca_memdump) {
    vfree(qca->qca_memdump->memdump_buf_head);
    kfree(qca->qca_memdump);
    qca->qca_memdump = NULL;
  }

> @@ -1520,8 +1524,13 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>                 qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
>                 cancel_delayed_work(&qca->ctrl_memdump_timeout);
>                 skb_queue_purge(&qca->rx_memdump_q);
> -               mutex_unlock(&qca->hci_memdump_lock);
> +       }
> +       mutex_unlock(&qca->hci_memdump_lock);
> +
> +       if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
> +           qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
>                 cancel_work_sync(&qca->ctrl_memdump_evt);
> +               skb_queue_purge(&qca->rx_memdump_q);
>         }

Earlier in the function, you call qca_wait_for_dump_collection for
[Idle, Collecting] so the state should be either [Timeout, Collected]
at this branch. So, you can remove the `cancel_delayed_work` and
`skb_queue_purge` from above and just leave it only in the bottom
branch. Currently you're duplicating these calls unnecessarily.

I don't know if we discussed this in an earlier review but I noticed
that `qca_wait_for_dump_collection` doesn't actually pay attention to
the return value of `wait_on_bit_timeout`. I don't have context for
the order of calls anymore but is there a possibility for that timeout
to complete before `qca_memdump_timeout` is called? In that case, you
should probably set the state to timeout in
`qca_wait_for_dump_collection` as well.

>
>         clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
