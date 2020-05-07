Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3320C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1AF20659
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UXfFLQuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGQGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:06:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31041 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgEGQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:06:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588867608; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: Cc: To: Sender;
 bh=jwMeAfchhcLCYgXDQ+3RZuZwLazuFlu1qTBcfgi+Ub4=; b=UXfFLQuE6PIBT/8UMyM8JrOLygqVvPs1EXxVb3kkkVpZOaJR/ExUKKh1aQy96F4Kbqm96S39
 nUCXJLnO0ydUWB25fGfGUDcc6WDy8HQ+PXKLuPGxWLBx9uO2wBUo16t1Ko8S1snc1uasfVEV
 VBm5lX+8M4NNqAEMFgi681AoxHY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb43201.7f45f5cc8260-smtp-out-n04;
 Thu, 07 May 2020 16:06:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B8F1C433D2; Thu,  7 May 2020 16:06:24 +0000 (UTC)
Received: from [192.168.0.103] (unknown [49.204.184.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51EE5C433BA;
        Thu,  7 May 2020 16:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51EE5C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
To:     julien.thierry.kdev@gmail.com, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: Query regarding pseudo nmi support on GIC V3 and request_nmi()
Message-ID: <2a0d5719-b2c7-1287-e0b5-2dd8b1072e49@codeaurora.org>
Date:   Thu, 7 May 2020 21:36:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have one query regarding pseudo NMI support on GIC v3; from what I 
could understand, GIC v3 supports pseudo NMI setup for SPIs and PPIs.
However the request_nmi() in irq framework requires NMI to be per cpu
interrupt source (it checks for IRQF_PERCPU). Can you please help
understand this part, how SPIs can be configured as NMIs, if there is
a per cpu interrupt source restriction?



Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
