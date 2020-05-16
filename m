Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F38C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0232A206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 17:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qJiOtBgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEPRiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 13:38:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22465 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgEPRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 13:38:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589650689; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: From: References: Cc: To: Subject:
 Sender; bh=NYMrMgeMq1+R7gwZnu89mZGOyvi5jlE2jtoptn1SMUM=; b=qJiOtBgsAnH423AcYfBef7TCwZTnKBrzkKA5F9Pv2FMs3zd7Yu28VMa8BqHZcSJFqEPtmRT/
 F73qYMgmdzsgHCcwdo0Q5qA+J+cN0k6waEJmXd28REB0WDEd8xXxvroqf0kJie2gCK8jiw09
 obSXhcYg1FqMWmPNOGpANGCipnA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec024fc.7fec3a164378-smtp-out-n01;
 Sat, 16 May 2020 17:38:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1C82C432C2; Sat, 16 May 2020 17:38:03 +0000 (UTC)
Received: from [10.86.13.83] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEFB4C433D2;
        Sat, 16 May 2020 17:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEFB4C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
Subject: Re: [PATCH v2 1/7] Documentation: device-tree: sound: Update
 lpass-cpu driver binding
To:     Mark Brown <broonie@kernel.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=ef=bf=bd=3e_=3c1589474298-29437-1-git-send-email-ajitp?=
 =?UTF-8?Q?=40codeaurora=2eorg=3e_=3c1589474298-29437-2-git-send-email-ajitp?=
 =?UTF-8?Q?=40codeaurora=2eorg=3e_=3c20200514164429=2eGJ5127=40sirena=2eorg?=
 =?UTF-8?Q?=2euk=3e?=
From:   Ajit Pandey <ajitp@codeaurora.org>
Message-ID: <c4268ee7-fa5d-74d3-52bf-2f6d3635758f@codeaurora.org>
Date:   Sat, 16 May 2020 23:07:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2020 10:14 PM, Mark Brown wrote:
> On Thu, May 14, 2020 at 10:08:12PM +0530, Ajit Pandey wrote:
>> Done the required cleanups to update lpass-cpu binding with newer
>> yaml formats.
> Please do YAML conversions as the last thing in any patch series, there
> is quite a big backlog of reviews of YAML conversions so they can slow
> down the code development.  It's good to do them, just try to make sure
> other patches don't depend on them.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Ok.. we'll do the yaml conversion as a separate patch chain so that it 
won't block

merging of this feature in ASoC core.
