Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD76C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5D220737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YT5p2fmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgFIPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:55:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42856 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730794AbgFIPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:55:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591718131; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=otJoXnyUTJ+AO1rtsueTFB+5jLpzPuvXqndqJnQhE84=;
 b=YT5p2fmSxx6XIuJFpYoWdrcGf4+o9/UrGJxjhbhMh8IgM815eT4UrOryf70dSTFFN7BppNDh
 wBcIpkCj/omVmuPhGonteYoGWyI2R6acEBNd4xPp2hlRmCeTlzpQ7GJthWG7qw1dbVcqb4sE
 Ru3bYeAXlZWLt+8JxBFLE9tuGr0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5edfb0e5bfb34e631cdf6e98 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 15:55:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27FF7C433C6; Tue,  9 Jun 2020 15:55:16 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: gubbaven)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32084C433C6;
        Tue,  9 Jun 2020 15:55:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 21:25:15 +0530
From:   gubbaven@codeaurora.org
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
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
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Fix double free during SSR timeout
In-Reply-To: <CANFp7mX1iKNETqzjdp5z4OrRJBdaGV+f4rOQBtGomYEhsazVfw@mail.gmail.com>
References: <1591279032-7527-1-git-send-email-gubbaven@codeaurora.org>
 <CANFp7mX1iKNETqzjdp5z4OrRJBdaGV+f4rOQBtGomYEhsazVfw@mail.gmail.com>
Message-ID: <219ebb83d596c245beed703e102122ab@codeaurora.org>
X-Sender: gubbaven@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2020-06-05 10:23, Abhishek Pandit-Subedi wrote:
> Hi,
> 
> On Thu, Jun 4, 2020 at 6:59 AM Venkata Lakshmi Narayana Gubba
> <gubbaven@codeaurora.org> wrote:
>> 
>> Due to race conditions between qca_hw_error and qca_controller_memdump
>> during SSR timeout,the same pointer is freed twice. Which results to
>> double free error. Now a lock is acquired while SSR state moved to 
>> timeout.
> suggestion: Change "which results to double free error" to "This
> results in a double free."
> suggestion: Change "while SSR state moved to timeout" to "when SSR
> state is changed to timeout"
> 
[Venkata]:
Sure will update in next patchset.
>> 
>> Signed-off-by: Venkata Lakshmi Narayana Gubba 
>> <gubbaven@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 836949d..9110775 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -983,8 +983,11 @@ static void qca_controller_memdump(struct 
>> work_struct *work)
>>         while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
>> 
>>                 mutex_lock(&qca->hci_memdump_lock);
>> -               /* Skip processing the received packets if timeout 
>> detected. */
>> -               if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT) {
>> +               /* Skip processing the received packets if timeout 
>> detected
>> +                * or memdump collection completed.
>> +                */
>> +               if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
>> +                   qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
>>                         mutex_unlock(&qca->hci_memdump_lock);
>>                         return;
>>                 }
>> @@ -1485,7 +1488,7 @@ static void qca_hw_error(struct hci_dev *hdev, 
>> u8 code)
>>  {
>>         struct hci_uart *hu = hci_get_drvdata(hdev);
>>         struct qca_data *qca = hu->priv;
>> -       struct qca_memdump_data *qca_memdump = qca->qca_memdump;
>> +       struct qca_memdump_data *qca_memdump = NULL;
>>         char *memdump_buf = NULL;
>> 
>>         set_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>> @@ -1509,9 +1512,10 @@ static void qca_hw_error(struct hci_dev *hdev, 
>> u8 code)
>>                 qca_wait_for_dump_collection(hdev);
>>         }
>> 
>> +       mutex_lock(&qca->hci_memdump_lock);
>>         if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
>>                 bt_dev_err(hu->hdev, "clearing allocated memory due to 
>> memdump timeout");
>> -               mutex_lock(&qca->hci_memdump_lock);
>> +               qca_memdump = qca->qca_memdump;
>>                 if (qca_memdump)
>>                         memdump_buf = qca_memdump->memdump_buf_head;
>>                 vfree(memdump_buf);
> 
> This section of code looks a bit unclear because it's only partially
> in an if statement. Suggestion:
>   if (qca->qca_memdump) {
>     vfree(qca->qca_memdump->memdump_buf_head);
>     kfree(qca->qca_memdump);
>     qca->qca_memdump = NULL;
>   }
> 
[Venkata]:
Sure will update in next patchset.
>> @@ -1520,8 +1524,13 @@ static void qca_hw_error(struct hci_dev *hdev, 
>> u8 code)
>>                 qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
>>                 cancel_delayed_work(&qca->ctrl_memdump_timeout);
>>                 skb_queue_purge(&qca->rx_memdump_q);
>> -               mutex_unlock(&qca->hci_memdump_lock);
>> +       }
>> +       mutex_unlock(&qca->hci_memdump_lock);
>> +
>> +       if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
>> +           qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
>>                 cancel_work_sync(&qca->ctrl_memdump_evt);
>> +               skb_queue_purge(&qca->rx_memdump_q);
>>         }
> 
> Earlier in the function, you call qca_wait_for_dump_collection for
> [Idle, Collecting] so the state should be either [Timeout, Collected]
> at this branch. So, you can remove the `cancel_delayed_work` and
> `skb_queue_purge` from above and just leave it only in the bottom
> branch. Currently you're duplicating these calls unnecessarily.
> 
> I don't know if we discussed this in an earlier review but I noticed
> that `qca_wait_for_dump_collection` doesn't actually pay attention to
> the return value of `wait_on_bit_timeout`. I don't have context for
> the order of calls anymore but is there a possibility for that timeout
> to complete before `qca_memdump_timeout` is called? In that case, you
> should probably set the state to timeout in
> `qca_wait_for_dump_collection` as well.
> 
[Venkata]:
I see only skb_queue_purge is getting duplicated and will update in next 
patchset.
But cancel_delayed_work is for qca->ctrl_memdump_timeout and 
cancel_work_sync is for
qca->ctrl_memdump_evt.So these calls are not getting duplicated.

If timeout happens in qca_wait_for_dump_collection, we are setting state 
to timeout
in subsequent if block which is  if (qca->memdump_state != 
QCA_MEMDUMP_COLLECTED).
>> 
>>         clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 

Regards,
Lakshmi Narayana.
