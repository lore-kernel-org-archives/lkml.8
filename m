Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07CE207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YXGd3zJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgFVGU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:20:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27461 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbgFVGU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:20:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592806857; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5I7VSl/4Rul7O9mJZbZ9v3pTVJhuCI7n/dCMG5x7Lq4=;
 b=YXGd3zJxMpbCdP02LgThoMPzApwIqxsF0YJGAMGkhnhTzv5VcGmExI5cy0GzpW8xdkCnlJn7
 cAenbo4ckANtm1buvH1vu3e0hBW0T1btpVM1wZePtud5RIQTTY7k1qXtQErzhm29s/z3r+9o
 rOij9BGr9ZDZoXwBTUXKz4UResU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ef04dc586de6ccd44e5cfc8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 06:20:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9EFBAC4339C; Mon, 22 Jun 2020 06:20:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DBB5C433C6;
        Mon, 22 Jun 2020 06:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Jun 2020 11:50:52 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 0/2] Convert QCOM watchdog timer bindings to YAML
In-Reply-To: <20200621073320.GI128451@builder.lan>
References: <cover.1581459151.git.saiprakash.ranjan@codeaurora.org>
 <c2b8fabcf82b27c7334482bd53ebba62@codeaurora.org>
 <20200621073320.GI128451@builder.lan>
Message-ID: <ce4c2b44cb15af12b04c09f1786a6c1a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-21 13:03, Bjorn Andersson wrote:
> On Tue 16 Jun 23:56 PDT 2020, Sai Prakash Ranjan wrote:
> 
>> Hi Bjorn,
>> 
> 
> Hi Sai,
> 
>> On 2020-02-12 03:54, Sai Prakash Ranjan wrote:
>> > This series converts QCOM watchdog timer bindings to YAML. Also
>> > it adds the missing SoC-specific compatible for QCS404, SC7180,
>> > SDM845 and SM8150 SoCs.
>> >
>> > v1:
>> > https://lore.kernel.org/lkml/cover.1576211720.git.saiprakash.ranjan@codeaurora.org/
>> > v2:
>> > https://lore.kernel.org/lkml/cover.1580570160.git.saiprakash.ranjan@codeaurora.org/
>> >
>> > Changes since v2:
>> >  * Add missing compatibles to enum.
>> >
>> > Changes since v1:
>> >  As per Rob's suggestion:
>> >   * Replaced oneOf+const with enum.
>> >   * Removed timeout-sec and included watchdog.yaml.
>> >   * Removed repeated use of const:qcom,kpss-wdt and made use of enum.
>> >
>> > Sai Prakash Ranjan (2):
>> >   dt-bindings: watchdog: Convert QCOM watchdog timer bindings to YAML
>> >   dt-bindings: watchdog: Add compatible for QCS404, SC7180, SDM845,
>> >     SM8150
>> >
>> >  .../devicetree/bindings/watchdog/qcom-wdt.txt | 28 -----------
>> >  .../bindings/watchdog/qcom-wdt.yaml           | 48 +++++++++++++++++++
>> >  2 files changed, 48 insertions(+), 28 deletions(-)
>> >  delete mode 100644
>> > Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>> >  create mode 100644
>> > Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> 
>> 
>> Gentle ping!
>> 
> 
> This should better go through the watchdog tree, so I believe Guenter
> would be the one to pick this up.
> 

Ah right, then a gentle ping for Guenter.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
