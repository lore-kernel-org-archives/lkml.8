Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144AFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D080A20665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dn6J/pJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAWVll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:41:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61829 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgAWVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:41:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579815700; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=727srEIGvZaamxbPDWOuuo9Qet/wFtdCSPSdg8yjYEU=; b=dn6J/pJ15c8KV3qjTQs9KtbBcwgnDDIWNDBWTDO3KRQm6ksTjtNAJfQ8Qvc/sKOLRbGvPrDR
 gtjfPX2yLxY3VBlHfS2ex8/AzeCG6hwHEq5/ZQyiPj1V4riWLiD3DsecS4p4LQYLQxKliJih
 wa8l72cEkmWdX7DkmO/Zglc2XmM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2a1311.7f32b98906f8-smtp-out-n03;
 Thu, 23 Jan 2020 21:41:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD344C447A1; Thu, 23 Jan 2020 21:41:36 +0000 (UTC)
Received: from [192.168.0.100] (unknown [103.140.231.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akdwived)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7967C433A2;
        Thu, 23 Jan 2020 21:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7967C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akdwived@codeaurora.org
Subject: Re: [PATCH v3 2/2] Embedded USB Debugger (EUD) driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
References: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
 <1542310374-18474-3-git-send-email-pheragu@codeaurora.org>
 <20181115230618.GB26568@kroah.com>
From:   "Dwivedi, Avaneesh Kumar (avani)" <akdwived@codeaurora.org>
Message-ID: <2c599a3f-ee1c-63d9-5f88-d2a610e6d357@codeaurora.org>
Date:   Fri, 24 Jan 2020 03:11:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20181115230618.GB26568@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/2018 4:36 AM, Greg KH wrote:
> On Thu, Nov 15, 2018 at 11:32:54AM -0800, Prakruthi Deepak Heragu wrote:
>> Add support for control peripheral of EUD (Embedded USB Debugger) to
>> listen to events such as USB attach/detach, charger enable/disable, pet
>> EUD to indicate software is functional. Reusing the platform device kobj,
>> sysfs entry 'enable' is created to enable or disable EUD.
> If you add/remove/change a sysfs file, you need to also have a
> Documentation/ABI/ file update as well.  Please do that here.
>
> thanks,
>
> greg k-h

Thank you very much Greg for your time to review, Shall i go ahead 
posting next patch set v4 addressing your comments?

I was awaiting Rob's review of patch set v3 and also have posted replies 
to his comments on patch setv-v2.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
