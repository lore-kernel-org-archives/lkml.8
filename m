Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F59C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FB2207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oeUOIdLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgEURhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:37:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47663 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbgEURhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:37:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590082635; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=F30tIyEfBVh5g5gaTce6ZjrM4vzM0/dihF/CEEqfqwE=; b=oeUOIdLBpIQvnK9WqzYt2m9Y4HvESSykxrdn6G7+wUwO0pXiVZZl/hJ3VX9rTA/v/XOFChWD
 rE1zwvrZElDdW/Y29jHTf2Xnq2UncOdRnWUfQFkVJvDicRiP2vR2V9B122VOra+yjlqzErPQ
 Hbn0P27j+h/RZnxKNCTgU0ks2c0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ec6bc497c3c9cd06989ea66 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 17:37:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E976C433CB; Thu, 21 May 2020 17:37:13 +0000 (UTC)
Received: from [10.110.95.251] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E707DC433C6;
        Thu, 21 May 2020 17:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E707DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v2 0/3] Re-introduce TX FIFO resize for larger EP bursting
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <1590050169-30747-1-git-send-email-wcheng@codeaurora.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <1e2e9c1b-fcd9-9e03-da86-a46e541a1480@codeaurora.org>
Date:   Thu, 21 May 2020 10:37:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590050169-30747-1-git-send-email-wcheng@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2020 1:36 AM, Wesley Cheng wrote:
> Changes in V2:
>  - Modified TXFIFO resizing logic to ensure that each EP is reserved a
>    FIFO.
>  - Removed dev_dbg() prints and fixed typos from patches
>  - Added some more description on the dt-bindings commit message
>


> Reviewed-by: Felipe Balbi <balbi@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Sorry, please disregard the Reviewed-by tags in the patches.  I added
those mistakenly.

> Currently, there is no functionality to allow for resizing the TXFIFOs, and
> relying on the HW default setting for the TXFIFO depth.  In most cases, the
> HW default is probably sufficient, but for USB compositions that contain
> multiple functions that require EP bursting, the default settings
> might not be enough.  Also to note, the current SW will assign an EP to a
> function driver w/o checking to see if the TXFIFO size for that particular
> EP is large enough. (this is a problem if there are multiple HW defined
> values for the TXFIFO size)
> 
> It is mentioned in the SNPS databook that a minimum of TX FIFO depth = 3
> is required for an EP that supports bursting.  Otherwise, there may be
> frequent occurences of bursts ending.  For high bandwidth functions,
> such as data tethering (protocols that support data aggregation), mass
> storage, and media transfer protocol (over FFS), the bMaxBurst value can be
> large, and a bigger TXFIFO depth may prove to be beneficial in terms of USB
> throughput. (which can be associated to system access latency, etc...)  It
> allows for a more consistent burst of traffic, w/o any interruptions, as
> data is readily available in the FIFO.
> 
> With testing done using the mass storage function driver, the results show
> that with a larger TXFIFO depth, the bandwidth increased significantly.
> 
> Test Parameters:
>  - Platform: Qualcomm SM8150
>  - bMaxBurst = 6
>  - USB req size = 256kB
>  - Num of USB reqs = 16
>  - USB Speed = Super-Speed
>  - Function Driver: Mass Storage (w/ ramdisk)
>  - Test Application: CrystalDiskMark
> 
> Results:
> 
> TXFIFO Depth = 3 max packets
> 
> Test Case | Data Size | AVG tput (in MB/s)
> -------------------------------------------
> Sequential|1 GB x     | 
> Read      |9 loops    | 193.60
> 	  |           | 195.86
>           |           | 184.77
>           |           | 193.60
> -------------------------------------------
> 
> TXFIFO Depth = 6 max packets
> 
> Test Case | Data Size | AVG tput (in MB/s)
> -------------------------------------------
> Sequential|1 GB x     | 
> Read      |9 loops    | 287.35
> 	  |           | 304.94
>           |           | 289.64
>           |           | 293.61
> -------------------------------------------
> 
> Wesley Cheng (3):
>   usb: dwc3: Resize TX FIFOs to meet EP bursting requirements
>   arm64: boot: dts: qcom: sm8150: Enable dynamic TX FIFO resize logic
>   dt-bindings: usb: dwc3: Add entry for tx-fifo-resize
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |   2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi           |   1 +
>  drivers/usb/dwc3/core.c                        |   2 +
>  drivers/usb/dwc3/core.h                        |   8 ++
>  drivers/usb/dwc3/ep0.c                         |  37 ++++++++-
>  drivers/usb/dwc3/gadget.c                      | 111 +++++++++++++++++++++++++
>  6 files changed, 159 insertions(+), 2 deletions(-)
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
