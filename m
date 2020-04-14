Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF8AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3012076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Onz2Ohxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407013AbgDNPFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:05:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35673 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406969AbgDNPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:05:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876699; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=it0gpSRDcAsaDyVlnGJ2QcKtZyPaaAyuAv6Y770rulQ=;
 b=Onz2Ohxnfew8K/8de/YwaAdhxp3azxjvurTe+Qcy5/Mvi4iw+7x9L6iaGOGhD0i4DLO0/b5N
 aPeO2gMRrkZBrODm6LYeeRRCMwJGeNbSbrNhaFozbjuCbIN3jtKPuPBMg9UpTBc1AtvrVhFA
 hkn/HHhho8WyLQ2nUWBfXb/6jh8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d10f.7f78045c7730-smtp-out-n01;
 Tue, 14 Apr 2020 15:04:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEC05C433BA; Tue, 14 Apr 2020 15:04:46 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F946C4478F;
        Tue, 14 Apr 2020 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F946C4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rsi: fix a typo "throld" -> "threshold"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585837078-6149-1-git-send-email-hqjagain@gmail.com>
References: <1585837078-6149-1-git-send-email-hqjagain@gmail.com>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     amitkarwar@gmail.com, siva8118@gmail.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150446.DEC05C433BA@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:04:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiujun Huang <hqjagain@gmail.com> wrote:

> There is a typo in debug message. Fix it.
> s/throld/threshold
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

f9f46bca59d1 rsi: fix a typo "throld" -> "threshold"

-- 
https://patchwork.kernel.org/patch/11470829/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
