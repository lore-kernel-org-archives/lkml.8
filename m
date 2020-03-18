Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36409C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F1020774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkVt+bwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRNlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:41:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCRNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:41:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id h6so10124377wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vqa6f91n5tqYaruXqwXHizG6T93kWUeobccehh6qm8=;
        b=jkVt+bwJK9uYi6EaZJNVp3BLRCYOv438Nnj06R9M3zGmCGLAMtcqw7ZkYR62UP1lKV
         DYPk1TBmHGBkYJCN4bScGe9VSeDD+HqnIIoXWYs5gjQWlf6kGSlLA7pfLK9yaPo0jf4p
         2zy5cHmuQWZJHtxZ/c9fxooGU4HjkG2oeavkWslysSnI6iPYZ+s8+svWve2WQwdQsjbB
         +MG2mS/nx3cB+NhHcb4HRSABJLhUyf2/eDQGT06X4oaRhSMkb0ji3R4zEFZjplbIYsbs
         cpVO6xYiV3V2oZFFQiJtEj5KZw+1jAEAc8/BF7alNc6226bRJvvwiaj6ncm9iQt0epXs
         9+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vqa6f91n5tqYaruXqwXHizG6T93kWUeobccehh6qm8=;
        b=uL8+ee1m/kwGow5/v3L6yUEkvtEhzjKhMzHOBktLryryKlqR6KMMdUUoXLTnvhNnOM
         dKgcHUtnmGzLCDY+8Iy6uYZL7eq8ADsWDQRFIhFATPl4qPDD3TPGAsiG7CAabt/E6UXt
         kcAkrxaSbB0j2w/c/a9n3jC6FpXtT73yV2PK3oglT7xScC8cA0UIyxx3bIGOvalkQf0g
         4D+v9xEv1hxy2Moq2L3ZpFb1NNTw6hUApagFOeKXh8+xpfVOptuqR7VNYJ+QtRfCLhKv
         xtumPGtswaf+3A4T8BUrcWX4Kj7s65mQIAX76K5APQ5pd4prPkUinCmbaffhd6mFMYmE
         VfsA==
X-Gm-Message-State: ANhLgQ09PtolMYFd+hOG6xxOEpv6H2I5ah8D7lHNjjxJhwBdyW4V2QrB
        VcRY2O1BecWn5ZMqZ/NG0xHSF4w5MoQ=
X-Google-Smtp-Source: ADFU+vuErWRQzAYGtyRkanb5pQc8vP9eJYuhg3l0ggj1C7K/RQSVXk0DSadczolE4KFMZV/61CbgYQ==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr6008909wrt.132.1584538859624;
        Wed, 18 Mar 2020 06:40:59 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b82sm3881671wmb.46.2020.03.18.06.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:40:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvmem: sprd: Fix the block lock operation
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        linux-kernel@vger.kernel.org
References: <cover.1584072223.git.baolin.wang7@gmail.com>
 <03c391fc1bbc3575ed47d5d249106de9e0b7d508.1584072223.git.baolin.wang7@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e71a9500-9671-ba54-5297-b547e135287d@linaro.org>
Date:   Wed, 18 Mar 2020 13:40:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <03c391fc1bbc3575ed47d5d249106de9e0b7d508.1584072223.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/2020 04:07, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> According to the Spreadtrum eFuse specification, we should write 0 to
> the block to trigger the lock operation.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>   drivers/nvmem/sprd-efuse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)



Applied all thanks,
srini
