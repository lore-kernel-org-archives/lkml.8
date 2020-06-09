Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92912C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DF620760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IctOi5jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgFIG0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:26:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16616 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgFIGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:25:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591683957; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Vx2GPsWxM6ireZ0v4FaW6ZxUHXpBk99SgBRd9srXTWQ=;
 b=IctOi5jEooa3xb84gCCiS8pteD+Ibgy96u8+My67WCxqtXsG12YePYLJNqKBJjHJ56TVJGSD
 7bosWbm6hCKhjgsNSgHdLzXRe6jB4jbBccN+/OjP5tbv9qPEpgxzZaFu6KVht52SdIh6xjAx
 /6DQ+hN871n6Fjm4aLyGcplrkmE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5edf2b70f9a707134514296e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 06:25:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8860AC433CA; Tue,  9 Jun 2020 06:25:51 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A63A9C433CA;
        Tue,  9 Jun 2020 06:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A63A9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/9] net: wireless: ath: fix wiki website url
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200605154112.16277-4-f.suligoi@asem.it>
References: <20200605154112.16277-4-f.suligoi@asem.it>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200609062551.8860AC433CA@smtp.codeaurora.org>
Date:   Tue,  9 Jun 2020 06:25:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Suligoi <f.suligoi@asem.it> wrote:

> In some ath files, the wiki url is still the old
> "wireless.kernel.org" instead of the new
> "wireless.wiki.kernel.org"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1141215c745b ath: fix wiki website url

-- 
https://patchwork.kernel.org/patch/11589901/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

