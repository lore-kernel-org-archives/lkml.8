Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC752C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF4020759
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XH1cbqhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGZSLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:11:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42117 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgGZSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:11:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595787091; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dkeTWaUqQPIijBo2b2trYUH4UirL83EHI+atIYwWFzE=; b=XH1cbqhw7zeavxrPibQdPDcHohoAhDxJ778jspNtqLvqznoBhaLsRIGnFivHWZ+hGQElOnWB
 kPn9W6ayjpmSTmaUhmSv/Bu7rHjIB8yh5BOSmg/qOhGWo1HI26ZRN3G9caGZkZQWlwMB9lKn
 OvRxP54+nXPsjrBiXuFnF7rmecY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f1dc75235f3e3d3168ebeff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 18:11:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6F6FC43391; Sun, 26 Jul 2020 18:11:30 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09F83C433C9;
        Sun, 26 Jul 2020 18:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09F83C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iwlwifi: yoyo: don't print failure if debug firmware is missing
References: <20200625165210.14904-1-wsa@kernel.org>
        <20200726152642.GA913@ninjato>
Date:   Sun, 26 Jul 2020 21:11:25 +0300
In-Reply-To: <20200726152642.GA913@ninjato> (Wolfram Sang's message of "Sun,
        26 Jul 2020 17:26:42 +0200")
Message-ID: <87y2n6404y.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@kernel.org> writes:

> On Thu, Jun 25, 2020 at 06:52:10PM +0200, Wolfram Sang wrote:
>> Missing this firmware is not fatal, my wifi card still works. Even more,
>> I couldn't find any documentation what it is or where to get it. So, I
>> don't think the users should be notified if it is missing. If you browse
>> the net, you see the message is present is in quite some logs. Better
>> remove it.
>> 
>> Signed-off-by: Wolfram Sang <wsa@kernel.org>
>> ---
>
> Any input on this? Or people I should add to CC?

This was discussed on another thread:

https://lkml.kernel.org/r/87mu3magfp.fsf@tynnyri.adurom.net

Unless Intel folks object I'm planning to take this to
wireless-drivers-next.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
