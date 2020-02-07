Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E50C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F4420726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UvqNzFIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGGKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:10:54 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:53758 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgBGGKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:10:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581055853; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9dWo6uK9jKsDwewb71Iojt0lLBywexIt8UvMHWOd8gc=;
 b=UvqNzFIcs5mkEdBK61didkE3NJ3uQ1KnzyvHSp8bIDfJDNduiAkR0CLid6XP2XA+QbiGAIJK
 ENCVbNuEyrqoRJ8yrY6B/LrcPjz/rvYbXYPKb/tnQIwZ5sHsNtmEIL9BLupq3W9SMKkqemra
 VI9dfhQFjdSfFzyhgcyJp1AmSLQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3cff6a.7f53327aeb58-smtp-out-n03;
 Fri, 07 Feb 2020 06:10:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24B6BC4479C; Fri,  7 Feb 2020 06:10:50 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6F35C43383;
        Fri,  7 Feb 2020 06:10:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Feb 2020 11:40:49 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree-owner@vger.kernel.org
Subject: Re: [PATCHv2 2/2] dt-bindings: watchdog: Add compatible for QCS404,
 SC7180, SDM845, SM8150
In-Reply-To: <20200206183808.GA5019@bogus>
References: <cover.1580570160.git.saiprakash.ranjan@codeaurora.org>
 <ff71077aa09c489b2b072c6f5605dccb96f60051.1580570160.git.saiprakash.ranjan@codeaurora.org>
 <20200206183808.GA5019@bogus>
Message-ID: <f26464226f74dffe2db0583b9482a489@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2020-02-07 00:08, Rob Herring wrote:
> On Sat, Feb 01, 2020 at 08:59:49PM +0530, Sai Prakash Ranjan wrote:
>> Add missing compatible for watchdog timer on QCS404,
>> SC7180, SDM845 and SM8150 SoCs.
> 
> That's not what the commit does. You are changing what's valid.
> 
> One string was valid, now 2 are required.
> 

Does this look good?

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml 
b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 46d6aad5786a..3378244b67cd 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -14,19 +14,22 @@ allOf:

  properties:
    compatible:
-    items:
+    oneOf:
        - enum:
            - qcom,apss-wdt-qcs404
            - qcom,apss-wdt-sc7180
            - qcom,apss-wdt-sdm845
            - qcom,apss-wdt-sm8150
-          - qcom,kpss-timer
-          - qcom,kpss-wdt
            - qcom,kpss-wdt-apq8064
            - qcom,kpss-wdt-ipq4019
            - qcom,kpss-wdt-ipq8064
            - qcom,kpss-wdt-msm8960
+          - qcom,kpss-timer
+          - qcom,kpss-wdt
            - qcom,scss-timer
+      - const: qcom,kpss-timer
+      - const: qcom,kpss-wdt
+      - const: qcom,scss-timer

    reg:
      maxItems: 1

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
