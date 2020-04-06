Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC1C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744A22277
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bL2vMupb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgDFQUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:20:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49309 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729017AbgDFQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:20:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586190007; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=q7MmcoHC+B5JqjEAn7yzTdc9VcYGuDPtoB3Hpi1mfCo=;
 b=bL2vMupbS0FO/OP/sL0JS+Dbce1m6WEaxFyzbrcdCMbkEhHEoKL2/DfkyKNeOjuszB+AfrQp
 sC3U8GJxv9oTAWc5X6lP5UbxknobcDVL//YqyzdgJWTwAfpAS6fCK7tZ49Ek2dVIfDsZbqfj
 nL1fiE0cGJz5gDZyua1wEIXVy+M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b5695.7f58e71649d0-smtp-out-n03;
 Mon, 06 Apr 2020 16:19:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72BDCC433F2; Mon,  6 Apr 2020 16:19:33 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12A15C433D2;
        Mon,  6 Apr 2020 16:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12A15C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] ath11k: fix error message to correctly report the
 command that failed
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200327192639.363354-1-colin.king@canonical.com>
References: <20200327192639.363354-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        John Crispin <john@phrozen.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406161933.72BDCC433F2@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:19:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Currently the error message refers to the command WMI_TWT_DIeABLE_CMDID
> which looks like a cut-n-paste mangled typo. Fix the message to match
> the command WMI_BSS_COLOR_CHANGE_ENABLE_CMDID that failed.
> 
> Fixes: 5a032c8d1953 ("ath11k: add WMI calls required for handling BSS color")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9a8074e3bcd7 ath11k: fix error message to correctly report the command that failed

-- 
https://patchwork.kernel.org/patch/11462997/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
