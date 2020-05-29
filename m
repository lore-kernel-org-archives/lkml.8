Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C682065C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lBKZnscO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgE2Rm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:42:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24480 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727793AbgE2RmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:42:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590774144; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mS0L5M5Zyxrfx3FqEsEhN7PolZq2SbMS2JzRaG3QdDM=;
 b=lBKZnscOZlFXnk2wOyl/kp0vmxg9KxQNRjRKvu2nJBRP0LxwxbYQEyGu3+h9K0a69hrDmtTh
 VSryW++DPLmcbp/RDRcdkKqynbmZImLkYZe7arqGp9E618M+KQBu1Egf13VnRQa4jqCA15Lm
 LPlPTAZSPZLookmzOs6bE9pSzb8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed14976b65440fdba16a287 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:42:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0567C4339C; Fri, 29 May 2020 17:42:13 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65DDBC433C9;
        Fri, 29 May 2020 17:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65DDBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mwifiex: Add support for NL80211_ATTR_MAX_AP_ASSOC_STA
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200521123559.29028-1-pali@kernel.org>
References: <20200521123559.29028-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529174213.D0567C4339C@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:42:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> SD8997 firmware sends TLV_TYPE_MAX_CONN with struct hw_spec_max_conn to
> inform kernel about maximum number of p2p connections and stations in AP
> mode.
> 
> During initialization of SD8997 wifi chip kernel prints warning:
> 
>   mwifiex_sdio mmc0:0001:1: Unknown GET_HW_SPEC TLV type: 0x217
> 
> This patch adds support for parsing TLV_TYPE_MAX_CONN (0x217) and sets
> appropriate cfg80211 member 'max_ap_assoc_sta' from retrieved structure.
> 
> It allows userspace to retrieve NL80211_ATTR_MAX_AP_ASSOC_STA attribute.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

982d7287f8da mwifiex: Add support for NL80211_ATTR_MAX_AP_ASSOC_STA

-- 
https://patchwork.kernel.org/patch/11562835/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

