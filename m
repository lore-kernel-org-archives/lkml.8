Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6A020719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QyrqQtsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCZJWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:22:36 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33178 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgCZJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:22:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585214555; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+OwM0HqMP4AbODh5vasra9NtQ7vqt8/GPNduIzrrTlg=; b=QyrqQtsp+/d8E6P3bbRYf8N/LGf4YSXdWhPS0hYMDxvp0lp8WppeUZetao1AMrlGXg/VRxIj
 LHAMkL22FWdZ4heiFxPeJlHPEomyr+IoOKzPLrB4f1LRPnTy033C96conDXwwuLhsUGj+FoQ
 FFaBQEP2bfE5fuiz15ToFJTCd6E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c7458.7fa94813c148-smtp-out-n02;
 Thu, 26 Mar 2020 09:22:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A213C44788; Thu, 26 Mar 2020 09:22:32 +0000 (UTC)
Received: from [192.168.0.103] (unknown [106.51.108.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61490C433BA;
        Thu, 26 Mar 2020 09:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61490C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC v6 0/2] Add SDHC interconnect bandwidth scaling
To:     Pradeep P V K <ppvk@codeaurora.org>, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
References: <1584973502-14775-1-git-send-email-ppvk@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c17d8842-0e1d-0014-b909-3114952b350b@codeaurora.org>
Date:   Thu, 26 Mar 2020 14:52:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584973502-14775-1-git-send-email-ppvk@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Viresh and Saravana,

On 3/23/2020 7:55 PM, Pradeep P V K wrote:
> Add interconnect bandwidths for SDHC driver using OPP framework that
> is required by SDHC driver based on the clock frequency and bus width
> of the card. Otherwise, the system clocks may run at minimum clock
> speed and thus affecting the performance.
> 
> This change is based on
> [RFC] mmc: host: sdhci-msm: Use the interconnect API
> (https://lkml.org/lkml/2018/10/11/499) and
> 
> [PATCH v6] Introduce Bandwidth OPPs for interconnects
> (https://lkml.org/lkml/2019/12/6/740)

Pradeep, since your series seems to depend on the above proposed bw bindings,
can you post the DT changes for the platform that you are testing these
patches on?

Please note that the above series is currently deadlocked [1][2] with no clear path
forward for now, so looking at how you plan to use this might throw some light onto
the requirements

[1] https://lkml.org/lkml/2020/1/14/511
[2] https://lkml.org/lkml/2020/3/20/106

> 
> Pradeep P V K (2):
>    mmc: sdhci-msm: Add interconnect bus bandwidth scaling support
>    dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings
> 
>   .../devicetree/bindings/mmc/sdhci-msm.txt          |  18 ++
>   drivers/mmc/host/sdhci-msm.c                       | 240 ++++++++++++++++++++-
>   2 files changed, 254 insertions(+), 4 deletions(-)
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
