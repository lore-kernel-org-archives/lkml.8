Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6272C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924432078E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dFbFJ2c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHQKVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:21:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbgHQKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:20:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659659; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=C1hZ2gm17WhpsJNUvxDXJNYffSUUYMl+EuQWFbm62NM=;
 b=dFbFJ2c+k5zOA/DSBVMUfv6GK8AgjuI7EbkMqmlY2p8IoN97lSHk7DtRJYUU14FnW4omduiF
 lFHoH0AfqkOw7pXAMmfwmpWkH3ez417ehJlkHOcg6OL2jiDk+v7sCSt+WW849tdL1t/C8/9V
 hSmhne7vve9MQ0UuWrayLIG0S/U=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3a59f603528d4024247de7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:20:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2496C433A1; Mon, 17 Aug 2020 10:20:37 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DFFDC433CB;
        Mon, 17 Aug 2020 10:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DFFDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/30] net: wireless: ath: ath5k: pcu: Add a description
 for
 'band' remove one for 'mode'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200814113933.1903438-10-lee.jones@linaro.org>
References: <20200814113933.1903438-10-lee.jones@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Reyk Floeter <reyk@openbsd.org>,
        "W. S. Bell" <mentor@madwifi.org>,
        Luis Rodriguez <mcgrof@winlab.rutgers.edu>,
        Pavel Roskin <proski@gnu.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817102037.C2496C433A1@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:20:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/ath/ath5k/pcu.c:115: warning: Function parameter or member 'band' not described in 'ath5k_hw_get_frame_duration'
>  drivers/net/wireless/ath/ath5k/pcu.c:955: warning: Excess function parameter 'mode' description in 'ath5k_hw_pcu_init'
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Reyk Floeter <reyk@openbsd.org>
> Cc: "W. S. Bell" <mentor@madwifi.org>
> Cc: Luis Rodriguez <mcgrof@winlab.rutgers.edu>
> Cc: Pavel Roskin <proski@gnu.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

3a059c76f4eb ath5k: pcu: Add a description for 'band' remove one for 'mode'
691c7a4d4fd7 wil6210: Demote non-kerneldoc headers to standard comment blocks
1d4f5c15cf65 ath5k: Fix kerneldoc formatting issue

-- 
https://patchwork.kernel.org/patch/11714405/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

