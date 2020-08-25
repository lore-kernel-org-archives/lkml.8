Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA85C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82100206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nIyomwgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHYU5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:57:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26097 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgHYU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:57:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598389021; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=D0pgoa12U+Gd/NH8un3c93cqAwl64FvasNwM0PnJW3I=;
 b=nIyomwgIghzwnDaQioZuE1sawlsY+RX8fkV5zNuQDd/OzcJka+12XZI8yPpd9XycqxMo2nU1
 Et9tDrqtyQcgx5NQ2fJqmU1aHgYE8qqEzTk5mwtJ8wkIsjTPYs+/gZv5WxNgfz/6zJULOLgJ
 74RvS8BAJrsmOxM8DM/3kLwrTcQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f457b0e2ec932ecb7ba0272 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 20:56:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38555C43391; Tue, 25 Aug 2020 20:56:46 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: merez)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90C8CC433C6;
        Tue, 25 Aug 2020 20:56:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 23:56:45 +0300
From:   merez@codeaurora.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 21/28] wireless: ath: wil6210: debugfs: Fix a couple of
 formatting issues in 'wil6210_debugfs_init'
In-Reply-To: <20200819072402.3085022-22-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
 <20200819072402.3085022-22-lee.jones@linaro.org>
Message-ID: <343d27c36245296e9dc27d5f3449e8b1@codeaurora.org>
X-Sender: merez@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 10:23, Lee Jones wrote:
> Kerneldoc expects attributes/parameters to be in '@*.: ' format and
> gets confused if the variable does not follow the type/attribute
> definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function
> parameter or member 'wil' not described in
> 'wil6210_debugfs_init_offset'
>  drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function
> parameter or member 'dbg' not described in
> 'wil6210_debugfs_init_offset'
>  drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function
> parameter or member 'base' not described in
> 'wil6210_debugfs_init_offset'
>  drivers/net/wireless/ath/wil6210/debugfs.c:456: warning: Function
> parameter or member 'tbl' not described in
> 'wil6210_debugfs_init_offset'
> 
> Cc: Maya Erez <merez@codeaurora.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: wil6210@qti.qualcomm.com
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/net/wireless/ath/wil6210/debugfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Maya Erez <merez@codeaurora.org>
