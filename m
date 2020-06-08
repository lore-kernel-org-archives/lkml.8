Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FF02074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Hri9TX2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgFHLRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:17:45 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35705 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbgFHLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:17:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591615064; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=A2l8ZtjPyjr/T5aVcdRp4TQUyoApQ642+Fc1l7Et+tQ=; b=Hri9TX2cSI6RfBBtAS2EBSCRM1FS6uNhyQxOq/mrWcP1xhnWrPSlE+nFVj54hvbe7QtrPT+l
 kmv2TJlCauzbnr2YP0pUTa5Mf0fQ2hZD/M+J9lo6lQPEnX/qbU/IJItozmqZAkXygUhUFcnb
 wgM8U0NkEap/DnZbPVqwXWoD7Rk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ede1e52d26ace6bd5dabe74 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 11:17:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82632C433CB; Mon,  8 Jun 2020 11:17:38 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00956C433C6;
        Mon,  8 Jun 2020 11:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00956C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Brian Norris <briannorris@chromium.org>,
        ath10k@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit() to avoid hard crash on reboot
References: <20200602052533.15048-1-john.stultz@linaro.org>
Date:   Mon, 08 Jun 2020 14:17:31 +0300
In-Reply-To: <20200602052533.15048-1-john.stultz@linaro.org> (John Stultz's
        message of "Tue, 2 Jun 2020 05:25:33 +0000")
Message-ID: <877dwhkdro.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz <john.stultz@linaro.org> writes:

> Ever since 5.7-rc1, if we call
> ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
> reboot, resulting in the device getting stuck in the usb crash
> debug mode and not coming back up wihthout a hard power off.
>
> This hack avoids the issue by returning early in
> ath10k_qmi_event_server_exit().
>
> A better solution is very much desired!
>
> Feedback and suggestions welcome!
>
> Cc: Rakesh Pillai <pillair@qti.qualcomm.com>
> Cc: Govind Singh <govinds@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: ath10k@lists.infradead.org
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Just so you know: as you didn't CC linux-wireless it's not on patchwork
and hence not on my radar. But hopefully we find a better solution to
fix this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
