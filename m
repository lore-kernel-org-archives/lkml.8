Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E072054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="f3o5WdOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgH0O6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:58:45 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32637 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbgH0MOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:14:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598530492; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xKkJldCpFuFFwvk5Ekpm5a9GeD8MRoy70tGm5lWY6Xk=; b=f3o5WdOEfYGvDREvSuMQBuWgQQWuPWyY3EFEeFHGo9LU7mzYRylVB/CQnFqemUXhaINYgwYz
 E4jc0/yMOvLCx9JRMXWFQJY7xEJLmTrlIaF3aMlIegGWpOgndDAICzz7Q1mSyfCJjaVi15YE
 Uu0UxBFtzliG9S3t06ya+VPkr9w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f47a11dc9ede11f5eb55929 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 12:03:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2039EC43391; Thu, 27 Aug 2020 12:03:41 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E98DC433C6;
        Thu, 27 Aug 2020 12:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E98DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/30] Set 3: Rid W=1 warnings in Wireless
References: <20200826093401.1458456-1-lee.jones@linaro.org>
Date:   Thu, 27 Aug 2020 15:03:37 +0300
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org> (Lee Jones's
        message of "Wed, 26 Aug 2020 10:33:31 +0100")
Message-ID: <87y2m09tye.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> There are quite a few W=1 warnings in the Wireless.  My plan
> is to work through all of them over the next few weeks.
> Hopefully it won't be too long before drivers/net/wireless
> builds clean with W=1 enabled.

How much patches are there going to be? I was first positive about the
idea but now I am really starting to wonder if this is worth the effort,
these patches are spamming my patchwork significantly and taking too
much time. At least please hold of on any new patches for at least a
week so I can catch up with all patches I have.

And like I said already before, follow the title style we use so that I
don't need to edit every patch myself:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
