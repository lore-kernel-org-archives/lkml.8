Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF992145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="LcGOHsKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgE1FEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:04:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:41796 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgE1FEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:04:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590642281; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=F/YkHIoGTRVe20hlMQi6nd837QqDHegA5W6Ur6tUtDU=; b=LcGOHsKAYLm9xnjo07PODs+ZBpnmdmrgERnsKKBNAZJ38IZws/TPIo+cEF7kmuyWDcAFKxnI
 qgMZQ9/I2p0Ba8KWxFL8ob6LR+gPBqHyLM1pKy3zO7lWxPJxwNNP9BEeKOe+nfjdpvZEHPGY
 3VJuQH6SP8X12aD1lRgBwj27+qk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ecf465ebf0e32d254f19f85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 05:04:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DC82C433C9; Thu, 28 May 2020 05:04:29 +0000 (UTC)
Received: from [10.253.38.28] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37DA9C433C6;
        Thu, 28 May 2020 05:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37DA9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
Subject: Re: [PATCH v3] bluetooth: hci_qca: Fix qca6390 enable failure after
 warm reboot
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
References: <1590546759-27387-1-git-send-email-zijuhu@codeaurora.org>
 <20200527164832.GH4525@google.com>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <4c5c9fd8-e90c-c7e2-8f21-edad3c3ca7ff@codeaurora.org>
Date:   Thu, 28 May 2020 13:04:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527164832.GH4525@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 12:48 AM, Matthias Kaehlcke wrote:
> Hi Zijun,
> 
> On Wed, May 27, 2020 at 10:32:39AM +0800, Zijun Hu wrote:
>> Warm reboot can not restore qca6390 controller baudrate
>> to default due to lack of controllable BT_EN pin or power
>> supply, so fails to download firmware after warm reboot.
>>
>> Fixed by sending EDL_SOC_RESET VSC to reset controller
>> within added device shutdown implementation.
>>
>> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index e4a6823..4b6f8b6 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1975,6 +1975,34 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>>  	hci_uart_unregister_device(&qcadev->serdev_hu);
>>  }
>>  
>> +static void qca_serdev_shutdown(struct device *dev)
>> +{
>> +	int ret;
>> +	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
>> +	struct serdev_device *serdev = to_serdev_device(dev);
>> +	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>> +	const u8 ibs_wake_cmd[] = { 0xFD };
>> +	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>> +
>> +	if (qcadev->btsoc_type == QCA_QCA6390) {
>> +		serdev_device_write_flush(serdev);
>> +		serdev_device_write_buf(serdev,
>> +				ibs_wake_cmd, sizeof(ibs_wake_cmd));
>> +		serdev_device_wait_until_sent(serdev, timeout);
> 
> Why no check of the return value of serdev_device_write_buf() here,
> does it make sense to continue if sending the wakeup command failed?
> 
i will correct it at v4 patch
> Couldn't serdev_device_write() be used instead of the _write_buf() +
> _wait_until_sent() combo?
> 
i don't think so, serdev_device_write() is not appropriate at here.
serdev_device_write_wakeup() should be used to release completion hold
by serdev_device_write(), however @hci_serdev_client_ops doesn't use
serdev_device_write_wakeup() to implement its write_wakeup operation.
we don't want to touch common hci_serdev.c code.

>> +		usleep_range(8000, 10000);
>> +
>> +		serdev_device_write_flush(serdev);
> 
> I suppose the flush is done because _wait_until_sent() could have timed out.
> Another reason to use _device_write() (if suitable), since it returns
> -ETIMEDOUT in that case?
>
flush is prefixed at write operation to speed up
shutdown procedure in case of unexpected data injected
during waiting for controller wakeup.
the combo have been used and i just follow it>> +		ret = serdev_device_write_buf(serdev,
>> +				edl_reset_soc_cmd, sizeof(edl_reset_soc_cmd));
>> +		if (ret < 0) {
>> +			BT_ERR("QCA send EDL_RESET_REQ error: %d", ret);
>> +			return;
>> +		}
>> +		serdev_device_wait_until_sent(serdev, timeout);
>> +		usleep_range(8000, 10000);
>> +	}
>> +}
>> +
>>  static int __maybe_unused qca_suspend(struct device *dev)
>>  {
>>  	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
>> @@ -2100,6 +2128,7 @@ static struct serdev_device_driver qca_serdev_driver = {
>>  		.name = "hci_uart_qca",
>>  		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
>>  		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
>> +		.shutdown = qca_serdev_shutdown,
>>  		.pm = &qca_pm_ops,
>>  	},
>>  };
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
