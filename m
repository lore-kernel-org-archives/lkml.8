Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9AC20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="uUG6bDW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgHQKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:25:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11620 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbgHQKZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:25:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659953; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=afrx+GYTeGfAA0L5NcErG+Sw5Rx8q7wQPJGJJR8T2QM=;
 b=uUG6bDW/axBdRDbj3/OKYfAdmAg4mgop5cs/w7rm5IfpluxDZt3q8+bDVSX/e56TRBkUIJ+h
 /QLfkIdg6JgAfeED5IaoFp9DC260dGk3Uw/81mC6nYBb48lmX3GLSUwp4bhlfXc6Xr+xLxiG
 yaOqiryPySIl5Sc8VApMhT8ud9I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3a5b2385672017516cb4a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:25:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2742C433C6; Mon, 17 Aug 2020 10:25:38 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04D70C433CA;
        Mon, 17 Aug 2020 10:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04D70C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix the size used in a 'dma_free_coherent()' call
 in
 an error handling path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200802122227.678637-1-christophe.jaillet@wanadoo.fr>
References: <20200802122227.678637-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, kuba@kernel.org, pillair@codeaurora.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817102538.B2742C433C6@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:25:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Update the size used in 'dma_free_coherent()' in order to match the one
> used in the corresponding 'dma_alloc_coherent()'.
> 
> Fixes: 1863008369ae ("ath10k: fix shadow register implementation for WCN3990")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

454530a9950b ath10k: Fix the size used in a 'dma_free_coherent()' call in an error handling path

-- 
https://patchwork.kernel.org/patch/11696383/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

