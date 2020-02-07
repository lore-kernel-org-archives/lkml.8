Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1592C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81112082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MzUU5Lot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBGHYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:24:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:52678 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgBGHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:24:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581060281; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yvIzAXlCUWtw8UVrvAHXcMI4NqUI2Q/iSLZWcJmbwuM=;
 b=MzUU5LotCNV+jQgt0LqQukqtkCd15fwaFD/u44KchhCElhYAcenw9aL/ghA7yTfHORFnQGG4
 izKLKyfhFf+okzxO+M0RdLULA2oYsZoyD6W0hOseDakNKvYph67GPNXmI4eKUJRoTr09mWKz
 bAj6GaJoTvlyWSqLJ4mQTBKZuJY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3d10ac.7f2e68c81340-smtp-out-n03;
 Fri, 07 Feb 2020 07:24:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04C79C4479C; Fri,  7 Feb 2020 07:24:27 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04154C433CB;
        Fri,  7 Feb 2020 07:24:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Feb 2020 12:54:25 +0530
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
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add modem Clock controller (MSS CC) driver for
 SC7180
In-Reply-To: <1580357923-19783-1-git-send-email-tdas@codeaurora.org>
References: <1580357923-19783-1-git-send-email-tdas@codeaurora.org>
Message-ID: <ba110478a0dba14e12665d7060712f4c@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-30 09:48, Taniya Das wrote:
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
>   dt-bindings: clock: Introduce QCOM Modem clock bindings
>   clk: qcom: Add modem clock controller driver for SC7180

Tested-by: Sibi Sankar <sibis@codeaurora.org>

> 
>  .../devicetree/bindings/clock/qcom,mss.yaml        |  58 +++++++++
>  drivers/clk/qcom/Kconfig                           |   9 ++
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/gcc-sc7180.c                      |  70 ++++++++++
>  drivers/clk/qcom/mss-sc7180.c                      | 143 
> +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sc7180.h        |   5 +
>  include/dt-bindings/clock/qcom,mss-sc7180.h        |  12 ++
>  7 files changed, 298 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/clock/qcom,mss.yaml
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
