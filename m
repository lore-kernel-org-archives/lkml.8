Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1459C35250
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922D20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fWABcCa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBCHUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 02:20:17 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:16883 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbgBCHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 02:20:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580714416; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qSVlR3dO7ZHERfYsHnBxuGBep5fGowjl98WEItqmRLk=;
 b=fWABcCa+/rFTAjmr7UCO6imMz2KpjicZ0cfpgUzbv63ZcRTyVSkHJO4neUVBk4ughwmfm9mi
 dL6Z4Y8RemrAIGrwlmKddwh2OBDjvgzvmuMJS9Z5xOp8poGjjTw789ngT4B6u/pimqYQkwMn
 DeXw7vi1TCk9KgTj0iYBoR+jJ30=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e37c9a8.7fc58852f650-smtp-out-n03;
 Mon, 03 Feb 2020 07:20:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9ADBC433CB; Mon,  3 Feb 2020 07:20:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 468EFC433CB;
        Mon,  3 Feb 2020 07:20:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Feb 2020 12:50:06 +0530
From:   ppvk@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     adrian.hunter@intel.com, georgi.djakov@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org, vbadigan@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, sboyd@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [RFC-v2 0/2] Add Support for SDHC bus bandwidth voting
In-Reply-To: <20200130213812.GK71044@google.com>
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
 <20200130213812.GK71044@google.com>
Message-ID: <12151f0bc2a44a43cd9bd9509e0320eb@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Will send my next series by end of this week.


Thanks and Regards,
Pradeep


On 2020-01-31 03:08, Matthias Kaehlcke wrote:
> Hi Pradeep,
> 
> what is the status of this series, do you plan to send v3 soon or
> is it abandonded?
> 
> Thanks
> 
> Matthias
> 
> On Fri, Nov 08, 2019 at 07:08:37PM +0530, Pradeep P V K wrote:
>> Vote for the MSM bus bandwidth required by SDHC driver
>> based on the clock speed and bus width of the card.
>> Otherwise, the system clocks may run at minimum clock
>> speed and thus affecting the performance.
>> 
>> Adapt to the new ICB framework for bus bandwidth voting.
>> 
>> This requires the source/destination port ids.
>> Also this requires a tuple of values.
>> 
>> The tuple is for two different paths - from SDHC master
>> to BIMC slave. The other is from CPU master to SDHC slave.
>> This tuple consists of the average and peak bandwidth.
>> 
>> This change is based on Georgi Djakov [RFC]
>> (https://lkml.org/lkml/2018/10/11/499)
>> 
>> ---
>> changed since v1:
>> * Addressed all the Review comments.
>> * Minor code rebasing.
>> 
>> Pradeep P V K (2):
>>   dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported strings
>>   mmc: sdhci-msm: Add support for bus bandwidth voting
>> 
>>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  32 ++
>>  drivers/mmc/host/sdhci-msm.c                       | 366 
>> ++++++++++++++++++++-
>>  2 files changed, 395 insertions(+), 3 deletions(-)
>> 
>> --
>> 1.9.1
>> 
