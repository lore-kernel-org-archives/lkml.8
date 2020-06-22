Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC43C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60470206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tX3MstXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgFVOS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:18:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:16624 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbgFVOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:18:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592835502; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=owZAZzzevo2vEHh+id5TiUQlxWbVBRunCY0q/fkSbg8=; b=tX3MstXloe1DtKd4tllNk7IvgehGS5JoCsYZ47RXddNvM622sJbOiVECWgGyjubMwmp1qEGY
 npILss6jSoCevS/OW/6L4H5MtKAbNuRyBe5sX/4iHD8SnWsIUjDUzgikZVma9o8teDSEL5pC
 z/bx9rV72xhAI7iNd3siV3v+0cc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ef0bda3fe1db4db89d85246 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:18:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E4D2C433CB; Mon, 22 Jun 2020 14:18:11 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2DC6C433C8;
        Mon, 22 Jun 2020 14:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2DC6C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net: wireless: intersil: orinoco: fix spelling mistake
References: <20200619093102.29487-1-f.suligoi@asem.it>
Date:   Mon, 22 Jun 2020 17:18:05 +0300
In-Reply-To: <20200619093102.29487-1-f.suligoi@asem.it> (Flavio Suligoi's
        message of "Fri, 19 Jun 2020 11:31:02 +0200")
Message-ID: <87wo3zfale.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Suligoi <f.suligoi@asem.it> writes:

> Fix typo: "EZUSB_REQUEST_TRIGER" --> "EZUSB_REQUEST_TRIGGER"
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The prefix should be "orinoco_usb: ", but I can fix that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
