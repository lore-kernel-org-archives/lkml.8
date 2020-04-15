Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C251206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NtCyGn98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895103AbgDOIup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:50:45 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58597 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895077AbgDOIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:50:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586940616; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=auWezVjogQxMcK0gEJGFK4CBiymKmdxiKLZPjLM9pjI=;
 b=NtCyGn98fz9kuo3DWqcwLYmUMmUeCCyENhSuBpiQAWqvcYXrr9rZRu0NCSRsfRlcCkOT0lnd
 lGSB2B3l3FwjmNtUrrdFaNvloyX2YIfT02ICZq4YsSxVDBGew7+3j4WjvJJqYzq4ZYTl3q9E
 pSGbMPcE+cDGBrZHvSBXBaqk4M0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96cabc.7f3eed1643b0-smtp-out-n01;
 Wed, 15 Apr 2020 08:50:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62E45C433F2; Wed, 15 Apr 2020 08:50:03 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AD8FC433CB;
        Wed, 15 Apr 2020 08:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AD8FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ipw2x00: make ipw_setup_deferred_work() void
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200414120251.35869-1-yanaijie@huawei.com>
References: <20200414120251.35869-1-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <stas.yakovlev@gmail.com>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415085003.62E45C433F2@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:50:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> This function actually needs no return value. So remove the unneeded
> variable 'ret' and make it void.
> 
> This also fixes the following coccicheck warning:
> 
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:10648:5-8: Unneeded
> variable: "ret". Return "0" on line 10684
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

5a652b49b41b ipw2x00: make ipw_setup_deferred_work() void

-- 
https://patchwork.kernel.org/patch/11487287/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
