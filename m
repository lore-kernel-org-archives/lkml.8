Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D6206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ukJFdJ1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgEPSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:14:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53365 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgEPSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:14:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589652881; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: From: References: Cc: To: Subject:
 Sender; bh=vHhfQLbmGkqdEq+nyD31PZJUA6mXrkeSkvttzWXp73g=; b=ukJFdJ1QcSoWatv7AMI2BaC+Mm5JlxHQ+zX+3pRxdCYR5vJYAAxT3tsWwuPg4gwLYQ06d32B
 fCVF6P2ijt1y1PceFjfPr7PR8lxxGJSkxgI1TFQbse6qZxqQoC/dAVLDV9iVFzA4+J6DOQB9
 8GAlgYZBQHowkiwVcbwyn6kHBok=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec02d8d.7f386cf47d18-smtp-out-n01;
 Sat, 16 May 2020 18:14:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1C24C43637; Sat, 16 May 2020 18:14:37 +0000 (UTC)
Received: from [10.86.13.83] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5641BC433D2;
        Sat, 16 May 2020 18:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5641BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
Subject: Re: [PATCH v2 5/7] include: dt-bindings: sound: Add sc7180-lpass
 bindings header
To:     Mark Brown <broonie@kernel.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=ef=bf=bd=3e_=3c1589474298-29437-1-git-send-email-ajitp?=
 =?UTF-8?Q?=40codeaurora=2eorg=3e_=3c1589474298-29437-6-git-send-email-ajitp?=
 =?UTF-8?Q?=40codeaurora=2eorg=3e_=3c20200514164828=2eGL5127=40sirena=2eorg?=
 =?UTF-8?Q?=2euk=3e?=
From:   Ajit Pandey <ajitp@codeaurora.org>
Message-ID: <9b02abcd-23a0-8edb-674a-44358a516015@codeaurora.org>
Date:   Sat, 16 May 2020 23:44:32 +0530
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

On 5/14/2020 10:18 PM, Mark Brown wrote:
> On Thu, May 14, 2020 at 10:08:16PM +0530, Ajit Pandey wrote:
>
>> +#define MI2S_PRIMARY	0
>> +#define MI2S_SECONDARY	1
>> +
>> +#define LPASS_MCLK0	0
> These look like they could use namespacing.  Is primary/secondary
> perhaps something that could be a boolean property?

Primary/secondary is a dai id and can be from 0-4 (SC7180 soc driver 
support only 0-1 at present). Such id is mainly used in dtsi and machine 
driver to do dai id based configuration for a soc hence we placed them 
in dt headers file for now.
