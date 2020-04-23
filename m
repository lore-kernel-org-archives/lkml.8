Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C8C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F37E20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IHyA1D6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgDWQHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:07:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40091 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbgDWQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:07:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587658034; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qbSJxZQNaWxw8mAgGamaaFomuWjyilvDfwW/TLq0WJQ=;
 b=IHyA1D6yl+BB7L449y6vqFB5SBWInfb4gN7A6HqItPNp2biPIamPm2VyPWLXVOww1NLgH5Uz
 GnUzmY1pfwccIqV83xulCAUvJskbGinGHvL+LuhEb/IlAjzICwXtyEEOAl6w3LpvKuDvPw8W
 5zX1IEaQkEC8rcE2okUiFuXlVLc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea1bd2a.7f736ae07c38-smtp-out-n01;
 Thu, 23 Apr 2020 16:07:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E24FDC433D2; Thu, 23 Apr 2020 16:07:04 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCF2BC433D2;
        Thu, 23 Apr 2020 16:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCF2BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] rtw88: Use udelay instead of usleep in atomic context
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200423073007.3566-1-kai.heng.feng@canonical.com>
References: <20200423073007.3566-1-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     yhchuang@realtek.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER
        (rtw88)), netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423160704.E24FDC433D2@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 16:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> It's incorrect to use usleep in atomic context.
> 
> Switch to a macro which uses udelay instead of usleep to prevent the issue.
> 
> Fixes: 6343a6d4b213 ("rtw88: Add delay on polling h2c command status bit")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

For patch 1 please also CC linux-wireless, otherwise patchwork cannot see it.

-- 
https://patchwork.kernel.org/patch/11505147/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
