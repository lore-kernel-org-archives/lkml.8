Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90907207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oXXUaI1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgGOKg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:36:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12646 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731183AbgGOKg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:36:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594809415; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WaOxlPyfSHay8BRBP3nto7aXSzb/V/iBqWby18Sm0eI=;
 b=oXXUaI1TSnW31WAaIZ7aqABQ5cRXLMGYrNr6PcKBGx5Txl466ZPTkm7ZN5Plm1SMveeySVh0
 SlOp2FK5c9AlJNz7/1BvypvMU+jGi/pXxuJPlwNPhDbE6Ud4Wqb+pHOwJDZVvh8VpPljyRjo
 sJADHUnqTuFVHpS8Aq93l6hN3a8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0edc25512812c070d04d4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 10:36:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EC1AC4339C; Wed, 15 Jul 2020 10:36:20 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4AAAC433C9;
        Wed, 15 Jul 2020 10:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4AAAC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] orinoco_usb: fix spelling mistake
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200619093102.29487-1-f.suligoi@asem.it>
References: <20200619093102.29487-1-f.suligoi@asem.it>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715103620.8EC1AC4339C@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 10:36:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Suligoi <f.suligoi@asem.it> wrote:

> Fix typo: "EZUSB_REQUEST_TRIGER" --> "EZUSB_REQUEST_TRIGGER"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Patch applied to wireless-drivers-next.git, thanks.

ad806454c3cb orinoco_usb: fix spelling mistake

-- 
https://patchwork.kernel.org/patch/11613589/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

