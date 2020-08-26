Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC228C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95F52078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AWkiwgGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHZOvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:51:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11691 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHZOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:51:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598453473; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O2P61fFaIWACVbX6D5mvTEtXsK1IGohXRkrD+M58vq4=;
 b=AWkiwgGaX8E2v8CVkQCjLU8sFFNLYoIP0G2sCNRTRGgcoTWfhubwjChiKkSfaORGHujN7q0d
 F7rfyzZ3Mx+twHH0ZXdDfqQT/yWdGz2UmubBQnRNI59sQgcGa5+SFbuk07FvgzJmnDpZMXdo
 xtGWSjykT/zodzO7mU9vtzkwWF4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4676a4e2cf79f0e27551b4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 14:50:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4E48C43387; Wed, 26 Aug 2020 14:50:11 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 775FAC43387;
        Wed, 26 Aug 2020 14:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 775FAC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] ath10k: Keep track of which interrupts fired,
 don't poll them
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
References: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        briannorris@chromium.org, saiprakash.ranjan@codeaurora.org,
        linux-wireless@vger.kernel.org, pillair@codeaurora.org,
        kuabhs@google.com, Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200826145011.C4E48C43387@smtp.codeaurora.org>
Date:   Wed, 26 Aug 2020 14:50:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> wrote:

> If we have a per CE (Copy Engine) IRQ then we have no summary
> register.  Right now the code generates a summary register by
> iterating over all copy engines and seeing if they have an interrupt
> pending.
> 
> This has a problem.  Specifically if _none_ if the Copy Engines have
> an interrupt pending then they might go into low power mode and
> reading from their address space will cause a full system crash.  This
> was seen to happen when two interrupts went off at nearly the same
> time.  Both were handled by a single call of ath10k_snoc_napi_poll()
> but, because there were two interrupts handled and thus two calls to
> napi_schedule() there was still a second call to
> ath10k_snoc_napi_poll() which ran with no interrupts pending.
> 
> Instead of iterating over all the copy engines, let's just keep track
> of the IRQs that fire.  Then we can effectively generate our own
> summary without ever needing to read the Copy Engines.
> 
> Tested-on: WCN3990 SNOC WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rakesh Pillai <pillair@codeaurora.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

My main concern of this patch is that there's no info how it works on other
hardware families. For example, QCA9984 is very different from WCN3990. The
best would be if someone can provide a Tested-on tags for other hardware (even
some of them).

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#hardware_families

-- 
https://patchwork.kernel.org/patch/11654625/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

