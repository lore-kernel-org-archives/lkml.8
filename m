Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D0C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9261320730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HuRn1U2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgD1RFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:05:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53447 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728250AbgD1RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:05:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588093517; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mqKQIoILk4/C9tu+s2NOo/+BdCq+TYpvfCmXhPRSth4=; b=HuRn1U2JmkR5++H+8hnPHBqCrumoA25g7d2O9PfdqxvqBapNdBsANhbt6Kghs/KHSn8rPw74
 Is09GRx50ZrRNYTbWvHlJVVDbrLtj+UoGC7JMPdhQfcEtei7RsLWXcsvQU8IjjxDEVPIJNaT
 p6Uq+PcNt7JUL+FHuM1zWCQOtaU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea86246.7ff446188e68-smtp-out-n02;
 Tue, 28 Apr 2020 17:05:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3588EC43636; Tue, 28 Apr 2020 17:05:09 +0000 (UTC)
Received: from [10.110.78.22] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7B85C433D2;
        Tue, 28 Apr 2020 17:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7B85C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v6 0/5] Add SS/HS-USB changes for Qualcomm SM8150 chipset
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1586472749-18599-1-git-send-email-wcheng@codeaurora.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <2e9ec41c-5d98-db66-9395-1651ce24cece@codeaurora.org>
Date:   Tue, 28 Apr 2020 10:05:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586472749-18599-1-git-send-email-wcheng@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon/Vinod,

Is this series good, and can be picked up?  Noticed that there was
another recent change to the QMP PHY driver as well:
https://patchwork.kernel.org/cover/11514761/

Did you want me to rebase my changes on top of that, or the current
changes are sufficient?

Thanks
Wesley

On 4/9/2020 3:52 PM, Wesley Cheng wrote:
> This series adds support for the Synopsis 7nm HSPHY USB driver being
> used in QCOM chipsets.  The HSPHY register map differs compared to 
> other PHY revisions.  In addition, modifications and updates are done
> to the QMP driver to add new registers/offsets, and to update the
> initialization sequence for enabling the SSUSB path on SM8150.
> 
> Changes in v6:
>  - Addressed coding style errors in phy-qcom-snps-femto-v2.c
> 
> Changes in v5:
>  - Reorganize IF check for when to use the proper PWRDOWN CTRL offset
>  - Rename UFS specific offset definitions in the QMP PHY driver to clearly
>    denote they are UFS specific
>  - Rename the phy-qcom-snps-7nm driver to phy-qcom-snps-femto-v2
> 
> Changes in v4:
>  - Fix POWERDOWN offset for QMP PHY exit routine, and check for
>    has_phy_dp_com_ctrl instead of !has_phy_com_ctrl
> 
> Changes in v3:
>  - Use devm_reset_control_get_exclusive instead of referencing index for
>    reset handle
> 
> Changes in v2:
>  - Fixed YAML errors caught by dt_binding_check
> 
> Jack Pham (1):
>   phy: qcom-qmp: Add SM8150 QMP USB3 PHY support
> 
> Wesley Cheng (4):
>   dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2
>   phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
>   phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
>   phy: qcom-qmp: Rename UFS PCS QMP v4 registers
> 
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  77 ++++++
>  drivers/phy/qualcomm/Kconfig                       |  10 +
>  drivers/phy/qualcomm/Makefile                      |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 193 +++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h                | 238 +++++++++++++++--
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 296 +++++++++++++++++++++
>  6 files changed, 779 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
