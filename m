Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C8DC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FAF2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VI0HbAwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDGW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:29:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40322 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbgDGW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:29:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586298594; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Y51llxo6V8hgiVIDqT1dGRczqJHThRU0itOQaSw5CeI=; b=VI0HbAwX2zoGlE/mrWClJR4gNs7YWmRgcqP12BG964IeQ0KU9sMFlqaOzO6ySbOr5uk+Fndc
 wWRDTkuUO97oRdX+uJaPVSCKvx+KA5RKN1pT1pzsfo5kA7DNwzfkrtlI1ibNhELAzOsxgNxB
 SUaMA23/ucdpEsD2I3u5HGSo9Fk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8cfed9.7fa01118d928-smtp-out-n01;
 Tue, 07 Apr 2020 22:29:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 220DFC44788; Tue,  7 Apr 2020 22:29:44 +0000 (UTC)
Received: from [10.110.111.40] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C548BC433F2;
        Tue,  7 Apr 2020 22:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C548BC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3 0/4] Add SS/HS-USB changes for Qualcomm SM8150 chipset
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org
References: <1586298209-4589-1-git-send-email-wcheng@codeaurora.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <a1328e98-fb97-3fff-913e-45ad85f44532@codeaurora.org>
Date:   Tue, 7 Apr 2020 15:29:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586298209-4589-1-git-send-email-wcheng@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the confusion, please disregard these patches.  I sent the
incorrect patch series update.

Thanks
Wesley

On 4/7/2020 3:23 PM, Wesley Cheng wrote:
> This series adds support for the Synopsis 7nm HSPHY USB driver being
> used in QCOM chipsets.  The HSPHY register map differs compared to 
> other PHY revisions.  In addition, modifications and updates are done
> to the QMP driver to add new registers/offsets, and to update the
> initialization sequence for enabling the SSUSB path on SM8150.
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
> Wesley Cheng (3):
>   dt-bindings: phy: Add binding for qcom,usb-hs-7nm
>   phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
>   phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
> 
>  .../devicetree/bindings/phy/qcom,usb-hs-7nm.yaml   |  76 ++++++
>  drivers/phy/qualcomm/Kconfig                       |  10 +
>  drivers/phy/qualcomm/Makefile                      |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 157 +++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                | 198 +++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-snps-7nm.c           | 294 +++++++++++++++++++++
>  6 files changed, 734 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-7nm.c
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
