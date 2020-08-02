Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C21C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76EF207BB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CIrs6chB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHBO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:57:07 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:48895 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgHBO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:57:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596380224; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=FGzGKZ5VVbzebKb6/1zAkWlel4gAZKDM5dA3vVO4/jk=;
 b=CIrs6chBk0w81OtqhhkQEQJTzX3wiv6nRjeWV2zBw5ll5wC+lYQhlBfHx6zin54o0ANuWDgh
 u14BAM7aylX7+EHR0tiD4pY2aa9nAZehVEE60BJHr4ZzG/OCrj8M8EwDi18ljp5RwDjSmm3S
 2uneEoHnyBFZK0x5npkojk20Uk0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f26d41aba6d142d1c2cf7a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 14:56:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 353DCC433CA; Sun,  2 Aug 2020 14:56:26 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07F30C433C6;
        Sun,  2 Aug 2020 14:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07F30C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: 11n_rxreorder: Remove unnecessary cast in
 kfree()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200727020405.8476-1-vulab@iscas.ac.cn>
References: <20200727020405.8476-1-vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     amitkarwar@gmail.com, ganapathi.bhat@nxp.com,
        huxinming820@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802145626.353DCC433CA@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 14:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Wang <vulab@iscas.ac.cn> wrote:

> Remove unnecassary casts in the argument to kfree.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Patch applied to wireless-drivers-next.git, thanks.

614946480f8f mwifiex: 11n_rxreorder: Remove unnecessary cast in kfree()

-- 
https://patchwork.kernel.org/patch/11686265/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

