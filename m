Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE79C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D3F20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pxO43HKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQMzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:55:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24217 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgCQMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:55:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584449721; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GjbOAVBonUachoEYynZJyqOqo/SneyKPARmLiqRE1nc=;
 b=pxO43HKXNXWAGyBzuNtEGJytk+EVXi6DQoEgIBLCdhVVsRma7DUtc/GqxhnFJrbl1j6yOdcb
 I9T/NW8BWnnDADtZRK8X56Wl+sU+NDR/hToqVPkbWbgZq4opG83+wBu4SH2D8Lc1BMZOLDm3
 pqLMyJY1FzOJeTzQLFmreqf/0Oo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70c8a9.7f870ab8da78-smtp-out-n03;
 Tue, 17 Mar 2020 12:55:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 507C8C43637; Tue, 17 Mar 2020 12:55:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 604C1C433BA;
        Tue, 17 Mar 2020 12:55:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Mar 2020 18:25:03 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Michael_Turquette_=C2=A0?= <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        linux-soc-owner@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add modem Clock controller (MSS CC) driver for
 SC7180
In-Reply-To: <1584211798-10332-1-git-send-email-tdas@codeaurora.org>
References: <1584211798-10332-1-git-send-email-tdas@codeaurora.org>
Message-ID: <e8bed15b87dda3698e37bfcd09dc3c31@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-15 00:19, Taniya Das wrote:
> [v6]
>  * Combine the Documentation YAML schema and clock IDs for GCC MSS and
>    MSS clocks.
>  * Remove a unnecessary header file inclusion, define the max_registers 
> for
>    regmap and also update the fw_name to remove _clk suffix.
>  * Update the copyright year.

Tested-by: Sibi Sankar <sibis@codeaurora.org>

> 
> [v5]
>  * Update the clock ID for GCC_MSS_NAV_AXIS_CLK to GCC_MSS_NAV_AXI_CLK
> 
> [v4]
>  * Split the GCC MSS clocks and Modem clock driver.
>  * Update mss_regmap_config to const.
>  * Rename the Documentation binding as per the latest convention.
>  * Minor comments of clock-names/clocks properties updated.
> 
> [v3]
>   * Add clocks/clock-names required for the MSS clock controller.
>   * Add pm_ops to enable/disable the required dependent clock.
>   * Add parent_data for the MSS clocks.
>   * Update the GCC MSS clocks from _CBCR to _CLK.
> 
> [v2]
>   * Update the license for the documentation and fix minor comments in 
> the
>     YAML bindings.
> 
> [v1]
>   * Add driver support for Modem clock controller for SC7180 and also
>     update device tree bindings for the various clocks supported in the
>     clock controller.
> 
> Taniya Das (3):
>   dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
>   clk: qcom: gcc: Add support for modem clocks in GCC
>   clk: qcom: Add modem clock controller driver for SC7180
> 
>  .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |  62 +++++++++
>  drivers/clk/qcom/Kconfig                           |   9 ++
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/gcc-sc7180.c                      |  72 ++++++++++-
>  drivers/clk/qcom/mss-sc7180.c                      | 143 
> +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sc7180.h        |   7 +-
>  include/dt-bindings/clock/qcom,mss-sc7180.h        |  12 ++
>  7 files changed, 304 insertions(+), 2 deletions(-)
>  create mode 100644 
> Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
>  create mode 100644 drivers/clk/qcom/mss-sc7180.c
>  create mode 100644 include/dt-bindings/clock/qcom,mss-sc7180.h
> 
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a 
> member
> of the Code Aurora Forum, hosted by the  Linux Foundation.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
