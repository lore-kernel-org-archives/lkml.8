Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365A7C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047F3206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="w/NNnyO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgD1JBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:01:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27061 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgD1JB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:01:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588064489; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=f7lCdIiB/qVorimyirKN/0oeBUQed5wtFKoPcb4m7Fs=;
 b=w/NNnyO09UlpHN0hHooHZKjZPPRpAxXK4i96ROootmI2D1O1ZCTB3f2ndf7knzETseWtczf/
 feT+5r7kGvJIazklO3uAmy/OcNm+4/1Pgkecc0IYyac5MY4Eql1bvHFQeCpWSiJ6qB/d0utR
 z5w0xKZKf6NVPe5n3yjfslT13wQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7f0e5.7f6a879263e8-smtp-out-n01;
 Tue, 28 Apr 2020 09:01:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F50CC432C2; Tue, 28 Apr 2020 09:01:25 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F44AC433F2;
        Tue, 28 Apr 2020 09:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F44AC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: sprom: fix block comments coding style issues
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200424175043.16261-1-john.oldman@polehill.co.uk>
References: <20200424175043.16261-1-john.oldman@polehill.co.uk>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200428090125.9F50CC432C2@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 09:01:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Oldman <john.oldman@polehill.co.uk> wrote:

> Fixed coding style issues
> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>

Patch applied to wireless-drivers-next.git, thanks.

2aad9f81d34c ssb: sprom: fix block comments coding style issues

-- 
https://patchwork.kernel.org/patch/11509841/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
