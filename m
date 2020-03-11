Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B220920736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iRM9XHzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgCKQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:52:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21907 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729584AbgCKQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:52:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583945542; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=13ER7EC6tNsem5IUYhvbU5i7rUU+ucV6ONkTZXwQszY=;
 b=iRM9XHzcles9LTIFTsFfJS/+g1+Tq5lR4PJ9QcOJ3aOQWVYAy25kIgvwFt0KtmTB8D85Lk1G
 ruCMttMnuATv09bT1me8typdAa1+Kado7LciOk/u/agLvZdZ5MCU1Sa1uVfu+9000Rtyl94p
 r1LjnyQuBQ6KnuNurwDswqIyTsI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69173f.7fa8321f8340-smtp-out-n02;
 Wed, 11 Mar 2020 16:52:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AE34C433CB; Wed, 11 Mar 2020 16:52:15 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0E1FC433CB;
        Wed, 11 Mar 2020 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0E1FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: Add proper dependency for ATH5K_AHB
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200224182447.4054-1-krzk@kernel.org>
References: <20200224182447.4054-1-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311165215.4AE34C433CB@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:52:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The CONFIG_ATH5K_AHB could be enabled on ATH25 system without enabling
> ATH5K driver itself.  This does not make sense because CONFIG_ATH5K_AHB
> controls object build within drivers/net/wireless/ath/ath5k/ so enabling
> it without CONFIG_ATH5K brings nothing.
> 
> Add proper dependency to CONFIG_ATH5K_AHB.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c98cdaef931c ath5k: Add proper dependency for ATH5K_AHB

-- 
https://patchwork.kernel.org/patch/11401313/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
