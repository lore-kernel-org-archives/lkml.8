Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC872072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mZQpOwVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgELIyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:54:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21280 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgELIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:54:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589273659; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4myBv0Eb7CjTFQWgbEm87difECtLoTIZZdLheI+zz60=;
 b=mZQpOwVEddvl1YivjyKSt22Kv/Ng93zZc83lva6gZ0EGVt7mE47xK2EInyLEIlsKOHMBrlNF
 S379gWa0dx5xhV5b2Sx7+Yx7vKi2amYE02gLdZ8qminkkM+orcFF+o8Ore3Zl+eG+5NclfGe
 /Yad0JOWONeb2aMV7GUkRZWXQ8k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba6429.7f5a33950fb8-smtp-out-n05;
 Tue, 12 May 2020 08:54:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5FC6C44788; Tue, 12 May 2020 08:54:00 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B1F5C433CB;
        Tue, 12 May 2020 08:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B1F5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] b43: remove dead function b43_rssinoise_postprocess()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200507110741.37757-1-yanaijie@huawei.com>
References: <20200507110741.37757-1-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <davem@davemloft.net>, <tglx@linutronix.de>,
        <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jason Yan <yanaijie@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200512085400.B5FC6C44788@smtp.codeaurora.org>
Date:   Tue, 12 May 2020 08:54:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> This function is dead for more than 10 years. Remove it.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

f2cd32a443da rndis_wlan: Remove logically dead code

-- 
https://patchwork.kernel.org/patch/11533111/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
