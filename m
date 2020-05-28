Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46242145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="U0mB3Kjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgE1Jba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:31:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42737 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgE1Jb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:31:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590658288; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=N6JOeyiaVOjJlL2Dph+G8pd68tEHavADTJ/VOgDov9w=; b=U0mB3KjlMWOQe/QqhyvpXEX5pVc7lBTDUjUg241pfQTsC7AkBDm1a1o1YhdDP7Ak/Xz9sDsV
 oyIPqWSkVmIoeYDDFdXFISozg7vTSZ5OnpUksLSHaStaXEDg3WjoNlORuM1iMIMVvJ3m3DBR
 xY4Z7o5oq+ge86lGTDifj5mfJ4o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ecf84e5ea0dfa490e091541 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 09:31:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71D59C433C9; Thu, 28 May 2020 09:31:16 +0000 (UTC)
Received: from [10.253.38.28] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DBBDC433C6;
        Thu, 28 May 2020 09:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DBBDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Improve controller ID info log
 level
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, mka@chromium.org, rjliao@codeaurora.org
References: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
 <A9C9A8F9-01AA-40D9-A0CA-25BA18B74BDA@holtmann.org>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <d238c1ac-bcce-28f5-4d74-66e0bc4189c4@codeaurora.org>
Date:   Thu, 28 May 2020 17:31:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <A9C9A8F9-01AA-40D9-A0CA-25BA18B74BDA@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 4:16 PM, Marcel Holtmann wrote:
> Hi Zijun,
> 
>> Controller ID info got by VSC EDL_PATCH_GETVER is very
>> important, so improve its log level from DEBUG to INFO.
>>
>> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
>> ---
>> drivers/bluetooth/btqca.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 3ea866d..94d8e15 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -74,10 +74,14 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>>
>> 	ver = (struct qca_btsoc_version *)(edl->data);
>>
>> -	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
>> -	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
>> -	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
>> -	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
>> +	bt_dev_info(hdev, "QCA Product ID   :0x%08x",
>> +			le32_to_cpu(ver->product_id));
>> +	bt_dev_info(hdev, "QCA SOC Version  :0x%08x",
>> +			le32_to_cpu(ver->soc_id));
>> +	bt_dev_info(hdev, "QCA ROM Version  :0x%08x",
>> +			le16_to_cpu(ver->rom_ver));
>> +	bt_dev_info(hdev, "QCA Patch Version:0x%08x",
>> +			le16_to_cpu(ver->patch_ver));
> 
> please align correctly according to the coding style.
>
if bt_dev_info() is wrote at one line, it will exceed 80 characters
so i split it at two line and aligned via vim. 
 
> Regards
> 
> Marcel
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
