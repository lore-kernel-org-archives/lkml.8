Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32793C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32212067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hwBRc/XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgIANJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:09:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31809 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgIANHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:07:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598965565; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cSrZbk7e/jeZSp8Bprl3QgOkG7poAuCV3fNdztHsFvY=;
 b=hwBRc/XJayLFYw9CoqnENmwDe+nrXyC2FwjovfNbn0HuNSTPuzzGGiJXVJM1hKT+ogWov4q2
 v6z7T/etzhWhm4RCLczP8qnTGVtGx27W6K2WqkXsmQ9aZ5QqwemmI+eiz9+BfEQ/tcE+uQlP
 wvfhkXfPE6SRs8BE1gatR61C6gY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4e4739238e1efa37926920 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 13:06:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10DFBC43395; Tue,  1 Sep 2020 13:06:01 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DC04C433CA;
        Tue,  1 Sep 2020 13:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DC04C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [01/30] mwifiex: pcie: Move tables to the only place they're used
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200826093401.1458456-2-lee.jones@linaro.org>
References: <20200826093401.1458456-2-lee.jones@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200901130601.10DFBC43395@smtp.codeaurora.org>
Date:   Tue,  1 Sep 2020 13:06:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> wrote:

> Saves on 10's of complains about 'defined but not used' variables.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  In file included from drivers/net/wireless/marvell/mwifiex/main.h:57,
>  from drivers/net/wireless/marvell/mwifiex/main.c:22:
>  drivers/net/wireless/marvell/mwifiex/pcie.h:310:41: warning: ‘mwifiex_pcie8997’ defined but not used [-Wunused-const-variable=]
>  310 | static const struct mwifiex_pcie_device mwifiex_pcie8997 = {
>  | ^~~~~~~~~~~~~~~~
>  drivers/net/wireless/marvell/mwifiex/pcie.h:300:41: warning: ‘mwifiex_pcie8897’ defined but not used [-Wunused-const-variable=]
>  300 | static const struct mwifiex_pcie_device mwifiex_pcie8897 = {
>  | ^~~~~~~~~~~~~~~~
>  drivers/net/wireless/marvell/mwifiex/pcie.h:292:41: warning: ‘mwifiex_pcie8766’ defined but not used [-Wunused-const-variable=]
>  292 | static const struct mwifiex_pcie_device mwifiex_pcie8766 = {
>  | ^~~~~~~~~~~~~~~~
> 
>  NB: Repeats 10's of times - snipped for brevity.
> 
> Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Cc: Xinming Hu <huxinming820@gmail.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

10 patches applied to wireless-drivers-next.git, thanks.

77dacc8fc64c mwifiex: pcie: Move tables to the only place they're used
f5c3bf15f34c brcmsmac: ampdu: Remove a couple set but unused variables
dd13d6dcc24d iwlegacy: 3945-mac: Remove all non-conformant kernel-doc headers
305fd82aee87 iwlegacy: 3945-rs: Remove all non-conformant kernel-doc headers
a60e33af4e28 iwlegacy: 3945: Remove all non-conformant kernel-doc headers
78211e026bd0 brcmfmac: p2p: Fix a couple of function headers
ef8308d34a93 orinoco_usb: Downgrade non-conforming kernel-doc headers
1d2389b53c85 brcmsmac: phy_cmn: Remove a unused variables 'vbat' and 'temp'
2fae7bf8e379 zd1211rw: zd_chip: Fix formatting
f3242a5ba91d zd1211rw: zd_mac: Add missing or incorrect function documentation

-- 
https://patchwork.kernel.org/patch/11737755/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

