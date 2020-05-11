Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A42C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F158206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ncTIibIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgEKTcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:32:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35890 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731041AbgEKTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:32:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589225529; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sAZDaw+WM1tRH6zdEndZjZXWJLv0r3DaQahoiRA1aOI=; b=ncTIibIny9D0pnj/JoyZKs2qj6bUj86KvOxn+Zmd0N295gm99pGh2ad3/Hx+JRWOzIEQy3D/
 rvURtiDwogASpVdFYG+P0lLspuO5MZr0Br1wWunjlryI6Fg/OPFozdzLUuXnV2K4PH+xXVcj
 dLEOK9r7s4eLfn1YKEkM0myf32A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9a825.7ffa94fa3848-smtp-out-n04;
 Mon, 11 May 2020 19:31:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D98E7C432C2; Mon, 11 May 2020 19:31:48 +0000 (UTC)
Received: from [192.168.1.179] (cpe-76-167-231-33.san.res.rr.com [76.167.231.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34720C433F2;
        Mon, 11 May 2020 19:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34720C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
Subject: Re: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
To:     Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Murali Nalajala <mnalajal@codeaurora.org>
References: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
 <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
From:   Elliot Berman <eberman@codeaurora.org>
Message-ID: <9b6694ac-acb3-6bc4-49c9-39ad1c64d6e1@codeaurora.org>
Date:   Mon, 11 May 2020 12:31:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2020 11:54 AM, Joe Perches wrote> Change-Id: probably isn't necessary.

Thanks for the catch

> 
> Is there a separate mechanism possible to avoid bloating the
> otherwise unused content?

This struct is being used in lib/dynamic_debug.c but compiler doesn't know
about this usage when optimizing the struct/branch away.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
