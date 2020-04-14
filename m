Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E1E20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="e5D7UujL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407216AbgDNPEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:04:35 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35673 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407186AbgDNPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:04:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876669; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HmWtBOhc5ul8DMonc70f3CKeVbSyX2fnAYsC76ntthg=;
 b=e5D7UujL64AvjGXvt8GbMsZNDWqRgEU8X4g7Jj61gC5tNvn4kc5J2FSfTONDwxAH/o+RUQ0w
 AoITQ+7DQXnau+BM4OTGcCZmUjX8K65+QjzDAXhigvwarJfewevawEtz3Ww/cFUJF+F8OhJy
 d0THHotvdEGF+oX0AYfa8/PXDOI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d0e2.7f022a4c7a40-smtp-out-n03;
 Tue, 14 Apr 2020 15:04:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4440C44788; Tue, 14 Apr 2020 15:04:02 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEC7FC432C2;
        Tue, 14 Apr 2020 15:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEC7FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8723ae: fix spelling mistake "chang" ->
 "change"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585815557-20212-1-git-send-email-hqjagain@gmail.com>
References: <1585815557-20212-1-git-send-email-hqjagain@gmail.com>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     pkshih@realtek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414150402.A4440C44788@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 15:04:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiujun Huang <hqjagain@gmail.com> wrote:

> There is a spelling mistake in a trace message. Fix it.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

a24993e54b9c rtlwifi: rtl8723ae: fix spelling mistake "chang" -> "change"

-- 
https://patchwork.kernel.org/patch/11470277/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
