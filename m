Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D8DC35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8420708
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mqNu5DZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgAZOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:25:18 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:52915 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgAZOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:25:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580048717; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DzhIXU+qv1ciGaNGzExa6n/8OGLjYzAcP3i90CedJAI=; b=mqNu5DZmTL6SqD2FTsiLaH0m0FMeYwLlCK28ngAmB+ylzKsgEBZCNGVpQJpcRzj+fJgw0KWk
 Qx2zfLZCWElxcuVyzxBEaGVB0az/rwSYdg+vUwkEGIOFnl4mJay8seqcborbUswpTjvcVd0w
 koeL11dVq3QPH+3ZjlSYX11wYo8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2da147.7f33070196c0-smtp-out-n03;
 Sun, 26 Jan 2020 14:25:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB1CAC4479F; Sun, 26 Jan 2020 14:25:11 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B35A3C43383;
        Sun, 26 Jan 2020 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B35A3C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Justin Capella <justincapella@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, netdev@vger.kernel.org,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Use device_get_match_data() to simplify code
References: <20200123232944.39247-1-swboyd@chromium.org>
        <CAMrEMU-e55q7uvd220+1kuYJ4Xa-4ckz5CvYezCj2ahn_K8t9w@mail.gmail.com>
Date:   Sun, 26 Jan 2020 16:25:07 +0200
In-Reply-To: <CAMrEMU-e55q7uvd220+1kuYJ4Xa-4ckz5CvYezCj2ahn_K8t9w@mail.gmail.com>
        (Justin Capella's message of "Sat, 25 Jan 2020 20:18:40 -0800")
Message-ID: <87o8uqcn24.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Capella <justincapella@gmail.com> writes:

> Maybe use dev here as well?
>
>>                 dev_err(&pdev->dev, "failed to find matching device tree id\n");

I changed that. And also fixed a checkpatch warning:

drivers/net/wireless/ath/ath10k/snoc.c:1483: Please don't use multiple blank lines

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
