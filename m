Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F190E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="h7KARshv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406238AbgFYTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:22:43 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13473 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403781AbgFYTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:22:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593112962; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=O0YcN5AuA42NSQG3m/WRAh4pR8AXXh5aSL0oaRcNrWk=;
 b=h7KARshv5HK9ZjSShRQDEgYudzpnkZe8h0SpjFzYeiYvMwECNQa5o5yCXe4j4+XKnooADTBU
 8su3cBU4cNikzKEHS079Y3RnV66EVQs7f421rBriAEyQhGummqNqDtvmOIuNsISKGwbHVisN
 ahMYekYaj/vyyW6oKIu8H9nnlMw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ef4f979567385e8e729638d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Jun 2020 19:22:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF52AC433CA; Thu, 25 Jun 2020 19:22:32 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0695FC433C8;
        Thu, 25 Jun 2020 19:22:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jun 2020 00:52:31 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCHv3 0/2] Convert QCOM watchdog timer bindings to YAML
In-Reply-To: <20200625160042.GC149301@roeck-us.net>
References: <cover.1581459151.git.saiprakash.ranjan@codeaurora.org>
 <c2b8fabcf82b27c7334482bd53ebba62@codeaurora.org>
 <20200621073320.GI128451@builder.lan>
 <ce4c2b44cb15af12b04c09f1786a6c1a@codeaurora.org>
 <20200625160042.GC149301@roeck-us.net>
Message-ID: <3e3cf81452e33c9385900177d0630a11@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 21:30, Guenter Roeck wrote:
> On Mon, Jun 22, 2020 at 11:50:52AM +0530, Sai Prakash Ranjan wrote:
>> On 2020-06-21 13:03, Bjorn Andersson wrote:
>> > On Tue 16 Jun 23:56 PDT 2020, Sai Prakash Ranjan wrote:
>> >
>> > > Hi Bjorn,
>> > >
>> >
>> > Hi Sai,
>> >
>> > > On 2020-02-12 03:54, Sai Prakash Ranjan wrote:
>> > > > This series converts QCOM watchdog timer bindings to YAML. Also
>> > > > it adds the missing SoC-specific compatible for QCS404, SC7180,
>> > > > SDM845 and SM8150 SoCs.
>> > > >
>> > > > v1:
>> > > > https://lore.kernel.org/lkml/cover.1576211720.git.saiprakash.ranjan@codeaurora.org/
>> > > > v2:
>> > > > https://lore.kernel.org/lkml/cover.1580570160.git.saiprakash.ranjan@codeaurora.org/
>> > > >
>> > > > Changes since v2:
>> > > >  * Add missing compatibles to enum.
>> > > >
>> > > > Changes since v1:
>> > > >  As per Rob's suggestion:
>> > > >   * Replaced oneOf+const with enum.
>> > > >   * Removed timeout-sec and included watchdog.yaml.
>> > > >   * Removed repeated use of const:qcom,kpss-wdt and made use of enum.
>> > > >
>> > > > Sai Prakash Ranjan (2):
>> > > >   dt-bindings: watchdog: Convert QCOM watchdog timer bindings to YAML
>> > > >   dt-bindings: watchdog: Add compatible for QCS404, SC7180, SDM845,
>> > > >     SM8150
>> > > >
>> > > >  .../devicetree/bindings/watchdog/qcom-wdt.txt | 28 -----------
>> > > >  .../bindings/watchdog/qcom-wdt.yaml           | 48 +++++++++++++++++++
>> > > >  2 files changed, 48 insertions(+), 28 deletions(-)
>> > > >  delete mode 100644
>> > > > Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>> > > >  create mode 100644
>> > > > Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> > >
>> > >
>> > > Gentle ping!
>> > >
>> >
>> > This should better go through the watchdog tree, so I believe Guenter
>> > would be the one to pick this up.
>> >
>> 
>> Ah right, then a gentle ping for Guenter.
>> 
> I don't think the watchdog mailing list has been copied on this series,
> meaning I don't have a copy that I could apply if I wanted to.

I kept you in CC for all the revisions but missed adding watchdog list.
Will resend with the appropriate lists added.

> I also see
> no evidence for a Reviewed-by: tag from Rob or any other DT maintainer.
> 

Not sure why you think I would add reviewed-by tag from Rob without him 
giving one.
But here's the evidence - 
https://lore.kernel.org/lkml/cover.1580570160.git.saiprakash.ranjan@codeaurora.org/
This link is also given v3 cover letter.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
