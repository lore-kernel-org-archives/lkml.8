Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46367C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085F220784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ElslmzG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441853AbgDOTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:45:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54263 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441830AbgDOTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:45:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586979937; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ibbsr5ypXdlwHeDCbyU70XBfIzXR6KVFiTZ4QWWPCL0=; b=ElslmzG2UGJm9f5T/g6oMXFnPVdUzcc1sXKOAn52d0e2vNzVqIPxX5tApU+YDIWBq5GVNP/D
 xgOvQDxXuI1iTDdF+PAWd30332CqFBAeLUwU4D3sJBGtC6kojItfbDkqEe+X9IIkt/hUSuhJ
 UBtqzHMIFGMWNf/4i+FK8WiWLLQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e976457.7f8fb8566fb8-smtp-out-n05;
 Wed, 15 Apr 2020 19:45:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 999E3C44788; Wed, 15 Apr 2020 19:45:26 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8595C433CB;
        Wed, 15 Apr 2020 19:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8595C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 15 Apr 2020 13:45:25 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: Use 5 digits for printing address
Message-ID: <20200415194525.GA3469@codeaurora.org>
References: <20200415192916.78339-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200415192916.78339-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15 2020 at 13:29 -0600, Stephen Boyd wrote:
>The top few bits aren't relevant to pad out because they're always zero.
>Let's just print 5 digits instead of 8 so that it's a little shorter and
>more readable.
>
>Suggested-by: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
