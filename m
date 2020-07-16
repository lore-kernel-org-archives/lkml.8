Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53080206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wItQWK2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgGPGjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:39:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20902 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPGjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:39:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594881541; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=URyxVwFZr3AjejW+Og0G6Nd4XGb+XQV7xYYxmN1mO6Q=; b=wItQWK2CI6j+26dJW6ff9z0V5Z957vlP1soI2YIU2ZuejqrGZbnsisfIlVWm83kMD/E7JKn1
 EGR/ejLlnITJnQbycb9t7lt44f2tQg7JdXXSjI9TxPUcM8LRLzmZODFkQjJBU8mSkm1VmvA+
 BYGxeiLHAif67LCJ764HKan0eVM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f0ff5ed8423214e130cc0d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 06:38:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9081EC43391; Thu, 16 Jul 2020 06:38:36 +0000 (UTC)
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8401FC433CA;
        Thu, 16 Jul 2020 06:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8401FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
        <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
        <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Date:   Thu, 16 Jul 2020 09:38:32 +0300
In-Reply-To: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
        (Brian Norris's message of "Fri, 26 Jun 2020 14:52:30 -0700")
Message-ID: <871rlcx8uv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Fri, Jun 26, 2020 at 2:49 PM Doug Anderson <dianders@chromium.org> wrote:
>> I should also note that, while I'm not terribly familiar with Kalle's
>> workflow, I would have expected to see him in the "To:" list.  I've
>> added him, but it's possible he'll need you to repost the patch with
>> him in the "To:" list.
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches
>
> Patchwork is his patch queue, so I don't think you need to address him directly.

Yup, I take all patches from patchwork so no need to Cc me.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
