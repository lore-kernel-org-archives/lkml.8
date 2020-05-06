Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FE020714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CjfeGmT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgEFIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:38:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43214 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728893AbgEFIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:38:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588754307; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lPH4rfvVUd4NKIPKpZ13zkNnX4E1/FhSowWkuPrhVcY=;
 b=CjfeGmT3hlF7CXFseHGUeJTctoHqjm1KvBpylS1Ns/yVjO3cG3Mdh0YALWCwAbqGirSexAvJ
 jBQDzr490MO6ocSZkTSRt1Z8Cz6Eeaz64arFDX1osMz30186hbPNr1Eux3SY0JxYKgkdqaUA
 JQTQFJxZQMpTO92rb6mxzfvuJ2g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2777d.7f3531016030-smtp-out-n01;
 Wed, 06 May 2020 08:38:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBD3CC4478C; Wed,  6 May 2020 08:38:19 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8246C44788;
        Wed,  6 May 2020 08:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8246C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v1] rtw88: fix an issue about leak system resources
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200504083442.3033-1-zhengdejin5@gmail.com>
References: <20200504083442.3033-1-zhengdejin5@gmail.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     yhchuang@realtek.com, davem@davemloft.net, sgruszka@redhat.com,
        briannorris@chromium.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506083819.EBD3CC4478C@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 08:38:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dejin Zheng <zhengdejin5@gmail.com> wrote:

> the related system resources were not released when pci_iomap() return
> error in the rtw_pci_io_mapping() function. add pci_release_regions() to
> fix it.
> 
> Fixes: e3037485c68ec1a ("rtw88: new Realtek 802.11ac driver")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

191f6b08bfef rtw88: fix an issue about leak system resources

-- 
https://patchwork.kernel.org/patch/11525207/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
